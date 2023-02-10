Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B66692A5A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 23:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbjBJWmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 17:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbjBJWmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 17:42:13 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC20975352
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 14:42:08 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id x8so8049716ybt.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 14:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=26hWLD5KLKkw4IobX1dhlza6o28KL+X+gg+uQ008c9Y=;
        b=kjAO4ixdBXxoURlwsMOwtpUwFlGiYNdLuN+PdolZDbrpvWlk1x6X4zAlKz8WNaTQBz
         7nxqo9eLHG7aDD/cviRWVaML4u2//Bdf3C2v5YU6EwzT+Zeh9xcIt9GSSxKfs1qaNejm
         wBY8eoEC5iCJhjNNbM3wPx8v8o61YCERxgNQi5qAFGbWSsUFZzZZZoCNmLz9mBW0bEHk
         L5twlyJKw66LKKLT6irS77UPRzqt1YTTFopcv0Kh/XVOIfDcpPMkxXQ0acxnzsfdguh1
         3fp/jKKj66UnNShJoYf9OBOja34rmCbYnWojNa3x4m3zfgDJTRd04VIpo5rYiZwgw7Uq
         oyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=26hWLD5KLKkw4IobX1dhlza6o28KL+X+gg+uQ008c9Y=;
        b=XQzn6VvCT4PobZR5If8Q3JzDpCErmeFZXCdUc7XI51GJPYsXeZznoAFMepf1rZ4OTz
         NE1En6y0NzCXzmfX2/5t5tLFJ3yQ+xXKyOtE9g+dl4knIJINMLVciIEFCWlyoQgaRrXX
         VS19xL5ZCsUVCubJkn8qYXgtQRYL3SYd7aj1JVMQaYn+XFGr0jwqtst3G8+VaZQZMi3X
         YwmOfITcXMHHwrq+V/ygf3NP7PyZsN86GkqJhA1wAXWE60v7ZJqY35AlMtkh2ACBotS9
         tq2x4eANZrwQOUPMk0WYj86nknvfmo8D8aA/plvox2ahcEY1Qlw9IDv9Yo96WDhMeiKW
         p/4Q==
X-Gm-Message-State: AO0yUKVswMOWa6nTf0/6BJiALGfHVHc5cqgjtk/OmyFR2Tj+ePQLk5bd
        04Ts6VtxYtsAKhVFoRtPWQHjoFAYG2TojPioQu+x7Q==
X-Google-Smtp-Source: AK7set++pi9cbqMLRO+KWKmt0V41DP+0fzmqkXucHMaDCx6QdoaC9+K1xNYqQJVZhD+aS/RZcDSOx/+85fWo8oFz6PY=
X-Received: by 2002:a25:f30e:0:b0:86f:8ba9:9474 with SMTP id
 c14-20020a25f30e000000b0086f8ba99474mr1835840ybs.302.1676068928035; Fri, 10
 Feb 2023 14:42:08 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Feb 2023 23:41:57 +0100
Message-ID: <CACRpkdax4qmftH974q+269YD65oMfLNFe-FrRSLyAZ_HY1OF0Q@mail.gmail.com>
Subject: [GIT PULL] pin control fixes for the v6.2 series
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

some assorted pin control fixes, the most interesting will be
the Intel patch fixing a classic problem: laptop touchpad IRQs...

Details in the signed tag, please pull it in!

Yours,
Linus Walleij


The following changes since commit 2241ab53cbb5cdb08a6b2d4688feb13971058f65:

  Linux 6.2-rc5 (2023-01-21 16:27:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v6.2-3

for you to fetch changes up to a8520be3ffef3d25b53bf171a7ebe17ee0154175:

  pinctrl: intel: Restore the pins that used to be in Direct IRQ mode
(2023-02-07 10:13:51 +0100)

----------------------------------------------------------------
Pin control fixes for the v6.2 series:

- Some pin drive register fixes in the Mediatek driver.

- Return proper error code in the Aspeed driver, and revert
  and ill-advised force-disablement patch that needs to be
  reworked.

- Fix AMD driver debug output.

- Fix potential NULL dereference in the Single driver.

- Fix a group definition error in the Qualcomm SM8450 LPASS
  driver.

- Restore pins used in direct IRQ mode in the Intel driver.
  (This fixes some laptop touchpads!)

----------------------------------------------------------------
Andy Shevchenko (1):
      pinctrl: intel: Restore the pins that used to be in Direct IRQ mode

Guodong Liu (1):
      pinctrl: mediatek: Fix the drive register definition of some Pins

Joel Stanley (2):
      pinctrl: aspeed: Fix confusing types in return value
      pinctrl: aspeed: Revert "Force to disable the function's signal"

Krzysztof Kozlowski (1):
      pinctrl: qcom: sm8450-lpass-lpi: correct swr_rx_data group

Mario Limonciello (1):
      pinctrl: amd: Fix debug output for debounce time

Maxim Korotkov (1):
      pinctrl: single: fix potential NULL dereference

 drivers/pinctrl/aspeed/pinctrl-aspeed.c         | 13 +++++++++++--
 drivers/pinctrl/intel/pinctrl-intel.c           | 16 +++++++++++++---
 drivers/pinctrl/mediatek/pinctrl-mt8195.c       |  4 ++--
 drivers/pinctrl/pinctrl-amd.c                   |  1 +
 drivers/pinctrl/pinctrl-single.c                |  2 ++
 drivers/pinctrl/qcom/pinctrl-sm8450-lpass-lpi.c |  2 +-
 6 files changed, 30 insertions(+), 8 deletions(-)
