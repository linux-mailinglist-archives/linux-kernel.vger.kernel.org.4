Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F9769FB5F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbjBVSl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbjBVSlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:41:24 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E235D41B4B;
        Wed, 22 Feb 2023 10:40:52 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id bt28so2090483wrb.8;
        Wed, 22 Feb 2023 10:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GQZ8qAd7vUgU+4b+W6RunOVqNL3/02QMSg5OECyOek=;
        b=gF5UguTKx+5wO9R3iI8jUuMqngJiy/plOyL8nDKrrZLjiNoG8lU4qTQrFco4KH74/J
         rqDNvM4M88vtto8ZkGxGpwrmBw8v+y9fLTrunl+jXRH97Je6IHZc+HmwjGhjSAn3xI/M
         gvq5oZ8uj5Se7L1o7z3nvW4gV5kxpT2wuHgfFdyFXkW5BN53mcHMLLxa7T+/PC13dXVB
         QL1M/0bm/Xt+1B9c1K8RO2XD3otMxlyWSsPTTF2yHKVd/WksCfexnaVf+oxq4F27rk7S
         Fjr7yPS15/vu0h8cXZKokU12XFSJBfOYx6p0LnPyHFQSytV4A6zjt9qp4/jVmUGzDmu7
         R4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GQZ8qAd7vUgU+4b+W6RunOVqNL3/02QMSg5OECyOek=;
        b=Mbq1HX68QndFD0AKCjotms0LKKUxnkh5fDb6y1ZvTkTzDmEPclgrpqoQZkRswiMXYI
         aU1eOnJj4Rf7Xueg0TmK33+40juEuv4d7eX5cqiLBU23PzY5uLKEgZ8ItygtNitBhU2B
         /YwEgapBucGiwfL8XeiqtYVfxbhPWGsynYJI7TT0BCmJxXwifpK9a7DnkRQI2kLeY7cK
         CNJPbTz6BZCQ1lDDsb0hD/zuMK+5wRc4q9PDLDPqlHFs+scJ5y9LbsEisQjTdbZiuflg
         8uEWrSSv2KkhyhQQU6OdicegV1jPQQ7TwVijvOuc0UF4xOLjzw1N+ETBbWWCj0Eea1JS
         9/bw==
X-Gm-Message-State: AO0yUKWbnzlgeNyWSYm3S80M2SkZVLqR/mG6NKStdcOl/fHXffpoxjMx
        BKK/3DwpdJyBPzLONemy3Ps=
X-Google-Smtp-Source: AK7set/fFzM3NYHNQny0U269a5WUM4hhg0gF5WL2JKE+SiZW5s9bqU947q6Qe/lLwGBgPYWyFND8sQ==
X-Received: by 2002:a05:6000:170a:b0:2c5:a38f:ca3a with SMTP id n10-20020a056000170a00b002c5a38fca3amr6617920wrc.10.1677091236355;
        Wed, 22 Feb 2023 10:40:36 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d4112000000b002c56179d39esm9372845wrp.44.2023.02.22.10.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 10:40:36 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
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
Subject: [RFC PATCH 14/16] dt-bindings: pinctrl: mediatek: mt8192: rename to mediatek,mt8192-pinctrl
Date:   Wed, 22 Feb 2023 21:39:30 +0300
Message-Id: <20230222183932.33267-15-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230222183932.33267-1-arinc.unal@arinc9.com>
References: <20230222183932.33267-1-arinc.unal@arinc9.com>
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

Rename pinctrl-mt8192.yaml to mediatek,mt8192-pinctrl.yaml to be on par
with the compatible string and other mediatek dt-binding schemas.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../{pinctrl-mt8192.yaml => mediatek,mt8192-pinctrl.yaml}       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/pinctrl/{pinctrl-mt8192.yaml => mediatek,mt8192-pinctrl.yaml} (98%)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8192-pinctrl.yaml
similarity index 98%
rename from Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
rename to Documentation/devicetree/bindings/pinctrl/mediatek,mt8192-pinctrl.yaml
index e0e943e5b874..e764cb0f8c1a 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8192-pinctrl.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/pinctrl/pinctrl-mt8192.yaml#
+$id: http://devicetree.org/schemas/pinctrl/mediatek,mt8192-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Mediatek MT8192 Pin Controller
-- 
2.37.2

