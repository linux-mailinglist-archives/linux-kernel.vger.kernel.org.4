Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C47E6B17B0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 01:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjCIAL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 19:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjCIALJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 19:11:09 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7803364B34
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 16:11:04 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id s12so292412qtq.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 16:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678320663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HOmxk433msYqPPBse0G4aA6KHYmyHO935bjszckxJUs=;
        b=uMTx3o9lHbtEp2eOLVPn8l5GsCkwb2KUF6UKpwDtj3+fej5r0zHzccnQ049t6RiUkW
         +HeasOBXXc3F1JliXrEicJytWxkwTGYhXFOFfPICNW2vtaML2JL9lk3P9QwzKeHWip7E
         x+qhTb1Krt3gabx3Ykxyqbr/tGZmSxl8Wv0+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678320663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOmxk433msYqPPBse0G4aA6KHYmyHO935bjszckxJUs=;
        b=0jIQMblCEjgAdedOgF+y9wagq/TXgWWPR7Ym096wewqSn7LqJG4jUWfpA7yfmLnqS2
         tP9zgL9GYV7QW7YFmoeAQCDVtuOMJZOlKBz6Jeb4nfAT3zZKdgBZ27sFSMoG/Mch0YE8
         gUic0yGyBY4BrzuSM7sNoHfqmx1csLGVySrocjygn4u9sgt7Bv85CN7PBbX2QzgK2A5w
         w5C0vIRcJiomLvabfLX19AcawKl0279MjL2agSszOLWh5hMnjdV/B9k0Yd7XeR+f81bl
         Bh3qm+QvteTtooUYaepivQ/loYB1e5jJIxF2xUymTJn2Q8pmLlS5i4Nsaor03m500SbG
         S66g==
X-Gm-Message-State: AO0yUKVcQ4I2+Cn8P25t/jStXP4Gh0dvPPl9HSyWpioheGnR6N31KG0j
        /CIXyKs2Qgw5OfX0D1pRhy61bQ==
X-Google-Smtp-Source: AK7set+RoB8nMsYTl+zudplTIeld0VTB6VQ+2dEdxFlVs9tsRKxRY/mNhUuTPT8nIqRex3STgacSwA==
X-Received: by 2002:a05:622a:104c:b0:3bf:d8e2:ab0e with SMTP id f12-20020a05622a104c00b003bfd8e2ab0emr898723qte.23.1678320663514;
        Wed, 08 Mar 2023 16:11:03 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id f19-20020ac84713000000b003bfbf16ad08sm12414661qtp.74.2023.03.08.16.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 16:11:02 -0800 (PST)
Date:   Thu, 9 Mar 2023 00:11:01 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Julian Anastasov <ja@ssi.bg>,
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
Message-ID: <20230309001101.GA155598@google.com>
References: <20230201150954.409693-1-urezki@gmail.com>
 <Y9qLB6Zyx5atcFUV@salvia>
 <7e87836a-c72-eefd-9c74-fc2637accd2@ssi.bg>
 <Y9qc+lgR1CgdszKs@salvia>
 <Y9qfNV0IX1tBsTxP@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9qfNV0IX1tBsTxP@pc636>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Feb 01, 2023 at 06:19:49PM +0100, Uladzislau Rezki wrote:
