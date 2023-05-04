Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241286F7743
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjEDUk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjEDUjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:39:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE9D1A1CD;
        Thu,  4 May 2023 13:34:44 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3779B6605701;
        Thu,  4 May 2023 21:07:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683230828;
        bh=tj5wNFVQXlsB8/T7XkM5lV9GRsAs+861QXowj8ll4qg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D5fUQzDh9jZEt4W5d0V5VZwBtc1VqHnMitIS+KkO9iiZxxrcKpyyR/dEow0nnuQmj
         ISR0vIw7Lpk+hC0hNaUF+F+TfDHc3foG3jBzfdDdd1i8Fn2yGfKkJ0PhdBdKT+qvkw
         Oufm+hnUZBbqTuWAuNosAZpMfaTQwjeH/ROcbcTKNyIPueZdoiPIBJjxPK4qo+t+bA
         c6BOWprlQYeRoy9piCHGnilDSN56RoG4Gd3v4DrFxfSq7E8ZU8SoBwipsE4VPgh+HS
         8hHd8rnHCLq9tA6IglAWi95kjzn/Xk5aEidcK1G95V/m1PYysQzNn5F2ovUp++aemm
         Wm0SJVgQ/8BZg==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Vincent Legoll <vincent.legoll@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v2 4/8] nvmem: rockchip-otp: Generalize rockchip_otp_wait_status()
Date:   Thu,  4 May 2023 23:06:44 +0300
Message-Id: <20230504200648.1119866-5-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230504200648.1119866-1-cristian.ciocaltea@collabora.com>
References: <20230504200648.1119866-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to support additional Rockchip OTP memory devices with
different register layout, generalize rockchip_otp_wait_status() to
accept a new parameter for specifying the offset of the status register.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Tested-by: Vincent Legoll <vincent.legoll@gmail.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/nvmem/rockchip-otp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
index b5a84b379da4..b62e001f9116 100644
--- a/drivers/nvmem/rockchip-otp.c
+++ b/drivers/nvmem/rockchip-otp.c
@@ -90,18 +90,19 @@ static int rockchip_otp_reset(struct rockchip_otp *otp)
 	return 0;
 }
 
-static int rockchip_otp_wait_status(struct rockchip_otp *otp, u32 flag)
+static int rockchip_otp_wait_status(struct rockchip_otp *otp,
+				    unsigned int reg, u32 flag)
 {
 	u32 status = 0;
 	int ret;
 
-	ret = readl_poll_timeout_atomic(otp->base + OTPC_INT_STATUS, status,
+	ret = readl_poll_timeout_atomic(otp->base + reg, status,
 					(status & flag), 1, OTPC_TIMEOUT);
 	if (ret)
 		return ret;
 
 	/* clean int status */
-	writel(flag, otp->base + OTPC_INT_STATUS);
+	writel(flag, otp->base + reg);
 
 	return 0;
 }
@@ -123,7 +124,7 @@ static int rockchip_otp_ecc_enable(struct rockchip_otp *otp, bool enable)
 
 	writel(SBPI_ENABLE_MASK | SBPI_ENABLE, otp->base + OTPC_SBPI_CTRL);
 
-	ret = rockchip_otp_wait_status(otp, OTPC_SBPI_DONE);
+	ret = rockchip_otp_wait_status(otp, OTPC_INT_STATUS, OTPC_SBPI_DONE);
 	if (ret < 0)
 		dev_err(otp->dev, "timeout during ecc_enable\n");
 
@@ -156,7 +157,7 @@ static int px30_otp_read(void *context, unsigned int offset,
 		       otp->base + OTPC_USER_ADDR);
 		writel(OTPC_USER_FSM_ENABLE | OTPC_USER_FSM_ENABLE_MASK,
 		       otp->base + OTPC_USER_ENABLE);
-		ret = rockchip_otp_wait_status(otp, OTPC_USER_DONE);
+		ret = rockchip_otp_wait_status(otp, OTPC_INT_STATUS, OTPC_USER_DONE);
 		if (ret < 0) {
 			dev_err(otp->dev, "timeout during read setup\n");
 			goto read_end;
-- 
2.40.0

