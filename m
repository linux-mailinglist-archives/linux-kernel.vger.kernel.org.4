Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4F96ED487
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjDXSgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjDXSew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:34:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665627293
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:34:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC8A46217D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 18:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B70C433A4;
        Mon, 24 Apr 2023 18:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682361283;
        bh=99mOoNg+t9iTEXLOHU2nKk4og2VJ/8Tifky4E0nqxWw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=h1dSPeSL7ErLqQk+j1JK2wZ3w6G4hF5C8ygUMbLsIv+UAVBen6p/Y0aQ2GarpA7mQ
         b7EdpdHrfzn607N5xgRC3QlqolSg96iJQ12Y0KVxL0NixdHtOmoTcEidKvkx7MGOy9
         dSi+tkvLGKCBUx/InNgeAod8EJSgTVEmcpH8GfqSxkwYxH4IlH/iGSew+MY+fMcu/w
         ivhMgjxcZzd1qyJC15gGp/qatNBOFlU3Tu3ybY+zpr8d6/gFwI/lsn5o0/5LrlM99t
         C/lR9/3Pd4xqRaC7zQh2s0Nw1io9AwDYCrwfQjcQi5ynGZ3O1VnnjiRThEi9qFedRu
         YxaJE+2fp6/yw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C67F115404E7; Mon, 24 Apr 2023 11:34:42 -0700 (PDT)
Date:   Mon, 24 Apr 2023 11:34:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, willy@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] mm/slab: break up RCU readers on
 SLAB_TYPESAFE_BY_RCU example code
Message-ID: <d3c609f6-4d0e-4953-8873-697ee3af13cc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230417190450.1682-1-sj@kernel.org>
 <20230417190450.1682-3-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417190450.1682-3-sj@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 07:04:50PM +0000, SeongJae Park wrote:
> The SLAB_TYPESAFE_BY_RCU example code snippet uses a single RCU
> read-side critical section for retries.
> 'Documentation/RCU/rculist_nulls.rst' has similar example code snippet,
> and commit da82af04352b ("doc: Update and wordsmith rculist_nulls.rst")
> broke it up.  Apply the change to SLAB_TYPESAFE_BY_RCU example code
> snippet, too.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  include/linux/slab.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index b18e56c6f06c..6acf1b7c6551 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -53,16 +53,18 @@
>   * stays valid, the trick to using this is relying on an independent
>   * object validation pass. Something like:
>   *
> + * begin:
>   *  rcu_read_lock();
> - * again:
>   *  obj = lockless_lookup(key);
>   *  if (obj) {
>   *    if (!try_get_ref(obj)) // might fail for free objects
> - *      goto again;
> + *      rcu_read_unlock();
> + *      goto begin;
>   *
>   *    if (obj->key != key) { // not the object we expected
>   *      put_ref(obj);
> - *      goto again;
> + *      rcu_read_unlock();
> + *      goto begin;
>   *    }
>   *  }
>   *  rcu_read_unlock();
> -- 
> 2.25.1
> 
