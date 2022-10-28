Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5E06115FC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiJ1Pfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiJ1Pfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:35:33 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606B56B8FD;
        Fri, 28 Oct 2022 08:35:26 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id sc25so13743244ejc.12;
        Fri, 28 Oct 2022 08:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z06pdfS003dG+bMsKoEr4GgY+rFAIFspiXbdk/yaqow=;
        b=dO+awnftpXtAIMQBIJ9FXtRxhAOZkhM4J2BxrYKZCmESb+oA+lj3C059YZ3Ex6aAYn
         4DQ4nELnVmjeJgceXYI7+Bx6WaFkiuWVMRdzE7NWX4Sgxf2PTOc6gmVr54Pj+c2Cr+t6
         i7BmANBSI8m3clsoYZo0BC9nyb599H1+KXmJxXdY43PFdIZgvFSM+qAsdgARQ309CkK/
         eyq+/x9Nm1eNEr2KrkEl8Ncb9zIBcIwpsX1NqCmdSs8h2G7d9Ubv8LBstk4GCfb7l/Cb
         AUm7/CzQx+KpvQRVeUqXyIUT17sXNj93aLBRwk8hyf5DnALzGjTM/0GTEjjd2vzbgKuk
         4EZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z06pdfS003dG+bMsKoEr4GgY+rFAIFspiXbdk/yaqow=;
        b=O68wrmNJ7yTicF9sswMLcxr21DX7MrQmZcRUstL2/GjuzUX1LukCKtsZiVHfRHDQYk
         Y6eA2LZn4toaU0mbHo2LPiPstdTKP+pssn4ccx3hCqNAiAs7ROZy24gbB+DypOAkQPe1
         kbYID5NOFzMPrVHVoDCafuR8Ujmf0U5mDdY455xNbBDCUPwisOuuThyU/hBM5qGGV0Ia
         /Z4dJ+Ww5A4ml0BxJvWvNmJq6CW4dpoA4t73ZO47Nwdv5anN2cq7OJNqaI6UFw/gFsIJ
         A/ELS76MBs6GvzbP5XGr63A7gwqnY/BAOUrzA1mwTFG7CoScPHPK0tqxvfHKqMd9vUww
         aGZA==
X-Gm-Message-State: ACrzQf1FshzgEIop66iDieZI/1i48cjcRzZrqnDjlPvnISI1YXGeUGK7
        gg+i5lkKxJiMjkT0QBdN4yo=
X-Google-Smtp-Source: AMsMyM665PDwpDa6biS24HSeKGo722HnC3egF6m8MyhVTIv0AxIMuc/D0YFhO2N4MItjPvG6qP8BVg==
X-Received: by 2002:a17:907:948f:b0:7a7:5fc8:909 with SMTP id dm15-20020a170907948f00b007a75fc80909mr25445458ejc.658.1666971324992;
        Fri, 28 Oct 2022 08:35:24 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id ds12-20020a0564021ccc00b00461aebb2fe2sm2830635edb.54.2022.10.28.08.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:35:24 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v4 02/13] dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Improve description
Date:   Fri, 28 Oct 2022 18:34:54 +0300
Message-Id: <20221028153505.23741-3-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221028153505.23741-1-y.oudjana@protonmail.com>
References: <20221028153505.23741-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

The current description mentions having to put the pin controller
node under a syscon node, but this is not the case in the current
MT6779 device tree. This is not actually needed, so replace the
current description with something more generic that describes
the use of the hardware block.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/pinctrl/mediatek,mt6779-pinctrl.yaml          | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
index 8c79fcef7c52..c6290bcdded6 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
@@ -9,10 +9,9 @@ title: Mediatek MT6779 Pin Controller
 maintainers:
   - Andy Teng <andy.teng@mediatek.com>
 
-description: |+
-  The pin controller node should be the child of a syscon node with the
-  required property:
-  - compatible: "syscon"
+description:
+  The MediaTek pin controller on MT6779 is used to control pin
+  functions, pull up/down resistance and drive strength options.
 
 properties:
   compatible:
-- 
2.38.1

