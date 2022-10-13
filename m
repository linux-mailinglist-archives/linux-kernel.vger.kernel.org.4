Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1803D5FD5DE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 10:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiJMIC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 04:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiJMICW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 04:02:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C595FC1C0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 01:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665648140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f+AKjn776JnFnk+JANcNLxbvGEj0GXIiAWMew/HeW2M=;
        b=jWY5s0lnZ6TP+ttYxb1NZIu+59kP5WDlVrEGY2FD1/PUqHwjfVanGQWy4hQVLyKenhBM0Y
        kOLNy/V+ELW6Kt36UDb+472uOb5azefII5swtjS+zFq8DyYXOMUXHS7rUvYjOmI2wxrNDJ
        1Ran6r3gOlSxH67zlwtkUTrhWUJ44dA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-111-wqeUa_TSO2KkhfYA2lEnGQ-1; Thu, 13 Oct 2022 04:02:19 -0400
X-MC-Unique: wqeUa_TSO2KkhfYA2lEnGQ-1
Received: by mail-qt1-f198.google.com with SMTP id ew15-20020a05622a514f00b0035cb76e35e5so638641qtb.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 01:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f+AKjn776JnFnk+JANcNLxbvGEj0GXIiAWMew/HeW2M=;
        b=WYJiICju8M/0EgnmT1aKjc3Z95CJYNTw28bNE/LojkDkzlLVuQoiVoDETLWOWqRwju
         yuMSwmrHY8AzaoaSmjXssTuA/aK6Qi/OXdx9CKMcKD8iFcCqNIr+N50q7pyQjQjxzOn/
         dKzmIP4Lj8C+VSdlLH/DNgGR1d66UTnNGNouYwESVhae+4gIikYzl+q4Gg3QHdJU8V6+
         jJvPdUUqsXezzq30Cg5wLG6ta7wC6k2fYrPmDFjaeV7yYW9ojsyPwiv9E8qCk0gnK7wS
         ff0FhRklZFMvR/I50SK/5xeNln0Vw/eGnlBR9vNQmSYVKBow+KgXxEn6Mp8a5q9CzVCu
         TsyQ==
X-Gm-Message-State: ACrzQf2a2CRHfvvqU5BS/MumAaFwqJ2rpxlkBdwnO+ReXqCx/0rPP1aY
        Wi94EVU7hUf1wx65jRMvCsy+LHdf+tc7Lj/hp7EjSIbM5IscTm0CRotl7wA8MJwK17COv7YC3lq
        kW/6VLZ0HaYVB4/eWB5FzTE0S
X-Received: by 2002:a05:620a:2409:b0:6ec:5325:340c with SMTP id d9-20020a05620a240900b006ec5325340cmr16070431qkn.300.1665648138194;
        Thu, 13 Oct 2022 01:02:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5gYst2dDC7+y/0aTJNhpsYBAy8KZArhfdL8xoMvfUKW4qQJzfGMJu7ds6BCroXdT05G9jBUA==
X-Received: by 2002:a05:620a:2409:b0:6ec:5325:340c with SMTP id d9-20020a05620a240900b006ec5325340cmr16070418qkn.300.1665648137927;
        Thu, 13 Oct 2022 01:02:17 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-103-235.dyn.eolo.it. [146.241.103.235])
        by smtp.gmail.com with ESMTPSA id w19-20020ac87e93000000b00399b73d06f0sm9362207qtj.38.2022.10.13.01.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 01:02:17 -0700 (PDT)
Message-ID: <5ff75959614e10c102c90ae3af744209f4d30a5f.camel@redhat.com>
Subject: Re: [syzbot] WARNING in ovs_dp_cmd_new (2)
From:   Paolo Abeni <pabeni@redhat.com>
To:     syzbot <syzbot+6c1a3b18294de0f138d8@syzkaller.appspotmail.com>,
        davem@davemloft.net, dev@openvswitch.org, edumazet@google.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pshelar@ovn.org,
        syzkaller-bugs@googlegroups.com
