Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033436C544F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjCVS4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjCVS4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:56:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0846A043;
        Wed, 22 Mar 2023 11:54:26 -0700 (PDT)
Date:   Wed, 22 Mar 2023 18:54:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679511252;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=A+gI28LSL9lsNL+RXPBvchUT9Vk3rqUxL+KSWkY39mY=;
        b=L8doCyZXKwR2xK2krWvW71riO6Yy++aqCtMp/3InHJzmTcKZhMPKhXSmr8Uhjn8NKsuVCo
        dwQ6WzW8QGzrBe85YEBLBVKImWGzzNI7BsMF2JjPyKe+trr9F9v+K+2eCBtP143B1Phkh4
        Q1L2w2cwxqojJoSItCY1qzWodpiVwKcKxMGLK8/NpPrwL0XqoeB3YE4tGU/KHrjje4xe57
        ViaieZlYO6+GHShOaHXHg25z1+skH3X8bzFf4/SotHA7yttpVUS6qKwkniByYjD9+WoJe3
        NlaXYf2mrUv2/a3Gn3KFAzpQJbz+SAsIPa28C+IhWouMkypj7dLXevv63caW8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679511252;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=A+gI28LSL9lsNL+RXPBvchUT9Vk3rqUxL+KSWkY39mY=;
        b=WZC2rmjqWvhgpfjJnRYqQYYqth5IzjgxC/iHA4Vhtp+w3qVPgB1FHMI76YeWRpYgNyVfvk
        XI1knlV7H0N7JVDA==
From:   "tip-bot2 for Luis Chamberlain" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: Simplify one-level sysctl registration for
 itmt_kern_table
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167951125144.5837.13563627492403972761.tip-bot2@tip-bot2>
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

Commit-ID:     89d7971eb2318595bc3b6ab7c5caede112c302ff
Gitweb:        https://git.kernel.org/tip/89d7971eb2318595bc3b6ab7c5caede112c302ff
Author:        Luis Chamberlain <mcgrof@kernel.org>
AuthorDate:    Fri, 10 Mar 2023 15:32:48 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 22 Mar 2023 11:47:21 -07:00

x86: Simplify one-level sysctl registration for itmt_kern_table

There is no need to declare an extra tables to just create directory,
this can be easily be done with a prefix path with register_sysctl().

Simplify this registration.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20230310233248.3965389-3-mcgrof%40kernel.org
---
 arch/x86/kernel/itmt.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
index 9ff480e..670eb08 100644
--- a/arch/x86/kernel/itmt.c
+++ b/arch/x86/kernel/itmt.c
@@ -77,15 +77,6 @@ static struct ctl_table itmt_kern_table[] = {
 	{}
 };
 
-static struct ctl_table itmt_root_table[] = {
-	{
-		.procname	= "kernel",
-		.mode		= 0555,
-		.child		= itmt_kern_table,
-	},
-	{}
-};
-
 static struct ctl_table_header *itmt_sysctl_header;
 
 /**
@@ -114,7 +105,7 @@ int sched_set_itmt_support(void)
 		return 0;
 	}
 
-	itmt_sysctl_header = register_sysctl_table(itmt_root_table);
+	itmt_sysctl_header = register_sysctl("kernel", itmt_kern_table);
 	if (!itmt_sysctl_header) {
 		mutex_unlock(&itmt_update_mutex);
 		return -ENOMEM;
