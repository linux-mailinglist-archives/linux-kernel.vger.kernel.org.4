Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50ACD6028A5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiJRJqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiJRJql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:46:41 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7204FA199;
        Tue, 18 Oct 2022 02:46:40 -0700 (PDT)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ms87Q0158z67ZwS;
        Tue, 18 Oct 2022 17:43:30 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 11:46:38 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 10:46:37 +0100
Date:   Tue, 18 Oct 2022 10:46:36 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC V2 PATCH 05/11] cxl/mem: Trace General Media Event Record
Message-ID: <20221018104636.000016fc@huawei.com>
In-Reply-To: <20221017132143.360d2d46@gandalf.local.home>
References: <20221010224131.1866246-1-ira.weiny@intel.com>
        <20221010224131.1866246-6-ira.weiny@intel.com>
        <20221011135702.00006f74@huawei.com>
        <Y0nx1UOeYfQu5WYO@iweiny-desk3>
        <20221017173717.00005921@huawei.com>
        <20221017132143.360d2d46@gandalf.local.home>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
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

On Mon, 17 Oct 2022 13:21:43 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 17 Oct 2022 17:37:17 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > Looking at other similar cases though and we have a lot of use
> > of trace_seq_printf() e.g. libata_trace_parse_status() though note
> > there is some magic macro stuff in include/trace/events/libata.h 
> > to tie that together.
> > https://elixir.bootlin.com/linux/latest/source/drivers/ata/libata-trace.c#L14
> > 
> > That seems to get you access to the actual buffer we are printing into
> > in similar cases.  
> 
> Looking at the code you linked to, I wonder why __print_flags() wasn't used?
> 
> For instance, you have:
> 
> const char *
> libata_trace_parse_status(struct trace_seq *p, unsigned char status)
> {
>         const char *ret = trace_seq_buffer_ptr(p);
> 
>         trace_seq_printf(p, "{ ");
>         if (status & ATA_BUSY)
>                 trace_seq_printf(p, "BUSY ");
>         if (status & ATA_DRDY)
>                 trace_seq_printf(p, "DRDY ");
>         if (status & ATA_DF)
>                 trace_seq_printf(p, "DF ");
>         if (status & ATA_DSC)
>                 trace_seq_printf(p, "DSC ");
>         if (status & ATA_DRQ)
>                 trace_seq_printf(p, "DRQ ");
>         if (status & ATA_CORR)
>                 trace_seq_printf(p, "CORR ");
>         if (status & ATA_SENSE)
>                 trace_seq_printf(p, "SENSE ");
>         if (status & ATA_ERR)
>                 trace_seq_printf(p, "ERR ");
>         trace_seq_putc(p, '}');
>         trace_seq_putc(p, 0);
> 
>         return ret;
> }
> 
> 
> Which is just a re-implementation of:
> 
> __print_flags(status, " ", 
> 	{ ATA_BUSY, "BUSY" },
> 	{ ATA_DRDY, "DRDY" },
> 	{ ATA_DF, "DF" },
> 	{ ATA_DSC, "DSC" },
> 	{ ATA_DRQ, "DRQ" },
> 	{ ATA_CORR, "CORR" },
> 	{ ATA_SENSE, "SENSE" },
> 	{ ATA_ERR, "ERR" })
> 
> 
> The major difference between the two, is that libtraceevent will be able to
> parse the above and convert the status bits into strings, whereas using
> libata_trace_parse_status() will just give you a parsing error.
> 
> That is, perf and trace-cmd will not be able to parse it unless you write a
> separate plugin for libtraceevent to do it but that means you'll have
> duplicate code.
> 
> I know you just want echo and cat, but that will still work, and this will
> make it work for the tooling as well.

Excellent point, though in the case we are interested in for CXL,
__print_flags() is not enough.

We have a mass of fields that only contain something useful to print if
the valid bits in a mask are set. I just pulled that example to
show how trace_seq_printf() could be used to achieve optional printing
as opposed to current situation where the reader of the print has
to interpret the mask to work out if fields contain anything useful.

To do something nice with them in perf (well probably ras-daemon in
this case) we'll have to parse the valid bits anyway so effectively
write such a plugin.  There we need to do a bunch of mangling to get
the events stored in a DB anyway, so this isn't a huge overhead.

Jonathan


> 
> -- Steve
> 

