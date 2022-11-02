Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B01D616CEB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbiKBSpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbiKBSpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:45:10 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB942D76A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 11:45:09 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id l2so7224503qtq.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 11:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OaJC1NoewmXjPxS0Lyt64Qa/JvMUE2LWOQneWFWHmgg=;
        b=midHby3kR8uErqu/QMklWynWJ1iNS4A6IADiLuugjxJDxFM2F+urA+6P4RVv7Xes8R
         COsOFSMAurr8NGV6v7V+gWlzpbPx1qYL8oqOpONVecxzTEoY5iIUrf1Btb0XWRi8IvzG
         cMWzZZFBwnDfI042JdRV5dCMwSXtHINOzz4Az2HF6+BltG9GGJ7ittZQnpCQOBfvwlsX
         ifqzr8I8mx1SabvBWpbjH6+/dCBa+DHmEj3PGb0UVtkxUEeMNbVCqymH0TzC8YjJhIDy
         WTXDVKYRIp7MfmP3JH5c87enlyHRgMDbs+tA1+rSw51FGSNPIrE0SSqzeaOeaz7+xOpw
         c9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OaJC1NoewmXjPxS0Lyt64Qa/JvMUE2LWOQneWFWHmgg=;
        b=zN00SxJU68FpD4B6v/GrJUwdLaxjisTnR9QlKPhv3xTWDeqml9piUCqh7nxxO7NFKC
         FxM6tG2tuaZYF0TM2HgUwO5gmJNfUhfb6ch00ye1etqpibFpP5jMxqhs1bDpFTboR2R4
         nb9LjHGcbL3qHQDbfDfuuU/IXBpQphtnNSjvRadL7i2X6IzbBHGtIo6PRUBZX4xmcyzk
         TdMdHDXokyOerPbOF1xbo4lqFcK3Jo93e6rrzJCw3AowD6lmUWUoqkPd0HPmSmmM+/FG
         Sg4kjXo5IGO/BAOvwsAD696Vxe4fdlN8WTknOULK5qDK5h4mpNyMkN9B6dS95NEYSGeC
         SATA==
X-Gm-Message-State: ACrzQf2g9j46qAdqxQJx2PidnEES1Ixa6pxUXJDBK1/Fg3GedK4pzHGu
        +cAmPAzGgoeDPpZS116ItAjpaw==
X-Google-Smtp-Source: AMsMyM4Xsbl0+npXWymI1g53Xuyz+ex5cxhVd/HsL/qqxgeky19y68fomQ9rZPZYd9MZ1kbNFoA2NQ==
X-Received: by 2002:ac8:5c11:0:b0:39c:fd77:336d with SMTP id i17-20020ac85c11000000b0039cfd77336dmr21164500qti.479.1667414708952;
        Wed, 02 Nov 2022 11:45:08 -0700 (PDT)
Received: from krzk-bin.. ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id w16-20020a05620a425000b006e54251993esm9090413qko.97.2022.11.02.11.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:45:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Purism Kernel Team <kernel@puri.sm>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Chris Zhong <zyw@rock-chips.com>,
        Zhang Qing <zhangqing@rock-chips.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/3] dt-bindings: power: supply: maxim,max17042: allow power-supplies
Date:   Wed,  2 Nov 2022 14:45:01 -0400
Message-Id: <20221102184501.109148-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221102184501.109148-1-krzysztof.kozlowski@linaro.org>
References: <20221102184501.109148-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAX17042 Fuel Gauge uses power-supplies supplies:

  arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb: fuel-gauge@36: 'power-supplies' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. New patch
---
 .../devicetree/bindings/power/supply/maxim,max17042.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
index aff5d0792e0f..64a0edb7bc47 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
@@ -59,6 +59,8 @@ properties:
       Voltage threshold to report battery as over voltage (in mV).
       Default is not to report over-voltage events.
 
+  power-supplies: true
+
 required:
   - compatible
   - reg
-- 
2.34.1

