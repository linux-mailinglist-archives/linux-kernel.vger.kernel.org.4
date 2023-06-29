Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13F174279D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 15:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjF2Nnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 09:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbjF2Nnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 09:43:43 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0B52681;
        Thu, 29 Jun 2023 06:43:42 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-992ac92aed9so86202166b.3;
        Thu, 29 Jun 2023 06:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688046220; x=1690638220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XudmxwalV4AlT0qJLqOHnMWwuiigipmsi3w0OPbf44c=;
        b=Zhs3fgvt1G+iCtnPEYMZxQ2g9jPDRO3yYUKeQozSK4MYqD1FqZAD+nuCS5ym+L+RaI
         duD2pbR+p9OqO0RZ7ZxLtZYd6CPenExqZnZYiuu56oq1o2LLnAquDIlc2cJMFiQP2ybs
         e7RWYdvhlftVKPRbfklEKIRL1lBIwKpmck78AUGng5zriDs5STsE7UNui+ZJMhj01hoG
         BeFERNcE7f2efp4qQvMMo47Kx1g24QC34yHyusdKDyl4Xof34yUtH1dcdkwRppvLj8D+
         XOOgzJLMT4jJRHtEgeefKdHlhIV6RKaU+vGqmuDVmZSvzVCmLtcIVobTYui7jBy//qQW
         Ytyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688046220; x=1690638220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XudmxwalV4AlT0qJLqOHnMWwuiigipmsi3w0OPbf44c=;
        b=YlKGm8Jsja0vBzuBONJnNVpSlw+5kEPHpBsT8Jjrqx6EwIYddrUzCjiCIVLbDeJqWk
         m+KtlCJsFYu2+DY3RtGaFQ1RDtEjxchDQQzkthPPYQ4GL6uxyXihJ0ipZ2JGQJHb1hWG
         jC0pxgtlVq0heak9N2cXSn5k0vXnVbPe4PZoCXpgDUqlT4AzQxQt7gNfVQFZNHZ0RH9E
         ioSBi0VoShbSVy9xe6hHbdi9gLEF0majSpxs1O01HMeeQWBOZbb1ISPpyNpbzVAikUv7
         brvLV9bZ/pVS0IT7WVroakOjC5RYWEq24gwWjTctMtUx8Ai7CfJXaddo04Q+QevDE8u7
         pt5w==
X-Gm-Message-State: AC+VfDxoIjdxlFQYASKOsrR3srPPhTDq0DwBjdvx1Va4R+hwnunFoJzA
        vmLeO2TX8fuW7rKSsXr+dDs=
X-Google-Smtp-Source: ACHHUZ6B80u4DW25Ogg7aE+QDNQ4h9KXySc0s2UC/n0LEEN2ZYI5mYC/YoRmVKDwg0HP2sGQinr9QQ==
X-Received: by 2002:a17:907:3f18:b0:975:942e:81d5 with SMTP id hq24-20020a1709073f1800b00975942e81d5mr39118977ejc.1.1688046220384;
        Thu, 29 Jun 2023 06:43:40 -0700 (PDT)
Received: from localhost (dslb-094-220-187-252.094.220.pools.vodafone-ip.de. [94.220.187.252])
        by smtp.gmail.com with ESMTPSA id bm6-20020a170906c04600b00988ae874fc3sm6894818ejb.40.2023.06.29.06.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 06:43:39 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: bcm-qspi: return error if neither hif_mspi nor mspi is available
Date:   Thu, 29 Jun 2023 15:43:05 +0200
Message-Id: <20230629134306.95823-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If neither a "hif_mspi" nor "mspi" resource is present, the driver will
just early exit in probe but still return success. Apart from not doing
anything meaningful, this would then also lead to a null pointer access
on removal, as platform_get_drvdata() would return NULL, which it would
then try to dereferce when trying to unregister the spi master.

Fix this by unconditionally calling devm_ioremap_resource(), as it can
handle a NULL res and will then return a viable ERR_PTR() if we get one.

The "return 0;" was previously a "goto qspi_resource_err;" where then
ret was returned, but since ret was still initialized to 0 at this place
this was a valid conversion in 63c5395bb7a9 ("spi: bcm-qspi: Fix
use-after-free on unbind"). The issue was not introduced by this commit,
only made more obvious.

Fixes: fa236a7ef240 ("spi: bcm-qspi: Add Broadcom MSPI driver")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
Found by looking a the driver while comparing it to its bindings.

Only build tested, not runtested.

 drivers/spi/spi-bcm-qspi.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 6b46a3b67c41..d91dfbe47aa5 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1543,13 +1543,9 @@ int bcm_qspi_probe(struct platform_device *pdev,
 		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 						   "mspi");
 
-	if (res) {
-		qspi->base[MSPI]  = devm_ioremap_resource(dev, res);
-		if (IS_ERR(qspi->base[MSPI]))
-			return PTR_ERR(qspi->base[MSPI]);
-	} else {
-		return 0;
-	}
+	qspi->base[MSPI]  = devm_ioremap_resource(dev, res);
+	if (IS_ERR(qspi->base[MSPI]))
+		return PTR_ERR(qspi->base[MSPI]);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "bspi");
 	if (res) {
-- 
2.34.1

