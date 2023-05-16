Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6633704DA0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjEPMTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjEPMTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:19:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E48469A;
        Tue, 16 May 2023 05:19:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D74962C99;
        Tue, 16 May 2023 12:19:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB7AC433EF;
        Tue, 16 May 2023 12:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684239546;
        bh=qTDoRfAIkC7F67wJ34T9NmziMuy/wyiI6h84xY8LLLA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YnmKFetmXE68lvhKqZYxQr0mmRanS5kNpmHqwEgW6KulSemp0Fm3G9koPueGMMh2q
         lNCoWje2nU8eJBphSsrOjB3PyxOBYE/wYtur5+N8oveP1gBhVrdiTyWoc5sGJ896HZ
         SYvT0WnrU2KI+gi7/wiIonnZmY4FQzL0+aCYDWQf4tcFt/PNH4/n22xk4yrw47UIOT
         nJ71wIcHLafpglSs/sYPg4Y/qtJsYFPZUivWe97MiVPSIs0uQ08d/dGHP+4TeemfnM
         wGvqUF7+sH6hU+muyVpElTxa0mwAjsTMT943VwJNcApu/d7lP58qYqHR98v05pllpO
         LbzTQwYEmh/IA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8432FCE1432; Tue, 16 May 2023 05:19:06 -0700 (PDT)
Date:   Tue, 16 May 2023 05:19:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the rcu tree
Message-ID: <62cabd2d-124f-4bc3-8eb8-36773c10b4f2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230511090010.2916e9d7@canb.auug.org.au>
 <59c2fd36-6920-47d8-a79c-9ff3fcf7c7ae@paulmck-laptop>
 <96c6fdf7-e589-ca56-9314-1d437b8082ac@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96c6fdf7-e589-ca56-9314-1d437b8082ac@linuxfoundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 01:28:23PM -0600, Shuah Khan wrote:
> On 5/11/23 10:52, Paul E. McKenney wrote:
> > On Thu, May 11, 2023 at 09:00:10AM +1000, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > The following commit is also in the kselftest-fixes tree as a different
> > > commit (but the same patch):
> > > 
> > >    6d9ed63d8bc3 ("tools/nolibc: Fix build of stdio.h due to header ordering")
> > > 
> > > This is commit
> > > 
> > >    d7eafa64a158 ("tools/nolibc: Fix build of stdio.h due to header ordering")
> > > 
> > > in the kselftest-fixes tree.
> > 
> > I can currently cleanly remove this commit from the rest of the nolibc
> > commits in -rcu.
> > 
> > However, I might need to re-introduce it in some way or another, for
> > example, if there are dependencies on it by future nolibc patches.
> > (I expect another batch in a few days.)
> > 
> > So how would you like to proceed?
> 
> Paul,
> 
> I can drop this from linux-kselftest fixes if that is the easier path.
> Just let me know.

That would work better for me, less need to keep track of different
commits in different trees.  So could you please drop this one?

							Thanx, Paul
