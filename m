Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F67663EB8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 11:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238220AbjAJKzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 05:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237872AbjAJKyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:54:45 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166331F4;
        Tue, 10 Jan 2023 02:54:43 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id az20so8462796ejc.1;
        Tue, 10 Jan 2023 02:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5xJKON5Ta6zI9VZAQEfIhcRQtQRxrWmROsI4bJtDyw=;
        b=fHEP579INgzePeFpjuOCrhgw+APWLrqlZj78kQe5xeeOLiJcbbl+2QOudZjLBFH5X2
         ZfjqjvOG1vWV3FuyP3G4YALYeMDVqcv0cQpD20pxnlNn351Nonkw/G6W0VUmZPK7391l
         nYo4xBECTFtAZdm4prqhWZVXmDTrSmf/KT4zmAWWkVQ+tKZRLZd7fwZH2G2DUXPCs0tG
         zqldBkFl8bUAnUnapAXsndHTIgIBALFCMREUsCuD1OkqudL65NGPCJJzYSBHetA+fKeT
         DvBwoss03FzrBF/MARRAoP6jwkm9Vwcbk4IXPiaJTs6Wp9qHwhw6pjoj2eImKEjYRYLz
         SW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5xJKON5Ta6zI9VZAQEfIhcRQtQRxrWmROsI4bJtDyw=;
        b=x+rqVTeb5Ak3aL37/sfJ1Bk0JYh2CVLEmYkhI+LBglGiiHjZy4hlLNlLzn78sFHGci
         a4An9tBNLYuJOnN0sJLgEB/YP9BEfXwEdhju+89QgjIAYjHLKpWbEaUjvI/Es/nicv5X
         6R5CLZoU3+8xbyLk8jd1PgGmd+uU56ke9UH7lROQsXai1SEkOLdzbnl/DCyuOoR4PsNK
         FmMUG25c9zOa65/TOAASVFOWOOnfRsfU3PPhCnfwYcoQGmXu0wW94iUjHYVWH3pgcn4d
         SQsw1GKO2XRvxM4QLcuqGZ6JpCb1szpL3Vy0a5ANWM0O4Ro2Fvzi4LAV5pGmKczIOPeA
         Ph0Q==
X-Gm-Message-State: AFqh2koyZD1kmtdE92wGLJwqoSK+7N1hFYLHmodIhxA/NZbpKNhTMsuc
        acyAG1d9p/55NBcnXEGM3Sw=
X-Google-Smtp-Source: AMrXdXsDivvK1wuFjL3hwWcq9UhWxr3hw428dQsN7UkIH5bPtEZNJm+US7BfJfiW2PQV1vpAs6ue3g==
X-Received: by 2002:a17:907:d093:b0:7c0:cd95:bbb7 with SMTP id vc19-20020a170907d09300b007c0cd95bbb7mr54046916ejc.77.1673348081568;
        Tue, 10 Jan 2023 02:54:41 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id s1-20020aa7c541000000b00495c3573b36sm4818199edr.32.2023.01.10.02.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 02:54:41 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        u-boot@lists.denx.de,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 5/6] dt-bindings: nvmem: u-boot,env: add MAC's #nvmem-cell-cells
Date:   Tue, 10 Jan 2023 11:54:24 +0100
Message-Id: <20230110105425.13188-5-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230110105425.13188-1-zajec5@gmail.com>
References: <20230110105425.13188-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

U-Boot's "ethaddr" environment variable is very often used to store
*base* MAC address. It's used as a base for calculating addresses for
multiple interfaces. It's done by adding proper values. Actual offsets
are picked by manufacturers and vary across devices.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../devicetree/bindings/nvmem/layouts/u-boot,env.yaml      | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
index fb273b174fe7..dbff702f2e5d 100644
--- a/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
@@ -45,7 +45,11 @@ properties:
 
   ethaddr:
     type: object
-    description: Ethernet interface's MAC address
+    description: Ethernet interfaces base MAC address.
+    properties:
+      "#nvmem-cell-cells":
+        description: The first argument is a MAC address offset.
+        const: 1
 
 additionalProperties: false
 
@@ -69,6 +73,7 @@ examples:
                 compatible = "u-boot,env";
 
                 mac: ethaddr {
+                    #nvmem-cell-cells = <1>;
                 };
             };
         };
-- 
2.34.1

