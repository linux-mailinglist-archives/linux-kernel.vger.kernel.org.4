Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE4E747414
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjGDO1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 10:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjGDO1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:27:39 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC816E47;
        Tue,  4 Jul 2023 07:27:36 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-47e3fb1cb73so818634e0c.0;
        Tue, 04 Jul 2023 07:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688480856; x=1691072856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYE1UYTztiaFERCEaWwBNSkWWZIy6N5S0h8HRmJY43E=;
        b=VF+FYDhGV2oUVATSYgTu6XgM9sKwQCYU3ozI3UFz5o1JkXEdphtl3y7D/oHR2to2LU
         FQYJSD8ag6l6m4LiWNcTk7kEyqbaF342vsPq3t28SU4kuXBg4LcaHmyPOjWW/80r+qWi
         nSp+hFuLvLS0wOyEXI/IwBK+uHf+LLAWmoYMujwad5FswcHwuYCysBnXNnRpnt2m7K5z
         HqG0PmKOWAf8gWbci22KcDr2dnaCWVJq5A7uAfUxB+M+JVXyHm0/jthE4k3JPnoZy33U
         eNTh089mfmyAqwaEKk5dTOfMHf2L4+nJYUG7Iy/u7aixD0ic9384av83MibcdTj1hk3e
         v68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688480856; x=1691072856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYE1UYTztiaFERCEaWwBNSkWWZIy6N5S0h8HRmJY43E=;
        b=IajEi0Du7rSfF2W+JdxY/SvowNBJHKbxDT2USs81VNZC4CViJvxjVijOXqp0xLQR5B
         JrValD5d1PYCPxu9JW6xt3BZXt7JOuPhZ3Nua/gF/kQt07oltLCnR+zM/h2e9SH9HJoJ
         Fj6p66Td4Kx225jzgVLNKOO7l0j4sblVSK5S5QAspriIhtIi4T93CJsKCTI+iIrrzk8D
         nOaAfxdTKfN98gqnQMMfF4b2mMaWGa3dwNFCZ68dGSPEm4APy7sGXQj4toJvpHSTayjV
         Ur5d6iVrM42mZfZrFztNkWvLhvenc3cNVxGeqdmMEq6NNbF8/DDFWp7OTKxwrykLhge+
         pPYA==
X-Gm-Message-State: ABy/qLbeMsvNkOGkvX4a5XT8ZEE+GyOe/QaIXSZr4dzutKJa8ymrc5TC
        5ZNOVgApfAxq/f331RvWqPIujv9zpHvtkrYnG+c=
X-Google-Smtp-Source: APBJJlEOHLOreeYS+nAEc2RTG9C514RObDARnl1NRxTg5qiH3PFLDG4UjapxCN293HJt7/TreyprbPR2noR25T/aSXc=
X-Received: by 2002:ac5:c957:0:b0:471:7996:228f with SMTP id
 s23-20020ac5c957000000b004717996228fmr6255845vkm.7.1688480855447; Tue, 04 Jul
 2023 07:27:35 -0700 (PDT)
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
 <486ae2687cd2e2624c0db1ea1f3d6ca36db15411.camel@redhat.com>
 <CAA85sZsJEZK0g0fGfH+toiHm_o4pdN+Wo0Wq9fgsUjHXGxgxQA@mail.gmail.com>
 <CAA85sZs4KkfVojx=vxbDaWhWRpxiHc-RCc2OLD2c+VefRjpTfw@mail.gmail.com>
 <5688456234f5d15ea9ca0f000350c28610ed2639.camel@redhat.com>
 <CAA85sZvT-vAHQooy8+i0-bTxgv4JjkqMorLL1HjkXK6XDKX41w@mail.gmail.com>
 <CAA85sZs2biYueZsbDqdrMyYfaqH6hnSMpymgbsk=b3W1B7TNRA@mail.gmail.com>
 <CAA85sZs_H3Dc-mYnj8J5VBEwUJwbHUupP+U-4eG20nfAHBtv4w@mail.gmail.com>
 <92a4d42491a2c219192ae86fa04b579ea3676d8c.camel@redhat.com>
 <CAA85sZvtspqfep+6rH8re98-A6rHNNWECvwqVaM=r=0NSSsGzA@mail.gmail.com>
 <dfbbe91a9c0abe8aba2c00afd3b7f7d6af801d8e.camel@redhat.com>
 <CAA85sZuQh0FMoGDFVyOad6G1UB9keodd3OCZ4d4r+xgXDArcVA@mail.gmail.com>
 <062061fc4d4d3476e3b0255803b726956686eb19.camel@redhat.com> <CAA85sZv9KCmw8mAzK4T-ORXB48wuLF+YXTYSWxkBhv3k_-wzcA@mail.gmail.com>
