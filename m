Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBBE6D8D89
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 04:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbjDFCgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 22:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbjDFCfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 22:35:04 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E07883D0
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 19:35:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 90AFB604ED;
        Thu,  6 Apr 2023 04:34:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680748500; bh=moyjB0vCzLhLbgsmt8YV49FqUNROO5qsChsvEK2tqEw=;
        h=From:To:Cc:Subject:Date:From;
        b=m8PruuXOs0gkDxPuepXn7L3Sv+xfM980nDlvUrdRZOxqCSEWBIbCWaiWeVjGMpx1y
         xzMrv2Pv2RAKG6g8HMbq+/J6rmCFSYr2ZfO6uHlq7UDvCb39JzgWBlQtX6lqZtqrVG
         nfpn+t0SLSwM4yR9ONdJml0SmTWInXBTQxNSEi9XRf3+lpDRPXBuNXM6bfvEG1SQsF
         HXBLadOWaNAVbSg/j+fO1EOs1BOusk6OOvu9ikptL1aeoeY0UI2210z8Ipo2I2ElYl
         mhS+dxljAvfbGy3glKQ1Yh+FOeOutmXvIdhI6itZu9dGyi2hsS1m5Am9+78pCApyf5
         l8+cw13kMmtJQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Jx_nZKwZw-ez; Thu,  6 Apr 2023 04:34:57 +0200 (CEST)
Received: by domac.alu.hr (Postfix, from userid 1014)
        id 31915604EF; Thu,  6 Apr 2023 04:34:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680748497; bh=moyjB0vCzLhLbgsmt8YV49FqUNROO5qsChsvEK2tqEw=;
        h=From:To:Cc:Subject:Date:From;
        b=Wc6uKvlQ6W+whn6zqWuHrfayS68UrU/JRL5RRNrPm/RX11WI7HyCnrZkmoi15HTWo
         n3ETlKN9S1Xhv9EfZn+eDzy3VOdV+SJvm3uvqW7wDtay6Wc2oYarPiscNf36DFqlNC
         k2V7/4BFgx+lzns4c8xg8h4tKELZelvy1D6ad0f0L18n/TsXD7ppDF6Htq6UJ5ZICM
         QAFbS/FBnIo0UpTN4uR+L0VtghXWuvkahSKpM3HLUa1y9tHsiAuAfAW62n6E0vHGYD
         u+he7wi/sOGCYB9nEIzSLM2KOArtmApr2Wkhyc1WtRGVbGSfqGWaH3TskSmY03rU0S
         2GZ6kTnneTBrA==
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russ Weight <russell.h.weight@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Takashi Iwai <tiwai@suse.de>, Dan Carpenter <error27@gmail.com>
Subject: [PATCH v3 1/2] test_firmware: Fix some racing conditions in test_fw_config locking.
Date:   Thu,  6 Apr 2023 03:53:17 +0200
Message-Id: <20230406015315.31505-1-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some functions were called both from locked and unlocked context, so the lock
was dropped prematurely, introducing a race condition when deadlock was avoided.

Having two locks wouldn't assure a race-proof mutual exclusion.

test_dev_config_update_bool_unlocked(), test_dev_config_update_u8_unlocked()
and test_dev_config_update_size_t_unlocked() versions of the functions were
introduced to be called from the locked contexts as a workaround without
releasing the main driver's lock and causing a race condition, much like putc()
and putc_unlocked() in stdio glibc library.

This should guarantee mutual exclusion and prevent any race conditions.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org> 
Cc: Luis Chamberlain <mcgrof@kernel.org> 
Cc: Russ Weight <russell.h.weight@intel.com> 
Cc: Tianfei zhang <tianfei.zhang@intel.com> 
Cc: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr> 
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr> 
Cc: Zhengchao Shao <shaozhengchao@huawei.com> 
Cc: Colin Ian King <colin.i.king@gmail.com> 
Cc: linux-kernel@vger.kernel.org 
Cc: Takashi Iwai <tiwai@suse.de>
Suggested-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 lib/test_firmware.c | 52 +++++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 14 deletions(-)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 05ed84c2fc4c..272af8dc54b0 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -353,16 +353,26 @@ static ssize_t config_test_show_str(char *dst,
 	return len;
 }
 
