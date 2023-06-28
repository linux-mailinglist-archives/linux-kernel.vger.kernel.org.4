Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953B17410B2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjF1MFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjF1ME5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:04:57 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E1B19B9;
        Wed, 28 Jun 2023 05:04:53 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1b0156a1c49so3659726fac.0;
        Wed, 28 Jun 2023 05:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687953892; x=1690545892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Os7Pwyqw3adEnV0KjvNCFwkd44Etj7e3jY5PQec1TF8=;
        b=fi8e+2ZcxmgKVPZ9ZhCU7aBKItkYU2JS5tD4jOHUB88OGrsdJ7rW37/27firHmKzf+
         tK8XXoRBW4q1QSSN2hleweEDei/MubxxF/LjaBcGXrO2NS/EFAb4u/ArNK1NeS5aGuCg
         +5YHC9A96IzhuE7UovI5QBLxXYZ5H9ASqwSIvTLxztBFLQ+73dT7uK6DIbop6QqdPnDE
         r0TajFC67sxEeaAfdzREhfc3PpPZP8+5B09Oh613dJrDIK91wIewV/91c9AY/d8KGTvX
         tXQjy6LJYLWANVJ1ew1NG4wis/pEuYAFVJltAVz1Q/2XHktAr3itHQoZORbFbF55o3Q4
         i22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687953892; x=1690545892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Os7Pwyqw3adEnV0KjvNCFwkd44Etj7e3jY5PQec1TF8=;
        b=fVTytNsXbPzFix4pPU+tP4m//E5JKIqbb2mYGx9SJnEmYm72yvvbUahfoVtKqbV4GV
         FxAw8Uo4jfO1ax5afxR9EO8NjWnTZ2H2jmkUUMa8KrDJJbPpf/TkbrgxwwqjGbUQUrag
         12/yD+zWkIXrtadIGx/0bwBO66lb0GEAMiKly5IpShNL/gUmTpyj/mkkduYDQovlYX7P
         G9yZxDFRRUCvD3F2q0YT5KUsKrY5w/07kakvd1VpQAV2qoNqBYtAXokZOWQSIuvdR3WE
         Pv8yElmgqDnFR4AX1/Es/6CkqDv65sXkTD42h8Q8SUYLj1uhRKpQh1yGE0gqBtcN3gk1
         P01w==
X-Gm-Message-State: AC+VfDx0wkfbHJs5uIcvAhOa8K7j3+Fcw6ivAipjUbNCuNkcY2RB8EKK
        7JKVAElr9aQfeQzIzmeqRFnR2UmhZYQTpmrr2OQ=
X-Google-Smtp-Source: ACHHUZ4MbvpcTNEPLZwPHRUrUYwdRGQm6qwN4ptUAjISspGqqNQnvSW4Xad9fZkGQehZcx+K86q97yVFmEMkRE6UlEE=
X-Received: by 2002:a05:6870:131a:b0:1b0:4e46:7f12 with SMTP id
 26-20020a056870131a00b001b04e467f12mr5357713oab.43.1687953892198; Wed, 28 Jun
 2023 05:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZukiFq4A+b9+en_G85eVDNXMQsnGc4o-4NZ9SfWKqaULA@mail.gmail.com>
 <CAA85sZvm1dL3oGO85k4R+TaqBiJsggUTpZmGpH1+dqdC+U_s1w@mail.gmail.com>
 <e7e49ed5-09e2-da48-002d-c7eccc9f9451@intel.com> <CAA85sZtyM+X_oHcpOBNSgF=kmB6k32bpB8FCJN5cVE14YCba+A@mail.gmail.com>
 <22aad588-47d6-6441-45b2-0e685ed84c8d@intel.com> <CAA85sZti1=ET=Tc3MoqCX0FqthHLf6MSxGNAhJUNiMms1TfoKA@mail.gmail.com>
 <CAA85sZvn04k7=oiTQ=4_C8x7pNEXRWzeEStcaXvi3v63ah7OUQ@mail.gmail.com>
 <ffb554bfa4739381d928406ad24697a4dbbbe4a2.camel@redhat.com>
 <CAA85sZunA=tf0FgLH=MNVYq3Edewb1j58oBAoXE1Tyuy3GJObg@mail.gmail.com>
 <CAA85sZsH1tMwLtL=VDa5=GBdVNWgifvhK+eG-hQg69PeSxBWkg@mail.gmail.com>
 <CAA85sZu=CzJx9QD87-vehOStzO9qHUSWk6DXZg3TzJeqOV5-aw@mail.gmail.com>
 <0a040331995c072c56fce58794848f5e9853c44f.camel@redhat.com>
 <CAA85sZuuwxtAQcMe3LHpFVeF7y-bVoHtO1nukAa2+NyJw3zcyg@mail.gmail.com>
 <CAA85sZurk7-_0XGmoCEM93vu3vbqRgPTH4QVymPR5BeeFw6iFg@mail.gmail.com>
 <486ae2687cd2e2624c0db1ea1f3d6ca36db15411.camel@redhat.com> <CAA85sZsJEZK0g0fGfH+toiHm_o4pdN+Wo0Wq9fgsUjHXGxgxQA@mail.gmail.com>
In-Reply-To: <CAA85sZsJEZK0g0fGfH+toiHm_o4pdN+Wo0Wq9fgsUjHXGxgxQA@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Wed, 28 Jun 2023 14:04:40 +0200
Message-ID: <CAA85sZs4KkfVojx=vxbDaWhWRpxiHc-RCc2OLD2c+VefRjpTfw@mail.gmail.com>
Subject: Re: [Intel-wired-lan] bug with rx-udp-gro-forwarding offloading?
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So have some hits, would it be better without your warn on? ... Things
are a bit slow atm - lets just say that i noticed the stacktraces
because a stream stuttered =3D)

