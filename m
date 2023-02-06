Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B11568C474
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjBFRUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjBFRUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:20:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48F91E1D0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 09:20:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D5EFB815A2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 17:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A89C433EF;
        Mon,  6 Feb 2023 17:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675704029;
        bh=NKlw9n7U/Lx8pgFxKtqz8pjgu/I76fEfQM1abPyoRec=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=vA2c50H5vezkfjUWTE9zIv/s4oidckVc63aeIBp2ouCOCTZXJp9mQjdhaGEp/nXCh
         WyNkNPaNtT7NdInGx6Nec09/xPr2qOc/C5SdrkuTgP6Hqg7jLRLGIF7rC7RPryW9i4
         zBpduGJhniCQZIpF4gMwk7D8x1aFrkgoAgrwbb8yGuMnvrbIOrufVJG98y4YVLZt0T
         acnKaIBmihYXsLNFpxx5NyziiCOEoOxLG3qN/I8FaaMKhcyWTR0b9cf9edb2BqLB7S
         7wUj6eXHe84muVUp5p07KA6gnuEyQQGo6CeruHLaBQaHYSAiKGZVgGxSUPToS806+O
         l3un+n1ILR+jg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 295EF5C0993; Mon,  6 Feb 2023 09:20:29 -0800 (PST)
Date:   Mon, 6 Feb 2023 09:20:29 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2 2/4] locktorture: Add nested locking to mutex torture
 tests
Message-ID: <20230206172029.GO2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230203200138.3872873-1-jstultz@google.com>
 <20230203200138.3872873-2-jstultz@google.com>
 <20230205190753.4sgvtxxaqcvr45ei@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230205190753.4sgvtxxaqcvr45ei@offworld>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2023 at 11:07:53AM -0800, Davidlohr Bueso wrote:
> On Fri, 03 Feb 2023, John Stultz wrote:
> 
> > This patch adds randomized nested locking to the mutex torture
> > tests, as well as new LOCK08 config files for testing mutexes
> > with nested locking
> > 
> > This was inspired by locktorture extensions originally implemented
> > by Connor O'Brien, for stress testing the proxy-execution series:
> >  https://lore.kernel.org/lkml/20221003214501.2050087-12-connoro@google.com/
> > 
> > Comments or feedback would be greatly appreciated!
> > 
> > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Signed-off-by: John Stultz <jstultz@google.com>
> 
> Just realized I sent two review tags for rtmutex, one was supposed
> to be this patch.
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

Thank you!

I will apply this to these commits on my next rebase:

f5a632cbbbea ("locktorture: Add nested locking to mutex torture tests")
83743c9839f5 ("locktorture: Add nested locking to rtmutex torture tests")

John, if you send a new version of these, please add Davidlohr's review
tags.

							Thanx, Paul
