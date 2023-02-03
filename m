Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87107688ECD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 06:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjBCFH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 00:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjBCFHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 00:07:55 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D236440C9
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 21:07:54 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id h24so6218583lfv.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 21:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dSI47TN1rvpQZQfzrMXdYQdHL57hkynNgY6fDRFFlN4=;
        b=UTcc51f+Jh6rBfVA0K8Gf8DRxVq0kI4W7jOIALB6af2YUvG0i8Tv8DCXEuSRlLa7a0
         C1ZVWOtxx0wpExXVmqVM2JnVxIpacZva/f3Fs6zPAlV9ts+R/oNNAdEnDz3/iPt9A+6U
         ZegmZ4KOGVfykFJfwNU+nsPW0IIJphBkZuwgKDmrxhOovy6WWkL2GX8phI/dkZt7AZpc
         gRJ4YdSMTgNioIKg2Dqh7q8QMVZg3whkK+i/PXVHBYi42Zy6jhmIHVK0v76jJ+hgaOId
         E5kGfJpD2Oa2kboOxRtKNz0I62p48a1Met52452dLnmiDhHzSq0XegfUVwMwZvruWgJp
         9fgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dSI47TN1rvpQZQfzrMXdYQdHL57hkynNgY6fDRFFlN4=;
        b=rvmNdhK15XxEeiUm9TvZOolSFkTGs3S4GhAZ+KHXrTZjGXzlW3DszGKlZdgj3iofdJ
         4FePOZAzlPVXqAEhFPJrfIQG+YpLoZEPwkhCQd2uuSBxnffv/SQCgCcDCFFRj+vwFyFu
         8XC85+/bxMKPpma66FDnRvsaoAVXsFKOmJUtipHt5IcsTotxxbF+0lZmXVbavjci9ikG
         Mx8dKNIk/8sgvpF1ljKs6eJBcRUKdBYtkGCXBE9zhl17PV+zeyqdiSm7IoLz9za+DrvR
         zK0yjAfht9KXEFQg7bYOAHi/nXeYZT6m7JRxL4aVX1L9P8pSbzKRr2buvDjMqKylIsqx
         7BFw==
X-Gm-Message-State: AO0yUKVlu3l6l1jXNTu3c2UL3spnyE7sNeIa6yzqjf0GkIgKzNcEFcmq
        YmqCm2jr/iCh5w24SFt+E+95chzPHcTL7QjPJD5a/g==
X-Google-Smtp-Source: AK7set/QQMcSjP18PtuXeZRhLR2/W2UW755nYMG0W6Md1KoY4A19NKki1v6DMYCVH/30aIkpfpN4CfdW7+5JTAkq3Ys=
X-Received: by 2002:a05:6512:32c8:b0:4d8:5d6a:4 with SMTP id
 f8-20020a05651232c800b004d85d6a0004mr1699418lfg.107.1675400872846; Thu, 02
 Feb 2023 21:07:52 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009da4c705dcb87735@google.com> <0000000000007a0f9905f3bf9d9d@google.com>
In-Reply-To: <0000000000007a0f9905f3bf9d9d@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 3 Feb 2023 06:07:39 +0100
Message-ID: <CACT4Y+Y6sCOwGKKcOyv+Qtjai0AX==Rg7pnjLXbeSO-d7LDAaw@mail.gmail.com>
Subject: Re: [syzbot] WARNING in check_map_prog_compatibility
To:     syzbot <syzbot+e3f8d4df1e1981a97abb@syzkaller.appspotmail.com>
Cc:     andrii.nakryiko@gmail.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com,
        jolsa@kernel.org, kafai@fb.com, kpsingh@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, martin.lau@linux.dev, memxor@gmail.com,
        nathan@kernel.org, ndesaulniers@google.com, netdev@vger.kernel.org,
        sdf@google.com, song@kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Feb 2023 at 00:06, syzbot
<syzbot+e3f8d4df1e1981a97abb@syzkaller.appspotmail.com> wrote:
>
> This bug is marked as fixed by commit:
> bpf: Relax the requirement to use preallocated hash maps in

Let' try to fix line wrapping in the commit title:

#syz fix:
bpf: Relax the requirement to use preallocated hash maps in tracing progs.


> But I can't find it in the tested trees[1] for more than 90 days.
> Is it a correct commit? Please update it by replying:
>
> #syz fix: exact-commit-title
>
> Until then the bug is still considered open and new crashes with
> the same signature are ignored.
>
> Kernel: Linux
> Dashboard link: https://syzkaller.appspot.com/bug?extid=e3f8d4df1e1981a97abb
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
> 4. master branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
>
> The full list of 10 trees can be found at
> https://syzkaller.appspot.com/upstream/repos
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000007a0f9905f3bf9d9d%40google.com.
