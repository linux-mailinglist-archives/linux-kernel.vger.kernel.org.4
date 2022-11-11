Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77F7626476
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 23:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbiKKWTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 17:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbiKKWTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 17:19:20 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3001F5FD2;
        Fri, 11 Nov 2022 14:19:13 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id k15so6019431pfg.2;
        Fri, 11 Nov 2022 14:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qpOJ3rVA6/X/I77P5ZYNEkOM6gDrKnPiFfbCrZsQZMA=;
        b=XE6EYDIOkSdUYCCkxzHig/4KE/tiDWG4nsgOB2EDTcVmrCrTie510lmRWzfa0kISyz
         3bVIXO8ps4aJODpuCy6rhvMiD2jTbn6JmGtjlG/mJGw55ieWX6wObKsXxoTX5s/uSknu
         T6PFeVnEriM6jgc9x16ugI4uDuuittNi8fz6UFBnI3D43Fmh0Rf/r2SMYnBghX42kzXg
         9nM+FzdhzA/Ojtav6NC7n59CXYm2uR/TVSNjRBRF7oDx2e3OTns8t9qz4CkrLyeaQVug
         kqk6TuQ1JNFzeVfOgYCcwegj/vT74SG4LuRTfxGM4Dv9Vw8sEwQKsiJCQ44hlBKxaVUF
         G7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qpOJ3rVA6/X/I77P5ZYNEkOM6gDrKnPiFfbCrZsQZMA=;
        b=4rGUwo0rK7TPgvPoYrP5yTZgsLSjgi0FkUt5yGlKDefctY7ThQcuwvNukU0LlSebAu
         DlD8LDJZu0ZNwa+WSrvT1zradbeQo75KiG2h22mcCg8mkf8g0qae+J1SdreNtX7nsvtC
         2sbyx1xV5D/5CyO3xDW1Yoo4urwElp2RqYI1AJASIQ1c8iLShPaFkMSYEMwkQ5OTDvio
         rvPaTLH9WHE1iFzfKq0SkQnsUP7ZNXHXWTp9YEvHesMn4+SmBlcwed26gvUtTSvNAp2t
         SAvuDR7sGQlzI6a4PFNR7hzQg/OmuQZlAUbXmxkZHi96xhlrE0bW1Kb5m7leYqZ+X6Ab
         Bb6A==
X-Gm-Message-State: ANoB5pmPaOdI/tayKx0HjFtgdqcQlK+BaMb3QXhHjEakKHBPtL8h4lJQ
        khzeL93ZD66Lt7b54XDWU/U=
X-Google-Smtp-Source: AA0mqf5FbHSSuKQXc103+x9LY5avOvdjIamoZrDgVoWi41Dax+7GKRM3/IL3tz+xbYezWfj39Vx/hA==
X-Received: by 2002:a63:fd41:0:b0:470:71df:7ec5 with SMTP id m1-20020a63fd41000000b0047071df7ec5mr3396016pgj.272.1668205152501;
        Fri, 11 Nov 2022 14:19:12 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:de05:ad1e:65ae:ea4d])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902bd8900b00180daa59314sm2201109pls.125.2022.11.11.14.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 14:19:11 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v4 0/6] Add support for software nodes to gpiolib
Date:   Fri, 11 Nov 2022 14:19:02 -0800
Message-Id: <20221031-gpiolib-swnode-v4-0-6c1671890027@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.11.0-dev-28747
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series attempts to add support for software nodes to gpiolib, using=0D
software node references. This allows us to convert more drivers to the=0D
generic device properties and drop support for custom platform data.=0D
=0D
To describe a GPIO via software nodes we can create the following data=0D
items:=0D
=0D
/* Node representing the GPIO controller/GPIO bank */=0D
static const struct software_node gpio_bank_b_node =3D {=0D
        .name =3D "B",=0D
};=0D
=0D
/*=0D
 * Properties that will be assigned to a software node assigned to=0D
 * the device that used platform data.=0D
 */=0D
static const struct property_entry simone_key_enter_props[] =3D {=0D
        PROPERTY_ENTRY_U32("linux,code", KEY_ENTER),=0D
        PROPERTY_ENTRY_STRING("label", "enter"),=0D
        PROPERTY_ENTRY_REF("gpios", &gpio_bank_b_node, 123, GPIO_ACTIVE_LOW=
),=0D
        { }=0D
};=0D
=0D
The code in gpiolib handling software nodes uses the name in the=0D
software node representing GPIO controller to locate the actual instance=0D
of GPIO controller.=0D
=0D
To: Linus Walleij <linus.walleij@linaro.org>=0D
To: Bartosz Golaszewski <brgl@bgdev.pl>=0D
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>=0D
Cc: linux-gpio@vger.kernel.org=0D
Cc: linux-kernel@vger.kernel.org=0D
Cc: linux-acpi@vger.kernel.org=0D
=0D
---=0D
Changes in v4:=0D
- Rebased on top of next-20221111=0D
- Added Andy's reviewed-by for patch #6=0D
- Link to v3: https://lore.kernel.org/r/20221031-gpiolib-swnode-v3-0-028216=
2b0fa4@gmail.com=0D
=0D
Changes in v3:=0D
- Addressed more Andy's comments=0D
- Link to v2: https://lore.kernel.org/r/20221031-gpiolib-swnode-v2-0-81f55a=
f5fa0e@gmail.com=0D
=0D
Changes in v2:=0D
- reworked the series to be independent of other in-flight patches.=0D
  That meant keeping devm_gpiod_get_from_of_node() for now.=0D
- removed handling of secondary nodes, it deserves a separate patch=0D
  series=0D
- fixed refcounting when handling swnodes (Andy)=0D
- added include/linux/gpio/property.h with PROPERTY_ENTRY_GPIO (Andy)=0D
- addressed most of the rest of Andy's comments=0D
- collected reviewed-by and acked-by=0D
- Link to v1: https://lore.kernel.org/r/20221031-gpiolib-swnode-v1-0-a0ab48=
d229c7@gmail.com=0D
=0D
---=0D
Dmitry Torokhov (6):=0D
      gpiolib: of: change of_find_gpio() to accept device node=0D
      gpiolib: acpi: change acpi_find_gpio() to accept firmware node=0D
      gpiolib: acpi: teach acpi_find_gpio() to handle data-only nodes=0D
      gpiolib: acpi: avoid leaking ACPI details into upper gpiolib layers=0D
      gpiolib: consolidate GPIO lookups=0D
      gpiolib: add support for software nodes=0D
=0D
 drivers/gpio/Makefile         |   1 +=0D
 drivers/gpio/gpiolib-acpi.c   | 132 +++++++++++++++-----------=0D
 drivers/gpio/gpiolib-acpi.h   |  54 +----------=0D
 drivers/gpio/gpiolib-of.c     |   7 +-=0D
 drivers/gpio/gpiolib-of.h     |   4 +-=0D
 drivers/gpio/gpiolib-swnode.c | 123 +++++++++++++++++++++++++=0D
 drivers/gpio/gpiolib-swnode.h |  14 +++=0D
 drivers/gpio/gpiolib.c        | 209 ++++++++++++++++----------------------=
----=0D
 include/linux/gpio/property.h |  11 +++=0D
 9 files changed, 315 insertions(+), 240 deletions(-)=0D
---=0D
base-commit: f8f60f322f0640c8edda2942ca5f84b7a27c417a=0D
change-id: 20221031-gpiolib-swnode-948203f49b23=0D
=0D
-- =0D
Dmitry=0D
=0D
