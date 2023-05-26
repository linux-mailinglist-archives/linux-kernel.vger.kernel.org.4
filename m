Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A297122C1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 10:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242826AbjEZIyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 04:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242674AbjEZIyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 04:54:15 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D3099
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 01:54:14 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64d604cc0aaso572072b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 01:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685091253; x=1687683253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5E1O6F8XFMIurLCllD6JGMVmsuqHQFoAO58kkivfIrk=;
        b=UnwWb9DC2h863iCSINm0c8593AEcbSTqSTS0nIydcAQxy4ijGiC1l8g3dq3zHEueQa
         mvKy8j9rxBeD0sO+ZHFGrNtQ0nKiEHGf8VE+zNkFwoOREZKXTqlYsGRWB11GiqxGbDaR
         Kw33o3SFcqbx6F4JAKf54w+CVZiNXn9MFDrCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685091253; x=1687683253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5E1O6F8XFMIurLCllD6JGMVmsuqHQFoAO58kkivfIrk=;
        b=alrDMTKk1fgnE7G2RIh1mV9HzZKo8dwPDcdDVos3P87MRVTXgBbx+Qp59AB1z6KWgH
         wKbieN5a/A8+gzRsi0PlADBveyiaVsg9cgeH/+bdPF1qmKEY8SelqdmSqLaTpWcs8z/T
         e63VdelVu5LZCZeOmYgXJZDL+AiHjh3/2Xifaq6E63P4UiSauHZTo5DOdpuGtvkFuoNR
         EhowiZ2egxWI2HpqgPG3zy4WP2i8x96KCR3CvSHLHfBVBaJS6KRw1M79x63hzhJI4hYE
         i7YmQe4tlXViEOLq5FMDXNeImpX2d6KT0mshXLAGEMNrp7XpIjPAbODynff9GfS25mEz
         kKmA==
X-Gm-Message-State: AC+VfDzsANDZmv9qs2NIqQaTyzwPau/z5/qe/g6sh95MsuYeGJRlmWWr
        Fh2DIRsO7uzf7dDX0WZjXsxphg==
X-Google-Smtp-Source: ACHHUZ6j1OCMp+SsbHSsvJ+n1AMIMl1mA9tSeKDh1T6ew63dCD88XS43sI5XhoaDF57pLVfUrA6m4Q==
X-Received: by 2002:a05:6a00:218e:b0:64d:3227:b806 with SMTP id h14-20020a056a00218e00b0064d3227b806mr2748121pfi.33.1685091253571;
        Fri, 26 May 2023 01:54:13 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:17b9:e0b5:a956:4510])
        by smtp.gmail.com with ESMTPSA id l14-20020a62be0e000000b006460751222asm2344166pff.38.2023.05.26.01.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 01:54:13 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, iommu@lists.linux.dev,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC] iommu/mediatek: Flush IOTLB completely only if domain has been attached
Date:   Fri, 26 May 2023 16:53:59 +0800
Message-ID: <20230526085402.394239-1-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an IOMMU domain was never attached, it lacks any linkage to the
actual IOMMU hardware. Attempting to do flush_iotlb_all() on it will
result in a NULL pointer dereference. This seems to happen after the
recent IOMMU core rework in v6.4-rc1.

    Unable to handle kernel read from unreadable memory at virtual address 0000000000000018
    Call trace:
     mtk_iommu_flush_iotlb_all+0x20/0x80
     iommu_create_device_direct_mappings.part.0+0x13c/0x230
     iommu_setup_default_domain+0x29c/0x4d0
     iommu_probe_device+0x12c/0x190
     of_iommu_configure+0x140/0x208
     of_dma_configure_id+0x19c/0x3c0
     platform_dma_configure+0x38/0x88
     really_probe+0x78/0x2c0

Check if the "bank" field has been filled in before actually attempting
the IOTLB flush to avoid it. The IOTLB is also flushed when the device
comes out of runtime suspend, so it should have a clean initial state.

Fixes: 08500c43d4f7 ("iommu/mediatek: Adjust the structure")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---

I think this is a valid fix, but I'm not very familiar with the hardware
or the design of the driver. The ARM SMMU drivers seem to do this as well.

 drivers/iommu/mtk_iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index aecc7d154f28..e93906d6e112 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -781,7 +781,8 @@ static void mtk_iommu_flush_iotlb_all(struct iommu_domain *domain)
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 
-	mtk_iommu_tlb_flush_all(dom->bank->parent_data);
+	if (dom->bank)
+		mtk_iommu_tlb_flush_all(dom->bank->parent_data);
 }
 
 static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
-- 
2.41.0.rc0.172.g3f132b7071-goog

