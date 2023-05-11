Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976776FFC86
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 00:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239314AbjEKWHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 18:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239272AbjEKWHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 18:07:30 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6716E90
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 15:07:29 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-24e4f674356so8261083a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 15:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683842849; x=1686434849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oNdmLNDKUs/TKLR+gsT5NpmW/ws1iPV3pHW3NShG8U=;
        b=FKICgaJfahEVpza6/yNir+fScXx3x3STtdt4nOBeEqwSVZml+ci7oo7WA4LOpHskZg
         yP1GfbFkAfnafJDiyRdUcrop9yvD/R/KlOyppyOUZYqxS6ThoYq6mLS4Y42Vc70gg1rQ
         PTkOZyGoUNqzdK7YbeppQldT1a34MEx609nmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683842849; x=1686434849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4oNdmLNDKUs/TKLR+gsT5NpmW/ws1iPV3pHW3NShG8U=;
        b=JDfnw+leI5MCldZrgf1ZWF4N0HQYkBWmj7k789BZmOCALGW3UzJ3WeYg4lhXvObMU5
         H6uCID70HjZEICYqLUVGB1i/x7wYkciwiY4Apu2DMHArRWCZkf3OyEidDSPww5zRYr2p
         GP88ah/dDOIS1FSlgGlrLaFgGmvXBf13n9h4/WXMSugDcNFlJqV5jK5kpKECLQWXc6Ut
         QP9SPOF/rjSD5AQODdlOn8Yt5dAdOQCKisZbDR5/kD7uCDqGgW2EErRvfj3Wsb+dqeb0
         bR+sUG6lP0hXYUkn6AX/XvaIg3VaScYMAOaG9TlR8aXynf25rL5pa6pOcjYe7Gnfdkw3
         n0kw==
X-Gm-Message-State: AC+VfDx9y0VA5Cqhk3rvGsXzjEFoouSm7BAZPmNAszSr6p7we63K+mv1
        C97DfXVj3ACUpS8yyypBWhqE9A==
X-Google-Smtp-Source: ACHHUZ7KHoYJUF8QcmYx3zYXY/ErcV8fKCA+CWgEODGDRJgk0tu1drw3OSzYGpFg9Cpo3TKkns7Hxw==
X-Received: by 2002:a17:90b:3a8e:b0:247:6ead:d0ed with SMTP id om14-20020a17090b3a8e00b002476eadd0edmr23026494pjb.28.1683842848965;
        Thu, 11 May 2023 15:07:28 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:b96a:d776:ee3:e572])
        by smtp.gmail.com with ESMTPSA id h24-20020a17090a9c1800b00247735d1463sm17589457pjp.39.2023.05.11.15.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 15:07:28 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        wenst@chromium.org, Eddie Huang <eddie.huang@mediatek.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        Tinghan Shen <tinghan.shen@mediatek.com>, jwerner@chromium.org,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        yidilin@chromium.org, Seiya Wang <seiya.wang@mediatek.com>,
        Douglas Anderson <dianders@chromium.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] arm64: dts: mediatek: mt8192: Add mediatek,gicr-save-quirk
Date:   Thu, 11 May 2023 15:05:39 -0700
Message-ID: <20230511150539.5.Ie7e600278ffbed55a1e5a58178203787b1449b35@changeid>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To: <20230511150539.6.Ia0b6ebbaa351e3cd67e201355b9ae67783c7d718@changeid>
References: <20230511150539.6.Ia0b6ebbaa351e3cd67e201355b9ae67783c7d718@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firmware shipped on mt8192 Chromebooks is affected by the GICR
save/restore issue as described by the patch ("dt-bindings:
interrupt-controller: arm,gic-v3: Add quirk for Mediatek SoCs w/
broken FW"). Add the quirk property.

Fixes: 48489980e27e ("arm64: dts: Add Mediatek SoC MT8192 and evaluation board dts and Makefile")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 5c30caf74026..8931c59c69f4 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -412,6 +412,7 @@ gic: interrupt-controller@c000000 {
 			reg = <0 0x0c000000 0 0x40000>,
 			      <0 0x0c040000 0 0x200000>;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
+			mediatek,gicr-save-quirk;
 
 			ppi-partitions {
 				ppi_cluster0: interrupt-partition-0 {
-- 
2.40.1.606.ga4b1b128d6-goog

