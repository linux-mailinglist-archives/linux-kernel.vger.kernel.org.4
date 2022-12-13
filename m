Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D321564BA98
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 18:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbiLMREk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 12:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236135AbiLMRD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:03:58 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9302C7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 09:03:57 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b13so5962426lfo.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 09:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szYuQKkpwRTzwOk3epQzQRwK6PcLRVEX0v7Brg6XO+E=;
        b=gR54zbVLpSNZRO/CMCTifP4zMaW+8m+2Ct3vOe68Recyk7nDqclNm34byp7Vpd9vXN
         nbOXn6Hb5kQ2uW0cXgIdSrlp6vYbFc1JEieGCg9bYhds8ywG3xybVLsTr+QYsGT6UX37
         bzghylyIBP1EVkjELY4pGkb3MAs5ryRH0+zKRSVgWjWcwiQaiB2ts0NXboQ+jAg2M4Jb
         j8ZC7McM2A3Na9LBMP7vIwsjMCuc2H/WhP0sgCnQgvGZIW+d//U7HD289jiN1NUBCRdC
         tSpMyolVctBUnmEGa3DvQNDGuAbzA1v+Oe2067Us65o3fkyTlXSRNUQhikpIzlIsUQC3
         LvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szYuQKkpwRTzwOk3epQzQRwK6PcLRVEX0v7Brg6XO+E=;
        b=m5xSt/aGtujVLQwbE3ES2Q+wTjTa4koMB3NWJ5ZvmzPGcDx19XFjF5cuTTk+LTHIk+
         DDj0VlCo0yIshtrXRLZ5+79Ef+1oTIJxFwnpufAR60ncMp2RoldhjMYXfPdCiB31EbwO
         NpLnmDVaIXtjt42mmyhUY9UFFsHMHsApL3zwOaUQsmVM3yZsx5/Ma1whBjWXuLE74VLz
         TDmGWkVcslOqzOeJAkGt9SFLHzzGkzAAv/T2awpQDq8R+5RJAYYJkZ/DtEa6wElxlq07
         6jor5299LwKS/gSb3nYwLez1E7H3n+/Dk1i9heSX9+1VZ2S2vS2HX4r1Yt8E3yUu7rF2
         idBw==
X-Gm-Message-State: ANoB5plBzxFhtCtD6gJQKoxqixGwPBlzj8E8rwa8WmnnFy/qpmRCk1YT
        vpDWDDAHB5sZ5Dcc0vJqnPeF+w==
X-Google-Smtp-Source: AA0mqf4tWn453nW+I33H443hop8FMMDkSd2lzh5fozXf35tb4FIVf0uJXI9rRvGTKW04lL+GwhALxA==
X-Received: by 2002:a05:6512:1115:b0:4b5:b7ba:cae with SMTP id l21-20020a056512111500b004b5b7ba0caemr4116987lfg.48.1670951035718;
        Tue, 13 Dec 2022 09:03:55 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id e2-20020a05651236c200b004b56bebdc4esm446874lfs.14.2022.12.13.09.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 09:03:55 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 2/2] soc: qcom: rmtfs: Optionally map RMTFS to NAV VM
Date:   Tue, 13 Dec 2022 18:03:40 +0100
Message-Id: <20221213170340.456252-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221213170340.456252-1-konrad.dybcio@linaro.org>
References: <20221213170340.456252-1-konrad.dybcio@linaro.org>
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

From: Loic Poulain <loic.poulain@linaro.org>

Some SoCs require that RMTFS is also mapped to the NAV VM. Trying to
power on the modem without that results in the whole platform crashing
and forces a hard reboot within about 2 seconds.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
[Konrad: reword, make conditional, add a define for NAV VMID]
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/rmtfs_mem.c | 22 +++++++++++++++-------
 include/linux/qcom_scm.h     |  1 +
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
index 0feaae357821..999f2c5b49b0 100644
--- a/drivers/soc/qcom/rmtfs_mem.c
+++ b/drivers/soc/qcom/rmtfs_mem.c
@@ -171,12 +171,13 @@ static void qcom_rmtfs_mem_release_device(struct device *dev)
 static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
-	struct qcom_scm_vmperm perms[2];
+	struct qcom_scm_vmperm perms[3];
 	struct reserved_mem *rmem;
 	struct qcom_rmtfs_mem *rmtfs_mem;
+	bool assign_to_nav;
 	u32 client_id;
 	u32 vmid;
-	int ret;
+	int ret, cnt = 0;
 
 	rmem = of_reserved_mem_lookup(node);
 	if (!rmem) {
@@ -191,6 +192,8 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 
 	}
 
+	assign_to_nav = of_property_read_bool(node, "qcom,assign-to-nav");
+
 	rmtfs_mem = kzalloc(sizeof(*rmtfs_mem), GFP_KERNEL);
 	if (!rmtfs_mem)
 		return -ENOMEM;
@@ -236,14 +239,19 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 			goto remove_cdev;
 		}
 
-		perms[0].vmid = QCOM_SCM_VMID_HLOS;
-		perms[0].perm = QCOM_SCM_PERM_RW;
-		perms[1].vmid = vmid;
-		perms[1].perm = QCOM_SCM_PERM_RW;
+		perms[cnt].vmid = QCOM_SCM_VMID_HLOS;
+		perms[cnt++].perm = QCOM_SCM_PERM_RW;
+		perms[cnt].vmid = vmid;
+		perms[cnt++].perm = QCOM_SCM_PERM_RW;
+
+		if (assign_to_nav) {
+			perms[cnt].vmid = QCOM_SCM_VMID_NAV;
+			perms[cnt++].perm = QCOM_SCM_PERM_RW;
+		}
 
 		rmtfs_mem->perms = BIT(QCOM_SCM_VMID_HLOS);
 		ret = qcom_scm_assign_mem(rmtfs_mem->addr, rmtfs_mem->size,
-					  &rmtfs_mem->perms, perms, 2);
+					  &rmtfs_mem->perms, perms, cnt);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "assign memory failed\n");
 			goto remove_cdev;
diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index f8335644a01a..150b72edb879 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -55,6 +55,7 @@ enum qcom_scm_ice_cipher {
 #define QCOM_SCM_VMID_MSS_MSA    0xF
 #define QCOM_SCM_VMID_WLAN       0x18
 #define QCOM_SCM_VMID_WLAN_CE    0x19
+#define QCOM_SCM_VMID_NAV        0x2B
 #define QCOM_SCM_PERM_READ       0x4
 #define QCOM_SCM_PERM_WRITE      0x2
 #define QCOM_SCM_PERM_EXEC       0x1
-- 
2.39.0

