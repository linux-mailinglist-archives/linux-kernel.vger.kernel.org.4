Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27B169FB57
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjBVSlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbjBVSlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:41:12 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443EC43440;
        Wed, 22 Feb 2023 10:40:37 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bo30so8192649wrb.0;
        Wed, 22 Feb 2023 10:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcArEGHX/fk4tdd7xlvhQYvzSJ8gqoZ4AEIyQIgQrNU=;
        b=AR3MjkftLOM10sT3eRRIRv3jttbYHUx5N7LjAquL7S+7THBL4C7hugZCKNdCHq/wZ2
         fMkseRfTBsJTi/fV5prmF8t2TNDDRjJRtSK6FUZ/zo7FRf8ywkXtipOg3uBR9Y/Y47JR
         3FNNzx+se451S5z4q9o28Hay2RgOaeXLWNO2WcU7KamknJkox2nIXg2AiB+DNOcCnVtm
         rTa7QuelafRefkSveHJ9LnD2M9GaKvwWoKTxfvaz+4Epkc0Scm6Y/WzAS5I3NE7ZKfBG
         VFmVo4TtB1rzZEySAoSCYvrUJlef+G+AAA5h/fyKvLEoqA9/r3rMnnEmwLbtHncv9yq9
         isIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UcArEGHX/fk4tdd7xlvhQYvzSJ8gqoZ4AEIyQIgQrNU=;
        b=7zOhKLGDT01xE4Tq8dDYe6t8g+VkrcOBRdmmxhElpFmhoBS2b83iUGDmdr4Ocqub3H
         0uptWdU5j9+pfoLg63zYNOy7VOG9qgsuY0wk+a0l5fKYHWkEZRp2jy6SKbl/JznoDS9d
         M9iGBLpQWI1+W1RExWvtNfRQMsgxTvB3EySjewUG9om7Ru4HlZRbImKe5XMNU0/1LnNy
         RE2RViZ35hCNgK/HVGXdXpODzVo7WON4DwPxxPoSK43uCsn4X6Wzb2D/PGOvsPy+jHIv
         eJQo6I4FwNV29TuGriSi79pI5LxgEs3pvrCLvm2EvfZN5bVE7zZoMvmxPRyxFx6Z4sC2
         Py6Q==
X-Gm-Message-State: AO0yUKViukRRsLd+pvUkPpSZdSbsYhqHd2rKWHn3ygnYKq9bVssLA7LM
        mrPtYwI3yt94QbaPwJa8w3g=
X-Google-Smtp-Source: AK7set/PI5j55Nw4TKwVmwP/MNB3vBBcm1slvLkmfdv12lERhBSSRt/I8s1yrUOc05aaohWWABC82Q==
X-Received: by 2002:a5d:4d4b:0:b0:2c5:5d15:4e25 with SMTP id a11-20020a5d4d4b000000b002c55d154e25mr8455403wru.16.1677091234179;
        Wed, 22 Feb 2023 10:40:34 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d4112000000b002c56179d39esm9372845wrp.44.2023.02.22.10.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 10:40:33 -0800 (PST)
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
Subject: [RFC PATCH 13/16] dt-bindings: pinctrl: mediatek: mt8186: rename to mediatek,mt8186-pinctrl
Date:   Wed, 22 Feb 2023 21:39:29 +0300
Message-Id: <20230222183932.33267-14-arinc.unal@arinc9.com>
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

Rename pinctrl-mt8186.yaml to mediatek,mt8186-pinctrl.yaml to be on par
with the compatible string and other mediatek dt-binding schemas.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
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

