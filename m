Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A987027D5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 11:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239144AbjEOJG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 05:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239134AbjEOJFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 05:05:34 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5A3199B
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:05:23 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f423c17bafso343195e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684141522; x=1686733522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgQznShlcEU/owRXS5pB/bMBA0shOHO8fmj2OZ6DolA=;
        b=G1EFKyQhvfOB1DU+z3A4aXg+42N7In3liWiZG/Jh9/5e9ZxgZPtgVhnS4LmfVsL3fW
         3R6OLEaDm5y3mAW/Hc6e7Iau+vS5YtVdWZnAiBrIRNozqWeebVkcb9Bpj2PcmPicTuS5
         TxOQO70y9WcMN0GQuuG2e6mq72dFlxVQQXORUiLvwI4t2Hkfsxl4E3+nD8J9EP1Zvnpn
         KMY+sGDUQD7q5dIM9OSAzU6/Sbxg4JdSbHNPckBtJXbJEryjMe0sUBRGwJW+oKeYfFIr
         lnL67gCkCwkfoOxHT8cIPJvO3szgUVGkdUHW6xe9iVUlG3kfFwgagmE49KY2CND+yuX7
         yRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684141522; x=1686733522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgQznShlcEU/owRXS5pB/bMBA0shOHO8fmj2OZ6DolA=;
        b=TicDWsoEyIKHBHrD1HhHE0Nkt41EXwMmkVElVvO3oBY0MZrHuYRNxAEofUl/Y3jqXs
         iSp/dLREV14gD8SAmvcS5FbdNEJH1lCkNbCjeer+EutTplnws0AiaF1ucMKMgNIFmylu
         JxsGr9rZXibiw6L0Jf0O+0WVWs/YMak7tYcCiAGnC6glDSmtfLemzAYfm1Iw+pKAagje
         KetFHV/h9aD8V6XaU6x5Kz8ccbwob70dF6bpzCEWaeI0azDnoP/NBl6CxcdvSTstB56N
         SBKPGNAnuhQ/cKHKCxDGZIgYdU7ebdHYXPnZTdBzaMyPMdy90MC7cEuuAhu1nEswUWp4
         ON8Q==
X-Gm-Message-State: AC+VfDxbxymNXaySiQIYs04Jou3pPnk/2BloIAKECGIggfd1PywId4qh
        NyAwi0cHdlIWcEE3aZx+STrEwKI+VUozdhSglT4BzA==
X-Google-Smtp-Source: ACHHUZ6WthzQz9qP/dl9280gK94WV7M4oXkVGcnS1LR3ZqMQqgt/Gt0cR1YOG5/Da/hzd9z/aBElFdN3hT3VqB5a/mI=
X-Received: by 2002:a05:600c:354a:b0:3f5:f63:d490 with SMTP id
 i10-20020a05600c354a00b003f50f63d490mr40224wmq.5.1684141522281; Mon, 15 May
 2023 02:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000001ca8c205f0f3ee00@google.com> <0000000000001f239205fb969174@google.com>
In-Reply-To: <0000000000001f239205fb969174@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Mon, 15 May 2023 11:05:10 +0200
Message-ID: <CANp29Y6G_1hKheTLG9NeSWv4+GYK=zOsUuu_sKCWqEBwGeOYig@mail.gmail.com>
Subject: Re: [syzbot] [xfs?] KASAN: use-after-free Read in xfs_btree_lookup_get_block
To:     syzbot <syzbot+7e9494b8b399902e994e@syzkaller.appspotmail.com>
Cc:     david@fromorbit.com, dchinner@redhat.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2023 at 7:29=E2=80=AFPM syzbot
<syzbot+7e9494b8b399902e994e@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 22ed903eee23a5b174e240f1cdfa9acf393a5210
> Author: Darrick J. Wong <djwong@kernel.org>
> Date:   Wed Apr 12 05:49:23 2023 +0000
>
>     xfs: verify buffer contents when we skip log replay
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D12710f7a28=
0000
> start commit:   1b929c02afd3 Linux 6.2-rc1
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D68e0be42c8ee4=
bb4
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D7e9494b8b399902=
e994e
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D172ff2e4480=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D11715ea848000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: xfs: verify buffer contents when we skip log replay

#syz fix: xfs: verify buffer contents when we skip log replay

>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
