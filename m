Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B5C5FA2DC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiJJRpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiJJRpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:45:07 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5E530F7B;
        Mon, 10 Oct 2022 10:45:00 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id z30so7076810qkz.13;
        Mon, 10 Oct 2022 10:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aFND8tOUDoogOYlSHqq+nm9CVKgkDI4jo97xHdJ+3GQ=;
        b=eE6P7BLL3b/r3/gcdbTPu69S7mpYSdSWMwm2Y/l5KWtHQzWf7tucBWge4KY2s6CpH6
         GQxIF+QCdDEVIDFhMoH3E8F5dENU+L8IlE7ffAIeBLdYIcoyhbqqIRTintbsg1drR691
         sSW9klLOf1WPFdUuMJB20Ahjzge/35HgZeBBcmGTIcxg/WjJI7Br65o6EHtgezJMPC1d
         lQlaiEor6uObH7omkiPF1JE9z1iWyUdHgFzhNhPbT9EuBN6//fCSOiKqJ/EXmf5MY0RH
         2SSYqPYo7mBcnAX4Ht6Jqp7L9K8kDI/e31F+VkYkeW9CZvP5sl5c7X0pt6u6EDfAM0tQ
         DDXw==
X-Gm-Message-State: ACrzQf2Bc0XqNebzk6OK/Tqtey6YLm5uqMUeKgos7dQI4kb1FOzi6J7O
        1nJX9HoqFhLJ8oTDZCc5L7/Md5bJTSXjiD9UChiOG9dgeRU=
X-Google-Smtp-Source: AMsMyM6vCDY+wUZmVj+9OJ75rzecLsYzFdy3OogmHAEm9vSN1moFkdoQSbjGgPa+MLeTKdVjcGDpuBPCL4F3nW+Cm+k=
X-Received: by 2002:a05:620a:4008:b0:6ce:8725:cb7 with SMTP id
 h8-20020a05620a400800b006ce87250cb7mr14043735qko.480.1665423899230; Mon, 10
 Oct 2022 10:44:59 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 10 Oct 2022 19:44:48 +0200
Message-ID: <CAJZ5v0jxEKB0521TSXqrJj4D0=2Dm+tXe-RxMff-2exxGLcA6A@mail.gmail.com>
Subject: [GIT PULL] More ACPI updates for v6.1-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.1-rc1-2

with top-most commit 056a81549c2722f0e7a9cceb7a98728eb1d67434

 Merge branches 'acpi-apei', 'acpi-wakeup', 'acpi-reboot' and 'acpi-thermal'

on top of commit 9388076b4cedf199624173b4fcd3f208c02632d6

 Merge tag 'acpi-6.1-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more ACPI updates for 6.1-rc1.

These fix 2 issues, in APEI and in the int3472 driver, clean up the
ACPI thermal driver, add ACPI support for non-GPE system wakeup events
and make the system reboot code use the S5 (system off) state by default.

Specifics:

 - Fix ACPI device object reference counting in (recently updated)
   skl_int3472_fill_clk_pdata() (Andy Shevchenko).

 - Fix a memory leak in APEI by avoiding to add a task_work to kernel
   threads running when an asynchronous error is detected (Shuai Xue).

 - Add ACPI support for handling system wakeups via GPIO wake capable
   IRQs in addition to GPEs (Raul E Rangel).

 - Make the system reboot code put ACPI-enabled systems into the S5
   (system off) state which is necessary for some platforms to work as
   expected (Kai-Heng Feng).

 - Make the white space usage in the ACPI thermal driver more consistent
   and drop redundant code from it (Rafael Wysocki).

Thanks!


---------------

Andy Shevchenko (1):
      platform/x86: int3472: Don't leak reference on error

Kai-Heng Feng (2):
      kernel/reboot: Add SYS_OFF_MODE_RESTART_PREPARE mode
      PM: ACPI: reboot: Reinstate S5 for reboot

Rafael J. Wysocki (3):
      ACPI: thermal: Use white space more consistently
      ACPI: thermal: Drop redundant parens from expressions
      ACPI: thermal: Drop some redundant code

Raul E Rangel (4):
      gpiolib: acpi: Add wake_capable variants of acpi_dev_gpio_irq_get
      ACPI: resources: Add wake_capable parameter to acpi_dev_irq_flags
      i2c: acpi: Use ACPI wake capability bit to set wake_irq
      ACPI: PM: Take wake IRQ into consideration when entering suspend-to-idle

Shuai Xue (1):
      ACPI: APEI: do not add task_work to kernel thread to avoid memory leak

---------------

 drivers/acpi/apei/ghes.c                      |   2 +-
 drivers/acpi/device_pm.c                      |  15 ++
 drivers/acpi/irq.c                            |   8 +-
 drivers/acpi/resource.c                       |  16 +-
 drivers/acpi/sleep.c                          |   8 +
 drivers/acpi/thermal.c                        | 211 +++++++++++++-------------
 drivers/gpio/gpiolib-acpi.c                   |  15 +-
 drivers/gpio/gpiolib-acpi.h                   |   2 +
 drivers/i2c/i2c-core-acpi.c                   |  40 +++--
 drivers/i2c/i2c-core-base.c                   |   6 +-
 drivers/i2c/i2c-core.h                        |   4 +-
 drivers/platform/x86/intel/int3472/tps68470.c |   6 +-
 drivers/pnp/pnpacpi/rsparser.c                |   7 +-
 include/linux/acpi.h                          |  23 ++-
 include/linux/ioport.h                        |   3 +-
 include/linux/reboot.h                        |   8 +
 kernel/reboot.c                               |  17 +++
 17 files changed, 245 insertions(+), 146 deletions(-)
