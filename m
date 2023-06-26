Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5660B73E673
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjFZRaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjFZRag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:30:36 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CDE10C9;
        Mon, 26 Jun 2023 10:30:34 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-784f7f7deddso918623241.3;
        Mon, 26 Jun 2023 10:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687800634; x=1690392634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YupLJRLcY1sdinPkTcG7rwq2sz9WRiDS4oWFlv/sXcM=;
        b=Xt+1ueqnJA3lFVjDcQtIFDoLdcgnwiJaa5wRn+P+OQzjhrUHXt8ABMw46gNy1Kxznt
         evHF9vmyx041WyGPQASQHIXXb8PYfkUlcYlQboevUuJe/cCbvj9j6tuj65qpRl7W3KmY
         rvnMOmty5N0y7qTHf2roMvIfg8et7X8i2G071Sgn1n7VNMRUti91Csqllu9kqqvEMd9m
         pUyC3JsTi00M/Lt4aLwVRWTU5wz5/DVRKrAR+ilCUeoZB+HNJTsB5/yRZf4b6CAt1YAo
         nB8kaRGyVG22KNIh2Gerwev9fReOjEatu56Wv9uvlduVC9+CKW+j59N2gbe0Pc3IjZTc
         MH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687800634; x=1690392634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YupLJRLcY1sdinPkTcG7rwq2sz9WRiDS4oWFlv/sXcM=;
        b=BXHEBQluc6yMCKXqn2Swo149qeCcSQ82QQlvP5TtKqdlRrTFmpe5XSjb5t7ZKOhy5c
         PCVfpcEVTb3DKll9Kzuur75/Duz15FWraxobhK8lqlFnSM9mRp9SlSdeC7YiylfMbLFs
         ts9O0GvtWkhngxUyaew8bxvLtlDIHcDFY1csDIAqKQ+RinmVcb/7ICkKPd+D24WhyRB5
         Jlk2biMxWlsPDJ+Yhx16zhNKiQuwtDd/MWt23ct04f81MfRmzIJ7sMVtJj4Ppl7WnJyE
         Ssawuxcc04znRMAisQxnZeEy3CYga9xdjFKQ2qVsZn3qfAxizdvbHePYASBEP99cLQ+T
         HnNg==
X-Gm-Message-State: AC+VfDwkeW2KvifNqdQ5TULFLn3AYKojxDVUjrJyFG6nkt0pB/wZn7ir
        PFKzMFKfDh1ZWAo8tDn8NcnOlpWdyaMuvbXtuO4=
X-Google-Smtp-Source: ACHHUZ4l8qKg8blxk803ZouljBVuuEsoIb/7JYeP7uRYrLF3pF5MXKXiFcWocl8SOIVZBrRZZnxOlQ6GC5kTlo+1+VI=
X-Received: by 2002:a67:f557:0:b0:443:6457:101 with SMTP id
 z23-20020a67f557000000b0044364570101mr1314520vsn.7.1687800633663; Mon, 26 Jun
 2023 10:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZukiFq4A+b9+en_G85eVDNXMQsnGc4o-4NZ9SfWKqaULA@mail.gmail.com>
 <CAA85sZvm1dL3oGO85k4R+TaqBiJsggUTpZmGpH1+dqdC+U_s1w@mail.gmail.com>
 <e7e49ed5-09e2-da48-002d-c7eccc9f9451@intel.com> <CAA85sZtyM+X_oHcpOBNSgF=kmB6k32bpB8FCJN5cVE14YCba+A@mail.gmail.com>
 <22aad588-47d6-6441-45b2-0e685ed84c8d@intel.com> <CAA85sZti1=ET=Tc3MoqCX0FqthHLf6MSxGNAhJUNiMms1TfoKA@mail.gmail.com>
In-Reply-To: <CAA85sZti1=ET=Tc3MoqCX0FqthHLf6MSxGNAhJUNiMms1TfoKA@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Mon, 26 Jun 2023 19:30:22 +0200
Message-ID: <CAA85sZvn04k7=oiTQ=4_C8x7pNEXRWzeEStcaXvi3v63ah7OUQ@mail.gmail.com>
Subject: Re: [Intel-wired-lan] bug with rx-udp-gro-forwarding offloading?
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
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

There, that didn't take long, even with wireguard disabled

