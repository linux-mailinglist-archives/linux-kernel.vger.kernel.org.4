Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A589C740C77
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbjF1JJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:09:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35045 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235701AbjF1JHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687943190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Mt+AGh8pL9GItdGuqz+S5zOSB1kzaQK/lmag+rkrIs=;
        b=HSg/r7Vdn88gSeEgY4rmFnx93wqs4tzuJHZN1glfRmfH/Nhe5CRLabjvsjniBkxgah3qvi
        mvDQ5TgKs4RjHxuStMzYxgH2J18eP8nX1fpQKB/OXAkUbL2WyhcWlB9vOzOcecup+ZJU92
        Ha9PDTvgDa6a5NP14g9XWNm6BO8oprk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-0IrrE71zNdmgeT_Vrlk2Fg-1; Wed, 28 Jun 2023 05:06:28 -0400
X-MC-Unique: 0IrrE71zNdmgeT_Vrlk2Fg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76716078e78so25930585a.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 02:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687943188; x=1690535188;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Mt+AGh8pL9GItdGuqz+S5zOSB1kzaQK/lmag+rkrIs=;
        b=iGTMMN0UkOZNtiAMghtUsQP0nXCOs/taJnasifbNWGMcxFvkZgvTJy+SOmmdzV5apc
         ewGgzzkEXmbzj04/6eE1iKq2UVxHCxRDDChKr/XndzuYJbqSEtTkTKDOT74BzmJN7X9k
         dUL+wDvNZQjrXzLw//HAaXcsT4dx8aNs9QVEacPnQbCQWLIazOnG3ny41Tgel9GguPE0
         /aCisxMWhkkaFPFjYB7pTO4mbIPY5qfeBSOJVog6zn9UU6Vb/n/b/NgK9WrcmP6Uh7lk
         iitZPgEx2SVekctBIKqcNYJWRsCTXvHpxVLWQfDxmEBC4KvJktxEzjnLp3gr+MHcOJyo
         dCXQ==
X-Gm-Message-State: AC+VfDzekv+xxGr8ROUk1OPRCHYMv/9vlQh69bRf296zqIy2vQ7KEC5f
        YksyHUjrHOYWMwZ5g0w5NYVOK5ttqi/nF41agtAyj6CelUf4a5UvrglBvQcasIv0V8HSglTGGXS
        u+NUA+dqYggButkjDNOYyBZJA
X-Received: by 2002:a05:620a:190e:b0:765:3b58:99ab with SMTP id bj14-20020a05620a190e00b007653b5899abmr6305782qkb.4.1687943187941;
        Wed, 28 Jun 2023 02:06:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Pi+d+bIvaIEDtLwWVvkne70c3lcUzJGi2BHechnsH7bQHg9u9IfRMS66e/7JSp3u01eCa+w==
X-Received: by 2002:a05:620a:190e:b0:765:3b58:99ab with SMTP id bj14-20020a05620a190e00b007653b5899abmr6305743qkb.4.1687943187280;
        Wed, 28 Jun 2023 02:06:27 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-127.dyn.eolo.it. [146.241.226.127])
        by smtp.gmail.com with ESMTPSA id pe34-20020a05620a852200b007623c96430csm3426449qkn.111.2023.06.28.02.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 02:06:26 -0700 (PDT)
