Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E08A715C1B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjE3KpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjE3Kop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:44:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B6FA0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:44:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8F88622A8
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1130C433EF;
        Tue, 30 May 2023 10:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685443483;
        bh=eBfJFF8pHhTp0zUU+YGUkJo5Dl+10aig4PUWD4yKQFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Owo8nkSbEgoBnnIMZ8WARtZza41Xv1ajh2YQ9/m+0gzWp+kG4k8NrlFGWfpQr9Ejp
         RYoQoHjHWUXjRQGYUiMhqutRYbeyS+9sdDrFezGFGXMqqiZBF3KUbwv6JeqiK2Y2St
         aEqpmQkkhbIQG/J48ci82VGtAF3uzoPKwaqKJ6nI=
Date:   Tue, 30 May 2023 11:44:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2] tty: tty_io: remove hung_up_tty_fops
Message-ID: <2023053005-alongside-unvisited-d9af@gregkh>
References: <6ff6fdea-c955-f9dd-289e-b0d613a28280@I-love.SAKURA.ne.jp>
 <20230423233433.GF3390869@ZenIV>
 <e1fe6a44-3021-62ad-690a-69146e39e1ac@I-love.SAKURA.ne.jp>
 <20230424004431.GG3390869@ZenIV>
 <8e21256a-736e-4c2d-1ff4-723775bcac46@I-love.SAKURA.ne.jp>
 <2fca7932-5030-32c3-dd61-48dd78e58e11@I-love.SAKURA.ne.jp>
 <20230425160344.GS3390869@ZenIV>
 <1b405689-ea0a-6696-6709-d372ce72d68c@I-love.SAKURA.ne.jp>
 <5cebade5-0aa9-506c-c817-7bcf098eba89@I-love.SAKURA.ne.jp>
 <c95c62ba-4f47-b499-623b-05627a81c601@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c95c62ba-4f47-b499-623b-05627a81c601@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2023 at 10:02:26AM +0900, Tetsuo Handa wrote:
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
>                                         }
>   }
> 
> If we care about only NULL pointer dereference, implementing missing
> callbacks to hung_up_tty_fops is fine. But if we also care about KCSAN
> reports, we will need to wrap all filp->f_op usages which are reachable
> via tty_fops callbacks using data_race().

I'm missing something here.  Why would KCSAN report problems if we
implement the needed callbacks in hung_up_tty_fops?  And what reports
would they be?

And why would data_race() help here?


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
> Finally, remove hung_up_tty_fops and mark callbacks used by
> hung_up_tty_fops as "inline".
> 
> Reported-by: syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=b7c3ba8cdc2f6cf83c21
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> ---
> Changes in v2:
>   Mark callbacks used by hung_up_tty_fops as "inline" in order to fix
>   -Wunused-function warning when CONFIG_COMPAT=n, reported by
>   Nathan Chancellor <nathan@kernel.org> and Arnd Bergmann <arnd@kernel.org>.
> 
>  drivers/tty/tty_io.c | 49 ++++++++++++++++++++++----------------------
>  include/linux/tty.h  |  1 +
>  2 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index c84be40fb8df..bff0a2ffa68f 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -182,7 +182,7 @@ int tty_alloc_file(struct file *file)
>  {
>  	struct tty_file_private *priv;
>  
> -	priv = kmalloc(sizeof(*priv), GFP_KERNEL);
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);

Why is this zeroing out everything now?  Just because you added one
bool?  Why not just set the bool properly instead?

>  	if (!priv)
>  		return -ENOMEM;
>  
> @@ -421,35 +421,35 @@ struct tty_driver *tty_find_polling_driver(char *name, int *line)
>  EXPORT_SYMBOL_GPL(tty_find_polling_driver);
>  #endif
>  
> -static ssize_t hung_up_tty_read(struct kiocb *iocb, struct iov_iter *to)
> +static inline ssize_t hung_up_tty_read(struct kiocb *iocb, struct iov_iter *to)
>  {
>  	return 0;
>  }
>  
> -static ssize_t hung_up_tty_write(struct kiocb *iocb, struct iov_iter *from)
> +static inline ssize_t hung_up_tty_write(struct kiocb *iocb, struct iov_iter *from)
>  {
>  	return -EIO;
>  }
>  
>  /* No kernel lock held - none needed ;) */
> -static __poll_t hung_up_tty_poll(struct file *filp, poll_table *wait)
> +static inline __poll_t hung_up_tty_poll(struct file *filp, poll_table *wait)
>  {
>  	return EPOLLIN | EPOLLOUT | EPOLLERR | EPOLLHUP | EPOLLRDNORM | EPOLLWRNORM;
>  }
>  
> -static long hung_up_tty_ioctl(struct file *file, unsigned int cmd,
> +static inline long hung_up_tty_ioctl(struct file *file, unsigned int cmd,
>  		unsigned long arg)
>  {
>  	return cmd == TIOCSPGRP ? -ENOTTY : -EIO;
>  }
>  
> -static long hung_up_tty_compat_ioctl(struct file *file,
> +static inline long hung_up_tty_compat_ioctl(struct file *file,
>  				     unsigned int cmd, unsigned long arg)
>  {
>  	return cmd == TIOCSPGRP ? -ENOTTY : -EIO;
>  }

Marking these as inline, and then treating them as a function pointer,
seems like a horrid way to work around a compiler warning.  As they
really are not inline functions anymore, but yet the compiler doesn't
know that.  Odds are once the compiler gets smarter, the warnings will
return, so please, solve this properly.


>  
> -static int hung_up_tty_fasync(int fd, struct file *file, int on)
> +static inline int hung_up_tty_fasync(int fd, struct file *file, int on)
>  {
>  	return -ENOTTY;
>  }
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

Why accept it?  Say why it's not really an issue here.

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

Same here.

>  }
>  EXPORT_SYMBOL(tty_hung_up_p);
>  
> @@ -911,6 +903,8 @@ static ssize_t tty_read(struct kiocb *iocb, struct iov_iter *to)
>  	struct tty_struct *tty = file_tty(file);
>  	struct tty_ldisc *ld;
>  
> +	if (tty_hung_up_p(file))
> +		return hung_up_tty_read(iocb, to);

What happens if you hang up _right_ after this check?  There's no
locking here, right?  Same everywhere else you have this pattern, you
made the race window smaller, but it's still there from what I can see.

> --- a/include/linux/tty.h
> +++ b/include/linux/tty.h
> @@ -255,6 +255,7 @@ struct tty_file_private {
>  	struct tty_struct *tty;
>  	struct file *file;
>  	struct list_head list;
> +	bool hung;

No hint as to what "hung" means here?

thanks,

greg k-h
