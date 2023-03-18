Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085CC6BF90D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 09:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjCRIiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 04:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjCRIiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 04:38:04 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F3BAFBA9;
        Sat, 18 Mar 2023 01:37:52 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id k17so3334834iob.1;
        Sat, 18 Mar 2023 01:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679128672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CUtzOx/VBQ65j6QlMGz++TFyPeFXZKVfsxJDvvHEMQ=;
        b=i0CifFNBS5TxrTOLSglL+vQ02NWG+AU7/XIfBYUXJ3buFVDtp8pgxvrqYV0jA77ZT/
         GdQXs67r74+33QxQPumVaCEg+WNt9tUOB/2Zyw8xg3wuUk5wagwYlqG63gnlMYIqrfSe
         2QXDO0VO5pO2oSuB4jCrjeQgH+4ty96Cbx2ztP/3IfHQrbB05iYDUB0JGyOdVYn1Yusd
         k13VRaMW8ud1by2fcvNPUPyTsnRjWZuVyrkZIYAe9GRm+CqQColAKEUIvYEalgKCPlcv
         sK+dvAlTZOg6K3ANBiYkSQ/4IhqHXoW0tGIPYr+5LpTuL615nqFJwb7AzTJ0cb7gnu35
         IHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679128672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CUtzOx/VBQ65j6QlMGz++TFyPeFXZKVfsxJDvvHEMQ=;
        b=VqFgZgb7PrvKYZW5iJeZR9jm1q0mTsJiXTgUe3tVJLv4lU4r/Q9HCjl5uBPy+rpUF+
         gDoFfKUI5SiJ/gimHm9aKWG6WgBbhtsBj88+9a7SMjnInSkBiYbB5EhWDw/zTS9TtDRh
         EZn9GmTRNeX6q6oSVnEcLVnTSSlQbtgV8akZUMRetU88ptOBxhfeCtFd0dFhXQwS6VqL
         lkPyo+BsgdQ3zIGCk6oC5uCKXTAy29YLVRUfzS40NTwwjp8skYzA38PvIDMQBb1/B9Is
         GvZncMiMBAxTUKytAPLxLB1UoFdX3z2P0Bl/asWrDLv4xfgjhwnVjZYg430zHX9ZPqB1
         RK4w==
X-Gm-Message-State: AO0yUKVt4f27izfzvzvaTin3A73kRpw7RnjAtYUiZ2Dzu/bF9lIp0br5
        DRajuNuQErmF74PGR4nd6Kc=
X-Google-Smtp-Source: AK7set/o4k5rbkIH2PJDc7znIIlGm+BwsedMSah7q0ths7ZKm9QTN8mKEya/a2eKqpSX6sqQ+xOEuw==
X-Received: by 2002:a5d:9c52:0:b0:74c:8b56:42bb with SMTP id 18-20020a5d9c52000000b0074c8b5642bbmr835123iof.8.1679128671773;
        Sat, 18 Mar 2023 01:37:51 -0700 (PDT)
Received: from localhost.localdomain (tunnel785484-pt.tunnel.tserv9.chi1.ipv6.he.net. [2001:470:1f10:aed::2])
        by smtp.googlemail.com with ESMTPSA id h8-20020a6b7a08000000b00746041ecbf9sm1174834iom.39.2023.03.18.01.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 01:37:51 -0700 (PDT)
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
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/5] dt-bindings: Add doc for FriendlyARM NanoPi R5C
Date:   Sat, 18 Mar 2023 16:37:42 +0800
Message-Id: <20230318083745.6181-3-cnsztl@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230318083745.6181-1-cnsztl@gmail.com>
References: <20230318083745.6181-1-cnsztl@gmail.com>
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

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 5474cb4a13d1..6f4270f2bd9e 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -201,9 +201,11 @@ properties:
               - friendlyarm,nanopi-r4s-enterprise
           - const: rockchip,rk3399
 
-      - description: FriendlyElec NanoPi R5S board
+      - description: FriendlyElec NanoPi R5 series boards
         items:
-          - const: friendlyarm,nanopi-r5s
+          - enum:
+              - friendlyarm,nanopi-r5c
+              - friendlyarm,nanopi-r5s
           - const: rockchip,rk3568
 
       - description: GeekBuying GeekBox
-- 
2.40.0

