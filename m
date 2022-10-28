Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3D26115F8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiJ1Pfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiJ1Pf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:35:26 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DD760E95;
        Fri, 28 Oct 2022 08:35:24 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x2so8428228edd.2;
        Fri, 28 Oct 2022 08:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JOBlKgg/kW62eSwLjo5AIuvvOOYYo6+JrLET6u1kQg=;
        b=Lokonk4He2xvlbb0fbSGgNBvGtfmJ+Cm3w1fR3GB3KPaUOgFO/DJLBT8Jh9cAlTWvg
         blZJBA64Mkg7OD9h4tm8kPTTHQzT6277uCDrVVEkcn4E52Lvgwr6WTMqf6zkUh1b5TTn
         4/H9m/4qYkEyuQ1gVVChxlRI/UGECSrF34XkXkypZBdqILubNuXc/onQrfxysdTuA9LO
         Lwh8gz6fzrsbrlQBhcPvXvXr0yc4Ur46faSWL+W5U4DvluQo6sA4yxgROLNfAr58Jfh2
         OaWjI+1XPsBqG2iz3L1v+bRE1Cuj58TRrr6CvB860HVT6Q84lbTfcFiKzEbDSLqPZsrc
         Ktcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JOBlKgg/kW62eSwLjo5AIuvvOOYYo6+JrLET6u1kQg=;
        b=AODuH5MCsJAwvmLyOJNeYVzaEqWguD6ztUVPrQ0c490YX515H6A7u/mJbehJdMFXBl
         2uT1rmVeh2BFnmcmRQMkWXVqh6eAqP0jolmbqDZTQWpiplUlhfa/RguliJMg5Px7H0jF
         ykTDzUZ/A9zXC1ghteSwSjMvuoD6lqUzo9R2gKWfMQZ9hIVY00yre8SJyPnI9aTw7VJj
         XnOekCYGM4qpa4Qvlm2hPFdohydlPId7RROk8slE0lRyuiGlJcY+OvKTY3KvQ7nHI+uD
         seD0wZDCMY+CVIzrXUSUOUAh7FF4X6UmBt949ZlQODGrppGRnhSjxE95o725vmkwDx9Z
         53/w==
X-Gm-Message-State: ACrzQf3Mma+1x4xb7jjaDc0XSXcKuptNSK435L/ISjLwZIePve9ssqpT
        x2Up0173fcGd8zTP8xYZkdo=
X-Google-Smtp-Source: AMsMyM6kzcugT2qZxWGejK7iVyAsKOi54x/a/sQwjsQcyTJruqJX4HMEf1MzEwUzsPRojZzKej5AxQ==
X-Received: by 2002:a05:6402:1d4f:b0:461:d2ed:788c with SMTP id dz15-20020a0564021d4f00b00461d2ed788cmr13269edb.418.1666971323016;
        Fri, 28 Oct 2022 08:35:23 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id ds12-20020a0564021ccc00b00461aebb2fe2sm2830635edb.54.2022.10.28.08.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:35:22 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v4 01/13] arm64: dts: mediatek: mt6779: Remove syscon compatible from pin controller
Date:   Fri, 28 Oct 2022 18:34:53 +0300
Message-Id: <20221028153505.23741-2-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221028153505.23741-1-y.oudjana@protonmail.com>
References: <20221028153505.23741-1-y.oudjana@protonmail.com>
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

Remove syscon compatible string from pin controller to follow
DT bindings and pass checks. Adding the syscon compatible to
the DT bindings documentation instead causes a different check
error due to the syscon document specifying a maximum of 1 item
in the reg property, while this has 9. This pin controller has
never been, and will never be, used as a syscon, hence it is
safe to drop this compatible.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt6779.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6779.dtsi b/arch/arm64/boot/dts/mediatek/mt6779.dtsi
index 9bdf5145966c..a6fa5212da4e 100644
--- a/arch/arm64/boot/dts/mediatek/mt6779.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6779.dtsi
@@ -160,7 +160,7 @@ infracfg_ao: clock-controller@10001000 {
 		};
 
 		pio: pinctrl@10005000 {
-			compatible = "mediatek,mt6779-pinctrl", "syscon";
+			compatible = "mediatek,mt6779-pinctrl";
 			reg = <0 0x10005000 0 0x1000>,
 			      <0 0x11c20000 0 0x1000>,
 			      <0 0x11d10000 0 0x1000>,
-- 
2.38.1

