Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4E474700A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 13:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjGDLgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 07:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjGDLgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 07:36:43 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFB7113;
        Tue,  4 Jul 2023 04:36:41 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-47191280066so1580195e0c.2;
        Tue, 04 Jul 2023 04:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688470600; x=1691062600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDLXsZkAoAHuO+fU7P0n10KX9AqtC/VUc9HIIhbOcJE=;
        b=H2TjhyTBh38s0AXIC24SfTl3wsO1yGxvc84XFFaB+lOVKYSHTlEX02Jxc1CTqRoJHD
         ZIApItJcBBJC1TE7VBURMWEdUEIm9OI6MkiewwmZ2WNo2QQIsnIsmxAsHan8TqAMbIDI
         EtEX/acF0tl04WsIdRGbyjAEw/XCgkaoQoltqrlIryz3qKe9E3FKQQ5TyfQEF4rJEQD1
         SRegEEFRRYCkx9+paBV0UxZQS5e++AHjS5JzTu4k4nke2623tHTcpmLxj4tn3tYuKh1p
         vNjcXSIbalWzPaWKtD8i3Lk9dgJZWYqvMlhZI0BjUyX/ISY/rM/kgl8HZNqHNiI5MMVh
         tkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688470600; x=1691062600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pDLXsZkAoAHuO+fU7P0n10KX9AqtC/VUc9HIIhbOcJE=;
        b=FsDlx2AeK0Fwuz+oymHJUvcr6BcuWcQEf4Aa/Yzyox/byAyolkDNLmolBCz7RgWhhx
         SvTs7hpBYIR60QZ5hkIvR2nlY9CSgRYRzQXe7PHWaUPkVltHlQRB7BPOGxCXM5CJZnLc
         Ya2Jd0RFvkN2dDGtNDseDLSXbdiHl8Aaektxt4ZhZjnWGqcShEtD07NeOfRuJrO9dynu
         54+C54mD9+vCd/D9QiOLitvbPk4d5A8ediBZmQCRGXxYthbWnPe33hwzo0tfrZ+TFt0X
         CYJJNHx62nH7MyJSiMZfJW7NRorVF20JqX6RVeZODXzoq7opOfnGhaKQHpo4Vq2unJaU
         uxCQ==
X-Gm-Message-State: ABy/qLaeMdhBQeSqpdfsS4eHLg4AtE/L8ofQjzF+NGRpD2yzFQRLOXDf
        +d0RUVgdYs29sOpsg6qs5RE34jkzcrvv1XtaSNk=
X-Google-Smtp-Source: APBJJlFRJrlNhTDYOg6FKLeugO+z2shvJ7IBHB4LXhpfv2LOO42Zzze2qCId5CnToMTt1iWskWhjDQZvTW3HMyXXTz8=
X-Received: by 2002:a1f:6005:0:b0:471:7498:e871 with SMTP id
 u5-20020a1f6005000000b004717498e871mr5654149vkb.10.1688470600135; Tue, 04 Jul
 2023 04:36:40 -0700 (PDT)
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
 <CAA85sZs_H3Dc-mYnj8J5VBEwUJwbHUupP+U-4eG20nfAHBtv4w@mail.gmail.com> <92a4d42491a2c219192ae86fa04b579ea3676d8c.camel@redhat.com>
In-Reply-To: <92a4d42491a2c219192ae86fa04b579ea3676d8c.camel@redhat.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Tue, 4 Jul 2023 13:36:28 +0200
Message-ID: <CAA85sZvtspqfep+6rH8re98-A6rHNNWECvwqVaM=r=0NSSsGzA@mail.gmail.com>
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

Propper bug this time:
cat bug.txt | ./scripts/decode_stacktrace.sh vmlinux
[  226.265742] ------------[ cut here ]------------
[  226.265767] kernel BUG at include/linux/skbuff.h:2645!
[  226.271087] invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
[  226.276962] CPU: 2 PID: 948 Comm: napi/eno2-81 Tainted: G        W
        6.4.1-dirty #374
