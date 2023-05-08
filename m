Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4666FA0EE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjEHHYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjEHHYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:24:30 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0FB44BB;
        Mon,  8 May 2023 00:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1683530668;
  x=1715066668;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HV4VesQTIEfe4oBorMAKl5xvLbnSA5K7+Sqvgwv4Wac=;
  b=gUTIUdtgDlZw8kaw6go8BmXYL93k8/wQOo0PU3cBA3iKzNZh7jFs5LPE
   +Q7mEUgJ9DtstHDsGtgK+jLsiVmHqirKL+S91+71WaAwto6p068HJNDxD
   V91+oRSyfSAVXHwxCElE0pnoSJNLgLILKNuMvPejh919baWgYYbyPkTrw
   YbyTJEerwp0Bvrbs5As8ScPBK+x8r45qD/FDpu/61fMF90LdRuEgfCFGx
   Ix4rBOJ/CGjPKJEtRc3QQdsLWjMOjQU6/BSwwEP5KiwIrxsSE5llXLUBC
   2zMqsr1YT0eXdN3qDpEevBgpgeIdo2d2SXWxXoNHTM1Dbid4SljdrPcsT
   Q==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Astrid Rost <astridr@axis.com>
Subject: [PATCH v1 0/7] iio: light: vcnl4000: Add features for vncl4040/4200
Date:   Mon, 8 May 2023 09:24:07 +0200
Message-ID: <20230508072414.2124841-1-astrid.rost@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Astrid Rost <astridr@axis.com>

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

Astrid Rost (7):
  [PATCH v1 1/7] iio: light: vcnl4000: Add proximity irq for vcnl4200
  [PATCH v1 2/7] iio: light: vcnl4000: Add proximity ps_it for vcnl4200
  [PATCH v1 3/7] iio: light: vcnl4000: Add als_it for vcnl4040/4200
  [PATCH v1 4/7] iio: light: vcnl4000: add illumination irq vcnl4040/4200
  [PATCH v1 5/7] iio: light: vcnl4000: Add debounce count for vcnl4040/4200
  [PATCH v1 6/7] iio: light: vcnl4000: Add oversampling_ratio for 4040/4200
  [PATCH v1 7/7] iio: light: vcnl4000: Add calibration bias for 4040/4200

 drivers/iio/light/vcnl4000.c | 716 +++++++++++++++++++++++++++++++----
 1 file changed, 648 insertions(+), 68 deletions(-)

-- 
2.30.2

