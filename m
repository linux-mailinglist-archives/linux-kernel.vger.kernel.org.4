Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FFD6CCD51
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 00:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjC1Whv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 18:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjC1Whs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 18:37:48 -0400
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2A6135;
        Tue, 28 Mar 2023 15:37:47 -0700 (PDT)
Received: by mail-pj1-f49.google.com with SMTP id d13so12299294pjh.0;
        Tue, 28 Mar 2023 15:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680043067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PvQPbEWvAU9FUvULu0M0thBy/ht8pKcMq8eorlt8kGw=;
        b=CWjlxmCVi7N1gSUO6mRAUx7HOEmhQ7nbK7jgiL4/7w0mRq9Cnl3SSqxwUkbRnxPWg1
         1GkkC2LIiyUOkcrxK8538X/0HBQzTJ7ZI7y+luxeyFbtNv1MX1bGdxOeDlyUC4KpVcHQ
         2eATJQuFSKaOMDXh5tUYZFNxRlbMSSAspgsTtzdw2dohUZAiNFoC9XZdJy5viLdE34vB
         wINfCAWlZLN9gwJ76RhRSlIaNU14j1TQ0lqKJsff+ultrDFGYcSEOtQBeivDUn+jgBZU
         CnMB5X4N3hbZ6VlvgZNMdjZ0fv8vR9Yi1Gvd9Hvizo55dC3loy6BRE4TmnHt8de0tj1O
         PPJA==
X-Gm-Message-State: AAQBX9fgc1ed8SuQUJSdhUZsObQYbEsiL3JHERYH7TgK1QA2tXCRAaFg
        Y16qZtDwa8Yd7IJ1nw49x4E=
X-Google-Smtp-Source: AKy350Zc7YIlxFdIVmmrnbrf3EJx3fY8Fdr/tbOwiFuEpS+PPdzPcALiOwLbdVyjIxyvIASwY02NTg==
X-Received: by 2002:a17:90b:4d06:b0:240:95a7:be7a with SMTP id mw6-20020a17090b4d0600b0024095a7be7amr6071988pjb.41.1680043066835;
        Tue, 28 Mar 2023 15:37:46 -0700 (PDT)
Received: from snowbird.robot.car ([199.73.127.3])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902c3c300b00198ac2769aesm21563072plj.135.2023.03.28.15.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 15:37:46 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH] mmc: allow mmc to block wait_for_device_probe()
Date:   Tue, 28 Mar 2023 15:37:40 -0700
Message-Id: <20230328223740.69446-1-dennis@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been hitting a failed data device lookup when using dm-verity and a
root device on an emmc partition. This is because there is a race where
dm-verity is looking for a data device, but the partitions on the emmc
device haven't been probed yet.

Initially I looked at solving this by changing devt_from_devname() to
look for partitions, but it seems there is legacy reasons and issues due
to dm.

MMC uses 2 levels of probing. The first to handle initializing the
host and the second to iterate attached devices. The second is done by
a workqueue item. However, this paradigm makes wait_for_device_probe()
useless as a barrier for when we can assume attached devices have been
probed.

This patch fixes this by exposing 2 methods inc/dec_probe_count() to
allow device drivers that do asynchronous probing to delay waiters on
wait_for_device_probe() so that when they are released, they can assume
attached devices have been probed.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 drivers/base/dd.c        | 17 +++++++++++++++--
 drivers/mmc/core/core.c  | 25 +++++++++++++++++++++++--
 include/linux/device.h   |  7 +++++++
 include/linux/mmc/host.h |  1 +
 4 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 95ae347df137..c0117476e1d6 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -494,6 +494,19 @@ EXPORT_SYMBOL_GPL(device_bind_driver);
 static atomic_t probe_count = ATOMIC_INIT(0);
 static DECLARE_WAIT_QUEUE_HEAD(probe_waitqueue);
 
