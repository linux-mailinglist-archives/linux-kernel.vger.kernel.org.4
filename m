Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFFE692F0E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 08:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjBKHeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 02:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjBKHeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 02:34:09 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3091CF48;
        Fri, 10 Feb 2023 23:34:04 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso5593155wms.4;
        Fri, 10 Feb 2023 23:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2xLyJ53huQXvmhIZNGemIcemfb0LptCrFwxhBre8f0=;
        b=nc53IyZLnmhvc74W4zDkK+Mcte68rwcfHhr1kVA84eFIf+6fG0aJfFPJpwRYLheq3d
         RXBDThvOUW2agefnaD6muBg8jgCa7BkPODnVobIuFD8dpUseO286v5LtX+UR5U7MuO9m
         fxWW4kH4Y+66nAd0U4wAVAPW3dEXl01K1n/fH6PG+ZbqbQ+/Whsj1HuBn2+IvlFJdWzb
         91XkBHG/F9kbmgiyQaqKIx3vdK+YKkrTzhDJO1oXiIC8gic6i2WDL0uVL3kQUxJiMRAl
         T9dRp9VHetMex4EgDU4mN8ruCPw+Z68zHYdD8FToNQwOqxpISIDnGa122LZSTeq9YIGZ
         vLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2xLyJ53huQXvmhIZNGemIcemfb0LptCrFwxhBre8f0=;
        b=AXZiPjz7PWFztXsVs+xS5kWqplxarW5YMYOaJAo7lfHEgnk9z8GFfdf1l57fkEs9j2
         jLRYHHbLhArXTcz+qpy0bs2rGgIMQQHOyzJGevUKl6jvcsDx/f5c3qdRlTdRthRjI2JK
         SFC9yUComQalPj3W9kveN37SPdt4IJX8hZ/952R4Q9O5Pz5hjteeNcuVSGRVzVRpoI+7
         zyLJnuFWB/ZontSqp2C02nr12EIgy8WZ03BtZlrjM1G7zPiCiX374ASZNwoNKMF3ghdw
         p4encyQmytrld5RCZEhkwp/QexWFmXJlLiQTye5JykLxVNeVlxEcvZe20Uz7zrcSQz/n
         1Afg==
X-Gm-Message-State: AO0yUKXMVb3LfLVoLXUtXaUv7rxqZFoQ2bdlz1amP14mfXLRx2/KYNom
        nbf04BNsJZwfuhV3S6sDE6Dialz8j5g=
X-Google-Smtp-Source: AK7set+5U8eANFbrGx5rWx2jKG8XMhxyEUTPapURmlBhvDbErJNk1+B6dF+JZoiz9mdNQappXVF7JA==
X-Received: by 2002:a05:600c:319d:b0:3dc:5950:b358 with SMTP id s29-20020a05600c319d00b003dc5950b358mr15819171wmp.14.1676100842669;
        Fri, 10 Feb 2023 23:34:02 -0800 (PST)
Received: from localhost.localdomain (23.red-88-10-60.dynamicip.rima-tde.net. [88.10.60.23])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b003daf681d05dsm7917829wms.26.2023.02.10.23.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 23:34:02 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v4 2/5] mips: dts: ralink: mt7621: add phandle to system controller node for watchdog
Date:   Sat, 11 Feb 2023 08:33:54 +0100
Message-Id: <20230211073357.755893-3-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230211073357.755893-1-sergio.paracuellos@gmail.com>
References: <20230211073357.755893-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
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

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/boot/dts/ralink/mt7621.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
index 5ca40fd21..764916eaf 100644
--- a/arch/mips/boot/dts/ralink/mt7621.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
@@ -73,6 +73,7 @@ sysc: syscon@0 {
 		wdt: wdt@100 {
 			compatible = "mediatek,mt7621-wdt";
 			reg = <0x100 0x100>;
+			mediatek,sysctl = <&sysc>;
 		};
 
 		gpio: gpio@600 {
-- 
2.25.1

