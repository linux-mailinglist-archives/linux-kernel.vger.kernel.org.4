Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469356EA30E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 07:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjDUFUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 01:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjDUFUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 01:20:15 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859EE3A90
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 22:20:13 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Q2jX84k4Gz4x5Q;
        Fri, 21 Apr 2023 15:20:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1682054408;
        bh=qMMIN3ov7JZAgmH7R1umRdp7sW0RTy/xY8uoQpaTt5g=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ZcrR2/bg6xc0PZPWxmB0oL8x18DaTjaSedqE3OgsFxXtbyuV6rkH8HyjumygWoFVe
         D4ZDqqgbhuHyKA85EeXwCf9ymLR2PaFYUrecpBkZHuh/jD88xp85lE4+m2QgiultnF
         9go7eHgOl76wNnRmgw04nW8GzkV0cu3GOTFOQ/iJy0bnDb1ZIUI7fmLl2FYXs+ZSHO
         YuOvw/apxBOxfI7c93qPdswA3/AAQOoOdC6+3hU7Sx2ve+Zml9iQwdFVNhFWgRL74D
         JCuaIb4V6UMFGRGWyjYGqdCzClDgoxDba4AoqDYsewbm1+WJbE0tKnHnH6ge/JsFzw
         PpiK5Eu+/tLOA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Tejun Heo <tj@kernel.org>, jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 01/22] powerpc, workqueue: Use alloc_ordered_workqueue()
 to create ordered workqueues
In-Reply-To: <20230421025046.4008499-2-tj@kernel.org>
References: <20230421025046.4008499-1-tj@kernel.org>
 <20230421025046.4008499-2-tj@kernel.org>
Date:   Fri, 21 Apr 2023 15:20:08 +1000
Message-ID: <87ildpg6bb.fsf@mail.concordia>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo <tj@kernel.org> writes:
> BACKGROUND
> ==========
>
> When multiple work items are queued to a workqueue, their execution order
> doesn't match the queueing order. They may get executed in any order and
> simultaneously. When fully serialized execution - one by one in the queueing
> order - is needed, an ordered workqueue should be used which can be created
> with alloc_ordered_workqueue().
>
> However, alloc_ordered_workqueue() was a later addition. Before it, an
> ordered workqueue could be obtained by creating an UNBOUND workqueue with
> @max_active==1. This originally was an implementation side-effect which was
> broken by 4c16bd327c74 ("workqueue: restore WQ_UNBOUND/max_active==1 to be
> ordered"). Because there were users that depended on the ordered execution,
> 5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active==1 to be ordered")
> made workqueue allocation path to implicitly promote UNBOUND workqueues w/
> @max_active==1 to ordered workqueues.
>
> While this has worked okay, overloading the UNBOUND allocation interface
> this way creates other issues. It's difficult to tell whether a given
> workqueue actually needs to be ordered and users that legitimately want a
> min concurrency level wq unexpectedly gets an ordered one instead. With
> planned UNBOUND workqueue updates to improve execution locality and more
> prevalence of chiplet designs which can benefit from such improvements, this
> isn't a state we wanna be in forever.
>
> This patch series audits all callsites that create an UNBOUND workqueue w/
> @max_active==1 and converts them to alloc_ordered_workqueue() as necessary.
>
> WHAT TO LOOK FOR
> ================
>
> The conversions are from
>
>   alloc_workqueue(WQ_UNBOUND | flags, 1, args..)
>
> to
>
>   alloc_ordered_workqueue(flags, args...)
>
> which don't cause any functional changes. If you know that fully ordered
> execution is not ncessary, please let me know. I'll drop the conversion and
> instead add a comment noting the fact to reduce confusion while conversion
> is in progress.
>
> If you aren't fully sure, it's completely fine to let the conversion
> through. The behavior will stay exactly the same and we can always
> reconsider later.
>
> As there are follow-up workqueue core changes, I'd really appreciate if the
> patch can be routed through the workqueue tree w/ your acks. Thanks.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Nathan Lynch <nathanl@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/kernel/tau_6xx.c          | 2 +-
>  arch/powerpc/platforms/pseries/dlpar.c | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)


> diff --git a/arch/powerpc/kernel/tau_6xx.c b/arch/powerpc/kernel/tau_6xx.c
> index 828d0f4106d2..cba6dd15de3b 100644
> --- a/arch/powerpc/kernel/tau_6xx.c
> +++ b/arch/powerpc/kernel/tau_6xx.c
> @@ -200,7 +200,7 @@ static int __init TAU_init(void)
>  	tau_int_enable = IS_ENABLED(CONFIG_TAU_INT) &&
>  			 !strcmp(cur_cpu_spec->platform, "ppc750");
>  
> -	tau_workq = alloc_workqueue("tau", WQ_UNBOUND, 1);
> +	tau_workq = alloc_ordered_workqueue("tau", 0);
>  	if (!tau_workq)
>  		return -ENOMEM;
>  
> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> index 75ffdbcd2865..e9117b03807e 100644
> --- a/arch/powerpc/platforms/pseries/dlpar.c
> +++ b/arch/powerpc/platforms/pseries/dlpar.c
> @@ -564,8 +564,7 @@ int __init dlpar_workqueue_init(void)
>  	if (pseries_hp_wq)
>  		return 0;
>  
> -	pseries_hp_wq = alloc_workqueue("pseries hotplug workqueue",
> -			WQ_UNBOUND, 1);
> +	pseries_hp_wq = alloc_ordered_workqueue("pseries hotplug workqueue", 0);
>  
>  	return pseries_hp_wq ? 0 : -ENOMEM;
>  }

The change log of commit 9054619ef54a ("powerpc/pseries: Add pseries
hotplug workqueue") makes it fairly clear that this code does explicitly
want an ordered queue.

cheers
