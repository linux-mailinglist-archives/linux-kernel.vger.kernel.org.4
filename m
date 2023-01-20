Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA15675CDC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjATSjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjATSjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:39:03 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D826E0E0;
        Fri, 20 Jan 2023 10:39:00 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id tz11so16294050ejc.0;
        Fri, 20 Jan 2023 10:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6BhUftdNaonuiROR9jpyMxYbsnTELD0tKBLUFO53zPU=;
        b=VBX2BW2A8fy6ZnGqVAoahdP7cjvLaOj1IOK9On7yi/synDxlwTSwELNzhGJA+ZJRkx
         Ty381MhvelZUZINrQdyKvKpu8JlYIPx0+TLlbmiNloHJuyZ1hV5PYyYGFxTRpX7fKxma
         2Y3YKIvnddwXA1oQjeVRN7JSrNiN/eTURjWoajtXpiY+dAlIq4bW4hTa8g7IpysnLzYS
         wopKhi+w+T8NdNml256tYPRQmDjYyCZO2nJvpHaqAVezA/rFeu0RoE5l8WJOXFRJFqkD
         H9htStayO6m9j2s60cbS25NCVR2aGjFqAz7eMKpscpfeMlMxxr4r13JkSWruIrWDrLA+
         AAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BhUftdNaonuiROR9jpyMxYbsnTELD0tKBLUFO53zPU=;
        b=R4G0aEfiUKvvElFPAES2V55L3mA25ZB/Y1JT5xZMmU8q64GtMhJkTqSer7G3q79azy
         ijz61lOFYmisSok6SQyvyvDoZvgoGkGSqJEFtAzRlttGsoGfJnzWqvsqQqZk3viB3TPw
         7Zj3Ga+INlUOAexb72prq7ZOWcBc5jY22kRVdfeSikpf/NP9CzCi6av/Ap+HZ8kedlfv
         b8sj+M9SL+VpQ/OuYpcr4O2zJRT2hjbbfxvzvOSO72hHdCqz3DIxQ41s5TTrRc0lOmMc
         2QMvlYB8VTqzb7/BE1Cu3YF6310qCD+ZzDjGALWy+vuKi9E2su3qqifOaA0LZlaP3NkB
         teoQ==
X-Gm-Message-State: AFqh2kogDCoFQyxy/cQHQoaLbpIs2NlMBfx4qbA/gYmylQLsFuvLrOHz
        pv45anUV6j3acUyjdF8kayg=
X-Google-Smtp-Source: AMrXdXv6bmu1GGgCx3L4ktykPc+juV1ucZB9xQae6CCQZ5WOeqj2fhSBdycG+hKIgBy3WnauLFVDLA==
X-Received: by 2002:a17:906:bc58:b0:872:2cc4:6882 with SMTP id s24-20020a170906bc5800b008722cc46882mr18144799ejv.58.1674239938585;
        Fri, 20 Jan 2023 10:38:58 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id o14-20020a17090637ce00b00871390a3b74sm7326818ejc.177.2023.01.20.10.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 10:38:57 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id DDB59BE2EE8; Fri, 20 Jan 2023 19:38:56 +0100 (CET)
Date:   Fri, 20 Jan 2023 19:38:56 +0100
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Jens Axboe <axboe@kernel.dk>,
        Pavel Machek <pavel@denx.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jeff Brady <jeffreyjbrady@gmail.com>
Subject: Re: [ANNOUNCE] 5.10.162-rt78
Message-ID: <Y8rfwA7F1gObKGG7@eldamar.lan>
References: <40de655e-26f3-aa7b-f1ec-6877396a9f1e@ti.com>
 <Y8krsVFguwWLy+zT@duo.ucw.cz>
 <Y8lCspFtQ0wg6uCy@uudg.org>
 <Y8mwF0m+M1+e/fz/@eldamar.lan>
 <a4f62523-b01e-3986-7914-767f999b4153@kernel.dk>
 <Y8oNTkUVDr7iQWzp@uudg.org>
 <c427d686-c850-4195-011b-93f51faa176d@kernel.dk>
 <Y8qOOxON9Vfsek0l@uudg.org>
 <Y8q1P8NUJYIxd1Tr@FVFF77S0Q05N>
 <Y8rctZK+QxmRNHqg@uudg.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zM3yRwb4TXqUf9Sm"
Content-Disposition: inline
In-Reply-To: <Y8rctZK+QxmRNHqg@uudg.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zM3yRwb4TXqUf9Sm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

