Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939CD5BB540
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 03:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiIQBQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 21:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiIQBQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 21:16:32 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E490445046
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 18:16:30 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id a20so14559780qtw.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 18:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=TapueQ5b1Bvm8CCBp00PaYkfMjxgzKZ89MFFT3rwJ2Q=;
        b=wcabjB6teeuSUmyhpUBBgOuPkJzOOJdGbKpxbHRNOBrPHLh4t7mmYKfHDV489WDwSI
         wHLi99nCJMNLLjfX8BK7qJljdsN+2vpaLPDDxVMcslMqdStONxQOb//wqUZJCA5As579
         7aDK2gjyn+4LDdpvuZSHHyR2mUayslhDQzE7Phq6zhfQvChjc3OUAXNKMCQV2NuIyy+l
         VQmajsF4dQgRZBO/9RkFTr+eTgRonWaIHj0aRDcP9DGBUf92S1DmJmYNMuHnXV3Cn0f2
         6xK4bQD0jYX+iBHtLXvhpkCVQlszPFdtMjcN97NXerlLWdonmDfFj+/buYOtBNTY/kGX
         BqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=TapueQ5b1Bvm8CCBp00PaYkfMjxgzKZ89MFFT3rwJ2Q=;
        b=LH83zl69P5EJKwanO8pIPNYKIJekqjbdL1LWZSj33wDuaQxEgYl4GG7yfJxEs4fhk2
         vJW1ICgj4+tAydh/SnxO/HxL93QXJDTfi7LESdcuRFze0OMtA1T8jSntyO3OSeQRuYRB
         +vbwm5Mag38nHlcOXMb2PCx11i1h1EdBe+jYxyQoarDj9r/YSkit2RYSMqW3b1S1eges
         Ye9wZHXeSCnmLerE5ZkBDJAjEsZj2gE1xDDvCMRszDgrjsPFtXpq7N1qLfUFjuPWrAmZ
         RPXDQ1clA9Gpw10yhIFNXYH0LJjobxSAJ9SmB6CXqK5mq1vLVAKwiLm6c28k1Y/+r0YR
         BoHA==
X-Gm-Message-State: ACrzQf3DPZawzZ+mxFmKhS3je3SH+b6dv+7uWsr0fSIQRindmm8f0apf
        0wn0vJt9POP9RiKsekXR5joZUQ==
X-Google-Smtp-Source: AMsMyM5LXyXf9hP8WDxaYOjxpFqyakGdtbuUiObd4/AeVkX45JUzQ4kC2Ub1xhMCEOZrvmO3ROIs9w==
X-Received: by 2002:ac8:5e49:0:b0:35b:b456:7261 with SMTP id i9-20020ac85e49000000b0035bb4567261mr6896652qtx.490.1663377390059;
        Fri, 16 Sep 2022 18:16:30 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id v6-20020a05620a440600b006bb87c4833asm8085434qkp.109.2022.09.16.18.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 18:16:29 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mranostay@ti.com,
        jpanis@baylibre.com, gwendal@chromium.org, bleung@chromium.org,
        groeck@chromium.org, jic23@kernel.org, david@lechnology.com,
        robertcnelson@gmail.com,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v2 0/4] Add support for Counter array components
Date:   Fri, 16 Sep 2022 20:39:24 -0400
Message-Id: <cover.1663372750.git.william.gray@linaro.org>
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

Changes in v2:
 - Fixed Counter array component id allocation; was previously
   allocating duplicate ids to subsequent components
 - Introduced the Signal polarity component
 - Added Signal polarity component for 104-quad-8 driver
 - Converted COUNTER_COMP_ARRAY_U64 to COUNTER_COMP_ARRAY
 - Added support for Counter arrays of Signal polarity component type
 - Introduced DEFINE_COUNTER_ARRAY helper macro to define Counter arrays

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
are passed to DEFINE_COUNTER_ARRAY.

William Breathitt Gray (4):
  counter: Introduce the Signal polarity component
  counter: 104-quad-8: Add Signal polarity component
  counter: Consolidate Counter extension sysfs attribute creation
  counter: Introduce the COUNTER_COMP_ARRAY component type

 Documentation/ABI/testing/sysfs-bus-counter |  13 +
 drivers/counter/104-quad-8.c                |  35 +++
 drivers/counter/counter-sysfs.c             | 298 ++++++++++++++++----
 include/linux/counter.h                     | 131 +++++++++
 include/uapi/linux/counter.h                |   6 +
 5 files changed, 434 insertions(+), 49 deletions(-)


base-commit: a12224997bec72d231a8dd642876e6364decdc45
-- 
2.37.3

