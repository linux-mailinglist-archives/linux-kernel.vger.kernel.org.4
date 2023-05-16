Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B94F7045AA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 08:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjEPG5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 02:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjEPG5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 02:57:44 -0400
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95224E6
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 23:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1684219934;
        bh=SDq8vRlBuA6Er2G1+K62Nfmk/ihK4Wc1KqVV8N0ACJA=;
        h=From:To:Cc:Subject:Date;
        b=R94YbxVCz9TTfmfoTypDoTDssHPTfV04bQMzDcglAnn4oGi7j2SCYEZ8ku+C/u67y
         HQ3otNgkbj+5P0DJNgBBgx+DMsgZUcOhP9HKnrRVPznDlpblAIQAWH2aUoZB4XT2ey
         HHXoaUBMuZSMx7FnVkxhkl/dyxcg5x92mlzJuQHo=
Received: from localhost.localdomain ([39.156.73.12])
        by newxmesmtplogicsvrszc2-1.qq.com (NewEsmtp) with SMTP
        id D083C0E0; Tue, 16 May 2023 14:52:08 +0800
X-QQ-mid: xmsmtpt1684219928t74i4c82v
Message-ID: <tencent_4DC4468312A1CB2CA34B0215FAD797D11F07@qq.com>
X-QQ-XMAILINFO: MGSlRwRrdVfIisT3TiXB4uYvCn2VPP6XpnWBkaHc0Fn1xUCdZ0n2LQgq1EGkOK
         PpppkJLZ3hV2G2VRhLsM8HVzJygVLuFXFJNZmD30h9Xxyt+A90tFJoZi0NhhHFFaaCs9kFFJk+EQ
         u0IGl5YZIjQfxOJcXgoGPOgOQtebO0DuvLJti2RK/bBPsUsmJ4LeSdCTM3iAXMdmXSipRQEbM0f6
         Z4PymvSRlJbGJRbdYDAzeFEvDcOkRXHK38cDh5a8/xhfFobv3Rj+rdrGouIEWzLvlr+tXgUmLXa+
         av+q22dlSr4NPYgtGBH73WXd5voBiP0ho9ziAoTINCA/ffzwAqrVDNA85AktekFsRcPm9kFBE9nI
         RS5iK1EyhDvOsN2KyTPICrN9fa+sYIO1OFUYhG7Xs4Ga5Xvdi4PHKvRSoNftufYm/h+xp3H4ZtFm
         kGp6C/a8+uvpUlbNT89xkgFKeAbiuv9bjxXN97+OI8TSURtrFX8e8ShGvx3rMrbqeZAoM9pvUUH6
         lrlbkNq/qGpsgXeumzEHnoRX9JiJsCbV/MXVdHU8M1tE8d3a6OKbEpB5RsfT+0ZU/F/5MheI1wUJ
         SpzYo3CburYpyhGMkZAwq+wg2TG5K7fMPrqmr0Pc3izqaDpXMFN2g4QEFqCXoyy4avjCRbNaLEBo
         B5FXWiUlThR9FnyCdLqXQu81lPvV/gJUnklY56dK+VToXbAnfmiExAnjHS0zHW+Od47Ae70ABhTO
         ZdkyVQ02OOIeYTyXo1FIKLqU3DEloYgmp/ZnKpXrGa1Xeb6b//AVDMA56bhbPm8OiZzAznLM3Mlc
         O81nQ+QOU/MQ29j4zyPIXPRMk0hAzIu51F3rgW9ArS2nJIiLNB9GwpJhIPahyIiFuLbdwV5ffQbZ
         cdEBBTDPVT80VY+Dy7AvuZW7uZHUbvs78YWpBxCt8dVJ2x2qIitVv38m4Rn9pHU+gr/geh3v+5gL
         fJXHCAKFBLQnqUPqGL1YdotzzBPhql2zLCi48fg5U=
From:   Rong Tao <rtoax@foxmail.com>
To:     tglx@linutronix.de
Cc:     rtoax@foxmail.com, Rong Tao <rongtao@cestc.cn>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH] x86/vdso: Use non-serializing instruction rdtsc
Date:   Tue, 16 May 2023 14:52:03 +0800
X-OQ-MSGID: <20230516065203.14548-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

Replacing rdtscp or 'lfence;rdtsc' with the non-serializable instruction
rdtsc can achieve a 40% performance improvement with only a small loss of
precision.

The RDTSCP instruction is not a serializing instruction, but it does wait
until all previous instructions have executed and all previous loads are
globally visible. The RDTSC instruction is not a serializing instruction.
It does not necessarily wait until all previous instructions have been
executed before reading the counter.

Record the time-consuming of vdso clock_gettime(), pseudo code:

    count = 1000 * 1000 * 100;
    while (count--)
        clock_gettime(CLOCK_REALTIME, &ts);

Time-consuming comparison:

     Time Consume(ns) | rdtsc_ordered() |  rdtsc()  | Promote
    ------------------+-----------------+-----------+---------
    Physical Machine  |  1269147289     | 759067324 |   40%
     Guest OS (KVM)   |  1756615963     | 995823886 |   43%

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 arch/x86/include/asm/vdso/gettimeofday.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index 4cf6794f9d68..342d29106208 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -228,7 +228,7 @@ static u64 vread_pvclock(void)
 		if (unlikely(!(pvti->flags & PVCLOCK_TSC_STABLE_BIT)))
 			return U64_MAX;
 
-		ret = __pvclock_read_cycles(pvti, rdtsc_ordered());
+		ret = __pvclock_read_cycles(pvti, rdtsc());
 	} while (pvclock_read_retry(pvti, version));
 
 	return ret;
@@ -246,7 +246,7 @@ static inline u64 __arch_get_hw_counter(s32 clock_mode,
 					const struct vdso_data *vd)
 {
 	if (likely(clock_mode == VDSO_CLOCKMODE_TSC))
-		return (u64)rdtsc_ordered();
+		return (u64)rdtsc();
 	/*
 	 * For any memory-mapped vclock type, we need to make sure that gcc
 	 * doesn't cleverly hoist a load before the mode check.  Otherwise we
-- 
2.39.1