Date:   Thu, 13 Oct 2022 10:02:13 +0200
In-Reply-To: <0000000000008bdd0305ead9cb9f@google.com>
References: <0000000000008bdd0305ead9cb9f@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-10-12 at 10:33 -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    e8bc52cb8df8 Merge tag 'driver-core-6.1-rc1' of git://git...
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1112f08a880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1b85abe77fd80fd6
> dashboard link: https://syzkaller.appspot.com/bug?extid=6c1a3b18294de0f138d8
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1112607c880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=144b0ca4880000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/40287b1866de/disk-e8bc52cb.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1ef7d0e94dfc/vmlinux-e8bc52cb.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6c1a3b18294de0f138d8@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> Dropping previously announced user features
> WARNING: CPU: 1 PID: 3616 at net/openvswitch/datapath.c:1619 ovs_dp_reset_user_features net/openvswitch/datapath.c:1619 [inline]
> WARNING: CPU: 1 PID: 3616 at net/openvswitch/datapath.c:1619 ovs_dp_cmd_new+0xdf5/0x1300 net/openvswitch/datapath.c:1822
> Modules linked in:
> CPU: 1 PID: 3616 Comm: syz-executor259 Not tainted 6.0.0-syzkaller-07994-ge8bc52cb8df8 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
> RIP: 0010:ovs_dp_reset_user_features net/openvswitch/datapath.c:1619 [inline]
> RIP: 0010:ovs_dp_cmd_new+0xdf5/0x1300 net/openvswitch/datapath.c:1822
> Code: 2a 0f b6 04 02 84 c0 74 04 3c 03 7e 21 c7 43 68 00 00 00 00 e9 30 fe ff ff e8 b7 fe 53 f8 48 c7 c7 00 13 21 8b e8 c7 a5 16 00 <0f> 0b eb be 4c 89 e7 e8 9f 14 a1 f8 eb d5 e8 38 14 a1 f8 e9 3f ff
> RSP: 0018:ffffc90003f0f4e8 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: ffff8880126fa000 RCX: 0000000000000000
> RDX: ffff88801e751d80 RSI: ffffffff8160f738 RDI: fffff520007e1e8f
> RBP: ffff888016a0ae00 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000080000000 R11: 676e6970706f7244 R12: ffff8880126fa068
> R13: 0000000000000008 R14: ffff888016a0ae58 R15: ffff8880266cd880
> FS:  000055555626b300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000916 CR3: 00000000265ee000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  genl_family_rcv_msg_doit+0x228/0x320 net/netlink/genetlink.c:731
>  genl_family_rcv_msg net/netlink/genetlink.c:808 [inline]
>  genl_rcv_msg+0x441/0x780 net/netlink/genetlink.c:825
>  netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2540
>  genl_rcv+0x24/0x40 net/netlink/genetlink.c:836
>  netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
>  netlink_unicast+0x543/0x7f0 net/netlink/af_netlink.c:1345
>  netlink_sendmsg+0x917/0xe10 net/netlink/af_netlink.c:1921
>  sock_sendmsg_nosec net/socket.c:714 [inline]
>  sock_sendmsg+0xcf/0x120 net/socket.c:734
>  ____sys_sendmsg+0x712/0x8c0 net/socket.c:2482
>  ___sys_sendmsg+0x110/0x1b0 net/socket.c:2536
>  __sys_sendmsg+0xf3/0x1c0 net/socket.c:2565
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f9aa25fce89
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff35f65558 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00000000000095e8 RCX: 00007f9aa25fce89
> RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 00007fff35f656f8 R09: 00007fff35f656f8
> R10: 00007fff35f64fd0 R11: 0000000000000246 R12: 00007fff35f6556c
> R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches

#syz dup: WARNING in ovs_dp_reset_user_features

