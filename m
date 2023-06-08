Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179BC727C92
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbjFHKR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjFHKRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:17:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F363D2706
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 03:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686219399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xYCw3I4nWr1p+lEe4qR80qwR+LhJGCUxY2FlsUOhHns=;
        b=TaS/yqanJbPbe4mRWobdIxOEiyhnO80LNH3IS6mPXJj3x/d0thz6MYDTuENKjYV9QqxcCB
        CUdztk4YdI0x2XGe5ehjbCrGc6WvUqo4FML4YhSrFPJOls8il9GtZe7dTTOWkLwoEX1RYf
        HchJzq/u12PkXj2tjvCr2nYNEb4C/wU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-V9RVtU4UNqGI7yO4LVyt7A-1; Thu, 08 Jun 2023 06:16:38 -0400
X-MC-Unique: V9RVtU4UNqGI7yO4LVyt7A-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5149e1bd242so443639a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 03:16:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686219397; x=1688811397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYCw3I4nWr1p+lEe4qR80qwR+LhJGCUxY2FlsUOhHns=;
        b=Tb1dGHhwlhd901zUmAt4z09qk9/Qr2w42jxFy76fH8W8zl9+QI9IpPdRFkvkdQfi0b
         eZuTkyaOprx5xyJJ/kqG1Vfn1m7cGHG5Q30js2KbgAGQWX8QJoaKH0fasUXhLsdTgY32
         opdnjnMPOD42W+oMzpgnpFl0VR+Xj+gUKl3TGDx1I7a2fzg7HkXGzkIwpcMMOro1XYkQ
         y5OblwVMEjwXZswbU5ghacjqn2IFCdC+V3au4I+kNd1B9nHtinIwVk26Huh/8mK+ah4d
         UybIi46SfNs3xMu6zzDEsSFGAFLG/TaWOODyLBruqYNyQSF0K6cowiH28XqSbD/+y0+E
         yo0g==
X-Gm-Message-State: AC+VfDwnaaFvsOrlalpcPjzkh4JdZ0hQ38XCXW5h4giFoh3C/hYVFLMv
        oFb3pkx7xnxnf8xVwOuMbhqoFXlK7K2ymY4qVrawSj5R/sFory4iWrPWGnyjvRj35+pve06kiu3
        0SGMxOCoTJz3mDu5mseVhPBGu
X-Received: by 2002:a17:906:4fcd:b0:978:9ad7:e736 with SMTP id i13-20020a1709064fcd00b009789ad7e736mr1906687ejw.39.1686219396857;
        Thu, 08 Jun 2023 03:16:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6FwyrOWXKjHsDINcg4QuGkxMlJ+8bPC1MM3qHtDfay7aIVDCD3WI28XJhe+u0atwcZ/NErNA==
X-Received: by 2002:a17:906:4fcd:b0:978:9ad7:e736 with SMTP id i13-20020a1709064fcd00b009789ad7e736mr1906661ejw.39.1686219396526;
        Thu, 08 Jun 2023 03:16:36 -0700 (PDT)
Received: from localhost.localdomain ([46.33.96.32])
        by smtp.gmail.com with ESMTPSA id e20-20020a170906249400b00977da0f14ffsm506558ejb.171.2023.06.08.03.16.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Jun 2023 03:16:35 -0700 (PDT)
From:   Michal Sekletar <msekleta@redhat.com>
To:     jirislaby@kernel.org
Cc:     arozansk@redhat.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        msekleta@redhat.com, shuah@kernel.org
Subject: [PATCH v2 1/2] tty: tty_io: update timestamps on all device nodes
Date:   Thu,  8 Jun 2023 12:16:15 +0200
Message-Id: <20230608101616.44152-1-msekleta@redhat.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <c91c458e-58d0-f13a-9adb-a48a19f82107@kernel.org>
References: <c91c458e-58d0-f13a-9adb-a48a19f82107@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

v1 -> v2: Minor style tweaks based on code review comments

drivers/tty/tty_io.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index c84be40fb..a505d2c49 100644
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
2.39.1

