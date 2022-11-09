Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB301622AF8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiKILwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiKILvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:51:33 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB19532052
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:51:26 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id j12so16858313plj.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 03:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylEXai1pRtcdgY4n/dSSiM2pUBQ7klnnGwSEjhZhHnw=;
        b=Y8CaZZpNNRXSN720dhEH8GJYbNFPJnj7qu6nXjDoVmEhFp1S6sV0e5ZQD+4UJySJNP
         6DPd+IsRr86SFqTWAIdYjHgWtQNzwRPeddZW8CfJIS+alIOMUtWqfLZYH9fKJUQ8sb1r
         Q+bjOa0eFHIPuVVvPiHll8unqEXUpibFpPrb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylEXai1pRtcdgY4n/dSSiM2pUBQ7klnnGwSEjhZhHnw=;
        b=yP/JPLUG3nxMOcGN+YjqM2DUdnq5grjqKASyLSzdh59RFwgE3obtmNG/GwfzjG4QDR
         S1xSasJnw/zcOELUr7X0/3gMpOc2QcMD9v/1/RtodQg/lzfpjXlzXkeBOpA/q8Yn5TG6
         LxAjL3wZOzZ0P/lum7CayVi9v6kob/bWGqJtp+vghHYyg2TSNQbfGIeFot2B9s2tqU1m
         MSKb0ROJZ/4JRyPChoQgZybOSr+/3FuOSntm/5QQoX1uMhsKCKBT1G3JPWAo4jI9Mqc2
         uZP5i0rXeHnHPvTO5Cea3FMf7NmwTi5/ggULgjNbJJSUX6ifvfEDO4baBuuo40Kwuf9v
         QPoA==
X-Gm-Message-State: ACrzQf1Z2gF9UCx1Blrld2FBY7YNuGefpXSaK8ezPBWiMotM5Z4o6mAd
        ONC09i8ge+HQDNPebLljSz7bjw==
X-Google-Smtp-Source: AMsMyM7uMF0Rz+8FL9QxtxgFBHi/+RsBUmvD/klEYsmwj83jE4uQ0gTGXKrZehLIcGHB3AaAGJSvPw==
X-Received: by 2002:a17:902:d708:b0:187:2721:68ca with SMTP id w8-20020a170902d70800b00187272168camr50203566ply.92.1667994685692;
        Wed, 09 Nov 2022 03:51:25 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:61f1:44d3:3f47:2cdb])
        by smtp.gmail.com with ESMTPSA id f5-20020a655505000000b00434760ee36asm7292311pgr.16.2022.11.09.03.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 03:51:25 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 12/13] zram: add incompressible writeback
Date:   Wed,  9 Nov 2022 20:50:46 +0900
Message-Id: <20221109115047.2921851-13-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221109115047.2921851-1-senozhatsky@chromium.org>
References: <20221109115047.2921851-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for incompressible pages writeback:

  echo incompressible > /sys/block/zramX/writeback

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/admin-guide/blockdev/zram.rst |  7 ++++++-
 drivers/block/zram/zram_drv.c               | 18 ++++++++++++------
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index d898b7ace33d..f14c8c2e42f3 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -348,8 +348,13 @@ this can be accomplished with::
 
         echo huge_idle > /sys/block/zramX/writeback
 
+If a user chooses to writeback only incompressible pages (pages that none of
+algorithms can compress) this can be accomplished with::
+
+	echo incompressible > /sys/block/zramX/writeback
+
 If an admin wants to write a specific page in zram device to the backing device,
-they could write a page index into the interface.
+they could write a page index into the interface::
 
 	echo "page_index=1251" > /sys/block/zramX/writeback
 
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 89d25f60b33e..2e4ef1ba1973 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -648,10 +648,10 @@ static int read_from_bdev_async(struct zram *zram, struct bio_vec *bvec,
 
 #define PAGE_WB_SIG "page_index="
 
-#define PAGE_WRITEBACK 0
-#define HUGE_WRITEBACK (1<<0)
-#define IDLE_WRITEBACK (1<<1)
-
+#define PAGE_WRITEBACK			0
+#define HUGE_WRITEBACK			(1<<0)
+#define IDLE_WRITEBACK			(1<<1)
+#define INCOMPRESSIBLE_WRITEBACK	(1<<2)
 
 static ssize_t writeback_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
@@ -672,6 +672,8 @@ static ssize_t writeback_store(struct device *dev,
 		mode = HUGE_WRITEBACK;
 	else if (sysfs_streq(buf, "huge_idle"))
 		mode = IDLE_WRITEBACK | HUGE_WRITEBACK;
+	else if (sysfs_streq(buf, "incompressible"))
+		mode = INCOMPRESSIBLE_WRITEBACK;
 	else {
 		if (strncmp(buf, PAGE_WB_SIG, sizeof(PAGE_WB_SIG) - 1))
 			return -EINVAL;
@@ -734,11 +736,15 @@ static ssize_t writeback_store(struct device *dev,
 			goto next;
 
 		if (mode & IDLE_WRITEBACK &&
-			  !zram_test_flag(zram, index, ZRAM_IDLE))
+		    !zram_test_flag(zram, index, ZRAM_IDLE))
 			goto next;
 		if (mode & HUGE_WRITEBACK &&
-			  !zram_test_flag(zram, index, ZRAM_HUGE))
+		    !zram_test_flag(zram, index, ZRAM_HUGE))
 			goto next;
+		if (mode & INCOMPRESSIBLE_WRITEBACK &&
+		    !zram_test_flag(zram, index, ZRAM_INCOMPRESSIBLE))
+			goto next;
+
 		/*
 		 * Clearing ZRAM_UNDER_WB is duty of caller.
 		 * IOW, zram_free_page never clear it.
-- 
2.38.1.431.g37b22c650d-goog

