Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A9C6C544C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjCVS4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjCVSzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:55:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2CD69CE7;
        Wed, 22 Mar 2023 11:54:19 -0700 (PDT)
Date:   Wed, 22 Mar 2023 18:54:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679511252;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=5GJf10FYfpAZrTDKMhvIyel8utBrLE4EWcSh0ltNPLE=;
        b=3KLRq8GyCfVV6dcFj+GSN5SSNHeVZRmbr6smykZRmpRP1ofDqp8+A8IjTTOhoxgUa1WDdl
        mPBwK95aKa7TSrLQEqBWjDvwtRt63JOpJT1W8fSZkowYan721y8Ae9+rpoiRtvvii9TvXj
        1xnfAZQm7XELhIgXjxswonNpnignqJe3QP/YDZr4IK/J6tHr2JXY8RAdhZto/ZRcU0ml+X
        skLOQwadSgd17LlNF4WOGAhV9dCV32RimB6Oo2aZYjyXIhgJJ/dqvmlk+sg59jUzpKxQOI
        iQgUmj3xu3E22MeX/PrMlaJcqEvZ5mzdVW87mTz2QohAdGQN1rzbRaGHg16+Kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679511252;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=5GJf10FYfpAZrTDKMhvIyel8utBrLE4EWcSh0ltNPLE=;
        b=ywG0YpRMGv9zZsD7/eflE8k7V58LjgBxKOBOECq13kztkPJf8fFtCh7Y0QMHNSw5oxWu6Z
        TzX1DkOZv7NrlKBw==
From:   "tip-bot2 for Luis Chamberlain" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: Simplify one-level sysctl registration for
 abi_table2
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167951125196.5837.18123258541770428595.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     3f6cc47f5eb40d96ce8cf443282a2c29fd629a76
Gitweb:        https://git.kernel.org/tip/3f6cc47f5eb40d96ce8cf443282a2c29fd629a76
Author:        Luis Chamberlain <mcgrof@kernel.org>
AuthorDate:    Fri, 10 Mar 2023 15:32:47 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 22 Mar 2023 11:47:21 -07:00

x86: Simplify one-level sysctl registration for abi_table2

There is no need to declare an extra tables to just create directory,
this can be easily be done with a prefix path with register_sysctl().

Simplify this registration.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20230310233248.3965389-2-mcgrof%40kernel.org
---
 arch/x86/entry/vdso/vdso32-setup.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso32-setup.c b/arch/x86/entry/vdso/vdso32-setup.c
index 3b300a7..f3b3cac 100644
--- a/arch/x86/entry/vdso/vdso32-setup.c
+++ b/arch/x86/entry/vdso/vdso32-setup.c
@@ -70,18 +70,9 @@ static struct ctl_table abi_table2[] = {
 	{}
 };
 
-static struct ctl_table abi_root_table2[] = {
-	{
-		.procname = "abi",
-		.mode = 0555,
-		.child = abi_table2
-	},
-	{}
-};
-
 static __init int ia32_binfmt_init(void)
 {
-	register_sysctl_table(abi_root_table2);
+	register_sysctl("abi", abi_table2);
 	return 0;
 }
 __initcall(ia32_binfmt_init);
