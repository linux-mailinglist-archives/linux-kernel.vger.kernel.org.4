Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F696EF30C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 13:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240619AbjDZLFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 07:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240482AbjDZLF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 07:05:29 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38FE524E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 04:05:23 -0700 (PDT)
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 33QB56Ie037041;
        Wed, 26 Apr 2023 20:05:06 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Wed, 26 Apr 2023 20:05:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 33QB56il037036
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Apr 2023 20:05:06 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5cebade5-0aa9-506c-c817-7bcf098eba89@I-love.SAKURA.ne.jp>
Date:   Wed, 26 Apr 2023 20:05:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: [PATCH] tty: tty_io: remove hung_up_tty_fops
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000013aaac05f9d44e7a@google.com>
 <CACT4Y+bj7jCOjGV5jCUPzN5zjgdHxRn9vkwQEBuPWVzMbMCnXw@mail.gmail.com>
 <6ff6fdea-c955-f9dd-289e-b0d613a28280@I-love.SAKURA.ne.jp>
 <20230423233433.GF3390869@ZenIV>
 <e1fe6a44-3021-62ad-690a-69146e39e1ac@I-love.SAKURA.ne.jp>
 <20230424004431.GG3390869@ZenIV>
 <8e21256a-736e-4c2d-1ff4-723775bcac46@I-love.SAKURA.ne.jp>
 <2fca7932-5030-32c3-dd61-48dd78e58e11@I-love.SAKURA.ne.jp>
 <20230425160344.GS3390869@ZenIV>
 <1b405689-ea0a-6696-6709-d372ce72d68c@I-love.SAKURA.ne.jp>
In-Reply-To: <1b405689-ea0a-6696-6709-d372ce72d68c@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot is reporting data race between __tty_hangup() and __fput(), for
filp->f_op readers are not holding tty->files_lock.

Dmitry Vyukov mentioned that this race has possibility of NULL pointer
dereference, for tty_fops implements e.g. splice_read callback whereas
hung_up_tty_fops does not.

  CPU0                                  CPU1
  ----                                  ----
  do_splice_to() {
                                        __tty_hangup() {
    // f_op->splice_read was generic_file_splice_read
    if (unlikely(!in->f_op->splice_read))
      return warn_unsupported(in, "read");
                                          filp->f_op = &hung_up_tty_fops;
    // f_op->splice_read is now NULL
    return in->f_op->splice_read(in, ppos, pipe, len, flags);
    }
  }

If we care about only NULL pointer dereference, implementing missing
callbacks to hung_up_tty_fops is fine. But if we also care about KCSAN
reports, we will need to wrap all filp->f_op usages which are reachable
via tty_fops callbacks using data_race().

Such wrapping is overkill as a fix for tty_io code. Therefore, instead of
implementing missing callbacks, stop updating filp->f_op and remove
hung_up_tty_fops. Then, changes will be limited to within tty_io code.

tty_open() is doing "filp->f_op = &tty_fops;".
__tty_hangup() is doing "filp->f_op = &hung_up_tty_fops;".
tty_hung_up_p() is doing "filp->f_op == &hung_up_tty_fops", and
most functions are checking tty_hung_up_p().

Since tty_open() allocates "struct tty_file_private" for each
"struct file", we can remember whether __tty_hangup() was called
by adding a flag to "struct tty_file_private".

Below is detail of where/what to change.

Regarding __tty_hangup(), replace "filp->f_op = &hung_up_tty_fops;" with
setting the above-mentioned flag.

Regarding tty_hungup_p(), replace "filp->f_op == &hung_up_tty_fops" with
"filp->f_op == &tty_fops" and check the above-mentioned flag.

Regarding tty_open(), just remove "filp->f_op = &tty_fops;" because
"struct tty_file_private" was already released by tty_del_file() from
tty_release() when control reaches this line.

Regarding tty_{read,write,poll,ioctl,compat_ioctl}(), respectively embed
hung_up_tty_{read,write,poll,ioctl,compat_ioctl}() right before
tty_paranoia_check().

Regarding tty_fasync(), embed hung_up_tty_fasync() right before tty_lock()
in tty_fasync() rather than tty_paranoia_check() in __tty_fasync(), for
tty_hung_up_p() is checked right after tty_lock() returned.

Since tty_read() is called via file->f_op->read_iter() from
call_read_iter() from generic_file_splice_read(), no change is needed for
tty_fops->splice_read.

Since tty_write() is called via file->f_op->write_iter() from
call_write_iter() from do_iter_readv_writev() from do_iter_write() from
vfs_iter_write() from iter_file_splice_write(), no change is needed for
tty_fops->splice_write.

Since both tty_fops and hung_up_tty_fops point to the same callback for
llseek/release, no change is needed for tty_fops->{llseek,release}.

Finally, remove hung_up_tty_fops.

