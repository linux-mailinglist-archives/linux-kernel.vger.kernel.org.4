Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117385F4082
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 12:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiJDKCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 06:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiJDKBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 06:01:54 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168EA220F1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 03:01:53 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id ay36so8556831wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 03:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=NdUo6/RI1p6tJoNnkq7zFle6/XBK3Sebzkw7jP2AOl8=;
        b=o1IkBO3YAhKU4s9MKlhvpiaTPghExEFW/DBaCNSBhbS4YissQn+5ZdOy7mRF7U7hNl
         UvxA1r1keZwf0Mcfae6W5DYCW4nYqiKNFvnxY8OQDQ+Cm+pJmuPRbBowh+KyGmxGV3Oc
         ECHFj2Dz43Z2sEbMYaPBfC9ZSd7Nz8FvT0mWvQZMJY80SL4Fg/qjdLm+suBznOzd1RMB
         mhlCG0/zZs0BtnDnSv8C8gvqHMnbcFhazWLTV3bz/U2pP3yhiuwRPYQMkfy/n5AQtG7z
         EOFPLw2TnwL/g9yFoA2MeGQFTJ8deNQiiEQAPpoj7Rqc8qWO+tazJO+DqsTl2NQp4kdO
         P9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NdUo6/RI1p6tJoNnkq7zFle6/XBK3Sebzkw7jP2AOl8=;
        b=WEae5I9hkyEkz++CvXMZNMO9Ets65w/GOBA/hNk0EaFXljP3CLuJEBzojcARAzCaBy
         Cojv7JOrccolGdosqKTcsNwz18oJISFYLP+W3DmmP3RJqDFM29n8+7w0YSvjWO4J1oJ0
         Sp1lB1S/BmKgnEXGM0t364EvhN+88E5Net20KnByMZboBMTaiW3NzZDTXhhmkOWZr347
         PvIe6rew0n/qELiZLEl7agLYjhZWXW8QP4WPo4BugWYdH1k1DqQ31KOKyrzTX++DxFV0
         o8Peei9Ek97d37bbF/PPSMl76vepJ2T1zRobbQ4zozvv5IaF5Y22Tulm+UK//y6UJmCG
         yXnA==
X-Gm-Message-State: ACrzQf1I7lOahbx0r7MlfgYt7zaTjLUNIwO1fgg7yoLD+18b6yvWjSe4
        +8V0v5u4B5gYMBLBns8/LwwiFA==
X-Google-Smtp-Source: AMsMyM5AVQ8uC07QObsna76DOmCqN7vSQlO5gGPYW6Eh2A68gdOkRj0HE6d7Z/x5JFxnQxwq3E5IBQ==
X-Received: by 2002:a05:600c:3d05:b0:3b4:9a42:10d0 with SMTP id bh5-20020a05600c3d0500b003b49a4210d0mr9844671wmb.135.1664877711565;
        Tue, 04 Oct 2022 03:01:51 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id d3-20020a5d6dc3000000b0022e3cba367fsm5473645wrz.100.2022.10.04.03.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 03:01:51 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Tue, 04 Oct 2022 12:01:40 +0200
