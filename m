Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A427279FE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbjFHIby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbjFHIbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:31:50 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED1526B2;
        Thu,  8 Jun 2023 01:31:47 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-97454836448so53960366b.2;
        Thu, 08 Jun 2023 01:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686213106; x=1688805106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8a3s6dNMGohL6lzSETKOy1sEkT5zPauvgRWFqwA9Lic=;
        b=QIsqMCHh+4cnkvqMawn1joP4jCx0aqzS4YZ8qgcrJe7lWOmauhJcp0a4akR8ycLUlZ
         VgHpfPjNnCamaRQOPPwW8BVtsExyTLHhzUttsYaUm6Jpe7ne36p83LBQHWOoIVGQ4iF+
         OF/J6tCZMNQXqJi8iKhLmqtfRxWuyDqqA/b7W8vmevwplcIR/X1lFo4MllUrtngOKuA0
         SR0h9KQU9lckvlJPawWhAi5MpVZkDBWB5+s20lk+neB4YeQpU6/JQ3j+uKLVQsDsX7Vz
         wFIHsLWecRsQcfyWJN2FOw5ngnF8/XppHSlAXzVwGkzd6QD06rkZCM9vnYvOOj7lGS5/
         TUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686213106; x=1688805106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8a3s6dNMGohL6lzSETKOy1sEkT5zPauvgRWFqwA9Lic=;
        b=OB/sz16npjltB8z8/ngbhjOHvqn4KXlnZHgLObF2iJt7wJ1DtzsOYi5SZ3dHsuqxdo
         CFqYR3gKhbjyme5ecPACgzY/NpEbL/7hkLUL20T0bjGDEDI5j8pNSt4Smwu+XsJogMQ6
         d4QOWNLVSexCxxzDrMolzsOINfMb/cyRpmWDRf/3uYRGqTa4Msd7lYiY66KxynlA2FUx
         VL4JFK9Af/QtmVibHIuPGc7TS7sOBLAoCK4Y2/v6CVkBZsq9VhHys0Efu26Osyi5WUWS
         H5gB/qD6cI1R1iQnJ0cXJw0lfpAKFFzLnw/q8F8BOYrClOCamHmpKxoRXvsAKp6D94UF
         OBFw==
X-Gm-Message-State: AC+VfDwb8um0ruHpAR3fY+vvnnyKbxQBm1zyMqcIs3wQm5BDuzkaVJPr
        gDLW7/uHfmPtCMZSLXh0TLE=
X-Google-Smtp-Source: ACHHUZ5u9yorLSnlw4ho90LcHOtj6uag/6Y/tnsOk71m6s9NvweNwK8OEstNOwJUXQGPJ7HyqfR/hg==
X-Received: by 2002:a17:907:5c3:b0:92b:3c78:91fa with SMTP id wg3-20020a17090705c300b0092b3c7891famr8150076ejb.28.1686213106065;
        Thu, 08 Jun 2023 01:31:46 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-50-121.cust.vodafonedsl.it. [188.217.50.121])
        by smtp.gmail.com with ESMTPSA id y8-20020a170906558800b00974c32c9a75sm373690ejp.216.2023.06.08.01.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 01:31:45 -0700 (PDT)
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
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Nicholas Roth <nicholas@rothemail.net>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v5 1/3] dt-bindings: vendor-prefixes: Add prefix alliedvision
Date:   Thu,  8 Jun 2023 10:31:14 +0200
Message-Id: <20230608083127.545750-2-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608083127.545750-1-tomm.merciai@gmail.com>
References: <20230608083127.545750-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

