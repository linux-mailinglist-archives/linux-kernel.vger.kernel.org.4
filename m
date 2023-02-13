Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0A9694100
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjBMJZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjBMJZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:25:06 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A33B815569;
        Mon, 13 Feb 2023 01:25:04 -0800 (PST)
Received: from vm02.corp.microsoft.com (unknown [167.220.196.155])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1CDF220C8B73;
        Mon, 13 Feb 2023 01:25:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1CDF220C8B73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1676280304;
        bh=je/3mF6RDXR0n2F5L5ZDLOFD8qSmDdLzDu1s3CUF/yc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hJ7/epNy7b8mi67fZB7M1U54lgF3LVaLTJI4xfE+mwvMUqDY7peHg7DN7doTyVmEx
         IGodrFFAckw461TgAyJUJmovuuGsXAATgDo2c7Kyj3h/7aqtAB+Jvg8jlsad9JNXoS
         kc9oCI4UgDKL6vSWUjrh8vFC8KJO990w8mXkwxjc=
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        "Brijesh Singh" <brijesh.singh@amd.com>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        linux-crypto@vger.kernel.org
Subject: [PATCH v2 7/8] crypto: ccp - Skip DMA coherency check for platform psp
Date:   Mon, 13 Feb 2023 09:24:28 +0000
Message-Id: <20230213092429.1167812-8-jpiotrowski@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213092429.1167812-1-jpiotrowski@linux.microsoft.com>
References: <20230213092429.1167812-1-jpiotrowski@linux.microsoft.com>
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

The value of device_get_dma_attr() is only relevenat for ARM64 and CCP
devices to configure the value of the axcache attribute used to access
memory by the coprocessor. None of this applies to the platform psp so
skip it. Skip the dma_attr check by keeping track of the fact that we
are a pure platform device.

Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
---
 drivers/crypto/ccp/sp-platform.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/sp-platform.c b/drivers/crypto/ccp/sp-platform.c
index 2e57ec15046b..be8306c47196 100644
--- a/drivers/crypto/ccp/sp-platform.c
+++ b/drivers/crypto/ccp/sp-platform.c
@@ -29,6 +29,7 @@
 struct sp_platform {
 	int coherent;
 	unsigned int irq_count;
+	bool is_platform_device;
 };
 
 static const struct sp_dev_vdata dev_vdata[] = {
@@ -109,6 +110,7 @@ static void sp_platform_fill_vdata(struct sp_dev_vdata *vdata, struct psp_vdata
 
 static struct sp_dev_vdata *sp_get_platform_version(struct sp_device *sp)
 {
+	struct sp_platform *sp_platform = sp->dev_specific;
 	struct psp_platform_data *pdata;
 	struct device *dev = sp->dev;
 	struct sp_dev_vdata *vdata;
@@ -129,6 +131,8 @@ static struct sp_dev_vdata *sp_get_platform_version(struct sp_device *sp)
 	sev = (void *)psp + sizeof(*psp);
 	sp_platform_fill_vdata(vdata, psp, sev, pdata);
 
+	sp_platform->is_platform_device = true;
+
 	dev_dbg(dev, "PSP feature register:\t%x\n", psp->feature_reg);
 	dev_dbg(dev, "PSP IRQ enable register:\t%x\n", psp->inten_reg);
 	dev_dbg(dev, "PSP IRQ status register:\t%x\n", psp->intsts_reg);
@@ -207,7 +211,7 @@ static int sp_platform_probe(struct platform_device *pdev)
 	}
 
 	attr = device_get_dma_attr(dev);
-	if (attr == DEV_DMA_NOT_SUPPORTED) {
+	if (attr == DEV_DMA_NOT_SUPPORTED && !sp_platform->is_platform_device) {
 		dev_err(dev, "DMA is not supported");
 		goto e_err;
 	}
-- 
2.25.1

