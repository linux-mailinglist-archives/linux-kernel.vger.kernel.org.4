Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2F26190B1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 07:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiKDGKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 02:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiKDGKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 02:10:22 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376C028E30;
        Thu,  3 Nov 2022 23:10:21 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so7322170pji.1;
        Thu, 03 Nov 2022 23:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TLME7jH56C8D1+m0LNBApvFwrtLDMdDD21KTM6uwzsE=;
        b=I4A3+fMFdFrw1ItUiXAMXyb/dpRXhGT7joIpaNMQ0W+htpFOy8qm0RnLufRDNI/oee
         ui0A4rrd/yjdVcAr7RIQRAC8GqqUe6MjpRyPsyE5xs9v5xj+RlqS4CKsYpmj+ZubOiXz
         Gx3wkPoK/VqHXweC6RPk2oIOTW2xe7RrZON67KUHnXdUOaQbl5Z5wtboxg1mljZNhuNr
         tOxTvYcCQwEdwhMXmSqOlptpeIaCOuKQ5h6PtRtWQyeQuWyuVbo7TZb85bxWRsk7mzGJ
         WPPhy3mzkTrHkv94sEzsV4VUHaxz8Ij20JKxnCkC/id7+pDZmsMTKYMqav5JH7+eyWOQ
         McpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TLME7jH56C8D1+m0LNBApvFwrtLDMdDD21KTM6uwzsE=;
        b=d85n0d9umkbTZ+cHMkAKSw7mWVP2z+qrd634cOLQ+DuoxNL+7MoKJC9V9ddp4lJfDW
         Z01YuS/+s/iZukx2FgrDU3jMC9ox74uxgl6fDROo9cM3IyFRrScd7FnysYgJeiVgczht
         i1joncTdCdx5bEZmK6YpQI+xfGwXmFffIueqmAOrHaz2WQ9hC3NNTb2Qk7KUrqANyQ5E
         GVK7nxc1HlMj+akcfJkuYLYXZ5XUhSkSxAYsTmlIUztLlq4xnhxNbyecrBVTlM/pAhxz
         fc2IKz64rTRTRQk1CqEVFqK8ZAvhIGqyVl3L1QS2oEvrgi+gVFA83Vbrr4kSgXeZcuhz
         d/Ww==
X-Gm-Message-State: ACrzQf2gSFDWxhAQ4ePyVST8Qps71GJY6zoyhyoOnWymZqSBAB+mzsTE
        1oVl9BqXDNrKefck8RzHejA=
X-Google-Smtp-Source: AMsMyM6BNQnQnQmZJJmsIBLNwFI6ds2hXPvf65DlA882GVt+r1tc2tqiMseTvUiQJJMHn6UWrZ3epA==
X-Received: by 2002:a17:90a:9c6:b0:213:b346:21dc with SMTP id 64-20020a17090a09c600b00213b34621dcmr32914249pjo.166.1667542220641;
        Thu, 03 Nov 2022 23:10:20 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id x5-20020aa79ac5000000b0056bfd4a2702sm1791411pfp.45.2022.11.03.23.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 23:10:19 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Add support for software nodes to gpiolib
Date:   Thu,  3 Nov 2022 23:10:10 -0700
Message-Id: <20221031-gpiolib-swnode-v1-0-a0ab48d229c7@gmail.com>
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
 * the devicei that used platform data.=0D
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
Note that kbuild robot is likely to complain about this patchset because=0D
it depends on patches removing [devm_]gpiod_get_from_of_node() and=0D
devm_fwnode_get_[index_]gpiod_from_child() APIs that are still pending.=0D
I pushed them to=0D
=0D
git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tmp-gpiolib=0D
=0D
for your reference.=0D
=0D
To: Linus Walleij <linus.walleij@linaro.org>=0D
To: Bartosz Golaszewski <brgl@bgdev.pl>=0D
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>=0D
Cc: linux-gpio@vger.kernel.org=0D
Cc: linux-kernel@vger.kernel.org=0D
Cc: linux-acpi@vger.kernel.org=0D
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
 drivers/gpio/gpiolib-acpi.c   | 132 +++++++++++++----------=0D
 drivers/gpio/gpiolib-acpi.h   |  54 +---------=0D
 drivers/gpio/gpiolib-of.c     |  52 +--------=0D
 drivers/gpio/gpiolib-of.h     |  16 +--=0D
 drivers/gpio/gpiolib-swnode.c | 106 +++++++++++++++++++=0D
 drivers/gpio/gpiolib-swnode.h |  13 +++=0D
 drivers/gpio/gpiolib.c        | 239 ++++++++++++++++++++------------------=
----=0D
 8 files changed, 316 insertions(+), 297 deletions(-)=0D
---=0D
base-commit: dc04f5ab1b1114aa19b9026f816fc01ca9c9941d=0D
change-id: 20221031-gpiolib-swnode-948203f49b23=0D
=0D
-- =0D
Dmitry=0D
=0D
