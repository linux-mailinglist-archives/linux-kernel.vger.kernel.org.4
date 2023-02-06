Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AC568BD67
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjBFNAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjBFNAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:00:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1408122DDF;
        Mon,  6 Feb 2023 05:00:09 -0800 (PST)
Date:   Mon, 06 Feb 2023 13:00:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675688406;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2LLZAH/u09eNQOaEpRXMUws4XchHC3Bq1ostiMn75cs=;
        b=t5oVurtL+rhT4CgLKzW0iYff7rRmL9x+xi4nCulN1KMrvv9GWhevLMAJmbhD70a/XoybkN
        Y3zEGFLXsFAlVIbqT1rP47/XDJPhACJmthGuWY+C8u51XGOZw7MnzIEdKutzJgUJtlZzQi
        kM8j3Zj5pM7GDaR4d4O0TBI4dEQUlROPWSG9IF8NH7fM5xjbpY7KE7Ca0Y2BodX6ZHOKip
        JJwU51kjT8q86usRnmP7HU8WgpGPIFFhXzDVv9+klP5MsYPh59+YA7ppvx3ya5kyurbNqC
        N6wvXWWq2b5SCIV26Zmnx5ubSzdcyk6cKwZPAhFs3QUggNCoCKK/EyIMsG4HPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675688406;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2LLZAH/u09eNQOaEpRXMUws4XchHC3Bq1ostiMn75cs=;
        b=HbF5oBgVChCvs9ugwJqeIb7I2wYAQrFh2p8tBFq/gXtRwTrJ4/JsnPYvxEwW7YF7/0f7mA
        PfQNayke0rRcKZBA==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/core: Return an error only when necessary
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230130161709.11615-5-bp@alien8.de>
References: <20230130161709.11615-5-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <167568840420.4906.17934418820483240527.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     f33e0c893b22bf94d7985f1f2aa3872237560c74
Gitweb:        https://git.kernel.org/tip/f33e0c893b22bf94d7985f1f2aa3872237560c74
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Mon, 30 Jan 2023 13:48:04 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 06 Feb 2023 13:41:31 +01:00

x86/microcode/core: Return an error only when necessary

Return an error from the late loading function which is run on each CPU
only when an error has actually been encountered during the update.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230130161709.11615-5-bp@alien8.de
---
 arch/x86/kernel/cpu/microcode/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index ddc0958..7a329e5 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -409,10 +409,10 @@ static int __reload_late(void *info)
 		goto wait_for_siblings;
 
 	if (err >= UCODE_NFOUND) {
-		if (err == UCODE_ERROR)
+		if (err == UCODE_ERROR) {
 			pr_warn("Error reloading microcode on CPU %d\n", cpu);
-
-		ret = -1;
+			ret = -1;
+		}
 	}
 
 wait_for_siblings:
