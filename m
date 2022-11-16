Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90B862C26A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbiKPPYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiKPPYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:24:30 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A848E7C;
        Wed, 16 Nov 2022 07:24:29 -0800 (PST)
Received: from frapeml500003.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NC6Gf3KQhz6H7XT;
        Wed, 16 Nov 2022 23:22:02 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 16:24:27 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 16 Nov
 2022 15:24:26 +0000
Date:   Wed, 16 Nov 2022 15:24:26 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 03/11] cxl/mem: Implement Clear Event Records command
Message-ID: <20221116152426.0000626b@Huawei.com>
In-Reply-To: <20221110185758.879472-4-ira.weiny@intel.com>
References: <20221110185758.879472-1-ira.weiny@intel.com>
        <20221110185758.879472-4-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
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

On Thu, 10 Nov 2022 10:57:50 -0800
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL rev 3.0 section 8.2.9.2.3 defines the Clear Event Records mailbox
> command.  After an event record is read it needs to be cleared from the
> event log.
> 
> Implement cxl_clear_event_record() and call it for each record retrieved
> from the device.
> 
> Each record is cleared individually.  A clear all bit is specified but
> events could arrive between a get and the final clear all operation.
> Therefore each event is cleared specifically.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
Some follow through comment updates needed from changes in earlier patches +
one comment you can ignore if you prefer to keep it as is.

>  static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
>  				    enum cxl_event_log_type type)
>  {
> @@ -728,14 +750,23 @@ static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
>  		}
>  
>  		pl_nr = le16_to_cpu(payload.record_count);
> -		if (trace_cxl_generic_event_enabled()) {

To simplify this patch, maybe push this check down in the previous patch so this
one doesn't move code around?  It'll look a tiny bit odd there of course..

> +		if (pl_nr > 0) {
>  			u16 nr_rec = min_t(u16, pl_nr, CXL_GET_EVENT_NR_RECORDS);
>  			int i;
>  
> -			for (i = 0; i < nr_rec; i++)
> -				trace_cxl_generic_event(dev_name(cxlds->dev),
> -							type,
> -							&payload.record[i]);
> +			if (trace_cxl_generic_event_enabled()) {
> +				for (i = 0; i < nr_rec; i++)
> +					trace_cxl_generic_event(dev_name(cxlds->dev),
> +								type,
> +								&payload.record[i]);
> +			}
> +
> +			rc = cxl_clear_event_record(cxlds, type, &payload, nr_rec);
> +			if (rc) {
> +				dev_err(cxlds->dev, "Event log '%s': Failed to clear events : %d",
> +					cxl_event_log_type_str(type), rc);
> +				return;
> +			}
>  		}
>  

> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index da64ba0f156b..28a114c7cf69 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h

>  
> +/*
> + * Clear Event Records input payload
> + * CXL rev 3.0 section 8.2.9.2.3; Table 8-51
> + *
> + * Space given for 1 record

Nope...


> + */
> +struct cxl_mbox_clear_event_payload {
> +	u8 event_log;		/* enum cxl_event_log_type */
> +	u8 clear_flags;
> +	u8 nr_recs;		/* 1 for this struct */
Nope :)  Delete the comments so they can't be wrong if this changes in future!

> +	u8 reserved[3];
> +	__le16 handle[CXL_GET_EVENT_NR_RECORDS];
> +};
> +
