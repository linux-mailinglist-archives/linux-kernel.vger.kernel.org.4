Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508496BD132
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjCPNqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjCPNpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:45:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E7CA17C9;
        Thu, 16 Mar 2023 06:45:36 -0700 (PDT)
Date:   Thu, 16 Mar 2023 13:45:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678974334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OFyaFDPEPaIsBCnzx7br38Ux0Nge11G84LMEMFd9lFg=;
        b=APG7eYFsvkLa17FbQXLBkWCWsXBE6CmKSm71TeKkIC2z2EQneH3HnS0bYCShZGaq/XQSbo
        qKGrgAp+S7yO9NN2k+7/2tAzebNykYk05ctJoetA732ePXvy6n0m0aEWWBlmhdSQG6K/qj
        pLElFEQnzfS5OS9Hes+WHgtYTJLNHMxDsPBTXeegE9MDfGrH+71t2u7bAuYFr7s+71kYIz
        e/IKQbSgSLM7bLchNG6F4uJQfGXlLlCrHvhotb5Byfm44iHutTRUtePUVZztA1buZ8gn3P
        7R2oAnG1rK0nZ9B7QsDybUhgqid7y+COqvgdSWCBntV6NCIdESsOsizucmiKfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678974334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OFyaFDPEPaIsBCnzx7br38Ux0Nge11G84LMEMFd9lFg=;
        b=EizeFONJGqpwHaWH5R1Z8GM48q/B9DeBRex6t6u4JYaj3jkN0//iCuKjOQ4Cq4cFSErUlM
        xVOV1Njr6EmlioBA==
From:   "tip-bot2 for Nikita Zhandarovich" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm: Fix use of uninitialized buffer in sme_enable()
Cc:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, <stable@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230306160656.14844-1-n.zhandarovich@fintech.ru>
References: <20230306160656.14844-1-n.zhandarovich@fintech.ru>
MIME-Version: 1.0
Message-ID: <167897433346.5837.2554151062062268699.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     cbebd68f59f03633469f3ecf9bea99cd6cce3854
Gitweb:        https://git.kernel.org/tip/cbebd68f59f03633469f3ecf9bea99cd6cce3854
Author:        Nikita Zhandarovich <n.zhandarovich@fintech.ru>
AuthorDate:    Mon, 06 Mar 2023 08:06:56 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 16 Mar 2023 12:22:25 +01:00

x86/mm: Fix use of uninitialized buffer in sme_enable()

cmdline_find_option() may fail before doing any initialization of
the buffer array. This may lead to unpredictable results when the same
buffer is used later in calls to strncmp() function.  Fix the issue by
returning early if cmdline_find_option() returns an error.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: aca20d546214 ("x86/mm: Add support to make use of Secure Memory Encryption")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/20230306160656.14844-1-n.zhandarovich@fintech.ru
---
 arch/x86/mm/mem_encrypt_identity.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 88cccd6..c6efcf5 100644
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