cat bug.txt | ./scripts/decode_stacktrace.sh vmlinux
[  100.136018] ------------[ cut here ]------------
[  100.136044] WARNING: CPU: 2 PID: 911 at net/core/skbuff.c:4307
skb_segment_list (net/core/skbuff.c:4307)
[  100.136085] Modules linked in: chaoskey
[  100.136113] CPU: 2 PID: 911 Comm: napi/eno1-67 Not tainted 6.4.0-dirty #=
367
[  100.136135] Hardware name: Supermicro Super Server/A2SDi-12C-HLN4F,
BIOS 1.7a 10/13/2022
[  100.136148] RIP: 0010:skb_segment_list (net/core/skbuff.c:4307)
[ 100.136169] Code: e9 21 fe ff ff 48 8b ac 24 a0 00 00 00 89 3c 24 e8
8e 5b c9 fd 8b 34 24 48 c7 c1 00 bc 3e 99 4c 89 ef 48 89 ea e8 19 97
fd ff <0f> 0b 48 b8 00 00 00 00 00 fc ff df 4c 89 fa 48 c1 ea 03 80 3c
02
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0: e9 21 fe ff ff        jmp    0xfffffffffffffe26
   5: 48 8b ac 24 a0 00 00 mov    0xa0(%rsp),%rbp
   c: 00
   d: 89 3c 24              mov    %edi,(%rsp)
  10: e8 8e 5b c9 fd        call   0xfffffffffdc95ba3
  15: 8b 34 24              mov    (%rsp),%esi
  18: 48 c7 c1 00 bc 3e 99 mov    $0xffffffff993ebc00,%rcx
  1f: 4c 89 ef              mov    %r13,%rdi
  22: 48 89 ea              mov    %rbp,%rdx
  25: e8 19 97 fd ff        call   0xfffffffffffd9743
  2a:* 0f 0b                ud2    <-- trapping instruction
  2c: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
  33: fc ff df
  36: 4c 89 fa              mov    %r15,%rdx
  39: 48 c1 ea 03          shr    $0x3,%rdx
  3d: 80                    .byte 0x80
  3e: 3c 02                cmp    $0x2,%al

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0: 0f 0b                ud2
   2: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
   9: fc ff df
   c: 4c 89 fa              mov    %r15,%rdx
   f: 48 c1 ea 03          shr    $0x3,%rdx
  13: 80                    .byte 0x80
  14: 3c 02                cmp    $0x2,%al
[  100.136188] RSP: 0018:ffff88811eea6fb0 EFLAGS: 00010212
[  100.136208] RAX: 00000000000005cc RBX: ffff88814b0da000 RCX: ffffffff97d=
7acb7
[  100.136222] RDX: ffff888221044474 RSI: 1ffff11044208891 RDI: 00000000000=
0002a
[  100.136236] RBP: 00000000000020c0 R08: 0000000000000000 R09: ffff8882210=
44497
[  100.136248] R10: ffffed1044208892 R11: 0000000000000014 R12: ffff8882210=
44480
[  100.136261] R13: ffff8882210443c0 R14: dffffc0000000000 R15: ffff88811a6=
472c0
[  100.136275] FS:  0000000000000000(0000) GS:ffff88842f300000(0000)
knlGS:0000000000000000
[  100.136289] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  100.136303] CR2: 0000000000000000 CR3: 0000000120900000 CR4: 00000000003=
526e0
[  100.136315] Call Trace:
[  100.136327]  <TASK>
[  100.136339] ? __warn (kernel/panic.c:673)
[  100.136361] ? skb_segment_list (net/core/skbuff.c:4307)
[  100.136379] ? report_bug (lib/bug.c:180 lib/bug.c:219)
[  100.136400] ? handle_bug (arch/x86/kernel/traps.c:324)
[  100.136419] ? exc_invalid_op (arch/x86/kernel/traps.c:345 (discriminator=
 1))
