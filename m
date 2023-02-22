Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4910D69FB3E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbjBVSmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbjBVSlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:41:25 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912E943461;
        Wed, 22 Feb 2023 10:40:56 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id 6so8346688wrb.11;
        Wed, 22 Feb 2023 10:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeXXWoYtcN7Md4fHV+U+ymSCKklKj3szjzv05DFaWBc=;
        b=CSWzu0RDifPIC5mVxgRnFfoFU8+34A0WTuQKE35mzW/6ggRyLHF3l6iM1+kgmTXwCu
         oCZS7EVL3DR/F5WVbsc5h/HkBDQ4ldhlfPPAq6fD45M6m5tbIGX4H0M3vtHvYoT/CSen
         sz4kd819EHvEaKI3aslUVvNWnqUDABjbGwIc0Hsge/5GBEmvdHvRAjJIhDHCb3JcqZnz
         E3t9NlAKw0VbYlt2CSdN0SCF5PvZ5MCDMn7q2slkvbNTQBExh/qsagyjOCYNzkBP8DbU
         nD1sWl3EL3jCc2o3CqrjKreER41SXYBR/X4ywF1wHtcfB4qb7TcoBLpgjqiz+CcAH7J8
         YICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PeXXWoYtcN7Md4fHV+U+ymSCKklKj3szjzv05DFaWBc=;
        b=Lb0BimT2+1FemgmughZrcMbtPnahoP5r5NSOvyaJNxW7jyi1qrTgUQR/GRMP6gWofv
         Hmdd0eeETpX9mHi78t/ExRgPHcQeGsn919fpb35cYIrDKVFanrRjdhQJC9E4wWNqAw0Q
         CaMP/O5v+9pU5NFQ8A5NEsWnf3xeazsrRr5XjkE5wQGoLiCjm2f2YLZ7JcQ1o5Ge0ZET
         yTStm5Zt42s8YcUWnyQmUh+aOFr0n8yU2NATowXznvRdTy1ZS5P/SdE62IEI2CHwld4M
         pTqNeobCa4t9BocTg8uorkoH5a0Z1T8Q1sL5N/v9V3NTqaiHtXWEs/vkUmBADbauiwa4
         CbiA==
X-Gm-Message-State: AO0yUKUKWqexq0fYcBHjr0goDoiXCPcJkj5o7InRLabfJF4aKIXtkc02
        g4dnkJKQVqcveTxkEZYlg+0=
X-Google-Smtp-Source: AK7set8Uz83OUsrFm9m3xtosfJbhI2niwL6prvque1JZYsakJ64OCWj+zmdlRdhG4BeR7sPUaUU1tg==
X-Received: by 2002:a5d:5486:0:b0:2c6:1482:33fa with SMTP id h6-20020a5d5486000000b002c6148233famr6770139wrv.59.1677091238565;
        Wed, 22 Feb 2023 10:40:38 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d4112000000b002c56179d39esm9372845wrp.44.2023.02.22.10.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 10:40:38 -0800 (PST)
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
Subject: [RFC PATCH 15/16] dt-bindings: pinctrl: mediatek: mt8195: rename to mediatek,mt8195-pinctrl
Date:   Wed, 22 Feb 2023 21:39:31 +0300
Message-Id: <20230222183932.33267-16-arinc.unal@arinc9.com>
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

Rename pinctrl-mt8195.yaml to mediatek,mt8195-pinctrl.yaml to be on par
with the compatible string and other mediatek dt-binding schemas.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
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