On Fri, Jan 20, 2023 at 03:25:57PM -0300, Luis Claudio R. Goncalves wrote:
> On Fri, Jan 20, 2023 at 03:37:35PM +0000, Mark Rutland wrote:
> > On Fri, Jan 20, 2023 at 09:51:07AM -0300, Luis Claudio R. Goncalves wrote:
> > > On Thu, Jan 19, 2023 at 08:49:28PM -0700, Jens Axboe wrote:
> > > > On 1/19/23 8:44?PM, Luis Claudio R. Goncalves wrote:
> > > > > On Thu, Jan 19, 2023 at 04:09:44PM -0700, Jens Axboe wrote:
> > > > >> On 1/19/23 2:03?PM, Salvatore Bonaccorso wrote:
> > > > >>> Hi Luis, all,
> > > > >>>
> > > > >>> On Thu, Jan 19, 2023 at 10:16:34AM -0300, Luis Claudio R. Goncalves wrote:
> > > > >>>> On Thu, Jan 19, 2023 at 12:38:25PM +0100, Pavel Machek wrote:
> > > > >>>>> Hi!
> > > > >>>>>
> > > > >>>>>>> I'm pleased to announce the 5.10.162-rt78 stable release.
> > > > >>>>>>>
> > > > >>>>>>> You can get this release via the git tree at:
> > > > >>>>>>>
> > > > >>>>>>>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
> > > > >>>>>>>
> > > > >>>>>>>   branch: v5.10-rt
> > > > >>>>>>>   Head SHA1: 143ef105f40a65f3ddd57121d4b4bc36eb10cc06
> > > > >>>>>>>
> > > > >>>>>>> Or to build 5.10.162-rt78 directly, the following patches should be applied:
> > > > >>>>>
> > > > >>>>>> I see that vanilla 5.10.162-rt78 fails to build with arm64 defconfig. [0] Full log [1]
> > > > >>>>>> Any pointers on what maybe wrong?
> > > > >>>>>
> > > > >>>>> We see the same failure. 
> > > > >>>>>
> > > > >>>>>>   AS      arch/arm64/kernel/entry.o
> > > > >>>>>> arch/arm64/kernel/entry.S: Assembler messages:
> > > > >>>>>> arch/arm64/kernel/entry.S:763: Error: immediate out of range at operand 3 -- `and x2,x19,#((1<<1)|(1<<0)|(1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6)|(1<<13)|(1<<7))'
> > > > >>>>>> make[2]: *** [scripts/Makefile.build:367: arch/arm64/kernel/entry.o] Error 1
> > > > >>>>>> make[1]: *** [scripts/Makefile.build:503: arch/arm64/kernel] Error 2
> > > > >>>>>> make: *** [Makefile:1837: arch/arm64] Error 2
> > > > >>>>>
> > > > >>>>> The line is:
> > > > >>>>>
> > > > >>>>>>        and     x2, x19, #_TIF_WORK_MASK
> > > > >>>>
> > > > >>>> I believe this is related to the arch/arm64/include/asm/thread_info.h
> > > > >>>> changes in 5.10.162-rt78, specifically:
> > > > >>>>
> > > > >>>>     79a9991e87fe arm64: add support for TIF_NOTIFY_SIGNAL
> > > > >>>>     1ba44dcf789d Merge tag 'v5.10.162' into v5.10-rt
> > > > >>>>
> > > > >>>> The first one is the original change, coming from stable v5.10.162 and the
> > > > >>>> second one has the merge conflict I fixed in that file due to the existence
> > > > >>>> of TIF_NEED_RESCHED_LAZY in PREEMPT_RT.
> > > > >>>>
> > > > >>>> It escaped me that having TIF_NEED_RESCHED_LAZY set to 13 breaks the AND
> > > > >>>> statement reported above. Looking at
> > > > >>>>
> > > > >>>>     b5a5a01d8e9a arm64: uaccess: remove addr_limit_user_check()
> > > > >>>>
> > > > >>>> specially this note
> > > > >>>>
> > > > >>>>     To ensure that _TIF_WORK_MASK can be used as an immediate value in an
> > > > >>>>     AND instruction (as it is in `ret_to_user`), TIF_MTE_ASYNC_FAULT is
> > > > >>>>     renumbered to keep the constituent bits of _TIF_WORK_MASK contiguous.
> > > > >>>>
> > > > >>>> I understand that I need to either have to renumber TIF_NEED_RESCHED_LAZY
> > > > >>>> to 8, with the risk of breaking something else, or backport commit
> > > > >>>> b5a5a01d8e9a in order to remove TIF_FSCHECK and then safely renumber
> > > > >>>> TIF_NEED_RESCHED_LAZY.
> > > > >>>>
> > > > >>>> Guidance is welcome here :)
> > > > >>>
> > > > >>> Should we loop in here Jens, as having some overview of the needed
> > > > >>> changes for io_uring rebase in the 5.10.y version? (doing so in the
> > > > >>> mail).
> > > > >>
> > > > >> Huh that's funky, I built and (runtime) tested this on arm64
> > > > >> specifically. But I do remember some details about the first 8 bits on
> > > > >> arm, but not arm64.
> > > > >>
> > > > >> I guess we need to twiddle that asm to deal with eg 16 bits, rather than
> > > > >> attempt to backport any TIF removal patches.
> > > > > 
> > > > > One simple solution, tested with defconfig plus FTRACE options (including
> > > > > FTRACE_SYSCALLS) enabled, is:
> > > > > 
> > > > > diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> > > > > index 6eb36a2126e8..37f19bb49d38 100644
> > > > > --- a/arch/arm64/include/asm/thread_info.h
> > > > > +++ b/arch/arm64/include/asm/thread_info.h
> > > > > @@ -70,12 +70,12 @@ void arch_release_task_struct(struct task_struct *tsk);
> > > > >  #define TIF_FSCHECK		5	/* Check FS is USER_DS on return */
> > > > >  #define TIF_MTE_ASYNC_FAULT	6	/* MTE Asynchronous Tag Check Fault */
> > > > >  #define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
> > > > > -#define TIF_SYSCALL_TRACE	8	/* syscall trace active */
> > > > > +#define TIF_NEED_RESCHED_LAZY	8
> > > > >  #define TIF_SYSCALL_AUDIT	9	/* syscall auditing */
> > > > >  #define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
> > > > >  #define TIF_SECCOMP		11	/* syscall secure computing */
> > > > >  #define TIF_SYSCALL_EMU		12	/* syscall emulation active */
> > > > > -#define TIF_NEED_RESCHED_LAZY	13
> > > > > +#define TIF_SYSCALL_TRACE	13	/* syscall trace active */
> > > > >  #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
> > > > >  #define TIF_FREEZE		19
> > > > >  #define TIF_RESTORE_SIGMASK	20
> > > > > 
> > > > > Would that be acceptable? With that we ensure the bits in
> > > > > _TIF_WORK_MASK are contiguous and within the 8 bits limit you
> > > > > mentioned. And TIF_SYSCALL_TRACE did not seem to have any (build)
> > > > > problem with the new value.
> > > > 
> > > > That should work too, the _TIF_WORK_MASK bits being in the lower 8 bits
> > > > is really all we should care about.
> > > 
> > > Jens, Salvatore, Mike, I ran a few tests and confirmed that the current asm
> > > code is not restricted to 8 bits. The problems is that there is a
> > > requirement for the mask bits to be contiguous in that specific context.
> > 
> > Just to confirm from the arm64 side, the instruction using this just requires
> > the bits to be contiguous, there's no restriction on *which* bits those are.
> 
> Thank you, that's really helpful!
>  
> > If you're going to mess around with the arm64 bits, please could you Cc someone
> > form the arm64 side? e.g. I fixed a similar issue in mainline in commit:
> > 
> >   870d16757ba8918c ("arm64: make _TIF_WORK_MASK bits contiguous")
> > 
> > ... and either Will Deacon or Catalin Marinas may have had comments as they're
> > the arm64 maintainers...
> 
> Just to avoid confusion here, this change is specific to the v5.10-rt, not
> applicable upstream nor to newer RT. We only saw the problem because
> TIF_NOTIFY_SIGNAL was mapped to a bit used by TIF_NEED_RESCHED_LAZY in
> v5.10-rt (the PREEMPT_RT changes on top of stable v5.10). This is why
> nobody from the arm64 side was copied initially, as we were trying to
> assert what was the problem.
> 
> > > The explanation from commit b5a5a01d8e9a ("arm64: uaccess: remove
> > > addr_limit_user_check()") describes quite well our case:
> > > 
> > >      To ensure that _TIF_WORK_MASK can be used as an immediate value in an
> > >      AND instruction (as it is in `ret_to_user`), TIF_MTE_ASYNC_FAULT is
> > >      renumbered to keep the constituent bits of _TIF_WORK_MASK contiguous.
> > > 
> > > My question is: do you prefer renumbering the bits or the neat asm hack
> > > that Mike proposed? 
> > 
> > I would strongly recommend renumbering the bits over changing the asm. That's
> > going to be closer to what mainline has already done, and it avoids introducing
> > weird ifdeffery.
> > 
> > That said, rather than swapping TIF_SYSCALL_TRACE and TIF_NEED_RESCHED_LAZY,
> > you could just shuffle the bits down-by-one, keeping all the existing
> > contiguity, e.g.
> > 
> > 	#define TIF_NEED_RESCHED_LAZY    8
> > 	#define TIF_SYSCALL_TRACE        9
> > 	#define TIF_SYSCALL_AUDIT        10
> > 	#define TIF_SYSCALL_TRACEPOINT   11
> > 
> > ... and so on.
> 
> Would something like this be a good interpretation of your suggestion?
> 
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index 6eb36a212..2afd9ceb6 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -70,12 +70,12 @@ void arch_release_task_struct(struct task_struct *tsk);
>  #define TIF_FSCHECK		5	/* Check FS is USER_DS on return */
>  #define TIF_MTE_ASYNC_FAULT	6	/* MTE Asynchronous Tag Check Fault */
>  #define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
> -#define TIF_SYSCALL_TRACE	8	/* syscall trace active */
> -#define TIF_SYSCALL_AUDIT	9	/* syscall auditing */
> -#define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
> -#define TIF_SECCOMP		11	/* syscall secure computing */
> -#define TIF_SYSCALL_EMU		12	/* syscall emulation active */
> -#define TIF_NEED_RESCHED_LAZY	13
> +#define TIF_NEED_RESCHED_LAZY	8
> +#define TIF_SYSCALL_TRACE	9	/* syscall trace active */
> +#define TIF_SYSCALL_AUDIT	10	/* syscall auditing */
> +#define TIF_SYSCALL_TRACEPOINT	11	/* syscall tracepoint for ftrace */
> +#define TIF_SECCOMP		12	/* syscall secure computing */
> +#define TIF_SYSCALL_EMU		13	/* syscall emulation active */
>  #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
>  #define TIF_FREEZE		19
>  #define TIF_RESTORE_SIGMASK	20

I tried to follow the discussion as well which resulted in the
following change, which matches how you interpreted it as well. It's
just for reference, you can trow away the patch here in favour of your
change by all means.

Regards,
Salvatore

--zM3yRwb4TXqUf9Sm
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-arm64-make-_TIF_WORK_MASK-bits-contiguous.patch"

From 2c84672db9b8a6bd61b9c0939cb94652b62aa39d Mon Sep 17 00:00:00 2001
From: Salvatore Bonaccorso <carnil@debian.org>
Date: Fri, 20 Jan 2023 19:23:03 +0100
Subject: [PATCH] arm64: make _TIF_WORK_MASK bits contiguous

As same as in commit 870d16757ba8 ("arm64: make _TIF_WORK_MASK bits
contiguous") in mainline, we need to make the bits of _TIF_WORK_MASK to
be contiguous in order to use this as an immediate argument to an AND
instruction in entry.S.

We shuffle these bits down-by-one keeping the existing contiguity after
inserting TIF_NEED_RESCHED_LAZY.

Otherwise, omitting this change will result in a build failure as below:

    arch/arm64/kernel/entry.S: Assembler messages:
    arch/arm64/kernel/entry.S:763: Error: immediate out of range at operand 3 -- `and x2,x19,#((1<<1)|(1<<0)|(1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6)|(1<<13)|(1<<7))'

