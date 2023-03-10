Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956C56B3380
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 02:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjCJBIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 20:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCJBIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 20:08:32 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB3A7D575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 17:08:31 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id r5so4229128qtp.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 17:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678410510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UokTDAQn7q1obW3NWHDp8O1nKfc0rpJyGGobFx0lY6o=;
        b=AFuy3V+dW135wdLQvl9/LwGgMzJeucpm5kFAghEhvP68Vp94KirvGilj4Nr6OGYE03
         ZCUlGhLFeCPV3cThc3ejh4S+0ngKiyGmMcM9CJ1C/yIRCqVDmsLTgGEkQyMplp9vOyfk
         8zQ/K0Rw2DOabJ5y50H/0HeDBtThSPxTDoiL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678410510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UokTDAQn7q1obW3NWHDp8O1nKfc0rpJyGGobFx0lY6o=;
        b=pZZwNPN06mcukzioY9Vxbgg00XPiDq+mFCxQkstknv/PyYPLamCuvTqbaH/BTVYm2e
         mBp/5TVbqzDwjJhhrsycRY2U2HuqNvjvukkIueElahiPRlX3VJ81mf4SMKlnPTZM8OOH
         0o3uTpnzYrjngFDx55ol6Q4lS+hEqxt/4hjwfnW2RNYWE5TusU6gmysxRpMAjJoZ43yp
         CDVRSjgl39+VqejgtX/VtU3BJmv6o6qgeN2USITm3ytiLuP1JeZR/0RDkQLbzL7JeEq7
         UnO3WfAvwDtXoMm2x075owwH8je1TgO8U5srr3D3tE1LDRdxMaEdbus5U6RTqwHE2+Tq
         k2DQ==
X-Gm-Message-State: AO0yUKUvA+JA97lSLh3KPt5feOGF52StGDxSetimyk9Jqs39WYZzLDs2
        zVoH8oAC50aWkYsb9opElq1Zgg==
X-Google-Smtp-Source: AK7set80WO4khewW3Wd6Q+Vozjr+sXkPlub6kbcMazLjmw+NFebExQZI8lk3QDLhbcQYfCmbN4V9zw==
X-Received: by 2002:ac8:5b56:0:b0:3bf:dbd3:a014 with SMTP id n22-20020ac85b56000000b003bfdbd3a014mr35729700qtw.45.1678410510171;
        Thu, 09 Mar 2023 17:08:30 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id t134-20020a37468c000000b007422eee8058sm306238qka.125.2023.03.09.17.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 17:08:29 -0800 (PST)
Date:   Fri, 10 Mar 2023 01:08:28 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, Julian Anastasov <ja@ssi.bg>,
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
Message-ID: <20230310010828.GA586277@google.com>
References: <20230201150954.409693-1-urezki@gmail.com>
 <Y9qLB6Zyx5atcFUV@salvia>
 <7e87836a-c72-eefd-9c74-fc2637accd2@ssi.bg>
 <Y9qc+lgR1CgdszKs@salvia>
 <Y9qfNV0IX1tBsTxP@pc636>
 <20230309001101.GA155598@google.com>
 <ZAmkrxguzzsqNFM+@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAmkrxguzzsqNFM+@salvia>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 10:19:43AM +0100, Pablo Neira Ayuso wrote:
