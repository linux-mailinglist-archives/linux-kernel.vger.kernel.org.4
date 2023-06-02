Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BD571FFD8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbjFBK6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235190AbjFBK6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:58:04 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E69123
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:58:03 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-33bf12b5fb5so78605ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 03:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685703482; x=1688295482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+R6ScZ/Un56g/QDJNYbFzDtHds5teBRsW9jLy+uI24=;
        b=1AXjAvflwc/uJbp/lBd/8rKNARlBO3y4OaLnZbCJui3lEWgw9Tsp7i5C95x9TRdfkH
         h68IwoM/XROIOZ4oSQuK30RHZziBey2MmTLrZjK1BvGsb4b5XeRPTty3uA2KSstG3CRT
         uIpm3VoLAi1RWtqrO18bXgi/GP2pYH0Gldr5t/hhQN1zBEVVaN2UCjm9gRVDPoyLOsbC
         OR2ub1aoyFpyTjKqnNmyht1plhwqk0BYS94bu+MbfL18CyzI5uv3zV/Ij3RDrjyCjxMs
         cXIkApmTJMZUzCnnp5QhujvQ+jknP0LfPqUqX1tHeaSvvDfM56oeG0hyCydQqUimUUUG
         OgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685703482; x=1688295482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+R6ScZ/Un56g/QDJNYbFzDtHds5teBRsW9jLy+uI24=;
        b=blDixVnK4xHAh8bqr5epEibChySiSypclzh21j+XAGn2bQU4055ouKkenqQvN+5YFu
         sRPV6TEpcMC2iYu00yh4t7BQVPaCYn7RQxkBoOCaOV7NbW5235oAp2ssE4KGWErdwsg/
         kbcq8g+HJ/Mh7BHgmsMDe+/qCRoxWU1mTgU59+szd9Tsmfg1jjKE5PRxtV4G/sQaqCfI
         2hFQ0vBqCr7FTDAbWou6MVM5ufmh77Odlra7w4cpZM4T0x3EiAOO0xCPo5GrJ5q6++wG
         SDvUcNq8Ik8kbdBBuhSwsXrzISX59l1qEXhn0/STox3UfG07JeDrHgzIkHKs8KDFQGLq
         5LqQ==
X-Gm-Message-State: AC+VfDyu6Alia27SrGF915eC53bTrUrxevxpE1uxGZM2IULbGdFZhaqP
        c3VSiZ5Wo0xL+ZIJdGM51Btg5VwLJyY79zHUEFGbPg==
X-Google-Smtp-Source: ACHHUZ4XzLlFhxj34TA+VRTk3cwSLwKaDIj9MmihQ/k+sNQL3X+68B23BasAbzjIInkv8Zd9eGTJbq0bcKczNhcOwgU=
X-Received: by 2002:a05:6e02:1785:b0:33a:e716:a766 with SMTP id
 y5-20020a056e02178500b0033ae716a766mr206692ilu.20.1685703482599; Fri, 02 Jun
 2023 03:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000015ac7905e97ebaed@google.com> <00000000000017cc6205fd233643@google.com>
In-Reply-To: <00000000000017cc6205fd233643@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Fri, 2 Jun 2023 12:57:51 +0200
Message-ID: <CANp29Y7kwQnezWxMZSQ=rFAky-Jn4SmMVqUh77tssnFYOUc=Kg@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in rdma_close
To:     syzbot <syzbot+67d13108d855f451cafc@syzkaller.appspotmail.com>
Cc:     asmadeus@codewreck.org, dan.carpenter@oracle.com,
        davem@davemloft.net, edumazet@google.com, ericvh@gmail.com,
        kuba@kernel.org, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux_oss@crudebyte.com, lucho@ionkov.net, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
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

Looks like the guilty patch was just edited -next.

As there's no fixing commit, let's just invalidate the bug:

#syz invalid

On Fri, Jun 2, 2023 at 12:42=E2=80=AFPM syzbot
<syzbot+67d13108d855f451cafc@syzkaller.appspotmail.com> wrote:
>
> This bug is marked as fixed by commit:
> 9p: client_create/destroy: only call trans_mod->close after create
>
> But I can't find it in the tested trees[1] for more than 90 days.
> Is it a correct commit? Please update it by replying:
>
> #syz fix: exact-commit-title
>
> Until then the bug is still considered open and new crashes with
> the same signature are ignored.
>
> Kernel: Linux
> Dashboard link: https://syzkaller.appspot.com/bug?extid=3D67d13108d855f45=
1cafc
>
> ---
> [1] I expect the commit to be present in:
>
> 1. for-kernelci branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
>
> 2. master branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
>
> 3. master branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git
>
> 4. main branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
>
> The full list of 10 trees can be found at
> https://syzkaller.appspot.com/upstream/repos
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/00000000000017cc6205fd233643%40google.com.
