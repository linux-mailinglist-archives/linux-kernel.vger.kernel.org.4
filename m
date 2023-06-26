Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DF373EABF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 20:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjFZS7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 14:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFZS7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:59:35 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601E913D;
        Mon, 26 Jun 2023 11:59:33 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-47148f11fe6so1427953e0c.2;
        Mon, 26 Jun 2023 11:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687805972; x=1690397972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnIKTVlr3r5lUzWSfOEJW3TGmQWaYlqSKdVHfEPHS8M=;
        b=bJhtzy9pThLua1c/0oTGPKCdWcoDCoUnPYqo5GxTsF9kxx7DJukvf9/eP+o1/j3IgB
         3TfVF8VaMi1iIfsJ0/G7Ad5TMEvU62owCJiV0IJ0xQcyBIH+G1EYmqJFzssil1w0UU14
         EcBXoa2AzzXNn7XisjQbSwcEBrEKdTjc3BiA57ZJ14AnvtKKf9jWz1ac0Y65mEZwVWrV
         5aet0klW750uUPYIqkt+A5ljy4Z6msWqZL4sK9ueh6yoy+GIX3+mAI3rmbF1GrQfeE9w
         audPP/R4Bg0ktH7MIPVIr6BhePwBER5+w5p8OXBQYbtAP8twg3xuqAvNg95slgs6h4Nd
         DKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687805972; x=1690397972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZnIKTVlr3r5lUzWSfOEJW3TGmQWaYlqSKdVHfEPHS8M=;
        b=RnkTk6OD4WJ6j/1sZtmyDBhubW7stQq+FQz4yoWb7NS1ToEeNz+JC2YCGoaZJEsEoo
         pLTjgqF00vqXuOhOUzeYu4eqhfWEYqdwk19ru7RnfIdbWXVXktfsE3zkZYETpAg8MDeX
         tViGiioJf4QkKR3IjNRKmHj4aNlGAOfkCBee2f6KuwGUPY5GdGDOTDRlEDw68j+I35Ft
         v7Ic8NerEmzY2g1LifnDp6FXtLxxuNCmKSMFOf5lKhhrGaAbM5iCS2r1vYUPExTmedGd
         ohdI+l8Pkc85Am66n4obGfgEocCH1bEnBW2vuDG90TjcJxOoOShfob1nb7xrV9Oj3zdf
         EBTg==
X-Gm-Message-State: AC+VfDyLYKXs07CKLl0xX9q4gKUX/fC2gyog+Fs2QXlLb7KNAPU0LUtd
        cf15V58i0cXr0wG/SShhv5fben2HhjWvjb/prO0=
X-Google-Smtp-Source: ACHHUZ5CLSpzJU7UImFKgtTfJ4fB3RGpAN71aVTWbO1RfyHdz19WoOQr8V6+6LrsjAVa5HafJqmUGz3wJavBNXhcKak=
X-Received: by 2002:a1f:5e92:0:b0:471:b111:4557 with SMTP id
 s140-20020a1f5e92000000b00471b1114557mr13217844vkb.12.1687805972155; Mon, 26
 Jun 2023 11:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZukiFq4A+b9+en_G85eVDNXMQsnGc4o-4NZ9SfWKqaULA@mail.gmail.com>
 <CAA85sZvm1dL3oGO85k4R+TaqBiJsggUTpZmGpH1+dqdC+U_s1w@mail.gmail.com>
 <e7e49ed5-09e2-da48-002d-c7eccc9f9451@intel.com> <CAA85sZtyM+X_oHcpOBNSgF=kmB6k32bpB8FCJN5cVE14YCba+A@mail.gmail.com>
 <22aad588-47d6-6441-45b2-0e685ed84c8d@intel.com> <CAA85sZti1=ET=Tc3MoqCX0FqthHLf6MSxGNAhJUNiMms1TfoKA@mail.gmail.com>
 <CAA85sZvn04k7=oiTQ=4_C8x7pNEXRWzeEStcaXvi3v63ah7OUQ@mail.gmail.com>
 <ffb554bfa4739381d928406ad24697a4dbbbe4a2.camel@redhat.com>
 <CAA85sZunA=tf0FgLH=MNVYq3Edewb1j58oBAoXE1Tyuy3GJObg@mail.gmail.com> <CAA85sZsH1tMwLtL=VDa5=GBdVNWgifvhK+eG-hQg69PeSxBWkg@mail.gmail.com>
