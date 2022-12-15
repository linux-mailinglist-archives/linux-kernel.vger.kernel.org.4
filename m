Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE28A64D45F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 01:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiLOAMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 19:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiLOAMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 19:12:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F69554EB;
        Wed, 14 Dec 2022 16:04:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90980B819B0;
        Thu, 15 Dec 2022 00:04:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EECC433D2;
        Thu, 15 Dec 2022 00:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671062674;
        bh=6zdqv7Q8vPqfC1s6lXlTSp0z37xOGozf4pV1uPfE9b4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RcOMqxLsW0m76iF/DD3ge96L0j5jl66w4BTseO5hUDYboMtPpGretDEbf1SOCa+yF
         kbFICx8Xt3lpbvy4LJ/fhOJLj5Gr9LTuR7hEvyfAhAHQRBDnU+WaWdh4/av56iyFpb
         vSA0+GPkksYIOxt+gcRKvkzySm/tlikcAXxn99zw0NfXtgOkYy0pSxNZGhlmyI7dL6
         Qv0rQGkspJ9gI/nsGWWAkAIJDMtUB3vjkyYD4k2Qk5ewVUGnO5XV/osN4TN82nauX3
         jBypUpy0THA0Ql7SvLNlKRbq53BQbtvJmk3tBo5RMJzwBY37k/PoETxr5FjflQDeJt
         RKC4YjxrU3OGA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BC4125C0A6A; Wed, 14 Dec 2022 16:04:33 -0800 (PST)
Date:   Wed, 14 Dec 2022 16:04:33 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     boqun.feng@gmail.com, frederic@kernel.org, neeraj.iitr10@gmail.com,
        urezki@gmail.com, rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] srcu: Yet more detail for
 srcu_readers_active_idx_check() comments
Message-ID: <20221215000433.GD4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221214191355.GA2596199@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTztHvaXJG9jQmQ13tF2HdCy8+TbvBDCYWd98tMrsE-vw@mail.gmail.com>
 <20221214212455.GA4001@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQp5K2iy0ULnFOVKQit3T+OM_vY29ZcLu6drNEt-ex1QQ@mail.gmail.com>
 <CAEXW_YRvSrD40WJ+8GicWB5NN8QyLLoUzRS9j8Tc9CMvojKO0g@mail.gmail.com>
 <CAEXW_YQx78ge_U7asX4YHcsi1EDZSRo_wGN_DJmWnXcAYjHWgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YQx78ge_U7asX4YHcsi1EDZSRo_wGN_DJmWnXcAYjHWgQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 11:14:48PM +0000, Joel Fernandes wrote:
> On Wed, Dec 14, 2022 at 11:10 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Wed, Dec 14, 2022 at 11:07 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > On Wed, Dec 14, 2022 at 9:24 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > I also did not get why you care about readers that come and ago (you
> > > > > mentioned the first reader seeing incorrect idx and the second reader
> > > > > seeing the right flipped one, etc). Those readers are irrelevant
> > > > > AFAICS since they came and went, and need not be waited on , right?.
> > > >
> > > > The comment is attempting to show (among other things) that we don't
> > > > need to care about readers that come and go more than twice during that
> > > > critical interval of time during the counter scans.
> > >
> > > Why do we need to care about readers that come and go even once? Once
> > > they are gone, they have already done an unlock() and their RSCS is
> > > over, so they need to be considered AFAICS.
> > >
> >
> > Aargh, I meant: "so they need to be considered AFAICS".
> 
> Trying again: "so they need not be considered AFAICS".

Give or take counter wrap, which can make it appear that still-present
readers have finished.

> Anyway, my 1 year old son is sick so signing off for now. Thanks.

Ouch!  I hope he recovers quickly and completely!!!

							Thanx, Paul
