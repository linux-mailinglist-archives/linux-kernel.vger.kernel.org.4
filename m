Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2A76014AB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiJQRV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiJQRVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:21:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52551116B;
        Mon, 17 Oct 2022 10:21:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6175AB819D0;
        Mon, 17 Oct 2022 17:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EA0C433C1;
        Mon, 17 Oct 2022 17:21:20 +0000 (UTC)
Date:   Mon, 17 Oct 2022 13:21:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC V2 PATCH 05/11] cxl/mem: Trace General Media Event Record
Message-ID: <20221017132143.360d2d46@gandalf.local.home>
In-Reply-To: <20221017173717.00005921@huawei.com>
References: <20221010224131.1866246-1-ira.weiny@intel.com>
        <20221010224131.1866246-6-ira.weiny@intel.com>
        <20221011135702.00006f74@huawei.com>
        <Y0nx1UOeYfQu5WYO@iweiny-desk3>
        <20221017173717.00005921@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2022 17:37:17 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Looking at other similar cases though and we have a lot of use
> of trace_seq_printf() e.g. libata_trace_parse_status() though note
> there is some magic macro stuff in include/trace/events/libata.h 
> to tie that together.
> https://elixir.bootlin.com/linux/latest/source/drivers/ata/libata-trace.c#L14
> 
> That seems to get you access to the actual buffer we are printing into
> in similar cases.

Looking at the code you linked to, I wonder why __print_flags() wasn't used?

For instance, you have:

const char *
libata_trace_parse_status(struct trace_seq *p, unsigned char status)
{
        const char *ret = trace_seq_buffer_ptr(p);

        trace_seq_printf(p, "{ ");
        if (status & ATA_BUSY)
                trace_seq_printf(p, "BUSY ");
        if (status & ATA_DRDY)
                trace_seq_printf(p, "DRDY ");
        if (status & ATA_DF)
                trace_seq_printf(p, "DF ");
        if (status & ATA_DSC)
                trace_seq_printf(p, "DSC ");
        if (status & ATA_DRQ)
                trace_seq_printf(p, "DRQ ");
        if (status & ATA_CORR)
                trace_seq_printf(p, "CORR ");
        if (status & ATA_SENSE)
                trace_seq_printf(p, "SENSE ");
        if (status & ATA_ERR)
                trace_seq_printf(p, "ERR ");
        trace_seq_putc(p, '}');
        trace_seq_putc(p, 0);

        return ret;
}


Which is just a re-implementation of:

__print_flags(status, " ", 
	{ ATA_BUSY, "BUSY" },
	{ ATA_DRDY, "DRDY" },
	{ ATA_DF, "DF" },
	{ ATA_DSC, "DSC" },
	{ ATA_DRQ, "DRQ" },
	{ ATA_CORR, "CORR" },
	{ ATA_SENSE, "SENSE" },
	{ ATA_ERR, "ERR" })


The major difference between the two, is that libtraceevent will be able to
parse the above and convert the status bits into strings, whereas using
libata_trace_parse_status() will just give you a parsing error.

That is, perf and trace-cmd will not be able to parse it unless you write a
separate plugin for libtraceevent to do it but that means you'll have
duplicate code.

I know you just want echo and cat, but that will still work, and this will
make it work for the tooling as well.

-- Steve
