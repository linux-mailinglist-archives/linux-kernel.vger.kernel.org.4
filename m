Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569F260D0AB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbiJYPdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiJYPdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:33:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7CD57E30
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:33:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A86A61997
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 15:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DA2C433C1;
        Tue, 25 Oct 2022 15:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666711998;
        bh=eRDzSkJF+LWtgGnt1Y7/1Uo+B6YVNqwBobA9N504LRg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mQR3f6Dwufxe4Yf0D995wgyrQuAC91zY39ZO5tkh8PN2QQzWkXT+7SO3GI5bXCJAD
         +ggfsnK0+dC9cYC9nCrNNOYjcP47l04XFaEgh83QLU2SRzUQRwsPKEZW4RsZHR6d00
         PhggN4lrnX5aeUV5LqTlAfrpN4yo/v1qnY6ppdpKW9YaS2BNKk0BHf5xvROxU+tzJ0
         FmtGgsfB8j1fBRi1eMoeKGvRO9wG6jeMzBcmBquHFLSiuJ2s6kfULx6QIQ46Unhpli
         MX7rsCwwfktzXdI89pr1LZcvsOGwoSN0Z9SCYDmdQUnb69M1zBwFlWoQQX7Sop6Tqf
         sYOyZnDglCo1A==
Date:   Wed, 26 Oct 2022 00:33:15 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     wuqiang <wuqiang.matt@bytedance.com>
Cc:     davem@davemloft.net, anil.s.keshavamurthy@intel.com,
        naveen.n.rao@linux.ibm.com, linux-kernel@vger.kernel.org,
        mattwu@163.com
Subject: Re: [PATCH] kretprobe events missing on 2-core KVM guest
Message-Id: <20221026003315.266d59d5c0780c2817be3a0d@kernel.org>
In-Reply-To: <20221025100117.18667-1-wuqiang.matt@bytedance.com>
References: <20221025100117.18667-1-wuqiang.matt@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2022 18:01:17 +0800
wuqiang <wuqiang.matt@bytedance.com> wrote:

> Default value of maxactive is set as num_possible_cpus() for nonpreemptable
> systems. For a 2-core system, only 2 kretprobe instances would be allocated
> in default, then these 2 instances for execve kretprobe are very likely to
> be used up with a pipelined command.
> 
> This patch increases the minimum of maxactive to 10.
> 

This looks reasonable to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> Signed-off-by: wuqiang <wuqiang.matt@bytedance.com>
> ---
>  kernel/kprobes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 3220b0a2fb4a..b781dee3f552 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2211,7 +2211,7 @@ int register_kretprobe(struct kretprobe *rp)
>  #ifdef CONFIG_PREEMPTION
>  		rp->maxactive = max_t(unsigned int, 10, 2*num_possible_cpus());
>  #else
> -		rp->maxactive = num_possible_cpus();
> +		rp->maxactive = max_t(unsigned int, 10, num_possible_cpus());
>  #endif
>  	}
>  #ifdef CONFIG_KRETPROBE_ON_RETHOOK
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