+void inc_probe_count(void)
+{
+	atomic_inc(&probe_count);
+}
+EXPORT_SYMBOL_GPL(inc_probe_count);
+
+void dec_probe_count(void)
+{
+	if (atomic_dec_return(&probe_count) == 0)
+		wake_up_all(&probe_waitqueue);
+}
+EXPORT_SYMBOL_GPL(dec_probe_count);
+
 static ssize_t state_synced_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
@@ -793,8 +806,8 @@ static int driver_probe_device(struct device_driver *drv, struct device *dev)
 		    !defer_all_probes)
 			driver_deferred_probe_trigger();
 	}
-	atomic_dec(&probe_count);
-	wake_up_all(&probe_waitqueue);
+	if (atomic_dec_return(&probe_count) == 0)
+		wake_up_all(&probe_waitqueue);
 	return ret;
 }
 
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 368f10405e13..92690984dac2 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2192,11 +2192,11 @@ void mmc_rescan(struct work_struct *work)
 	int i;
 
 	if (host->rescan_disable)
-		return;
+		goto out_probe;
 
 	/* If there is a non-removable card registered, only scan once */
 	if (!mmc_card_is_removable(host) && host->rescan_entered)
-		return;
+		goto out_probe;
 	host->rescan_entered = 1;
 
 	if (host->trigger_card_event && host->ops->card_event) {
@@ -2247,6 +2247,13 @@ void mmc_rescan(struct work_struct *work)
  out:
 	if (host->caps & MMC_CAP_NEEDS_POLL)
 		mmc_schedule_delayed_work(&host->detect, HZ);
+
+out_probe:
+	if (host->start_probe) {
+		/* matches inc_probe_count() in mmc_start_host() */
+		dec_probe_count();
+		host->start_probe = 0;
+	}
 }
 
 void mmc_start_host(struct mmc_host *host)
@@ -2261,6 +2268,15 @@ void mmc_start_host(struct mmc_host *host)
 	}
 
 	mmc_gpiod_request_cd_irq(host);
+
+	/*
+	 * MMC uses 2 levels of probing. The first to handle initializing the
+	 * host and the second to iterate attached devices. However, this
+	 * paradigm breaks wait_for_device_probe(). Fix this here by
+	 * incrementing the probe_count and decrementing after the scan.
+	 */
+	host->start_probe = 1;
+	inc_probe_count();
 	_mmc_detect_change(host, 0, false);
 }
 
@@ -2273,6 +2289,11 @@ void __mmc_stop_host(struct mmc_host *host)
 
 	host->rescan_disable = 1;
 	cancel_delayed_work_sync(&host->detect);
+	/* start_probe is protected by the cancel_delayed_work_sync() */
+	if (host->start_probe) {
+		dec_probe_count();
+		host->start_probe = 0;
+	}
 }
 
 void mmc_stop_host(struct mmc_host *host)
diff --git a/include/linux/device.h b/include/linux/device.h
index e270cb740b9e..d09bdc33d1cf 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -891,6 +891,13 @@ int __must_check device_reprobe(struct device *dev);
 
 bool device_is_bound(struct device *dev);
 
+/*
+ * Functions that inc/dec probe_count to allow device drivers that finish
+ * probing asynchronously to delay wait_for_device_probe() appropriately.
+ */
+void inc_probe_count(void);
+void dec_probe_count(void);
+
 /*
  * Easy functions for dynamically creating devices on the fly
  */
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 0c0c9a0fdf57..ea7b9158f052 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -428,6 +428,7 @@ struct mmc_host {
 	unsigned int		retune_paused:1; /* re-tuning is temporarily disabled */
 	unsigned int		retune_crc_disable:1; /* don't trigger retune upon crc */
 	unsigned int		can_dma_map_merge:1; /* merging can be used */
+	unsigned int		start_probe:1; /* if this is our first scan */
 
 	int			rescan_disable;	/* disable card detection */
 	int			rescan_entered;	/* used with nonremovable devices */
-- 
2.40.0

