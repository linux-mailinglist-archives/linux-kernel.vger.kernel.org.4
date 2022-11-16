Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A262162C1A2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbiKPO5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbiKPO5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:57:23 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F413D2C13B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 06:57:21 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id f18so11691301ejz.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 06:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9/cpzKxny9lt7J2uqRZQx//vvzeNsc0OHeymfe7bFMI=;
        b=XyQGsIU+A/TF0P2+MWJDH+mnscb8c+MyRIggIlVbCtneTaOkH7jFFxCB2HnX8TkS8n
         KiLHRwmyOiQTnb95b1bZe6Yd4HsVZHvefljJb/PFENYgaz6yZoSPCVIx+wWl+J0shc0p
         TFb5n9Ye4RBIgkY1OUpdS1Rbb5n0wqMC+53GTk1PWcxm89gJfYbHXUaq+0R954++/FBJ
         Ney1cP1jstfWK+KO6OznWLSD7YJISeOZ94oBkHoQDzta9LbA1wOL7AvPKdRE/AyGhPPb
         +qLpeOMPrtpW23M3Dp/ewdMQO81DAvJcGlJ4/HRo+Hf23Aa50dahe/Mgc/IO4ctXRfBU
         usqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9/cpzKxny9lt7J2uqRZQx//vvzeNsc0OHeymfe7bFMI=;
        b=oWkJvZMUPrheVI5hxoiOxLfbPycXei6e9ALjO43Ilv0da4uFk13oL4mu7WZNBs3udS
         0PwAvAnvGuL26hpMRgQDQthA5nxM+9TbSifLvlNrtBGLFioUFzbIJkxZZ8ybcWgHbpeR
         aQdZTwT6UdAVwHbmX+bWICOf3B0autHMVzJjzEAbVRDMEpOM9pzIcDlNt5TXaPBk2rMA
         8uEc26zrIXr3k8e6q75FUf0UA4v/1gNCMLcy4QqfCuWhEKUALBfy1Hn9+diuH2PKqmPg
         OPEj7MaVLjO/e+AmYVtwS1sGvigvgGSokIC3Kl6oOhtX37eEsPjQ8BXjfeREfSSau/Qt
         jkoQ==
X-Gm-Message-State: ANoB5pncOJE6WTAWUYWb5rvjSTsiIz3YnSF3r2/pEBI9VF/eGQp+c0zI
        qDYZxtdY0xEOeQ16nPA6aIQpy2+j0Gj2AvLf/MoDag==
X-Google-Smtp-Source: AA0mqf5JzpzScq/+SMh/iM+LwwBELp6t9A6aFL+klEI+TLdGcMxSO/hfrlQ/uktwuZWwC1qjhNu5jEGN4yAvs0PWsUs=
X-Received: by 2002:a17:907:7889:b0:78e:11ea:8528 with SMTP id
 ku9-20020a170907788900b0078e11ea8528mr18161419ejc.190.1668610640528; Wed, 16
 Nov 2022 06:57:20 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 16 Nov 2022 15:57:09 +0100
Message-ID: <CACRpkdaJy5hhrMfdZWtpoBUxBEc1QnxaX4pRzQVUBoEoKqrwzA@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for v6.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here is a hopefully final round of pin control fixes.
Nothing special, driver fixes and we caught a potential
NULL pointer exception.

What took time for me was to figure out how to get the
GPG password entry for signing the tag come up in
curses on a remote machine instead of giving up when
trying to open the secure little signing widget that locks
the desktop UI which it doesn't have. Comes down to
export PINENTRY_USER_DATA=USE_TTY=1
then creating .gnupg/gpg-agent.conf setting up
pinentry-program /usr/bin/pinentry-curses.
Well that was not intuitive, especially not an
environment variable containing an environment
variable. GPG might need some UX polish (or maybe
it's the distros that do this to us). Anyway here it is!

Yours,
Linus Walleij

The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc:

  Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v6.1-4

for you to fetch changes up to 2e35b25dd8e666b8619355fc3defb1b246a5dc02:

  pinctrl: mediatek: Export debounce time tables (2022-11-15 09:13:59 +0100)

----------------------------------------------------------------
Pin control fixes for the v6.1 kernel:

- Fix a potential NULL dereference in the core!

- Fix all pin mux routes in the Rockchop PX30 driver.

- Fix the UFS pins in the Qualcomm SC8280XP driver.

- Fix bias disabling in the Mediatek driver.

- Fix debounce time settings in the Mediatek driver.

----------------------------------------------------------------
AngeloGioacchino Del Regno (2):
      pinctrl: mediatek: common-v2: Fix bias-disable for PULL_PU_PD_RSEL_TYPE
      pinctrl: mediatek: Fix EINT pins input debounce time configuration

Anjana Hari (1):
      pinctrl: qcom: sc8280xp: Rectify UFS reset pins

Linus Walleij (1):
      pinctrl: mediatek: Export debounce time tables

Quentin Schulz (1):
      pinctrl: rockchip: list all pins in a possible mux route for PX30

Zeng Heng (1):
      pinctrl: devicetree: fix null pointer dereferencing in pinctrl_dt_to_map

 drivers/pinctrl/devicetree.c                     |  2 ++
 drivers/pinctrl/mediatek/mtk-eint.c              | 34 +++++++++++++++++---
 drivers/pinctrl/mediatek/mtk-eint.h              |  6 ++++
 drivers/pinctrl/mediatek/pinctrl-mt2701.c        |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt2712.c        |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt6765.c        |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt6779.c        |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt6795.c        |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt7622.c        |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt7623.c        |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt7629.c        |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt7986.c        |  2 ++
 drivers/pinctrl/mediatek/pinctrl-mt8127.c        |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt8135.c        |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt8167.c        |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt8173.c        |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt8183.c        |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt8186.c        |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt8188.c        |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt8192.c        |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt8195.c        |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt8365.c        |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt8516.c        |  1 +
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c |  3 ++
 drivers/pinctrl/pinctrl-rockchip.c               | 40 ++++++++++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-sc8280xp.c          |  4 +--
 26 files changed, 103 insertions(+), 7 deletions(-)
