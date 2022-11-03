Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7E2617DB0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiKCNSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKCNSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:18:34 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9DF1B3;
        Thu,  3 Nov 2022 06:18:32 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1oqa73-0002Y7-2M; Thu, 03 Nov 2022 14:18:29 +0100
Date:   Thu, 3 Nov 2022 14:18:29 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Shigeru Yoshida <syoshida@redhat.com>
Cc:     pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot+178efee9e2d7f87f5103@syzkaller.appspotmail.com
Subject: Re: [PATCH] netfilter: Cleanup nft_net->module_list from
 nf_tables_exit_net()
Message-ID: <20221103131829.GB29268@breakpoint.cc>
References: <20221103130849.1624522-1-syoshida@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103130849.1624522-1-syoshida@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shigeru Yoshida <syoshida@redhat.com> wrote:
> syzbot reported a warning like below [1]:
> 
> This patch fixes this issue by calling __nf_tables_abort() when
> nft_net->module_list is not empty in nf_tables_exit_net().

Fixes: eb014de4fd41 ("netfilter: nf_tables: autoload modules from the abort path")

> diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
> index 58d9cbc9ccdc..a7579d16f59f 100644
> --- a/net/netfilter/nf_tables_api.c
> +++ b/net/netfilter/nf_tables_api.c
> @@ -10088,7 +10088,8 @@ static void __net_exit nf_tables_exit_net(struct net *net)
>  	struct nftables_pernet *nft_net = nft_pernet(net);
>  
>  	mutex_lock(&nft_net->commit_mutex);
> -	if (!list_empty(&nft_net->commit_list))
> +	if (!list_empty(&nft_net->commit_list) ||
> +	    !list_empty(&nft_net->module_list))
>  		__nf_tables_abort(net, NFNL_ABORT_NONE);

Maybe just an unconditionall call to nf_tables_module_autoload_cleanup().

Or, alternatively, unconditionally call __nf_tables_abort().
The downside is that we will need to change __nf_tables_abort to elide
synchronize_rcu() unless needed -- else netns dismantling might become
too expensive.

OTOH, module_list should always be empty here, so this is ok.

Reviewed-by: Florian Westphal <fw@strlen.de>