In-Reply-To: <CAA85sZsH1tMwLtL=VDa5=GBdVNWgifvhK+eG-hQg69PeSxBWkg@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Mon, 26 Jun 2023 20:59:20 +0200
Message-ID: <CAA85sZu=CzJx9QD87-vehOStzO9qHUSWk6DXZg3TzJeqOV5-aw@mail.gmail.com>
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

On Mon, Jun 26, 2023 at 8:20=E2=80=AFPM Ian Kumlien <ian.kumlien@gmail.com>=
 wrote:
>
> Nevermind, I think I found it, I will loop this thing until I have a
> proper trace....

Still some question marks, but much better

cat bug.txt | ./scripts/decode_stacktrace.sh vmlinux
[   62.624003] BUG: kernel NULL pointer dereference, address: 0000000000000=
0c0
[   62.631083] #PF: supervisor read access in kernel mode
[   62.636312] #PF: error_code(0x0000) - not-present page
[   62.641541] PGD 0 P4D 0
[   62.644174] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   62.648629] CPU: 1 PID: 913 Comm: napi/eno2-79 Not tainted 6.4.0 #364
[   62.655162] Hardware name: Supermicro Super Server/A2SDi-12C-HLN4F,
BIOS 1.7a 10/13/2022
[   62.663344] RIP: 0010:__udp_gso_segment
(./include/linux/skbuff.h:2858 ./include/linux/udp.h:23
net/ipv4/udp_offload.c:228 net/ipv4/udp_offload.c:261
net/ipv4/udp_offload.c:277)
[ 62.668329] Code: c3 08 66 89 5c 02 04 45 84 e4 0f 85 27 fd ff ff 49
8b 1e 49 8b ae c0 00 00 00 41 0f b7 86 b4 00 00 00 45 0f b7 a6 b2 00
00 00 <48> 8b b3 c0 00 00 00 0f b7 8b b2 00 00 00 49 01 ec 48 01 c5 48
8d
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0: c3                    ret
   1: 08 66 89              or     %ah,-0x77(%rsi)
   4: 5c                    pop    %rsp
   5: 02 04 45 84 e4 0f 85 add    -0x7af01b7c(,%rax,2),%al
   c: 27                    (bad)
   d: fd                    std
   e: ff                    (bad)
   f: ff 49 8b              decl   -0x75(%rcx)
  12: 1e                    (bad)
  13: 49 8b ae c0 00 00 00 mov    0xc0(%r14),%rbp
  1a: 41 0f b7 86 b4 00 00 movzwl 0xb4(%r14),%eax
  21: 00
  22: 45 0f b7 a6 b2 00 00 movzwl 0xb2(%r14),%r12d
  29: 00
  2a:* 48 8b b3 c0 00 00 00 mov    0xc0(%rbx),%rsi <-- trapping instruction
  31: 0f b7 8b b2 00 00 00 movzwl 0xb2(%rbx),%ecx
  38: 49 01 ec              add    %rbp,%r12
  3b: 48 01 c5              add    %rax,%rbp
  3e: 48                    rex.W
  3f: 8d                    .byte 0x8d

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0: 48 8b b3 c0 00 00 00 mov    0xc0(%rbx),%rsi
   7: 0f b7 8b b2 00 00 00 movzwl 0xb2(%rbx),%ecx
   e: 49 01 ec              add    %rbp,%r12
  11: 48 01 c5              add    %rax,%rbp
  14: 48                    rex.W
  15: 8d                    .byte 0x8d