[  100.136439] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:568)
[  100.136462] ? skb_segment_list (./arch/x86/include/asm/atomic.h:29
./include/linux/atomic/atomic-instrumented.h:28
./include/linux/refcount.h:147 ./include/linux/skbuff.h:1986
net/core/skbuff.c:4281)
[  100.136482] ? skb_segment_list (net/core/skbuff.c:4307)
[  100.136503] __udp_gso_segment (net/ipv4/udp_offload.c:255
net/ipv4/udp_offload.c:277)
[  100.136525] ? nft_masq_init (net/netfilter/nft_masq.c:102)
[  100.136542] ? ixgbe_xdp_xmit
(drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8718)
[  100.136563] inet_gso_segment (net/ipv4/af_inet.c:1399)
[  100.136582] ? skb_crc32c_csum_help (./include/linux/skbuff.h:2698
./include/linux/skbuff.h:2956 net/core/dev.c:3303)
[  100.136604] skb_mac_gso_segment (net/core/gro.c:141)
[  100.136624] ? skb_eth_gso_segment (net/core/gro.c:127)
[  100.136645] __skb_gso_segment (net/core/dev.c:3403 (discriminator 2))
[  100.136663] ? netif_skb_features (net/core/dev.c:3474 net/core/dev.c:356=
3)
[  100.136683] validate_xmit_skb (./include/linux/netdevice.h:4862
net/core/dev.c:3659)
[  100.136704] validate_xmit_skb_list (net/core/dev.c:3710)
[  100.136725] sch_direct_xmit (net/sched/sch_generic.c:330)
[  100.136745] ? qdisc_put_unlocked (net/sched/sch_generic.c:317)
[  100.136762] ? _raw_spin_trylock (./arch/x86/include/asm/atomic.h:29
./include/linux/atomic/atomic-instrumented.h:28
./include/asm-generic/qspinlock.h:92 ./include/linux/spinlock.h:192
./include/linux/spinlock_api_smp.h:89 kernel/locking/spinlock.c:138)
[  100.136783] ? _raw_spin_lock_irqsave (kernel/locking/spinlock.c:137)
[  100.136835] __dev_queue_xmit (net/core/dev.c:3805 net/core/dev.c:4210)
[  100.136862] ? ip_finish_output2 (net/ipv4/ip_output.c:196)
[  100.136883] ? netdev_core_pick_tx (net/core/dev.c:4151)
[  100.136907] ? ip_setup_cork (net/ipv4/ip_output.c:196)
[  100.136927] ? __ip_finish_output (net/ipv4/ip_output.c:250
net/ipv4/ip_output.c:302 net/ipv4/ip_output.c:289)
[  100.136945] ? eth_header (net/ethernet/eth.c:100)
[  100.136966] ? neigh_resolve_output
(./include/linux/netdevice.h:3140 net/core/neighbour.c:1547
net/core/neighbour.c:1532)
[  100.136988] neigh_xmit (net/core/neighbour.c:3156)
[  100.137007] nf_flow_offload_ip_hook (net/netfilter/nf_flow_table_ip.c:41=
8)
[  100.137032] ? nf_flow_queue_xmit (net/netfilter/nf_flow_table_ip.c:342)
[  100.137054] ? consume_skb (./arch/x86/include/asm/atomic.h:190
./include/linux/atomic/atomic-instrumented.h:177
./include/linux/refcount.h:272 ./include/linux/refcount.h:315
./include/linux/refcount.h:333 ./include/linux/skbuff.h:1221
net/core/skbuff.c:1240)
[  100.137071] nf_hook_slow (./include/linux/netfilter.h:143
net/netfilter/core.c:626)
[  100.137094] __netif_receive_skb_core.constprop.0
(./include/linux/netfilter_netdev.h:34 net/core/dev.c:5274
net/core/dev.c:5361)
[  100.137120] ? do_xdp_generic (net/core/dev.c:5281)
[  100.137142] ? __udp4_lib_lookup (net/ipv4/udp.c:531)
[  100.137164] __netif_receive_skb_list_core (net/core/dev.c:5570)
[  100.137188] ? __netif_receive_skb_core.constprop.0 (net/core/dev.c:5546)
[  100.137211] ? load_balance (kernel/sched/fair.c:10908)
[  100.137230] ? recalibrate_cpu_khz (./arch/x86/include/asm/msr.h:215
arch/x86/kernel/tsc.c:1110)
[  100.137250] ? ktime_get_with_offset (kernel/time/timekeeping.c:292
(discriminator 3) kernel/time/timekeeping.c:388 (discriminator 3)
kernel/time/timekeeping.c:891 (discriminator 3))
[  100.137272] netif_receive_skb_list_internal (net/core/dev.c:5638
net/core/dev.c:5727)
[  100.137295] ? process_backlog (net/core/dev.c:5699)
[  100.137317] ? napi_gro_complete.constprop.0 (net/core/gro.c:321)
[  100.137338] ? dev_gro_receive (./arch/x86/include/asm/bitops.h:94
(discriminator 8)
./include/asm-generic/bitops/instrumented-non-atomic.h:45
(discriminator 8) net/core/gro.c:583 (discriminator 8))
[  100.137357] napi_complete_done (./include/linux/list.h:37
./include/net/gro.h:434 ./include/net/gro.h:429 net/core/dev.c:6067)
[  100.137378] ? napi_busy_loop (net/core/dev.c:6034)
[  100.137399] ixgbe_poll (drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:31=
91)
[  100.137425] ? ixgbe_xdp_ring_update_tail_locked
(drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:3141)
[  100.137447] ? io_schedule_timeout (kernel/sched/core.c:6551)
[  100.137469] __napi_poll (net/core/dev.c:6498)
[  100.137490] napi_threaded_poll (./include/linux/netpoll.h:89
net/core/dev.c:6640)
[  100.137513] ? __napi_poll (net/core/dev.c:6625)
[  100.137531] ? migrate_enable (kernel/sched/core.c:3045)
[  100.137553] ? __kthread_parkme (./arch/x86/include/asm/bitops.h:207
./arch/x86/include/asm/bitops.h:239
./include/asm-generic/bitops/instrumented-non-atomic.h:142
kernel/kthread.c:271)
[  100.137572] ? __napi_poll (net/core/dev.c:6625)
[  100.137591] kthread (kernel/kthread.c:379)
[  100.137610] ? kthread_complete_and_exit (kernel/kthread.c:336)
[  100.137631] ret_from_fork (arch/x86/entry/entry_64.S:314)
[  100.137651]  </TASK>
[  100.137661] ---[ end trace 0000000000000000 ]---

[  112.103156] ------------[ cut here ]------------
[  112.103183] WARNING: CPU: 4 PID: 922 at net/core/skbuff.c:4337
skb_segment_list (net/core/skbuff.c:4337 (discriminator 1))
[  112.103222] Modules linked in: chaoskey
[  112.103251] CPU: 4 PID: 922 Comm: napi/eno2-80 Tainted: G        W
        6.4.0-dirty #367
