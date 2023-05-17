Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5551706C5F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjEQPOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjEQPOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:14:17 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A739E75;
        Wed, 17 May 2023 08:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1684336456;
  x=1715872456;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N/eMCsIiyll+x4kcz0Wo3RiOWp9di7LTaMCImN+QjZU=;
  b=OeFLvCEvMBM93q9O8RFRrX9t04wVgUytkSnp+usFwu9+b0TAoq8w3gwh
   RrVDj0FjvqbczQMwGMdBRwczwxWviL2Qpq07t+GGLp8cAB206chWWKNC8
   wkNCd5kuXxt2SxUJK0thefKBksVsaYlmri8cxnv3dRhEmBPcRShVGRvJ5
   IJ2NjKIiE1MZ5i/a4hJtHxyNxBnvb2iM8JGzp16qfoXR5Ifsw8mGoXd7n
   a43bW7HlwdL6HXqJClXMclTxfFby+MwxfOVJZmhk0hTPPuIJvcfCaoeJF
   2Ux5PGRGQHOdqneHuEfC/ojklxRp7uXC8M/Y3bGIb5GnGwDBWbfHHokKe
   w==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Astrid Rost <astrid.rost@axis.com>
Subject: [PATCH v3 0/7] iio: light: vcnl4000: Add features for vncl4040/4200
Date:   Wed, 17 May 2023 17:13:59 +0200
Message-ID: <20230517151406.368219-1-astrid.rost@axis.com>
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


Astrid Rost (7):
  [PATCH v3 1/7] iio: light: vcnl4000: Add proximity irq for vcnl4200
  [PATCH v3 2/7] iio: light: vcnl4000: Add proximity ps_it for vcnl4200
  [PATCH v3 3/7] iio: light: vcnl4000: Add als_it for vcnl4040/4200
  [PATCH v3 4/7] iio: light: vcnl4000: add illuminance irq vcnl4040/4200
  [PATCH v3 5/7] iio: light: vcnl4000: Add period for vcnl4040/4200
  [PATCH v3 6/7] iio: light: vcnl4000: Add oversampling_ratio for 4040/4200
  [PATCH v3 7/7] iio: light: vcnl4000: Add calibration bias for 4040/4200

 drivers/iio/light/vcnl4000.c | 721 +++++++++++++++++++++++++++++++----
 1 file changed, 653 insertions(+), 68 deletions(-)

--
2.30.2

