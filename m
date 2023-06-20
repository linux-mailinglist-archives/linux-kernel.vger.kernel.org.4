Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84BD736E69
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjFTOMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbjFTOMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:12:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C74E72
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VmM0Nc3LtyvvmpukuP4nGr0cZ1knJlu8u3HNcvubAaw=; b=hm0iJgo4ztBsmZPctKxioshyft
        ZpurZs5YOMn0tybmwtDzZ26ulMwGO+q8Ug9sWYwSrySeGGgJONlCiviE5nxghdkhl7Fc+yVWDVpKp
        vNlJzJub/+yh6VwpjHlvDJRa12pIwZqkqZMJKyQ04yIFS0Ja4DChE0Likncf8MfZGzs4GLEkJ0Fob
        9lRcbK3qYzDPjyXtQG9ItqgL7zHCndZpLgw4gnaT6LyjvcMa5RkUUmxNNZ0cGFQFuu2GQX1WwZebG
        aAp2YhyBSIOrKFAFh4ZPBiivTOZKA4IxgLPhwKiugqsC+blAamhKRZTG0dtS2IN5HcWpoYeqaL3Ta
        +mgshOFA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qBc4o-00G6C2-24;
        Tue, 20 Jun 2023 14:11:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 84B17300137;
        Tue, 20 Jun 2023 16:11:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3BF96241C2230; Tue, 20 Jun 2023 16:11:20 +0200 (CEST)
Date:   Tue, 20 Jun 2023 16:11:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/topology: remove unneeded do while loop in
 cpu_attach_domain()
Message-ID: <20230620141120.GA2016469@hirez.programming.kicks-ass.net>
References: <20230617081926.2035113-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230617081926.2035113-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 04:19:26PM +0800, Miaohe Lin wrote:
> When sg != sd->groups, the do while loop would cause deadloop here. But
> that won't occur because sg is always equal to sd->groups now. Remove
> this unneeded do while loop.

This Changelog makes no sense to me.. Yes, as is the do {} while loop is
dead code, but it *should* have read like:

	do {
		sg->flags = 0;
		sg = sg->next;
	} while (sg != sd->groups);

as I noted here:

  https://lore.kernel.org/all/20230523105935.GN83892@hirez.programming.kicks-ass.net/T/#u

So what this changelog should argue is how there cannot be multiple
groups here -- or if there can be, add the missing iteration.

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  kernel/sched/topology.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index ca4472281c28..9010c93c3fdb 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -750,10 +750,7 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
>  			 * domain for convenience. Clear such flags since
>  			 * the child is being destroyed.
>  			 */
> -			do {
> -				sg->flags = 0;
> -			} while (sg != sd->groups);
> -
> +			sg->flags = 0;
>  			sd->child = NULL;
>  		}
>  	}
> -- 
> 2.27.0
> 
