Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A5868178F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 18:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbjA3R1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 12:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjA3R1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 12:27:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4303F286;
        Mon, 30 Jan 2023 09:27:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AAF161207;
        Mon, 30 Jan 2023 17:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF09BC433D2;
        Mon, 30 Jan 2023 17:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675099651;
        bh=quYfkLUImPhhTtzramxIW7HgG0blpWTUEF/+VmpVN/k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WqN/qBtk3iywU2wOP7/cN+HJQCcXmq0JtCKoY9t8D4gYEYKoPbZV9Zfh83nV3Q6Qn
         EPTGv+M5hzGUJqivB7DlV8jTbvcNKN1h/0xW1rulITY1+E5MEMJY6eab4HmDD/Uc8O
         P3kMrQEUzVr9h9J9YeQFAAopuPSRMXz8ZcgExYL/+MZ1Fj5hPb6eod4FTm7t4xRg3M
         slNx6ReYUm8lV489LQHgJlEMeEKrCcW9nV2wr0AdEn2T30nPnirWR4hFhfrYhSWbLF
         4+v6LDuv+8vZlcie1GCC5lPHBPF73lKEwej11/5pJAUO3VqaLSgJ6uAoWibYFdMWmq
         mVQK9dEgOtQLQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5031B5C084D; Mon, 30 Jan 2023 09:27:31 -0800 (PST)
Date:   Mon, 30 Jan 2023 09:27:31 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Zqiang <qiang1.zhang@intel.com>, frederic@kernel.org,
        quic_neeraju@quicinc.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Register rcu-lazy shrinker only CONFIG_RCU_LAZY is
 enabled
Message-ID: <20230130172731.GT2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230130071737.2806534-1-qiang1.zhang@intel.com>
 <CAEXW_YRUV_P7oEbtkRdKyRGcrWjkr9331SD4ymw_7q-54Ggx7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YRUV_P7oEbtkRdKyRGcrWjkr9331SD4ymw_7q-54Ggx7A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 10:00:42AM -0500, Joel Fernandes wrote:
> On Mon, Jan 30, 2023 at 2:12 AM Zqiang <qiang1.zhang@intel.com> wrote:
> >
> > The rcu-lazy shrinker is registered without CONFIG_RCU_LAZY enabled
> > is meaningless, this commit therefore make rcu-lazy shrinker is
> > registered only when CONFIG_RCU_LAZY is enabled.
> >
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Queued and pushed, thank you both!

Twice, actually.  I missed Joel's reviewed-by the first time around,
fixed now.

							Thanx, Paul

> Thanks.
> 
> > ---
> >  kernel/rcu/tree_nocb.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index 9e1c8caec5ce..28c1c092817b 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -1312,6 +1312,7 @@ int rcu_nocb_cpu_offload(int cpu)
> >  }
> >  EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
> >
> > +#ifdef CONFIG_RCU_LAZY
> >  static unsigned long
> >  lazy_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
> >  {
> > @@ -1360,6 +1361,7 @@ static struct shrinker lazy_rcu_shrinker = {
> >         .batch = 0,
> >         .seeks = DEFAULT_SEEKS,
> >  };
> > +#endif
> >
> >  void __init rcu_init_nohz(void)
> >  {
> > @@ -1391,8 +1393,10 @@ void __init rcu_init_nohz(void)
> >         if (!rcu_state.nocb_is_setup)
> >                 return;
> >
> > +#ifdef CONFIG_RCU_LAZY
> >         if (register_shrinker(&lazy_rcu_shrinker, "rcu-lazy"))
> >                 pr_err("Failed to register lazy_rcu shrinker!\n");
> > +#endif
> >
> >         if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
> >                 pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
> > --
> > 2.25.1
> >
