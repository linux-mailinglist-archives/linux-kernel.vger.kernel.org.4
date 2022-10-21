Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0866078BC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiJUNmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiJUNmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:42:25 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DACD2527C0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:42:24 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so2037086wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZkpCfZ+KMMwdMgbTKPeMwoZ/jSslJjuzqWkYEMkvtQ=;
        b=HWa5jZP3Yi7VjMIDR2ZhX79ughNhUyVMb7tUT3kITu8QztzprAZyp48Y7CnLXix1LG
         edM8FJnZMCp3K+z7+nsrbWNhKEKKke5B+KziijHCXJnUU4fQnZT2PnJEBAPkrICMdN4A
         sQj3/l514Pg4shqR5LKA3m12Nnk4c9WwjgbuKTt1YQrQpnpfSnVl+dbSdC/X+MZDOEg1
         5zcNDlzkt6gzFx7zoPyn+sNqhzKH5YXnA5tZRf018CcW5oxEGxUkbsC0zL3dXR2CNhFJ
         lbre5/dYRPIglkJzm6XZ6orfdFO0+0y+4duNyPUTxvqlXK9yVbd3p5IwIGA7vxasDrQ+
         FZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZkpCfZ+KMMwdMgbTKPeMwoZ/jSslJjuzqWkYEMkvtQ=;
        b=Q47jZdk7kTypCcvMyueR2DfVM7qH7QsmLmI3pjgqWOo49TdrxhYe6Pn5ssgTnb6Z8L
         Hlq3MUkPd8XC3FM6X3nxL4S03ksROEoNowNIppyfwHnSuovQNQpggqZcanLYUhf9zCfl
         gprnm3yol5LxJxl0cQJeIXYsTF66OknD3RdB197lybbR9QLAJUssOih3aBW03Lcgai+V
         zaUdD0LmL1NPB6jabqXjT+E6S8M8ow6UF/dTWPSQ/x0Js0qlUhAzLruYrROPfe/n4bI7
         8DyP5Y9qdlj/7taX+TShzZXADCuDmiELXqNVcrRUVHBBo2ttBFtCCUfQK7tRTY+iI8/W
         qE/Q==
X-Gm-Message-State: ACrzQf15iGMlplSdFAJ0Hc8DNzKgVurptg5+xN78ZT67ICKIXAbPdBkv
        rSczc0C0cFoxmWaQGT4vmDKqiJoVHi90oeL7uno=
X-Google-Smtp-Source: AMsMyM4EruCHz4FiRPMJsTIRWJvpIkxJsn5bnd2+NEZlct0ZiYu+cbazTvuVeKgM8+Ts27UWb9+6Fw==
X-Received: by 2002:a05:600c:3c84:b0:3b4:eff4:ab69 with SMTP id bg4-20020a05600c3c8400b003b4eff4ab69mr33845695wmb.104.1666359742231;
        Fri, 21 Oct 2022 06:42:22 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id h5-20020adfe985000000b002322bff5b3bsm22966355wrm.54.2022.10.21.06.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 06:42:21 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 21 Oct 2022 15:42:17 +0200
