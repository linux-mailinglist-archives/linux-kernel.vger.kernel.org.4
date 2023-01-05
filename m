Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1187165F273
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbjAERTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbjAERSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:18:16 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595C9F5E;
        Thu,  5 Jan 2023 09:11:03 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id b88so46369343edf.6;
        Thu, 05 Jan 2023 09:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0/YbCUbiIk7jw/h/JX9JQTuGXWp0ew1oCAgQXwBuda4=;
        b=IojnGYDPn9/9kUDImAM4/qPxH1tqs8AraceRSrGaPrIA4K0BRlCAPDmiBwZEg9QXQT
         jG8NZZpy9XBTTB43h/Qh4IRnJJWSC1XKZFUXqJrg3vMkW8c92mN+vnhLuFR1nQ1BIhpo
         C1pjPh0QmKFQRehd6MyFU3oCS9Fq17hTATXQEUmkS7Id1y7ILI2vLVlRmx+Tt8fd6CW1
         lL3h034rSuNYg3bQyHofC94WE0CP3oQ9Z8ft8R+bp1ZoV9tgvJFCzrPN8TW6uAe2mAXV
         dlaDaK8cFh/IDl0oDiS8AI1iqgB5m/AwFXYw0MOCg9nqHal+h1VGqkNHDhR6+wFf9Ezi
         Wm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/YbCUbiIk7jw/h/JX9JQTuGXWp0ew1oCAgQXwBuda4=;
        b=JVOgqsTBdzD5tT3BhIalR6q5ptyDwgl8g0ZWqvyik6ty5yUdy3sOsyoUHbxqjFJAIs
         KN1Bb+MuYoWGTaJG6tzqhZfa3qbEGa+Ehc9Dks6qu4ATPetJ+3AZFTjz2jw/3j4qRxjq
         rpEgPWai9EExOVsFNwsfnvMci6Q8qZG/ql5OCVWM50Ps+J8dDZ4CXABpO8DPdcbFPLpW
         YJ6CDq5HgroOR7aACzkcWCbJX/vzxKyuO9l7lH7rO0Bwv/x93c+/lnqwG1Fl/vc+wrYt
         Q+35WfseelWvJ40gkLCjhqm4HwzM+VWaYVOnB38unJfajZi6i044FfhBLGlDNDaYjVAU
         qOyQ==
X-Gm-Message-State: AFqh2koyRwgyXHUF+HfVQoaXBLbnh+PEV/mQouyf1TbZ0L4C3qemVrqx
        EIwwAm5Jwai4YrqByunx8WI=
X-Google-Smtp-Source: AMrXdXsnbZYzuSv0TqR8hfYnHxxX2Xd5kBkoqfcQ9arljmolLSRX2rKW22FQCZ/5qyGNKYpvruiI5Q==
X-Received: by 2002:a05:6402:3909:b0:492:846d:e86d with SMTP id fe9-20020a056402390900b00492846de86dmr2651833edb.23.1672938661792;
        Thu, 05 Jan 2023 09:11:01 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id cn9-20020a0564020ca900b0048fdf37c441sm1714829edb.3.2023.01.05.09.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 09:11:01 -0800 (PST)
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
Subject: [PATCH 1/3] dt-bindings: nvmem: u-boot,env: add MAC's #nvmem-cell-cells
Date:   Thu,  5 Jan 2023 18:10:36 +0100
Message-Id: <20230105171038.13649-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
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
 Documentation/devicetree/bindings/nvmem/u-boot,env.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
index cbc5c69fd405..1c139bd689ea 100644
--- a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
@@ -50,7 +50,11 @@ properties:
 
   ethaddr:
     type: object
-    description: Ethernet interface's MAC address
+    description:
+      Ethernet interfaces base MAC address. The first argument is an offset.
+    properties:
+      "#nvmem-cell-cells":
+        const: 1
 
 additionalProperties: false
 
@@ -72,6 +76,7 @@ examples:
             reg = <0x40000 0x10000>;
 
             mac: ethaddr {
+                #nvmem-cell-cells = <1>;
             };
         };
     };
-- 
2.34.1

