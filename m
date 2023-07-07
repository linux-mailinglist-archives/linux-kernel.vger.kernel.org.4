Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF1774B6EA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 21:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjGGTJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 15:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjGGTJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 15:09:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39AE2107
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 12:09:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 792BA61A3E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 19:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13E0C433C7;
        Fri,  7 Jul 2023 19:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1688756972;
        bh=bsWOwWbAgPkBn7wNRZCfCwO7B5F2fdglS9wNNhs6Ktc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=huiLJISGDK/hYqE/5V6ivNupwqho4dWwXwAxA4slsqQghRydE5umU/1VEXpS+hnZp
         kKkKcWIoD9DesPxWBno1uPce5ZjpSWgMl7AgxENL0G2HcM6kCy7J8FiKUs1tCwurqB
         3xEBo1GUeY/gqR3rA8aaVSAZopgleBUSXs+fGs14=
Date:   Fri, 7 Jul 2023 12:09:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Efly Young <yangyifei03@kuaishou.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm:vmscan: fix inaccurate reclaim during proactive
 reclaim
Message-Id: <20230707120931.f2ec7f5c53c5dd2788afda11@linux-foundation.org>
In-Reply-To: <20230707103226.38496-1-yangyifei03@kuaishou.com>
References: <20230707103226.38496-1-yangyifei03@kuaishou.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(cc hannes)

On Fri, 7 Jul 2023 18:32:26 +0800 Efly Young <yangyifei03@kuaishou.com> wrote:

> With commit f53af4285d77 ("mm: vmscan: fix extreme overreclaim
> and swap floods"), proactive reclaim still seems inaccurate.
> 
> Our problematic scene also are almost anon pages. Request 1G
> by writing memory.reclaim will reclaim 1.7G or other values
> more than 1G by swapping.
> 
> This try to fix the inaccurate reclaim problem.

It would be helpful to have some additional explanation of why you
believe the current code is incorrect?

> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -6208,7 +6208,7 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
>  	unsigned long nr_to_scan;
>  	enum lru_list lru;
>  	unsigned long nr_reclaimed = 0;
> -	unsigned long nr_to_reclaim = sc->nr_to_reclaim;
> +	unsigned long nr_to_reclaim = (sc->nr_to_reclaim - sc->nr_reclaimed);
>  	bool proportional_reclaim;
>  	struct blk_plug plug;
>  