In-Reply-To: <CAA85sZv9KCmw8mAzK4T-ORXB48wuLF+YXTYSWxkBhv3k_-wzcA@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Tue, 4 Jul 2023 16:27:24 +0200
Message-ID: <CAA85sZt6ssXRaZyq4awM0yTLFk62Gxbgw-0+bTKWsHwQvVzZXQ@mail.gmail.com>
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

More stacktraces.. =3D)

cat bug.txt | ./scripts/decode_stacktrace.sh vmlinux
[  411.413767] ------------[ cut here ]------------
[  411.413792] WARNING: CPU: 9 PID: 942 at include/net/udp.h:509
udpv6_queue_rcv_skb (./include/net/udp.h:509 net/ipv6/udp.c:800
net/ipv6/udp.c:787)
[  411.413829] Modules linked in: chaoskey
[  411.413857] CPU: 9 PID: 942 Comm: napi/eno2-87 Tainted: G        W
        6.4.1-dirty #375
[  411.413879] Hardware name: Supermicro Super Server/A2SDi-12C-HLN4F,
BIOS 1.7a 10/13/2022
[  411.413891] RIP: 0010:udpv6_queue_rcv_skb (./include/net/udp.h:509
net/ipv6/udp.c:800 net/ipv6/udp.c:787)
[ 411.413912] Code: 70 48 c7 c7 80 77 e6 b5 44 89 c6 e8 3e 72 ef fc 31
d2 48 89 de 48 c7 c7 c0 77 e6 b5 e8 4d e2 74 ff 0f 0b 0f 0b e9 51 fd
ff ff <0f> 0b e9 1c fe ff ff 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48
c1
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0: 70 48                jo     0x4a
   2: c7 c7 80 77 e6 b5    mov    $0xb5e67780,%edi
   8: 44 89 c6              mov    %r8d,%esi
   b: e8 3e 72 ef fc        call   0xfffffffffcef724e
  10: 31 d2                xor    %edx,%edx
  12: 48 89 de              mov    %rbx,%rsi
  15: 48 c7 c7 c0 77 e6 b5 mov    $0xffffffffb5e677c0,%rdi
  1c: e8 4d e2 74 ff        call   0xffffffffff74e26e
  21: 0f 0b                ud2
  23: 0f 0b                ud2
  25: e9 51 fd ff ff        jmp    0xfffffffffffffd7b
  2a:* 0f 0b                ud2    <-- trapping instruction
  2c: e9 1c fe ff ff        jmp    0xfffffffffffffe4d
  31: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
  38: fc ff df
  3b: 4c 89 f2              mov    %r14,%rdx
  3e: 48                    rex.W
  3f: c1                    .byte 0xc1

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0: 0f 0b                ud2
   2: e9 1c fe ff ff        jmp    0xfffffffffffffe23
   7: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
   e: fc ff df
  11: 4c 89 f2              mov    %r14,%rdx
  14: 48                    rex.W
  15: c1                    .byte 0xc1
[  411.413930] RSP: 0018:ffff888112cd6e68 EFLAGS: 00010202
[  411.413949] RAX: 0000000000000000 RBX: ffff88811b52b7c0 RCX: 00000000000=
00002
[  411.413963] RDX: 0000000000000055 RSI: 000000000000008b RDI: ffff88811b5=
2b802
[  411.413976] RBP: 0000000000000036 R08: 0000000000000036 R09: ffff88813ac=
9d0e7
[  411.413988] R10: ffffed1027593a1c R11: 75d99cb20000000f R12: ffff88813ac=
9d080
[  411.414001] R13: dffffc0000000000 R14: ffff8881a34dc0f6 R15: 00000000000=
00000
[  411.414014] FS:  0000000000000000(0000) GS:ffff8883ef680000(0000)
knlGS:0000000000000000
[  411.414029] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  411.414084] CR2: 0000562e17b4bd98 CR3: 00000001188b2000 CR4: 00000000003=
526e0
[  411.414103] Call Trace:
[  411.414114]  <TASK>
[  411.414126] ? __warn (kernel/panic.c:673)
[  411.414149] ? udpv6_queue_rcv_skb (./include/net/udp.h:509
net/ipv6/udp.c:800 net/ipv6/udp.c:787)
[  411.414168] ? report_bug (lib/bug.c:180 lib/bug.c:219)
[  411.414189] ? handle_bug (arch/x86/kernel/traps.c:324)
[  411.414209] ? exc_invalid_op (arch/x86/kernel/traps.c:345 (discriminator=
 1))
