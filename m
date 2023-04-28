Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2F96F1C92
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 18:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346219AbjD1Q1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 12:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjD1Q1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 12:27:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B86659C0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 09:27:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2576164475
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 16:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B32AC43442;
        Fri, 28 Apr 2023 16:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682699240;
        bh=qb7m4YMSBa4d9x6zOodZ7Skbbb7rceDFiv6iQvlojmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q5pcH/JaolO4MJYCkt17RC1SYi+3ZoMAM+3OeE9/gqVILGc4NS5/fnG/KmKhSNkpS
         zsM3kKvczmpIhith2svV9xUjWsP5jVO0dtn8tvbGbBGbPgzct6yxXnHQhirhaBRdzR
         BOfeRqlKWqEhYvEJxbMYPKHht3aE14+oKMDHEHQzv8M43fbxBfzdcAhiZumSjaRRba
         DEYhs6YgZ63M8O1w9g7sTWJzUFRkKWPGbaOeaDttgepq/9oFnEP2xdhP0qf2ZnIGuN
         jOILEK+/p4LoM2LgM4ItLpks1NcKOe9Felm8BFbIg/Zc/ubMXEw4g2Hi1GQzDocKUA
         Mg7CGRTd1ApjA==
Date:   Fri, 28 Apr 2023 09:27:18 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] tty: tty_io: remove hung_up_tty_fops
Message-ID: <20230428162718.GA1099174@dev-arch.thelio-3990X>
References: <CACT4Y+bj7jCOjGV5jCUPzN5zjgdHxRn9vkwQEBuPWVzMbMCnXw@mail.gmail.com>
 <6ff6fdea-c955-f9dd-289e-b0d613a28280@I-love.SAKURA.ne.jp>
 <20230423233433.GF3390869@ZenIV>
 <e1fe6a44-3021-62ad-690a-69146e39e1ac@I-love.SAKURA.ne.jp>
 <20230424004431.GG3390869@ZenIV>
 <8e21256a-736e-4c2d-1ff4-723775bcac46@I-love.SAKURA.ne.jp>
 <2fca7932-5030-32c3-dd61-48dd78e58e11@I-love.SAKURA.ne.jp>
 <20230425160344.GS3390869@ZenIV>
 <1b405689-ea0a-6696-6709-d372ce72d68c@I-love.SAKURA.ne.jp>
 <5cebade5-0aa9-506c-c817-7bcf098eba89@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cebade5-0aa9-506c-c817-7bcf098eba89@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tetsuo,

