Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAFE60CCD1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbiJYNAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbiJYM7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:59:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153078262D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:56:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5FD26191C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 12:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1378CC433C1;
        Tue, 25 Oct 2022 12:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666702579;
        bh=bCqzRGl1FdGUqf/GpPxaKPWh93hx4ZWz6ftzxtQpuIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fRntCiii7c5mSijZk1L3Fa+Qx4RLEixdsh2rozeRDnjojuqrR0tVa85Xvx0gVryYa
         VZp/ClVwMBri+BYU+uiFSvwNImaCNBcwNTUrTdFIJLbo38l2feEJ1KaoW2UwFPordm
         L+02ZpKW9IwFQ2wxOsyWVxwS4TZGpKsWEoSljj1MCo/Ekmr/uWBzblWNeLYjnEbzLP
         u37g/RcVLCmIrXAfgJHe2CPAiZ+f7U+O6vnWUz1h9eq22nskSGGTEJf+JpDlmtFH4v
         +Jie6glnXXIzlEQSm6MobnwXFGZ8QhRB3aKw67ziDM0kNBd+QW8drueZhEklAJxQcg
         xb7PWZVq47mZA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1onJTM-0001iG-Ju; Tue, 25 Oct 2022 14:56:01 +0200
Date:   Tue, 25 Oct 2022 14:56:00 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware/psci: demote suspend-mode warning to debug level
Message-ID: <Y1fc4FQ8WKnFb5my@hovoldconsulting.com>
References: <20221024143417.11463-1-johan+linaro@kernel.org>
 <20221025115355.26zrhmaudigumivn@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025115355.26zrhmaudigumivn@bogus>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 12:53:55PM +0100, Sudeep Holla wrote:
> On Mon, Oct 24, 2022 at 04:34:17PM +0200, Johan Hovold wrote:
> > On some Qualcomm platform, like SC8280XP, the attempt to set PC mode
> > during boot fails with PSCI_RET_DENIED and since commit 998fcd001feb
> > ("firmware/psci: Print a warning if PSCI doesn't accept PC mode") this
> > is now logged at warning level:
> >
> > 	psci: failed to set PC mode: -3
> >
> > As there is nothing users can do about the firmware behaving this way,
> > demote the warning to debug level.
> >
> 
> As mentioned in the other thread I prefer to keep this as error as we
> shouldn't mask this error and enable more/newer platforms to ignore it
> when they can go and fix it. So I don't agree with this.

But now every owner of an X13s laptop will see this not very informative
error at every boot and wonder what it means. Has something gone broken?
Should they be worried? Can something be done about it?

Remember that this is firmware used by Windows machines so by the time
we see this in Linux it's probably way too late to fix in firmware
anyway.

Johan
