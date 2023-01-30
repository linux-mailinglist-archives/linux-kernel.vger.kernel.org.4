Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A525F680AC0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 11:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbjA3K0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 05:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236282AbjA3K0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:26:42 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB5918AB6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:26:37 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o18so1082123wrj.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a1sabGNp0i0jnpvKtDcfkVpINZEUTfpEqzCGhBjXqIw=;
        b=TGbOhzz/rPG3jSJFwXwz9IARb5DEJa0LNKqqAhM8Or6IuR3iLbqSOj9ah3EQaWUZv3
         QtpJDEd/CQRktCQqVLtB4vMZaVkaUSlj+f5413ziTkTbsZUGJC4difgipU7P2mnJ841b
         zG1f6EeK7NeiAN/BqZVB1ON0FvRmlPDDVE9eVMZVPoBM9CLB5O5dIyX2rQeA6GAJEwJ6
         16CHJhQItoI+eKYhP7OGYNAFW1GMAdm5Dtrr41T9yxgdjS3/MmzxF9LWlc0xEXyuXtgP
         cmZDGJRW7Ap0j75DnTuemaHRy5l01XZKOCvIULOdnHGtgMI/vE9fKap6yzNcupMNxijc
         Q35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a1sabGNp0i0jnpvKtDcfkVpINZEUTfpEqzCGhBjXqIw=;
        b=uCwZ3mlyjNV6ROwqbbNYjVyIU3um57C1QYxFj7QK22oLbfxQxD5PLsgicoJnKdf+px
         U0ZDckHpzEI+WPDkAFwskDeTclAWHVJSkeGIPkyCUb5pmRDiJH41JEye/5/mJdS/7EZr
         rftUiAuWVUR5zlF2sYskUEX4xKTGDRqBV2zBLf1u4dEytz9x+Y4zzQH1w/7kBdmWKaEq
         pFEQ3aSgRyQQUY5fSlKb7IXdeyAP7QBp48bY4yOhBNF0Z6VR5jKniDVmeb0vqCr4+Wxd
         Ahriv0XslYSA0eWm85fYaj+Vvr4Ak9yrLqISCSa+hrtb+MEuPkibMd8wjYDp4976XPCA
         Q4Cg==
X-Gm-Message-State: AFqh2kpOkXwdrXDCdR3o8k+Ztv15EFRxuzwqjMFv3ja8wOAeZ9fvI9mQ
        bFQ/PZ6f4G/qVf3I+aKoWypSIQ==
X-Google-Smtp-Source: AMrXdXusnxR1vGulnY9qOYGIrAj2fP/mpLLBdaOBnAzh7KNVOon1ShfM7VQfgnYhs0CrTstGHVq8UA==
X-Received: by 2002:a5d:6e8b:0:b0:2bd:d9b5:8191 with SMTP id k11-20020a5d6e8b000000b002bdd9b58191mr42677507wrz.61.1675074396348;
        Mon, 30 Jan 2023 02:26:36 -0800 (PST)
Received: from alex-T14.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s5-20020a5d5105000000b002bdfcd8c77csm11426785wrt.101.2023.01.30.02.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 02:26:35 -0800 (PST)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     yong.wu@mediatek.com, joro@8bytes.org, will@kernel.org
Cc:     robin.murphy@arm.com, matthias.bgg@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH 0/3] Add support of unmanaged domain to mediatek IOMMU
Date:   Mon, 30 Jan 2023 11:27:19 +0100
Message-Id: <20230130102722.133271-1-abailon@baylibre.com>
X-Mailer: git-send-email 2.38.2
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

Mediatek mt8365 SoC APU support (AI Processor Unit) is being upstremed.
This device, behind an IOMMU uses remoteproc which requires unmanaged domain.
This updates the iommu driver to support unmanaged iommu domain and let
remoteproc use the IOMMU.

Alexandre Bailon (3):
  dt-bindings: memory: mediatek: Add support of unmanaged iommu domain
  iommu: mediatek: Add support of unmanaged iommu domain
  dt-bindings: iommu: memory: Use unmanaged iommu domain for the APU

 drivers/iommu/mtk_iommu.c                              | 6 ++++++
 include/dt-bindings/memory/mediatek,mt8365-larb-port.h | 4 ++--
 include/dt-bindings/memory/mtk-memory-port.h           | 3 +++
 3 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.38.2

