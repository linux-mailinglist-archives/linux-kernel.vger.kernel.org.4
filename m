Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E5E687E4C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 14:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjBBNJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 08:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjBBNJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 08:09:54 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA398C1C2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 05:09:53 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id u199so824207vkb.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 05:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3g2aZTms8NeVvQbaJ/VqQGXtTC/cXBjRoHkFTENxgmg=;
        b=Y+J5920NzJqGfYEmAer86jjld1wvkctxHuFCL4OsBk+BfBt+73cYCHT6kX4OZdDG0v
         Yr4D1V3wkW+HcbD8O0YMlGvAXMO5BlRQq7cOsaDhgm/fxRH/mMCjKnogoMG0bRt0oGdE
         96zPLjXmtV7/83lm5H308bd8wwPOlmbrTJe1QygzKF8BFgtt/i8zd8UBMz6oo08UAwdm
         yn5gZT3rmPo8NwAN1VcBd8ctJxjnmcMw8VTWQyGKx7zhbX2xQWjL83qL6gUuUWAXIui7
         wHdFjIgYcgPjH59V5oauvyjhb1CfVa15kvdv3lOxXar/CoiDBOlAVnz0CbHDN+gPMxAr
         cO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3g2aZTms8NeVvQbaJ/VqQGXtTC/cXBjRoHkFTENxgmg=;
        b=bbIgvp+A50eriPTZyD9bIzd+cUL8v//THLAbp20yFzxUA3rMOWpgveO0DoZoU7JvkQ
         uBNQGej6+oAeAaKQ9AIpOahTWk/xtuDQy0drzLzNKFbqBSVjR+hK8hZLyhGfXa3bKrsF
         6MWHZ3pqKITQpWHs0FUV1fO48lWrzZF8fh1vSwP0aWyviNu69Qc/5JqNw2GIvXfjZw5O
         1hwe2uSO4Ni4jgbAQMyWaCcBDCmS6sde5/wfeFAGhk3ZxbNRPCyJ1miI8YbOJL1tb3al
         V/hqeeyOgO+rFvf4VXI1d7uGqZVmcFnX0g+ed59t3MvQ6SNJIurfXI92MFCsXqmLoDjS
         +++w==
X-Gm-Message-State: AO0yUKVYwuDik4v72qJJ2ztCUCbdoiNGUWcULM63cUnmBaUOrs0JFH+V
        9mdRsnwRZ0WH/50ncbBJSFP9xIHd21H3QCgoTgKZdA==
X-Google-Smtp-Source: AK7set9LdYWkQiKZklNknS6+pdcDKZRVbczRpnpXIdkrmmjnY8Ds80FwebwYoP4lPjbyW66OF6ZkyRGV7rARs309fuY=
X-Received: by 2002:a05:6122:d83:b0:3b7:5ff7:cfb8 with SMTP id
 bc3-20020a0561220d8300b003b75ff7cfb8mr866192vkb.11.1675343392112; Thu, 02 Feb
 2023 05:09:52 -0800 (PST)
MIME-Version: 1.0
References: <000000000000befd1d05eeb5af30@google.com> <000000000000168a9205f3b6738f@google.com>
In-Reply-To: <000000000000168a9205f3b6738f@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Thu, 2 Feb 2023 14:09:41 +0100
Message-ID: <CANp29Y7y=Gr5J3wihAOar-EN-JH1wzcXEJcLNV=AOQSUz-aABw@mail.gmail.com>
Subject: Re: [syzbot] WARNING in ext4_expand_extra_isize_ea
To:     syzbot <syzbot+4d99a966fd74bdeeec36@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, bagasdotme@gmail.com,
        ebiggers@kernel.org, guohanjun@huawei.com, jack@suse.cz,
        johnny.chenyi@huawei.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, liuyongqiang13@huawei.com,
        miaoxie@huawei.com, patchwork@huawei.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu,
        weiyongjun1@huawei.com, yanaijie@huawei.com, yebin10@huawei.com,
        yebin@huaweicloud.com, yuehaibing@huawei.com
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

On Thu, Feb 2, 2023 at 1:10 PM syzbot
<syzbot+4d99a966fd74bdeeec36@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit cc12a6f25e07ed05d5825a1664b67a970842b2ca
> Author: Ye Bin <yebin10@huawei.com>
> Date:   Thu Dec 8 02:32:31 2022 +0000
>
>     ext4: allocate extended attribute value in vmalloc area
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e7b9a5480000
> start commit:   644e9524388a Merge tag 'for-v6.1-rc' of git://git.kernel.o..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
> dashboard link: https://syzkaller.appspot.com/bug?extid=4d99a966fd74bdeeec36
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f49603880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=163dfb9b880000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: ext4: allocate extended attribute value in vmalloc area

Looks reasonable.

#syz fix: ext4: allocate extended attribute value in vmalloc area

>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000168a9205f3b6738f%40google.com.
