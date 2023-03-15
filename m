Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1F06BB8FB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjCOQDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjCOQD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:03:28 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20044AFFB;
        Wed, 15 Mar 2023 09:02:56 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id y12so6383534ilq.4;
        Wed, 15 Mar 2023 09:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678896175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ezi8oNC2pf7LWaqlTmOz5LE1KTRmUQ4OdTaGPWRRLc=;
        b=L/plJVhS43n3cjFazUgrq1EMvu6ckndESaagQLNKwXMfsosWlroo/vHn4kjimtWPAL
         YpRqO8edvNx1iBMbnRnr7xOvzxr7Hoj48wNFBosNkoge8PGK48/QdTr70x0J4cTIDw0V
         uOeIM2d+70dMSXRkMNFw1XyN/1Dlc22v0BckQtfn36z1Ejt6SjbeCphABoyk4Iygu/XO
         GqLeW4JvSI1qO2v0eXNc7F6hMVpzS96KsF5t+1AE86COOkzxguOcrGJXM1mbWTQ35lCY
         dEBK73E7pogDFLq0A9qlIMLKSq6+rJ8afhL9BJ7B9C0WVPvTE+7uWC3GNmn7afLX/sy2
         shTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678896175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ezi8oNC2pf7LWaqlTmOz5LE1KTRmUQ4OdTaGPWRRLc=;
        b=K1AXbIE6/0Sm0AFUPrFNsgxbWvSIcXoiz279U2fXamQMnUPeA7REMeUV4bTdAZwqS9
         j1LvkRbMrXo+iO0AOcoVu9hVG5DF72/Obe252bldXF2V7OysusWUzD+gBFD3vpSRIPXb
         tuBA+N3bI9v7Sy+oTEfzTK3M/WbdesXuckVIB+60EYbkHFVU+rbeOAE2z36V0IrHokNM
         7Hn3Y40tO7pHuen7WQJNyEUc3IrVF5Oi2ilXQBn8jtLTcHOt8+DbAcDt78ybEhXVZ7C5
         ypjb0x5QaFTQhx3NUwZ+TMiSaQNHS4czdJ/x6lk0goZg0XVwuU4m+ALROm03gp+xqqJK
         yu0g==
X-Gm-Message-State: AO0yUKU9F7nUCGyz9+nMQDi7sI/FYlSEMIfQ4K62Q8x4HZzb+RDk+HNi
        iKsr6MKlmFLZ3edgn9NAFjE=
X-Google-Smtp-Source: AK7set/RF/anczqhdjGZbAL1DrAPHGeX4qH+SRdNWCa9qWA1YsnlFw27MVqFj8qagCF2j+uAfhWtGw==
X-Received: by 2002:a92:908:0:b0:318:6d32:b12a with SMTP id y8-20020a920908000000b003186d32b12amr5215890ilg.13.1678896175062;
        Wed, 15 Mar 2023 09:02:55 -0700 (PDT)
Received: from localhost.localdomain (tunnel785484-pt.tunnel.tserv9.chi1.ipv6.he.net. [2001:470:1f10:aed::2])
        by smtp.googlemail.com with ESMTPSA id l2-20020a92d942000000b00313fa733bcasm1730725ilq.25.2023.03.15.09.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 09:02:54 -0700 (PDT)
From:   Tianling Shen <cnsztl@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Peter Geis <pgwipeout@gmail.com>, Andy Yan <andyshrk@163.com>,
        Tianling Shen <cnsztl@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Andrew Powers-Holmes <aholmes@omnom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] dt-bindings: Add doc for FriendlyARM NanoPi R5C
Date:   Thu, 16 Mar 2023 00:02:25 +0800
Message-Id: <20230315160228.2362-3-cnsztl@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230315160228.2362-1-cnsztl@gmail.com>
References: <20230315160228.2362-1-cnsztl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding documentation for the FriendlyARM NanoPi R5C.

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 5474cb4a13d1..d9105e609c27 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -201,9 +201,11 @@ properties:
               - friendlyarm,nanopi-r4s-enterprise
           - const: rockchip,rk3399
 
-      - description: FriendlyElec NanoPi R5S board
+      - description: FriendlyElec NanoPi R5 series board
         items:
-          - const: friendlyarm,nanopi-r5s
+          - enum:
+              - friendlyarm,nanopi-r5c
+              - friendlyarm,nanopi-r5s
           - const: rockchip,rk3568
 
       - description: GeekBuying GeekBox
-- 
2.17.1

