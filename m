Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183A95F0FA1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 18:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiI3QLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 12:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbiI3QLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:11:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE5012F74B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:11:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE5E7623A9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 16:11:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F30FC433C1;
        Fri, 30 Sep 2022 16:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664554290;
        bh=gW7NrWZ5dZhqXeyRZaZTY+AnXwbY6ITCSrT7CcnNXB0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pYNdszuNZcMaTUIUknEPeYgzSwYimZ0llVrrj53VtLWo14/diU89AdTEGw5GTHAg4
         8DCSXv7dSI0aji9LH5UKa4pEaJrKoo9/ZWIh9pXJsSpL0SyMaUNpeAE+PaxjCpJUoo
         Ix8R6KmiyfQLYFsdSUPLDyMqvG4Fl6+nByNJ4cefmi3L09qBjfcGjGSLhFrVcEHgpX
         ia0bBxkU5n9BfF/p42WzMDftMQcrH0WN19ihjM29UWWMG4JTp8URPiJBPlAslseXhW
         pfaVXm3Y4MYE6kFE4F1v3P9NyX4PwTmi46aCci1pDBO3CGZqr+UzXSbaXbOSND+mxH
         mgBXF5siPEOpw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D51B45C0BE3; Fri, 30 Sep 2022 09:11:29 -0700 (PDT)
Date:   Fri, 30 Sep 2022 09:11:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: INFO: task rcu_gp:3 blocked for more than 122 seconds.
Message-ID: <20220930161129.GH4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YzVkyxSjifFghj8H@zn.tnic>
 <20220929153722.GG4196@paulmck-ThinkPad-P17-Gen-1>
 <YzbCtvNWue+qUnT0@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzbCtvNWue+qUnT0@zn.tnic>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 12:19:34PM +0200, Borislav Petkov wrote:
> On Thu, Sep 29, 2022 at 08:37:22AM -0700, Paul E. McKenney wrote:
> > As discussed on IRC, I got nuttin' on this one.  Looks like an RCU
> > expedited grace period is stuck waiting for its workqueue kthread, and
> > that this workqueue kthread is stuck for some reason.
> 
> Yeah, it is not that easy to repro - I need to wait a couple of minutes
> after it boots. Look at the timestamps:
> 
> [  249.149378] INFO: task rcu_gp:3 blocked for more than 122 seconds.
> ^^^^^^^^^^^^^^

That can be annoying!  I well recall one bisection session where each step
took several hours, and where each step required manual intervention,
and where the bug was urgent.  I got the bisection overnight, but was
pretty useless then next day.  ;-)

> But it looks like sched/core is the culprit because merging it into
> Linus master triggers it.

It is possible that Peter would want proof of this.  ;-)

> Lemme bisect that.

Please, and thank you in advance!

							Thanx, Paul

> Stay tuned.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
