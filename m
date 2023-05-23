Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F9770E246
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237748AbjEWQnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237742AbjEWQnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:43:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FABAE4C
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:43:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AA1660EC0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 16:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D02C4339B;
        Tue, 23 May 2023 16:43:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XPGWlRQB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1684860186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=asrvrrrgFQMawFCZ+bsqpGNa7mr0dgHaC2R+m4mleeY=;
        b=XPGWlRQBEoAnttTLA8JwX8ZdjQS9zdSV9QWsMtayOjHy0qCv4lNBahdNDThRX3kk9iRKaC
        SWagC/bDN8I7MFACPL0tThCHaPsiJZrhryihSR/4vW523/33ML860PpA60Nr+K+bYXDmQt
        Zhf/jjGZf33Xi2AzYtTodcmnsHWklNU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 70c7fd67 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 23 May 2023 16:43:06 +0000 (UTC)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-783f17f0a00so2430199241.2;
        Tue, 23 May 2023 09:43:06 -0700 (PDT)
X-Gm-Message-State: AC+VfDyRVuwHMD2qOHy9dhFWSpjwn5RyU9dREYtDzuUZ2lPUrbp8qhmH
        I6bxWgzhsWIw+xOCdspsokz87cs1C6gd6Y8Xjl4=
X-Google-Smtp-Source: ACHHUZ4oT9L31pW9wsbwLlrLmTAWZHoDjP2zg8TDuWsDgQ+d7LMofjUYh2Ra0Y77YPhB/pH9oRXCXjHHeVjhQeuI8zg=
X-Received: by 2002:a67:e912:0:b0:439:3f93:dabe with SMTP id
 c18-20020a67e912000000b004393f93dabemr2903351vso.22.1684860185045; Tue, 23
 May 2023 09:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c0b11d05fa917fe3@google.com> <ZGzfzEs-vJcZAySI@zx2c4.com>
 <20230523090512.19ca60b6@kernel.org> <CANn89iLVSiO1o1C-P30_3i19Ci8W1jQk9mr-_OMsQ4tS8Nq2dg@mail.gmail.com>
 <20230523094108.0c624d47@kernel.org>
In-Reply-To: <20230523094108.0c624d47@kernel.org>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 23 May 2023 18:42:53 +0200
X-Gmail-Original-Message-ID: <CAHmME9obRJPrjiJE95JZug0r6NUwrwwWib+=LO4jiQf-y2m+Vg@mail.gmail.com>
Message-ID: <CAHmME9obRJPrjiJE95JZug0r6NUwrwwWib+=LO4jiQf-y2m+Vg@mail.gmail.com>
Subject: Re: [syzbot] [wireguard?] KASAN: slab-use-after-free Write in enqueue_timer
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        syzbot <syzbot+c2775460db0e1c70018e@syzkaller.appspotmail.com>,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        pabeni@redhat.com, wireguard@lists.zx2c4.com, jann@thejh.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 6:41=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 23 May 2023 18:12:32 +0200 Eric Dumazet wrote:
> > > Your timer had the pleasure of getting queued _after_ a dead watchdog
> > > timer, no? IOW it tries to update the ->next pointer of a queued
> > > watchdog timer. We should probably do:
> > >
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index 374d38fb8b9d..f3ed20ebcf5a 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -10389,6 +10389,8 @@ void netdev_run_todo(void)
> > >                 WARN_ON(rcu_access_pointer(dev->ip_ptr));
> > >                 WARN_ON(rcu_access_pointer(dev->ip6_ptr));
> > >
> > > +               WARN_ON(timer_shutdown_sync(&dev->watchdog_timer));
> > > +
> > >                 if (dev->priv_destructor)
> > >                         dev->priv_destructor(dev);
> > >                 if (dev->needs_free_netdev)
> > >
> > > to catch how that watchdog_timer is getting queued. Would that make
> > > sense, Eric?
> >
> > Would this case be catched at the time the device is freed ?
> >
> > (CONFIG_DEBUG_OBJECTS_FREE=3Dy or something)
>
> It should, no idea why it isn't. Looking thru the code now I don't see
> any obvious gaps where timer object is on a list but not active :S
> There's no way to get a vmcore from syzbot, right? :)
>
> Also I thought the shutdown leads to a warning when someone tries to
> schedule the dead timer but in fact add_timer() just exits cleanly.
> So the shutdown won't help us find the culprit :(

Worth noting that it could also be caused by adding to a dead timer
anywhere in priv_data of another netdev, not just the sole timer_list
in net_device.
