Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAED5FEAC0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 10:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiJNIqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 04:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiJNIpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 04:45:40 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0019B748DB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 01:45:37 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so3080371wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 01:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jK/ZA8ZpYldXBDNDXbE1og7C8Juwo1v3zOCfZOVwjtQ=;
        b=c4HGrOTb5Yo0phJrq0cHskbgHHArrHgXZ1xnh0/OZqKYreIP28X7bhGqOeyhEhwoFI
         20IALVhmrLvJtd+xc7ri7/D5drW9Sm5cIsIuy0DB/N5ORN6dCBkAhDpFuYBb9aFhog3f
         WYzeL/XA2drhy44dzShrcAEn93Bb3uy4W/XjW7IlCBeI5YuoCFXf95Nh7xrBvx16hI3f
         HSpFGWCNeAAnVSCsq5AN32lfS/e19CqCoPNLjvpW7moVC0vsYia9cgmWLdAEp6TVTvAp
         luAqwjQ/U0Zwgcul4d/WzXknivB+2HnvGV3BHVaYHjYZn5sfX7NdvTD7hlqIeW/kJs2K
         rbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jK/ZA8ZpYldXBDNDXbE1og7C8Juwo1v3zOCfZOVwjtQ=;
        b=UUA768Dqme+SY44dS48JuSZtKZ9kx/mONRtxHLZlIqlS5zqulDIyJ67cCK7XKoMXYg
         q4Ym9n5cXgQZoPPhpMkJ/C+ioinTruYKfQJdefqnCnu56+1uGWVZxw7YoJCV7W3HEF4w
         LAFK/xB31R5Cv9EI6lTrRc1b+8DIf6ZzBScym3Xg9G4lsgeIWXYpyqo6cOx19Gx6JpDH
         CloKClZztWHo+HZPcZM4q3g1RZCt/BMTChtuU0pda563BBq2MVDKZIXzGBihtV9vK7Lx
         Kt1HY8AsUU3GZgHoer8Skb1FNUCjiY2Pc36IBP33vOpHgc+QfxW6u+Jy2YHNy7ko5Fob
         Q9FA==
X-Gm-Message-State: ACrzQf1HLx3v28Zo6eBMoHLrtpX5e8768Dt4E65BeIUiOltK+8euNmwb
        Yt4jkmMhefamfTibNINiMepPLw==
X-Google-Smtp-Source: AMsMyM5ohMLvbcNIBjc+8GqTi8oCQoemygDDVgtEUDuLY0s/kkI5P2wJbG6B8qGRU2FQQ3UpJ64iXg==
X-Received: by 2002:a05:600c:4611:b0:3c5:e3a3:942a with SMTP id m17-20020a05600c461100b003c5e3a3942amr9635205wmo.82.1665737136527;
        Fri, 14 Oct 2022 01:45:36 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id m6-20020a1c2606000000b003c452678025sm6684633wmm.4.2022.10.14.01.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 01:45:36 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 14 Oct 2022 10:45:31 +0200
Subject: [PATCH v4 3/3] iommu/mediatek: add support for MT8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221001-iommu-support-v4-3-f1e13438dfd2@baylibre.com>
References: <20221001-iommu-support-v4-0-f1e13438dfd2@baylibre.com>
In-Reply-To: <20221001-iommu-support-v4-0-f1e13438dfd2@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-mediatek@lists.infradead.org,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        devicetree@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        iommu@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1965; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=5Lr2zHqNQGwcj6em1b7xul4Vf/YWO9kNyKL5oDTlads=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjSSGr7BsQTUiLKrxehh8tOo4ZIC5hyHUIZIW9sOAi
 nwgII0GJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY0khqwAKCRArRkmdfjHURbuxD/
 0WqvLoBQgSimQKQGAD+x70DIZxlDlnXKz5qAuK2/l59EWQCZbsyJuG/Kbtq/FmKj5opM1RHnmmtuz0
 orFwKeYMWtBygxpnBL/fzDvVOcJ3SvVrZnh+5p40r4BdQdGxJK54gl+DUBaIQN+DdVUyLCWHCcvbJ3
 X6LREa4Ig5pGEeepwk1leJCpb9sP3dOQtQG0nndXpwZJ6Agrkg3Jzk7/5Wl40T19J/0FxVS8qdECXH
 gt68v1ZksaWQLSjm+oDFUKlEfS3VMI6fVb/PXAkjbRmKXm9S0pTzFH6kcnGEgx6bro7KuFDSO2nUQS
 oDZlxIqiOpJWeiO1f01Qy/AWTwuFEeLyqSRGYvR3F9jpVJbsoxxZftZHfKhaZJtVQcqt+TDpUPhsJ/
 mRFZvxDiR6s+Yx7aU8Ido4J0plgJ5XFRPhZUuO92mWFHi+PF0CNuG4QFmRXacf8mxeYJJCQOLnMENh
 4kQxc78OF+1LLCcpFmeZgF/VGY1I1WkYoPLp7Vh1tFgW/nsPO5kfydYRULda1bwOev5LyZFBLi0DVV
 SCR22/3TDT4A1PPtOIXIDWiWTD4J5/rmz7nYhhmGbZu4RYVqCXn9lMU76iDugKeqlZXNveAnqLa4T5
 UX3eefNZecasDMcNzqNQVDhP2uuYFrTreO+3KlO64P7AZIYGQiwYZ1dS3ZiQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

Add IOMMU support for MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Reviewed-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Tested-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/iommu/mtk_iommu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 50195a900611..051ed5234538 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -170,6 +170,7 @@ enum mtk_iommu_plat {
 	M4U_MT8186,
 	M4U_MT8192,
 	M4U_MT8195,
+	M4U_MT8365,
 };
 
 struct mtk_iommu_iova_region {
@@ -1528,6 +1529,17 @@ static const struct mtk_iommu_plat_data mt8195_data_vpp = {
 			   {4, MTK_INVALID_LARBID, MTK_INVALID_LARBID, MTK_INVALID_LARBID, 6}},
 };
 
+static const struct mtk_iommu_plat_data mt8365_data = {
+	.m4u_plat	= M4U_MT8365,
+	.flags		= RESET_AXI | HAS_INT_ID_PORT_WIDTH_6,
+	.inv_sel_reg	= REG_MMU_INV_SEL_GEN1,
+	.banks_num	= 1,
+	.banks_enable	= {true},
+	.iova_region	= single_domain,
+	.iova_region_nr	= ARRAY_SIZE(single_domain),
+	.larbid_remap	= {{0}, {1}, {2}, {3}, {4}, {5}}, /* Linear mapping. */
+};
+
 static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
 	{ .compatible = "mediatek,mt6779-m4u", .data = &mt6779_data},
@@ -1540,6 +1552,7 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
 	{ .compatible = "mediatek,mt8195-iommu-infra", .data = &mt8195_data_infra},
 	{ .compatible = "mediatek,mt8195-iommu-vdo",   .data = &mt8195_data_vdo},
 	{ .compatible = "mediatek,mt8195-iommu-vpp",   .data = &mt8195_data_vpp},
+	{ .compatible = "mediatek,mt8365-m4u", .data = &mt8365_data},
 	{}
 };
 

-- 
b4 0.10.1
