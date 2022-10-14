Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1075FF39B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 20:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiJNSfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 14:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiJNSfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 14:35:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A89C3FA23;
        Fri, 14 Oct 2022 11:35:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39762B82362;
        Fri, 14 Oct 2022 18:35:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8B0C433C1;
        Fri, 14 Oct 2022 18:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665772503;
        bh=3JFYtTPiOuJ7CoqD4Y9wJ7Xb3TwXYCMW/FdwbU/z9Io=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cJ8wPYcU+GGA2ggdfwZ2DNbQjRbFjKC31uXOenHuoqNvrqtvD+f9gvir2Ih6ADvqp
         T+3UVq1sA77kDMaS6eyqB/C7JXFLUjNXu4FSoMO2Gi3YnWoAs8Tbxo7g8b3PQqf4ZY
         e/WCCOaYEiHRKAlcrel4CBulH5aqehz+jGPw9U+rOslQIKU0LqPZasXEmBw/aiKfNl
         xezBXXIM8xLNVIjXgtXI7qc85q6s4929+S9iaQ8o5MLevFS4QgpGqj1HzAJVrut75G
         akt0ltwXs+YNABFxNrzsauTlhHEa4HQZrIkCBt82Ga2pP2hfWxMfDsO4bUxXFO4HA5
         Kg+eLX05TzG4A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 750D75C32BF; Fri, 14 Oct 2022 11:35:00 -0700 (PDT)
Date:   Fri, 14 Oct 2022 11:35:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH 0/3] srcu: A few NMI-safe debugging updates
Message-ID: <20221014183500.GK4221@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221013172244.1099010-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013172244.1099010-1-frederic@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 07:22:41PM +0200, Frederic Weisbecker wrote:
> Hi,
> 
> This has passed SRCU-N, SRCU-P and SRCU-T so far.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> 	srcu/nmisafe
> 
> HEAD: 3cfdc2c6b8e89ca3c33954ea9b0d69e8cd141412

Thank you, Frederic!

I have pulled this is for review and testing.

							Thanx, Paul

> Thanks,
> 	Frederic
> ---
> 
> Frederic Weisbecker (3):
>       srcu: Warn when NMI-unsafe API is used in NMI
>       srcu: Explain the reason behind the read side critical section on GP start
>       srcu: Debug NMI safety even on archs that don't require it
> 
> 
>  include/linux/srcu.h     | 44 ++++++++++++++++++++++++++++++++++----------
>  include/linux/srcutiny.h | 12 ------------
>  include/linux/srcutree.h |  7 -------
>  kernel/rcu/srcutree.c    | 31 ++++++++++++++++---------------
>  4 files changed, 50 insertions(+), 44 deletions(-)
