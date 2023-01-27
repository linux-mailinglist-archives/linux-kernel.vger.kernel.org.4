Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D7867E81D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjA0OWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjA0OWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:22:31 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B05F7F31A;
        Fri, 27 Jan 2023 06:22:30 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id t18so5140648wro.1;
        Fri, 27 Jan 2023 06:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDAPnltMdRm1ugUQxshJ1/bx7aojXccJ0679qqZoo0Q=;
        b=kAeJjQWJNHE8CQ+467n+ObDLeH4XMup0tRUWzagdgBA/kl4NBhb8rC8PA/xHCUQlMx
         VpKIlKn6ZJpAeVDDSdCq+1opeE2lagO1r0FrrS4n2JvsLRBPSgk+HcnCsNZ4Xvqy6BMt
         Ns+FWpszlBigRvayDY/W4ZdHNGimw9x9VL2s2uJysB659gpPvaCfu9RSuipnOYmlb42s
         gErKWigh8MzVh/4ynTUMRKjhpEn7JhoZXCH4AZm0UETYnpfVE6wERUnsDydgHYmjYfd6
         7giwlAJThu3O00H3BdSUEDhMNkDBtScm8BmXk9arnw+PI2ZC/aPjd5b0EXDM3xVPsAEM
         DnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDAPnltMdRm1ugUQxshJ1/bx7aojXccJ0679qqZoo0Q=;
        b=6JZKpOk1IoVJvbmJMvOTAiqoJRxVn0t9sq1gaViQuSed8X/rl05ZQGwiqZGJ6xUWmz
         l+/tJwerzZtEoL/Rl9zdikrbdv/uSpa25zBJda31zC8IxVS0pr82FIgHEv5vYuM8tQrc
         3q/oO0thGicXVXAO+Ms5oBIElUILuWGxJlN0Wtc4LakZteywHRy7aTt9KkcBE72VbI5C
         2YB33SHkazEv0HfbikwKuUrg57N+UPTKLdd48eS4zUnoUS19fo9wcqmxagIW+z8NVh7I
         TVDSfd0FwpGwGVuNJzNvl/yrHp+IdEazqiFmPYWXsPWBNaUCmeL9I91o++HEZdLm+dHe
         5dwQ==
X-Gm-Message-State: AFqh2kpYuG63NhanowcWlHZr3wqPLxANKRtpyI787GMiPoQQvcRQqvzF
        Ho2NYT8ceGm1SaDip3MgQf8=
X-Google-Smtp-Source: AMrXdXuPgItqz2YFvhsDQUBsxBJbBa6hpjC4Ng9uwYW9LPS5ffYmGUsO6XjxmQBMsTS0MoiexZGNqQ==
X-Received: by 2002:a05:6000:1c0e:b0:2be:5403:45ef with SMTP id ba14-20020a0560001c0e00b002be540345efmr27000772wrb.6.1674829349079;
        Fri, 27 Jan 2023 06:22:29 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id c11-20020adfa30b000000b002bfb5ebf8cfsm4301039wrb.21.2023.01.27.06.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 06:22:28 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 1/5] arm64: dts: meson: bananapi-m5: switch VDDIO_C pin to OPEN_DRAIN
Date:   Fri, 27 Jan 2023 14:22:17 +0000
Message-Id: <20230127142221.3718184-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127142221.3718184-1-christianshewitt@gmail.com>
References: <20230127142221.3718184-1-christianshewitt@gmail.com>
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

For proper warm (re)boot from SD card the BPI-M5 board requires TFLASH_VDD_EN
and VDDIO_C pins to be switched to high impedance mode. This can be achieved
using OPEN_DRAIN instead of ACTIVE_HIGH to leave the GPIO pins in input mode
and retain high state (pin has the pull-up).

This change is inspired by meson-sm1-odroid.dtsi where OPEN_DRAIN has been
used to resolve similar problems with the Odroid C4 board (TF_IO in the C4
dts is the equivalent regulator).

Fixes: 976e920183e4 ("arm64: dts: meson-sm1: add Banana PI BPI-M5 board dts")
Suggested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
index 028220ed45ad..3c1267a7ffef 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
@@ -123,7 +123,7 @@ vddio_c: regulator-vddio_c {
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <3300000>;
 
-		enable-gpio = <&gpio_ao GPIOE_2 GPIO_ACTIVE_HIGH>;
+		enable-gpio = <&gpio_ao GPIOE_2 GPIO_OPEN_DRAIN>;
 		enable-active-high;
 		regulator-always-on;
 
-- 
2.34.1

