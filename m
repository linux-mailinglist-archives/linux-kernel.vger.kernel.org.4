Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16ED62BAB1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbiKPLCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238967AbiKPLBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:01:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41F871FFA0;
        Wed, 16 Nov 2022 02:49:38 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A20C150C;
        Wed, 16 Nov 2022 02:49:44 -0800 (PST)
Received: from [10.57.40.76] (unknown [10.57.40.76])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E18253F663;
        Wed, 16 Nov 2022 02:49:36 -0800 (PST)
Message-ID: <774c9e6b-a8f4-66fe-aae0-d1cefedf7df3@arm.com>
Date:   Wed, 16 Nov 2022 10:49:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: linux-next: build failure after merge of the arm64 tree
To:     Besar Wicaksono <bwicaksono@nvidia.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20221116090401.0cd5ccc7@canb.auug.org.au>
 <SJ0PR12MB56762CFC0B8D680B05828EF8A0049@SJ0PR12MB5676.namprd12.prod.outlook.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <SJ0PR12MB56762CFC0B8D680B05828EF8A0049@SJ0PR12MB5676.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2022 23:52, Besar Wicaksono wrote:
> 
> 
>> -----Original Message-----
>> From: Stephen Rothwell <sfr@canb.auug.org.au>
>> Sent: Tuesday, November 15, 2022 4:04 PM
>> To: Catalin Marinas <catalin.marinas@arm.com>; Will Deacon
>> <will@kernel.org>
>> Cc: Besar Wicaksono <bwicaksono@nvidia.com>; Linux Kernel Mailing List
>> <linux-kernel@vger.kernel.org>; Linux Next Mailing List <linux-
>> next@vger.kernel.org>
>> Subject: linux-next: build failure after merge of the arm64 tree
>>
>> Hi all,
>>
>> After merging the arm64 tree, today's linux-next build (x86_64
>> allmodconfig) failed like this:
>>
>> drivers/perf/arm_cspmu/arm_cspmu.c: In function 'arm_cspmu_get_cpus':
>> drivers/perf/arm_cspmu/arm_cspmu.c:1114:29: error: implicit declaration of
>> function 'get_acpi_id_for_cpu' [-Werror=implicit-function-declaration]
>>   1114 |                             get_acpi_id_for_cpu(cpu)) {
>>        |                             ^~~~~~~~~~~~~~~~~~~
>>
> 
> +CC Suzuki for awareness.
> 
> This function is used for searching CPU with matching ACPI Processor ID in PPTT.
> I will check if adding PPTT dependency to arm_cspmu would resolve this issue.

Please make this dependent on ARM64. That should resolve the failure.
As such the helper is available with ARM64 && ACPI.

Suzuki

> 
> Regards,
> Besar
> 
>> Caused by commit
>>
>>    e37dfd65731d ("perf: arm_cspmu: Add support for ARM CoreSight PMU
>> driver")
>>
>> I have used the arm64 tree from next-20221115 for today.
>>
>> --
>> Cheers,
>> Stephen Rothwell

