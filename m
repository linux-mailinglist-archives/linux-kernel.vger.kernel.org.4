Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3BB6807C3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbjA3Is2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbjA3Is0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:48:26 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB86FB
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 00:48:00 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id f34so17853122lfv.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 00:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8TjYrkDsK6yPh84aPbosRJZw6roXrwTWLBrSTolIxuA=;
        b=EOPi1f4PhNW8zMtICF44BKx0E45GpHOXt3JJtGhNl7RHwQaB777/tjHXv340DArSLW
         UOJ7aMsLn9ChCVVwbB4TipfuHXGETdPfw9J0qlGi09p795ccHwVFPUze0Q8hH0eRGbqa
         6IBTs0IGSyOE1s3izidQ6TnRNZpN4VO+YZKAfZzkcIveglXU19dQEnuOtDoYcfT2pnqW
         1C8UpPPYjT8SoDmaRrP/Yq9p8yLS5+HIkkhIRxAZ/xH3H8Qykc6fXhQgGa0cZMZZBSc9
         9HOCzwIaIfJxrNnFPnDbp6vdzKjpkxXpFB4u5tjB8HrAaewj79OxNT9fiQJgdE+AyFpn
         I1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TjYrkDsK6yPh84aPbosRJZw6roXrwTWLBrSTolIxuA=;
        b=R0egtO5ZVaYedS3NriEDToBXbKOphLEi6Y7kAjeJgYo7EAtFxSGde2Q1uuqNLMQoug
         ZNy1iw7kN3M+SyTc8K0BzplM9DLQBSQlzwIFZey7L/0LD1R0ThTz1LDu7SA06fs3OL0Q
         pSEsXtJdjjFMFJEu085geBXgDD+/MrUkSO86Goowx89zXxAzwPnYVMyv2WD47Yk/s8XU
         a+Fr0RGu+BzJgzTfNyWP25LZaT1WSBr3HBCG1z2pmSUMnplDnS9qtVq1AiZkZO3QqbJB
         08N8AFzqxVzYPbMS2gwptAXrUq/9OssKmMGMqOj63m3Lg2DALgfTRT2yGanKsEu4eZph
         DnFQ==
X-Gm-Message-State: AFqh2krhFMfkJDsUZBbt9laVk1d1CG8Gw0zKTregltMC9V3DcRSHwhWd
        SliMGT5KFjtsgwHjUn7vyV5yDhCMtMH4O+o6CcXbQA==
X-Google-Smtp-Source: AMrXdXt7y5vMXZIG9DYJ+X2Yi72vbKoqU45iffpH2rKNAKrqtwPz8QtByBV3oMBVvAdRSJhA4f+cSzfB/zrvXXCz3F0=
X-Received: by 2002:a05:6512:250b:b0:4d4:fcdb:6376 with SMTP id
 be11-20020a056512250b00b004d4fcdb6376mr6074442lfb.218.1675068478212; Mon, 30
 Jan 2023 00:47:58 -0800 (PST)
MIME-Version: 1.0
References: <00000000000076699c05ed7c54a2@google.com> <00000000000091f75805f3627ddd@google.com>
In-Reply-To: <00000000000091f75805f3627ddd@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 30 Jan 2023 09:47:45 +0100
Message-ID: <CACT4Y+bUreYncw=xFEf_qvrKJ8GKgzstv8BF8LBWTD=XOj_vXw@mail.gmail.com>
Subject: Re: [syzbot] possible deadlock in btrfs_commit_transaction
To:     syzbot <syzbot+52d708a0bca2efc4c9df@syzkaller.appspotmail.com>
Cc:     anand.jain@oracle.com, clm@fb.com, dsterba@suse.com,
        hdanton@sina.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Sun, 29 Jan 2023 at 09:00, syzbot
<syzbot+52d708a0bca2efc4c9df@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit b740d806166979488e798e41743aaec051f2443f
> Author: Josef Bacik <josef@toxicpanda.com>
> Date:   Mon Nov 7 16:44:51 2022 +0000
>
>     btrfs: free btrfs_path before copying root refs to userspace
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e58bae480000
> start commit:   08ad43d554ba Merge tag 'net-6.1-rc7' of git://git.kernel.o..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
> dashboard link: https://syzkaller.appspot.com/bug?extid=52d708a0bca2efc4c9df
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114d3e03880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1320ea4b880000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: btrfs: free btrfs_path before copying root refs to userspace
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks reasonable:

#syz fix: btrfs: free btrfs_path before copying root refs to userspace
