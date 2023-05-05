Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C786F7C9D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 07:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjEEF6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 01:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjEEF6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 01:58:38 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E49E11D89;
        Thu,  4 May 2023 22:58:34 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1puoSU-0003tm-VJ; Fri, 05 May 2023 07:58:22 +0200
Date:   Fri, 5 May 2023 07:58:22 +0200
From:   Florian Westphal <fw@strlen.de>
To:     "Fengtao (fengtao, Euler)" <fengtao40@huawei.com>
Cc:     Florian Westphal <fw@strlen.de>, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        kuba@kernel.org, stephen@networkplumber.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        yanan@huawei.com, caowangbao@huawei.com
Subject: Re: BUG: KASAN: stack-out-of-bounds in __ip_options_echo
Message-ID: <20230505055822.GA6126@breakpoint.cc>
References: <05324dd2-3620-8f07-60a0-051814913ff8@huawei.com>
 <20230502165446.GA22029@breakpoint.cc>
 <9dd7ec8f-bc40-39af-febb-a7e8aabbaaed@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dd7ec8f-bc40-39af-febb-a7e8aabbaaed@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fengtao (fengtao, Euler) <fengtao40@huawei.com> wrote:
> Hi
> 
> I have tested the patch, the panic not happend.
> And I search the similar issue in kernel, and found commit:
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ed0de45a1008
> [2]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3da1ed7ac398
> 
> So I tested another patch like this:
> ------------[ cut here ]------------
> --- .//net/ipv4/netfilter/nf_reject_ipv4.c      2023-05-02 13:03:35.427896081 +0000
> +++ .//net/ipv4/netfilter/nf_reject_ipv4.c.new  2023-05-02 13:03:00.433897970 +0000
> @@ -187,6 +187,7 @@ > 
>  void nf_send_unreach(struct sk_buff *skb_in, int code, int hook)
>  {
> +       struct ip_options opt;
>         struct iphdr *iph = ip_hdr(skb_in);
>         u8 proto = iph->protocol;
> 
> @@ -196,13 +197,18 @@
>         if (hook == NF_INET_PRE_ROUTING && nf_reject_fill_skb_dst(skb_in))
>                 return;
> 
> +       memset(&opt, 0, sizeof(opt));
> +       opt.optlen = iph->ihl*4 - sizeof(struct iphdr);
> +       if (__ip_options_compile(dev_net(skb_in->dev), &opt, skb_in, NULL))
> +               return;
> +
>         if (skb_csum_unnecessary(skb_in) || !nf_reject_verify_csum(proto)) {
> -               icmp_send(skb_in, ICMP_DEST_UNREACH, code, 0);
> +               __icmp_send(skb_in, ICMP_DEST_UNREACH, code, 0, &opt);
>                 return;
>         }
> 
>         if (nf_ip_checksum(skb_in, hook, ip_hdrlen(skb_in), proto) == 0)
> -               icmp_send(skb_in, ICMP_DEST_UNREACH, code, 0);
> +               __icmp_send(skb_in, ICMP_DEST_UNREACH, code, 0, &opt);
>  }
>  EXPORT_SYMBOL_GPL(nf_send_unreach);
> ------------[ cut here ]------------
> 
> This can also fix the issue :)

No, it papers over the problem, by only fixing this specific instance
(icmpv4).  What about ipv6?  What about all other IPCB accesses?

> BTW, I think the problem is more then ipvlan? Maybe some other scenarios that can trigger such issue.

Such as?

I don't see how this is fixable, just have have a look at "git grep
IPCB", how do you envision stack to know how such access is valid or
not?
