Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F7668E00E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjBGSbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjBGSbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:31:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B737B3E09B;
        Tue,  7 Feb 2023 10:31:40 -0800 (PST)
Date:   Tue, 07 Feb 2023 18:31:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675794699;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g9bCm+6iKVhDzLDQh5XmZaZrHINE5HUt57TMySLUnQY=;
        b=OO9FpvVyyvTtTeR6MaQn4b//o80LXJ3O4Iv5rGmkhAJs7HM3hoYVegY+rxas2WW4FOenHq
        XeCK4hevkFhvo1HqBCmZexZuCdsPHSfX11jrRIcItXHSmeoGDwLRZnWt7nBaJw+wy+AB7i
        zyfQN9VCGMNb/SSFaJmEIta9CNqkPrbChMGMdE0oMTBH1LU74qA4zuczB+G6skvKvKGJhF
        /Au5VgmNbnJlPNVmYV8/YCuYuA5GhI8C7PBe7V5Z6PKPwKbm9Zz5P+1Yr5jSWzEwdueEre
        msKTxlKczPxWh7azdnRjlPpnSQKJ8TKS/KTjzofz3mNyubbGhP42tz06xu1Gmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675794699;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g9bCm+6iKVhDzLDQh5XmZaZrHINE5HUt57TMySLUnQY=;
        b=z+aHs+T/Ta/86ESuxdXh/ukeG9vHG1sa6Jp2dr08qYrKLKkMgOfxqaZJ4leJu7MxLHhddK
        2aQuUPuKdzXAvYBA==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/vdso] x86/vdso: Fix -Wmissing-prototypes warnings
Cc:     kernel test robot <lkp@intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <202302070742.iYcnoJwk-lkp@intel.com>
References: <202302070742.iYcnoJwk-lkp@intel.com>
MIME-Version: 1.0
Message-ID: <167579469826.4906.1882516265685994388.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/vdso branch of tip:

Commit-ID:     dac0da428f8dfb23666ab4ea54a7768c152b857a
Gitweb:        https://git.kernel.org/tip/dac0da428f8dfb23666ab4ea54a7768c152=
b857a
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Tue, 07 Feb 2023 16:13:24 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 07 Feb 2023 18:23:17 +01:00

x86/vdso: Fix -Wmissing-prototypes warnings

Fix those:

  In file included from arch/x86/entry/vdso/vdso32/vclock_gettime.c:4:
arch/x86/entry/vdso/vdso32/../vclock_gettime.c:70:5: warning: no previous pro=
totype for =E2=80=98__vdso_clock_gettime64=E2=80=99 [-Wmissing-prototypes]
   70 | int __vdso_clock_gettime64(clockid_t clock, struct __kernel_timespec =
*ts)
      |

In file included from arch/x86/entry/vdso/vdso32/vgetcpu.c:3:
arch/x86/entry/vdso/vdso32/../vgetcpu.c:13:1: warning: no previous prototype =
for =E2=80=98__vdso_getcpu=E2=80=99 [-Wmissing-prototypes]
   13 | __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unu=
sed)
      | ^~~~~~~~~~~~~

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/202302070742.iYcnoJwk-lkp@intel.com
---
 arch/x86/include/asm/vdso/gettimeofday.h | 2 ++
 arch/x86/include/asm/vdso/processor.h    | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/=
vdso/gettimeofday.h
index 1936f21..4cf6794 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -318,6 +318,8 @@ u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 m=
ult)
 }
 #define vdso_calc_delta vdso_calc_delta
=20
+int __vdso_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts);
+
 #endif /* !__ASSEMBLY__ */
=20
 #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/x86/include/asm/vdso/processor.h b/arch/x86/include/asm/vds=
o/processor.h
index 57b1a70..2cbce97 100644
--- a/arch/x86/include/asm/vdso/processor.h
+++ b/arch/x86/include/asm/vdso/processor.h
@@ -18,6 +18,10 @@ static __always_inline void cpu_relax(void)
 	rep_nop();
 }
=20
+struct getcpu_cache;
+
+notrace long __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cach=
e *unused);
+
 #endif /* __ASSEMBLY__ */
=20
 #endif /* __ASM_VDSO_PROCESSOR_H */
