Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905745BF417
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 05:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiIUDHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 23:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiIUDHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 23:07:11 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452FC7E028
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 20:07:10 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id b75so4581210pfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 20:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=a1/JrpahI0MCnEJkWnZC0/MOqcEnsO92UJD6M/si+Ww=;
        b=Nnn6Ba/dbQ5V/6rjJfnskHVktjzMORpcnUjkNu9n5iJxqbYbCD74gh+Vl8h8Sw0Xin
         4+/0YH5zhTXKqdWdDovWnUZGjDfvcpcwCOOAvdTl47OubWyWOPyDujdoxasDjWegXGeo
         mdPtr9E+Pl3+LOJHPSiHfJX5G3i2OBLfMY1FxcT2Gq4qeiUItiv47tL4grhjHjFpeTUe
         PqP9FmX+22Bw2XwI9By4W6XFRHMwci54+lDsRDomDGqJZZ4W+JAQYxwbOGBSpCXWIGL/
         sPJt/zhwtayCTtj9GHKNf9kzh8D6H1e+5i8wl9p9poM75H7Q6mk9njDhFYMRL+Yzgh49
         Rt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=a1/JrpahI0MCnEJkWnZC0/MOqcEnsO92UJD6M/si+Ww=;
        b=blDtTFZjGHataqH6ggI3fusAOTx0g91SZCKbEsXNXRk4qjMgW/oTWFWdvOkyZxvm6s
         hLtO3CBYZO4Ddrru4o92EdqeLchStoFAr6x0ai98kN75YDYGf99/mPAbVO8TZ55I/21D
         IJxJK5fzwR+OG/Rvi9on5t4xYIHuqouiRWUiN9PNgpcFJiy4pW+DCVqRTPPH6covZ6I/
         JE44VnZJf5pW16BfdMHxx6QrexIPa/kpePrdbePF2L+KtCQq1PtIsTIDkyb6RN4+owCG
         5k7fCDzmlvUDL5hn3H+uR18s03GGs0n9i7cQETFUxDedM0E6no6eEx9lu4S3YbwmZhC1
         UKwg==
X-Gm-Message-State: ACrzQf3rrAs7a40E1YyV4xj5Dy5nYA1yZwIb3tAt848zRBplb5jrOG7I
        6N0bG7ZaxcjI/ZRb9hXyTYekqe1ZUzSwMA==
X-Google-Smtp-Source: AMsMyM4G4jXvDCpCygWYfcj2Gyr4NDg+7AKSdAIp6B8FKovCOLd0ki0bh4bLjKdwvO+FltlBR1y1gA==
X-Received: by 2002:a63:8843:0:b0:439:3c8e:c2c0 with SMTP id l64-20020a638843000000b004393c8ec2c0mr23013880pgd.404.1663729629829;
        Tue, 20 Sep 2022 20:07:09 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c61:8e50:8ba8:7ad7:f34c:2f5])
        by smtp.gmail.com with ESMTPSA id y23-20020aa78f37000000b0053e61633057sm690846pfr.132.2022.09.20.20.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 20:07:09 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     dmaengine@vger.kernel.org
Cc:     agross@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        thara.gopinath@gmail.com, devicetree@vger.kernel.org,
        andersson@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, vkoul@kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 1/1] dma: qcom: bam_dma: Add support to initialize interconnect path
Date:   Wed, 21 Sep 2022 08:36:49 +0530
Message-Id: <20220921030649.1436434-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220921030649.1436434-1-bhupesh.sharma@linaro.org>
References: <20220921030649.1436434-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thara Gopinath <thara.gopinath@gmail.com>

BAM dma engine associated with certain hardware blocks could require
relevant interconnect pieces be initialized prior to the dma engine
initialization. For e.g. crypto bam dma engine on sm8250. Such requirement
is passed on to the bam dma driver from dt via the "interconnects"
property. Add support in bam_dma driver to check whether the interconnect
path is accessible/enabled prior to attempting driver intializations.

If interconnects are not yet setup, defer the BAM DMA driver probe().

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Thara Gopinath <thara.gopinath@gmail.com>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
[Bhupesh: Make header file inclusion alphabetical and use 'devm_of_icc_get()']
---
 drivers/dma/qcom/bam_dma.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 2ff787df513e..a5b0cf28ffb7 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -26,6 +26,7 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/init.h>
+#include <linux/interconnect.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
@@ -394,6 +395,7 @@ struct bam_device {
 	const struct reg_offset_data *layout;
 
 	struct clk *bamclk;
+	struct icc_path *mem_path;
 	int irq;
 
 	/* dma start transaction tasklet */
@@ -1294,6 +1296,14 @@ static int bam_dma_probe(struct platform_device *pdev)
 	if (IS_ERR(bdev->bamclk))
 		return PTR_ERR(bdev->bamclk);
 
+	/* Ensure that interconnects are initialized */
+	bdev->mem_path = devm_of_icc_get(bdev->dev, "memory");
+	if (IS_ERR(bdev->mem_path)) {
+		ret = dev_err_probe(bdev->dev, PTR_ERR(bdev->mem_path),
+				    "failed to acquire icc path\n");
+		return ret;
+	}
+
 	ret = clk_prepare_enable(bdev->bamclk);
 	if (ret) {
 		dev_err(bdev->dev, "failed to prepare/enable clock\n");
-- 
2.37.1