[  226.285520] Hardware name: Supermicro Super Server/A2SDi-12C-HLN4F,
BIOS 1.7a 10/13/2022
[  226.293717] RIP: 0010:udpv6_queue_rcv_skb
(./include/linux/skbuff.h:2645 net/ipv6/udp.c:798 net/ipv6/udp.c:787)
[ 226.298901] Code: 04 00 00 b9 01 00 00 00 48 89 de e8 bb ac f7 ff 4d
85 f6 75 97 48 83 c4 08 31 c0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc
cc cc <0f> 0b 0f 0b e9 b1 fe ff ff e8 f3 38 41 fd e9 63 fb ff ff 4c 89
e7
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0: 04 00                add    $0x0,%al
   2: 00 b9 01 00 00 00    add    %bh,0x1(%rcx)
   8: 48 89 de              mov    %rbx,%rsi
   b: e8 bb ac f7 ff        call   0xfffffffffff7accb
  10: 4d 85 f6              test   %r14,%r14
  13: 75 97                jne    0xffffffffffffffac
  15: 48 83 c4 08          add    $0x8,%rsp
  19: 31 c0                xor    %eax,%eax
  1b: 5b                    pop    %rbx
  1c: 5d                    pop    %rbp
  1d: 41 5c                pop    %r12
  1f: 41 5d                pop    %r13
  21: 41 5e                pop    %r14
  23: 41 5f                pop    %r15
  25: c3                    ret
  26: cc                    int3
  27: cc                    int3
  28: cc                    int3
  29: cc                    int3
  2a:* 0f 0b                ud2    <-- trapping instruction
  2c: 0f 0b                ud2
  2e: e9 b1 fe ff ff        jmp    0xfffffffffffffee4
  33: e8 f3 38 41 fd        call   0xfffffffffd41392b
  38: e9 63 fb ff ff        jmp    0xfffffffffffffba0
  3d: 4c 89 e7              mov    %r12,%rdi

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0: 0f 0b                ud2
   2: 0f 0b                ud2
   4: e9 b1 fe ff ff        jmp    0xfffffffffffffeba
   9: e8 f3 38 41 fd        call   0xfffffffffd413901
   e: e9 63 fb ff ff        jmp    0xfffffffffffffb76
  13: 4c 89 e7              mov    %r12,%rdi
