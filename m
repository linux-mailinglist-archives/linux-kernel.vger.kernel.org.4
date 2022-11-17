Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F3B62DAEA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240139AbiKQMbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239831AbiKQMbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:31:33 -0500
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092A17721A;
        Thu, 17 Nov 2022 04:30:21 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 8FF3518640DD;
        Thu, 17 Nov 2022 15:30:18 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 3Wyc6Ar0RLbD; Thu, 17 Nov 2022 15:30:18 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 3589018640D7;
        Thu, 17 Nov 2022 15:30:18 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ynNIvwKRm9Iv; Thu, 17 Nov 2022 15:30:18 +0300 (MSK)
Received: from rbta-msk-lt-106062.DL (unknown [37.1.14.128])
        by mail.astralinux.ru (Postfix) with ESMTPSA id 832A71863D1F;
        Thu, 17 Nov 2022 15:30:17 +0300 (MSK)
From:   Anastasia Belova <abelova@astralinux.ru>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Anastasia Belova <abelova@astralinux.ru>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Teppei Kamijou <teppei.kamijou.yb@renesas.com>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>,
        Chris Ball <cjb@laptop.org>,
        linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE
        DIGITAL (SD) AND...), linux-kernel@vger.kernel.org (open list),
        lvc-project@linuxtesting.org
Subject: [PATCH] mmc: sh_mmcif: Add check for NULL for host->chan_yx and host->chan_rx in sh_mmcif_end_cmd
Date:   Thu, 17 Nov 2022 15:30:07 +0300
Message-Id: <20221117123007.13071-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without these checks NULL-pointer may be dereferenced in
sh_mmcif_end_cmd parameters inside if (data->flags & MMC_DATA_READ).

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: eae309836509 ("mmc: sh_mmcif: Terminate DMA transactions when dete=
cting timeout or error")
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 drivers/mmc/host/sh_mmcif.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 0fd4c9d644dd..f35694acafcc 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1136,14 +1136,17 @@ static bool sh_mmcif_end_cmd(struct sh_mmcif_host=
 *host)
 	time =3D wait_for_completion_interruptible_timeout(&host->dma_complete,
 							 host->timeout);
=20
-	if (data->flags & MMC_DATA_READ)
-		dma_unmap_sg(host->chan_rx->device->dev,
-			     data->sg, data->sg_len,
-			     DMA_FROM_DEVICE);
-	else
-		dma_unmap_sg(host->chan_tx->device->dev,
-			     data->sg, data->sg_len,
-			     DMA_TO_DEVICE);
+	if (data->flags & MMC_DATA_READ) {
+		if (host->chan_rx)
+			sh_mmcif_end_cmd(host->chan_rx->device->dev,
+					data->sg, data->sg_len,
+					DMA_FROM_DEVICE);
+	} else {
+		if (host->chan_tx)
+			dma_unmap_sg(host->chan_tx->device->dev,
+					data->sg, data->sg_len,
+					DMA_TO_DEVICE);
+	}
=20
 	if (host->sd_error) {
 		dev_err(host->mmc->parent,
--=20
2.30.2

