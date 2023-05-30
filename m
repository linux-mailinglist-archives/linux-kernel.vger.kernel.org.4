Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329AD71608A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjE3MwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbjE3MwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:52:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90AE114
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:51:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A07F62F9B
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 12:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F505C433A0;
        Tue, 30 May 2023 12:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685451068;
        bh=m8PuzIw3Q7jLtH3/tMkEUSU5ayOjdxZr0LDbkFUL2ew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tKDyikQorDN8CnVpQTukTJlyzgIfm+wpQ6vd4+7bXOEAeXXVtp9Y/7C1TLSIisflK
         DCbPvN8MbbGw9Q8k7/iyJRmFJcG7Q+6Dgu3WmmD9Fj4/TBgVUX1oLYaB6sjg++ZQ2P
         UQlN753e24uuXvUf7ZXr0tYhmzB71dVrYQtD9r1Y=
Date:   Tue, 30 May 2023 13:51:06 +0100
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
Message-ID: <2023053048-saved-undated-9adf@gregkh>
References: <e1fe6a44-3021-62ad-690a-69146e39e1ac@I-love.SAKURA.ne.jp>
 <20230424004431.GG3390869@ZenIV>
 <8e21256a-736e-4c2d-1ff4-723775bcac46@I-love.SAKURA.ne.jp>
 <2fca7932-5030-32c3-dd61-48dd78e58e11@I-love.SAKURA.ne.jp>
 <20230425160344.GS3390869@ZenIV>
 <1b405689-ea0a-6696-6709-d372ce72d68c@I-love.SAKURA.ne.jp>
 <5cebade5-0aa9-506c-c817-7bcf098eba89@I-love.SAKURA.ne.jp>
 <c95c62ba-4f47-b499-623b-05627a81c601@I-love.SAKURA.ne.jp>
 <2023053005-alongside-unvisited-d9af@gregkh>
 <8edbd558-a05f-c775-4d0c-09367e688682@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8edbd558-a05f-c775-4d0c-09367e688682@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 08:57:42PM +0900, Tetsuo Handa wrote:
> On 2023/05/30 19:44, Greg Kroah-Hartman wrote:
> > On Sun, May 14, 2023 at 10:02:26AM +0900, Tetsuo Handa wrote:
> >> If we care about only NULL pointer dereference, implementing missing
> >> callbacks to hung_up_tty_fops is fine. But if we also care about KCSAN
> >> reports, we will need to wrap all filp->f_op usages which are reachable
> >> via tty_fops callbacks using data_race().
> > 
> > I'm missing something here.  Why would KCSAN report problems if we
> > implement the needed callbacks in hung_up_tty_fops?  And what reports
> > would they be?
> 
> Unlike atomic operations such as atomic_read()/atomic_set(), normal read/write
> operations are not atomic for KCSAN. KCSAN reports some value being changed
> during a read/write.
> 
> In this report, KCSAN detected that __tty_hangup() changed the value of
> filp->f_op from 0xffffffff84e91ed0 to 0xffffffff84e91dc0 at
> 
>   filp->f_op = &hung_up_tty_fops;
> 
> line when __fput() was reading the value of filp->f_op at
> 
>   if (file->f_op->release)
> 
> line.
> 
> Even if we implement the needed callbacks in hung_up_tty_fops,
> KCSAN will continue reporting that the value of filp->f_op changes.

That sounds like a bug in KCSAN, let's not add loads of infrastructure
just because we have bad tools.

> > And why would data_race() help here?
> 
> data_race() tells KCSAN not to report.
> data_race() is used when the race KCSAN checks is harmless.

Again, document it, and also perhaps, not use KCSAN?  :)

> >> @@ -182,7 +182,7 @@ int tty_alloc_file(struct file *file)
> >>  {
> >>  	struct tty_file_private *priv;
> >>  
> >> -	priv = kmalloc(sizeof(*priv), GFP_KERNEL);
> >> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> > 
> > Why is this zeroing out everything now?  Just because you added one
> > bool?  Why not just set the bool properly instead?
> 
> Because I consider that this function is not performance critical where
> avoid increasing code size by zeroing out everything is acceptable.

It happens on open() which yes, is not performance critical, but you are
now requiring it where before this was not required.  Which isn't always
so obvious, right?

> >> @@ -911,6 +903,8 @@ static ssize_t tty_read(struct kiocb *iocb, struct iov_iter *to)
> >>  	struct tty_struct *tty = file_tty(file);
> >>  	struct tty_ldisc *ld;
> >>  
> >> +	if (tty_hung_up_p(file))
> >> +		return hung_up_tty_read(iocb, to);
> > 
> > What happens if you hang up _right_ after this check?  There's no
> > locking here, right?  Same everywhere else you have this pattern, you
> > made the race window smaller, but it's still there from what I can see.
> 
> We cannot close the race window without introducing locking,
> but we don't need to close the race window.
> 
> The race KCSAN found in this report is harmless, as long as callbacks
> reachable via filp->f_op does not disappear.

Which we can fix.  So let's fix that and then not worry about these
false-positives with KCSAN as it's obviously wrong.  That would make for
a much smaller and simpler and easier-to-maintain-over-time change.

Please do that instead.

> This patch prevents filp->f_op from suddenly disappearing callbacks,
> by not changing the value of filp->f_op.
> 
> 
> 
> >> @@ -255,6 +255,7 @@ struct tty_file_private {
> >>  	struct tty_struct *tty;
> >>  	struct file *file;
> >>  	struct list_head list;
> >> +	bool hung;
> > 
> > No hint as to what "hung" means here?
> 
> Whether __tty_hangup() was called or not.

How will you know this in 5 years when you see this new field?
Documentation matters.

thanks,

greg k-h
