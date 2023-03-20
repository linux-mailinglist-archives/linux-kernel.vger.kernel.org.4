Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C9B6C21B7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 20:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjCTTlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 15:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCTTkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:40:43 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2676C40FA;
        Mon, 20 Mar 2023 12:35:49 -0700 (PDT)
Received: from vm02.corp.microsoft.com (unknown [167.220.197.27])
        by linux.microsoft.com (Postfix) with ESMTPSA id ECE8B20FB401;
        Mon, 20 Mar 2023 12:20:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ECE8B20FB401
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1679340033;
        bh=bBdSO4BEUDEVvMxcTCZ7JtzxLQQi6ViWeqB1o0Yg5QQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aC4qY5fbWDOd1/rAuigVUKUZ43nQyrIVW4WFOyvpm+pi97B1zWWKl+JPY0633s+7t
         1HReNQZ1bUjA6tZVJWrlVhCfEdptTd7x/0CBnuo2AMavRVYrL4QbA0HOrVZuSJYOoA
         +N5MumsbrDr0W1dPgg08GkGb90B1bsKbjQjeL1t4=
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        "Brijesh Singh" <brijesh.singh@amd.com>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        linux-crypto@vger.kernel.org
Subject: [PATCH v3 7/8] crypto: ccp - Skip DMA coherency check for platform psp
Date:   Mon, 20 Mar 2023 19:19:55 +0000
Message-Id: <20230320191956.1354602-8-jpiotrowski@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320191956.1354602-1-jpiotrowski@linux.microsoft.com>
References: <20230320191956.1354602-1-jpiotrowski@linux.microsoft.com>
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

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
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
2.34.1

