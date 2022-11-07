Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F80461EB70
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 08:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbiKGHP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 02:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiKGHPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 02:15:17 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C0113D13;
        Sun,  6 Nov 2022 23:15:16 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id g10so6681234qkl.6;
        Sun, 06 Nov 2022 23:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XNx+rgJgduq7rCvuRhTlcngQGfS0jYPWbvWIVqx1qM=;
        b=fkfG9ot2ZJgYRbjgmfQajtUOKmevc7ckdcsndCM1TmZAPhW6j+EysoQPGDBwIJRxgq
         NE3yWYDf/T5yPZRzXdSOGT+vS4p83A0LAfW44V+LJFZgK9HfZBlMxEsYoYeWeMyXy4KR
         Qneape2Fqn0VRYB72SmDoFFfjTxZNdaDxjcD54Ie9/QNzwfLHy0GVt7fFqgpiWOfVIiO
         2/ZnikDSmoABsfIoxJ0p34AQIgAg6jtB3imD0BYedVnBBB1qfS1wnApFT2H7f1Kd0Gti
         Xqzt60nux9KRPbQAhfoM1GMffCVsXXi2CEJKKCPjXbrYLSbVeV2PowzLNHs5MP37kAl2
         UIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XNx+rgJgduq7rCvuRhTlcngQGfS0jYPWbvWIVqx1qM=;
        b=ie7sg38fc+QZo7klBrQEAgQaFAQz6opW2NGnKb4Q89NabrPOLlHMaEJlE3ndDsKFjN
         aXF/IZvEOIWFMtLj1mY66RxetuoReWfy8fS7qDaSA45QXcxOYXwhbImcAso1H5JUlgLi
         rVB4O7G7+dJUj5WV54LqTWY0bpaUuRz7gtBhQxJOIZP3Wuixb+5sU0icGeUmOfIXBzo+
         3QBYC+qu+03usCR0vD7Hwq+jeIimoYfftWC9WbTCR2/x9N0uqC/Amni3gEAwNyNw1UVD
         3k7fMHO6OFPoQGm/Zgj5nAYBGHG3v/x5Rtyrwx3VWirjRWYwiSi/dtoDFTAvu8Lsmv99
         lNXg==
X-Gm-Message-State: ACrzQf27dUlypD50525aRbXObid7qN5Qi8THERjnRBMdnSWrTWdm3D9C
        aQiLjeeqZUR4xnVT/xo++nI=
X-Google-Smtp-Source: AMsMyM77e+VuZnZM7E7UgYqBiy6cpufDm9treTU+akYNQtE5dR3s7GTF4Q0lLO9teekpOEtECVAWow==
X-Received: by 2002:a05:620a:2b45:b0:6fa:509f:d0c2 with SMTP id dp5-20020a05620a2b4500b006fa509fd0c2mr21882138qkb.302.1667805315213;
        Sun, 06 Nov 2022 23:15:15 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (pool-108-26-185-122.bstnma.fios.verizon.net. [108.26.185.122])
        by smtp.gmail.com with ESMTPSA id br8-20020a05620a460800b006cf38fd659asm6318428qkb.103.2022.11.06.23.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 23:15:14 -0800 (PST)
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
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v1 2/7] dt-bindings: pinctrl: Fix file path for pinfunc include
Date:   Mon,  7 Nov 2022 02:15:06 -0500
Message-Id: <20221107071511.2764628-3-Mr.Bossman075@gmail.com>
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

Reference to pinfunc.h was wrong. Fix it.

Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
 Documentation/devicetree/bindings/pinctrl/fsl,imxrt1050.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imxrt1050.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,imxrt1050.yaml
index 1278f7293560..db5fe66ad873 100644
--- a/Documentation/devicetree/bindings/pinctrl/fsl,imxrt1050.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imxrt1050.yaml
@@ -35,7 +35,7 @@ patternProperties:
           each entry consists of 6 integers and represents the mux and config
           setting for one pin. The first 5 integers <mux_reg conf_reg input_reg
           mux_val input_val> are specified using a PIN_FUNC_ID macro, which can
-          be found in <include/dt-bindings/pinctrl/pins-imxrt1050.h>. The last
+          be found in <arch/arm/boot/dts/imxrt1050-pinfunc.h>. The last
           integer CONFIG is the pad setting value like pull-up on this pin. Please
           refer to i.MXRT1050 Reference Manual for detailed CONFIG settings.
         $ref: /schemas/types.yaml#/definitions/uint32-matrix
-- 
2.37.2

