Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE77A6E2E55
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 03:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjDOBzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 21:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDOBzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 21:55:43 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E934C0C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 18:55:42 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id p5-20020a17090a428500b002400d8a8d1dso8998598pjg.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 18:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681523741; x=1684115741;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wgg0kRJ3s4RNAMUV5romv+CLC/70n6mh2aOg/nYLnSo=;
        b=LL3Uiq0aMFuWs5pOQABjTo2pDdSvJzIV26S0d1tlTc1KwOPzxxjJLPifBH+8GgN7Wq
         RUbePsbhn5MxmjmzRspLksuwKIh40zw2Q2KqlzTvTI3Zp3vnLOTu27NaX2IL+RuKrtGb
         ZlX8puvvxlmqZm76Lekxr8LNulJlU2AZ9f5cpQF3DWPUJB6T8U2iVOY7YkL1CuJXff3h
         D0CJ6qON1pffWZlnygSlyw8bQLlOOrbnMz1tJiTJSkK4Y3EdF2aRQVOdGye4cYVmfyEK
         EQ6+i1KIK9xvl/40puWq+/TnZ8AGwWtgaWRIJsrNfd5IuQJEu81YgeuBHIJqinei+sbL
         TqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681523741; x=1684115741;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wgg0kRJ3s4RNAMUV5romv+CLC/70n6mh2aOg/nYLnSo=;
        b=E4+TYSJyuzbIEFWPLTN35MKNJ2buabSdpJmOQe7l47GtB0NgAMn+yoeHW4Wmze1BKt
         0qllwY2Id4TafuZyMWBzsG4xqGDCBRY3KHZis62ISFAwLezQvXA8fVYu2bpVuwSfKvAe
         OQs73UG+qoUYeytOJCZgkiblEx7OcYyUL/0UXmliecBx84lty2ttPBpIOYy9LUR6pN9N
         x2Vot2SnP31k+mzbaZmVUbFrecid9x4teQT3c61mmsZ5WEOm5rYr073bM7T+MeMd7ISN
         mB2t/ZYFWMxOF7FyH+5301vXg1orcs1/3e8jd0xVyuU7w63HtxHxUdvgX24dk4N4dMi7
         M8VQ==
X-Gm-Message-State: AAQBX9eUTW7PTh7nH1paOlspSI43OxuyCZW2rOALTndiCUmxxhZSrrqL
        WR/QWdSmTFHGP8hWJbPLLn+Tmqc=
X-Google-Smtp-Source: AKy350bXvYkqDduF6+mlorKT8pd0PbKxNmHZmWysx0GeSVuezBGd7BYrdATRQxgzXEDPxjpf3GQZfAY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a65:55cd:0:b0:514:3d3d:da5a with SMTP id
 k13-20020a6555cd000000b005143d3dda5amr1341981pgs.3.1681523741052; Fri, 14 Apr
 2023 18:55:41 -0700 (PDT)
Date:   Fri, 14 Apr 2023 18:55:39 -0700
In-Reply-To: <CAKH8qBt+xPygUVPMUuzbi1HCJuxc4gYOdU6JkrFmSouRQgoG6g@mail.gmail.com>
Mime-Version: 1.0
References: <20230413133355.350571-1-aleksandr.mikhalitsyn@canonical.com>
 <20230413133355.350571-3-aleksandr.mikhalitsyn@canonical.com>
 <CANn89iLuLkUvX-dDC=rJhtFcxjnVmfn_-crOevbQe+EjaEDGbg@mail.gmail.com>
 <CAEivzxcEhfLttf0VK=NmHdQxF7CRYXNm6NwUVx6jx=-u2k-T6w@mail.gmail.com> <CAKH8qBt+xPygUVPMUuzbi1HCJuxc4gYOdU6JkrFmSouRQgoG6g@mail.gmail.com>
Message-ID: <ZDoEG0VF6fb9y0EC@google.com>
Subject: Re: [PATCH net-next v4 2/4] net: socket: add sockopts blacklist for
 BPF cgroup hook
From:   Stanislav Fomichev <sdf@google.com>
To:     Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        daniel@iogearbox.net, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/13, Stanislav Fomichev wrote:
> On Thu, Apr 13, 2023 at 7:38=E2=80=AFAM Aleksandr Mikhalitsyn
> <aleksandr.mikhalitsyn@canonical.com> wrote:
> >
> > On Thu, Apr 13, 2023 at 4:22=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Thu, Apr 13, 2023 at 3:35=E2=80=AFPM Alexander Mikhalitsyn
> > > <aleksandr.mikhalitsyn@canonical.com> wrote:
> > > >
> > > > During work on SO_PEERPIDFD, it was discovered (thanks to Christian=
),
> > > > that bpf cgroup hook can cause FD leaks when used with sockopts whi=
ch
> > > > install FDs into the process fdtable.
> > > >
> > > > After some offlist discussion it was proposed to add a blacklist of
> > >
> > > We try to replace this word by either denylist or blocklist, even in =
changelogs.
> >
> > Hi Eric,
> >
> > Oh, I'm sorry about that. :( Sure.
> >
> > >
> > > > socket options those can cause troubles when BPF cgroup hook is ena=
bled.
> > > >
> > >
> > > Can we find the appropriate Fixes: tag to help stable teams ?
> >
> > Sure, I will add next time.
> >
> > Fixes: 0d01da6afc54 ("bpf: implement getsockopt and setsockopt hooks")
> >
> > I think it's better to add Stanislav Fomichev to CC.
>=20
> Can we use 'struct proto' bpf_bypass_getsockopt instead? We already
> use it for tcp zerocopy, I'm assuming it should work in this case as
> well?

Jakub reminded me of the other things I wanted to ask here bug forgot:

- setsockopt is probably not needed, right? setsockopt hook triggers
  before the kernel and shouldn't leak anything
- for getsockopt, instead of bypassing bpf completely, should we instead
  ignore the error from the bpf program? that would still preserve
  the observability aspect
- or maybe we can even have a per-proto bpf_getsockopt_cleanup call that
  gets called whenever bpf returns an error to make sure protocols have
  a chance to handle that condition (and free the fd)

> > Kind regards,
> > Alex
> >
> > >
> > > > Cc: "David S. Miller" <davem@davemloft.net>
> > > > Cc: Eric Dumazet <edumazet@google.com>
> > > > Cc: Jakub Kicinski <kuba@kernel.org>
> > > > Cc: Paolo Abeni <pabeni@redhat.com>
> > > > Cc: Leon Romanovsky <leon@kernel.org>
> > > > Cc: David Ahern <dsahern@kernel.org>
> > > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > > Cc: Kees Cook <keescook@chromium.org>
> > > > Cc: Christian Brauner <brauner@kernel.org>
> > > > Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > > Cc: Lennart Poettering <mzxreary@0pointer.de>
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Cc: netdev@vger.kernel.org
> > > > Cc: linux-arch@vger.kernel.org
> > > > Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
> > > > Suggested-by: Christian Brauner <brauner@kernel.org>
> > > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonic=
al.com>
> > >
> > > Thanks.