[14079.678380] BUG: kernel NULL pointer dereference, address: 0000000000000=
0c0
[14079.685456] #PF: supervisor read access in kernel mode
[14079.690686] #PF: error_code(0x0000) - not-present page
[14079.695915] PGD 0 P4D 0
[14079.698540] Oops: 0000 [#1] PREEMPT SMP NOPTI
[14079.702996] CPU: 11 PID: 891 Comm: napi/eno2-80 Not tainted 6.4.0 #360
[14079.709614] Hardware name: Supermicro Super Server/A2SDi-12C-HLN4F,
BIOS 1.7a 10/13/2022
[14079.717796] RIP: 0010:__udp_gso_segment+0x346/0x4f0
[14079.722778] Code: c3 08 66 89 5c 02 04 45 84 e4 0f 85 27 fd ff ff
49 8b 1e 49 8b ae c0 00 00 00 41 0f b7 86 b4 00 00 00 45 0f b7 a6 b2
00 00 00 <48> 8b b3 c0 00 00 00 0f b7 8b b2 00 00 00 49 01 ec 48 01 c5
48 8d
[14079.741645] RSP: 0018:ffffa83643a4f818 EFLAGS: 00010246
[14079.746966] RAX: 00000000000000ce RBX: 0000000000000000 RCX: 00000000000=
00000
[14079.754195] RDX: ffffa2ad1403b000 RSI: 0000000000000028 RDI: ffffa2afc9d=
302d4
[14079.761422] RBP: ffffa2ad1403b000 R08: 0000000000000022 R09: 00002000001=
558c9
[14079.768650] R10: 0000000000000000 R11: ffffa2b02fcea888 R12: 00000000000=
000e2
[14079.775879] R13: ffffa2afc9d30200 R14: ffffa2afc9d30200 R15: 00002000001=
558c9
[14079.783106] FS:  0000000000000000(0000) GS:ffffa2b02fcc0000(0000)
knlGS:0000000000000000
[14079.791305] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[14079.797162] CR2: 00000000000000c0 CR3: 0000000151ff4000 CR4: 00000000003=
526e0
[14079.804408] Call Trace:
[14079.806961]  <TASK>
[14079.809170]  ? __die+0x1a/0x60
[14079.812340]  ? page_fault_oops+0x158/0x440
[14079.816551]  ? ip6_route_output_flags+0xe3/0x160
[14079.821284]  ? exc_page_fault+0x3f4/0x820
[14079.825408]  ? update_load_avg+0x77/0x710
[14079.829534]  ? asm_exc_page_fault+0x22/0x30
[14079.833836]  ? __udp_gso_segment+0x346/0x4f0
[14079.838218]  ? __udp_gso_segment+0x2fa/0x4f0
[14079.842600]  ? _raw_spin_unlock_irqrestore+0x16/0x30
[14079.847679]  ? try_to_wake_up+0x8e/0x5a0
[14079.851713]  inet_gso_segment+0x150/0x3c0
[14079.855827]  ? vhost_poll_wakeup+0x31/0x40
[14079.860032]  skb_mac_gso_segment+0x9b/0x110
[14079.864331]  __skb_gso_segment+0xae/0x160
[14079.868455]  ? netif_skb_features+0x144/0x290
[14079.872928]  validate_xmit_skb+0x167/0x370
[14079.877139]  validate_xmit_skb_list+0x43/0x70
[14079.881612]  sch_direct_xmit+0x267/0x380
[14079.885641]  __qdisc_run+0x140/0x590
[14079.889324]  __dev_queue_xmit+0x44d/0xba0
[14079.893450]  ? nf_hook_slow+0x3c/0xb0
[14079.897229]  br_dev_queue_push_xmit+0xb2/0x1c0
[14079.901788]  maybe_deliver+0xa9/0x100
[14079.905564]  br_flood+0x8a/0x180
[14079.908903]  br_handle_frame_finish+0x31f/0x5b0
[14079.913547]  br_handle_frame+0x28f/0x3a0
[14079.917585]  ? ipv6_find_hdr+0x1f0/0x3e0
[14079.921622]  ? br_handle_local_finish+0x20/0x20
[14079.926267]  __netif_receive_skb_core.constprop.0+0x4c5/0xc90
[14079.932125]  ? br_handle_frame_finish+0x5b0/0x5b0
[14079.936946]  ? ___slab_alloc+0x4bf/0xaf0
[14079.940986]  __netif_receive_skb_list_core+0x107/0x250
[14079.946240]  netif_receive_skb_list_internal+0x194/0x2b0
[14079.951660]  ? napi_gro_flush+0x97/0xf0
[14079.955604]  napi_complete_done+0x69/0x180
[14079.959808]  ixgbe_poll+0xe10/0x12e0
[14079.963506]  __napi_poll+0x26/0x1b0
[14079.967106]  napi_threaded_poll+0x232/0x250
[14079.971405]  ? __napi_poll+0x1b0/0x1b0
[14079.975260]  kthread+0xee/0x120
[14079.978510]  ? kthread_complete_and_exit+0x20/0x20
[14079.983415]  ret_from_fork+0x22/0x30
[14079.987102]  </TASK>
[14079.989395] Modules linked in: chaoskey
[14079.993347] CR2: 00000000000000c0
[14079.996773] ---[ end trace 0000000000000000 ]---
[14080.018013] pstore: backend (erst) writing error (-28)
[14080.023274] RIP: 0010:__udp_gso_segment+0x346/0x4f0
[14080.028264] Code: c3 08 66 89 5c 02 04 45 84 e4 0f 85 27 fd ff ff
49 8b 1e 49 8b ae c0 00 00 00 41 0f b7 86 b4 00 00 00 45 0f b7 a6 b2
00 00 00 <48> 8b b3 c0 00 00 00 0f b7 8b b2 00 00 00 49 01 ec 48 01 c5
48 8d
[14080.047181] RSP: 0018:ffffa83643a4f818 EFLAGS: 00010246
[14080.052522] RAX: 00000000000000ce RBX: 0000000000000000 RCX: 00000000000=
00000
[14080.059765] RDX: ffffa2ad1403b000 RSI: 0000000000000028 RDI: ffffa2afc9d=
302d4
[14080.067012] RBP: ffffa2ad1403b000 R08: 0000000000000022 R09: 00002000001=
558c9
[14080.074257] R10: 0000000000000000 R11: ffffa2b02fcea888 R12: 00000000000=
000e2
[14080.081502] R13: ffffa2afc9d30200 R14: ffffa2afc9d30200 R15: 00002000001=
558c9
[14080.088746] FS:  0000000000000000(0000) GS:ffffa2b02fcc0000(0000)
knlGS:0000000000000000
[14080.096964] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[14080.102823] CR2: 00000000000000c0 CR3: 0000000151ff4000 CR4: 00000000003=
526e0
[14080.110067] Kernel panic - not syncing: Fatal exception in interrupt
[14080.325501] Kernel Offset: 0x12600000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[14080.353129] ---[ end Kernel panic - not syncing: Fatal exception in
interrupt ]---

On Mon, Jun 26, 2023 at 7:24=E2=80=AFPM Ian Kumlien <ian.kumlien@gmail.com>=
 wrote:
>
> On Mon, Jun 26, 2023 at 7:15=E2=80=AFPM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
> >
> > From: Ian Kumlien <ian.kumlien@gmail.com>
> > Date: Mon, 26 Jun 2023 16:25:24 +0200
> >
> > > On Mon, Jun 26, 2023 at 4:18=E2=80=AFPM Alexander Lobakin
> > > <aleksander.lobakin@intel.com> wrote:
> > >>
> > >> From: Ian Kumlien <ian.kumlien@gmail.com>
> > >> Date: Sun, 25 Jun 2023 12:59:54 +0200
> > >>
> > >>> It could actually be that it's related to: rx-gro-list but
> > >>> rx-udp-gro-forwarding makes it trigger quicker...  I have yet to
> > >>> trigger it on igb
> > >>
> > >> Hi, the rx-udp-gro-forwarding author here.
> > >>
> > >> (good thing this appeared on IWL, which I read time to time, but ple=
ase
> > >>  Cc netdev next time)
> > >> (thus +Cc Jakub, Eric, and netdev)
> > >
> > > Well, two things, it seems like rx-udp-gro-forwarding accelerates it
> > > but the issue is actually in: rx-gro-list
> >
> > Do you enable them simultaneously? I remember, when I was adding
> > gro-fwd, it was working (and working good) as follows:
> >
> > 1. gro-fwd on, gro-list off: gro-fwd
> > 2. gro-fwd off, gro-list on: gro-list
> > 3. gro-fwd on, gro-list on: gro-list
> >
> > Note that their receive paths are independent[0]: skb_gro_receive_list(=
)
> > vs skb_gro_receive(), thus I'm still not really sure how gro-fwd can
> > trigger gro-list's bug.
>
> Neither am I... I have enabled sol via ipmitool now, will try to get a
> better capture
>
> > > And since i've only been able to trigger it in ixgbe i thought it
> > > might be a driver issue =3D)
> >
> > Your screenshot says "__udp_gso_segment", which means that the
> > problematic UDP GRO packet hits the Tx path. Rx is in general
> > driver-independent. Tx has separate netdev feature ("tx-gso-list"), but
> > it's not supported by any driver, just software stack. It might be that
> > your traffic goes through a bridge or tunnel or anything else that
> > triggers GSO and software segmentation then booms for some reason.
> > BTW, __udp_gso_segment() is one-liner when the passed skb was
> > gro-listed[1], so having it in the bug splat could mean the skb didn't
> > take that route. But hard to say with no full stacktrace.
>
> I do have a UDP tunnel, in wireguard, will disable it.
>
> Beyond that some bridges and veth interfaces, but lets wait for a full tr=
ace
>
> > [...]
> >
> > >>>> But correlating that with the source is beyond me, it could be gen=
eric
> > >>>> but i thought i'd send it you first since it's part of the redhat
> > >>>> guide to speeding up udp traffic
> > >> [0]
> > >> https://lore.kernel.org/netdev/f83d79d6-f8d7-a229-941a-7d7427975160@=
nvidia.com
> > >>
> > >> Thanks,
> > >> Olek
> >
> > [0]
> > https://elixir.bootlin.com/linux/latest/source/net/ipv4/udp_offload.c#L=
518
> > [1]
> > https://elixir.bootlin.com/linux/latest/source/net/ipv4/udp_offload.c#L=
277
> >
> > Thanks,
> > Olek
