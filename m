Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FE262D33C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 07:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239184AbiKQGHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 01:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbiKQGHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 01:07:19 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD8754B15;
        Wed, 16 Nov 2022 22:07:13 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id l39-20020a05600c1d2700b003cf93c8156dso999347wms.4;
        Wed, 16 Nov 2022 22:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYLz02viNCcZeuKJqkLZJicl/v6PrsUfH2KEY8TpF5c=;
        b=XAILsUAJagM8MUl29mV+63W7fYXbvVj1O6ywhS5MTgcLI3+dE+YuG2BgElNzv6qGWd
         MIZhedNEAN9eTFz/qYbXZx2SjfD70pLE01qrHOw3JGyBdYj6UsAcNBEtF2N5XvcmhAJ0
         WtWGTmDzYXmFJ7LNism80tQWa8NLSn2Qjmys/RmCnCbJ4moyDyZ4kNBacLPBepBvYcTa
         WP7rHuVe+fy4cFCCxUGZUGCtFHBL0EznaMPh+gxSyKLHaCq9rhNckWaf+qPIWNQ1G9rF
         pbxv3rI+yj4bcGOzQW/oH0Ug5kZ+MGSOaMSCMf7Rv198BUocjZaEy+Gb8hRpUYKFcrvn
         Rnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYLz02viNCcZeuKJqkLZJicl/v6PrsUfH2KEY8TpF5c=;
        b=TBmHtnQ5jURK4VhVZXwEQwYAoPVJ/vWBVTXwi5wQG/iHkQYm1mHPhwpas1zQ+ZFZ9x
         bHIFFqutWzQSVsN45F2PvEL+sVHx+4c2RC46kGN5mzL19WKGMN9J5gVCLJc9ztBaje2f
         4pvFRMUT2gVR8ZpxfcFFmLep6Y6pAOcTgW25oprBvpkTbBS72YfJlePBmeBXlvrJVJDH
         qh0WG2eCxR4ycTAX/4vRHJF6pcbXBH7aD3ImmKFeSaZ/Uo2YzceZS58rMdMSUSkRP2CY
         xp07PcRNyX3uxRu6VZWDderWBxG1ZIT/9xlyAtFAKIBW9qTnHi+UHJAVwrnLVupgwujt
         y/uw==
X-Gm-Message-State: ANoB5pkJwj3XwBrTyZUmCQpKD732bFHkAgYgyYRMPOW8mWRmesTBLpce
        NWTV9Qdvbdo8Nxyamb+VGHE=
X-Google-Smtp-Source: AA0mqf7PN/VpawVglIwIn6auY2jtpRLyUWC/cyLwr5nNPze1Twrr1VtCbQ+ltxYbw0sQ6aJURe2Rag==
X-Received: by 2002:a05:600c:3b18:b0:3cf:6ab3:49ce with SMTP id m24-20020a05600c3b1800b003cf6ab349cemr538308wms.137.1668665231715;
        Wed, 16 Nov 2022 22:07:11 -0800 (PST)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id r11-20020a5d694b000000b0023691d62cffsm16542568wrw.70.2022.11.16.22.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 22:07:11 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        samuel@sholland.org
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 2/2] arm64: dts: allwinner: h6: Fix Cedrus IOMMU channels
Date:   Thu, 17 Nov 2022 07:07:04 +0100
Message-Id: <20221117060704.367945-3-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117060704.367945-1-jernej.skrabec@gmail.com>
References: <20221117060704.367945-1-jernej.skrabec@gmail.com>
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

Cedrus H6 actually uses two IOMMU channels. During development page
faults from both were observed. Documentation also lists both of them
to be connected to Cedrus, but it doesn't make clear which is used for
what.

Add second IOMMU channel.

Reviewed-by: Samuel Holland <samuel@sholland.org>
Fixes: 62a8ccf3a248 ("arm64: dts: allwinner: h6: Fix Cedrus IOMMU usage")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 53f6660656ac..7bff054a9bdf 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -172,7 +172,7 @@ video-codec@1c0e000 {
 			resets = <&ccu RST_BUS_VE>;
 			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 			allwinner,sram = <&ve_sram 1>;
-			iommus = <&iommu 3>;
+			iommus = <&iommu 1>, <&iommu 3>;
 		};
 
 		gpu: gpu@1800000 {
-- 
2.38.1

