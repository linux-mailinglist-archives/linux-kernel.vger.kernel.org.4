Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A8F73396E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345937AbjFPTRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjFPTQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:16:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09EA3A8C;
        Fri, 16 Jun 2023 12:16:54 -0700 (PDT)
Date:   Fri, 16 Jun 2023 19:16:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686943013;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=iovYtGDAR/iBGfQFTuKy+OfLY4uRUPtPAYOMshctPE0=;
        b=3XmLumZO1viAcpRF/plHjU3AZ48D02cWnL9+ZAyFMPZFdFajznmWQ3ZaJUdRQWZjmVaB7j
        1Z2B+EHVHBkDGXXHWQS/p4jOsPjwWy6don6z5xgwHKs07HI/71hK9F8mdsXsA3v3/hlFur
        9NvK71u9yExSJ6zwzwbQ5GwD1XEhlbst6VTqh8fsmsfuXPgI4OxV8VGdSn1WhAIyt7QWUg
        MmQ40gnVtUx3t3OgouwUL+5UIwK/K/1oR+SDBXKZ2/3TxuMhkaXlR5LU6rt7qTDAduG7n2
        BU8WDxWRXhsExuUXG/Errym/CWFWtWcPQZRD0nbdIgvcjYGwLTkoMj2/ncCVjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686943013;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=iovYtGDAR/iBGfQFTuKy+OfLY4uRUPtPAYOMshctPE0=;
        b=IQDKuAPs7rL51DxhrR74FDVurV1ORXil6SD1n32qBXzeRDdzCZKjMoXJr++UNGDgqeR9Y7
        OjPMcGgCpILeDmDg==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/shstk: Wire in shadow stack interface
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168694301311.404.15338316204935361111.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     d463cfe241f0ea4194f3575b4d28fd744db321f1
Gitweb:        https://git.kernel.org/tip/d463cfe241f0ea4194f3575b4d28fd744db321f1
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:11:03 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Jun 2023 16:31:34 -07:00

x86/shstk: Wire in shadow stack interface

The kernel now has the main shadow stack functionality to support
applications. Wire in the WRSS and shadow stack enable/disable functions
into the existing shadow stack API skeleton.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230613001108.3040476-38-rick.p.edgecombe%40intel.com
---
 arch/x86/kernel/shstk.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index ea0bf11..d723cdc 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -502,9 +502,17 @@ long shstk_prctl(struct task_struct *task, int option, unsigned long features)
 		return -EINVAL;
 
 	if (option == ARCH_SHSTK_DISABLE) {
+		if (features & ARCH_SHSTK_WRSS)
+			return wrss_control(false);
+		if (features & ARCH_SHSTK_SHSTK)
+			return shstk_disable();
 		return -EINVAL;
 	}
 
 	/* Handle ARCH_SHSTK_ENABLE */
+	if (features & ARCH_SHSTK_SHSTK)
+		return shstk_setup();
+	if (features & ARCH_SHSTK_WRSS)
+		return wrss_control(true);
 	return -EINVAL;
 }
