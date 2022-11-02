Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DE6616CEE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbiKBSpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiKBSpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:45:09 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C56E2F64B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 11:45:08 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id ml12so13129976qvb.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 11:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sw13xCxrWW7/c5Fz/JcFaLDrTASeOurUe6I0AYCZbD4=;
        b=udIT0nxuenxnrydYnnneSbq1kxmcFyNXi2DVAJTm3kehndEks41kjDCpG0lzbYIf78
         PgCCATBleZBo7Vmex+/nXIzct+osTedJjN/dNlgPOt8N8ZoYVlvmtRs0jU09kjnYRlIt
         B5BJuNKg9fpJsLQWfJqifZIjK23+wXtJDqPhrtj2FfIWf2iyeddQNcpi6ZJRMXVD0lCc
         8nP0Uc2etqzmXqbOPjSBuKvTwx9cpD6NkjY9NwEtvXriCZ1wxd0iYIkwfqnOJ3NDqcUO
         PkND7tSuTILfNdQ/i2KkV1f7It+RrVobFs3lvrm8j+xfNnmfaS4MPvkDRa4WFBLqcBf/
         RZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sw13xCxrWW7/c5Fz/JcFaLDrTASeOurUe6I0AYCZbD4=;
        b=dvN+oz/G2tOxAPmAJr/aZ8s6aX3ku9OL+2ed8SaekAcVoWNVjG5YSMVquurEu1UhRq
         IEckZ8H1Qv1p+Rb9KKBkYsnxVhd3gEnjoEloYnvQNr5/hAcwvf8GUaDSq4YRBhWHjLi4
         O+sGuAwsZuZ+naIWr2EO6yfNSCn/9o67vqp+GQDYq8C8G08WSZzqyxtTSoVOjmjB+LbG
         AJFrXBssD2yiMka0lk+Qfzw5wf10sdxJ2OoM3X8CA0+UIZXfg4B7QuwNixgj88RpuM1k
         6XZEFnFUcbmuD1p//8VBhA53RuIcp9OX0sdpiM9li7GWH+JP70Y9Jy0DgbWj7+CnyZmn
         7hYQ==
X-Gm-Message-State: ACrzQf09SYdvV/3Lk3dy2UWay+nQCJZmg1bDtHokVSEJ8xYS1c89Nyad
        WK2Q4nTjWNlgl4So6utJGF//qg==
X-Google-Smtp-Source: AMsMyM4oPJF+sU24TOosWCSqTLZRNbJTu8UlWiOtm53FD1sSIgM2j2p83IQQj7zV5DX2nVcByTzDFg==
X-Received: by 2002:a05:6214:300e:b0:4bb:704a:ec5d with SMTP id ke14-20020a056214300e00b004bb704aec5dmr22066032qvb.42.1667414707185;
        Wed, 02 Nov 2022 11:45:07 -0700 (PDT)
Received: from krzk-bin.. ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id w16-20020a05620a425000b006e54251993esm9090413qko.97.2022.11.02.11.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:45:06 -0700 (PDT)
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
Subject: [PATCH v2 2/3] dt-bindings: power: supply: bq25890: allow power-supply fields
Date:   Wed,  2 Nov 2022 14:45:00 -0400
Message-Id: <20221102184501.109148-2-krzysztof.kozlowski@linaro.org>
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

The BQ25890 schema references common power-supply.yaml, so allow all its
properties to fix warnings like:

  arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb: charger@6a: 'monitored-battery', 'power-supplies', ... do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. New patch
---
 Documentation/devicetree/bindings/power/supply/bq25890.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/bq25890.yaml b/Documentation/devicetree/bindings/power/supply/bq25890.yaml
index b7e8eeb940b9..ee51b6335e72 100644
--- a/Documentation/devicetree/bindings/power/supply/bq25890.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq25890.yaml
@@ -97,7 +97,7 @@ required:
   - ti,boost-voltage
   - ti,boost-max-current
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1