[  112.103273] Hardware name: Supermicro Super Server/A2SDi-12C-HLN4F,
BIOS 1.7a 10/13/2022
[  112.103286] RIP: 0010:skb_segment_list (net/core/skbuff.c:4337
(discriminator 1))
[ 112.103308] Code: 41 0f c1 87 d4 00 00 00 85 c0 74 25 8d 50 01 09 c2
78 08 4c 89 f8 e9 28 fa ff ff be 01 00 00 00 48 89 df e8 63 70 a1 fe
eb e9 <0f> 0b e9 df f9 ff ff be 02 00 00 00 48 89 df e8 4d 70 a1 fe eb
d3
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0: 41 0f c1 87 d4 00 00 xadd   %eax,0xd4(%r15)
   7: 00
   8: 85 c0                test   %eax,%eax
   a: 74 25                je     0x31
   c: 8d 50 01              lea    0x1(%rax),%edx
   f: 09 c2                or     %eax,%edx
  11: 78 08                js     0x1b
  13: 4c 89 f8              mov    %r15,%rax
  16: e9 28 fa ff ff        jmp    0xfffffffffffffa43
  1b: be 01 00 00 00        mov    $0x1,%esi
  20: 48 89 df              mov    %rbx,%rdi
  23: e8 63 70 a1 fe        call   0xfffffffffea1708b
  28: eb e9                jmp    0x13
  2a:* 0f 0b                ud2    <-- trapping instruction
  2c: e9 df f9 ff ff        jmp    0xfffffffffffffa10
  31: be 02 00 00 00        mov    $0x2,%esi
  36: 48 89 df              mov    %rbx,%rdi
  39: e8 4d 70 a1 fe        call   0xfffffffffea1708b
  3e: eb d3                jmp    0x13

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0: 0f 0b                ud2
   2: e9 df f9 ff ff        jmp    0xfffffffffffff9e6
   7: be 02 00 00 00        mov    $0x2,%esi
   c: 48 89 df              mov    %rbx,%rdi
   f: e8 4d 70 a1 fe        call   0xfffffffffea17061
  14: eb d3                jmp    0xffffffffffffffe9
[  112.103326] RSP: 0018:ffff88811c93ec38 EFLAGS: 00010246
[  112.103346] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffff888218b=
92848
[  112.103361] RDX: 1ffff110431724f0 RSI: ffff888218b92834 RDI: 00000000000=
00000
[  112.103374] RBP: ffff8881804b6ec0 R08: ffff888218b92840 R09: 1ffff110431=
724fe
[  112.103388] R10: ffff8881804b6000 R11: 0000000000000014 R12: 00000000000=
00000
[  112.103400] R13: ffff8881804b6ec0 R14: 0000000000000022 R15: ffff888218b=
92780
[  112.103414] FS:  0000000000000000(0000) GS:ffff88842f400000(0000)
knlGS:0000000000000000
[  112.103429] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  112.103442] CR2: 00007fd1aa0419e5 CR3: 00000001287ea000 CR4: 00000000003=
526e0
[  112.103456] Call Trace:
[  112.103467]  <TASK>
[  112.103521] ? __warn (kernel/panic.c:673)
[  112.103549] ? skb_segment_list (net/core/skbuff.c:4337 (discriminator 1)=
)
[  112.103569] ? report_bug (lib/bug.c:180 lib/bug.c:219)
[  112.103590] ? handle_bug (arch/x86/kernel/traps.c:324)
[  112.103611] ? exc_invalid_op (arch/x86/kernel/traps.c:345 (discriminator=
 1))