[  411.414229] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:568)
[  411.414255] ? udpv6_queue_rcv_skb (./include/net/udp.h:509
net/ipv6/udp.c:800 net/ipv6/udp.c:787)
[  411.414274] ? udpv6_queue_rcv_skb (net/ipv6/udp.c:801 net/ipv6/udp.c:787=
)
[  411.414293] __udp6_lib_rcv (net/ipv6/udp.c:906 net/ipv6/udp.c:1013)
[  411.414314] ? ipv6_chk_mcast_addr (net/ipv6/mcast.c:1048)
[  411.414336] ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:439
(discriminator 4))
[  411.414363] ip6_input_finish (./include/linux/rcupdate.h:805
net/ipv6/ip6_input.c:483)
[  411.414384] ip6_input (./include/linux/netfilter.h:303
./include/linux/netfilter.h:297 net/ipv6/ip6_input.c:491)
[  411.414403] ? ip6_input_finish (net/ipv6/ip6_input.c:490)
[  411.414423] ? fib6_select_path (./include/net/nexthop.h:515
net/ipv6/route.c:435)
[  411.414443] ? ip6_protocol_deliver_rcu
(./include/linux/skbuff.h:4180 net/ipv6/ip6_input.c:480)
[  411.414465] ? ipv6_chk_mcast_addr (net/ipv6/mcast.c:1048)
[  411.414486] ip6_mc_input (net/ipv6/ip6_input.c:591)
[  411.414507] ? ip6_rcv_finish (net/ipv6/ip6_input.c:498)
[  411.414529] ipv6_rcv (./include/net/dst.h:468
net/ipv6/ip6_input.c:79 ./include/linux/netfilter.h:303
./include/linux/netfilter.h:297 net/ipv6/ip6_input.c:309)
[  411.414549] ? ip6_input (net/ipv6/ip6_input.c:303)
[  411.414567] ? kthread (kernel/kthread.c:379)
[  411.414587] ? ret_from_fork (arch/x86/entry/entry_64.S:314)
[  411.414605] ? ipv6_gro_complete (net/ipv6/ip6_offload.c:357)
[  411.414623] ? ipv6_list_rcv (./include/net/l3mdev.h:169
./include/net/l3mdev.h:190 net/ipv6/ip6_input.c:74)
[  411.414644] ? br_dev_queue_push_xmit (net/bridge/br_forward.c:55)
[  411.414666] ? ip6_input (net/ipv6/ip6_input.c:303)
[  411.414685] __netif_receive_skb_one_core (net/core/dev.c:5486)
[  411.414709] ? __netif_receive_skb_list_core (net/core/dev.c:5486)
[  411.414730] ? nf_hook_slow (./include/linux/netfilter.h:143
net/netfilter/core.c:626)
[  411.414754] ? br_forward_finish (./include/linux/netfilter.h:303
./include/linux/netfilter.h:297 net/bridge/br_forward.c:66)
[  411.414774] netif_receive_skb (net/core/dev.c:5693 net/core/dev.c:5752)
[  411.414795] ? __netif_receive_skb (net/core/dev.c:5747)
[  411.414815] ? br_multicast_set_startup_query_intvl
(net/bridge/br_multicast.c:5014)
[  411.414835] ? br_fdb_offloaded_set (net/bridge/br_forward.c:34)
[  411.414857] ? nf_hook_slow (./include/linux/netfilter.h:143
net/netfilter/core.c:626)
[  411.414879] br_pass_frame_up (net/bridge/br_input.c:30
./include/linux/netfilter.h:303 ./include/linux/netfilter.h:297
net/bridge/br_input.c:68)
[  411.414900] ? br_netif_receive_skb (net/bridge/br_input.c:34)
[  411.414921] ? br_multicast_flood (net/bridge/br_forward.c:126
net/bridge/br_forward.c:336)
[  411.414943] ? br_dev_queue_push_xmit (net/bridge/br_forward.c:64)
[  411.414964] ? br_pass_frame_up (net/bridge/br_input.c:30
./include/linux/netfilter.h:303 ./include/linux/netfilter.h:297
net/bridge/br_input.c:68)
[  411.414986] br_handle_frame_finish (net/bridge/br_input.c:216)
[  411.415009] ? br_handle_local_finish (net/bridge/br_input.c:75)
[  411.415031] ? br_nf_post_routing
(net/bridge/br_netfilter_hooks.c:116
net/bridge/br_netfilter_hooks.c:837)
[  411.415070] ? br_nf_pre_routing_finish (net/bridge/br_netfilter_hooks.c:=
481)
[  411.415093] ? br_handle_local_finish (net/bridge/br_input.c:75)
[  411.415115] ? br_nf_post_routing
(net/bridge/br_netfilter_hooks.c:116
net/bridge/br_netfilter_hooks.c:837)
[  411.415135] ? br_nf_pre_routing_finish (net/bridge/br_netfilter_hooks.c:=
481)
[  411.415155] br_handle_frame (net/bridge/br_input.c:298
net/bridge/br_input.c:416)
[  411.415178] ? br_handle_frame_finish (net/bridge/br_input.c:321)
[  411.415201] ? br_handle_local_finish (net/bridge/br_input.c:75)
[  411.415222] ? packet_rcv (net/packet/af_packet.c:2231)
[  411.415242] __netif_receive_skb_core.constprop.0 (net/core/dev.c:5387)
[  411.415265] ? br_handle_frame_finish (net/bridge/br_input.c:321)
[  411.415288] ? do_xdp_generic (net/core/dev.c:5281)
[  411.415309] ? __netif_receive_skb_core.constprop.0 (net/core/dev.c:5387)
[  411.415332] ? udp6_lib_lookup2 (net/ipv6/udp.c:199)
[  411.415352] __netif_receive_skb_list_core (net/core/dev.c:5570)
[  411.415376] ? __netif_receive_skb_core.constprop.0 (net/core/dev.c:5546)
[  411.415398] ? __netif_receive_skb_list_core (net/core/dev.c:5570)
[  411.415419] ? ipv6_portaddr_hash.isra.0 (net/ipv4/inet_hashtables.c:300)
[  411.415438] ? recalibrate_cpu_khz (./arch/x86/include/asm/msr.h:215
arch/x86/kernel/tsc.c:1110)
[  411.415459] ? ktime_get_with_offset (kernel/time/timekeeping.c:292
(discriminator 3) kernel/time/timekeeping.c:388 (discriminator 3)
kernel/time/timekeeping.c:891 (discriminator 3))
[  411.415481] netif_receive_skb_list_internal (net/core/dev.c:5638
net/core/dev.c:5727)
[  411.415504] ? process_backlog (net/core/dev.c:5699)
[  411.415524] ? netif_receive_skb_list_internal (net/core/dev.c:5699)
[  411.415547] ? ipv6_gro_receive (net/ipv6/ip6_offload.c:281 (discriminato=
r 7))
[  411.415565] ? dev_close_many (net/core/dev.c:1516)
[  411.415585] napi_gro_complete.constprop.0
(./include/linux/list.h:37 ./include/net/gro.h:434
./include/net/gro.h:446 net/core/gro.c:328)
[  411.415608] dev_gro_receive (net/core/gro.c:553)
[  411.415631] napi_gro_receive (net/core/gro.c:657)
[  411.415651] ixgbe_poll
(drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2420
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:3178)
[  411.415678] ? ixgbe_xdp_ring_update_tail_locked
(drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:3141)
[  411.415702] ? __napi_poll (./arch/x86/include/asm/bitops.h:207
./arch/x86/include/asm/bitops.h:239
./include/asm-generic/bitops/instrumented-non-atomic.h:142
net/core/dev.c:6497)
[  411.415723] __napi_poll (net/core/dev.c:6498)
[  411.415743] napi_threaded_poll (./include/linux/netpoll.h:89
net/core/dev.c:6640)
[  411.415766] ? __napi_poll (net/core/dev.c:6625)
[  411.415785] ? migrate_enable (kernel/sched/core.c:3045)
[  411.415808] ? __kthread_parkme (./arch/x86/include/asm/bitops.h:207
./arch/x86/include/asm/bitops.h:239
./include/asm-generic/bitops/instrumented-non-atomic.h:142
kernel/kthread.c:271)
[  411.415827] ? __napi_poll (net/core/dev.c:6625)
[  411.415847] kthread (kernel/kthread.c:379)
[  411.415866] ? kthread_complete_and_exit (kernel/kthread.c:336)
[  411.415887] ret_from_fork (arch/x86/entry/entry_64.S:314)
[  411.415908]  </TASK>
[  411.415919] ---[ end trace 0000000000000000 ]---
[  411.415932] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  411.423277] BUG: KASAN: slab-use-after-free in udpv6_queue_rcv_skb
(./include/net/udp.h:524 net/ipv6/udp.c:800 net/ipv6/udp.c:787)
[  411.430624] Write of size 2 at addr ffff88811b52b800 by task napi/eno2-8=
7/942

