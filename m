Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82A36E3AA9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 19:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjDPRhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 13:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjDPRhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 13:37:14 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1236310CB
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 10:37:13 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id k101-20020a9d19ee000000b006a14270bc7eso8720822otk.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 10:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681666632; x=1684258632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p3MXe62Qv7CtzPpmu8rvoy3GoIPPlkCTC8+8F1j3AqY=;
        b=R3Du7y6BhPUpvvixwE3OW/ohBtepqNDlfE90M9shQrOx76Z/fhM7fXKhouOtlYIE+p
         id5Tfj4F61nLw8I3nS+kX3+YJJhXbqmYdBf9V391Rcb4Rtz4UFx8IHcJ9J6aJHMi1v9e
         w58oe5JFw0hM2C9pzJ1Q40RXdP4sNyB4tHYjlAC9lORFWOSQnV8B3SRjp1+v9JYqiSbI
         KbzanzvSmArETFunvri6vSJtEzACxV8Qsok5T8PYxPh8bHzbw1KPQG4o8nCaAE4vTe43
         btGEJYfGhQeAIzjgyhuPa0phpUCdHgrf4k/jZUIGWNc02s/vf/i7fio1kejjjRG7StE0
         mpew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681666632; x=1684258632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p3MXe62Qv7CtzPpmu8rvoy3GoIPPlkCTC8+8F1j3AqY=;
        b=cvcm1Ajl0KiDH2Tg91m/oamDl+8T7QpZw8pl6jdz0QtNXfdbprgdJ7isJmGOjx8gVa
         wsW5Np/YQANP5XpPuZO4Te8vR3RrlCt9mP9n6IPJOY+EqdTOuvea1+/mHa+z+iUC3mfU
         BkVj6dKuxMo8TeDkTZJTCCPUqCu4ly6vrPnoN1pS766Z5+vWUFfWkoDFAIsocqncFyzi
         vvm97e5WvOMNuh6W3zy5EP/zMW93LnsYl0eXgdCSU6ndu5XTObLdyBrdSvesT8JyrhPQ
         yEXktrBIZULeGua2vRG7P8asol7Yx29077kRs/ZY3JjfsAzxXrd/E02ti/BHDZScimSa
         DsTQ==
X-Gm-Message-State: AAQBX9f7/C6/ZfIIlKBgBEcGmo+fiWUZn4tsSqZ0Od3Er41ZqLxxBxz5
        80cBsAwipI4YuUpOokV6Jl8njQ==
X-Google-Smtp-Source: AKy350bXVC/EzCQENYaq2Vy3eSjms9K00QDVO1VZxCNm3FLEvQ9qdIhKHUxU7ogt5zyfoN193fznHw==
X-Received: by 2002:a05:6830:10c9:b0:6a5:e8da:a216 with SMTP id z9-20020a05683010c900b006a5e8daa216mr513558oto.27.1681666632369;
        Sun, 16 Apr 2023 10:37:12 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id v16-20020a05683011d000b0069457b86060sm3771038otq.47.2023.04.16.10.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 10:37:11 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 0/3] Add Intel 8254 Counter support
Date:   Sun, 16 Apr 2023 13:36:52 -0400
Message-Id: <cover.1681665189.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
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

The Intel 8254 PIT first appeared in the early 1980s and was used
initially in IBM PC compatibles. The popularity of the original Intel
825x family of chips led to many subsequent variants and clones of the
interface in various chips and integrated circuits. Although still
popular, interfaces compatible with the Intel 8254 PIT are nowdays
typically found embedded in larger VLSI processing chips and FPGA
components rather than as discrete ICs.

This patch series introduces a library to provide support for interfaces
compatible with the venerable Intel 8254 Programmable Interval Timer
(PIT). Modules wanting access to the i8254 library should select the
newly introduced CONFIG_I8254 Kconfig option, and import the I8254
symbol namespace.

Support for the i8254 is added in respective follow-up patches for the
104-dio-48e driver and stx104 driver whose devices feature i8254
compatible interfaces. Several additional dependencies are necessary for
the 104-dio-48e [0][1][2] and stx104 [3][4].

Due to the dependency requirements, I can take the i8254 introduction
patch through the Counter tree and provide an immutable branch that can
be merged to the GPIO and IIO trees; the 104-dio-48e patch and stx104
patch could then be picked up separately by the respective subsystem
maintainers.

[0] https://lore.kernel.org/all/05a878d340251b781387db4b6490f288e41a651c.1680543810.git.william.gray@linaro.org/
[1] https://lore.kernel.org/all/20230208105542.9459-1-william.gray@linaro.org/
[2] https://lore.kernel.org/all/cover.1679323449.git.william.gray@linaro.org/
[3] https://lore.kernel.org/all/20230318185503.341914-1-william.gray@linaro.org/
[4] https://lore.kernel.org/all/cover.1680790580.git.william.gray@linaro.org/

William Breathitt Gray (3):
  counter: i8254: Introduce the Intel 8254 interface library module
  gpio: 104-dio-48e: Add Counter/Timer support
  iio: addac: stx104: Add 8254 Counter/Timer support

 Documentation/ABI/testing/sysfs-bus-counter |  54 +++
 MAINTAINERS                                 |   7 +
 drivers/counter/Kconfig                     |  15 +
 drivers/counter/Makefile                    |   1 +
 drivers/counter/counter-sysfs.c             |   8 +-
 drivers/counter/i8254.c                     | 447 ++++++++++++++++++++
 drivers/gpio/Kconfig                        |   1 +
 drivers/gpio/gpio-104-dio-48e.c             | 127 +++++-
 drivers/iio/addac/Kconfig                   |   1 +
 drivers/iio/addac/stx104.c                  |  61 ++-
 include/linux/i8254.h                       |  21 +
 include/uapi/linux/counter.h                |   6 +
 12 files changed, 730 insertions(+), 19 deletions(-)
 create mode 100644 drivers/counter/i8254.c
 create mode 100644 include/linux/i8254.h


base-commit: 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d
prerequisite-patch-id: 934c63dd47cb47e19739af076b95d3d55f5604f1
prerequisite-patch-id: 02aafdd535091da6a4ed6abbb20fb661f74af9fb
prerequisite-patch-id: cd19046150b7cff1be4ac7152198777aa960a3df
prerequisite-patch-id: bd3e3830d9ce4f3876a77483364d7190b7fdffa7
prerequisite-patch-id: 1e091c1f8f945a56cac59070221c4284306ba087
prerequisite-patch-id: c6f681fcbf7495c5ed6a596872dc4f762f22d977
prerequisite-patch-id: 239b016817624d56a4a2bddea1fda95282cb3d81
prerequisite-patch-id: 5fbfe7df44dcf5a629cd82ba8383480cb05b52d1
prerequisite-patch-id: 25a89f7312f225aaca11ef192e8d1f903a8b20e8
prerequisite-patch-id: 899b556161f417e20db8e957c5099b92c3dcb673
prerequisite-patch-id: eb09641cfb9e7caf7641ae6cb8e84e33cbb665a6
-- 
2.39.2

