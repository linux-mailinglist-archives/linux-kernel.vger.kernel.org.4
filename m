Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA5C65C4AB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbjACRGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238514AbjACRGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:06:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA92914082;
        Tue,  3 Jan 2023 09:02:24 -0800 (PST)
Date:   Tue, 03 Jan 2023 17:02:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672765325;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=p/JG5L2EoojYjh6GpY/ztsHyqNDX+TYGc/56wDuZiUA=;
        b=K0QXuvKsIqSusMPHKgz+k8jEG2ZaDzm09+ARTHFc0YfmsErKjoWLDyqf0reaoVncN9xO5V
        nrSRb9GqG3IQlpebU8zw0WXiAS2nlnF/E8H8TPIs4K4ytbtuaRD+NldkxxIhRNK2Do/MeY
        tMdfqq/KehOOh5cfpISH0rN7tJN+P1ogTjjGNRjnOPRPdS6Yhv4skipRrrlcA31VS6L9fR
        PCrWLMF7x++jCzK0p7coC0Lt2d+MzyXr8+ZTsAzIgW7TGZe0I1CkYKbjys/ohvZG/GhYSH
        GVGtwfQB4Slh7rusnzF16auggAfbf2CipzgbSTLsp348cYb6j+Y59f33LWxCEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672765325;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=p/JG5L2EoojYjh6GpY/ztsHyqNDX+TYGc/56wDuZiUA=;
        b=2HopG3ua/Kv7hIzdUg00I934uUyxXb38G1Pqi5a5jm9HpuOakK1fcviyeYvWp8hfG8OhHt
        SaHL1x3JNjo2ojDw==
From:   "tip-bot2 for Mikulas Patocka" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/asm: Fix an assembler warning with current binutils
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org
MIME-Version: 1.0
Message-ID: <167276532482.4906.17722576860770017597.tip-bot2@tip-bot2>
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

Commit-ID:     55d235361fccef573990dfa5724ab453866e7816
Gitweb:        https://git.kernel.org/tip/55d235361fccef573990dfa5724ab453866e7816
Author:        Mikulas Patocka <mpatocka@redhat.com>
AuthorDate:    Tue, 03 Jan 2023 10:24:11 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Jan 2023 17:55:11 +01:00

x86/asm: Fix an assembler warning with current binutils

Fix a warning: "found `movsd'; assuming `movsl' was meant"

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/lib/iomap_copy_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/iomap_copy_64.S b/arch/x86/lib/iomap_copy_64.S
index a1f9416..6ff2f56 100644
--- a/arch/x86/lib/iomap_copy_64.S
+++ b/arch/x86/lib/iomap_copy_64.S
@@ -10,6 +10,6 @@
  */
 SYM_FUNC_START(__iowrite32_copy)
 	movl %edx,%ecx
-	rep movsd
+	rep movsl
 	RET
 SYM_FUNC_END(__iowrite32_copy)