> On Thu, Mar 09, 2023 at 12:11:01AM +0000, Joel Fernandes wrote:
> > Hello,
> > 
> > On Wed, Feb 01, 2023 at 06:19:49PM +0100, Uladzislau Rezki wrote:
> > > On Wed, Feb 01, 2023 at 06:10:18PM +0100, Pablo Neira Ayuso wrote:
> > > > On Wed, Feb 01, 2023 at 06:12:04PM +0200, Julian Anastasov wrote:
> > > > > 
> > > > > 	Hello,
> > > > > 
> > > > > On Wed, 1 Feb 2023, Pablo Neira Ayuso wrote:
> > > > > 
> > > > > > Hi,
> > > > > > 
> > > > > > On Wed, Feb 01, 2023 at 04:09:51PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > > > > The kfree_rcu()'s single argument name is deprecated therefore
> > > > > > > rename it to kfree_rcu_mightsleep() variant. The goal is explicitly
> > > > > > > underline that it is for sleepable contexts.
> > > > > > > 
> > > > > > > Cc: Julian Anastasov <ja@ssi.bg>
> > > > > > > Cc: Pablo Neira Ayuso <pablo@netfilter.org>
> > > > > > > Cc: Jiri Wiesner <jwiesner@suse.de>
> > > > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > > > ---
> > > > > > >  net/netfilter/ipvs/ip_vs_est.c | 2 +-
> > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > 
> > > > > > > diff --git a/net/netfilter/ipvs/ip_vs_est.c b/net/netfilter/ipvs/ip_vs_est.c
> > > > > > > index ce2a1549b304..a39baf6d1367 100644
> > > > > > > --- a/net/netfilter/ipvs/ip_vs_est.c
> > > > > > > +++ b/net/netfilter/ipvs/ip_vs_est.c
> > > > > > > @@ -549,7 +549,7 @@ void ip_vs_stop_estimator(struct netns_ipvs *ipvs, struct ip_vs_stats *stats)
> > > > > > >  	__set_bit(row, kd->avail);
> > > > > > >  	if (!kd->tick_len[row]) {
> > > > > > >  		RCU_INIT_POINTER(kd->ticks[row], NULL);
> > > > > > > -		kfree_rcu(td);
> > > > > > 
> > > > > > I also found this kfree_rcu() without rcu_head call a few weeks ago.
> > > > > > 
> > > > > > @Wiesner, @Julian: Any chance this can be turned into kfree_rcu(td, rcu_head); ?
> > > > > 
> > > > > 	Yes, as simple as this:
> > > > > 
> > > > > diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
> > > > > index c6c61100d244..6d71a5ff52df 100644
> > > > > --- a/include/net/ip_vs.h
> > > > > +++ b/include/net/ip_vs.h
> > > > > @@ -461,6 +461,7 @@ void ip_vs_stats_free(struct ip_vs_stats *stats);
> > > > >  
> > > > >  /* Multiple chains processed in same tick */
> > > > >  struct ip_vs_est_tick_data {
> > > > > +	struct rcu_head		rcu_head;
> > > > >  	struct hlist_head	chains[IPVS_EST_TICK_CHAINS];
> > > > >  	DECLARE_BITMAP(present, IPVS_EST_TICK_CHAINS);
> > > > >  	DECLARE_BITMAP(full, IPVS_EST_TICK_CHAINS);
> > > > > diff --git a/net/netfilter/ipvs/ip_vs_est.c b/net/netfilter/ipvs/ip_vs_est.c
> > > > > index df56073bb282..25c7118d9348 100644
> > > > > --- a/net/netfilter/ipvs/ip_vs_est.c
> > > > > +++ b/net/netfilter/ipvs/ip_vs_est.c
> > > > > @@ -549,7 +549,7 @@ void ip_vs_stop_estimator(struct netns_ipvs *ipvs, struct ip_vs_stats *stats)
> > > > >  	__set_bit(row, kd->avail);
> > > > >  	if (!kd->tick_len[row]) {
> > > > >  		RCU_INIT_POINTER(kd->ticks[row], NULL);
> > > > > -		kfree_rcu(td);
> > > > > +		kfree_rcu(td, rcu_head);
> > > > >  	}
> > > > >  	kd->est_count--;
> > > > >  	if (kd->est_count) {
> > > > > 
> > > > > 	I was about to reply to Uladzislau Rezki but his patchset
> > > > > looks more like a renaming, so I'm not sure how we are about
> > > > > to integrate this change, as separate patch or as part of his
> > > > > patchset. I don't have preference, just let me know how to
> > > > > handle it.
> > > > 
> > > > @Uladzislau Rezki: Are you fine with dropping this patch from your
> > > > series and Julian will send us a patch for inclusion into net-next to
> > > > use the kfree_rcu(x, rcu_head) variant?
> > > Absolutely. So i will drop it from my series.
> > 
> > Since this patch was dropped, it is the only case blocking the proper
> > integration of this series into linux-next. We want to drop the old API and
> > currently we are not able to, thus this revert [1] has to be unfortunately
> > carried in linux-next.
> >
> > For that reason, there are 2 options:
> > 
> > 1. Can we get the new rcu_head approach for ipvs posted and reviewed with
> > suitable Acks?
> > 
> > 2. Can we carry Vlad's patch to use kfree_rcu_mightsleep() in ipvs and drop
> > it later if/when #1 is completed?
> > 
> > Option 2 has the unfortunate effect that it will conflict with your new
> > approach of using rcu_head so I'd rather you fix it that way and get it
> > Acked. And once acked, we can also take it via the RCU tree if the net
> > maintainers are Ok with that.
> > 
> > Please advise.
> 
> JFYI, this patch is already in linux.git
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e4d0fe71f59dc5137a2793ff7560730d80d1e1f4

Indeed it is in, thank you!

 - Joel