Message-ID: <486ae2687cd2e2624c0db1ea1f3d6ca36db15411.camel@redhat.com>
Subject: Re: [Intel-wired-lan] bug with rx-udp-gro-forwarding offloading?
From:   Paolo Abeni <pabeni@redhat.com>
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 28 Jun 2023 11:06:23 +0200
In-Reply-To: <CAA85sZurk7-_0XGmoCEM93vu3vbqRgPTH4QVymPR5BeeFw6iFg@mail.gmail.com>
References: <CAA85sZukiFq4A+b9+en_G85eVDNXMQsnGc4o-4NZ9SfWKqaULA@mail.gmail.com>
         <CAA85sZvm1dL3oGO85k4R+TaqBiJsggUTpZmGpH1+dqdC+U_s1w@mail.gmail.com>
         <e7e49ed5-09e2-da48-002d-c7eccc9f9451@intel.com>
         <CAA85sZtyM+X_oHcpOBNSgF=kmB6k32bpB8FCJN5cVE14YCba+A@mail.gmail.com>
         <22aad588-47d6-6441-45b2-0e685ed84c8d@intel.com>
         <CAA85sZti1=ET=Tc3MoqCX0FqthHLf6MSxGNAhJUNiMms1TfoKA@mail.gmail.com>
         <CAA85sZvn04k7=oiTQ=4_C8x7pNEXRWzeEStcaXvi3v63ah7OUQ@mail.gmail.com>
         <ffb554bfa4739381d928406ad24697a4dbbbe4a2.camel@redhat.com>
         <CAA85sZunA=tf0FgLH=MNVYq3Edewb1j58oBAoXE1Tyuy3GJObg@mail.gmail.com>
         <CAA85sZsH1tMwLtL=VDa5=GBdVNWgifvhK+eG-hQg69PeSxBWkg@mail.gmail.com>
         <CAA85sZu=CzJx9QD87-vehOStzO9qHUSWk6DXZg3TzJeqOV5-aw@mail.gmail.com>
         <0a040331995c072c56fce58794848f5e9853c44f.camel@redhat.com>
         <CAA85sZuuwxtAQcMe3LHpFVeF7y-bVoHtO1nukAa2+NyJw3zcyg@mail.gmail.com>
         <CAA85sZurk7-_0XGmoCEM93vu3vbqRgPTH4QVymPR5BeeFw6iFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, 2023-06-28 at 09:37 +0200, Ian Kumlien wrote:
