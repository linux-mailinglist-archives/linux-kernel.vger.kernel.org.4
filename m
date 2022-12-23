Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC64365533D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 18:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbiLWRX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 12:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiLWRXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 12:23:54 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8141132
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 09:23:53 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id C0A467E2B5;
        Fri, 23 Dec 2022 17:23:46 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1671816232;
        bh=A+XWNt0Nw1fJTM/CspO4FSOwWhPIKN6FwGIstBqw8HU=;
        h=From:To:Cc:Subject:Date:From;
        b=Ro5GbXoBTmgecVAU657w8poz0f6nNSJW2o3oA+t6QT6A3qUZIQupHqzt3xsYHLIE+
         3IfQm1dn/PFBo2p5GE+5YDDdczJOgJYtdheUGNggZ3AyYOd1jkEBAjuUEN6cIFLkpB
         eYUZ7sBNsANUhFLz0DDBhNSCS/2sg8RMPmpCQOd67upX+b0bXZ0t3HtoxCXjKWP46i
         K05FFLyXR+SulclW/LyEPYWUPNiLiBEgA2yB0PgQscikxjI3VctWV0HKpaJB50emot
         eMx1yZr9ycaCNBV50AU5Gsv7fhpEJprEQuzNKsASPeACLZ7IbnMrcwKSXp5rNqYyBt
         V04dWcbPg/+qw==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     x86 Mailing List <x86@kernel.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux User-Mode Mailing List <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: [PATCH v1] x86: um: vdso: Add '%rcx' and '%r11' to the syscall clobber list
Date:   Sat, 24 Dec 2022 00:23:38 +0700
Message-Id: <20221223172338.3813186-1-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

The 'syscall' instruction clobbers '%rcx' and '%r11', but they are not
listed in the inline Assembly that performs the syscall instruction.

No real bug is found. It wasn't buggy by luck because '%rcx' and '%r11'
are caller-saved registers, and not used in the functions, and the
functions are never inlined.

Add them to the clobber list for code correctness.

Fixes: f1c2bb8b9964ed31de988910f8b1cfb586d30091 ("um: implement a x86_64 vDSO")
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 arch/x86/um/vdso/um_vdso.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/um/vdso/um_vdso.c b/arch/x86/um/vdso/um_vdso.c
index 2112b8d14668..ff0f3b4b6c45 100644
--- a/arch/x86/um/vdso/um_vdso.c
+++ b/arch/x86/um/vdso/um_vdso.c
@@ -17,8 +17,10 @@ int __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts)
 {
 	long ret;
 
-	asm("syscall" : "=a" (ret) :
-		"0" (__NR_clock_gettime), "D" (clock), "S" (ts) : "memory");
+	asm("syscall"
+		: "=a" (ret)
+		: "0" (__NR_clock_gettime), "D" (clock), "S" (ts)
+		: "rcx", "r11", "memory");
 
 	return ret;
 }
@@ -29,8 +31,10 @@ int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 {
 	long ret;
 
-	asm("syscall" : "=a" (ret) :
-		"0" (__NR_gettimeofday), "D" (tv), "S" (tz) : "memory");
+	asm("syscall"
+		: "=a" (ret)
+		: "0" (__NR_gettimeofday), "D" (tv), "S" (tz)
+		: "rcx", "r11", "memory");
 
 	return ret;
 }

base-commit: 8395ae05cb5a2e31d36106e8c85efa11cda849be
-- 
Ammar Faizi

