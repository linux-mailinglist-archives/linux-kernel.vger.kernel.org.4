Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E203770E3BB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237722AbjEWR3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237899AbjEWR3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:29:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F003DBF
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:29:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C919618CB
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 17:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA51C433D2;
        Tue, 23 May 2023 17:28:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CB+AWCXr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1684862936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bCbw3sck91JI8j5eCygSPRLzknR7AWXoCmQ+oX+qRr8=;
        b=CB+AWCXrDI9jvFQ6iye2JxcJfHeYEcwqnpevMWDiWz+jxcjEN7vy1iUyHaqzaKe+nhP0n/
        ISF9HZFmTdgNb4YX3JF/A9qziYTbkAidh4BSJl5O5m4NRabFgn57kEHsQW7jyRzLJ7l42e
        JElag0RgCKIywBjPzp8GHI++UMCe/4w=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cab93579 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 23 May 2023 17:28:56 +0000 (UTC)
Date:   Tue, 23 May 2023 19:28:54 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     edumazet@google.com,
        syzbot <syzbot+c2775460db0e1c70018e@syzkaller.appspotmail.com>,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        pabeni@redhat.com, wireguard@lists.zx2c4.com, jann@thejh.net
Subject: Re: [syzbot] [wireguard?] KASAN: slab-use-after-free Write in
 enqueue_timer
Message-ID: <ZGz31pkpzt3RVQDd@zx2c4.com>
References: <000000000000c0b11d05fa917fe3@google.com>
 <ZGzfzEs-vJcZAySI@zx2c4.com>
 <20230523090512.19ca60b6@kernel.org>
 <ZGzmWtd7itw6oFsI@zx2c4.com>
 <20230523094606.6f4f8f4f@kernel.org>
 <CAHmME9pEu2cvrSQd+Rg8Cp=KDfKEfjeiPPgF-WecXLHyRZVjcw@mail.gmail.com>
 <ZGz05BI29KBb2fdz@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZGz05BI29KBb2fdz@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 07:16:20PM +0200, Jason A. Donenfeld wrote:
> On Tue, May 23, 2023 at 06:47:41PM +0200, Jason A. Donenfeld wrote:
> > On Tue, May 23, 2023 at 6:46 PM Jakub Kicinski <kuba@kernel.org> wrote:
> > >
> > > On Tue, 23 May 2023 18:14:18 +0200 Jason A. Donenfeld wrote:
> > > > So, IOW, not a wireguard bug, right?
> > >
> > > What's slightly concerning is that there aren't any other timers
> > > leading to
> > >
> > >   KASAN: slab-use-after-free Write in enqueue_timer
> > >
> > > :( If WG was just an innocent bystander there should be, right?
> > 
> > Well, WG does mod this timer for every single packet in its RX path.
> > So that's bound to turn things up I suppose.
> 
> Here's one that is seemingly the same -- enqueuing a timer to a freed
> base -- with the allocation and free being the same netdev core
> function, but the UaF trigger for it is a JBD2 transaction thing:
> https://syzkaller.appspot.com/text?tag=CrashReport&x=17dd2446280000
> No WG at all in it, but there's still the mysterious 5376 value...

In this one, you see the free happens in some infiniband code.  Looking
at ipoib_dev_priv, and going to the member at net_device+ipoib_dev_priv,
we get this at 5320:

        struct delayed_work        neigh_reap_task;

5376-5320=56, which doesn't quite put us at the timer_list. Close but no
cigar?
