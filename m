Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7825C68DE7F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 18:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjBGRHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 12:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjBGRHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:07:52 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E74C3BDAB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 09:07:51 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C88861EC047F;
        Tue,  7 Feb 2023 18:07:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675789669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1dJoMuVzuM1aNIUSF1OCPBNvUwYGuGQIxuTeKwLrK5w=;
        b=Uhyh6ZfV/ahAjSQ0cPYrVUYGf5cTuLra9t8WWSpM4l7ChwGejDFE4jrsJMmJKHus4pPniA
        E5K0dO2JTviani/IKpgHQFpPUCMVi9nJ1AUDAJA62FVdCkK8XH5jJ9V1rP2lY1Y1anCa9A
        MviDLTkvykfl4oL16RQjm8FdzZJ/jpQ=
Date:   Tue, 7 Feb 2023 18:07:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [tip:x86/vdso 3/4] arch/x86/entry/vdso/vdso32/../vgetcpu.c:13:1:
 warning: no previous prototype for '__vdso_getcpu'
Message-ID: <Y+KFYUqM5pT7iuoK@zn.tnic>
References: <202302070742.iYcnoJwk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202302070742.iYcnoJwk-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 07:41:54AM +0800, kernel test robot wrote:
> All warnings (new ones prefixed by >>):
> 
>    In file included from arch/x86/entry/vdso/vdso32/vgetcpu.c:2:
> >> arch/x86/entry/vdso/vdso32/../vgetcpu.c:13:1: warning: no previous prototype for '__vdso_getcpu' [-Wmissing-prototypes]
>       13 | __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
>          | ^~~~~~~~~~~~~

---
From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Tue, 7 Feb 2023 16:13:24 +0100
Subject: [PATCH] x86/vdso: Fix -Wmissing-prototypes warnings
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix those:

  In file included from arch/x86/entry/vdso/vdso32/vclock_gettime.c:4:
arch/x86/entry/vdso/vdso32/../vclock_gettime.c:70:5: warning: no previous prototype for ‘__vdso_clock_gettime64’ [-Wmissing-prototypes]
   70 | int __vdso_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts)
      |

In file included from arch/x86/entry/vdso/vdso32/vgetcpu.c:3:
arch/x86/entry/vdso/vdso32/../vgetcpu.c:13:1: warning: no previous prototype for ‘__vdso_getcpu’ [-Wmissing-prototypes]
   13 | __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
      | ^~~~~~~~~~~~~

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/202302070742.iYcnoJwk-lkp@intel.com
---
 arch/x86/include/asm/vdso/gettimeofday.h | 2 ++
 arch/x86/include/asm/vdso/processor.h    | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index 1936f21ed8cd..4cf6794f9d68 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -318,6 +318,8 @@ u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
 }
 #define vdso_calc_delta vdso_calc_delta
 
+int __vdso_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts);
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/x86/include/asm/vdso/processor.h b/arch/x86/include/asm/vdso/processor.h
index 57b1a7034c64..2cbce97d29ea 100644
--- a/arch/x86/include/asm/vdso/processor.h
+++ b/arch/x86/include/asm/vdso/processor.h
@@ -18,6 +18,10 @@ static __always_inline void cpu_relax(void)
 	rep_nop();
 }
 
+struct getcpu_cache;
+
+notrace long __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __ASM_VDSO_PROCESSOR_H */
-- 
2.35.1

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
