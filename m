Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C599270E2FE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238011AbjEWRHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbjEWRHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:07:24 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6957418C
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:07:19 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f600a6a890so4225e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684861638; x=1687453638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHdfMZv0cy22FLane8ijEboUT+kVjbL/DCDppADKX+k=;
        b=0grIKoLCQ1KOkzxXNQQcTiRdILG1UZHFa44FWGwoPciSkfblNsR9BngCSr/4SsspVN
         Ow5Na28xe6jkBR4eQUWliJUf4ayw2x+wKW4jUydglJ0ybRUK0UVJsOfm8ai0XpG56eaJ
         adC7VuahPtsUuh668ZqeL96i42QjQ5YY8wtlvocUrs2eqAuE5O/ZIXdfJbmXpfyVzXTQ
         REwGx1vCgYxWf8o2Uf+C+eurWXc0401I8BY1u9X9c/SkwcP2NHPhVBnROt11OXWK/RuB
         4VDOfv4Mz82SJLwDg6AfcPDU+u648WMpG9F1z6lnxpd4g8OPmqdMhEAoxvjNJo759r+G
         XPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684861638; x=1687453638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHdfMZv0cy22FLane8ijEboUT+kVjbL/DCDppADKX+k=;
        b=LPPjYRVFKeX/ciFWHgphg+4lTIBEoc/DvTxIGGTV4GsSEWUxUbvKryOilXl7NO7aaf
         veYJhQYB9TgOGNGiHknI+C+OpJ64Au5Hxc1+qL+dWWUaaAK/rO+f4PCvEwR6rdR+IrCv
         Wg4cRNGt8gotfs9GQYivb2+ULxJ+UlM352YVPMwkw3/tvn9VUdNWAHt1zZnhlttYkq9G
         Xh+w9WB/wpjnpGbo82BwjIiMseQprcIOMiN8jjOxiphX/3WS74vWkYc/HLRkChqGUNw4
         8fiB1t3awQXTvwmQzUN9llBHODU3Fx5RRnQsVTa7u3SoJRuvbsXy8K1GXyfktLDqwQ/h
         Ax2A==
X-Gm-Message-State: AC+VfDyr4UKejgQQoi7+HSY6qvZ4uWH+PFQX1tWLAGitZlVxkHaRLSFp
        0ak0JU3pd2CM3afzGWLI7KzLxmMJ2/KfpvivQQUMQA==
X-Google-Smtp-Source: ACHHUZ5Js64aJk0ljsRBYPJmgK9djtmA1ZUniVrphpU59gCR5nDmOPv+1UdBUgInscfNur8wGv5eVd5TyYXEDbVbjeM=
X-Received: by 2002:a05:600c:4309:b0:3f1:9396:6fbf with SMTP id
 p9-20020a05600c430900b003f193966fbfmr2569wme.4.1684861637622; Tue, 23 May
 2023 10:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c0b11d05fa917fe3@google.com> <ZGzfzEs-vJcZAySI@zx2c4.com>
 <20230523090512.19ca60b6@kernel.org> <CANn89iLVSiO1o1C-P30_3i19Ci8W1jQk9mr-_OMsQ4tS8Nq2dg@mail.gmail.com>
 <20230523094108.0c624d47@kernel.org> <CAHmME9obRJPrjiJE95JZug0r6NUwrwwWib+=LO4jiQf-y2m+Vg@mail.gmail.com>
 <20230523094736.3a9f6f8c@kernel.org> <ZGzxa18w-v8Dsy5D@zx2c4.com> <CANn89iLrP7-NbE1yU_okruVKqbuUc3gxPABq4-vQ4SKrUhEdtA@mail.gmail.com>
In-Reply-To: <CANn89iLrP7-NbE1yU_okruVKqbuUc3gxPABq4-vQ4SKrUhEdtA@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 23 May 2023 19:07:05 +0200
Message-ID: <CANn89iKEjb-g1ed2M+VS5avSs=M0gNgH9QWXtOQRM_uDTMCwPw@mail.gmail.com>
Subject: Re: [syzbot] [wireguard?] KASAN: slab-use-after-free Write in enqueue_timer
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
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

On Tue, May 23, 2023 at 7:05=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, May 23, 2023 at 7:01=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4.c=
om> wrote:
> >
> > On Tue, May 23, 2023 at 09:47:36AM -0700, Jakub Kicinski wrote:
> > > On Tue, 23 May 2023 18:42:53 +0200 Jason A. Donenfeld wrote:
> > > > > It should, no idea why it isn't. Looking thru the code now I don'=
t see
> > > > > any obvious gaps where timer object is on a list but not active :=
S
> > > > > There's no way to get a vmcore from syzbot, right? :)
> > > > >
> > > > > Also I thought the shutdown leads to a warning when someone tries=
 to
> > > > > schedule the dead timer but in fact add_timer() just exits cleanl=
y.
> > > > > So the shutdown won't help us find the culprit :(
> > > >
> > > > Worth noting that it could also be caused by adding to a dead timer
> > > > anywhere in priv_data of another netdev, not just the sole timer_li=
st
> > > > in net_device.
> > >
> > > Oh, I thought you zero'ed in on the watchdog based on offsets.
> > > Still, object debug should track all timers in the slab and complain
> > > on the free path.
> >
> > No, I mentioned watchdog because it's the only timer_list in struct
> > net_device.
> >
> > Offset analysis is an interesting idea though. Look at this:
> >
> > > The buggy address belongs to the object at ffff88801ecc0000
> > >  which belongs to the cache kmalloc-cg-8k of size 8192
> > > The buggy address is located 5376 bytes inside of
> > >  freed 8192-byte region [ffff88801ecc0000, ffff88801ecc2000)
> >
> > IDA says that for syzkaller's vmlinux, net_device has a size of 0xc80
> > and wg_device has a size of 0x880. 0xc80+0x880=3D5376. Coincidence that
> > the address offset is just after what wg uses?
>
>
> Note that the syzkaller report mentioned:
>
> alloc_netdev_mqs+0x89/0xf30 net/core/dev.c:10626
>  usbnet_probe+0x196/0x2770 drivers/net/usb/usbnet.c:1698
>  usb_probe_interface+0x5c4/0xb00 drivers/usb/core/driver.c:396
>  really_probe+0x294/0xc30 drivers/base/dd.c:658
>  __driver_probe_device+0x1a2/0x3d0 drivers/base/dd.c:800
>  driver_probe_device+0x50/0x420 drivers/base/dd.c:830
>  __device_attach_driver+0x2d3/0x520 drivers/base/dd.c:958
>
> So maybe an usbnet driver has a timer_list in its priv_data.

struct usbnet {
...
struct timer_list   delay;