Subject: [PATCH v5 2/3] iommu/mediatek: add support for 6-bit encoded port IDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221001-iommu-support-v5-2-92cdbb83bbb8@baylibre.com>
References: <20221001-iommu-support-v5-0-92cdbb83bbb8@baylibre.com>
In-Reply-To: <20221001-iommu-support-v5-0-92cdbb83bbb8@baylibre.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Alexandre Mergnat <amergnat@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        devicetree@vger.kernel.org, Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        linux-mediatek@lists.infradead.org, iommu@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2703; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=MoEet6B6VXSSp8bcExDnQBc+mSaQhOo/W6ZW7xDSJ1M=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjUqG7pUZ+phrWMxCNEdvxMKQ0eD2JmCEsamlEU4kP
 73CMikiJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY1KhuwAKCRArRkmdfjHURXeBEA
 CApVh33ghEZK+kDfwj5T840sxHThUAsf3eiBpjL4lK8Pmj3DRZTsduYCWyf2JudtZrSX8b7x4piVc+
 0M/3Epe+pSIWd4j4NGxOTTR+lDJ0OD1UtLzA7/wZac3UTaZmN1RHsJPyf9/ML3tAHbnuP/UmJZ5ft9
 9y5KXs0k4/kOAOrnLFz3Ry28vxpxwZXhyjPcr/N89KWiuRJPC+F711PABdvWYncrwi9Rkash/qncwE
 Mq357kSgh0dTZwL7UvAR8O3LsnGlfcSRkrdBvRVIILaIRkUXxHEUZe87qZdUcOITqCb7tQZKO2MoFT
 +WbBIcwCvdjwbFxde8cZvDUaRsq0zpW5Ji3poARdQ0qHR06HE6uoTSs6HmitqpVaM/G8hxwLqfaYdu
 F2VZUhCW5sbI10kp1u+3a9lLQPS9JHCtGRIZJJWWbIy6as7RavrbvC170Vy8v3AFd7EEAK/Lo/IB1Q
 +IDj71IczmLVv1F9Js1tgrM/AyRFyJjqssnZPmKanYUjTOzVbAoqP9tchUzT+zHAN15abowFvkgUdj
 hFQXuhF7tcB7ZUVobsFM3idBwtkTPsPzHhQDJk3HjJU67qGEPSY04rqRE98w09GAQtvTnLU8QtAWIB
 LTU1cZZj0cH7nG3AfqLW4xtMzypnrVmd4vOk38DrxdgK9PZMRUVnkD89klJA==
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
the port ID is encoded as a 6-bit data. This requires to add extra
macro F_MMU_INT_ID_LARB_ID_EXT, and F_MMU_INT_ID_PORT_ID_EXT in order
to support 6-bit encoded port IDs.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/iommu/mtk_iommu.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 5a4e00e4bbbc..563e3c54a0e2 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -108,8 +108,12 @@
 #define F_MMU_INT_ID_SUB_COMM_ID(a)		(((a) >> 7) & 0x3)
 #define F_MMU_INT_ID_COMM_ID_EXT(a)		(((a) >> 10) & 0x7)
 #define F_MMU_INT_ID_SUB_COMM_ID_EXT(a)		(((a) >> 7) & 0x7)
+/* Macro for 5 bits length port ID field (default) */
 #define F_MMU_INT_ID_LARB_ID(a)			(((a) >> 7) & 0x7)
 #define F_MMU_INT_ID_PORT_ID(a)			(((a) >> 2) & 0x1f)
+/* Macro for 6 bits length port ID field */
+#define F_MMU_INT_ID_LARB_ID_WID_6(a)		(((a) >> 8) & 0x7)
+#define F_MMU_INT_ID_PORT_ID_WID_6(a)		(((a) >> 2) & 0x3f)
 
 #define MTK_PROTECT_PA_ALIGN			256
 #define MTK_IOMMU_BANK_SZ			0x1000
@@ -139,6 +143,7 @@
 #define IFA_IOMMU_PCIE_SUPPORT		BIT(16)
 #define PGTABLE_PA_35_EN		BIT(17)
 #define TF_PORT_TO_ADDR_MT8173		BIT(18)
+#define INT_ID_PORT_WIDTH_6		BIT(19)
 
 #define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)	\
 				((((pdata)->flags) & (mask)) == (_x))
@@ -441,14 +446,19 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 	fault_pa |= (u64)pa34_32 << 32;
 
 	if (MTK_IOMMU_IS_TYPE(plat_data, MTK_IOMMU_TYPE_MM)) {
-		fault_port = F_MMU_INT_ID_PORT_ID(regval);
 		if (MTK_IOMMU_HAS_FLAG(plat_data, HAS_SUB_COMM_2BITS)) {
 			fault_larb = F_MMU_INT_ID_COMM_ID(regval);
 			sub_comm = F_MMU_INT_ID_SUB_COMM_ID(regval);
+			fault_port = F_MMU_INT_ID_PORT_ID(regval);
 		} else if (MTK_IOMMU_HAS_FLAG(plat_data, HAS_SUB_COMM_3BITS)) {
 			fault_larb = F_MMU_INT_ID_COMM_ID_EXT(regval);
 			sub_comm = F_MMU_INT_ID_SUB_COMM_ID_EXT(regval);
+			fault_port = F_MMU_INT_ID_PORT_ID(regval);
+		} else if (MTK_IOMMU_HAS_FLAG(plat_data, INT_ID_PORT_WIDTH_6)) {
+			fault_port = F_MMU_INT_ID_PORT_ID_WID_6(regval);
+			fault_larb = F_MMU_INT_ID_LARB_ID_WID_6(regval);
 		} else {
+			fault_port = F_MMU_INT_ID_PORT_ID(regval);
 			fault_larb = F_MMU_INT_ID_LARB_ID(regval);
 		}
 		fault_larb = data->plat_data->larbid_remap[fault_larb][sub_comm];

-- 
b4 0.10.1