[   62.687193] RSP: 0018:ffffbd3a83b4f868 EFLAGS: 00010246
[   62.692515] RAX: 00000000000000ce RBX: 0000000000000000 RCX: 00000000000=
00000
[   62.699743] RDX: ffffa124def8a000 RSI: 0000000000000079 RDI: ffffa125952=
a14d4
[   62.706970] RBP: ffffa124def8a000 R08: 0000000000000022 R09: 00002000001=
558c9
[   62.714199] R10: 0000000000000000 R11: 00000000be554639 R12: 00000000000=
000e2
[   62.721426] R13: ffffa125952a1400 R14: ffffa125952a1400 R15: 00002000001=
558c9
[   62.728654] FS:  0000000000000000(0000) GS:ffffa127efa40000(0000)
knlGS:0000000000000000
[   62.736852] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   62.742702] CR2: 00000000000000c0 CR3: 00000001034b0000 CR4: 00000000003=
526e0
[   62.749948] Call Trace:
[   62.752498]  <TASK>
[   62.754708] ? __die (arch/x86/kernel/dumpstack.c:421
arch/x86/kernel/dumpstack.c:434)
[   62.757879] ? page_fault_oops (arch/x86/mm/fault.c:707)
[   62.762093] ? exc_page_fault (arch/x86/mm/fault.c:1285
arch/x86/mm/fault.c:1534 arch/x86/mm/fault.c:1590)
[   62.766215] ? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:570)
[   62.770508] ? __udp_gso_segment (./include/linux/skbuff.h:2858
./include/linux/udp.h:23 net/ipv4/udp_offload.c:228
net/ipv4/udp_offload.c:261 net/ipv4/udp_offload.c:277)
[   62.774890] ? __udp_gso_segment (net/ipv4/udp_offload.c:255
net/ipv4/udp_offload.c:277)
[   62.779267] inet_gso_segment (net/ipv4/af_inet.c:1398)
[   62.783392] ? __wake_up_common (kernel/sched/wait.c:108)
[   62.787605] skb_mac_gso_segment (net/core/gro.c:141)
[   62.791906] __skb_gso_segment (net/core/dev.c:3403 (discriminator 2))
[   62.796029] ? netif_skb_features (net/core/dev.c:3474 net/core/dev.c:356=
3)
[   62.800492] validate_xmit_skb (./include/linux/netdevice.h:4862
net/core/dev.c:3659)
[   62.804695] validate_xmit_skb_list (net/core/dev.c:3710)
[   62.809158] sch_direct_xmit (net/sched/sch_generic.c:330)
[   62.813198] __dev_queue_xmit (net/core/dev.c:3805 net/core/dev.c:4210)
[   62.817314] ? nf_hook_slow (./include/linux/netfilter.h:143
net/netfilter/core.c:626)
[   62.821093] br_dev_queue_push_xmit (net/bridge/br_forward.c:55)
[   62.825652] maybe_deliver (net/bridge/br_forward.c:193)
[   62.829420] br_flood (net/bridge/br_forward.c:233)
[   62.832758] br_handle_frame_finish (net/bridge/br_input.c:215)
[   62.837403] br_handle_frame (net/bridge/br_input.c:298
net/bridge/br_input.c:416)
[   62.841431] ? ip6gre_tunnel_siocdevprivate (net/ipv6/ip6_gre.c:295
net/ipv6/ip6_gre.c:311 net/ipv6/ip6_gre.c:1325)
[   62.846771] ? br_handle_local_finish (net/bridge/br_input.c:75)
[   62.851417] __netif_receive_skb_core.constprop.0 (net/core/dev.c:5387)
[   62.857273] ? br_handle_frame_finish (net/bridge/br_input.c:321)
[   62.862086] ? sched_clock_cpu (kernel/sched/clock.c:387)
[   62.866114] __netif_receive_skb_list_core (net/core/dev.c:5570)
[   62.871367] netif_receive_skb_list_internal (net/core/dev.c:5638
net/core/dev.c:5727)
[   62.876795] napi_complete_done (./include/linux/list.h:37
./include/net/gro.h:434 ./include/net/gro.h:429 net/core/dev.c:6067)
[   62.881004] ixgbe_poll (drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:31=
91)
[   62.884689] ? finish_task_switch.isra.0
(./arch/x86/include/asm/irqflags.h:42
./arch/x86/include/asm/irqflags.h:77 kernel/sched/sched.h:1378
kernel/sched/core.c:5095 kernel/sched/core.c:5213)
[   62.889679] ? __napi_poll (net/core/dev.c:6625)
[   62.893534] __napi_poll (net/core/dev.c:6498)
[   62.897133] napi_threaded_poll (./include/linux/netpoll.h:89
net/core/dev.c:6640)
[   62.901422] ? __napi_poll (net/core/dev.c:6625)
[   62.905276] kthread (kernel/kthread.c:379)
[   62.908529] ? kthread_complete_and_exit (kernel/kthread.c:332)
[   62.913435] ret_from_fork (arch/x86/entry/entry_64.S:314)
[   62.917119]  </TASK>
[   62.919411] Modules linked in: chaoskey
[   62.923357] CR2: 00000000000000c0
[   62.926782] ---[ end trace 0000000000000000 ]---
[   62.947865] pstore: backend (erst) writing error (-28)
[   62.953125] RIP: 0010:__udp_gso_segment
(./include/linux/skbuff.h:2858 ./include/linux/udp.h:23
net/ipv4/udp_offload.c:228 net/ipv4/udp_offload.c:261
net/ipv4/udp_offload.c:277)
[ 62.958119] Code: c3 08 66 89 5c 02 04 45 84 e4 0f 85 27 fd ff ff 49
8b 1e 49 8b ae c0 00 00 00 41 0f b7 86 b4 00 00 00 45 0f b7 a6 b2 00
00 00 <48> 8b b3 c0 00 00 00 0f b7 8b b2 00 00 00 49 01 ec 48 01 c5 48
8d
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0: c3                    ret
   1: 08 66 89              or     %ah,-0x77(%rsi)
   4: 5c                    pop    %rsp
   5: 02 04 45 84 e4 0f 85 add    -0x7af01b7c(,%rax,2),%al
   c: 27                    (bad)
   d: fd                    std
   e: ff                    (bad)
   f: ff 49 8b              decl   -0x75(%rcx)
  12: 1e                    (bad)
  13: 49 8b ae c0 00 00 00 mov    0xc0(%r14),%rbp
  1a: 41 0f b7 86 b4 00 00 movzwl 0xb4(%r14),%eax
  21: 00
  22: 45 0f b7 a6 b2 00 00 movzwl 0xb2(%r14),%r12d
  29: 00
  2a:* 48 8b b3 c0 00 00 00 mov    0xc0(%rbx),%rsi <-- trapping instruction
  31: 0f b7 8b b2 00 00 00 movzwl 0xb2(%rbx),%ecx
  38: 49 01 ec              add    %rbp,%r12
  3b: 48 01 c5              add    %rax,%rbp
  3e: 48                    rex.W
  3f: 8d                    .byte 0x8d

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0: 48 8b b3 c0 00 00 00 mov    0xc0(%rbx),%rsi
   7: 0f b7 8b b2 00 00 00 movzwl 0xb2(%rbx),%ecx
   e: 49 01 ec              add    %rbp,%r12
  11: 48 01 c5              add    %rax,%rbp
  14: 48                    rex.W
  15: 8d                    .byte 0x8d
