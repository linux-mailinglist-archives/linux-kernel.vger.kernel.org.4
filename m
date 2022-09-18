Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985245BBE75
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 16:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiIROg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 10:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiIROgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 10:36:45 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F96220C0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 07:36:43 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id k12so18944399qkj.8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 07:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=13QwewIwzroQU6uQsOD5mJo714A427B3glcmrYb0jfs=;
        b=Qr7qp0URoDQJLonqKRKVXmRkpDxoBoVE6IGqFVWHgJrtH5v8QvK1akfUJxqfcU4oJJ
         LFbY+dp0gj2opdgVdyYIoAVRS06DL0SKU0KlCX3KHAjiY+nRjjwxQpcafzHQ6azdYisF
         gxSqoUI2Vnlb/+crK0xnNpQlXv8ywVJcAPiPrZTVz2Ne7EuVcdBqZFF7l5hcL4kibo5e
         mP/q/r/ynCUM5zvZcSrpyd0cBesxdawKHtzgo0uK+MQVgIjUdudnFLbkqY7rxPkrwv5r
         NdEdQ9EXGzncahSKREs9O4jgIsCHretjToBoXQn+u/0NQyWgrPY44mkQk8/xkVt6C/+r
         6+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=13QwewIwzroQU6uQsOD5mJo714A427B3glcmrYb0jfs=;
        b=ylWnfcVYp4DKi8k9jeiN5WN2y/XtUnTz58aDox7A8Nhs384cqMT+zO+0lg71nArpr1
         X67yV66KVg5g8Ima7opF+S20Dhh6QKiOoj+2o767kf7yNZcX6jsMflcvGGAq8lKEzBWb
         jQYMWaMC+FZ0CgL8orcsuQF9rjm2Vcy0RytDCtajKDknUuV/BBCY1VER0oTKZIFfD6gd
         UWz29/5SZ1lIiiKTrGcECNuWGJ8g71/nDEVcHNOLI6A+frdeROlykMc3jb3Gm1O/4/OI
         feCCgtExQZlav6Gldk3lgoquINUjOLF54DmSFn8lAHFHFMXi402kiOQlDaPcAC/tn06I
         C2ww==
X-Gm-Message-State: ACrzQf30oMk9Horip48t+MudSHp5L93jliCku6/tFuGinLLSF2ct+ytK
        dxktSzqyZDTBZNGchmAhsVfAQQ==
X-Google-Smtp-Source: AMsMyM7pfQasD7jkJqYSKPTlg6d4Na6JLJVvUKrDnX/Rzru0o7Iaie995kOt0dsa5d39xUGMoOUn7A==
X-Received: by 2002:a05:620a:29c5:b0:6ce:b8f3:fd5b with SMTP id s5-20020a05620a29c500b006ceb8f3fd5bmr10344295qkp.107.1663511802512;
        Sun, 18 Sep 2022 07:36:42 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id q31-20020a05620a2a5f00b006bb0e5ca4bbsm11456215qkp.85.2022.09.18.07.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 07:36:42 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mranostay@ti.com,
        jpanis@baylibre.com, gwendal@chromium.org, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, david@lechnology.com,
        robertcnelson@gmail.com,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v3 0/4] Implement support for Counter array components
Date:   Sun, 18 Sep 2022 10:36:30 -0400
Message-Id: <cover.1663511054.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v3:
 - Fix array length overwrite by allocating space for each array element
 - Add support for counter array component reads from Counter chrdev

The COUNTER_COMP_ARRAY Counter component type is introduced to enable
support for Counter array components. With Counter array components,
exposure for buffers on counter devices can be defined via new Counter
array component macros. This should simplify code for driver authors who
would otherwise need to define individual Counter components for each
array element.

Driver authors can handle reads/writes for an array component by
receiving an element index via the `idx` parameter and processing the
respective value via the `val` parameter.

For example, suppose a driver wants to expose a Count's read-only
capture buffer of four elements using a callback
`foobar_capture_read()`::

        DEFINE_COUNTER_ARRAY(foobar_capture_array, COUNTER_COMP_U64,
                             NULL, 4)
        COUNTER_COMP_COUNT_ARRAY_U64("capture", foobar_capture_read,
                                     NULL, foobar_capture_array)

Respective sysfs attributes for each array element would appear for the
respective Count:

* /sys/bus/counter/devices/counterX/countY/capture0
* /sys/bus/counter/devices/counterX/countY/capture1
* /sys/bus/counter/devices/counterX/countY/capture2
* /sys/bus/counter/devices/counterX/countY/capture3

If a user tries to read _capture2_ for example, `idx` will be `2` when
passed to the `foobar_capture_read()` callback, and thus the driver
knows which array element to handle.

In addition, this patchset introduces the Signal polarity component,
which represents the active level of a respective Signal. There are two
possible states: positive (rising edge) and negative (falling edge). The
104-quad-8 driver is updated to expose its index_polarity functionality
via this new polarity component.

A macro COUNTER_COMP_ARRAY_POLARITY() is provided for driver authors to
support Counter arrays of Signal polarity component type;
DEFINE_COUNTER_AVAILABLE may be used to define the polarity modes that
are passed to DEFINE_COUNTER_ARRAY. The only component types supported
for Counter arrays currently are COUNTER_COMP_U64 and
COUNTER_COMP_SIGNAL_POLARITY.

William Breathitt Gray (4):
  counter: Introduce the Signal polarity component
  counter: 104-quad-8: Add Signal polarity component
  counter: Consolidate Counter extension sysfs attribute creation
  counter: Introduce the COUNTER_COMP_ARRAY component type

 Documentation/ABI/testing/sysfs-bus-counter |  13 +
 drivers/counter/104-quad-8.c                |  35 +++
 drivers/counter/counter-chrdev.c            |  47 ++-
 drivers/counter/counter-sysfs.c             | 303 ++++++++++++++++----
 include/linux/counter.h                     | 131 +++++++++
 include/uapi/linux/counter.h                |   6 +
 6 files changed, 483 insertions(+), 52 deletions(-)


base-commit: a12224997bec72d231a8dd642876e6364decdc45
-- 
2.37.3

