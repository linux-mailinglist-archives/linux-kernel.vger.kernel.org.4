Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FC367612D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 00:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjATXFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 18:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjATXE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 18:04:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DD45E509;
        Fri, 20 Jan 2023 15:04:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A4C6620DB;
        Fri, 20 Jan 2023 23:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268A6C433D2;
        Fri, 20 Jan 2023 23:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674255895;
        bh=LMsw88cgBpVjJxCIhi0DRVqJ1kShBhfQt3V1Vb3MHh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gyz6TzB30132BD9VGssYLbtPt5kemf/ipUDNgihtydIFj/1FnEJXALQJ88a0XyrSk
         dJmRWzDvUCVW1p3+OpQkIa0repD0fkfF6hmT/KMuCsGaeC/Dci//ZzdwOwH5piUZwg
         CK/mSpidoF6EVlvkUzdJZCem7apBbXqpqFEjD8Agkl+p0BpB8RoKTtoiLVfCO5IOCz
         fk3rIf/f0+zV17AUl+2oi+DZiW6zZsnkC/SYf2amAURCENspdLNOjj2hKSRLni9rin
         l95fmgFGp6J4RAt7tS1AhCj23mPLdomYGuKAPtdE6uIuqmBhxGYIxtm8dUv497aBDV
         YEcjkN/BwIh9Q==
Date:   Sat, 21 Jan 2023 00:04:51 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, quic_neeraju@quicinc.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rcu: Remove impossible wakeup rcu GP kthread action
 from rcu_report_qs_rdp()
Message-ID: <Y8seE8Tr1w0UWf+m@lothringen>
References: <PH0PR11MB5880A16045A842AB80A25C4BDAC59@PH0PR11MB5880.namprd11.prod.outlook.com>
 <B3E458A6-9279-4716-B242-873C77EC1E3A@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B3E458A6-9279-4716-B242-873C77EC1E3A@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 08:27:03AM -0500, Joel Fernandes wrote:
> 
> Sure, I know what the code currently does, I am asking why and it feels wrong.
> 
> I suggest you slightly change your approach to not assuming the code should be bonafide correct and then fixing it (which is ok once in a while), and asking higher level questions to why things are the way they are in the first place (that is just my suggestion and I am not in a place to provide advice, far from it, but I am just telling you my approach — I care more about the code than increasing my patch count :P).
> 
> If you are in an intermediate state, part way to a !nocb state — you may have
> missed a nocb-related accel and wake, correct? Why does that matter? Once we
> transition to a !nocb state, we do not do a post-qs-report accel+wake anyway
> as we clearly know from the discussion.

I'm confused. We are doing that acceleration on qs report for !nocb CPU, right?

> So why do we need to do it if we
> missed it for the intermediate stage? So, I am not fully sure yet what that
> needac is doing and why it is needed.

To summarize:

* If the CPU is NOCB, all the callbacks advance and acceleration is performed
  by the rcuo/rcuog kthreads.

* If the CPU is not NOCB, all the callbacks acceleration is performed by the
  CPU, such as in the case of rcu_report_qs_rdp().

* If the CPU is transitionning from NOCB to !NOCB or from !NOCB to NOCB, the
  kthreads may not be available to do the advance/acceleration, so we must do
  it locally. That's the needacc path.

What am I missing?

Thanks.
