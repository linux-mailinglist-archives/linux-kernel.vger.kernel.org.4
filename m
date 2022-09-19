Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DA35BD1F1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiISQPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiISQPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:15:07 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0C413DE4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 09:15:06 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so7764036pjq.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 09:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ETVkJGsHbRQfzGEcydO0b9qAVRVZbWDGRCa+GJ2CZig=;
        b=PYqGrMnydl91H6U9MGvWS8OfrlF6MyThO+g3c1oKpoaXlO6+0aOpp3YLMDKiFt1t2W
         bXH+2VTNpWW5gQ8AztzFVjT5G2KO7uXcL+nNVb+kRivzRCoUkphAJiMBnZbRXc2+rbbw
         RTzSoLke0BFXp4EtiiO4R6+djq4KiNXX1EcIMRzueOKf4QUL7/EQbn800aTJ2WhHNnrq
         C97L84+arjfJh+TyK3vExXxc1/XBk5K0rrTyxyh7XxjMjLFIrV4Ba1CmB/Ax93eYXPhj
         OahioHMewdwVv7huybFU80brUxWDDcWDgnfsPqmwyEm2vcyAinDU+xk1ro3rNEclbRKJ
         RgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ETVkJGsHbRQfzGEcydO0b9qAVRVZbWDGRCa+GJ2CZig=;
        b=HhpwApkzjkRRgHhWG5N/9EMG/+jH5JdgsICFy/XkJ31OC4LF3sOGQoKJeYseASnvVP
         RgzMQ1pzLzViut6aNZECY8FQdypH+n6If8wPEeVwesQMC9AIkNKP33loLzcQ/fTx0I66
         LsWPsnCSKvWvfV3WhEKFkoArr5cGjyZ2We/Lbmjmn71quo84PVbkYQx0aPlHDfbH6AB/
         X8pzJAFIhhvMUTeDRIOCN3EtC1e4BwWkESIR4ADNJ8Hpfuldzy53NxqOnUTN+fwh+ZEl
         SOdcd2Kfj6xKKL7eG0JIHWOHnjSJjCk7RTpjO6tBTn23f4YGO6j2c2BNaGclhRV9qUaO
         d12g==
X-Gm-Message-State: ACrzQf30BQOQwazIWNQ8WKkizRNgWi2Ika+8dY2+DNuInFEEG44QeC0O
        LSkaqqVuPmWnyZFXvaP+dzddz3xoz+w=
X-Google-Smtp-Source: AMsMyM6lgBQDlLT6qMrFgjgYD6Yw+u+vaau7eYa+5G2r7Ek5iyWbGDSNbIEOQqnvtJOHG5C3vNwGig==
X-Received: by 2002:a17:902:8c81:b0:178:a33f:8b8f with SMTP id t1-20020a1709028c8100b00178a33f8b8fmr541383plo.50.1663604106139;
        Mon, 19 Sep 2022 09:15:06 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:8958:94cc:1777:6efd])
        by smtp.gmail.com with ESMTPSA id x21-20020aa78f15000000b00540f3ac5fb8sm20709787pfr.69.2022.09.19.09.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 09:15:05 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs-tools: support F2FS_IOC_START_ATOMIC_REPLACE
Date:   Mon, 19 Sep 2022 09:15:02 -0700
Message-Id: <20220919161502.2219862-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Added options in f2fs_io write command to support
F2FS_IOC_START_ATOMIC_REPLACE.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 tools/f2fs_io/f2fs_io.c | 31 ++++++++++++++++++++++---------
 tools/f2fs_io/f2fs_io.h |  1 +
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index 5be7b9e..6dcd840 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -513,7 +513,9 @@ static void do_erase(int argc, char **argv, const struct cmd_desc *cmd)
 "  osync         : O_SYNC\n"				\
 "  atomic_commit : atomic write & commit\n"		\
 "  atomic_abort  : atomic write & abort\n"		\
