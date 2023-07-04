Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25AD746E52
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 12:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjGDKLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 06:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjGDKK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 06:10:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCCEEE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 03:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688465415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rwDSntNr5wEEbcV6kdAG97wPrmyPp7RMUEimzXt++K8=;
        b=EPse+af7zhg6bePMgZlq0rPB/293daOFZPuTxRW5C2hIyeWvxBeTSKrNDGaa+xLAOE6/5z
        O3iOF4RjN5Yuo+YAsWJhjK8warHg4IeLE58A8wllPwP/hO4TdITkE1rRvlN3v/8tv9/ZdQ
        cr9K4CyZXGd8NAOGj6C7agO4vdi6Dig=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-3pl5S4-sOHSrxqjUf__uaA-1; Tue, 04 Jul 2023 06:10:14 -0400
X-MC-Unique: 3pl5S4-sOHSrxqjUf__uaA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7673887b2cfso150759685a.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 03:10:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688465414; x=1691057414;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rwDSntNr5wEEbcV6kdAG97wPrmyPp7RMUEimzXt++K8=;
        b=XcIrRq007TE4ISMn3PK6KNv0i5qsYJM3okbh2qGS0BV/Fmxw17Cc1rCbYoCRjyd4m2
         91A6fz44Tua2SB516mIJWu2SFcC+lu0SfmGMBe6pXop0b12t6oM4nsFs+JdD0Cs9gasV
         cnjFzxmLWFirCL5M/CGbfMC4rG7QqCDU0sEIksogqilamo+N2SkOebp+zzzZx/dSFzq1
         ouq0ddGKo57s+Uu+OUVRuUm/71P2e0gxyw90wxgAKDv602exx0lGCiHBXoE9+7PbJ6M8
         aAHx1XPgGGnzTXCqHOGqYeHQinVyXVMZ95L7qE+wzBEJyoY+1+Nhf9I3G9QFx7IbWZgJ
         3vag==
X-Gm-Message-State: AC+VfDxqaYZFbHyumOde9xd4XBwkNjqseiWCxVdCYxuCUN1K/LB7xCEv
        hU+kQ0M8E7w3VgFi6UAaPUfqYIiUys1/mOLi0g15ScbtJq1wZ7nE+IE1DNkbaS5DZbU9vP833Ql
        7/34YdUKEgrsTO+FxoPHyM+v7
X-Received: by 2002:a05:620a:45a7:b0:767:1a23:137 with SMTP id bp39-20020a05620a45a700b007671a230137mr15037647qkb.2.1688465414355;
        Tue, 04 Jul 2023 03:10:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5lFZqFiRa5rblBT821TamXePsU5poL/pAZQagGwI12ATgJwdlndUduhu0Q/jSAUq02yi0A2Q==
X-Received: by 2002:a05:620a:45a7:b0:767:1a23:137 with SMTP id bp39-20020a05620a45a700b007671a230137mr15037629qkb.2.1688465414006;
        Tue, 04 Jul 2023 03:10:14 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-156.dyn.eolo.it. [146.241.247.156])
        by smtp.gmail.com with ESMTPSA id g16-20020a05620a13d000b0076753219bb1sm4115061qkl.29.2023.07.04.03.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 03:10:13 -0700 (PDT)
Message-ID: <92a4d42491a2c219192ae86fa04b579ea3676d8c.camel@redhat.com>
Subject: Re: [Intel-wired-lan] bug with rx-udp-gro-forwarding offloading?
From:   Paolo Abeni <pabeni@redhat.com>
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 04 Jul 2023 12:10:10 +0200
In-Reply-To: <CAA85sZs_H3Dc-mYnj8J5VBEwUJwbHUupP+U-4eG20nfAHBtv4w@mail.gmail.com>
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
         <486ae2687cd2e2624c0db1ea1f3d6ca36db15411.camel@redhat.com>
         <CAA85sZsJEZK0g0fGfH+toiHm_o4pdN+Wo0Wq9fgsUjHXGxgxQA@mail.gmail.com>
         <CAA85sZs4KkfVojx=vxbDaWhWRpxiHc-RCc2OLD2c+VefRjpTfw@mail.gmail.com>
         <5688456234f5d15ea9ca0f000350c28610ed2639.camel@redhat.com>
         <CAA85sZvT-vAHQooy8+i0-bTxgv4JjkqMorLL1HjkXK6XDKX41w@mail.gmail.com>
         <CAA85sZs2biYueZsbDqdrMyYfaqH6hnSMpymgbsk=b3W1B7TNRA@mail.gmail.com>
         <CAA85sZs_H3Dc-mYnj8J5VBEwUJwbHUupP+U-4eG20nfAHBtv4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-07-03 at 11:37 +0200, Ian Kumlien wrote:
