Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429CD73EEE3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 00:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjFZW7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 18:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjFZW7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 18:59:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A995199
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 15:59:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E224E60F79
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 22:59:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B844FC433C0;
        Mon, 26 Jun 2023 22:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687820346;
        bh=652MFVzhku0Nt68TmRIUSHH/UvVI7+/iNQrsltfUhdc=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=iS+ulOWO8zDjh7RgglL3o9Y6+s7N4KQtzNuxU8YWMOJyN8VGOoHS10JxAoODDSbhk
         /zoXeAHlFb2xgu+BSjHN6b0KWlhTmC8XWGkOWOSQ6PpbUXp26RCD4mNqCUikr1fIMu
         KENuFesoed8eIp25eKay0qgrOUPlH3lai+NYTB+1ONmKKJLOSiJ+pieiz3+7QBLrq7
         wFSIPSWGRgYjmjxICeeqSDhn7IJ362av2u4Wzvwbnwk7tMglYjqp3u1rzEe+QmwHqM
         EdxQVCo06PiM49hJ2vYf0S+CaqmOFC+6K/mRir7BBm+841oDk9QN4pkM05VZCLZnpH
         dgSgyUuTzUqcg==
Date:   Tue, 27 Jun 2023 00:59:03 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     tj@kernel.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, fuyuanli@didiglobal.com,
        zwp10758@gmail.com, zyhtheonly@gmail.com, zyhtheonly@yeah.net
Subject: Re: [PATCH v3] sched/isolation: add a workqueue parameter onto
 isolcpus to constrain unbound CPUs
Message-ID: <ZJoYNzXfQjgocqvj@lothringen>
References: <ZJNizvI-7A2hFDoM@slm.duckdns.org>
 <20230622032133.GA29012@didi-ThinkCentre-M930t-N000>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622032133.GA29012@didi-ThinkCentre-M930t-N000>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 11:22:17AM +0800, tiozhang wrote:
> Motivation of doing this is to better improve boot times for devices when
> we want to prevent our workqueue works from running on some specific CPUs,
> i,e, some CPUs are busy with interrupts.
> 
> Also remove HK_FLAG_WQ from nohz_full to prevent nohz_full overriding
> workqueue's cpu config.

But then nohz_full= doesn't re-affine workqueues anymore, right?

> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: tiozhang <tiozhang@didiglobal.com>
> ---
>  kernel/sched/isolation.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 373d42c707bc..5cd67c51622e 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -181,8 +181,8 @@ static int __init housekeeping_nohz_full_setup(char *str)
>  {
>  	unsigned long flags;
>  
> -	flags = HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU |
> -		HK_FLAG_MISC | HK_FLAG_KTHREAD;
> +	flags = HK_FLAG_TICK | HK_FLAG_TIMER | HK_FLAG_RCU | HK_FLAG_MISC
> +		| HK_FLAG_KTHREAD;
>  
>  	return housekeeping_setup(str, flags);
>  }
> @@ -208,6 +208,12 @@ static int __init housekeeping_isolcpus_setup(char *str)
>  			continue;
>  		}
>  
> +		if (!strncmp(str, "workqueue,", 10)) {
> +			str += 10;
> +			flags |= HK_FLAG_WQ;
> +			continue;
> +		}
> +

I'm planning on removing HK_FLAG_TICK, HK_FLAG_WQ, HK_FLAG_TIMER, HK_FLAG_RCU,
HK_FLAG_MISC and HK_FLAG_KTHREAD and merge them all together. Also the problem with
these flags is that once they are modified on boot, you can't modify them later.

I much prefer what was done in this patch:

  https://lore.kernel.org/all/20230623073033.GA6584@didi-ThinkCentre-M930t-N000/

Thanks!

>  		if (!strncmp(str, "managed_irq,", 12)) {
>  			str += 12;
>  			flags |= HK_FLAG_MANAGED_IRQ;
> -- 
> 2.17.1
> 
