Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD335FE6C7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 04:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJNCEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 22:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJNCEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 22:04:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A48A8359;
        Thu, 13 Oct 2022 19:04:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F2D3B821B7;
        Fri, 14 Oct 2022 02:04:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DF0C433C1;
        Fri, 14 Oct 2022 02:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665713069;
        bh=71JUZnb+/GHrSs/6gc/+znRrLGAfu5erJaV2UmEv+m0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M+FQzbL3lM0qGKwdlolPZlvEUUsmTgpP8TcQVX6CKmos/pVjrUau3/h11d3x0428d
         TiON4OkKo1L1Np0Rc6/01kI6W+BrYjmdQmtSfToHvLsoA0wJcCFcFVO/pYsGPjddr4
         voAcZ5M5gllo4H822+NaDZN1ln0a76yLBK7yJITO6lCsJ08nCasgXTYBUlYET6MHeT
         csux4KwOIaaLdDm7FXBLim6gCIJQ9VYVrnZi6p02BkWoWkVWrOQTHGULQQ4LTih+AD
         0LRYd088p7F6ongtuiGRE36UnlxVu+ETwGVI+ZP4UWiFRtdXNbEc965npGWQp/ecGH
         Y5UlutY8qFE4A==
Date:   Thu, 13 Oct 2022 19:04:27 -0700
From:   Mark Gross <markgross@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Mark Gross <markgross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Danie l Wagner <dwagner@suse.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Junxiao Chang <junxiao.chang@intel.com>
Subject: Re: [ANNOUNCE] 4.9.327-rt197
Message-ID: <Y0jDq2cCoTrLFHGZ@T470>
References: <165222469651.210737.17409564443317121708@T470>
 <Yy4ShVWORi6XNhCv@T470>
 <YzcEIU17EIZ7ZIF5@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzcEIU17EIZ7ZIF5@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 04:58:41PM +0200, Sebastian Andrzej Siewior wrote:
> On 2022-09-23 13:09:41 [-0700], Mark Gross wrote:
> > > As this was a tricky one I request people to give a good look over.
> 
> You did good. I not so much. If you could please add the following patch
> on top, then it will compile also on !RT.
> 
> Thank you for work.
> 
> ------->8----------
> 
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Date: Fri, 30 Sep 2022 16:55:34 +0200
> Subject: [PATCH] local_lock: Provide INIT_LOCAL_LOCK().
> 
> The original code was using INIT_LOCAL_LOCK() and I tried to sneak
> around it and forgot that this code also needs to compile on !RT
> platforms.
> 
> Provide INIT_LOCAL_LOCK() to initialize properly on RT and do nothing on
> !RT. Let random.c use which is the only user so far and oes not compile
> on !RT otherwise.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/char/random.c     | 4 ++--
>  include/linux/locallock.h | 5 +++++
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index daea466812fed..86c475f70343d 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -236,7 +236,7 @@ struct crng {
>  
>  static DEFINE_PER_CPU(struct crng, crngs) = {
>  	.generation = ULONG_MAX,
> -	.lock.lock = __SPIN_LOCK_UNLOCKED(crngs.lock.lock),
> +	.lock = INIT_LOCAL_LOCK(crngs.lock),
>  };
>  
>  /* Used by crng_reseed() and crng_make_state() to extract a new seed from the input pool. */
> @@ -515,7 +515,7 @@ struct batch_ ##type {								\
>  };										\
>  										\
>  static DEFINE_PER_CPU(struct batch_ ##type, batched_entropy_ ##type) = {	\
> -	.lock.lock = __SPIN_LOCK_UNLOCKED(batched_entropy_ ##type.lock.lock),	\
> +	.lock = INIT_LOCAL_LOCK(batched_entropy_ ##type.lock),			\
>  	.position = UINT_MAX							\
>  };										\
>  										\
> diff --git a/include/linux/locallock.h b/include/linux/locallock.h
> index 0c3ff5b23f6a1..70af9a177197e 100644
> --- a/include/linux/locallock.h
> +++ b/include/linux/locallock.h
> @@ -22,6 +22,8 @@ struct local_irq_lock {
>  	unsigned long		flags;
>  };
>  
> +#define INIT_LOCAL_LOCK(lvar)			{ .lock = __SPIN_LOCK_UNLOCKED((lvar).lock.lock) }
> +
>  #define DEFINE_LOCAL_IRQ_LOCK(lvar)					\
>  	DEFINE_PER_CPU(struct local_irq_lock, lvar) = {			\
>  		.lock = __SPIN_LOCK_UNLOCKED((lvar).lock) }
> @@ -256,6 +258,9 @@ static inline int __local_unlock_irqrestore(struct local_irq_lock *lv,
>  
>  #else /* PREEMPT_RT_BASE */
>  
> +struct local_irq_lock { };
> +#define INIT_LOCAL_LOCK(lvar)			{ }
> +
>  #define DEFINE_LOCAL_IRQ_LOCK(lvar)		__typeof__(const int) lvar
>  #define DECLARE_LOCAL_IRQ_LOCK(lvar)		extern __typeof__(const int) lvar
>  
> -- 
> 2.37.2
> 
> 
> Sebastian

Thanks!  I've applied this and starting some testing. I've also pushed the
update to v4.9-rt-next if anyone feels like giving a spin before I make the
release.

I think I'll finally get the release done in the next few days.

--mark
