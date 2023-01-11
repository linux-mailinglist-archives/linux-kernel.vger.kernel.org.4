Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D59666259
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 18:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjAKR4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 12:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbjAKR4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 12:56:15 -0500
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC85913F6D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:56:13 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id az20so19725444ejc.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:56:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=btQ0AMdvOQpF+hu0+WAqnwGM4Ktk9ZWe95MbXLJ3hNk=;
        b=dseTmxcG+k2N+P7eTT5BPkQ6MUOZrDYy7QsLQlEFfFCea8UZfw3qRgjGwt1RHPP1Ny
         GczgmB1KcIMHlW0gj4flgGOXRAQNitnsRCjbrgqpNqbaj8yep4AjNFZxlY1EX6Nhnz6T
         +9V8TcdLZl16LqP58aeV2GuS8BEhIMGnJ8hmBn6EERja/yYOS3c41B2wv6w6fE6wuAOK
         jQAMKHHqtqVAw2LzeTjYp0i9QzXwqCuhAT9oJPIAH9nOl2qsSWeljWk9KPbw/oYVsjl8
         cgT9tUQQBoWHjjM4EhpXa0BIDMnd4msDWEjTL3c78psW8OEaS9vW+ivmSFSdOooDdHAJ
         FaoQ==
X-Gm-Message-State: AFqh2kqjF4UQfUXBLHAEEV8H7kdeTapngt3HtPCOwhv7mqFrwpA/0Dwk
        LIFVK7ccPGBbd+nKTVv0NQ+HOPnfY3K/HxTvmGmc848XIbc=
X-Google-Smtp-Source: AMrXdXvCa5dwn3YT3QvNBr5wNA++8qc2IG5Xn2iL/QFt++L6A9MBlsHn9XlRbSMY9vObDgerKKxZi7ard0T5b2FhXvU=
X-Received: by 2002:a17:907:98ee:b0:7c1:5ff0:6cc2 with SMTP id
 ke14-20020a17090798ee00b007c15ff06cc2mr5350950ejc.246.1673459772403; Wed, 11
 Jan 2023 09:56:12 -0800 (PST)
MIME-Version: 1.0
References: <20230108030748.158120-1-joanbrugueram@gmail.com>
 <20230109040531.7888-1-joanbrugueram@gmail.com> <Y76bbtJn+jIV3pOz@hirez.programming.kicks-ass.net>
In-Reply-To: <Y76bbtJn+jIV3pOz@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 11 Jan 2023 18:56:01 +0100
Message-ID: <CAJZ5v0j1gk2bW1s3w23frjroxKihBFEb_9CJ7_Vx_ezkCO01GA@mail.gmail.com>
Subject: Re: Wake-up from suspend to RAM broken under `retbleed=stuff`
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joan Bruguera <joanbrugueram@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 12:20 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jan 09, 2023 at 04:05:31AM +0000, Joan Bruguera wrote:
> > This fixes wakeup for me on both QEMU and real HW
> > (just a proof of concept, don't merge)
> >
> > diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
> > index ffea98f9064b..8704bcc0ce32 100644
> > --- a/arch/x86/kernel/callthunks.c
> > +++ b/arch/x86/kernel/callthunks.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/memory.h>
> >  #include <linux/moduleloader.h>
> >  #include <linux/static_call.h>
> > +#include <linux/suspend.h>
> >
> >  #include <asm/alternative.h>
> >  #include <asm/asm-offsets.h>
> > @@ -150,6 +151,10 @@ static bool skip_addr(void *dest)
> >       if (dest >= (void *)hypercall_page &&
> >           dest < (void*)hypercall_page + PAGE_SIZE)
> >               return true;
> > +#endif
> > +#ifdef CONFIG_PM_SLEEP
> > +     if (dest == restore_processor_state)
> > +             return true;
> >  #endif
> >       return false;
> >  }
> > diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
> > index 236447ee9beb..e667894936f7 100644
> > --- a/arch/x86/power/cpu.c
> > +++ b/arch/x86/power/cpu.c
> > @@ -281,6 +281,9 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
> >  /* Needed by apm.c */
> >  void notrace restore_processor_state(void)
> >  {
> > +     /* Restore GS before calling anything to avoid crash on call depth accounting */
> > +     native_wrmsrl(MSR_GS_BASE, saved_context.kernelmode_gs_base);
> > +
> >       __restore_processor_state(&saved_context);
> >  }
>
> Yeah, I can see why, but I'm not really comfortable with this. TBH, I
> don't see how the whole resume code is correct to begin with. At the
> very least it needs a heavy dose of noinstr.
>
> Rafael, what cr3 is active when we call restore_processor_state()?

On resume from suspend-to-RAM, the one that was saved by
__save_processor_state() AFAICS.

On resume from hibernation, it looks like this is the one that was
used by the restore kernel.

> Specifically, the problem is that I don't feel comfortable doing any
> sort of weird code until all the CR and segment registers have been
> restored, however, write_cr*() are paravirt functions that result in
> CALL, which then gives us a bit of a checken and egg problem.
>
> I'm also wondering how well retbleed=stuff works on Xen, if at all. If
> we can ignore Xen, things are a little earier perhaps.
