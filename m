Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA018674141
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 19:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjASSuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 13:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjASSti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:49:38 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771D78BA9C;
        Thu, 19 Jan 2023 10:49:34 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id d30so4540162lfv.8;
        Thu, 19 Jan 2023 10:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFat64LMoXDYuRBJ5PYrBQ4w2KeQw9mnd+EpUQW2z98=;
        b=Smx7EiRZr0YFLFdiLbw9CGyQYH5KkwXlCnXcJXZVaw24v8CD2LwOklq3XKkYwQAf9L
         4eceQvdoqisR5BsqY9Ne3XFyEVzhktoK4W/68XSZYFHdGLZlAuP2Yb1ICYtV7eJK7Adz
         zxbeQvDMm29TiPJ7ZMbEkCf1RcLeoAs9R0kW14sbx/5rjqSlbR9zaCirDouEDdg2GW6L
         IOXdzIfg7p33PhAn9eJ9Ng3jwa/UjdU7ZKKQMMAbBJ7dkWKPIU+4tC48u1SY81+chX2P
         rICN1Q5mgGAe8s9KP/ZO1ptMg8lGTGO3bdeqMenCmrgnlP/OjSkN/XVw1JqCouw7Kshw
         QV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFat64LMoXDYuRBJ5PYrBQ4w2KeQw9mnd+EpUQW2z98=;
        b=qXTWCe+tg5HLPPXLElE5BtQi1nci4mjM9Ek/BFp5yJRoVgakaYSL1GD+1GpqeYPTOu
         HMFZIjxKQlQmZjfiyWB2qdmrXvumR9Vwxua6iSHklHPy+kKS9ilvKfHISEdgN/g6K3By
         BvSUs3Wv1PdbYLf+zCfLFxccw3Iix58XYVh/qBbSqW+aE2qP9zgoJejhR5UCefAf8sq+
         ig20S88eBLkGWu3WMUYmghlzLGo2p5f23vui+wY6n2afdKtR87d0hQxXet2VLayoS3Qp
         iNMnEYPr18B9YM61co1aNKBdZoTX2BODU/2FbFtaFURiNO7clNV4gzx2O2hZi8rmpiMe
         RyBw==
X-Gm-Message-State: AFqh2kqWOqG8ux8c5AG7SDzmwywXT8GnDkoLKmojnQslqXBvvQFyMzJA
        tWRuTIwAg/RVq1pC46cZu/s=
X-Google-Smtp-Source: AMrXdXsS73pkCKlic27wdJ6t/u2GF8WN5cOENCK0syWt1LSQd2eWuZ+/51FXuUHtnDJ3XgjSGs8C2Q==
X-Received: by 2002:a05:6512:2529:b0:4d2:9f92:a145 with SMTP id be41-20020a056512252900b004d29f92a145mr7462574lfb.50.1674154172862;
        Thu, 19 Jan 2023 10:49:32 -0800 (PST)
Received: from U19.ag.local (static.187.76.181.135.clients.your-server.de. [135.181.76.187])
        by smtp.gmail.com with ESMTPSA id b31-20020a0565120b9f00b004d30752a561sm2112737lfv.298.2023.01.19.10.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 10:49:32 -0800 (PST)
From:   Alibek Omarov <a1ba.omarov@gmail.com>
Cc:     a1ba.omarov@gmail.com, alexander.sverdlin@siemens.com,
        macromorgan@hotmail.com, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Peter Geis <pgwipeout@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alex Bee <knaerzche@gmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dt-bindings: display: rockchip-lvds: add compatible string for RK3568
Date:   Thu, 19 Jan 2023 21:48:05 +0300
Message-Id: <20230119184807.171132-4-a1ba.omarov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230119184807.171132-1-a1ba.omarov@gmail.com>
References: <20230119184807.171132-1-a1ba.omarov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RK3568 SoCs have a single LVDS output, that use PHY shared by two display
pipelines: LVDS and MIPI DSI.

Signed-off-by: Alibek Omarov <a1ba.omarov@gmail.com>
---
 .../devicetree/bindings/display/rockchip/rockchip-lvds.txt       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt
index aaf8c44cf90f..ec8a8d05368a 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt
@@ -5,6 +5,7 @@ Required properties:
 - compatible: matching the soc type, one of
 	- "rockchip,rk3288-lvds";
 	- "rockchip,px30-lvds";
+	- "rockchip,rk3568-lvds";
 
 - reg: physical base address of the controller and length
 	of memory mapped region.
-- 
2.34.1