[  411.439464] CPU: 9 PID: 942 Comm: napi/eno2-87 Tainted: G        W
        6.4.1-dirty #375
[  411.448024] Hardware name: Supermicro Super Server/A2SDi-12C-HLN4F,
BIOS 1.7a 10/13/2022
[  411.456225] Call Trace:
[  411.458772]  <TASK>
[  411.460973] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1))
[  411.464754] print_report (mm/kasan/report.c:352 mm/kasan/report.c:462)
[  411.468455] ? udpv6_queue_rcv_skb (./include/net/udp.h:524
net/ipv6/udp.c:800 net/ipv6/udp.c:787)
[  411.473012] kasan_report (mm/kasan/report.c:574)
[  411.476618] ? udpv6_queue_rcv_skb (./include/net/udp.h:524
net/ipv6/udp.c:800 net/ipv6/udp.c:787)
[  411.481175] udpv6_queue_rcv_skb (./include/net/udp.h:524
net/ipv6/udp.c:800 net/ipv6/udp.c:787)
[  411.485561] __udp6_lib_rcv (net/ipv6/udp.c:906 net/ipv6/udp.c:1013)
[  411.489688] ? ipv6_chk_mcast_addr (net/ipv6/mcast.c:1048)
[  411.494254] ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:439
(discriminator 4))
[  411.499189] ip6_input_finish (./include/linux/rcupdate.h:805
net/ipv6/ip6_input.c:483)
[  411.503240] ip6_input (./include/linux/netfilter.h:303
./include/linux/netfilter.h:297 net/ipv6/ip6_input.c:491)
[  411.506688] ? ip6_input_finish (net/ipv6/ip6_input.c:490)
[  411.511006] ? fib6_select_path (./include/net/nexthop.h:515
net/ipv6/route.c:435)
[  411.515320] ? ip6_protocol_deliver_rcu
(./include/linux/skbuff.h:4180 net/ipv6/ip6_input.c:480)
[  411.520504] ? ipv6_chk_mcast_addr (net/ipv6/mcast.c:1048)
[  411.525079] ip6_mc_input (net/ipv6/ip6_input.c:591)
[  411.528877] ? ip6_rcv_finish (net/ipv6/ip6_input.c:498)
[  411.533020] ipv6_rcv (./include/net/dst.h:468
net/ipv6/ip6_input.c:79 ./include/linux/netfilter.h:303
./include/linux/netfilter.h:297 net/ipv6/ip6_input.c:309)
[  411.536468] ? ip6_input (net/ipv6/ip6_input.c:303)
[  411.540174] ? kthread (kernel/kthread.c:379)
[  411.543703] ? ret_from_fork (arch/x86/entry/entry_64.S:314)
[  411.547575] ? ipv6_gro_complete (net/ipv6/ip6_offload.c:357)
[  411.551980] ? ipv6_list_rcv (./include/net/l3mdev.h:169
./include/net/l3mdev.h:190 net/ipv6/ip6_input.c:74)
[  411.556036] ? br_dev_queue_push_xmit (net/bridge/br_forward.c:55)
[  411.560871] ? ip6_input (net/ipv6/ip6_input.c:303)
[  411.564580] __netif_receive_skb_one_core (net/core/dev.c:5486)
[  411.569765] ? __netif_receive_skb_list_core (net/core/dev.c:5486)
[  411.575213] ? nf_hook_slow (./include/linux/netfilter.h:143
net/netfilter/core.c:626)
[  411.579098] ? br_forward_finish (./include/linux/netfilter.h:303
./include/linux/netfilter.h:297 net/bridge/br_forward.c:66)
[  411.583414] netif_receive_skb (net/core/dev.c:5693 net/core/dev.c:5752)
[  411.587641] ? __netif_receive_skb (net/core/dev.c:5747)
[  411.592218] ? br_multicast_set_startup_query_intvl
(net/bridge/br_multicast.c:5014)
[  411.598102] ? br_fdb_offloaded_set (net/bridge/br_forward.c:34)
[  411.602618] ? nf_hook_slow (./include/linux/netfilter.h:143
net/netfilter/core.c:626)
[  411.606502] br_pass_frame_up (net/bridge/br_input.c:30
./include/linux/netfilter.h:303 ./include/linux/netfilter.h:297
net/bridge/br_input.c:68)
[  411.610645] ? br_netif_receive_skb (net/bridge/br_input.c:34)
[  411.615133] ? br_multicast_flood (net/bridge/br_forward.c:126
net/bridge/br_forward.c:336)
[  411.619708] ? br_dev_queue_push_xmit (net/bridge/br_forward.c:64)
[  411.624545] ? br_pass_frame_up (net/bridge/br_input.c:30
./include/linux/netfilter.h:303 ./include/linux/netfilter.h:297
net/bridge/br_input.c:68)
[  411.628861] br_handle_frame_finish (net/bridge/br_input.c:216)
[  411.633610] ? br_handle_local_finish (net/bridge/br_input.c:75)
[  411.638273] ? br_nf_post_routing
(net/bridge/br_netfilter_hooks.c:116
net/bridge/br_netfilter_hooks.c:837)
[  411.642849] ? br_nf_pre_routing_finish (net/bridge/br_netfilter_hooks.c:=
481)
[  411.648030] ? br_handle_local_finish (net/bridge/br_input.c:75)
[  411.652693] ? br_nf_post_routing
(net/bridge/br_netfilter_hooks.c:116
net/bridge/br_netfilter_hooks.c:837)
[  411.657270] ? br_nf_pre_routing_finish (net/bridge/br_netfilter_hooks.c:=
481)
[  411.662451] br_handle_frame (net/bridge/br_input.c:298
net/bridge/br_input.c:416)
[  411.666596] ? br_handle_frame_finish (net/bridge/br_input.c:321)
[  411.671612] ? br_handle_local_finish (net/bridge/br_input.c:75)
[  411.676274] ? packet_rcv (net/packet/af_packet.c:2231)
[  411.680148] __netif_receive_skb_core.constprop.0 (net/core/dev.c:5387)
[  411.686119] ? br_handle_frame_finish (net/bridge/br_input.c:321)
[  411.691129] ? do_xdp_generic (net/core/dev.c:5281)
[  411.695273] ? __netif_receive_skb_core.constprop.0 (net/core/dev.c:5387)
[  411.701417] ? udp6_lib_lookup2 (net/ipv6/udp.c:199)
[  411.705732] __netif_receive_skb_list_core (net/core/dev.c:5570)
[  411.711004] ? __netif_receive_skb_core.constprop.0 (net/core/dev.c:5546)
[  411.717232] ? __netif_receive_skb_list_core (net/core/dev.c:5570)
[  411.722674] ? ipv6_portaddr_hash.isra.0 (net/ipv4/inet_hashtables.c:300)
[  411.727770] ? recalibrate_cpu_khz (./arch/x86/include/asm/msr.h:215
arch/x86/kernel/tsc.c:1110)
[  411.732172] ? ktime_get_with_offset (kernel/time/timekeeping.c:292
(discriminator 3) kernel/time/timekeeping.c:388 (discriminator 3)
kernel/time/timekeeping.c:891 (discriminator 3))
[  411.736834] netif_receive_skb_list_internal (net/core/dev.c:5638
net/core/dev.c:5727)
[  411.742281] ? process_backlog (net/core/dev.c:5699)
[  411.746506] ? netif_receive_skb_list_internal (net/core/dev.c:5699)
[  411.752122] ? ipv6_gro_receive (net/ipv6/ip6_offload.c:281 (discriminato=
r 7))
[  411.756526] ? dev_close_many (net/core/dev.c:1516)
[  411.760582] napi_gro_complete.constprop.0
(./include/linux/list.h:37 ./include/net/gro.h:434
./include/net/gro.h:446 net/core/gro.c:328)
[  411.765853] dev_gro_receive (net/core/gro.c:553)
[  411.770084] napi_gro_receive (net/core/gro.c:657)
[  411.774224] ixgbe_poll
(drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2420
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:3178)
[  411.778026] ? ixgbe_xdp_ring_update_tail_locked
(drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:3141)
[  411.783644] ? __napi_poll (./arch/x86/include/asm/bitops.h:207
./arch/x86/include/asm/bitops.h:239
./include/asm-generic/bitops/instrumented-non-atomic.h:142
net/core/dev.c:6497)
[  411.787440] __napi_poll (net/core/dev.c:6498)
[  411.791064] napi_threaded_poll (./include/linux/netpoll.h:89
net/core/dev.c:6640)
[  411.795381] ? __napi_poll (net/core/dev.c:6625)
[  411.799258] ? migrate_enable (kernel/sched/core.c:3045)
[  411.803404] ? __kthread_parkme (./arch/x86/include/asm/bitops.h:207
./arch/x86/include/asm/bitops.h:239
./include/asm-generic/bitops/instrumented-non-atomic.h:142
kernel/kthread.c:271)
[  411.807631] ? __napi_poll (net/core/dev.c:6625)
[  411.811515] kthread (kernel/kthread.c:379)
[  411.814876] ? kthread_complete_and_exit (kernel/kthread.c:336)
[  411.819800] ret_from_fork (arch/x86/entry/entry_64.S:314)
[  411.823505]  </TASK>

