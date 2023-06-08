Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013427284DE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjFHQZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbjFHQZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:25:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDAB2711
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:25:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6DEA64E9D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 16:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58470C433EF;
        Thu,  8 Jun 2023 16:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686241509;
        bh=h1kBxLorPIU5PBDes0GulA99549cBEyy7lMp58JWQXw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GJq5TyBwdDPvaJv8lZ9wwbQvIE+7hIt36nRxZl6r2vkhCUQSJ2AyKfxpyMb6DOubv
         pugf4v4m00tBz3Ygm1R0GccU3GqXI3sKj42eFYVqiOmnWgCWb5z6EKyk3ZcSn7xir6
         +hxsaU5+u5GBF7+J+7p+rJl7DRsYwARmVDjpihoHb8Au7nG/8IuWXroxdcWQTpIsAt
         wFrKDlpQQ/3a9IPlsRaTG0WazRO6Sce0DjDuPeN8toBW7FCj+UFGBqaCCGO6iV6Vhs
         iQlxyj53171k6xjKNFI1yUNfFpG1Bjr3qWCKD/7zxplEpts7chj6HLcJxfUBJuhq2P
         tzwcttFHHCCgQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E809FCE14DD; Thu,  8 Jun 2023 09:25:08 -0700 (PDT)
Date:   Thu, 8 Jun 2023 09:25:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Chris Bainbridge <chris.bainbridge@gmail.com>
Cc:     Feng Tang <feng.tang@intel.com>, tglx@linutronix.de,
        sboyd@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: skew message does not handle negative ns skew
Message-ID: <41b91385-8f04-4498-9eeb-0b3a192b55cb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAP-bSRZuLhZQ4Kpb4NRF2yY6XifYpB3ei4=6oFDAaG+OmeGebQ@mail.gmail.com>
 <ZH8YS+LxMM1ZPpsc@feng-clx>
 <CAP-bSRaNQj+fi1r0MZ64wB5_rfjHmEBFQ+QueiNQ9dnyJixG8A@mail.gmail.com>
 <ZH8pyG1SyfGxQKAm@feng-clx>
 <CAP-bSRa3_Janfh0yAnwmG=bh9niNUjWRPG2fQqc2SxcQR=OHGA@mail.gmail.com>
 <ZH86C4A4qpeAz/n4@feng-clx>
 <86521835-f13f-4d43-9a38-9a55abae0b89@paulmck-laptop>
 <CAP-bSRZa9axG59E3knkVXy4=36irR9E7SXqT-QSikW7BoQueBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-bSRZa9axG59E3knkVXy4=36irR9E7SXqT-QSikW7BoQueBw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 10:41:51AM +0100, Chris Bainbridge wrote:
> On Wed, 7 Jun 2023 at 20:04, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > That is a bit user-unfriendly.  Does the following fix address this
> > issue at your end?
> 
> [    2.095149] clocksource: timekeeping watchdog on CPU3: Marking
> clocksource 'tsc' as unstable because the skew is too large:
> [    2.095152] clocksource:                       'hpet' wd_nsec:
> 515998611 wd_now: 1c29fb9 wd_last: 151e3b8 mask: ffffffff
> [    2.095154] clocksource:                       'tsc' cs_nsec:
> 515124524 cs_now: 8af4c89f9 cs_last: 874f8e80b mask: ffffffffffffffff
> [    2.095155] clocksource:                       Clocksource 'tsc'
> skewed -874087 ns (0 ms) over watchdog 'hpet' interval of 515998611 ns
> (515 ms)

Very good, thank you!

May I please apply your Tested-by?

							Thanx, Paul