Reported-by: syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>
Link: https://syzkaller.appspot.com/bug?extid=b7c3ba8cdc2f6cf83c21
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
 drivers/tty/tty_io.c | 37 ++++++++++++++++++-------------------
 include/linux/tty.h  |  1 +
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 36fb945fdad4..c1748e4da233 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -182,7 +182,7 @@ int tty_alloc_file(struct file *file)
 {
 	struct tty_file_private *priv;
 
-	priv = kmalloc(sizeof(*priv), GFP_KERNEL);
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
@@ -491,17 +491,6 @@ static const struct file_operations console_fops = {
 	.fasync		= tty_fasync,
 };
 
-static const struct file_operations hung_up_tty_fops = {
-	.llseek		= no_llseek,
-	.read_iter	= hung_up_tty_read,
-	.write_iter	= hung_up_tty_write,
-	.poll		= hung_up_tty_poll,
-	.unlocked_ioctl	= hung_up_tty_ioctl,
-	.compat_ioctl	= hung_up_tty_compat_ioctl,
-	.release	= tty_release,
-	.fasync		= hung_up_tty_fasync,
-};
-
 static DEFINE_SPINLOCK(redirect_lock);
 static struct file *redirect;
 
@@ -619,7 +608,8 @@ static void __tty_hangup(struct tty_struct *tty, int exit_session)
 			continue;
 		closecount++;
 		__tty_fasync(-1, filp, 0);	/* can't block */
-		filp->f_op = &hung_up_tty_fops;
+		/* Accept race with tty_hung_up_p() test. */
+		data_race(priv->hung = true);
 	}
 	spin_unlock(&tty->files_lock);
 
@@ -743,7 +733,9 @@ void tty_vhangup_session(struct tty_struct *tty)
  */
 int tty_hung_up_p(struct file *filp)
 {
-	return (filp && filp->f_op == &hung_up_tty_fops);
+	return filp && filp->f_op == &tty_fops &&
+		/* Accept race with __tty_hangup(). */
+		data_race(((struct tty_file_private *) filp->private_data)->hung);
 }
 EXPORT_SYMBOL(tty_hung_up_p);
 
@@ -911,6 +903,8 @@ static ssize_t tty_read(struct kiocb *iocb, struct iov_iter *to)
 	struct tty_struct *tty = file_tty(file);
 	struct tty_ldisc *ld;
 
+	if (tty_hung_up_p(file))
+		return hung_up_tty_read(iocb, to);
 	if (tty_paranoia_check(tty, inode, "tty_read"))
 		return -EIO;
 	if (!tty || tty_io_error(tty))
@@ -1073,6 +1067,8 @@ static ssize_t file_tty_write(struct file *file, struct kiocb *iocb, struct iov_
 	struct tty_ldisc *ld;
 	ssize_t ret;
 
+	if (tty_hung_up_p(file))
+		return hung_up_tty_write(iocb, from);
 	if (tty_paranoia_check(tty, file_inode(file), "tty_write"))
 		return -EIO;
 	if (!tty || !tty->ops->write ||	tty_io_error(tty))
@@ -2159,11 +2155,6 @@ static int tty_open(struct inode *inode, struct file *filp)
 			return retval;
 
 		schedule();
-		/*
-		 * Need to reset f_op in case a hangup happened.
-		 */
-		if (tty_hung_up_p(filp))
-			filp->f_op = &tty_fops;
 		goto retry_open;
 	}
 	clear_bit(TTY_HUPPED, &tty->flags);
@@ -2197,6 +2188,8 @@ static __poll_t tty_poll(struct file *filp, poll_table *wait)
 	struct tty_ldisc *ld;
 	__poll_t ret = 0;
 
+	if (tty_hung_up_p(filp))
+		return hung_up_tty_poll(filp, wait);
 	if (tty_paranoia_check(tty, file_inode(filp), "tty_poll"))
 		return 0;
 
@@ -2249,6 +2242,8 @@ static int tty_fasync(int fd, struct file *filp, int on)
 	struct tty_struct *tty = file_tty(filp);
 	int retval = -ENOTTY;
 
+	if (tty_hung_up_p(filp))
+		return hung_up_tty_fasync(fd, filp, on);
 	tty_lock(tty);
 	if (!tty_hung_up_p(filp))
 		retval = __tty_fasync(fd, filp, on);
@@ -2658,6 +2653,8 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	int retval;
 	struct tty_ldisc *ld;
 
+	if (tty_hung_up_p(file))
+		return hung_up_tty_ioctl(file, cmd, arg);
 	if (tty_paranoia_check(tty, file_inode(file), "tty_ioctl"))
 		return -EINVAL;
 
@@ -2943,6 +2940,8 @@ static long tty_compat_ioctl(struct file *file, unsigned int cmd,
 		return tty_ioctl(file, cmd, arg);
 	}
 
+	if (tty_hung_up_p(file))
+		return hung_up_tty_compat_ioctl(file, cmd, arg);
 	if (tty_paranoia_check(tty, file_inode(file), "tty_ioctl"))
 		return -EINVAL;
 
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 093935e97f42..d7fa18f8c526 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -255,6 +255,7 @@ struct tty_file_private {
 	struct tty_struct *tty;
 	struct file *file;
 	struct list_head list;
+	bool hung;
 };
 
 /**
-- 
2.34.1

