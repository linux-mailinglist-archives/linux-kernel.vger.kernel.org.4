Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0CA6A2AC4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 17:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjBYQlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 11:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjBYQlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 11:41:00 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7904612064
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 08:40:58 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l2-20020a05600c1d0200b003e1f6dff952so4389418wms.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 08:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93hyDfec2pzQ0OqfcBQZLUSCJi6w4Dee8fakzIJF/Lo=;
        b=u55skNVbzNAMNmMY57wS15v5LY2y/uvjqRS0ScvrbuTcue7SPHChCEjtW/lpMlNIni
         b1HtB+6f/u/7SrfnLIYe3khjq1W7dtBGIklB1b14+PCQKpp7zsbTBZ6mbwq6uRMh4oX1
         Ya0To1Bap76JVUSv0vKa3cMRE/v12Nt6QsEllzwjhlCO2CpsxoFUV45oEj16dVVwSICd
         6EKmeAI85gX7ju+3gKTr7MxWngmxie0G9cYuoprd2Z6swoEfQVBOrCh285MAByeg499z
         hlsrftMjTISK1NKTLj2ByjOlMD0vn/EG6bMnKPiDhnCSizJZ9JyLtSPwI5knGdmtiGxs
         h5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93hyDfec2pzQ0OqfcBQZLUSCJi6w4Dee8fakzIJF/Lo=;
        b=tnILD7FVvBznpMCPiQC/o75ekPPAUYyoimhLgGXdV/2BmDvxj8jdp9ItjkHbR23iY1
         ENHCmgKLQMjjore82Pbj0CW+AFdUF70WnryHaxuk7J+NfS21VCJlCzMdt+Ly95S3dN5h
         wOL3oE71laUUOBYP+ZKh2CEhxovgMjQ2tmuz3in7tvmMeOoeWH+If0os9d4su9h7znNV
         oZ266IOzLsNexcqRHcTx7+zFLhTmU7uL43ife0Cy2FzWpf0n/4pw3tXtgmDRC3SlWpfP
         QlGJrQyZF5jUj5XAlubD5ao17/b+HukR4te+iiI8FxDp+eU7pCPVHlS3ohJKDe7ChwHd
         z89g==
X-Gm-Message-State: AO0yUKUibV3gDlQ6TI+o1S2K5If2anuh8ZdE3SKvLIykAnPFsjNmcsgW
        dHFA1pNT/ekkJ/rrjeXW2zNq6A==
X-Google-Smtp-Source: AK7set8H0d/6CvKxwPN/EpPWiObC3wRIWcGhIYxYauaZ312Cp0qfxdmTTylXsTgpAxOt5ju6iVhGxg==
X-Received: by 2002:a05:600c:994:b0:3eb:3104:efec with SMTP id w20-20020a05600c099400b003eb3104efecmr1816212wmp.16.1677343256966;
        Sat, 25 Feb 2023 08:40:56 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id s17-20020adff811000000b002c758fe9689sm2189163wrp.52.2023.02.25.08.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 08:40:56 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ARM: dts: exynos: drop fake align STMPE properties in P4 Note
Date:   Sat, 25 Feb 2023 17:40:50 +0100
Message-Id: <20230225164050.42522-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230225164050.42522-1-krzysztof.kozlowski@linaro.org>
References: <20230225164050.42522-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From STMPE device node in P4 Note remove unused irq-trigger property and
incorrectly placed interrupt-controller (which would be a property of
GPIO child).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos4412-p4note.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-p4note.dtsi b/arch/arm/boot/dts/exynos4412-p4note.dtsi
index 84db696d543a..317e248f354b 100644
--- a/arch/arm/boot/dts/exynos4412-p4note.dtsi
+++ b/arch/arm/boot/dts/exynos4412-p4note.dtsi
@@ -188,8 +188,6 @@ adc@41 {
 			pinctrl-names = "default";
 			interrupt-parent = <&gpx0>;
 			interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
-			interrupt-controller;
-			irq-trigger = <0x1>;
 			st,adc-freq = <3>;
 			st,mod-12b = <1>;
 			st,ref-sel = <0>;
-- 
2.34.1

