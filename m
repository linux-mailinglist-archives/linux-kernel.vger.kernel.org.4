Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F40A62B6A6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbiKPJfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbiKPJfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:35:14 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5313725FD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:35:13 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id x21so21050685ljg.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nnGZMm94TS+LvaxxKTJdVvSSqPuScV0DEkrGulsvoNU=;
        b=cWvOAeWRcgEWMUU9ZznDG/GIhzoVfPeDPYCfL3l0ItQDiQF9Vpwd+Ll9Tlsq0ihG3J
         C1saqr623DWv8nWlq9DO+NUFZrtoTG3WrOGAv18uq+fgdZFUScWzO0EwdKIIXNVBLBJG
         TaItHFqLV3XayjnXAhzHPLFLhe1NA2Ckc1WoZru6mgimf0DyTlf2DcHQt/TOf0y+NOft
         JWhBeNocjMmGQqXR5fyRfOh64tUkPAOLdEYNHhw4lMO4sXfrxKCzZPyQUz+gk+vd55pG
         l2zhmtJYFxG9F3xalVHX6OpDpVWo9zk/kGgn2k7s9nTMm/15SdoEJ5Uxgm3FCxHQ+6vQ
         ZYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nnGZMm94TS+LvaxxKTJdVvSSqPuScV0DEkrGulsvoNU=;
        b=P0Pji/ZvJBnEH443HXvYST/oJbMMRb81y8xGXpf+9jVTTjhBD9yEdgVnUHGaEvgjSN
         TX0NRoPf7hH1SZV0SyUPnyQ1Un04mQYuoHmMbY5Zd4E28iweShH1YZpLgqQY/TSmT+nx
         CxLY47/tGIP+2Nrq8SrSrGYoZQpm/3Ue2O21Nzrr6lhuhGKECA+5T8BQUYblvhF3wfuw
         AD1G8/xscFzcGLO3tp5wou86OOWNGYOWr9mKCu6c5ZTi4/3FlH+UF/+1c3CQ1VLJP2EV
         oMnUwEDzOaLiR8/Y9oqsfpzxoP7elwJPkdvDYJtohjv2B4IzW9QTJzWXsjpc1KHs9nRy
         UCfg==
X-Gm-Message-State: ANoB5pkE+Hlyha8gHijEVFbl40dAL8pArQOsajGfHLSqshUSgUseBR79
        w1wFU/tIMz2dkcLoMoRhKwgcocKXxxItMxB7
X-Google-Smtp-Source: AA0mqf6zDJT3zFwexfzOscLO3lxb6Dm90Fbd7lU0o4wGJ1bmYYWYcpyr1QnsA6spHenpqZr6LJA9vQ==
X-Received: by 2002:a2e:3505:0:b0:277:328:aff6 with SMTP id z5-20020a2e3505000000b002770328aff6mr6830580ljz.182.1668591311647;
        Wed, 16 Nov 2022 01:35:11 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id r27-20020a2e8e3b000000b0026dffd032b8sm2914488ljk.2.2022.11.16.01.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 01:35:11 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] memory: drivers for v6.2, part two
Date:   Wed, 16 Nov 2022 10:35:09 +0100
Message-Id: <20221116093509.19657-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On top of previous pull request.

Best regards,
Krzysztof


The following changes since commit a11a5debdf4b5b5c24e88a378b53b42cc4fe1bb9:

  dt-bindings: memory-controller: st,stm32: Split off MC properties (2022-10-18 13:05:18 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-6.2-2

for you to fetch changes up to 8dd7e4af585331dda004e92ed0739c3609e37177:

  memory: omap-gpmc: fix coverity issue "Control flow issues" (2022-11-10 11:04:07 +0100)

----------------------------------------------------------------
Memory controller drivers for v6.2, part two

1. ARM PL353: document PL354 in bindings.
2. TI/OMAP GPMC: allow setting wait-pin polarity.

----------------------------------------------------------------
Benedikt Niedermayr (3):
      memory: omap-gpmc: wait pin additions
      dt-bindings: memory-controllers: ti,gpmc: add wait-pin polarity
      memory: omap-gpmc: fix coverity issue "Control flow issues"

Lukas Bulwahn (1):
      MAINTAINERS: arm,pl353-smc: correct dt-binding path

Rob Herring (1):
      dt-bindings: memory-controllers: arm,pl353-smc: Extend to support 'arm,pl354' SMC

 .../{arm,pl353-smc.yaml => arm,pl35x-smc.yaml}     |  80 +++++++++-----
 .../bindings/memory-controllers/ti,gpmc-child.yaml |   7 ++
 MAINTAINERS                                        |   2 +-
 drivers/memory/omap-gpmc.c                         | 122 ++++++++++++++++++---
 include/linux/platform_data/gpmc-omap.h            |   8 ++
 5 files changed, 178 insertions(+), 41 deletions(-)
 rename Documentation/devicetree/bindings/memory-controllers/{arm,pl353-smc.yaml => arm,pl35x-smc.yaml} (65%)
