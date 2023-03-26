Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F176C97A8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 21:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjCZTx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 15:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCZTx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 15:53:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BC455B6;
        Sun, 26 Mar 2023 12:53:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A87660EE6;
        Sun, 26 Mar 2023 19:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E891C433EF;
        Sun, 26 Mar 2023 19:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679860405;
        bh=a3idF1OnzK0ta+M1kQ6BZWvXz40Iu3iKa784Cxx/8Vw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iGvz7UBSRqd/qIsq5mmxZn4YtZPz/tuq0A9ZxKUPP0P0p0nJujXJN7KIVKypgPlcv
         7WaWBwM5SeD+ITD31Cvkn9zukQ7uYJ+hFJMu9TsgQNq1Fq4Sdl3u/u0elt6OGYKSMQ
         zFnReDgOEWMl1+HffjaydAmSGJ+lSh04I9tKK51EhpiTtC9LPkZBp7oiuBiFQBYgfH
         02sCbX8kbUe1Sg5dCOEgrFsHYs9a6AdrDJrY1k3Mxl82Rp+jEEASaPNC4xuxSsF5EI
         s6Amus2zpXJwjNZGshyY5vy2jzOHeTLLIa4NFrmdXgIRP1urU/ztcoRzC/+o2VvbhR
         yJuaJTjPuyTfw==
Date:   Sun, 26 Mar 2023 21:53:22 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang1.zhang@intel.com>, Mark Brown <broonie@kernel.org>,
        rcu@vger.kernel.org
Subject: Re: [PATCH v2 11/13] rcu-tasks: Report stalls during
 synchronize_srcu() in rcu_tasks_postscan()
Message-ID: <ZCCish6dAkiOOZ1Q@localhost.localdomain>
References: <20230325173316.3118674-1-joel@joelfernandes.org>
 <20230325173316.3118674-12-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230325173316.3118674-12-joel@joelfernandes.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Sat, Mar 25, 2023 at 05:33:14PM +0000, Joel Fernandes (Google) a écrit :
> From: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> 
> The call to synchronize_srcu() from rcu_tasks_postscan() can be stalled
> by a task getting stuck in do_exit() between that function's calls to
> exit_tasks_rcu_start() and exit_tasks_rcu_finish().   To ease diagnosis
> of this situation, print a stall warning message every rcu_task_stall_info
> period when rcu_tasks_postscan() is stalled.
> 
> [ paulmck: Adjust to handle CONFIG_SMP=n. ]
> 
> Reported-by: Mark Brown <broonie@kernel.org>
> Link: https://lore.kernel.org/rcu/20230111212736.GA1062057@paulmck-ThinkPad-P17-Gen-1/
> Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

