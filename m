Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC92D63D160
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiK3JGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiK3JGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:06:01 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4680412098
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:06:00 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so872470wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fseEas+14xAFQxVLUfGfLUvuzNka2Dj76aCyMrxyJlY=;
        b=GpQ96fxp4whTMGCYqs8TBy1BcNSIrYVuSZjU9RaukJvnf7q7O8L1T4gUNrnq8/73/D
         n+IcaLAKz+DRd7jAFLITQOAzzNTFuTymRHrS0cTLHykFs2NL5vZvCSDuiWDemod3Y/Cr
         znwbr/SEj0XqEUZ+sh3rYDz/qjmdRxyAX90WJ/LuEjJitkZcmJWBpl7WnG/vb/ukzHXS
         pQ24vdtxd0G0C4OqBBqNsrkzCH4SWcq2OUV/1VyV4Wljj3Ix8UGR7zYgPTsBQvd4DaXR
         pQKrTmmV2BAUEo4a45wxh68TQf/AS6Zxokyx2kaOkFkMf9tijb02+epZxjL2wgATopnL
         LpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fseEas+14xAFQxVLUfGfLUvuzNka2Dj76aCyMrxyJlY=;
        b=hBnxXBgQFmoTKxR9sxsICwh3BN4sL/Acj4DFeNyyMC1BdliighnqVj+GapOXbOShkW
         gInxtt0YF7h9qHs6VpXgiABCUXSWULvlZMEo+dEX+sQEPCyNXk/7Jl30NPbz3cfty9+Y
         7qtSIUB4OIpwbKas7idFnB5NcGwX4KaNYd30fIOX7kP4ycvijP2zkZrbCb4wt6cGb6mC
         APU956Y9jhvi2L4LWcZj2HZl9GyLKxldH+qfuB1mUdrauvRgSIEBEZl9wqE155euwKyO
         zkeAUu+noaQIcZ3/tJT9gDvZ4EiishYmKw0ETV9cW2tacrDQeje9yQSKMk6LPYVVZWBn
         MPNA==
X-Gm-Message-State: ANoB5pkDz2uAZyIBlyFN2ud7Xmo6+XkbJPQJCcswiVz/NXWhRmTYMc9A
        N6PN2M37wEJWruBjzwqpwHeS58+ZlvJEqg==
X-Google-Smtp-Source: AA0mqf5HT58T2vj6+6kE1i2BnXwpq6xMhPYtTGAHhATGCfOfiqQYA7p6fZqshKmNIh5wLkxDt2kgdQ==
X-Received: by 2002:a05:600c:3514:b0:3cf:e0ef:1f6c with SMTP id h20-20020a05600c351400b003cfe0ef1f6cmr36475633wmq.75.1669799158797;
        Wed, 30 Nov 2022 01:05:58 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:458c:6db9:e033:a468])
        by smtp.gmail.com with ESMTPSA id v24-20020a05600c4d9800b003cfbe1da539sm1168841wmp.36.2022.11.30.01.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 01:05:58 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 0/2] gpiolib: don't allow user-space to crash the kernel with hot-unplugs
Date:   Wed, 30 Nov 2022 10:05:54 +0100
Message-Id: <20221130090556.40280-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Sending it once more with some more tweaks and review tags collected. Will
apply shortly.

--

This is the final iteration of the changes that aim at fixing the situation
in which the user-space can provoke a NULL-pointer derefence in the kernel
when a GPIO device that's in use by user-space is removed.

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

 drivers/gpio/gpiolib-cdev.c | 190 +++++++++++++++++++++++++++++++-----
 drivers/gpio/gpiolib.c      |   4 +
 drivers/gpio/gpiolib.h      |   5 +
 3 files changed, 177 insertions(+), 22 deletions(-)

-- 
2.37.2

