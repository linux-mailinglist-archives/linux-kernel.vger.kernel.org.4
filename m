Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E956EF14F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240351AbjDZJl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240310AbjDZJlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:41:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08E630EB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:41:18 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3670F1EC0441;
        Wed, 26 Apr 2023 11:41:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1682502077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=uziZ0nC95pE1bmYPqhWD9tTWtuuxLYKpfD3KPfIloxo=;
        b=nPihICyT4GyugLPX3j1YerlXclryfdX7mVnvh3a0Q4EtCgy9KlM7SJ4WRobaSX7ZUbLsND
        gMkHstXqXs0co0xOr3pJFH48x7g6ZSYnL6QueQPlRsekFa+XxAdZBgGM53Ughca1sCVUmM
        3CZp1awn9g4jn/s/P+B/Onphs4jTIcI=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] tools/x86/kcpuid: Dump the correct CPUID function in error
Date:   Wed, 26 Apr 2023 11:41:07 +0200
Message-Id: <20230426094107.27348-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

The tool uses the 16 least significant bits of the CPUID leaf as an
index into its array of CPUID function field descriptions.

However, when that index is non-existent, it uses the same, truncated
index to report it, which is wrong:

$ kcpuid -l 0x80000034
  ERR: invalid input index (0x34)

Use the original index number in the error message.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 416f5b35dd8f..24b7d017ec2c 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -517,15 +517,16 @@ static void show_range(struct cpuid_range *range)
 static inline struct cpuid_func *index_to_func(u32 index)
 {
 	struct cpuid_range *range;
+	u32 func_idx;
 
 	range = (index & 0x80000000) ? leafs_ext : leafs_basic;
-	index &= 0x7FFFFFFF;
+	func_idx = index & 0xffff;
 
-	if (((index & 0xFFFF) + 1) > (u32)range->nr) {
+	if ((func_idx + 1) > (u32)range->nr) {
 		printf("ERR: invalid input index (0x%x)\n", index);
 		return NULL;
 	}
-	return &range->funcs[index];
+	return &range->funcs[func_idx];
 }
 
 static void show_info(void)
-- 
2.35.1

