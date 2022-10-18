Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EF7602F9A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiJRPYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiJRPYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:24:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6635625B;
        Tue, 18 Oct 2022 08:24:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0EDE615C5;
        Tue, 18 Oct 2022 15:24:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBB8C433D6;
        Tue, 18 Oct 2022 15:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666106659;
        bh=BC2Hq7y2IYPbSVkSJem2YkCxDtM4WUocEUlVsVjhl5E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Pi2DQhxFBnpCX6HRCABC6Vnh/z7gDugQU/22bxdQ8rr1lw7bBpww/pIqFP+DW56Yw
         mOXllpywLImJT1IUVcIpyaCHhWJHRPyxUtUthP7QwHy6+U9TxHtndc+BPeiMwATQAY
         JieK49edOoqdA2wISlR/IfVRdNqoAcjWa9MB4WoT3AqdYELxTVLzgXHECUHgi66qDH
         0HZ3sUXrmp3ST57wOe8R+oozatSjOGGZy0AHc+YJZoA1gnNUmXDZ5MasAfsgnv5iwU
         RIvyvFO2qP6TLKW686CoNaGL+EJXsviDkcIBEY5dDEVTPTR/Yhm27y8vzTKS889WA+
         77dD++DAsi3iA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 03E285C0528; Tue, 18 Oct 2022 08:24:18 -0700 (PDT)
Date:   Tue, 18 Oct 2022 08:24:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org, tglx@linutronix.de,
        pmladek@suse.com, Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 rcu 0/8] NMI-safe SRCU reader API
Message-ID: <20221018152418.GR5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220921144620.GA1200846@paulmck-ThinkPad-P17-Gen-1>
 <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
 <87k04x4e0r.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k04x4e0r.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 12:39:40PM +0206, John Ogness wrote:
> Hi Paul,
> 
> On 2022-09-29, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > This RFC series provides the second version of an NMI-safe SRCU reader
> > API in the guise of srcu_read_lock_nmisafe() and
> > srcu_read_unlock_nmisafe().
> 
> I would like to post a new series for printk that will rely on the
> NMI-safe reader API. From the feedback of this series it appears that
> the RFC v2 is an acceptable starting point. How should we proceed?

Currently, I have this series on -rcu branch srcunmisafe.2022.10.03a,
with Frederic's patches on branch "dev".  I will be producing a shiny
new branch with your fix and Frederic's debug later today, Pacific Time.
With luck, based on v6.1-rc1.

> Will Frederic be sending a patch for the extra safety checks using
> srcu_nmi_flags? Are you planning on posting a new version? Should I
> include this or another version within my upcoming series?

I will be incorporating these commits from Frederic:

6558b914fc4e ("srcu: Warn when NMI-unsafe API is used in NMI")
5dc788627109 ("srcu: Explain the reason behind the read side critical section on GP start")
54a118fce487 ("srcu: Debug NMI safety even on archs that don't require it")

Are there other patches I should be applying?

> Thanks for all your help on this!

And looking forward to the new improved printk()!

							Thanx, Paul
