Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB89727F7A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236466AbjFHLyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjFHLyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:54:24 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114941FFA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 04:54:23 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f7359a3b78so65745e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 04:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686225261; x=1688817261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pazMV69yfgFZtP5YDiQoyIf8m2D7hEJoNwU1Dx6CL8=;
        b=n38eRUOr4umoCI3/QeJjYKUG5wauY5XjpbsCAk1wajgj91PVr1M6zAt4A9q6TvWUs7
         VqUI2OLwjSp69CjrKIYNdE1Vl9nj/0BUVDz9dzA3+W70nmnMscD1svF4KX9ZvTVBRcY0
         e/efkjGrGTB30e4tokL4P9NUorLG51i/Iao4ki/GG4GlhZ1Q59kKNACiouxvuKwQXD0r
         V6npe7gl/9G7ZmM1Q8Uxzo0NKePnr9/d/wQ++4oKKTT5adJuUNdliPlwwZYz/WttxAdU
         3VviFQ3ER2MuB7p5zTA1IPCQ02NF9kS4fNagTOZ+5i+QKGqgqX0D7m+ugJzTtYpwTiTf
         F/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686225261; x=1688817261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9pazMV69yfgFZtP5YDiQoyIf8m2D7hEJoNwU1Dx6CL8=;
        b=aSIa3WL0JFAHDzgU8pk6moPRf+TOSSGfd1C656pAVUaVM12e3aUH/3ZyHUicCAbnZf
         +6AZmwMTAQ5WMeLLDpoJUI29sYDImxiHEnIiQmOa3D9vpMaMf0IWVlfA5UrTqfURJBvT
         cARic5R2lZGs0idX3WFd055V+hnGHvOQWafhfz/U5YkCsssOR9KhplNgNkwWQOBFDoq/
         tCs0it/8apxlfBBZBX6/dxUYG7xj2njyr+IUpBNFEPUWG60zCFJ9V2rPgqerzWWuqGGK
         OOj4MsdMaoNKeLKAgds24SqJKzweqg6xc+6z8lASUCSMkBgNTvC/28hZ7ssY50T/cmmu
         xrjw==
X-Gm-Message-State: AC+VfDwtk1HAdkbSuzYPaYenRv2TEsu7gtM7Heo+5gmNhc0r4kLes/fa
        wpw1zsEgzEJwY3FiuQledSn9AloP6j7I7r+jeNcwtQ==
X-Google-Smtp-Source: ACHHUZ4mzPivgHhSIaZ4zzukHxcstQVei8abw9RuANC/UKP6oJ2udNBEdZbHZg/kO9daP38viSJzG29otuBxNJ69Wmg=
X-Received: by 2002:a05:600c:1f0d:b0:3f7:ba55:d03b with SMTP id
 bd13-20020a05600c1f0d00b003f7ba55d03bmr156301wmb.2.1686225261431; Thu, 08 Jun
 2023 04:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230606064306.9192-1-duanmuquan@baidu.com> <CANn89iKwzEtNWME+1Xb57DcT=xpWaBf59hRT4dYrw-jsTdqeLA@mail.gmail.com>
 <DFBEBE81-34A5-4394-9C5B-1A849A6415F1@baidu.com> <CANn89iLm=UeSLBVjACnqyaLo7oMTrY7Ok8RXP9oGDHVwe8LVng@mail.gmail.com>
 <D8D0327E-CEF0-4DFC-83AB-BC20EE3DFCDE@baidu.com> <CANn89iKXttFLj4WCVjWNeograv=LHta4erhtqm=fpfiEWscJCA@mail.gmail.com>
 <8C32A1F5-1160-4863-9201-CF9346290115@baidu.com> <CANn89i+JBhj+g564rfVd9gK7OH48v3N+Ln0vAgJehM5xJh32-g@mail.gmail.com>
 <7FD2F3ED-A3B5-40EF-A505-E7A642D73208@baidu.com>
In-Reply-To: <7FD2F3ED-A3B5-40EF-A505-E7A642D73208@baidu.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 8 Jun 2023 13:54:09 +0200
Message-ID: <CANn89iJ5kHmksR=nGSMVjacuV0uqu5Hs0g1s343gvAM9Yf=+Bg@mail.gmail.com>
Subject: Re: [PATCH v2] tcp: fix connection reset due to tw hashdance race.
To:     "Duan,Muquan" <duanmuquan@baidu.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Thu, Jun 8, 2023 at 1:24=E2=80=AFPM Duan,Muquan <duanmuquan@baidu.com> w=
rote:
>
> Besides trying to find the right tw sock, another idea is that if FIN seg=
ment finds listener sock, just discard the segment, because this is obvious=
 a bad case, and the peer will retransmit it. Or for FIN segment we only lo=
ok up in the established hash table, if not found then discard it.
>

Sure, please give the RFC number and section number that discusses
this point, and then we might consider this.

Just another reminder about TW : timewait sockets are "best effort".

Their allocation can fail, and /proc/sys/net/ipv4/tcp_max_tw_buckets
can control their number to 0

Applications must be able to recover gracefully if a 4-tuple is reused too =
fast.

>
> 2023=E5=B9=B46=E6=9C=888=E6=97=A5 =E4=B8=8B=E5=8D=8812:13=EF=BC=8CEric Du=
mazet <edumazet@google.com> =E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Jun 8, 2023 at 5:59=E2=80=AFAM Duan,Muquan <duanmuquan@baidu.com>=
 wrote:
>
>
> Hi, Eric,
>
> Thanks a lot for your explanation!
>
> Even if we add reader lock,  if set the refcnt outside spin_lock()/spin_u=
nlock(), during the interval between spin_unlock() and refcnt_set(),  other=
 cpus will see the tw sock with refcont 0, and validation for refcnt will f=
ail.
>
> A suggestion, before the tw sock is added into ehash table, it has been a=
lready used by tw timer and bhash chain, we can firstly add refcnt to 2 bef=
ore adding two to ehash table,. or add the refcnt one by one for timer, bha=
sh and ehash. This  can avoid the refcont validation failure on other cpus.
>
> This can reduce the frequency of the connection reset issue from 20 min t=
o 180 min for our product,  We may wait quite a long time before the best s=
olution is ready, if this obvious defect is fixed, userland applications ca=
n benefit from it.
>
> Looking forward to your opinions!
>
>
> Again, my opinion is that we need a proper fix, not work arounds.
>
> I will work on this a bit later.
>
> In the meantime you can apply locally your patch if you feel this is
> what you want.
>
>
