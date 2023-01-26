Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C3867D55D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjAZTbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjAZTbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:31:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF50A5CFCC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:31:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C40F60B55
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 19:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25AAC433EF;
        Thu, 26 Jan 2023 19:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674761468;
        bh=PGqWzb4wgvcNL+4at+iClbkHPoLojf2NKMh3JxPkiEk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iX03FAtac96I2DRhYB+Srj8X8jEkbl9mbu4U+p8Vc8qOIPYQcMXMWLy6XK+PGVa+C
         hg1Q7GffLzwGP1DKiPv6fZfmXT1YOvGbUB5nmg7shzt8PoswHEB7VGHYm9CBptLSNg
         Uqn/7kCYRw6mtKhjLwr7kCbCk2is1xIYP7dH5gXRKq7x1IqeMb4Y744e7pGGTIPJ9t
         mW9DZgKoq0sZ3WYuH9RWxuRoc/pV/WQnkHhN1FCeAm3Mk+3qU4K+YVUnCEF54LnFmA
         Pw7j2u37kNaz2Cyi8DIrFsimKZqQVaGOYcdgaosixfN/fhcCpgHhCE1WhHH6VXyhQy
         taHFEzHDA09zg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7B8275C0510; Thu, 26 Jan 2023 11:31:08 -0800 (PST)
Date:   Thu, 26 Jan 2023 11:31:08 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>, npiggin <npiggin@gmail.com>,
        dhowells <dhowells@redhat.com>,
        "j.alglave" <j.alglave@ucl.ac.uk>,
        "luc.maranget" <luc.maranget@inria.fr>, akiyks <akiyks@gmail.com>,
        dlustig <dlustig@nvidia.com>, joel <joel@joelfernandes.org>,
        urezki <urezki@gmail.com>,
        quic_neeraju <quic_neeraju@quicinc.com>,
        frederic <frederic@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 2/2] tools/memory-model: Provide exact SRCU semantics
Message-ID: <20230126193108.GH2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Y9GO3xEYkIQq/qSl@rowland.harvard.edu>
 <Y9GPI/g23YWx+0Ce@rowland.harvard.edu>
 <Y9GPVnK6lQbY6vCK@rowland.harvard.edu>
 <c44183e7-44ae-4be3-bb47-517067a112b5@huaweicloud.com>
 <Y9Gyuj+2UFefUdJS@rowland.harvard.edu>
 <edadb690-e791-0e9c-e641-ea8876abe96e@huaweicloud.com>
 <20230126173507.GE2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9LQEuUBn3fwZEBe@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9LQEuUBn3fwZEBe@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 02:10:10PM -0500, Alan Stern wrote:
> On Thu, Jan 26, 2023 at 09:35:07AM -0800, Paul E. McKenney wrote:
> > On Thu, Jan 26, 2023 at 12:30:14PM +0100, Jonas Oberhauser wrote:
> > > I don't think they're necessarily implemented in a compatible way, so
> > > 
> > > r = srcu_lock(s);
> > > srcu_up(s,r);
> > > 
> > > might not actually work, but would currently be ok'ed by LKMM.
> > 
> > In kernels built with CONFIG_PROVE_LOCKING=y (AKA built with lockdep
> > enabled), lockdep would complain about having an srcu_read_lock() with
> > no matching srcu_read_unlock().  Kernels built without lockdep (that is,
> > kernels actually used in production) would be happy with this.
> > 
> > So as Jonas suspects, this should be classified as not actually working.
> 
> Lockdep complaints don't actually stop things from working (unless you 
> want them to).  They're just warnings, right?

True, but they are taken seriously due to lockdep disabling itself after
the first warning.  So a warning for this sort of thing could hide some
other deadlock, which tend to strongly motivate fixing issues leading
to lockdep warnings.

							Thanx, Paul
