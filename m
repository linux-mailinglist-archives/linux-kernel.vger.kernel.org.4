Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EF565A976
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 10:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjAAJVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 04:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjAAJVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 04:21:34 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC95162CA;
        Sun,  1 Jan 2023 01:21:32 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id g10so4497495wmo.1;
        Sun, 01 Jan 2023 01:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGM5YWcMUl/AKOA1Ej+/uSN1K21Yt+2nOh2g+QQjZ2Y=;
        b=J49sVIlCogAopBtUt1pkmMXj/RvX9Wds1rIU4GhIV/Ag14KaF6SBeYr9jW0E5SOkxM
         85q1JZVayVzhh76Ajv6bTTAWmkYf7cDzOAe0eOGpp+HdO43FZP1y8TGyTVnl93DGGJPr
         ZkwhCuduRsXpb+If11zuEOsBk+E2aB5ZgVLy6hifFYXsQpPzOW+sKGlO9oZlqxQd5D7I
         CnoVWGUAL547F80a/7p/WaiImi1F7NfEnwEKukgAFAYdU/jpEwXAEw5hPmiHxGrXELzy
         Y4NrwxDUi0hRcvjWnUvpVienrfLLpMcO3JrAfea61MIxSgsvbWm125PrndeC7TrmDMv1
         NgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGM5YWcMUl/AKOA1Ej+/uSN1K21Yt+2nOh2g+QQjZ2Y=;
        b=4nt3v9hNAhs865FEXbucHlX/JtP8He3l4giTMIAACRDjs5k32ULRVMyLaoIFeJTisd
         KCEl3enhi9+IICNfZG/6xPsS7i3EOhYVt8h/NKh8/4hAIiLNr5CGB2H9dnzfhsAKCUZu
         vbR74D53dFoJvawCSPDpUBWNkvjYf5eq0Ubdu4kMLfm5LoHeaZm7BkPttIedI8ncCSk9
         QhWh7mUYQ/nS1OMAEKvVJZAFWF5d6zwG9NM9f3uGCWl6lmWXqGYUo2/LqGwbwc9hWhV+
         xrlhFSh6fNoORWcaMTlGjnK6bbl1gSk8ngn88DuqFnPvD/yi/O4406EXUAV9BGFPZdIZ
         cH6w==
X-Gm-Message-State: AFqh2krqC5ruq1yUyBC65YOqv6mOcNm11MLs3QpOc4T7VUIp0DMhLzbf
        Pq+ei62q5S1opB33bshG+iQ=
X-Google-Smtp-Source: AMrXdXtZaieFheiEJbJbkSsAk1+KA/2iYj+M64zo8HqegJ/I5r7gR69yFolcID91T4c4eqvwITxdkA==
X-Received: by 2002:a05:600c:3493:b0:3d2:370b:97f4 with SMTP id a19-20020a05600c349300b003d2370b97f4mr30151839wmq.16.1672564891468;
        Sun, 01 Jan 2023 01:21:31 -0800 (PST)
Received: from mars.. ([2a02:168:6806:0:2624:83db:c4f6:846d])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c425100b003cffd3c3d6csm32763769wmm.12.2023.01.01.01.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 01:21:31 -0800 (PST)
From:   Klaus Kudielka <klaus.kudielka@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Klaus Kudielka <klaus.kudielka@gmail.com>
Subject: [PATCH 2/2] Revert "ARM: dts: armada-39x: Fix compatible string for gpios"
Date:   Sun,  1 Jan 2023 10:20:33 +0100
Message-Id: <20230101092033.45803-2-klaus.kudielka@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230101092033.45803-1-klaus.kudielka@gmail.com>
References: <20230101092033.45803-1-klaus.kudielka@gmail.com>
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

This reverts commit d10886a4e6f85ee18d47a1066a52168461370ded.

Commit 5f79c651e81e states armadaxp-gpio is broken in a non-trivial way.
Commit 988c8c0cd04d deprecates armadaxp-gpio for this reason.

Signed-off-by: Klaus Kudielka <klaus.kudielka@gmail.com>
---
 arch/arm/boot/dts/armada-39x.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-39x.dtsi b/arch/arm/boot/dts/armada-39x.dtsi
index 1e05208d9f..9d1cac49c0 100644
--- a/arch/arm/boot/dts/armada-39x.dtsi
+++ b/arch/arm/boot/dts/armada-39x.dtsi
@@ -213,7 +213,7 @@ nand_pins: nand-pins {
 			};
 
 			gpio0: gpio@18100 {
-				compatible = "marvell,armadaxp-gpio", "marvell,orion-gpio";
+				compatible = "marvell,orion-gpio";
 				reg = <0x18100 0x40>;
 				ngpios = <32>;
 				gpio-controller;
@@ -227,7 +227,7 @@ gpio0: gpio@18100 {
 			};
 
 			gpio1: gpio@18140 {
-				compatible = "marvell,armadaxp-gpio", "marvell,orion-gpio";
+				compatible = "marvell,orion-gpio";
 				reg = <0x18140 0x40>;
 				ngpios = <28>;
 				gpio-controller;
-- 
2.39.0

