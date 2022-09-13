Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EF45B6B80
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiIMKSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiIMKSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:18:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9F74E845
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:18:01 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [89.101.193.68])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DC5C5660201B;
        Tue, 13 Sep 2022 11:17:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663064279;
        bh=29Z10RWsq7AW0UfkNaeIMYvdC/rNzF3b8Jgmnnt3IdM=;
        h=From:To:Cc:Subject:Date:From;
        b=UPafAOeD4+ZAZWrJAlMsutTfyXIvZZ8dsUyIw0mD0nFHBq2FIrIvcmzrEL6KkOCox
         NJwr2LoXKCtMwP0hnmaNE7fCu3bm0jH2hMjQdL7zwI7X9Ja8NrRnq96Fpy4v06VbMf
         MyKyEhhFXvkJvxHl08aJZxZVzKFuyyZimvQxrzalRrdU+M7hPfT6ZgzS+7Vdm/MlVj
         aNw20q69y+3KkpGaFeDM8bzspN4NSrqJCaZEbMSQYkx9iMXrkWKa2MYVN2KajcSUR6
         Cggw2QVZFlljH2IcvDGDCRXwxGenl6KtEohOcYXjY/S0Xe9FtPhWB8FUMQE2D90wzQ
         L6Rk8ZVQEcNBQ==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v2] soc: imx: imx8m-blk-ctrl: Defer probe if 'bus' genpd is not yet ready
Date:   Tue, 13 Sep 2022 12:17:47 +0200
Message-Id: <20220913101747.60891-1-benjamin.gaignard@collabora.com>
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
v2:
- keep dev_err_probe only change the return value
 
 drivers/soc/imx/imx8m-blk-ctrl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index dff7529268e4..253d08de8923 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -215,9 +215,10 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 
 	bc->bus_power_dev = genpd_dev_pm_attach_by_name(dev, "bus");
 	if (IS_ERR(bc->bus_power_dev))
-		return dev_err_probe(dev, PTR_ERR(bc->bus_power_dev),
+		return dev_err_probe(dev, -EPROBE_DEFER,
 				     "failed to attach power domain \"bus\"\n");
 
+
 	for (i = 0; i < bc_data->num_domains; i++) {
 		const struct imx8m_blk_ctrl_domain_data *data = &bc_data->domains[i];
 		struct imx8m_blk_ctrl_domain *domain = &bc->domains[i];
-- 
2.32.0

