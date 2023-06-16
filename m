Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0FD732EAF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345299AbjFPKeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345222AbjFPKdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:33:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CED959DF;
        Fri, 16 Jun 2023 03:28:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87A2D636A8;
        Fri, 16 Jun 2023 10:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE7BC433CB;
        Fri, 16 Jun 2023 10:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686911295;
        bh=SXumiZ7DSGjqS/QPZdIQChJYL9zob/waop+PFTSxUR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W60VfmbYERBDVL+TavVnaBjxVe5CQQGKsUf+QXSlUHJ+MJqXOPyrW2kRPeSVYb8kF
         dfqmg+blygiJos+imJs7Mt1Inb7F24K+J9rzFtoyT1ZJy38Snk4SMYGIISnzKB/2Of
         LsNDOjJjfzHUIrWEbWAV/YqQubOwyN7/mtGecAmlbvvTkmfP8LpYgSpG+2RoU/Dm8L
         fla4oc2P2URCrbHuMnRNDvYCg4DZ0ilIad8Cz0UB8GALHiLCmPTneVFRyuSB6GS+YJ
         N12+Wc4g0o2lhwjjJ3EVqPs31p9zioTce9HxCymzxxV7SIYA7Z5L3lopwkfmk4eMtv
         UmXnQeu4h2znA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Min Li <lm0963hack@gmail.com>, Andi Shyti <andi.shyti@kernel.org>,
        Inki Dae <inki.dae@samsung.com>,
        Sasha Levin <sashal@kernel.org>, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com, airlied@gmail.com, daniel@ffwll.ch,
        krzysztof.kozlowski@linaro.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 10/14] drm/exynos: fix race condition UAF in exynos_g2d_exec_ioctl
Date:   Fri, 16 Jun 2023 06:27:47 -0400
Message-Id: <20230616102753.673975-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616102753.673975-1-sashal@kernel.org>
References: <20230616102753.673975-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.184
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

From: Min Li <lm0963hack@gmail.com>

[ Upstream commit 48bfd02569f5db49cc033f259e66d57aa6efc9a3 ]

If it is async, runqueue_node is freed in g2d_runqueue_worker on another
worker thread. So in extreme cases, if g2d_runqueue_worker runs first, and
then executes the following if statement, there will be use-after-free.

Signed-off-by: Min Li <lm0963hack@gmail.com>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/exynos/exynos_drm_g2d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
index 967a5cdc120e3..81211a9d9d0a9 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -1332,7 +1332,7 @@ int exynos_g2d_exec_ioctl(struct drm_device *drm_dev, void *data,
 	/* Let the runqueue know that there is work to do. */
 	queue_work(g2d->g2d_workq, &g2d->runqueue_work);
 
-	if (runqueue_node->async)
+	if (req->async)
 		goto out;
 
 	wait_for_completion(&runqueue_node->complete);
-- 
2.39.2

