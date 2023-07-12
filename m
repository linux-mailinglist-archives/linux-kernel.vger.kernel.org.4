Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A77750B41
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbjGLOon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbjGLOol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:44:41 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0361993;
        Wed, 12 Jul 2023 07:44:40 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-785d738d3feso19647739f.0;
        Wed, 12 Jul 2023 07:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689173080; x=1691765080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TXl73vS3xoLImN4/kTBTqeB+mjux+k3hDkyvAJUy8Zo=;
        b=Nadm7A9EVMUzXlNA8QPkV85OmN7THGpQHeyqWtsCcNlJ2hS7nMddDUr3H7etC+4QF+
         45ZTkutubBkNf7L02N44pgwD1FeLbHXgUUQLhgONTqNoxC9hOZSMBlGt+b8JaWmMtG7g
         1mR+HgTl62/3SdVvy5VyaF0+4cxwOnU8sxDlRQoenhpSxwjTYJ1L/ZNsSnccZRMZ5EkE
         IvnRluFD8ICwkahraDNpPyG7E0xNPoioLWngQWzwT/WQ62zkGNufDcT4EGfgr3wQ6ghK
         BsjC18aOdPHE5CvO6BaXTzj+6VSYZBXfYHD1Tiu1pKmNNaWJJli0LbnneHbRNsKLQt68
         Qnsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689173080; x=1691765080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TXl73vS3xoLImN4/kTBTqeB+mjux+k3hDkyvAJUy8Zo=;
        b=dt1CzrFJaVTzvp+0w4+98xepbXtubdX446KA6XtrdlJJqduj3/nw8SPFzSSOLIZDEK
         lFJRQ3GJPlG8YMt/pdYio2WqQ8jY5Phniym8FbssmPTqIsTbslBE1MN1t/r8XJHVCREt
         6CXIXqgxp20fUQ0TL5OJjCBrvT6xS5mRh7puXWkrF8qWgxQyPocK3SwFZ1u8B5bqisis
         1+/04yyiyuclmgPNHQ6mIHs5hXDfPNUJKUb2e0ImCWvWcLVg3XI0oA5Iz9ObiNnUDSTw
         q4NyZbub5iD9JVtvQcG/npdOV3AM/HXCPh4Dw/A19c5fM1q9f7B5RCTLnnwtvK43Bpv4
         vrDg==
X-Gm-Message-State: ABy/qLZlNw6vfFL2gHQA0YGB+/uoubzJ/5Ho8Dc2UajBkd5Grkc3Wa/+
        BIQ/Ym9tILhimihW4HO5v8k=
X-Google-Smtp-Source: APBJJlGOKGPTxrO7lRfORr6DqagNLPzwzzshhLs9Bw1pOYkel88A1WGJgfjWr1WXV0Rqur+dEjublQ==
X-Received: by 2002:a05:6602:1584:b0:787:1c7f:8abf with SMTP id e4-20020a056602158400b007871c7f8abfmr1510784iow.10.1689173079714;
        Wed, 12 Jul 2023 07:44:39 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id y24-20020a02c018000000b0042b669f5084sm1282110jai.62.2023.07.12.07.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 07:44:39 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] hwmon: Remove strlcpy occurences
Date:   Wed, 12 Jul 2023 14:44:29 +0000
Message-ID: <20230712144429.2845940-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with direct assignment.

strlcpy in this file is used to copy fixed-length strings which can be
completely avoided by direct assignment and is safe to do so. strlen()
is used to return the length of @tbuf.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 drivers/hwmon/pmbus/max20730.c |   64 +++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 31 deletions(-)

diff --git a/drivers/hwmon/pmbus/max20730.c b/drivers/hwmon/pmbus/max20730.c
index 7bcf27995033..f5ba23f0fed5 100644
--- a/drivers/hwmon/pmbus/max20730.c
+++ b/drivers/hwmon/pmbus/max20730.c
@@ -113,7 +113,8 @@ static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
 	struct max20730_debugfs_data *psu = to_psu(idxp, idx);
 	const struct pmbus_driver_info *info;
 	const struct max20730_data *data;
-	char tbuf[DEBUG_FS_DATA_MAX] = { 0 };
+	char tbuf[DEBUG_FS_DATA_MAX] = {};
+	char *result = tbuf;
 	u16 val;

 	info = pmbus_get_driver_info(psu->client);
@@ -148,13 +149,13 @@ static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
 			>> MAX20730_MFR_DEVSET1_TSTAT_BIT_POS;

 		if (val == 0)
-			len = strlcpy(tbuf, "2000\n", DEBUG_FS_DATA_MAX);
+			result = "2000\n";
 		else if (val == 1)
-			len = strlcpy(tbuf, "125\n", DEBUG_FS_DATA_MAX);
+			result = "125\n";
 		else if (val == 2)
-			len = strlcpy(tbuf, "62.5\n", DEBUG_FS_DATA_MAX);
+			result = "62.5\n";
 		else
-			len = strlcpy(tbuf, "32\n", DEBUG_FS_DATA_MAX);
+			result = "32\n";
 		break;
 	case MAX20730_DEBUGFS_INTERNAL_GAIN:
 		val = (data->mfr_devset1 & MAX20730_MFR_DEVSET1_RGAIN_MASK)
