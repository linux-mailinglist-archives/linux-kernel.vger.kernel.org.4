Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC55692404
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 18:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjBJRHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 12:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjBJRHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 12:07:39 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FAD77BA6;
        Fri, 10 Feb 2023 09:07:33 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id o15so2402284wrc.9;
        Fri, 10 Feb 2023 09:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NShXRZ//vQQKtuVXg+FNEbyRHYKUYaCN+nMk9xF7QT8=;
        b=JwUX0eWxUb22c/W1Rd79586QKOgA79JbHl85PxJ02XMrWaq8ajpRNZKj34tLSdRpZv
         hXsDQ7Ulpdr/XpbqCX3XtacFCLPbotVxFiUmFBg2pOihgiEvOkh/u3c7oYfV7kNloIgf
         eYBW+CqEQ+p7ykFl98rXNTYaJCDpe10b0iFh1/LBGBgQP60EVYIq+DaB9py8uXzAztvl
         /7aHWnwMcDlV1F/4CYOAzukoYY4JtGObuthixAncdXepCQMqKmf15yl55xi7e/arjPrF
         s6zc59yqX4EnJgFtYrbWVMutfcG+KNYE4QX+ZrVugh3sBZ9oPPosL10sizWl0nhMJ4Qx
         6gMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NShXRZ//vQQKtuVXg+FNEbyRHYKUYaCN+nMk9xF7QT8=;
        b=rQjolyFyEHIJX7fyFBD7Tlderzf47xGRMR45mOjW+P6Vr3QEEAsPwZFv9yWR1ycEeD
         Cb9yhj4W2Rmbc4gRvxamDodlmFmmE5lp+XQHtH18qPN1k0RDIlm6gfjSsI0rAxbYRucn
         mKZZOp0oW3fxc1hnDAS/nqo4XmAy16+/j8CvUhpNiT0F/FlWzm6+g/2fMzdCYIzzmkFW
         hsFlxYsg8gsn4Wp6nJ3aj6EJN4SqwzoY/NZ/LVAr1iyg0rvf/QLkFe1/pLZsBOlZOAOR
         Bu39dllFweW7lnmh5MZDj3fmrPUOzMV1rJedkJkc+z+4jZmAMiN8O6uiOH7yPUNggNgY
         T4Lg==
X-Gm-Message-State: AO0yUKXDXIaHE5ni0fxQFTgUDEWic6OJsXdVbOdzDwda7F41SW/WxaEF
        bKuwB9gB9LCeeddVzs2sfsY=
X-Google-Smtp-Source: AK7set/zf30D4z7uo6XAFo0iaaixvySpn6xO4O7pHkonAWBs++Ll7qHK6srUdwjQKspCgca9vYhNlg==
X-Received: by 2002:a5d:508d:0:b0:2bf:d776:1c97 with SMTP id a13-20020a5d508d000000b002bfd7761c97mr14126761wrt.43.1676048851945;
        Fri, 10 Feb 2023 09:07:31 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id x7-20020a05600c188700b003cffd3c3d6csm5351531wmp.12.2023.02.10.09.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 09:07:31 -0800 (PST)
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
Subject: [PATCH v2 2/3] arm64: dts: meson: gxbb-kii-pro: complete the bluetooth node
Date:   Fri, 10 Feb 2023 17:07:20 +0000
Message-Id: <20230210170721.1285914-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230210170721.1285914-1-christianshewitt@gmail.com>
References: <20230210170721.1285914-1-christianshewitt@gmail.com>
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
index 9bfdb54d912a..435ae2aa404e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
@@ -72,5 +72,10 @@ &uart_A {
 
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

