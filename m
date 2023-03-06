Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DBA6ABF40
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjCFMOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjCFMOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:14:04 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B02B1EBF7;
        Mon,  6 Mar 2023 04:14:02 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l7-20020a05600c1d0700b003eb5e6d906bso5036288wms.5;
        Mon, 06 Mar 2023 04:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678104841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7p5DGlKwmRimZVfiR93bnlEzszSiteyjzg97cN2oOAo=;
        b=ohuzAEBj9rP7cgYi9TFIIVKq9iKrstPSWqplPOUpVgkFAPM1g0S+Owu+Q89uMSgZyU
         miyftmjCsKqdKyo3SShzaA5NMpP6fOBsBZmzDY8YUTs4idGsdwESoqfudXKnWmqHOg2T
         ID3Wj9DbFOB0LJ2HSDUSw/Xbqj81jDCLeh7SI8tirvEBnU5ASQssCraNjiJLQGr0HXiZ
         njR6J3rrTZhI2gUg/0kJe+hbCvsAnpteUwItyFuAxKfx4DUqRmPSWRe8Vq0ch6+7wfp+
         KKyo/1m8vj0CewJ8I1ZsBWanvUKslJcI0m0V5YReDclx4fm4fgui9PmaoqFtVJQnvjg/
         wElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678104841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7p5DGlKwmRimZVfiR93bnlEzszSiteyjzg97cN2oOAo=;
        b=olTeH/2X1uU16i6Q68TL6c7A6v+XKd7SPellDuyvaPnw62EcVxaqJPM75u/2R/eT4M
         rFUKs3vzbwl/uPaWMaW6jRrRWokKHacVPE5u6TP832Id5Veqeoya7lPS0AyeeKP5XgnQ
         PJV1+rdrdaQvU4wp8Z5Co8bx0ARwfMoM9jEyLxyhctcMYZO9Qly5MP5jfhY3G5Uza+PH
         5CYt/DKHZSBu5GsCcaG1aTSvS846KEDey6r7b4ojuXig+ZYA7NR7iYn87VflaEAXxQlP
         1wtYesmd7dWnrZtLB1b3S5f1hiCuwqlJ0ljQbEuIsbSnbwnX9sahSNfqnxxS3pgImKnI
         aMVQ==
X-Gm-Message-State: AO0yUKXwv7pIjhG57SxGGqRUnmLdFEZe6cYYtkLA2S0XMbp7rev4Y5kN
        dVa0sZqO2q2DBBOz+ZSWFN0=
X-Google-Smtp-Source: AK7set9QWbq9KwaBnJ+zVtHzm+bRIjEdMLdmdF747zrVXwb/zaVDARkqjvDvKsJqw+i4hzWGc8KyAA==
X-Received: by 2002:a05:600c:35cf:b0:3de:a525:1d05 with SMTP id r15-20020a05600c35cf00b003dea5251d05mr7296373wmq.8.1678104840984;
        Mon, 06 Mar 2023 04:14:00 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d660a000000b002c70ce264bfsm9814798wru.76.2023.03.06.04.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 04:14:00 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Ferass El Hafidi <vitali64pmemail@protonmail.com>
Subject: [PATCH v3 2/3] arm64: dts: meson: gxbb-kii-pro: complete the bluetooth node
Date:   Mon,  6 Mar 2023 12:13:50 +0000
Message-Id: <20230306121351.1606360-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230306121351.1606360-1-christianshewitt@gmail.com>
References: <20230306121351.1606360-1-christianshewitt@gmail.com>
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

Add missing content to the bluetooth node to align it with the content
used in (all) other GXBB dts files.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Tested-by: Ferass El Hafidi <vitali64pmemail@protonmail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
index 73ad0f5110f3..a800e8955c4a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
@@ -71,5 +71,10 @@ &uart_A {
 
 	bluetooth {
 		compatible = "brcm,bcm4335a0";
+		shutdown-gpios = <&gpio GPIOX_20 GPIO_ACTIVE_HIGH>;
+		host-wakeup-gpios = <&gpio GPIOX_21 GPIO_ACTIVE_HIGH>;
+		max-speed = <2000000>;
+		clocks = <&wifi32k>;
+		clock-names = "lpo";
 	};
 };
-- 
2.34.1

