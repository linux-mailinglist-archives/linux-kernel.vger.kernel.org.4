Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11197715AF0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjE3KCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjE3KCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:02:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F03293;
        Tue, 30 May 2023 03:02:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C44EAB6;
        Tue, 30 May 2023 03:03:00 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AC5F3F67D;
        Tue, 30 May 2023 03:02:12 -0700 (PDT)
Message-ID: <c0a23406-662d-cb85-e68c-5775de6b9440@arm.com>
Date:   Tue, 30 May 2023 12:02:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 09/17] PM: EM: Add RCU mechanism which safely cleans
 the old data
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        Pierre.Gondois@arm.com, ionela.voinescu@arm.com,
        rostedt@goodmis.org, mhiramat@kernel.org
References: <20230512095743.3393563-1-lukasz.luba@arm.com>
 <20230512095743.3393563-10-lukasz.luba@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230512095743.3393563-10-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 11:57, Lukasz Luba wrote:
> The EM is going to support runtime modifications of the power data.
> In order to achieve that prepare the internal mechanism. This patch
> introduces RCU safe mechanism to clean up the old allocated EM data.

s/In order to achieve that prepare the internal mechanism. This patch
introduces/Introduce ... much shorter, same information.

[...]

> +static void em_perf_runtime_table_set(struct device *dev,
> +				      struct em_perf_table *runtime_table)
> +{
> +	struct em_perf_domain *pd = dev->em_pd;
> +	struct em_perf_table *tmp;
> +
> +	tmp = pd->runtime_table;
> +
> +	rcu_assign_pointer(pd->runtime_table, runtime_table);
> +
> +	em_cpufreq_update_efficiencies(dev, runtime_table->state);
> +
> +	if (trace_em_perf_state_enabled()) {
> +		unsigned long freq, power, cost, flags;
> +		int i;
> +
> +		for (i = 0; i < pd->nr_perf_states; i++) {
> +			freq = runtime_table->state[i].frequency;
> +			power = runtime_table->state[i].power;
> +			cost = runtime_table->state[i].cost;
> +			flags = runtime_table->state[i].flags;
> +
> +			trace_em_perf_state(dev_name(dev), pd->nr_perf_states,
> +					    i, freq, power, cost, flags);
> +		}
> +	}
> +
> +	/*
> +	 * Check if the 'state' array is not actually the one from setup.
> +	 * If it is then don't free it.
> +	 */
> +	if (tmp->state == pd->table)

It's unfortunate that you have the refactoring in 13/17 which would lead to:

 if (pd->runtime_table>state == pd->default_table->state)
         ^^^^^^^^^^^^^              ^^^^^^^^^^^^^

so people would immediately grasp one of the core concepts of the
design: non-modifiable default_table and modifiable runtime_table.

I still belief that it would be the better idea to do the refactoring first.

[...]
