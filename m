Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824A270D5A4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbjEWHqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjEWHqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:46:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB04CA;
        Tue, 23 May 2023 00:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=EWuwvN52YaVomkJrHyz+Th3XVhdtjsWEISWoQpd7/ZY=; b=vypnPh6qmuSsSl3ZsDNTmZXRc+
        rR8XyrEXLK1riOnO2D1hbB/Gf6gI79SR/ivFUG6d+B6MUQZUBOtazkv2rm/bdxhIi/EnsKg3I1w6F
        7K12DmdaXTx+AgkX6tjSCrUEM5hNfOa0ZraekTsgPZq+GvMzFmVN7KZkLGOl96BRGCS6XaRxJ8idw
        ZG2mAA+mg/iv7RWkyJswffbcxbvpHU+Bj4qTWqUL5b40SoaD4Ja44X/NUlN2vNrY8vCIQ4PRQ4qx8
        /S1PiOaE27PDWjQ8jCN0o/bSJOaXJUi4evNIZ3SlB4JjWNZ2RDEH3rEzZglCY/qYt4k2bBUQBEDQz
        r1ZgMOJg==;
Received: from [2001:4bb8:188:23b2:6ade:85c9:530f:6eb0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1MiC-009GTv-0t;
        Tue, 23 May 2023 07:45:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH 01/24] driver core: return bool from driver_probe_done
Date:   Tue, 23 May 2023 09:45:12 +0200
Message-Id: <20230523074535.249802-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230523074535.249802-1-hch@lst.de>
References: <20230523074535.249802-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bool is the most sensible return value for a yes/no return.  Also
add __init as this funtion is only called from the early boot code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/base/dd.c             | 6 ++----
 include/linux/device/driver.h | 2 +-
 init/do_mounts.c              | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 9c09ca5c4ab68e..878aa7646b37e4 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -751,14 +751,12 @@ static int really_probe_debug(struct device *dev, struct device_driver *drv)
  *
  * Should somehow figure out how to use a semaphore, not an atomic variable...
  */
-int driver_probe_done(void)
+bool __init driver_probe_done(void)
 {
 	int local_probe_count = atomic_read(&probe_count);
 
 	pr_debug("%s: probe_count = %d\n", __func__, local_probe_count);
-	if (local_probe_count)
-		return -EBUSY;
-	return 0;
+	return !local_probe_count;
 }
 
 /**
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index c244267a67443e..7738f458995fba 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -126,7 +126,7 @@ int __must_check driver_register(struct device_driver *drv);
 void driver_unregister(struct device_driver *drv);
 
 struct device_driver *driver_find(const char *name, const struct bus_type *bus);
-int driver_probe_done(void);
+bool __init driver_probe_done(void);
 void wait_for_device_probe(void);
 void __init wait_for_init_devices_probe(void);
 
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 811e94daf0a84a..2fe7901b5bcfaf 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -635,7 +635,7 @@ void __init prepare_namespace(void)
 	if ((ROOT_DEV == 0) && root_wait) {
 		printk(KERN_INFO "Waiting for root device %s...\n",
 			saved_root_name);
-		while (driver_probe_done() != 0 ||
+		while (!driver_probe_done() ||
 			(ROOT_DEV = name_to_dev_t(saved_root_name)) == 0)
 			msleep(5);
 		async_synchronize_full();
-- 
2.39.2

