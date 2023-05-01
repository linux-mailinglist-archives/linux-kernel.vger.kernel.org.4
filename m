Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524B76F2F62
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 10:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjEAIo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 04:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjEAIom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 04:44:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A381BCB;
        Mon,  1 May 2023 01:44:28 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0841C660316A;
        Mon,  1 May 2023 09:44:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682930666;
        bh=9fCkdJIhomNHjg/BSj98OPViI3ZhU3YXyHQVh8Ob45w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BZVj6tyYWbTCLZL7F8tEBQ6EnB5bFziJVZlhJK8CISd/7uX0pSGgEzzj/XMy2KBD2
         /QvfGWkiTQIN9GcJeTzTNbkbEwwW5KMr6QCUYE1XaOER2cXEE1xi4rQDPHgwRxNHFx
         IfoPqi4/vh6r1B3+0rBo/xeR/UBb+SrH4XYPHQR/9ZTtW+lNa7zTYhz30TD8eTxvMM
         cYq0U05aDr2s4tOLtIZ6oZ0T58e/1WJXVG2zboG4rcHgV04iXmzny8TnknR3OR1ffZ
         KxTTfVGvoT8NovSNUSYieUIHtpyA0W5sDc7Ky7nrHZVvhBxZcI9HVw3f+mZUwykkX/
         cUT3J0K8LRwKQ==
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
Subject: [PATCH 7/8] nvmem: rockchip-otp: Add support for RK3588
Date:   Mon,  1 May 2023 11:43:59 +0300
Message-Id: <20230501084401.765169-8-cristian.ciocaltea@collabora.com>
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

Add support for the OTP memory device found on the Rockchip RK3588 SoC.

While here, remove the unnecessary 'void *' casts in the OF device ID
table.

Co-developed-by: Finley Xiao <finley.xiao@rock-chips.com>
Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/nvmem/rockchip-otp.c | 78 +++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
index 4370d6c5e4e9..022691cadf94 100644
--- a/drivers/nvmem/rockchip-otp.c
+++ b/drivers/nvmem/rockchip-otp.c
@@ -54,6 +54,19 @@
 
 #define OTPC_TIMEOUT			10000
 
+/* RK3588 Register */
+#define RK3588_OTPC_AUTO_CTRL		0x04
+#define RK3588_OTPC_AUTO_EN		0x08
+#define RK3588_OTPC_INT_ST		0x84
+#define RK3588_OTPC_DOUT0		0x20
+#define RK3588_NO_SECURE_OFFSET		0x300
+#define RK3588_NBYTES			4
+#define RK3588_BURST_NUM		1
+#define RK3588_BURST_SHIFT		8
+#define RK3588_ADDR_SHIFT		16
+#define RK3588_AUTO_EN			BIT(0)
+#define RK3588_RD_DONE			BIT(1)
+
 struct rockchip_data {
 	int size;
 	const char * const *clocks;
@@ -171,6 +184,52 @@ static int px30_otp_read(void *context, unsigned int offset,
 	return ret;
 }
 
+static int rk3588_otp_read(void *context, unsigned int offset,
+			   void *val, size_t bytes)
+{
+	struct rockchip_otp *otp = context;
+	unsigned int addr_start, addr_end, addr_len;
+	int ret, i = 0;
+	u32 data;
+	u8 *buf;
+
+	addr_start = round_down(offset, RK3588_NBYTES) / RK3588_NBYTES;
+	addr_end = round_up(offset + bytes, RK3588_NBYTES) / RK3588_NBYTES;
+	addr_len = addr_end - addr_start;
+	addr_start += RK3588_NO_SECURE_OFFSET;
+
+	buf = kzalloc(array_size(addr_len, RK3588_NBYTES), GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	while (addr_len--) {
+		writel((addr_start << RK3588_ADDR_SHIFT) |
+		       (RK3588_BURST_NUM << RK3588_BURST_SHIFT),
+		       otp->base + RK3588_OTPC_AUTO_CTRL);
+		writel(RK3588_AUTO_EN, otp->base + RK3588_OTPC_AUTO_EN);
+
+		ret = rockchip_otp_wait_status(otp, RK3588_OTPC_INT_ST,
+					       RK3588_RD_DONE);
+		if (ret < 0) {
+			dev_err(otp->dev, "timeout during read setup\n");
+			goto read_end;
+		}
+
+		data = readl(otp->base + RK3588_OTPC_DOUT0);
+		memcpy(&buf[i], &data, RK3588_NBYTES);
+
+		i += RK3588_NBYTES;
+		addr_start++;
+	}
+
+	memcpy(val, buf + offset % RK3588_NBYTES, bytes);
+
+read_end:
+	kfree(buf);
+
+	return ret;
+}
+
 static int rockchip_otp_read(void *context, unsigned int offset,
 			     void *val, size_t bytes)
 {
@@ -213,14 +272,29 @@ static const struct rockchip_data px30_data = {
 	.reg_read = px30_otp_read,
 };
 
+static const char * const rk3588_otp_clocks[] = {
+	"otpc", "apb", "arb", "phy",
+};
+
+static const struct rockchip_data rk3588_data = {
+	.size = 0x400,
+	.clocks = rk3588_otp_clocks,
+	.num_clks = ARRAY_SIZE(rk3588_otp_clocks),
+	.reg_read = rk3588_otp_read,
+};
+
 static const struct of_device_id rockchip_otp_match[] = {
 	{
 		.compatible = "rockchip,px30-otp",
-		.data = (void *)&px30_data,
+		.data = &px30_data,
 	},
 	{
 		.compatible = "rockchip,rk3308-otp",
-		.data = (void *)&px30_data,
+		.data = &px30_data,
+	},
+	{
+		.compatible = "rockchip,rk3588-otp",
+		.data = &rk3588_data,
 	},
 	{ /* sentinel */ },
 };
-- 
2.40.0

