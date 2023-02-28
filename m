Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D936A53F5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 08:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjB1H5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 02:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjB1H5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 02:57:13 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EF32748B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 23:57:12 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id h9so9234110ljq.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 23:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677571031;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nqh6k7lLKfOfA+qZNQXHMx2HFoYuETh49MYOfc9k5dU=;
        b=R3ZfcgpGxLqu0MbdBRU/luv3TuSs7ppTN845xxinSW8Wr9INXGKzSblDmCCjQeaMh+
         0Js/7yuiGJ7n4dbLVPMe9dh53LD5weGbDB5MEBi9cvQTQPGqV6jqnrVy1s95YINDDQa8
         xy51pni+IVjlk4UAyjyXVskcWiNAIJKpz48DT+8yMMOTd/+xLRQ/vvRvijJhXwpvjtoq
         wjcE4s4ZUL8TXy57I04InGBL5xtkT/SrtB6k+9J1tVeTp+58gxY66eku30uM+rRmSaxH
         OX8EEsZ+S5vOIHXWroT7QSil6lSkZ8tNBLgm7NkT9+wBK0IHBDBz+H7gMhtKtcrB2bo3
         xR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677571031;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nqh6k7lLKfOfA+qZNQXHMx2HFoYuETh49MYOfc9k5dU=;
        b=Uy+cQKMOaUH5covSrTL4Mc/c9U+oOV49Bif+eOJAi5hm01IKtZ2T2X1RwmU4KsV6Qr
         BkyK+6za42Q4aacwMaCVgqGhrp5mVpjXoE8bJwPrnm6xg7zghFxAHt2Q17TEL+Splegf
         LJ1DdaFH6KDn5EafxibxCivWgVDq8DLnuPH3d5+xJ2KnBbK8tdgmIBrIwxj+rPBIIiFu
         eJFG1BfKdW0mmP+rVw5junrv9xUOvsutWj2yp1JFjVhQHKTDKZ3bA92DUmLEbEWNerLc
         j7UE+Rs8Y2Yuuh3B7YdfBe2yxgHmD9Dv//+coZrvgkwuTmCIXnN4MS8v6i2IXp6iDs4x
         u2iQ==
X-Gm-Message-State: AO0yUKXHfzHTiiBn0jN9giq9qwPygiNRiIfbCjn1UXdDxjQWUJGVnLqo
        Cn8aFNx6DnJTMW9VdnIxBsIW4iOVNoneWcMNYi5NjA==
X-Google-Smtp-Source: AK7set+I56JzWxEwgeSA2GOk8vYSjntF6TOYRFTaD9w/cgzoF53LhUV5+7MV6ES+ec893Su7vWLHc1LtQwUNLVsJHjM=
X-Received: by 2002:a2e:86d7:0:b0:295:b026:8c34 with SMTP id
 n23-20020a2e86d7000000b00295b0268c34mr475554ljj.4.1677571030611; Mon, 27 Feb
 2023 23:57:10 -0800 (PST)
MIME-Version: 1.0
References: <000000000000dca7e505e9978943@google.com> <000000000000478fb705f5b2d79c@google.com>
In-Reply-To: <000000000000478fb705f5b2d79c@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 28 Feb 2023 08:56:57 +0100
Message-ID: <CACT4Y+bDpiHJ4yGYdv0DYYNwjkvTmV3F9p3Zq3jc+cZoqRSQJg@mail.gmail.com>
Subject: Re: [syzbot] [udf?] KASAN: null-ptr-deref Write in udf_write_fi
To:     syzbot <syzbot+8a5a459f324d510ea15a@syzkaller.appspotmail.com>
Cc:     jack@suse.com, jack@suse.cz, khoroshilov@ispras.ru,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org, pchelkin@ispras.ru,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2023 at 19:42, syzbot
<syzbot+8a5a459f324d510ea15a@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit e9109a92d2a95889498bed3719cd2318892171a2
> Author: Jan Kara <jack@suse.cz>
> Date:   Thu Oct 6 14:41:23 2022 +0000
>
>     udf: Convert udf_rename() to new directory iteration code
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1191f00f480000
> start commit:   55be6084c8e0 Merge tag 'timers-core-2022-10-05' of git://g..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=df75278aabf0681a
> dashboard link: https://syzkaller.appspot.com/bug?extid=8a5a459f324d510ea15a
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=100a46c2880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=116a4e72880000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: udf: Convert udf_rename() to new directory iteration code
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks sane:

#syz fix: udf: Convert udf_rename() to new directory iteration code
