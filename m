Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA6D731BB0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344932AbjFOOpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241542AbjFOOpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:45:39 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E781D294E;
        Thu, 15 Jun 2023 07:45:35 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f61b45ee0dso10748465e87.0;
        Thu, 15 Jun 2023 07:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686840334; x=1689432334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wV92pSpCVmnx9n4E1q+MRb4GksMGgD+y07OYM0/qT58=;
        b=aIzfv4Mjupmq37gyHvFs8F/LSK3Xj9YVHKM2j607IKnuOkrvGZAVssXNMRXeWX+dmV
         /AABX0+ICsavEYJX+R3R3oC/NUjWUAt54gfecZ3dQ96G9nKrk4AmGMC0G7j9Lbv1SgaH
         HquSTWXbpgXY4d8vkgRan3VK+R5OFrH+2Tzl6vO74LPZSu7DHUE/j3uzddwaTKvx2H/t
         5202qourcPHXWuCglvCP6CdoV+V9kEbAap/hK6RIej9iv8rZpwVYy0hFRMU8uItAvMrz
         5CsyEKHBt1Sfnna5pi9Im9hGJRY1hJVT/ZiTBhH9OukB8sEog1MjIDrMhfm4o4YpicQL
         mQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686840334; x=1689432334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wV92pSpCVmnx9n4E1q+MRb4GksMGgD+y07OYM0/qT58=;
        b=UAIVFo7qfg4ejUsezgWLlRjiFd7Ze5lYvELDHff4zg5nY0R19NQycCM2T1vQ1MpMn7
         1KkkHBgaEUaVj4YbGzp2qRC8MgcNHbYuen4YRi0EgRd19Rlv+wNqtfI+GtiC4BKx4lZi
         GElieDKpKXDR2vZhqeMYoiJT/8et/j8HlgPrih5xskj94u34khXFIvs8GsXJM7ZDiJJT
         I4/dce4DVxi90Rl9svUbp/nkKnyBryssNlJ5aED3k0XHFUeUIRRTb3U9qknzlWwE0MAJ
         zPgEzItajHPEbQFmAutzjwrw1kblqdcdToShWZPp12/dsbI0S4HTuvdNBdTSW02lA4iV
         d20A==
X-Gm-Message-State: AC+VfDyhcdb4qdd9KtOUM0Nz7aWoviG2AMKGNZbPaBICKWlLsqhzcm04
        eJ+q9THAuGqyQl9Qra6/SQa0UCIremN2xU9Djw==
X-Google-Smtp-Source: ACHHUZ7JCXFEpcyRUkA34U51/Dy11OR5ITEbLUmrZUsxSsG6Is9Uo9yDnK3rcDKYLGftkk2WwnqeoQ==
X-Received: by 2002:a19:e01e:0:b0:4f8:4348:e000 with SMTP id x30-20020a19e01e000000b004f84348e000mr1324141lfg.13.1686840333381;
        Thu, 15 Jun 2023 07:45:33 -0700 (PDT)
Received: from localhost.localdomain (mail.pulsar-telecom.ru. [94.181.180.60])
        by smtp.gmail.com with ESMTPSA id h7-20020ac25967000000b004f13f4ec267sm244451lfp.186.2023.06.15.07.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 07:45:32 -0700 (PDT)
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
        Maxime Ripard <mripard@kernel.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: [PATCH v1 3/3] riscv: dts: allwinner: d1: Add pwm node
Date:   Thu, 15 Jun 2023 17:43:58 +0300
Message-Id: <20230615144423.828698-4-privatesub2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230615144423.828698-1-privatesub2@gmail.com>
References: <20230615144423.828698-1-privatesub2@gmail.com>
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

