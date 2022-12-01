Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0720763EB2B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiLAIdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiLAIdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:33:41 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3504C241
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 00:33:40 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m19so617928wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 00:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wX0uGx/FmFRDa4kSdWRlloB+K4Vw99mHzIFHONaLerg=;
        b=InQBr7oL475ZoNWQv9JfdWq7nk0FrTxkDD9rlFhPNZxxYYFD3+FXZhFJ/ls/fCj09t
         H6Rox6mplA/LjjmwPtLmM8SvQ+qXVE/xV14LuHakEaI8pbGyvlLe30VsQ/T6cKzpUnOd
         Qi2B6JeAf09dPr4zjljGnT2H+ouQPMCQOLf5lsdRyCiigYhfNuxJGnFApAcDVCV1vYHo
         O4JofyO1rNDPmVOu0NcC3+dcxaqCKGcKzbA5kYxTUNg+eOO6mfljYYT5F/13/guDMQID
         XwLRkadG7haQRwyzAnW0Nr7sQ9Ov/79BvjKqs9/8vwnAyCfgPYji9MAAHjQg81L43BnY
         2fzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wX0uGx/FmFRDa4kSdWRlloB+K4Vw99mHzIFHONaLerg=;
        b=4AKCNNRVh/3sPDm1Ve/HnamEj01snI2Qul3E/ophGAEdDy+YC6nSk+nBbJQxxhpLSu
         ClqkNH2B4aNgc9YMDYs3UqPruqSeGb4t9gmMYfaqLXo0PYTW7HJjtcrBJ70Wb1kM9rQc
         GzRZfIT87l6wx12WMoqJyBrdUzkVmEZIG4nG45E7Qle3IppQUuLjtcsjQttLCv6uuDTJ
         vz+txVR+/9+OTXPs5qy8aEvvAYC34vDiUe7gGzsf6lnNN83S8drdnfcHAPHoZ9+C7Ji9
         d7s8600EHfiRhsDkk2UkD1vqg2xRr7JbtVSTnPervu68OE6Su1rU2X0tA7RYgMHKSHAB
         oEpg==
X-Gm-Message-State: ANoB5pmc5fMJWUx6AJgTn/izY55e9ivw4QYpSwTqQwSWqzqi5c2zAUfn
        My8Nov5PrB7hSH8GSG9Y0z9rdA==
X-Google-Smtp-Source: AA0mqf58NcaStZc12qWzWnkpqrHPoEkydIZcsd78XEPELpmo9DjCKkUOb5A4y0FYnSWgMk8lsWoA8Q==
X-Received: by 2002:a05:600c:5118:b0:3d0:7026:49eb with SMTP id o24-20020a05600c511800b003d0702649ebmr5618756wms.53.1669883618685;
        Thu, 01 Dec 2022 00:33:38 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:26bb:b860:c227:f05d])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c358f00b003c6b874a0dfsm6132349wmq.14.2022.12.01.00.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 00:33:38 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v5 0/2] gpiolib: don't allow user-space to crash the kernel with hot-unplugs
Date:   Thu,  1 Dec 2022 09:33:33 +0100
Message-Id: <20221201083335.819190-1-brgl@bgdev.pl>
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

This is (hopefully) the final iteration of the changes that aim at fixing
the situation in which the user-space can provoke a NULL-pointer derefence
in the kernel when a GPIO device that's in use by user-space is removed.

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

