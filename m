Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF662732C92
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbjFPJ5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243969AbjFPJ5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:57:43 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3545B30FD;
        Fri, 16 Jun 2023 02:57:39 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-98377c5d53eso68793566b.0;
        Fri, 16 Jun 2023 02:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686909457; x=1689501457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8a3s6dNMGohL6lzSETKOy1sEkT5zPauvgRWFqwA9Lic=;
        b=YF6BktpWF0yg0FoWHEc7Ls5+WQRUH/BKQMHW+zZsIFzq2TMF7HREWBIRdu+wFuz7U7
         KmN5BX3+dmSV3C24pLEjxLEemBgBBFIycIJm6oi67BwmE6OSjy10KVjYwqAD/RKO7wbX
         e5PClJ2kDaKJ/n0WcITGWe2SVEuGQh/0tKAmRyG+6KD1IfdtwKexyE54ad/QIlbAzqpO
         6AWZlgf+0hjpW22N7ys1/lTbkUV30o6vyrLolVFvkPtvfqK6q7tQM2c66wNoIOpaoJ/Z
         XR/dSq+cfhWgp+THs7iis1wTRCSprg0pW+Jb2SL00kpLVjwGbhpQiaEevKQoQnJhtTDL
         F9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686909457; x=1689501457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8a3s6dNMGohL6lzSETKOy1sEkT5zPauvgRWFqwA9Lic=;
        b=CdqG5BHkytRAPV2skTuwvR+S2d9Bxmf/bTBRm1+X4avwW7AI0dnUh+x+d/RDtu0pU/
         AGBmQIrK/z7ufYQfLIRPL8+Ja2RSeXtXWCUviEVXxA5sIUvsvnu2Hc4p3+gf6HG2gKEy
         x0hlb8R1bYsf5Y9gx9hi6iC9QBB2Ri62740KPalOirp1/f4AAl4zoDJ0CpjjtE9NU59Y
         KF2bTsfqjAc52WxD+pLgf6RF3EH1MzF7FHSztBW+28OXR0IbQwTd43uE1AWtA0WpPJmL
         mgCCVuldGqIcwPM9C9+MEwz5f3yl05pF8zSLTRk4KMPfoMIiGs+N9eU9v8hcymjRW3HJ
         ALYg==
X-Gm-Message-State: AC+VfDxq9KtQOQ1e8DZgz8J064WFnR6pl4g23x2PMDZNzL9Rb1dKVmSN
        8EX3EPEerrYGX8zQXaHxj3g=
X-Google-Smtp-Source: ACHHUZ64SmTt9EJLkdkmc7vYi5fIifUnEDtkCewvVdOGMt4kpV6A7xGsBUBtMjayNgVL5aPP35WrpA==
X-Received: by 2002:a17:907:6d07:b0:982:9dc1:a439 with SMTP id sa7-20020a1709076d0700b009829dc1a439mr1276356ejc.2.1686909457409;
        Fri, 16 Jun 2023 02:57:37 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-2-39-142-242.cust.vodafonedsl.it. [2.39.142.242])
        by smtp.gmail.com with ESMTPSA id v22-20020a1709063bd600b0098314c30e8fsm1110083ejf.46.2023.06.16.02.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 02:57:37 -0700 (PDT)
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
        Bjorn Andersson <andersson@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>, Jagan Teki <jagan@edgeble.ai>,
        Chris Morgan <macromorgan@hotmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v6 1/3] dt-bindings: vendor-prefixes: Add prefix alliedvision
Date:   Fri, 16 Jun 2023 11:56:59 +0200
Message-Id: <20230616095713.187544-2-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616095713.187544-1-tomm.merciai@gmail.com>
References: <20230616095713.187544-1-tomm.merciai@gmail.com>
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

