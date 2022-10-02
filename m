Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB235F23F7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 17:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiJBP5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 11:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiJBP5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 11:57:33 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8241F632;
        Sun,  2 Oct 2022 08:57:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1D250CE0A24;
        Sun,  2 Oct 2022 15:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628EEC433D6;
        Sun,  2 Oct 2022 15:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664726248;
        bh=Pra79ol2ovEgO3kPHl0rXQdJqZBHKdslT/I7VF9Gz4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ErbPI121/WPeHeO49ceioGaxKOdILvzYJFHD4dkAipd5Jcmo7mjrZF9fIHKcXB48O
         Mn48Hrj2EfP4Mvm+hWJOr/FyXx/d2VQ2cVdydRJTsFPpP40hHV59NdjIkcE7Igu0rZ
         VjrPm4vMgcBOuFPdCNQxj5zWYnqRhLEglYGiebZCRwkQwALHBmsSizA+85nVuQpull
         bmoOPpsyA0KCG2RPhHfOH60fBd2lcn5lOr38EbcWju1HstTIUpoqdOz0/fTPPEyf3x
         WI89qbUsB2rtTUodXYJ9pESFhV8EiSCxLxkEAGBgR29f3ET6okpAVwhRCl6zsw4nDQ
         GwJyK3LMped7Q==
Date:   Sun, 2 Oct 2022 17:57:25 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH RFC v2 rcu 2/8] srcu: Create an srcu_read_lock_nmisafe()
 and srcu_read_unlock_nmisafe()
Message-ID: <20221002155725.GC292620@lothringen>
References: <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
 <20220929180731.2875722-2-paulmck@kernel.org>
 <20221002155516.GB292620@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221002155516.GB292620@lothringen>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2022 at 05:55:16PM +0200, Frederic Weisbecker wrote:
> On Thu, Sep 29, 2022 at 11:07:25AM -0700, Paul E. McKenney wrote:
> > @@ -1090,7 +1121,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
> >  	int ss_state;
> >  
> >  	check_init_srcu_struct(ssp);
> > -	idx = srcu_read_lock(ssp);
> > +	idx = __srcu_read_lock_nmisafe(ssp);
> 
> Why do we need to force the atomic based version here (even if
> CONFIG_NEED_SRCU_NMI_SAFE=y)?

...even if CONFIG_NEED_SRCU_NMI_SAFE=n that is...
