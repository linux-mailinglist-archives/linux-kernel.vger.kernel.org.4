Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C916766CF
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 15:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjAUOyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 09:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjAUOyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 09:54:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A892D8A59;
        Sat, 21 Jan 2023 06:54:30 -0800 (PST)
Date:   Sat, 21 Jan 2023 14:54:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674312868;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xc3e1Isd07hyMmhdJs218O+phbX8yWD6UQMKDWzBjkk=;
        b=bLO0ff6HMm1bjn5UISQ4JztCD2w2XhJ5pfnRP7yiTzGMnATwgcWRTAj6KYz6JjunkjjScX
        Nyrz9Lx5RiOE6SSAYmqd7xtEX8u+IFnbuc6Hn4FBIro/13BopeH37C35UJRLWXqCzfbY/1
        N9NeqDTfiILAGcKssk5t4Cvv/Ks7llt4uacv3ac23xXWoLwHHxZLX7ipym6jX1tDhPqCCX
        enRwcQcviqqRqyKzu+jruHnFNYJxixDIJvmfTFPDJcGf/esQUqLsGxTUk36isR9dVhOZcz
        LOdsPKVG+7FaKhBPTgX9jxeaEOwOh5Q6B3zLDrMFWCz4Pe8WbdXBThgBS4zd0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674312868;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xc3e1Isd07hyMmhdJs218O+phbX8yWD6UQMKDWzBjkk=;
        b=9M2HFj6WtRrCLpx3MQ+2611fxqv/vAPDrOj58RtWpA2uzI2hKFB3Tg9ZXkUqAaMmp8ieGr
        Y4OE9Z4rZcVzT1DA==
From:   "tip-bot2 for Ashok Raj" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Adjust late loading result
 reporting message
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ashok Raj <ashok.raj@intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167431286818.4906.11374888066745069135.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     6eab3abac7043226e5375e9ead0c7607ced6767b
Gitweb:        https://git.kernel.org/tip/6eab3abac7043226e5375e9ead0c7607ced6767b
Author:        Ashok Raj <ashok.raj@intel.com>
AuthorDate:    Mon, 09 Jan 2023 07:35:52 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 21 Jan 2023 14:55:20 +01:00

x86/microcode: Adjust late loading result reporting message

During late microcode loading, the "Reload completed" message is issued
unconditionally, regardless of success or failure.

Adjust the message to report the result of the update.

  [ bp: Massage. ]

Fixes: 9bd681251b7c ("x86/microcode: Announce reload operation's completion")
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/lkml/874judpqqd.ffs@tglx/
---
 arch/x86/kernel/cpu/microcode/core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 8ec38c1..61d57d9 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -453,11 +453,14 @@ static int microcode_reload_late(void)
 	store_cpu_caps(&prev_info);
 
 	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
-	if (ret == 0)
+	if (!ret) {
+		pr_info("Reload succeeded, microcode revision: 0x%x -> 0x%x\n",
+			old, boot_cpu_data.microcode);
 		microcode_check(&prev_info);
-
-	pr_info("Reload completed, microcode revision: 0x%x -> 0x%x\n",
-		old, boot_cpu_data.microcode);
+	} else {
+		pr_info("Reload failed, current microcode revision: 0x%x\n",
+			boot_cpu_data.microcode);
+	}
 
 	return ret;
 }
