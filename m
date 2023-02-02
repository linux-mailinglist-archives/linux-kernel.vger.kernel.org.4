Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1C9688650
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 19:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjBBS0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 13:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjBBSZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 13:25:59 -0500
Received: from exchange.fintech.ru (e10edge.fintech.ru [195.54.195.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE17B61D40
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 10:25:57 -0800 (PST)
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 2 Feb
 2023 21:25:55 +0300
Received: from localhost (10.0.253.157) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 2 Feb 2023
 21:25:54 +0300
From:   Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To:     Dave Hansen <dave.hansen@linux.intel.com>
CC:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] x86/mm: Fix use of uninitialized buffer in sme_enable()
Date:   Thu, 2 Feb 2023 10:25:38 -0800
Message-ID: <20230202182538.29352-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.253.157]
X-ClientProxiedBy: Ex16-01.fintech.ru (10.0.10.18) To Ex16-01.fintech.ru
 (10.0.10.18)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cmdline_find_option() may fail before doing any initialization of
buffer array. This may lead to unpredictable results when the same
buffer is used later in calls to strncmp() function.
Fix the issue by initializing the buffer to an empty string.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1cd9c22fee3a ("x86/mm/encrypt: Move page table helpers into separate translation unit")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
 arch/x86/mm/mem_encrypt_identity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 88cccd65029d..6b84243bfd54 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -509,7 +509,7 @@ void __init sme_enable(struct boot_params *bp)
 	unsigned long feature_mask;
 	bool active_by_default;
 	unsigned long me_mask;
-	char buffer[16];
+	char buffer[16] = "";
 	bool snp;
 	u64 msr;
 
-- 
2.25.1

