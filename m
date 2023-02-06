Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973A568B8AC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 10:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjBFJ1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 04:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjBFJ0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 04:26:51 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7561EFFF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 01:26:36 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso8209991wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 01:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NltTiy8xn2JKwfiZaBO3T//bukmYqSDYuR6n40WhPpM=;
        b=UfiPwjvAoUzezhkip6mvvxbrXO30ukQZoogg8ATIDBoWsAg5A5bUPu83r7sz/Qnk0v
         4nVbTC769OJUqg0vNK+qbmBNhb00gzTW2XjUmbjDwm4wPiwkASmCY1B3wtSq51sceN3I
         HBJV33GaNVCoahXuEl1tCXCs985CjTG6Pfgm2+wJt4VCTmVQR4STdPSIwgrPj3GY+rOq
         FGNilXgciFd/34mcEsh4gZ2ssVjVJ1gB2jx637dDjNmjACdAdIqqICba7FPzPzxOm/oP
         p8ZWXbJrCfabvZaQtwCY+dKBMvz77UbIr1N9nOvqdijx6vJPd0h92nnEt0lKT0T4DrgP
         Lr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NltTiy8xn2JKwfiZaBO3T//bukmYqSDYuR6n40WhPpM=;
        b=15KPYrDAWvXSUt9AVbHlv2PkGQTsV4yzemxwfMKYFySnttImJXuMWcNqqhIKaBkDab
         bHE7tbEva/Xm/pM/AvxBt8ZoUWnPPl1XbH9Q+CgOBqVVgu4XQHcpw/llz1afOV5By/tO
         k2hMk9PA+P6PJcLnmICPjEyCX06LzOETNI7xIL1tqQ1p1nXjeffgNOIJO3WYKkOMqiCz
         qT6Bz2WJTM7AqukvKF7NUDBmtDYSNJnID40+rjA9s8Jn4FR8/hrCYiavXVrwqX2hFvdy
         x3QfyT6MEUf7JP77qvzf8GpubJxDq49gpDo083Veh+T/OLYYwom9U9tDUv13aS+dXNsm
         weSQ==
X-Gm-Message-State: AO0yUKWqVo/Q58/em8HES9NEf39tIX+uyX2/9DM/rqvvST+DUSf3Ae0L
        CpzxLLRJOAVZRGxCim7NA/Q8XQ==
X-Google-Smtp-Source: AK7set/+YAlCKEnfu65t5EEdU3AxjxK4oxPpS1jjtxFOzqaxj4/XoLM83k/+r7P9XXYa0rbjJTUcnQ==
X-Received: by 2002:a05:600c:3496:b0:3df:f3df:29b0 with SMTP id a22-20020a05600c349600b003dff3df29b0mr7027632wmq.14.1675675595281;
        Mon, 06 Feb 2023 01:26:35 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m5-20020a7bcb85000000b003de8a1b06c0sm15722568wmi.7.2023.02.06.01.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 01:26:34 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marek Vasut <marex@denx.de>, Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3 2/3] dt-bindings: reference MC peripheral properties in relevant devices
Date:   Mon,  6 Feb 2023 10:26:23 +0100
Message-Id: <20230206092624.22922-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230206092624.22922-1-krzysztof.kozlowski@linaro.org>
References: <20230206092624.22922-1-krzysztof.kozlowski@linaro.org>
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

Several devices can be attached to memory controllers (or memory-mapped
buses), thus they can come with additional controller-specific
properties, e.g. devices wired under Intel IXP4XX bus: cfi-flash,
intel,ixp4xx-compact-flash, NS8250 serial and MAX6369 watchdog.

Referencing Memory Controller or IXP4XX bus peripheral properties fixes
few dtbs_check warnings like:

  intel-ixp42x-gateworks-gw2348.dtb: ide@1,0: Unevaluated properties are not allowed
    ('intel,ixp4xx-eb-ahb-split-transfers', 'intel,ixp4xx-eb-byte-access', ... ' were unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../devicetree/bindings/ata/intel,ixp4xx-compact-flash.yaml      | 1 +
 Documentation/devicetree/bindings/mtd/mtd-physmap.yaml           | 1 +
 Documentation/devicetree/bindings/serial/8250.yaml               | 1 +
 Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml    | 1 +
 4 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/intel,ixp4xx-compact-flash.yaml b/Documentation/devicetree/bindings/ata/intel,ixp4xx-compact-flash.yaml
index 52e18600ecff..378692010c56 100644
--- a/Documentation/devicetree/bindings/ata/intel,ixp4xx-compact-flash.yaml
+++ b/Documentation/devicetree/bindings/ata/intel,ixp4xx-compact-flash.yaml
@@ -35,6 +35,7 @@ required:
 
 allOf:
   - $ref: pata-common.yaml#
+  - $ref: /schemas/memory-controllers/intel,ixp4xx-expansion-peripheral-props.yaml#
 
 unevaluatedProperties: false
 
diff --git a/Documentation/devicetree/bindings/mtd/mtd-physmap.yaml b/Documentation/devicetree/bindings/mtd/mtd-physmap.yaml
index 5df94953c34e..44cd4476d1d3 100644
--- a/Documentation/devicetree/bindings/mtd/mtd-physmap.yaml
+++ b/Documentation/devicetree/bindings/mtd/mtd-physmap.yaml
@@ -15,6 +15,7 @@ description: |
 
 allOf:
   - $ref: "mtd.yaml#"
+  - $ref: /schemas/memory-controllers/mc-peripheral-props.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 2d0cac642427..4aeecd0abb68 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -11,6 +11,7 @@ maintainers:
 
 allOf:
   - $ref: serial.yaml#
+  - $ref: /schemas/memory-controllers/mc-peripheral-props.yaml#
   - if:
       anyOf:
         - required:
diff --git a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
index ab9641e845db..38079e1b6a44 100644
--- a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
+++ b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
@@ -8,6 +8,7 @@ title: Maxim 63xx Watchdog Timers
 
 allOf:
   - $ref: "watchdog.yaml#"
+  - $ref: /schemas/memory-controllers/mc-peripheral-props.yaml#
 
 maintainers:
   - Marc Zyngier <maz@kernel.org>
-- 
2.34.1