[  411.827426] Allocated by task 933:
[  411.830945] kasan_save_stack (mm/kasan/common.c:46)
[  411.830969] kasan_set_track (mm/kasan/common.c:52)
[  411.830987] __kasan_slab_alloc (mm/kasan/common.c:328)
[  411.831006] kmem_cache_alloc_bulk (mm/slab.h:711 mm/slub.c:4033)
[  411.831025] napi_skb_cache_get (net/core/skbuff.c:338)
[  411.831044] __napi_build_skb (net/core/skbuff.c:517)
[  411.831062] napi_build_skb (net/core/skbuff.c:539)
[  411.831080] ixgbe_poll
(drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2165
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2361
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:3178)
[  411.831097] __napi_poll (net/core/dev.c:6498)
[  411.831114] napi_threaded_poll (./include/linux/netpoll.h:89
net/core/dev.c:6640)
[  411.831131] kthread (kernel/kthread.c:379)
[  411.831148] ret_from_fork (arch/x86/entry/entry_64.S:314)

[  411.832772] Freed by task 996:
[  411.835945] kasan_save_stack (mm/kasan/common.c:46)
[  411.835965] kasan_set_track (mm/kasan/common.c:52)
[  411.835984] kasan_save_free_info (mm/kasan/generic.c:523)
[  411.836000] __kasan_slab_free (mm/kasan/common.c:238
mm/kasan/common.c:200 mm/kasan/common.c:244)
[  411.836019] kmem_cache_free (mm/slub.c:1807 mm/slub.c:3786 mm/slub.c:380=
8)
[  411.836036] tun_do_read (drivers/net/tun.c:2242)
[  411.836054] tun_recvmsg (drivers/net/tun.c:2624)
[  411.836070] handle_rx (drivers/vhost/net.c:1213)
[  411.836089] vhost_worker (./include/linux/sched.h:2086
(discriminator 3) drivers/vhost/vhost.c:354 (discriminator 3))
[  411.836104] vhost_task_fn (kernel/vhost_task.c:56)
[  411.836122] ret_from_fork (arch/x86/entry/entry_64.S:314)

