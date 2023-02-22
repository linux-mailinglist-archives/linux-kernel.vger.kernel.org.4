Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8D569FB50
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjBVSkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbjBVSkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:40:32 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF84D410BB;
        Wed, 22 Feb 2023 10:40:19 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v3so8678091wrp.2;
        Wed, 22 Feb 2023 10:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5e/ZXnR3dtECd1NLYQLnE3pN49tDwVf5mdK22wA4HAI=;
        b=e0L1GfVCQaNJwuNE7XclNZMlRZNRUbEPHBJfd0XncqutQGUyeH29zyH1a4dp3yp8ue
         2FPJ56gfS2drYpxkrIOaFPx1wEFXcX/dJxdpRZ01GwaJYdXbHgiyOTtFMlAuGw62AJf5
         sxctNZ3H+RjC1XDulEZ2dxOd+kFwAIfCHAvIU6SGnX2Y2L3x/Fi2U06YQbWxRi5kngAb
         NWwBFJCNZzrDFpfydVfRtYZBlzXrcdnqhjiEnFpR8Rhym7L2u9agpN6KJ1Knadw1wIS9
         GxI9UstKeSXnA0ao+IqVc8xn92gc+q9w9YY45GOYxf4PmitUzueaMTNTX7h+wjdNz08k
         PKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5e/ZXnR3dtECd1NLYQLnE3pN49tDwVf5mdK22wA4HAI=;
        b=pWKjClHb0l9KFa8RCLbjLnCZH9D0PctAVvlePxrcB9+hzeM1SYSfWtbn1QKK1AB2Nj
         7zK0jFSYkyf+SlI0vwknrc21pyz9aFPmkLwrHYiNbbukx0o2KwZ1pFniNwAdJXtGjLH3
         OnNMMr21zTYVa+sYixPOM+rq6g3/yDi5EEHcqCUXzmmDp78oldFBmwZa/v8MuQHKG5T9
         VdLNYikEGjhVFDWSLlb/Ttmu1PKtVMkQWOyqkFSKbbv58HZfj+a2nZudqahc72Qke6k1
         nJMRbh6qbnVH3QWjRy2Nn2FL6Wf4LgL9lCzqhg5yBpyMLMRrJ+DXRhyzuGwIzwTl5liD
         li3g==
X-Gm-Message-State: AO0yUKWYWP0mrLKpcPnQhV6VwDS5Ew+3jK/+epB7ebZ0B+3KBZdYa/ch
        nkc3nNcdr3CfSC6BaI/UzZM=
X-Google-Smtp-Source: AK7set8tOiP8tGMuQ3l6IstW96Nd9dQl0IaddFW3GsuMpCs2zDBluc4RNWftK0pXdEQZNEzjhGbM2g==
X-Received: by 2002:a05:6000:1246:b0:2c5:5ef8:fa36 with SMTP id j6-20020a056000124600b002c55ef8fa36mr8713882wrx.70.1677091218257;
        Wed, 22 Feb 2023 10:40:18 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d4112000000b002c56179d39esm9372845wrp.44.2023.02.22.10.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 10:40:17 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
Subject: [RFC PATCH 06/16] pinctrl: mediatek: remove OF_GPIO as reverse dependency
Date:   Wed, 22 Feb 2023 21:39:22 +0300
Message-Id: <20230222183932.33267-7-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230222183932.33267-1-arinc.unal@arinc9.com>
References: <20230222183932.33267-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Arınç ÜNAL <arinc.unal@arinc9.com>

The OF_GPIO option is enabled by default when GPIOLIB is enabled, and
cannot be disabled. Remove it as a reverse dependency where GPIOLIB is also
set as a reverse dependency.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/pinctrl/mediatek/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index 3a6b99b23f35..809037b146a2 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -17,7 +17,6 @@ config PINCTRL_MTK
 	select GENERIC_PINCONF
 	select GPIOLIB
 	select EINT_MTK
-	select OF_GPIO
 
 config PINCTRL_MTK_V2
 	tristate
@@ -35,7 +34,6 @@ config PINCTRL_MTK_MOORE
 	select GENERIC_PINCTRL_GROUPS
 	select GENERIC_PINMUX_FUNCTIONS
 	select GPIOLIB
-	select OF_GPIO
 	select EINT_MTK
 	select PINCTRL_MTK_V2
 
@@ -46,7 +44,6 @@ config PINCTRL_MTK_PARIS
 	select GENERIC_PINCONF
 	select GPIOLIB
 	select EINT_MTK
-	select OF_GPIO
 	select PINCTRL_MTK_V2
 
 # For MIPS SoCs
-- 
2.37.2