[  112.103631] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:568)
[  112.103658] ? skb_segment_list (net/core/skbuff.c:4337 (discriminator 1)=
)
[  112.103678] ? set_track_prepare (mm/slub.c:5682)
[  112.103696] ? napi_complete_done (./include/linux/list.h:37
./include/net/gro.h:434 ./include/net/gro.h:429 net/core/dev.c:6067)
[  112.103716] ? pcpu_alloc (mm/percpu-internal.h:129 mm/percpu.c:1880)
[  112.103734] __udp_gso_segment (net/ipv4/udp_offload.c:255
net/ipv4/udp_offload.c:277)
[  112.103758] ? _raw_spin_lock_irqsave
(./arch/x86/include/asm/atomic.h:202
./include/linux/atomic/atomic-instrumented.h:543
./include/asm-generic/qspinlock.h:111 ./include/linux/spinlock.h:186
./include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162)
[  112.103782] ? _raw_read_unlock_irqrestore (kernel/locking/spinlock.c:161=
)
[  112.103804] ? __netif_receive_skb_core.constprop.0 (net/core/dev.c:5387)
[  112.103826] ? netif_receive_skb_list_internal (net/core/dev.c:5638
net/core/dev.c:5727)
[  112.103848] inet_gso_segment (net/ipv4/af_inet.c:1399)
[  112.103868] ? skb_crc32c_csum_help (./include/linux/skbuff.h:2698
./include/linux/skbuff.h:2956 net/core/dev.c:3303)
[  112.103891] skb_mac_gso_segment (net/core/gro.c:141)
[  112.103911] ? skb_eth_gso_segment (net/core/gro.c:127)
[  112.103933] __skb_gso_segment (net/core/dev.c:3403 (discriminator 2))
[  112.103952] ? netif_skb_features (net/core/dev.c:3474 net/core/dev.c:356=
3)
[  112.103973] validate_xmit_skb (./include/linux/netdevice.h:4862
net/core/dev.c:3659)
[  112.103993] ? kasan_save_stack (mm/kasan/common.c:47)
[  112.104017] validate_xmit_skb_list (net/core/dev.c:3710)
[  112.104039] sch_direct_xmit (net/sched/sch_generic.c:330)
[  112.104058] ? ret_from_fork (arch/x86/entry/entry_64.S:308)
[  112.104075] ? unwind_next_frame (arch/x86/kernel/unwind_orc.c:195
arch/x86/kernel/unwind_orc.c:469)
[  112.104098] ? ret_from_fork (arch/x86/entry/entry_64.S:314)
[  112.104115] ? qdisc_put_unlocked (net/sched/sch_generic.c:317)
[  112.104133] ? _raw_spin_trylock (./arch/x86/include/asm/atomic.h:29
./include/linux/atomic/atomic-instrumented.h:28
./include/asm-generic/qspinlock.h:92 ./include/linux/spinlock.h:192
./include/linux/spinlock_api_smp.h:89 kernel/locking/spinlock.c:138)
[  112.104154] ? _raw_spin_lock_irqsave (kernel/locking/spinlock.c:137)
[  112.104178] __dev_queue_xmit (net/core/dev.c:3805 net/core/dev.c:4210)
[  112.104200] ? filter_irq_stacks (kernel/stacktrace.c:114)
[  112.104222] ? netdev_core_pick_tx (net/core/dev.c:4151)
[  112.104242] ? unwind_next_frame (arch/x86/kernel/unwind_orc.c:381
arch/x86/kernel/unwind_orc.c:623)
[  112.104264] ? i8237A_resume (./arch/x86/include/asm/dma.h:250
arch/x86/kernel/i8237.c:33)
[  112.104282] ? ret_from_fork (arch/x86/entry/entry_64.S:308)
[  112.104298] ? unwind_next_frame (arch/x86/kernel/unwind_orc.c:195
arch/x86/kernel/unwind_orc.c:469)
[  112.104320] ? ret_from_fork (arch/x86/entry/entry_64.S:314)
[  112.104337] ? br_handle_frame_finish (net/bridge/br_input.c:215)
[  112.104359] ? write_profile (kernel/stacktrace.c:86)
[  112.104379] ? arch_stack_walk (arch/x86/kernel/stacktrace.c:24)
[  112.104398] br_dev_queue_push_xmit (net/bridge/br_forward.c:55)
[  112.104421] ? stack_trace_save (kernel/stacktrace.c:123)
[  112.104442] ? br_fdb_offloaded_set (net/bridge/br_forward.c:34)
[  112.104464] ? nf_hook_slow (./include/linux/netfilter.h:143
net/netfilter/core.c:626)
[  112.104510] br_forward_finish (./include/linux/netfilter.h:303
./include/linux/netfilter.h:297 net/bridge/br_forward.c:66)
[  112.104536] ? br_dev_queue_push_xmit (net/bridge/br_forward.c:64)
[  112.104558] ? maybe_deliver (net/bridge/br_forward.c:125
net/bridge/br_forward.c:189)
[  112.104577] ? br_flood (net/bridge/br_forward.c:233)
[  112.104596] ? br_fdb_offloaded_set (net/bridge/br_forward.c:34)
[  112.104617] ? nf_hook_slow (./include/linux/netfilter.h:143
net/netfilter/core.c:626)
[  112.104639] __br_forward (./include/linux/netfilter.h:304
./include/linux/netfilter.h:297 net/bridge/br_forward.c:115)
[  112.104660] ? br_forward_finish (net/bridge/br_forward.c:75)
[  112.104682] ? br_dev_queue_push_xmit (net/bridge/br_forward.c:64)
[  112.104703] ? __copy_skb_header (./include/net/dst.h:297
net/core/skbuff.c:1338)
[  112.104725] ? __skb_clone (./arch/x86/include/asm/atomic.h:95
(discriminator 4) ./include/linux/atomic/atomic-instrumented.h:191
(discriminator 4) net/core/skbuff.c:1409 (discriminator 4))
[  112.104746] maybe_deliver (net/bridge/br_forward.c:193)
[  112.104766] ? br_fdb_update (./arch/x86/include/asm/bitops.h:207
./arch/x86/include/asm/bitops.h:239
./include/asm-generic/bitops/instrumented-non-atomic.h:142
net/bridge/br_fdb.c:896)
[  112.104787] br_flood (net/bridge/br_forward.c:233)
[  112.104809] br_handle_frame_finish (net/bridge/br_input.c:215)
[  112.104832] ? br_handle_local_finish (net/bridge/br_input.c:75)
[  112.104855] ? br_cfm_config_fill_info
(./include/linux/skbuff.h:2527 ./include/net/netlink.h:1815
./include/net/netlink.h:1835 net/bridge/br_cfm_netlink.c:462)
[  112.104874] ? br_nf_pre_routing_finish (net/bridge/br_netfilter_hooks.c:=
481)
[  112.104893] ? unwind_next_frame (arch/x86/kernel/unwind_orc.c:381
arch/x86/kernel/unwind_orc.c:623)
[  112.104915] ? arch_stack_walk (arch/x86/kernel/stacktrace.c:24)
[  112.104933] ? ret_from_fork (arch/x86/entry/entry_64.S:308)
[  112.104949] ? unwind_next_frame (arch/x86/kernel/unwind_orc.c:195
arch/x86/kernel/unwind_orc.c:469)
[  112.104970] ? ret_from_fork (arch/x86/entry/entry_64.S:314)
[  112.104987] ? br_nf_pre_routing_finish (net/bridge/br_netfilter_hooks.c:=
481)
[  112.105006] br_handle_frame (net/bridge/br_input.c:298
net/bridge/br_input.c:416)
[  112.105028] ? br_handle_frame_finish (net/bridge/br_input.c:321)
[  112.105050] ? br_handle_local_finish (net/bridge/br_input.c:75)
[  112.105071] ? packet_rcv (net/packet/af_packet.c:2231)
[  112.105090] __netif_receive_skb_core.constprop.0 (net/core/dev.c:5387)
[  112.105112] ? br_handle_frame_finish (net/bridge/br_input.c:321)
[  112.105135] ? do_xdp_generic (net/core/dev.c:5281)
[  112.105154] ? udp4_lib_lookup2 (net/ipv4/udp.c:456)
[  112.105175] ? queued_spin_lock_slowpath
(kernel/locking/qspinlock.c:183 kernel/locking/qspinlock.c:463)
[  112.105193] ? __udp4_lib_lookup (net/ipv4/udp.c:531)
[  112.105215] __netif_receive_skb_list_core (net/core/dev.c:5570)
[  112.105239] ? __netif_receive_skb_core.constprop.0 (net/core/dev.c:5546)
[  112.105262] ? load_balance (kernel/sched/fair.c:10908)
[  112.105281] ? recalibrate_cpu_khz (./arch/x86/include/asm/msr.h:215
arch/x86/kernel/tsc.c:1110)
[  112.105302] ? ktime_get_with_offset (kernel/time/timekeeping.c:292
(discriminator 3) kernel/time/timekeeping.c:388 (discriminator 3)
kernel/time/timekeeping.c:891 (discriminator 3))
[  112.105323] netif_receive_skb_list_internal (net/core/dev.c:5638
net/core/dev.c:5727)
[  112.105346] ? process_backlog (net/core/dev.c:5699)
[  112.105368] ? napi_gro_flush (./arch/x86/include/asm/bitops.h:94
./include/asm-generic/bitops/instrumented-non-atomic.h:45
net/core/gro.c:346 net/core/gro.c:361)
[  112.105386] ? dev_gro_receive (./arch/x86/include/asm/bitops.h:68
(discriminator 8)
./include/asm-generic/bitops/instrumented-non-atomic.h:29
(discriminator 8) net/core/gro.c:581 (discriminator 8))
[  112.105405] napi_complete_done (./include/linux/list.h:37
./include/net/gro.h:434 ./include/net/gro.h:429 net/core/dev.c:6067)
[  112.105425] ? napi_busy_loop (net/core/dev.c:6034)
[  112.105447] ixgbe_poll (drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:31=
91)
[  112.105468] ? attach_entity_load_avg (kernel/sched/pelt.h:44
kernel/sched/fair.c:4162)
[  112.105514] ? ixgbe_xdp_ring_update_tail_locked
(drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:3141)
[  112.105544] __napi_poll (net/core/dev.c:6498)
[  112.105566] napi_threaded_poll (./include/linux/netpoll.h:89
net/core/dev.c:6640)
[  112.105589] ? __napi_poll (net/core/dev.c:6625)
[  112.105608] ? migrate_enable (kernel/sched/core.c:3045)
[  112.105630] ? __kthread_parkme (./arch/x86/include/asm/bitops.h:207
./arch/x86/include/asm/bitops.h:239
./include/asm-generic/bitops/instrumented-non-atomic.h:142
kernel/kthread.c:271)
[  112.105649] ? __napi_poll (net/core/dev.c:6625)
[  112.105668] kthread (kernel/kthread.c:379)
[  112.105687] ? kthread_complete_and_exit (kernel/kthread.c:336)
[  112.105708] ret_from_fork (arch/x86/entry/entry_64.S:314)
[  112.105729]  </TASK>
[  112.105739] ---[ end trace 0000000000000000 ]---

