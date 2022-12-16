Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533EB64F3B8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 23:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiLPWIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 17:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiLPWHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 17:07:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045631740C;
        Fri, 16 Dec 2022 14:07:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BEBD621A5;
        Fri, 16 Dec 2022 22:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D718C433D2;
        Fri, 16 Dec 2022 22:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671228472;
        bh=zTo+zHpQ3FKbyUHKDoeV/N0D43S8xikzmzbD68oM+mE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XEYKhyhxiK0VHZSEumzuCt+yABNQTaGSR2NZEpef+49wHoZpyBS3s3gfcqwRnmfo0
         ep2nVlWQ7SlL5HFbya8zmwQf92qkOvbvfr/a4gDXY4VJyqwV308npYdZDALedDWMCO
         7lSk8AnEFClHCUbQbEcgGmxW0mElrdDPfhNxqiHA9hV/ZacjXhw+0/13NqeeCI3gTf
         HJpzZ/G/DolUn+88NW/TfEYFBHZELke1Ew5ThQRitUCHptyGWLcCtPM2PxxvgkjhYb
         2efQ06JS57zvNqv/bhrFl/xjF3VRXiuw9Mdc/fOvqa+dNUHeqrVFfViufOknvbFJme
         NR9WIggBYNYqw==
Date:   Fri, 16 Dec 2022 23:07:48 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        len.brown@intel.com
Subject: Re: [RFC/RFT PATCH 1/2] sched/core: Check and schedule ksoftirq
Message-ID: <20221216220748.GA1967978@lothringen>
References: <20221215184300.1592872-1-srinivas.pandruvada@linux.intel.com>
 <20221215184300.1592872-2-srinivas.pandruvada@linux.intel.com>
 <Y5xURk3CkzhIjmmq@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5xURk3CkzhIjmmq@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 12:19:34PM +0100, Peter Zijlstra wrote:
> On Thu, Dec 15, 2022 at 10:42:59AM -0800, Srinivas Pandruvada wrote:
> > +		/* Give ksoftirqd 1 jiffy to get a chance to start its job */
> > +		if (!READ_ONCE(it.done) && task_is_running(__this_cpu_read(ksoftirqd))) {
> > +			__set_current_state(TASK_UNINTERRUPTIBLE);
> > +			schedule_timeout(1);
> > +		}
> 
> That's absolutely disgusting :-/

I know, and I hate checking task_is_running(__this_cpu_read(ksoftirqd))
everywhere in idle. And in fact it doesn't work because some cpuidle drivers
also do need_resched() checks.

I guess that either we assume that the idle injection is more important
than serving softirqs and we shutdown the warnings accordingly, or we arrange
for idle injection to have a lower prio than ksoftirqd.

Thoughts?
