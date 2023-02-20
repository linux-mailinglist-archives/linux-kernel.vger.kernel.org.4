Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF35269D156
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 17:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjBTQa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 11:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjBTQa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 11:30:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1255A1DB94;
        Mon, 20 Feb 2023 08:30:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AFF5EB80D61;
        Mon, 20 Feb 2023 16:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89250C433D2;
        Mon, 20 Feb 2023 16:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676910624;
        bh=C1qaZQhoveFXJhdRuPeOzPzr3B8QSkfH+2dmQtcXWRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c0vBpvB9LYOIXsotuQuZWbyBHM49cHNLl65ljTuQ59UuPV2prZNbp7Nb+9QL9PPvc
         eNQG9rgeQQXoZKOuiEqVuY/cXAb/UKoJ1tsFmDMr9Ey/HZ+VEIV8wNdkZnPceUhN00
         vKoyxcKb2BlwUKlwz4BXgT4lq449fzMu0qllAyitf/M1JE2B6gkaQdAszGBSqnhwtW
         gYZIb+Wcp8bkQHIFYxmTd5YyforWYPxiJAtKIUbDiHCbsQ24DYmCdQY7SrUljl2A1U
         q1t8LkcFCttSU8jmjlwLRgRX6WBrONQK7N5y552uU+vW6gPBaDYWqF77Zl/VtoauZ0
         itnnqK2i+fmMg==
Date:   Mon, 20 Feb 2023 08:33:54 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, mka@chromium.org
Subject: Re: [PATCH v3 1/2] clk: Add generic sync_state callback for
 disabling unused clocks
Message-ID: <20230220163354.keppkzdt6nzh6xfb@ripper>
References: <20221227204528.1899863-1-abel.vesa@linaro.org>
 <ebc257025ebd641e624ef506ea09c800.sboyd@kernel.org>
 <Y/OV3CF0ootyooDJ@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/OV3CF0ootyooDJ@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 05:46:36PM +0200, Abel Vesa wrote:
> On 23-02-17 21:38:22, Stephen Boyd wrote:
> > Quoting Abel Vesa (2022-12-27 12:45:27)
> > > There are unused clocks that need to remain untouched by clk_disable_unused,
> > > and most likely could be disabled later on sync_state. So provide a generic
> > > sync_state callback for the clock providers that register such clocks.
> > > Then, use the same mechanism as clk_disable_unused from that generic
> > > callback, but pass the device to make sure only the clocks belonging to
> > > the current clock provider get disabled, if unused. Also, during the
> > > default clk_disable_unused, if the driver that registered the clock has
> > > the generic clk_sync_state_disable_unused callback set for sync_state,
> > > skip disabling its clocks.
> > 
> > How does that avoid disabling clks randomly in the clk tree? I'm
> > concerned about disabling an unused clk in the middle of the tree
> > because it doesn't have a driver using sync state, while the clk is the
> > parent of an unused clk that is backed by sync state.
> > 
> >    clk A -->  clk B 
> > 
> > clk A: No sync state
> > clk B: sync state
> > 
> > clk B is left on by the bootloader. __clk_disable_unused(NULL) is called
> > from late init. Imagine clk A is the root of the tree.
> > 
> > 	clk_disable_unused_subtree(clk_core A)
> > 	  clk_disable_unused_subtree(clk_core B)
> > 	    if (from_sync_state && core->dev != dev)
> > 	      return;
> > 	  ...
> > 	  clk core A->ops->disable()
> > 
> > clk core B is off now?
> 
> Yes, that is correct. But the same thing is happening currently if the
> clk_ignore_unused in not specified. At least with this new approach, we
> get to leave unused clocks enabled either until sync_state is called or forever.
> All the provider has to do is to implement a sync_state callback (or use
> the generic one provided). So the provider of clk A would obviously need
> a sync state callback registered.
> 
> > 
> > Also sync_state seems broken right now. I saw mka mentioned that if you
> > have a device node enabled in your DT but never enable a driver for it
> > in the kernel we'll never get sync_state called. This is another
> > problem, but it concerns me that sync_state would make the unused clk
> > disabling happen at some random time or not at all.
> 
> Well, the fact that the sync state not being called because a driver for
> a consumer device doesn't probe does not really mean it is broken. Just
> because the consumer driver hasn't probed yet, doesn't mean it will
> not probe later on.
> 
> That aside, rather than going with clk_ignore_unused all the time on
> qcom platforms, at least in a perfect scenario (where sync state is
> reached for all providers) the clocks get disabled.
> 

Furthermore, the sync_state approach will cause clk_disable_unused() to
be invoked for clock drivers that probe after late_initcall() as well.

So not only can we boot without clk_ignore_unused, we will actually turn
off unused display clocks (perhaps all of them, for a headless device).

Regards,
Bjorn
