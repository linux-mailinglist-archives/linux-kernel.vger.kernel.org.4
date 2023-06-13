Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB2972E976
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239371AbjFMRWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjFMRWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:22:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEA2E79
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 10:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686676896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BjgBOJODoG0+DT3CMIocMTEhThgFSzfN+D2mFGpmXp4=;
        b=iJ3/4j4K/MYxTwnwNfSqGjgH8ZMTu0QRh6XutBZ8jnUMAaJOZ7/JterqybZuCgIKTC6HK6
        EUPmJxl6H+7gWSFEeTu5eOaybQb2BsfaDodxggR8arZHXtqGYnFbbf5vtxpDrq+ayIWVJ+
        UiwkJF6w496PcbJBae0FUHsI3UvCjtk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-PRxSn9OuMBOx8ID9IdFbBw-1; Tue, 13 Jun 2023 13:21:34 -0400
X-MC-Unique: PRxSn9OuMBOx8ID9IdFbBw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-51495d51e0fso4433646a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 10:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686676893; x=1689268893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjgBOJODoG0+DT3CMIocMTEhThgFSzfN+D2mFGpmXp4=;
        b=hcoSY3Xb/4NR9f1i1AGW+2QDMxCem1PFRe1Iqg4icSEwW51JnkEjqQfwe67aU6KyGJ
         m+VHqN6ZO9IQWc80uGhHPootGpQmOcfDK7+9XvtPkBxvLiNhbqLMEYfqntZh528ZYAS/
         ZeeY1KVXX0kaV47xre6KFrQM0+n3cQhb58HgFDxLZGkolkQXJActo38GBK1/ij+mm9+W
         jsS3EqXjvdW4Kz4N+ol5WAEeRzQY/RnFWoM9TZk4lKEXs9vm43IWa0b2UBbOOL93nBVk
         KAB8B+3nOPycATtQHsyXamALzTcSHXWV/hIko6ytoI7QbWVabs1FyaKlokl98qF7U6A1
         DvyQ==
X-Gm-Message-State: AC+VfDyYpoUUlOz8M/BH5MT6JLXGG944hFR48N1YBZnbzNGH2Ly2tHvz
        2/kIuVNLhyc4FCsKQ0QF/DH3BKAOnDGzOHHOlJHrJ/8tvIk2jWnK+60VmirmhH98woSu9Ip+f9h
        eT6lZBH5u/MF7VAuA241ag0Ec
X-Received: by 2002:aa7:d7d8:0:b0:518:4abe:965c with SMTP id e24-20020aa7d7d8000000b005184abe965cmr2963452eds.4.1686676892728;
        Tue, 13 Jun 2023 10:21:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7UMkHCOARQuHHToWZY8W7C0GC3djyS9MFRrH1Pb+3d4ezP73Vrq+11XEmagjErFGJsqxgEvA==
X-Received: by 2002:aa7:d7d8:0:b0:518:4abe:965c with SMTP id e24-20020aa7d7d8000000b005184abe965cmr2963440eds.4.1686676892332;
        Tue, 13 Jun 2023 10:21:32 -0700 (PDT)
Received: from localhost.localdomain ([46.33.96.32])
        by smtp.gmail.com with ESMTPSA id g16-20020aa7d1d0000000b0050bc4600d38sm6697705edp.79.2023.06.13.10.21.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Jun 2023 10:21:31 -0700 (PDT)
From:   Michal Sekletar <msekleta@redhat.com>
To:     jirislaby@kernel.org
Cc:     arozansk@redhat.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        msekleta@redhat.com, shuah@kernel.org
Subject: [PATCH v3 1/2] tty: tty_io: update timestamps on all device nodes
Date:   Tue, 13 Jun 2023 19:21:06 +0200
Message-Id: <20230613172107.78138-1-msekleta@redhat.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <2023061359-document-armband-d67d@gregkh>
References: <2023061359-document-armband-d67d@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User space applications watch for timestamp changes on character device
files in order to determine idle time of a given terminal session. For
example, "w" program uses this information to populate the IDLE column
of its output [1]. Similarly, systemd-logind has optional feature where
it uses atime of the tty character device to determine if there was
activity on the terminal associated with the logind's session object. If
there was no activity for a configured period of time then logind will
terminate such session [2].

Now, usually (e.g. bash running on the terminal) the use of the terminal
will update timestamps (atime and mtime) on the corresponding terminal
character device. However, if access to the terminal, e.g. /dev/pts/0,
is performed through magic character device /dev/tty then such access
obviously changes the state of the terminal, however timestamps on the
device that correspond to the terminal (/dev/pts/0) are not updated.

This patch makes sure that we update timestamps on *all* character
devices that correspond to the given tty, because outside observers (w,
systemd-logind) are maybe checking these timestamps. Obviously, they can
not check timestamps on /dev/tty as that has per-process meaning.

[1] https://gitlab.com/procps-ng/procps/-/blob/v4.0.0/w.c#L286
[2] https://github.com/systemd/systemd/blob/v252/NEWS#L477

Signed-off-by: Michal Sekletar <msekleta@redhat.com>
---

v2 -> v3: Added more ellaborate commit message for newly introduced kselftest

 drivers/tty/tty_io.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index c84be40fb8df..a505d2c49110 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -101,6 +101,7 @@
 #include <linux/compat.h>
 #include <linux/uaccess.h>
 #include <linux/termios_internal.h>
+#include <linux/fs.h>
 
 #include <linux/kbd_kern.h>
 #include <linux/vt_kern.h>
@@ -811,18 +812,26 @@ void start_tty(struct tty_struct *tty)
 }
 EXPORT_SYMBOL(start_tty);
 
-static void tty_update_time(struct timespec64 *time)
+static void tty_update_time(struct tty_struct *tty, bool mtime)
 {
 	time64_t sec = ktime_get_real_seconds();
+	struct tty_file_private *priv;
 
-	/*
-	 * We only care if the two values differ in anything other than the
-	 * lower three bits (i.e every 8 seconds).  If so, then we can update
-	 * the time of the tty device, otherwise it could be construded as a
-	 * security leak to let userspace know the exact timing of the tty.
-	 */
-	if ((sec ^ time->tv_sec) & ~7)
-		time->tv_sec = sec;
+	spin_lock(&tty->files_lock);
+	list_for_each_entry(priv, &tty->tty_files, list) {
+		struct inode *inode = file_inode(priv->file);
+		struct timespec64 *time = mtime ? &inode->i_mtime : &inode->i_atime;
+
+		/*
+		 * We only care if the two values differ in anything other than the
+		 * lower three bits (i.e every 8 seconds).  If so, then we can update
+		 * the time of the tty device, otherwise it could be construded as a
+		 * security leak to let userspace know the exact timing of the tty.
+		 */
+		if ((sec ^ time->tv_sec) & ~7)
+			time->tv_sec = sec;
+	}
+	spin_unlock(&tty->files_lock);
 }
 
 /*
@@ -928,7 +937,7 @@ static ssize_t tty_read(struct kiocb *iocb, struct iov_iter *to)
 	tty_ldisc_deref(ld);
 
 	if (i > 0)
-		tty_update_time(&inode->i_atime);
+		tty_update_time(tty, false);
 
 	return i;
 }
@@ -1036,7 +1045,7 @@ static inline ssize_t do_tty_write(
 		cond_resched();
 	}
 	if (written) {
-		tty_update_time(&file_inode(file)->i_mtime);
+		tty_update_time(tty, true);
 		ret = written;
 	}
 out:
-- 
2.40.0

