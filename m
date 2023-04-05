Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA10D6D76C3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbjDEIXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237332AbjDEIXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:23:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12492108;
        Wed,  5 Apr 2023 01:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ovd5hXRsOE5BFiVbEKAgrCe4dxPYF+VcZXzpv2OMimY=; b=Akh/sDR+wFbMHLRn6PZBksVNhY
        tBk4gxN70DUw4NUU2NcTQH9548WjYjys1rc32Fqsyxmetdj6Juil9jWCZ+CuNhuXUFJlU1nZO05vO
        w+gdwNoUXtChwsB3HEwTqoT/L2d7J95EaRbsJIBUAW/6Yfd1pyIdzWvSrAHz8DmfXQdLdCLZEtNlU
        Qwd2wqBu7os59E2lA3ZcvArHuGRnExUR4IP/aIal2VQXKFov4Gz4+WG090bn0FfN3kt9B+lsSM5b1
        9KSksbvUpdzk2P8ho5hVBl9PlkZ1RCVL7nrkpwuikRPxQedlHEdhO4Cg/Ev3qbCfbblfo0hj/YAG1
        ZmFCU5hA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pjyPx-009ps6-28;
        Wed, 05 Apr 2023 08:22:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B7BF6300274;
        Wed,  5 Apr 2023 10:22:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6EB1926A69DAC; Wed,  5 Apr 2023 10:22:56 +0200 (CEST)
Date:   Wed, 5 Apr 2023 10:22:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Dai <davidai@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH 6/6] cpufreq: add kvm-cpufreq driver
Message-ID: <20230405082256.GY4253@hirez.programming.kicks-ass.net>
References: <20230330224348.1006691-1-davidai@google.com>
 <20230330224348.1006691-7-davidai@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330224348.1006691-7-davidai@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 03:43:41PM -0700, David Dai wrote:

> +struct remote_data {
> +	int ret;
> +	struct cpufreq_frequency_table *table;
> +};
> +
> +static void remote_get_freqtbl_num_entries(void *data)
> +{
> +	struct arm_smccc_res hvc_res;
> +	u32 freq = 1UL;
> +	int *idx = data;
> +
> +	while (freq != CPUFREQ_TABLE_END) {
> +		arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_KVM_GET_CPUFREQ_TBL_FUNC_ID,
> +				*idx, &hvc_res);
> +		if (hvc_res.a0) {
> +			*idx = -ENODEV;
> +			return;
> +		}
> +		freq = hvc_res.a1;
> +		(*idx)++;
> +	}
> +}
> +
> +static int kvm_cpufreq_get_freqtbl_num_entries(int cpu)
> +{
> +	int num_entries = 0;
> +
> +	smp_call_function_single(cpu, remote_get_freqtbl_num_entries, &num_entries, true);
> +	return num_entries;
> +}
> +
> +static void remote_populate_freqtbl(void *data)
> +{
> +	struct arm_smccc_res hvc_res;
> +	struct remote_data *freq_data = data;
> +	struct cpufreq_frequency_table *pos;
> +	struct cpufreq_frequency_table *table = freq_data->table;
> +	int idx;
> +
> +	cpufreq_for_each_entry_idx(pos, table, idx) {
> +		arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_KVM_GET_CPUFREQ_TBL_FUNC_ID,
> +				idx, &hvc_res);
> +		if (hvc_res.a0) {
> +			freq_data->ret = -ENODEV;
> +			return;
> +		}
> +		pos->frequency = hvc_res.a1;
> +	}
> +	freq_data->ret = 0;
> +}
> +
> +static int kvm_cpufreq_populate_freqtbl(struct cpufreq_frequency_table	*table, int cpu)
> +{
> +	struct remote_data freq_data;
> +
> +	freq_data.table = table;
> +	smp_call_function_single(cpu, remote_populate_freqtbl, &freq_data, true);
> +	return freq_data.ret;
> +}

*WHY* are you sending IPIs to do a hypercall ?!?

You can simply have the hypercall tell what vCPU you're doing this for.

