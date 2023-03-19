Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295E06C0128
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 12:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjCSLy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 07:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjCSLy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 07:54:57 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975D423C71
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 04:54:22 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 4B58AC009; Sun, 19 Mar 2023 12:54:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1679226848; bh=hUkpQYX6FPbHROaRClNRBhcGdvpGKHhE07K6SZ+ej8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=4saFNJu/dyVz7/ZJ3AgtW1h+dpqdSN9pLzQT1bY58NJcHTilSbRgID+PJTEbJisVD
         I9AGsalDYB2C42ZajS592H1w11urO/ukTjRJy3oslqSjebp34K3AQScduQPMYlDbZb
         Hx5s/TIf8X3BTX3IMbZ3pN1XHgJZPaFkDghN1oKmqNtXXhT8P2tKw0wUFQJUy4Xw2U
         MPvtrtL52ibviQKPajtCGTpCX78uL9PimsJgUz6BKnPoWovfejZloHhlpJKsLQB7k2
         Gl/3RFXzDUQnmQCFlsudFetzJBvRfZXumREU4xes6dZRPPWKZVRrECN06T2VI4m0Pp
         csp1oZqEUFWyg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 8E85CC009;
        Sun, 19 Mar 2023 12:54:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1679226846; bh=hUkpQYX6FPbHROaRClNRBhcGdvpGKHhE07K6SZ+ej8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G+N8gE/osiXg9+nhDZhsyAVaGQPptayRIoxjsd8/+0dle2IuZzQ/xCNTWangClAgC
         Y8to+5J7Ii+/zoS+ft2xiMVBT5NaQY11okLnQk3CO928AnAi3grC2LGT9i6iQgqN2N
         VcTtynNyoNxYeHqTcpkqOamIAZLSyegNm/HRUsEu8mSlAiwEcbXaJmMTjw5s0Hqy6p
         DIUlpwZioJPKBhQPvHpG+vqqhSZbaULTaZZxXmfuVDhrJxu4Cu5dFTT/Q8v6ao7tDq
         juPuwzd5V38NWooVutcMqBEbjfOUcXCWXgkAPaI3pgAg49dtfZFWb96dcLX9b/DyWc
         EsLjHCh4JlNXw==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 2cc1ba83;
        Sun, 19 Mar 2023 11:54:01 +0000 (UTC)
Date:   Sun, 19 Mar 2023 20:53:46 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        linux-kernel@vger.kernel.org, Pengfei Xu <pengfei.xu@intel.com>,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [V9fs-developer] [PATCH 0/5] Take 3 at async RPCs and no longer
 looping forever on signals
Message-ID: <ZBb3ynXntaom/0hg@codewreck.org>
References: <20230211075023.137253-1-asmadeus@codewreck.org>
 <2973654.udxrvWzM6v@silver>
 <Y+q7vvc2Sek8d7wG@codewreck.org>
 <2526146.SOovFYVi4y@silver>
 <Y+ttlog6sth3vPHJ@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+ttlog6sth3vPHJ@codewreck.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's been a while but I didn't forget...

Dominique Martinet wrote on Tue, Feb 14, 2023 at 08:16:38PM +0900:
> > Yes, apparently it tries to write dirty pages of the mapped file and keeps
> > hanging there [fs/9p/vfs_inode_dotl.c:586]:
> 
> Yeah, it'd help to get the trace of the thread actually trying to do the
> IO, if it still exists.
> I had some hangs in the check that there are no flush in flight at some
> point, and I thought I fixed that, but I can't really see anywhere else
> that'd start hanging with this... it'll be clearer if I can reproduce.

I couldn't reproduce this one, but manually inspecting
p9_client_wait_flush again I noticed the wait_event_interruptible was
waiting on req->flushed_req->wq but looking at req->status in the
condition; that was an error.
Also, we have a ref on req->flushed_req but not on req, so
req->flushed_req wasn't safe.

I've changed the code to add a variable directly on req->flushed_req and
use it consistently, I'm not sure that's the problem you ran into but it
might help.
It's been a while but do you remember if that hang was consistently
happening on shutdown, or was it a one time thing?

Either way, I'd appreciate if you could try my 9p-test branch again:
https://github.com/martinetd/linux/commits/9p-test


With that said, I expect that p9_client_wait_req will cause hangs on
broken servers.
If connection drops hopefully the reqs will just be marked as error and
free the thread, but I can see syzbot complaining about yet another
thread stuck.. Well it's interruptible at least, and bails out on
ERESTARTSYS.


> Anyway, I found another bug, just running ./configure on a random project
> (picked coreutils tarball) fails with interrupted system call ?!

That other bug was weird, I could reproduce it reliably until I rebooted
the host because of an unrelated nfs bug on the host, and after reboot I
couldn't reproduce anymore.
I'll chalk it down to buggy host/weird happenstance, but something to
watch for if random EINTR happen again :/

-- 
Dominique