[  226.317801] RSP: 0018:ffff888107b8ee78 EFLAGS: 00010207
[  226.323151] RAX: 0000000000000007 RBX: ffff888109dfe8c0 RCX: 00000000000=
00000
[  226.330403] RDX: ffff8881227200c0 RSI: 0000000000000004 RDI: ffff888109d=
fe934
[  226.337646] RBP: 0000000000000036 R08: 0000000000000001 R09: ffff888109d=
fe997
[  226.344892] R10: ffffed10213bfd32 R11: 00c000ce00f6dd86 R12: dffffc00000=
00000
[  226.352137] R13: ffff8881186ae780 R14: ffff888109dff2c0 R15: 00000000000=
00025
[  226.359383] FS:  0000000000000000(0000) GS:ffff8883ef300000(0000)
knlGS:0000000000000000
[  226.367590] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  226.373449] CR2: 00007f40938086d0 CR3: 00000001197c0000 CR4: 00000000003=
526e0
[  226.380705] Call Trace:
[  226.383282]  <TASK>
[  226.385507] ? die (arch/x86/kernel/dumpstack.c:421
arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447)
[  226.388521] ? do_trap (arch/x86/kernel/traps.c:124
arch/x86/kernel/traps.c:165)
[  226.392056] ? udpv6_queue_rcv_skb (./include/linux/skbuff.h:2645
net/ipv6/udp.c:798 net/ipv6/udp.c:787)
[  226.396635] ? udpv6_queue_rcv_skb (./include/linux/skbuff.h:2645
net/ipv6/udp.c:798 net/ipv6/udp.c:787)
[  226.401211] ? handle_invalid_op (arch/x86/kernel/traps.c:88
arch/x86/kernel/traps.c:186 arch/x86/kernel/traps.c:297)
[  226.405438] ? udpv6_queue_rcv_skb (./include/linux/skbuff.h:2645
net/ipv6/udp.c:798 net/ipv6/udp.c:787)
[  226.410016] ? exc_invalid_op (arch/x86/kernel/traps.c:352)
[  226.413983] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:568)
[  226.418305] ? udpv6_queue_rcv_skb (./include/linux/skbuff.h:2645
net/ipv6/udp.c:798 net/ipv6/udp.c:787)
[  226.422886] ? udpv6_queue_rcv_skb (net/ipv6/udp.c:797 net/ipv6/udp.c:787=
)
[  226.427461] __udp6_lib_rcv (net/ipv6/udp.c:906 net/ipv6/udp.c:1013)
[  226.431606] ? ipv6_chk_mcast_addr (net/ipv6/mcast.c:1048)
[  226.436186] ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:439
(discriminator 4))
[  226.441116] ip6_input_finish (./include/linux/rcupdate.h:805
net/ipv6/ip6_input.c:483)
[  226.445174] ip6_input (./include/linux/netfilter.h:303
./include/linux/netfilter.h:297 net/ipv6/ip6_input.c:491)
[  226.448623] ? ip6_input_finish (net/ipv6/ip6_input.c:490)
[  226.452939] ? ip6_route_del (net/ipv6/route.c:3949 net/ipv6/route.c:4090=
)
[  226.457082] ? ip6_protocol_deliver_rcu
(./include/linux/skbuff.h:4180 net/ipv6/ip6_input.c:480)
[  226.462266] ? ipv6_chk_mcast_addr (net/ipv6/mcast.c:1048)
[  226.466840] ip6_mc_input (net/ipv6/ip6_input.c:591)
[  226.470639] ? ip6_rcv_finish (net/ipv6/ip6_input.c:498)
[  226.474783] ipv6_rcv (./include/net/dst.h:468
net/ipv6/ip6_input.c:79 ./include/linux/netfilter.h:303
./include/linux/netfilter.h:297 net/ipv6/ip6_input.c:309)
[  226.478229] ? ip6_input (net/ipv6/ip6_input.c:303)
[  226.481937] ? kthread (kernel/kthread.c:379)
[  226.485473] ? ret_from_fork (arch/x86/entry/entry_64.S:314)
[  226.489348] ? ipv6_mc_validate_checksum (net/ipv6/mcast_snoop.c:173)
[  226.494443] ? ipv6_list_rcv (./include/net/l3mdev.h:169
./include/net/l3mdev.h:190 net/ipv6/ip6_input.c:74)
[  226.498500] ? br_dev_queue_push_xmit (net/bridge/br_forward.c:55)
[  226.503334] ? ip6_input (net/ipv6/ip6_input.c:303)
[  226.507045] __netif_receive_skb_one_core (net/core/dev.c:5486)
[  226.512237] ? __netif_receive_skb_list_core (net/core/dev.c:5486)
[  226.517688] ? nf_hook_slow (./include/linux/netfilter.h:143
net/netfilter/core.c:626)
[  226.521569] ? br_forward_finish (./include/linux/netfilter.h:303
./include/linux/netfilter.h:297 net/bridge/br_forward.c:66)
[  226.525887] netif_receive_skb (net/core/dev.c:5693 net/core/dev.c:5752)
[  226.530114] ? __netif_receive_skb (net/core/dev.c:5747)
[  226.534691] ? br_multicast_set_startup_query_intvl
(net/bridge/br_multicast.c:5014)
[  226.540574] ? br_fdb_offloaded_set (net/bridge/br_forward.c:34)
[  226.545066] ? nf_hook_slow (./include/linux/netfilter.h:143
net/netfilter/core.c:626)
[  226.548949] br_pass_frame_up (net/bridge/br_input.c:30
./include/linux/netfilter.h:303 ./include/linux/netfilter.h:297
net/bridge/br_input.c:68)
[  226.553091] ? br_netif_receive_skb (net/bridge/br_input.c:34)
[  226.557579] ? br_multicast_flood (net/bridge/br_forward.c:126
net/bridge/br_forward.c:336)
[  226.562154] ? br_dev_queue_push_xmit (net/bridge/br_forward.c:64)
[  226.566992] ? br_pass_frame_up (net/bridge/br_input.c:30
./include/linux/netfilter.h:303 ./include/linux/netfilter.h:297
net/bridge/br_input.c:68)
[  226.571311] br_handle_frame_finish (net/bridge/br_input.c:216)
[  226.576085] ? br_handle_local_finish (net/bridge/br_input.c:75)
[  226.580753] ? br_nf_dev_queue_xmit
(net/bridge/br_netfilter_hooks.c:165
net/bridge/br_netfilter_hooks.c:778)
[  226.585503] ? sysvec_call_function_single (arch/x86/kernel/smp.c:262)
[  226.590607] ? br_nf_pre_routing_finish (net/bridge/br_netfilter_hooks.c:=
481)
[  226.595792] ? migrate_enable (kernel/sched/core.c:2291)
[  226.599942] ? br_nf_pre_routing_finish (net/bridge/br_netfilter_hooks.c:=
481)
[  226.605124] br_handle_frame (net/bridge/br_input.c:298
net/bridge/br_input.c:416)
[  226.609267] ? asm_sysvec_apic_timer_interrupt
(./arch/x86/include/asm/idtentry.h:645)
[  226.614720] ? br_handle_frame_finish (net/bridge/br_input.c:321)
[  226.619755] ? br_handle_local_finish (net/bridge/br_input.c:75)
[  226.624434] ? packet_rcv (net/packet/af_packet.c:2231)
[  226.628337] __netif_receive_skb_core.constprop.0 (net/core/dev.c:5387)
[  226.634336] ? br_handle_frame_finish (net/bridge/br_input.c:321)
[  226.639378] ? do_xdp_generic (net/core/dev.c:5281)
[  226.643543] ? write_profile (kernel/stacktrace.c:86)
[  226.647631] ? udp6_lib_lookup2 (net/ipv6/udp.c:199)
[  226.651972] __netif_receive_skb_list_core (net/core/dev.c:5570)
[  226.657277] ? __netif_receive_skb_core.constprop.0 (net/core/dev.c:5546)
[  226.663531] ? kasan_save_stack (mm/kasan/common.c:46)
[  226.667698] ? kasan_set_track (mm/kasan/common.c:52)
[  226.671768] ? __kasan_slab_alloc (mm/kasan/common.c:328)
[  226.676095] ? ipv6_portaddr_hash.isra.0 (net/ipv4/inet_hashtables.c:300)
[  226.681198] ? napi_threaded_poll (./include/linux/netpoll.h:89
net/core/dev.c:6640)
[  226.685684] ? kthread (kernel/kthread.c:379)
[  226.689221] ? ret_from_fork (arch/x86/entry/entry_64.S:314)
[  226.693105] ? recalibrate_cpu_khz (./arch/x86/include/asm/msr.h:215
arch/x86/kernel/tsc.c:1110)
[  226.697507] ? ktime_get_with_offset (kernel/time/timekeeping.c:292
(discriminator 3) kernel/time/timekeeping.c:388 (discriminator 3)
kernel/time/timekeeping.c:891 (discriminator 3))
[  226.702176] netif_receive_skb_list_internal (net/core/dev.c:5638
net/core/dev.c:5727)
[  226.707643] ? process_backlog (net/core/dev.c:5699)
[  226.711884] ? setup_object (mm/slub.c:1832)
[  226.715681] ? ipv6_gro_receive (net/ipv6/ip6_offload.c:281 (discriminato=
r 7))
[  226.720085] napi_gro_complete.constprop.0
(./include/linux/list.h:37 ./include/net/gro.h:434
./include/net/gro.h:446 net/core/gro.c:328)
[  226.725365] dev_gro_receive (net/core/gro.c:553)
[  226.729515] ? ixgbe_alloc_rx_buffers
(drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:1602)
[  226.734361] napi_gro_receive (net/core/gro.c:657)
[  226.738511] ixgbe_poll
(drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2420
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:3178)
[  226.742322] ? ixgbe_xdp_ring_update_tail_locked
(drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:3141)
[  226.747949] ? common_interrupt (arch/x86/kernel/irq.c:240)
[  226.752111] __napi_poll (net/core/dev.c:6498)
[  226.755741] napi_threaded_poll (./include/linux/netpoll.h:89
net/core/dev.c:6640)
[  226.760067] ? __napi_poll (net/core/dev.c:6625)
[  226.763952] ? migrate_enable (kernel/sched/core.c:3045)
[  226.768100] ? __kthread_parkme (./arch/x86/include/asm/bitops.h:207
./arch/x86/include/asm/bitops.h:239
./include/asm-generic/bitops/instrumented-non-atomic.h:142
kernel/kthread.c:271)
[  226.772341] ? __napi_poll (net/core/dev.c:6625)
[  226.776227] kthread (kernel/kthread.c:379)
[  226.779589] ? kthread_complete_and_exit (kernel/kthread.c:336)
[  226.784518] ret_from_fork (arch/x86/entry/entry_64.S:314)
[  226.788233]  </TASK>
[  226.790540] Modules linked in: chaoskey
[  226.794603] ---[ end trace 0000000000000000 ]---
[  226.829752] pstore: backend (erst) writing error (-28)
[  226.835076] RIP: 0010:udpv6_queue_rcv_skb
(./include/linux/skbuff.h:2645 net/ipv6/udp.c:798 net/ipv6/udp.c:787)
[ 226.840291] Code: 04 00 00 b9 01 00 00 00 48 89 de e8 bb ac f7 ff 4d
85 f6 75 97 48 83 c4 08 31 c0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc
cc cc <0f> 0b 0f 0b e9 b1 fe ff ff e8 f3 38 41 fd e9 63 fb ff ff 4c 89
e7
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0: 04 00                add    $0x0,%al
   2: 00 b9 01 00 00 00    add    %bh,0x1(%rcx)
   8: 48 89 de              mov    %rbx,%rsi
   b: e8 bb ac f7 ff        call   0xfffffffffff7accb
  10: 4d 85 f6              test   %r14,%r14
  13: 75 97                jne    0xffffffffffffffac
  15: 48 83 c4 08          add    $0x8,%rsp
  19: 31 c0                xor    %eax,%eax
  1b: 5b                    pop    %rbx
  1c: 5d                    pop    %rbp
  1d: 41 5c                pop    %r12
  1f: 41 5d                pop    %r13
  21: 41 5e                pop    %r14
  23: 41 5f                pop    %r15
  25: c3                    ret
  26: cc                    int3
  27: cc                    int3
  28: cc                    int3
  29: cc                    int3
  2a:* 0f 0b                ud2    <-- trapping instruction
  2c: 0f 0b                ud2
  2e: e9 b1 fe ff ff        jmp    0xfffffffffffffee4
  33: e8 f3 38 41 fd        call   0xfffffffffd41392b
  38: e9 63 fb ff ff        jmp    0xfffffffffffffba0
  3d: 4c 89 e7              mov    %r12,%rdi

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0: 0f 0b                ud2
   2: 0f 0b                ud2
   4: e9 b1 fe ff ff        jmp    0xfffffffffffffeba
   9: e8 f3 38 41 fd        call   0xfffffffffd413901
   e: e9 63 fb ff ff        jmp    0xfffffffffffffb76
  13: 4c 89 e7              mov    %r12,%rdi
