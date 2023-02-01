Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C600686C20
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjBAQwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjBAQwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:52:12 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D52677A3;
        Wed,  1 Feb 2023 08:52:07 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id f7so11105345edw.5;
        Wed, 01 Feb 2023 08:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/WfkJK1m4uMcYazdq9Xzjjoa4w46FK18lwbBMkuuqyk=;
        b=KO8P3ldzNOgJXkygyVUbD37TO7GjteZYnODMUz+IUTiYRU/hwmNf4VrJ7QGLReogbU
         zm4WVsfGlHBMt2d3fMkQITMS+slphHX8l80TnBol8fRAhPWMn7Lan7TXf0SvcBEjOKHL
         o/JXfltNBUmE0w/lODjD/zFQXFgmJPq4lO1FsGhvQ5J0Y0Jyze72birAO4ftVhgovynf
         cZW0o42q2XLFS51kiR5CqWLh4ZWc0VKd/5EYU6Ec/hvCqjyTTQjTlvzSVa2pXunIQwvh
         B+SVPhOTqhau97qbY3yd+fXu0kzG283kM9XRiHaQZF7E20Zae+Pp1st1SjJWhH9riEV2
         1+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WfkJK1m4uMcYazdq9Xzjjoa4w46FK18lwbBMkuuqyk=;
        b=zcww1t2lJ2GbeiVWa2AIbx7ziGGixDKodZw51R+sOCzuDrXNIZvi/m8SOMxq8bI50d
         PPpC4EZHapUZ1mrBcTK+dBpZewaD2rKi8GfGkH9orMsheHvv3hjef4mEa6tL0qgLFM5N
         9zt8YU1pvC8FRnJMzs/J7MU026mJM20T6DLayY6X45KRMz65iX+wva1Vs4JbvAsBcbI7
         8UGWMEKFgiooJmn4l9iNGkK3EnuEh9fmxzM3vxCT3MmJPA5U65sJAefRwSvGi72pu20s
         KDxJgLtq2iBcInXvb+EIEXWcXz3lTvPVKhaPcd54rR715xVWAwL1kpvGdX8BmzT/s/W/
         7uQQ==
X-Gm-Message-State: AO0yUKVcbyHBVqIU/MJQb50vKkK7v5BaZZPl8PiSwgqvgl8E0uSN5s0d
        OCd4Uw+jBe6UAYnkryrtVFU=
X-Google-Smtp-Source: AK7set8lps1GUVXwzeD8oYwd5gb5p6Ce2ecb5MWRyPPhaxSb9by6FbnjnxCOiif9l7YrqRNvUF0L4Q==
X-Received: by 2002:a50:9304:0:b0:4a2:7489:a70a with SMTP id m4-20020a509304000000b004a27489a70amr3113695eda.22.1675270326062;
        Wed, 01 Feb 2023 08:52:06 -0800 (PST)
Received: from pc636 (host-78-79-169-126.mobileonline.telia.com. [78.79.169.126])
        by smtp.gmail.com with ESMTPSA id b17-20020aa7df91000000b0049b5c746df7sm10127186edy.0.2023.02.01.08.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 08:52:05 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 1 Feb 2023 17:52:02 +0100
To:     Julian Anastasov <ja@ssi.bg>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Jiri Wiesner <jwiesner@suse.de>
Subject: Re: [PATCH 10/13] ipvs: Rename kfree_rcu() to kfree_rcu_mightsleep()
Message-ID: <Y9qYsi5x7nxtSsx/@pc636>
References: <20230201150954.409693-1-urezki@gmail.com>
 <Y9qLB6Zyx5atcFUV@salvia>
 <7e87836a-c72-eefd-9c74-fc2637accd2@ssi.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e87836a-c72-eefd-9c74-fc2637accd2@ssi.bg>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 06:12:04PM +0200, Julian Anastasov wrote:
> 
> 	Hello,
> 
> On Wed, 1 Feb 2023, Pablo Neira Ayuso wrote:
> 
> > Hi,
> > 
> > On Wed, Feb 01, 2023 at 04:09:51PM +0100, Uladzislau Rezki (Sony) wrote:
> > > The kfree_rcu()'s single argument name is deprecated therefore
> > > rename it to kfree_rcu_mightsleep() variant. The goal is explicitly
> > > underline that it is for sleepable contexts.
> > > 
> > > Cc: Julian Anastasov <ja@ssi.bg>
> > > Cc: Pablo Neira Ayuso <pablo@netfilter.org>
> > > Cc: Jiri Wiesner <jwiesner@suse.de>
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > ---
> > >  net/netfilter/ipvs/ip_vs_est.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/net/netfilter/ipvs/ip_vs_est.c b/net/netfilter/ipvs/ip_vs_est.c
> > > index ce2a1549b304..a39baf6d1367 100644
> > > --- a/net/netfilter/ipvs/ip_vs_est.c
> > > +++ b/net/netfilter/ipvs/ip_vs_est.c
> > > @@ -549,7 +549,7 @@ void ip_vs_stop_estimator(struct netns_ipvs *ipvs, struct ip_vs_stats *stats)
> > >  	__set_bit(row, kd->avail);
> > >  	if (!kd->tick_len[row]) {
> > >  		RCU_INIT_POINTER(kd->ticks[row], NULL);
> > > -		kfree_rcu(td);
> > 
> > I also found this kfree_rcu() without rcu_head call a few weeks ago.
> > 
> > @Wiesner, @Julian: Any chance this can be turned into kfree_rcu(td, rcu_head); ?
> 
> 	Yes, as simple as this:
> 
> diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
> index c6c61100d244..6d71a5ff52df 100644
> --- a/include/net/ip_vs.h
> +++ b/include/net/ip_vs.h
> @@ -461,6 +461,7 @@ void ip_vs_stats_free(struct ip_vs_stats *stats);
>  
>  /* Multiple chains processed in same tick */
>  struct ip_vs_est_tick_data {
> +	struct rcu_head		rcu_head;
>  	struct hlist_head	chains[IPVS_EST_TICK_CHAINS];
>  	DECLARE_BITMAP(present, IPVS_EST_TICK_CHAINS);
>  	DECLARE_BITMAP(full, IPVS_EST_TICK_CHAINS);
> diff --git a/net/netfilter/ipvs/ip_vs_est.c b/net/netfilter/ipvs/ip_vs_est.c
> index df56073bb282..25c7118d9348 100644
> --- a/net/netfilter/ipvs/ip_vs_est.c
> +++ b/net/netfilter/ipvs/ip_vs_est.c
> @@ -549,7 +549,7 @@ void ip_vs_stop_estimator(struct netns_ipvs *ipvs, struct ip_vs_stats *stats)
>  	__set_bit(row, kd->avail);
>  	if (!kd->tick_len[row]) {
>  		RCU_INIT_POINTER(kd->ticks[row], NULL);
> -		kfree_rcu(td);
> +		kfree_rcu(td, rcu_head);
>  	}
>  	kd->est_count--;
>  	if (kd->est_count) {
> 
> 	I was about to reply to Uladzislau Rezki but his patchset
> looks more like a renaming, so I'm not sure how we are about
> to integrate this change, as separate patch or as part of his
> patchset. I don't have preference, just let me know how to
> handle it.
> 
If you give on this patch an Ack i will resend it once i collect
all other ACKs. So it will be integrated via RCU-tree.

So this is just renaming.

If the ip_vs_stop_estimator() can be invoked from an atomic context
then it is a bug and you need to integrate rcu_head in your structure.

--
Uladzislau Rezki
