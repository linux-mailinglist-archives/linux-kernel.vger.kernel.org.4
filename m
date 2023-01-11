Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C98B66552F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 08:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbjAKHbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 02:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235838AbjAKHbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 02:31:23 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC56C76A;
        Tue, 10 Jan 2023 23:31:22 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id i9so21101386edj.4;
        Tue, 10 Jan 2023 23:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5xJKON5Ta6zI9VZAQEfIhcRQtQRxrWmROsI4bJtDyw=;
        b=clAg3pNMynRTgt/ZYGkCxez++C8JfrcYYOJZCCGvBuPqzuRYGoWbhgwlQOdL134HL/
         2Eho/ERuAQm679eEFNivP61UWKBR6vnvRLVlRBoBbj/5A8qfWPCJpvnJluJXduu2y2Zw
         5N6HGQdGRmuoZTI17dO44aXEDGxlwvnrNHwrgWiUxXLvby4S9tsB3hvnRLpjA6OtG5nR
         Yj7DfjmE0lqgaIN4gTyJiI4Sdl0AXsoWZa2ufgS02RNunujn2FKKpB1u6VcTo+CHgKAD
         iYCuFF3HgSga/zF2X9d+Tx/G7CZKSTC3nXzE+jrxJZmMLCyI5wsU4rp4xM9mC53YPYuO
         2maA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5xJKON5Ta6zI9VZAQEfIhcRQtQRxrWmROsI4bJtDyw=;
        b=HrXzNKYQ+wV9zCEip116MR4fgObsVZG430i2icnbQ7pQV68BWAQeZ3lKxpd2ntd2Q6
         SOXvXF/joFTWqeyjF8dUM53QhNE7phmXt1YSWzJIRG5jpwHOxf4h2Enl0VFX37UwgL1e
         FCEYSTn6kyvB2YIBvC9b/7pF39URTAYxjX7zbYZFw+aQEz7wkm8R4RhkggHPEnZg2IKo
         yjYv08clC4VTKeIfrMf19/kR4jHd0CEOQHYvQjAVuds4ESiw9SCOcdveKdRgcKqxEmZw
         TQx1FmrKbFBLyk++mUVCSB+ZoA/KrbLhTq7kYt454MRex3S2oJpuWMGpvuu/V+D7C/nc
         u7Xw==
X-Gm-Message-State: AFqh2kqETDcCfKnDAcUsg5Hg8w01O71b0o7JLFZc9lUMf0rMNnYjMb5c
        i9peJ1XM3eaPU1UbjMOJE14=
X-Google-Smtp-Source: AMrXdXshmijD2se+S/uS6CRtU21sfZ8aA7lNf5pWw0PkbyxS3Q4+XC35AzGeVuw9BhxMstgIidu0rA==
X-Received: by 2002:a50:a401:0:b0:46d:53d7:d21e with SMTP id u1-20020a50a401000000b0046d53d7d21emr64886229edb.27.1673422280601;
        Tue, 10 Jan 2023 23:31:20 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id ed6-20020a056402294600b00499e5659988sm593193edb.68.2023.01.10.23.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 23:31:20 -0800 (PST)
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
Subject: [PATCH V2 5/6] dt-bindings: nvmem: u-boot,env: add MAC's #nvmem-cell-cells
Date:   Wed, 11 Jan 2023 08:31:01 +0100
Message-Id: <20230111073102.8147-5-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230111073102.8147-1-zajec5@gmail.com>
References: <20230111073102.8147-1-zajec5@gmail.com>
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

