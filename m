Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE54B700D2B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbjELQkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjELQkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:40:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFAA10F3;
        Fri, 12 May 2023 09:40:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D45563A6D;
        Fri, 12 May 2023 16:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE27C433D2;
        Fri, 12 May 2023 16:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683909605;
        bh=mFss654Av6NPd92VYAU9bWcL0SPn6hYIYfGafkyQKig=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WKGPZmGNT5X7m7XurXJcDmqWlBSe4qJ3Xm9oD3u4XpDGK2OVP2o04h/tJQ/Xj/Ohq
         jLPfoMuXsv/u96UZFhruCaneaqJ/Uu+yYLDQhNKBE/hZ18Sn0MrhLW9CuKAJwvUyJ3
         gR8yzngfAuObAuPExF6lQX8RHOusBD+/Lnx14pirtjn3RFaDaGlQRLg0cFtlhm6POB
         3ejebmE0BKMuc64TffNkIAtN8vuIgWkVlUEFtUO2C8QuvExvgJLchlMVO+qlDmztRK
         EyxkjZtQDf7kuTAJr75tl9mqhJXqmE0ue6CAx7yYbc0ZBGfhv8+Iw+vWvp1zV+3sMz
         HuQcvdmAvkBWg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0FE5ACE0CCF; Fri, 12 May 2023 09:40:05 -0700 (PDT)
Date:   Fri, 12 May 2023 09:40:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: Re: [PATCH rcu 3/6] rcu/rcuscale: Move rcu_scale_*() after
 kfree_scale_cleanup()
Message-ID: <4d508096-300c-4d16-9c39-18598d00b500@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <IA1PR11MB6171B1AD7716B95B0B2C683889759@IA1PR11MB6171.namprd11.prod.outlook.com>
 <30F06C03-6950-4E2B-B3CE-3939B3CDD295@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30F06C03-6950-4E2B-B3CE-3939B3CDD295@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 09:15:17PM -0700, Joel Fernandes wrote:
> 
> 
> > On May 11, 2023, at 8:20 PM, Zhuo, Qiuxu <qiuxu.zhuo@intel.com> wrote:
> > 
> > ﻿
> >> 
> >> From: Paul E. McKenney <paulmck@kernel.org>
> >> ...
> >>>> I wish diff was better at showing what really changed. The meld tool
> >>>> can help but its gui...
> >>>> 
> >>>> Should I run meld later (I'm out at a conference so no access to
> >>>> meld-capable
> >>>> machines) or are we sufficiently confident that the lines were moved
> >>>> as-is ? :)
> >>>> 
> >>> 
> >>> Thank you, Joel for this concern. Good to know the meld diff GUI tool.
> >>> I just run the command below and confirmed that the lines were moved
> >>> as-is: rcu_scale_{cleanup,shutdown}() follows kfree_scale_cleanup().
> >>> You may double check it ;-).
> >>> 
> >>>      meld --diff ./rcuscale.c.before ./rcuscale.c.after
> >> 
> >> Nice, thank you both!
> >> 
> >> Another option is to check out the commit corresponding to this patch, then
> >> do "git blame -M kernel/rcu/rcuscale.c".  Given a move-only commit, there
> >> should be no line tagged with this commit's SHA-1.
> > 
> > Just had a good experiment with the "git blame -M" option: 
> > - Used this option to prove a move-only commit quickly (no line tagged with that commit) (the fastest method to me). 
> > - Then just only needed to quickly check the positions of the moved code chunk by myself (easy).  
> > 
> > Thank you, Paul for sharing this. It's very useful to me. 
> 
> Looks good to me as well and thank you both for sharing the tips.

Here is one way to script this, where "SHA" identifies the commit to
be checked and PATHS the affected pathnames:

	git checkout SHA^
	git show SHA | git apply -
	git blame -M PATHS | grep '^0* '

If there is no output, there were no non-move changes.  

Or just do the "git blame -M PATHS | grep '^0* '" before doing the
checking.

And yes, you can derive PATHS using "git status" if you want.  ;-)

							Thanx, Paul
