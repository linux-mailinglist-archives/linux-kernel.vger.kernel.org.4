Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3930675C6A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjATSFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjATSE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:04:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BEF66011;
        Fri, 20 Jan 2023 10:04:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D364B829C1;
        Fri, 20 Jan 2023 18:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF51C4339B;
        Fri, 20 Jan 2023 18:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674237891;
        bh=rE5bdPR8ydsuy1WViMrPoNGn/hFuJl8sylozRghEyoo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Lj/6zQ5MxRH/hOESWSHh5g5QS/tTNHMAcjOZmqjFTfF+099zWY9yV17IHls0aLEIF
         8TA77beAM1ZUV52pYO2lxRa8iI3P6Yix12zlEA2HgNBnCfWZa6f5tkKPbRyXJABFSG
         CsUGcSiPvwqAIcVnh4jYDFH8Afala4/afQEcgiXEZSYDwPwKR5kkVQ6pzKN5k84cpc
         y76XLaav3hI3mV3DCvYyi3XGldoH7DwayZn7KSZ+tl7AiVCIflzkyp1HUj6AOHz44j
         ZVCtG+8yVcCdqNM2FhmSzwkp6MNOBolD6ocurBfVNzSl87CNyw8YPJRZtR5714yhXC
         uxtS5kscOJh8Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 63C045C17DC; Fri, 20 Jan 2023 10:04:51 -0800 (PST)
Date:   Fri, 20 Jan 2023 10:04:51 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, John Ogness <john.ogness@linutronix.de>,
        sfr@canb.auug.org.au
Subject: Re: [PATCH rcu v2 16/20] kernel/power: Remove "select SRCU"
Message-ID: <20230120180451.GP2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1>
 <20230113001132.3375334-16-paulmck@kernel.org>
 <CAJZ5v0gNbp4ZgPRDfLV6kmieUo7zcQSEGjdsB=G8Zr4W=HAHoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gNbp4ZgPRDfLV6kmieUo7zcQSEGjdsB=G8Zr4W=HAHoQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 05:55:04PM +0100, Rafael J. Wysocki wrote:
> On Fri, Jan 13, 2023 at 1:11 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Now that the SRCU Kconfig option is unconditionally selected, there is
> > no longer any point in selecting it.  Therefore, remove the "select SRCU"
> > Kconfig statements.
> >
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: <linux-pm@vger.kernel.org>
> > Acked-by: "Rafael J. Wysocki" <rafael@kernel.org>
> > Reviewed-by: John Ogness <john.ogness@linutronix.de>
> > ---
> >  kernel/power/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> > index 60a1d3051cc79..4b31629c5be4b 100644
> > --- a/kernel/power/Kconfig
> > +++ b/kernel/power/Kconfig
> > @@ -118,7 +118,6 @@ config PM_SLEEP
> >         def_bool y
> >         depends on SUSPEND || HIBERNATE_CALLBACKS
> >         select PM
> > -       select SRCU
> >
> >  config PM_SLEEP_SMP
> >         def_bool y
> > --
> 
> Applied as 6.3 material, thanks!

Thank you, and I will drop this from my tree on my next rebase.

							Thanx, Paul
