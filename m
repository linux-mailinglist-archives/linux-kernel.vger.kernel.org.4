Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12EC6A5FC3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 20:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjB1ThX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 14:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjB1ThW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:37:22 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11889271C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 11:37:19 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id c3-20020a170902724300b0019d1ffec36dso3050388pll.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 11:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677613038;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E2L+GAy/YvAYbKBRaue7XDuXS1/NBXymrvrEmdhdNP8=;
        b=EaQNtkGpkyOxOBGk8gY8X9yeVcaB6MBGDbyWEmjwyDmnpZ7lL8pfbpn7bz3RP9tukx
         UTFnskamZqdb4eUPQbcvQTRzmZKjDuNF/GQCAFCKkTvQPe8pCBK78PTOJ7w6TBPGcMri
         Fb6lzt8C7P27Fl/3GkKDKXqHeAq+c4icloUrmVG9qpMeU0041VN3W/pdl5E6B895x/7R
         7j1/q0qIsamJ8l+obsulIQHUojVSflwPQfxT6DSM2sRP3X9ts4xkWiigPCCDCcTlzRqL
         7zb5piHtNRXECjhT34nd4xMgUlx0Sz+ZPpfdiQWVS1jvkD7Kfh9gE+psSDBu8cKU5pwl
         ldJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677613038;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E2L+GAy/YvAYbKBRaue7XDuXS1/NBXymrvrEmdhdNP8=;
        b=ntcOOY5oOwL3s0tF7oLdutIxeUSYN2exPI0uL/GnoZJTxi+e0VGy9frl5gkOc6ObjD
         bYZ62J1GOHyAZt8eOt1do6VqnnkOQQ2fMxLtlFz27cku7N37El2p9Hfio6KSqOX5xtJW
         naCS4hbzfuVPSEpiie3Gp93gwxE+HdnfyFIYnW4uvuJ69jWgxMXdfzyay2jq4UbwQmSC
         WH4PW8vPxqLjxHbrQ0Ry1m5DPaEAg13yIyv+Pwzl353VHFval9l3YYNpHG++gwzWZR6W
         H7IMDC5zMiJ+7BOa+vRT2TbwfsZcVyBlIhYwNibU1xXcej4ej09L4NJEIIANHPwoQ6xf
         lyCQ==
X-Gm-Message-State: AO0yUKX3yBt2xsezgLNufrvds1wy+Lnsw22mgxv6yv8Qk2FkfFLQ/wIM
        edKY0VB9JG1PE8q0Ec8x7oRkol4=
X-Google-Smtp-Source: AK7set/xUo6b0h3h58IkD6ZSafI/hkkFt3+3pR92QSeur3X0N47hQQ9mdkV18sbfFmeTN9lX9jlApSc=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:9518:0:b0:4fb:94e2:d1c0 with SMTP id
 p24-20020a639518000000b004fb94e2d1c0mr1187089pgd.11.1677613038524; Tue, 28
 Feb 2023 11:37:18 -0800 (PST)
Date:   Tue, 28 Feb 2023 11:37:16 -0800
In-Reply-To: <7145c9891791db1c868a326476fef590f22b352b.1677526810.git.dxu@dxuuu.xyz>
Mime-Version: 1.0
References: <cover.1677526810.git.dxu@dxuuu.xyz> <7145c9891791db1c868a326476fef590f22b352b.1677526810.git.dxu@dxuuu.xyz>
Message-ID: <Y/5X7BF9CDYZMuMl@google.com>
Subject: Re: [PATCH bpf-next v2 3/8] bpf, net, frags: Add bpf_ip_check_defrag()
 kfunc
From:   Stanislav Fomichev <sdf@google.com>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
        dsahern@kernel.org, pabeni@redhat.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/27, Daniel Xu wrote:
> This kfunc is used to defragment IPv4 packets. The idea is that if you
> see a fragmented packet, you call this kfunc. If the kfunc returns 0,
> then the skb has been updated to contain the entire reassembled packet.

