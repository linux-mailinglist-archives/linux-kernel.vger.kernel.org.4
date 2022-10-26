Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066C160E220
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbiJZNZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbiJZNZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:25:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8AD2D2ED56
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:25:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CE3223A;
        Wed, 26 Oct 2022 06:25:16 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.1.5])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 774603F71A;
        Wed, 26 Oct 2022 06:25:08 -0700 (PDT)
Date:   Wed, 26 Oct 2022 14:24:58 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware/psci: demote suspend-mode warning to debug level
Message-ID: <Y1k1Hp+0I1k1mioW@FVFF77S0Q05N>
References: <20221024143417.11463-1-johan+linaro@kernel.org>
 <20221025115355.26zrhmaudigumivn@bogus>
 <Y1fc4FQ8WKnFb5my@hovoldconsulting.com>
 <20221025132655.4kddpdod5czw3vts@bogus>
 <Y1fzlItO+cwVybZm@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1fzlItO+cwVybZm@hovoldconsulting.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 04:32:52PM +0200, Johan Hovold wrote:
> On Tue, Oct 25, 2022 at 02:26:55PM +0100, Sudeep Holla wrote:
> > On Tue, Oct 25, 2022 at 02:56:00PM +0200, Johan Hovold wrote:
> > > On Tue, Oct 25, 2022 at 12:53:55PM +0100, Sudeep Holla wrote:
> > > > On Mon, Oct 24, 2022 at 04:34:17PM +0200, Johan Hovold wrote:
> > > > > On some Qualcomm platform, like SC8280XP, the attempt to set PC mode
> > > > > during boot fails with PSCI_RET_DENIED and since commit 998fcd001feb
> > > > > ("firmware/psci: Print a warning if PSCI doesn't accept PC mode") this
> > > > > is now logged at warning level:
> > > > >
> > > > > 	psci: failed to set PC mode: -3
> > > > >
> > > > > As there is nothing users can do about the firmware behaving this way,
> > > > > demote the warning to debug level.
> > > > >
> > > >
> > > > As mentioned in the other thread I prefer to keep this as error as we
> > > > shouldn't mask this error and enable more/newer platforms to ignore it
> > > > when they can go and fix it. So I don't agree with this.
> > >
> > > But now every owner of an X13s laptop will see this not very informative
> > > error at every boot and wonder what it means. Has something gone broken?
> > > Should they be worried? Can something be done about it?
> > >
> > 
> > I understand that but I have expressed why I am concerned on generalising
> > it. As long as we inform the concerned owners running Linux(which is quite
> > small at the moment), keeping it will help to get these fixed on platforms
> > that are running Linux today for validation and get it fixed if their
> > platform firmware suffers from the same.
> 
> Trying to inform every user that a warning during boot is actually
> benign and nothing to worry about generally seems backwards to me and is
> not something that is likely to scale.

It's not *entirely* beningn; we still have to bodge around this not being to
spec, and there are things that won't work (e.g. if we kexec to a kernel that
expects the FW to actually follow the spec it claims to).

I agree with Sudeep that we should log something here, but I do appreciate that
argumetn that for 90% of users this is not interesting.

I would suggest we make this:

	pr_info(FW_BUG "failed to set PC mode: %d\n", ...);

... so that it's always logged for those who care, but as it's INFO rather than
WARNING, it'll easily be filtered out of logs (e.g. for users booting with
"quiet"). Adding FW_BUG will also make this clear we're complaining about a FW
bug rather than this being a kernel-internal error.

Thanks,
Mark.
