Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBE66990A8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBPKE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBPKEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:04:23 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE26D4DBFE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:04:19 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id y25so2093210lfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iC4G6Chpv1TwtaQwrHEgm0cQhdw6ILUAcXbBMMjaI3I=;
        b=OC41sN/IZzwtlfqWw88+8lhJoyzGOPS0Kj4SBGJ7/81+5c8vboPc13pf0GlMGe99dV
         X9/gS+o08YrGj0NhSF2Tpi81ZF5ifQcA8vLA12LNjFTJgKi7dscPo25tQwrKJNAOXC3r
         gzJ192bgsCiZ/qImclprAJ0Ne4qP+2UqEsyGtO9CI7axJVZAG08llLN8VBodKnDDG4Vw
         pQyKp6e525LKacW3b4d78Zn5b0r2PeaWcdenpltgwXXdJSyQ6cFIFXSnl1SpvuucBXhB
         7o3O2n8x7EE8xiHgDCMdbVIq6CmSD1A9kG0idn5KdmXoucBbX0VXr9Dcm42G9tEmeM3l
         qPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iC4G6Chpv1TwtaQwrHEgm0cQhdw6ILUAcXbBMMjaI3I=;
        b=ylRsr38SZ7Ocj9ueMycBwCqa0AoTsas0DHPkoYt8M9mdlh/8JLsBTlt7sEoqonabOV
         C4NLPVNf5sjr/nA/PA7VA3dl4qq08G8AOV+AmIirQBQrFUjmoGcpWhDddwUQ7zfbyHME
         HiD6EuQlWPHbj2bb2auQPkM0a7FD5DMZAmQnsAik1OFTo3aSlIGWszbudUd/uoppqTxf
         Z+bH6+Un8N1ZsWoK3+kkWN2O6EFqgdE6gRCySXkXIV6nui/UxCzyOzIdZwcyNBjew0KP
         2U7mJJjkOHossc6scB3JhtmnWLNoAMoB2AWLBjaJ4//TaThiLfw/GN3EJ6RnMT6yorgZ
         RqiA==
X-Gm-Message-State: AO0yUKW3ptGcAAKFzVZMsYzKuJtT54NmSxtxd7iO6HkOTp3S1SjNmJhu
        e7TJVAzYOmuB8CCXJENrZ3QUrL39ubjuT7SnvjyTpQ==
X-Google-Smtp-Source: AK7set8DBh29ZMgrX8CBnHNMbWMxKn/kt4U0dnk9NpCe5ik8g7wyoxdQMEgGbV+W3gg4GFVBxJuwXanX9utnx96XXnA=
X-Received: by 2002:ac2:54b8:0:b0:4db:2c5a:e4f6 with SMTP id
 w24-20020ac254b8000000b004db2c5ae4f6mr1462667lfk.3.1676541858071; Thu, 16 Feb
 2023 02:04:18 -0800 (PST)
MIME-Version: 1.0
References: <000000000000035bbc05f4ce4501@google.com>
In-Reply-To: <000000000000035bbc05f4ce4501@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 16 Feb 2023 11:04:05 +0100
Message-ID: <CACT4Y+YzZb2vscjBLiJ-p-ghbu77o851gbESfE=nZebXqfgE4g@mail.gmail.com>
Subject: Re: [syzbot] WARNING: stack going in the wrong direction? at __sys_setsockopt
To:     syzbot <syzbot+91c3651bb190d53b4d16@syzkaller.appspotmail.com>,
        jpoimboe@kernel.org, Ingo Molnar <mingo@kernel.org>
Cc:     bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        richardcochran@gmail.com, syzkaller-bugs@googlegroups.com
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

On Thu, 16 Feb 2023 at 11:00, syzbot
<syzbot+91c3651bb190d53b4d16@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    9d9019bcea1a Add linux-next specific files for 20230215
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=11ad7710c80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=60f48e09dc64b527
> dashboard link: https://syzkaller.appspot.com/bug?extid=91c3651bb190d53b4d16
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/7a22fa9fb779/disk-9d9019bc.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/68851ce42fd7/vmlinux-9d9019bc.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/09be0a2c410b/bzImage-9d9019bc.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+91c3651bb190d53b4d16@syzkaller.appspotmail.com
>
> WARNING: stack going in the wrong direction? at __sys_setsockopt+0x2c6/0x5b0 net/socket.c:2271

+Josh, Ingo,

Yesterday we started seeing lots of "stack going in the wrong
direction" all over the kernel.

I see there is only your recent commit to ORC unwinder:
"x86/unwind/orc: Add 'signal' field to ORC metadata"

Can it be related?


> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
