Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8316331ED
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 02:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbiKVBJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 20:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbiKVBJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 20:09:14 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C21E1D0FB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 17:08:09 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id v8so7575642edi.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 17:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NXlietmMDnMDDCbd3vt3QmKB/26LHM3Ufg/KK8xRGJ8=;
        b=m0TewJWW7KhTdSXchwcIkyxlc1EkvKyFWq5uJQv+yKMBp+IF5UtjELWqTQSb6qyCew
         kJHBq5X2f6gtjHpqsgh3S4R+eSNqeSybw4Z++QF6NViBx9aQNs9n6HbaVslpThBjx+8Y
         z85ErMR41r9qSXqg2hznA9QNL6CaZ4N3UymM3Ml9fqxpmgFNJHzKuK3g51mbb04B14oL
         6Cc1EOYi14h1Qu7wmDAPRkY4+Ot8gdVQMu+ubmNtFivjU97hBzmtHhCtlwuUdI9UF9ee
         kueWGK/JDg0GEw9aVPF4x3B+j2tCzomWngtlys7Z8cxOYlblZulqOdR0txPc88AqW6W2
         nhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NXlietmMDnMDDCbd3vt3QmKB/26LHM3Ufg/KK8xRGJ8=;
        b=nWS5VFpjPLukZzbja6x1bpKVy0Etay0/9T2fPd9sIDWVY5mNXCd0W3zlpvZHwlPsKp
         8stevrFjDFixISwimN8rbaYkG6e0e5vmyz9dqEy3Petv2bsvPzZyEL0BZU8FVXoHK7qU
         VlLNKmEzvEQrwIJ4+hIprWlcRqE8Ad92h7lp1+s/t9zTR3wSMj1YTCnvX05C3+Zs0JAw
         tC+1Eb3oLiD0bh2JXVprOnM/qNn2r7pgOYqGJZKcY8Qx5wulThpQ4WAhntw21MWiAD7n
         L3nxRhebRJjjCpbLYcwLbCbug1YzNIHKEYLv7V8fhI7h2WF7UjFT7dbl91nGUCBQNIcx
         42Yg==
X-Gm-Message-State: ANoB5pmlQROhax/MeGeFTZdPGLXQQ5vihBrmf7o15GZv5Gz8RtpDJX4U
        ecw2tNq2LpX4lVhPRhGT78rFkNKoJcd9ekpj
X-Google-Smtp-Source: AA0mqf6YHtIfMeR6UPTvsarDA6CMoaDvypsfuFvEc487eJW3bla0HrQAC73iEkA2LGGrx+B9tWkmow==
X-Received: by 2002:aa7:cc14:0:b0:468:58d4:a10e with SMTP id q20-20020aa7cc14000000b0046858d4a10emr19202803edt.222.1669079287797;
        Mon, 21 Nov 2022 17:08:07 -0800 (PST)
Received: from c64.fritz.box ([2a01:2a8:8108:8301:7643:bec8:f62b:b074])
        by smtp.gmail.com with ESMTPSA id f13-20020a1709064dcd00b007030c97ae62sm5514683ejw.191.2022.11.21.17.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 17:08:07 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     devicetree@vger.kernel.org
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        krzysztof.kozlowski@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, khilman@baylibre.com
Subject: [PATCH v2 0/7] Remove the pins-are-numbered DT property
Date:   Tue, 22 Nov 2022 02:07:46 +0100
Message-Id: <20221122010753.3126828-1-bero@baylibre.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the review of my MT8365 support patchset
(https://lore.kernel.org/linux-mediatek/20221117210356.3178578-1-bero@baylibre.com/),
the issue of the "pins-are-numbered" DeviceTree property has come up.

This property is unique to Mediatek MT65xx and STM32 pinctrls, and
doesn't seem to serve any purpose (both the Mediatek and STM32 drivers
simply refuse to deal with a device unless pins-are-numbered is set to
true).

There is no other use of this property in the kernel or in other projects
using DeviceTrees (checked u-boot and FreeBSD -- in both of those, the
flag is present in Mediatek and STM devicetrees, but not used anywhere).

There is also no known use in userspace (in fact, a userland application
relying on the property would be broken because it would get true on
any Mediatek or STM chipset and false on all others, even though other
chipsets use numbered pins).

This patchset removes all uses of pins-are-numbered and marks the
property as deprecated.

v2:
  - Deprecate the property instead of removing it completely from
    schemas
  - squash some related commits

 Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml | 5 ++---
 Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml        | 7 +++----
 arch/arm/boot/dts/mt2701.dtsi                                          | 1 -
 arch/arm/boot/dts/mt7623.dtsi                                          | 1 -
 arch/arm/boot/dts/mt8135.dtsi                                          | 1 -
 arch/arm/boot/dts/stm32f4-pinctrl.dtsi                                 | 1 -
 arch/arm/boot/dts/stm32f7-pinctrl.dtsi                                 | 1 -
 arch/arm/boot/dts/stm32h743.dtsi                                       | 1 -
 arch/arm/boot/dts/stm32mp131.dtsi                                      | 1 -
 arch/arm/boot/dts/stm32mp151.dtsi                                      | 2 --
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi                              | 1 -
 arch/arm64/boot/dts/mediatek/mt8167.dtsi                               | 1 -
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi                           | 1 -
 arch/arm64/boot/dts/mediatek/mt8173.dtsi                               | 1 -
 arch/arm64/boot/dts/mediatek/mt8516.dtsi                               | 1 -
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c                          | 6 ------
 drivers/pinctrl/stm32/pinctrl-stm32.c                                  | 5 -----
 17 files changed, 5 insertions(+), 32 deletions(-)



