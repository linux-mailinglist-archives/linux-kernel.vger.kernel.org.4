Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2353667092
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbjALLKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbjALLIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:08:24 -0500
Received: from out29-79.mail.aliyun.com (out29-79.mail.aliyun.com [115.124.29.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6B0C63;
        Thu, 12 Jan 2023 03:01:29 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08690067|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00273212-0.000615305-0.996653;FP=14365338695671385583|2|1|1|0|-1|-1|-1;HT=ay29a033018047206;MF=yulong.zhang@metoak.net;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.Qr-Q0x9_1673521285;
Received: from localhost.localdomain(mailfrom:yulong.zhang@metoak.net fp:SMTPD_---.Qr-Q0x9_1673521285)
          by smtp.aliyun-inc.com;
          Thu, 12 Jan 2023 19:01:26 +0800
From:   Yulong Zhang <yulong.zhang@metoak.net>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org,
        Yulong Zhang <yulong.zhang@metoak.net>
Subject: [PATCH] tools/iio/iio_utils:fix memory leak
Date:   Thu, 12 Jan 2023 19:01:22 +0800
Message-Id: <20230112110122.22973-1-yulong.zhang@metoak.net>
X-Mailer: git-send-email 2.25.1
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

1.fopen sysfsfp without fclose
2.asprintf filename without free

Signed-off-by: Yulong Zhang <yulong.zhang@metoak.net>
---
 tools/iio/iio_utils.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index 8d35893b2..38e9352e5 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -264,6 +264,8 @@ int iioutils_get_param_float(float *output, const char *param_name,
 			if (fscanf(sysfsfp, "%f", output) != 1)
 				ret = errno ? -errno : -ENODATA;
 
+			fclose(sysfsfp);
+
 			break;
 		}
 error_free_filename:
@@ -444,6 +446,7 @@ int build_channel_array(const char *device_dir, int buffer_idx,
 				count--;
 				goto error_cleanup_array;
 			}
+			free(filename);
 
 			ret = asprintf(&filename,
 				       "%s/%s_index",
-- 
2.25.1

