Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16AC743B85
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 14:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbjF3MGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 08:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjF3MGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:06:05 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA40F4203;
        Fri, 30 Jun 2023 05:05:27 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fba545d743so20409965e9.0;
        Fri, 30 Jun 2023 05:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688126720; x=1690718720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wW4HxCYnatcP/vztbzCLoFkbFaiPGRf9h2XT9nzoMiE=;
        b=VMutcdnOHcriAlE+V2oVuSLEZkP283yTDLN5t6c/yEHifGOtsPHZ0SiWEWs3WvFCMo
         AXDE2kzOIFrcBIfHkiU3sXEUVXK3bxCuUtBm64a+pX8OCRf69cQ5Dj+tkXD/hQMdaaNZ
         xB1SpI4kcKPKUx1aGyAOk5fWDXJbbW5qt+dXBpc9xNGNs/Q26UjSkAsyKuB0lYqPZn/4
         eRQlDAN6b2a5kp8wjrwmyxzNIWfzyQT9R5Z7Cu80k2BVzjhcKBaEG2ZTJSjXhrEJxG4l
         njAtczOuJeQ6GiH0qAlj1hT5jAmhza91Pk/gx9m/si961e34XynbZT9Ms7Ryp4SqGmjc
         Q7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688126720; x=1690718720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wW4HxCYnatcP/vztbzCLoFkbFaiPGRf9h2XT9nzoMiE=;
        b=RyQrQYaAC3kRNNEhYJDQxHL8U/snBcainMpdQCaCDGO4ZMiJI4W85w1nMK+hT+gk9t
         s8/0Yuj0FXvAvDoJru7HWOTcGsEWBMk2YGA0Pvjcar5Oa+abopIPOSCQTICQwJx0KtK9
         DLs+i5qjdn5MjgpC6y7XDk1gh17Ng2x6jKUSFtf7PCAS6Oxl/NUfokpUscLI/mkBnH4q
         IBwz3osuECoAzjfMqvwan3YqLeulTauV4f+kF5RJCyhVa/taUOBUXvnvgWnrbjtMUYOn
         AqG5MI0XTQdPZp5uVsRXR1eR38PLCCMgfVp2d3TS30P6fY4WIr3dO7g6uEzlvWavtAks
         UryA==
X-Gm-Message-State: AC+VfDxtsVr8fKcS1cR8AuzG3P0z5iYIxVBUCeVMpgaeSRIA7+W7Q/+Q
        zWUn6TRMr9zzWq4dzX6G7H4=
X-Google-Smtp-Source: ACHHUZ6EeL6gq5EtG9xZeYtWyzA5dejfnqdUzMMQGBUc9q9SgKVmMs87uSMG5uyXDkN0xF6o5D4hEg==
X-Received: by 2002:a05:600c:b54:b0:3f9:846:d892 with SMTP id k20-20020a05600c0b5400b003f90846d892mr1874404wmr.9.1688126720584;
        Fri, 30 Jun 2023 05:05:20 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:dbbb:7082:18ec:f407])
        by smtp.gmail.com with ESMTPSA id k22-20020a05600c0b5600b003fb40f5f553sm11766912wmr.31.2023.06.30.05.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 05:05:19 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 4/4] riscv: dts: renesas: r9a07g043f: Update gpio-ranges property
Date:   Fri, 30 Jun 2023 13:04:33 +0100
Message-Id: <20230630120433.49529-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630120433.49529-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230630120433.49529-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

On RZ/Five we have additional pins compared to the RZ/G2UL SoC so update
the gpio-ranges property in RZ/Five SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
index b0796015e36b..e68a91c9fe77 100644
--- a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
+++ b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
@@ -42,6 +42,10 @@ cpu0_intc: interrupt-controller {
 	};
 };
 
+&pinctrl {
+	gpio-ranges = <&pinctrl 0 0 232>;
+};
+
 &soc {
 	dma-noncoherent;
 	interrupt-parent = <&plic>;
-- 
2.34.1

