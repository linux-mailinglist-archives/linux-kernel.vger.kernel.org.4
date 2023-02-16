Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AF469987D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 16:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjBPPOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 10:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjBPPOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 10:14:40 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EBA3BDB4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 07:14:39 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bi36so3164771lfb.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 07:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kC8IDsKp/YgrN85NE+XVA1BnM3bDS0BQfGSyhvUIGb4=;
        b=RZpUIpKFzUdmqjbZEMGiiB9Kufmm/dFDN2TU8vniw04SUdpU2Z6r+ww/QT3sA3i4mx
         TFgzFODxvLWzZKKt5JtfxuhWvgUN6EGlm1jQzuBnrOYuuOzoWWQ+Mj1WwFMaUOHEuTPW
         vjd4sqEpAeraD6hMOAySj3w/dQ7jyStzxVIURNovpYg7ag3ZszfejCwxgJ47e0neaWtj
         YwJKTi5rHjPeU8O0Qc+pI4Hp+hszkuFU4FXS17qIAS97EBvVh5bmEt8SQYf6M8ewgTRy
         ZXSy9DTIWZGiXz6GFnhAgcJDZIjpW1dEHNjYwH/SUphHvO5Fqm2SI6LLqNInSXx26jTq
         gqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kC8IDsKp/YgrN85NE+XVA1BnM3bDS0BQfGSyhvUIGb4=;
        b=y4RyQ/4kOsga3q+HWn2F+UI/7ho28tWvCvRLj8qnhL0PMVHyOis23ClH6JCDh7c/tS
         BFKC0LgzDvarZhwwHTmVg9JgKkxIMS6wcqRfWi3eFM4XFoGwu7j/SkNi0RGGPWugcsFL
         DNpcXmeJi8wGzzGBMqr8ezqCBtuulWZ8PZQyy1a01uetlCWPy17w+jQUmticd1QbBoPw
         bzvTOUol0EcFp4CQuUPT4n7sCy2yHu+q1EwZeR3P6J+hSULajtoJ9999mdaoZOY/hkqy
         chZ66mveFZWFfPCq2VPgOClbyego89HKo/GUOgpaooundCeNRj7QtfxQrLq7/WNxoc59
         NYyg==
X-Gm-Message-State: AO0yUKVgZemBSGpl0A3CwcgaI6OSe/fPZoolUx/BXI4hn0zB2d8QBM2e
        TbYYEzxzeu0zzPMNhr0pqG929Muew350P4JaWR3f2A==
X-Google-Smtp-Source: AK7set+iSv+zZT0G6BTVkJ9rolzRwC/x6vvKNsH0/+uVnumcSPc+9wePCbMk+0milETGFHZln9wo7vhWTMppJuHUIr0=
X-Received: by 2002:ac2:5dd4:0:b0:4d5:ca42:e43a with SMTP id
 x20-20020ac25dd4000000b004d5ca42e43amr1751761lfq.3.1676560477452; Thu, 16 Feb
 2023 07:14:37 -0800 (PST)
MIME-Version: 1.0
References: <000000000000ff304105f4d1cd36@google.com>
In-Reply-To: <000000000000ff304105f4d1cd36@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 16 Feb 2023 16:14:25 +0100
Message-ID: <CACT4Y+Yq1knodAhoBnUe-Tf6QLrQCrGV5gyWC7An8poQDcfv6g@mail.gmail.com>
Subject: Re: [syzbot] WARNING: can't access registers at entry_SYSCALL_64_after_hwframe
To:     syzbot <syzbot+dac365e3ce07c3d0e496@syzkaller.appspotmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

On Thu, 16 Feb 2023 at 15:13, syzbot
<syzbot+dac365e3ce07c3d0e496@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    9d9019bcea1a Add linux-next specific files for 20230215
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=144edcc8c80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a64cbb8ad0da425e
> dashboard link: https://syzkaller.appspot.com/bug?extid=dac365e3ce07c3d0e496
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/70f0c6bb5351/disk-9d9019bc.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7eed8686df34/vmlinux-9d9019bc.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/84bb6da6b00e/bzImage-9d9019bc.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+dac365e3ce07c3d0e496@syzkaller.appspotmail.com
>
> WARNING: can't access registers at entry_SYSCALL_64_after_hwframe+0x63/0xcd


This is another splat of reports we started getting recently. Looks
like this may be ORC unwinder related as well.
