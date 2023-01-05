Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A428565E4D8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 05:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjAEEuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 23:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjAEEuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 23:50:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1166441D7B;
        Wed,  4 Jan 2023 20:50:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F1E061773;
        Thu,  5 Jan 2023 04:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC3BC433D2;
        Thu,  5 Jan 2023 04:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672894213;
        bh=RlIk+6xzFcUpo0alCDuagyZj26UMRNP+X7tR9BLKZxQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rWBYtDBzDPPjGhc44m2n75jg0i/6NKrtRbSocNTh7JQ1F17F3c6mm4YBzkwbpAmc6
         lRnpBYlT6JqtiEvLGaYkJwysQ3XoHaxRsqAXfAUNLSY9o322OXH1K/9wPK7dkO5eH7
         Wi44HUklclCgHJNUpSZV1KB3xFdADKpJ4mASCmB3ICKf58Q/EDWPUSYgY3pbdMbZVq
         DHQ21BTQmuz2PkbxjddGmaUjV69T5Cpae1D7symvkFYsGea4JmEiX90HNaB/Dw7arU
         aDWJY+8eewpvppJMqthxAwHISCh0g7NozXWF4j1uoOxEPOtLKtCdMG6aUQrWb8Mi4h
         FClg4wMgMwRbw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 965FD5C05CA; Wed,  4 Jan 2023 20:50:12 -0800 (PST)
Date:   Wed, 4 Jan 2023 20:50:12 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH rcu 16/27] drivers/opp: Remove "select SRCU"
Message-ID: <20230105045012.GM4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-16-paulmck@kernel.org>
 <20230105040616.7algt4tvswpzal6d@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105040616.7algt4tvswpzal6d@vireshk-i7>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 09:36:16AM +0530, Viresh Kumar wrote:
> On 04-01-23, 16:38, Paul E. McKenney wrote:
> > Now that the SRCU Kconfig option is unconditionally selected, there is
> > no longer any point in selecting it.  Therefore, remove the "select SRCU"
> > Kconfig statements.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Viresh Kumar <vireshk@kernel.org>
> > Cc: Nishanth Menon <nm@ti.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: <linux-pm@vger.kernel.org>
> > ---
> >  drivers/opp/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/opp/Kconfig b/drivers/opp/Kconfig
> > index e8ce47b327359..d7c649a1a981c 100644
> > --- a/drivers/opp/Kconfig
> > +++ b/drivers/opp/Kconfig
> > @@ -1,7 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  config PM_OPP
> >  	bool
> > -	select SRCU
> >  	help
> >  	  SOCs have a standard set of tuples consisting of frequency and
> >  	  voltage pairs that the device will support per voltage domain. This
> 
> Paul,
> 
> Should I apply this in my tree ? Or you plan to merge all the patches
> yourself ?

Your choice, either way works for me, just let me know!

							Thanx, Paul
