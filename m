Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8506E5E54B3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 22:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiIUUpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 16:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIUUpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 16:45:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA499DFAB;
        Wed, 21 Sep 2022 13:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663793120; x=1695329120;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l/G74zZaxudvWZKszn/5aJm/frFg9KrxRccC2qSWFEw=;
  b=bjIaYva4QR5cDeFbKI3HcB7aH9MBkDU2XgCmo9jhGsvXDR+cLm++QRI8
   iup/gcPX9HYhtKJDBNy/ahd8jUakgUqP5PUP9o3Rc20gaAmZbJD7+TA7f
   E8KMLSyw0bMpypP2yOKIyyiYvD3wqKwMVNGfWMNPyyjQYW9qawlFnWotX
   ABIzUnYcM9I7CnxkqalDn+tSjcQIQwEljBEqd5oNUgKN79b3luKQqm410
   CTgnEzje2rhDL/i9ubnuXPPXMWQsduMkMpF7K8bxUflCblkFnQIg7/ysG
   w+v52puIWtqJBxz5DR0EVIxBPlRQHLZhkJJJ4htlS4nBj1fwcWLe+2SOg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="287196383"
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="287196383"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 13:45:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="708610769"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Sep 2022 13:45:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 516AAF7; Wed, 21 Sep 2022 23:45:35 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wei Yongjun <weiyongjun@huaweicloud.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] spi: Introduce spi_get_device_match_data() helper
Date:   Wed, 21 Sep 2022 23:45:20 +0300
Message-Id: <20220921204520.23984-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The proposed spi_get_device_match_data() helper is for retrieving
a driver data associated with the ID in an ID table. First, it tries
to get driver data of the device enumerated by firmware interface
(usually Device Tree or ACPI). If none is found it falls back to
the SPI ID table matching.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c       | 12 ++++++++++++
 include/linux/spi/spi.h |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ad254b94308e..a0947d63afbc 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -360,6 +360,18 @@ const struct spi_device_id *spi_get_device_id(const struct spi_device *sdev)
 }
 EXPORT_SYMBOL_GPL(spi_get_device_id);
 
+const void *spi_get_device_match_data(const struct spi_device *sdev)
+{
+	const void *match;
+
+	match = device_get_match_data(&sdev->dev);
+	if (match)
+		return match;
+
+	return (const void *)spi_get_device_id(sdev)->driver_data;
+}
+EXPORT_SYMBOL_GPL(spi_get_device_match_data);
+
 static int spi_match_device(struct device *dev, struct device_driver *drv)
 {
 	const struct spi_device	*spi = to_spi_device(dev);
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 6ea889df0813..f2565c24ef27 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1510,6 +1510,9 @@ extern void spi_unregister_device(struct spi_device *spi);
 extern const struct spi_device_id *
 spi_get_device_id(const struct spi_device *sdev);
 
+extern const void *
+spi_get_device_match_data(const struct spi_device *sdev);
+
 static inline bool
 spi_transfer_is_last(struct spi_controller *ctlr, struct spi_transfer *xfer)
 {
-- 
2.35.1

