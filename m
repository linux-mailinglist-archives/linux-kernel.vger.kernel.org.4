Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7DE686157
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 09:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjBAIMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 03:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjBAIMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 03:12:50 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47894B75C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 00:12:48 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id b14so5865713ljr.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 00:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qU6H97cBHYDDiWOXv9FIJjK9ZhqfSabXbV56hNDgUkM=;
        b=FO3joSiwJ15G65yaolk11DKwExcbJYVk+OHkxicW2LpEeUHnQj85UOQxGBXofFteam
         BFdm4p6cOieu4rQ9fLeIkYGd9xVnOt8OUiLfYxbIY0ESzwjujB7NLPGZboC4s0G6PTXw
         DhsZAPvboBoP0gohq/jEP83wk6q0zVfXSHaMZXMXVuu1rSwSaJTJsxZwvE4hvAZVpF0L
         eBxW/YtfsX3WcapBViHxPQ/RG57e9X6q85wtwM+wX7BAv7FEjd8zY4AxHUOZN6i/90OX
         SZKQPTPKVdbjUEZR5e9MmkcoQvc73LoHq4KBtBqgnwxfy26Urf44Yzjb3hvcMy+x/thC
         Td4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qU6H97cBHYDDiWOXv9FIJjK9ZhqfSabXbV56hNDgUkM=;
        b=LpYqNAOTwjfp0L2gE/lQHTvOYVn6XAl0hv3bNEHn3wbTnQW8VajksJsMoAxcmWx3pG
         73Bkn/ptQjag6rb20knJw4I1K+BS+8a8Dk6Aw7bPDEdhGGtJhZwYGIg7+APzBn69au3f
         vopUV+jXSkcwJ0j0ggChAIxxcgEsJNKKILNzjqgSbJ+Qcd6uPE93gczkw6CbPX7PLzya
         i/FQna+gLs73EjECT7LerSZ1Wxt/lmu2foWFnIG3Mbrzz18NqOYOp6MAOhSchTJ6QGgw
         b9mbsiFVpDAYihjDNDKUg8PSE3VYv4dTOs6r2E1hDgZbJY0LPhDi2cyAYstRPHGdjs8g
         oSPg==
X-Gm-Message-State: AO0yUKXUlGianrmK3lJX3nKONBUn7O95Xtx6QFkyymvkvnL8thmHg8es
        g+861yZAPPL0JBJy3ueaAGc04oSpwNlFfvJS/6SEjw==
X-Google-Smtp-Source: AK7set/7TOyZJsj8rmpwhEYuSjp5B1B9e0Avb97Fk47NdCdy9i8ErxI2tA0pm5PiKRmAoYhEyz7UjowFofra5SwuZRM=
X-Received: by 2002:a05:651c:200a:b0:290:7c00:8cee with SMTP id
 s10-20020a05651c200a00b002907c008ceemr154449ljo.144.1675239167025; Wed, 01
 Feb 2023 00:12:47 -0800 (PST)
MIME-Version: 1.0
References: <00000000000010d44905f01bf8e7@google.com> <0000000000007dd57305f3975d7d@google.com>
In-Reply-To: <0000000000007dd57305f3975d7d@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 1 Feb 2023 09:12:34 +0100
Message-ID: <CACT4Y+Z+u3PwPxyV+Mdbw57CrQFCdEuhmZN2i4_pKGvTCy+12w@mail.gmail.com>
Subject: Re: [syzbot] [ntfs3?] BUG: unable to handle kernel NULL pointer
 dereference in ntfs_sparse_cluster
To:     syzbot <syzbot+deb631beeb93bdb2df4c@syzkaller.appspotmail.com>
Cc:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Feb 2023 at 00:05, syzbot
<syzbot+deb631beeb93bdb2df4c@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit c380b52f6c5702cc4bdda5e6d456d6c19a201a0b
> Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> Date:   Fri Oct 7 11:02:36 2022 +0000
>
>     fs/ntfs3: Change new sparse cluster processing
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1377b979480000
> start commit:   e2ca6ba6ba01 Merge tag 'mm-stable-2022-12-13' of git://git..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=276eb8ff64eb2c27
> dashboard link: https://syzkaller.appspot.com/bug?extid=deb631beeb93bdb2df4c
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d8601b880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a09c93880000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: fs/ntfs3: Change new sparse cluster processing
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks reasonable, let's close the bug so that syzbot reports similar
bugs in future:

#syz fix: fs/ntfs3: Change new sparse cluster processing
