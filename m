Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0306A8E12
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 01:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjCCAbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 19:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjCCAaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 19:30:46 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7B85943C;
        Thu,  2 Mar 2023 16:30:28 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id z42so716130ljq.13;
        Thu, 02 Mar 2023 16:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677803424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1EO681NLLyGQFHGfJf2gv1cVQUWKJ2bHIXepwv2glw=;
        b=jYpbKsl9Nsw4DwxLHHkbnq2jY3A1MpuQQF/XFdukoMRo6p6chJJVL8SU8X2Y+0V5qt
         xAREb7n1etY1CKu3qDWRsHgzAChFWmlCCVqcubbCXK9OkB6uHVrs8uNjCNVuzqUpdRhe
         6UlbLMVgR02S5+ZhRmiJpIOJHB8IQ8YFWr+5YkbMI4U0FAx1/RWZlD6cm16KQitcoXec
         CyrudItmTPT5jf3EZyDRTjpdr9m3Kh2GhEQyRUTcjKSZ2HaXYPXKHhYJ5j9Qn0Lx9wWW
         AgZbrouMa7lPv5PD1M7kU++hEYXctrIFnsBBcHijXOyi7ojRHf6wNJWrSQGa8wmAqaPc
         s1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677803424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1EO681NLLyGQFHGfJf2gv1cVQUWKJ2bHIXepwv2glw=;
        b=RmIc8pgwwG5IfWwNKn4ZhfcnzhWE3FMhLDdAn2AVPjptqMMOaQJxZ4L9nvsoQ7GQy1
         nyMZAtcEsdvCQ2Afsrcp22xUnX2zN8FgsNsnGWbsQZ5pECp3NqqllBJl6L2jiVFumbi7
         EE+a+dSPHaD761K33/q9HmwBoxS+daXCmN1sDyHPxJ2EJE1HtGNQJ0S0In4Vf/cB6Cyi
         Mdv4qhOmtSyw2EqHP1RrGNH+hmd5Y0491RLvtyMc6pdd6wpxIibeKJDIzeS2/fkxJk2a
         imwohHgXiYQvqXyvP7/wJExpKW7Pyfmlv44Pyn53qXb8x/UWoGDVLkY54IC5bQcijgfL
         9+EQ==
X-Gm-Message-State: AO0yUKUmoM9gFDyjrFO5LgKRzyj85pA/WbZT1GNvAxdL6Kw536gsfAcc
        o4icpiPxZB4VzihUFx3VwE0=
X-Google-Smtp-Source: AK7set8brLrLoVwNHcgj14Xjo3ys/agkh/5bIb+NCvbVQ35DVnkWmkqUzvAwOvYWewiYAbl2lg1wCA==
X-Received: by 2002:a2e:86d1:0:b0:295:a5e1:8347 with SMTP id n17-20020a2e86d1000000b00295a5e18347mr3395254ljj.28.1677803424712;
        Thu, 02 Mar 2023 16:30:24 -0800 (PST)
Received: from arinc9-PC.lan ([212.68.60.226])
        by smtp.gmail.com with ESMTPSA id v19-20020a2e9f53000000b002932b817990sm64901ljk.31.2023.03.02.16.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 16:30:24 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Rob Herring <robh@kernel.org>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
Subject: [PATCH 13/20] dt-bindings: pinctrl: mediatek: mt8195: rename to mediatek,mt8195-pinctrl
Date:   Fri,  3 Mar 2023 03:28:42 +0300
Message-Id: <20230303002850.51858-14-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230303002850.51858-1-arinc.unal@arinc9.com>
References: <20230303002850.51858-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Rename pinctrl-mt8195.yaml to mediatek,mt8195-pinctrl.yaml to be on par
with the compatible string and other mediatek dt-binding schemas.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../{pinctrl-mt8195.yaml => mediatek,mt8195-pinctrl.yaml}       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/pinctrl/{pinctrl-mt8195.yaml => mediatek,mt8195-pinctrl.yaml} (99%)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8195-pinctrl.yaml
similarity index 99%
rename from Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
rename to Documentation/devicetree/bindings/pinctrl/mediatek,mt8195-pinctrl.yaml
index 66fe17e9e4d3..7b3dfc14eedc 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8195-pinctrl.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/pinctrl/pinctrl-mt8195.yaml#
+$id: http://devicetree.org/schemas/pinctrl/mediatek,mt8195-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Mediatek MT8195 Pin Controller
-- 
2.37.2

