Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC75968B996
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjBFKLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjBFKLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:11:31 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C528C13528
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:10:13 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id v5so5826924vkc.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9sQMrFnmMENqVwum3WBrvUwEv6xbguvnHSWE1XksF40=;
        b=QckFQSxzR3wuDfcrAnpGUJK+a1QzLkCX1PebBrZjfM1SvG+AtHmttCDanhj4GQbDPb
         lJINsJ53yGWTG3k4bVqpSJe6Ww+LtGv7Mjl82fAmihoxVCaeOZluanWWzgB67iwCoOwD
         dnAPOy0/Juojy/zOT4zq+hTzR4RxUzkOSxmXSgEuuNzo+9UgN74KtcLDripWzQkk9G+P
         KgAY7POG0FMUcLeIWCujtFlvB+R2xLqKHAm3nvK9fNsk9532m8dP++tOrW/Ic13morpY
         xHWHVSDMDAT6hiddExqsasfhg0cXy7jDrRQWDkQOcSkfaPqAVzonAGT11hE9FvdgzbsE
         wztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9sQMrFnmMENqVwum3WBrvUwEv6xbguvnHSWE1XksF40=;
        b=FJGCJJNwaa0pzW4Tz53Hv1MDbOpV1FzWYaka7cVA2k5PqsR3i4okZDHFABiZ7/oo3Z
         69XKGShmNZu60eV5ecEY4bxzcAuUZNJvLiymHOobJMLuQ/dbqfRuKH516FWIkn8FusFM
         NPTE/k2GiAVnCs5cX55BcnUVEbPZX2+ILiUwlbgyiJEeIDvUl1wFcAG6kBLqt8I8k4by
         daVrY0RPF7wBJd9Z67wReTboz9gomPeOCXiDaKg4WWlKb92sayioNCNThovrxdmlgwkN
         G8a57e7frbi13VAzyNUb5PXQjmhkGGlUseMjl6TzMu6bnm0gRTCuSEzZQWiS18+7doCg
         iNyw==
X-Gm-Message-State: AO0yUKVDMxr0nArD9n6LOJE0T+lStHttmOwNj1Ro1LLCqzdUfgwPeo/g
        k0ZO4CUI2wB/EWs6yZCzZm35Z7hDvvhzv1zwbyaqhH1zhwae/3nkqE0=
X-Google-Smtp-Source: AK7set+IO7RGPUC8CK4qGlVLQF1uUvlP2D0BSP38Ka5fcymFzCVWNn/4LzVaurjDtuT+h4aBkUZL4o2ZeqRedf8r0LA=
X-Received: by 2002:a1f:98c5:0:b0:3f5:ef5e:ff80 with SMTP id
 a188-20020a1f98c5000000b003f5ef5eff80mr989627vke.10.1675678209951; Mon, 06
 Feb 2023 02:10:09 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f61bdf05e79a7c5c@google.com> <00000000000067d34605f3e029f7@google.com>
In-Reply-To: <00000000000067d34605f3e029f7@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Mon, 6 Feb 2023 11:09:57 +0100
Message-ID: <CANp29Y72b7Vd5JpU8aiZLxqhyMtF_Y04bR8-+AxzS9Oj5S6EVw@mail.gmail.com>
Subject: Re: [syzbot] [ntfs3?] BUG: unable to handle kernel paging request in mi_enum_attr
To:     syzbot <syzbot+28207acc70bbf3d85b74@syzkaller.appspotmail.com>
Cc:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 4, 2023 at 2:56 PM syzbot
<syzbot+28207acc70bbf3d85b74@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 0e8235d28f3a0e9eda9f02ff67ee566d5f42b66b
> Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> Date:   Mon Oct 10 10:15:33 2022 +0000
>
>     fs/ntfs3: Check fields while reading
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13c11ba5480000
> start commit:   f9ff5644bcc0 Merge tag 'hsi-for-6.2' of git://git.kernel.o..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c163713cf9186fe7
> dashboard link: https://syzkaller.appspot.com/bug?extid=28207acc70bbf3d85b74
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1275aed7880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124f533b880000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: fs/ntfs3: Check fields while reading

The reproducer was mostly triggering a KASAN: use-after-free in
mi_enum_attr error and the patch indeed looks like the one that could
have fixed this problem.
Let's close the bug, if `unable to handle kernel paging request in
mi_enum_attr` is still not fixed, it will pop up again.

#syz fix: fs/ntfs3: Check fields while reading

>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000067d34605f3e029f7%40google.com.
