Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F803736769
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjFTJO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbjFTJNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:13:52 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C516C1BCE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:13:28 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-516500163b2so16218a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687252406; x=1689844406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gn6F1r4JetejXjMhljN018Vg+0Oo2AizIn4uwEH2p64=;
        b=NDqM+rm9D5qpt3J5Ss4X0ynUh/cA9LO6J8buwFEXXRWBW90GkOIJMZqS+4bQh++Kz3
         +DjF3NK5zPNFE6wjn/Ox7SWSBr3KAFvLdRwhDMs8VB3mWy/+gbpyRSKrwHEQ2LM4nxtO
         sdFATplquBv5MFYQcRu9Sz1RknwGTfB55BiB5UHF817kijlqJGi7U71alXhXjAQOREnb
         DhYo5FHEOilCY+LFqGSIG9tIHu4cAe7qYRvXsCvrACsbpdcx54zu1OF1j1et6HBCvoW0
         jVugB66kbzyOKemzdMUrpKfrWZjV1K6etP8DxzQI5HnKHruMKWvqL1Xnk/dgyGFAdglf
         hBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687252406; x=1689844406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gn6F1r4JetejXjMhljN018Vg+0Oo2AizIn4uwEH2p64=;
        b=CmhpVlT/VvTCrKQEhvSGAUYJn1/Xmqfx4lNnI0E4B2i+jJE+sop4Y03b0J+sNQlwT6
         IkK+Dl/xxStFwv3q7RBCIDl7X8l/6xY55Wz8irEHd4XBWcyDyRTEZudTBf0tLjAEKuc/
         ag/+7Zw8wCsfqV589gvjH58SEimQ+acP4S230VbG1an33K+sSaIUuN7l3ltfNQ+U7d/6
         ev4hpo6EuaIEPPvGpVXBlJbOHKmx94clhTCyaNhqLz3LjmggRxYVEiz47cfemigYvXey
         CviISTn2kkD17zy97AEkTkzwyOT8oNezPHpe8F/xPJSfpMB6CqF+2rkAc9H1M4bRxCZ1
         dkRQ==
X-Gm-Message-State: AC+VfDx1rq7s3KjBiNIpHpaMI4kJuvl6GYRctiN7PKrsOhvn7aVQ+Ot3
        8QJZQEnopdC3vJje0/GF6xs8DOt2BFjyjzG8oXDbrFeqjjyIC1E0mfX0Xg==
X-Google-Smtp-Source: ACHHUZ7wa2QfFHSoh4ffltU5YMF6szFm+oz6f5YhUdVzPKlzXndLS78AruSCSvPYPbwzDDAyuWfXQR5K3SMnPhvv/60=
X-Received: by 2002:a50:c054:0:b0:514:92e4:ab9f with SMTP id
 u20-20020a50c054000000b0051492e4ab9fmr298095edd.7.1687252406029; Tue, 20 Jun
 2023 02:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000001f31eb056ea92fcb@google.com> <00000000000097ad8105fe89f0a9@google.com>
In-Reply-To: <00000000000097ad8105fe89f0a9@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Tue, 20 Jun 2023 11:13:14 +0200
Message-ID: <CANp29Y4_pqfAvKJMi5X+vcsa+UXPR99i0U8OkreoHwnQMnL2ag@mail.gmail.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in xfrm_state_find
To:     syzbot <syzbot+131cd4c6d21724b99a26@syzkaller.appspotmail.com>
Cc:     anant.thazhemadam@gmail.com, davem@davemloft.net,
        dvyukov@google.com, edumazet@google.com, glider@google.com,
        herbert@gondor.apana.org.au, icytxw@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, steffen.klassert@secunet.com,
        syzkaller-bugs@googlegroups.com, tobias@strongswan.org,
        tonymarislogistics@yandex.com
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

On Tue, Jun 20, 2023 at 8:41=E2=80=AFAM syzbot
<syzbot+131cd4c6d21724b99a26@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 3d776e31c841ba2f69895d2255a49320bec7cea6
> Author: Tobias Brunner <tobias@strongswan.org>
> Date:   Tue May 9 08:59:58 2023 +0000
>
>     xfrm: Reject optional tunnel/BEET mode templates in outbound policies
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D13eeaa4b28=
0000
> start commit:   e4cf7c25bae5 Merge tag 'kbuild-fixes-v6.2' of git://git.k=
e..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D2651619a26b4d=
687
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D131cd4c6d21724b=
99a26
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1140605c480=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D14c9271848000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: xfrm: Reject optional tunnel/BEET mode templates in outbound po=
licies

Looks related.

#syz fix: xfrm: Reject optional tunnel/BEET mode templates in outbound poli=
cies

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
d/syzkaller-bugs/00000000000097ad8105fe89f0a9%40google.com.
