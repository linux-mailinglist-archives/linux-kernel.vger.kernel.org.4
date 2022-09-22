Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771A65E5D3A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 10:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiIVIRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 04:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiIVIRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:17:30 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C2CAE9F6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 01:17:28 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b35so12523446edf.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 01:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=KE+/FM+bp7N2bfStw2xsvWCt4BBN5yEPTRTsFRdtKeg=;
        b=n53jlU3q2smKbDG61noembjZEeMMj8P1cuCuN3dZB8EmJh0u9gGsIhFdozata0/pkn
         o/ciDs6GCO9DJ7Zet23Lbt0Ha5GQ9+5KjkPUqY7hs7P1bD8AOpFqKjLjVdkVu+Pt+ibk
         sEIMw879Q8LvYprYma/rDXJfKcbaPvksOBij3x1ylQv9Fd0fZ5v8WdwYZCQNRxyq+HzT
         tLYnb0p9QzyNgJu1R+2YWbQoT6MvmRWJdzemhmLGygNC8eqWkTRNwNmnNsc8kWkIaUHk
         jLYqDl9BQpU09ilwfxsGigaAvTnMU25NdG/LukH8XyYmWRfioKBpN6bAkDC0/MQFI0a5
         e05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=KE+/FM+bp7N2bfStw2xsvWCt4BBN5yEPTRTsFRdtKeg=;
        b=5ZvVfFj43RfwpBt+/zbNGKGFwj9GojFwOa7XBDjRu1thqqC9rEHc5xasJfiHI3EOf5
         0+fTPRO42e/iZeLw9cUk0A3LbyA3IWXn7Y7m6cjrSc3GvxMb68CKW5WBusEa0cIE5Saj
         pdNR0lH0dIcB7Es+BvsnrBnyX4uTQhsy/5nJ1G/daasfGdAS+JHnvwy/e1S6XUQrcaY0
         r6Ytou9hjDsjnJw+7uyFM+OHiXr3Uv4JLTHTr1HITWByGyNtLgYE/OV1EWsfPYfL+RBE
         x4RHSG3jeXKocZxyO+JtaxI0pFYUiTkQVkjecrF2A4fXDyTLvctkvpFS3gtJJAMGuURI
         qS0g==
X-Gm-Message-State: ACrzQf26w3eFogBBu4gNCdMGWv2sIblgfaqM6ACDe+jLsxmYqbWvln3V
        mTDYjw425O77t3n22l/iIBW7Fw==
X-Google-Smtp-Source: AMsMyM6QMc/Zd33+GWfdUAdAYyrkARY8ZRDYkZ/gWXvXOI+eB6baCB+s5Cm9WKXKyG+3FPV0qOQApg==
X-Received: by 2002:a05:6402:440d:b0:450:de54:3fcf with SMTP id y13-20020a056402440d00b00450de543fcfmr2009214eda.312.1663834646828;
        Thu, 22 Sep 2022 01:17:26 -0700 (PDT)
Received: from cmo-ThinkPad-T495.tess.elex.be ([194.150.35.21])
        by smtp.gmail.com with ESMTPSA id b10-20020aa7df8a000000b0044e01e2533asm3301303edy.43.2022.09.22.01.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 01:17:26 -0700 (PDT)
From:   cmo@melexis.com
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v6 0/3] iio: temperature: mlx90632: Add powermanagement
Date:   Thu, 22 Sep 2022 10:13:21 +0200
Message-Id: <cover.1663834141.git.cmo@melexis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Crt Mori <cmo@melexis.com>

As discussed previously on the group under the
"Controlling device power management from terminal" thread the mlx90632
sensor provides measurement capabilities under sleep_step mode. This
series runtime suspends the unused chip to sleep step mode to save power
but in case of continuous sequential reading it switches to continuous
mode for faster readouts. This value is hardcoded to
MLX90632_MEAS_MAX_TIME (with some buffer) and not user configurable.

The sensor runtime suspension is set to MLX90632_SLEEP_DELAY_MS which is
hardcoded to 3 times as much as MEAS_MAX_TIME.

Changes in v6:

 - Revert changes to the suspend to prevent power mode regression

Changes in v5 (per review comments from Jonathan Cameron):

 - Migrate to devm also for driver removal, along with putting it to low
   power mode

Changes in v4 (per review comments from Jonathan Cameron):

 - Migrate back to devm_pm_runtime_enable and remove the pm_disable function
 - Remove pm stuff from remove and also sleep, since when iio device is
   not registered also sleep makes no sense.
 - Replace use EOPNOTSUPP as per checkpatch suggestion although some drivers
   still use ENOTSUPP.
 - Change the style of read frequency

Changes in v3 (per review comments from Jonathan Cameron):

 - Change the "available" attribute presentation to more recent way
   suggested
 - Replace devm_pm_runtime_enable with enable and devm_add_action_or_reset
 - When suspending device also put it to lower power mode in case there is
   dummy regulator
 - Use more switch cases instead of if/else

Changes in v2:

 - apply review comments from Andy Shevchenko

Crt Mori (3):
  iio: temperature: mlx90632 Add runtime powermanagement modes
  iio: temperature: mlx90632 Read sampling frequency
  iio: temperature: mlx90632 Change return value of sensor measurement
    channel

 drivers/iio/temperature/mlx90632.c | 440 ++++++++++++++++++++++++-----
 1 file changed, 369 insertions(+), 71 deletions(-)

-- 
2.34.1