[   62.977037] RSP: 0018:ffffbd3a83b4f868 EFLAGS: 00010246
[   62.982376] RAX: 00000000000000ce RBX: 0000000000000000 RCX: 00000000000=
00000
[   62.989621] RDX: ffffa124def8a000 RSI: 0000000000000079 RDI: ffffa125952=
a14d4
[   62.996864] RBP: ffffa124def8a000 R08: 0000000000000022 R09: 00002000001=
558c9
[   63.004111] R10: 0000000000000000 R11: 00000000be554639 R12: 00000000000=
000e2
[   63.011355] R13: ffffa125952a1400 R14: ffffa125952a1400 R15: 00002000001=
558c9
[   63.018602] FS:  0000000000000000(0000) GS:ffffa127efa40000(0000)
knlGS:0000000000000000
[   63.026816] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   63.032666] CR2: 00000000000000c0 CR3: 00000001034b0000 CR4: 00000000003=
526e0
[   63.039911] Kernel panic - not syncing: Fatal exception in interrupt
[   63.218844] Kernel Offset: 0x35e00000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   63.246284] ---[ end Kernel panic - not syncing: Fatal exception in
interrupt ]---

> On Mon, Jun 26, 2023 at 8:01=E2=80=AFPM Ian Kumlien <ian.kumlien@gmail.co=
m> wrote:
> >
> > On Mon, Jun 26, 2023 at 7:56=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > >
> > > On Mon, 2023-06-26 at 19:30 +0200, Ian Kumlien wrote:
> > > > There, that didn't take long, even with wireguard disabled
> > > >
> > > > [14079.678380] BUG: kernel NULL pointer dereference, address: 00000=
000000000c0
> > > > [14079.685456] #PF: supervisor read access in kernel mode
> > > > [14079.690686] #PF: error_code(0x0000) - not-present page
> > > > [14079.695915] PGD 0 P4D 0
> > > > [14079.698540] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > > > [14079.702996] CPU: 11 PID: 891 Comm: napi/eno2-80 Not tainted 6.4.=
0 #360
> > > > [14079.709614] Hardware name: Supermicro Super Server/A2SDi-12C-HLN=
4F,
> > > > BIOS 1.7a 10/13/2022
> > > > [14079.717796] RIP: 0010:__udp_gso_segment+0x346/0x4f0
> > > > [14079.722778] Code: c3 08 66 89 5c 02 04 45 84 e4 0f 85 27 fd ff f=
f
> > > > 49 8b 1e 49 8b ae c0 00 00 00 41 0f b7 86 b4 00 00 00 45 0f b7 a6 b=
2
> > > > 00 00 00 <48> 8b b3 c0 00 00 00 0f b7 8b b2 00 00 00 49 01 ec 48 01=
 c5