Subject: [PATCH v2 2/3] iommu/mediatek: add support for 6-bit encoded port IDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221001-iommu-support-v2-2-dbfef2eeebc9@baylibre.com>
References: <20221001-iommu-support-v2-0-dbfef2eeebc9@baylibre.com>
In-Reply-To: <20221001-iommu-support-v2-0-dbfef2eeebc9@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Alexandre Mergnat <amergnat@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        devicetree@vger.kernel.org, iommu@lists.linux.dev
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5941; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=poDJT7kVKFCzuP8AS6+Z3lQvstHhtNzhwUfS9ADL8m4=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjPASLI0qNjwoycoxtw2YRuYwQznnVA/L5C8e/1O4T
 02ghUbSJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCYzwEiwAKCRArRkmdfjHURb58EA
 ChJ/5F8pJnAY3CQAUrbkpRveMzBQsCluotHM8KtXwhDs4gtosZR3gf6RPP5+5x5qcUBNMtHwGgLgKc
 3joMrEMg0ngf/4WdW2YYFCCuqICFSE8Xd6SzMnL5vEzyFrEjNoal7JMJuA9VGr+GQArokXZg+jJMGg
 g8Yuh5c97+8A85+nW37YPp29LDFxxwzP7v0qLLl4bU3ek1ETq53ElHUs3dVRLEb+emUDMMdbJGuR5S
 UbZsueoscrsUdrIexC3oO86wb9Y/z3/isevvk7yoGdH+q2stTFD0HY1CKFV8v9dLSHvbNOvfasQAbx
 /RCmoNSu9D6ranJFiNklbNnESct4j2G0yLNOvc3JjJn8+MaBpljYnAOgZxzZF1O+cSKTdRZXM8jXsG
 uUof2xTYE2DCUR0mR6QrbulBzjFVUKWXSS09kMMou3t8t/VXyv6wVC83mM8obD0hQvzoMtZqISWsYc
 N6oqtC354yZWm916frLQJ/kZ9TlxnqBTiVr5VBk6/Oh13BqQ7SxWS3u24EMit5+6OXSWHI4oaLnt4+
 vGWAhHgqRiH2nYE78srZbXBFE2QLugPudyjjj5QQyjbGTwdEIZeL1QPRRjrDvjguKDtW/K/myNm3Re
 dlnCHWpX+N4nR5xIn2B6/sZGgRrZz0wfRoHwojsIA6rjTccpGJOSTr2hrXIQ==
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

Until now the port ID was always encoded as a 5-bit data. On MT8365,
the port ID is encoded as a 6-bit data. This requires to rework the
macros F_MMU_INT_ID_LARB_ID, and F_MMU_INT_ID_PORT_ID in order
to support 5-bit and 6-bit encoded port IDs.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/iommu/mtk_iommu.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 5a4e00e4bbbc..a57ce509c8b5 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -108,8 +108,10 @@
 #define F_MMU_INT_ID_SUB_COMM_ID(a)		(((a) >> 7) & 0x3)
 #define F_MMU_INT_ID_COMM_ID_EXT(a)		(((a) >> 10) & 0x7)
 #define F_MMU_INT_ID_SUB_COMM_ID_EXT(a)		(((a) >> 7) & 0x7)
-#define F_MMU_INT_ID_LARB_ID(a)			(((a) >> 7) & 0x7)
-#define F_MMU_INT_ID_PORT_ID(a)			(((a) >> 2) & 0x1f)
+#define F_MMU_INT_ID_LARB_ID(a, int_id_port_width)	\
+				((a) >> (((int_id_port_width) + 2) & 0x7))
+#define F_MMU_INT_ID_PORT_ID(a, int_id_port_width)	\
+				(((a) >> 2) & GENMASK((int_id_port_width) - 1, 0))
 
 #define MTK_PROTECT_PA_ALIGN			256
 #define MTK_IOMMU_BANK_SZ			0x1000
@@ -188,6 +190,7 @@ struct mtk_iommu_plat_data {
 	enum mtk_iommu_plat	m4u_plat;
 	u32			flags;
 	u32			inv_sel_reg;
+	u8			int_id_port_width;
 
 	char			*pericfg_comp_str;
 	struct list_head	*hw_list;
@@ -441,7 +444,8 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 	fault_pa |= (u64)pa34_32 << 32;
 
 	if (MTK_IOMMU_IS_TYPE(plat_data, MTK_IOMMU_TYPE_MM)) {
-		fault_port = F_MMU_INT_ID_PORT_ID(regval);
+		fault_port = F_MMU_INT_ID_PORT_ID(regval,
+						  data->plat_data->int_id_port_width);
 		if (MTK_IOMMU_HAS_FLAG(plat_data, HAS_SUB_COMM_2BITS)) {
 			fault_larb = F_MMU_INT_ID_COMM_ID(regval);
 			sub_comm = F_MMU_INT_ID_SUB_COMM_ID(regval);
@@ -449,7 +453,8 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 			fault_larb = F_MMU_INT_ID_COMM_ID_EXT(regval);
 			sub_comm = F_MMU_INT_ID_SUB_COMM_ID_EXT(regval);
 		} else {
-			fault_larb = F_MMU_INT_ID_LARB_ID(regval);
+			fault_larb = F_MMU_INT_ID_LARB_ID(
+					regval, data->plat_data->int_id_port_width);
 		}
 		fault_larb = data->plat_data->larbid_remap[fault_larb][sub_comm];
 	}
@@ -1379,6 +1384,7 @@ static const struct mtk_iommu_plat_data mt2712_data = {
 	.banks_enable = {true},
 	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}},
