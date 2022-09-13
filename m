Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3A25B6A48
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbiIMJHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiIMJHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:07:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A515509B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:07:18 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [89.101.193.68])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0E94F6602006;
        Tue, 13 Sep 2022 10:07:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663060037;
        bh=4FYzYAq78L/H37k97U6Zxjw0N7leWulRRE9rHyIP+b0=;
        h=From:To:Cc:Subject:Date:From;
        b=g6ExAZPeFs9W5nvE3hrCzpUx1HHIy/t6o+Mp/Q7InLnxuQMPVNqFYaQoa/mVuP2CO
         J7zrBoPvNwO1owzSNOMhRcuDns6vf/Ao7Ipqqo8zDfh/O30dqmlrbLA/O7DNXvzlIG
         iWFULEMLF1kDf6sEqq2QG9E/W3dIfQWqbkNlL6zo2BuRAKUSXChDZ4lGyJU+0838Ad
         NdJ0FFhl6iOfu4HZFvcP3wtnbrHySA0YoLSk/dxR3BZFL1yjDveMzC25zJRaqteoBg
         Bg2sSYM18gS1nO2CHtpmPQrE5m2bB5n2nK/TqnsKt7/GA7Vyv3+dmJ8jOdAPWNqb/T
         Z1gCg+qHVwoRA==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH] soc: imx: imx8m-blk-ctrl: Defer probe if 'bus' genpd is not yet ready
Date:   Tue, 13 Sep 2022 11:06:55 +0200
Message-Id: <20220913090655.39778-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending of the boot sequence 'bus' genpd could be probed after imx8m-blk-ctrl
which led driver probe to fail. Change the returned error to allow
to defer the probe in this case.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/soc/imx/imx8m-blk-ctrl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index dff7529268e4..99f5226a465b 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -215,8 +215,7 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 
 	bc->bus_power_dev = genpd_dev_pm_attach_by_name(dev, "bus");
 	if (IS_ERR(bc->bus_power_dev))
-		return dev_err_probe(dev, PTR_ERR(bc->bus_power_dev),
-				     "failed to attach power domain \"bus\"\n");
+		return -EPROBE_DEFER;
 
 	for (i = 0; i < bc_data->num_domains; i++) {
 		const struct imx8m_blk_ctrl_domain_data *data = &bc_data->domains[i];
-- 
2.32.0

