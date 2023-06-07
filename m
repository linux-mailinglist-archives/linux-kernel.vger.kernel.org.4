Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB378725B26
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbjFGJ7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbjFGJ7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:59:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C83221BC3;
        Wed,  7 Jun 2023 02:59:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA853AB6;
        Wed,  7 Jun 2023 02:59:45 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE3E13F587;
        Wed,  7 Jun 2023 02:58:58 -0700 (PDT)
Date:   Wed, 7 Jun 2023 10:58:56 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Beata Michalska <beata.michalska@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        mark.rutland@arm.com, will@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, ionela.voinescu@arm.com,
        sumitg@nvidia.com, Sudeep Holla <sudeep.holla@arm.com>,
        yang@os.amperecomputing.com
Subject: Re: [PATCH] arm64: Provide an AMU-based version of
 arch_freq_get_on_cpu
Message-ID: <20230607095856.7nyv7vzuehceudnl@bogus>
References: <20230606155754.245998-1-beata.michalska@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606155754.245998-1-beata.michalska@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 04:57:54PM +0100, Beata Michalska wrote:
> With the Frequency Invariance Engine (FIE) being already wired up with
> sched tick and making use of relevant (core counter and constant
> counter) AMU counters, getting the current frequency for a given CPU
> on supported platforms, can be achieved by utilizing the frequency scale
> factor which reflects an average CPU frequency for the last tick period
> length.
> 
> With that at hand, arch_freq_get_on_cpu dedicated implementation
> gets enrolled into cpuinfo_cur_freq policy sysfs attribute handler,
> which is expected to represent the current frequency of a given CPU,
> as obtained by the hardware. This is exactly the type of feedback that
> cycle counters provide.
> 
> In order to avoid calling arch_freq_get_on_cpu from the scaling_cur_freq
> attribute handler for platforms that do provide cpuinfo_cur_freq, and
> yet keeping things intact for those platform that do not, its use gets
> conditioned on the presence of cpufreq_driver (*get) callback (which also
> seems to be the case for creating cpuinfo_cur_freq attribute).
>

LGTM,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

However I fail to understand if both the changes are dependent ?
Can this be split into 2 patches ? I fail to see the dependency, what
am I missing ? Even if there is some dependency to get arch value
(arch_freq_get_on_cpu() from show_cpuinfo_cur_freq()), you can push
that change first followed by the arm64 change as 2 different change.

-- 
Regards,
Sudeep
