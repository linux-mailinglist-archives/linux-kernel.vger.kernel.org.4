Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3849617B70
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 12:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiKCLVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 07:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKCLVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 07:21:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99C8210FCC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 04:21:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 981A01FB;
        Thu,  3 Nov 2022 04:21:57 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 716973F5A1;
        Thu,  3 Nov 2022 04:21:49 -0700 (PDT)
Date:   Thu, 3 Nov 2022 11:21:47 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, quic_kshivnan@quicinc.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v4 0/11] Introduce a unified API for SCMI Server testing
Message-ID: <20221103112147.rq2v7dwte577kmb4@bogus>
References: <20221019204626.3813043-1-cristian.marussi@arm.com>
 <fc09a68c-bd6d-0328-4052-88d40b50077d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc09a68c-bd6d-0328-4052-88d40b50077d@gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 07:38:25PM -0700, Florian Fainelli wrote:
> Hi Christian,
> 
> On 10/19/2022 1:46 PM, Cristian Marussi wrote:
> [snip]
> 
> > In V2 the runtime enable/disable switching capability has been removed
> > (for now) since still not deemed to be stable/reliable enough: as a
> > consequence when SCMI Raw support is compiled in, the regular SCMI stack
> > drivers are now inhibited permanently for that Kernel.
> 
> For our platforms (ARCH_BRCMSTB) we would need to have the ability to start
> with the regular SCMI stack to satisfy if nothing else, all clock consumers
> otherwise it makes it fairly challenging for us to boot to a prompt as we
> purposely turn off all unnecessary peripherals to conserve power. We could
> introduce a "full on" mode to remove the clock provider dependency, but I
> suspect others on "real" silicon may suffer from the same short comings.
>

Fair enough. But if we are doing SCMI firmware testing or conformance via
the $subject proposed way, can these drivers survive if the userspace do
a random or a torture test changing the clock configurations ? Not sure
how to deal with that as the intention here is to do the testing from the
user-space and anything can happen. How do we avoid bring the entire system
down while doing this testing. Can we unbind all the drivers using scmi on
your platform ? I guess no. Let me know.

> Once user-space is reached, I suppose we could find a way to unbind from all
> SCMI consumers, and/or ensure that runtime PM is disabled, cpufreq is in a
> governor that won't do any active frequency switching etc.
>
> What do you think?

Yes, Cristian always wanted to support that but I am the one trying to
convince him not to unless there is a strong requirement for it. You seem
to suggest that you have such a requirement, but that just opens loads of
questions and how to we deal with that. Few of them are as stated above, I
need to recall all the conversations I had with Cristian around that and why
handling it may be bit complex.

--
Regards,
Sudeep
