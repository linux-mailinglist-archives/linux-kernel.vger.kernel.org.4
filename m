Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D205A74F367
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjGKP2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbjGKP2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:28:20 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0941713
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:28:12 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-634f59e7d47so33687266d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1689089291; x=1691681291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i+ay3yLBi0LIZZhlWfubcnK7psf6xXC5MPT4ey2dzCM=;
        b=VN0P4UAkymUQrXpU1rjo9NzV9mGcIxqtOp3WvPrMyJxIQnMVCUL1e8ErcMDoLFDkY3
         HYhWC0QCl+gPpmkzB/ZmiZDUMkpy7zKSVKYp96qoSxkNnqP+rcng3EpM+lkt6gPC6DWq
         BbxyzZFjZittEeqjL3KZ964FkHJBaERbR4Mawx72T2pOqpfPEsGJ5mh8//f28Peie/aG
         6OdI/gZSWFOAl359C+3r5+bK337Pd+74MtXX64ivc15S0SFX9Br1HCh83ALv0SfM8gJi
         E1Ogcg5CmYiUqYP3yhwZbtTKvylgLFXc+3F7Q4Ep02nGHfd3Np62wrXJz9n7GiZZphuv
         wVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689089291; x=1691681291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+ay3yLBi0LIZZhlWfubcnK7psf6xXC5MPT4ey2dzCM=;
        b=Q7JNJXE32VLtBozH9waZ9dT4qE8BcrRLVfMmtKllBE7D1WKHckzLOIZbvdnT6qZoSN
         ePqIXRK42zp66uhX4WQSqltzPox3QCKSaQHBYKQFiW0X4CzujRAmaALlMuBQYIF4XdjA
         LZI6P+C2Lvl+tgm96F5/SoEYoAuv4khi7Yq6K+go77hLpEoGg0Tdw1SdWwv/ts59SlnO
         pqLpB+Hge2e+U2pnOorRcE23b6xxFynTiIzgkcX7+HgzdBODF47MPtlc1Ou2fuCcBfCz
         +9A7A6zz698h7bXlqesxfU/7hVbBTzTLIWXmCUkSownV5z1zPa6JNRAbIRb0aNyGpcrr
         Iugg==
X-Gm-Message-State: ABy/qLbfIlUFOn1z6HolRLAOi4ue83Ne5n29WcrioowI63vyhpCsx3k8
        pGuPybtdB6y0QH7WUMOvS4Ml2pz5Ww1vTngHmTM=
X-Google-Smtp-Source: APBJJlEgZLDXLGeHihxnGCUofKR/JoUYQTX9WolJ0gTVafxsDHYm1R0HhGeKfrwF0S/taIa4N1WPLw==
X-Received: by 2002:a0c:9a92:0:b0:636:60c6:203d with SMTP id y18-20020a0c9a92000000b0063660c6203dmr12252322qvd.35.1689089291549;
        Tue, 11 Jul 2023 08:28:11 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:f593])
        by smtp.gmail.com with ESMTPSA id s4-20020a0ce304000000b00636b3519467sm1180685qvl.54.2023.07.11.08.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 08:28:11 -0700 (PDT)
Date:   Tue, 11 Jul 2023 11:28:10 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Efly Young <yangyifei03@kuaishou.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm:vmscan: fix inaccurate reclaim during proactive
 reclaim
Message-ID: <20230711152810.GA2627@cmpxchg.org>
References: <20230707103226.38496-1-yangyifei03@kuaishou.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707103226.38496-1-yangyifei03@kuaishou.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 06:32:26PM +0800, Efly Young wrote:
> With commit f53af4285d77 ("mm: vmscan: fix extreme overreclaim
> and swap floods"), proactive reclaim still seems inaccurate.
> 
> Our problematic scene also are almost anon pages. Request 1G
> by writing memory.reclaim will reclaim 1.7G or other values
> more than 1G by swapping.
> 
> This try to fix the inaccurate reclaim problem.

I can see how this happens. Direct and kswapd reclaim have much
smaller nr_to_reclaim targets, so it's less noticable when we loop a
few times. Proactive reclaim can come in with a rather large value.

What does the reproducer setup look like? Are you calling reclaim on a
higher level cgroup with several children? Or is the looping coming
from having multiple zones alone?

> Signed-off-by: Efly Young <yangyifei03@kuaishou.com>
> ---
>  mm/vmscan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 9c1c5e8b..2aea8d9 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -6208,7 +6208,7 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
>  	unsigned long nr_to_scan;
>  	enum lru_list lru;
>  	unsigned long nr_reclaimed = 0;
> -	unsigned long nr_to_reclaim = sc->nr_to_reclaim;
> +	unsigned long nr_to_reclaim = (sc->nr_to_reclaim - sc->nr_reclaimed);

This can underflow. shrink_list() eats SWAP_CLUSTER_MAX batches out of
lru_pages >> priority, and only checks reclaimed > to_reclaim
after. This will then disable the bailout mechanism entirely.

In general, I'm not sure this is the best spot to fix the problem:

- During reclaim/compaction, should_continue_reclaim() may decide that
  more reclaim is required before compaction can proceed. But the
  second cycle might not do anything now, since you remember the work
  done by the previous one.

- shrink_node_memcgs() might do the full batch against the first
  cgroup and not touch the second one anymore. This will result in
  super lopsided behavior when you target a tree of multiple groups.

There might be other spots that break, I haven't checked.

You could go through them one by one, of course. But the truth is,
larger reclaim targets are the rare exception. Trying to support them
at the risk of breaking all other reclaim users seems ill-advised.

A better approach might be to just say: "don't call reclaim with large
numbers". Have proactive reclaim code handle the batching into smaller
chunks:

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e8ca4bdcb03c..4b016806dcc7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6696,7 +6696,7 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 			lru_add_drain_all();
 
 		reclaimed = try_to_free_mem_cgroup_pages(memcg,
-						nr_to_reclaim - nr_reclaimed,
+						min(nr_to_reclaim - nr_reclaimed, SWAP_CLUSTER_MAX),
 						GFP_KERNEL, reclaim_options);
 
 		if (!reclaimed && !nr_retries--)