[  411.837746] The buggy address belongs to the object at ffff88811b52b7c0
which belongs to the cache skbuff_head_cache of size 224
[  411.850937] The buggy address is located 64 bytes inside of
freed 224-byte region [ffff88811b52b7c0, ffff88811b52b8a0)

[  411.864866] The buggy address belongs to the physical page:
[  411.870561] page:00000000e6f9dafd refcount:1 mapcount:0
mapping:0000000000000000 index:0x0 pfn:0x11b52a
[  411.870582] head:00000000e6f9dafd order:1 entire_mapcount:0
nr_pages_mapped:0 pincount:0
[  411.870598] flags: 0x8000000000010200(slab|head|zone=3D2)
[  411.870616] page_type: 0xffffffff()
[  411.870634] raw: 8000000000010200 ffff88810033adc0 dead000000000122
0000000000000000
[  411.870650] raw: 0000000000000000 0000000000190019 00000001ffffffff
0000000000000000
[  411.870661] page dumped because: kasan: bad access detected

[  411.872284] Memory state around the buggy address:
[  411.877201]  ffff88811b52b700: fb fb fb fb fb fb fb fb fb fb fb fb
fc fc fc fc
[  411.884566]  ffff88811b52b780: fc fc fc fc fc fc fc fc fa fb fb fb
fb fb fb fb
[  411.891933] >ffff88811b52b800: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[  411.899295]                    ^
[  411.902644]  ffff88811b52b880: fb fb fb fb fc fc fc fc fc fc fc fc
fc fc fc fc
[  411.910011]  ffff88811b52b900: fa fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[  411.917373] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  411.924832] Disabling lock debugging due to kernel taint

