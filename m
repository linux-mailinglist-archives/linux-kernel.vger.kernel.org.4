Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0875BD80A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 01:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiISXRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 19:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiISXRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 19:17:38 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521BC4B0F6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:17:37 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id cj27so633985qtb.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=HEQfTK7qHVjLGiN97ioW09zFTOOgtsYJ7V5eTJpH85Q=;
        b=Rcj5+E+FXPBHgNjvxOB/OScvkxnPIDT+ujjJkjjIqSe49VFLukNcBkm9Tk4pYDclDd
         Zk16ab8nMDcHA4ybKEp5awiXeBAr6xwAd+a9Z52mqYH2YrEimDp7iwInBS2twxmDbZGc
         6kNZDjdyMhykEBsBHrW+J4lE3BSiHzloZHnTHb+06xX5AZaO6f2VKe3VJ2bKCK58EdgX
         4rc9DGXHIGVXuRiF2cjk11JEtHieDkNxCLvNxTEz822TduvZreKxR06HRfEk0706xh6l
         CPP0a4EQJQ2lFCl4CLw1PzCfcFDHXD1vy03T34oxMOdvfiTlf6STAVrpgqfS+PMxw7yp
         G2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=HEQfTK7qHVjLGiN97ioW09zFTOOgtsYJ7V5eTJpH85Q=;
        b=w8Xxzfb6Pem4udZCdypJOZt+5rR7JLJrKaMWt9l86U8gLBPUd+mqZ/lNQmHMaVWpwY
         3+hs6RDcn14iu6kGLCLWiJzIiAwIeXxwKXPp9KsqyGRBPaij1+yVkchb6UGTAxM3ltwY
         CbZZ2Ldt0bGilYBO+mY56DTylAqGGniH4nLD69415OdJi9kYlQY6b2OE4Ti2anJLFDjo
         m/QDg7yBe4vadfE+ALJPuoL8FCy612U8+is3QN3h2q8kGnYJdEuWAFbuq5vy7irqlfal
         nJJff8n3BEORjLKMIhPDpTEOlvKzSdyM1HVAr5vP7ur3LK6gLWhPiUpIODVAos62DOw3
         6uWQ==
X-Gm-Message-State: ACrzQf2nlSKrVNW1sdEDf1gAwxGy/MaJeFs3TVpRTtCUY9eXT9s/Ejkd
        S0J5jBlHJonV1NQCAvF/TVpZpg==
X-Google-Smtp-Source: AMsMyM6nCRojs2BqY0lnG4M2JzOXF8V1CojRcj/5zs0IChvsroSuT63mNh2MoxbhwGQ+lTtpIZWdXA==
X-Received: by 2002:a05:622a:60f:b0:35b:b737:bcbe with SMTP id z15-20020a05622a060f00b0035bb737bcbemr17214118qta.149.1663629456435;
        Mon, 19 Sep 2022 16:17:36 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id d4-20020ac80604000000b0035cebb79aaesm2547005qth.18.2022.09.19.16.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 16:17:35 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mranostay@ti.com,
        jpanis@baylibre.com, gwendal@chromium.org, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, david@lechnology.com,
        robertcnelson@gmail.com,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v4 0/4] Add support for Counter array components
Date:   Sun, 18 Sep 2022 14:22:03 -0400
Message-Id: <cover.1663524845.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v4:
 - Handle COUNTER_COMP_SIGNAL_POLARITY type in counter_attr_create() and
   counter_get_data(); previously was incorrectly treating as invalid
 - Replace DEFINE_COUNTER_ARRAY macro with DEFINE_COUNTER_ARRAY_U64 and
   DEFINE_COUNTER_ARRAY_POLARITY macros

The COUNTER_COMP_ARRAY Counter component type is introduced to enable
support for Counter array components. With Counter array components,
exposure for buffers on counter devices can be defined via new Counter
array component macros. This should simplify code for driver authors who
would otherwise need to define individual Counter components for each
array element.

Six Counter array component macros are introduced::

        DEFINE_COUNTER_ARRAY_U64(_name, _length)
        DEFINE_COUNTER_ARRAY_POLARITY(_name, _enums, _length)
        COUNTER_COMP_DEVICE_ARRAY_U64(_name, _read, _write, _array)
        COUNTER_COMP_COUNT_ARRAY_U64(_name, _read, _write, _array)
        COUNTER_COMP_SIGNAL_ARRAY_U64(_name, _read, _write, _array)
        COUNTER_COMP_ARRAY_POLARITY(_read, _write, _array)

Eight Counter array callbacks are introduced as well::

        int (*signal_array_u32_read)(struct counter_device *counter,
                                     struct counter_signal *signal,
                                     size_t idx, u32 *val);
        int (*signal_array_u32_write)(struct counter_device *counter,
                                      struct counter_signal *signal,
                                      size_t idx, u32 val);
        int (*device_array_u64_read)(struct counter_device *counter,
                                     size_t idx, u64 *val);
        int (*count_array_u64_read)(struct counter_device *counter,
                                    struct counter_count *count,
                                    size_t idx, u64 *val);
        int (*signal_array_u64_read)(struct counter_device *counter,
                                     struct counter_signal *signal,
                                     size_t idx, u64 *val);
        int (*device_array_u64_write)(struct counter_device *counter,
                                      size_t idx, u64 val);
        int (*count_array_u64_write)(struct counter_device *counter,
                                     struct counter_count *count,
                                     size_t idx, u64 val);
        int (*signal_array_u64_write)(struct counter_device *counter,
                                      struct counter_signal *signal,
                                      size_t idx, u64 val);

Driver authors can handle reads/writes for an array component by
receiving an element index via the `idx` parameter and processing the
respective value via the `val` parameter.

For example, suppose a driver wants to expose a Count's read-only
capture buffer of four elements using a callback
`foobar_capture_read()`::

        DEFINE_COUNTER_ARRAY_U64(foobar_capture_array, 4);
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

Counter arrays for polarity elements can be defined in a similar
manner as u64 elements::

        const enum counter_signal_polarity foobar_polarity_states[] = {
                COUNTER_SIGNAL_POLARITY_POSITIVE,
                COUNTER_SIGNAL_POLARITY_NEGATIVE,
        };
        DEFINE_COUNTER_ARRAY_POLARITY(foobar_polarity_array,
                                      foobar_polarity_states, 4);
        COUNTER_COMP_ARRAY_POLARITY(foobar_polarity_read,
                                    foobar_polarity_write,
                                    foobar_polarity_array)

The only component types supported for Counter arrays currently are
COUNTER_COMP_U64 and COUNTER_COMP_SIGNAL_POLARITY.

William Breathitt Gray (4):
  counter: Introduce the Signal polarity component
  counter: 104-quad-8: Add Signal polarity component
  counter: Consolidate Counter extension sysfs attribute creation
  counter: Introduce the COUNTER_COMP_ARRAY component type

 Documentation/ABI/testing/sysfs-bus-counter |  13 +
 drivers/counter/104-quad-8.c                |  35 +++
 drivers/counter/counter-chrdev.c            |  48 +++-
 drivers/counter/counter-sysfs.c             | 304 ++++++++++++++++----
 include/linux/counter.h                     | 138 +++++++++
 include/uapi/linux/counter.h                |   6 +
 6 files changed, 492 insertions(+), 52 deletions(-)


base-commit: f95ec98139dc58db72e4bd0df049a3097990a8e7
-- 
2.37.3

