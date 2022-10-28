Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B696119C9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiJ1SAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiJ1SAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:00:47 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFF969BEF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 11:00:43 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id t4so3664705wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 11:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=smdWxHRtEO+PTUqODIAY9J3ZmIcI6FLoPLj5U1S7fzY=;
        b=PqRljvG6XB3XGqOsF43juRSzcKEmk/Ug6d7eyTMgpL5hsfl7JfXCbf8e57eE4/ZFqF
         s41gxLYm3sBbOOLNsc7l7ZLkoY0+gjpeGhPIBEyN7qm5uN3X6EL2Rp2uWG0cyWogtljg
         rsh9UUwYmjsckB0Mi1f+RYOYCHLWWf3eaD4F82LYzQjrdOJj/soGoKAMUFuavHCjp7Ac
         HkgPdaVsNzAI4z5DTRCZkKsHvd+Y7Q7+u9TU8S5mknpS+A0ger3EwH4WIIlUJt7wcEga
         0vbjTE9xBVHSLARwFoom1WtGpDa+ZXCUVlf9xvxzYEqZMyLK927JqHLgL4DQKA+sVlWz
         jzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=smdWxHRtEO+PTUqODIAY9J3ZmIcI6FLoPLj5U1S7fzY=;
        b=dd3eXrx6HEvkPDGxUKkF5iDe+ZiLfNtMVpCZVjX3Q7vZG5KzZKpwyY8o7hFuKdjXqD
         HXkHF8keWpMM79bOVyR0Pv9N+m/lfR2+zkIE3hEaS5uT44tXC9Gos9WXRVkphdq37Ugd
         uXlbOKA8tnBlcotDnVcEjWTWN6fgDPSLbri9cHtInWOCYSLBPOV+B6UzcDV76j/bM2td
         NIAdDu7LaZYG4K4GpueQuStwY3RoiyhLsJRZRmt19PoH8wo+8Ob6TQrCRED0Hl+Xfepy
         13/A0kXlwWwKKctJTyS7RtmnEdFBD+Uh7yf9X4/bsqHq2abCk2i4n+fhJB1ZhQx3fRbq
         e5OA==
X-Gm-Message-State: ACrzQf2DNh7+/WcO5DriBfazDDnLqXqlZ2NpL/Yp9kF28u77Kf5DtzVn
        pE1B3ir+4hiHYwEy6rHzW5yGcQ==
X-Google-Smtp-Source: AMsMyM4AvlRio9ODd6XxLoB4qs0p0Wif2JBGAMBcBlJkoOTS8nxP+6g/FufNPIct3leO5o4W6jSznQ==
X-Received: by 2002:a05:600c:1da7:b0:3ce:a1:f961 with SMTP id p39-20020a05600c1da700b003ce00a1f961mr10173407wms.175.1666980041750;
        Fri, 28 Oct 2022 11:00:41 -0700 (PDT)
Received: from nicolas-Precision-3551.home ([2001:861:5180:dcc0:dd1b:73fb:9e6e:c05f])
        by smtp.gmail.com with ESMTPSA id e7-20020a5d65c7000000b0022ccae2fa62sm4155108wrw.22.2022.10.28.11.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 11:00:40 -0700 (PDT)
From:   Nicolas Frayer <nfrayer@baylibre.com>
To:     nm@ti.com, ssantosh@kernel.org, linux-kernel@vger.kernel.org
Cc:     khilman@baylibre.com, glaroque@baylibre.com, nfrayer@baylibre.com
Subject: [PATCH v3] soc: ti: Convert allocations to devm
Date:   Fri, 28 Oct 2022 20:00:33 +0200
Message-Id: <20221028180033.606362-1-nfrayer@baylibre.com>
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

Changed the memory and resource allocations in the probe function
to devm. Also added a remove callback.

Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
---

v2->v3:
dropped module conversion part of this series while other driver dependencies
on socinfo are worked out.
A dependency issue is introduced by changing subsys_initcall()
to module_platform_driver(). Some drivers using the socinfo information probe
before the socinfo driver itself and it makes their probe fail.

Dropped series:
https://lore.kernel.org/all/20221010131538.7333-1-nfrayer@baylibre.com/

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

