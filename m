Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA76572B22F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 16:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbjFKOEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 10:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbjFKOEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:04:08 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B052C1708
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:03:58 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f738f579ceso25062295e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686492237; x=1689084237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/NKBVXo4bBAQn6pvSuGzwTyD4+3HhpXFgPX4wlW3Ow=;
        b=Rcx8/guuHLX1MaXAYm75m7RkdGEqs8uCZlTz+PFMN+URgML1XH0WliHMzmphRtjqYt
         cUw7RobsEQVa5BYoTnstvw2okHFAQmBZDtzeIrN/7f2for3qRpOh8OxLPc5EExFZWboe
         nNGMEJFKvEPKD7irMPPu/166uMnKsOndU9XVp26u9Pupg+E+ukXn73n3CR80PrNOkuWp
         ROKJ9D/8jMIjT/dU2wnSFCS2aG3/9piB/2p4coS/RXqcrwwf18KhM5wujH5GdAYRklEc
         D/a4AdL9w8SqWnRH9/ukW5DFLO9+JbpM/Qq0drhbpbyGYt69ZQhSkx864oE0f8X0D3VY
         1FQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686492237; x=1689084237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/NKBVXo4bBAQn6pvSuGzwTyD4+3HhpXFgPX4wlW3Ow=;
        b=iwulljPHf9iD+Al+Kvf6UAoO+/J/B9kniY96XHXrTBfRgpxB4Ujop9pneTtzbPigFP
         eLpQyV+Kn9WRfiAfPm03zkK5H3XL1CVbTN9xwwSKdj/nuYLtfm7zTTw8q3jJ0UxN7LuQ
         uDcYbruhDGXWu4zmJfL4tms6n6wqrrXcGQV9W/3zLCpNi2Hlqjl6InWL7VqfZzFLZ2Z2
         EAes9tBxuZ0x6F5vBSr7YldJDpsqhvQVR2ijr0Q+3eLZEZuHsexHEh6reCd7Gw8O1QRA
         Uk4pdr4F/6WPjwBakgk16EV9YugHKZATF+zjtPWaIstXb1B2qITuUO1y2mIA8ndzEy+5
         k/SA==
X-Gm-Message-State: AC+VfDx1rTgijLohs9+4cyWnxyGxz4zY76dXYJgOpyveBZcfptx985+Q
        ozQ9/ukAyHdMNzpaEM/MljgzFK6g/e+MXKvm82Q=
X-Google-Smtp-Source: ACHHUZ4pI7+HJ8N0/mRobLMZDXJ29I0bxUCP1RY4wS6ATuW5hDLQ4F1uRyA+0qZILjFLuZBUL7q6zw==
X-Received: by 2002:a7b:c4d0:0:b0:3f7:376a:ee60 with SMTP id g16-20020a7bc4d0000000b003f7376aee60mr4602636wmk.6.1686492236909;
        Sun, 11 Jun 2023 07:03:56 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c28d100b003f080b2f9f4sm8567222wmd.27.2023.06.11.07.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 07:03:56 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 10/26] nvmem: rockchip-otp: Generalize rockchip_otp_wait_status()
Date:   Sun, 11 Jun 2023 15:03:14 +0100
Message-Id: <20230611140330.154222-11-srinivas.kandagatla@linaro.org>
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

In preparation to support additional Rockchip OTP memory devices with
different register layout, generalize rockchip_otp_wait_status() to
accept a new parameter for specifying the offset of the status register.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Tested-by: Vincent Legoll <vincent.legoll@gmail.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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
2.25.1

