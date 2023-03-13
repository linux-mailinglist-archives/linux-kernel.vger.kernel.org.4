Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37276B7837
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjCMM6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjCMM6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:58:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EDC2D7E;
        Mon, 13 Mar 2023 05:58:16 -0700 (PDT)
Date:   Mon, 13 Mar 2023 12:58:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678712291;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lbf4SQk6dTRJEfYxdlPAqQeFRGUttK8k0Iht4g9Hq6M=;
        b=gpNF13ER/GBxxqZpCaBd7xR7e6gR/M33dOjQkmltWTvwkLfk7xGXuh9vtAYsVb/t2ey4rI
        ywOWFrzi2LHVomkiuH5Khz7wvnSpNi/O87oPkJtSo9WGUyeywsGqvsFTHj4YG9SGGSeBnO
        euG8ykVe/eyuzXyovjw0eAdDF0SyOvHMW4zwAvZYp0HHa3pHtH2FsXr3hx/4cf30iSeqyE
        WWn3q3uDiBbdxRNqm6HbQtE3MmMQAFw5Wh5xatIKLQf6m3F4casp3SX5W3+qCCZOvpaHgs
        EGwzbwf7U80RAyLnZ6ZrMI57ehboOy4phWnfboBdAjVZ7IAa+HoX8Uu5r83FDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678712291;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lbf4SQk6dTRJEfYxdlPAqQeFRGUttK8k0Iht4g9Hq6M=;
        b=8aIzzVqtFsUN5zvGBKCH3+w1SjgH6We+H7XwR+IG1S5UkMe8fe1UDIDItl/QZ4FoSdmtI+
        O7fMOPawVviZWEAQ==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] virt/coco/sev-guest: Check SEV_SNP attribute at probe time
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230307192449.24732-3-bp@alien8.de>
References: <20230307192449.24732-3-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <167871229135.5837.1913962659795610718.tip-bot2@tip-bot2>
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

Commit-ID:     d6fd48eff7506bb866a54e40369df8899f2078a9
Gitweb:        https://git.kernel.org/tip/d6fd48eff7506bb866a54e40369df8899f2078a9
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 15 Feb 2023 11:01:42 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 13 Mar 2023 11:20:20 +01:00

virt/coco/sev-guest: Check SEV_SNP attribute at probe time

No need to check it on every ioctl. And yes, this is a common SEV driver
but it does only SNP-specific operations currently. This can be
revisited later, when more use cases appear.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20230307192449.24732-3-bp@alien8.de
---
 arch/x86/kernel/sev.c                   | 3 ---
 drivers/virt/coco/sev-guest/sev-guest.c | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 679026a..c644c34 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2183,9 +2183,6 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned 
 	struct ghcb *ghcb;
 	int ret;
 
-	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
-		return -ENODEV;
-
 	if (!fw_err)
 		return -EINVAL;
 
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 7b4e900..ed5d6ae 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -703,6 +703,9 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	void __iomem *mapping;
 	int ret;
 
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return -ENODEV;
+
 	if (!dev->platform_data)
 		return -ENODEV;
 
