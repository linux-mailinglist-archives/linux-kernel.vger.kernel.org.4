Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7FA6EC32B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 01:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjDWXet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 19:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDWXer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 19:34:47 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2AEE40
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 16:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QboGlpLN/tOwaNeHOvW+vLuIImI/acGyqt4GZ8ZZTb8=; b=Yi0sWdHp36EbCKN34Ujm+aOCHo
        KePBQxMIodVW5+iiK30MqRkFtK4quhrD0l3MZ74Zjd/yjDXe4hVufuk7xP2COjt7fFFeXpgiWaOJn
        zMG+a5ciIVo6ezdBEMuIOoX8wm+zzx+7ETUFCsZvIIXh7v/ra7kd4l8bRsuT06XIBk1N+ifLsWKbN
        7FwsbOdn56BEYAjkbIdCa8bKTFCtrEFqCPaWvryPrP61BzD4ddsBOJ4ZcTcmSeFxrUsjBMPcmXb+G
        kKzPbi/atJP7UbxT/5jGw67QitMw9r1lKHNR4tU5+LUunL3ImAXv28nTG+DLblKkuvT3+ywbFKJLX
        54uan+XA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pqjE1-00Bwck-2w;
        Sun, 23 Apr 2023 23:34:34 +0000
Date:   Mon, 24 Apr 2023 00:34:33 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] KCSAN: data-race in __fput / __tty_hangup (4)
Message-ID: <20230423233433.GF3390869@ZenIV>
References: <00000000000013aaac05f9d44e7a@google.com>
 <CACT4Y+bj7jCOjGV5jCUPzN5zjgdHxRn9vkwQEBuPWVzMbMCnXw@mail.gmail.com>
 <6ff6fdea-c955-f9dd-289e-b0d613a28280@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ff6fdea-c955-f9dd-289e-b0d613a28280@I-love.SAKURA.ne.jp>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2023 at 12:12:02AM +0900, Tetsuo Handa wrote:
> On 2023/04/21 17:21, Dmitry Vyukov wrote:
> > If I am reading this correctly, this race can lead to NULL derefs
> > among other things.
> > hung_up_tty_fops does not have splice_read, while other fops have.
> > 
> > So the following code in splice can execute NULL callback:
> > 
> > if (unlikely(!in->f_op->splice_read))
> >     return warn_unsupported(in, "read");
> > return in->f_op->splice_read(in, ppos, pipe, len, flags);
> > 
> 
> __fput(file) is called when the last reference to file is released.
> Since __tty_hangup() traverses tty->tty_files under tty->files_lock,
> tty_add_file() needs to hold a ref before adding to tty->tty_files
> in order to defer concurrent __fput() by other threads?
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 36fb945fdad4..2838703d48cf 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -197,7 +197,7 @@ void tty_add_file(struct tty_struct *tty, struct file *file)
>  	struct tty_file_private *priv = file->private_data;
>  
>  	priv->tty = tty;
> -	priv->file = file;
> +	priv->file = get_file(file);

This is broken.  Simple open() + close() on a tty will leak the damn thing -
that extra reference will stick around, possibly all the way until reboot.

As for the original report - add a (failing) ->splice_read() in hung_ut_tty_fops
to deal with the original problem.
