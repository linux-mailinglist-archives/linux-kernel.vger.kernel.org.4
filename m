Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AC95F0131
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 01:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiI2XET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 19:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiI2XER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 19:04:17 -0400
X-Greylist: delayed 602 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Sep 2022 16:04:09 PDT
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69656125799;
        Thu, 29 Sep 2022 16:04:09 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id B6FBEE0EB4;
        Fri, 30 Sep 2022 01:46:55 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=UkQr9fjSZTvQkPs/TdOJJ7ucByrB+5O3OiT3zCPhxos=; b=daxnT/Wt2lRx
        LdfDcr8bocUrY/As/wrQG39sxic/sfkWdshgyzrgtjf9QJMcAo5I1pVo3qL7gvqQ
        RRckRfjNCmcMye6Mw4idHhU/+pdesabAan7qsgh3EazGyxT0eg9Vc+vw50M6J80Y
        EfH4/AnYtxYfqOIIK/Nu+Z3QQWvmKn8=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id A8DEBE0E6B;
        Fri, 30 Sep 2022 01:46:55 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Sep 2022 01:46:56 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Guenter Roeck <linux@roeck-us.net>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/3] nvme-hwmon: Kmalloc the NVME SMART log buffer
Date:   Fri, 30 Sep 2022 01:46:47 +0300
Message-ID: <20220929224648.8997-3-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220929224648.8997-1-Sergey.Semin@baikalelectronics.ru>
References: <20220929224648.8997-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.168.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent commit 52fde2c07da6 ("nvme: set dma alignment to dword") has caused
a regression on our platform. It turned out that the nvme_get_log() method
invocation caused the nvme_hwmon_data structure instance corruption. In
particular the nvme_hwmon_data.ctrl pointer was overwritten either with
zeros or with garbage. After some researches we discovered that the
problem happened even before the actual NVME DMA execution, but during the
buffer mapping. Since our platform was DMA-noncoherent the mapping implied
the cache-lines invalidations or write-backs depending on the
DMA-direction parameter. In case of the NVME SMART log getting the DMA was
performed from-device-to-memory, thus the cache-invalidation was activated
during the buffer mapping. Since the log-buffer wasn't cache-line aligned
the cache-invalidation caused the neighbour data discard. The neighbouring
data turned to be the data surrounding the buffer in the framework of the
nvme_hwmon_data structure.

In order to fix that we need to make sure that the whole log-buffer is
defined within the cache-line-aligned memory region so the
cache-invalidation procedure wouldn't involve the adjacent data. One of
the option to guarantee that is to kmalloc the DMA-buffer [1]. Seeing the
rest of the NVME core driver prefer that method it has been chosen to fix
this problem too.

Note after a deeper researches we found out that the denoted commit wasn't
a root cause of the problem. It just revealed the invalidity by activating
the DMA-based NVME SMART log getting performed in the framework of the
NVME hwmon driver. The problem was here since the initial commit of the
driver.

[1] Documentation/core-api/dma-api-howto.rst

Fixes: 400b6a7b13a3 ("nvme: Add hardware monitoring support")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Folks, I've thoroughly studied the whole NVME subsystem looking for
similar problems. Turned out there is one more place which may cause the
same issue. It's connected with the opal_dev.{cmd,req} buffers passed to
the nvme_sec_submit() method. The rest of the buffers involved in the NVME
DMA are either allocated by kmalloc (must be cache-line-aligned by design)
or bounced-buffered if allocated on the stack (see the blk_rq_map_kern()
method implementation). I am still not fully sure regarding the buffers
coming from user-space though, but AFAICS based on our
DMA-buffers-alignment sanity check procedure they haven't been detected as
cache-unaligned so far.

Changelog v2:
- Convert to allocating the nvme_smart_log structure instance instead of
  cache-aligning it. (@Christoph)
---
 drivers/nvme/host/hwmon.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
index 1afb24a64145..654309767e76 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -12,7 +12,7 @@
 
 struct nvme_hwmon_data {
 	struct nvme_ctrl *ctrl;
-	struct nvme_smart_log log;
+	struct nvme_smart_log *log;
 	struct mutex read_lock;
 };
 
@@ -60,14 +60,14 @@ static int nvme_set_temp_thresh(struct nvme_ctrl *ctrl, int sensor, bool under,
 static int nvme_hwmon_get_smart_log(struct nvme_hwmon_data *data)
 {
 	return nvme_get_log(data->ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
-			   NVME_CSI_NVM, &data->log, sizeof(data->log), 0);
+			   NVME_CSI_NVM, data->log, sizeof(*data->log), 0);
 }
 
 static int nvme_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 			   u32 attr, int channel, long *val)
 {
 	struct nvme_hwmon_data *data = dev_get_drvdata(dev);
-	struct nvme_smart_log *log = &data->log;
+	struct nvme_smart_log *log = data->log;
 	int temp;
 	int err;
 
@@ -163,7 +163,7 @@ static umode_t nvme_hwmon_is_visible(const void *_data,
 	case hwmon_temp_max:
 	case hwmon_temp_min:
 		if ((!channel && data->ctrl->wctemp) ||
-		    (channel && data->log.temp_sensor[channel - 1])) {
+		    (channel && data->log->temp_sensor[channel - 1])) {
 			if (data->ctrl->quirks &
 			    NVME_QUIRK_NO_TEMP_THRESH_CHANGE)
 				return 0444;
@@ -176,7 +176,7 @@ static umode_t nvme_hwmon_is_visible(const void *_data,
 		break;
 	case hwmon_temp_input:
 	case hwmon_temp_label:
-		if (!channel || data->log.temp_sensor[channel - 1])
+		if (!channel || data->log->temp_sensor[channel - 1])
 			return 0444;
 		break;
 	default:
@@ -232,14 +232,19 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
 	if (!data)
 		return -ENOMEM;
 
+	data->log = kzalloc(sizeof(*data->log), GFP_KERNEL);
+	if (!data->log) {
+		err = -ENOMEM;
+		goto err_free_data;
+	}
+
 	data->ctrl = ctrl;
 	mutex_init(&data->read_lock);
 
 	err = nvme_hwmon_get_smart_log(data);
 	if (err) {
 		dev_warn(dev, "Failed to read smart log (error %d)\n", err);
-		kfree(data);
-		return err;
+		goto err_free_log;
 	}
 
 	hwmon = hwmon_device_register_with_info(dev, "nvme",
@@ -247,11 +252,19 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
 						NULL);
 	if (IS_ERR(hwmon)) {
 		dev_warn(dev, "Failed to instantiate hwmon device\n");
-		kfree(data);
-		return PTR_ERR(hwmon);
+		err = PTR_ERR(hwmon);
+		goto err_free_log;
 	}
 	ctrl->hwmon_device = hwmon;
 	return 0;
+
+err_free_log:
+	kfree(data->log);
+
+err_free_data:
+	kfree(data);
+
+	return err;
 }
 
 void nvme_hwmon_exit(struct nvme_ctrl *ctrl)
@@ -262,6 +275,7 @@ void nvme_hwmon_exit(struct nvme_ctrl *ctrl)
 
 		hwmon_device_unregister(ctrl->hwmon_device);
 		ctrl->hwmon_device = NULL;
+		kfree(data->log);
 		kfree(data);
 	}
 }
-- 
2.37.3