@@ -163,35 +164,35 @@ static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
 		if (data->id == max20734) {
 			/* AN6209 */
 			if (val == 0)
-				len = strlcpy(tbuf, "0.8\n", DEBUG_FS_DATA_MAX);
+				result = "0.8\n";
 			else if (val == 1)
-				len = strlcpy(tbuf, "3.2\n", DEBUG_FS_DATA_MAX);
+				result = "3.2\n";
 			else if (val == 2)
-				len = strlcpy(tbuf, "1.6\n", DEBUG_FS_DATA_MAX);
+				result = "1.6\n";
 			else
-				len = strlcpy(tbuf, "6.4\n", DEBUG_FS_DATA_MAX);
+				result = "6.4\n";
 		} else if (data->id == max20730 || data->id == max20710) {
 			/* AN6042 or AN6140 */
 			if (val == 0)
-				len = strlcpy(tbuf, "0.9\n", DEBUG_FS_DATA_MAX);
+				result = "0.9\n";
 			else if (val == 1)
-				len = strlcpy(tbuf, "3.6\n", DEBUG_FS_DATA_MAX);
+				result = "3.6\n";
 			else if (val == 2)
-				len = strlcpy(tbuf, "1.8\n", DEBUG_FS_DATA_MAX);
+				result = "1.8\n";
 			else
-				len = strlcpy(tbuf, "7.2\n", DEBUG_FS_DATA_MAX);
+				result = "7.2\n";
 		} else if (data->id == max20743) {
 			/* AN6042 */
 			if (val == 0)
-				len = strlcpy(tbuf, "0.45\n", DEBUG_FS_DATA_MAX);
+				result = "0.45\n";
 			else if (val == 1)
-				len = strlcpy(tbuf, "1.8\n", DEBUG_FS_DATA_MAX);
+				result = "1.8\n";
 			else if (val == 2)
-				len = strlcpy(tbuf, "0.9\n", DEBUG_FS_DATA_MAX);
+				result = "0.9\n";
 			else
-				len = strlcpy(tbuf, "3.6\n", DEBUG_FS_DATA_MAX);
+				result = "3.6\n";
 		} else {
-			len = strlcpy(tbuf, "Not supported\n", DEBUG_FS_DATA_MAX);
+			result = "Not supported\n";
 		}
 		break;
 	case MAX20730_DEBUGFS_BOOT_VOLTAGE:
@@ -199,26 +200,26 @@ static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
 			>> MAX20730_MFR_DEVSET1_VBOOT_BIT_POS;

 		if (val == 0)
-			len = strlcpy(tbuf, "0.6484\n", DEBUG_FS_DATA_MAX);
+			result = "0.6484\n";
 		else if (val == 1)
-			len = strlcpy(tbuf, "0.8984\n", DEBUG_FS_DATA_MAX);
+			result = "0.8984\n";
 		else if (val == 2)
-			len = strlcpy(tbuf, "1.0\n", DEBUG_FS_DATA_MAX);
+			result = "1.0\n";
 		else
-			len = strlcpy(tbuf, "Invalid\n", DEBUG_FS_DATA_MAX);
+			result = "Invalid\n";
 		break;
 	case MAX20730_DEBUGFS_OUT_V_RAMP_RATE:
 		val = (data->mfr_devset2 & MAX20730_MFR_DEVSET2_VRATE)
 			>> MAX20730_MFR_DEVSET2_VRATE_BIT_POS;

 		if (val == 0)
-			len = strlcpy(tbuf, "4\n", DEBUG_FS_DATA_MAX);
+			result = "4\n";
 		else if (val == 1)
-			len = strlcpy(tbuf, "2\n", DEBUG_FS_DATA_MAX);
+			result = "2\n";
 		else if (val == 2)
-			len = strlcpy(tbuf, "1\n", DEBUG_FS_DATA_MAX);
+			result = "1\n";
 		else
-			len = strlcpy(tbuf, "Invalid\n", DEBUG_FS_DATA_MAX);
+			result = "Invalid\n";
 		break;
 	case MAX20730_DEBUGFS_OC_PROTECT_MODE:
 		ret = (data->mfr_devset2 & MAX20730_MFR_DEVSET2_OCPM_MASK)
@@ -230,13 +231,13 @@ static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
 			>> MAX20730_MFR_DEVSET2_SS_BIT_POS;

 		if (val == 0)
-			len = strlcpy(tbuf, "0.75\n", DEBUG_FS_DATA_MAX);
+			result = "0.75\n";
 		else if (val == 1)
-			len = strlcpy(tbuf, "1.5\n", DEBUG_FS_DATA_MAX);
+			result = "1.5\n";
 		else if (val == 2)
-			len = strlcpy(tbuf, "3\n", DEBUG_FS_DATA_MAX);
+			result = "3\n";
 		else
-			len = strlcpy(tbuf, "6\n", DEBUG_FS_DATA_MAX);
+			result = "6\n";
 		break;
 	case MAX20730_DEBUGFS_IMAX:
 		ret = (data->mfr_devset2 & MAX20730_MFR_DEVSET2_IMAX_MASK)
@@ -287,9 +288,10 @@ static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
 				"%d.%d\n", ret / 10000, ret % 10000);
 		break;
 	default:
-		len = strlcpy(tbuf, "Invalid\n", DEBUG_FS_DATA_MAX);
+		result = "Invalid\n";
 	}

+	len = strlen(result);
 	return simple_read_from_buffer(buf, count, ppos, tbuf, len);
 }

--
2.41.0.255.g8b1d071c50-goog


