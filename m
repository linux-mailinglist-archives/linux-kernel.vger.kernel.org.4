Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C9D67690F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 21:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjAUURH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 15:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAUURF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 15:17:05 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7AC22A3E;
        Sat, 21 Jan 2023 12:17:05 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id v10so10391899edi.8;
        Sat, 21 Jan 2023 12:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwQ17Lcm2IqVHFAnePP290nHJ1hZODiXeBdsdtLFjw0=;
        b=og6pcBTr7D5pvRAyb42Xz9xPybTt/oSalzP9ZnazP+9M6yvHv4mY8Oay4TZZ30YCAE
         ZF9cJqyHK1Lj4QwHX7GAB9heole1WE3Fm90cyphLTL4M7d+BwSaTwpZL2BfiVpgSVGb6
         Xe/zdIUtouTNVHg9x9mwe4ZAAWvu4N3x/qaWa3q8cMPVwjfEBqVxXqZv3L0BaGiEuI8k
         sNfcmKhPHhJG0BPz35SQjyfxmbm0xVVbxQeyHzFczzxD9PJ3BY1FPH/LjUdSKSwG/Fod
         LytxM5IppXP34nJODQNXHNshM4QNBCmnjCnR31LELLAeDt6fNs/Wj8KLLVEzbEFwC43s
         9Xag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwQ17Lcm2IqVHFAnePP290nHJ1hZODiXeBdsdtLFjw0=;
        b=b03PczgOhPVguSy9u5HkYUp9dw9TNk8jjjpSU0erTuzDRHuNWqoXy2lVRD6ecdgOW+
         a+zKqaoi+QrFrLf4JRULJE4svPoWq0unHAILcGd55BkTyfJwyw0BVZY2Gq4Xu5d+WPUO
         Rmf8MZD7oeVLevb5F7/j7zXNm6kvcdx8oJZfwC5bDG4uuHfRYKgLDqZ995qQABnAWvUc
         h0LR7p9LjYTorNEaUOstg28BHMXhFnhBw1HHQFMCSLskFK6/rtz94Ra3+4tlZzk2qIpJ
         Jyt+3ORCEkpStu0+t9tlsmZUqSa3NwSi5jbtjz69qQ3ttD6qOk88X3EdvYRYju/PIfXM
         taXg==
X-Gm-Message-State: AFqh2krABbkEMD5lHQnhHs/w+Y0PbVZL0x4cy3EPgaT85yw3QrK2a2hI
        Pqig6QBX0GDqkmugexo3J3C/rebPGzGvvA==
X-Google-Smtp-Source: AMrXdXuZy15B5at4aDuBC8tmWa1tu5zz1apWtInK+RxXxiD/ErduWlS9FrOJ57gVeucx/z8H5uzKJA==
X-Received: by 2002:a05:6402:448a:b0:472:46bf:fb3c with SMTP id er10-20020a056402448a00b0047246bffb3cmr31774598edb.35.1674332223207;
        Sat, 21 Jan 2023 12:17:03 -0800 (PST)
Received: from localhost.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id g8-20020aa7d1c8000000b0049e1f167956sm8278427edp.9.2023.01.21.12.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 12:17:02 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 1/2] arm: dts: exynos5420: Use Exynos5420 compatible for the MIPI video phy
Date:   Sat, 21 Jan 2023 22:16:48 +0200
Message-Id: <20230121201650.46560-2-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121201650.46560-1-markuss.broks@gmail.com>
References: <20230121201650.46560-1-markuss.broks@gmail.com>
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

For some reason, the driver adding support for Exynos5420 MIPI phy
back in 2016 wasn't used on Exynos5420, which caused a kernel panic.
Add the proper compatible for it.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 9f2523a873d9..62263eb91b3c 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -592,7 +592,7 @@ dp_phy: dp-video-phy {
 		};
 
 		mipi_phy: mipi-video-phy {
-			compatible = "samsung,s5pv210-mipi-video-phy";
+			compatible = "samsung,exynos5420-mipi-video-phy";
 			syscon = <&pmu_system_controller>;
 			#phy-cells = <1>;
 		};
-- 
2.39.0

