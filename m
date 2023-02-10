Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABDE691F1E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 13:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjBJM2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 07:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjBJM2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 07:28:32 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C15735A5;
        Fri, 10 Feb 2023 04:28:30 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id j23so4959277wra.0;
        Fri, 10 Feb 2023 04:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glqZSh8z1DjmHlU5auQAlpkpEjpKVs3OPkg4NeOXn1M=;
        b=apR+vpK19609mIwWsOVMpmcME0xNCu1tzifaKj/fHrxo5zHyutgJvE/y1iksbrWioU
         7Eu/iZKcemFG1ii7R1VX7st0jR/wDAKE2UCdb6vqQWagGCzGDjsbVKSzbPZ7+plD7EN1
         13gXeoHDz43EwIy/2hdWMgBAzEhTPJNo1wg3M3V6e9j+TtxlGGqFGtqXaLquELtkKbRc
         W1eAy/AtonsgvrUOJA+9JzkHrgiQ4UJsi8WKuDNub6aNo1HN6Pxn/uqc7v05T8JqNWmO
         wEwnEdRLZRReVNWt7hVuzSLTVtWXQQJJRGVQ9hf4vvr5CUFMlbql4QkfcF4uFFthQNYD
         dQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glqZSh8z1DjmHlU5auQAlpkpEjpKVs3OPkg4NeOXn1M=;
        b=iNEQB56eM4aTv6Gys28pO10SuyPaPesfhNuQBZOGrWezCO0LHsK7AL7lsZ9AFmPygf
         d9u0nY/UYWnldB2xtxof5RkJHbPq22+qhSRVdJ3qAP8cBKn2UFP7vpylk+mdXMkdKIMD
         sagsqetI9ozee5PKxG+cC5anCRYALJB5iW0mga7Jf0hW85BP0ReWhR1PPGJubHhvaXrE
         oIUTFFg9K9UfXHwev5RZvB+iGIq678uMhIXhmn/s4RypCJAGycLFDtX61rOOMgsgByM9
         qIVlybFAGQ6WfOGL9/8mL+UVhJbDQ6Scrfqrp3N29Ye5VxZ8/RLejEcyaGh8nQHpRqz0
         a6Ng==
X-Gm-Message-State: AO0yUKVgbM3FHX62trBfWczVnfgZF5AqYeLYBDffRV9mR+31aRNoXvEU
        9qbpLb8QPlRZktKdtAyc6GU=
X-Google-Smtp-Source: AK7set/+DWrghsFar9DtLynYL/yBNRLOaDwUQHTKmG8xM5HBuG5OrBk4olLnD9KJF9UuRbz0+Pq6zg==
X-Received: by 2002:a5d:4852:0:b0:2bf:d610:e49 with SMTP id n18-20020a5d4852000000b002bfd6100e49mr11802874wrs.16.1676032109400;
        Fri, 10 Feb 2023 04:28:29 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id i8-20020a5d4388000000b002c5493a17efsm1540989wrq.25.2023.02.10.04.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 04:28:28 -0800 (PST)
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
Subject: [PATCH 2/3] arm64: dts: meson: gxbb-kii-pro: complete the bluetooth node
Date:   Fri, 10 Feb 2023 12:28:16 +0000
Message-Id: <20230210122817.1027765-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230210122817.1027765-1-christianshewitt@gmail.com>
References: <20230210122817.1027765-1-christianshewitt@gmail.com>
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

