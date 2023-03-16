Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56956BD2CD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjCPO44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjCPO4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:56:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02B5C97C0;
        Thu, 16 Mar 2023 07:56:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 371A262063;
        Thu, 16 Mar 2023 14:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96556C433EF;
        Thu, 16 Mar 2023 14:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678978610;
        bh=30oq+syR7e9uPhfYEn77txXhTmYN92uLTefpdhflrDM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IBnTDT1+WGPD9xu4oBohaT+WaT3DWyMQyL3NUb+KiUrqrzXcrUoCEZFMz0csR11u7
         g6g1OhXyOQmCBRmi0At6yHK0AKg9yuQz9x2j1amS/Ty8B53VPH0tnvVfjpCx9HGnjK
         LTaKSmRKj4jY8NLjjYVUDqO9gnix0dxNziERmxbhRpbtory3k1M/TrBmhWyLWG+e7l
         msr/g1F/K80yc8AqIpsjnn5KPKD4rLw+Ex/fQhsp4CIah5CnkAnOhwEtIpBvCGmzBc
         qJW69S5MUlHznVFDHmsGbeTfC3cEyMraeXrjkQMhe47S/bSUAfGECd8eZ56IveYNu0
         JtiXrZy6A5X8Q==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 320EF1540395; Thu, 16 Mar 2023 07:56:50 -0700 (PDT)
Date:   Thu, 16 Mar 2023 07:56:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Jens Axboe <axboe@kernel.dk>,
        Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Subject: Re: [PATCH 04/13] tracing: Rename kvfree_rcu() to
 kvfree_rcu_mightsleep()
Message-ID: <8d42e647-617a-4ee9-b4d0-bc1e7bc1b732@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230201150815.409582-1-urezki@gmail.com>
 <20230201150815.409582-5-urezki@gmail.com>
 <ZAni8Q1NW9cWrvHJ@pc636>
 <20230315183648.5164af0f@gandalf.local.home>
 <d404a6b6-4ff9-930a-1cdc-fd730270fbe7@kernel.dk>
 <60f55a5d-213f-46b7-9294-c37f10f98252@paulmck-laptop>
 <20230315222323.7afe82e7@gandalf.local.home>
 <29b54f07-b4ce-4eab-bbc2-281672bca5a5@paulmck-laptop>
 <CAEXW_YRr_fpkNAF8dFHLt0vGjYeksS+ObUPGgEUJimGpsASKcQ@mail.gmail.com>
 <20230316081424.28dd8b7f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316081424.28dd8b7f@gandalf.local.home>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 08:14:24AM -0400, Steven Rostedt wrote:
> On Thu, 16 Mar 2023 00:16:39 -0400
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > Indeed, and one could argue that "headless" sounds like something out
> > of a horror movie ;-). Which of course does match the situation when
> > the API is applied incorrectly.
> 
> Well, "headless" is a common term in IT.
> 
>    https://en.wikipedia.org/wiki/Headless_software

Indeed it is.  But RCU is incapable of headlessness, so in the
kvfree_rcu_mightsleep() case, the rcu_head is dynamically allocated.

> We could be specific to what horror movie/story, and call it:
> 
>   kvfree_rcu_sleepy_hollow()
> 
> Which will imply both headless *and* might_sleep!

Heh!  That one is almost bad enough to be good!  Almost!  ;-)

							Thanx, Paul
