Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3C165C881
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjACU4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjACU4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:56:43 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B67219C
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 12:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=B69Mxv4OYvnu+oYUZaX6wp8uon3z08Dc9pWJfcsHKpM=; b=DiFduzu2Xtgm6JqneAWhTJF8qY
        OX4p3jCeeL1DPWHsA65o+cr5wMFRhr83wGAkyoxpUB8fnIQFFHGRrJRfHPBdww//2GHssyAt0wJ3c
        77Fyh9xGCvUfCUU4GwnqQFTHa6wu719DhGBWGddqjQV0FVP2IHpukJ45zhR6voKOkKwyZx+/FBvK3
        DAitqEjqMaXsCeWs62rUuxzRJDwZRLGZkEkJWMV0lX5dPzTF0kZtdqd6oSIyX7bLUzlJUAAQDAWFQ
        rZ43FKNBui//kig1zehADjB8jGKnoKV3g8yVm446BOzkl9cHMs0gjJF4X9SUbdlGhJeNrCdU4bQve
        4wGmBaWw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35954)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1pCoKq-0005rk-Jo; Tue, 03 Jan 2023 20:56:36 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1pCoKm-0002PL-VL; Tue, 03 Jan 2023 20:56:32 +0000
Date:   Tue, 3 Jan 2023 20:56:32 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Hector Martin <marcan@marcan.st>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v3 0/5] Fix a whole host of nvmem registration/cleanup
 issues
Message-ID: <Y7SWgC7m4tYSU1UJ@shell.armlinux.org.uk>
References: <Y7RezbPSGrO37NZZ@shell.armlinux.org.uk>
 <5333ed0e-010c-178a-beb2-e8a4338f2d43@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5333ed0e-010c-178a-beb2-e8a4338f2d43@marcan.st>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Really not interested in your politics. Not interested in fixing this
problem.

I'll use these patches to fix the problem in my tree. I don't care about
mainline.

On Wed, Jan 04, 2023 at 03:12:44AM +0900, Hector Martin wrote:
> On 04/01/2023 01.58, Russell King (Oracle) wrote:
> > Hi,
> > 
> > This series fixes a whole host of nvmem registration/error cleanup
> > issues that have been identified by both Hector and myself. It is a
> > substantial rework of my original patch fixing the first problem.
> > 
> > The first most obvious problem is the race between nvmem registration
> > and use, which leads to sporadic failures of drivers to probe at boot
> > time.
> > 
> > While fixing this, it has been noticed that a recent fix to check the
> > return value of dev_set_name() introduced a new bug where wp_gpio was
> > not being put in that newly introduced error path.
> > 
> > Then there's a fix for a previous fix which itself purports to fix
> > another bug, but results in the allocated ID being leaked. Fix for a
> > fix for a fix is not good!
> > 
> > Then there's an error in the docbook documentation for wp_gpio (it's
> > listed as wp-gpio instead) but as nothing seems to set wp_gpio, we
> > might as well get rid of it - which also solves the issue that we
> > call gpiod_put() on this whether we own it or not.
> > 
> > Lastly, there's a fix for yet another spurious white-space in this
> > code, one of what seems to be a long history of past white-space
> > fixes.
> > 
> > These patches have been individually build-tested in the order of
> > posting, but not run-time tested except for the entire series.
> > 
> >  drivers/nvmem/core.c           | 51 ++++++++++++++++++------------------------
> >  include/linux/nvmem-provider.h |  2 --
> >  2 files changed, 22 insertions(+), 31 deletions(-)
> > 
> 
> Uhh. The series itself looks fine as far as fixing the problems, but I
> fail to see how this is any better than my attempt as far as backporting
> or commit atomicity goes. Patch #4 fixes the newer gpio leak bug *and*
> half fixes the race condition bug, then patch #5 completes the race
> condition fix but now depends on #4, meaning you're left with exactly
> the same backporting mess since now you can't apply #5 to older kernels
> and #4 only to newer ones. Splitting the commits like this buys you nothing.
> 
> I thought we were doing minimal backportable fixes to solve this, but
> your commit message for #4 literally says "While a minimal fix for this
> would be to add the gpiod_put() call, we can do better if we split
> device_register() [...]"... and then that whole "let's do better" part
> is what breaks the backportability again.
> 
> And then of course if you *do* manage to queue at least #4 to be
> backported to a newer subset of stable trees, #3 certainly isn't going
> to get backported itself (since it's just removing dead code, not
> eligible for stable since it fixes no actual bugs), but then you're left
> with the same
> broken-on-paper-except-nobody-uses-it-anyway-so-it-doesn't-matter
> situation my v2 left us in for those stable kernels.
> 
> That said, thanks for identifying that nobody uses the functionality I
> supposedly regressed (in a tiny corner case code path where it was
> already broken anyway) in my v2, and therefore I didn't actually regress
> anything in practice and strictly fixed real bugs.
> 
> - Hector
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
