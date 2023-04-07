Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E222B6DAC51
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 13:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239695AbjDGLpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 07:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDGLpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 07:45:36 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F49D7AA2
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 04:45:34 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j11so2426587wrd.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 04:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1680867932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vl1dRMp+Q4FFX2vNo32On0Ea39yTxGMtIW9v6QS7t0A=;
        b=oDLI+61iRVKtAZveU+x4j4eY1Wl5tIqe2eKzgACCWBKTCxczwXqSNdlJ2g2tNdpc6C
         5SlMFM0CcLEChwD1ROmXctHpv6+GaLY0OUYetJul0ImZEQV1WcJ3Qmfbg8ie0lqo8mcz
         c9THLn3MzFMPucP17S9ukwTA2SVgVW5WrdLUIQ/VJT6X8XUYmUkcIWj4qpJiaWt38L3T
         fLq63SSw9FZbzeyDyySsU0COgidml32kPvJhsnovcX/LgxYNXW78aDEkhRC+0OEJseRZ
         okfH6B+FfEIMq8dV8ZwIorfWARX8T+y96LVcIU8y8MF0KbYaNSIPH6n/STFaDsjf3tm1
         7rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680867932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vl1dRMp+Q4FFX2vNo32On0Ea39yTxGMtIW9v6QS7t0A=;
        b=bdpZb1HJ7Hz7eEfkrq1eIPyvtvr8yA5JueTVHrZZWfT3pGuowuVS2PCLSjPzzktLdc
         KGz/iBQOrhOuoGqM0qYwlxe9mOumXGJ/4GM6LtRA5Rz7yO2EE56qG4Lkm/dtOsjbrpfH
         p0ezGBVY860/IqkNAnX9nmfrHJjIdj2QH0wMZ4gKYdeG/LKaPtJ1iyn4yEE0Dt0X7RLT
         oFMstbbAUXWP2u45n3NCGL/0BKw/iB9i063ktATHKvU9znWVwSgGYQPfiCAKZ9cu/c0w
         5TBUZTC5EdbBeS6TZQ9+wkgU5mX1X5F54PZZQbYk3QjahTrqT5sq6ymxdfYJB8W+RNPZ
         IYGg==
X-Gm-Message-State: AAQBX9d513xiJ9yDaCq9PApR5bptDi1+9XytPx1wBewVQc4WnAFI/re7
        L8qE8RjY3F3ci0RSMfMlBadkkA==
X-Google-Smtp-Source: AKy350Yy3WJllVZV1malvNyUDDAvN+ZO2oV1aI0pme9Rcria2PGv4gOo1fmOiA9PDTXcpmu7/yuO6A==
X-Received: by 2002:a5d:4806:0:b0:2cf:e9de:1082 with SMTP id l6-20020a5d4806000000b002cfe9de1082mr1595649wrq.24.1680867932561;
        Fri, 07 Apr 2023 04:45:32 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:af1:1a75:9668:27a9])
        by smtp.gmail.com with ESMTPSA id m8-20020adfe0c8000000b002cff0e213ddsm4399037wri.14.2023.04.07.04.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 04:45:32 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: fixes for v6.3-rc6
Date:   Fri,  7 Apr 2023 13:45:30 +0200
Message-Id: <20230407114530.75942-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull the following fixes from the GPIO subsystem for this release.

Thanks,
Bartosz

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.3-rc6

for you to fetch changes up to 7b75c4703609a3ebaf67271813521bc0281e1ec1:

  gpio: davinci: Add irq chip flag to skip set wake (2023-04-03 17:40:41 +0200)

----------------------------------------------------------------
gpio fixes for v6.3-rc6

- fix irq handling in gpio-davinci
- fix Kconfig dependencies for gpio-regmap

----------------------------------------------------------------
Dhruva Gole (2):
      gpio: davinci: Do not clear the bank intr enable bit in save_context
      gpio: davinci: Add irq chip flag to skip set wake

Randy Dunlap (1):
      gpio: GPIO_REGMAP: select REGMAP instead of depending on it

 drivers/gpio/Kconfig        | 2 +-
 drivers/gpio/gpio-davinci.c | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)
