Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46AF679F4F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbjAXQ6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbjAXQ6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:58:31 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB0B45BC1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:58:28 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id s4so13594872qtx.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4qUiDe46C6VRX7ZHZU9nb0H49/VoZpIdfPJmqtDQGds=;
        b=dZLjr/KYxIvFemNW2IsflLazv16AGJ4Fictk81LIIBucOqK80TE4ZdQwUDTMCFirT2
         ti88u8/FV3ud464/GMC9gY2V1+hDnRTJci4xfZO5CQ1KSLNf16H5AnyGzk8x6aAF0blh
         Rml9MRKRq/eyzi2ZrtAij6Ws2ZcT+ojfBfy38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4qUiDe46C6VRX7ZHZU9nb0H49/VoZpIdfPJmqtDQGds=;
        b=RIDqADR3A/c+oAXOJTDOpzuDTN7cPF+o/T+W7Yk1rIN7ysGXz+IMN6Ck5TZJ8rEHqa
         xf4DLqNKPizJzs6yI5bKY3qID/Lea5WYQpQRn1Oh4P2IqmLdjokYAHjwthvEOZy8vIyX
         fADcm3aLSM3oZrC8LdoV6PgLwFQ1WxHxsgvogcM5nLDx0tvHewbnKImpVmeQMDQz8MIH
         c+EDLrlMVKjDUr2CWLnaoElKKkMrYV7E69cEvVr7UWaG/emG8SVhDqdNPbOJ9jTF35mo
         SCN7ZV12H+3+hq47YWvoEKiKFZqiM0NkjxQO57JRs1rSN996r+0xaoJCnbSpkYE1r8t5
         +AOQ==
X-Gm-Message-State: AFqh2kre/+0IZiusankixCWyHouNxFdNSUa18gQfMCARvA2blx5ZE6EZ
        i0tGW7ejLPSpsfQRQ+e58eSZmg==
X-Google-Smtp-Source: AMrXdXsG8yos8UdZcq3YT2hj5MtqT79VpjjiRIn2PzdIsXHIA3p0yrq7MaW0BO5X5trciymOBLcUVw==
X-Received: by 2002:ac8:44c6:0:b0:3b6:3272:960e with SMTP id b6-20020ac844c6000000b003b63272960emr42175379qto.54.1674579507583;
        Tue, 24 Jan 2023 08:58:27 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id x12-20020ac87ecc000000b0039cc0fbdb61sm1532332qtj.53.2023.01.24.08.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 08:58:26 -0800 (PST)
Date:   Tue, 24 Jan 2023 16:58:26 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, quic_neeraju@quicinc.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rcu: Remove impossible wakeup rcu GP kthread action
 from rcu_report_qs_rdp()
Message-ID: <Y9AOMhy4GCyaqxdG@google.com>
References: <Y861Xuoa+CrZt9PB@lothringen>
 <375EBA2F-F47A-4BC6-B4D4-2E96D5D15AB6@joelfernandes.org>
 <Y873895orjOvPNg9@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y873895orjOvPNg9@lothringen>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederic,

