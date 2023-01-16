Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B2666B626
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 04:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjAPDbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 22:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjAPDbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 22:31:06 -0500
Received: from out29-175.mail.aliyun.com (out29-175.mail.aliyun.com [115.124.29.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D43910D0;
        Sun, 15 Jan 2023 19:31:00 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436261|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00737706-0.000674387-0.991949;FP=11045481846625830584|1|1|1|0|-1|-1|-1;HT=ay29a033018047211;MF=yulong.zhang@metoak.net;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.QtfOCll_1673839856;
Received: from localhost.localdomain(mailfrom:yulong.zhang@metoak.net fp:SMTPD_---.QtfOCll_1673839856)
          by smtp.aliyun-inc.com;
          Mon, 16 Jan 2023 11:30:57 +0800
From:   Yulong Zhang <yulong.zhang@metoak.net>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, yulong.zhang@metoak.net
Subject: [PATCH v2] tools/iio/iio_utils:fix memory leak
Date:   Mon, 16 Jan 2023 11:30:07 +0800
Message-Id: <20230116033007.58038-1-yulong.zhang@metoak.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230114164114.3212921d@jic23-huawei>
References: <20230114164114.3212921d@jic23-huawei>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. fopen sysfs without fclose.
2. asprintf filename without free.
3. if asprintf return error,do not need to free the buffer.

Signed-off-by: Yulong Zhang <yulong.zhang@metoak.net>
---
Yes, you are right. Thanks you for the advice.
I found another problem, when asprintf return error, still free the
buffer.This is not correct,I've removed it.

> sysfsfp = fopen(filename, "r");
> if (!sysfsfp) {
>       ret = -errno;
>       fprintf(stderr, "failed to open %s\n",
>               filename);
>       free(filename);
>       goto error_cleanup_array;
> }
> free(filename);
Because in if statement still use filename,so I can't free filename
before it.And I am not sure it can be removed,so I free filename after if
statement.

 tools/iio/iio_utils.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index 8d35893b2fa8..abec4331701c 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -264,6 +264,7 @@ int iioutils_get_param_float(float *output, const char *param_name,
 			if (fscanf(sysfsfp, "%f", output) != 1)
 				ret = errno ? -errno : -ENODATA;
 
+			fclose(sysfsfp);
 			break;
 		}
 error_free_filename:
@@ -350,6 +351,7 @@ int build_channel_array(const char *device_dir, int buffer_idx,
 				free(filename);
 				goto error_close_dir;
 			}
+			free(filename);
 
 			errno = 0;
 			if (fscanf(sysfsfp, "%i", &ret) != 1) {
@@ -357,7 +359,6 @@ int build_channel_array(const char *device_dir, int buffer_idx,
 				if (fclose(sysfsfp))
 					perror("build_channel_array(): Failed to close file");
 
-				free(filename);
 				goto error_close_dir;
 			}
 			if (ret == 1)
@@ -365,11 +366,9 @@ int build_channel_array(const char *device_dir, int buffer_idx,
 
 			if (fclose(sysfsfp)) {
 				ret = -errno;
-				free(filename);
 				goto error_close_dir;
 			}
 
-			free(filename);
 		}
 
 	*ci_array = malloc(sizeof(**ci_array) * (*counter));
@@ -395,9 +394,9 @@ int build_channel_array(const char *device_dir, int buffer_idx,
 			}
 
 			sysfsfp = fopen(filename, "r");
+			free(filename);
 			if (!sysfsfp) {
 				ret = -errno;
-				free(filename);
 				count--;
 				goto error_cleanup_array;
 			}
@@ -405,20 +404,17 @@ int build_channel_array(const char *device_dir, int buffer_idx,
 			errno = 0;
 			if (fscanf(sysfsfp, "%i", &current_enabled) != 1) {
 				ret = errno ? -errno : -ENODATA;
-				free(filename);
 				count--;
 				goto error_cleanup_array;
 			}
 
 			if (fclose(sysfsfp)) {
 				ret = -errno;
-				free(filename);
 				count--;
 				goto error_cleanup_array;
 			}
 
 			if (!current_enabled) {
-				free(filename);
 				count--;
 				continue;
 			}
@@ -429,7 +425,6 @@ int build_channel_array(const char *device_dir, int buffer_idx,
 						strlen(ent->d_name) -
 						strlen("_en"));
 			if (!current->name) {
-				free(filename);
 				ret = -ENOMEM;
 				count--;
 				goto error_cleanup_array;
@@ -439,7 +434,6 @@ int build_channel_array(const char *device_dir, int buffer_idx,
 			ret = iioutils_break_up_name(current->name,
 						     &current->generic_name);
 			if (ret) {
-				free(filename);
 				free(current->name);
 				count--;
 				goto error_cleanup_array;
@@ -450,7 +444,6 @@ int build_channel_array(const char *device_dir, int buffer_idx,
 				       scan_el_dir,
 				       current->name);
 			if (ret < 0) {
-				free(filename);
 				ret = -ENOMEM;
 				goto error_cleanup_array;
 			}
@@ -463,6 +456,7 @@ int build_channel_array(const char *device_dir, int buffer_idx,
 				free(filename);
 				goto error_cleanup_array;
 			}
+			free(filename);
 
 			errno = 0;
 			if (fscanf(sysfsfp, "%u", &current->index) != 1) {
@@ -470,17 +464,14 @@ int build_channel_array(const char *device_dir, int buffer_idx,
 				if (fclose(sysfsfp))
 					perror("build_channel_array(): Failed to close file");
 
-				free(filename);
 				goto error_cleanup_array;
 			}
 
 			if (fclose(sysfsfp)) {
 				ret = -errno;
-				free(filename);
 				goto error_cleanup_array;
 			}
 
-			free(filename);
 			/* Find the scale */
 			ret = iioutils_get_param_float(&current->scale,
 						       "scale",
-- 
2.25.1

