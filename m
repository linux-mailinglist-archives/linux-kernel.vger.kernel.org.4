Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523EF66D4C4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbjAQCzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235628AbjAQCzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:55:03 -0500
Received: from out29-79.mail.aliyun.com (out29-79.mail.aliyun.com [115.124.29.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A8617CFE;
        Mon, 16 Jan 2023 18:52:24 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436261|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00640295-0.000820888-0.992776;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=yulong.zhang@metoak.net;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.QujuXNn_1673923940;
Received: from localhost.localdomain(mailfrom:yulong.zhang@metoak.net fp:SMTPD_---.QujuXNn_1673923940)
          by smtp.aliyun-inc.com;
          Tue, 17 Jan 2023 10:52:22 +0800
From:   Yulong Zhang <yulong.zhang@metoak.net>
To:     jonathan.cameron@huawei.com
Cc:     jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, yulong.zhang@metoak.net
Subject: [PATCH v3] tools/iio/iio_utils:fix memory leak
Date:   Tue, 17 Jan 2023 10:51:47 +0800
Message-Id: <20230117025147.69890-1-yulong.zhang@metoak.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230116151654.00005666@Huawei.com>
References: <20230116151654.00005666@Huawei.com>
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
 tools/iio/iio_utils.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index 8d35893b2fa8..6a00a6eecaef 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -264,6 +264,7 @@ int iioutils_get_param_float(float *output, const char *param_name,
 			if (fscanf(sysfsfp, "%f", output) != 1)
 				ret = errno ? -errno : -ENODATA;
 
+			fclose(sysfsfp);
 			break;
 		}
 error_free_filename:
@@ -345,9 +346,9 @@ int build_channel_array(const char *device_dir, int buffer_idx,
 			}
 
 			sysfsfp = fopen(filename, "r");
+			free(filename);
 			if (!sysfsfp) {
 				ret = -errno;
-				free(filename);
 				goto error_close_dir;
 			}
 
@@ -357,7 +358,6 @@ int build_channel_array(const char *device_dir, int buffer_idx,
 				if (fclose(sysfsfp))
 					perror("build_channel_array(): Failed to close file");
 
-				free(filename);
 				goto error_close_dir;
 			}
 			if (ret == 1)
@@ -365,11 +365,9 @@ int build_channel_array(const char *device_dir, int buffer_idx,
 
 			if (fclose(sysfsfp)) {
 				ret = -errno;
-				free(filename);
 				goto error_close_dir;
 			}
 
-			free(filename);
 		}
 
 	*ci_array = malloc(sizeof(**ci_array) * (*counter));
@@ -395,9 +393,9 @@ int build_channel_array(const char *device_dir, int buffer_idx,
 			}
 
 			sysfsfp = fopen(filename, "r");
+			free(filename);
 			if (!sysfsfp) {
 				ret = -errno;
-				free(filename);
 				count--;
 				goto error_cleanup_array;
 			}
@@ -405,20 +403,17 @@ int build_channel_array(const char *device_dir, int buffer_idx,
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
@@ -429,7 +424,6 @@ int build_channel_array(const char *device_dir, int buffer_idx,
 						strlen(ent->d_name) -
 						strlen("_en"));
 			if (!current->name) {
-				free(filename);
 				ret = -ENOMEM;
 				count--;
 				goto error_cleanup_array;
@@ -439,7 +433,6 @@ int build_channel_array(const char *device_dir, int buffer_idx,
 			ret = iioutils_break_up_name(current->name,
 						     &current->generic_name);
 			if (ret) {
-				free(filename);
 				free(current->name);
 				count--;
 				goto error_cleanup_array;
@@ -450,17 +443,16 @@ int build_channel_array(const char *device_dir, int buffer_idx,
 				       scan_el_dir,
 				       current->name);
 			if (ret < 0) {
-				free(filename);
 				ret = -ENOMEM;
 				goto error_cleanup_array;
 			}
 
 			sysfsfp = fopen(filename, "r");
+			free(filename);
 			if (!sysfsfp) {
 				ret = -errno;
-				fprintf(stderr, "failed to open %s\n",
-					filename);
-				free(filename);
+				fprintf(stderr, "failed to open %s/%s_index\n",
+					scan_el_dir, current->name);
 				goto error_cleanup_array;
 			}
 
@@ -470,17 +462,14 @@ int build_channel_array(const char *device_dir, int buffer_idx,
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

