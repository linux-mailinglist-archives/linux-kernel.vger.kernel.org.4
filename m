Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC4561EB8A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 08:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiKGHQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 02:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiKGHPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 02:15:36 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D7313D62;
        Sun,  6 Nov 2022 23:15:20 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id k4so6680943qkj.8;
        Sun, 06 Nov 2022 23:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0r57Vvw4A7lJzIo/9EbiUI/3USItkedCC8EGqi95SU=;
        b=FmYBOZqYub8si8sSull+j9QRtiVf7LQKFWqcrUoqWpAz/CjcJmAbFmKbUQiUB2HMya
         WLVc8I+SP19VDoZZ5exD/CvkLgRcuX23bE5NRaTfJG7NVFjXGZJes0VeqCxZ4SICr+lQ
         Q9kG0U5bueB+d1T7hNWtWMtsvDin8p1Jn5Q0ubf8ClzFXepOumhs3uQ1qjDzZRWEt1V6
         JVe4uyeZlx/NVfW3hQmRl+MkAdMQq21aqyAXbKbxcob1LcMUZ+8mVyfwM5ChBuCO+Dql
         ILziT+Pvc/mUADH/AcTg5Db7KY395ykiVuNRr7vvdFyBFx+5VjJd/YXBoT5wUx/E35eU
         qbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0r57Vvw4A7lJzIo/9EbiUI/3USItkedCC8EGqi95SU=;
        b=6Uz07WngoOhQ3m5FXKe2V5oawvJC6iumzlwOG/hapW+d2wD5Ut7EgLIute7HBVUtcr
         +K3Rv3YOm5S1mZZra0nMlXZS98x3iBVHSXYiZ0nyTfgCbcUjOCeTYrkI/VeePwJJmw6P
         8mgVbA1iEzspO2kAwKt4e6TTZSluxrfWWhDXe/OjZZvsF1JKdvDcncHhVsbUK22GmrL/
         Etvquus0UM4ovcQTJ3S60bgQpOZP7TKEyvVCk7iwufbjDPTkfTlGNXA1/bWys+9YbADW
         YZ7x748artRJPoKYmTfu9yNIv6krgTFHtx2Q5f/Y6vAgbgEB/8uVUQy0DnSUi1RxOfpG
         KsUA==
X-Gm-Message-State: ACrzQf0PrA+ZGcWiw6T9qDjoMxB7JAMERSLgywd80iTpmxtL0h1sbMPS
        uOmpzT0sKnvC7FutK+uQ7aU=
X-Google-Smtp-Source: AMsMyM4Cger4O1dNqIMvlSZOE1rmt3mv+pZVh6V5xEukOqvLnKxxpug2f51xjjbdOYp+fpY6Jbtzcw==
X-Received: by 2002:a05:620a:9cb:b0:6fa:22bf:9fa with SMTP id y11-20020a05620a09cb00b006fa22bf09famr30741111qky.625.1667805319141;
        Sun, 06 Nov 2022 23:15:19 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (pool-108-26-185-122.bstnma.fios.verizon.net. [108.26.185.122])
        by smtp.gmail.com with ESMTPSA id br8-20020a05620a460800b006cf38fd659asm6318428qkb.103.2022.11.06.23.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 23:15:18 -0800 (PST)
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
Subject: [PATCH v1 5/7] dt-bindings: mmc: fsl-imx-esdhc: add i.MXRT1170 compatible
Date:   Mon,  7 Nov 2022 02:15:09 -0500
Message-Id: <20221107071511.2764628-6-Mr.Bossman075@gmail.com>
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

Add i.MXRT1170 compatible string to Documentation.

Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index 29339d0196ec..0e7833478869 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -75,6 +75,10 @@ properties:
           - const: fsl,imx8qxp-usdhc
           - const: fsl,imx7d-usdhc
         deprecated: true
+      - items:
+          - enum:
+              - fsl,imxrt1170-usdhc
+          - const: fsl,imxrt1050-usdhc
 
   reg:
     maxItems: 1
-- 
2.37.2

