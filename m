Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0657E6F703B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 18:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjEDQvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 12:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjEDQvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 12:51:16 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C5D128
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 09:51:15 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3f0a2f8216fso788531cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 09:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683219075; x=1685811075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smUXkej0xPzQw1tg67ntvigJgPPhrNFSnWepihD6ur8=;
        b=K1oJeQe320jy4VAtg3hw+5lreYPqWQXRA2DhbRqCx+JumP5I+wGtVUapJkj4xbP5Gc
         LekZghaozR/4Qo4Man59/cjwsyO1mWdp1HYs2Up0YspSfb5Y09KyJUACWQO64fh2SfhT
         /WrgNUBfJy561g+iLGCchaOa0QJrOGh+51kgnejTI4ms2xjEgy0cE0eYTdIcQfuaBbj2
         laz1HzpEdBlAd4yN3mcFlfSFxvlDATXF+jgnemjKagcvfb4oBUn6y5WhU1hAzE9eLHd8
         YBShAagG+6NldxNv9bhLZFUy84FIwetvoEpA2oDHLtvoPB+boKrhKz9OSAuX1NBtfLR1
         3Mtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683219075; x=1685811075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smUXkej0xPzQw1tg67ntvigJgPPhrNFSnWepihD6ur8=;
        b=kb66OCokoaXw5EoKdxwoObfsscni0EG0X/yS1aan8QNjxdeLywL/UtTA9kGcTec9/m
         z7/FG6o0YpAPcAbt+GOwpIbFi1B46+fPkkcSu6yFmrYvkH4q9PX9hGNvW7YC1oWF/SoL
         6Uxv7h0iyjuxv+4m60+z4UxaMm8t0qcriNprBZIocb01wtP0Pui3kTk46OkKBfemwWth
         McU7BT+1hZZKSzEZ4j60BaOQGTnimONcK4L/eguv3H9hrUqEAd+rAOEWyED6rXQJq6RF
         rUTbGsavm8mudcpfHcfnuqlGPtNJvowX31KcMgf14hLC9dncWlssrwL3fOV2ZFPGbkeS
         QJIg==
X-Gm-Message-State: AC+VfDxHTOC9IPL1NE6HhSluLvzBO8rl5hUsui9NgjcO0x4peybiVzO0
        1kpGD1aoZ3jvUbXR0nfry+PhQkQQy7bg364X+0843Q3hjwnI2emgxY2xkA==
X-Google-Smtp-Source: ACHHUZ57M6XvrZOUlJI4JuZPd/5ZX1/+KJTt4pAsY8OkJ3eOXQG7rcN0DdhPWJ3waUZhDaSXwPJ+uOusE1Vz1WLvmCE=
X-Received: by 2002:ac8:7f8c:0:b0:3f1:f8d0:a3a7 with SMTP id
 z12-20020ac87f8c000000b003f1f8d0a3a7mr498652qtj.8.1683219074618; Thu, 04 May
 2023 09:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000951c2505d8a0a8e5@google.com> <00000000000091b72905fae0eda2@google.com>
In-Reply-To: <00000000000091b72905fae0eda2@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Thu, 4 May 2023 18:51:03 +0200
Message-ID: <CANp29Y6PHCKRWSQvhs2gKTMC3u95Zo8VLTmXRxP1=5X00EKh-w@mail.gmail.com>
Subject: Re: [syzbot] [can?] WARNING in j1939_session_deactivate_activate_next
To:     syzbot <syzbot+3d2eaacbc2b94537c6c5@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, kernel@pengutronix.de,
        kuba@kernel.org, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rempel-privat.de,
        mkl@pengutronix.de, netdev@vger.kernel.org,
        o.rempel@pengutronix.de, pabeni@redhat.com, robin@protonic.nl,
        socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com,
        william.xuanziyang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 4, 2023 at 6:47=E2=80=AFPM syzbot
<syzbot+3d2eaacbc2b94537c6c5@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit d0553680f94c49bbe0e39eb50d033ba563b4212d
> Author: Ziyang Xuan <william.xuanziyang@huawei.com>
> Date:   Mon Sep 6 09:42:00 2021 +0000
>
>     can: j1939: fix errant WARN_ON_ONCE in j1939_session_deactivate
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D10cf099028=
0000
> start commit:   fa182ea26ff0 net: phy: micrel: Fixes FIELD_GET assertion
> git tree:       net
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D796b7c2847a68=
66a
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D3d2eaacbc2b9453=
7c6c5
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1455e3b2880=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10296e7c88000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: can: j1939: fix errant WARN_ON_ONCE in j1939_session_deactivate

Looks correct.
#syz fix: can: j1939: fix errant WARN_ON_ONCE in j1939_session_deactivate

>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/00000000000091b72905fae0eda2%40google.com.
