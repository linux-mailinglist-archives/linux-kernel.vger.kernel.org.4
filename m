Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235116188F7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 20:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiKCTwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 15:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiKCTwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 15:52:05 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076ED20358
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 12:52:03 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x2so4712022edd.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 12:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GteW77xtmVFSxJeOH5lkPz2xCnVHhXZ4689sF4PXr4=;
        b=XS+nYmWGxVzp8b3+Ikv2y44FFDaFheYgYIbiPVlgn49mfTqtgEsOyaHPJ3r/p5B3tt
         Nt5dBpQKml2iwalKxnRphnFIG/LSj40LX/DzeEwbsW5Dg19uBCqt/dPpJ2mM/QlxNP0t
         ViMsoPF0uR0Y3DKOyO063X/SvB/Y+eaqBrfHolnwX/6pjNtDDh3k1wIWEqvSHb7fE5B7
         BIhEjckfBLuXmH/TBcTQHGLPIYq+oavrnSOxXg6z7utaTTQs+wYLNmcNTZ/7g3YeuT0q
         LHdaXBVv5HYmGiczZ9CUEcLy03QRnuty4MISIWcoLtHL7iaGIIQ20TYEJGlpEADAFiA4
         Gw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GteW77xtmVFSxJeOH5lkPz2xCnVHhXZ4689sF4PXr4=;
        b=zxPkt69izCMPtW2SBv1j1YQgCdun4bi0tZOFN+nimSq+nc6/3P+5MBufXEfN87d8l4
         1xtD2RLPy4q3lujJxjQlBXPfSrkz7uq4Mzg/2zfEMhDi/13mgVuzlzjhiwQhsTDUv/S0
         W4oWZrurS8Mix/4TA2yw1IJY9Hsef/cr7H989owwc5sbJe0WLV1MyF1VtDmIEHZTB1oD
         2zIw9vvv1gaDgxZYPZt75M81ytJwiSJSfkiGk2c4mQCxxVOwL5JUTNOWjKGXrbIFTQ7q
         vaeEfxTDcC5fmvPGiF919UppH9AeDCRmM8AKZQ05PuBjJfrC+Njf5Nd9ZP5DLlZVyoJ+
         sVww==
X-Gm-Message-State: ACrzQf0dXLpvVy3rdRLqRa1ifTkXK2/kjsXIEWx7YgttQoBeYeoAqy5q
        ECJNaWddl9FKu4HUtjCyy2Q4VA==
X-Google-Smtp-Source: AMsMyM4DNEi7YFpsAkwoRPewFN1jOqD6yNDTR6Aqxrw0T9uOy1Ku99Cu3zusUZikSVaqJSi9fToi2A==
X-Received: by 2002:a05:6402:1f06:b0:457:149d:beaa with SMTP id b6-20020a0564021f0600b00457149dbeaamr31567406edb.238.1667505122589;
        Thu, 03 Nov 2022 12:52:02 -0700 (PDT)
Received: from localhost (cgw.msart-bajzova4.ke.cust.o2bs.sk. [90.176.4.227])
        by smtp.gmail.com with ESMTPSA id m4-20020a1709062b8400b0078c213ad441sm864087ejg.101.2022.11.03.12.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:52:02 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        David Virag <virag.david003@gmail.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 4/6] iommu/exynos: Implement shutdown driver method
Date:   Thu,  3 Nov 2022 20:51:52 +0100
Message-Id: <20221103195154.21495-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221103195154.21495-1-semen.protsenko@linaro.org>
References: <20221103195154.21495-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While remove method shouldn't be implemented, as it can't be done
reliably, the shutdown method can be useful for performing a kexec.
That was inspired by other IOMMU drivers, see commit 1a4e90f25b2c
("iommu/rockchip: Perform a reset on shutdown") for example.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - New patch

 drivers/iommu/exynos-iommu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index aad845677bda..cd3f74e638f0 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -753,6 +753,16 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static void exynos_sysmmu_shutdown(struct platform_device *pdev)
+{
+	struct sysmmu_drvdata *data = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	int irq = platform_get_irq(pdev, 0);
+
+	devm_free_irq(dev, irq, data);
+	pm_runtime_force_suspend(dev);
+}
+
 static int __maybe_unused exynos_sysmmu_suspend(struct device *dev)
 {
 	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
@@ -803,6 +813,7 @@ MODULE_DEVICE_TABLE(of, sysmmu_of_match);
 
 static struct platform_driver exynos_sysmmu_driver = {
 	.probe	= exynos_sysmmu_probe,
+	.shutdown = exynos_sysmmu_shutdown,
 	.driver	= {
 		.name		= "exynos-sysmmu",
 		.of_match_table	= sysmmu_of_match,
-- 
2.35.1

