Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96EB6D8748
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 21:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbjDETsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 15:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbjDETs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:48:26 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46887EDC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 12:48:08 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id l12so37293046wrm.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 12:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680724086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CU/wqXDquoM5iWh5fb3D/RMmrzIlHoB0ba0E3004b4=;
        b=eMRuS9EyVLJMDLwDK0g79KHNxCAnYRdZUPH4KiP38+XxFjvV4KeSHiVVA9CqQGpx00
         GrrHP7yJKxB9hnSG9ZHPLfljeqKbir7udiIqqqKPaLGaPI3lCBCT571TEFHU2CaROFOA
         Y0h239vruAnlPLQ50G/fyzHPvXjEalfpN625OqG6XPNnung2WMJk/wEMg2bXxr1rZ74m
         1dalar/zW9URBb19pFaIJCFkpzTQtxe9nsTAfm/Y1EFDvyksvoGvDBx0p+j3bWyoh0KW
         FJLlP6a31ZqaU/K3+g/4y82zvP6hty21Qnryel/86EFDPR9Lcq95e1Z+At2aU4WLPoLE
         oT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680724086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CU/wqXDquoM5iWh5fb3D/RMmrzIlHoB0ba0E3004b4=;
        b=pgNwVOEnshkHG1H5ECAblDSnRaiiio4vTu5tGi0EhPNOPwja9TBoEmXk6wYeBi/bZA
         TuLMeS8F5M1wQRa8NKnt/qqQS1CAwxF9VhMuAJo8fCLhvcsdUO8c5LzlxkbDTyq0kZXX
         RASxzZgxT/RFNGuRfjlr38/KqEg2T+v+iNKUEhmRvpFG8tdOb0bh+pxz6wRPPBfdPCMs
         ZiCPOdFlW//mNvnNNQADJZ+S1lcc6hL+d+kzLY9TVYT91G/mFYa65vNX5Xdv0xNcBytp
         TUz7NOX4DSrBqvqTwOGEtmJ24L2tvfCodLo/FeFuA2OKFU1uP8PMsbve4MFbM8UHrBq/
         Sf1w==
X-Gm-Message-State: AAQBX9f9rCE0Gd7ui2VztUsoh1bqC7KjwAmerdUe6Pgv8DkxBudj2q31
        Zapi5vvhsBDIJUalTwDCZwFHhYTKnIYXYUr/LM+l/g==
X-Google-Smtp-Source: AKy350aeaYHLJq/TU0Pt84k7DKQ9XA3V8glYD/ljox0u0btbqTyv19eQ+lB7J0ClP0EF6eaBfn7pd5ZJ6saf2+mYv3Y=
X-Received: by 2002:adf:fc41:0:b0:2ce:a5f8:b786 with SMTP id
 e1-20020adffc41000000b002cea5f8b786mr1381127wrs.12.1680724086448; Wed, 05 Apr
 2023 12:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <CANn89iKn4rpqj_8fYt0UMMgAq5L_2PNoY0Ev70ck8u4t4FC_=g@mail.gmail.com>
 <20230405194143.15708-1-kuniyu@amazon.com>
In-Reply-To: <20230405194143.15708-1-kuniyu@amazon.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 5 Apr 2023 21:47:54 +0200
Message-ID: <CANn89iJeHFb8VnFPUq4-d+jzAO6XKiSQhaPsPFY98wjH0Yx1Lw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in tcp_write_timer_handler
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     bpf@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, threeearcat@gmail.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 5, 2023 at 9:42=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> From:   Eric Dumazet <edumazet@google.com>
> Date:   Wed, 5 Apr 2023 13:28:16 +0200
> > On Wed, Apr 5, 2023 at 12:41=E2=80=AFPM Dae R. Jeong <threeearcat@gmail=
.com> wrote:
> > >
> > > Hi,
> > >
> > > We observed an issue "KASAN: use-after-free Read in tcp_write_timer_h=
andler" during fuzzing.
> > >
> > > Unfortunately, we have not found a reproducer for the crash yet. We
> > > will inform you if we have any update on this crash.  Detailed crash
> > > information is attached below.
> > >
> >
> > Thanks for the report.
> >
> > I have dozens of similar syzbot reports, with no repro.
> >
> > I usually hold them, because otherwise it is just noise to mailing list=
s.
> >
> > Normally, all user TCP sockets hold a reference on the netns
> >
> > In all these cases, we see a netns being dismantled while there is at
> > least one socket with a live timer.
> >
> > This is therefore a kernel TCP socket, for which we do not have yet
> > debugging infra ( REF_TRACKER )
> >
> > CONFIG_NET_DEV_REFCNT_TRACKER=3Dy is helping to detect too many dev_put=
(),
> > we need something tracking the "kernel sockets" as well.
>
> Maybe I missed something, but we track kernel sockets with netns
> by notrefcnt_tracker ?

Oh right, I forgot I did this already :)

commit 0cafd77dcd032d1687efaba5598cf07bce85997f
Author: Eric Dumazet <edumazet@google.com>
Date:   Thu Oct 20 23:20:18 2022 +0000

    net: add a refcount tracker for kernel sockets

Dae, make sure to not send reports based on old kernels.

Using 6.0-rc7 is a waste of your time, and everyone else reading this threa=
d.

I confess I did not check this, and I really should do that all the time.



>
> I thought now CONFIG_NET_NS_REFCNT_TRACKER can catch the case.
>
>
> >
> > Otherwise bugs in subsystems not properly dismantling their kernel
> > socket at netns dismantle are next to impossible to track and fix.
> >
> > If anyone has time to implement this, feel free to submit patches.
> >
> > Thanks.
