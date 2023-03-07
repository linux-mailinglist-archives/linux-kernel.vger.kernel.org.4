Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2090F6AF919
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjCGWnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjCGWmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:42:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655E2A2C1E;
        Tue,  7 Mar 2023 14:41:56 -0800 (PST)
Date:   Tue, 07 Mar 2023 22:41:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678228891;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j15x+BYOBOkwPBLJCLLZQ9uWzQhHFZ6rz4FIHGL1vUs=;
        b=G58vKNsGiHwS7dZ21eWHkB8qcgUb/0r0+ZotATHhrIrI1mwc2gwq+qoTtkaxAX6rMi4SV+
        gex+vAjrv0TmZ/NumFAjqPYvh87gvaZVJys+9EPWYKDUgYHMJsAzk+NcpA85cQwnInpX5X
        qKG1hseYNnrbXKOt7XAi6rx/6z4YWWbebf3LYXiobZyHuYsgiwrxpBl6oEb7QC1VnfogyF
        FeoQiyt2lffXvQfuvS0BGR3jhvfWpsp0YSylSpcEMsVj2ybYAxbQKH2ryM1EwgZa7l2zYN
        ghB7uycBMiYH3ZKnr/OqzbT8FOgrymvSb+KHUnKe5FyfFU5llblPEZ7FJyMihw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678228891;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j15x+BYOBOkwPBLJCLLZQ9uWzQhHFZ6rz4FIHGL1vUs=;
        b=XI22hM2EbI8xOwZPfKDqbtkl5JVbRTvSBcB0WLAU3nTBfvYH3K5VES4oYr8Zr9asfUMArZ
        LkKn9ubhcCbu5lAQ==
From:   "tip-bot2 for Terry Bowman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] tools/x86/kcpuid: Fix avx512bw and avx512lvl fields
 in Fn00000007
Cc:     Terry Bowman <terry.bowman@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Feng Tang <feng.tang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230206141832.4162264-2-terry.bowman@amd.com>
References: <20230206141832.4162264-2-terry.bowman@amd.com>
MIME-Version: 1.0
Message-ID: <167822889104.5837.1505725503143263010.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     4e347bdf44c1fd4296a7b9657a2c0e1bd900fa50
Gitweb:        https://git.kernel.org/tip/4e347bdf44c1fd4296a7b9657a2c0e1bd900fa50
Author:        Terry Bowman <terry.bowman@amd.com>
AuthorDate:    Mon, 06 Feb 2023 08:18:30 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 07 Mar 2023 23:27:07 +01:00

tools/x86/kcpuid: Fix avx512bw and avx512lvl fields in Fn00000007

Leaf Fn00000007 contains avx512bw at bit 26 and avx512vl at bit 28. This
is incorrect per the SDM. Correct avx512bw to be bit 30 and avx512lvl to
be bit 31.

Fixes: c6b2f240bf8d ("tools/x86: Add a kcpuid tool to show raw CPU features")
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Feng Tang <feng.tang@intel.com>
Link: https://lore.kernel.org/r/20230206141832.4162264-2-terry.bowman@amd.com
---
 tools/arch/x86/kcpuid/cpuid.csv | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/arch/x86/kcpuid/cpuid.csv b/tools/arch/x86/kcpuid/cpuid.csv
index 4f1c4b0..9914bdf 100644
--- a/tools/arch/x86/kcpuid/cpuid.csv
+++ b/tools/arch/x86/kcpuid/cpuid.csv
@@ -184,8 +184,8 @@
 	 7,    0,  EBX,     27, avx512er, AVX512 Exponent Reciproca instr
 	 7,    0,  EBX,     28, avx512cd, AVX512 Conflict Detection instr
 	 7,    0,  EBX,     29, sha, Intel Secure Hash Algorithm Extensions instr
-	 7,    0,  EBX,     26, avx512bw, AVX512 Byte & Word instr
-	 7,    0,  EBX,     28, avx512vl, AVX512 Vector Length Extentions (VL)
+	 7,    0,  EBX,     30, avx512bw, AVX512 Byte & Word instr
+	 7,    0,  EBX,     31, avx512vl, AVX512 Vector Length Extentions (VL)
 	 7,    0,  ECX,      0, prefetchwt1, X
 	 7,    0,  ECX,      1, avx512vbmi, AVX512 Vector Byte Manipulation Instructions
 	 7,    0,  ECX,      2, umip, User-mode Instruction Prevention
