Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756BF71F2DA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 21:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjFATVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 15:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjFATVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 15:21:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284F013E;
        Thu,  1 Jun 2023 12:21:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A857C64924;
        Thu,  1 Jun 2023 19:21:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C2BC433EF;
        Thu,  1 Jun 2023 19:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685647302;
        bh=R8ZXq4/9sL/Vcs0YG2bdwjiu82BUxaSwNos4HHu++pU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=V0nupLbxwoYLeb6REcRZ2P8ENisI1muZ2wVYPTgNPdmg6pDHnJoxHuuy0+7JkD2Z9
         PNPCUoZ4SwvJIrGRad+tgaj2WsJ7Q9tz9PYHa+7XVdD3O9aIP61U2byQWfZ7bWK/KR
         p/SK1dukZM1pzCXlKTZK823WVQAGxFL7u33uRdaH3Xutomp7/vKFlKanfZvOmFJJer
         OlE4c8rsjQAW7rzaNod4IPu5cuJei0JIIoRZQ6LP1Tbkmi+0/qFs1EyjMAhymD7H8r
         b+UL09VMz02+fxtz7pNnzc3JjlNBFualmYtl4Oz/rDMvQ8p8l/8/u5XmOkCq9kPWx9
         fWtr6SPCoQk5Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A3F99CE04B0; Thu,  1 Jun 2023 12:21:41 -0700 (PDT)
Date:   Thu, 1 Jun 2023 12:21:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Z qiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        Sachin Sant <sachinp@linux.ibm.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH rcu 11/20] srcu: Move grace-period fields from
 srcu_struct to srcu_usage
Message-ID: <bb71b53a-6913-480d-a519-04e2b6b3e0b6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
 <20230330224726.662344-11-paulmck@kernel.org>
 <6549da46-dddc-67ac-73c4-966965addad7@nvidia.com>
 <CALm+0cVXGdLNQpfJxnAnq2j2Ybs_rVAEqNzxgLSq7bDJp1KnfA@mail.gmail.com>
 <0a35ce9d-8eec-4e10-a607-a2e84c8fc5a0@paulmck-laptop>
 <3e2b38f7-95a3-3d7a-9ac5-3d7712d181ab@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e2b38f7-95a3-3d7a-9ac5-3d7712d181ab@nvidia.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 06:14:21PM +0100, Jon Hunter wrote:
> Hi Paul, Zqiang,
> 
> On 01/06/2023 14:46, Paul E. McKenney wrote:
> 
> ...
> 
> > Thank you both!
> > 
> > Huh.  It looks like Chen-Yu Tsai sent a patch to this effect and
> > AngeloGioacchino Del Regno tested it.  No one has picked it up yet.
> > 
> > https://lore.kernel.org/all/20230526073539.339203-1-wenst@chromium.org/
> > 
> > This is clearly a regression, and I don't see it in -next.  I will pick
> > it up and send it along in a few days if Matthias or Rafael don't beat
> > me to it.
> > 
> > In the meantime, I would be happy to add Jon's Reported-by and Tested-by,
> > along with Qiang's Acked-by or Reviewed-by.
> 
> 
> Thanks for the rapid response. Yes that does fix the problem for me so ...
> 
> Tested-by: Jon Hunter <jonathanh@nvidia.com>

Added, and again, thank you!

							Thanx, Paul
