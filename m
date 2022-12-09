Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65AC64883D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 19:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiLISOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 13:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLISOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 13:14:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A311A431B;
        Fri,  9 Dec 2022 10:14:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3089AB828A7;
        Fri,  9 Dec 2022 18:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E59C433EF;
        Fri,  9 Dec 2022 18:13:59 +0000 (UTC)
Date:   Fri, 9 Dec 2022 13:13:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ross Zwisler <zwisler@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ring-buffer: Handle resize in early boot up
Message-ID: <20221209131357.5e4f6d01@gandalf.local.home>
In-Reply-To: <Y5NpDF0AnY9ibwEl@google.com>
References: <20221209101151.1fec1167@gandalf.local.home>
        <Y5NpDF0AnY9ibwEl@google.com>
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

On Fri, 9 Dec 2022 09:57:48 -0700
Ross Zwisler <zwisler@google.com> wrote:

> > +			if (cpu_id == smp_processor_id()) {
> > +				rb_update_pages(cpu_buffer);
> > +				migrate_enable();
> > +			} else {
> > +				migrate_enable();
> > +				schedule_work_on(cpu_id,
> > +						 &cpu_buffer->update_pages_work);
> > +				wait_for_completion(&cpu_buffer->update_done);  
> 
> I ran with this patch on my test VM and hit the same Oops from the original
> report.
> 
> I think the problem is that we're still trying to enable interrupts via
> wait_for_completion():
> 
> wait_for_completion()
>   wait_for_common()
>     __wait_for_common()
>       raw_spin_unlock_irq()
>         _raw_spin_unlock_irq()
>           __raw_spin_unlock_irq()
>             local_irq_enable()
> 
> I'm testing on a QEMU VM with 4 virtual CPUs, if that helps WRT where work is
> being scheduled (cpu_id == smp_processor_id).

Can you show the backtrace with that. Because when I triggered it, the
other CPUs were not up and running. I'm testing this on a VM with 8 CPUs.

-- Steve
