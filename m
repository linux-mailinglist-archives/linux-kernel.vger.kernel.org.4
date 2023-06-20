Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B50736BD6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 14:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjFTMWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 08:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjFTMWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:22:42 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D3710E2;
        Tue, 20 Jun 2023 05:22:41 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-987c932883bso530681966b.0;
        Tue, 20 Jun 2023 05:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687263760; x=1689855760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8a3s6dNMGohL6lzSETKOy1sEkT5zPauvgRWFqwA9Lic=;
        b=RHQ99NRXJBFBN/YIRaV1bWc6jsEVdzqh/ekEQ1y3NzSTwa95vGXgqfM0bl+F38mwlz
         Bs+2NeoNZuHKEbEXpM5HyBGK5KZZExZy0MJhx6ik1wI7i+SBwAKKBgdsG29ONUitmRCK
         Lyjir/nHhudQR3TAmExaQOeFZkCHfNt+sCqkW6rbnELb7CDL4XdX+pw2eFvzqygSBcYa
         3oCPG2oMY1oKDNjnvlAv4VzxKHBJYJ3IgqmHQxsIKTGQDVBtPQDb8f5U6OH+MUBJlJy2
         mxS4z2EeVXUHP3UbCQLSPrQjOvjV0qq9JWFGTbkIh83dfgUw4l4hJe81gkpwwPDCnHXU
         d9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687263760; x=1689855760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8a3s6dNMGohL6lzSETKOy1sEkT5zPauvgRWFqwA9Lic=;
        b=WaiZENbjdySzxtE7beLzLPMA26NZOCurAy5StyGkVqHsxvWSUIXivXW+WnOs7my3sf
         nEEqjXwPLQMUxJaM3TrjBUt5bh3xNFOxc8WT3fwL9OQQ0hGJXmOIaAb5Ad19Ui5p1EiC
         NYoAeKvTMz+qkoacZTS6tiuIaCCHv8cLXqaMjRFXYMHG01mmCFLmBBSaI+Kz/9PXpEHP
         m72k8hf6afxOX5rdiscA4v5Qp1uY69eTuof3xj3nBeqQSXO/MfA29ELbWfmHfz0JxzFq
         q+tv/fx66TbifiNvpb0rPlh2ODWxx32r/Lz+1OwVI5nF5YN09aS8c95ERQPHbyvv8y7I
         eaHw==
X-Gm-Message-State: AC+VfDxeb4CTnlTZsx9ZNlEC/EHvZK0KqNYliHd6xz9EJWkT4HculoJy
        R9aANg2ZVqTpmHZ0MKedRsg=
X-Google-Smtp-Source: ACHHUZ7HCXhreNWMYX2IRTuznU/PLFzYFLFhRLqUFA5w44ujOGGQ+8L4Y5aYyNwXFTZogTlitcoOXg==
X-Received: by 2002:a17:907:969f:b0:947:335f:5a0d with SMTP id hd31-20020a170907969f00b00947335f5a0dmr11236956ejc.62.1687263760064;
        Tue, 20 Jun 2023 05:22:40 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-2-39-142-242.cust.vodafonedsl.it. [2.39.142.242])
        by smtp.gmail.com with ESMTPSA id me16-20020a170906aed000b0098669cc16b2sm1305200ejb.83.2023.06.20.05.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 05:22:39 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        martin.hecht@avnet.eu, michael.roeder@avnet.eu,
        linuxfancy@googlegroups.com, hdegoede@redhat.com,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Jagan Teki <jagan@edgeble.ai>,
        Chris Morgan <macromorgan@hotmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jason Chen <jason.z.chen@intel.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v7 1/3] dt-bindings: vendor-prefixes: Add prefix alliedvision
Date:   Tue, 20 Jun 2023 14:22:18 +0200
Message-Id: <20230620122225.58862-2-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620122225.58862-1-tomm.merciai@gmail.com>
References: <20230620122225.58862-1-tomm.merciai@gmail.com>
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