> > > > 48 8d
> > > > [14079.741645] RSP: 0018:ffffa83643a4f818 EFLAGS: 00010246
> > > > [14079.746966] RAX: 00000000000000ce RBX: 0000000000000000 RCX: 000=
0000000000000
> > > > [14079.754195] RDX: ffffa2ad1403b000 RSI: 0000000000000028 RDI: fff=
fa2afc9d302d4
> > > > [14079.761422] RBP: ffffa2ad1403b000 R08: 0000000000000022 R09: 000=
02000001558c9
> > > > [14079.768650] R10: 0000000000000000 R11: ffffa2b02fcea888 R12: 000=
00000000000e2
> > > > [14079.775879] R13: ffffa2afc9d30200 R14: ffffa2afc9d30200 R15: 000=
02000001558c9
> > > > [14079.783106] FS:  0000000000000000(0000) GS:ffffa2b02fcc0000(0000=
)
> > > > knlGS:0000000000000000
> > > > [14079.791305] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [14079.797162] CR2: 00000000000000c0 CR3: 0000000151ff4000 CR4: 000=
00000003526e0
> > > > [14079.804408] Call Trace:
> > > > [14079.806961]  <TASK>
> > > > [14079.809170]  ? __die+0x1a/0x60
> > > > [14079.812340]  ? page_fault_oops+0x158/0x440
> > > > [14079.816551]  ? ip6_route_output_flags+0xe3/0x160
> > > > [14079.821284]  ? exc_page_fault+0x3f4/0x820
> > > > [14079.825408]  ? update_load_avg+0x77/0x710
> > > > [14079.829534]  ? asm_exc_page_fault+0x22/0x30
> > > > [14079.833836]  ? __udp_gso_segment+0x346/0x4f0
> > > > [14079.838218]  ? __udp_gso_segment+0x2fa/0x4f0
> > > > [14079.842600]  ? _raw_spin_unlock_irqrestore+0x16/0x30
> > > > [14079.847679]  ? try_to_wake_up+0x8e/0x5a0
> > > > [14079.851713]  inet_gso_segment+0x150/0x3c0
> > > > [14079.855827]  ? vhost_poll_wakeup+0x31/0x40
> > > > [14079.860032]  skb_mac_gso_segment+0x9b/0x110
> > > > [14079.864331]  __skb_gso_segment+0xae/0x160
> > > > [14079.868455]  ? netif_skb_features+0x144/0x290
> > > > [14079.872928]  validate_xmit_skb+0x167/0x370
> > > > [14079.877139]  validate_xmit_skb_list+0x43/0x70
> > > > [14079.881612]  sch_direct_xmit+0x267/0x380
> > > > [14079.885641]  __qdisc_run+0x140/0x590
> > > > [14079.889324]  __dev_queue_xmit+0x44d/0xba0
> > > > [14079.893450]  ? nf_hook_slow+0x3c/0xb0
> > > > [14079.897229]  br_dev_queue_push_xmit+0xb2/0x1c0
> > > > [14079.901788]  maybe_deliver+0xa9/0x100
> > > > [14079.905564]  br_flood+0x8a/0x180
> > > > [14079.908903]  br_handle_frame_finish+0x31f/0x5b0
> > > > [14079.913547]  br_handle_frame+0x28f/0x3a0
> > > > [14079.917585]  ? ipv6_find_hdr+0x1f0/0x3e0
> > > > [14079.921622]  ? br_handle_local_finish+0x20/0x20
> > > > [14079.926267]  __netif_receive_skb_core.constprop.0+0x4c5/0xc90
> > > > [14079.932125]  ? br_handle_frame_finish+0x5b0/0x5b0
> > > > [14079.936946]  ? ___slab_alloc+0x4bf/0xaf0
> > > > [14079.940986]  __netif_receive_skb_list_core+0x107/0x250
> > > > [14079.946240]  netif_receive_skb_list_internal+0x194/0x2b0
> > > > [14079.951660]  ? napi_gro_flush+0x97/0xf0
> > > > [14079.955604]  napi_complete_done+0x69/0x180
> > > > [14079.959808]  ixgbe_poll+0xe10/0x12e0
> > > > [14079.963506]  __napi_poll+0x26/0x1b0
> > > > [14079.967106]  napi_threaded_poll+0x232/0x250
> > > > [14079.971405]  ? __napi_poll+0x1b0/0x1b0
> > > > [14079.975260]  kthread+0xee/0x120
> > > > [14079.978510]  ? kthread_complete_and_exit+0x20/0x20
> > > > [14079.983415]  ret_from_fork+0x22/0x30
> > > > [14079.987102]  </TASK>
> > > > [14079.989395] Modules linked in: chaoskey
> > > > [14079.993347] CR2: 00000000000000c0
> > > > [14079.996773] ---[ end trace 0000000000000000 ]---
> > > > [14080.018013] pstore: backend (erst) writing error (-28)
> > > > [14080.023274] RIP: 0010:__udp_gso_segment+0x346/0x4f0
> > > > [14080.028264] Code: c3 08 66 89 5c 02 04 45 84 e4 0f 85 27 fd ff f=
f
> > > > 49 8b 1e 49 8b ae c0 00 00 00 41 0f b7 86 b4 00 00 00 45 0f b7 a6 b=
2
> > > > 00 00 00 <48> 8b b3 c0 00 00 00 0f b7 8b b2 00 00 00 49 01 ec 48 01=
 c5
