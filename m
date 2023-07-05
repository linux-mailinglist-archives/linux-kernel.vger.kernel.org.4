Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0DE7486FD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjGEO4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjGEO4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:56:43 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BF41712;
        Wed,  5 Jul 2023 07:56:38 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3144bf65ce9so250600f8f.3;
        Wed, 05 Jul 2023 07:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688568996; x=1691160996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wyS/AuhXyE6+VyB6NMgbRJz2h3QQq9EfDiqpIcxbQ+o=;
        b=rJ+YDpHOhYp5fgpmARP1W0xJQQ4S/uwxuqaBWmR9YM3I1EDx/z9vlq63jBoRDq3+x1
         Y+4rpdDKqWST/oBMWmx/NeoKS2lV27g4VZ2/AjiSFpbdy2nw+LIuf6ESRRcOK+Dq+Hds
         LUUJzwvojhxKah3DULmQqhEzF8yjjhOzwDoQ0i/U90n13OsGftjEAtrxh/Uo9czvRUuJ
         fVtMsuOOkFu4UxelAUe8NqkJbh4zJ1B+a0qL9jNyHETVoqb2VtHgsrA/NeG+jzOf18qR
         mcUnfyumpB2U7fRBI+zsPEJlIQJcHozYnEDxw3XYBeJ+pcMaI7pM6Nxg0cCRPlw99c+Q
         sNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688568996; x=1691160996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wyS/AuhXyE6+VyB6NMgbRJz2h3QQq9EfDiqpIcxbQ+o=;
        b=I6fa2pzmpiiCPRQZdR2C7swT8ibtmppEHKkFBg56XvUAqFam3810RGwbJd632/OAuF
         MZYYghvP40I7doNjNMw7h5XGUukzHpi4k4qvGD4KuWRY6xSfD6hRdxVcPFvCTd6ACIVi
         TuHbRs6Vn4UHEhqNydMhVyie/EFgOPX88EBJqyuJEjY8v5rMWp9zZzMFdCBXLBXutqjN
         w1ECW24hmORwen7gwJL0RlkK/gl2Etui1EzhjrUTL2T+VZNlBziM9bit81UsHtp5O6So
         mUTCJnBJu0S9JVSDw3uvCMFqiCD0V84lWvYwo16gpCjzGnzhJgPmBtExrr0qA4Rp2fQG
         B3xA==
X-Gm-Message-State: ABy/qLaHmto7DK6RRJfVrKIAq5k1000PSUmzKS+CEBAy+qqMlKFDRzYm
        EU7LM+sYT+O7eK6w1xFy5Dw=
X-Google-Smtp-Source: APBJJlHXIoRYHqc9wmgxCHq6TYbxiiDVlKTz0d8gunY6iAJe7ooY5TcVLQfwTVhyVrVwkjrWblNNZw==
X-Received: by 2002:a5d:4ec7:0:b0:313:f4ea:4d97 with SMTP id s7-20020a5d4ec7000000b00313f4ea4d97mr11738444wrv.23.1688568996289;
        Wed, 05 Jul 2023 07:56:36 -0700 (PDT)
Received: from localhost (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id d10-20020adfe2ca000000b0031272fced4dsm31455452wrj.52.2023.07.05.07.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 07:56:35 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v6.5-rc1
Date:   Wed,  5 Jul 2023 16:56:31 +0200
Message-ID: <20230705145632.2510377-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-6.5-rc1

for you to fetch changes up to 92554cdd428fce212d2a71a06939e7cab90f7c77:

  dt-bindings: pwm: convert pwm-bcm2835 bindings to YAML (2023-06-23 15:49:35 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v6.5-rc1

There's a little bit of everything in here: we've got various
improvements and cleanups to drivers, some fixes across the board and a
bit of new hardware support.

----------------------------------------------------------------
Alexander Stein (1):
      dt-bindings: pwm: imx: add i.MX8QXP compatible

Biju Das (1):
      pwm: Add Renesas RZ/G2L MTU3a PWM driver

Christophe JAILLET (1):
      pwm: clk: Use the devm_clk_get_prepared() helper function

Conor Dooley (2):
      pwm: add microchip soft ip corePWM driver
      MAINTAINERS: add pwm to PolarFire SoC entry

Dan Carpenter (1):
      pwm: ab8500: Fix error code in probe()

Daniel Golle (2):
      dt-bindings: pwm: mediatek: Add mediatek,mt7981 compatible
      pwm: mediatek: Add support for MT7981

Fancy Fang (1):
      pwm: imx-tpm: force 'real_period' to be zero in suspend

Heiner Kallweit (6):
      pwm: meson: modify and simplify calculation in meson_pwm_get_state
      pwm: meson: fix handling of period/duty if greater than UINT_MAX
      pwm: meson: remove not needed check in meson_pwm_calc
      pwm: meson: switch to using struct clk_parent_data for mux parents
      pwm: meson: don't use hdmi/video clock as mux parent
      pwm: meson: make full use of common clock framework

Krzysztof Kozlowski (1):
      dt-bindings: pwm: restrict node name suffixes

Marek Vasut (1):
      pwm: sysfs: Do not apply state to already disabled PWMs

Shuijing Li (1):
      pwm: mtk_disp: Fix the disable flow of disp_pwm

Stefan Wahren (1):
      dt-bindings: pwm: convert pwm-bcm2835 bindings to YAML

Uwe Kleine-König (2):
      pwm: sifive: Simplify using devm_clk_get_prepared()
      pwm: pca9685: Switch i2c driver back to use .probe()

Wolfram Sang (1):
      dt-bindings: pwm: Add R-Car V3U device tree bindings

 Documentation/devicetree/bindings/pwm/imx-pwm.yaml |   4 +
 .../bindings/pwm/mediatek,mt2712-pwm.yaml          |   1 +
 .../devicetree/bindings/pwm/pwm-bcm2835.txt        |  30 --
 .../devicetree/bindings/pwm/pwm-bcm2835.yaml       |  43 ++
 Documentation/devicetree/bindings/pwm/pwm.yaml     |   2 +-
 .../devicetree/bindings/pwm/renesas,pwm-rcar.yaml  |   1 +
 MAINTAINERS                                        |   1 +
 drivers/pwm/Kconfig                                |  21 +
 drivers/pwm/Makefile                               |   2 +
 drivers/pwm/pwm-ab8500.c                           |   2 +-
 drivers/pwm/pwm-clk.c                              |  12 +-
 drivers/pwm/pwm-imx-tpm.c                          |   7 +
 drivers/pwm/pwm-mediatek.c                         |  39 +-
 drivers/pwm/pwm-meson.c                            | 212 ++++----
 drivers/pwm/pwm-microchip-core.c                   | 507 +++++++++++++++++++
 drivers/pwm/pwm-mtk-disp.c                         |  13 +-
 drivers/pwm/pwm-pca9685.c                          |   2 +-
 drivers/pwm/pwm-rz-mtu3.c                          | 551 +++++++++++++++++++++
 drivers/pwm/pwm-sifive.c                           |   7 +-
 drivers/pwm/sysfs.c                                |  17 +
 20 files changed, 1302 insertions(+), 172 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-bcm2835.yaml
 create mode 100644 drivers/pwm/pwm-microchip-core.c
 create mode 100644 drivers/pwm/pwm-rz-mtu3.c
