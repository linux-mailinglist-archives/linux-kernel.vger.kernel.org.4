Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5459750C6F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbjGLP2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbjGLP2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:28:08 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944A71BD5;
        Wed, 12 Jul 2023 08:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1689175688;
  x=1720711688;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=rwAJJHUO0JnZisxLO3+eFKnrpeHeVsnZgdBx2AOpPlA=;
  b=NQ6s4KOjUS5ga4u+fH6m5CmRjglX2vF2+/ngr+g0pucYk6hI4J5dcIVM
   8og+YZ9SU3q4TI2Vh1+Tk3xQx73bTn3BkPGkb2vzDEc64vOlxrHJaF1YY
   Hs8HWtIrziXLxoaLt7iH2oVH0E5XYCpZ1u0qrAXfq3HKKUoU2oqFciEnU
   BC2XurzRQyiv3vUKAW2ABbDKl55yoABeY6PQNVEgwz5/fZQ2gCsHEgMpw
   tCInreteLoh70i+G9NegVWtlNuI4bhWWgAQWKNDSlGA9UwXlCntbfXeS9
   MZjTKx+4Rw1uKjpYcdpT2bx/HDVsAMQs31rPYZ0lonAm4uvo8RoIy/xAl
   g==;
References: <cover.1689174736.git.waqar.hameed@axis.com>
User-agent: a.out
From:   Waqar Hameed <waqar.hameed@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     <kernel@axis.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/3] iio: Add event enums for running period and count
In-Reply-To: <cover.1689174736.git.waqar.hameed@axis.com>
Date:   Wed, 12 Jul 2023 17:12:16 +0200
Message-ID: <206111caec7e4a8ae0e7628fb49b9ac295097177.1689174736.git.waqar.hameed@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are devices (such as Murata IRS-D200 PIR proximity sensor) that
check the data signal with a running period. I.e. for a specified time,
they count the number of conditions that have occurred, and then signal
if that is more than a specified amount.

`IIO_EV_INFO_PERIOD` resets when the condition no longer is true and is
therefore not suitable for these devices. Add a new `iio_event_info`
`IIO_EV_INFO_RUNNING_PERIOD` that can be used as a running period. Also
add a new `IIO_EV_INFO_RUNNING_COUNT` that can be used to specify the
number of conditions that must occur during this running period.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 16 ++++++++++++++++
 drivers/iio/industrialio-event.c        |  2 ++
 include/linux/iio/types.h               |  2 ++
 3 files changed, 20 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 7140e8e7313f..a2854dc9a839 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2163,3 +2163,19 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		An example format is 16-bytes, 2-digits-per-byte, HEX-string
 		representing the sensor unique ID number.
+
+What:		/sys/.../events/in_proximity_thresh_either_runningperiod
+KernelVersion:	6.6
+Contact:	linux-iio@vger.kernel.org
+Description:
+		A running period of time (in seconds) for which
+		in_proximity_thresh_either_runningcount amount of conditions
+		must occur before an event is generated. If direction is not
+		specified then this period applies to both directions.
+
+What:		/sys/.../events/in_proximity_thresh_either_runningcount
+KernelVersion:	6.6
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Number of conditions that must occur, during a running
+		period, before an event is generated.
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index f77ce49d4c36..19f7a91157ee 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -252,6 +252,8 @@ static const char * const iio_ev_info_text[] = {
 	[IIO_EV_INFO_TIMEOUT] = "timeout",
 	[IIO_EV_INFO_RESET_TIMEOUT] = "reset_timeout",
 	[IIO_EV_INFO_TAP2_MIN_DELAY] = "tap2_min_delay",
+	[IIO_EV_INFO_RUNNING_PERIOD] = "runningperiod",
+	[IIO_EV_INFO_RUNNING_COUNT] = "runningcount",
 };
 
 static enum iio_event_direction iio_ev_attr_dir(struct iio_dev_attr *attr)
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 82faa98c719a..117bde7d6ad7 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -19,6 +19,8 @@ enum iio_event_info {
 	IIO_EV_INFO_TIMEOUT,
 	IIO_EV_INFO_RESET_TIMEOUT,
 	IIO_EV_INFO_TAP2_MIN_DELAY,
+	IIO_EV_INFO_RUNNING_PERIOD,
+	IIO_EV_INFO_RUNNING_COUNT,
 };
 
 #define IIO_VAL_INT 1
-- 
2.30.2

