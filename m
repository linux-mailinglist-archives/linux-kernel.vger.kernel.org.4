Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7113A692B98
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 00:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjBJXqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 18:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjBJXqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 18:46:20 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0948516330
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 15:45:53 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 456D91EC0758;
        Sat, 11 Feb 2023 00:45:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676072748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=PJ0MCIKmicATxfrO7Q7VcthrEobh2IANYeLpCnb2HiE=;
        b=HzZbrocOhAKhfcka5Zv+XFRFjIC35p0EyEw+Y2T2pBGIvQrUpdIC1A28BSZyWQxvKCB8qf
        XP0ltu6K3NRJ+D3rvZWImFBSKC9QXCTxRFauNQcQ6b9LRCr5XckK8zqqyKcFBroLR5Bq9Z
        SdEJSP+cD1n7CLO6c2bonbt8JySXwnk=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/cacheinfo: Remove unused trace variable
Date:   Sat, 11 Feb 2023 00:45:41 +0100
Message-Id: <20230210234541.9694-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

15cd8812ab2c ("x86: Remove the CPU cache size printk's") removed the
last use of the trace local var. Remove it too and the useless trace
cache case.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index f4e5aa27eec6..4063e8991211 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -734,7 +734,7 @@ void init_hygon_cacheinfo(struct cpuinfo_x86 *c)
 void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 {
 	/* Cache sizes */
-	unsigned int trace = 0, l1i = 0, l1d = 0, l2 = 0, l3 = 0;
+	unsigned int l1i = 0, l1d = 0, l2 = 0, l3 = 0;
 	unsigned int new_l1d = 0, new_l1i = 0; /* Cache sizes from cpuid(4) */
 	unsigned int new_l2 = 0, new_l3 = 0, i; /* Cache sizes from cpuid(4) */
 	unsigned int l2_id = 0, l3_id = 0, num_threads_sharing, index_msb;
@@ -835,9 +835,6 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 						case LVL_3:
 							l3 += cache_table[k].size;
 							break;
-						case LVL_TRACE:
-							trace += cache_table[k].size;
-							break;
 						}
 
 						break;
-- 
2.35.1

