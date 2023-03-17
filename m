Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAD96BF411
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjCQVbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjCQVbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:31:14 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C81F2F04D;
        Fri, 17 Mar 2023 14:30:47 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id eh3so25369701edb.11;
        Fri, 17 Mar 2023 14:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8438bEydUlrPZrkVMSwHAqPRPD9BxspbjMsnayfq+s=;
        b=BKQ1OiJAvSoi6GkGS20VepyAZM2aTwKrXTe4Ydz1TSkodfhZrKh8lT9EDNJDHEjOmU
         UWH8sM+IvQ5tGgoLfe8AcROvIYDEi/blCyXacpL+2Y2fry6S19VwnxFlmGn7c9tfE0LU
         VRQwJLXqxH2xf2VXLFnngDReFs0Gi3upAk3JGMDOBIw4x6BXA8Nv3W48+gR3vX7y1a88
         W65qEaKoMl0650ce4rzfomFy7ZhPkSOKRNwj1sspUl9SeG1SDGBhqfDVsL14WcCfYKrp
         2mWAyyLceE4zFuozksoNNhqpeQw/GsHLliaIuvyqNXfeMd0Nv85/JQoQAZp0fBoe8ldJ
         1emA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8438bEydUlrPZrkVMSwHAqPRPD9BxspbjMsnayfq+s=;
        b=PEz6iYLJ+8IU9kSmOKdUY24/aoZYCAB9NnROEtrzToJVJNzVBt3uNpkS2mPgR5K69C
         s5Zcki1EIc2b75nYXleMcbwVqMqlSMJ0Gckq3AIPVU/Y3WK1Slv6BaOsFaC85U2KbpYK
         JsWdZbzeGKqBdjJgOFZMuuYu7g6juBouRnlYS3N+j9k8l6g4d/VPU3Tgfa36KSwvMhQb
         wVR+fAhJIiMAE5OL2xevOXI/WVOnTFJeTIfh+58GIGU3cG1B9Q710+TCQmx5yl3JTBW/
         w3hDOzxtfqjDstIRerQBSucbMUxgX4ZHKD/6qF9uxhv1Q4Bun3PUq76qdrTcbFt/id96
         jIXQ==
X-Gm-Message-State: AO0yUKU4jDB8gAY4BmWKVUYRn8/fK12GdQXw1lzhKxhICa/UhorMAvP3
        AfgTL3t5WpfptLpknK9LHRc=
X-Google-Smtp-Source: AK7set9WdDW37amJ7JOELl+SoaTQ+kMULS23MCFyTGLUsyOVdgPMIEeQ75qrnhAz2a9GQMdJyXcBVA==
X-Received: by 2002:a17:907:a04f:b0:931:51c0:7300 with SMTP id gz15-20020a170907a04f00b0093151c07300mr665581ejc.77.1679088644180;
        Fri, 17 Mar 2023 14:30:44 -0700 (PDT)
Received: from arinc9-PC.lan ([149.91.1.15])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090651d300b0092b86d41dbasm1404683ejk.114.2023.03.17.14.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:30:43 -0700 (PDT)
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
Subject: [PATCH v3 11/21] dt-bindings: pinctrl: mediatek: mt8186: rename to mediatek,mt8186-pinctrl
Date:   Sat, 18 Mar 2023 00:30:01 +0300
Message-Id: <20230317213011.13656-12-arinc.unal@arinc9.com>
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

Rename pinctrl-mt8186.yaml to mediatek,mt8186-pinctrl.yaml to be on par
with the compatible string and other mediatek dt-binding schemas.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../{pinctrl-mt8186.yaml => mediatek,mt8186-pinctrl.yaml}       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/pinctrl/{pinctrl-mt8186.yaml => mediatek,mt8186-pinctrl.yaml} (99%)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8186-pinctrl.yaml
similarity index 99%
rename from Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml
rename to Documentation/devicetree/bindings/pinctrl/mediatek,mt8186-pinctrl.yaml
index 26573a793b57..32d64416eb16 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8186-pinctrl.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/pinctrl/pinctrl-mt8186.yaml#
+$id: http://devicetree.org/schemas/pinctrl/mediatek,mt8186-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Mediatek MT8186 Pin Controller
-- 
2.37.2

