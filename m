Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803F26EADA8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 17:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjDUPAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 11:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbjDUPAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:00:47 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978126584
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:00:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id A7FC960129;
        Fri, 21 Apr 2023 17:00:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1682089240; bh=AdV3O7KiwN7j21d+V+A5xL08XlBgHT/p7NwH96/b7Vk=;
        h=From:To:Cc:Subject:Date:From;
        b=Q3OUKDIPJlgg1Q2vtcTw5G2bbO8EFdsb/EcnyltyAHYeMqwRnBmya4hwVg/fY2nWo
         vqEPOn5HMN8YRMnU3k0xpfs6L5BtSUmIsWNMAqILduuftpZHrk/yw6+2Q21SlyRsjq
         /169kIlRmMO3VCMP8irIXIHZmpKGXUT2b4MBV3YhLnwuYs/sdvlvi/hblbFdOQjzgg
         sNRHlwVfrFKCic7SgodrNWJf9WSrj9SLria+q1OYm6lEmU1OlCMb3GZPmYQmCJCT5J
         S/3IgTyPq3KXHqL23Ae/9CPq6Tg2yNfUqIU4qNACAedVHb4jL0nIhTOye2lAs4ZWEq
         TqNTDwSwVb4Dw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NMxl2fA2PsiM; Fri, 21 Apr 2023 17:00:37 +0200 (CEST)
Received: by domac.alu.hr (Postfix, from userid 1014)
        id 36A9460126; Fri, 21 Apr 2023 17:00:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1682089237; bh=AdV3O7KiwN7j21d+V+A5xL08XlBgHT/p7NwH96/b7Vk=;
        h=From:To:Cc:Subject:Date:From;
        b=WlES1e5YEg4G7SQXZfk1U1+qQXWKb6StKBpwoNO2lnwsZaG+XaPYbvnEKJc2gjwfz
         D6GIEJBx41zfmQOet/lRRlxpCBY9QO5HHST60gj88o/v51rfqLPx/hIfC+lP+Ng2CA
         SyvFP96Yedg0uMf0AW/DRl5U/B/5xaTr89uPIjJ+Qkgl3ANjGp+semz27+ttQ72bbc
         yndVlKDbYMQ6GKy9ck+pUPjOt6XYRKdRGjvSrm2NDgYl1aDtpeUA3fGrkVFxOUDagm
         8iZRVdlK1iBVJnQCP8v2aSLzNbkH4QIhaSqMk1c9wYHc4vQjnfnYhNB2TQSDTm2W95
         CCitji9yKujAg==
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Scott Branden <sbranden@broadcom.com>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH v4 1/1] test_firmware: fix some memory leaks and racing conditions
Date:   Fri, 21 Apr 2023 16:57:01 +0200
Message-Id: <20230421145700.20931-1-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some functions were called both from locked and unlocked context, so
the lock was dropped prematurely, introducing a race condition when
deadlock was avoided.

Having two locks wouldn't assure a race-proof mutual exclusion.

__test_dev_config_update_bool(), __test_dev_config_update_u8() and
__test_dev_config_update_size_t() unlocked versions of the functions
were introduced to be called from the locked contexts as a workaround
without releasing the main driver's lock and causing a race condition.

This should guarantee mutual exclusion and prevent any race conditions.

Locked versions simply allow for mutual exclusion and call the unlocked
counterparts, to avoid duplication of code.

trigger_batched_requests_store() and trigger_batched_requests_async_store()
now return -EBUSY if called with test_fw_config->reqs already allocated,
so the memory leak is prevented.

The same functions now keep track of the allocated buf for firmware in
req->fw_buf as release_firmware() will not deallocate this storage for us.

