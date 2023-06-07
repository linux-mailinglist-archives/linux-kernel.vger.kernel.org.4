Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEDD726200
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239829AbjFGOA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbjFGOA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:00:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4AE4E1BD9;
        Wed,  7 Jun 2023 07:00:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 198C9AB6;
        Wed,  7 Jun 2023 07:01:41 -0700 (PDT)
Received: from e120325.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDD9B3F587;
        Wed,  7 Jun 2023 07:00:52 -0700 (PDT)
Date:   Wed, 7 Jun 2023 15:00:49 +0100
From:   Beata Michalska <beata.michalska@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        mark.rutland@arm.com, will@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, ionela.voinescu@arm.com,
        sumitg@nvidia.com, yang@os.amperecomputing.com
Subject: Re: [PATCH] arm64: Provide an AMU-based version of
 arch_freq_get_on_cpu
Message-ID: <ZICNkXfBQUiT/BvK@e120325.cambridge.arm.com>
References: <20230606155754.245998-1-beata.michalska@arm.com>
 <20230607095856.7nyv7vzuehceudnl@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607095856.7nyv7vzuehceudnl@bogus>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 10:58:56AM +0100, Sudeep Holla wrote:
> On Tue, Jun 06, 2023 at 04:57:54PM +0100, Beata Michalska wrote:
> > With the Frequency Invariance Engine (FIE) being already wired up with
> > sched tick and making use of relevant (core counter and constant
> > counter) AMU counters, getting the current frequency for a given CPU
> > on supported platforms, can be achieved by utilizing the frequency scale
> > factor which reflects an average CPU frequency for the last tick period
> > length.
> > 
> > With that at hand, arch_freq_get_on_cpu dedicated implementation
> > gets enrolled into cpuinfo_cur_freq policy sysfs attribute handler,
> > which is expected to represent the current frequency of a given CPU,
> > as obtained by the hardware. This is exactly the type of feedback that
> > cycle counters provide.
> > 
> > In order to avoid calling arch_freq_get_on_cpu from the scaling_cur_freq
> > attribute handler for platforms that do provide cpuinfo_cur_freq, and
> > yet keeping things intact for those platform that do not, its use gets
> > conditioned on the presence of cpufreq_driver (*get) callback (which also
> > seems to be the case for creating cpuinfo_cur_freq attribute).
> >
> 
> LGTM,
> 
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> 
Thanks for the review.
> However I fail to understand if both the changes are dependent ?
> Can this be split into 2 patches ? I fail to see the dependency, what
> am I missing ? Even if there is some dependency to get arch value
> (arch_freq_get_on_cpu() from show_cpuinfo_cur_freq()), you can push
> that change first followed by the arm64 change as 2 different change.
> 
I guess I could split the patch into two parts:
1. adding implementation for the arch_freq_get_on_cpu
2. wiring it up with the cpufreq relevant attrib handlers

or the other way round (if that's what you have in mind).

Will wait a bit for any further comments before pushing new v.

---
BR
B.

> -- 
> Regards,
> Sudeep
