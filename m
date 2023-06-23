Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4625A73BB2C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjFWPKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbjFWPKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:10:10 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBD61BD8;
        Fri, 23 Jun 2023 08:09:55 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f86e1bdce5so997589e87.3;
        Fri, 23 Jun 2023 08:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687532993; x=1690124993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wV92pSpCVmnx9n4E1q+MRb4GksMGgD+y07OYM0/qT58=;
        b=sXiFVh8mY4yRjMQ5IDRS3cdjZB3EQPHWCuZIj6T60Sk4ybZiSnmXIs8m6+e0J+kRXR
         QyWq6q/MRb3rSbsQGNAkCkPh087W0VWgSiSo5ojaGLCHomXibYIGnq7aLHmKjkx7/864
         lMSIZEHjuVmaivRjWAiG3+vqrRHCwculvuB73JKZcDnWDXNe5fyW+7oymLyl5Hyt20eA
         JQIAm18JoJefEQUpn7wf5z9ZFwjb+W/r7RTHOalryMcC1FF6V5cm8EWVk2J5NYJ4wJH7
         1JBhZLJqTXRGbgoNm8qWTFOfPNrogHwSYD4uQtCp+GDPDOE8pUwYI+vzJXZdMS0KBLys
         dNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687532993; x=1690124993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wV92pSpCVmnx9n4E1q+MRb4GksMGgD+y07OYM0/qT58=;
        b=KV+xgkLskb//ZCLWge8kWlcfECmRSK7nx6hJAX1gRs8xr+UabBE08rwxqi5B6cfNb3
         dareYpDYpD0r57Q4a5RbMb5yzJSCyrVL/G/EOS7CUP1X6z4o1R+OTeeMlJCSXX+v6anv
         dVduhnoi+CpPspUB7XWYgejW5nEU5aQt54YcLydxXKjH2BN1HEZsQUU6E60OpyFGNfCa
         o2/xsQ94HIzopTfKOpE2nTA8ZlVu9pveSx6S+RzkYnwVPnPDbDjboxgBrkO4mSE0Yrb+
         Hc+EN1iLwxc1/NMP3uE435PJXRAW6easOyzlD5+UrrzXbeimpZwY6OwSb+g0kle0imgv
         NVpg==
X-Gm-Message-State: AC+VfDwVLzx9KfXudTuOnct/ezxdDQy5ct0rmPlqDmYw3Mk6AJyFRk6C
        Nkbtwo1j/JQ3OIKB552VgLqwpeGsV+Mi
X-Google-Smtp-Source: ACHHUZ7z54b932g35QQQnfiEtWSCAb/7Udc6dQREd6ky5WQPL1j9+L467bjzNGx/Y3G3O42+0hDICg==
X-Received: by 2002:ac2:5f93:0:b0:4f9:d9d:eacb with SMTP id r19-20020ac25f93000000b004f90d9deacbmr7825166lfe.8.1687532992750;
        Fri, 23 Jun 2023 08:09:52 -0700 (PDT)
Received: from localhost.localdomain (mail.pulsar-telecom.ru. [94.181.180.60])
        by smtp.gmail.com with ESMTPSA id w25-20020a19c519000000b004f842e58d08sm1465686lfe.84.2023.06.23.08.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 08:09:52 -0700 (PDT)
From:   Aleksandr Shubin <privatesub2@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Aleksandr Shubin <privatesub2@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 3/3] riscv: dts: allwinner: d1: Add pwm node
Date:   Fri, 23 Jun 2023 18:00:01 +0300
Message-Id: <20230623150012.1201552-4-privatesub2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230623150012.1201552-1-privatesub2@gmail.com>
References: <20230623150012.1201552-1-privatesub2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D1 and T113s contain a pwm controller with 8 channels.
This controller is supported by the sun20i-pwm driver.

Add a device tree node for it.

Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
---
 arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
index 922e8e0e2c09..50f0f761527b 100644
--- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
@@ -127,6 +127,18 @@ uart3_pb_pins: uart3-pb-pins {
 			};
 		};
 
+		pwm: pwm@2000c00 {
+			compatible = "allwinner,sun20i-d1-pwm";
+			reg = <0x02000c00 0x400>;
+			clocks = <&dcxo>,
+				 <&ccu CLK_BUS_PWM>;
+			clock-names = "hosc", "bus";
+			resets = <&ccu RST_BUS_PWM>;
+			allwinner,pwm-channels = <8>;
+			status = "disabled";
+			#pwm-cells = <0x3>;
+		};
+
 		ccu: clock-controller@2001000 {
 			compatible = "allwinner,sun20i-d1-ccu";
 			reg = <0x2001000 0x1000>;
-- 
2.25.1

