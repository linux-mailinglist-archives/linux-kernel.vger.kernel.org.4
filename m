Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC186A4596
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjB0PHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjB0PHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:07:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3393D1EBED;
        Mon, 27 Feb 2023 07:07:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90FEC60EA5;
        Mon, 27 Feb 2023 15:07:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F17C4339C;
        Mon, 27 Feb 2023 15:07:17 +0000 (UTC)
Date:   Mon, 27 Feb 2023 10:07:15 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: Re: [PATCH v3 20/20] thermal/traces: Replace the thermal zone
 structure parameter with the field value
Message-ID: <20230227100715.7d896836@gandalf.local.home>
In-Reply-To: <20230226225406.979703-21-daniel.lezcano@linaro.org>
References: <20230226225406.979703-1-daniel.lezcano@linaro.org>
        <20230226225406.979703-21-daniel.lezcano@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Feb 2023 23:54:06 +0100
Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> In the work of the thermal zone device self-encapsulation, let's pass
> the field value instead of dereferencing them in the traces which
> force us to export publicly the thermal_zone_device structure.
> 
> No fonctionnal change intended.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/gov_fair_share.c              |  4 +++-
>  drivers/thermal/gov_power_allocator.c         |  6 +++--
>  drivers/thermal/gov_step_wise.c               |  4 +++-
>  drivers/thermal/thermal_core.c                |  8 +++++--
>  include/trace/events/thermal.h                | 24 +++++++++----------
>  .../trace/events/thermal_power_allocator.h    | 12 +++++-----
>  6 files changed, 34 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/thermal/gov_fair_share.c b/drivers/thermal/gov_fair_share.c
> index aad7d5fe3a14..cdddd593021d 100644
> --- a/drivers/thermal/gov_fair_share.c
> +++ b/drivers/thermal/gov_fair_share.c
> @@ -35,7 +35,9 @@ static int get_trip_level(struct thermal_zone_device *tz)
>  	 * point, in which case, trip_point = count - 1
>  	 */
>  	if (count > 0)
> -		trace_thermal_zone_trip(tz, count - 1, trip.type);
> +		trace_thermal_zone_trip(thermal_zone_device_type(tz),
> +					thermal_zone_device_id(tz),
> +					count - 1, trip.type);

The problem with this approach is that you are moving all the work to
dereference the pointers into the hot paths (the code execution), instead
of doing it in the slow path (where the tracepoint work is done).

If you are concerned with exporting a structure then move the trace file
from:

  include/trace/events/thermal.h to drivers/thermal/trace.h

like drivers/vfio/pci/trace.h and many other drivers do.

Read
   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/trace_events/Makefile
to see how to use a trace header outside the include/trace/events directory.

also, by removing the pointer, you lose out on BPF and kprobe traces that
could dereference the pointer if you needed to trace something that was not
exported by the trace point itself.

-- Steve


>  
>  	return count;
>  }
