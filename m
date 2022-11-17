Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C579262D78D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239419AbiKQJ4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239421AbiKQJzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:55:32 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FDB43AFE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:54:29 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id z14so2875160wrn.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1o2x75QMXnEx7W9bo3sYlpr0oxVXvlHN3ieGl1S2FPc=;
        b=F2sxDaqNmyRFU3z4S0Onk+bOJP0mQcW/5PONPT8SXUJziEIvIo/1FwHHO266M0witV
         ZIFDxUV1eikIhGo9ZFkzd20h8+WtXuGnEJy6mulsQkRanw4LYXkuWlIFJVVwbJ7m6job
         rTy8mAbNoqlqhz0GudToFxJL5w97RH56WUrfTNItIIMzKamn2Qwee972p2Ou1uzWG8F2
         eHVUL6mFW7uBV78aAIyZq58qk8rHKMXpRA+sEne3sEs7lHEFLYVWLxePOqy/6ZcMg1ha
         DfwDX/SWL7qboeqAHfvN7bhyE2lo4pk8iQa5e8nkwvkXDCWJagqjI1f+VY+owbjgyn/0
         2JCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1o2x75QMXnEx7W9bo3sYlpr0oxVXvlHN3ieGl1S2FPc=;
        b=w/xDNNhgJleQdtMjsCmvZpn40hBxkeQIF/C8vTJxQCUqz9GRHoMEiwpXw0MLwT0qzh
         VwsjCcWr/XvS68OmKEut2CqVxIb+pMt6NZkBm5FsDn806M9xflUU7yQDOhYgMhM4Kfn9
         kwMAgtdHygb36ADKCSGNuvyL2sCbE1ZGmFUDsviVCk1Pai60s8bhu1+0ixwvaa1+rX6t
         zbqcv+7EBBZxsuqLnNqRIPAX8xBKlSoBqe454ogqJ10oCXWqNNpBAwEFO3dqWFvqThFK
         ksh6wD7klufREJ8+LgGui4fQoP/Cc5BKtuCyHQ2G/KzCQZxUu4XjYPRhjj/DGl0S90Y3
         9hhg==
X-Gm-Message-State: ANoB5pnpczyDf8hEesXpslD1SBSimL2hGWz8sHrZXhiyZgPFZ7UWgal+
        RUkOzh0w0Loeyg/KGKVQTOrVJg==
X-Google-Smtp-Source: AA0mqf6DQq9HKMbJVhBHzcujBbtwoXJUJKNe0Bf2Bb0RioItGpEc2WaOe6H3EboIddDlE1YESX6pTQ==
X-Received: by 2002:a5d:58c7:0:b0:236:60f3:d28f with SMTP id o7-20020a5d58c7000000b0023660f3d28fmr976253wrf.454.1668678867980;
        Thu, 17 Nov 2022 01:54:27 -0800 (PST)
Received: from nicolas-Precision-3551.home ([2001:861:5180:dcc0:9287:74a3:4740:e7a0])
        by smtp.gmail.com with ESMTPSA id v18-20020a5d6112000000b00236e834f050sm497021wrt.35.2022.11.17.01.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 01:54:27 -0800 (PST)
From:   Nicolas Frayer <nfrayer@baylibre.com>
To:     nm@ti.com, ssantosh@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     khilman@baylibre.com, glaroque@baylibre.com, nfrayer@baylibre.com
Subject: [PATCH v6 1/2] soc: ti: k3-socinfo: Convert allocations to devm
Date:   Thu, 17 Nov 2022 10:54:18 +0100
Message-Id: <20221117095419.171906-2-nfrayer@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117095419.171906-1-nfrayer@baylibre.com>
References: <20221117095419.171906-1-nfrayer@baylibre.com>
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