> On Wed, Feb 01, 2023 at 06:10:18PM +0100, Pablo Neira Ayuso wrote:
> > On Wed, Feb 01, 2023 at 06:12:04PM +0200, Julian Anastasov wrote:
> > > 
> > > 	Hello,
> > > 
> > > On Wed, 1 Feb 2023, Pablo Neira Ayuso wrote:
> > > 
> > > > Hi,
> > > > 
> > > > On Wed, Feb 01, 2023 at 04:09:51PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > > The kfree_rcu()'s single argument name is deprecated therefore
> > > > > rename it to kfree_rcu_mightsleep() variant. The goal is explicitly
> > > > > underline that it is for sleepable contexts.
> > > > > 
> > > > > Cc: Julian Anastasov <ja@ssi.bg>
> > > > > Cc: Pablo Neira Ayuso <pablo@netfilter.org>
> > > > > Cc: Jiri Wiesner <jwiesner@suse.de>
> > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > ---
> > > > >  net/netfilter/ipvs/ip_vs_est.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/net/netfilter/ipvs/ip_vs_est.c b/net/netfilter/ipvs/ip_vs_est.c
> > > > > index ce2a1549b304..a39baf6d1367 100644
> > > > > --- a/net/netfilter/ipvs/ip_vs_est.c
> > > > > +++ b/net/netfilter/ipvs/ip_vs_est.c
> > > > > @@ -549,7 +549,7 @@ void ip_vs_stop_estimator(struct netns_ipvs *ipvs, struct ip_vs_stats *stats)
> > > > >  	__set_bit(row, kd->avail);
> > > > >  	if (!kd->tick_len[row]) {
> > > > >  		RCU_INIT_POINTER(kd->ticks[row], NULL);
> > > > > -		kfree_rcu(td);
> > > > 
> > > > I also found this kfree_rcu() without rcu_head call a few weeks ago.
> > > > 
> > > > @Wiesner, @Julian: Any chance this can be turned into kfree_rcu(td, rcu_head); ?
> > > 
> > > 	Yes, as simple as this:
> > > 
> > > diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
> > > index c6c61100d244..6d71a5ff52df 100644
> > > --- a/include/net/ip_vs.h
> > > +++ b/include/net/ip_vs.h
> > > @@ -461,6 +461,7 @@ void ip_vs_stats_free(struct ip_vs_stats *stats);
> > >  
> > >  /* Multiple chains processed in same tick */
> > >  struct ip_vs_est_tick_data {
> > > +	struct rcu_head		rcu_head;
> > >  	struct hlist_head	chains[IPVS_EST_TICK_CHAINS];
> > >  	DECLARE_BITMAP(present, IPVS_EST_TICK_CHAINS);
> > >  	DECLARE_BITMAP(full, IPVS_EST_TICK_CHAINS);
> > > diff --git a/net/netfilter/ipvs/ip_vs_est.c b/net/netfilter/ipvs/ip_vs_est.c
> > > index df56073bb282..25c7118d9348 100644
> > > --- a/net/netfilter/ipvs/ip_vs_est.c
> > > +++ b/net/netfilter/ipvs/ip_vs_est.c
> > > @@ -549,7 +549,7 @@ void ip_vs_stop_estimator(struct netns_ipvs *ipvs, struct ip_vs_stats *stats)
> > >  	__set_bit(row, kd->avail);
> > >  	if (!kd->tick_len[row]) {
> > >  		RCU_INIT_POINTER(kd->ticks[row], NULL);
> > > -		kfree_rcu(td);
> > > +		kfree_rcu(td, rcu_head);
> > >  	}
> > >  	kd->est_count--;
> > >  	if (kd->est_count) {
> > > 
> > > 	I was about to reply to Uladzislau Rezki but his patchset
> > > looks more like a renaming, so I'm not sure how we are about
> > > to integrate this change, as separate patch or as part of his
> > > patchset. I don't have preference, just let me know how to
> > > handle it.
> > 
> > @Uladzislau Rezki: Are you fine with dropping this patch from your
> > series and Julian will send us a patch for inclusion into net-next to
> > use the kfree_rcu(x, rcu_head) variant?
> Absolutely. So i will drop it from my series.
> 

Since this patch was dropped, it is the only case blocking the proper
integration of this series into linux-next. We want to drop the old API and
currently we are not able to, thus this revert [1] has to be unfortunately
carried in linux-next.

For that reason, there are 2 options:

1. Can we get the new rcu_head approach for ipvs posted and reviewed with
suitable Acks?

2. Can we carry Vlad's patch to use kfree_rcu_mightsleep() in ipvs and drop
it later if/when #1 is completed?

Option 2 has the unfortunate effect that it will conflict with your new
approach of using rcu_head so I'd rather you fix it that way and get it
Acked. And once acked, we can also take it via the RCU tree if the net
maintainers are Ok with that.

Please advise.

thanks,

 - Joel

[1] https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?h=dev&id=3898e7642316732e23716ca902f9d122736f9805

