Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D5060F83F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbiJ0M6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbiJ0M6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:58:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39F9F173FC4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:58:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4699D23A;
        Thu, 27 Oct 2022 05:58:46 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5EBD3F7B4;
        Thu, 27 Oct 2022 05:58:38 -0700 (PDT)
Date:   Thu, 27 Oct 2022 13:58:36 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] firmware/psci: demote suspend-mode warning to info
 level
Message-ID: <20221027125836.jlqis3qzyh232smy@bogus>
References: <20221026135445.8004-1-johan+linaro@kernel.org>
 <Y1p2f6OnN2wjCuop@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1p2f6OnN2wjCuop@FVFF77S0Q05N>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 01:15:59PM +0100, Mark Rutland wrote:
> On Wed, Oct 26, 2022 at 03:54:45PM +0200, Johan Hovold wrote:
> > On some Qualcomm platforms, like SC8280XP, the attempt to set PC mode
> > during boot fails with PSCI_RET_DENIED and since commit 998fcd001feb
> > ("firmware/psci: Print a warning if PSCI doesn't accept PC mode") this
> > is now logged at warning level:
> > 
> > 	psci: failed to set PC mode: -3
> > 
> > As there is nothing users can do about the firmware behaving this way,
> > demote the warning to info level and clearly mark it as a firmware bug:
> > 
> > 	psci: [Firmware Bug]: failed to set PC mode: -3
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> On the assumption that we don't have any latent issues in this case, this looks
> ok to me, so:
> 
>   Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Sudeep, does this reasonable to you?
> 
> Are there any latent issues that mean we should keep this as a pr_warn()?

I am fine removing it as warning but making it debug may mask the issue
completely on the platforms that are using Linux itself for validation of
their PSCI firmware implementation. This sounds like a good compromise
instead of jumping from warning directly to debug. I just want to give a
chance for platforms noticing this and working on getting their firmware
fixed.

So for this version:

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
