Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF65E732C8B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243224AbjFPJ5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjFPJ5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:57:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59F47194;
        Fri, 16 Jun 2023 02:57:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AA7A1FB;
        Fri, 16 Jun 2023 02:58:06 -0700 (PDT)
Received: from e120325.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDA603F5A1;
        Fri, 16 Jun 2023 02:57:18 -0700 (PDT)
Date:   Fri, 16 Jun 2023 10:57:15 +0100
From:   Beata Michalska <beata.michalska@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        mark.rutland@arm.com, will@kernel.org, rafael@kernel.org,
        sudeep.holla@arm.com, ionela.voinescu@arm.com, sumitg@nvidia.com,
        yang@os.amperecomputing.com, Len Brown <len.brown@intel.com>,
        vincent.guittot@linaro.org
Subject: Re: [PATCH] arm64: Provide an AMU-based version of
 arch_freq_get_on_cpu
Message-ID: <ZIwx+4zVzgKGLcS3@e120325.cambridge.arm.com>
References: <20230606155754.245998-1-beata.michalska@arm.com>
 <20230608051509.h4a6gn572mjgdusv@vireshk-i7>
 <20230608051816.2ww7ncg65qo7kcuk@vireshk-i7>
 <ZIHpd6unkOtYVEqP@e120325.cambridge.arm.com>
 <20230609043922.eyyqutbwlofqaddz@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609043922.eyyqutbwlofqaddz@vireshk-i7>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 10:09:22AM +0530, Viresh Kumar wrote:
> On 08-06-23, 15:45, Beata Michalska wrote:
> > For those CPUs that are in full dynticks mode , the arch_freq_scale_factor will
> > be basically useless (as there will be no regular sched_tick which eventually
> > calls topology_scale_freq_tick()), so the code below will look for any other
> > available CPU within current policy that could server as the source of the
> > counters. If there is none it will fallback to cpufreq driver to provide
> > current frequency.
> 
> Understood.
> 
> > There is a little bit of ambiguity around both 'cpuinfo_cur_freq' and
> > 'scaling_cur_freq' and how those two are being handled on different platforms.
> > If I got things right, the first one is supposed to reflect the frequency as
> > obtained from  the hardware,
> 
> Yes, this must be accurate, as much as possible.
> 
> > whereas the latter is more of a sw point of view on that,
> 
> Historically, it was more about the last frequency requested by the software.
> But that has changed, for example for X86 and now there is no limitation here
> which disallows one to report the more accurate one.
>
That's my observation as well - thank you for clarifying.
> > That could work, I guess. But then we would have 'cpuinfo_cur_freq' ==
> > 'scaling_cur_freq' for platforms that do provide arch_freq_get_on_cpu,
> > which might lead to more confusion as per what is the actual difference between
> > the two (?)
> 
> The behavior should be same for all platforms. That's my primary concern here.
> If getting same freq from both these files is okay for X86, then it should be
> for ARM as well.
> 
I agree it would be good to align the behaviour here.
I guess we should wait for more input on what we can and cannot do for x86.

---
BR
B.
> If the X86 commit (f8475cef9008) wasn't already merged, I would have suggested
> to do this aperf/mperf thing only in cpuinfo_cur_freq() and not
> scaling_cur_freq().
> 
> Maybe we can still revert back if there is no hard dependency here.
> 
> Len / Rafael ?
> 
> The question is if we should make scaling_cur_freq() to always return the last
> requested frequency and make cpuinfo_cur_freq() to return the most accurate one,
> preferably using aperf/mperf ?
> 
> -- 
> viresh