On Tue, Jul 4, 2023 at 4:06=E2=80=AFPM Ian Kumlien <ian.kumlien@gmail.com> =
wrote:
>
> On Tue, Jul 4, 2023 at 3:41=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
> >
> > On Tue, 2023-07-04 at 15:23 +0200, Ian Kumlien wrote:
> > > On Tue, Jul 4, 2023 at 2:54=E2=80=AFPM Paolo Abeni <pabeni@redhat.com=
> wrote:
> > > >
> > > > On Tue, 2023-07-04 at 13:36 +0200, Ian Kumlien wrote:
> > > > > Propper bug this time:
> > > > > cat bug.txt | ./scripts/decode_stacktrace.sh vmlinux
> > > >
> > > > To be sure, is this with the last patch I shared? this one I mean:
> > >
> > > The current modifications I have, on top of v6.4.1, is:
> > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > index cea28d30abb5..8552caa197f9 100644
> > > --- a/net/core/skbuff.c
> > > +++ b/net/core/skbuff.c
> > > @@ -4272,6 +4272,11 @@ struct sk_buff *skb_segment_list(struct sk_buf=
f *skb,
> > >
> > >         skb_shinfo(skb)->frag_list =3D NULL;
> > >
> > > +       /* later code will clear the gso area in the shared info */
> > > +       err =3D skb_header_unclone(skb, GFP_ATOMIC);
> > > +       if (err)
> > > +               goto err_linearize;
> > > +
> > >         while (list_skb) {
> > >                 nskb =3D list_skb;
> > >                 list_skb =3D list_skb->next;
> > > @@ -4328,6 +4333,9 @@ struct sk_buff *skb_segment_list(struct sk_buff=
 *skb,
> > >
> > >         skb->prev =3D tail;
> > >
> > > +       if (WARN_ON_ONCE(!skb->next))
> > > +               goto err_linearize;
> > > +
> > >         if (skb_needs_linearize(skb, features) &&
> > >             __skb_linearize(skb))
> > >                 goto err_linearize;
> > > ---
> > >
> > > > https://lore.kernel.org/netdev/92a4d42491a2c219192ae86fa04b579ea367=
6d8c.camel@redhat.com/
> > > >
> > > > Could you please additionally enable CONFIG_DEBUG_NET in your build=
?
> > >
> > > Sure, will do
> > >
> > > > Could you please give a detailed description of your network topolo=
gy
> > > > and the running traffic?
> > >
> > > This machine has two "real interfaces" and two interfaces that runs a=
s
> > > bridges for virtual machines
> > > eno1 - real internal
> > > eno2 - bridge - internal
> > > eno3 - real external
> > > eno4 - bridge - external
> > >
> > > The bridges are used by three virtual machines, two of which are
> > > attached on both networks
> > >
> > > Traffic seemed to be video streaming, at least at first, now I don't
> > > really know. I do have a few smart devices so I assume there is
> > > a bit of multicast traffic as well - but not really anything unusual =
as such.
> >
> > In there any XDP program running on the host side? Possibly changing
> > the packet hdr?
>
> Only systemd standard things, I haven't done anything and the normal
> nftables fw doesn't do anything special
>
> > Thanks!
> >
> > /P
> >
