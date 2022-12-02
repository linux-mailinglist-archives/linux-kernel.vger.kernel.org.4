Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3175664079A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 14:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbiLBNSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 08:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiLBNSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 08:18:46 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC55A1C3A;
        Fri,  2 Dec 2022 05:18:42 -0800 (PST)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NNtmL5LLfz6J68q;
        Fri,  2 Dec 2022 21:18:10 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Fri, 2 Dec 2022 14:18:40 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Dec
 2022 13:18:40 +0000
Date:   Fri, 2 Dec 2022 13:18:36 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V2 03/11] cxl/mem: Implement Clear Event Records command
Message-ID: <20221202131836.00000f35@Huawei.com>
In-Reply-To: <6389630036769_3cbe02947d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
        <20221201002719.2596558-4-ira.weiny@intel.com>
        <6389630036769_3cbe02947d@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > +static int cxl_clear_event_record(struct cxl_dev_state *cxlds,
> > +				  enum cxl_event_log_type log,
> > +				  struct cxl_get_event_payload *get_pl,
> > +				  u16 total)
> > +{
> > +	struct cxl_mbox_clear_event_payload payload = {
> > +		.event_log = log,
> > +	};
> > +	int cnt;
> > +
> > +	/*
> > +	 * Clear Event Records uses u8 for the handle cnt while Get Event
> > +	 * Record can return up to 0xffff records.
> > +	 */
> > +	for (cnt = 0; cnt < total; /* cnt incremented internally */) {
> > +		u8 nr_recs = min_t(u8, (total - cnt),
> > +				   CXL_CLEAR_EVENT_MAX_HANDLES);  
> 
> This seems overly complicated. @total is a duplicate of
> @get_pl->record_count, and the 2 loops feel like it could be cut
> down to one.


You could do something nasty like
	for (i = 0; i < total; i++) {

		...
		payload.handle[i % CLEAR_EVENT_MAX_HANDLES] = ...
		if (i % CXL_CLEAR_EVENT_MAX_HANDLES == CXL_CLEAR_EVENT_MAX_HANDLE - 1) {
			send command.
		}
	}

but that looks worse to me than the double loop.

Making outer loop
	for (j = 0; j <= total / CXL_CLEAR_EVENT_MAX_HANDLES; j++)
might bet clearer but then you'd have to do
records[j * CXL_CLEAR_EVENT_MAX_HANDLES + i] which isn't nice.

Ah well, Ira gets to try and find a happy compromise.


...

> > diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> > index 70459be5bdd4..7c1ad8062792 100644
> > --- a/include/uapi/linux/cxl_mem.h
> > +++ b/include/uapi/linux/cxl_mem.h
> > @@ -25,6 +25,7 @@
> >  	___C(RAW, "Raw device command"),                                  \
> >  	___C(GET_SUPPORTED_LOGS, "Get Supported Logs"),                   \
> >  	___C(GET_EVENT_RECORD, "Get Event Record"),                       \
> > +	___C(CLEAR_EVENT_RECORD, "Clear Event Record"),                   \
> >  	___C(GET_FW_INFO, "Get FW Info"),                                 \
> >  	___C(GET_PARTITION_INFO, "Get Partition Information"),            \
> >  	___C(GET_LSA, "Get Label Storage Area"),                          \  
> 
> Same, "yikes" / "must be at the end of the enum" feedback.

Macro magic makes that non obvious.. Not that I'd ever said I thought this trick
was a bad idea ;) 

