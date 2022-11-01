Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E16614ABB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 13:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiKAMcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 08:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKAMcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 08:32:24 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D4118B12;
        Tue,  1 Nov 2022 05:32:23 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id w14so19876223wru.8;
        Tue, 01 Nov 2022 05:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bg/tq8mc0td21VxYxjkcP/FxMATVdKN1/vdE4yipxA4=;
        b=HxeTSKDytWdqrppMzJdUt6sgSoPymV2VPF26TP9Fb6CbFx1c6fwS+7sIjbaXRiElTF
         z8xNpSFX/UhK5KGmYuGfrE46MteZvRiB8x0x1XQEuJCDOvNVnSwXofX3WT5jLpnoaVSQ
         0e4N1cTpNSVfW7dOnWcHGzQIUf99gBKLzj+uumXJE2yIQzl+VIv3QeUzFaDsW+HYC5mX
         qrauECSAzW4hTsTffwmzeqX0VvmI4ptrWv/v6+jr749d26InGtVdHUsUIiv+3o92j5X/
         W9dEUJNnPYtjfHoM5FRDg6FeYvcop+2hTgVZ7OL/nYg0otMRZkWfvqxP5asvKT2umaTR
         rFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bg/tq8mc0td21VxYxjkcP/FxMATVdKN1/vdE4yipxA4=;
        b=pZA1BkDFnKy87/LViFAKozXj7KzHH9ny2hfhnTi0SJGKRGor7/yFeudcWDI8RRLKAG
         qfMYV7KUgdlGA1v8pXz5xUWqNKRWNdFxbCkCc10Rus7/IvWFe/RrNFmgFbIbtV+Km2Hg
         kItoXmpz1DSjLeWlDREsx+r4yuVW8/t8h2YdhCTEPqjvsoJGRxNZh3+PMYyEDBa03ABW
         xvVXLHxhAkwbVVKcT0uX3gvxkmJMI62GeaZ0AxGxrGymi/+TV4GLhAdEmMsC6Fb2QMjb
         TgwkFAy/k+YbVs4PtV5lNe7d4UC2dD3gKwhrbElaixxb2ev24PQkfIqn/iW1bDi08RgN
         sNzw==
X-Gm-Message-State: ACrzQf1I93enRnR4VGdnpAevGjOeXu051KDxDhpunUA4ljPU0ps/q+3z
        GIYm0skREJv41rJl4+ijif8=
X-Google-Smtp-Source: AMsMyM67xgqrFvdCk92DmG+pXdrUp6p+i6JO/9O/Gv6lDJmfmGTlKfueosAa4DWo4K9KaX+dYjCDZw==
X-Received: by 2002:a05:6000:42:b0:236:6c52:bc22 with SMTP id k2-20020a056000004200b002366c52bc22mr11585644wrx.692.1667305942512;
        Tue, 01 Nov 2022 05:32:22 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id f18-20020a1cc912000000b003cf5ec79bf9sm10404176wmb.40.2022.11.01.05.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 05:32:22 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wens@csie.org, samuel@sholland.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 3/3] arm64: dts: allwinner: h6: Add deinterlace node
Date:   Tue,  1 Nov 2022 13:32:01 +0100
Message-Id: <20221101123201.3021129-4-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221101123201.3021129-1-jernej.skrabec@gmail.com>
References: <20221101123201.3021129-1-jernej.skrabec@gmail.com>
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

H6 has deinterlace core. Add a node for it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 0aa6dfafc197..badc6afd6941 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -154,6 +154,18 @@ mixer0_out_tcon_top_mixer0: endpoint {
 			};
 		};
 
+		deinterlace@1420000 {
+			compatible = "allwinner,sun50i-h6-deinterlace";
+			reg = <0x01420000 0x2000>;
+			clocks = <&ccu CLK_BUS_DEINTERLACE>,
+				 <&ccu CLK_DEINTERLACE>,
+				 <&ccu CLK_MBUS_DEINTERLACE>;
+			clock-names = "bus", "mod", "ram";
+			resets = <&ccu RST_BUS_DEINTERLACE>;
+			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+			iommus = <&iommu 2>;
+		};
+
 		video-codec-g2@1c00000 {
 			compatible = "allwinner,sun50i-h6-vpu-g2";
 			reg = <0x01c00000 0x1000>;
-- 
2.38.1

