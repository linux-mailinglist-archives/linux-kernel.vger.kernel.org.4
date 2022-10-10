Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D035F9EEE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 14:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiJJMyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 08:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiJJMyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 08:54:22 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3761258B51
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 05:54:20 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n9so1217166wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 05:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmxR3um4spniKrU53rveTwc+P5yMRl5wO2vmfcVu86g=;
        b=vh/8DDdSud/RVv13pylyII+LJFPvrAuNJ5y7jA56FMFVURoDylE9N5z2OIOqNfrzlY
         XYapgbnrP9TeFlOWCsH4ujw+WN+VxGALgDnmKiE7XQK9n2XQQruAlzf7xuaFUhseFHcx
         3olE+TW2NIsQjY4hvGL5llKiEAi1PguqI9YwqEUi39hf70jHEeo4Oa83fhmKSEIjDn2s
         KJIMsbUgQhaIiDfyiTLgp/uM0NvJkE1bQ79dZ2V38jQdy6OHR3OkRTatmvijRolYIiGO
         BLfjAD53e32gjMsRJ/y7NUU1DAvvCZb4ZUur0ENiLBfQFW7yv2yovPMhRuTGH44Kr/nj
         uggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmxR3um4spniKrU53rveTwc+P5yMRl5wO2vmfcVu86g=;
        b=8A8RwJJc6FJKho8lEAGLEUZ9Ox/AQk7gsuVBCLgDtuVaOryoIWRgPBB59N1XxlIpfH
         RFoSwjRgOYKEJt8+6XeR7POwGRmxWWKaDqi43mZ+PfN+WTLwbGujO+xqWyZ84kp4imA7
         5aFPkd2pSEOudHMDZaj/rqHV0EacNd6LFfUwx9BKfCrm0wL9n0GHlK0YD9Y71TAQ8ij0
         0Cewc5AHOpnQkBJSbNTFzlKZ4pzsdNVj7Eq3YOXBp+HJ+8ygYmwUnIceEyWWJ5s/rv0B
         w4TnSoXNfnqSfEBNsT7bJTsRny5Qy+5Cnhc5oi63YKj/pt1zyhcM/xCuEguonbx+pid4
         DYjQ==
X-Gm-Message-State: ACrzQf1c83GJfdEeUOIBIdFaZb15j3SvOPHW0bgNo4CIk+6OiidW0hK1
        mSemOJZ8+bZsxo67+/4mZwAY8w==
X-Google-Smtp-Source: AMsMyM5e/ro8Q9KiuUwPEt9wTVF1C8YnK/+Kpd/WM6NPHdzx+3DtpxssO50mMBicIMeImLelqerAnA==
X-Received: by 2002:a1c:2743:0:b0:3b3:f017:f23a with SMTP id n64-20020a1c2743000000b003b3f017f23amr20455356wmn.137.1665406458413;
        Mon, 10 Oct 2022 05:54:18 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id v24-20020a1cf718000000b003a6125562e1sm9767020wmh.46.2022.10.10.05.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 05:54:17 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 10 Oct 2022 14:54:08 +0200
Subject: [PATCH v3 2/3] iommu/mediatek: add support for 6-bit encoded port IDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221001-iommu-support-v3-2-c7b3059b0d16@baylibre.com>
References: <20221001-iommu-support-v3-0-c7b3059b0d16@baylibre.com>
In-Reply-To: <20221001-iommu-support-v3-0-c7b3059b0d16@baylibre.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     iommu@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        linux-mediatek@lists.infradead.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2694; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=BCe+/ykFa/fn5SOJye+/BgPzDIeybFkkbiXBZtITeNI=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjRBX2NMVamMxV4iKNdLs5Ytoj7x609EByzseEUlTr
 DCfCrwmJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY0QV9gAKCRArRkmdfjHURXkqD/
 4kl4rMFWfYv99V/bLZVANdkEu77lQ589T720XVn8pm3TCt7R3wPnDPW1pQ5PFpUNw8QrFVzCl0FLTH
 rob/5QlnOXrSsP7UbptiAySmzifaGslwWa1nkumPRIWRn3yVfV+Lufs3rb7RoWdQuKX5VcN1rmg2kV
 uAeh4NkOxuUmjSiNJ6ZRBrVMye2vwFCk/3zQpB+vd/dVDKkaANhDrO7ZscT3xO+Mgy4Wjsuu85mHQk
 KETF3RFnwN51wwb90GaA8S4sfnT4tuG3RxGP+BFHaWCq80lpKo0EcxZXYbf9sNVUYUpNUThwqsGpOV
 KwGy0YIJ3rOSTQ31GyYYix6QuhUhqE/+K9jQjwSJJ5k4U5mpa+XEOinGJR/7G5CahDb5G6i2mxVXSW
 OrqyacrT2yjFKLO2s9HsO1sUUy5kbMIpQcUwlyIqMaxOBkK9QoLVQ2Q+DxtVP20ZyDeF6+NrmdHZB/
 VK3EoniLFX22BqXAtrWrr+rGA2gfkCf0lfyce7LyP1u31swSk/lXzxxbrmDnK9ODBczX+4U2Ng5Eb+
 n60sRNliqSmm/o3DBKXHSt2BU4IZyq5cizoPK29RPGjUuC/rJx7YD/n2QmwBIPs6j2QauZr+9b0sB5
 5v4E94mRCBs8r8PgKsoyur1k6BK6w+wdwVfj5OIl/DZbyFRUbhEfvLzlvVnw==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

