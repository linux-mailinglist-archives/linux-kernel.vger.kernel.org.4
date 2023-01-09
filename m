Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56804663056
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237713AbjAIT3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237692AbjAIT3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:29:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2668462A;
        Mon,  9 Jan 2023 11:28:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48E78B80F98;
        Mon,  9 Jan 2023 19:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C26C433EF;
        Mon,  9 Jan 2023 19:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673292481;
        bh=JnBnjMw8xHojNM712myCFe1VMmK89/7cGKUSJ3U6/bs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dWVj/ddC7JqKTDwHPaytugN0owtKirLQlyY0qUwBHfa8APiEu06nesO81qRPsivbk
         +AKBTAs+UnrKNphPYOP1dR8gw7fnH2FG7TbbhIrvgkE37+NYzqUzak+tpUOsYPkvi5
         X4iJOcSTpgT8XvGQeopXTh3qprLmexIx23jLHGKDN+0sfceG7jpN77X8gtS4zGw/mC
         b5c3++RzPS/BIFHYIwQd4RUzgErZitWyUV3VHhiPlpyo1qtfRFgalM2SEtlDSlSZgV
         +b/2O15pr+zXT2Kurp9jwYO/Fnazw/HRdcvvOmQ6OdXVyCzJiTQASRI+VEA9kHQIdM
         3qk4bc1JTGdWg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 77C6C5C05C8; Mon,  9 Jan 2023 11:28:01 -0800 (PST)
Date:   Mon, 9 Jan 2023 11:28:01 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Zqiang <qiang1.zhang@intel.com>, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Fix missing TICK_DEP_MASK_RCU_EXP dependency check
Message-ID: <20230109192801.GW4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221220141625.3612085-1-qiang1.zhang@intel.com>
 <20221221201634.GH4001@paulmck-ThinkPad-P17-Gen-1>
 <Y7nmihQ126cjqEss@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7nmihQ126cjqEss@lothringen>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2023 at 10:39:22PM +0100, Frederic Weisbecker wrote:
> On Wed, Dec 21, 2022 at 12:16:34PM -0800, Paul E. McKenney wrote:
> > On Tue, Dec 20, 2022 at 10:16:25PM +0800, Zqiang wrote:
> > > This commit add TICK_DEP_MASK_RCU_EXP dependency check in
> > > check_tick_dependency(), fix commit df1e849ae4559 ("rcu: Enable
> > > tick for nohz_full CPUs slow to provide expedited QS").
> > > 
> > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > 
> > Again, good eyes, thank you!!!
> > 
> > I have queued this for further review and testing, given that it affects
> > pretty much only RCU.  However, if someone else would rather take it:
> > 
> > Acked-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Thanks for picking it up! Please also add the following tags:
> 
> Fixes: df1e849ae455 ("rcu: Enable tick for nohz_full CPUs slow to provide expedited QS")
> Acked-by: Frederic Weisbecker <frederic@kernel.org>

Thank you for looking it over!  I will apply these on my next rebase.

							Thanx, Paul
