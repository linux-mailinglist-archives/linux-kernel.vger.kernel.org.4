Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0545260685F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJTSo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJTSoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:44:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2CA193;
        Thu, 20 Oct 2022 11:44:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C24DB828D7;
        Thu, 20 Oct 2022 18:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF639C433D6;
        Thu, 20 Oct 2022 18:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666291456;
        bh=r4tyae1m+QyJ9kVbJORW9phEHEfPme4l/8vXt6JH1NI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mB7qzo5gzLrUCyu3C22FWZQyjjJpVR5XYBEknGR3q4FBpIJSRztAEmpNZP+9QRDtT
         Y+rx4ohxyqwt8XkgxuOeuc+gqlJP/8m8zen/2NR6uxjVBbhwSSa4/IdllxgGEoxmG+
         JFl4Xq3GnfphKn8t0tro2+jaWnjaA5sBud/Sy/L0WGyFNficTIUunGn1kfU0I6YAYg
         5lFnBsuC35AFgzwHlJ0hI7WJYRwC+R7mtSHoHw8M9Xt6G+rdcSd7RnEw8dAaTBdnB2
         3g6UuQ5PuB4JquNhKG46GJINUSpikqGMzIpkW5X18N2PoT4zqI7zBAogjg6m1DtfZ2
         Zxs9AlgzfWU9w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 74DBA5C0624; Thu, 20 Oct 2022 11:44:16 -0700 (PDT)
Date:   Thu, 20 Oct 2022 11:44:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     zhaomzhao@126.com
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, edumazet@google.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Subject: Re: [PATCH v1] rcu: use hlist_nulls_next_rcu() in
 hlist_nulls_add_tail_rcu()
Message-ID: <20221020184416.GV5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221019123650.139210-1-zhaomzhao@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019123650.139210-1-zhaomzhao@126.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 08:36:50AM -0400, zhaomzhao@126.com wrote:
> From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> 
> In commit 8dbd76e79a16 ("tcp/dccp: fix possible race
> __inet_lookup_established()"), function hlist_nulls_add_tail_rcu() was
> added back, but the local variable *last* is of type hlist_nulls_node,
> so use hlist_nulls_next_rcu() instead of hlist_next_rcu().
> 
> Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

Good eyes!

I have queued this for testing and further review.

							Thanx, Paul

> ---
>  include/linux/rculist_nulls.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
> index d8afdb8784c1..ba4c00dd8005 100644
> --- a/include/linux/rculist_nulls.h
> +++ b/include/linux/rculist_nulls.h
> @@ -139,7 +139,7 @@ static inline void hlist_nulls_add_tail_rcu(struct hlist_nulls_node *n,
>  	if (last) {
>  		n->next = last->next;
>  		n->pprev = &last->next;
> -		rcu_assign_pointer(hlist_next_rcu(last), n);
> +		rcu_assign_pointer(hlist_nulls_next_rcu(last), n);
>  	} else {
>  		hlist_nulls_add_head_rcu(n, h);
>  	}
> -- 
> 2.37.1
> 
