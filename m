Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFBD68D939
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 14:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjBGNYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 08:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjBGNYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:24:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AE9C643;
        Tue,  7 Feb 2023 05:24:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9105AB818E8;
        Tue,  7 Feb 2023 13:24:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938BEC433EF;
        Tue,  7 Feb 2023 13:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675776244;
        bh=uCbshn+qe74HjI3bUDjFeLeAizMW+J2giZWltFU2N8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V5Q0mkmSKbd1/aV8yViRxHmUCEasgQ4reB4ylLa6jCdCyYqE+SopkONicaxvqg/Cz
         VojA7oLHuXB/rsjpFvoAGa1auvV9DlhdLij7mG8Eaol4SzQlQYkOA/YJ1TKzw2yE5A
         7o4u9PTYa0JZO7jk4E53DkNhMomtFNcHXzdspJojui2OxEr0pft3RDTe88DE7qunxV
         tY6k3RCuDaLGBuMnwZ/o0KDYuKCyDImvQuC2lF7HeLsiKYOQLbCNLfsJitTyZRMfN0
         +F8yU2AaFjpRL0bFHSMj5G4HcCwIoxKYhKcORjyuWz5XBSAhiXBnD0Bt76vIAzRCsv
         SurMb0/QoKbhQ==
Date:   Tue, 7 Feb 2023 14:24:00 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Qiang Zhang <Qiang1.zhang@intel.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] rcu/tree: Improve comments in rcu_report_qs_rdp()
Message-ID: <Y+JQ8GX82Gn+7ZWe@lothringen>
References: <20230204022051.2737724-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230204022051.2737724-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2023 at 02:20:50AM +0000, Joel Fernandes (Google) wrote:
> Recent discussion triggered due to a patch linked below, from Qiang,
> shed light on the need to accelerate from QS reporting paths.
> 
> Update the comments to capture this piece of knowledge.
> 
> Link: https://lore.kernel.org/all/20230118073014.2020743-1-qiang1.zhang@intel.com/
> Cc: Qiang Zhang <Qiang1.zhang@intel.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> ---
>  kernel/rcu/tree.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 93eb03f8ed99..713eb6ca6902 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1983,7 +1983,12 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
>  	} else {
>  		/*
>  		 * This GP can't end until cpu checks in, so all of our
> -		 * callbacks can be processed during the next GP.
> +		 * callbacks can be processed during the next GP. Do
> +		 * the acceleration from here otherwise there may be extra
> +		 * grace period delays, as any accelerations from rcu_core()
> +		 * or note_gp_changes() may happen only after the GP after the
> +		 * current one has already started. Further, rcu_core()
> +		 * only accelerates if RCU is idle (no GP in progress).

Actually note_gp_changes() should take care of that. My gut feeling is that the
acceleration in rcu_report_qs_rdp() only stands for:

* callbacks that may be enqueued from an IRQ firing during the small window
  between the RNP unlock in note_gp_changes() and the RNP lock in
  rcu_report_qs_rdp()

* __note_gp_changes() got called even before from the GP kthread, and callbacks
  got enqueued between that and rcu_core().
  
Thanks.
