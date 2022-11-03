Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899016188EF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 20:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiKCTwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 15:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKCTv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 15:51:58 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C68220183
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 12:51:57 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id y14so8136689ejd.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 12:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dSoY1RFfLiYGbG6PVIWaPMns1WQq6G1mUH0o4v3ezJs=;
        b=jXb0goUM1eMoI1vo0YE498npOwxh/JsIH3dtk03GixxejFSVByMt5Dl6Oj9UpEy2W9
         Pf8lK5SE9nKJLqX7fqqHjAKN4x8cTWoBC/ZO7NmVESWXWlgiku667ugCRTUlki6fNW62
         4aJsr84+PNy515JKoqpLImWu/5xN8FtmAHgQKjqLtggAsm39S7frbEXGlFG59qD144CR
         7+lrhEeKGAsBbKo5uOUH426MhT6SnUzT2vBvRxhCUrKOJtrcUrJovRbrtKy0VNuT5kOS
         Jfw13SRy0c7DWpiQN9LurfnyRJQXmhFBacMlSISHuC7N78xKzzX9rDrxxcNd6dhhmr1g
         DxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dSoY1RFfLiYGbG6PVIWaPMns1WQq6G1mUH0o4v3ezJs=;
        b=ftD9xsf/226yVzZjpDTI8/JHvyWnY1mAwTupOevLEujqTJB8EMRurpv4q1PrJtmIs+
         C4EBEFImq3EssTNXlo0Nyjir7gCUwZwtO0S/MNX8Gi28zQlF8s8HVyePJb3pr2JLDeav
         s4kfh+KXSL5rJ+BjTpWou5NkNqkbJtglB/qycND7sWxKsmS9kAbsTskBnOiyAy7YGx+I
         z4FokjchsroJBZGfCtBmWIDCJnoH30qTfS0d142Sctrv+nEUskb+TttVLVVb78zdjPXS
         OiK/W4DxBDKDwTOsHjmDvESmbqylG5J7nvywjbcMydzE+ZSormsQkmgKcbYyevJJrKNR
         pJtg==
X-Gm-Message-State: ACrzQf3eXaMn/xaJ8aM+cWh8smwLf19kipe3JONFl9qWIUkdNFDpWbm5
        B988BSsd6VPssnP9BdYe5z3Awg==
X-Google-Smtp-Source: AMsMyM7oHxP/WKbsDall/gZqsAjIooBN50fjNtXMSu/4PKkO5F+CS5IHBjfjNr2w+TaIs3Ggwoj52g==
X-Received: by 2002:a17:906:730d:b0:78e:9ca5:3269 with SMTP id di13-20020a170906730d00b0078e9ca53269mr31172648ejc.366.1667505115999;
        Thu, 03 Nov 2022 12:51:55 -0700 (PDT)
Received: from localhost (cgw.msart-bajzova4.ke.cust.o2bs.sk. [90.176.4.227])
        by smtp.gmail.com with ESMTPSA id j14-20020a1709062a0e00b007415f8ffcbbsm870386eje.98.2022.11.03.12.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:51:55 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        David Virag <virag.david003@gmail.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 0/6] iommu/exynos: Convert to a module
Date:   Thu,  3 Nov 2022 20:51:48 +0100
Message-Id: <20221103195154.21495-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.35.1
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

As exynos-iommu driver is not a critical platform driver, it can be
converted to a loadable module to avoid loading it on non-Exynos
platforms in order to improve the RAM footprint. This patch series
converts it to a module and does some related cleanups. IOMMU/DMA
specifics were taken into the account, so remove/exit methods weren't
added.

There are two drivers using CONFIG_EXYNOS_IOMMU in their code:
DRM_EXYNOS and S5P_MFC. Both were checked, and only a slight change was
needed for S5P_MFC driver (patch #6).

Changes in v2:
  - Extracted the "shutdown" method addition into a separate patch
  - Added MODULE_DEVICE_TABLE(of, ...) to support hot-plug loading
  - Added MODULE_ALIAS("platform:exynos-sysmmu")
  - Added fix for S5P_MFC driver to work correctly with EXYNOS_IOMMU=m
  - Fixed checkpatch coding style suggestion with "--strict" flag
  - Rebased on top of most recent joro/iommu.git:next

Sam Protsenko (6):
  iommu: Export iommu_group_default_domain() API
  iommu/exynos: Fix retval on getting clocks in probe
  iommu/exynos: Modularize the driver
  iommu/exynos: Implement shutdown driver method
  iommu/exynos: Rearrange the platform driver code
  media: platform: Use IS_ENABLED() to check EXYNOS_IOMMU in s5p_mfc

 drivers/iommu/Kconfig                         |   2 +-
 drivers/iommu/exynos-iommu.c                  | 355 +++++++++---------
 drivers/iommu/iommu.c                         |   1 +
 .../platform/samsung/s5p-mfc/s5p_mfc_iommu.h  |   4 +-
 4 files changed, 191 insertions(+), 171 deletions(-)

-- 
2.35.1

