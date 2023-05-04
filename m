Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775696F7735
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjEDUjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjEDUjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:39:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCED23497;
        Thu,  4 May 2023 13:33:26 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4CC666605703;
        Thu,  4 May 2023 21:07:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683230837;
        bh=sZ9X6bpnej/8y+Ig3kRI3R+kapqR1qQMI4PAr0MewPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RjM/umzakZN6doBk0Zcy2pHpfbP7qBGgH/xGzFbZVLvF+wJmAqz0v/f74TD3x6nM7
         rnWzAqcMsuX5Jjv9dcbnyiqyea+Kk8Z6qvFvkgzF0GUKDG67LnzR30CmnVCxKcp7DS
         S68hhm8aY6nHcj+E8JNOmHpjDWn8oh3vrY7Nk3WBIrwb8H6LkzO5rR74F1W0Utrvbq
         UbbU3ZTt0Yv99fIuvtW0oYsh0axsR68pf7GgzwWir5QruHNGNGo3raGQTeCo+JRUSw
         BXHp9hKKrSDXvFSfJuUufiMOn8DDwvzs2xsKsTSrxgieomCXpuaTWxi+GR0bQHsH0K
         AUD2lksxSKpJA==
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
Subject: [PATCH v2 7/8] nvmem: rockchip-otp: Add support for RK3588
Date:   Thu,  4 May 2023 23:06:47 +0300
Message-Id: <20230504200648.1119866-8-cristian.ciocaltea@collabora.com>
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

Add support for the OTP memory device found on the Rockchip RK3588 SoC.

While here, remove the unnecessary 'void *' casts in the OF device ID
table.

Co-developed-by: Finley Xiao <finley.xiao@rock-chips.com>
Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Tested-by: Vincent Legoll <vincent.legoll@gmail.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/nvmem/rockchip-otp.c | 78 +++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
index 84bf956cc4e1..cb9aa5428350 100644
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
 	const char * const *clks;
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
+	"otp", "apb_pclk", "phy", "arb",
+};
+
+static const struct rockchip_data rk3588_data = {
+	.size = 0x400,
+	.clks = rk3588_otp_clocks,
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