Until now the port ID was always encoded as a 5-bit data. On MT8365,
the port ID is encoded as a 6-bit data. This requires to add extra
macro F_MMU_INT_ID_LARB_ID_EXT, and F_MMU_INT_ID_PORT_ID_EXT in order
to support 6-bit encoded port IDs.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/iommu/mtk_iommu.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 5a4e00e4bbbc..35e9731c3441 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -108,8 +108,12 @@
 #define F_MMU_INT_ID_SUB_COMM_ID(a)		(((a) >> 7) & 0x3)
 #define F_MMU_INT_ID_COMM_ID_EXT(a)		(((a) >> 10) & 0x7)
 #define F_MMU_INT_ID_SUB_COMM_ID_EXT(a)		(((a) >> 7) & 0x7)
+/* Macro for 5 bits lenght port ID field (default) */
 #define F_MMU_INT_ID_LARB_ID(a)			(((a) >> 7) & 0x7)
 #define F_MMU_INT_ID_PORT_ID(a)			(((a) >> 2) & 0x1f)
+/* Macro for 6 bits lenght port ID field */
+#define F_MMU_INT_ID_LARB_ID_EXT(a)		(((a) >> 8) & 0x7)
+#define F_MMU_INT_ID_PORT_ID_EXT(a)		(((a) >> 2) & 0x3f)
 
 #define MTK_PROTECT_PA_ALIGN			256
 #define MTK_IOMMU_BANK_SZ			0x1000
@@ -139,6 +143,7 @@
 #define IFA_IOMMU_PCIE_SUPPORT		BIT(16)
 #define PGTABLE_PA_35_EN		BIT(17)
 #define TF_PORT_TO_ADDR_MT8173		BIT(18)
+#define HAS_INT_ID_PORT_WIDTH_6		BIT(19)
 
 #define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)	\
 				((((pdata)->flags) & (mask)) == (_x))
@@ -441,7 +446,11 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 	fault_pa |= (u64)pa34_32 << 32;
 
 	if (MTK_IOMMU_IS_TYPE(plat_data, MTK_IOMMU_TYPE_MM)) {
-		fault_port = F_MMU_INT_ID_PORT_ID(regval);
+		if (MTK_IOMMU_HAS_FLAG(plat_data, HAS_INT_ID_PORT_WIDTH_6)) {
+			fault_port = F_MMU_INT_ID_PORT_ID_EXT(regval);
+		} else {
+			fault_port = F_MMU_INT_ID_PORT_ID(regval);
+		}
 		if (MTK_IOMMU_HAS_FLAG(plat_data, HAS_SUB_COMM_2BITS)) {
 			fault_larb = F_MMU_INT_ID_COMM_ID(regval);
 			sub_comm = F_MMU_INT_ID_SUB_COMM_ID(regval);
@@ -449,7 +458,11 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 			fault_larb = F_MMU_INT_ID_COMM_ID_EXT(regval);
 			sub_comm = F_MMU_INT_ID_SUB_COMM_ID_EXT(regval);
 		} else {
-			fault_larb = F_MMU_INT_ID_LARB_ID(regval);
+			if (MTK_IOMMU_HAS_FLAG(plat_data, HAS_INT_ID_PORT_WIDTH_6)) {
+				fault_larb = F_MMU_INT_ID_LARB_ID_EXT(regval);
+			} else {
+				fault_larb = F_MMU_INT_ID_LARB_ID(regval);
+			}
 		}
 		fault_larb = data->plat_data->larbid_remap[fault_larb][sub_comm];
 	}

-- 
b4 0.10.1
