Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECAF732EAA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345219AbjFPKeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345208AbjFPKdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:33:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DAD59D5;
        Fri, 16 Jun 2023 03:28:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65BCA63655;
        Fri, 16 Jun 2023 10:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801D5C433D9;
        Fri, 16 Jun 2023 10:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686911262;
        bh=XFn1afc3CoB5JTiXT23yatsipLgYi74pLHBf8rgy/9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iQqH9zeGv/b/+G9mbyR1e03jCagrCIr7p1JqlWuKpgi/HQD0+QEprpiXOMvuS8LCI
         GK9MThOY53OnWcw/QYLMvsovlYMmexxpQYLjbz3YaFvpr9NCQ00FJhOCU6PGBJaNeP
         yKiPUqhRDKntEw33umG5ZJmwMNI+8png9D60bTMsuSG5hgmNEGoiTji8AkBFE7Aiqn
         NJ7lzvGpIh95EV5Uopke+DTM8/nt9bH7ZWo4ZvBOpWh7pwMvZXbQZ86If2Y1fQN7fR
         aIvcYMEfsCVyrxdBny3qq9ahN4psfXp+Av7CZaWpyX/A+j2g3JP70GoE65PuElkIvT
         nEnktgQCqV2xg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Inki Dae <inki.dae@samsung.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Sasha Levin <sashal@kernel.org>, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com, airlied@gmail.com, daniel@ffwll.ch,
        krzysztof.kozlowski@linaro.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 10/16] drm/exynos: vidi: fix a wrong error return
Date:   Fri, 16 Jun 2023 06:27:13 -0400
Message-Id: <20230616102721.673775-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616102721.673775-1-sashal@kernel.org>
References: <20230616102721.673775-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.117
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Inki Dae <inki.dae@samsung.com>

[ Upstream commit 4a059559809fd1ddbf16f847c4d2237309c08edf ]

Fix a wrong error return by dropping an error return.

When vidi driver is remvoed, if ctx->raw_edid isn't same as fake_edid_info
then only what we have to is to free ctx->raw_edid so that driver removing
can work correctly - it's not an error case.

Signed-off-by: Inki Dae <inki.dae@samsung.com>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/exynos/exynos_drm_vidi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index e5662bdcbbde3..e96436e11a36c 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -468,8 +468,6 @@ static int vidi_remove(struct platform_device *pdev)
 	if (ctx->raw_edid != (struct edid *)fake_edid_info) {
 		kfree(ctx->raw_edid);
 		ctx->raw_edid = NULL;
-
-		return -EINVAL;
 	}
 
 	component_del(&pdev->dev, &vidi_component_ops);
-- 
2.39.2

