Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4EE72E497
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242597AbjFMNug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240572AbjFMNuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:50:32 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E551B2;
        Tue, 13 Jun 2023 06:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1686664231;
  x=1718200231;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LUX9cP79go9f+wGu1o/Mzl0dQ6jN4HTs40FnoqtdA9w=;
  b=hAU/e87ooJkYheYo/CIZqFfneFuzSgJgBjzF7jo1DMsD+ActRm2MW5XW
   uY9gDvD5e+z/AjbYwPofxziAFPtvyUhgM8quq7mO9YwsHyXuCeFVCM+we
   z1vF/kTKHlWXZ2BCUceruJy5P5FVtIRcMAsOmIxGqd3vadCcfdUBWgODz
   jgC3jUWFzFJFxNzv1srZA86a0AYYrpb/s3Erl1UTlAOazFX31XyaWYx7F
   /eBUIgtBtES0DLRbgiT3iJ5tKG2rPUMj7uxXw9q6EK8nJxtLCzmgMfdwJ
   K5WZOSb7Z5cjS5UKoNrPijj/WhHRlx5gfD+GXdLkV9fOTrdKr3GQ3RM4m
   A==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Astrid Rost <astrid.rost@axis.com>
Subject: [PATCH v6 0/8]  iio: light: vcnl4000: Add features for vncl4040/4200
Date:   Tue, 13 Jun 2023 15:50:16 +0200
Message-ID: <20230613135025.2596641-1-astrid.rost@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a more complete support for vncl4040 and vcnl4200, which allows to
change the distance of proximity detection and interrupt support for the
illuminance sensor.

Proximity functionality:
  - Interrupt support (new on vcnl4200).

Proximity reduce the amount of interrupts:
  - Adaptable integration time (new on vcnl4200) - the sampling rate
    changes according to this value.
  - Period - interrupt is asserted if the value is above or
    below a certain threshold.

Proximity change the activity distance:
  - Oversampling ratio - Amount of LED pulses per measured raw value.
  - Calibration bias - LED current calibration of the sensor.

Illuminance functionality:
  - Interrupt support.

Illuminance reduce the amount of interrupts:
  - Adaptable integration time - the sampling rate and scale changes
    according to this value.
  - Period – interrupt is asserted if the value is above or
    below a certain threshold.

changes v2:
- [PATCH v2 3/7] Fixed calculation of al_scale.
  Fix the value of vcnl4040 according to the data-sheet.
  Use div_u64 for the division.
scription for the branch

changes v3:
- [PATCH v3 1-3/7] Add differences between the chips as variables in
  chip-spec.
- [PATCH v3 4/7] Changed commit message.
- [PATCH v3 5/7] Use period instead of debounce time. This causes some
  calculations as the period is a time and the chip allows to set a certain
  amount of measurements above/below the threshold, before throwing an
  interrupt.
- [PATCH v3 6/7] Changed commit message.

changes v4:
- [PATCH v3 1-3/7] Fix setting correct als_it for vcnl4040.
- [PATCH v3 5/7] Use MICRO macro.
  Fix values greater than 1 s for the proximity period.

changes v5:
[PATCH v5 2/7]:
- Calculate ps_it from ps_it_times by usinh NSEC_PER_USEC.
[PATCH v5 3/7]:
- Calculate als_it from ps_it_times by using NSEC_PER_USEC.
- Store scale step factor in chip_spec.
- Fixes sampling_rate to ns + 20 %.
[PATCH v5 3/7 - 7/7]
- Changed formatting.
- Changed some variable names.

- [PATCH v3 4/7] Changed commit message.
- [PATCH v3 5/7] Use period instead of debounce time. This causes some
  calculations as the period is a time and the chip allows to set a certain
  amount of measurements above/below the threshold, before throwing an
  interrupt.
- [PATCH v3 6/7] Changed commit message.

changes v4:
- [PATCH v3 1-3/7] Fix setting correct als_it for vcnl4040.
- [PATCH v3 5/7] Use MICRO macro.
  Fix values greater than 1 s for the proximity period.

changes v5:
[PATCH v5 2/7]:
- Calculate ps_it from ps_it_times by usinh NSEC_PER_USEC.
[PATCH v5 3/7]:
- Calculate als_it from ps_it_times by using NSEC_PER_USEC.
- Store scale step factor in chip_spec.
- Fixes sampling_rate to ns + 20 %.
[PATCH v5 3/7 - 7/7]
- Changed formatting.
- Changed some variable names.

changes v6:
Added [PATCH v6 3/8]:
- Add switch case for IIO_PROXIMITY check.
 [PATCH v5 1/7 - 7/7]
- Changed formatting.
[PATCH v5 3/7, 5/7, 6/7, 7/7]
- Changed loop.
- Changed some variable names.

Astrid Rost (8):
  [PATCH v6 1/8] iio: light: vcnl4000: Add proximity irq for vcnl4200
  [PATCH v6 2/8] iio: light: vcnl4000: Add proximity ps_it for vcnl4200
  [PATCH v6 3/8] iio: light: vcnl4000: Check type with switch case
  [PATCH v6 4/8] iio: light: vcnl4000: Add als_it for vcnl4040/4200
  [PATCH v6 5/8] iio: light: vcnl4000: add illuminance irq vcnl4040/4200
  [PATCH v6 6/8] iio: light: vcnl4000: Add period for vcnl4040/4200
  [PATCH v6 7/8] iio: light: vcnl4000: Add oversampling_ratio for 4040/4200
  [PATCH v6 8/8] iio: light: vcnl4000: Add calibration bias for 4040/4200

 drivers/iio/light/vcnl4000.c | 710 +++++++++++++++++++++++++++++++----
 1 file changed, 643 insertions(+), 67 deletions(-)

-- 
2.30.2

