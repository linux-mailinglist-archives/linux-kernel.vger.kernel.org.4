Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1566C5FF673
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 00:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiJNWw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 18:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiJNWw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 18:52:26 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018903C8F6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 15:52:24 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id a17so3278592ilq.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 15:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jbR5+XwFTuPn9xSU9fHoCkGo3f4KWngVx7w96DA+l4M=;
        b=cHPFwe4iw4yl5mXEfprNsN2xaBgevjV5qO4OzsPu5p8eDEiPSR7KEmYRst4GpE9/xU
         p9tNgxcXGObKH2u5IpWvsgX5Qf/f1YxJsapzR55DMn1k1Mch4IBnDoTyUkXaz+IemXlD
         f7mXXFL3XpJSkoyz2vlVY0B9b9cHjIughBqPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jbR5+XwFTuPn9xSU9fHoCkGo3f4KWngVx7w96DA+l4M=;
        b=i20F2GYRaljJrVSLt/kpqz9GyVNdYJd6Kc827pv1HHXUUHHCYCJaG9B5XdsbVm2o8h
         I95JN+uzV/uZ64jkk2/77ZCcsZ9IHAlDFLWCe9lWjO4rnlW7TJ6KQ1DZHUn/rrjRueLO
         EfgeKa2cXSk9G/3XxNVd3umClfwmCFXCVHdsdPesXouGxrfTFK+jzN1FjROjQgYwrzvX
         FXa6dpFcSQH+6S5W25Gyl+M2cjnpYY6hz4jdZvs/SLGdy24ckcy1qUTT9sqmQZHP/rnN
         ahpE32TwHIQgBjixIl+LA/MTlf43KKIGDgaRoZ2nAfheLVCESHJMsm411L3aTYrpOAxk
         GnMQ==
X-Gm-Message-State: ACrzQf0v1HNICKK2vokYfegZTjX53C7nJ8qMP+6PU9xitCRq6srjuQNP
        mXxzgozI9I5KTCBoHBmbWtRhKtpTwAI6fdxXQOmgAA==
X-Google-Smtp-Source: AMsMyM5Y9vWnWJmRhIm/lbebDofHqwRfmBROC6dwCfOFWUYgGfL3zlVkCIAiFZoccJ++1Y8Q4J9s01TbymiJ9+tTLzw=
X-Received: by 2002:a05:6e02:507:b0:2f9:6ab8:2dd5 with SMTP id
 d7-20020a056e02050700b002f96ab82dd5mr6260ils.85.1665787944147; Fri, 14 Oct
 2022 15:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220921144620.GA1200846@paulmck-ThinkPad-P17-Gen-1>
 <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1> <Y0nnBjTHgoIVYMrJ@google.com>
In-Reply-To: <Y0nnBjTHgoIVYMrJ@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 14 Oct 2022 18:52:13 -0400
Message-ID: <CAEXW_YTBOM--SF0JDGmsa4sj5PmA6Zjx-b9t-4gfLtGkxhnHUQ@mail.gmail.com>
Subject: Re: [PATCH v2 rcu 0/8] NMI-safe SRCU reader API
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org, tglx@linutronix.de,
        john.ogness@linutronix.de, pmladek@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 6:47 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Thu, Sep 29, 2022 at 11:07:14AM -0700, Paul E. McKenney wrote:
> > Hello!
> >
> > This RFC series provides the second version of an NMI-safe SRCU reader API
> > in the guise of srcu_read_lock_nmisafe() and srcu_read_unlock_nmisafe().
>
> Just a comment about high-level use of the new NMI-safe SRCU api: say if for
> certain arch, NMI cannot be interrupted (by breakpoint or something), then
> using NMI-safe API will force such arch to potentially use more expensive RMW
> atomic than the previously cheap local non-atomic operations that the arch
> was able to get away with.
>
> Thoughts? Otherwise, LGTM.
>

I take it back. You are indeed guarding it correctly as below. I got
confused by another patch that was doing debug checking even for arch
that does not need it (which is a good thing).

+config NEED_SRCU_NMI_SAFE
+ def_bool HAVE_NMI && !ARCH_HAS_NMI_SAFE_THIS_CPU_OPS && !TINY_SRCU
+

Thanks!

 - Joel


> thanks,
>
>  - Joel
>
>
> > A given srcu_struct structure must use either the traditional
> > srcu_read_lock() and srcu_read_unlock() API or the new _nmisafe() API:
> > Mixing and matching is not permitted.  So much so that kernels built
> > with CONFIG_PROVE_RCU=y will complain if you try it.
> >
> > The reason for this restriction is that I have yet to find a use case
> > that is not a accident waiting to happen.  And if free intermixing
> > were permitted, it is pretty much a given that someone somewhere will
> > get confused and use srcu_read_lock_nmisafe() within NMI handlers and
> > srcu_read_lock() elsewhere, which will not (repeat, NOT) provide NMI
> > safety.
> >
> > I do not expect to push this into the v6.1 merge window.  However, if
> > the printk() series that needs it goes in, then I will push it as a fix
> > for the resulting regression.
> >
> > The series is as follows:
> >
> > 1.    Convert ->srcu_lock_count and ->srcu_unlock_count to atomic.
> >
> > 2.    Create an srcu_read_lock_nmisafe() and srcu_read_unlock_nmisafe().
> >
> > 3.    Check for consistent per-CPU per-srcu_struct NMI safety.
> >
> > 4.    Check for consistent global per-srcu_struct NMI safety.
> >
> > 5.    Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.
> >
> > 6.    Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.
> >
> > 7.    Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.
> >
> > 8.    Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.
> >
> > Changes since v1 RFC:
> >
> > 1.    Added enabling patches for arm64, loongarch, s390, and x86.
> >       These have what appear to me to be NMI-safe this_cpu_inc()
> >       implementations.
> >
> > 2.    Fix a build error on !SMP kernels built without SRCU.
> >
> > 3.    Fix a build error on !SMP kernels.
> >
> >                                               Thanx, Paul
> >
> > ------------------------------------------------------------------------
> >
> >  b/arch/arm64/Kconfig       |    1
> >  b/arch/loongarch/Kconfig   |    1
> >  b/arch/s390/Kconfig        |    1
> >  b/arch/x86/Kconfig         |    1
> >  b/include/linux/srcu.h     |   39 +++++++++++++++++++++
> >  b/include/linux/srcutiny.h |   11 ++++++
> >  b/include/linux/srcutree.h |    4 +-
> >  b/kernel/rcu/Kconfig       |    3 +
> >  b/kernel/rcu/rcutorture.c  |   11 ++++--
> >  b/kernel/rcu/srcutree.c    |   24 ++++++-------
> >  include/linux/srcu.h       |    4 +-
> >  include/linux/srcutiny.h   |    4 +-
> >  include/linux/srcutree.h   |   12 +++++-
> >  kernel/rcu/srcutree.c      |   82 +++++++++++++++++++++++++++++++++++++++------
> >  14 files changed, 166 insertions(+), 32 deletions(-)