[  226.859293] RSP: 0018:ffff888107b8ee78 EFLAGS: 00010207
[  226.864692] RAX: 0000000000000007 RBX: ffff888109dfe8c0 RCX: 00000000000=
00000
[  226.871994] RDX: ffff8881227200c0 RSI: 0000000000000004 RDI: ffff888109d=
fe934
[  226.879294] RBP: 0000000000000036 R08: 0000000000000001 R09: ffff888109d=
fe997
[  226.886588] R10: ffffed10213bfd32 R11: 00c000ce00f6dd86 R12: dffffc00000=
00000
[  226.893899] R13: ffff8881186ae780 R14: ffff888109dff2c0 R15: 00000000000=
00025
[  226.901198] FS:  0000000000000000(0000) GS:ffff8883ef300000(0000)
knlGS:0000000000000000
[  226.909470] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  226.915379] CR2: 00007f40938086d0 CR3: 00000001197c0000 CR4: 00000000003=
526e0
[  226.922684] Kernel panic - not syncing: Fatal exception in interrupt


On Tue, Jul 4, 2023 at 12:10=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Mon, 2023-07-03 at 11:37 +0200, Ian Kumlien wrote:
> > So, got back, switched to 6.4.1 and reran with kmemleak and kasan
> >
> > I got the splat from:
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index cea28d30abb5..701c1b5cf532 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -4328,6 +4328,9 @@ struct sk_buff *skb_segment_list(struct sk_buff *=
skb,
> >
> >         skb->prev =3D tail;
> >
> > +       if (WARN_ON_ONCE(!skb->next))
> > +               goto err_linearize;
> > +
> >         if (skb_needs_linearize(skb, features) &&
> >             __skb_linearize(skb))
> >                 goto err_linearize;
> >
> > I'm just happy i ran with dmesg -W since there was only minimal output
> > on the console:
> > [39914.833696] rcu: INFO: rcu_preempt self-detected stall on CPU
> > [39914.839598] rcu:     2-....: (20997 ticks this GP)
> > idle=3Ddd64/1/0x4000000000000000 softirq=3D4633489/4633489 fqs=3D4687
> > [39914.849839] rcu:     (t=3D21017 jiffies g=3D18175157 q=3D45473 ncpus=
=3D12)
> > [39977.862108] rcu: INFO: rcu_preempt self-detected stall on CPU
> > [39977.868002] rcu:     2-....: (84001 ticks this GP)
> > idle=3Ddd64/1/0x4000000000000000 softirq=3D4633489/4633489 fqs=3D28434
> > [39977.878340] rcu:     (t=3D84047 jiffies g=3D18175157 q=3D263477 ncpu=
s=3D12)
> > [40040.892521] rcu: INFO: rcu_preempt self-detected stall on CPU
> > [40040.898414] rcu:     2-....: (147006 ticks this GP)
> > idle=3Ddd64/1/0x4000000000000000 softirq=3D4633489/4633489 fqs=3D53043
> > [40040.908831] rcu:     (t=3D147079 jiffies g=3D18175157 q=3D464422 ncp=
us=3D12)
> > [40065.080842] ixgbe 0000:06:00.1 eno2: Reset adapter
>
> Ouch, just another slightly different issue, apparently :(
>
> I'll try some wild guesses. The rcu stall could cause the OOM observed
> in the previous tests. Here we the OOM did not trigger because due to
> kasan/kmemleak the kernel is able to process a lesser number of packets
> in the same period of time.
>
> [...]
> > [39914.857231] skb_segment (net/core/skbuff.c:4519)
>
> I *think* this could be looping "forever", if gso_size becomes 0, which
> is in turn completely unexpected ...
>
>
> > [39914.857257] ? write_profile (kernel/stacktrace.c:83)
> > [39914.857296] ? pskb_extract (net/core/skbuff.c:4360)
> > [39914.857320] ? rt6_score_route (net/ipv6/route.c:713 (discriminator 1=
))
> > [39914.857346] ? llist_add_batch (lib/llist.c:33 (discriminator 14))
> > [39914.857379] __udp_gso_segment (net/ipv4/udp_offload.c:290)
> > [39914.857413] ? ip6_dst_destroy (net/ipv6/route.c:788)
> > [39914.857442] udp6_ufo_fragment (net/ipv6/udp_offload.c:47)
> > [39914.857472] ? udp6_gro_complete (net/ipv6/udp_offload.c:20)
> > [39914.857498] ? ipv6_gso_pull_exthdrs (net/ipv6/ip6_offload.c:53)
> > [39914.857528] ipv6_gso_segment (net/ipv6/ip6_offload.c:119
> > net/ipv6/ip6_offload.c:74)
> > [39914.857557] ? ipv6_gso_pull_exthdrs (net/ipv6/ip6_offload.c:76)
> > [39914.857583] ? nft_update_chain_stats (net/netfilter/nf_tables_core.c=
:254)
> > [39914.857612] ? fib6_select_path (net/ipv6/route.c:458)
> > [39914.857643] skb_mac_gso_segment (net/core/gro.c:141)
> > [39914.857673] ? skb_eth_gso_segment (net/core/gro.c:127)
> > [39914.857702] ? ipv6_skip_exthdr (net/ipv6/exthdrs_core.c:190)
> > [39914.857726] ? kasan_save_stack (mm/kasan/common.c:47)
> > [39914.857758] __skb_gso_segment (net/core/dev.c:3401 (discriminator 2)=
)
> > [39914.857787] udpv6_queue_rcv_skb (./include/net/udp.h:492
> > net/ipv6/udp.c:796 net/ipv6/udp.c:787)
> > [39914.857816] __udp6_lib_rcv (net/ipv6/udp.c:906 net/ipv6/udp.c:1013)
>
> ... but this means we are processing a multicast packet, likely skb is
> cloned. If one of the clone instance enters simultaneusly
> skb_segment_list() the latter would inconditionally call:
>
>         skb_gso_reset(skb);
>
> clearing the gso area in the shared info and causing unexpected results
> (possibly the memory corruption observed before, and the above RCU
> stall) for the other clone instances.
>
> Assuming there are no other issues and that the above is not just a
> side effect of ENOCOFFEE here, the following should possibly solve,
> could you please add it to your testbed? (still with kasan+previous
> patch, kmemleak is possibly not needed).
>
> Thanks!
> ---
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 6c5915efbc17..ac1ca6c7bff9 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4263,6 +4263,11 @@ struct sk_buff *skb_segment_list(struct sk_buff *s=
kb,
>
>         skb_shinfo(skb)->frag_list =3D NULL;
>
> +       /* later code will clear the gso area in the shared info */
> +       err =3D skb_header_unclone(skb, GFP_ATOMIC);
> +       if (err)
> +               goto err_linearize;
> +
>         while (list_skb) {
>                 nskb =3D list_skb;
>                 list_skb =3D list_skb->next;
>
