Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BABC6A10C4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjBWTrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjBWTrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:47:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A6659436;
        Thu, 23 Feb 2023 11:47:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97A11616DE;
        Thu, 23 Feb 2023 19:47:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBFCC433EF;
        Thu, 23 Feb 2023 19:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677181628;
        bh=Em2QDyAZ0KH0bHZu71kQxLJbevaqhicO73kmNvOzY7o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NJVJBNO0CbECmpzZ7CYF1nC3DQOotZgcFtXiGSwr3htPlfAoSRdqaDNigBjOGVoWQ
         FA6GR5eW97zAQ+7jdCndC/Zp71J8QwA35+s/vRT4eMX+rFY7fgA+OGIr98gfmBVarH
         drqnUS8FKHCIxJQzGPVlMgIZ+V2VsKg/oZuKLaZni2vjFX5kmxwk7AYv1aAlnX3LjR
         HOPiTaHHM5dM20MyMmk+pypwbZ62OyJHZxh1Y/R7LyqSLGW4PyfL1GlEzKahme9ENY
         JlRE6XXlgAyJmUS4ABT2T7dGug2NRiwxrm03vJwDE24TZHIahVIxUaa1UvAp7w4uMe
         HesVXxDnsdyXg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 706C35C0DBB; Thu, 23 Feb 2023 11:47:08 -0800 (PST)
Date:   Thu, 23 Feb 2023 11:47:08 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Subject: Re: [PATCH 00/13] Rename k[v]free_rcu() single argument to
 k[v]free_rcu_mightsleep()
Message-ID: <20230223194708.GI2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230201150815.409582-1-urezki@gmail.com>
 <84fd00b0-aa87-e4b7-e0a4-d57b720216c0@kernel.dk>
 <20230223183124.GF2948950@paulmck-ThinkPad-P17-Gen-1>
 <ae3a6434-1b3a-b848-c8f9-bf6b3d0521e6@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae3a6434-1b3a-b848-c8f9-bf6b3d0521e6@kernel.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 12:36:57PM -0700, Jens Axboe wrote:
> On 2/23/23 11:31 AM, Paul E. McKenney wrote:
> > On Thu, Feb 23, 2023 at 07:57:13AM -0700, Jens Axboe wrote:
> >> On 2/1/23 8:08 AM, Uladzislau Rezki (Sony) wrote:
> >>> This small series is based on Paul's "dev" branch. Head is 6002817348a1c610dc1b1c01ff81654cdec12be4
> >>> it renames a single argument of k[v]free_rcu() to its new k[v]free_rcu_mightsleep() name.
> >>>
> >>> 1.
> >>> The problem is that, recently we have run into a precedent when
> >>> a user intended to give a second argument to kfree_rcu() API but
> >>> forgot to do it in a code so a call became as a single argument
> >>> of kfree_rcu() API.
> >>>
> >>> 2.
> >>> Such mistyping can lead to hidden bags where sleeping is forbidden.
> >>>
> >>> 3.
> >>> _mightsleep() prefix gives much more information for which contexts
> >>> it can be used for.
> >>
> >> This patchset seems weird to me. We have a LOT of calls that might
> >> sleep, yet we don't suffix them all with _mightsleep(). Why is this
> >> any different? Why isn't this just a might_sleep() call in the
> >> actual helper, which will suffice for checkers and catch it at
> >> runtime as well.
> > 
> > Fair enough, and the situation that this patchset is addressing is also a
> > bit unusual.  This change was requested by Eric Dumazet due to a situation
> > where someone forgot the optional second argument to kfree_rcu().  Now,
> > you are right that this would be caught if invoked from a non-sleepable
> > context, but there are also cases where sleeping is legal, but where the
> > occasional wait for an RCU grace period would be a problem.  The checkers
> > cannot easily catch this sort of thing, and hence the change in name.
> > 
> > Hey, the combined one/two-argument form seemed like a good idea at
> > the time!  ;-)
> 
> Hah, not sure what you were smoking back then!

If I remember, would you like me to send you some?  ;-)

							Thanx, Paul