-static int test_dev_config_update_bool(const char *buf, size_t size,
+static inline int test_dev_config_update_bool_unlocked(const char *buf, size_t size,
 				       bool *cfg)
 {
 	int ret;
 
-	mutex_lock(&test_fw_mutex);
 	if (kstrtobool(buf, cfg) < 0)
 		ret = -EINVAL;
 	else
 		ret = size;
+
+	return ret;
+}
+
+static int test_dev_config_update_bool(const char *buf, size_t size,
+				       bool *cfg)
+{
+	int ret;
+
+	mutex_lock(&test_fw_mutex);
+	ret = test_dev_config_update_bool_unlocked(buf, size, cfg);
 	mutex_unlock(&test_fw_mutex);
 
 	return ret;
@@ -373,7 +383,8 @@ static ssize_t test_dev_config_show_bool(char *buf, bool val)
 	return snprintf(buf, PAGE_SIZE, "%d\n", val);
 }
 
-static int test_dev_config_update_size_t(const char *buf,
+static int test_dev_config_update_size_t_unlocked(
+					 const char *buf,
 					 size_t size,
 					 size_t *cfg)
 {
@@ -384,9 +395,7 @@ static int test_dev_config_update_size_t(const char *buf,
 	if (ret)
 		return ret;
 
-	mutex_lock(&test_fw_mutex);
 	*(size_t *)cfg = new;
-	mutex_unlock(&test_fw_mutex);
 
 	/* Always return full write size even if we didn't consume all */
 	return size;
@@ -402,6 +411,21 @@ static ssize_t test_dev_config_show_int(char *buf, int val)
 	return snprintf(buf, PAGE_SIZE, "%d\n", val);
 }
 
+static int test_dev_config_update_u8_unlocked(const char *buf, size_t size, u8 *cfg)
+{
+	u8 val;
+	int ret;
+
+	ret = kstrtou8(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	*(u8 *)cfg = val;
+
+	/* Always return full write size even if we didn't consume all */
+	return size;
+}
+
 static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
 {
 	u8 val;
@@ -471,10 +495,10 @@ static ssize_t config_num_requests_store(struct device *dev,
 		mutex_unlock(&test_fw_mutex);
 		goto out;
 	}
-	mutex_unlock(&test_fw_mutex);
 
-	rc = test_dev_config_update_u8(buf, count,
-				       &test_fw_config->num_requests);
+	rc = test_dev_config_update_u8_unlocked(buf, count,
+						&test_fw_config->num_requests);
+	mutex_unlock(&test_fw_mutex);
 
 out:
 	return rc;
@@ -518,10 +542,10 @@ static ssize_t config_buf_size_store(struct device *dev,
 		mutex_unlock(&test_fw_mutex);
 		goto out;
 	}
-	mutex_unlock(&test_fw_mutex);
 
-	rc = test_dev_config_update_size_t(buf, count,
-					   &test_fw_config->buf_size);
+	rc = test_dev_config_update_size_t_unlocked(buf, count,
+						    &test_fw_config->buf_size);
+	mutex_unlock(&test_fw_mutex);
 
 out:
 	return rc;
@@ -548,10 +572,10 @@ static ssize_t config_file_offset_store(struct device *dev,
 		mutex_unlock(&test_fw_mutex);
 		goto out;
 	}
-	mutex_unlock(&test_fw_mutex);
 
-	rc = test_dev_config_update_size_t(buf, count,
-					   &test_fw_config->file_offset);
+	rc = test_dev_config_update_size_t_unlocked(buf, count,
+						    &test_fw_config->file_offset);
+	mutex_unlock(&test_fw_mutex);
 
 out:
 	return rc;
-- 
2.30.2

