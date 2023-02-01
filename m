Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDC5686CB0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 18:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjBART7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 12:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjBARTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 12:19:55 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43363303F2;
        Wed,  1 Feb 2023 09:19:54 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id lu11so16166326ejb.3;
        Wed, 01 Feb 2023 09:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i9+p9Bcm6YyaW1LZ9eaYctAF7uXc0lrq3SOegE0u2Qs=;
        b=RSlq5fUaB9+KvDOjVoOnR0jnyYtYl0GQ3BOcquQpUdMOHMCWN1oo9ryy5XqY+aBUjf
         W5NhPeaiemy5UsWK8AX3fFgwspul9TY+9Axz9qrRrrdU3LBwoUjRNj2zuwGGlZP2c/D8
         t07T1Y8dsyOG1Nmd7nSUfZDzIbGNDMFILcQYtAIy5utg/zeIYRw6n9e20aErZJpZzVD0
         V2mAs/BUmsUneeLvazdQtoGoP+ClovI+2aptjCzNhTQ60aOzHMxeQVqWOLmyiYCf3es0
         3MJpAT7qE+0zaF3F88CPCQNKz1XEB59g4pBhF7GyJ4rxwZRqFRhL3ZMNbGSFgD/WuHyS
         pMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9+p9Bcm6YyaW1LZ9eaYctAF7uXc0lrq3SOegE0u2Qs=;
        b=BN3DvpeCp82uoJbO2zeanenat1PjDXHY7Iy/fkwaXO+H7yp6LsF+5ZrnGHSiFyyeV8
         U5xKqgYdsgNVfKivq3nzZdojMh/wmVLCigUFAeksuYEmZd1RIEv2ZzSC6zpuG97eIrD0
         j9NDzaoJt2dub8z27PrYyMdtnIBiPU3KFmcRR/daYetDeJb1Eb44PmdNfqjhFPI6Eh/p
         Uv3JWKrA8/KY7ch13CUagvjGPSX1/GeCkL5RNNDrYnWUgJdv4dCzh0EZL45f7rFWlC4r
         PhffaLDwqvCf96UoOYDDiP2OBEtrTPmm7m6hIeZMwvHWqfdANMY7xr/r7Et56y78wLBj
         deeQ==
X-Gm-Message-State: AO0yUKWeeQnaQYCzTVUqjrWx453yzQB0y01v5uxpVlNggWT5lSedC2QY
        M8kkR+QUnPrv+QnpRfylU+I=
X-Google-Smtp-Source: AK7set/H9XGmOyLCS2ORbkrfZ4es9omjadD8XEMs2BwGebRujc8mkNylnRDyymc7latf127BOS8Yjg==
X-Received: by 2002:a17:907:1707:b0:884:3174:119d with SMTP id le7-20020a170907170700b008843174119dmr3285735ejc.14.1675271992617;
        Wed, 01 Feb 2023 09:19:52 -0800 (PST)
Received: from pc636 (host-78-79-169-126.mobileonline.telia.com. [78.79.169.126])
        by smtp.gmail.com with ESMTPSA id r22-20020a1709064d1600b00878803d4049sm9804309eju.93.2023.02.01.09.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 09:19:52 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 1 Feb 2023 18:19:49 +0100
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Julian Anastasov <ja@ssi.bg>,
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
Message-ID: <Y9qfNV0IX1tBsTxP@pc636>
References: <20230201150954.409693-1-urezki@gmail.com>
 <Y9qLB6Zyx5atcFUV@salvia>
 <7e87836a-c72-eefd-9c74-fc2637accd2@ssi.bg>
 <Y9qc+lgR1CgdszKs@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9qc+lgR1CgdszKs@salvia>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 06:10:18PM +0100, Pablo Neira Ayuso wrote:
> On Wed, Feb 01, 2023 at 06:12:04PM +0200, Julian Anastasov wrote:
> > 
> > 	Hello,
> > 
> > On Wed, 1 Feb 2023, Pablo Neira Ayuso wrote:
> > 
> > > Hi,
> > > 
> > > On Wed, Feb 01, 2023 at 04:09:51PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > The kfree_rcu()'s single argument name is deprecated therefore
> > > > rename it to kfree_rcu_mightsleep() variant. The goal is explicitly
> > > > underline that it is for sleepable contexts.
> > > > 
> > > > Cc: Julian Anastasov <ja@ssi.bg>
> > > > Cc: Pablo Neira Ayuso <pablo@netfilter.org>
> > > > Cc: Jiri Wiesner <jwiesner@suse.de>
> > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > ---
> > > >  net/netfilter/ipvs/ip_vs_est.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/net/netfilter/ipvs/ip_vs_est.c b/net/netfilter/ipvs/ip_vs_est.c
> > > > index ce2a1549b304..a39baf6d1367 100644
> > > > --- a/net/netfilter/ipvs/ip_vs_est.c
> > > > +++ b/net/netfilter/ipvs/ip_vs_est.c
> > > > @@ -549,7 +549,7 @@ void ip_vs_stop_estimator(struct netns_ipvs *ipvs, struct ip_vs_stats *stats)
> > > >  	__set_bit(row, kd->avail);
> > > >  	if (!kd->tick_len[row]) {
> > > >  		RCU_INIT_POINTER(kd->ticks[row], NULL);
> > > > -		kfree_rcu(td);
> > > 
> > > I also found this kfree_rcu() without rcu_head call a few weeks ago.
> > > 
> > > @Wiesner, @Julian: Any chance this can be turned into kfree_rcu(td, rcu_head); ?
> > 
> > 	Yes, as simple as this:
> > 
> > diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
> > index c6c61100d244..6d71a5ff52df 100644
> > --- a/include/net/ip_vs.h
> > +++ b/include/net/ip_vs.h
> > @@ -461,6 +461,7 @@ void ip_vs_stats_free(struct ip_vs_stats *stats);
> >  
> >  /* Multiple chains processed in same tick */
> >  struct ip_vs_est_tick_data {
> > +	struct rcu_head		rcu_head;
> >  	struct hlist_head	chains[IPVS_EST_TICK_CHAINS];
> >  	DECLARE_BITMAP(present, IPVS_EST_TICK_CHAINS);
> >  	DECLARE_BITMAP(full, IPVS_EST_TICK_CHAINS);
> > diff --git a/net/netfilter/ipvs/ip_vs_est.c b/net/netfilter/ipvs/ip_vs_est.c
> > index df56073bb282..25c7118d9348 100644
> > --- a/net/netfilter/ipvs/ip_vs_est.c
> > +++ b/net/netfilter/ipvs/ip_vs_est.c
> > @@ -549,7 +549,7 @@ void ip_vs_stop_estimator(struct netns_ipvs *ipvs, struct ip_vs_stats *stats)
> >  	__set_bit(row, kd->avail);
> >  	if (!kd->tick_len[row]) {
> >  		RCU_INIT_POINTER(kd->ticks[row], NULL);
> > -		kfree_rcu(td);
> > +		kfree_rcu(td, rcu_head);
> >  	}
> >  	kd->est_count--;
> >  	if (kd->est_count) {
> > 
> > 	I was about to reply to Uladzislau Rezki but his patchset
> > looks more like a renaming, so I'm not sure how we are about
> > to integrate this change, as separate patch or as part of his
> > patchset. I don't have preference, just let me know how to
> > handle it.
> 
> @Uladzislau Rezki: Are you fine with dropping this patch from your
> series and Julian will send us a patch for inclusion into net-next to
> use the kfree_rcu(x, rcu_head) variant?
Absolutely. So i will drop it from my series.

Thanks!

--
Uladzislau Rezki
