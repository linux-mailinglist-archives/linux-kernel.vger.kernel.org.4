Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D643570694D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjEQNNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjEQNNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:13:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4157A80
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:13:08 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-510b56724caso9417914a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684329186; x=1686921186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsCYEtDB1ffr+2Y+/vC2jddSRU/GNfdHR9H1LD49MZ4=;
        b=AY4YtKtj0ujl9+Mmw+CN96C9qS1pl/EP9v0K0ELoQazLV651LI2GjmChiUhIn9r2bh
         xeXqQ7sJ+WCpNmAkbF/6YEdSVcYfmd4qodUP7gpKPgdFLvMnYB/UO0H+iwNfBl4MC95G
         Mvdm+rLhHfM7lKzFEQQU+sXSGNyWozdxEnKOiIuZZDLsZIo8GgVLUbGrrLGBvq2kDErf
         oMVN90lZnHHJpP6NHBpoca10ZkD2n8Kx40bij1U3jH3g646VVOZSQBeQPNozefNIPv4H
         V+ae/JgK7z4xmgoihVFr+QScA1c4i2uNL66UzChrtQO2FLWQzf3LBB2Tk7pS2WRBRcyy
         5cYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684329186; x=1686921186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RsCYEtDB1ffr+2Y+/vC2jddSRU/GNfdHR9H1LD49MZ4=;
        b=Ijrev1KcpaXHBFh9u1z57jCc0WrcvRGZOFG4JIHH/In+MFjmVEqbwYPZ5FxFWk50Fd
         lkoo1MYbZ8NDWZot26VRVfyiZrLz5Tc4zLwjspFP/Upo48PvoNPGdFzUkO2/DUVtqSrG
         jXSf77ItMuUzRGvp51mScTRCBj+tjy5sas5goaOzUWK5ZpJ2o2hJHMkQGIWFHIXCWPdl
         CR4qr/HenO2kjkOVpZDchDnb18vwhshIlh4J32ImxyoaVOS1C/Lmk6yE6XaMpzNCKc5x
         mhz6FsyGa8Bjl6K4ASRgemfwXtPM6DJ6pv6EyQrodm8ih0j1Kahiuoxrq1zPZZL0gZDp
         v+dQ==
X-Gm-Message-State: AC+VfDypClUzS0KgT6ZxlvTkHIvgS0HyCNLmd92xpFa6raIThxbS0qUN
        SU0Jif8WTio4s3NclrwqbVOkig==
X-Google-Smtp-Source: ACHHUZ4KHT9X6WEz67mV7Zi3b4JfOl7XqzWOKK6QNiEjbdiMOUpttEUxIbNwfYMDn2EKItI3M03jZQ==
X-Received: by 2002:a17:907:1621:b0:968:892b:1902 with SMTP id hb33-20020a170907162100b00968892b1902mr2122535ejc.6.1684329186304;
        Wed, 17 May 2023 06:13:06 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id hs32-20020a1709073ea000b009534211cc97sm12291184ejc.159.2023.05.17.06.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 06:13:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com
Subject: [GIT PULL 2/2] ARM: dts: cleanup for v6.5
Date:   Wed, 17 May 2023 15:12:55 +0200
Message-Id: <20230517131255.471002-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517131255.471002-1-krzysztof.kozlowski@linaro.org>
References: <20230517131255.471002-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git tags/dt-cleanup-6.5

for you to fetch changes up to 21f475946d89911e31bccd02f8a7ce40b8f52a70:

  ARM: dts: en7523: add missing cache properties (2023-05-16 18:26:24 +0200)

----------------------------------------------------------------
Minor improvements in ARM DTS for v6.5

Minor improvements to fix dtbs_check warnings:
1. STE: Align UART nodes with bindings.
2. EN7523: add missing cache properties.

----------------------------------------------------------------
Krzysztof Kozlowski (2):
      ARM: dts: ste: align UART node name with bindings
      ARM: dts: en7523: add missing cache properties

 arch/arm/boot/dts/en7523.dtsi                      | 2 ++
 arch/arm/boot/dts/ste-dbx5x0.dtsi                  | 6 +++---
 arch/arm/boot/dts/ste-href.dtsi                    | 6 +++---
 arch/arm/boot/dts/ste-hrefprev60.dtsi              | 2 +-
 arch/arm/boot/dts/ste-nomadik-nhk15.dts            | 2 +-
 arch/arm/boot/dts/ste-nomadik-s8815.dts            | 2 +-
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi         | 6 +++---
 arch/arm/boot/dts/ste-snowball.dts                 | 6 +++---
 arch/arm/boot/dts/ste-ux500-samsung-codina-tmo.dts | 6 +++---
 arch/arm/boot/dts/ste-ux500-samsung-codina.dts     | 6 +++---
 arch/arm/boot/dts/ste-ux500-samsung-gavini.dts     | 6 +++---
 arch/arm/boot/dts/ste-ux500-samsung-golden.dts     | 6 +++---
 arch/arm/boot/dts/ste-ux500-samsung-janice.dts     | 6 +++---
 arch/arm/boot/dts/ste-ux500-samsung-kyle.dts       | 6 +++---
 arch/arm/boot/dts/ste-ux500-samsung-skomer.dts     | 6 +++---
 15 files changed, 38 insertions(+), 36 deletions(-)
