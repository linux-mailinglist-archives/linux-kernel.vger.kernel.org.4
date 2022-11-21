Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76E5631800
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 01:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiKUAyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 19:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiKUAxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 19:53:51 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692AF6434
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 16:53:50 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id y83so3798653yby.6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 16:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TrR9tOTmmG1TbaSCSfozcLow+Bsm4fJxe0iyZV+9CFM=;
        b=TVrPTSt8r2Jz1zSMLgNF08MRtXIIMyyvA3bNcYvH08Ur1qf7Iu/FRV6nliKe7qjgpQ
         dIg5QR7vgbEnp2VmyOH37i1Fa1gUYKI06pOTYkDdpQ20bNT7zf87+0p2geLow62+XTaI
         b627XlsogwLBJKhDHfG3HSY3aqkquc773CFMROBvblJ85uSoKPsmu524wQ4lx2BhdNfp
         XdKqUJ6w0JzWkg5ZH0Feu2HALMF9cs1FAcVDZ6u4aIfan1gRJ7hm2bKc/hrA8KIWZ1UC
         4s88KuUUfWW6Uuqp/5s+bsEe02A0XdJ+/8loJzrJdvlH5ng5mOJzvg+IIxvNTPyXXDXw
         N75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TrR9tOTmmG1TbaSCSfozcLow+Bsm4fJxe0iyZV+9CFM=;
        b=4OaglgTSh+aAJHyvq0/1IM9u3g0uFbGMrs94v4nnZ0Nhd6+ClLBqZb0794yAuZ9fG9
         tPq6+EAhVxXA5Bz5YMPvIK9FS/S7mrOOfHqw5r9hfcoWvXCfvd/yae9jUR0cwaeq6aNl
         XJfnKFJ6NmhWCHnsdwVibdRKzIWyYr5c+MrJisM84yXNokPQYiBPy3Y+Is+WYQNvrKQs
         U4/H4a6nYjWt/a6vpjYVXPrmVzNvJUzYAztglB1Jg1cBw7ll8Q0AdVPX7Dr5MZgWAtL8
         4V49P4t7JM9MDt+M2KK7vulmiqxu8BpJgx7AhZLrgcs22NXt0vsITr+aPYy1VnknY6Nq
         MCOQ==
X-Gm-Message-State: ANoB5plmlrETNJOfCKsExoMhD8MfVFvbx++WcveVP8g0Z6HpNHkCHXKW
        04sDNWC/1qDMMK6EWAQBSglPbpIVmsg5e3PmUOMPcQ==
X-Google-Smtp-Source: AA0mqf6cSVccND9M5xJ5RTp71E2Ny3s2Nok8MgF/a1P3G908wQ59plabT92n3YUX4ro8/poXoubFdM3GH/Cg/PaFa5M=
X-Received: by 2002:a25:bcc6:0:b0:6dd:1c5c:5602 with SMTP id
 l6-20020a25bcc6000000b006dd1c5c5602mr15818415ybm.36.1668992029284; Sun, 20
 Nov 2022 16:53:49 -0800 (PST)
MIME-Version: 1.0
References: <20221120090213.922567-1-syoshida@redhat.com> <20221120104907.4795-1-hdanton@sina.com>
 <CANn89iJxiV_-g6n60aeA=mO=DYwGV9VdJswHP4pc-Vwq_UgrRA@mail.gmail.com> <20221121003404.4875-1-hdanton@sina.com>
In-Reply-To: <20221121003404.4875-1-hdanton@sina.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sun, 20 Nov 2022 16:53:38 -0800
Message-ID: <CANn89i+cmAAH8om3ET-478ZxPV4=t5nF0Ei+DCZOxND5=EqBLw@mail.gmail.com>
Subject: Re: [PATCH v2] net: tun: Fix use-after-free in tun_detach()
To:     Hillf Danton <hdanton@sina.com>
Cc:     Shigeru Yoshida <syoshida@redhat.com>, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot+106f9b687cd64ee70cd1@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2022 at 4:34 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On 20 Nov 2022 08:04:13 -0800 Eric Dumazet <edumazet@google.com>
> > On Sun, Nov 20, 2022 at 2:49 AM Hillf Danton <hdanton@sina.com> wrote:
> > > On 20 Nov 2022 18:02:13 +0900 Shigeru Yoshida <syoshida@redhat.com>
> > > >
> > > > This patch fixes the issue by calling sock_put() from tun_detach()
> > > > after all necessary accesses for the struct net has done.
> > >
> > > Thanks for your fix.
> > >
> > > But tun is not special wrt netdev_run_todo() and call_netdevice_notifiers(),
> > > so the correct fix should be making netdev grab another hold on net and
> > > invoking put_net() in the path of netdev_run_todo().
> >
> > Well, this is not going to work. Unless I am missing something.
>
> Thanks for taking a look.
>
> I mean bump up refcount for net when updating netdev->nd_net in a bid to
> make dev_net() safe throught netdev's life span.

This would prevent netns deletion, as the following sequence would
then no longer work as intended.

ip netns add foo
ip netns add ip link set lo up
ip netns del foo

When a netns is deleted ("ip netns del" and no more refcounted sockets),
we have callbacks to unregister all devices tied to it.
