Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75F56CD5E3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjC2JFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjC2JEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:04:43 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4D110F;
        Wed, 29 Mar 2023 02:04:36 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id eg48so60269981edb.13;
        Wed, 29 Mar 2023 02:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680080675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+DbffmHfR9yVX7SiFnx6sOjtVl/DwLLnQZOWycWI+s=;
        b=n+ViGVoyl/wZVdMrWxH/nIlgWn3DQIt7vTOKGuCfxrWUjtP4auMc1Nuw5aF6PefQwK
         1flyPPFPhK3ofFlad/aTSAjtUIfSFCYjeAOBJ1CVVLB6d21kyBkXoVNRv+dMojbM0Slt
         JUDdLfSodJIfZZHY+QfplNfyanjZcR45BsooUlEvoCw2X5729JC/G+WFHUsJ/TvK5BZ1
         d5v6DEZbGEnoXyoTin25w8F9XoqU2ShRwz1hQJapZXslYTPtWaCQDUQ/+I2jaIGJ1S5u
         t2Ig4YiaayPmILtdWH8hC6B6Z67mvefjWoCPe4hm7mW1Rqdtx3Qq0Hp/N+Z1/Jq441hr
         yADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680080675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+DbffmHfR9yVX7SiFnx6sOjtVl/DwLLnQZOWycWI+s=;
        b=dqVqnkul9EJlmSJLI3ak+qXKn0zUsp1ORZT70ogr8LuVlpUT7ajUPvofbc2smU+C5n
         ekPlls/M3O4GVbdDVJAx+iTpYTYRMr5qj5DUvYK8KklfPyDcMe/kLf77rLr5f/z23ynu
         PhEf5ImtTzS7S2ByjjMTPtVT8FlDqdyj0WHWnI6ii7WYkR5z0SdHLPP6RGrFkGxzQ5um
         r4tVdaDrJ2qlB+32jiAsUhupK98VNQQq+efn6zb8yKfUi0Ii02exHlwRTBQfk/tY9MH5
         JknCJy1Kkt05+G+eiFGvq6JYG22SwQ37Pl7XUOsuYtz1P6R4s/fudIzyyIO8c/gZmZVz
         yz9g==
X-Gm-Message-State: AAQBX9fgyMGlLVyzzoC3UBQftrlCRYwK7hdzybX9K8Rngid2ho16HtvM
        BoIkeJyWkwW+pUYqER2jWiU=
X-Google-Smtp-Source: AKy350ZrP2HM33GK8UwVgVqH4NdCWSDzV06rZ/mqLdvKAINwQ9R3jmnTuDMOwi85Qxhre7PAO/D4zA==
X-Received: by 2002:a17:906:348a:b0:92e:d6e6:f3ad with SMTP id g10-20020a170906348a00b0092ed6e6f3admr20031134ejb.6.1680080675022;
        Wed, 29 Mar 2023 02:04:35 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id n3-20020a170906088300b009327ed171f2sm15437127eje.129.2023.03.29.02.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 02:04:34 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] ARM: tegra30: Use cpu* labels
Date:   Wed, 29 Mar 2023 12:04:01 +0300
Message-Id: <20230329090403.5274-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230329090403.5274-1-clamor95@gmail.com>
References: <20230329090403.5274-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxim Schwalm <maxim.schwalm@gmail.com>

Replace cpu paths with labels since those already exist in tree.

Signed-off-by: Maxim Schwalm <maxim.schwalm@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/tegra30.dtsi | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index b6fcac6016e0..9cba67b54111 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -1283,10 +1283,7 @@ pmu {
 			     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-affinity = <&{/cpus/cpu@0}>,
-				     <&{/cpus/cpu@1}>,
-				     <&{/cpus/cpu@2}>,
-				     <&{/cpus/cpu@3}>;
+		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
 	};
 
 	thermal-zones {
-- 
2.37.2

