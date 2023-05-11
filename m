Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E23F6FF9F1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 21:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238949AbjEKTMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 15:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbjEKTMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 15:12:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D456E8A57
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 12:12:15 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683832263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z/c57fGI76Etvz35JP6oYi56+W2cE5Opvi4hQ9J18Gk=;
        b=eieIKIMVU6HyUXgjUhiQnvhyCt0FltP7sWWls5ql4poV9hK21esWHSd0mHfiQi9aY6OEs8
        7/EkYpiasPxMwNyJ77uIjD1sldif2LJ1zW0dV4EnYZWZxYMMtVH+Nt9vlpvIe3Yo3J7KB+
        OSiIEIi3+vgdAI36p5GCloBxJv/uYJ98+D1KgV+Gh/wgPioj8zlHGeIOwJoqrteTVN2R7y
        uZjNMleW8+zNWU9WHxuS+jPjlE5N+X9ElCXVaVgMUFMefEj4eWariHnyEOqIow2SbSl+q2
        Nk3Kt8bev2QHCyRSbudoB56jRaOWbG18AUIrdzwv4bKhnJ+Km0bf7XesbWzGdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683832263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z/c57fGI76Etvz35JP6oYi56+W2cE5Opvi4hQ9J18Gk=;
        b=mx435wk27fjwmLF8qGCLTrq98EJJ76mOT5Snc5JargynMtdsU1X8/5wfzkRWj68wXA86ZV
        kiIh1FNJo3YuIkCg==
To:     Adamos Ttofari <attofari@amazon.de>
Cc:     abusse@amazon.de, dwmw@amazon.co.uk, hborghor@amazon.de,
        sironi@amazon.de, attofari@amazon.de,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Kyle Huey <me@kylehuey.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpu: xstate: Keep xfd_state always in-sync with
 IA32_XFD MSR
In-Reply-To: <20230511152818.13839-1-attofari@amazon.de>
References: <20230511152818.13839-1-attofari@amazon.de>
Date:   Thu, 11 May 2023 21:11:02 +0200
Message-ID: <877cted6pl.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11 2023 at 15:28, Adamos Ttofari wrote:

> Commit 672365477ae8 ("x86/fpu: Update XFD state where required") and
> commit 8bf26758ca96 ("x86/fpu: Add XFD state to fpstate") introduced a
> per_cpu variable xfd_state to keep the IA32_XFD MSR value cached. In
> order to avoid unnecessary writes to the MSR.
>
> xfd_state might not be always synced with the MSR. Eventually affecting
> MSR writes. xfd_state is initialized with 0, meanwhile the MSR is
> initialized with the XFEATURE_MASK_USER_DYNAMIC to make XFD fire. Then
> later on reschedule to a different CPU, when a process that uses extended
> xfeatures and handled the #NM (by allocating the additional space in task's
> fpstate for extended xfeatures) it will skip the MSR update in
> restore_fpregs_from_fpstate because the value might match to already cached
> xfd_state (meanwhile it is not the same with the MSR). Eventually calling a
> XRSTOR to set the new state (that caries extended xfeatures) and fire a #NM
> from kernel context. The XFD is expected to fire from user-space context,
> but not in this case and the kernel crashes.

I'm completely confused.

So after reading the patch I think I know what you are trying to
explain:

   On CPU hotplug MSR_IA32_XFD is reset to the init_fpstate.xfd, which
   wipes out any stale state. But the per CPU cached xfd value is not
   reset, which brings them out of sync.

   As a consequence a subsequent xfd_update_state() might fail to update
   the MSR which in turn can result in XRSTOR raising a #NM in kernel
   space, which crashes the kernel.

Right?

> To address the issue mentioned initialize xfd_state with the current MSR
> value and update the XFD MSR always with xfd_update_state to avoid
> un-sync cases.
>
> Fixes: 672365477ae8 ("x86/fpu: Update XFD state where required")
>
> Signed-off-by: Adamos Ttofari <attofari@amazon.de>
> ---
>  arch/x86/kernel/fpu/xstate.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 0bab497c9436..36ed27ac0ecd 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -179,8 +179,14 @@ void fpu__init_cpu_xstate(void)
>  	 * key as that does not work on the boot CPU. This also ensures
>  	 * that any stale state is wiped out from XFD.
>  	 */
> -	if (cpu_feature_enabled(X86_FEATURE_XFD))
> -		wrmsrl(MSR_IA32_XFD, init_fpstate.xfd);
> +	if (cpu_feature_enabled(X86_FEATURE_XFD)) {
> +		u64 xfd;
> +
> +		rdmsrl(MSR_IA32_XFD, xfd);
> +		__this_cpu_write(xfd_state, xfd);
> +
> +		xfd_update_state(&init_fpstate);
> +	}

This does not compile on 32bit. You want something like the uncompiled
below.

>  	/*
>  	 * XCR_XFEATURE_ENABLED_MASK (aka. XCR0) sets user features
> @@ -915,7 +921,7 @@ void fpu__resume_cpu(void)
>  	}
>  
>  	if (fpu_state_size_dynamic())
> -		wrmsrl(MSR_IA32_XFD, current->thread.fpu.fpstate->xfd);
> +		xfd_update_state(&init_fpstate);

On suspend per CPU xfd_state == current->thread.fpu.fpstate->xfd so it's
correct to restore the exact state which was active _before_ suspend.
xfd_state can't be out of sync in that case, no?

Thanks,

        tglx
---
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 0bab497c9436..70785a722759 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -177,10 +177,11 @@ void fpu__init_cpu_xstate(void)
 	 * Must happen after CR4 setup and before xsetbv() to allow KVM
 	 * lazy passthrough.  Write independent of the dynamic state static
 	 * key as that does not work on the boot CPU. This also ensures
-	 * that any stale state is wiped out from XFD.
+	 * that any stale state is wiped out from XFD. Reset the per CPU
+	 * xfd cache too.
 	 */
 	if (cpu_feature_enabled(X86_FEATURE_XFD))
-		wrmsrl(MSR_IA32_XFD, init_fpstate.xfd);
+		xfd_reset_state();
 
 	/*
 	 * XCR_XFEATURE_ENABLED_MASK (aka. XCR0) sets user features
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index a4ecb04d8d64..6cfaf72228f4 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -159,9 +159,16 @@ static inline void xfd_update_state(struct fpstate *fpstate)
 	}
 }
 
+static inline void xfd_reset_state(void)
+{
+	wrmsrl(MSR_IA32_XFD, init_fpstate.xfd);
+	__this_cpu_write(xfd_state, init_fpstate.xfd);
+}
+
 extern int __xfd_enable_feature(u64 which, struct fpu_guest *guest_fpu);
 #else
 static inline void xfd_update_state(struct fpstate *fpstate) { }
+static inline void xfd_reset_state(void) { }
 
 static inline int __xfd_enable_feature(u64 which, struct fpu_guest *guest_fpu) {
 	return -EPERM;