Reported-by: Vignesh Raghavendra <vigneshr@ti.com>
Reported-by: Pavel Machek <pavel@denx.de>
Link: https://lore.kernel.org/lkml/40de655e-26f3-aa7b-f1ec-6877396a9f1e@ti.com/
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 arch/arm64/include/asm/thread_info.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 6eb36a2126e8..2afd9ceb66c9 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -70,12 +70,12 @@ void arch_release_task_struct(struct task_struct *tsk);
 #define TIF_FSCHECK		5	/* Check FS is USER_DS on return */
 #define TIF_MTE_ASYNC_FAULT	6	/* MTE Asynchronous Tag Check Fault */
 #define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
-#define TIF_SYSCALL_TRACE	8	/* syscall trace active */
-#define TIF_SYSCALL_AUDIT	9	/* syscall auditing */
-#define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
-#define TIF_SECCOMP		11	/* syscall secure computing */
-#define TIF_SYSCALL_EMU		12	/* syscall emulation active */
-#define TIF_NEED_RESCHED_LAZY	13
+#define TIF_NEED_RESCHED_LAZY	8
+#define TIF_SYSCALL_TRACE	9	/* syscall trace active */
+#define TIF_SYSCALL_AUDIT	10	/* syscall auditing */
+#define TIF_SYSCALL_TRACEPOINT	11	/* syscall tracepoint for ftrace */
+#define TIF_SECCOMP		12	/* syscall secure computing */
+#define TIF_SYSCALL_EMU		13	/* syscall emulation active */
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
 #define TIF_FREEZE		19
 #define TIF_RESTORE_SIGMASK	20
-- 
2.39.0


--zM3yRwb4TXqUf9Sm--
