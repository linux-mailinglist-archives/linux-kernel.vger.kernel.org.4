Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D88563B4B7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 23:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbiK1WRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 17:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbiK1WRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 17:17:10 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46781B0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 14:17:09 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id fy37so29379458ejc.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 14:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MAW05hTsf1HLoUuE6p0dl7JsXN+VzBADWa8mNA4Y/hg=;
        b=WYgndSXHj6ddz2fZBKTRfkQUz7mAVIPNr5tWbke7zeNAmyHVSr00rQo+g+e+Ig9n5A
         JOzbV0d2a47ONyXYuQQAWV0o3G/Xj36z25DKdaItmLNy+Y5uL4DyHAMU/ZptFXzbP+dw
         31GQbB905qEFxaQ//SkmSLxRipbbwOTlIuMus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MAW05hTsf1HLoUuE6p0dl7JsXN+VzBADWa8mNA4Y/hg=;
        b=hdFmiUzm2W+4K6G7A4a/sGR+echbFbnTrDKaKb1M6JH2h3lOvwdwneCWTw4jaLxIlM
         jyiwSPw0PIEWq/oggGHvnGHOYeNa5c3Jy4GgxiVPQthctWFl9KA2/4TOcwk4w5Qsx8Qy
         DHrZXZQdnUITucmzspHBn1hN735BuTl5wkQYPJ3bPLRnDhE5rHzhAsP2u7/+t0OAqA1e
         9DRxzL1wVunqC2YuedNHlX9KI/7+Xh2bemFecoIS2nuGx2Rm5RxG0NupUv6QQwFZPEyy
         kTHdzJ1n+pkSy8esjNDENPmNVrk03Z4x/klsQGQA5fFhhWajywB6eVr3CmsUNvO/pUJP
         rZww==
X-Gm-Message-State: ANoB5pmdjXuU9VFfAmw1eMOrbAixKVFZpjbsootaEPj/+PPCzaZD6bmU
        eJYnHFUJQZ8zsav2cFr8+3rpFbXF3iTjJBVV
X-Google-Smtp-Source: AA0mqf70yVrAUhynDk2vdBC4OtVXhma/NfU6NAL0dThRj19AHZrOu6G0CK1mNxqDHN8Pi1Re2p4/zQ==
X-Received: by 2002:a17:907:1a53:b0:7b2:b15e:86e6 with SMTP id mf19-20020a1709071a5300b007b2b15e86e6mr31905059ejc.410.1669673828342;
        Mon, 28 Nov 2022 14:17:08 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id tb20-20020a1709078b9400b007bd0bb6423csm4128949ejc.199.2022.11.28.14.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 14:17:07 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 28 Nov 2022 23:16:48 +0100
Subject: [PATCH v2] iommu/mediatek: Fix crash on isr after kexec()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221125-mtk-iommu-v2-0-e168dff7d43e@chromium.org>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Ricardo Ribalda <ribalda@chromium.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1793; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=dQfj3zCk9LjAmEiLiE9kNq1HaUvEPzI6tySk+CkPJU8=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjhTNSjV2AVUV1u6b3OtHjWp14zbnoC4ycSB7AvQmE
 zAt5+SGJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4UzUgAKCRDRN9E+zzrEiFkEEA
 CmcpMWAeHsCtZuviT/mT8Xq/4lFkFnGzMzPk301P40cSGw5TDuodU0hT7Baqg4lvNhRJRfDvWxiD9n
 /rIYUf+QqQXu3X1v+25hQQSvR4fRE7RWiMWU2ZsqejVK3lAnQm95xXTfzLY+ZgcxA4xhAKw3EPIuEx
 CSYLihg9AXmoalZ1dnpKZ6ELt5euP06KWMOBt1/o3850p9pbM0FWrjjEfGiA6rW4SBaOxdjk/X+0KZ
 i+KF43Csf0UG8EEJz2aXq8M6dmNsXDS+dOsRfo2wTTvVoHWa0JE8NEuFOi4nqIRhdo3ELCunnTpJsX
 h2GN964CSjD0/AvrbCG+SQWNkn1zCBWf1GcSWwlv0twB3I/yfXdC35YGMhoB5CvwbnUStrIx74I/Sk
 1Ue4s9Uhryo5/10c2t2VXUGKy4e61/kKVaBJQvkRF8BzNi3fb8oZ4DPC/3vUDfEDMOCD3F2TUz2R/D
 WZLDMvRxvkH9VeFhP9DzZS/wUTvELN/eoOTb8KRHvH/yT3cDavAOgewI7OyGEkJH8rT7F0V4XWZVCP
 +s90qaTi4Wf7lBj2iT6drIMPiO52Q5lCVa/+jfBypVKIDslS7KJzUZ/dT3ZxL10Y318GJ3iZ/HhUu2
 NUFz2a1Bz/tm/6IAwsoByFTnSTJrNfgXVjh/Gy+5f8IOfOyrAnGjW4m0yIiA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the system is rebooted via isr(), the IRQ handler might be triggerd
before the domain is initialized. Resulting on an invalid memory access
error.

Fix:
[    0.500930] Unable to handle kernel read from unreadable memory at virtual address 0000000000000070
[    0.501166] Call trace:
[    0.501174]  report_iommu_fault+0x28/0xfc
[    0.501180]  mtk_iommu_isr+0x10c/0x1c0

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
To: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: iommu@lists.linux.dev
Cc: linux-mediatek@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
Changes in v2:
- Also print the error message if !dom (Thanks Yong)
- Link to v1: https://lore.kernel.org/r/20221125-mtk-iommu-v1-0-bb5ecac97a28@chromium.org
---
 drivers/iommu/mtk_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 2ab2ecfe01f8..3d913ab5029c 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -454,7 +454,7 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 		fault_larb = data->plat_data->larbid_remap[fault_larb][sub_comm];
 	}
 
-	if (report_iommu_fault(&dom->domain, bank->parent_dev, fault_iova,
+	if (!dom || report_iommu_fault(&dom->domain, bank->parent_dev, fault_iova,
 			       write ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ)) {
 		dev_err_ratelimited(
 			bank->parent_dev,

---
base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
change-id: 20221125-mtk-iommu-13023f971298

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
