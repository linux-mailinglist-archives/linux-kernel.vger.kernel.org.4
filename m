Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDC470E180
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbjEWQMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjEWQMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:12:47 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55201C5
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:12:46 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f601283b36so78435e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684858365; x=1687450365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaxUKyg3v1/DSFjf0841AVoJq3Sn1coPOkjz1YC43Z4=;
        b=Z1X68jQ8pbOqXQ4QyOHCAPfRTV775BHHx3nsfFJT8EUCEyGlKrigBV/UkJnGOW8B8L
         RkYji1dMJMEvI8hm9lZ4I2FO1KXB5mcHRi7ciV/rTRKoOtWwauyl7zIFz91yMhSwotSa
         dKFCCiLKtgbD5oNBho1Z9nrv38v7/trV6tBM9y2WJ+qcA91Y2DK15a2xdLd5J5z327GX
         WvgUoYMqP2/Tvy/ZMP5kuJgp0qndIvfViUz6YesOkN6uAPCf74LVzBmo8tS+2bFfr7GT
         qCP0W/5FQ9MWPiwLrfvkgeoUZJ7uXGo5PKi1KkfZX1Lro5VAaZ8UOfXqHF7qiVLqELi1
         /5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684858365; x=1687450365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaxUKyg3v1/DSFjf0841AVoJq3Sn1coPOkjz1YC43Z4=;
        b=YA4+rnmTrEuHDvKgeQj70rVF32EM4TnkcTHTnlqUI9iViWSnhCzIyj8EcIrMP4tXKw
         Q6gju+57oN8BKPU3ACJcDAaaSN6VWOxeuQQueTX73og5DO9JPqhsKBLSgKgA69ZfnEFr
         meV/eTNbfaJgSX4EXITkhMjHQeEBa+cI27Xzbo+Xv+Y+9KzEPD8+sV8aZ9dBrKBf2ppq
         gfg+1+mw6NnL90zTWzXGJhMtb+TgPGnNbk/19889fYSaE2PH8n9ciivgMHpcV1XxNLFg
         8Mvwv3ioiVJIwQhdZSpj5VnxvPiPsnCDtF2ftgIWk1lqzRuBjxtS9IbABqFTsAlWN4w6
         OHHw==
X-Gm-Message-State: AC+VfDxLAch0NDVDGXZ7I05uD4PW+ymKz/uLBAmtjxs4dpwp8tVt2lCS
        /ZaA4m2KnpMEFRbtzKuVBgOUzI3oX4otlsuUSteMgA==
X-Google-Smtp-Source: ACHHUZ6mdACrMdiMkBTkvWwsn3GCnAXCe77uBaiXeBW+mTRxG9hLE6RqSOFIaYMNdc3rHW/q8NissBtSpV+G/2JUyXQ=
X-Received: by 2002:a05:600c:6023:b0:3f3:3855:c5d8 with SMTP id
 az35-20020a05600c602300b003f33855c5d8mr235463wmb.6.1684858364620; Tue, 23 May
 2023 09:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c0b11d05fa917fe3@google.com> <ZGzfzEs-vJcZAySI@zx2c4.com>
 <20230523090512.19ca60b6@kernel.org>
In-Reply-To: <20230523090512.19ca60b6@kernel.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 23 May 2023 18:12:32 +0200
Message-ID: <CANn89iLVSiO1o1C-P30_3i19Ci8W1jQk9mr-_OMsQ4tS8Nq2dg@mail.gmail.com>
Subject: Re: [syzbot] [wireguard?] KASAN: slab-use-after-free Write in enqueue_timer
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        syzbot <syzbot+c2775460db0e1c70018e@syzkaller.appspotmail.com>,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        pabeni@redhat.com, wireguard@lists.zx2c4.com, jann@thejh.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 6:05=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 23 May 2023 17:46:20 +0200 Jason A. Donenfeld wrote:
> > > Freed by task 41:
> > >  __kmem_cache_free+0x264/0x3c0 mm/slub.c:3799
> > >  device_release+0x95/0x1c0
> > >  kobject_cleanup lib/kobject.c:683 [inline]
> > >  kobject_release lib/kobject.c:714 [inline]
> > >  kref_put include/linux/kref.h:65 [inline]
> > >  kobject_put+0x228/0x470 lib/kobject.c:731
> > >  netdev_run_todo+0xe5a/0xf50 net/core/dev.c:10400
> >
> > So that means the memory in question is actually the one that's
> > allocated and freed by the networking stack. Specifically, dev.c:10626
> > is allocating a struct net_device with a trailing struct wg_device (its
> > priv_data). However, wg_device does not have any struct timer_lists in
> > it, and I don't see how net_device's watchdog_timer would be related to
> > the stacktrace which is clearly operating over a wg_peer timer.
> >
> > So what on earth is going on here?
>
> Your timer had the pleasure of getting queued _after_ a dead watchdog
> timer, no? IOW it tries to update the ->next pointer of a queued
> watchdog timer. We should probably do:
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 374d38fb8b9d..f3ed20ebcf5a 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10389,6 +10389,8 @@ void netdev_run_todo(void)
>                 WARN_ON(rcu_access_pointer(dev->ip_ptr));
>                 WARN_ON(rcu_access_pointer(dev->ip6_ptr));
>
> +               WARN_ON(timer_shutdown_sync(&dev->watchdog_timer));
> +
>                 if (dev->priv_destructor)
>                         dev->priv_destructor(dev);
>                 if (dev->needs_free_netdev)
>
> to catch how that watchdog_timer is getting queued. Would that make
> sense, Eric?

Would this case be catched at the time the device is freed ?

(CONFIG_DEBUG_OBJECTS_FREE=3Dy or something)