> If the kfunc returns an error (most likely -EINPROGRESS), then it means
> the skb is part of a yet-incomplete original packet. A reasonable
> response to -EINPROGRESS is to drop the packet, as the ip defrag
> infrastructure is already hanging onto the frag for future reassembly.

> Care has been taken to ensure the prog skb remains valid no matter what
> the underlying ip_check_defrag() call does. This is in contrast to
> ip_defrag(), which may consume the skb if the skb is part of a
> yet-incomplete original packet.

> So far this kfunc is only callable from TC clsact progs.

> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>   include/net/ip.h           | 11 +++++
>   net/ipv4/Makefile          |  1 +
>   net/ipv4/ip_fragment.c     |  2 +
>   net/ipv4/ip_fragment_bpf.c | 98 ++++++++++++++++++++++++++++++++++++++
>   4 files changed, 112 insertions(+)
>   create mode 100644 net/ipv4/ip_fragment_bpf.c

> diff --git a/include/net/ip.h b/include/net/ip.h
> index c3fffaa92d6e..f3796b1b5cac 100644
> --- a/include/net/ip.h
> +++ b/include/net/ip.h
> @@ -680,6 +680,7 @@ enum ip_defrag_users {
>   	IP_DEFRAG_VS_FWD,
>   	IP_DEFRAG_AF_PACKET,
>   	IP_DEFRAG_MACVLAN,
> +	IP_DEFRAG_BPF,
>   };

>   /* Return true if the value of 'user' is between 'lower_bond'
> @@ -693,6 +694,16 @@ static inline bool ip_defrag_user_in_between(u32  
> user,
>   }

>   int ip_defrag(struct net *net, struct sk_buff *skb, u32 user);
> +
> +#ifdef CONFIG_DEBUG_INFO_BTF
> +int register_ip_frag_bpf(void);
> +#else
> +static inline int register_ip_frag_bpf(void)
> +{
> +	return 0;
> +}
> +#endif
> +
>   #ifdef CONFIG_INET
>   struct sk_buff *ip_check_defrag(struct net *net, struct sk_buff *skb,  
> u32 user);
>   #else
> diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
> index 880277c9fd07..950efb166d37 100644
> --- a/net/ipv4/Makefile
> +++ b/net/ipv4/Makefile
> @@ -65,6 +65,7 @@ obj-$(CONFIG_TCP_CONG_ILLINOIS) += tcp_illinois.o
>   obj-$(CONFIG_NET_SOCK_MSG) += tcp_bpf.o
>   obj-$(CONFIG_BPF_SYSCALL) += udp_bpf.o
>   obj-$(CONFIG_NETLABEL) += cipso_ipv4.o
> +obj-$(CONFIG_DEBUG_INFO_BTF) += ip_fragment_bpf.o

>   obj-$(CONFIG_XFRM) += xfrm4_policy.o xfrm4_state.o xfrm4_input.o \
>   		      xfrm4_output.o xfrm4_protocol.o
> diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
> index 959d2c4260ea..e3fda5203f09 100644
> --- a/net/ipv4/ip_fragment.c
> +++ b/net/ipv4/ip_fragment.c
> @@ -759,5 +759,7 @@ void __init ipfrag_init(void)
>   	if (inet_frags_init(&ip4_frags))
>   		panic("IP: failed to allocate ip4_frags cache\n");
>   	ip4_frags_ctl_register();
> +	if (register_ip_frag_bpf())
> +		panic("IP: bpf: failed to register ip_frag_bpf\n");
>   	register_pernet_subsys(&ip4_frags_ops);
>   }
> diff --git a/net/ipv4/ip_fragment_bpf.c b/net/ipv4/ip_fragment_bpf.c
> new file mode 100644
> index 000000000000..a9e5908ed216
> --- /dev/null
> +++ b/net/ipv4/ip_fragment_bpf.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Unstable ipv4 fragmentation helpers for TC-BPF hook
> + *
> + * These are called from SCHED_CLS BPF programs. Note that it is allowed  
> to
> + * break compatibility for these functions since the interface they are  
> exposed
> + * through to BPF programs is explicitly unstable.
> + */
> +
> +#include <linux/bpf.h>
> +#include <linux/btf_ids.h>
> +#include <linux/ip.h>
> +#include <linux/filter.h>
> +#include <linux/netdevice.h>
> +#include <net/ip.h>
> +#include <net/sock.h>
> +
> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +		  "Global functions as their definitions will be in ip_fragment BTF");
> +
> +/* bpf_ip_check_defrag - Defragment an ipv4 packet
> + *
> + * This helper takes an skb as input. If this skb successfully  
> reassembles
> + * the original packet, the skb is updated to contain the original,  
> reassembled
> + * packet.
> + *
> + * Otherwise (on error or incomplete reassembly), the input skb remains
> + * unmodified.
> + *
> + * Parameters:
> + * @ctx		- Pointer to program context (skb)
> + * @netns	- Child network namespace id. If value is a negative signed
> + *		  32-bit integer, the netns of the device in the skb is used.
> + *
> + * Return:
> + * 0 on successfully reassembly or non-fragmented packet. Negative value  
> on
> + * error or incomplete reassembly.
> + */
> +int bpf_ip_check_defrag(struct __sk_buff *ctx, u64 netns)

