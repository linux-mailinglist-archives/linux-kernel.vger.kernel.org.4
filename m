Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2256B284E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjCIPGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjCIPGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:06:16 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E46BFA5C6;
        Thu,  9 Mar 2023 07:03:54 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 712041516;
        Thu,  9 Mar 2023 07:04:37 -0800 (PST)
Received: from e127643.arm.com (unknown [10.57.48.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E91193F5A1;
        Thu,  9 Mar 2023 07:03:50 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-kernel@vger.kernel.org, linux@roeck-us.net,
        michal.simek@amd.com
Cc:     James Clark <james.clark@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v2 3/4] iio: adc: Use devm_krealloc_array
Date:   Thu,  9 Mar 2023 15:03:32 +0000
Message-Id: <20230309150334.216760-4-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230309150334.216760-1-james.clark@arm.com>
References: <20230309150334.216760-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that it exists, use it instead of doing the multiplication and
checking for overflow manually.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/iio/adc/xilinx-ams.c       |  9 +++------
 drivers/iio/adc/xilinx-xadc-core.c | 17 +++++++----------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index 34cf336b3490..f0b71a1220e0 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -1263,7 +1263,7 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
 	struct device *dev = indio_dev->dev.parent;
 	struct fwnode_handle *child = NULL;
 	struct fwnode_handle *fwnode = dev_fwnode(dev);
-	size_t ams_size, dev_size;
+	size_t ams_size;
 	int ret, ch_cnt = 0, i, rising_off, falling_off;
 	unsigned int num_channels = 0;
 
@@ -1320,11 +1320,8 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
 		}
 	}
 
-	dev_size = array_size(sizeof(*dev_channels), num_channels);
-	if (dev_size == SIZE_MAX)
-		return -ENOMEM;
-
-	dev_channels = devm_krealloc(dev, ams_channels, dev_size, GFP_KERNEL);
+	dev_channels = devm_krealloc_array(dev, ams_channels, num_channels,
+					   sizeof(*dev_channels), GFP_KERNEL);
 	if (!dev_channels)
 		return -ENOMEM;
 
diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 292f2892d223..dba73300f894 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -613,20 +613,17 @@ static int xadc_update_scan_mode(struct iio_dev *indio_dev,
 	const unsigned long *mask)
 {
 	struct xadc *xadc = iio_priv(indio_dev);
-	size_t new_size, n;
+	size_t n;
 	void *data;
 
 	n = bitmap_weight(mask, indio_dev->masklength);
 
-	if (check_mul_overflow(n, sizeof(*xadc->data), &new_size))
-		return -ENOMEM;
-
-	data = devm_krealloc(indio_dev->dev.parent, xadc->data,
-			     new_size, GFP_KERNEL);
+	data = devm_krealloc_array(indio_dev->dev.parent, xadc->data,
+				   n, sizeof(*xadc->data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	memset(data, 0, new_size);
+	memset(data, 0, n * sizeof(*xadc->data));
 	xadc->data = data;
 
 	return 0;
@@ -1281,9 +1278,9 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
 	}
 
 	indio_dev->num_channels = num_channels;
-	indio_dev->channels = devm_krealloc(dev, channels,
-					    sizeof(*channels) * num_channels,
-					    GFP_KERNEL);
+	indio_dev->channels = devm_krealloc_array(dev, channels,
+						  num_channels, sizeof(*channels),
+						  GFP_KERNEL);
 	/* If we can't resize the channels array, just use the original */
 	if (!indio_dev->channels)
 		indio_dev->channels = channels;
-- 
2.34.1

