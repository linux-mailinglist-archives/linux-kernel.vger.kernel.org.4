Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E80E62C170
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbiKPOxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbiKPOwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:52:55 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4072C3E08C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 06:51:22 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h9so30334223wrt.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 06:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1o2x75QMXnEx7W9bo3sYlpr0oxVXvlHN3ieGl1S2FPc=;
        b=3h5rMDTfwHaUo8Tfz7KdfwB3vd9otM7RLbRVqDPrK0mXHyv1qWktN8luJxAvG9UMDw
         ptRhtrRFo7AHRmoASbdCIto3/QR/kPAn1dnpKfTo1BRm8jVKf1CdVWNI6B/dqCN2oEiV
         OQvW3fKZCdmfNj/4rsIIsoMV6oaZOUbPkHwuXZcGNlbhlCi/T+LLMiqZhI6FGB6bTij6
         esYVmyzfEhXNEu7ZOtZEXtIOOgwyJ4Mu3zesB5R5tgz5FoYz5Ak5K073v1ASb1ru+wyL
         KNZVjlPwssDLKvMipJXLy7/XSmkETaGDMqq+2+KGtuOW/1TAIaxVwKjGlYh/2fHeP+gK
         tpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1o2x75QMXnEx7W9bo3sYlpr0oxVXvlHN3ieGl1S2FPc=;
        b=p0T40NdZ5lIhNJVxoTXTl6fCoxvFOFVc0eWvI66KnI/Qfw+wfdaD1garQq8jg0EfMc
         H0EcPdV5rPZn3etx4kd7glG9o6Lkv38T+hWCxxJZfvCKfd4KqghS1G0dd4/XQ8SdiB4K
         kc0qD9hdnn38BZdD2dPxuLQJJ5sOavHcvRbJ5/dtWXU8iFO+n6wcsPNGjTRVea1M2YJU
         czspvNXZXH5yHXVPAtROPJS2h8p6e3tAON8Jdude7CR2NeWhdn3XBvO+X3tnG3PH813A
         K/3FXuVuYLSkO4eTJ71s+8A/E4+kk0tQssoCcgMWlA4J7coCpeWKA08dPljQg5yq3Ha+
         KU5A==
X-Gm-Message-State: ANoB5plG9okd/eB3FN/zqUJv2pG7SC8kBV9ZzWfZi7P3joTrdEzlwOw2
        DzEnA9JWbvky7qWSgjJuFk5WcA==
X-Google-Smtp-Source: AA0mqf6ejUMBaMrkNuhXR4zlkR72Ojcc5WTamVCqnJ1JVDZn9Z20s7tmePtDouHInnYDJrrMipsf2w==
X-Received: by 2002:adf:cd06:0:b0:236:5e6a:7c4 with SMTP id w6-20020adfcd06000000b002365e6a07c4mr13998768wrm.150.1668610280721;
        Wed, 16 Nov 2022 06:51:20 -0800 (PST)
Received: from nicolas-Precision-3551.home ([2001:861:5180:dcc0:3f99:5293:49fd:9c5b])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b003cfa3a12660sm8641789wms.1.2022.11.16.06.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:51:20 -0800 (PST)
From:   Nicolas Frayer <nfrayer@baylibre.com>
To:     nm@ti.com, ssantosh@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     khilman@baylibre.com, glaroque@baylibre.com, nfrayer@baylibre.com
Subject: [PATCH v5 1/2] soc: ti: Convert allocations to devm
Date:   Wed, 16 Nov 2022 15:51:02 +0100
Message-Id: <20221116145103.26744-2-nfrayer@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221116145103.26744-1-nfrayer@baylibre.com>
References: <20221116145103.26744-1-nfrayer@baylibre.com>
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

Changed the memory and resource allocations in the probe function
to devm. Also added a remove callback.

Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
---
 drivers/soc/ti/k3-socinfo.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
index 91f441ee6175..19f3e74f5376 100644
--- a/drivers/soc/ti/k3-socinfo.c
+++ b/drivers/soc/ti/k3-socinfo.c
@@ -96,21 +96,18 @@ static int k3_chipinfo_probe(struct platform_device *pdev)
 	partno_id = (jtag_id & CTRLMMR_WKUP_JTAGID_PARTNO_MASK) >>
 		 CTRLMMR_WKUP_JTAGID_PARTNO_SHIFT;
 
-	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	soc_dev_attr = devm_kzalloc(&pdev->dev, sizeof(*soc_dev_attr), GFP_KERNEL);
 	if (!soc_dev_attr)
 		return -ENOMEM;
 
-	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%x.0", variant);
-	if (!soc_dev_attr->revision) {
-		ret = -ENOMEM;
-		goto err;
-	}
+	soc_dev_attr->revision = devm_kasprintf(&pdev->dev, GFP_KERNEL, "SR%x.0", variant);
+	if (!soc_dev_attr->revision)
+		return -ENOMEM;
 
 	ret = k3_chipinfo_partno_to_names(partno_id, soc_dev_attr);
 	if (ret) {
 		dev_err(dev, "Unknown SoC JTAGID[0x%08X]\n", jtag_id);
-		ret = -ENODEV;
-		goto err_free_rev;
+		return -ENODEV;
 	}
 
 	node = of_find_node_by_path("/");
@@ -118,22 +115,26 @@ static int k3_chipinfo_probe(struct platform_device *pdev)
 	of_node_put(node);
 
 	soc_dev = soc_device_register(soc_dev_attr);
-	if (IS_ERR(soc_dev)) {
-		ret = PTR_ERR(soc_dev);
-		goto err_free_rev;
-	}
+	if (IS_ERR(soc_dev))
+		return PTR_ERR(soc_dev);
+
+	platform_set_drvdata(pdev, soc_dev);
 
 	dev_info(dev, "Family:%s rev:%s JTAGID[0x%08x] Detected\n",
 		 soc_dev_attr->family,
 		 soc_dev_attr->revision, jtag_id);
 
 	return 0;
+}
+
+static int k3_chipinfo_remove(struct platform_device *pdev)
+{
+	struct soc_device *soc_dev = platform_get_drvdata(pdev);
 
-err_free_rev:
-	kfree(soc_dev_attr->revision);
-err:
-	kfree(soc_dev_attr);
-	return ret;
+	if (soc_dev)
+		soc_device_unregister(soc_dev);
+
+	return 0;
 }
 
 static const struct of_device_id k3_chipinfo_of_match[] = {
@@ -147,6 +148,7 @@ static struct platform_driver k3_chipinfo_driver = {
 		.of_match_table = k3_chipinfo_of_match,
 	},
 	.probe = k3_chipinfo_probe,
+	.remove = k3_chipinfo_remove,
 };
 
 static int __init k3_chipinfo_init(void)
-- 
2.25.1

