Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0D9692F16
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 08:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjBKHeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 02:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjBKHeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 02:34:10 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EF028866;
        Fri, 10 Feb 2023 23:34:06 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id n13so5363956wmr.4;
        Fri, 10 Feb 2023 23:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVRb8cmWOFqU9n4+7sFTWzjVPS3DujkHQ/+pnVD+RAM=;
        b=EsUPcIoTv12ndczXEyY8G3j5BCqL4EGj9zTY3O8JFJrnrOzHAxtyx4rFYcxDezgORC
         mlMgbiGd7V5AxOw9Z8GIEa3shiwWGAEBq3rnplqtNLWBGFtFOh7NLa/Q3tVfS7DNTujd
         2+h8ucJumps/3T/FNWEBm+bWfoRxbtfd6U8wEk4XB7aK6GbFzqkzCTwM4xlZvhG3+JNC
         Q2t17VZVkkXtYl4Y9xDz2XR1fxJ/GhDfWk0vhh8ScWh52LDBaV2rOoAaawYZS0Ij2X/u
         H1Mj745u0kJu0aLhvKoQDu5pz/GCbkc9TwkTsg0NYIBF41Ndd8O8pqoAP1Wq7XLW5dI3
         pFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVRb8cmWOFqU9n4+7sFTWzjVPS3DujkHQ/+pnVD+RAM=;
        b=OH4hnzKjOfT9w8/GGIqkiSOQnX/GsV8Kd9v8GXnA03F6mAXCX5/ouhHM+IyMLJCquS
         PiTTtZtTDVtdVa/TdxCDVl88hXjD/IROLXysV/sUUgh0bOb34DBSjzpew9QJ0fj4WaMm
         v/rjCwubqJHZ0HeQj64NN7b06eg8Ev7xFhFYlBIsNB2rh7XqoIZQeUheiVSXDZYoarhw
         GwKaIksbaG3ZVBmQ3nwFIze9V9BTVj9BYVxw7JXxqgcndsH/tAePKx5ezKpTwC3SNKke
         f/5R64QcKTB3ndgPndtYQ7WnhYorgHzmufoeZfvIS1k9aezWcVtSwCbnd/1kUAFTioON
         R4jw==
X-Gm-Message-State: AO0yUKXEhRzEXturGDCXr6KpWa6pQmEp1GQAva95jr/qVTkUud8Xm5bU
        hAX3hdQjAQOPkUrt/Cl8XYlrozR1eJM=
X-Google-Smtp-Source: AK7set/uHYB64dWcXKWq6/xg8SKAKSDXYYqo/RaXqR1A3Tvra4Coz9kalYEBsgZFp3s+xNlGNCqteQ==
X-Received: by 2002:a05:600c:319b:b0:3db:8de:6993 with SMTP id s27-20020a05600c319b00b003db08de6993mr562560wmp.4.1676100843864;
        Fri, 10 Feb 2023 23:34:03 -0800 (PST)
Received: from localhost.localdomain (23.red-88-10-60.dynamicip.rima-tde.net. [88.10.60.23])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b003daf681d05dsm7917829wms.26.2023.02.10.23.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 23:34:03 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v4 3/5] mips: dts: ralink: mt7621: rename watchdog node from 'wdt' into 'watchdog'
Date:   Sat, 11 Feb 2023 08:33:55 +0100
Message-Id: <20230211073357.755893-4-sergio.paracuellos@gmail.com>
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

Watchdog nodes must use 'watchdog' for node name. When a 'make dtbs_check'
is performed the following warning appears:

wdt@100: $nodename:0: 'wdt@100' does not match '^watchdog(@.*|-[0-9a-f])?$'

Fix this warning up properly renaming the node into 'watchdog'.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/boot/dts/ralink/mt7621.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
index 764916eaf..3d16beb77 100644
--- a/arch/mips/boot/dts/ralink/mt7621.dtsi
+++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
@@ -70,7 +70,7 @@ sysc: syscon@0 {
 					     "250m", "270m";
 		};
 
-		wdt: wdt@100 {
+		wdt: watchdog@100 {
 			compatible = "mediatek,mt7621-wdt";
 			reg = <0x100 0x100>;
 			mediatek,sysctl = <&sysc>;
-- 
2.25.1

