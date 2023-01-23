Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC27677F99
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjAWPZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbjAWPYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:24:46 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD9D429E14;
        Mon, 23 Jan 2023 07:24:25 -0800 (PST)
Received: from vm02.corp.microsoft.com (unknown [167.220.196.155])
        by linux.microsoft.com (Postfix) with ESMTPSA id CFB7320E2D17;
        Mon, 23 Jan 2023 07:23:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CFB7320E2D17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1674487416;
        bh=ZRr5emoAjwsKHLORaeHN0pRgcw3vJaLO85YWOsHBP7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BWIKbfSO9UWd7qMXcBTSiPeJnP/HB4O6zvUwhR8md4LIvss8UxStEY6iOg4rq3GJy
         XMLY9NJLgoKvARIO6sHAJmgJC19D4EZwbyVdqYiqVw6jxNo98NaKaz9mt6sMxOxd2O
         pQJwIIuO2wbw3SjO9y9yLwaTE00Xg4Sta9cCOP4M=
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Brijesh Singh" <brijesh.singh@amd.com>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        linux-crypto@vger.kernel.org,
        Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Subject: [PATCH v1 5/8] crypto: cpp - Bind to psp platform device on x86
Date:   Mon, 23 Jan 2023 15:22:47 +0000
Message-Id: <20230123152250.26413-6-jpiotrowski@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230123152250.26413-1-jpiotrowski@linux.microsoft.com>
References: <20230123152250.26413-1-jpiotrowski@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PSP in Hyper-V VMs is exposed through the ASP ACPI table and is
represented as a platform_device. Allow the ccp driver to bind to it by
adding an id_table and initing the platform_driver also on x86. At this
point probe is called for the psp device but init fails due to missing
driver data.

Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
---
 drivers/crypto/ccp/sp-dev.c      | 8 ++++++--
 drivers/crypto/ccp/sp-platform.c | 7 +++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/ccp/sp-dev.c b/drivers/crypto/ccp/sp-dev.c
index 7eb3e4668286..52b8d957d0f6 100644
--- a/drivers/crypto/ccp/sp-dev.c
+++ b/drivers/crypto/ccp/sp-dev.c
@@ -258,7 +258,11 @@ static int __init sp_mod_init(void)
 	ret = sp_pci_init();
 	if (ret)
 		return ret;
-
+	ret = sp_platform_init();
+	if (ret) {
+		sp_pci_exit();
+		return ret;
+	}
 #ifdef CONFIG_CRYPTO_DEV_SP_PSP
 	psp_pci_init();
 #endif
@@ -286,7 +290,7 @@ static void __exit sp_mod_exit(void)
 #ifdef CONFIG_CRYPTO_DEV_SP_PSP
 	psp_pci_exit();
 #endif
-
+	sp_platform_exit();
 	sp_pci_exit();
 #endif
 
diff --git a/drivers/crypto/ccp/sp-platform.c b/drivers/crypto/ccp/sp-platform.c
index 7d79a8744f9a..ea8926e87981 100644
--- a/drivers/crypto/ccp/sp-platform.c
+++ b/drivers/crypto/ccp/sp-platform.c
@@ -56,6 +56,12 @@ static const struct of_device_id sp_of_match[] = {
 MODULE_DEVICE_TABLE(of, sp_of_match);
 #endif
 
+static const struct platform_device_id sp_plat_match[] = {
+	{ "psp" },
+	{ },
+};
+MODULE_DEVICE_TABLE(platform, sp_plat_match);
+
 static struct sp_dev_vdata *sp_get_of_version(struct platform_device *pdev)
 {
 #ifdef CONFIG_OF
@@ -212,6 +218,7 @@ static int sp_platform_resume(struct platform_device *pdev)
 #endif
 
 static struct platform_driver sp_platform_driver = {
+	.id_table = sp_plat_match,
 	.driver = {
 		.name = "ccp",
 #ifdef CONFIG_ACPI
-- 
2.25.1

