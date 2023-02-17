Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6D869B29B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 19:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjBQSxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 13:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjBQSxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 13:53:00 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E1D11E93;
        Fri, 17 Feb 2023 10:52:58 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id a11-20020a05600c224b00b003e1f6dff952so1584155wmm.1;
        Fri, 17 Feb 2023 10:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHDnEinTRmd4SoQ9dH9rKDosnOXl5ELjM68bNY773ck=;
        b=ZGTIKXW15RTh+6YdP9JSTUqLZXDje6luzloNlmWCiiNhBBlavbWtSIvnZMKHdaxo/B
         1A3VxyC1BuknxTlALkbhI6IQQbuQvy9BESbaR89ijyJVg+Hv2FIGcNZ9AsGYeJrCE4nD
         xnPA1boK5QEOWiiBm2cXZja4NgIuMRIaDlCeq//OlcroxQzGZ6i6q+ahbvVMqYPfEcKJ
         KRQrGfGKtXJRUWe1zzjKj2L0XlW5g+n0oSeuqSrNdVVFOnvZXpllG4wHf7THpEhJpSkR
         WBrO6BRyWUpiukCUfwDyggImfL0Cs2NksPc9QyLkNchs3IDQJXwFZKYJJkSwxNS17PSh
         csCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZHDnEinTRmd4SoQ9dH9rKDosnOXl5ELjM68bNY773ck=;
        b=mVzoKMXIoFbtmocmppc9Sa50A+hnummJTI99WcP95A4hD92a0jhDHjxT5Xsn1eGRNq
         kIluMN4W8zCtZmlZT8j/Toq4bVKnZOBrNyjOXmgYDVbQhnstzu6tP2nYHtcQPaPjwO2D
         M2CaM/YKWhlu+y6oHNnEi6jUwboaIA2WHMRTZyKJ+RGMNsVtn2GnVv19RhlWFvLV3GnL
         oD5iKreY7qHw+6TdunDcRzjsc8pce7uXPoLft/ZWIJc2M9HVJOcFf3SHR4SD+meRHvrX
         duR0IR8p9eLROhXrO8fQafrrprkkMmnldNf0jKlfvK9MCru18Bn6xahxlv9wRHGXTMQ7
         +vCg==
X-Gm-Message-State: AO0yUKWrgMTJEnDw/rtgq8UAZND5uaegjHwFeYHGtcZ0Jv294TPG8sKl
        w7b7u56jT0ZdHVkfG3vMGz/vlqcVsyRTIQ==
X-Google-Smtp-Source: AK7set9XnLnmKIlm6nCz1Hs+VH2mjKrxq3W6ZQ1AmK9c7R9ar4hKJKKl+c9m/V5wh9omNS+GlIEuCA==
X-Received: by 2002:a05:600c:4494:b0:3e1:f8af:8da4 with SMTP id e20-20020a05600c449400b003e1f8af8da4mr806854wmo.1.1676659976455;
        Fri, 17 Feb 2023 10:52:56 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:d8bd:e692:c27f:c09d])
        by smtp.gmail.com with ESMTPSA id l37-20020a05600c1d2500b003db0ad636d1sm2964514wms.28.2023.02.17.10.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 10:52:55 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/4] RZ/G2L SSI: Update interrupt numbers
Date:   Fri, 17 Feb 2023 18:52:21 +0000
Message-Id: <20230217185225.43310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This patch series aims to fix interrupt numbers for SSI channels and updates
the DT binding and the driver accordingly.

Note, this patch series applies on top of [0].

[0] https://patchwork.kernel.org/project/linux-renesas-soc/cover/20230131223529.11905-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (4):
  ASoC: dt-bindings: renesas,rz-ssi: Update interrupts and
    interrupt-names properties
  ASoC: sh: rz-ssi: Update interrupt handling for half duplex channels
  arm64: dts: renesas: r9a07g044: Update IRQ numbers for SSI channels
  arm64: dts: renesas: r9a07g043: Update IRQ numbers for SSI channels

 .../bindings/sound/renesas,rz-ssi.yaml        | 21 ++++---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi    | 19 +++---
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    | 19 +++---
 sound/soc/sh/rz-ssi.c                         | 63 +++++++++++++------
 4 files changed, 70 insertions(+), 52 deletions(-)

-- 
2.25.1

