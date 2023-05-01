Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605386F2D28
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjEADHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbjEADEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 23:04:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05124495;
        Sun, 30 Apr 2023 20:01:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 318DB61710;
        Mon,  1 May 2023 03:01:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E8FC433D2;
        Mon,  1 May 2023 03:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682910079;
        bh=cv8JJGXNWBr26hY0SkfA4Eso+vQuOnX6tOzJprj6XyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ug1c7SKE4is/WPO7z4not0gLK107US9sRbdNr9/rTuPmuzgC9aXzHmXPk+IFoQZlB
         yGNoDBQnasi7+UKYkvTs1IbqQtAGz/v25rxA16d1duM5eNkAlvyN0ErVVmFforA3LQ
         mN34NQ3YMKdnuVoTmQSGvn145JjbzyxENeVGb4874NPZd2ukpPbUHud5LWDdbsuxu+
         n32ZB3Lwama8+vyC3YLxwRL5SzWk6wIboRg1/efLuqhRFMm2M8fByMDBpr00+CdGpS
         3v0E1fNH6WlznD78EyRjuREUQUuvLHVPr5Y0EeZhMaQ3vyWLZF9X7j2k8ZaW7Ksd2P
         5yoko3VYcTAqQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nur Hussein <hussein@unixcat.org>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>, thierry.reding@gmail.com,
        mperttunen@nvidia.com, airlied@gmail.com, daniel@ffwll.ch,
        jonathanh@nvidia.com, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 6.2 24/37] drm/tegra: Avoid potential 32-bit integer overflow
Date:   Sun, 30 Apr 2023 22:59:32 -0400
Message-Id: <20230501025945.3253774-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501025945.3253774-1-sashal@kernel.org>
References: <20230501025945.3253774-1-sashal@kernel.org>
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
index 8af632740673a..77723d5f1d3fd 100644
--- a/drivers/gpu/drm/tegra/sor.c
+++ b/drivers/gpu/drm/tegra/sor.c
@@ -1153,7 +1153,7 @@ static int tegra_sor_compute_config(struct tegra_sor *sor,
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

