Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5976E824A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 22:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjDSUDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 16:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjDSUDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 16:03:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF6B46B7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 13:03:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E13763887
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 20:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF2BC433EF;
        Wed, 19 Apr 2023 20:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681934592;
        bh=Jfd6Xw8NQMQFh3SvgGvyWz47eLEspURjqLTeUCEqvR4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vRCaoOzyYQozupKl9cnrLB0UfnuK3KJXN7MCcTdViQpst9lNJ52INEF5T6j0m8XDx
         2AFs2oGpOrpZFyFkaS25uhRF7U25nPk1KZcYLOOMlhhLEKclcsbOdsH+dZIzFMJS6e
         9yvdiL6SPO0eW4jzmKhJI+mXR0hGM4lCI6uqgJdU=
Date:   Wed, 19 Apr 2023 13:03:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev,
        shakeelb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, vmpressure: remove redundant check in vmpressure()
Message-Id: <20230419130311.587b7273eca2512c07b32bd0@linux-foundation.org>
In-Reply-To: <20230419092007.186938-1-haifeng.xu@shopee.com>
References: <20230419092007.186938-1-haifeng.xu@shopee.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2023 09:20:07 +0000 Haifeng Xu <haifeng.xu@shopee.com> wrote:

> There are three places, vmpressure_prio(), shrink_node_memcgs() and
> shrink_node(), which invoke vmpressure(). But only shrink_node_memcgs()
> sets tree to false and the memcg used in it is not NULL, so we don't
> check it again in vmpressure().
> 
> ...
>
> --- a/mm/vmpressure.c
> +++ b/mm/vmpressure.c
> @@ -284,7 +284,7 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
>  		enum vmpressure_levels level;
>  
>  		/* For now, no users for root-level efficiency */
> -		if (!memcg || mem_cgroup_is_root(memcg))
> +		if (mem_cgroup_is_root(memcg))
>  			return;
>  
>  		spin_lock(&vmpr->sr_lock);

try_to_free_pages()->
  do_try_to_free_pages()->
    vmpressure_prio()-> 
      vmpressure()->
        crash

what am I missing here?


It does appear that vmpressure() could be simplified with

	if (!memcg)
		memcg = root_mem_cgroup;

so the test you identified goes away and the memcg_to_vmpressure() call
becomes simpler.  But that's such a small change it doesn't seem worth
the effort.
