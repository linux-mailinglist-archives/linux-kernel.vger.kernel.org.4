Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2620669FB20
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjBVSkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjBVSkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:40:16 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1804108F;
        Wed, 22 Feb 2023 10:39:58 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id i11so2585243wrp.5;
        Wed, 22 Feb 2023 10:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=91+V2URQd5z0cRWdOdijFthyyEN9gwUVNKx2OIXRm+M=;
        b=luRFZSblmPWY3gvrk6yKViXpppEt290S64jD0a09c5fdl2Wa+zgTS/VVVcLaeZtGf1
         uQc5DXdqqz1i38W1yT70ERXNJiB92MhivB/TLlXOsjqbGBOEDn1YmsVCAyVyitmZEi+V
         ex1usBk+Gq8bgb5cFOGt1bzMGObP/5AaaIJq8A7KCF7pCl693CW+ZZPd0NIFwJsBP5y4
         eMy+V9aV2/NCp7+OpslssgUNIdTwKfTlw4iLNITnyTSGaNfk2ouKTJnx7PWmbcAkNCXT
         KSnq0GDCosZ1Gz7uM4hNy2HQQTaq6TJIGWSGQjmnHB6JsLLQ5KM/1/SAimU4XXSZhm4J
         QVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=91+V2URQd5z0cRWdOdijFthyyEN9gwUVNKx2OIXRm+M=;
        b=4P6yJdplc6ogTSfdItm9NLPwW4+5JpG1/7ZnOio2ml0dBhpr2ciJTg2ub1IV0JnfO9
         qOTVjxjikc18EJvZbSrvOUQAJwHR2Mk4eU7UTmx/lOAVZPuwgebXWawuwatV8ARSehBT
         P+TIBu311i9Jc7b+gZ92cKJpC1iF6Q7F8KCwlESkDzcVTr219eLo55SE1Itm79qahubF
         T69UjVGdu8Wz5PFpVKcK5F50KkKHHVG9stExCBn+A+5q8xweYa4OLNA15UlnL+ZqbQsJ
         FHNgndVuWrZXmPoyNNAwbmvr6ifWgc00pYg8g4aS5c2n2k4zMfVtTcxOeCRZ3r5n0Yz2
         obHQ==
X-Gm-Message-State: AO0yUKVRP0N9M+xaFDUQAR+APfQOk5ch38oCn+6CtwKVo0cawkIyoqaH
        RRpOxo/Mkxk1BAMRSfgX6QM=
X-Google-Smtp-Source: AK7set/Ay1pTP7dhUzrpNZ4kePGXVZQAHKH5ICQPaMGVsqN5CiW4i4RTql7o2vSio2A1mf+Qef4G7A==
X-Received: by 2002:a5d:6305:0:b0:2c7:e1f:60eb with SMTP id i5-20020a5d6305000000b002c70e1f60ebmr802521wru.69.1677091197184;
        Wed, 22 Feb 2023 10:39:57 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d4112000000b002c56179d39esm9372845wrp.44.2023.02.22.10.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 10:39:56 -0800 (PST)
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
Subject: [RFC PATCH 00/16] pinctrl: ralink: fix ABI, improve driver, move to mediatek, improve dt-bindings
Date:   Wed, 22 Feb 2023 21:39:16 +0300
Message-Id: <20230222183932.33267-1-arinc.unal@arinc9.com>
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

This is an ambitious effort I've been wanting to do for months.

Straight off the bat, I'm fixing the ABI that I broke a while back, by
reintroducing the ralink,rt2880-pinmux compatible string.

If you take a look at the schema for mt7620 and rt305x, some functions got
multiple lists for groups. Like refclk on mt7620. Because mt7620 and
mt7628/mt7688 SoCs use the same compatible string, it's impossible to
differentiate on the binding which SoC a devicetree is actually for.
Therefore, the binding will allow all groups listed for that function. For
example, if the SoC is mt7620, only the refclk function for the mdio group
can be used. If one were to put "spi cs1" as the function there, there
wouldn't be a warning.

I address this by introducing new compatible strings for these SoCs, then
split the schemas. I also separate mt7628/mt7688 from mt7620 pinctrl
subdriver in the process.

I wanted to split the rt305x driver too but too much code would be reused
so I backed down from that.

Ralink was acquired by MediaTek in 2011. These SoCs have been rebranded as
MediaTek. We're moving the Ralink pinctrl driver to MediaTek, and rename
the schemas to mediatek.

I've renamed the ralink core driver to mtmips. I decided to call the core
mtmips as I've seen folks from MediaTek use the same name when they added
support for MT7621 pinctrl on U-Boot. Feel free to comment on this.

The MTMIPS pinctrl driver requires rt_sysc_membase from
arch/mips/ralink/of.c, so, for COMPILE_TEST to be useful, RALINK must be
selected. These headers, asm/mach-ralink/ralink_regs.h and
asm/mach-ralink/mt7620.h, from arch/mips/include are also required but
they can easily be included:

ifeq ($(CONFIG_COMPILE_TEST),y)
CFLAGS_pinctrl-mtmips.o			+= -I$(srctree)/arch/mips/include
endif

Sergio, do you see a way to make the pinctrl driver independent of
architecture code? At least avoid using rt_sysc_membase.

dtbs_check will print warnings for DTs with the old strings as it will
match multiple bindings. I assume that's acceptable in order to have the
things properly documented without breaking the ABI. The bindings will work
fine with the new compatible strings.

I could define the checks under $defs:, then refer to it if the compatible
string is the one which would work fine. Or I could put only the new
compatible strings on the documentation. What are your thoughts Krzysztof,
Rob?

Arınç


