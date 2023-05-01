Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EEC6F2D77
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjEADMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbjEADKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 23:10:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCDD26A5;
        Sun, 30 Apr 2023 20:04:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DD4C61029;
        Mon,  1 May 2023 03:03:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB978C433D2;
        Mon,  1 May 2023 03:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682910222;
        bh=cv8JJGXNWBr26hY0SkfA4Eso+vQuOnX6tOzJprj6XyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SlYlSkWGcAZedzaH4az8/BIXMITaWtgg5rU2tp3Iu9hgoLsjtr54yPdtSO9930lu6
         HPb8QBjHWTXdnOZtav+JQ3C4q/Tt19QXRxO6JyDMJVAzeCeI4GF62dGFJo4uxn10Vi
         rTCt3iji4F6juaot+5AQ2GpL59TtH8dCRVEhum60BjAh5t79ovaXjEa4vWvTMLVX6t
         gxcOh74qAuxFMrFIOcSZQOCogUnJyBU4cPDQCPkIRSWw7G067kILgPAd8DntkPg1MT
         aNPAUO+NFcgzpLlifuaSZErxCiW8iFXgKjZIRquJvfH6llVcoMYX7Pl2xC1zRDIZNz
         nI3S/h3YWbwUw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nur Hussein <hussein@unixcat.org>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>, thierry.reding@gmail.com,
        mperttunen@nvidia.com, airlied@gmail.com, daniel@ffwll.ch,
        jonathanh@nvidia.com, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 21/33] drm/tegra: Avoid potential 32-bit integer overflow
Date:   Sun, 30 Apr 2023 23:02:15 -0400
Message-Id: <20230501030227.3254266-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501030227.3254266-1-sashal@kernel.org>
References: <20230501030227.3254266-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

