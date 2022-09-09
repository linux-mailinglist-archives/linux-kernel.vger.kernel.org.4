Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF24B5B3F5C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 21:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiIITTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 15:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIITTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:19:37 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB03F12AAF;
        Fri,  9 Sep 2022 12:19:34 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id E8885DBA;
        Fri,  9 Sep 2022 22:23:10 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com E8885DBA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1662751391;
        bh=g/qnbR3kmCe/hsDgvp6zCp5qkLBtvy6bgBjvx6x6e8w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=YES6vKyJfvMMdrO20kNxAanHBoFyOZ10pFXxE7G1x4aD++ilUms+nwqjVLYPDYEDD
         7KE5Frp3PJ6w++pm8zZ0XWDuVTnhPWxcgWSNMuspnYaVeh+L5e5CPxHUDOR5k5Fo88
         C90Jhz+tvIVTQlW1sFqCSYEiGhodiDd9T0xPo0M8=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 9 Sep 2022 22:19:20 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
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
Subject: [PATCH 1/2] nvme-hwmon: Cache-line-align the NVME SMART log-buffer
Date:   Fri, 9 Sep 2022 22:19:15 +0300
Message-ID: <20220909191916.16013-2-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220909191916.16013-1-Sergey.Semin@baikalelectronics.ru>
References: <20220909191916.16013-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
DMA-direction parameter. In case of the NVME SMART log getting the DMA
was performed from-device-to-memory, thus the cache-invalidation was
activated during the buffer mapping. Since the log-buffer wasn't
cache-line aligned the cache-invalidation caused the neighbour data
discard. The neighbouring data turned to be the data surrounding the
buffer in the framework of the nvme_hwmon_data structure.

In order to fix that we need to make sure that the whole log-buffer is
defined within the cache-line-aligned memory region so the
cache-invalidation procedure wouldn't involve the adjacent data. By doing
so we not only get rid from the denoted problem but also fulfill the
requirement explicitly described in [1].

After a deeper researches we found out that the denoted commit wasn't a
root cause of the problem. It just revealed the invalidity by activating
the DMA-based NVME SMART log getting performed in the framework of the
NVME hwmon driver. The problem was here since the initial commit of the
driver.

[1] Documentation/core-api/dma-api.rst

Fixes: 400b6a7b13a3 ("nvme: Add hardware monitoring support")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Folks, I've thoroughly studied the whole NVME subsystem looking for
similar problems. Turned out there is one more place which may cause the
same issue. It's connected with the opal_dev.{cmd,req} buffers passed to
the nvme_sec_submit() method. The rest of the buffers involved in the NVME
DMA are either allocated by kmalloc (must be cache-line-aligned by design)
or bounced-buffered if allocated on the stack (see the blk_rq_map_kern()
method implementation).
---
 drivers/nvme/host/hwmon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
index 0a586d712920..94192ab7a02d 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -10,9 +10,10 @@
 
 #include "nvme.h"
 
+/* DMA-noncoherent platforms require the cache-aligned buffers */
 struct nvme_hwmon_data {
+	struct nvme_smart_log log ____cacheline_aligned;
 	struct nvme_ctrl *ctrl;
-	struct nvme_smart_log log;
 	struct mutex read_lock;
 };
 
-- 
2.37.2

