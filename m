Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F326FC579
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbjEILzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbjEILyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:54:43 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BDC421D;
        Tue,  9 May 2023 04:54:40 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3062db220a3so3709421f8f.0;
        Tue, 09 May 2023 04:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683633279; x=1686225279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tolBytGtS8Xn8iqANX94YDwAEigexY0tGBNVZtJhEmU=;
        b=D6TvQygrPJNzSbMNHt4fPWFwo/YKMyUETTgiVamzBUKtWWKADyyauhyudd3KgaG6Wy
         iZ+nvp3l0YOQ2TZKMzVB3UPT4j1JLTeQa7/VNhfYQYDP4I0ZKZFmdgfhNe+vRCrg/5ao
         yv64sC8Cr54gQ0i783euGwBVeO+zPdAg4flsJwDByFISeQP+KqS1/CYySsjjP3Oejfgb
         zh6RtIeg5738bgB8y7hoYAMd3nzqV2E4sY/SAdR5H9rKruIXLjcSx8/rYhR5019vOU7A
         yjSBZhlfsUDFIsn6snjXLJJPsxGKmqdaarDD+vML/Mp2RO5sgFJghcdoHV3TxLgeA0ra
         /HJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683633279; x=1686225279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tolBytGtS8Xn8iqANX94YDwAEigexY0tGBNVZtJhEmU=;
        b=W8g8WggNjz/O9hTOLGDIGjjQCRE7L7ZXliUFze+6YJpXd6wdgQq16QbfTf08NoqjqO
         L4sYwVFLnmUpxpr0qaXuSbAU0s9KVwR+YUMH5X58/r8KrThvf/izeaPtP3VwZYlKoHZX
         y32fzVzB70G3e4VOKVTnz7vbEGhIzpo0hBPlQIO3TEQBIcLPGrClKlSuELNUirS30HJf
         Kb85GZs383hMwDyfutCbVrRLdOwHnyo2Km0NVXjq3R/uIvMrJTjw9JW30uCf5FKXrkOh
         ihYVabCCfok7rc3DLzTjJxgaCCqkJnJx85FxJ7HlfIEFRd7uGWIHxyfUufQ0UICuGLF8
         1Cng==
X-Gm-Message-State: AC+VfDwGpjaph1gDAoajQmBpcUiswNmeYx9ToSNynEkmm0610frNs8Tl
        4B2rsm2QaVT8A+jAACbTqkpYU9q/9Pk=
X-Google-Smtp-Source: ACHHUZ7lUnR1lX2mgpHgMvrPLwQZiXCLPakDNhXkNVP+sknjVOjyDfgZTT0z9ZjxVHwGQvBtagcN7Q==
X-Received: by 2002:a05:6000:10a:b0:2f9:482f:c13f with SMTP id o10-20020a056000010a00b002f9482fc13fmr8829581wrx.46.1683633279032;
        Tue, 09 May 2023 04:54:39 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id b15-20020a5d4b8f000000b003064600cff9sm14153895wrt.38.2023.05.09.04.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 04:54:38 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] scsi: ses: Avoid reporting errors for simple subenclosures
Date:   Tue,  9 May 2023 12:54:24 +0100
Message-Id: <20230509115424.3996664-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the SES driver reports bogus errors when plugging
in a drive that exposes only a single, simple subenclosure:

[  432.713731] scsi 3:0:0:0: Direct-Access     WD       Elements 2667    2007 PQ: 0 ANSI: 6
[  432.714127] scsi 3:0:0:1: Enclosure         WD       SES Device       2007 PQ: 0 ANSI: 6
...
[  432.716508] scsi 3:0:0:1: Attached scsi generic sg2 type 13
...
[  439.897020] scsi 3:0:0:1: Wrong diagnostic page; asked for 1 got 8
[  439.897023] scsi 3:0:0:1: Failed to get diagnostic page 0x1
[  439.897025] scsi 3:0:0:1: Failed to bind enclosure -19

According to the SES specification, simple subenclosures always
return diagnostic page 8 no matter what page was requested, so
the device is permitted to page 8 here and nothing is wrong.

