Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E4F6D6568
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235654AbjDDOdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234699AbjDDOc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:32:58 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C796EC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 07:32:55 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5419d4c340aso616714677b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 07:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680618775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5TeZQ266LbK5QH2jgnCEXAl0zq9NQeUvBQJ7yQxwh3E=;
        b=UbXeQpuUhpG7jUJNy8ONc+3FOc98eRLbYbSMzyfCaoohZiewRQOjpLfLeZ8sagEiRx
         rCeHtTkjtGo+LuyH1+aSgdQ/BIei5fWlDpwvVflkDjlu94ub8itXOzHFtSkJy9zEvqHZ
         mafj4TyZnrheCv3TAB7zfbhtgZf3Hrhckv2/aOjRWr/UUd1m1NzzOWB2OFG2l6HP2TPc
         /5h8YXNKgQcNxiZxPiS81rHQowkL0zSoRlNiOJwwqVhqchbhkG35fEZ0Jv6K8t/PTz/m
         9lDADd8rq5lQ+y8mG0vf0tcXzX9ZxrsfEqidEb0Hz+HiIC8HKN1NWGdPDB9PvKVAovBo
         p37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680618775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5TeZQ266LbK5QH2jgnCEXAl0zq9NQeUvBQJ7yQxwh3E=;
        b=USm1+NtzQ1x85MJNOnZ/ECUJQzOih8MkZaOdyypzhBWO+2oKrI3ctrUSWarUzakouI
         Vi0OyOvoKf5BBtx1MFKkRO2xr7T5eiIKF2nlB2nP78HOy72JWhOc5scp85uqZhjU0dgS
         5R9Lpw/FV9anRbcBaaCcFtpYvyLWeddv1A4f/tw1JFR+3a/HWoGvthm27rYaSDWb4DKw
         cbGCJ3Av8K+GdTZlEP3OvD3gCzmfiNnimsDgXW/sMAIUqQz8l3Hc2jO699XuWBYVvYf0
         w7eRdjhgaNquwom7kLeZQ3V4MLMUw+E0Dnsvpq0+RzGyYDUHOWCj72NRWcMJ7Aj01VB/
         aljg==
X-Gm-Message-State: AAQBX9fzQFen9cJz1uKXzioahN99XZigw8ms6d1PPjG4LkwxNPF21MC2
        1t9+iRSOIlDkJYLUp0iY456m8w==
X-Google-Smtp-Source: AKy350bWh+5vjDW9hGWTBBv4oczteiAWOVzKArLgUlLA6mfRVA4cLr/5wyVrkNsz13Q+I8hAzxfSow==
X-Received: by 2002:a0d:df02:0:b0:541:6b00:f68d with SMTP id i2-20020a0ddf02000000b005416b00f68dmr2876678ywe.16.1680618774816;
        Tue, 04 Apr 2023 07:32:54 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id p76-20020a81984f000000b00545a0818489sm3234439ywg.25.2023.04.04.07.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:32:54 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v5 0/4] Migrate IDIO-16 GPIO drivers to regmap API
Date:   Tue,  4 Apr 2023 10:32:44 -0400
Message-Id: <cover.1680618405.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v5:
 - Remove regmap_config max_register lines as superfluous
 - Enable use_raw_spinlock to prevent deadlocks when running -rt kernels

The regmap API supports IO port accessors so we can take advantage of
regmap abstractions rather than handling access to the device registers
directly in the driver. The 104-idio-16 and pci-idio-16 modules depend
on the IDIO-16 library and are thus updated accordingly.

By leveraging the regmap API, the idio-16 library is reduced to simply a
devm_idio_16_regmap_register() function and a configuration structure
struct idio_16_regmap_config.

This patchset depends on the "Drop map from handle_mask_sync()
parameters" patchset [0].

[0] https://lore.kernel.org/all/cover.1679323449.git.william.gray@linaro.org/

William Breathitt Gray (4):
  gpio: idio-16: Migrate to the regmap API
  gpio: 104-idio-16: Migrate to the regmap API
  gpio: pci-idio-16: Migrate to the regmap API
  gpio: idio-16: Remove unused legacy interface

 drivers/gpio/Kconfig            |   7 +-
 drivers/gpio/gpio-104-idio-16.c | 286 +++++++------------------------
 drivers/gpio/gpio-idio-16.c     | 254 ++++++++++++++-------------
 drivers/gpio/gpio-idio-16.h     |  79 +++------
 drivers/gpio/gpio-pci-idio-16.c | 294 +++++++-------------------------
 5 files changed, 289 insertions(+), 631 deletions(-)


base-commit: 7b59bdbc3965ca8add53e084af394c13a2be22a8
prerequisite-patch-id: cd19046150b7cff1be4ac7152198777aa960a3df
prerequisite-patch-id: bd3e3830d9ce4f3876a77483364d7190b7fdffa7
-- 
2.39.2

