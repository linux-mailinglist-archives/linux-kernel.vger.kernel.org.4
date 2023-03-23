Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D6E6C6FB1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjCWRvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjCWRvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:51:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1BD03250B;
        Thu, 23 Mar 2023 10:51:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EA162F4;
        Thu, 23 Mar 2023 10:52:25 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.31.167])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85E133F766;
        Thu, 23 Mar 2023 10:51:39 -0700 (PDT)
Date:   Thu, 23 Mar 2023 17:51:36 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     wangxiaolei <xiaolei.wang@windriver.com>
Cc:     will@kernel.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: perf record -e branch-misses ls > /dev/null
Message-ID: <ZByRqNRX10knmnuo@FVFF77S0Q05N.cambridge.arm.com>
References: <08994540-d132-6e49-f6a0-82d8dfd1f3f0@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08994540-d132-6e49-f6a0-82d8dfd1f3f0@windriver.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 03:56:41PM +0800, wangxiaolei wrote:
> hi
> 
> When I use the perf tool on nxp-imx6sx, the CPU is armv7 cortex-A9 to test,
> I execute the perf record -e branch-misses ls > /dev/null command, but the
> perf report result is indeed:
> perf report
> Error:
> The perf.data data has no samples!
> # To display the perf.data header info, please use --header/--header-only
> options.

Which kernel version are you seeing this with?

Is anything printed regarding the PMU in dmesg?

> root@nxp-imx6:~# perf list hardware
> 
> List of pre-defined events (to be used in -e):
> 
>    branch-instructions OR branches [Hardware event]
>    branch-misses [Hardware event]
>    bus-cycles [Hardware event]
>    cache-misses [Hardware event]
>    cache-references [Hardware event]
>    cpu-cycles OR cycles [Hardware event]
>    instructions [Hardware event]

That's just listing the generic HW events; does the PMU actually show up under
sysfs?

What do you see if you run:

$ ls /sys/bus/event_source/devices/

> And not only this one hardware event, only cycles are working normally in
> the following supported hardware time, other hardware events are not
> interrupted and reported

Can you explain what you mean by "not interrupted and reported"?

Do you mean the PMU interrupt isn't firing?

> , and the value in the read PMXEVCNTR register is
> always -1, and the PMCR register E, bit[0 ] it will be written to 0 before
> reading the PMXEVCNTR register.

How are you reading PMXEVCNTR?

Have you instrumented the PMU driver, or are you using other code?

> I don’t know if the value in the PMXEVCNTR register is always -1 for this
> reason. Does anyone have any good suggestions for debugging this problem?

There are a number of potential reasons for this; if you can answer some of my
questions above it'd help to narrow this down.

Thanks,
Mark.
