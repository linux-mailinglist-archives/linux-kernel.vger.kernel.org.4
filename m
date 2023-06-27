Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A48073F706
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjF0IZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjF0IY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:24:57 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213571991;
        Tue, 27 Jun 2023 01:24:27 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fb7acaa7a5so2173531e87.1;
        Tue, 27 Jun 2023 01:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687854265; x=1690446265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pjgEmaLZWbZLKm+zTsTjeEOP7/LCJvRIUhdiZyAT1I=;
        b=TE7f+u5TbI/yG0U+0SyVxyNL4Hk/MPzSwlErkUfNEC8YTRK3M1Vh7mPhmv0rZ7kfQU
         eRR7Ws9gTUZrwfagnu/E8dW7m7MXunWK65JTfquV2cc9qrwQW9GAqTjFQ/sBJX/ptFFK
         p9Awmdhm1YRA+PHkhZwDZI2+y9MP6ZXjxD5pgJe/MN5RqTZsvtkZufqCVro47pOi1WjH
         t6wKmtgRLmGI322xF27HOIye6IcvL+bV0LnBKHknVOKOxDAC+tLsgqxWFGRXVehVaDvD
         RWxTDMdvb8628zNsTAS7lxudN343CwebXvd50Aox32mctKzNVLexHf6BPNPJ39cBB48T
         vc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687854265; x=1690446265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9pjgEmaLZWbZLKm+zTsTjeEOP7/LCJvRIUhdiZyAT1I=;
        b=BtQ5WL6NhPn5Lu6NdK7lJTLHZmYS3TCe5OPsYz+f37cTyUFeH5f6rxcTtp9M8WwT0X
         8rTjobwTueSd9HYpGWulmReJ1Ep1ygLDLX2PAh7+ddwky//HUB/gqHf1cz46DfR6pBg1
         d9BubyrzG2kLwicgSGSJRMkwuoHNEaV27+bNwLdAjI7A62fNB37aK7Q9e9z8DzgizWjH
         +QvDtPUcB0QBwdcHgd+tAPPMcvz7EltiDuQyS40dcQ6ysUyql/n51JjmsakiXQsIre2U
         mBN47qTsVv8g9yBnOliepTnMfu6bAb+e1DbrFgr9HUJ7ZvwTaScIpMia9pJn4naqn58M
         XGKA==
X-Gm-Message-State: AC+VfDzrljVxAr+RK7znLHyPDyTViXOLm0z2PtwQlJ8r3yikvShOJw1h
        VsQ//9HG27kAe8dtOBRIcCwmtDlGGizLRfo=
X-Google-Smtp-Source: ACHHUZ4vz531eTh8MoQqbWPlqMxY7J/X7ms73AZisnK4IJIfmP73nvAIsdUP/6rmmWoOTpA9+n88FQ==
X-Received: by 2002:a19:434a:0:b0:4f8:6e1d:cf98 with SMTP id m10-20020a19434a000000b004f86e1dcf98mr13755647lfj.66.1687854264719;
        Tue, 27 Jun 2023 01:24:24 -0700 (PDT)
Received: from localhost.localdomain (mail.pulsar-telecom.ru. [94.181.180.60])
        by smtp.gmail.com with ESMTPSA id i12-20020a056512006c00b004eb12329053sm1420673lfo.256.2023.06.27.01.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 01:24:24 -0700 (PDT)
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
        Andre Przywara <andre.przywara@arm.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 3/3] riscv: dts: allwinner: d1: Add pwm node
Date:   Tue, 27 Jun 2023 11:23:26 +0300
Message-Id: <20230627082334.1253020-4-privatesub2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230627082334.1253020-1-privatesub2@gmail.com>
References: <20230627082334.1253020-1-privatesub2@gmail.com>
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
 arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
index 922e8e0e2c09..e24543b6aff7 100644
--- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
@@ -127,6 +127,17 @@ uart3_pb_pins: uart3-pb-pins {
 			};
 		};
 
+		pwm: pwm@2000c00 {
+			compatible = "allwinner,sun20i-d1-pwm";
+			reg = <0x02000c00 0x400>;
+			clocks = <&dcxo>,
+				 <&ccu CLK_BUS_PWM>;
+			clock-names = "hosc", "bus";
+			resets = <&ccu RST_BUS_PWM>;
+			status = "disabled";
+			#pwm-cells = <0x3>;
+		};
+
 		ccu: clock-controller@2001000 {
 			compatible = "allwinner,sun20i-d1-ccu";
 			reg = <0x2001000 0x1000>;
-- 
2.25.1

