Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5369265C1CD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237631AbjACOW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238183AbjACOWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:22:24 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 920B025C3;
        Tue,  3 Jan 2023 06:22:23 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 091E62F4;
        Tue,  3 Jan 2023 06:23:05 -0800 (PST)
Received: from e126311.manchester.arm.com (unknown [10.57.76.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECCAF3F587;
        Tue,  3 Jan 2023 06:22:21 -0800 (PST)
Date:   Tue, 3 Jan 2023 14:22:18 +0000
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, kajetan.puchalski@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v5 0/2] cpuidle: teo: Introduce util-awareness
Message-ID: <Y7Q6GnjKKhCVp1Zf@e126311.manchester.arm.com>
References: <20221130153204.2085591-1-kajetan.puchalski@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130153204.2085591-1-kajetan.puchalski@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 03:32:02PM +0000, Kajetan Puchalski wrote:

Hi Rafael,

As it's been a while since the last email I wanted to bump this thread
and ask what you think about the last changes.

Additionally, I got some emails from the kernel test robot and noticed
that sched_cpu_util is contingent on CONFIG_SMP so in the current form
there's build errors on !SMP machines.

The following change should fix the problem, do you think it's all right to add?

@@ -207,10 +207,17 @@ static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
  * @dev: Target CPU
  * @cpu_data: Governor CPU data for the target CPU
  */
+#ifdef CONFIG_SMP
 static void teo_get_util(struct cpuidle_device *dev, struct teo_cpu *cpu_data)
 {
        cpu_data->utilized = sched_cpu_util(dev->cpu) > cpu_data->util_threshold;
 }
+#else
+static void teo_get_util(struct cpuidle_device *dev, struct teo_cpu *cpu_data)
+{
+       cpu_data->utilized = false;
+}
+#endif

Thanks in advance for your time,
Kajetan

> v4 -> v5:
> - remove the restriction to only apply the mechanism for C1 candidate state
> - clarify some code comments, fix comment style
> - refactor the fast-exit path loop implementation
> - move some cover letter information into the commit description
> 
> v3 -> v4:
> - remove the chunk of code skipping metrics updates when the CPU was utilized
> - include new test results and more benchmarks in the cover letter
> 
> v2 -> v3:
> - add a patch adding an option to skip polling states in teo_find_shallower_state()
> - only reduce the state if the candidate state is C1 and C0 is not a polling state
> - add a check for polling states in the 2-states fast-exit path
> - remove the ifdefs and Kconfig option
> 
> v1 -> v2:
> - rework the mechanism to reduce selected state by 1 instead of directly selecting C0 (suggested by Doug Smythies)
> - add a fast-exit path for systems with 2 idle states to not waste cycles on metrics when utilized
> - fix typos in comments
> - include a missing header
> 
> Kajetan Puchalski (2):
>   cpuidle: teo: Optionally skip polling states in teo_find_shallower_state()
>   cpuidle: teo: Introduce util-awareness
> 
>  drivers/cpuidle/governors/teo.c | 93 +++++++++++++++++++++++++++++++--
>  1 file changed, 89 insertions(+), 4 deletions(-)
> 
> -- 
> 2.37.1
> 
