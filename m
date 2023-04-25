Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FBF6EE538
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbjDYQD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbjDYQD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:03:57 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB9BCC29
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 09:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vpsVZkzTnab674ErX7AmTVbpF3JMqygDrThxln8tUuo=; b=YOOJolJWtANcPE7pVpHlzw9zb6
        nVpfTY+TukDP9j/iqQUKm3i5vYKB2lzKIaKqvZAWlBAmPw/JHO/Lh6lrYYEvnOVcjXAL4SDf6WHyL
        OArX2Jz5l5OHvvxcKgtdeuxO9raUL9YRc+Jdr95JrHRPuuihSq5KtamjGEULbV5hi+EgAbmfzH4JG
        Z70X7uoOaef/Z+A17hDkJHwTWFiA/I5RriHzh6aD3/4BwYwxgaKp10cJCMy4WYL0sAS3EoFhLMbEd
        Fo6AqHfIv2IXjkpg+C2j7SmC7i5E/rxIftMrZIKkK0ZwPNwEysFWN5lnbCHdid4LEg9fm2Li75w5L
        NMRgDRNA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1prL8r-00CSTD-01;
        Tue, 25 Apr 2023 16:03:45 +0000
Date:   Tue, 25 Apr 2023 17:03:44 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] KCSAN: data-race in __fput / __tty_hangup (4)
Message-ID: <20230425160344.GS3390869@ZenIV>
References: <00000000000013aaac05f9d44e7a@google.com>
 <CACT4Y+bj7jCOjGV5jCUPzN5zjgdHxRn9vkwQEBuPWVzMbMCnXw@mail.gmail.com>
 <6ff6fdea-c955-f9dd-289e-b0d613a28280@I-love.SAKURA.ne.jp>
 <20230423233433.GF3390869@ZenIV>
 <e1fe6a44-3021-62ad-690a-69146e39e1ac@I-love.SAKURA.ne.jp>
 <20230424004431.GG3390869@ZenIV>
 <8e21256a-736e-4c2d-1ff4-723775bcac46@I-love.SAKURA.ne.jp>
 <2fca7932-5030-32c3-dd61-48dd78e58e11@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fca7932-5030-32c3-dd61-48dd78e58e11@I-love.SAKURA.ne.jp>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 11:47:20PM +0900, Tetsuo Handa wrote:
> @@ -743,7 +733,8 @@ void tty_vhangup_session(struct tty_struct *tty)
>   */
>  int tty_hung_up_p(struct file *filp)
>  {
> -	return (filp && filp->f_op == &hung_up_tty_fops);
> +	/* Accept race with __tty_hangup(). */
> +	return filp && data_race(((struct tty_file_private *) filp->private_data)->hung);
>  }
>  EXPORT_SYMBOL(tty_hung_up_p);

Umm...  Are you sure we never call that for non-TTY files?  Seeing that
it's exported and all such...  For internal uses (tty_read(), etc.) the
check for file being NULL is pointless; for general-purpose primitive
we probably want to check ->f_op as well...

> @@ -2159,11 +2154,6 @@ static int tty_open(struct inode *inode, struct file *filp)
>  			return retval;
>  
>  		schedule();
> -		/*
> -		 * Need to reset f_op in case a hangup happened.
> -		 */
> -		if (tty_hung_up_p(filp))
> -			filp->f_op = &tty_fops;

That needs a comment in commit message - hangup indication doesn't
need to be reset here, since tty_release() has freed the entire thing
that used to hang off the ->private_data.

> I don't know what changes are required for tty_open() and tty_show_fdinfo().
> I assume that making no change for tty_show_fdinfo() is harmless.
> But how does "hung_up_tty_fops does not call tty_open()" affects here?

It doesn't - file->f_op->open() is only called once, and only on fresh
struct file.
