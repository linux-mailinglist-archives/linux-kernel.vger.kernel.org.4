Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D6D638E3D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 17:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiKYQ2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 11:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKYQ2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 11:28:21 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FED517427
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 08:28:20 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id cw8so1311745ejb.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 08:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FPfIcZ7oMFAWMErNOiDjIKAKPnIKu22VqMpx37ofk00=;
        b=aUwGVuMXyJgJCAsCUvWy3cRAnZdydVYshWa7vdWjNxFdJlX17LHfBZidw2jPsd6Ias
         rDsTEWcavVDqxeeofCi6uvNO79qiGVFMmDKKrrMomr8desXQAn9S2PY5T+eVfdHMFi/h
         8ty+kGBPgvn7HF22ZOAAZA0P+oYT/20dD8t9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FPfIcZ7oMFAWMErNOiDjIKAKPnIKu22VqMpx37ofk00=;
        b=sOnUkjkfwmE0Te6n6aBEazVGAGBQ8sV/BRz0J1Nlz51kL/n8LIHO2xYZ+1fHyFmQzx
         VQdhFmVwRmeeWp1wFOOSEsR4ZOZIH8GtWtrtBKap6SL8HMDJgkwTdIwEZk+9uewqYKwc
         9hVvxEII6vHBfRSDBSyD9fJI6/mo3jEy/JGa1GdXIiZyBR8qSXtmnp1hEbUrLcvrBtET
         jPsFx9Rlm0MqgkGg2nMB63ghgI+SVs1VNVTdv2DJPRXKjPzLzsg/vNnbX4dqCjoYleE8
         sU33ZZLsNMqSNCb4T0Qlk3s+qEyjSmCDqyLxnDMZU1WHr92m65JQJUWb4CjmYG9/RSU3
         CLmg==
X-Gm-Message-State: ANoB5pkWI5VEJUkeQzxltFGwuaKzd7nibpK9AJVyDd/WxPci2wBk1/ul
        ry83ziPFqwu7zb/nDXZCULw9XOzKdP6q2FCp
X-Google-Smtp-Source: AA0mqf5CoPt+3iMGVdMS5sptppyW5DW0OMpWoLkAdjvxpFJYpZ18xIoomWaaxApwBWBj+x5ZfUfApg==
X-Received: by 2002:a17:906:d8db:b0:7ba:8633:7f7b with SMTP id re27-20020a170906d8db00b007ba86337f7bmr9893641ejb.206.1669393699000;
        Fri, 25 Nov 2022 08:28:19 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id ud10-20020a170907c60a00b007b29eb8a4dbsm1771589ejc.13.2022.11.25.08.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 08:28:18 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 25 Nov 2022 17:28:10 +0100
Subject: [PATCH] iommu/mediatek: Fix crash on isr after kexec()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221125-mtk-iommu-v1-0-bb5ecac97a28@chromium.org>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-mediatek@lists.infradead.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1626; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=yRsx62PHekdowYwa/Kc+JnAl1OMT11qcvF/UlUuv6e0=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjgO0e3Iz3uM3saXvlJTwcfd3xV9teD31lx/tBsCaA
 +GKjJmCJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4DtHgAKCRDRN9E+zzrEiJyVD/
 4m5rgQ65+VT7WWI6q1UJaIcmFMXSC9WDSpsxRNyMBz6BZRl8DFMhNassgGM7Yjvs/dpX2vSLlc65qv
 GiFTZaTAvqIk5J8IS7wIrf4/vfknf9EVix8AUcFguYeK8FlPNWbxWWVPtum55vKSQS1a86HOlOtmAt
 0JWGTzVCkSPmG9whMr37fwsQmcXd1U22IoxKYKxlTDsW43eplAc8+YCXlGUw/jIRf6VSD2jyCC6q1s
 VPPdqFmFrVvYPnvPj9x2JYrSyJxgATgup+ik22/syCK/2Gfm/q6Q+F3i9D5SlOi9UceYAkazZgGTQ4
 9DU0HQ4BfNJxEdEHEeiAwMuFuA4ghfTigyEgD/U2gIt2mVnaI0+ja67va3TFrqfFjX4viTps6fQDRO
 ysS39413twJwmd2jmq9jSUAMgv7dJJnpAAwajU5EO5Ll7Jiefj982V5jwuHIEv+2UfNBcNcNy4hHpC
 rT4CPllsoZC40ASm16E4LEQ8k957AN9mCXoSOAaFpM9xoKhtwIOthkoXW5QRWPjB1iYsAYfiMo3GDb
 vpyigsb2GbfNvCV7+oZmpcrnWBBqBG/Oiohf4LIsBsuI+3HWAZMIKAT2sYpW9BrpXoPvD7qKWefC9f
 VT9oitp2Ge/qjpxG1RCS3QoszdeRwAsmwGWTzh2I0RFE5HJUvMUQaTOzdYLg==
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
 drivers/iommu/mtk_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 2ab2ecfe01f8..17f6be5a5097 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -454,7 +454,7 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 		fault_larb = data->plat_data->larbid_remap[fault_larb][sub_comm];
 	}
 
-	if (report_iommu_fault(&dom->domain, bank->parent_dev, fault_iova,
+	if (dom && report_iommu_fault(&dom->domain, bank->parent_dev, fault_iova,
 			       write ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ)) {
 		dev_err_ratelimited(
 			bank->parent_dev,

---
base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
change-id: 20221125-mtk-iommu-13023f971298

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
