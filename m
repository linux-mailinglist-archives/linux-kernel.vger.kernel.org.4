Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C91160CD66
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbiJYN1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiJYN1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:27:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4C79766A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:26:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B7AE23A;
        Tue, 25 Oct 2022 06:27:05 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 939043F71A;
        Tue, 25 Oct 2022 06:26:57 -0700 (PDT)
Date:   Tue, 25 Oct 2022 14:26:55 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware/psci: demote suspend-mode warning to debug level
Message-ID: <20221025132655.4kddpdod5czw3vts@bogus>
References: <20221024143417.11463-1-johan+linaro@kernel.org>
 <20221025115355.26zrhmaudigumivn@bogus>
 <Y1fc4FQ8WKnFb5my@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1fc4FQ8WKnFb5my@hovoldconsulting.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 02:56:00PM +0200, Johan Hovold wrote:
> On Tue, Oct 25, 2022 at 12:53:55PM +0100, Sudeep Holla wrote:
> > On Mon, Oct 24, 2022 at 04:34:17PM +0200, Johan Hovold wrote:
> > > On some Qualcomm platform, like SC8280XP, the attempt to set PC mode
> > > during boot fails with PSCI_RET_DENIED and since commit 998fcd001feb
> > > ("firmware/psci: Print a warning if PSCI doesn't accept PC mode") this
> > > is now logged at warning level:
> > >
> > > 	psci: failed to set PC mode: -3
> > >
> > > As there is nothing users can do about the firmware behaving this way,
> > > demote the warning to debug level.
> > >
> >
> > As mentioned in the other thread I prefer to keep this as error as we
> > shouldn't mask this error and enable more/newer platforms to ignore it
> > when they can go and fix it. So I don't agree with this.
>
> But now every owner of an X13s laptop will see this not very informative
> error at every boot and wonder what it means. Has something gone broken?
> Should they be worried? Can something be done about it?
>

I understand that but I have expressed why I am concerned on generalising
it. As long as we inform the concerned owners running Linux(which is quite
small at the moment), keeping it will help to get these fixed on platforms
that are running Linux today for validation and get it fixed if their
platform firmware suffers from the same.

> Remember that this is firmware used by Windows machines so by the time
> we see this in Linux it's probably way too late to fix in firmware
> anyway.
>

I am well aware of that fact, but I am targeting platforms that are using
Linux for validation today.

Honestly, I am not sure if we need to target for zero errors or warnings
on the platforms instead of repeatedly annoy them with warnings until it
is fixed. Otherwise I see it won't be fixed ever.

That said, this is just my opinion.

--
Regards,
Sudeep