On Mon, Jan 23, 2023 at 10:11:15PM +0100, Frederic Weisbecker wrote:
> On Mon, Jan 23, 2023 at 03:54:07PM -0500, Joel Fernandes wrote:
> > > On Jan 23, 2023, at 11:27 AM, Frederic Weisbecker <frederic@kernel.org> wrote:
> > > 
> > > On Mon, Jan 23, 2023 at 10:22:19AM -0500, Joel Fernandes wrote:
> > >>> What am I missing?
> > >> 
> > >> That the acceleration is also done by __note_gp_changes() once the
> > >> grace period ends anyway, so if any acceleration was missed as you
> > >> say, it will be done anyway.
> > >> 
> > >> Also it is done by scheduler tick raising softirq:
> > >> 
> > >> rcu_pending() does this:
> > >>        /* Has RCU gone idle with this CPU needing another grace period? */
> > >>        if (!gp_in_progress && rcu_segcblist_is_enabled(&rdp->cblist) &&
> > >>            !rcu_rdp_is_offloaded(rdp) &&
> > >>            !rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
> > >>                return 1;
> > >> 
> > >> and rcu_core():
> > >>        /* No grace period and unregistered callbacks? */
> > >>        if (!rcu_gp_in_progress() &&
> > >>            rcu_segcblist_is_enabled(&rdp->cblist) && do_batch) {
> > >>                rcu_nocb_lock_irqsave(rdp, flags);
> > >>                if (!rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
> > >>                        rcu_accelerate_cbs_unlocked(rnp, rdp);
> > >>                rcu_nocb_unlock_irqrestore(rdp, flags);
> > >>        }
> > >> 
> > >> So, I am not sure if you need needacc at all. Those CBs that have not
> > >> been assigned grace period numbers will be taken care off :)
> > > 
> > > But that's only when there is no grace period pending, so it can't happen while
> > > we report a QS.
> > > 
> > > OTOH without the needacc, those callbacks waiting to be accelerated would be
> > > eventually processed but only on the next tick following the end of a grace
> > > period...if none has started since then. So if someone else starts a new GP
> > > before the current CPU, we must wait another GP, etc...
> > > 
> > > That's potentially dangerous.
> > 
> > Waiting for just one more GP cannot be dangerous IMO. Anyway there is no
> > guarantee that callback will run immediately at end of GP, there may be one or
> > more GPs before callback can run, if I remember correctly. That is by
> > design.. but please correct me if my understanding is different from yours.
> 
> It's not bound to just one GP. If you have N CPUs flooding callbacks for a
> long while, your CPU has 1/N chances to be the one starting the next GP on
> each turn. Relying on the acceleration to be performed only when no GP is
> running may theoretically starve your callbacks forever.

I tend to agree with you, however I was mostly referring to the "needac". The
theoretical case is even more theoretical because you have to be half way
through the transition _and_ flooding at the same time such that there is not
a chance for RCU to be idle for a long period of time (which we don't really
see in our systems per-se). But I agree, even if theoretical, maybe better to
handle it.

> > > And unfortunately we can't do the acceleration from __note_gp_changes()
> > > due to lock ordering restrictions: nocb_lock -> rnp_lock
> > > 

Yeah I was more going for the fact that if the offload to deoffload
transition completed before note_gp_changes() was called, which obviously we
cannot assume...

But yeah for the 'limbo between offload to not offload state', eventually RCU
goes idle, the scheduling clock interrupt (via rcu_pending()) will raise
softirq or note_gp_changes() will accelerate. Which does not help the
theoretical flooding case above, but still...

> > 
> > Ah. This part I am not sure. Appreciate if point me to any old archive
> > links or documentation detailing that, if possible… 
> 
> It's not documented but the code in nocb_gp_wait() or nocb_cb_wait() has
> that locking order for example.
> 
> Excerpt:
> 
> 	rcu_nocb_lock_irqsave(rdp, flags); if (rcu_segcblist_nextgp(cblist,
> 	&cur_gp_seq) && rcu_seq_done(&rnp->gp_seq, cur_gp_seq) &&
> 	raw_spin_trylock_rcu_node(rnp)) { /* irqs already disabled. */
> 	needwake_gp = rcu_advance_cbs(rdp->mynode, rdp);
> 	raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */ }
> 
> Thanks.

Ah I know what you mean now, in other words there is a chance of an ABBA
deadlock if we do not acquire the locks in the correct order. Thank you for
clarifying. Indeed rcutree_migrate_callbacks() also confirms it.

I guess to Frederic's point, another case other than the CB flooding, that can
starve CB accelerations is if the system is in the 'limbo between offload and
de-offload' state for a long period of time. In such a situation also, neither
note_gp_changes(), nor the scheduling-clock interrupt via softirq will help
accelerate CBs.

Whether such a limbo state is possible indefinitely, I am not sure...

Thanks a lot for the discussions and it is always a learning experience
talking about these...!

thanks,

 - Joel

