Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DA36F2C6F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjEADAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbjEAC7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 22:59:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D754F1BD4;
        Sun, 30 Apr 2023 19:58:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2EF660E9E;
        Mon,  1 May 2023 02:57:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA0CC4339B;
        Mon,  1 May 2023 02:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682909879;
        bh=Vu0+qWqefyWhMzSESBgfYJzPeVchKVsuZgJb+f4X4Z8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LFj1930RxJJ+02gvE3QlyOc7gtlzKOK0uwWOElk816ihKdy81OzlM/ZAlDIdai5mZ
         ZsDOz+NFewAuExD4rBa8nqS7GaQB6njiYuwq1kRsTuTgytVoIWljJTU4P1YHTFoCRY
         TaWnSwmk38tRflVzWgIIbDUADielGyG4qWJKdmeWUOoHbT6BtUwns+WMO/AsgrS8aK
         R3aNqymW2XSUoPgI5DRGkNhqPPix55Qc1oqnqeI5I4hooWQ4la4eGrrUeM1GEtw8Bq
         eRrr/31oKgi53RCnwTIM2wKwpnjQWbSnCPclLQLhvruJEWpw5YhRkr8mpbN1lqcmMP
         4pldsAyh8MEZg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Toby Chen <tobyc@nvidia.com>, Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>, hjc@rock-chips.com,
        airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 6.3 19/44] drm/rockchip: dw_hdmi: cleanup drm encoder during unbind
Date:   Sun, 30 Apr 2023 22:56:07 -0400
Message-Id: <20230501025632.3253067-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501025632.3253067-1-sashal@kernel.org>
References: <20230501025632.3253067-1-sashal@kernel.org>
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

From: Toby Chen <tobyc@nvidia.com>

[ Upstream commit b5af48eedcb53491c02ded55d5991e03d6da6dbf ]

This fixes a use-after-free crash during rmmod.

The DRM encoder is embedded inside the larger rockchip_hdmi,
which is allocated with the component. The component memory
gets freed before the main drm device is destroyed. Fix it
by running encoder cleanup before tearing down its container.

Signed-off-by: Toby Chen <tobyc@nvidia.com>
[moved encoder cleanup above clk_disable, similar to bind-error-path]
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20230317005126.496-1-tobyc@nvidia.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 2f4b8f64cbad3..ae857bf8bd624 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -640,6 +640,7 @@ static void dw_hdmi_rockchip_unbind(struct device *dev, struct device *master,
 	struct rockchip_hdmi *hdmi = dev_get_drvdata(dev);
 
 	dw_hdmi_unbind(hdmi->hdmi);
+	drm_encoder_cleanup(&hdmi->encoder.encoder);
 	clk_disable_unprepare(hdmi->ref_clk);
 
 	regulator_disable(hdmi->avdd_1v8);
-- 
2.39.2