> > > > 48 8d
> > > > [14080.047181] RSP: 0018:ffffa83643a4f818 EFLAGS: 00010246
> > > > [14080.052522] RAX: 00000000000000ce RBX: 0000000000000000 RCX: 000=
0000000000000
> > > > [14080.059765] RDX: ffffa2ad1403b000 RSI: 0000000000000028 RDI: fff=
fa2afc9d302d4
> > > > [14080.067012] RBP: ffffa2ad1403b000 R08: 0000000000000022 R09: 000=
02000001558c9
> > > > [14080.074257] R10: 0000000000000000 R11: ffffa2b02fcea888 R12: 000=
00000000000e2
> > > > [14080.081502] R13: ffffa2afc9d30200 R14: ffffa2afc9d30200 R15: 000=
02000001558c9
> > > > [14080.088746] FS:  0000000000000000(0000) GS:ffffa2b02fcc0000(0000=
)
> > > > knlGS:0000000000000000
> > > > [14080.096964] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [14080.102823] CR2: 00000000000000c0 CR3: 0000000151ff4000 CR4: 000=
00000003526e0
> > > > [14080.110067] Kernel panic - not syncing: Fatal exception in inter=
rupt
> > > > [14080.325501] Kernel Offset: 0x12600000 from 0xffffffff81000000
> > > > (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> > > > [14080.353129] ---[ end Kernel panic - not syncing: Fatal exception=
 in
> > > > interrupt ]---
> > >
> > > Could you please provide a decoded stack trace?
> > >
> > > # in your git tree:
> > > cat <stacktrace file > | ./scripts/decode_stacktrace.sh vmlinux
> >
> > I'm afraid it doesn't yield more information, really... I can't say why
> >
> >  cat bug.txt | ./scripts/decode_stacktrace.sh vmlinux
> > [14079.678380] BUG: kernel NULL pointer dereference, address: 000000000=
00000c0
> > [14079.685456] #PF: supervisor read access in kernel mode
> > [14079.690686] #PF: error_code(0x0000) - not-present page
> > [14079.695915] PGD 0 P4D 0
> > [14079.698540] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > [14079.702996] CPU: 11 PID: 891 Comm: napi/eno2-80 Not tainted 6.4.0 #3=
60
> > [14079.709614] Hardware name: Supermicro Super Server/A2SDi-12C-HLN4F,
> > BIOS 1.7a 10/13/2022
> > [14079.717796] RIP: 0010:__udp_gso_segment (??:?)
> > [14079.722778] Code: c3 08 66 89 5c 02 04 45 84 e4 0f 85 27 fd ff ff
> >
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    0: c3                    ret
> >    1: 08 66 89              or     %ah,-0x77(%rsi)
> >    4: 5c                    pop    %rsp
> >    5: 02 04 45 84 e4 0f 85 add    -0x7af01b7c(,%rax,2),%al
> >    c: 27                    (bad)
> >    d: fd                    std
> >    e: ff                    (bad)
> >    f: ff                    .byte 0xff
> > 49 8b 1e 49 8b ae c0 00 00 00 41 0f b7 86 b4 00 00 00 45 0f b7 a6 b2
> > 00 00 00 <48> 8b b3 c0 00 00 00 0f b7 8b b2 00 00 00 49 01 ec 48 01 c5
> > 48 8d
> > [14079.741645] RSP: 0018:ffffa83643a4f818 EFLAGS: 00010246
> > [14079.746966] RAX: 00000000000000ce RBX: 0000000000000000 RCX: 0000000=
000000000
> > [14079.754195] RDX: ffffa2ad1403b000 RSI: 0000000000000028 RDI: ffffa2a=
fc9d302d4
> > [14079.761422] RBP: ffffa2ad1403b000 R08: 0000000000000022 R09: 0000200=
0001558c9
> > [14079.768650] R10: 0000000000000000 R11: ffffa2b02fcea888 R12: 0000000=
0000000e2
> > [14079.775879] R13: ffffa2afc9d30200 R14: ffffa2afc9d30200 R15: 0000200=
0001558c9
> > [14079.783106] FS:  0000000000000000(0000) GS:ffffa2b02fcc0000(0000)
> > knlGS:0000000000000000
> > [14079.791305] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [14079.797162] CR2: 00000000000000c0 CR3: 0000000151ff4000 CR4: 0000000=
0003526e0
> > [14079.804408] Call Trace:
> > [14079.806961]  <TASK>
> > [14079.809170] ? __die (??:?)
> > [14079.812340] ? page_fault_oops (fault.c:?)
> > [14079.816551] ? ip6_route_output_flags (??:?)
> > [14079.821284] ? exc_page_fault (??:?)
> > [14079.825408] ? update_load_avg (fair.c:?)
> > [14079.829534] ? asm_exc_page_fault (??:?)
> > [14079.833836] ? __udp_gso_segment (??:?)
> > [14079.838218] ? __udp_gso_segment (??:?)
> > [14079.842600] ? _raw_spin_unlock_irqrestore (??:?)
> > [14079.847679] ? try_to_wake_up (core.c:?)
> > [14079.851713] inet_gso_segment (??:?)
> > [14079.855827] ? vhost_poll_wakeup (vhost.c:?)
> > [14079.860032] skb_mac_gso_segment (??:?)
> > [14079.864331] __skb_gso_segment (??:?)
> > [14079.868455] ? netif_skb_features (??:?)
> > [14079.872928] validate_xmit_skb (dev.c:?)
> > [14079.877139] validate_xmit_skb_list (??:?)
> > [14079.881612] sch_direct_xmit (??:?)
> > [14079.885641] __qdisc_run (??:?)
> > [14079.889324] __dev_queue_xmit (??:?)
> > [14079.893450] ? nf_hook_slow (??:?)
> > [14079.897229] br_dev_queue_push_xmit (??:?)
> > [14079.901788] maybe_deliver (br_forward.c:?)
> > [14079.905564] br_flood (??:?)
> > [14079.908903] br_handle_frame_finish (??:?)
> > [14079.913547] br_handle_frame (br_input.c:?)
> > [14079.917585] ? ipv6_find_hdr (??:?)
> > [14079.921622] ? br_handle_local_finish (??:?)
> > [14079.926267] __netif_receive_skb_core.constprop.0 (dev.c:?)
> > [14079.932125] ? br_handle_frame_finish (br_input.c:?)
> > [14079.936946] ? ___slab_alloc (slub.c:?)
> > [14079.940986] __netif_receive_skb_list_core (dev.c:?)
> > [14079.946240] netif_receive_skb_list_internal (??:?)
> > [14079.951660] ? napi_gro_flush (??:?)
> > [14079.955604] napi_complete_done (??:?)
> > [14079.959808] ixgbe_poll (??:?)
> > [14079.963506] __napi_poll (dev.c:?)
> > [14079.967106] napi_threaded_poll (dev.c:?)
> > [14079.971405] ? __napi_poll (dev.c:?)
> > [14079.975260] kthread (kthread.c:?)
> > [14079.978510] ? kthread_complete_and_exit (kthread.c:?)
> > [14079.983415] ret_from_fork (??:?)
> > [14079.987102]  </TASK>
> > [14079.989395] Modules linked in: chaoskey
> > [14079.993347] CR2: 00000000000000c0
> > [14079.996773] ---[ end trace 0000000000000000 ]---
> > [14080.018013] pstore: backend (erst) writing error (-28)
> > [14080.023274] RIP: 0010:__udp_gso_segment (??:?)
> > [14080.028264] Code: c3 08 66 89 5c 02 04 45 84 e4 0f 85 27 fd ff ff
> >
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    0: c3                    ret
> >    1: 08 66 89              or     %ah,-0x77(%rsi)
> >    4: 5c                    pop    %rsp
> >    5: 02 04 45 84 e4 0f 85 add    -0x7af01b7c(,%rax,2),%al
> >    c: 27                    (bad)
> >    d: fd                    std
> >    e: ff                    (bad)
> >    f: ff                    .byte 0xff
> > 49 8b 1e 49 8b ae c0 00 00 00 41 0f b7 86 b4 00 00 00 45 0f b7 a6 b2
> > 00 00 00 <48> 8b b3 c0 00 00 00 0f b7 8b b2 00 00 00 49 01 ec 48 01 c5
> > 48 8d
> > [14080.047181] RSP: 0018:ffffa83643a4f818 EFLAGS: 00010246
> > [14080.052522] RAX: 00000000000000ce RBX: 0000000000000000 RCX: 0000000=
000000000
> > [14080.059765] RDX: ffffa2ad1403b000 RSI: 0000000000000028 RDI: ffffa2a=
fc9d302d4
> > [14080.067012] RBP: ffffa2ad1403b000 R08: 0000000000000022 R09: 0000200=
0001558c9
> > [14080.074257] R10: 0000000000000000 R11: ffffa2b02fcea888 R12: 0000000=
0000000e2
> > [14080.081502] R13: ffffa2afc9d30200 R14: ffffa2afc9d30200 R15: 0000200=
0001558c9
> > [14080.088746] FS:  0000000000000000(0000) GS:ffffa2b02fcc0000(0000)
> > knlGS:0000000000000000
> > [14080.096964] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [14080.102823] CR2: 00000000000000c0 CR3: 0000000151ff4000 CR4: 0000000=
0003526e0
> > [14080.110067] Kernel panic - not syncing: Fatal exception in interrupt
> > [14080.325501] Kernel Offset: 0x12600000 from 0xffffffff81000000
> > (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> > [14080.353129] ---[ end Kernel panic - not syncing: Fatal exception in
> > interrupt ]---
> >
> > The binaries aren't stripped so i don't, currently, know why it's like =
this...
> >
> > but i also get:
> > gdb vmlinux
> > GNU gdb (Gentoo 13.2 vanilla) 13.2
> > Copyright (C) 2023 Free Software Foundation, Inc.
> > License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl=
.html>
> > This is free software: you are free to change and redistribute it.
> > There is NO WARRANTY, to the extent permitted by law.
> > Type "show copying" and "show warranty" for details.
> > This GDB was configured as "x86_64-pc-linux-gnu".
> > Type "show configuration" for configuration details.
> > For bug reporting instructions, please see:
> > <https://bugs.gentoo.org/>.
> > Find the GDB manual and other documentation resources online at:
> >     <http://www.gnu.org/software/gdb/documentation/>.
> >
> > For help, type "help".
> > Type "apropos word" to search for commands related to "word"...
> > Reading symbols from vmlinux...
> > (No debugging symbols found in vmlinux)
> > Traceback (most recent call last):
> >   File "/usr/src/linux/vmlinux-gdb.py", line 25, in <module>
> >     import linux.constants
> >   File "/usr/src/linux/scripts/gdb/linux/constants.py", line 10, in <mo=
dule>
> >     LX_hrtimer_resolution =3D gdb.parse_and_eval("hrtimer_resolution")
> >                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > gdb.error: 'hrtimer_resolution' has unknown type; cast it to its declar=
ed type
> > ---
> >
> > > Thanks!
> > >
> > > Paolo
> > >
