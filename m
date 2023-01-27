Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B8E67E5E2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbjA0M5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234499AbjA0M5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:57:31 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE577D6C6;
        Fri, 27 Jan 2023 04:57:28 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id y11so4656519edd.6;
        Fri, 27 Jan 2023 04:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWNUjeJHZnSxax1J2QjLkizJUwF4ziE2YWbkX0rtPtc=;
        b=nLzIreB5ldC6Mp5rqVhPzuPxFbBJ/iBxrU+VlBRAVm43hgO6dsx9XK0J0BE1Z/iYGE
         WcVyHAcJvvYBynwjHXkdR34VzcyeNSCGYVtBfQth1l1h16TbdTJPAivb8BfifmS8/nlM
         MWpFiH9oggy1HEBeOVKqmPHKudXjp2m83NMfzeweSC6qnOj8w4FiPr/A8JkKybI9ZSvN
         T3VcZjEB0mXOXZpPwhVTvaecKa9dKnlL5dWX2IDRFGzm1dBsjfr7fQGrCEmomDOBGQ2Y
         Tke5PgnbquaWAQILFe2AKvPwPxpEeg0SG0XFOv8Olh5sbBZW2+mUqEMN4ajEwip94fiX
         0P8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWNUjeJHZnSxax1J2QjLkizJUwF4ziE2YWbkX0rtPtc=;
        b=Xn0ZnsMkh18ssPH0BVIhGk328jQ6bGsnF+Mb6gOo0UA1F5G+UYMaDE4RWtg4KF7Mdm
         ysKc0eBJNPW+nN8UhHQTwGJVNESYRsDxPzMyiZqs431edLa0jJbRm5g8cC7+XFAGI9Oz
         9YURVwdFkIhl5Dgm40k8hGxppSssdkV9+b1BeQ/cEOHnflWZfs1QHeBAovliXzLoMbJE
         0rV/Cvwm+lvSwD4XfDw/tmQJDw94+YlC3QjsiKQi6Y5h9ax4FiYoGHPAMDfKL7/S78AP
         U8We06qpGpfmrkhUGmwif9ZHZ1ajnO3jMSqvv7NXiM8pcdQMuhwr8ujVAU9b/HpNZI4N
         pHFw==
X-Gm-Message-State: AO0yUKW5pLfzBu/vRpPhy298cWg2vtewc4nn8x+taksdt8COJGMvC2fe
        10d9wSgKljjpxOQEfRPP9CA=
X-Google-Smtp-Source: AK7set/5bZ4uI784IuJUkInee1H79LNBugj8JNQgijXYDt78IC6myb1oTH9Sdn4EhNbI3tN0iNi/7A==
X-Received: by 2002:a05:6402:320c:b0:4a0:b756:cfba with SMTP id g12-20020a056402320c00b004a0b756cfbamr8972644eda.32.1674824247045;
        Fri, 27 Jan 2023 04:57:27 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id y5-20020a056402358500b00482e0c55e2bsm2248136edc.93.2023.01.27.04.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 04:57:26 -0800 (PST)
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
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V3 5/6] dt-bindings: nvmem: u-boot,env: add MAC's #nvmem-cell-cells
Date:   Fri, 27 Jan 2023 13:57:08 +0100
Message-Id: <20230127125709.32191-5-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127125709.32191-1-zajec5@gmail.com>
References: <20230127125709.32191-1-zajec5@gmail.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
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