Additionally, in __test_release_all_firmware(), req->fw_buf is released
before calling release_firmware(reqs->fw) foreach test_fw_config->regs[i].

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org> 
Cc: Luis Chamberlain <mcgrof@kernel.org> 
Cc: Russ Weight <russell.h.weight@intel.com> 
Cc: Tianfei zhang <tianfei.zhang@intel.com> 
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr> 
Cc: Zhengchao Shao <shaozhengchao@huawei.com> 
Cc: Colin Ian King <colin.i.king@gmail.com> 
Cc: linux-kernel@vger.kernel.org 
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Luis R. Rodriguez <mcgrof@kernel.org>
Suggested-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 lib/test_firmware.c | 81 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 63 insertions(+), 18 deletions(-)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 05ed84c2fc4c..1d7d480b8eeb 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -45,6 +45,7 @@ struct test_batched_req {
 	bool sent;
 	const struct firmware *fw;
 	const char *name;
+	const char *fw_buf;
 	struct completion completion;
 	struct task_struct *task;
 	struct device *dev;
@@ -175,8 +176,14 @@ static void __test_release_all_firmware(void)
 
 	for (i = 0; i < test_fw_config->num_requests; i++) {
 		req = &test_fw_config->reqs[i];
-		if (req->fw)
+		if (req->fw) {
+			if (req->fw_buf) {
+				kfree_const(req->fw_buf);
+				req->fw_buf = NULL;
+			}
 			release_firmware(req->fw);
+			req->fw = NULL;
+		}
 	}
 
 	vfree(test_fw_config->reqs);
@@ -353,16 +360,26 @@ static ssize_t config_test_show_str(char *dst,
 	return len;
 }
 
-static int test_dev_config_update_bool(const char *buf, size_t size,
+static inline int __test_dev_config_update_bool(const char *buf, size_t size,
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
+	ret = __test_dev_config_update_bool(buf, size, cfg);
 	mutex_unlock(&test_fw_mutex);
 
 	return ret;
@@ -373,7 +390,8 @@ static ssize_t test_dev_config_show_bool(char *buf, bool val)
 	return snprintf(buf, PAGE_SIZE, "%d\n", val);
 }
 
-static int test_dev_config_update_size_t(const char *buf,
+static int __test_dev_config_update_size_t(
+					 const char *buf,
 					 size_t size,
 					 size_t *cfg)
 {
@@ -384,9 +402,7 @@ static int test_dev_config_update_size_t(const char *buf,
 	if (ret)
 		return ret;
 
-	mutex_lock(&test_fw_mutex);
 	*(size_t *)cfg = new;
-	mutex_unlock(&test_fw_mutex);
 
 	/* Always return full write size even if we didn't consume all */
 	return size;
@@ -402,7 +418,7 @@ static ssize_t test_dev_config_show_int(char *buf, int val)
 	return snprintf(buf, PAGE_SIZE, "%d\n", val);
 }
 
-static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
+static int __test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
 {
 	u8 val;
 	int ret;
@@ -411,14 +427,23 @@ static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
 	if (ret)
 		return ret;
 
-	mutex_lock(&test_fw_mutex);
 	*(u8 *)cfg = val;
-	mutex_unlock(&test_fw_mutex);
 
 	/* Always return full write size even if we didn't consume all */
 	return size;
 }
 
+static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
+{
+	int ret;
+
+	mutex_lock(&test_fw_mutex);
+	ret = __test_dev_config_update_u8(buf, size, cfg);
+	mutex_unlock(&test_fw_mutex);
+
+	return ret;
+}
+
 static ssize_t test_dev_config_show_u8(char *buf, u8 val)
 {
 	return snprintf(buf, PAGE_SIZE, "%u\n", val);
@@ -471,10 +496,10 @@ static ssize_t config_num_requests_store(struct device *dev,
 		mutex_unlock(&test_fw_mutex);
 		goto out;
 	}
-	mutex_unlock(&test_fw_mutex);
 
-	rc = test_dev_config_update_u8(buf, count,
-				       &test_fw_config->num_requests);
+	rc = __test_dev_config_update_u8(buf, count,
+					 &test_fw_config->num_requests);
+	mutex_unlock(&test_fw_mutex);
 
 out:
 	return rc;
@@ -518,10 +543,10 @@ static ssize_t config_buf_size_store(struct device *dev,
 		mutex_unlock(&test_fw_mutex);
 		goto out;
 	}
-	mutex_unlock(&test_fw_mutex);
 
-	rc = test_dev_config_update_size_t(buf, count,
-					   &test_fw_config->buf_size);
+	rc = __test_dev_config_update_size_t(buf, count,
+					     &test_fw_config->buf_size);
+	mutex_unlock(&test_fw_mutex);
 
 out:
 	return rc;
@@ -548,10 +573,10 @@ static ssize_t config_file_offset_store(struct device *dev,
 		mutex_unlock(&test_fw_mutex);
 		goto out;
 	}
-	mutex_unlock(&test_fw_mutex);
 
-	rc = test_dev_config_update_size_t(buf, count,
-					   &test_fw_config->file_offset);
+	rc = __test_dev_config_update_size_t(buf, count,
+					     &test_fw_config->file_offset);
+	mutex_unlock(&test_fw_mutex);
 
 out:
 	return rc;
@@ -652,6 +677,8 @@ static ssize_t trigger_request_store(struct device *dev,
 
 	mutex_lock(&test_fw_mutex);
 	release_firmware(test_firmware);
+	if (test_fw_config->reqs)
+		__test_release_all_firmware();
 	test_firmware = NULL;
 	rc = request_firmware(&test_firmware, name, dev);
 	if (rc) {
@@ -752,6 +779,8 @@ static ssize_t trigger_async_request_store(struct device *dev,
 	mutex_lock(&test_fw_mutex);
 	release_firmware(test_firmware);
 	test_firmware = NULL;
+	if (test_fw_config->reqs)
+		__test_release_all_firmware();
 	rc = request_firmware_nowait(THIS_MODULE, 1, name, dev, GFP_KERNEL,
 				     NULL, trigger_async_request_cb);
 	if (rc) {
@@ -794,6 +823,8 @@ static ssize_t trigger_custom_fallback_store(struct device *dev,
 
 	mutex_lock(&test_fw_mutex);
 	release_firmware(test_firmware);
+	if (test_fw_config->reqs)
+		__test_release_all_firmware();
 	test_firmware = NULL;
 	rc = request_firmware_nowait(THIS_MODULE, FW_ACTION_NOUEVENT, name,
 				     dev, GFP_KERNEL, NULL,
@@ -856,6 +887,8 @@ static int test_fw_run_batch_request(void *data)
 						 test_fw_config->buf_size);
 		if (!req->fw)
 			kfree(test_buf);
+		else
+			req->fw_buf = test_buf;
 	} else {
 		req->rc = test_fw_config->req_firmware(&req->fw,
 						       req->name,
@@ -895,6 +928,11 @@ static ssize_t trigger_batched_requests_store(struct device *dev,
 
 	mutex_lock(&test_fw_mutex);
 
+	if (test_fw_config->reqs) {
+		rc = -EBUSY;
+		goto out_bail;
+	}
+
 	test_fw_config->reqs =
 		vzalloc(array3_size(sizeof(struct test_batched_req),
 				    test_fw_config->num_requests, 2));
@@ -911,6 +949,7 @@ static ssize_t trigger_batched_requests_store(struct device *dev,
 		req->fw = NULL;
 		req->idx = i;
 		req->name = test_fw_config->name;
+		req->fw_buf = NULL;
 		req->dev = dev;
 		init_completion(&req->completion);
 		req->task = kthread_run(test_fw_run_batch_request, req,
@@ -993,6 +1032,11 @@ ssize_t trigger_batched_requests_async_store(struct device *dev,
 
 	mutex_lock(&test_fw_mutex);
 
+	if (test_fw_config->reqs) {
+		rc = -EBUSY;
+		goto out_bail;
+	}
+
 	test_fw_config->reqs =
 		vzalloc(array3_size(sizeof(struct test_batched_req),
 				    test_fw_config->num_requests, 2));
@@ -1010,6 +1054,7 @@ ssize_t trigger_batched_requests_async_store(struct device *dev,
 	for (i = 0; i < test_fw_config->num_requests; i++) {
 		req = &test_fw_config->reqs[i];
 		req->name = test_fw_config->name;
+		req->fw_buf = NULL;
 		req->fw = NULL;
 		req->idx = i;
 		init_completion(&req->completion);
-- 
2.30.2