To avoid polluting the kernel logs with bogus errors, the first
diagnostic page read bypasses the usual page code check. If it
returns page 8 the device is assumed to be a simple subenclosure
and no enclosure device is created. Simple subenclosures only
return a vendor specific status byte in page 8 and don't support
any other pages, so they can't support the enclosure interface.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/scsi/ses.c | 53 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/ses.c b/drivers/scsi/ses.c
index d7d0c35c58b8..3457d8bc1ddf 100644
--- a/drivers/scsi/ses.c
+++ b/drivers/scsi/ses.c
@@ -73,9 +73,12 @@ static void init_device_slot_control(unsigned char *dest_desc,
 	dest_desc[3] &= 0x3c;
 }
 
-
-static int ses_recv_diag(struct scsi_device *sdev, int page_code,
-			 void *buf, int bufflen)
+/*
+ * Raw RECEIVE_DIAGNOSTIC page command. Does not check the returned
+ * page code, which may differ from the requested page code!
+ */
+static int __ses_recv_diag(struct scsi_device *sdev, int page_code,
+			   void *buf, int bufflen)
 {
 	int ret;
 	unsigned char cmd[] = {
@@ -86,7 +89,6 @@ static int ses_recv_diag(struct scsi_device *sdev, int page_code,
 		bufflen & 0xff,
 		0
 	};
-	unsigned char recv_page_code;
 	unsigned int retries = SES_RETRIES;
 	struct scsi_sense_hdr sshdr;
 	const struct scsi_exec_args exec_args = {
@@ -100,6 +102,15 @@ static int ses_recv_diag(struct scsi_device *sdev, int page_code,
 		 (sshdr.sense_key == NOT_READY ||
 		  (sshdr.sense_key == UNIT_ATTENTION && sshdr.asc == 0x29)));
 
+	return ret;
+}
+
+static int ses_recv_diag(struct scsi_device *sdev, int page_code,
+			 void *buf, int bufflen)
+{
+	unsigned char recv_page_code;
+	int ret = __ses_recv_diag(sdev, page_code, buf, bufflen);
+
 	if (unlikely(ret))
 		return ret;
 
@@ -108,8 +119,11 @@ static int ses_recv_diag(struct scsi_device *sdev, int page_code,
 	if (likely(recv_page_code == page_code))
 		return ret;
 
-	/* successful diagnostic but wrong page code.  This happens to some
-	 * USB devices, just print a message and pretend there was an error */
+	/*
+	 * Successful diagnostic but wrong page code. Shouldn't happen
+	 * except for simple subenclosures, which should already have
+	 * been detected by this point.
+	 */
 
 	sdev_printk(KERN_ERR, sdev,
 		    "Wrong diagnostic page; asked for %d got %u\n",
@@ -695,11 +709,33 @@ static int ses_intf_add(struct device *cdev)
 	if (!hdr_buf || !ses_dev)
 		goto err_init_free;
 
+	/*
+	 * Read without checking page code, getting a different page
+	 * is not necessarily an error for devices with only a simple
+	 * subenclosure (eg. some USB drives).
+	 */
 	page = 1;
-	result = ses_recv_diag(sdev, page, hdr_buf, INIT_ALLOC_SIZE);
+	result = __ses_recv_diag(sdev, page, hdr_buf, INIT_ALLOC_SIZE);
 	if (result)
 		goto recv_failed;
 
+	/*
+	 * A simple subenclosure only supports page 8 and will return
+	 * it after any diagnostic page request. Simple subenclosures
+	 * are not supported by this driver -- there is simply no data
+	 * to report besides a vendor specific byte -- but they will
+	 * not be treated as an error.
+	 */
+	if (hdr_buf[0] == 8) {
+		err = 0;
+		goto err_init_free;
+	}
+
+	/*
+	 * All diagnostic pages will include a length field so even
+	 * if the page code is incorrect at this point, that'll get
+	 * detected when re-reading the page.
+	 */
 	len = (hdr_buf[2] << 8) + hdr_buf[3] + 4;
 	buf = kzalloc(len, GFP_KERNEL);
 	if (!buf)
@@ -817,7 +853,8 @@ static int ses_intf_add(struct device *cdev)
  err_init_free:
 	kfree(ses_dev);
 	kfree(hdr_buf);
-	sdev_printk(KERN_ERR, sdev, "Failed to bind enclosure %d\n", err);
+	if (err)
+		sdev_printk(KERN_ERR, sdev, "Failed to bind enclosure %d\n", err);
 	return err;
 }
 
-- 
2.39.2

