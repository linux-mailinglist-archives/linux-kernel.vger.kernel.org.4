Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED7D6AC9A8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjCFRUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjCFRUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:20:15 -0500
Received: from exchange.fintech.ru (e10edge.fintech.ru [195.54.195.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405743C37
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 09:19:51 -0800 (PST)
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 6 Mar
 2023 19:07:14 +0300
Received: from localhost (10.0.253.157) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 6 Mar 2023
 19:07:13 +0300
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
Subject: [PATCH v2] x86/mm: Fix use of uninitialized buffer in sme_enable()
Date:   Mon, 6 Mar 2023 08:06:56 -0800
Message-ID: <20230306160656.14844-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.253.157]
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
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
Fix the issue by returning early if cmdline_find_option() returns -1.

Found by Linux Verification Center (linuxtesting.org) with static analysis
tool SVACE.

Fixes: aca20d546214 ("x86/mm: Add support to make use of Secure Memory Encryption")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
v2: per Borislav Petkov's <bp@alien8.de> remarks:
- return early if cmdline_find_options() fails with -1 instead of zeroing out
buffer;
- use correct Fixes: commit hash

 arch/x86/mm/mem_encrypt_identity.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 88cccd65029d..c6efcf559d88 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -600,7 +600,8 @@ void __init sme_enable(struct boot_params *bp)
 	cmdline_ptr = (const char *)((u64)bp->hdr.cmd_line_ptr |
 				     ((u64)bp->ext_cmd_line_ptr << 32));
 
-	cmdline_find_option(cmdline_ptr, cmdline_arg, buffer, sizeof(buffer));
+	if (cmdline_find_option(cmdline_ptr, cmdline_arg, buffer, sizeof(buffer)) < 0)
+		return;
 
 	if (!strncmp(buffer, cmdline_on, sizeof(buffer)))
 		sme_me_mask = me_mask;
