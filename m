Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367056BF415
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjCQVbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjCQVbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:31:15 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B7122797;
        Fri, 17 Mar 2023 14:30:49 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ek18so25431553edb.6;
        Fri, 17 Mar 2023 14:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1EO681NLLyGQFHGfJf2gv1cVQUWKJ2bHIXepwv2glw=;
        b=Nj/yv883NrbobitzXaKxcYWACXTNOv5IeesF3v8/SYibxX7Grd0zQqBqRo4aCNf69P
         qs7cv6Z2pLjSi7PElPIjTE4yFfkXsoSfNvHxfySPguyzaLHoH642t208C/4SVMfSeWF0
         oh9gqCBMXwmn9zU/HJae0O6YN1pLywu5otcUDIceCk6Xv/lmDfMeXwqOFhhVdwCo5Noy
         VoCNAgl5EY/ijB6idyAoam0qDGZl7K4riAk/4VQrja4PiHsvvcwYyMRom5cjQNHCpdfN
         x80AsQxCu1At9LqN3Z8sI9eig9SOocDcs8Nl8gK1CvesJeQvCKFNRX9CDsl4THoATuAs
         1NSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1EO681NLLyGQFHGfJf2gv1cVQUWKJ2bHIXepwv2glw=;
        b=scb/ZBOY59hi2BWEzU1pEFoxvcAhixM8epOhIwIdS78DkCq//Sgqjx1azOX0kgO1rI
         FyDegi1fQ6yZaqoEHHSZgRpsYDiCjH7Wkdc/Jp1EgeclLy+xa3wdY0hfus+iLEPtssxg
         qBqTiKNQ554Koul/YcVgxRstd9l7UmAaQ7BQPYBnsccHRHRGKZxuFIR6vBMEsm49S4r3
         AwBvwogaKvt98cozoWTlrD60zVgr7PSgnt2YpRP9N28T+NuGfxGo3x+GOCfY1CihRg6q
         jiNu+bXxDDcX/g5bTjc8L+NIrpqF2NPWzN/r4TXfJIX5zUwgMokTYD9aZLXd253FtHY9
         1IBw==
X-Gm-Message-State: AO0yUKWpcPKK8OCM3TWDScFxCZfmJk0+kFQSHDCiH6UutcNHkyKfr7JT
        /P+QUfq0XA2QyaWRtlCQqBc=
X-Google-Smtp-Source: AK7set8exkSeTiGGFVcm4bMaCRqAh37sCsa47AQqZCcy7GGsu7JIZnViKmVXS1DpDenp0lpJfstl0A==
X-Received: by 2002:a05:6402:7c3:b0:4fa:4b1c:5ea3 with SMTP id u3-20020a05640207c300b004fa4b1c5ea3mr4692669edy.23.1679088649113;
        Fri, 17 Mar 2023 14:30:49 -0700 (PDT)
Received: from arinc9-PC.lan ([149.91.1.15])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090651d300b0092b86d41dbasm1404683ejk.114.2023.03.17.14.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:30:48 -0700 (PDT)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Rob Herring <robh@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
Subject: [PATCH v3 13/21] dt-bindings: pinctrl: mediatek: mt8195: rename to mediatek,mt8195-pinctrl
Date:   Sat, 18 Mar 2023 00:30:03 +0300
Message-Id: <20230317213011.13656-14-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230317213011.13656-1-arinc.unal@arinc9.com>
References: <20230317213011.13656-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
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

