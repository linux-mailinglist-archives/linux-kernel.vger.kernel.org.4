Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08F7611AAE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 21:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJ1TMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 15:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiJ1TMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:12:50 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDE422BC86
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 12:12:49 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id f27so15200487eje.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 12:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPukQ/yCudN3mqPZzaxRUNn/wYyZYIm9PajEvh4bGro=;
        b=lFTIh99owmh/k1Uys/CzuTK6ZozjQkmrkSRPYw/izZPPV1+ekj/xUZq+xdZIuzBSEi
         Hu2MNhvE7/5GWe4M8T1ALVbA94OsV/nyapNTmItil0ZsWAVMW/J1VoNCQ0ecUo62zGVe
         bVJb/7j6Y2x7lIr0mbOeB1HEYozSsBjYy+TsN12tYb4CciaQgrovy2v1b9ko7ngZ78Us
         D5Be1E/jXuXPzcUlN8p2PDqXjp7m0sHYU7zrIWZX/sEk0LA1PBInO9VeUD7dojL8YN4x
         WzeLw1IDjKaLdGPuqIh9RcDlMiPGdtrqOCfLZ5N4sPFu2Ky0NG7BCx3gq/ENFOtgAuy4
         /cYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPukQ/yCudN3mqPZzaxRUNn/wYyZYIm9PajEvh4bGro=;
        b=XYkIEQXOVCSh4ZJpY/N5qW5Ybi4aa6rw755BV9h+eRJdYPrtNLR+iE7T4D/Y+R0Fwc
         4yWaXjKgYIajxI/DJK0Wh/wO5JR9ZH1iPFl1aJ2G+v5LeZV7JHK78WJqnwkZfp2aHL8K
         xm8jlIWgi7waeM/CvEa+LKlBGp/QCfFZyBuvBcNwsxlXgio6ylJSb5iMXNFH0o5v2UNG
         EzHnBiqz67wRJZHgeWQFa0GB39QWaTDubfGWpQqh3MQGDP7apowgfnqbp7RnS/7/2W1K
         vAs7Zowt6RTLNmOnZXYLrQL/RQtjDhUxOFXifRAVSGPy9LJIWKPTnlrhabtTEdHawaJO
         4cqQ==
X-Gm-Message-State: ACrzQf2s0B5iogBVEjuRiMPqWoB9fa0qc/akt2flBmRXHt1OSqylDfrs
        s2aAA3mUcH37POgY68OS0ES+RQ==
X-Google-Smtp-Source: AMsMyM735bMRdxnT5KlbKqNEMak3CVb6j1Wqf6v5Pqc4XjxitPVec2Unz2ViivjTEjrkRWNu2Tgclw==
X-Received: by 2002:a17:907:7fac:b0:7a1:cace:1352 with SMTP id qk44-20020a1709077fac00b007a1cace1352mr804100ejc.6.1666984367966;
        Fri, 28 Oct 2022 12:12:47 -0700 (PDT)
Received: from localhost (cgw.msart-bajzova4.ke.cust.o2bs.sk. [90.176.4.227])
        by smtp.gmail.com with ESMTPSA id f1-20020a05640214c100b004623028c594sm3105183edx.49.2022.10.28.12.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 12:12:47 -0700 (PDT)
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
Subject: [PATCH 1/4] iommu: Export iommu_group_default_domain() API
Date:   Fri, 28 Oct 2022 21:12:40 +0200
Message-Id: <20221028191243.31721-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221028191243.31721-1-semen.protsenko@linaro.org>
References: <20221028191243.31721-1-semen.protsenko@linaro.org>
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

iommu_group_default_domain() may be needed for module users. E.g.
exynos-iommu driver is using it right now, and it's going to be
converted to a module soon.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/iommu/iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 65a3b3d886dc..257143116185 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1650,6 +1650,7 @@ struct iommu_domain *iommu_group_default_domain(struct iommu_group *group)
 {
 	return group->default_domain;
 }
+EXPORT_SYMBOL_GPL(iommu_group_default_domain);
 
 static int probe_iommu_group(struct device *dev, void *data)
 {
-- 
2.35.1

