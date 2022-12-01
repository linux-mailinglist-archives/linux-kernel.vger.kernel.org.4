Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D9E63F105
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 13:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiLAM7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 07:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiLAM7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 07:59:32 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A59F98032
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 04:59:31 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m19so1101358wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 04:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWWI630ihqLttfdEKhQ55bkwJEf504KdujInZX4vcy0=;
        b=c6bPPJatoxgbm4GGHfRqT0JxF3g6j4evHvR3GTLmsxKeDzPyVSG+JEFEt4f05JFon6
         17lp4A+opTdAb+3KfIg46WOEAJ4L9Z8WoWC1JUb3lQ0Npbejvg9B77JJ6EmxiAFn7KYw
         VzYNK/Q3UAIl5t6XdIvgIJWQX24H51L/x4UTCJJQHsxMs2rll2lweDWIOHICfpxHfGLU
         E+wQQVsAi80Il5tIZy9FHMMU065s2Atjm41Ho5r5nBi0QIiwLoEzFIcnF3K6yxR/NuDH
         I3Ym1T4SFBWl3CcwLxiTAcIrcocW7PqO4voPsKeDo8ofr9SK5WkwmL+YKwpzYspuWhTX
         WXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZWWI630ihqLttfdEKhQ55bkwJEf504KdujInZX4vcy0=;
        b=3QXk5/IVP8lb0s78wOTJJtS7ePy41TuXY8htij3tYUkJteL5ovSbAvTXYgg9iCMLC9
         lIs2PXZysxLMPs7dZ6Zq7RPaBfdIGEMuSW8T4VKTY2JAHalcxNg9/t+JMFdKLIHuq+0E
         4xEGF5UmSt5PQxR5ghFKqFhX+5B6jGX96E99aQ5MJqAETenJxKEBGnNDWdGtufpMwH4W
         cPl/ls5GgmZPjBgvEmXo2QfIfwyBw0arQ7OYeThp8l+DpY4mrcgHCwCRpCPvQeNGPyal
         edob+YW7Y2Y6LzIBkArDBc9Fm532kRLfKwyNDm+DHTQBcLoJBeStkAAvi/10/1J2YtAL
         Yhvg==
X-Gm-Message-State: ANoB5pnwb8jwkUaKcnodRJW39FT+a+/lwLTqQVxdEz97Nz+v1OBRdH5P
        eAZct3ibRO5i2z4jdamARDAs3Q==
X-Google-Smtp-Source: AA0mqf6mjFDpIkayW0hDci+6B0JNcHncRAH+QrvkrMR+7v7MnxiZCr0t/brztLSEpwkoFVb6j+NckA==
X-Received: by 2002:a7b:c008:0:b0:3cf:a85d:2ab2 with SMTP id c8-20020a7bc008000000b003cfa85d2ab2mr38181487wmb.43.1669899569901;
        Thu, 01 Dec 2022 04:59:29 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:26bb:b860:c227:f05d])
        by smtp.gmail.com with ESMTPSA id v14-20020a05600c444e00b003a1980d55c4sm9564753wmn.47.2022.12.01.04.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 04:59:29 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v6 0/2] gpiolib: don't allow user-space to crash the kernel with hot-unplugs
Date:   Thu,  1 Dec 2022 13:59:26 +0100
Message-Id: <20221201125928.3031325-1-brgl@bgdev.pl>
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

This is (hopefully) the final iteration of the changes that aim at fixing
the situation in which the user-space can provoke a NULL-pointer derefence
in the kernel when a GPIO device that's in use by user-space is removed.

v5 -> v6:
- signal an error in poll callbacks instead of returning 0 which would make
  the user-space assume a timeout occurred (which could lead to user-space
  spinning a timeout loop forever)

v4 -> v5:
- try to acquire the semaphore for reading and bail out of syscall callbacks
  immediately in case of lock contention

v3 -> v4:
- use function typedefs to make code cleaner
- add a blank line after down_write()

v2 -> v3:
- drop the helper variable in patch 1/2 as we won't be using it in 2/2
- refactor patch 2/2 to use locking wrappers around the syscall callbacks

v1 -> v2:
- add missing gdev->chip checks in patch 1/2
- add a second patch that protects the structures that can be accessed
  by user-space calls against concurrent removal

Bartosz Golaszewski (2):
  gpiolib: cdev: fix NULL-pointer dereferences
  gpiolib: protect the GPIO device against being dropped while in use by
    user-space

 drivers/gpio/gpiolib-cdev.c | 193 ++++++++++++++++++++++++++++++++----
 drivers/gpio/gpiolib.c      |   4 +
 drivers/gpio/gpiolib.h      |   5 +
 3 files changed, 180 insertions(+), 22 deletions(-)

-- 
2.37.2