+	.int_id_port_width = 5,
 };
 
 static const struct mtk_iommu_plat_data mt6779_data = {
@@ -1391,6 +1397,7 @@ static const struct mtk_iommu_plat_data mt6779_data = {
 	.iova_region   = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap  = {{0}, {1}, {2}, {3}, {5}, {7, 8}, {10}, {9}},
+	.int_id_port_width = 5,
 };
 
 static const struct mtk_iommu_plat_data mt6795_data = {
@@ -1404,6 +1411,7 @@ static const struct mtk_iommu_plat_data mt6795_data = {
 	.iova_region  = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap = {{0}, {1}, {2}, {3}, {4}}, /* Linear mapping. */
+	.int_id_port_width = 5,
 };
 
 static const struct mtk_iommu_plat_data mt8167_data = {
@@ -1415,6 +1423,7 @@ static const struct mtk_iommu_plat_data mt8167_data = {
 	.iova_region  = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap = {{0}, {1}, {2}}, /* Linear mapping. */
+	.int_id_port_width = 5,
 };
 
 static const struct mtk_iommu_plat_data mt8173_data = {
@@ -1428,6 +1437,7 @@ static const struct mtk_iommu_plat_data mt8173_data = {
 	.iova_region  = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}}, /* Linear mapping. */
+	.int_id_port_width = 5,
 };
 
 static const struct mtk_iommu_plat_data mt8183_data = {
@@ -1439,6 +1449,7 @@ static const struct mtk_iommu_plat_data mt8183_data = {
 	.iova_region  = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
 	.larbid_remap = {{0}, {4}, {5}, {6}, {7}, {2}, {3}, {1}},
+	.int_id_port_width = 5,
 };
 
 static const struct mtk_iommu_plat_data mt8186_data_mm = {
@@ -1453,6 +1464,7 @@ static const struct mtk_iommu_plat_data mt8186_data_mm = {
 	.banks_enable   = {true},
 	.iova_region    = mt8192_multi_dom,
 	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
+	.int_id_port_width = 5,
 };
 
 static const struct mtk_iommu_plat_data mt8192_data = {
@@ -1466,6 +1478,7 @@ static const struct mtk_iommu_plat_data mt8192_data = {
 	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
 	.larbid_remap   = {{0}, {1}, {4, 5}, {7}, {2}, {9, 11, 19, 20},
 			   {0, 14, 16}, {0, 13, 18, 17}},
+	.int_id_port_width = 5,
 };
 
 static const struct mtk_iommu_plat_data mt8195_data_infra = {
@@ -1481,6 +1494,7 @@ static const struct mtk_iommu_plat_data mt8195_data_infra = {
 			    },
 	.iova_region      = single_domain,
 	.iova_region_nr   = ARRAY_SIZE(single_domain),
+	.int_id_port_width = 5,
 };
 
 static const struct mtk_iommu_plat_data mt8195_data_vdo = {
@@ -1495,6 +1509,7 @@ static const struct mtk_iommu_plat_data mt8195_data_vdo = {
 	.iova_region_nr	= ARRAY_SIZE(mt8192_multi_dom),
 	.larbid_remap   = {{2, 0}, {21}, {24}, {7}, {19}, {9, 10, 11},
 			   {13, 17, 15/* 17b */, 25}, {5}},
+	.int_id_port_width = 5,
 };
 
 static const struct mtk_iommu_plat_data mt8195_data_vpp = {
@@ -1513,6 +1528,7 @@ static const struct mtk_iommu_plat_data mt8195_data_vpp = {
 			   /* 16: 16a; 29: 16b; 30: CCUtop0; 31: CCUtop1 */
 			   {14, 16, 29, 26, 30, 31, 18},
 			   {4, MTK_INVALID_LARBID, MTK_INVALID_LARBID, MTK_INVALID_LARBID, 6}},
+	.int_id_port_width = 5,
 };
 
 static const struct of_device_id mtk_iommu_of_ids[] = {

-- 
b4 0.10.1
