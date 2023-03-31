Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354A06D2465
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 17:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjCaPtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 11:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbjCaPtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:49:16 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B653F20DA6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 08:49:07 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3e632769c5eso323681cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 08:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680277746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUOEBkfqFyDCBC8ECDHsPP9QVPu8ZlPnlnebW3bc4Wk=;
        b=FY953/CnzlwXU3r1VaUDCjpKU3/FnptXqMVBTcFFdpOiaNBzMrpEDeIuFcWlKor7Kn
         lFFhCvjaBgKh7SxjnFBNv6uNosDKUfuW+LTfhRPMIGnHdUBybMPH5KDYKg6w3JBVeZ/n
         F5uogEgSeVOqBktcX9OhMBmv+FrZZfr/IjS0BXLmTTrF7l5ZBRroUkUuNIbCYyR4B/W6
         t28pBBawCuMqIJJz4+Wh+CgPl/+vVNMjWsydcdfM+IL3qpUZOFD1MdF8zDa1BH5QXuze
         rYmP4lyHFFYJIlB7R5kOYJfyGsOPqtYBIFlBha4fzASc93k/j1FT75YboKPSc8W3T0V1
         fsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680277746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUOEBkfqFyDCBC8ECDHsPP9QVPu8ZlPnlnebW3bc4Wk=;
        b=KQE3EQw8CfFHoUfRov0oRqdPH1Ato8uzBUyD55U6uXCBokKAWTTtri9zzZX3pVs9+W
         XmQy7mcX5vchKoi+joYm12+QbzMr+DalnSdhuhmbeUp0rPy2k2BnrJJqHHINlb1OmoDF
         s7x9F7h2HG2M+hSRyQzBZt8p6eYhRsE5PscyzeURSZEld0LR+fPPt3xuKjer+U6GyqRm
         car24+y5RoSyvgxgazEWtJTemTpqrS//iULRot4EZSPxfUV1szIfCnKZnuNSFPQ3IngL
         5qiRWKPrbfR0Cw5yRFMQMqQTMs69PNuBtgqPsg9ypEWqQt383oWEPt0cyNd3/uLssWrv
         iGCA==
X-Gm-Message-State: AAQBX9f/rtrEUvmk6rPR3hAQfQBSW4s/3GfGEy8OKPltyBRg2F9Lff8F
        Uij/3l907pF4MIy4q/uIWzF3FhhM4xNkCpEPuNdytw==
X-Google-Smtp-Source: AKy350ag99cJ/JEGuKnsMSmBASTRl+ZXG21PE7l3bKosWkqKptj6CG0C5aWUVPT4lPH4wD1HF4kzYv2oTCBy7ERfqKQ=
X-Received: by 2002:ac8:5bca:0:b0:3e2:3de:3732 with SMTP id
 b10-20020ac85bca000000b003e203de3732mr346582qtb.7.1680277746464; Fri, 31 Mar
 2023 08:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a5c9be05ed85b31b@google.com> <00000000000020d46805f8340e6b@google.com>
In-Reply-To: <00000000000020d46805f8340e6b@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Fri, 31 Mar 2023 17:48:54 +0200
Message-ID: <CANp29Y4gA0D=O5CL3bxhYjT3mYtifXU-J-SXBiOTxfpYsfvTdw@mail.gmail.com>
Subject: Re: [syzbot] [block?] KASAN: use-after-free Read in netdev_core_pick_tx
To:     syzbot <syzbot+10a7a8ca6e94600110ec@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, gakula@marvell.com, hdanton@sina.com,
        jiasheng@iscas.ac.cn, justin@coraid.com, kuba@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.swiatkowski@linux.intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-13.2 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 5:42=E2=80=AFPM syzbot
<syzbot+10a7a8ca6e94600110ec@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit f038f3917baf04835ba2b7bcf2a04ac93fbf8a9c
> Author: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> Date:   Fri Mar 17 06:43:37 2023 +0000
>
>     octeontx2-vf: Add missing free for alloc_percpu
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D133a3d2ec8=
0000
> start commit:   42226c989789 Linux 5.18-rc7
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd84df8e1a4c4d=
5a4
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D10a7a8ca6e94600=
110ec
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D11ed1369f00=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D166b22cef0000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:

No, the commit is unfortunately unrelated.

>
> #syz fix: octeontx2-vf: Add missing free for alloc_percpu
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
d/syzkaller-bugs/00000000000020d46805f8340e6b%40google.com.