Needs a __bpf_kfunc tag as well?

> +{
> +	struct sk_buff *skb = (struct sk_buff *)ctx;
> +	struct sk_buff *skb_cpy, *skb_out;
> +	struct net *caller_net;
> +	struct net *net;
> +	int mac_len;
> +	void *mac;
> +

[..]

> +	if (unlikely(!((s32)netns < 0 || netns <= S32_MAX)))
> +		return -EINVAL;

Can you explain what it does? Is it checking for -1 explicitly? Not sure
it works :-/

Maybe we can spell out the cases explicitly?

if (unlikely(
	     ((s32)netns < 0 && netns != S32_MAX) || /* -1 */
	     netns > U32_MAX /* higher 4 bytes */
	    )
	return -EINVAL;

> +
> +	caller_net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
> +	if ((s32)netns < 0) {
> +		net = caller_net;
> +	} else {
> +		net = get_net_ns_by_id(caller_net, netns);
> +		if (unlikely(!net))
> +			return -EINVAL;
> +	}
> +
> +	mac_len = skb->mac_len;
> +	skb_cpy = skb_copy(skb, GFP_ATOMIC);
> +	if (!skb_cpy)
> +		return -ENOMEM;
> +
> +	skb_out = ip_check_defrag(net, skb_cpy, IP_DEFRAG_BPF);
> +	if (IS_ERR(skb_out))
> +		return PTR_ERR(skb_out);
> +
> +	skb_morph(skb, skb_out);
> +	kfree_skb(skb_out);
> +
> +	/* ip_check_defrag() does not maintain mac header, so push empty header
> +	 * in so prog sees the correct layout. The empty mac header will be
> +	 * later pulled from cls_bpf.
> +	 */
> +	mac = skb_push(skb, mac_len);
> +	memset(mac, 0, mac_len);
> +	bpf_compute_data_pointers(skb);
> +
> +	return 0;
> +}
> +
> +__diag_pop()
> +
> +BTF_SET8_START(ip_frag_kfunc_set)
> +BTF_ID_FLAGS(func, bpf_ip_check_defrag, KF_CHANGES_PKT)
> +BTF_SET8_END(ip_frag_kfunc_set)
> +
> +static const struct btf_kfunc_id_set ip_frag_bpf_kfunc_set = {
> +	.owner = THIS_MODULE,
> +	.set   = &ip_frag_kfunc_set,
> +};
> +
> +int register_ip_frag_bpf(void)
> +{
> +	return register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS,
> +					 &ip_frag_bpf_kfunc_set);
> +}
> --
> 2.39.1

