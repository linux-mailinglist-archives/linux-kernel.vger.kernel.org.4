Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41326726113
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240574AbjFGNUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240743AbjFGNT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:19:57 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93BF95;
        Wed,  7 Jun 2023 06:19:56 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-973bf581759so1197493266b.0;
        Wed, 07 Jun 2023 06:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686143995; x=1688735995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8a3s6dNMGohL6lzSETKOy1sEkT5zPauvgRWFqwA9Lic=;
        b=e9OFzs0/hYsYYGluQTWwOyas5lGBEN8aOUJpDakaU2Nh3SnPWPTCPt9Ovr3zxqqH5x
         XqpswZAOWa99RBonDBv/4GjjpoGcxChFLxGtbh0SXIiM0ZcKkiDO7nc1gxPujvMj3Bcl
         +jD64g6rQOAzG6ysgshB+SZncbfZbNEmFRNhW4mwFbD0SMHuSFmw5JZsublcy7VEztCv
         Isf7uaxLyZkMFmxiLXYPRrHyOJKr6Mw12IhnidYPi4rivOB0EU5w78kIFrrZpl1IOEEk
         byOsXovL8x9NXUidPnpSWCF7grPZQCQq1CfVpJSoEdur6jsLy49PWbOgMmsN9bDVIhsZ
         agqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686143995; x=1688735995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8a3s6dNMGohL6lzSETKOy1sEkT5zPauvgRWFqwA9Lic=;
        b=Q4tPQaKHrCrAbJZOKYNWNRDtUrb6PURmqnQMLn3kRGKrPepAUBFG4R3h3UA7aBz3qW
         cEbdrtQk64UBeTpdkA9ccwnQ21PPQ0kS2ac72E9YUbf4P38HBUEHOC11kVxGwwpoF2PL
         AufDxMH8R/89hIPP25KYh7ibaM4lNOEfh0q6iRaNsA2b+w6+jbgOr/AHBqQE0Do90n3i
         XdNM2N4jSGU/ih015aNDdBcb5ATaGZxKAbE4amOCwrSibDBeFfp5YHe4ZJwRkOl+KfI6
         rkBtET6pFHTb/e/dXafuGfthGUJSkF/wVpKzK48YlnyNc3X58mcZANWkqlJDpHydK5bp
         Ygbw==
X-Gm-Message-State: AC+VfDwaDBXwwHgSbSq62d3jZ652GlGqNULwzdsYXqcr1HpeZxWNYTh+
        QQlyPAjNRpc8LqETbX4Wfis=
X-Google-Smtp-Source: ACHHUZ6dFzzS165fB0JVdGyKZhVRzKvs1qrXQZd/EMFtwjJ8kPnNCX2ioseJWTzkD91VSSj0XL4DNw==
X-Received: by 2002:a17:907:72d0:b0:974:5ece:19a6 with SMTP id du16-20020a17090772d000b009745ece19a6mr6815876ejc.54.1686143994904;
        Wed, 07 Jun 2023 06:19:54 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-50-121.cust.vodafonedsl.it. [188.217.50.121])
        by smtp.gmail.com with ESMTPSA id k12-20020aa7d8cc000000b005169ffc81absm493353eds.51.2023.06.07.06.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 06:19:54 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        martin.hecht@avnet.eu, michael.roeder@avnet.eu,
        linuxfancy@googlegroups.com,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Jagan Teki <jagan@edgeble.ai>,
        Chris Morgan <macromorgan@hotmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Shawn Tu <shawnx.tu@intel.com>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Nicholas Roth <nicholas@rothemail.net>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v4 1/3] dt-bindings: vendor-prefixes: Add prefix alliedvision
Date:   Wed,  7 Jun 2023 15:19:23 +0200
Message-Id: <20230607131936.382406-2-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607131936.382406-1-tomm.merciai@gmail.com>
References: <20230607131936.382406-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a vendor prefix entry for Allied Vision Inc.
(https://www.alliedvision.com)

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes since v3:
 - Collected tags from LPinchart, CDooley, KKozlowski

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 82d39ab0231b..7bd678956b3d 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -77,6 +77,8 @@ patternProperties:
     description: ALFA Network Inc.
   "^allegro,.*":
     description: Allegro DVT
+  "^alliedvision,.*":
+    description: Allied Vision Inc.
   "^allo,.*":
     description: Allo.com
   "^allwinner,.*":
-- 
2.34.1

