Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401255BCB8E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiISMNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiISMNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:13:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299A2AE5A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 05:13:16 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:a78:dc38:d663:4e37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5B26B66019EE;
        Mon, 19 Sep 2022 13:13:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663589593;
        bh=0ExZBX4ZBR0DoaPRlH8a5BMVZUgZpBnkAA1zeufhj+8=;
        h=From:To:Cc:Subject:Date:From;
        b=OXmGJ+jmWQ4GDb8m1enGjTWYIOPeRNAUlDbyt7SMsyXMybTbF9Ef1RF6kXXEoV7Gx
         s/mmhd3q47BpWL7vEO4Wc7nSxVDUWmAq/QdYYp4Vt99/wLlWd8H+iHsnOyV1HHmyQ8
         X0e2d9AR059l7g283E2vr4OPPeH+V9Z+GVmJruOz4FzDANz9uqo3TWz6JI2V7djHXk
         HAJU4rMxQD5dCi3kutGfvY/AeVl4aXGAixc2V5jZzBqqsYUk+eftv4dvF86Se5v9xa
         8/vv2gTGjBO1CetvWHKRqxhWvPhGxSqjghcrEOj7euF6o2RqUHSAjlXFJW0H2SGK5h
         T45ygJcST2dWA==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v3] soc: imx: imx8m-blk-ctrl: Defer probe if 'bus' genpd is not yet ready
Date:   Mon, 19 Sep 2022 14:13:02 +0200
Message-Id: <20220919121302.597993-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
v3:
- only return -EPROBE_DEFER if 'bus' device hasn't be found.

v2:
- keep dev_err_probe only change the return value.

 drivers/soc/imx/imx8m-blk-ctrl.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index dff7529268e4..1c195e9e8895 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -214,9 +214,14 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	bc->bus_power_dev = genpd_dev_pm_attach_by_name(dev, "bus");
-	if (IS_ERR(bc->bus_power_dev))
-		return dev_err_probe(dev, PTR_ERR(bc->bus_power_dev),
-				     "failed to attach power domain \"bus\"\n");
+	if (IS_ERR(bc->bus_power_dev)) {
+		if (PTR_ERR(bc->bus_power_dev) == -ENODEV)
+			return dev_err_probe(dev, -EPROBE_DEFER,
+					     "failed to attach power domain \"bus\"\n");
+		else
+			return dev_err_probe(dev, PTR_ERR(bc->bus_power_dev),
+					     "failed to attach power domain \"bus\"\n");
+	}
 
 	for (i = 0; i < bc_data->num_domains; i++) {
 		const struct imx8m_blk_ctrl_domain_data *data = &bc_data->domains[i];
-- 
2.32.0

