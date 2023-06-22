Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475EC739C4A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjFVJMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjFVJL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:11:57 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0AC421D;
        Thu, 22 Jun 2023 02:02:40 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-666683eb028so4137691b3a.0;
        Thu, 22 Jun 2023 02:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687424560; x=1690016560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d6zDpm6SD0RxKjfR478ABKL+HYLdKnnccJQGQalujl4=;
        b=g6onHDg9F0lEFx/R2IRBdwp6L8NUCjELS+bgfsk/By0fR2WkH3iL2Xvw6PDOj5vPGf
         DLMQ95UwluXPLqmbLmx1t0B0WZ+y/zcoSbOQvaOD3ZC+rtEOtl7ooFrUvS4UgZbwgFFl
         ceHYSAXXfqMFT2TZvMZgcmRE4XmoiCfSnopXfFWH11ZAdV17zsIN+eMsTAjjfTOj6BdB
         h3gPmeXwdhTg+xB1qpy7oH/zlmDCKQTtR3LH6t7XPNWzrf3u0w8cvoqa9eCDBWNQ6Qwr
         Wy/v1TH6JQmcYHFf3yam22eWMnvnc4far8rEAkoVibEpjOkyeKdxW48KER0V7tug8Oye
         zVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687424560; x=1690016560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6zDpm6SD0RxKjfR478ABKL+HYLdKnnccJQGQalujl4=;
        b=PYmbU0AFIRcruJGfqkMe5XDSJVuQT4XCwfMgolDI+Cxya/uvsc7fWuSo7yEE9CAERN
         GNR+KZh/Zs8vwVAC/EiKqhTtSNicFaqrRBEunZMIEc7mkUNucjg8bvxAfS4NTfAVzWPr
         p9M8JLVT/w/A8aNMJx+fHI+fDFMyOih/exCjul98Tj+suoMtwWNG4vL1vwkHJBYfOeFz
         d8y1pzLX58Em8MXFAHHrtiDaxaY8RQI0/+HFZ5knKVjK5sKuK+WljhWkOimdcpBEgGfU
         BuXNXD+Kg2e5At0dhUn63flp6Z0AX614pXi4p603IKjHtVlWC4j258vHasCXksh83vs2
         x1dw==
X-Gm-Message-State: AC+VfDy6L6d47572I02uNFIsofzeezPm5W9WA5GTWeCRGBhbBCCLgAwo
        3L65deyThEzkfej7hmBdGKM=
X-Google-Smtp-Source: ACHHUZ7/YeU8hZPjv85Errxr+74DQRBJc4FlkRd2uCXZ8gqyASlBT4K+/rmK5nuMdES9y2SDeiKPFg==
X-Received: by 2002:a05:6a00:1995:b0:668:95c1:ec9d with SMTP id d21-20020a056a00199500b0066895c1ec9dmr7261032pfl.28.1687424560173;
        Thu, 22 Jun 2023 02:02:40 -0700 (PDT)
Received: from chcpu13.cse.ust.hk (191host119.mobilenet.cse.ust.hk. [143.89.191.119])
        by smtp.gmail.com with ESMTPSA id j25-20020a62e919000000b00662610cf7a8sm4239614pfh.172.2023.06.22.02.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 02:02:39 -0700 (PDT)
From:   Wei Chen <harperchen1110@gmail.com>
To:     tonyhuang.sunplus@gmail.com
Cc:     lhjeff911@gmail.com, ulf.hansson@linaro.org,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wei Chen <harperchen1110@gmail.com>
Subject: [PATCH] mmc: sunplus: fix return value check of mmc_add_host()
Date:   Thu, 22 Jun 2023 09:02:33 +0000
Message-Id: <20230622090233.188539-1-harperchen1110@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mmc_add_host() may return error, if we ignore its return value,
1. the memory allocated in mmc_alloc_host() will be leaked
2. null-ptr-deref will happen when calling mmc_remove_host()
in remove function spmmc_drv_remove() because deleting not
added device.

Fix this by checking the return value of mmc_add_host(). Moreover,
I fixed the error handling path of spmmc_drv_probe() to clean up.

Signed-off-by: Wei Chen <harperchen1110@gmail.com>
---
 drivers/mmc/host/sunplus-mmc.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sunplus-mmc.c b/drivers/mmc/host/sunplus-mmc.c
index db5e0dcdfa7f..a96e90ea6541 100644
--- a/drivers/mmc/host/sunplus-mmc.c
+++ b/drivers/mmc/host/sunplus-mmc.c
@@ -902,7 +902,7 @@ static int spmmc_drv_probe(struct platform_device *pdev)
 
 	ret = mmc_of_parse(mmc);
 	if (ret)
-		goto probe_free_host;
+		goto clk_disable;
 
 	mmc->ops = &spmmc_ops;
 	mmc->f_min = SPMMC_MIN_CLK;
@@ -911,7 +911,7 @@ static int spmmc_drv_probe(struct platform_device *pdev)
 
 	ret = mmc_regulator_get_supply(mmc);
 	if (ret)
-		goto probe_free_host;
+		goto clk_disable;
 
 	if (!mmc->ocr_avail)
 		mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
@@ -927,9 +927,17 @@ static int spmmc_drv_probe(struct platform_device *pdev)
 	host->tuning_info.enable_tuning = 1;
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
-	mmc_add_host(mmc);
+	ret = mmc_add_host(mmc);
+	if (ret)
+		goto pm_disable;
 
-	return ret;
+	return 0;
+
+pm_disable:
+	pm_runtime_disable(&pdev->dev);
+
+clk_disable:
+	clk_disable_unprepare(host->clk);
 
 probe_free_host:
 	if (mmc)
-- 
2.25.1

