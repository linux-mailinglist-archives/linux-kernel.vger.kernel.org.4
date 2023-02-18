Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C01469B860
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 07:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjBRGvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 01:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBRGvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 01:51:21 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834324FC88;
        Fri, 17 Feb 2023 22:51:19 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id ec30so668949edb.10;
        Fri, 17 Feb 2023 22:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x+7lF519TNw7DEedjha5cPKcDehMAz7Bv8bHQk6jEz4=;
        b=Dy1NDiS2zWrTpyDfLkUhVZ19otqYOvNIptA058v62e0ANpW60H1SUSoQX+/+J9s25J
         icpFwasXPieGs8kPw/NxgHlxgBrwZHz0poumxNExqboqexXWj/DY2y5rGZaAvybgcnwO
         U4wfKDCbRElAOGYy5wAet6r+SuNTlM+cCGNIvWu/1+KeuYadkHj6yDipD6LeO3wxz2h/
         D/6AjlKO4UKRX6CphqxeozWnup0mKOW0CJC0Q5xoCgc8iJHiAW+jb+E+2IbYT3d1AOvj
         oUkfKZsOKm8FKbizjupIFPH96LfgDqv1GvVJQw0+Kw6aKMMu3cG0BcdhIsidR+KhElHO
         3vJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x+7lF519TNw7DEedjha5cPKcDehMAz7Bv8bHQk6jEz4=;
        b=zBsCql/5T0K1/M5AhPKn4WlNdjN9NXTqTYJ/sNO09KC51B3zGMHUW3iq3fHBt2zcne
         CYp2kIuPOFZZ+yugoOYC+ZieYHG3ZXBLefw6wTos02EgCEQdkrL/iKQqIIElaD56S0cZ
         9IvNiRReOJpJSjF/VrvFJc3jdkJ/R5BLdDWqgKN9atPqps/Hi1PCVwmsC17re7StBM3B
         b261BZRHewZjW1i872RQZlv1U5LFAprKEQxxyC1qEwukc3jJyRdSZWZ89brFNLIuDZUe
         nx8M7lvzFUdlXqxCrQnDfZ6XkLKnj3PnDtoRkl8vdsUVAvVVvdHUUvdATio3iruBwQsK
         ueOA==
X-Gm-Message-State: AO0yUKWnNkblZJC4JmGI6iUfqiu9VWOg10IP0RfC2pXZO/CDjG0vjKvv
        1CzpLX99ncyw1YC3IYJeWXo=
X-Google-Smtp-Source: AK7set/N25F8xcfjFi2RltkDno35yAF90bOUYEt+V4Pc7+D3K+722xn/kcgteRJXzhKnuN0U4y2vOg==
X-Received: by 2002:a05:6402:12ca:b0:4ad:7204:6968 with SMTP id k10-20020a05640212ca00b004ad72046968mr6459722edx.32.1676703077887;
        Fri, 17 Feb 2023 22:51:17 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id y19-20020a50ce13000000b004acc6c67089sm3156039edi.75.2023.02.17.22.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 22:51:17 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Daniel Golle <daniel@makrotopia.org>, erkin.bozoglu@xeront.com
Subject: [PATCH 1/2] pinctrl: mediatek: add missing options to PINCTRL_MT7981
Date:   Sat, 18 Feb 2023 09:51:06 +0300
Message-Id: <20230218065108.8958-1-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
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

There are options missing from PINCTRL_MT7981 whilst being on every other
pin controller. Add them.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/pinctrl/mediatek/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index f20c28334bcb..67818ba14d4e 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -130,6 +130,8 @@ config PINCTRL_MT7622
 config PINCTRL_MT7981
 	bool "Mediatek MT7981 pin control"
 	depends on OF
+	depends on ARM64 || COMPILE_TEST
+	default ARM64 && ARCH_MEDIATEK
 	select PINCTRL_MTK_MOORE
 
 config PINCTRL_MT7986
-- 
2.37.2

