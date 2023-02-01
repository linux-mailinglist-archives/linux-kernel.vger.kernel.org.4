Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF75686101
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjBAHyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjBAHye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:54:34 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E0D83EF
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 23:54:31 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id br9so28023988lfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 23:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0diAaeCGuTZlOnZxWXSitLoB/1kBFfQP3ozqLMthdrY=;
        b=lF1UqyudEA09FkqGGF5NmMuHvah8KKfPO3eWxAubAvEp7iQ9LhiLV+T8p4K8BfqCkI
         o5XDl4XUegL87wDptfNUHusoDNEWwR3kFLY8uWxHBNe6XtsuzkcfE7wHub8jBpu78zJ3
         8u1P4xOeiohBEfpUULqu61VPZz9Xew9ZVJI6Yz75XRZe614dAnDNrWbqS7E5xSrbl2U7
         96TkvetBtlpEr4RcP2JS1DfMs9a6a2wTTGBG1810gECpndWZgdeP3309sd66sbxpUGhw
         AE378mpGhvx2hHZVLhvgMzMtgL07iSV3ITOMMuFfTEgj1ZCx285Z7z0BsGCManr5FYdf
         DJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0diAaeCGuTZlOnZxWXSitLoB/1kBFfQP3ozqLMthdrY=;
        b=tE5rFMAiq/mxds8vlp6gtrxtYSF/08sLSDcZ5ko6mMH48jNhPxuJhRDLofE21JRXMk
         uOEILO5d5g8JFKAkEqdc51Omyr20YNYpllYr+F+K+vecn3fKdH5ZJdy/211Rd/78s7PG
         i4vEzg2pwaTobIq0Mn0TETd8hkUFa4GC0ypfv1HjqvbEtD+b/faE/UJc+slhfJOsYgAj
         +mhxbguzwGpIESKgDINO0eM2RsfprEJTmrOvy5/xZmOj/kv1F87Gyhx1VqTFKJYyTXwk
         Rkf9QwPDwulBJT9nOLObkZYjqD/vY+anvRHctf8IrphyhUDqla1p+QI8L+s/wEe4b+VQ
         CuqQ==
X-Gm-Message-State: AO0yUKWrxQbrXdX0tN99Xh8mITkGL4lJTUCWjZrDn9/3ceBFnGEHxpN7
        7ZxTDIS5NNpJ/mzCzhG19meWnI3LDoJJb6KCEXwgeg==
X-Google-Smtp-Source: AK7set/pcUtZ6NpoWDLM7Q0eQN46Pgx8dTWbO5ck5QVBIuUe66c4GmhgfonlDo7ZR0OVUA9vhbz0YNjfIAEBW1Cds4k=
X-Received: by 2002:a05:6512:b01:b0:4cc:8686:8c87 with SMTP id
 w1-20020a0565120b0100b004cc86868c87mr152383lfu.188.1675238069550; Tue, 31 Jan
 2023 23:54:29 -0800 (PST)
MIME-Version: 1.0
References: <0000000000008be6b405f01164f8@google.com> <0000000000005eca3205f391aade@google.com>
In-Reply-To: <0000000000005eca3205f391aade@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 1 Feb 2023 08:54:16 +0100
Message-ID: <CACT4Y+Ym4=mzMO6XNB0fYQJMo_QvUpYwkC1K7cmwr_XwKSdwzA@mail.gmail.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: out-of-bounds Read in ntfs_set_ea
To:     syzbot <syzbot+8778f030156c6cd16d72@syzkaller.appspotmail.com>
Cc:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
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

On Tue, 31 Jan 2023 at 17:17, syzbot
<syzbot+8778f030156c6cd16d72@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 0e8235d28f3a0e9eda9f02ff67ee566d5f42b66b
> Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> Date:   Mon Oct 10 10:15:33 2022 +0000
>
>     fs/ntfs3: Check fields while reading
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11d9c385480000
> start commit:   02bf43c7b7f7 Merge tag 'fs.xattr.simple.rework.rbtree.rwlo..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8c59170b68d26a55
> dashboard link: https://syzkaller.appspot.com/bug?extid=8778f030156c6cd16d72
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136b8f57880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=175ca3a3880000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: fs/ntfs3: Check fields while reading
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks reasonable, let's close the bug report:

#syz fix: fs/ntfs3: Check fields while reading
