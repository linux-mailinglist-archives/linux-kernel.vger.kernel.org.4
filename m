Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD52D62E4B0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240692AbiKQSo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240737AbiKQSoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:44:23 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528AE88FA6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 10:44:16 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id i12so1469616wrb.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 10:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rp0+8BPuJ8E8smg5sOZObB/EIeL6ON/FELSHAO9YZBo=;
        b=AXY8l7YC5VNrVrpoQhdKI9J3ad43+/giUy55N3ubiICCui4jIh7PWDBCoGiDYjLZ4w
         r34Iuw7JEkvUVtwFKIlEb+fqj/htEpH+Gkf3HwLq7+0GpE51rmg2+g5Rj6b1ROHujrtx
         SkS8pYISP3dT99/FFVmYSsXSsXXmS6xREX9vNBW99pXQd9jSRtnWOdyXGbjWMBe2yIMS
         21iqHZfQ2/mVUxHw79a0FygJZamt5+u3XZ6dggfV6dq3KJTmoVKxxI/ug+uctY7PXf+j
         CN1fXPizYDbXL7eAWsrLvHOLAsFFpovlu1uoHUCmUgoIV5RWjLumJHmY1awclP0VDfi5
         amKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rp0+8BPuJ8E8smg5sOZObB/EIeL6ON/FELSHAO9YZBo=;
        b=6PaNtpkgZTjnNvbIsuRn9cNcf+5vtkTliY2e8faeF2NiIJHH29lb7IOMQaVl/pdVpp
         VH0vUf8enobqU7ovY6Jichx9ZUhyV1PemLalYkWbeSczkhDOwvZOdaXP5bjotkf+ZJ8k
         eJu6H0JwFulKBFzntLNsWmCdPVkx9Y5AxQKjay+6lsqzT2pXtOrUEjRnlBlrxZJRfU/6
         0T41DPuNUJXp5A5oYZ3WOsVwE+dbd4GisB/J6bBJJ5Pb3jWlWsZS9j05kjL/TmcDDA4N
         cRvAJZxynyDsYvZVOR20LXzsUH+RbdBeD+RqVe/3N4IRqoZ1K9kYXw0+PGDJGB+BYcHg
         4oiQ==
X-Gm-Message-State: ANoB5pnSSn1Mvq5XtFITaapXeVj3eMTH/gdlfCrzKlBGG49A4AMjHvLX
        pZTizJoR1Pd++yfvWc2QCLPF3sXf/U1DlA==
X-Google-Smtp-Source: AA0mqf5pPHP3OtCVF/DwPk7PI+XYjhjwR2oyWFDFPLgy5tmVieUd+ggblt1YYpDjmOK9T2F6VE1cZg==
X-Received: by 2002:a05:6000:1f10:b0:241:b92f:1753 with SMTP id bv16-20020a0560001f1000b00241b92f1753mr1942764wrb.81.1668710654839;
        Thu, 17 Nov 2022 10:44:14 -0800 (PST)
Received: from nicolas-Precision-3551.home ([2001:861:5180:dcc0:9287:74a3:4740:e7a0])
        by smtp.gmail.com with ESMTPSA id l32-20020a05600c1d2000b003cfbbd54178sm11548635wms.2.2022.11.17.10.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 10:44:13 -0800 (PST)
From:   Nicolas Frayer <nfrayer@baylibre.com>
To:     peter.ujfalusi@gmail.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     khilman@baylibre.com, glaroque@baylibre.com, nfrayer@baylibre.com
Subject: [PATCH v3] dmaengine: ti: k3-udma: Deferring probe when soc_device_match() returns NULL
Date:   Thu, 17 Nov 2022 19:44:06 +0100
Message-Id: <20221117184406.292416-1-nfrayer@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the k3 socinfo driver is built as a module, there is a possibility
that it will probe after the k3 udma driver and the later returns -ENODEV.
By deferring the k3 udma probe we allow the k3 socinfo to probe and
register the soc_device_attribute structure needed by the k3 udma driver.
Removed the dev_err() message as well as it's deferring and not failing.

Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
---
v1->v2:
Extracted this patch from the following series:
https://lore.kernel.org/all/20221108181144.433087-1-nfrayer@baylibre.com/

v2->v3:
Removed the dev_err() message

 drivers/dma/ti/k3-udma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index ce8b80bb34d7..ca1512eb9910 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -5271,10 +5271,10 @@ static int udma_probe(struct platform_device *pdev)
 	ud->match_data = match->data;
 
 	soc = soc_device_match(k3_soc_devices);
-	if (!soc) {
-		dev_err(dev, "No compatible SoC found\n");
-		return -ENODEV;
-	}
+
+	if (!soc)
+		return -EPROBE_DEFER;
+
 	ud->soc_data = soc->data;
 
 	ret = udma_get_mmrs(pdev, ud);
-- 
2.25.1

