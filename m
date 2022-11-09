Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F9C62337B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbiKITaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKITau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:30:50 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1775926558;
        Wed,  9 Nov 2022 11:30:49 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id l6so17676969pjj.0;
        Wed, 09 Nov 2022 11:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lnle8lMV56XQau4jCvU7SPGxEKG97XKxs8od3dMkLCg=;
        b=DQGYIMyN6k+qRFSIQdQrSA7Fxg32QuZXoUzGz4iaueCclRKOjcztwpQsBBRReaah3r
         6B2r7RbW5+cFnlfiZ2hhFVHtbk96NVP5cGMm54/wz8KEW+f3FGoDImOLMtOOL5Fc8b21
         15eg5pmOteR++0WTIJmWhvzf3YX0l6LVWD6cEZKNO8/3U4dGkEFpyQs8nu0hurptIG2P
         HRnDi5fwAYl7o5lyb/kXcIv3XSkEZFqcJbCk0reQLXwYvYzwETAmqEE7JhAmwDs8NXwC
         /tj96wu9SpQy7wh5i9IoCQDf8HDeL7QOYJdVmLZaBb6DFmAxmS9CjAIU0w1EZWHWBJqJ
         bG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lnle8lMV56XQau4jCvU7SPGxEKG97XKxs8od3dMkLCg=;
        b=fEPZUAtPa9LFPVW102CS8Kl23BWz96orUUp1WcD2FopmG5I0ZM7fMb1aWBolC3utcW
         ZIMB3212q3k6BBN7J7CLMwV9bBOAJPzBnYCv94yHySncBpLNtBwSrQas0bk/dtRGgvfJ
         1/LZ0xp7WUsHt/dAia0g64gNX8nDkzt37N/NUFRzidxRtl2zxzIAZN9dnn3Gkqpw1Kv0
         ZcsjLjgqbFQRwYAAVGtnFbz0+KY6nn+PNK8vxCfc3IrZ/PjZjRnjgJDA0xynUo88MPMB
         Fc43ADdHPZj56qnrLhkWRHx2zZyDbDcB3PDHW+grdkp87gLAPJAfj78GsMOQlMfKQrCa
         ZglA==
X-Gm-Message-State: ACrzQf3StDiVmpP9b4x9he4WvUYynJQLDs3CLc1Aje4/53GCym/azrIu
        Y5nb8huAI9weMHJIPiaL2Os=
X-Google-Smtp-Source: AMsMyM7DJdU+TvsxX46ZY2ZEetPtW7U6l3W9hejmCFjFzrC44et5WLIKh21yjZ31aFU5hNJy8dVSHQ==
X-Received: by 2002:a17:902:9b88:b0:188:620d:90fc with SMTP id y8-20020a1709029b8800b00188620d90fcmr32387279plp.61.1668022248374;
        Wed, 09 Nov 2022 11:30:48 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:9f46:7242:26:f220])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902f68200b00186ac4b21cfsm9567462plg.230.2022.11.09.11.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 11:30:47 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v3 0/6] Add support for software nodes to gpiolib
Date:   Wed,  9 Nov 2022 11:30:38 -0800
Message-Id: <20221031-gpiolib-swnode-v3-0-0282162b0fa4@gmail.com>
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
base-commit: b6fc3fddade7a194bd141a49f2689e50f796ef46=0D
change-id: 20221031-gpiolib-swnode-948203f49b23=0D
=0D
-- =0D
Dmitry=0D
=0D
