Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5786F2F5E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 10:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjEAIoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 04:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbjEAIoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 04:44:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36734171B;
        Mon,  1 May 2023 01:44:21 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C979E660316A;
        Mon,  1 May 2023 09:44:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682930660;
        bh=x9XZQ3uvxTsAewM1Yl0ycP8UKF79G7B1mNgN7RoKnIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VrbFGRRyDt+77pqbitqtY1sN76z1tYvVESWYrVbjH/7Jr48ltiHzsIPYxDXBHw4Za
         Dj60ePX2+kI39jGyjvshxIG18+Rml62ysPMU+2iWLUvjLne7oLCHP8kKmd7DCTzFS+
         MGcHkgjcqPHrtvI+oN39DO/dbHbUbnUNoYs4FrETcewBVab0pC5MM9sB3vb2/ZsRnZ
         yCdqMPJTUhdMXoz3grpOe/zIGGrAHM8M/WsAkWkWzLiyJafZZuEQAhCyLA398MHZda
         PQQrsEbTkxxvC3jbWm+Ov1VrrgFtF8XZ4rF7cRUlR4TqQBXdGvz5ofMgWHZT7Gpdr/
         LxFb7sI1MAS7w==
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
Subject: [PATCH 5/8] nvmem: rockchip-otp: Use devm_reset_control_array_get_exclusive()
Date:   Mon,  1 May 2023 11:43:57 +0300
Message-Id: <20230501084401.765169-6-cristian.ciocaltea@collabora.com>
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

In preparation to support new Rockchip OTP memory devices having
specific reset configurations, switch devm_reset_control_get() to
devm_reset_control_array_get_exclusive().

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/nvmem/rockchip-otp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
index e308dd3b4eb1..b74d98f82ae5 100644
--- a/drivers/nvmem/rockchip-otp.c
+++ b/drivers/nvmem/rockchip-otp.c
@@ -263,7 +263,7 @@ static int rockchip_otp_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	otp->rst = devm_reset_control_get(dev, "phy");
+	otp->rst = devm_reset_control_array_get_exclusive(dev);
 	if (IS_ERR(otp->rst))
 		return PTR_ERR(otp->rst);
 
-- 
2.40.0