> Been running all night but eventually it crashed again...
>=20
> [21753.055795] Out of memory: Killed process 970 (qemu-system-x86)
> total-vm:4709488kB, anon-rss:2172652kB, file-rss:4608kB,
> shmem-rss:0kB, UID:77 pgtables:4800kB oom_score_adj:0
> [24249.061154] general protection fault, probably for non-canonical
> address 0xb0746d4e6bee35e2: 0000 [#1] PREEMPT SMP NOPTI
> [24249.072138] CPU: 0 PID: 893 Comm: napi/eno1-68 Tainted: G        W
>         6.4.0-dirty #366
> [24249.080670] Hardware name: Supermicro Super Server/A2SDi-12C-HLN4F,
> BIOS 1.7a 10/13/2022
> [24249.088852] RIP: 0010:kmem_cache_alloc_bulk (mm/slub.c:377
> mm/slub.c:388 mm/slub.c:395 mm/slub.c:3963 mm/slub.c:4026)
> [24249.094086] Code: 0f 84 46 ff ff ff 65 ff 05 a4 bd e4 47 48 8b 4d
> 00 65 48 03 0d e8 5f e3 47 9c 5e fa 45 31 d2 eb 2f 8b 45 28 48 01 d0
> 48 89 c7 <48> 8b 00 48 33 85 b8 00 00 00 48 0f cf 48 31 f8 48 89 01 49
> 89 17
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0: 0f 84 46 ff ff ff    je     0xffffffffffffff4c
>    6: 65 ff 05 a4 bd e4 47 incl   %gs:0x47e4bda4(%rip)        # 0x47e4bdb=
1
>    d: 48 8b 4d 00          mov    0x0(%rbp),%rcx
>   11: 65 48 03 0d e8 5f e3 add    %gs:0x47e35fe8(%rip),%rcx        # 0x47=
e36001
>   18: 47
>   19: 9c                    pushf
>   1a: 5e                    pop    %rsi
>   1b: fa                    cli
>   1c: 45 31 d2              xor    %r10d,%r10d
>   1f: eb 2f                jmp    0x50
>   21: 8b 45 28              mov    0x28(%rbp),%eax
>   24: 48 01 d0              add    %rdx,%rax
>   27: 48 89 c7              mov    %rax,%rdi
>   2a:* 48 8b 00              mov    (%rax),%rax <-- trapping instruction
>   2d: 48 33 85 b8 00 00 00 xor    0xb8(%rbp),%rax
>   34: 48 0f cf              bswap  %rdi
>   37: 48 31 f8              xor    %rdi,%rax
>   3a: 48 89 01              mov    %rax,(%rcx)
>   3d: 49 89 17              mov    %rdx,(%r15)
>=20
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0: 48 8b 00              mov    (%rax),%rax
>    3: 48 33 85 b8 00 00 00 xor    0xb8(%rbp),%rax
>    a: 48 0f cf              bswap  %rdi
>    d: 48 31 f8              xor    %rdi,%rax
>   10: 48 89 01              mov    %rax,(%rcx)
>   13: 49 89 17              mov    %rdx,(%r15)
> [24249.112951] RSP: 0018:ffff9fc303973d20 EFLAGS: 00010086
> [24249.118275] RAX: b0746d4e6bee35e2 RBX: 0000000000000001 RCX: ffff8d5a2=
fa31da0
> [24249.125501] RDX: b0746d4e6bee3572 RSI: 0000000000000286 RDI: b0746d4e6=
bee35e2
> [24249.132730] RBP: ffff8d56c016d500 R08: 0000000000000400 R09: ffff8d56e=
de0e67a
> [24249.139958] R10: 0000000000000001 R11: ffff8d56c59d88c0 R12: 000000000=
0000010
> [24249.147187] R13: 0000000000000820 R14: ffff8d5a2fa2a810 R15: ffff8d5a2=
fa2a818
> [24249.154415] FS:  0000000000000000(0000) GS:ffff8d5a2fa00000(0000)
> knlGS:0000000000000000
> [24249.162620] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [24249.168471] CR2: 00007f0f3f7f8760 CR3: 0000000102466000 CR4: 000000000=
03526f0
> [24249.175717] Call Trace:
> [24249.178268]  <TASK>
> [24249.180476] ? die_addr (arch/x86/kernel/dumpstack.c:421
> arch/x86/kernel/dumpstack.c:460)
> [24249.183907] ? exc_general_protection (arch/x86/kernel/traps.c:783
> arch/x86/kernel/traps.c:728)
> [24249.188726] ? asm_exc_general_protection
> (./arch/x86/include/asm/idtentry.h:564)
> [24249.193720] ? kmem_cache_alloc_bulk (mm/slub.c:377 mm/slub.c:388
> mm/slub.c:395 mm/slub.c:3963 mm/slub.c:4026)
> [24249.198361] ? netif_receive_skb_list_internal (net/core/dev.c:5729)
> [24249.203960] napi_skb_cache_get (net/core/skbuff.c:338)
> [24249.208078] __napi_build_skb (net/core/skbuff.c:517)
> [24249.211934] napi_build_skb (net/core/skbuff.c:541)
> [24249.215616] ixgbe_poll
> (drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2165
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2361
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:3178)
> [24249.219305] __napi_poll (net/core/dev.c:6498)
> [24249.222905] napi_threaded_poll (./include/linux/netpoll.h:89
> net/core/dev.c:6640)
> [24249.227197] ? __napi_poll (net/core/dev.c:6625)
> [24249.231050] kthread (kernel/kthread.c:379)
> [24249.234300] ? kthread_complete_and_exit (kernel/kthread.c:332)
> [24249.239207] ret_from_fork (arch/x86/entry/entry_64.S:314)
> [24249.242892]  </TASK>
> [24249.245185] Modules linked in: chaoskey
> [24249.249133] ---[ end trace 0000000000000000 ]---
> [24249.270157] pstore: backend (erst) writing error (-28)
> [24249.275408] RIP: 0010:kmem_cache_alloc_bulk (mm/slub.c:377
> mm/slub.c:388 mm/slub.c:395 mm/slub.c:3963 mm/slub.c:4026)
> [24249.280660] Code: 0f 84 46 ff ff ff 65 ff 05 a4 bd e4 47 48 8b 4d
> 00 65 48 03 0d e8 5f e3 47 9c 5e fa 45 31 d2 eb 2f 8b 45 28 48 01 d0
> 48 89 c7 <48> 8b 00 48 33 85 b8 00 00 00 48 0f cf 48 31 f8 48 89 01 49
> 89 17
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0: 0f 84 46 ff ff ff    je     0xffffffffffffff4c
>    6: 65 ff 05 a4 bd e4 47 incl   %gs:0x47e4bda4(%rip)        # 0x47e4bdb=
1
>    d: 48 8b 4d 00          mov    0x0(%rbp),%rcx
>   11: 65 48 03 0d e8 5f e3 add    %gs:0x47e35fe8(%rip),%rcx        # 0x47=
e36001
>   18: 47
>   19: 9c                    pushf
>   1a: 5e                    pop    %rsi
>   1b: fa                    cli
>   1c: 45 31 d2              xor    %r10d,%r10d
>   1f: eb 2f                jmp    0x50
>   21: 8b 45 28              mov    0x28(%rbp),%eax
>   24: 48 01 d0              add    %rdx,%rax
>   27: 48 89 c7              mov    %rax,%rdi
>   2a:* 48 8b 00              mov    (%rax),%rax <-- trapping instruction
>   2d: 48 33 85 b8 00 00 00 xor    0xb8(%rbp),%rax
>   34: 48 0f cf              bswap  %rdi
>   37: 48 31 f8              xor    %rdi,%rax
>   3a: 48 89 01              mov    %rax,(%rcx)
>   3d: 49 89 17              mov    %rdx,(%r15)
>=20
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0: 48 8b 00              mov    (%rax),%rax
>    3: 48 33 85 b8 00 00 00 xor    0xb8(%rbp),%rax
>    a: 48 0f cf              bswap  %rdi
>    d: 48 31 f8              xor    %rdi,%rax
>   10: 48 89 01              mov    %rax,(%rcx)
>   13: 49 89 17              mov    %rdx,(%r15)
> [24249.299578] RSP: 0018:ffff9fc303973d20 EFLAGS: 00010086
> [24249.304917] RAX: b0746d4e6bee35e2 RBX: 0000000000000001 RCX: ffff8d5a2=
fa31da0
> [24249.312161] RDX: b0746d4e6bee3572 RSI: 0000000000000286 RDI: b0746d4e6=
bee35e2
> [24249.319407] RBP: ffff8d56c016d500 R08: 0000000000000400 R09: ffff8d56e=
de0e67a
> [24249.326651] R10: 0000000000000001 R11: ffff8d56c59d88c0 R12: 000000000=
0000010
> [24249.333896] R13: 0000000000000820 R14: ffff8d5a2fa2a810 R15: ffff8d5a2=
fa2a818
> [24249.341141] FS:  0000000000000000(0000) GS:ffff8d5a2fa00000(0000)
> knlGS:0000000000000000
> [24249.349356] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [24249.355206] CR2: 00007f0f3f7f8760 CR3: 0000000102466000 CR4: 000000000=
03526f0
> [24249.362452] Kernel panic - not syncing: Fatal exception in interrupt
> [24249.566854] Kernel Offset: 0x36e00000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [24249.594124] ---[ end Kernel panic - not syncing: Fatal exception in
> interrupt ]---
>=20
> It's also odd that i get a OOM - it only seems to happen when i enable
> rx-gro-list=C2=A0

Unfortunately, not the result I was looking for. That leads to more
questions then answer, I'm sorry.

How long did the host keep going with rx-gro-list enabled?

Did you observe the WARN_ON() introduced by the tentative fix?

> - it's also odd because this machine always has ~8GB of
> memory available

It looks like there is a memory leak somewhere, and I don't think the
tentative fixup introduced such issue.

It looks like the above splat is due to a slab corruption, which in
turn could be unrelated from the mentioned leak, but it could/should=20
be related to rx-gro-list.=20

Could you please run the test with both kmemleak and kasan enabled?

Additionally could you please disclose if you have non trivial
netfilter and/or bridge filter and/or tc rules possibly modifying the
incoming/egress packets?

If kasan is not an option, could you please apply the debug the patch
below? (on top of the previous one)

Thanks!

Paolo
---
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6c5915efbc17..94adca27b205 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4295,6 +4295,8 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
 		delta_len +=3D nskb->len;
=20
 		skb_push(nskb, -skb_network_offset(nskb) + offset);
+		if (WARN_ON_ONCE(nskb->data - skb->head > skb->tail))
+			goto err_linearize;
=20
 		skb_release_head_state(nskb);
 		len_diff =3D skb_network_header_len(nskb) - skb_network_header_len(skb);
@@ -4302,6 +4304,11 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb=
,
=20
 		skb_headers_offset_update(nskb, skb_headroom(nskb) - skb_headroom(skb));
 		nskb->transport_header +=3D len_diff;
+		if (WARN_ON_ONCE(tnl_hlen > skb_headroom(nskb)))
+			goto err_linearize;
+		if (WARN_ON_ONCE(skb_headroom(nskb) + offset > nskb->tail))
+			goto err_linearize;
+
 		skb_copy_from_linear_data_offset(skb, -tnl_hlen,
 						 nskb->data - tnl_hlen,
 						 offset + tnl_hlen);


