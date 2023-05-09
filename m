Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715666FC870
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjEIOCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbjEIOCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:02:08 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51582718;
        Tue,  9 May 2023 07:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1683640918;
  x=1715176918;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qDagt0IbQhY0WYpliZ1+/6WFtA2GBq8FrdsKcMA5ZKg=;
  b=d511bJYtF6NjTb1lCq13TuNi3Yg9enh05gWUmII4YeLEl3zX6DopPV2U
   syf/lPa5pWYC76jUcbeHSJjSwfJOCIDTOS2fzssjOqClgQM3uEbJwBMKs
   FW3eXsk2FpfrpvMdE/lmDva1XAf+XTHd1KjfaB4n0nzma7tg72viWZiY2
   RxUPjyUXzv4c1BYv6Z/kip1hnKEhWuU26w4Q2ArueJGoo3QHeZjK1cFSl
   Qn+Jek7ykDUFet6QKqctHxAlDD11uwFv2/ZBgolajHO6xVKYAjvFzBrNA
   ZR14Wlaq4qXDBFf2fDN70fU9c3NNuc8DOUBxvZbGYSTEQ1l8+Q3axTFs8
   g==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Astrid Rost <astrid.rost@axis.com>
Subject: [PATCH v2 0/7] iio: light: vcnl4000: Add features for vncl4040/4200
Date:   Tue, 9 May 2023 16:01:46 +0200
Message-ID: <20230509140153.3279288-1-astrid.rost@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="No"
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
illumination sensor.

Proximity:
  - Interrupt support (new on vcnl4200).
  - Adaptable integration time (new on vcnl4200) - the sampling rate
    changes according to this value.
  - Debounce times - interrupt is asserted if the value is above or
    below a certain threshold.
  - Oversampling ratio - Amount of LED pulses per measurement.
  - Calibration bias - LED current calibration of the sensor.
Illumination:
  - Interrupt support.
  - Adaptable integration time - the sampling rate and scale changes
    according to this value.
  - Debounce times – interrupt is asserted if the value is above or
    below a certain threshold.

changes v2:
- [PATCH v2 3/7] Fixed calculation of al_scale.
  Fix the value of vcnl4040 according to the data-sheet.
  Use div_u64 for the division.

Astrid Rost (7):
  [PATCH v2 1/7] iio: light: vcnl4000: Add proximity irq for vcnl4200
  [PATCH v2 2/7] iio: light: vcnl4000: Add proximity ps_it for vcnl4200
  [PATCH v2 3/7] iio: light: vcnl4000: Add als_it for vcnl4040/4200
  [PATCH v2 4/7] iio: light: vcnl4000: add illumination irq vcnl4040/4200
  [PATCH v2 5/7] iio: light: vcnl4000: Add debounce count for vcnl4040/4200
  [PATCH v2 6/7] iio: light: vcnl4000: Add oversampling_ratio for 4040/4200
  [PATCH v2 7/7] iio: light: vcnl4000: Add calibration bias for 4040/4200

 drivers/iio/light/vcnl4000.c | 723 +++++++++++++++++++++++++++++++----
 1 file changed, 654 insertions(+), 69 deletions(-)

--
2.30.2

