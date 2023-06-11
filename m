Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236B272B233
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 16:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbjFKOFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 10:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbjFKOEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:04:33 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B54210C
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:04:03 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f6e1393f13so24968795e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686492241; x=1689084241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eAfucaCV2o24HzyudEWTZ4yFqPF9x8yujUzoQbLFp8=;
        b=wEQivJZApWNBHK7qtEC57YnEQg2qLtTGLneD1L32jIF4BAicXn5dUdhOFKwieipuWX
         mFYGyd31M4C9JMGuJdIPYY9kme0sPDxPyBF+gDrER88fkatXqdJibWEhJfBBN5eLwtDw
         YSdNRaJgdfYC9FDCOVwZrLRfo+/6OhuXePxGlp/uQoH502j4UqTMMq00ATBPKo2ONjtT
         3VFukMfMO2hAHzIF7Uny6G2mfxhYaZTXFgD+EjBW8BU6VyJxXDH0YDB19CLkBGxa4b6+
         d+wHARJrrIfjPfgNbV/VFdTzFlNDRrGez86GWIxVEMs+8KxJrvqdxouyClucEucAIO2H
         6DYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686492241; x=1689084241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+eAfucaCV2o24HzyudEWTZ4yFqPF9x8yujUzoQbLFp8=;
        b=Q/pSfBcmNUfDEk4dXAl3WZh/6mMKNDMz9EtRT7A7QFM6IXVq77wu8W2grce+yLL00o
         fT7Qx+DnrEWybsHTVgvA5oIrnYn6+f/W8Z9+Smwdu540eRHpc0uIoHxJXgYgUC/g2fID
         PcN0avjooagVkCURqPSfjdBtQRx760ZepJGHIkj2nAp09/TLjZZc02IfacrH8itaze3M
         2cylPIKjmpeLHmr9ThbDfBh8RydegtA7l+cVtNedpRi6f2rbsrNVCVrX+dQgxIO90yEX
         p24s+hx8u7k/ZD6+uvR3iVNb5ebrTTyLfdFmANHydyIxxLfSqhVgo4RLnPDJLfXVl/PQ
         Y/RQ==
X-Gm-Message-State: AC+VfDxmA9Vi6P4xNrIzEkAGW04wTWAMiixa7Z8FzaG2uZp8iBZcfrOz
        u26aZzhCgnOY6KXu6Czw8/bRgw==
X-Google-Smtp-Source: ACHHUZ7xhCs0PLx3X3jsrOhy9V/YHojF4kU4dsX+3uU5us7z6v1qBy7V5RYvnqJrYMDJXQxfIyfl8w==
X-Received: by 2002:a7b:c8da:0:b0:3f7:e8fc:678d with SMTP id f26-20020a7bc8da000000b003f7e8fc678dmr4914215wml.13.1686492241496;
        Sun, 11 Jun 2023 07:04:01 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c28d100b003f080b2f9f4sm8567222wmd.27.2023.06.11.07.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 07:04:00 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 13/26] nvmem: rockchip-otp: Add support for RK3588
Date:   Sun, 11 Jun 2023 15:03:17 +0100
Message-Id: <20230611140330.154222-14-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
References: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Add support for the OTP memory device found on the Rockchip RK3588 SoC.

While here, remove the unnecessary 'void *' casts in the OF device ID
table.

Co-developed-by: Finley Xiao <finley.xiao@rock-chips.com>
Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Tested-by: Vincent Legoll <vincent.legoll@gmail.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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
2.25.1

