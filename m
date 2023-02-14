Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABD369610D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjBNKjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbjBNKjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:39:45 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC0A244B6;
        Tue, 14 Feb 2023 02:39:44 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so11230701wms.0;
        Tue, 14 Feb 2023 02:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekxDSggQEhQ7H1NkJge9cvo6SYMx9+I0A7x1Q/tQJSo=;
        b=hweHO2jbKLEYBnzJIcDq8JaPYzxv/MTxMwloUS5d8wcZPUWgLNHa7VPTMG4deBK5kR
         ILIwcNSV73+iydbWDKSEqxb9PaLRqL27RtVeVyiq/mB1HBHYhVwwdtsPkYGm7ePaOOu0
         2YDMUb4xb4jhiSqeb78HNh38cmDi5NpBYaKn3SmxO8lSxg37RbEk+Zxw0fBhLSvBcxxv
         FsMX9lluBzCeucOvd341nNoAB6eLsLLdgoyjkxsSbX2+fIbsrtjm1Q7mksWqDo+FhxvP
         VQcZ4AHjUAKaT6kwCt/fVXsLHBcsQNGr3kLl459KfHk4/lkg3QM1JOn3U/sZyvsHTbQh
         Qd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ekxDSggQEhQ7H1NkJge9cvo6SYMx9+I0A7x1Q/tQJSo=;
        b=7JTvFGPnuJ9Nhwoo9CDcrkZDHC8MyDMyFq7V3zRnAQvo2eybo91gSg9yyNgRkC3cyP
         p7/v9cJc0vHBV+4etQM6Czsl3dZ8TuvPbAbRdHHXcnf7LuxYWZkGrhXslN+O0IPhO8pN
         h8CTnb3GjD6DLQpqDf4I641QXjLw2LKRxHOsIqGDgxg8aj9B04HRS2v2fsnJiwWFyvtN
         gR9ndX88k4qwmEf2c2QClumITzJpPJuSJYWt2IGDvGWM3VkZ8a4vWljC7ycmNcXZD9k7
         9a1DF6e7SlaFxvE15uJgMo3dW1vweGU2mns3M7xpe6NnSbeWxqYXWoeyKC9HtYlOBiQU
         Q/RQ==
X-Gm-Message-State: AO0yUKV2LpDRsNSIK/lfljhGfO24ixWUST8NenEvjYdhpkRdGVa7ryky
        1lBcgv7hTY+CcKAO91o0wdG0K/KCcYg=
X-Google-Smtp-Source: AK7set87QWbytswcbk5ef/eFip2htvxUelGTmP3NtH6bAsafuVc7gj7Vp8RGeEdr8VEDMPBY1P9GPw==
X-Received: by 2002:a05:600c:1656:b0:3dc:561a:79d8 with SMTP id o22-20020a05600c165600b003dc561a79d8mr1546799wmn.35.1676371182460;
        Tue, 14 Feb 2023 02:39:42 -0800 (PST)
Received: from localhost.localdomain (23.red-88-10-60.dynamicip.rima-tde.net. [88.10.60.23])
        by smtp.gmail.com with ESMTPSA id v2-20020a5d6102000000b002be5bdbe40csm12693241wrt.27.2023.02.14.02.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 02:39:42 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v7 3/5] mips: dts: ralink: mt7621: add phandle to system controller node for watchdog
Date:   Tue, 14 Feb 2023 11:39:34 +0100
Message-Id: <20230214103936.1061078-4-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230214103936.1061078-1-sergio.paracuellos@gmail.com>
References: <20230214103936.1061078-1-sergio.paracuellos@gmail.com>
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

To allow to access system controller registers from watchdog driver code
add a phandle in the watchdog 'wdt' node. This avoid using arch dependent
operations in driver code.

Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/boot/dts/ralink/mt7621.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
index ac818fd721ae..3d16beb77440 100644
--- a/arch/mips/boot/dts/ralink/mt7621.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
@@ -73,6 +73,7 @@ sysc: syscon@0 {
 		wdt: watchdog@100 {
 			compatible = "mediatek,mt7621-wdt";
 			reg = <0x100 0x100>;
+			mediatek,sysctl = <&sysc>;
 		};
 
 		gpio: gpio@600 {
-- 
2.25.1

