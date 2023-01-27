Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3243467DE61
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 08:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjA0HR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 02:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjA0HR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 02:17:26 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F9F4522A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 23:17:25 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id j17so6821707lfr.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 23:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t6JX9N8YU0ZRqNe6wufmk02qXuxOtdyVljTACCKEcGg=;
        b=nCK59OAyOOqOuLFK6Msjex5na6gejqRtW7VDdGlgPWnyiNabSGmrz7xdV4mqU3MqyM
         v6DJjMDP33gKhfCVwArnR6xC3FzIlt/bymM3F0CX/1HfuciggqhLllB12otkqPBTn8kY
         4jb075vjMBa+69RYRSSHiElBLHGhX+kLWqEW4oVSyjjCT3zrCGCQV7MRWFLKrcEtVJeM
         /twxQvRNx4ANELvYUaL18ZlQO+f9MoICnKhERkjgLbk3KGcsbBZ19tI31HJ3/soqvueX
         U0WegXVbXbx3VP7jTRF2SvYcI1gGZF/DoYzE043MQ7F2xwgcfonn99UaD3YdpD+nOlbF
         tjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t6JX9N8YU0ZRqNe6wufmk02qXuxOtdyVljTACCKEcGg=;
        b=IBKs9T6084mhvETdj6ozczCB2XWDyW8Ux/ePmPMnbq06lPpQT4d+n2SmkFs1bIDyk+
         nWvjuKLlNb93mZPDTL0CKLqgX33IXLVX20dnELcyjO/bOs6FW6L1pD77FuIeBPbxIj5C
         w5G6SC6Bwd2PYrxMjF/zgr2/fgA/roKU08MV0leS7we53vp1Ssuhsky5hPtJ2or/XlI2
         SzBm9FGq2MJnO8vR3ccSRMsi5X+KUo9LZDKzEwOylfQjhzi/FQzyeoSRvmhxGlxDtY9f
         4ELMBQKHhOjAUhcxmSAwkzJ8SUuRQNYU3o6fgUTqwQc5WApzwRVwp0ueCpS22yRYWGs6
         kxuw==
X-Gm-Message-State: AFqh2ko1lC4SBW/FlffMc8m2UgWaaVdcGnT15UXcvmVlOZg23rBmeb/6
        Z17MiOALr9y3Z9doLO7yVg+glq/xB3Z/2hEZER3aVw==
X-Google-Smtp-Source: AMrXdXs0v6Ue3yA4k8NUfTIYEvwqIAxkwxmjFuIPuay9e+m8eQqDdhAU2niVaLWNAdVcke53Mmk9l92bsjfzZz2pOUI=
X-Received: by 2002:ac2:508f:0:b0:4cb:7c2:87ee with SMTP id
 f15-20020ac2508f000000b004cb07c287eemr3927074lfm.165.1674803843191; Thu, 26
 Jan 2023 23:17:23 -0800 (PST)
MIME-Version: 1.0
References: <000000000000e4630c05e974c1eb@google.com> <000000000000defd4b05f2feb35c@google.com>
In-Reply-To: <000000000000defd4b05f2feb35c@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 27 Jan 2023 08:17:11 +0100
Message-ID: <CACT4Y+Y7CDqyXq87bh=eXfpQz2Xdu=8HV5pojnNd2Xv6x-4G9Q@mail.gmail.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in evict
To:     syzbot <syzbot+6b74cf8fcd7378d8be7c@syzkaller.appspotmail.com>
Cc:     feldsherov@google.com, hirofumi@mail.parknet.co.jp, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu,
        viro@zeniv.linux.org.uk
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

On Tue, 24 Jan 2023 at 09:57, syzbot
<syzbot+6b74cf8fcd7378d8be7c@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 4e3c51f4e805291b057d12f5dda5aeb50a538dc4
> Author: Svyatoslav Feldsherov <feldsherov@google.com>
> Date:   Tue Nov 15 20:20:01 2022 +0000
>
>     fs: do not update freeing inode i_io_list
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=111208cd480000
> start commit:   b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1d3548a4365ba17d
> dashboard link: https://syzkaller.appspot.com/bug?extid=6b74cf8fcd7378d8be7c
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1353a3e2880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16163dce880000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: fs: do not update freeing inode i_io_list
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks reasonable. Let's close the bug report:

#syz fix: fs: do not update freeing inode i_io_list
