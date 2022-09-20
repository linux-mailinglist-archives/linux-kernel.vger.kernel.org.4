Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBB05BEA8D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiITPww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiITPwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:52:49 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A24A6AA36;
        Tue, 20 Sep 2022 08:52:48 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MX5Y03KNpz67mY5;
        Tue, 20 Sep 2022 23:48:04 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 17:52:46 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 20 Sep
 2022 16:52:45 +0100
Date:   Tue, 20 Sep 2022 16:52:44 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 4/9] cxl/mem: Trace General Media Event Record
Message-ID: <20220920165244.0000581d@huawei.com>
In-Reply-To: <Yx+03ZoI+zvylO40@iweiny-mobl>
References: <20220813053243.757363-1-ira.weiny@intel.com>
        <20220813053243.757363-5-ira.weiny@intel.com>
        <20220824171113.00006f80@huawei.com>
        <Yx+03ZoI+zvylO40@iweiny-mobl>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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

On Mon, 12 Sep 2022 15:38:21 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> On Wed, Aug 24, 2022 at 05:11:13PM +0100, Jonathan Cameron wrote:
> > On Fri, 12 Aug 2022 22:32:38 -0700
> > ira.weiny@intel.com wrote:
> >   
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > CXL v3.0 section 8.2.9.2.1.1 defines the General Media Event Record.
> > > 
> > > Determine if the event read is a general media record and if so trace
> > > the record.
> > > 
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>  
> > A few trivial things inline...
> >   
> 
> [snip]
> 
> > > +/*
> > > + * General Media Event Record - GMER
> > > + * CXL v2.0 Section 8.2.9.1.1.1; Table 154
> > > + */
> > > +#define CXL_GMER_PHYS_ADDR_VOLATILE			BIT(0)
> > > +#define CXL_GMER_PHYS_ADDR_MASK				0x3f  
> > 
> > Inverse of mask is confusing. Just specify the full mask.  
> 
> Fixed
> 
> [snip]
> 
> > > +	TP_printk("%s: %s time=%llu id=%pUl handle=%x related_handle=%x hdr_flags='%s': " \
> > > +		  "phys_addr=%llx volatile=%s desc='%s' type='%s' trans_type='%s' channel=%u " \
> > > +		  "rank=%u device=%x comp_id=%s valid_flags='%s'",
> > > +		__get_str(dev_name), show_log_type(__entry->log),
> > > +		__entry->timestamp, __entry->id, __entry->handle,
> > > +		__entry->related_handle, show_hdr_flags(__entry->flags),
> > > +		__entry->phys_addr & ~CXL_GMER_PHYS_ADDR_MASK,
> > > +		(__entry->phys_addr & CXL_GMER_PHYS_ADDR_VOLATILE) ? "TRUE" : "FALSE",
> > > +		show_event_desc_flags(__entry->descriptor),
> > > +		show_mem_event_type(__entry->type),
> > > +		show_trans_type(__entry->transaction_type),
> > > +		__entry->channel, __entry->rank, __entry->device,
> > > +		__print_hex(__entry->comp_id, CXL_EVT_GEN_MED_COMP_ID_SIZE),
> > > +		show_valid_flags(__entry->validity_flags)  
> > 
> > Can we make the printing of fields with valid flags conditional?
> > Been a while since I wrote a Trace point, but I think I recall doing that..  
> 
> I'm not seeing a way right off.  But I can't say it is impossible...

Needs some helper code... Here's one I made earlier (and had almost entirely
banished from my memory!)

https://lore.kernel.org/all/20191114133919.32290-2-Jonathan.Cameron@huawei.com/

> 
> I'll keep an eye out as I clean the series up,
> Ira
> 
> >   
> > > +		)
> > > +);
> > > +
> > >  #endif /* _CXL_TRACE_EVENTS_H */
> > >  
> > >  /* This part must be outside protection */  
> >   

