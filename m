Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F266F2F5C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 10:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbjEAIoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 04:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbjEAIoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 04:44:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836C8E7A;
        Mon,  1 May 2023 01:44:17 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 415B16602F6A;
        Mon,  1 May 2023 09:44:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682930656;
        bh=ZmCzaqB0Ylzg7HWMRjjmRxOmRNTg2+5slMJcMqm5f6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d1YFnRqU2NXyvNPxFtU+B4cH0+o7q5oe9isAwzP7ExBDZR0Itb2A7oFB0Eyy5tFNL
         YU1BihI9sYxK2yHEPU24oB3gfHcoXqynHmCirbreZzU9wRczVxs0z4YvokBGvAHnDd
         GPgHGdmbIitnMCvs1s+zBJ+/CAYAFjvD0sOM4G2TPa+m0cWwHxQydOrmQ0YrA9qFjj
         eLwmtoXdjlbRZTnnc1zYZqW4ojTxyDdMG/RlYyAsy5+3Io3RFggqtKYBwoBfAeM3bQ
         +KaZo9etZNsf4UsqpPiuzrwXaFLNYN5u+g00qCMpeJCjHMpQhVohoEHGmkv+UldU3q
         vUN1ZoJRr9Nsw==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH 4/8] nvmem: rockchip-otp: Generalize rockchip_otp_wait_status()
Date:   Mon,  1 May 2023 11:43:56 +0300
Message-Id: <20230501084401.765169-5-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230501084401.765169-1-cristian.ciocaltea@collabora.com>
References: <20230501084401.765169-1-cristian.ciocaltea@collabora.com>
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

In preparation to support additional Rockchip OTP memory devices with
different register layout, generalize rockchip_otp_wait_status() to
accept a new parameter for specifying the offset of the status register.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/nvmem/rockchip-otp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
index a5b234e60735..e308dd3b4eb1 100644
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

