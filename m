Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1A3750058
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 09:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjGLHol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 03:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjGLHok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 03:44:40 -0400
Received: from bjm7-spam01.kuaishou.com (smtpcn03.kuaishou.com [103.107.217.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8871739
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 00:44:37 -0700 (PDT)
Received: from bjm7-pm-mail12.kuaishou.com ([172.28.1.94])
        by bjm7-spam01.kuaishou.com with ESMTPS id 36C7i54E091281
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Jul 2023 15:44:05 +0800 (GMT-8)
        (envelope-from yangyifei03@kuaishou.com)
DKIM-Signature: v=1; a=rsa-sha256; d=kuaishou.com; s=dkim; c=relaxed/relaxed;
        t=1689147699; h=from:subject:to:date:message-id;
        bh=4bsjq3/OpZknyXpOBaPqn5L7sbEDbyMoFRu21WzLBU4=;
        b=Qpzzs4dHeH87du7WuBb9IbhYP0oz6ali7QQhTQKv9+WJyjtZMAttJdDVI/iGf0ExokIf4ZKPI4f
        8V0lQ3/8L2Mhkz++Sx1083Rod4J66wyizIDtQDIrIxlILnWSar7F4ZZwwcPYQ3P52eX5CpSC3LtHz
        bwYOudEdUpnRC4AC0IY=
Received: from public-bjmt-d51.idcyz.hb1.kwaidc.com (172.28.1.32) by
 bjm7-pm-mail12.kuaishou.com (172.28.1.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Wed, 12 Jul 2023 15:41:39 +0800
From:   Efly Young <yangyifei03@kuaishou.com>
To:     <hannes@cmpxchg.org>
CC:     <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <yangyifei03@kuaishou.com>
Subject: Re:Re:[PATCH] mm:vmscan: fix inaccurate reclaim during proactive reclaim
Date:   Wed, 12 Jul 2023 15:42:52 +0800
Message-ID: <20230712074252.25894-1-yangyifei03@kuaishou.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230711152810.GA2627@cmpxchg.org>
References: <20230711152810.GA2627@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.28.1.32]
X-ClientProxiedBy: bjm7-pm-mail06.kuaishou.com (172.28.1.6) To
 bjm7-pm-mail12.kuaishou.com (172.28.1.94)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: bjm7-spam01.kuaishou.com 36C7i54E091281
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> With commit f53af4285d77 ("mm: vmscan: fix extreme overreclaim
>> and swap floods"), proactive reclaim still seems inaccurate.
>> 
>> Our problematic scene also are almost anon pages. Request 1G
>> by writing memory.reclaim will reclaim 1.7G or other values
>> more than 1G by swapping.
>> 
>> This try to fix the inaccurate reclaim problem.
>
> I can see how this happens. Direct and kswapd reclaim have much
> smaller nr_to_reclaim targets, so it's less noticable when we loop a
> few times. Proactive reclaim can come in with a rather large value.
> 
> What does the reproducer setup look like? Are you calling reclaim on a
> higher level cgroup with several children? Or is the looping coming
> from having multiple zones alone?

Thank you for your comment. The process in a leaf cgroup without children
just malloc 20G anonymous memory and sleep, then calling reclaim in the
leaf cgroup. Before commit f53af4285d77 ("mm: vmscan: fix extreme
overreclaim and swap floods"), reclaimer may reclaim many times the amount
of request. Now it should eventually reclaim in [request, 2 * request).

>> Signed-off-by: Efly Young <yangyifei03@kuaishou.com>
>> ---
>>  mm/vmscan.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 9c1c5e8b..2aea8d9 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -6208,7 +6208,7 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
>>  	unsigned long nr_to_scan;
>>  	enum lru_list lru;
>>  	unsigned long nr_reclaimed = 0;
>> -	unsigned long nr_to_reclaim = sc->nr_to_reclaim;
>> +	unsigned long nr_to_reclaim = (sc->nr_to_reclaim - sc->nr_reclaimed);
>
> This can underflow. shrink_list() eats SWAP_CLUSTER_MAX batches out of
> lru_pages >> priority, and only checks reclaimed > to_reclaim
> after. This will then disable the bailout mechanism entirely.
> 
> In general, I'm not sure this is the best spot to fix the problem:
> 
> - During reclaim/compaction, should_continue_reclaim() may decide that
>   more reclaim is required before compaction can proceed. But the
>   second cycle might not do anything now, since you remember the work
>   done by the previous one.
> 
> - shrink_node_memcgs() might do the full batch against the first
>   cgroup and not touch the second one anymore. This will result in
>   super lopsided behavior when you target a tree of multiple groups.
> 
> There might be other spots that break, I haven't checked.
> 
> You could go through them one by one, of course. But the truth is,
> larger reclaim targets are the rare exception. Trying to support them
> at the risk of breaking all other reclaim users seems ill-advised.

I agree with your view. These explanations are more considerate. Thank
you again for helping me out.

> A better approach might be to just say: "don't call reclaim with large
> numbers". Have proactive reclaim code handle the batching into smaller
> chunks:
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e8ca4bdcb03c..4b016806dcc7 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6696,7 +6696,7 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
>  			lru_add_drain_all();
>  
>  		reclaimed = try_to_free_mem_cgroup_pages(memcg,
> -						nr_to_reclaim - nr_reclaimed,
> +						min(nr_to_reclaim - nr_reclaimed, SWAP_CLUSTER_MAX),
>  						GFP_KERNEL, reclaim_options);
>  
>  		if (!reclaimed && !nr_retries--)

May be this way could solve the inaccurate proactive reclaim
problem without breaking the original balance. But may be less
efficient than before?
