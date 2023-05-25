Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698E67115EF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242901AbjEYSs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242774AbjEYSpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:45:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5E93A85;
        Thu, 25 May 2023 11:41:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D0B460BEC;
        Thu, 25 May 2023 18:40:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D328C4339C;
        Thu, 25 May 2023 18:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685040049;
        bh=W7cDmmMskAmQKOeAEBTMMtSUHQeSM063tf6xjoDLGpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JzdcfOid6x06z3HWw0UZSqWfBnF9mBZniu74xxl/AA4m+Fi4tTfK7j8Rju1STJQQb
         vYZDro03Yp/QrC15CyeSo4/OXpQU/yipCBS/jCbWy8bnbT7Ea4yXooMmJC4qJRa3Gk
         nBnzeIHHfkRX+ShOMU7CJ2151T38XJtCy3BeixHE0M42nY1v4tzWPrNNu02sMpSUbf
         qzXaFz90GIkMVkyz50mAYuyJRLhxJxkbWZy2o8s0xdeBlHTnV7EybcL8pToSlV4xiV
         5DDeoi2mxvwojtAFJdpzRR5N/SGiXC5kLxnv8aRgeYYOJkImK5G93O00A8worZTO06
         HOJYIEimdNJhw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sasha Levin <sashal@kernel.org>, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, airlied@gmail.com, daniel@ffwll.ch,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 39/43] drm/msm: Be more shouty if per-process pgtables aren't working
Date:   Thu, 25 May 2023 14:38:50 -0400
Message-Id: <20230525183854.1855431-39-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183854.1855431-1-sashal@kernel.org>
References: <20230525183854.1855431-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

[ Upstream commit 5c054db54c43a5fcb5cc81012361f5e3fac37637 ]

Otherwise it is not always obvious if a dt or iommu change is causing us
to fall back to global pgtable.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/537359/
Link: https://lore.kernel.org/r/20230516222039.907690-2-robdclark@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_iommu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index a54ed354578b5..ef4da3f0cd22d 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -157,7 +157,12 @@ struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent)
 	/* Get the pagetable configuration from the domain */
 	if (adreno_smmu->cookie)
 		ttbr1_cfg = adreno_smmu->get_ttbr1_cfg(adreno_smmu->cookie);
-	if (!ttbr1_cfg)
+
+	/*
+	 * If you hit this WARN_ONCE() you are probably missing an entry in
+	 * qcom_smmu_impl_of_match[] in arm-smmu-qcom.c
+	 */
+	if (WARN_ONCE(!ttbr1_cfg, "No per-process page tables"))
 		return ERR_PTR(-ENODEV);
 
 	/*
-- 
2.39.2

