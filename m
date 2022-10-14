Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C285C5FF671
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 00:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiJNWri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 18:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJNWrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 18:47:37 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB83E985F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 15:47:36 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id h15so4617865qtu.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 15:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CIDMRjxZ4Xyp6yANZOVgTit6chFtmm8gE1u2KRrbiU8=;
        b=GipgvN6jIGf1x1HRWRkuPlagiWaApeFXdmJAP4qXH3TwUDbzJXtfqr9R3opH8hRWY/
         +/KDsmggt6ZxSzmGITw6hPj4/xT8x+GbDbVtnvjoUsxcx3QH7X07ta/EqTNWHeq2LdjV
         N7yTbp//7DJEsF8daPKOFeR3TIrsbhBlxBGT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIDMRjxZ4Xyp6yANZOVgTit6chFtmm8gE1u2KRrbiU8=;
        b=re31ljcqnouoxaPSHWiJPAETHtIKDoFmxzIPJmrcj4oiK0UOe4iZFFcEL5OJ0ShHbt
         A74HLi1NZYjfBbkwzT19fqlQRKrb2h6MjtajPGcirN3WLbFbQuc2M9wGuI0gs9YyT0GP
         wCf/53AAfvYVW0XOHz2lw7ze+g2IcceeacDhcpI48Uw5yBFzDy7YyjoNoISkq3bd63GX
         /M3c5zJVtwNMSFMEnRDfhkV4BLUPtZjUMrzGoEENu3da1L89akkp2yNddMSmc0a0kB7Z
         4OD9xY/OnHtEvL+nZfi9sDCqVtu1tefQutJeCMofovXqsseFGkTVaj+7IyohVK1sEnpF
         UP+w==
X-Gm-Message-State: ACrzQf059LZ8NdnMhjsS61j4ZGzwYDLuYEF8vv9dbxsCBvcqi7hwzpsx
        8vpKj+dzGqvvhMDFNsDVODawBQ==
X-Google-Smtp-Source: AMsMyM7wDDuVtEeH+l+T5khpojv2WAPqZgECsSkVI+QouWbHu5+cM9SHTr9XgZdHMNlNXHQgigMWew==
X-Received: by 2002:a05:622a:4d1:b0:39c:beaa:411e with SMTP id q17-20020a05622a04d100b0039cbeaa411emr54269qtx.530.1665787655417;
        Fri, 14 Oct 2022 15:47:35 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id d9-20020ac85349000000b00343057845f7sm2800923qto.20.2022.10.14.15.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 15:47:34 -0700 (PDT)
Date:   Fri, 14 Oct 2022 22:47:34 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org, tglx@linutronix.de,
        john.ogness@linutronix.de, pmladek@suse.com
Subject: Re: [PATCH v2 rcu 0/8] NMI-safe SRCU reader API
Message-ID: <Y0nnBjTHgoIVYMrJ@google.com>
References: <20220921144620.GA1200846@paulmck-ThinkPad-P17-Gen-1>
 <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 11:07:14AM -0700, Paul E. McKenney wrote:
> Hello!
> 
> This RFC series provides the second version of an NMI-safe SRCU reader API
> in the guise of srcu_read_lock_nmisafe() and srcu_read_unlock_nmisafe().

Just a comment about high-level use of the new NMI-safe SRCU api: say if for
certain arch, NMI cannot be interrupted (by breakpoint or something), then
using NMI-safe API will force such arch to potentially use more expensive RMW
atomic than the previously cheap local non-atomic operations that the arch
was able to get away with.

Thoughts? Otherwise, LGTM.

thanks,

 - Joel


> A given srcu_struct structure must use either the traditional
> srcu_read_lock() and srcu_read_unlock() API or the new _nmisafe() API:
> Mixing and matching is not permitted.  So much so that kernels built
> with CONFIG_PROVE_RCU=y will complain if you try it.
> 
> The reason for this restriction is that I have yet to find a use case
> that is not a accident waiting to happen.  And if free intermixing
> were permitted, it is pretty much a given that someone somewhere will
> get confused and use srcu_read_lock_nmisafe() within NMI handlers and
> srcu_read_lock() elsewhere, which will not (repeat, NOT) provide NMI
> safety.
> 
> I do not expect to push this into the v6.1 merge window.  However, if
> the printk() series that needs it goes in, then I will push it as a fix
> for the resulting regression.
> 
> The series is as follows:
> 
> 1.	Convert ->srcu_lock_count and ->srcu_unlock_count to atomic.
> 
> 2.	Create an srcu_read_lock_nmisafe() and srcu_read_unlock_nmisafe().
> 
> 3.	Check for consistent per-CPU per-srcu_struct NMI safety.
> 
> 4.	Check for consistent global per-srcu_struct NMI safety.
> 
> 5.	Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.
> 
> 6.	Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.
> 
> 7.	Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.
> 
> 8.	Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.
> 
> Changes since v1 RFC:
> 
> 1.	Added enabling patches for arm64, loongarch, s390, and x86.
> 	These have what appear to me to be NMI-safe this_cpu_inc()
> 	implementations.
> 
> 2.	Fix a build error on !SMP kernels built without SRCU.
> 
> 3.	Fix a build error on !SMP kernels.
> 
> 						Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
>  b/arch/arm64/Kconfig       |    1 
>  b/arch/loongarch/Kconfig   |    1 
>  b/arch/s390/Kconfig        |    1 
>  b/arch/x86/Kconfig         |    1 
>  b/include/linux/srcu.h     |   39 +++++++++++++++++++++
>  b/include/linux/srcutiny.h |   11 ++++++
>  b/include/linux/srcutree.h |    4 +-
>  b/kernel/rcu/Kconfig       |    3 +
>  b/kernel/rcu/rcutorture.c  |   11 ++++--
>  b/kernel/rcu/srcutree.c    |   24 ++++++-------
>  include/linux/srcu.h       |    4 +-
>  include/linux/srcutiny.h   |    4 +-
>  include/linux/srcutree.h   |   12 +++++-
>  kernel/rcu/srcutree.c      |   82 +++++++++++++++++++++++++++++++++++++++------
>  14 files changed, 166 insertions(+), 32 deletions(-)
