Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F9063DCFE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiK3STe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiK3STO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:19:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9ADA98D64E
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 10:16:24 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07E61D6E;
        Wed, 30 Nov 2022 10:16:31 -0800 (PST)
Received: from [10.57.71.118] (unknown [10.57.71.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84B0B3F73B;
        Wed, 30 Nov 2022 10:16:23 -0800 (PST)
Message-ID: <c34db006-4d5b-fb71-f998-63fcdcde6c0b@arm.com>
Date:   Wed, 30 Nov 2022 18:16:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/2] perf/arm-cmn: Cope with spurious IRQs better
Content-Language: en-GB
To:     Geoff Blake <blakgeof@amazon.com>
Cc:     will@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <bc8183fcd7f6ca07b0d56aa8061d816485b84341.1669822447.git.robin.murphy@arm.com>
 <f41af5cb-7fc7-4bd3-ec9e-53071b9a41f9@amazon.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <f41af5cb-7fc7-4bd3-ec9e-53071b9a41f9@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-30 16:02, Geoff Blake wrote:
> Robin,
> 
>  From my perspective, this is a worse solution as now we're sweeping an
> issue under the rug and consuming CPU cycles handling IRQs we should not
> be getting in the first place.  While an overflow IRQ from the cmn should
> not be high frequency, there is a non-zero chance in the future it could
> be and this could lead to a very hard to debug performance issue instead
> of the current problem, which is discovering we need to clean up better
> from a noisy kernel message.

Kexec is not the only possible source of spurious IRQs. If they cause a 
problem for this driver, that cannot be robustly addressed by trying to 
rely on whatever software might happen to run before this driver.

> The driver as best I can grok currently is optimized to limit the amount
> of register writes for the common use-case, which is setting and unsetting
> events, so all the wiring for the PMU to feed events to the DTC is done up
> front on load: DTC_CTL's DT_EN bit is set immediately during probe, as is
> OVFL_INTR_EN. All the DN states and DTM PMU_CONFIG_PMU_EN is deferred
> for when an event is actually set, and here we go through all of them
> anyways for each event unless its bynodeid, so the expense of setting
> events grows linearly with the mesh size anyways.

If arm_cmn_init_dtc() writing 0 to PMCR didn't stop the PMU then we've 
got bigger problems, because that's how we expect to start and stop it 
in normal operation. I'm not ruling out that some subtle bug in that 
regard might exist, since I've still not yet had a chance to reproduce 
and observe this behaviour on my board, but I've also not seen 
sufficient evidence to suggest that that is the case either. (Now that 
I'm looking closely, I think there *is* actually a small oversight for 
the DTMs, but that would lead to different symptoms than you reported)

At least the writes to PMOVSR_CLR *did* clearly work, because you're 
seeing the "nobody cared" message from the IRQ core rather than the 
WARN_ON(!dtc->counters[i]) which would happen if a fresh overflow was 
actually asserted. Currently I would expect to see up to 4 of those 
messages since there can be up to 4 IRQs, but once those are all 
requested, enabled, and "handled", all the spurious initially-latched 
state should be cleared and any *new* overflows will be indicated in 
PMOVSR. I don't see how a single IRQ could ever be unhandled more than 
once anyway, if the first time disables it.

Thanks,
Robin.