On Wed, Jun 28, 2023 at 1:47=E2=80=AFPM Ian Kumlien <ian.kumlien@gmail.com>=
 wrote:
>
> On Wed, Jun 28, 2023 at 11:06=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >
> > Hello,
> >
> > On Wed, 2023-06-28 at 09:37 +0200, Ian Kumlien wrote:
> > > Been running all night but eventually it crashed again...
> > >
> > > [21753.055795] Out of memory: Killed process 970 (qemu-system-x86)
> > > total-vm:4709488kB, anon-rss:2172652kB, file-rss:4608kB,
> > > shmem-rss:0kB, UID:77 pgtables:4800kB oom_score_adj:0
> > > [24249.061154] general protection fault, probably for non-canonical
> > > address 0xb0746d4e6bee35e2: 0000 [#1] PREEMPT SMP NOPTI
> > > [24249.072138] CPU: 0 PID: 893 Comm: napi/eno1-68 Tainted: G        W
> > >         6.4.0-dirty #366
> > > [24249.080670] Hardware name: Supermicro Super Server/A2SDi-12C-HLN4F=
,
> > > BIOS 1.7a 10/13/2022
> > > [24249.088852] RIP: 0010:kmem_cache_alloc_bulk (mm/slub.c:377
> > > mm/slub.c:388 mm/slub.c:395 mm/slub.c:3963 mm/slub.c:4026)
> > > [24249.094086] Code: 0f 84 46 ff ff ff 65 ff 05 a4 bd e4 47 48 8b 4d
> > > 00 65 48 03 0d e8 5f e3 47 9c 5e fa 45 31 d2 eb 2f 8b 45 28 48 01 d0
> > > 48 89 c7 <48> 8b 00 48 33 85 b8 00 00 00 48 0f cf 48 31 f8 48 89 01 4=
9
> > > 89 17
> > > All code
> > > =3D=3D=3D=3D=3D=3D=3D=3D
> > >    0: 0f 84 46 ff ff ff    je     0xffffffffffffff4c
> > >    6: 65 ff 05 a4 bd e4 47 incl   %gs:0x47e4bda4(%rip)        # 0x47e=
4bdb1
> > >    d: 48 8b 4d 00          mov    0x0(%rbp),%rcx
> > >   11: 65 48 03 0d e8 5f e3 add    %gs:0x47e35fe8(%rip),%rcx        # =
0x47e36001
> > >   18: 47
> > >   19: 9c                    pushf
> > >   1a: 5e                    pop    %rsi
> > >   1b: fa                    cli
> > >   1c: 45 31 d2              xor    %r10d,%r10d
> > >   1f: eb 2f                jmp    0x50
> > >   21: 8b 45 28              mov    0x28(%rbp),%eax
> > >   24: 48 01 d0              add    %rdx,%rax
> > >   27: 48 89 c7              mov    %rax,%rdi
> > >   2a:* 48 8b 00              mov    (%rax),%rax <-- trapping instruct=
ion
> > >   2d: 48 33 85 b8 00 00 00 xor    0xb8(%rbp),%rax
> > >   34: 48 0f cf              bswap  %rdi
> > >   37: 48 31 f8              xor    %rdi,%rax
> > >   3a: 48 89 01              mov    %rax,(%rcx)
> > >   3d: 49 89 17              mov    %rdx,(%r15)
> > >
> > > Code starting with the faulting instruction
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >    0: 48 8b 00              mov    (%rax),%rax
> > >    3: 48 33 85 b8 00 00 00 xor    0xb8(%rbp),%rax
> > >    a: 48 0f cf              bswap  %rdi
> > >    d: 48 31 f8              xor    %rdi,%rax
> > >   10: 48 89 01              mov    %rax,(%rcx)
> > >   13: 49 89 17              mov    %rdx,(%r15)
> > > [24249.112951] RSP: 0018:ffff9fc303973d20 EFLAGS: 00010086
> > > [24249.118275] RAX: b0746d4e6bee35e2 RBX: 0000000000000001 RCX: ffff8=
d5a2fa31da0
> > > [24249.125501] RDX: b0746d4e6bee3572 RSI: 0000000000000286 RDI: b0746=
d4e6bee35e2
> > > [24249.132730] RBP: ffff8d56c016d500 R08: 0000000000000400 R09: ffff8=
d56ede0e67a
> > > [24249.139958] R10: 0000000000000001 R11: ffff8d56c59d88c0 R12: 00000=
00000000010
> > > [24249.147187] R13: 0000000000000820 R14: ffff8d5a2fa2a810 R15: ffff8=
d5a2fa2a818
> > > [24249.154415] FS:  0000000000000000(0000) GS:ffff8d5a2fa00000(0000)
> > > knlGS:0000000000000000
> > > [24249.162620] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [24249.168471] CR2: 00007f0f3f7f8760 CR3: 0000000102466000 CR4: 00000=
000003526f0
> > > [24249.175717] Call Trace:
> > > [24249.178268]  <TASK>
> > > [24249.180476] ? die_addr (arch/x86/kernel/dumpstack.c:421
> > > arch/x86/kernel/dumpstack.c:460)
> > > [24249.183907] ? exc_general_protection (arch/x86/kernel/traps.c:783
> > > arch/x86/kernel/traps.c:728)
> > > [24249.188726] ? asm_exc_general_protection
> > > (./arch/x86/include/asm/idtentry.h:564)
> > > [24249.193720] ? kmem_cache_alloc_bulk (mm/slub.c:377 mm/slub.c:388
> > > mm/slub.c:395 mm/slub.c:3963 mm/slub.c:4026)
> > > [24249.198361] ? netif_receive_skb_list_internal (net/core/dev.c:5729=
)
> > > [24249.203960] napi_skb_cache_get (net/core/skbuff.c:338)
> > > [24249.208078] __napi_build_skb (net/core/skbuff.c:517)
> > > [24249.211934] napi_build_skb (net/core/skbuff.c:541)
> > > [24249.215616] ixgbe_poll
> > > (drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2165
> > > drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2361
> > > drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:3178)
> > > [24249.219305] __napi_poll (net/core/dev.c:6498)
> > > [24249.222905] napi_threaded_poll (./include/linux/netpoll.h:89
> > > net/core/dev.c:6640)
> > > [24249.227197] ? __napi_poll (net/core/dev.c:6625)
> > > [24249.231050] kthread (kernel/kthread.c:379)
> > > [24249.234300] ? kthread_complete_and_exit (kernel/kthread.c:332)
> > > [24249.239207] ret_from_fork (arch/x86/entry/entry_64.S:314)
> > > [24249.242892]  </TASK>
> > > [24249.245185] Modules linked in: chaoskey
> > > [24249.249133] ---[ end trace 0000000000000000 ]---
> > > [24249.270157] pstore: backend (erst) writing error (-28)
> > > [24249.275408] RIP: 0010:kmem_cache_alloc_bulk (mm/slub.c:377
> > > mm/slub.c:388 mm/slub.c:395 mm/slub.c:3963 mm/slub.c:4026)
> > > [24249.280660] Code: 0f 84 46 ff ff ff 65 ff 05 a4 bd e4 47 48 8b 4d
> > > 00 65 48 03 0d e8 5f e3 47 9c 5e fa 45 31 d2 eb 2f 8b 45 28 48 01 d0
> > > 48 89 c7 <48> 8b 00 48 33 85 b8 00 00 00 48 0f cf 48 31 f8 48 89 01 4=
9
> > > 89 17
> > > All code
> > > =3D=3D=3D=3D=3D=3D=3D=3D
> > >    0: 0f 84 46 ff ff ff    je     0xffffffffffffff4c
> > >    6: 65 ff 05 a4 bd e4 47 incl   %gs:0x47e4bda4(%rip)        # 0x47e=
4bdb1
> > >    d: 48 8b 4d 00          mov    0x0(%rbp),%rcx
> > >   11: 65 48 03 0d e8 5f e3 add    %gs:0x47e35fe8(%rip),%rcx        # =
0x47e36001
> > >   18: 47
> > >   19: 9c                    pushf
> > >   1a: 5e                    pop    %rsi
> > >   1b: fa                    cli
> > >   1c: 45 31 d2              xor    %r10d,%r10d
> > >   1f: eb 2f                jmp    0x50
> > >   21: 8b 45 28              mov    0x28(%rbp),%eax
> > >   24: 48 01 d0              add    %rdx,%rax
> > >   27: 48 89 c7              mov    %rax,%rdi
> > >   2a:* 48 8b 00              mov    (%rax),%rax <-- trapping instruct=
ion
> > >   2d: 48 33 85 b8 00 00 00 xor    0xb8(%rbp),%rax
> > >   34: 48 0f cf              bswap  %rdi
> > >   37: 48 31 f8              xor    %rdi,%rax
> > >   3a: 48 89 01              mov    %rax,(%rcx)
> > >   3d: 49 89 17              mov    %rdx,(%r15)
> > >
> > > Code starting with the faulting instruction
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >    0: 48 8b 00              mov    (%rax),%rax
> > >    3: 48 33 85 b8 00 00 00 xor    0xb8(%rbp),%rax
> > >    a: 48 0f cf              bswap  %rdi
> > >    d: 48 31 f8              xor    %rdi,%rax
> > >   10: 48 89 01              mov    %rax,(%rcx)
> > >   13: 49 89 17              mov    %rdx,(%r15)
> > > [24249.299578] RSP: 0018:ffff9fc303973d20 EFLAGS: 00010086
> > > [24249.304917] RAX: b0746d4e6bee35e2 RBX: 0000000000000001 RCX: ffff8=
d5a2fa31da0
> > > [24249.312161] RDX: b0746d4e6bee3572 RSI: 0000000000000286 RDI: b0746=
d4e6bee35e2
> > > [24249.319407] RBP: ffff8d56c016d500 R08: 0000000000000400 R09: ffff8=
d56ede0e67a
> > > [24249.326651] R10: 0000000000000001 R11: ffff8d56c59d88c0 R12: 00000=
00000000010
> > > [24249.333896] R13: 0000000000000820 R14: ffff8d5a2fa2a810 R15: ffff8=
d5a2fa2a818
> > > [24249.341141] FS:  0000000000000000(0000) GS:ffff8d5a2fa00000(0000)
> > > knlGS:0000000000000000
> > > [24249.349356] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [24249.355206] CR2: 00007f0f3f7f8760 CR3: 0000000102466000 CR4: 00000=
000003526f0
> > > [24249.362452] Kernel panic - not syncing: Fatal exception in interru=
pt
> > > [24249.566854] Kernel Offset: 0x36e00000 from 0xffffffff81000000
> > > (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> > > [24249.594124] ---[ end Kernel panic - not syncing: Fatal exception i=
n
> > > interrupt ]---
> > >
> > > It's also odd that i get a OOM - it only seems to happen when i enabl=
e
> > > rx-gro-list
> >
> > Unfortunately, not the result I was looking for. That leads to more
> > questions then answer, I'm sorry.
>
> I understand you...
>
> > How long did the host keep going with rx-gro-list enabled?
>
> Well, hours...
>
> reboot   system boot  6.4.0-dirty      Wed Jun 28 04:20 - 13:39  (09:19)
> reboot   system boot  6.4.0-dirty      Tue Jun 27 21:31 - 13:39  (16:08)
>
> So, lets imagine a few seconds to login and enable everything
>
> > Did you observe the WARN_ON() introduced by the tentative fix?
>
> I could only see the console, so saw nothing...
>
> > > - it's also odd because this machine always has ~8GB of
> > > memory available
> >
> > It looks like there is a memory leak somewhere, and I don't think the
> > tentative fixup introduced such issue.
>
> I agree, it was there before...
>
> > It looks like the above splat is due to a slab corruption, which in
> > turn could be unrelated from the mentioned leak, but it could/should
> > be related to rx-gro-list.
>
> Agreed =3D)
>
> > Could you please run the test with both kmemleak and kasan enabled?
>
> Machine-slowdown-enabled^tm
>
> > Additionally could you please disclose if you have non trivial
> > netfilter and/or bridge filter and/or tc rules possibly modifying the
> > incoming/egress packets?
>
> I only have basic reject accept rules, some snat/dnat pairs, but i
> don't see it ending up in "non trivial" ;)
>
> > If kasan is not an option, could you please apply the debug the patch
> > below? (on top of the previous one)
>
> I actually did both, if it's unrelated we should know as well..
>
> I hope i have something for you before tomorrow, else there will be a
> bit of a break until next week
>
> > Thanks!
> >
> > Paolo
> > ---
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 6c5915efbc17..94adca27b205 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -4295,6 +4295,8 @@ struct sk_buff *skb_segment_list(struct sk_buff *=
skb,
> >                 delta_len +=3D nskb->len;
> >
> >                 skb_push(nskb, -skb_network_offset(nskb) + offset);
> > +               if (WARN_ON_ONCE(nskb->data - skb->head > skb->tail))
> > +                       goto err_linearize;
> >
> >                 skb_release_head_state(nskb);
> >                 len_diff =3D skb_network_header_len(nskb) - skb_network=
_header_len(skb);
> > @@ -4302,6 +4304,11 @@ struct sk_buff *skb_segment_list(struct sk_buff =
*skb,
> >
> >                 skb_headers_offset_update(nskb, skb_headroom(nskb) - sk=
b_headroom(skb));
> >                 nskb->transport_header +=3D len_diff;
> > +               if (WARN_ON_ONCE(tnl_hlen > skb_headroom(nskb)))
> > +                       goto err_linearize;
> > +               if (WARN_ON_ONCE(skb_headroom(nskb) + offset > nskb->ta=
il))
> > +                       goto err_linearize;
> > +
> >                 skb_copy_from_linear_data_offset(skb, -tnl_hlen,
> >                                                  nskb->data - tnl_hlen,
> >                                                  offset + tnl_hlen);
> >
> >
