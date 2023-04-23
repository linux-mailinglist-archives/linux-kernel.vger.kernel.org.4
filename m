Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A742A6EBFDB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 16:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjDWOAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 10:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjDWOAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 10:00:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3C41FE3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 07:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 282EB61A27
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 14:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE32C433D2;
        Sun, 23 Apr 2023 14:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682258418;
        bh=rXa7qPtIZGglVvOdvfEFs+lsgsASMTAj/fjqzEcamoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0HBxJ96/rK7xfxinCXBvRC2dnxYjJbPapAoW/d0H5TAn22BFZCOUx2qcQhspeJ3BX
         HvW1yXodryz/7ob9AmU91FrPsC9aY3al0N3kQAL+hLgCC1mO8yNSUYBC75TmUUE2kG
         8Of4sljZePqney0NhN7AmkToZqb11f4oAMhtlrqw=
Date:   Sun, 23 Apr 2023 16:00:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] KCSAN: data-race in __fput / __tty_hangup (4)
Message-ID: <2023042342-nebula-hydrogen-baf4@gregkh>
References: <00000000000013aaac05f9d44e7a@google.com>
 <CACT4Y+bj7jCOjGV5jCUPzN5zjgdHxRn9vkwQEBuPWVzMbMCnXw@mail.gmail.com>
 <6bec279c-07b3-d6f1-0860-4d6b136a2025@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bec279c-07b3-d6f1-0860-4d6b136a2025@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23, 2023 at 10:28:58PM +0900, Tetsuo Handa wrote:
> On 2023/04/21 17:21, Dmitry Vyukov wrote:
> > On Fri, 21 Apr 2023 at 10:18, syzbot
> > <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com> wrote:
> >>
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    fcd476ea6a88 Merge tag 'urgent-rcu.2023.03.28a' of git://g..
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=146618b9c80000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=f7350c77b8056a38
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=b7c3ba8cdc2f6cf83c21
> >> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> >>
> >> Unfortunately, I don't have any reproducer for this issue yet.
> >>
> >> Downloadable assets:
> >> disk image: https://storage.googleapis.com/syzbot-assets/f3d8ce4faab0/disk-fcd476ea.raw.xz
> >> vmlinux: https://storage.googleapis.com/syzbot-assets/fc53d9dee279/vmlinux-fcd476ea.xz
> >> kernel image: https://storage.googleapis.com/syzbot-assets/22ad755d39b2/bzImage-fcd476ea.xz
> >>
> >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >> Reported-by: syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com
> > 
> > If I am reading this correctly, this race can lead to NULL derefs
> > among other things.
> > hung_up_tty_fops does not have splice_read, while other fops have.
> > 
> > So the following code in splice can execute NULL callback:
> > 
> > if (unlikely(!in->f_op->splice_read))
> >     return warn_unsupported(in, "read");
> > return in->f_op->splice_read(in, ppos, pipe, len, flags);
> 
> Hmm, it seems to me that we need multiple patches (which would become too big to
> backport) for fixing this bug.

Fix the bug properly first.  And then only start to worry about stable
kernels, don't let the existance of them affect your development efforts
at all please.

thanks,

greg k-h
