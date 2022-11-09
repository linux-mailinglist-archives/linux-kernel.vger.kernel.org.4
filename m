Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B126220B7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 01:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiKIA07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 19:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiKIA05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 19:26:57 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396B122B09;
        Tue,  8 Nov 2022 16:26:56 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id h193so14781016pgc.10;
        Tue, 08 Nov 2022 16:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rd9e65C2L1MaGoFoYCg3309gq69yAsyo4bc99h0REBg=;
        b=WQBHB3EEgLGD0Peb3Dhu47EhbgvWkkxuf1lWtGGP8WDJf1zJ+j7532pEa8XkD3Br0a
         tFURJP63+WH0aCBjMN2xh0aladptn8+OXNq2wozfp4tJnVvDCTYeKNCIZKjHumK6R+xG
         3ogLAn2pZzFxj60wVZBR3LbSs7xT0sb2sC+Y3+Scf/soJCBgPfgr8lTM/CLb2ygFhWdi
         mx7sYiKtVmO57xiA5zPghz+dqHEqdk6J5TB9enRv0XjEI4ylO9Bw6IMylrZHal3noXTi
         sJm2WbZavHoH1XCuSr7juxktPPoDRKO/WUnauXua9sNAzDO+BstlgVWpSavU03zR/KlY
         ndsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rd9e65C2L1MaGoFoYCg3309gq69yAsyo4bc99h0REBg=;
        b=4gE3GA4bmQwZFF72AWtiOW26rdF8YLHKm86OYiLNPcbSYkZ/xsLYJMoUsSqF6NXhjw
         4eF/gxwXURiyX7cnVzSm09s6Dy3sHGSXlnhCfFlV7xCfksqWO8LKFyaaivZivVJ6+bQZ
         QnG3319blQRvj4bF1sMDJpbJasPA7hROU0A5Id3B91sOslfP3kq7eHGwP8d9kSmd+PbC
         JNILUKaiOeFUay+mV6uZh6kkHNT7z3MpkAsyRWGJGHDmsR6UaOBuc8zvOjOx6p0QtGqB
         VK5YJVThSUQ1nZFMkI5KpGA+hQ3ft6WolvzMVJWuH1Q4yafpTPeaFWioxLvYzGldgbOV
         8ylA==
X-Gm-Message-State: ACrzQf1zKGga6HzXt82ry67DjM0JqBPgXlQMjsOAdpbU6AQyrhbk8KTw
        Bf8FKiPXBmM8WOwjMaFFDPI=
X-Google-Smtp-Source: AMsMyM6Otpg0/E8uz/jT/dsjwExFbpKYWzWZzV86jIj5kCV7qSDIXiqfisx61m+Uq69f7bKJUY0KLA==
X-Received: by 2002:a05:6a00:1504:b0:56d:1ee8:973e with SMTP id q4-20020a056a00150400b0056d1ee8973emr36325685pfu.30.1667953615481;
        Tue, 08 Nov 2022 16:26:55 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:9f46:7242:26:f220])
        by smtp.gmail.com with ESMTPSA id i65-20020a626d44000000b0056bd737fdf3sm6907324pfc.123.2022.11.08.16.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 16:26:54 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] Add support for software nodes to gpiolib
Date:   Tue,  8 Nov 2022 16:26:45 -0800
Message-Id: <20221031-gpiolib-swnode-v2-0-81f55af5fa0e@gmail.com>
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
 drivers/gpio/gpiolib-acpi.c   | 132 ++++++++++++++-----------=0D
 drivers/gpio/gpiolib-acpi.h   |  54 +----------=0D
 drivers/gpio/gpiolib-of.c     |   7 +-=0D
 drivers/gpio/gpiolib-of.h     |   4 +-=0D
 drivers/gpio/gpiolib-swnode.c | 128 ++++++++++++++++++++++++=0D
 drivers/gpio/gpiolib-swnode.h |  14 +++=0D
 drivers/gpio/gpiolib.c        | 219 +++++++++++++++++---------------------=
----=0D
 include/linux/gpio/property.h |  11 +++=0D
 9 files changed, 329 insertions(+), 241 deletions(-)=0D
---=0D
base-commit: b6fc3fddade7a194bd141a49f2689e50f796ef46=0D
change-id: 20221031-gpiolib-swnode-948203f49b23=0D
=0D
-- =0D
Dmitry=0D
=0D
