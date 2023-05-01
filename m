Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0F36F2E20
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbjEADUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbjEADQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 23:16:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF9B46BE;
        Sun, 30 Apr 2023 20:07:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A205561889;
        Mon,  1 May 2023 03:06:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24AAC433D2;
        Mon,  1 May 2023 03:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682910406;
        bh=BR4psieaLe5m1WiFLrB14WfFWXXRVLIaoIjw3D6ekk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nk2hiPwv0x7FFOAopa09Q4jGRqoNa8FcTnvt9czAzUqIgJU57b9N1aqUCDrWvWW94
         iFjZN5bUTFvbyOhhjBgRDlL6V8qMTZSMPFes36ssMnhhq0d5fDgBshwkK4Wf3E/AW7
         CJB+2fodCY+UPJNgEmACKm6Wr64CyiJ2+hpmwBtHfJhayvgWbN54Pccnf+TyGL8G/X
         g5YnGQpgjSyxLuYNjNuNbHHvMnSGyAtl9f23OQ7m6M/4eiP79970aqFuIx8vRZljNQ
         bAaSs73hey8Sl6DFXfrISl+uMZ1C4c60EneMZKZ88BNWiLMoAiCZF1zSYOF72JESkH
         +7IzTIPRJ9xMw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nur Hussein <hussein@unixcat.org>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>, thierry.reding@gmail.com,
        mperttunen@nvidia.com, airlied@gmail.com, daniel@ffwll.ch,
        jonathanh@nvidia.com, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 6/9] drm/tegra: Avoid potential 32-bit integer overflow
Date:   Sun, 30 Apr 2023 23:06:28 -0400
Message-Id: <20230501030633.3255202-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501030633.3255202-1-sashal@kernel.org>
References: <20230501030633.3255202-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nur Hussein <hussein@unixcat.org>

[ Upstream commit 2429b3c529da29d4277d519bd66d034842dcd70c ]

In tegra_sor_compute_config(), the 32-bit value mode->clock is
multiplied by 1000, and assigned to the u64 variable pclk. We can avoid
a potential 32-bit integer overflow by casting mode->clock to u64 before
we do the arithmetic and assignment.

Signed-off-by: Nur Hussein <hussein@unixcat.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tegra/sor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
index 83108e2430501..adc191ec26a99 100644
--- a/drivers/gpu/drm/tegra/sor.c
+++ b/drivers/gpu/drm/tegra/sor.c
@@ -829,7 +829,7 @@ static int tegra_sor_compute_config(struct tegra_sor *sor,
 				    struct drm_dp_link *link)
 {
 	const u64 f = 100000, link_rate = link->rate * 1000;
-	const u64 pclk = mode->clock * 1000;
+	const u64 pclk = (u64)mode->clock * 1000;
 	u64 input, output, watermark, num;
 	struct tegra_sor_params params;
 	u32 num_syms_per_line;
-- 
2.39.2

