Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3117C6FE25C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbjEJQYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjEJQXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:23:31 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B757ED3;
        Wed, 10 May 2023 09:22:53 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-94a34a14a54so1478553966b.1;
        Wed, 10 May 2023 09:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683735772; x=1686327772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WALWBIDRCy2Im1+Zefi6a8VTNkQRo4AaNAbgHfHj61I=;
        b=dprPTyXEAdUOId24KwggpwCUCj4yZ51+IHjSiAoP9maz+f5XiGZ5Vw6JPtQxx/Ky+x
         gjsHn6dJXDqyZUJa88b9PV+HCv2zQHoBLBGWLp9UZBBQo4qUDSTVB2GpeBl0LS65En3b
         1v1OnUL6z48/RpF0No+7p84MyK4tEkpCgz/1Vmil7rsbpIgA4OorThSUg3n2dyTqfptm
         m3vwx4XhkQ1MZdhqQqOtH/Z08MfBQQ3FpqQ8MTNNHLzDjMQDOhnJQlH5i0/x1jQRQ3WJ
         ET87xXDTR62X5LpP9+1na85Vuk1dcqwAQhGyMf5igMwlM6o1CERY4OXThUEbc+QTF0ia
         n0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683735772; x=1686327772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WALWBIDRCy2Im1+Zefi6a8VTNkQRo4AaNAbgHfHj61I=;
        b=FXMEUTEC02WgU7E5lcmqDoMBFLTIRjBlVG3ga0UX2G6Z+DIZys6+LyhbM/gfzr/VOX
         tBoO/zReJsMX+KfucpYJS4ZWJJqud7mlqRPX/oV+eEF+Ut0+7io361Bx5J1YDqa8xzTS
         CLSuybt7crb4lYC0qA6C8NrEqLVdQiqexWhkfirHNvRIjMghVMLBJ1VFgZ2lrK1LI8Ka
         MWetdEo1hv9f+vl6B2VsqdcWbJDBluACZE+YUC73J16xsJ8owKy6bYVl9kGnRlXmCr3J
         Zi/cjCRXfSLa8wtrvhL3RL59j17TV6oM31LDz50HT9j5UHtrAVsNbxqPSIaRQWjhrHQR
         cDJw==
X-Gm-Message-State: AC+VfDyZlvYHrPFy9JZK8mDf4aHx2FCfqlE4KPVCqL0rTlQLZ38Cf2p3
        Qyl3r3Hso4TDbJ8WROKHj0NxkZL1WQ6AGpLJ
X-Google-Smtp-Source: ACHHUZ5wOI+TatY/6aL0vQPXZXufisRY/j8y9VIcsJLva9Vzv9wXjrlfTPzCoHOf4Bye3ib5CMGgFw==
X-Received: by 2002:a17:906:9c83:b0:95f:4889:412a with SMTP id fj3-20020a1709069c8300b0095f4889412amr17957266ejc.33.1683735771892;
        Wed, 10 May 2023 09:22:51 -0700 (PDT)
Received: from fedora.dev.tbscz ([85.93.123.158])
        by smtp.gmail.com with ESMTPSA id m28-20020a17090677dc00b00947ed087a2csm2890149ejn.154.2023.05.10.09.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 09:22:51 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregkh@linuxfoundation.org,
        beanhuo@micron.com, nipun.gupta@amd.com, linus.walleij@linaro.org,
        mwen@igalia.com, bvanassche@acm.org, arnd@arndb.de,
        ogabbay@kernel.org, linux@zary.sk,
        jacek.lawrynowicz@linux.intel.com, geert+renesas@glider.be,
        benjamin.tissoires@redhat.com, masahiroy@kernel.org,
        yangyicong@hisilicon.com, devicetree@vger.kernel.org,
        =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
Subject: [PATCHv4 0/4] Wiegand bus driver and GPIO bitbanged Wiegand
Date:   Wed, 10 May 2023 18:22:39 +0200
Message-Id: <20230510162243.95820-1-m.zatovic1@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

thank you for the feedback regarding the previous version of this patch series.
I have tried to follow all of the advice I got and fix all the pointed issues.
One of the main issues was the usage of of API for device registration. This
has now been fixed to use fwnode API, however I was not yet able to get rid of
the of_device include, since it is required for of_driver_match_device. Please
let me know if this is correct.

CHANGELOG:

wiegand.c:
- changed ID allocation API from IDR to IDA, since the references associated to
the IDs are not needed
- removed the board_lock mutex, because it was only guarding the allocacion
and freeing of IDs, which is already supported by IDA API
- restructured the file, so that most functions are close to their caller, or
defined them at the top for better code readability
- in the function devm_wiegand_register_controller, the devres management of
the pointer to wiegand_controller structure has been replaced with
devm_add_action_or_reset function. It was intended to do the same with
devm_wiegand_alloc_controller, however, the kernel kept panicing, despite the
call order of the unregister and release functions being proper(same as with
devres managed pointer). Please let me know if this is an absolute must, if so
I will look into it further.
- moved the miscdevice from wiegand-gpio driver to be a part of the bus
driver. Now every controller is associated a /dev file. The file operation
functions were simply moved and renamed and the miscdevice structure was moved
to be a part of wiegand_controller structure
- since now every controller has a miscdevice assosciated, the data_buffer was
also moved to be a part of the controller structure, and it was made a bitmap
- used fwnode API for device registration instead of of API
- removed warnings when driver fails to get wiegand properties, instead
implemented mechanism for setting a default value similar I2C
- removed the driver matching code in register driver, as
of_driver_match_device does that already
- made wiegand_device and opaque pointer
- changed the terminology to primary and secondary

wiegand.h
- reordered the wiegand_driver structure so that miscdevice is first

wiegand-gpio.c
- removed of.h include
- changed udelay to usleep_range for longer wait times in wiegand_gpio_send_bit
- moved wiegand_gpio_groups to dev groups of the struct driver
- style changes(no commas for terminator entries, removed redundant blank
lines etc.)
- changed the names of gpio_descs from gpio_data_hi and gpio_data_lo to
data1_gpio and data0_gpio

Martin Zaťovič (4):
  dt-bindings: wiegand: add Wiegand controller common properties
  wiegand: add Wiegand bus driver
  dt-bindings: wiegand: add GPIO bitbanged Wiegand controller
  wiegand: add Wiegand GPIO bitbanged controller driver

 .../ABI/testing/sysfs-driver-wiegand-gpio     |   9 +
 .../bindings/wiegand/wiegand-controller.yaml  |  39 ++
 .../bindings/wiegand/wiegand-gpio.yaml        |  51 ++
 MAINTAINERS                                   |  14 +
 drivers/Kconfig                               |   2 +
 drivers/Makefile                              |   1 +
 drivers/wiegand/Kconfig                       |  28 +
 drivers/wiegand/Makefile                      |   2 +
 drivers/wiegand/wiegand-gpio.c                | 189 ++++++
 drivers/wiegand/wiegand.c                     | 609 ++++++++++++++++++
 include/linux/wiegand.h                       | 144 +++++
 11 files changed, 1088 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-wiegand-gpio
 create mode 100644 Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
 create mode 100644 Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml
 create mode 100644 drivers/wiegand/Kconfig
 create mode 100644 drivers/wiegand/Makefile
 create mode 100644 drivers/wiegand/wiegand-gpio.c
 create mode 100644 drivers/wiegand/wiegand.c
 create mode 100644 include/linux/wiegand.h

-- 
2.40.0

