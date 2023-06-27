Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8736573FAD5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjF0LND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjF0LNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:13:00 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08181FF3;
        Tue, 27 Jun 2023 04:12:58 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qE6cq-0003Sm-6H; Tue, 27 Jun 2023 13:12:48 +0200
Date:   Tue, 27 Jun 2023 13:12:48 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     daniel@iogearbox.net, edumazet@google.com, kuba@kernel.org,
        fw@strlen.de, pabeni@redhat.com, pablo@netfilter.org,
        andrii@kernel.org, davem@davemloft.net, ast@kernel.org,
        kadlec@netfilter.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, dsahern@kernel.org
Subject: Re: [PATCH bpf-next 4/7] netfilter: bpf: Support
 BPF_F_NETFILTER_IP_DEFRAG in netfilter link
Message-ID: <20230627111248.GH3207@breakpoint.cc>
References: <cover.1687819413.git.dxu@dxuuu.xyz>
 <242c66138bf4ec8aa26b29d736fb48242b4164ce.1687819413.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <242c66138bf4ec8aa26b29d736fb48242b4164ce.1687819413.git.dxu@dxuuu.xyz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Xu <dxu@dxuuu.xyz> wrote:
> +static int bpf_nf_enable_defrag(struct bpf_nf_link *link)
> +{
> +	int err;
> +
> +	switch (link->hook_ops.pf) {
> +#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4)
> +	case NFPROTO_IPV4:
> +		const struct nf_defrag_v4_hook *v4_hook;
> +
> +		err = request_module("nf_defrag_ipv4");
> +		if (err)
> +			return err;
> +
> +		rcu_read_lock();
> +		v4_hook = rcu_dereference(nf_defrag_v4_hook);
> +		err = v4_hook->enable(link->net);
> +		rcu_read_unlock();

I'd reverse this, first try rcu_dereference(), then modprobe
if thats returned NULL.

> +static void bpf_nf_disable_defrag(struct bpf_nf_link *link)
> +{
> +	switch (link->hook_ops.pf) {
> +#if IS_ENABLED(CONFIG_NF_DEFRAG_IPV4)
> +	case NFPROTO_IPV4:
> +		const struct nf_defrag_v4_hook *v4_hook;
> +
> +		rcu_read_lock();
> +		v4_hook = rcu_dereference(nf_defrag_v4_hook);
> +		v4_hook->disable(link->net);
> +		rcu_read_unlock();

if (v4_hook)
	v4_hook->disable()

Else we get trouble on manual 'rmmod'.

> +	/* make sure conntrack confirm is always last */
> +	prio = attr->link_create.netfilter.priority;
> +	if (prio == NF_IP_PRI_FIRST)
> +		return -ERANGE;  /* sabotage_in and other warts */
> +	else if (prio == NF_IP_PRI_LAST)
> +		return -ERANGE;  /* e.g. conntrack confirm */
> +	else if ((attr->link_create.netfilter.flags & BPF_F_NETFILTER_IP_DEFRAG) &&
> +		 (prio > NF_IP_PRI_FIRST && prio <= NF_IP_PRI_CONNTRACK_DEFRAG))
> +		return -ERANGE;  /* cannot use defrag if prog runs before nf_defrag */

You could elide the (prio > NF_IP_PRI_FIRST, its already handled by
first conditional.  Otherwise this looks good to me.
