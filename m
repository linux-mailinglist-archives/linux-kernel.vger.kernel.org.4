Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B32866299E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237209AbjAIPPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbjAIPOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:14:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247FA1EC7A;
        Mon,  9 Jan 2023 07:13:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B711C61182;
        Mon,  9 Jan 2023 15:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A67C433D2;
        Mon,  9 Jan 2023 15:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673277217;
        bh=AMs5OuZG5+W3JYSxa9vgyOdLUbMCf90Na5I+i3c8ilc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=oyY1tWmY0gkV+FHbgETSaJy8QlHLLr5mA97sbTOfwL0tfxJXifd9AI/jSh16FgLYR
         kF8z9TGQvLHP7kvbearhyaWbXZ97gVxTpaTIQhRAFP1BItTEBjmrGoFpPD9ClWXbwq
         4WSQsokjThf49wX7ew65b5wY6ywPfq7sihvPBoBp9/xAIy//uXTMkpiW3LqswCR2wd
         YOnLdJKZkD6uWzUCOdKa8vEYVWVkIFV70QB/iJfWVjvzcMEw2hqXSZdH0dY7jqqQOB
         e19G9MD44/WWPansMWfkwG3NO5f1ZWSz+tSmdSN1qFw49uTYXFI886wt4/CKcaHgOr
         ViKbbckzDJebQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B0E125C03F3; Mon,  9 Jan 2023 07:13:36 -0800 (PST)
Date:   Mon, 9 Jan 2023 07:13:36 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Dave Chinner <david@fromorbit.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH rcu 6/6] rcu: Allow up to five minutes expedited RCU CPU
 stall-warning timeouts
Message-ID: <20230109151336.GO4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230105005105.GA1772125@paulmck-ThinkPad-P17-Gen-1>
 <20230105005126.1772294-6-paulmck@kernel.org>
 <CAMuHMdU_+t=msiusxi3BxgFVxMO8Y-mMDoTLnx_RUzPXVWrdOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU_+t=msiusxi3BxgFVxMO8Y-mMDoTLnx_RUzPXVWrdOQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 11:10:10AM +0100, Geert Uytterhoeven wrote:
> Hi Paul,
> 
> Thanks for your patch, which is now commit 0d49d9123dcf41f7 ("rcu:
> Allow up to five minutes expedited RCU CPU stall-warning timeouts")
> in next-20230109.
> 
> On Thu, Jan 5, 2023 at 2:10 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > The maximum value of RCU CPU stall-warning timeouts has historically been
> > five minutes (300 seconds).  However, the recently introduced expedited
> > RCU CPU stall-warning timeout is instead limited to 21 seconds.  This
> > causes problems for CI/fuzzing services such as syzkaller by obscuring
> > the issue in question with expedited RCU CPU stall-warning timeout splats.
> >
> > This commit therefore sets the RCU_EXP_CPU_STALL_TIMEOUT Kconfig options
> > upper bound to 300000 milliseconds, which is 300 seconds and 5 minutes.
> 
> s/and/or/

Good eyes!  I will apply with attribution on my next rebase.

							Thanx, Paul
