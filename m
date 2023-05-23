Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31EA70E21E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjEWQlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEWQlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:41:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FDEC2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:41:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E03961AF2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 16:41:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BE6C433EF;
        Tue, 23 May 2023 16:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684860069;
        bh=99tQwGA2fivyaV7yBZi/QCxkc1ZXrPn5AFuiF2mq8rg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WCr6pmi8qFTvA9PzUaQCujXU10uw4JCyzTKklseMJ6rM1cpkexU/37RFwEj3m8IO1
         vuHCtztHI3Yyrhp/TPATmpzc+lPAYW0+RFFjKeJapxrje56uSOB6Mi4RPvHOz0rSxl
         pGiLYHYyJ3UDYg6j6+ymGz3L177PLcUb/dcEP1FyBn9GNKG2qYC4Zf7Q0AYXbgXM6N
         R1AQrN3mCqPQY5MV+4NVt+CCfHNKsocqU6nNJ+dmzcBRj8fQsjQayGKhVLnkS49LFi
         XcADI5btRA3/gN3IuwOD4H8Yk+a+UG++lKvhr6kdyqsfzTltXkXEuet5M24U4LrpBi
         pMpb+bp4AYxlQ==
Date:   Tue, 23 May 2023 09:41:08 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        syzbot <syzbot+c2775460db0e1c70018e@syzkaller.appspotmail.com>,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        pabeni@redhat.com, wireguard@lists.zx2c4.com, jann@thejh.net
Subject: Re: [syzbot] [wireguard?] KASAN: slab-use-after-free Write in
 enqueue_timer
Message-ID: <20230523094108.0c624d47@kernel.org>
In-Reply-To: <CANn89iLVSiO1o1C-P30_3i19Ci8W1jQk9mr-_OMsQ4tS8Nq2dg@mail.gmail.com>
References: <000000000000c0b11d05fa917fe3@google.com>
        <ZGzfzEs-vJcZAySI@zx2c4.com>
        <20230523090512.19ca60b6@kernel.org>
        <CANn89iLVSiO1o1C-P30_3i19Ci8W1jQk9mr-_OMsQ4tS8Nq2dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 18:12:32 +0200 Eric Dumazet wrote:
> > Your timer had the pleasure of getting queued _after_ a dead watchdog
> > timer, no? IOW it tries to update the ->next pointer of a queued
> > watchdog timer. We should probably do:
> >
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 374d38fb8b9d..f3ed20ebcf5a 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -10389,6 +10389,8 @@ void netdev_run_todo(void)
> >                 WARN_ON(rcu_access_pointer(dev->ip_ptr));
> >                 WARN_ON(rcu_access_pointer(dev->ip6_ptr));
> >
> > +               WARN_ON(timer_shutdown_sync(&dev->watchdog_timer));
> > +
> >                 if (dev->priv_destructor)
> >                         dev->priv_destructor(dev);
> >                 if (dev->needs_free_netdev)
> >
> > to catch how that watchdog_timer is getting queued. Would that make
> > sense, Eric?  
> 
> Would this case be catched at the time the device is freed ?
> 
> (CONFIG_DEBUG_OBJECTS_FREE=y or something)

It should, no idea why it isn't. Looking thru the code now I don't see
any obvious gaps where timer object is on a list but not active :S
There's no way to get a vmcore from syzbot, right? :)

Also I thought the shutdown leads to a warning when someone tries to
schedule the dead timer but in fact add_timer() just exits cleanly.
So the shutdown won't help us find the culprit :(
