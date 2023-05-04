Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C426F7744
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjEDUka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjEDUjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:39:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9D65FD7;
        Thu,  4 May 2023 13:34:45 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 276456605702;
        Thu,  4 May 2023 21:07:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683230831;
        bh=QY6rnLRfHC9dXg+8BbD6mqIP1zCqEQmwLS6ENTx+qfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RvDTFACjzeBm2rFU3uAOCw0rcmWMiAd63/IZOt7IK0hz6Le+EGcutL7FByoUkeHs0
         6CWhe6rEu6J7uOFsM1i8tw1CtSr/Y9suiwYkbSU/aufYh9mgIU0ShLaG6y/mwY0sTp
         Kk6Cddb4XkKWjnb7VCFU5HSAkZMlntS4niDuVptBabPCm1df1uswkR2zP7mywvidV6
         a9TAl6Dx/jbxn4tlbRqJiZI8i1i1tFdTWfwnbGcoMFyCicJ8Dv1UjIfz+cTi+ti/b0
         1DAuwK9hU2VN4rIgVmHhtL+IsAJXMTc7or2W3l3/KMVkkYN5lUUn4qHCtfZJYqkKnp
         jhl/+eKKSEqYQ==
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
Subject: [PATCH v2 5/8] nvmem: rockchip-otp: Use devm_reset_control_array_get_exclusive()
Date:   Thu,  4 May 2023 23:06:45 +0300
Message-Id: <20230504200648.1119866-6-cristian.ciocaltea@collabora.com>
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

In preparation to support new Rockchip OTP memory devices having
specific reset configurations, switch devm_reset_control_get() to
devm_reset_control_array_get_exclusive().

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Tested-by: Vincent Legoll <vincent.legoll@gmail.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/nvmem/rockchip-otp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
index b62e001f9116..439aea1f8874 100644
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

