Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C12686104
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjBAHzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjBAHzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:55:01 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D8B83EF
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 23:55:00 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id j17so28049365lfr.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 23:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AhWiO+p9x9WvJVlyCm4UKDXTp9wp+AugKSgLzsEWkSM=;
        b=OdJg2J6Fq6RC82L5qiRdzhcICkRaa401c3XJ2z4UaFlMfxJKql91GEJx7wXFlJVWE9
         0A6Om5ynV19o1g4U4YEgXL3F9N3M2qWRW235OQjFfXjasRJ6/l0jk8NLK0KfiL4rrtdU
         Pf9qXK4GH8MMjaWRpP7xFI2T5uA1Kq4pPdMej6r+Zd6XVOc3U/u4q8H0oVYNnFUAdLJK
         kW8F9YgI5S9MNzkGn0k3dA0kbR/dejUsXZF2EpBwuhpXbp6cp+S0JHdpLllffej2Yxv+
         hrzcJLTbqGW2N53Vy5oy40/ehsFCWUFmVi3Ps7oGUo90bHhBIwfDnTHGH4s0Z3Of5RKH
         XVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AhWiO+p9x9WvJVlyCm4UKDXTp9wp+AugKSgLzsEWkSM=;
        b=7vp7cGDYyuhPXrMbMZnaHRq1Nhj9iX9l3kL1KqBaEF7zTVdvzFTopRP1yv8KgD2tdY
         KgI2t3Jj8Fa0rgyr0vtUE0FqfstBzuZ896iMnGARI7L8tCQT9kxj20Fid+LNb8631/IK
         DjotAlLnkpY9fSrfXoQQL6g6RCo4s7xruZuapDs4c4s5aSMbiGTCwUzYiG6FZ3o1jYkd
         4A1OpFbZ0tD6Pmjr3JeML+r+fFCQ7A5M8OTjR+LJxRxH+k5An0AjfOGLJzbclAY/IWQn
         2w4q5U0GMo709XjkEJODq3sSnyBS2lr6MgDGg6cv5n6GT7aEddKgCNa8qwZkE0iTv3SI
         hweQ==
X-Gm-Message-State: AO0yUKVPfAiiPewfG34T8+0Hl4xc0lrk6DrmXiARUwoK3ELcz9QRgk6Y
        ciEEH+FiIcc7jfaRxiLwbGDEaGUklmiEa2w+gWNOjW6pGSZNOdTMJ4s=
X-Google-Smtp-Source: AK7set8NtXvm0jBebiwKSfALgi6I403BGuRww4o1r00RYIWc+fbOyjqqE766o8ePH49oxCqyY/IBFexla9RPfxtC6LA=
X-Received: by 2002:ac2:5336:0:b0:4b5:2aed:39be with SMTP id
 f22-20020ac25336000000b004b52aed39bemr206347lfh.195.1675238098213; Tue, 31
 Jan 2023 23:54:58 -0800 (PST)
MIME-Version: 1.0
References: <000000000000d7eced05f01fa8d0@google.com> <000000000000171a2805f38bf07a@google.com>
In-Reply-To: <000000000000171a2805f38bf07a@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 1 Feb 2023 08:54:46 +0100
Message-ID: <CACT4Y+ZRU8PZVNEyuWr_CMqyGHtV8O9vG_kf7zQK3uhbQ=0pKg@mail.gmail.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in mi_find_attr
To:     syzbot <syzbot+8ebb469b64740648f1c3@syzkaller.appspotmail.com>
Cc:     almaz.alexandrovich@paragon-software.com, edward.lo@ambergroup.io,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
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

On Tue, 31 Jan 2023 at 10:27, syzbot
<syzbot+8ebb469b64740648f1c3@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 4f1dc7d9756e66f3f876839ea174df2e656b7f79
> Author: Edward Lo <edward.lo@ambergroup.io>
> Date:   Fri Sep 9 01:04:00 2022 +0000
>
>     fs/ntfs3: Validate attribute name offset
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12e74535480000
> start commit:   e2ca6ba6ba01 Merge tag 'mm-stable-2022-12-13' of git://git..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a6133b41a9a0f500
> dashboard link: https://syzkaller.appspot.com/bug?extid=8ebb469b64740648f1c3
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fb2ad0480000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164513e0480000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: fs/ntfs3: Validate attribute name offset
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks reasonable, let's close the bug report:

#syz fix: fs/ntfs3: Validate attribute name offset
