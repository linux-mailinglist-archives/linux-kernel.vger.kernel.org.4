Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6300F5EADEA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiIZRQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiIZRQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:16:25 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A3F9F0FB
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 09:30:14 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id x18so4432044qkn.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 09:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=mmHGu7GIqnLfc3oj6qy16LLQNqltkgBvvr4JGiJ4pdg=;
        b=P6FZxUrhBdPi7i7DR0gVo/ZjxXDAK+vUOQc4jFe5+Ate0qP5u4GX994LFSZ9s5wKJI
         LnJehcHH1ZsmmDggMI/cD1YcpqU3uYSzKHuVn1PO/IWqMBBfKQvUQD8ONjEgS9fCAN0k
         eOJpYSw3YYy0/fId1hda19H+9r232pk29RkQ+1y4xIddOOULJ0IK78EDUyyJll2Bkj0D
         ilm+qpuUVDY3pO0Ak6t+0aZEHZkkm8IgWfEUODvpYSiE8lvYYiqcrWsdbfVIBH/SOy3y
         O91u903qLSP0q0zvAkNwd+inhFGDZlt9Vp5a3JlNzNkbi3FAqgRPC5dEj9vgV/W4XPib
         XCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=mmHGu7GIqnLfc3oj6qy16LLQNqltkgBvvr4JGiJ4pdg=;
        b=YhNo+Du9mv/I/bAY+lfRS1XB67L8Q//MUGeHskv7VMPUQ/N7SdSTtGJm+1zJ+91Hhv
         c8VuXItdkvFruR8D6oq1OH9JQ62wGS6CMtVuTyNHBRe4OFoxh3XW5+HaMxVpBfGsqBTC
         n+GrQHUuwDO+Q9FkP29JfKdoimozLG6PFdUbOPBiB4/1S3FFQJTfarCtbZTNlsFyWELv
         d5Du4t0JNGsTScK1NR3Qhp1eMEHDxxttF8gLif+9Rx2Jk5sGRvr+ttrVPRFV2iTserhW
         Vz9Gz0jHVunhINO3IIxKUho7vb4oG5nBzF1DK9ZG+VqrChviu196rAaP9ANuxO8H++uC
         eCiw==
X-Gm-Message-State: ACrzQf2Q/gVj99oLJkDelpswkjvNM1F066C7UfZy2WA47+Y7vOQUtHTL
        2KVUmCyJX378ffKbJHwTrY6QJQ==
X-Google-Smtp-Source: AMsMyM5Z4nQMzaHqSq6Fw7kceX8iDr7t+2kNa9f+BzEt03cLzWmuhK1XJinmdrIEt+hL0e+n5e5fnA==
X-Received: by 2002:a05:620a:4807:b0:6cf:55d:e4c3 with SMTP id eb7-20020a05620a480700b006cf055de4c3mr14795660qkb.563.1664209813300;
        Mon, 26 Sep 2022 09:30:13 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id 139-20020a370a91000000b006ce60296f97sm11542146qkk.68.2022.09.26.09.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 09:30:12 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mranostay@ti.com,
        jpanis@baylibre.com, gwendal@chromium.org, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, david@lechnology.com,
        robertcnelson@gmail.com,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v6 0/5] Add support for Counter array components
Date:   Mon, 26 Sep 2022 11:16:33 -0400
Message-Id: <cover.1664204990.git.william.gray@linaro.org>
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

Changes in v6:
 - Rebase on latest counter-next branch
 - Add ABI Documentation lines for capture_component_id and
   polarity_component_id

The COUNTER_COMP_ARRAY Counter component type is introduced to enable
support for Counter array components. With Counter array components,
exposure for buffers on counter devices can be defined via new Counter
array component macros. This should simplify code for driver authors who
would otherwise need to define individual Counter components for each
array element.

Eight Counter array component macros are introduced::

        DEFINE_COUNTER_ARRAY_U64(_name, _length)
        DEFINE_COUNTER_ARRAY_CAPTURE(_name, _length)
        DEFINE_COUNTER_ARRAY_POLARITY(_name, _enums, _length)
        COUNTER_COMP_DEVICE_ARRAY_U64(_name, _read, _write, _array)
        COUNTER_COMP_COUNT_ARRAY_U64(_name, _read, _write, _array)
        COUNTER_COMP_SIGNAL_ARRAY_U64(_name, _read, _write, _array)
        COUNTER_COMP_ARRAY_CAPTURE(_read, _write, _array)
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

        DEFINE_COUNTER_ARRAY_CAPTURE(foobar_capture_array, 4);
        COUNTER_COMP_ARRAY_CAPTURE(foobar_capture_read, NULL,
                                   foobar_capture_array)

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

William Breathitt Gray (5):
  counter: Introduce the Signal polarity component
  counter: 104-quad-8: Add Signal polarity component
  counter: Introduce the Count capture component
  counter: Consolidate Counter extension sysfs attribute creation
  counter: Introduce the COUNTER_COMP_ARRAY component type

 Documentation/ABI/testing/sysfs-bus-counter |  21 ++
 drivers/counter/104-quad-8.c                |  35 +++
 drivers/counter/counter-chrdev.c            | 135 +++++++--
 drivers/counter/counter-sysfs.c             | 304 ++++++++++++++++----
 include/linux/counter.h                     | 147 ++++++++++
 include/uapi/linux/counter.h                |   8 +
 6 files changed, 583 insertions(+), 67 deletions(-)


base-commit: 7d333188e1d048457572d3a7d0630cd7b91f902d
-- 
2.37.3

