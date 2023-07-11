Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A79E74E948
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjGKIm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjGKImV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:42:21 -0400
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AD4BF;
        Tue, 11 Jul 2023 01:42:20 -0700 (PDT)
Received: from 82-132-229-125.dab.02.net ([82.132.229.125] helo=[192.168.252.81])
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qJ8wN-007Gds-VX; Tue, 11 Jul 2023 09:41:48 +0100
Message-ID: <74385f9d-ed8d-8906-13e3-b3091dae7993@codethink.co.uk>
Date:   Tue, 11 Jul 2023 09:41:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/3] soc: sifive: Add SiFive private L2 cache PMU driver
Content-Language: en-GB
To:     Eric Lin <eric.lin@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     conor@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu, maz@kernel.org,
        chenhuacai@kernel.org, baolu.lu@linux.intel.com, will@kernel.org,
        kan.liang@linux.intel.com, nnac123@linux.ibm.com,
        pierre.gondois@arm.com, jgross@suse.com, chao.gao@intel.com,
        maobibo@loongson.cn, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dslin1010@gmail.com, Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>, Nick Hu <nick.hu@sifive.com>
References: <20230616063210.19063-1-eric.lin@sifive.com>
 <20230616063210.19063-3-eric.lin@sifive.com>
 <20230616-revision-speed-a83dc926b334@wendy>
 <CAPqJEFo5genyjY7qJBaESzeppbEnTiDe9qzv98ETLhWfMZeG4A@mail.gmail.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <CAPqJEFo5genyjY7qJBaESzeppbEnTiDe9qzv98ETLhWfMZeG4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2023 04:14, Eric Lin wrote:
> On Fri, Jun 16, 2023 at 6:13 PM Conor Dooley <conor.dooley@microchip.com> wrote:
>>
>> On Fri, Jun 16, 2023 at 02:32:09PM +0800, Eric Lin wrote:
>>> From: Greentime Hu <greentime.hu@sifive.com>
>>>
>>> This adds SiFive private L2 cache PMU driver. User
>>> can use perf tool to profile by event name and event id.
>>>
>>> Example:
>>> $ perf stat -C 0 -e /sifive_pl2_pmu/inner_acquire_block_btot/
>>>                  -e /sifive_pl2_pmu/inner_acquire_block_ntob/
>>>                  -e /sifive_pl2_pmu/inner_acquire_block_ntot/ ls
>>>
>>>   Performance counter stats for 'CPU(s) 0':
>>>
>>>                 300      sifive_pl2_pmu/inner_acquire_block_btot/
>>>               17801      sifive_pl2_pmu/inner_acquire_block_ntob/
>>>                5253      sifive_pl2_pmu/inner_acquire_block_ntot/
>>>
>>>         0.088917326 seconds time elapsed
>>>
>>> $ perf stat -C 0 -e /sifive_pl2_pmu/event=0x10001/
>>>                  -e /sifive_pl2_pmu/event=0x4001/
>>>                  -e /sifive_pl2_pmu/event=0x8001/ ls
>>>
>>>   Performance counter stats for 'CPU(s) 0':
>>>
>>>                 251      sifive_pl2_pmu/event=0x10001/
>>>                2620      sifive_pl2_pmu/event=0x4001/
>>>                 644      sifive_pl2_pmu/event=0x8001/
>>>
>>>         0.092827110 seconds time elapsed
>>>
>>> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
>>> Signed-off-by: Eric Lin <eric.lin@sifive.com>
>>> Reviewed-by: Zong Li <zong.li@sifive.com>
>>> Reviewed-by: Nick Hu <nick.hu@sifive.com>
>>> ---
>>>   drivers/soc/sifive/Kconfig            |   9 +
>>>   drivers/soc/sifive/Makefile           |   1 +
>>>   drivers/soc/sifive/sifive_pl2.h       |  20 +
>>>   drivers/soc/sifive/sifive_pl2_cache.c |  16 +
>>>   drivers/soc/sifive/sifive_pl2_pmu.c   | 669 ++++++++++++++++++++++++++
>>
>> Perf drivers should be in drivers/perf, no?
>>
> 
> Hi Conor,
> 
> Yes, I see most of the drivers are in the drivers/perf.
> 
> But I grep perf_pmu_register(), it seems not all the pmu drivers are
> in drivers/perf as below:
> 
> arch/arm/mach-imx/mmdc.c:517:   ret =
> perf_pmu_register(&(pmu_mmdc->pmu), name, -1);
> arch/arm/mm/cache-l2x0-pmu.c:552:       ret =
> perf_pmu_register(l2x0_pmu, l2x0_name, -1);
> ...
> drivers/dma/idxd/perfmon.c:627: rc = perf_pmu_register(&idxd_pmu->pmu,
> idxd_pmu->name, -1);
> drivers/fpga/dfl-fme-perf.c:904:static int
> fme_perf_pmu_register(struct platform_device *pdev,
> drivers/fpga/dfl-fme-perf.c:929:        ret = perf_pmu_register(pmu, name, -1);
> ...
> drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:549:    ret =
> perf_pmu_register(&pmu_entry->pmu, pmu_name, -1);
> drivers/gpu/drm/i915/i915_pmu.c:1190:   ret =
> perf_pmu_register(&pmu->base, pmu->name, -1);
> drivers/hwtracing/coresight/coresight-etm-perf.c:907:   ret =
> perf_pmu_register(&etm_pmu, CORESIGHT_ETM_PMU_NAME, -1);
> drivers/hwtracing/ptt/hisi_ptt.c:895:   ret =
> perf_pmu_register(&hisi_ptt->hisi_ptt_pmu, pmu_name, -1);
> drivers/iommu/intel/perfmon.c:570:      return
> perf_pmu_register(&iommu_pmu->pmu, iommu_pmu->pmu.name, -1);
> drivers/nvdimm/nd_perf.c:309:   rc = perf_pmu_register(&nd_pmu->pmu,
> nd_pmu->pmu.name, -1);
> ...
> 
> I just wondering what kind of pmu drivers should be in drivers/perf
> and what kind of pmu drivers should not be in drivers/perf.
> Thanks.
>

Given the registers for the l2 cache controls and l2 pmu don't overlap
do we need the pmu and general cache drivers together?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

