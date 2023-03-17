Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89DE6BF3FF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjCQVbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjCQVaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:30:52 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF43E4C41;
        Fri, 17 Mar 2023 14:30:37 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z21so25476360edb.4;
        Fri, 17 Mar 2023 14:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=831eezpQQ1y/Bza6SFUBg+0j0MfEOywRdTuqRTBfi2A=;
        b=FZP2v4NhwY9EMcMyXAOB/4mR5Uaqqjjjo/eSIVX3nNmoMsoG3W3WauJzviFMQdrPuv
         r0ax7LrM9Dk5vxnQ1buyq5JGDDbJBGz8Frn/iuIKVRm3sOlZ3lfkjUKfYgdj1uE5CEWP
         247fcpcKXb1cjGcN3Z03xaBrwA/YnYLqP0DZDL9FlKU+W3AQajMzHi1b/aUMthaIy03g
         iVK9ykoOZKd2+krO7312/Cgopejv7cSGOuFQ4Fd9/ldnfMlUGgoohOE3eRPDjABBgl5m
         34AkRUg08tKXJuWes5+KJmO7dbZbehsxCSJslayDahtQneaAkjheCgw3ROMuDJ8Qasry
         04Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=831eezpQQ1y/Bza6SFUBg+0j0MfEOywRdTuqRTBfi2A=;
        b=LXBkETVPNwL5IFOg/MDwOsxUkq00L4LVilIMtTQgjgftDi4i8/p9oDwNT28E7Wi1/M
         M9M+S2kiewV/IymH4dlQusZb44aC8FTZINbVmAw5uwb2uKefPD7W9RikSeBuiLWLMWiB
         64E7vYewpgzeqoeWnlYt/CRkGnLuuPkky8sH57+xaILywMi/QgIiBqBM0oKwgV+AdJyB
         48d411zpfudYNz+87DMqBK1vDu4kbeoWR+n9fnADUDZMv+bZOGfn6MlJfxB48zIDrDty
         GR30/bS5aPRqwHdNeAla4EUuCT9NeFXJhu0lCxOPbYv67OYUuSS1tjxISWtc0wDf/1l8
         7ohA==
X-Gm-Message-State: AO0yUKVTAM4RDnK4vT6bOKjhvGfF/VaFePdvlBizyPcHVuFGA2wvmYmF
        7XPa3aCjXuZKEZP31a4xbnCs0lPVB3d+CgsF
X-Google-Smtp-Source: AK7set9JPZMCF+E0gStn6M7piSEshol9kTKXaImBhSCtm+waAogNmPksEqhtUxggIfKyH7peDZgUJA==
X-Received: by 2002:a17:906:51d0:b0:92f:c6b5:de08 with SMTP id v16-20020a17090651d000b0092fc6b5de08mr711214ejk.76.1679088636688;
        Fri, 17 Mar 2023 14:30:36 -0700 (PDT)
Received: from arinc9-PC.lan ([149.91.1.15])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090651d300b0092b86d41dbasm1404683ejk.114.2023.03.17.14.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:30:36 -0700 (PDT)
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
Subject: [PATCH v3 08/21] dt-bindings: pinctrl: ralink: add new compatible strings
Date:   Sat, 18 Mar 2023 00:29:58 +0300
Message-Id: <20230317213011.13656-9-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230317213011.13656-1-arinc.unal@arinc9.com>
References: <20230317213011.13656-1-arinc.unal@arinc9.com>
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

Add the new compatible strings for mt7620, mt76x8, and rt305x to be able to
properly document the pin muxing information of each SoC, or SoCs that use
the same pinmux data.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml   | 4 +++-
 .../devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml   | 5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
index cde6de77e228..09ebb8ac22ac 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
@@ -17,7 +17,9 @@ description:
 
 properties:
   compatible:
-    const: ralink,mt7620-pinctrl
+    enum:
+      - ralink,mt7620-pinctrl
+      - ralink,mt76x8-pinctrl
 
 patternProperties:
   '-pins$':
diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
index 8b1256af09c3..23fb82f9959c 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
@@ -18,7 +18,10 @@ description:
 
 properties:
   compatible:
-    const: ralink,rt305x-pinctrl
+    enum:
+      - ralink,rt305x-pinctrl
+      - ralink,rt3352-pinctrl
+      - ralink,rt5350-pinctrl
 
 patternProperties:
   '-pins$':
-- 
2.37.2

