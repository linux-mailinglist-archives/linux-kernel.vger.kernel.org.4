Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC99164837C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiLIOMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiLIOL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:11:28 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A34C1D323
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 06:07:47 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so5842762wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 06:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9ifEzYQVWgi27Tkh3vf+OK8A00LK9ON40E32Dr2itBE=;
        b=a6iDHi2eu7tlyATy9Debb4go9/WqaTPOWZbnOyk9Hkmy54InAp41PPJhli2R67ffx9
         J5uh6QxY4p4pXBWFFWcLuCtfXHVKJk1LO8ZEJaHvOgY/REFmcpjiZQI5c4mMfvTWSIUJ
         9bJpamWU+J+Fl0pc56au/jTfMELC7GRvqQ8onw4kBTJZUl3BQDL68wPRWL28RD+B4rdR
         s+QR01e+ZDAN1KYe0dUBJ1Rh2vc2AUbpcOXNhgskwJeUAyrF+xbiFGUMNnzZJd4YLuzR
         LdmnrC/+n5EZe6TX7ZusU7Ye+fG/6lHh3zwMKI2npgEGgNekz2r3YTZJaBCZpVg3urQW
         kiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ifEzYQVWgi27Tkh3vf+OK8A00LK9ON40E32Dr2itBE=;
        b=j45BwqGBnhUDzQIe9wwAPjlisxw4SQrlmwNdw+KhtV9LoR4pUI0BCcR/27s/QXgYsF
         Uas97H7MHAPzen6jMWC7u32iyfo92Ri3uUF8AVKrDgwOU5wS4OAZOkQ4IWdg65AcG/hm
         UWTVQOehPTFth0KJf34futbwXdTvf6eqSH2HTH0KRn2XVebn0KDD5Sgt4ivsjPpQ6YY3
         WLtPvVFKjLNglf8ZmNnX6cz2MeOJs3e29UaZl288kn7hL/rzIuiVt8nRZHFG+j56LCBI
         y7IBg42kYRLulFTHhc2oDaadoiuNi2AirM11/fJu0Y2Hc66u4oGmP/wyqVh6U8MvBL/Z
         v32w==
X-Gm-Message-State: ANoB5pkmjkVDAuHaIYcMlT89tJlzixXxEr3sbbsMtVbYLtQz1TKz/5rg
        FMGh02OLBqEi8qa1iIMbeuTLbg==
X-Google-Smtp-Source: AA0mqf5M5nFxDZ8gitSxEywysxN2WU8x6dsn9ZKZmkOe7rX95bLrnLlH5x5gUuy0Rd0g2/YD5oAPCg==
X-Received: by 2002:a05:600c:1d83:b0:3d2:13c6:4740 with SMTP id p3-20020a05600c1d8300b003d213c64740mr1382557wms.39.1670594855337;
        Fri, 09 Dec 2022 06:07:35 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:51db:8fd7:45e0:fe69])
        by smtp.gmail.com with ESMTPSA id q3-20020a1c4303000000b003cfa81e2eb4sm1869848wma.38.2022.12.09.06.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 06:07:34 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 0/2] tty: serial: add and use a managed variant of uart_add_one_port()
Date:   Fri,  9 Dec 2022 15:07:29 +0100
Message-Id: <20221209140731.573503-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This series adds a managed variant of uart_add_one_port() and uses it in the
qcom-geni-serial driver.

I've been asked by Greg to send it separately and he didn't seem to be
impressed by the proposition of adding devres interfaces to the tty layer
in general. I can only assume it has something to do with the ongoing
discussion about the supposed danger of using devres interfaces in conjunction
with exporting character devices to user-space.

The bug in question can be triggered by opening a device file, unbinding the
driver that exported it and then calling any of the system calls on the
associated file descriptor.

After some testing I noticed that many subsystems are indeed either crashing
or deadlocking in the above situation. I've sent patches that attempt to fix
the GPIO and I2C subsystems[1][2]. Neither of these issues have anything to
do with devres and all to do with the fact that certain resources are freed
on driver unbind and others need to live for as long as the character device
exists. More details on that in the cover letters and commit messages in the
links.

I'd like to point out that the serial code is immune to this issue as before
every operation, the serial core takes the port lock and checks the uart
state. If the device no longer exists (when the uart port is removed, the
pointer to uart_port inside uart_state is to NULL), it gracefully returns
-ENODEV to user-space.

Please consider applying the patches in the series as devres is the easiest
way to lessen the burden on driver developers when dealing with complex error
paths and resource leaks. The general rule for devres is: if it can be freed
in .remove() then it can be managed by devres, which is the case for this new
helper.

Bart

[1] https://lkml.org/lkml/2022/12/8/826
[2] https://lkml.org/lkml/2022/12/5/414

Bartosz Golaszewski (2):
  tty: serial: provide devm_uart_add_one_port()
  tty: serial: qcom-geni-serial: use devres for uart port management

 .../driver-api/driver-model/devres.rst        |  3 ++
 drivers/tty/serial/qcom_geni_serial.c         |  8 +---
 drivers/tty/serial/serial_core.c              | 48 +++++++++++++++++++
 include/linux/serial_core.h                   |  6 +++
 4 files changed, 58 insertions(+), 7 deletions(-)

-- 
2.37.2

