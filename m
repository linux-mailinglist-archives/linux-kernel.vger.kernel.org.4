Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1A17290A5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237823AbjFIHO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjFIHOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:14:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 647F2272A;
        Fri,  9 Jun 2023 00:14:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43818AB6;
        Fri,  9 Jun 2023 00:15:08 -0700 (PDT)
Received: from [10.163.44.201] (unknown [10.163.44.201])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B954E3F71E;
        Fri,  9 Jun 2023 00:14:17 -0700 (PDT)
Message-ID: <584cb976-4e21-5dc2-bce2-cd6c3b5d1613@arm.com>
Date:   Fri, 9 Jun 2023 12:44:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V11 05/10] arm64/perf: Add branch stack support in ARMV8
 PMU
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230531040428.501523-1-anshuman.khandual@arm.com>
 <20230531040428.501523-6-anshuman.khandual@arm.com>
 <ZH3PCqYt/UzoiVx3@FVFF77S0Q05N>
 <ba396c30-6719-1dfb-77c2-9f7e1715b57c@arm.com>
 <290b577c-4740-d2e2-d236-c8bbe2f907b9@arm.com>
Content-Language: en-US
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <290b577c-4740-d2e2-d236-c8bbe2f907b9@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[..]

On 6/8/23 15:43, Suzuki K Poulose wrote:
>>> | static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
>>> | {
>>> |         struct armv8pmu_probe_info probe = {
>>> |                 .pmu = cpu_pmu,
>>> |                 .present = false,
>>> |         };
>>> |         int ret;
>>> |
>>> |         ret = smp_call_function_any(&cpu_pmu->supported_cpus,
>>> |                                     __armv8pmu_probe_pmu,
>>> |                                     &probe, 1);
>>> |         if (ret)
>>> |                 return ret;
>>> |         if (!probe.present)
>>> |                 return -ENODEV;
>>> |
>>> |           if (!arm_pmu_branch_stack_supported(cpu_pmu))
>>> |             return 0;
>>> |
>>> |         ret = armv8pmu_private_alloc(cpu_pmu);
>>> |         if (ret)
>>> |         return ret;
>>> |       
>>> |          ret = branch_records_alloc(cpu_pmu);
>>> |          if (ret)
>>> |          armv8pmu_private_free(cpu_pmu);
>>> |       
>>> |        return ret;
>>> | }


After splitting the task ctx cache management from pmu private data
management, the above function will look something like this taking
care of all error path freeing as well.

static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
{
        struct armv8pmu_probe_info probe = {
                .pmu = cpu_pmu,
                .present = false,
        };
        int ret;

        ret = armv8pmu_private_alloc(cpu_pmu);
        if (ret)
                return ret;

        ret = smp_call_function_any(&cpu_pmu->supported_cpus,
                                    __armv8pmu_probe_pmu,
                                    &probe, 1);
        if (ret)
                goto probe_err;

        if (!probe.present) {
                ret = -ENODEV;
                goto probe_err;
        }

        if (cpu_pmu->has_branch_stack) {
                ret = armv8pmu_task_ctx_cache_alloc(cpu_pmu);
                if (ret)
                        goto probe_err;

                ret = branch_records_alloc(cpu_pmu);
                if (ret) {
                        armv8pmu_task_ctx_cache_free(cpu_pmu);
                        goto probe_err;
                }
                return 0;
        }
        armv8pmu_private_free(cpu_pmu);
        return 0;

probe_err:
        armv8pmu_private_free(cpu_pmu);
        return ret;
}
