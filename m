Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7282074D35A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbjGJK2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjGJK15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:27:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2C6B7;
        Mon, 10 Jul 2023 03:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688984876; x=1720520876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i+Jmb8Ni5ZNMBB74vGh9B4SucNYBPaQ0rpIJBqbWbw0=;
  b=JWjEs0zgGq+3S7+hiCA6UPf9KVaqngVvA2MaaGFJfJ0f6MmcmN/HK5V5
   GvR0VMKzDD6xPgv2U0waC9EhWdag1asBBgs594yCfTokVjHNppF/CIQX8
   5/Fe4fc6gROST7/WlReyvNhr75IWuUAEAz0ZMpWhka3wKwhLrIwVgAjum
   Pabi/hjguh1u1FAvXv8p0K0/HWW9Uizs5yM0Y5bo9kwWQ9yxq56MsYOn9
   M748MlA1yjDBFNaWb4I96iJQu6fMgIgxWJXTARP18EWiOJhjXP/JbXhzj
   VI1AqLzATDRVYSo7wgdHsmAUxbVVQEt6IkPdwlYq0d+IP2arsdkK9O5Fi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="364345437"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="364345437"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 03:27:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="865297524"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="865297524"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2023 03:27:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 18E8C3E3; Mon, 10 Jul 2023 13:27:53 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Amit Kumar Mahapatra via Alsa-devel 
        <alsa-devel@alsa-project.org>, Kris Bahnsen <kris@embeddedTS.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org
Cc:     Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH v1 3/8] spi: Use sysfs_emit() to instead of s*printf()
Date:   Mon, 10 Jul 2023 13:27:46 +0300
Message-Id: <20230710102751.83314-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230710102751.83314-1-andriy.shevchenko@linux.intel.com>
References: <20230710102751.83314-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the advice of the Documentation/filesystems/sysfs.rst and show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the
value to be returned to user space.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 6d74218cf38e..0f05773c277c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -64,7 +64,7 @@ modalias_show(struct device *dev, struct device_attribute *a, char *buf)
 	if (len != -ENODEV)
 		return len;
 
-	return sprintf(buf, "%s%s\n", SPI_MODULE_PREFIX, spi->modalias);
+	return sysfs_emit(buf, "%s%s\n", SPI_MODULE_PREFIX, spi->modalias);
 }
 static DEVICE_ATTR_RO(modalias);
 
@@ -89,7 +89,7 @@ static ssize_t driver_override_show(struct device *dev,
 	ssize_t len;
 
 	device_lock(dev);
-	len = snprintf(buf, PAGE_SIZE, "%s\n", spi->driver_override ? : "");
+	len = sysfs_emit(buf, "%s\n", spi->driver_override ? : "");
 	device_unlock(dev);
 	return len;
 }
@@ -2814,8 +2814,7 @@ static ssize_t slave_show(struct device *dev, struct device_attribute *attr,
 	struct device *child;
 
 	child = device_find_any_child(&ctlr->dev);
-	return sprintf(buf, "%s\n",
-		       child ? to_spi_device(child)->modalias : NULL);
+	return sysfs_emit(buf, "%s\n", child ? to_spi_device(child)->modalias : NULL);
 }
 
 static ssize_t slave_store(struct device *dev, struct device_attribute *attr,
-- 
2.40.0.1.gaa8946217a0b

