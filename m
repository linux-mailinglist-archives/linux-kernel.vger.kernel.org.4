Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848006B215C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjCIK0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjCIK01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:26:27 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E0361A9F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:26:24 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8B9EF6603023;
        Thu,  9 Mar 2023 10:26:22 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678357582;
        bh=nkvko6i3DR/+q3uywCjPVyZkbTw5ZbNySmFdON0XhIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kAh8CahGTq3xAWE5qrqzyRqFX7H8WuXeEHEzCOobzTFrNRMdPwTOBHF9nFv3BGOkd
         dyJRW4TaMbfJsunc7TWAF+1QWKS08UCVvjMjg2bpkLa+pCv7MiZhXH0QGQZCEeN3nA
         mZ0Rvq3RgHnae/VEiroT7FzrNz1REl4XEylfVj4PfsbN+69P7ruaPlN1dPQDukRWwd
         YAsHqQhcMqXU/osI6nzleZwAItNmQECuajSqk75RqwiEioawSmM9nnVLqZlYRasmAp
         qBC39G6BY2mv0dlh+i3puHers3mkzsP/BffXdCMi8a/C16a0sOA3LQdDJ9KcySyi7/
         hMpVMDfAcdCnw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH 2/3] soc: mediatek: mtk-mmsys: Change MT8173 num_resets to 64
Date:   Thu,  9 Mar 2023 11:26:17 +0100
Message-Id: <20230309102618.114157-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309102618.114157-1-angelogioacchino.delregno@collabora.com>
References: <20230309102618.114157-1-angelogioacchino.delregno@collabora.com>
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

The MT8173 SoC has 64 MMSYS resets, split in two contiguous 32-bits
registers, MMSYS_SW0_RST_B (0x140) and MMSYS_SW1_RST_B (0x144), as
also stated in the downstream kernel for the Amazon Fire TV 2
(Sloane) in the ddp_reg.h header.

Please note that managing more than 32 reset bits is supported since commit
2004f8be8483 ("soc: mediatek: mmsys: add mmsys for support 64 reset bits")

This commit brings no functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-mmsys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index d5844aff0621..c4eeab99756b 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -56,7 +56,7 @@ static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
 	.routes = mt8173_mmsys_routing_table,
 	.num_routes = ARRAY_SIZE(mt8173_mmsys_routing_table),
 	.sw0_rst_offset = MT8183_MMSYS_SW0_RST_B,
-	.num_resets = 32,
+	.num_resets = 64,
 };
 
 static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
-- 
2.39.2

