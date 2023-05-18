Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E856708B47
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 00:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjERWDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 18:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjERWDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 18:03:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401BEE7A;
        Thu, 18 May 2023 15:03:18 -0700 (PDT)
Date:   Thu, 18 May 2023 22:03:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684447395;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PcgtW3iA4+dOUhzzk/M2he6NDx+hgFUlACPkQmL+IVI=;
        b=mkcMrZLFWhphvPJ8QzuXMqo0gu3z8a43LPLnSNFoDNTq2CpShPSeG8oXVEhYcPLlcrFxKU
        mDP47f3XrEl88CQbYRjyA+StsB8qMmAHmb45eWgk/diP60re40dDEiR0yGavn7/Y/7B+9r
        tRnc4PaIvT/Q6yS744jwXifdr9L35hi2/FmLMTqjfrJfx6yB2cmoL6/dcmKW4nh5Sv7TOK
        HIwaOvabz9MJxAlbdhXAyQCu0XxvPDcQexA5qA7PckeFybr2Ze2j3+DJMncgzK35vrWSE4
        vOUSw/QP38FAjVFsC+03hWTZKywVRNYmVxrqV60akT3FfLY4x+UIS+mZVatXlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684447395;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PcgtW3iA4+dOUhzzk/M2he6NDx+hgFUlACPkQmL+IVI=;
        b=xQlDWD4qoho+SxiVvKxcUYknmEb/0RqODuADgO9XHO2UUtmYzVVhQqnuLRFHbN0NnKfkB4
        i2wt/htfuYqfyLAA==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: Add dummy prototype for mk_early_pgtbl_32()
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168444739518.404.1158362129763767934.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     2eb5d1df2aa657ccc65cfab67e65eb9f97cef4d6
Gitweb:        https://git.kernel.org/tip/2eb5d1df2aa657ccc65cfab67e65eb9f97cef4d6
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 16 May 2023 21:35:34 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 18 May 2023 11:56:16 -07:00

x86: Add dummy prototype for mk_early_pgtbl_32()

'make W=1' warns about a function without a prototype in the x86-32 head code:

arch/x86/kernel/head32.c:72:13: error: no previous prototype for 'mk_early_pgtbl_32' [-Werror=missing-prototypes]

This is called from assembler code, so it does not actually need a prototype.
I could not find an appropriate header for it, so just declare it in front
of the definition to shut up the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Link: https://lore.kernel.org/all/20230516193549.544673-6-arnd%40kernel.org
---
 arch/x86/kernel/head32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/head32.c b/arch/x86/kernel/head32.c
index 10c27b4..246a609 100644
--- a/arch/x86/kernel/head32.c
+++ b/arch/x86/kernel/head32.c
@@ -69,6 +69,7 @@ asmlinkage __visible void __init __noreturn i386_start_kernel(void)
  * to the first kernel PMD. Note the upper half of each PMD or PTE are
  * always zero at this stage.
  */
+void __init mk_early_pgtbl_32(void);
 void __init mk_early_pgtbl_32(void)
 {
 #ifdef __pa