> So, got back, switched to 6.4.1 and reran with kmemleak and kasan
>=20
> I got the splat from:
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index cea28d30abb5..701c1b5cf532 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4328,6 +4328,9 @@ struct sk_buff *skb_segment_list(struct sk_buff *sk=
b,
>=20
>         skb->prev =3D tail;
>=20
> +       if (WARN_ON_ONCE(!skb->next))
> +               goto err_linearize;
> +
>         if (skb_needs_linearize(skb, features) &&
>             __skb_linearize(skb))
>                 goto err_linearize;
>=20
> I'm just happy i ran with dmesg -W since there was only minimal output
> on the console:
> [39914.833696] rcu: INFO: rcu_preempt self-detected stall on CPU
> [39914.839598] rcu:     2-....: (20997 ticks this GP)
> idle=3Ddd64/1/0x4000000000000000 softirq=3D4633489/4633489 fqs=3D4687
> [39914.849839] rcu:     (t=3D21017 jiffies g=3D18175157 q=3D45473 ncpus=
=3D12)
> [39977.862108] rcu: INFO: rcu_preempt self-detected stall on CPU
> [39977.868002] rcu:     2-....: (84001 ticks this GP)
> idle=3Ddd64/1/0x4000000000000000 softirq=3D4633489/4633489 fqs=3D28434
> [39977.878340] rcu:     (t=3D84047 jiffies g=3D18175157 q=3D263477 ncpus=
=3D12)
> [40040.892521] rcu: INFO: rcu_preempt self-detected stall on CPU
> [40040.898414] rcu:     2-....: (147006 ticks this GP)
> idle=3Ddd64/1/0x4000000000000000 softirq=3D4633489/4633489 fqs=3D53043
> [40040.908831] rcu:     (t=3D147079 jiffies g=3D18175157 q=3D464422 ncpus=
=3D12)
> [40065.080842] ixgbe 0000:06:00.1 eno2: Reset adapter

Ouch, just another slightly different issue, apparently :(

I'll try some wild guesses. The rcu stall could cause the OOM observed
in the previous tests. Here we the OOM did not trigger because due to
kasan/kmemleak the kernel is able to process a lesser number of packets
in the same period of time.

[...]
> [39914.857231] skb_segment (net/core/skbuff.c:4519)

I *think* this could be looping "forever", if gso_size becomes 0, which
is in turn completely unexpected ...


> [39914.857257] ? write_profile (kernel/stacktrace.c:83)
> [39914.857296] ? pskb_extract (net/core/skbuff.c:4360)
> [39914.857320] ? rt6_score_route (net/ipv6/route.c:713 (discriminator 1))
> [39914.857346] ? llist_add_batch (lib/llist.c:33 (discriminator 14))
> [39914.857379] __udp_gso_segment (net/ipv4/udp_offload.c:290)
> [39914.857413] ? ip6_dst_destroy (net/ipv6/route.c:788)
> [39914.857442] udp6_ufo_fragment (net/ipv6/udp_offload.c:47)
> [39914.857472] ? udp6_gro_complete (net/ipv6/udp_offload.c:20)
> [39914.857498] ? ipv6_gso_pull_exthdrs (net/ipv6/ip6_offload.c:53)
> [39914.857528] ipv6_gso_segment (net/ipv6/ip6_offload.c:119
> net/ipv6/ip6_offload.c:74)
> [39914.857557] ? ipv6_gso_pull_exthdrs (net/ipv6/ip6_offload.c:76)
> [39914.857583] ? nft_update_chain_stats (net/netfilter/nf_tables_core.c:2=
54)
> [39914.857612] ? fib6_select_path (net/ipv6/route.c:458)
> [39914.857643] skb_mac_gso_segment (net/core/gro.c:141)
> [39914.857673] ? skb_eth_gso_segment (net/core/gro.c:127)
> [39914.857702] ? ipv6_skip_exthdr (net/ipv6/exthdrs_core.c:190)
> [39914.857726] ? kasan_save_stack (mm/kasan/common.c:47)
> [39914.857758] __skb_gso_segment (net/core/dev.c:3401 (discriminator 2))
> [39914.857787] udpv6_queue_rcv_skb (./include/net/udp.h:492
> net/ipv6/udp.c:796 net/ipv6/udp.c:787)
> [39914.857816] __udp6_lib_rcv (net/ipv6/udp.c:906 net/ipv6/udp.c:1013)

... but this means we are processing a multicast packet, likely skb is
cloned. If one of the clone instance enters simultaneusly
skb_segment_list() the latter would inconditionally call:

	skb_gso_reset(skb);

clearing the gso area in the shared info and causing unexpected results
(possibly the memory corruption observed before, and the above RCU
stall) for the other clone instances.

Assuming there are no other issues and that the above is not just a
side effect of ENOCOFFEE here, the following should possibly solve,
could you please add it to your testbed? (still with kasan+previous
patch, kmemleak is possibly not needed).

Thanks!
---
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6c5915efbc17..ac1ca6c7bff9 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4263,6 +4263,11 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb=
,
=20
 	skb_shinfo(skb)->frag_list =3D NULL;
=20
+	/* later code will clear the gso area in the shared info */
+	err =3D skb_header_unclone(skb, GFP_ATOMIC);
+	if (err)
+		goto err_linearize;
+
 	while (list_skb) {
 		nskb =3D list_skb;
 		list_skb =3D list_skb->next;

