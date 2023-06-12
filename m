Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE4072BC47
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjFLJ1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjFLJ0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:26:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C7D44B8;
        Mon, 12 Jun 2023 02:20:32 -0700 (PDT)
Date:   Mon, 12 Jun 2023 09:20:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686561630;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=70zNvW5VA+Ah0281r+mT+kVt1mXlLOUUZzCOWk3D6fo=;
        b=DFPCi/rJ+6iWsWuSBXd7uikjQZANygh7+YFriqGBex2nMnblVyRM2+6UJlHniZbzCOuw/I
        E2lVjsbl/1DSjQjI1o1mxfsjRRnyeS3TYBL8+tdTSMLgXh4yMR2mpYN9/YUhT5D5yqjQJ3
        GH+UPSiVJReWtRGtF0iMs3FvnBVYxJa69j2tnTIIOOnjwrtihaZqK1n95CZGjeZJnAWG38
        VCNoA+7AosfP9V5w+yQjEqXQS7iwidTqI+Autjrw0AFYsuxp2d4x9+hQAesOCWJ/f+0pKF
        cH6ecHmuZkoJeJXB3NOj3grTBvjplOBAMPeYMwgNwlFCYv2STae9uBxFJXf5tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686561630;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=70zNvW5VA+Ah0281r+mT+kVt1mXlLOUUZzCOWk3D6fo=;
        b=BcvIhHpWG3YQQFIxCIcIzPOErxf1ybpEAlQ80BnlWnVM/yqf8lUaaM0DsRXL6TOs5fGDRv
        uqM6IEGUIy1GipDw==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/AMD: Load late on both threads too
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>, <stable@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230605141332.25948-1-bp@alien8.de>
References: <20230605141332.25948-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <168656163014.404.7079279455029595651.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     a32b0f0db3f396f1c9be2fe621e77c09ec3d8e7d
Gitweb:        https://git.kernel.org/tip/a32b0f0db3f396f1c9be2fe621e77c09ec3d8e7d
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Tue, 02 May 2023 19:53:50 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 12 Jun 2023 11:02:17 +02:00

x86/microcode/AMD: Load late on both threads too

Do the same as early loading - load on both threads.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/20230605141332.25948-1-bp@alien8.de
---
 arch/x86/kernel/cpu/microcode/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index f14f4ea..87208e4 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -700,7 +700,7 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
 
 	/* need to apply patch? */
-	if (rev >= mc_amd->hdr.patch_id) {
+	if (rev > mc_amd->hdr.patch_id) {
 		ret = UCODE_OK;
 		goto out;
 	}
