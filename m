Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93596F8E2E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 05:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjEFDCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 23:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjEFDCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 23:02:38 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED687D9E
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 20:02:25 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-55a5a830238so23093887b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 20:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683342144; x=1685934144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQpKNgXO2ZnIB2b0oZRLkuUeVp2jvRipev1uBl4QDDI=;
        b=QfrsLV2t2I5DB3yrzgisfEkevBro4pFmIcQZeyOd1FWLLI5I8RMyksfenSbIPJyxqP
         BDzLy22a7mYPBrFqWPXs/bOA4R7nq23QQc9vh7Z/kUR9RGcNvfRJw9JzsygDuFR8edYh
         m2ZlVfzko5TbNKZyLVrWNLzyjrmw9bE40g9tJFgj6XTCtYi3YnJMp6q7lLh8b1l3rORO
         BFyedo97C+TRAXLRzj6J3A1Igk8SfmVO6j7L6+40P8Bp5VZIHCLdPfkD/EgRy6T0NBhv
         2e4lZg0glALu1QNRnBPIXWW6uttY+llVPej7av/dA2GJgqGJYa/i5Gf9x9Ks7ljPUcGj
         MFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683342144; x=1685934144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQpKNgXO2ZnIB2b0oZRLkuUeVp2jvRipev1uBl4QDDI=;
        b=SScRacIpMZqCZmhbCdH97exu0/Ekwd2C9JThJKjxKAr+cB/ovl15q3RtIwJD5bRhmB
         bkeg6HY3mXOwOSg9bY0XeJVAiaBMPEB3L5cFLNZ4LcjcAQVsYvUVdWCEEWBFbovK/zSY
         4WR9xOhuAarS+kpMH66b5MLN0s4It94MOwJ09bSrnHpZsICmXXcDDtJPflywJWEHNt74
         sC2ICOSfri+oOdGI8Ip/DDqIZF1Tkp89eqq5tj1mU5h9ZsBUNtjooIeDinC4gdpu7yl6
         3j2sPhW5i9DT/5wLjtK1nKfaVpDIKBK9OfT8uDO5AEoD8u7eNMn9k5bg2HzP/AIOmf4J
         w9iA==
X-Gm-Message-State: AC+VfDx+QvATXyeTZUUTCgmVg+ZAmFNCnxvl9to6nLI9X+pFzCzo9o4Q
        uryBHT20hgZe04i1wuMRrCcn9SgmpgJmYKzI62FkmQ==
X-Google-Smtp-Source: ACHHUZ6Trnz+womVZTZ1dupvzPcHfLUjonREgIxizP/WjFW6+oCAoVKD+b2h/SGGfPErR7G0qy02oN684Hi1cNvlgfI=
X-Received: by 2002:a25:cc5:0:b0:b9a:663b:eced with SMTP id
 188-20020a250cc5000000b00b9a663becedmr3152907ybm.36.1683342144514; Fri, 05
 May 2023 20:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000016552c05f1d7e734@google.com> <00000000000014678c05faf51958@google.com>
In-Reply-To: <00000000000014678c05faf51958@google.com>
From:   Jiaqi Yan <jiaqiyan@google.com>
Date:   Fri, 5 May 2023 20:02:13 -0700
Message-ID: <CACw3F53T=bbn6f6db_T_5=udLq-cvChYALhmmpQ1QOkjH-7gpg@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING in shmem_evict_inode
To:     syzbot <syzbot+3d4aa0d3e784b29b1520@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        shy828301@gmail.com, syzkaller-bugs@googlegroups.com
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

It seems commit 12904d953364 caused the WARNING  when MADV_COLLAPSE on
shmem memory, but right now the root cause is still unclear to me
after some digging. Will keep digging and/or try to repro over the
weekend.

On Fri, May 5, 2023 at 9:51=E2=80=AFAM syzbot
<syzbot+3d4aa0d3e784b29b1520@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit 12904d953364e3bd21789a45137bf90df7cc78ee
> Author: Jiaqi Yan <jiaqiyan@google.com>
> Date:   Wed Mar 29 15:11:21 2023 +0000
>
>     mm/khugepaged: recover from poisoned file-backed memory
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D14f6703228=
0000
> start commit:   3c4aa4434377 Merge tag 'ceph-for-6.4-rc1' of https://gith=
u..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D16f6703228=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D12f6703228000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc1d541e02d3fa=
ec
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D3d4aa0d3e784b29=
b1520
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14d1973c280=
000
>
> Reported-by: syzbot+3d4aa0d3e784b29b1520@syzkaller.appspotmail.com
> Fixes: 12904d953364 ("mm/khugepaged: recover from poisoned file-backed me=
mory")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
