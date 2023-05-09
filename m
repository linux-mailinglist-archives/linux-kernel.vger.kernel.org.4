Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31706FC6EF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbjEIMnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbjEIMnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:43:12 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F5549DE;
        Tue,  9 May 2023 05:42:53 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f420618d5bso20314845e9.1;
        Tue, 09 May 2023 05:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683636165; x=1686228165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZplJga8URR6w22NuOXzuaUfxRbCk+zusrF2eonp43Ic=;
        b=M8kM4F50Y4QTpse4LTLaTC1p2lmcHK/sWrXz58Uxbdofq75cCK6nNc6tPZC5QyUyuq
         itS6L8KsQbXQLFbX6rssoOqIJTKrxa+d5P4RUpP1y7jwIU+ae5TyoANwDKjMR2GfM1uz
         DQEmnv60HVaZyyHeULYvT/yZqvXaV8N3/nRaVtvvnuFsm9gMqt9M5UsjptXzOcC8aLJe
         5VFkMJrUx1QzSQO1wBTorV4wBjQH/lJxtQ4HN9zf52oYG5ZFLVHp5maEVBBKuWh0G5fa
         M7/eIHccCIzaMzXED2bvBJYGn00JlpH1Y9bpXKsjk/1lmnhZGyl2HTv6acFjYShVQZWV
         5U7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683636165; x=1686228165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZplJga8URR6w22NuOXzuaUfxRbCk+zusrF2eonp43Ic=;
        b=COYYWgEmlkHQZt2PqiCMO0QI3mzddFccjEwsm+88tl3UxeGcYmaYoLfNGZnl3MjCT6
         MxbP/M8pFLgn2YvQ+ytRZv+N6HIDOcADkdVUFxkupVUe9ocSUiaTfkV7lsYGb0ylV9dp
         B2M7Kuuaswu0XHkkvf7jaRbHV5NiQFxgL/LQTgxgZCTJpRAxrWalKr5r4z4Ve9dJ++WA
         bvEwuhv7MzrVGF1MS3TPah7C+Iwgz2sATt/0v6tgm80nhFCLy5x8LhK4oAVysp83mTVd
         wN9CKhzDP81PGEI6uMDRSJWDNGNR8sv1CUmpQcM1idaqXhKjcArR6slw/uCDuIok64Xm
         ZERA==
X-Gm-Message-State: AC+VfDy6pkaVSeZDYVUrUzLCE14Yxyh0qbhwozStnz29qSAPLOwvvekB
        Cek1vn49MRJLoat0KFj0Szs=
X-Google-Smtp-Source: ACHHUZ5JuGl0TT7zoc5WZviOsoU/R1kF0RdwnsYbTD5iMTaRYgFq5PeC4oHx05osceUHEJ0tdlmpXw==
X-Received: by 2002:a05:600c:22d9:b0:3f0:9a90:a5e7 with SMTP id 25-20020a05600c22d900b003f09a90a5e7mr8961042wmg.28.1683636165108;
        Tue, 09 May 2023 05:42:45 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id f1-20020a1cc901000000b003f25b40fc24sm19933419wmb.6.2023.05.09.05.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 05:42:44 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tsbogend@alpha.franken.de, paul@crapouillou.net
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v1 3/3] mips: dts: ingenic: x1000: Add AIC device tree node
Date:   Tue,  9 May 2023 13:42:38 +0100
Message-Id: <20230509124238.195191-3-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20230509124238.195191-1-aidanmacdonald.0x0@gmail.com>
References: <20230509124238.195191-1-aidanmacdonald.0x0@gmail.com>
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

Add a node for the on-board I2S audio controller.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 arch/mips/boot/dts/ingenic/x1000.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi b/arch/mips/boot/dts/ingenic/x1000.dtsi
index 42e69664efd9..cc264cfff826 100644
--- a/arch/mips/boot/dts/ingenic/x1000.dtsi
+++ b/arch/mips/boot/dts/ingenic/x1000.dtsi
@@ -417,4 +417,22 @@ otg: usb@13500000 {
 
 		status = "disabled";
 	};
+
+	aic: audio-controller@10020000 {
+		compatible = "ingenic,x1000-i2s";
+		reg = <0x10020000 0x38>;
+
+		#sound-dai-cells = <0>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <1>;
+
+		clocks = <&cgu X1000_CLK_AIC>,
+			 <&cgu X1000_CLK_I2S>;
+		clock-names = "aic", "i2s";
+
+		dmas = <&pdma X1000_DMA_I2S0_RX 0xffffffff>,
+			   <&pdma X1000_DMA_I2S0_TX 0xffffffff>;
+		dma-names = "rx", "tx";
+	};
 };
-- 
2.39.2

