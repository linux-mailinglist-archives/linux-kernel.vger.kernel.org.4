Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1426C6C3E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjCWPZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjCWPZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:25:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BD41DB88
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:25:21 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 327C81FE51;
        Thu, 23 Mar 2023 15:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679585120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wN72/dJR7Kff5UXvD5fbRCZZ2Yy5JDS1c3chb1KkPMM=;
        b=uOHYRK4zS1lfC4goqgx5uapPfNZLuV9NKwb3KOxBuyFJUKRIbG1ke6fdSiOId3L3Xq/6Ia
        1mAWzyRyCe/Ct4lC8f4FxmtdTD2qjsks+Qi9HJNuKUlC8naOI7RtI/g5qqw2g3mL/qC9T0
        asQ5G2X176twpwoQMZSNOrt33Gny9Pg=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BFE812C142;
        Thu, 23 Mar 2023 15:25:19 +0000 (UTC)
Date:   Thu, 23 Mar 2023 16:25:16 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 07/18] printk: nobkl: Add buffer management
Message-ID: <ZBxvXDl34qdKnJ6o@alley>
References: <ZBndaSUFd4ipvKwj@alley>
 <87y1nna8po.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1nna8po.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-03-23 14:44:43, John Ogness wrote:
> On 2023-03-21, Petr Mladek <pmladek@suse.com> wrote:
> > The per-CPU buffer actually looks dangerous. It might
> > be used by more NOBKL consoles. How is the access synchronized
> > please? By console_list_lock? It is not obvious to me.
> 
> Each console has its own set of per-CPU buffers (con->pcpu_data).
> 
> > On the contrary, we might need 4 static buffers for the early
> > boot. For example, one atomic console might start printing
> > in the normal context. Second atomic console might use
> > the same static buffer in IRQ context. But the first console
> > will not realize it because it did not loose the per-CPU
> > atomic lock when the CPU handled the interrupt..
> > Or is this handled another way, please?
> 
> You are correct! Although I think 3 initdata static buffers should
> suffice. (2 if the system does not support NMI).

I am never completely sure about it. My undestanding is that softirq
might be proceed at the end if irq_exit():

  + irq_exit()
    + __irq_exit_rcu()
      + invoke_softirq()
	+ __do_softirq()

And I see local_irq_enable() in __do_softirq() before softirq actions
are proceed. It means that there might be 4 nested contexts:

   + task
   + softirq
   + irq
   + NMI

So we need 4 buffers (3 if the system does not support NMI).


> Your feedback points out that we are allocating a lot of extra memory
> for the rare case of a hostile takeover from another CPU when in
> panic. I suppose it would be enough to have a single dedicated panic
> buffer to use in this case.

Yup.

> With all that in mind, we would have 3 initdata early buffers, a single
> panic buffer, and per-console buffers. So the function would look
> something like this:
> 
> static __ref void cons_context_set_pbufs(struct cons_context *ctxt)
> {
> 	struct console *con = ctxt->console;
> 
> 	if (atomic_read(&panic_cpu) == smp_processor_id())
> 		ctxt->pbufs = &panic_ctxt_data.pbufs;
> 	else if (con->pbufs)
> 		ctxt->pbufs = con->pbufs;
> 	else
> 		ctxt->pbufs = &early_cons_ctxt_data[early_nbcon_nested].pbufs;
> }

Looks good.

> It should be enough to increment @early_nbcon_nested in cons_get_wctxt()
> and decrement it in a new cons_put_wctxt() that is called after
> cons_atomic_flush_con().

I still have to understand the logic related to
cons_atomic_flush_con() and early boot.


> Originally in tglx's design, hostile takeovers were allowed at any time,
> which requires the per-CPU data per console. His idea was that the
> policy about hostile takeovers should be implemented outside the nbcons
> framework. However, with this newly proposed change in order to avoid
> per-CPU buffers for every console, we are adding an implicit rule that
> hostile takeovers only occur at panic. Maybe it is ok to hard-code this
> particular policy. It would certainly save significant buffer space and
> I not sure if hostile takeovers make sense outside of a panic context.

I am not sure about the hostile takeovers as well. But they might be
potentially dangerous so I would allow them only in panic for a start.
And I would avoid the per-CPU buffers if we do not need them now.
We could always make it more complicated...

Best Regards,
Petr
