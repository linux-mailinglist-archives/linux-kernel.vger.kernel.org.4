Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394376BF429
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjCQVcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjCQVbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:31:44 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4327064848;
        Fri, 17 Mar 2023 14:31:11 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w9so25498783edc.3;
        Fri, 17 Mar 2023 14:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5OtwbUxmcTKUcw9nCm7KvLn2T2yQoHX2fxmIgn1joc=;
        b=k5HsOmpP6ocKUMcjWKrrBBicP5UP1XV0pgXiowNDsc8efI8SjF8Ug8j+PlzoizDdCN
         TJXVDLEFe2+yBx7YMqylpFiZYc1hLL8VE8uh7GmQAzjkaBOQWWOBDjAfBHvpqJ3TrzUs
         k75WwOjgSqSnCUaurN2DOiATz7dYdqiqiF7PoklCyXJjjVEwT4TviLtOQwmoFfgphtRX
         95f7pL99JgGaSGKa14DzIbTe/I3iUQ8i3dXvMQtsNG8kaSzJG2eQSqAV5k97W1Bydrmx
         xAahyDiV0s7RWznH1dju4uMZRmF/3eIWoY3j9E2POBe1trABTHRKGuqbp0Heozm1JkUg
         Rudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5OtwbUxmcTKUcw9nCm7KvLn2T2yQoHX2fxmIgn1joc=;
        b=e/ELa50Nn29YBKHU5EaEy0nhlckqIO6rq5xUG+A4BOkSR83yCX9rc4PZPAhzlSkDCv
         j9aOr7fiLNU4R/DvniemH/32psN927hFhj/z8XtBE2GzIYqwHM9pHIYus44rxg/CvVP/
         3YZeTydEJYoOrFBNgwVAR2c+BvVGzJolzyjbCDjnmrEEFTLtq/MnXcIHcfR4UvVCsRA1
         S+301c1+CTqVwJmokdKqhs0ozo4+XAa5AVxY2feiXrqAyP38WtylXJl0GdYhyeUyBy/Z
         LUznm2Fg+UY2HCWIb7rD/cy+ATcuUJcDZX4E6djy+YeBBRQqYE/5J7zYDZn2NTBXVdpw
         ZCyA==
X-Gm-Message-State: AO0yUKVFiOBY6wPtOpjB9jKwl6wyGueIcOBe/Cys+YaMat87riI4g9JD
        X8Y00V/8m/mBQVjtTlKvNDE=
X-Google-Smtp-Source: AK7set8dxol7s9TtQUQkUVdpCaiNcAKLEikKSgZOp+3/1rG7qVY0TV37G3jWDSdtBvXKUvmRn4xEcQ==
X-Received: by 2002:a17:906:810:b0:8f0:143d:ee34 with SMTP id e16-20020a170906081000b008f0143dee34mr844693ejd.1.1679088661990;
        Fri, 17 Mar 2023 14:31:01 -0700 (PDT)
Received: from arinc9-PC.lan ([149.91.1.15])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090651d300b0092b86d41dbasm1404683ejk.114.2023.03.17.14.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:31:01 -0700 (PDT)
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
Subject: [PATCH v3 18/21] dt-bindings: pinctrl: mediatek: mt7986: fix patternProperties regex
Date:   Sat, 18 Mar 2023 00:30:08 +0300
Message-Id: <20230317213011.13656-19-arinc.unal@arinc9.com>
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

Set second level patternProperties to '^.*mux.*$' and '^.*conf.*$' on
mediatek,mt7986-pinctrl.yaml to be on par with other schemas.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml  | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
index 31c36689438c..0f615ada290a 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
@@ -72,7 +72,7 @@ patternProperties:
     additionalProperties: false
 
     patternProperties:
-      '.*mux.*':
+      '^.*mux.*$':
         type: object
         additionalProperties: false
         description: |
@@ -256,7 +256,7 @@ patternProperties:
                   items:
                     enum: [wf_2g, wf_5g, wf_dbdc]
                   maxItems: 3
-      '.*conf.*':
+      '^.*conf.*$':
         type: object
         additionalProperties: false
         description:
-- 
2.37.2

