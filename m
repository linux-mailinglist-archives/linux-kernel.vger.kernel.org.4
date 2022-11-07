Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C4661EB6F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 08:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiKGHPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 02:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiKGHPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 02:15:15 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0315413D13;
        Sun,  6 Nov 2022 23:15:15 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id x15so7567265qvp.1;
        Sun, 06 Nov 2022 23:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTuGs4Qr8OjIPTV0EW+3fOR56dGgW7kE0R2qX2cKw3M=;
        b=lGzX8P6W7zgpcKY2ylsffT7ItgS2ThQqmOG+9r35EVmd8AMXBLsiGPK6JE/5FQdgvE
         D71/a3QofCTUTYPSoHE12mcp+HW0ZF0DehozUwvTPMmvlwYXlmGEZ/1qBZ7L0o7i1D9i
         FFowQIO82vroCPcleeWyOVCYnnlDXKghRhmA2U4QQUBwbH2H0mzzlAPxUB2PgOZ3u5VJ
         yn5x8ZFKobFI3vVr5j6It5Hu8m6S3+i0iZ/shOGJknfQE5+sosUJ5/zIC0DLJ43X9Lp2
         dEXqIMU1kMBMwbBfd1V1ETase9Wf9qx1QKFARiEHAC4cdNPZA8TghoraBmM+D+07hPEd
         uZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTuGs4Qr8OjIPTV0EW+3fOR56dGgW7kE0R2qX2cKw3M=;
        b=TmT1D3AOUI0a8qXcM2iXDYw94Utw37oJfK7HQPqnoxQCYwL1fFv/KalTJZX2CVIQlY
         KMRrDCXuGjJnYj/74QlUzl36IM2zNClTev6lM8amAYC2idu0BaDrmOWNjVdaqp7V9A9t
         sTh59BH74aUcftGgOU12akJE0UhtGnvmahFnHYJ51UUlFyKHV11k0kh06GdNQUEwYlgz
         VdzPqzps665W7rGJ/zGGvVkvLLXQ/XJxC4iZfS4k7qgxkyzPASRWwoCDojn+vIrcUij+
         DI6VGyhdJcV7eiPXSDBrBYr1ai3AkWcHMP2RYuQfDagbW9dZUF6fdi0B41WB1IV02FEv
         XTnw==
X-Gm-Message-State: ACrzQf2MbeFzsmA6Dg09FLvwC055lxphNE7ks96hdK0hH/0lQKYxXD5g
        ApD+zS23GPy5Ec+eArS3y3Y=
X-Google-Smtp-Source: AMsMyM7EMf8qeKS1zjYmLF98QBhhMYd9qMDGQBRAc31DPFEcgLyErj+9GDeMmbDWbhjXCx77hWl0jg==
X-Received: by 2002:a0c:8107:0:b0:496:a715:dc8c with SMTP id 7-20020a0c8107000000b00496a715dc8cmr43396491qvc.96.1667805314146;
        Sun, 06 Nov 2022 23:15:14 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (pool-108-26-185-122.bstnma.fios.verizon.net. [108.26.185.122])
        by smtp.gmail.com with ESMTPSA id br8-20020a05620a460800b006cf38fd659asm6318428qkb.103.2022.11.06.23.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 23:15:13 -0800 (PST)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     robh+dt@kernel.org, sboyd@kernel.org, shawnguo@kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        stefan@agner.ch, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, linux@armlinux.org.uk,
        abel.vesa@nxp.com, dev@lynxeye.de, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, leoyang.li@nxp.com, fugang.duan@nxp.com,
        Mr.Bossman075@gmail.com, giulio.benetti@benettiengineering.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v1 1/7] dt-bindings: arm: imx: Add i.MXRT compatible Documentation
Date:   Mon,  7 Nov 2022 02:15:05 -0500
Message-Id: <20221107071511.2764628-2-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221107071511.2764628-1-Mr.Bossman075@gmail.com>
References: <20221107071511.2764628-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
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

Recently the imxrt1050 was added but the cpu compatible node wasn't
added. Add both i.MXRT1170 and 1050 compatibles to fsl.yaml.

Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 59e6e8b4dab3..a95b774e5d67 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1046,6 +1046,18 @@ properties:
               - fsl,imx93-11x11-evk       # i.MX93 11x11 EVK Board
           - const: fsl,imx93
 
+      - description: i.MXRT1050 based Boards
+        items:
+          - enum:
+              - fsl,imxrt1050-evk         # i.MXRT1050 EVK Board
+          - const: fsl,imxrt1050
+
+      - description: i.MXRT1170 based Boards
+        items:
+          - enum:
+              - fsl,imxrt1170-evk         # i.MXRT1170 EVK Board
+          - const: fsl,imxrt1170
+
       - description:
           Freescale Vybrid Platform Device Tree Bindings
 
-- 
2.37.2