On Wed, Apr 26, 2023 at 08:05:03PM +0900, Tetsuo Handa wrote:
> syzbot is reporting data race between __tty_hangup() and __fput(), for
> filp->f_op readers are not holding tty->files_lock.
> 
> Dmitry Vyukov mentioned that this race has possibility of NULL pointer
> dereference, for tty_fops implements e.g. splice_read callback whereas
> hung_up_tty_fops does not.
> 
>   CPU0                                  CPU1
>   ----                                  ----
>   do_splice_to() {
>                                         __tty_hangup() {
>     // f_op->splice_read was generic_file_splice_read
>     if (unlikely(!in->f_op->splice_read))
>       return warn_unsupported(in, "read");
>                                           filp->f_op = &hung_up_tty_fops;
>     // f_op->splice_read is now NULL
>     return in->f_op->splice_read(in, ppos, pipe, len, flags);
>     }
>   }
> 
> If we care about only NULL pointer dereference, implementing missing
> callbacks to hung_up_tty_fops is fine. But if we also care about KCSAN
> reports, we will need to wrap all filp->f_op usages which are reachable
> via tty_fops callbacks using data_race().
> 
> Such wrapping is overkill as a fix for tty_io code. Therefore, instead of
> implementing missing callbacks, stop updating filp->f_op and remove
> hung_up_tty_fops. Then, changes will be limited to within tty_io code.
> 
> tty_open() is doing "filp->f_op = &tty_fops;".
> __tty_hangup() is doing "filp->f_op = &hung_up_tty_fops;".
> tty_hung_up_p() is doing "filp->f_op == &hung_up_tty_fops", and
> most functions are checking tty_hung_up_p().
> 
> Since tty_open() allocates "struct tty_file_private" for each
> "struct file", we can remember whether __tty_hangup() was called
> by adding a flag to "struct tty_file_private".
> 
> Below is detail of where/what to change.
> 
> Regarding __tty_hangup(), replace "filp->f_op = &hung_up_tty_fops;" with
> setting the above-mentioned flag.
> 
> Regarding tty_hungup_p(), replace "filp->f_op == &hung_up_tty_fops" with
> "filp->f_op == &tty_fops" and check the above-mentioned flag.
> 
> Regarding tty_open(), just remove "filp->f_op = &tty_fops;" because
> "struct tty_file_private" was already released by tty_del_file() from
> tty_release() when control reaches this line.
> 
> Regarding tty_{read,write,poll,ioctl,compat_ioctl}(), respectively embed
> hung_up_tty_{read,write,poll,ioctl,compat_ioctl}() right before
> tty_paranoia_check().
> 
> Regarding tty_fasync(), embed hung_up_tty_fasync() right before tty_lock()
> in tty_fasync() rather than tty_paranoia_check() in __tty_fasync(), for
> tty_hung_up_p() is checked right after tty_lock() returned.
> 
> Since tty_read() is called via file->f_op->read_iter() from
> call_read_iter() from generic_file_splice_read(), no change is needed for
> tty_fops->splice_read.
> 
> Since tty_write() is called via file->f_op->write_iter() from
> call_write_iter() from do_iter_readv_writev() from do_iter_write() from
> vfs_iter_write() from iter_file_splice_write(), no change is needed for
> tty_fops->splice_write.
> 
> Since both tty_fops and hung_up_tty_fops point to the same callback for
> llseek/release, no change is needed for tty_fops->{llseek,release}.
> 
> Finally, remove hung_up_tty_fops.
> 
> Reported-by: syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>
> Link: https://syzkaller.appspot.com/bug?extid=b7c3ba8cdc2f6cf83c21
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> ---
>  drivers/tty/tty_io.c | 37 ++++++++++++++++++-------------------
>  include/linux/tty.h  |  1 +
>  2 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 36fb945fdad4..c1748e4da233 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -182,7 +182,7 @@ int tty_alloc_file(struct file *file)
>  {
>  	struct tty_file_private *priv;
>  
> -	priv = kmalloc(sizeof(*priv), GFP_KERNEL);
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
>  
> @@ -491,17 +491,6 @@ static const struct file_operations console_fops = {
>  	.fasync		= tty_fasync,
>  };
>  
> -static const struct file_operations hung_up_tty_fops = {
> -	.llseek		= no_llseek,
> -	.read_iter	= hung_up_tty_read,
> -	.write_iter	= hung_up_tty_write,
> -	.poll		= hung_up_tty_poll,
> -	.unlocked_ioctl	= hung_up_tty_ioctl,
> -	.compat_ioctl	= hung_up_tty_compat_ioctl,
> -	.release	= tty_release,
> -	.fasync		= hung_up_tty_fasync,
> -};
> -
>  static DEFINE_SPINLOCK(redirect_lock);
>  static struct file *redirect;
>  
> @@ -619,7 +608,8 @@ static void __tty_hangup(struct tty_struct *tty, int exit_session)
>  			continue;
>  		closecount++;
>  		__tty_fasync(-1, filp, 0);	/* can't block */
> -		filp->f_op = &hung_up_tty_fops;
> +		/* Accept race with tty_hung_up_p() test. */
> +		data_race(priv->hung = true);
>  	}
>  	spin_unlock(&tty->files_lock);
>  
> @@ -743,7 +733,9 @@ void tty_vhangup_session(struct tty_struct *tty)
>   */
>  int tty_hung_up_p(struct file *filp)
>  {
> -	return (filp && filp->f_op == &hung_up_tty_fops);
> +	return filp && filp->f_op == &tty_fops &&
> +		/* Accept race with __tty_hangup(). */
> +		data_race(((struct tty_file_private *) filp->private_data)->hung);
>  }
>  EXPORT_SYMBOL(tty_hung_up_p);
>  
> @@ -911,6 +903,8 @@ static ssize_t tty_read(struct kiocb *iocb, struct iov_iter *to)
>  	struct tty_struct *tty = file_tty(file);
>  	struct tty_ldisc *ld;
>  
> +	if (tty_hung_up_p(file))
> +		return hung_up_tty_read(iocb, to);
>  	if (tty_paranoia_check(tty, inode, "tty_read"))
>  		return -EIO;
>  	if (!tty || tty_io_error(tty))
> @@ -1073,6 +1067,8 @@ static ssize_t file_tty_write(struct file *file, struct kiocb *iocb, struct iov_
>  	struct tty_ldisc *ld;
>  	ssize_t ret;
>  
> +	if (tty_hung_up_p(file))
> +		return hung_up_tty_write(iocb, from);
>  	if (tty_paranoia_check(tty, file_inode(file), "tty_write"))
>  		return -EIO;
>  	if (!tty || !tty->ops->write ||	tty_io_error(tty))
> @@ -2159,11 +2155,6 @@ static int tty_open(struct inode *inode, struct file *filp)
>  			return retval;
>  
>  		schedule();
> -		/*
> -		 * Need to reset f_op in case a hangup happened.
> -		 */
> -		if (tty_hung_up_p(filp))
> -			filp->f_op = &tty_fops;
>  		goto retry_open;
>  	}
>  	clear_bit(TTY_HUPPED, &tty->flags);
> @@ -2197,6 +2188,8 @@ static __poll_t tty_poll(struct file *filp, poll_table *wait)
>  	struct tty_ldisc *ld;
>  	__poll_t ret = 0;
>  
> +	if (tty_hung_up_p(filp))
> +		return hung_up_tty_poll(filp, wait);
>  	if (tty_paranoia_check(tty, file_inode(filp), "tty_poll"))
>  		return 0;
>  
> @@ -2249,6 +2242,8 @@ static int tty_fasync(int fd, struct file *filp, int on)
>  	struct tty_struct *tty = file_tty(filp);
>  	int retval = -ENOTTY;
>  
> +	if (tty_hung_up_p(filp))
> +		return hung_up_tty_fasync(fd, filp, on);
>  	tty_lock(tty);
>  	if (!tty_hung_up_p(filp))
>  		retval = __tty_fasync(fd, filp, on);
> @@ -2658,6 +2653,8 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  	int retval;
>  	struct tty_ldisc *ld;
>  
> +	if (tty_hung_up_p(file))
> +		return hung_up_tty_ioctl(file, cmd, arg);
>  	if (tty_paranoia_check(tty, file_inode(file), "tty_ioctl"))
>  		return -EINVAL;
>  
> @@ -2943,6 +2940,8 @@ static long tty_compat_ioctl(struct file *file, unsigned int cmd,
>  		return tty_ioctl(file, cmd, arg);
>  	}
>  
> +	if (tty_hung_up_p(file))
> +		return hung_up_tty_compat_ioctl(file, cmd, arg);
>  	if (tty_paranoia_check(tty, file_inode(file), "tty_ioctl"))
>  		return -EINVAL;
>  
> diff --git a/include/linux/tty.h b/include/linux/tty.h
> index 093935e97f42..d7fa18f8c526 100644
> --- a/include/linux/tty.h
> +++ b/include/linux/tty.h
> @@ -255,6 +255,7 @@ struct tty_file_private {
>  	struct tty_struct *tty;
>  	struct file *file;
>  	struct list_head list;
> +	bool hung;
>  };
>  
>  /**
> -- 
> 2.34.1
> 

I see this change has shown up in -next as commit 4c87e9e5479b ("tty:
tty_io: remove hung_up_tty_fops"), where it causes the following warning
for configurations without CONFIG_COMPAT (I used ARCH=arm defconfig):

  drivers/tty/tty_io.c:446:13: warning: 'hung_up_tty_compat_ioctl' defined but not used [-Wunused-function]
    446 | static long hung_up_tty_compat_ioctl(struct file *file,
        |             ^~~~~~~~~~~~~~~~~~~~~~~~

I am not sure if you just added that patch for additional test coverage
or for final acceptance but the following diff resolves this warning for
me, perhaps it can be folded in for a v2?

Cheers,
Nathan

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 553182753098..9588ee356646 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -443,12 +443,6 @@ static long hung_up_tty_ioctl(struct file *file, unsigned int cmd,
 	return cmd == TIOCSPGRP ? -ENOTTY : -EIO;
 }
 
-static long hung_up_tty_compat_ioctl(struct file *file,
-				     unsigned int cmd, unsigned long arg)
-{
-	return cmd == TIOCSPGRP ? -ENOTTY : -EIO;
-}
-
 static int hung_up_tty_fasync(int fd, struct file *file, int on)
 {
 	return -ENOTTY;
@@ -2812,6 +2806,12 @@ struct serial_struct32 {
 	compat_int_t    reserved;
 };
 
+static long hung_up_tty_compat_ioctl(struct file *file,
+				     unsigned int cmd, unsigned long arg)
+{
+	return cmd == TIOCSPGRP ? -ENOTTY : -EIO;
+}
+
 static int compat_tty_tiocsserial(struct tty_struct *tty,
 		struct serial_struct32 __user *ss)
 {