-"{delay} is in ms unit and optional only for atomic_commit and atomic_abort\n"
+"  atomic_rcommit: atomic replace & commit\n"	\
+"  atomic_rabort : atomic replace & abort\n"	\
+"{delay} is in ms unit and optional only for atomic operations\n"
 
 static void do_write(int argc, char **argv, const struct cmd_desc *cmd)
 {
@@ -524,7 +526,7 @@ static void do_write(int argc, char **argv, const struct cmd_desc *cmd)
 	int flags = 0;
 	int fd;
 	u64 total_time = 0, max_time = 0, max_time_t = 0;
-	bool atomic_commit = false, atomic_abort = false;
+	bool atomic_commit = false, atomic_abort = false, replace = false;
 	int useconds = 0;
 
 	srand(time(0));
@@ -551,18 +553,25 @@ static void do_write(int argc, char **argv, const struct cmd_desc *cmd)
 	else if (strcmp(argv[4], "inc_num") && strcmp(argv[4], "rand"))
 		die("Wrong pattern type");
 
-	if (!strcmp(argv[5], "dio"))
+	if (!strcmp(argv[5], "dio")) {
 		flags |= O_DIRECT;
-	else if (!strcmp(argv[5], "dsync"))
+	} else if (!strcmp(argv[5], "dsync")) {
 		flags |= O_DIRECT | O_DSYNC;
-	else if (!strcmp(argv[5], "osync"))
+	} else if (!strcmp(argv[5], "osync")) {
 		flags |= O_SYNC;
-	else if (!strcmp(argv[5], "atomic_commit"))
+	} else if (!strcmp(argv[5], "atomic_commit")) {
 		atomic_commit = true;
-	else if (!strcmp(argv[5], "atomic_abort"))
+	} else if (!strcmp(argv[5], "atomic_abort")) {
 		atomic_abort = true;
-	else if (strcmp(argv[5], "buffered"))
+	} else if (!strcmp(argv[5], "atomic_rcommit")) {
+		atomic_commit = true;
+		replace = true;
+	} else if (!strcmp(argv[5], "atomic_rabort")) {
+		atomic_abort = true;
+		replace = true;
+	} else if (strcmp(argv[5], "buffered")) {
 		die("Wrong IO type");
+	}
 
 	fd = xopen(argv[6], O_CREAT | O_WRONLY | flags, 0755);
 
@@ -572,7 +581,11 @@ static void do_write(int argc, char **argv, const struct cmd_desc *cmd)
 		if (argc == 8)
 			useconds = atoi(argv[7]) * 1000;
 
-		ret = ioctl(fd, F2FS_IOC_START_ATOMIC_WRITE);
+		if (replace)
+			ret = ioctl(fd, F2FS_IOC_START_ATOMIC_REPLACE);
+		else
+			ret = ioctl(fd, F2FS_IOC_START_ATOMIC_WRITE);
+
 		if (ret < 0) {
 			fputs("setting atomic file mode failed\n", stderr);
 			exit(1);
diff --git a/tools/f2fs_io/f2fs_io.h b/tools/f2fs_io/f2fs_io.h
index bd8db0b..58be8f8 100644
--- a/tools/f2fs_io/f2fs_io.h
+++ b/tools/f2fs_io/f2fs_io.h
@@ -90,6 +90,7 @@ typedef u32	__be32;
 						struct f2fs_comp_option)
 #define F2FS_IOC_DECOMPRESS_FILE        _IO(F2FS_IOCTL_MAGIC, 23)
 #define F2FS_IOC_COMPRESS_FILE          _IO(F2FS_IOCTL_MAGIC, 24)
+#define F2FS_IOC_START_ATOMIC_REPLACE	_IO(F2FS_IOCTL_MAGIC, 25)
 
 #ifndef FSCRYPT_POLICY_V1
 #define FSCRYPT_POLICY_V1		0
-- 
2.37.3.968.ga6b4b080e4-goog

