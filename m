Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4DC6B43D1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjCJOSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjCJORz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:17:55 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0B1733A4;
        Fri, 10 Mar 2023 06:16:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+4vdg3yQh50WI4CUitxXCl7z3Pisru/a5f+6srqjVu3YKodoclhS6BhKMbPKXx4HiyZ3tEwpunD7TemsEzX9LC8Jo1PTlGUZl+wDwN57g7DaR8uccjSO9ZxKlwVPWnu/PP7zkAdedTIpPqISWe4wzZHm7Z06k3FkQKoTmWqXigHAyPrtfHTVtuSL/s99YcokutvdenmFhMulVHhqSfmRP8AbDJU+wBjTvPiIiOLRmRPR2crbDRuM80fbr7oqn9cLunUOyD6HvOpoAN6+SKGcLTPL6gA4Uo1J9G0v3mt5qLLViCwcdYv3uCJo+fuyQ+LIxAac/DNHMzKFriSQdOykg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nngG9GxjWzp0dvWFluH3E9qb3s22/PJuImoOq7drnL0=;
 b=eYMpzB0BXcS3rhnfVpL9iwJtZEMnh1hJ4OQ/mne832PkEzXkyQpTccI19j37FDqADIRMKmB+XA1r/HAxcr8PEh6+SNqVeaVyiTD9nItLVJzMvU0B1Z0Gif38e2r8QZWJa4NN2kae1lZO5KNZHH1LyhC+IleUi/e2PCAq4uuF5eCEAAx1RASLj7d3HEuMTvvEQCT3PExzfa9acheAJG3I2Xx6o0WnMap3+02klkhN66kLNfAQe4X9dBLZNSdu1cMp0KUqgH5iB7csmK1Dpq/fRyaLZdnDh10h1YLRw2HICeGlvIZcE5XJNSYY9Aq+tanmlrDHzopiJHjjnaV+Ki5M/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nngG9GxjWzp0dvWFluH3E9qb3s22/PJuImoOq7drnL0=;
 b=kM0lvFqSkGHRFid7WwnOBFl6hh+CO4cPvnPtYguKD/OcreCkd7JVlycgm4r4+4ma7kzeb1NISrKyGkSf4yXorYXni1FKYW44mXFlTc56V783prCeP1hj0Hv8RDCv5w0UliwNd/CXLrLhTOECu8mrr/Jy3SBUn6pSzWiUE5bAs2n92kVgankb7Sf+Hy9KugeFo4kF9hvjIs2c7qRuWil1nkFjgMWZAPjPRU7XdNrXw/OxyTU70JjF8xTDYLy9zJJ9hy36yxyT4GirnuC7NW5C9j2j6FODwRcQwXf26K92OjSzHn9FEeG7HE/qAanM8unyuFOsoCsv2gsWQCZQqqBgzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by MN2PR12MB4520.namprd12.prod.outlook.com (2603:10b6:208:26f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 14:16:39 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f3e4:c5a8:7103:8ef1]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f3e4:c5a8:7103:8ef1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 14:16:39 +0000
Message-ID: <ff5306c3-c72e-87a3-f21f-13cdf11e1df5@nvidia.com>
Date:   Fri, 10 Mar 2023 08:16:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] irqchip/gicv3: Workaround for NVIDIA erratum
 T241-FABRIC-4
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vikram Sethi <vsethi@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
References: <20230306013148.3483335-1-sdonthineni@nvidia.com>
 <87ilfdgdx9.wl-maz@kernel.org>
From:   Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <87ilfdgdx9.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:74::22) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|MN2PR12MB4520:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fdbce92-9c27-47bf-2810-08db2172107f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M3RI+BS3xefOdGHoUs/l/PS0jJXMied5d4/G0mWjRiV3GuV0cqvPiR025am9qqYM4UH01+jNbrdC0uKTzw0598g0fkf9sc9/e3uZI1J55PUsteiFRvXGSSc0xabvF1AtMWMNuOWaUI8+RsKgFqOrgnJwwkuJg9VT/G12WzJQEi9HaTuDOnkeliK8DwVmF+gmNitu96ln9ADfT4UPvuXw8I251M7cpZwCFxlZLZRacEEZ5jt8gymlWIz5p+qNmFXZBI9Y9Srui3SiXTdYtzDNFYJnI7R78Fyl1WqiqNFzqf0Pe37Dm0boTdbDpIWg8ijJ5HO3/p44CLBZf1FYdLcxQyzrqwz94C1ZWnz4aU0W1KEZTFjJg+8jEp/O2mxQgr+wTKnjovDu3KfMHuzOWUsnWny8A2Wk98E8i9CdEHwg5jY2+OplyPQ33U71Eoo2m7h46pGC9BV5yNgjkfmTdXEv2cQ6hzyqvxlRfzWh4JuS0IYHPppBWmrDCIN8AZLn5ba8H3/wqT1ob+hvj6UdV5dMWNouNq/CjNOCIA5MI270jnmTOR6a0IIeztZLQjH9NSRhBOy15l7pq/Gf1dQ+Gs7np6069ALoq+gg1ypCSRnnlYHqBQUoUoeovjphei6fjvkKwN2CfzWler7dDLTfoSbEnKInquWU0to8/mQBh8ZKMqmnLXT48zWdATE6afUA1DaH8VttniPP9UFU7zYQPcUHOnpvwctU/LBfxO7qqYoxTuB5CGrtex4jpt3u781hGnngGBKRrH+npOMyqNSPVx5LEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199018)(36756003)(6486002)(966005)(186003)(53546011)(107886003)(5660300002)(83380400001)(26005)(6666004)(2616005)(6512007)(41300700001)(66476007)(6916009)(8936002)(66556008)(8676002)(4326008)(2906002)(6506007)(66946007)(30864003)(38100700002)(86362001)(316002)(478600001)(31696002)(54906003)(31686004)(66899018)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzM4VXZDTzl4NkhzL1dKbS9NMWx4cHA1aGRNZGprYi9rVjZ4aHJad0MvRUdR?=
 =?utf-8?B?Rzg2eDAzSk1mYTJ3a2NPL1R0eWNOR3hNdmR5UkQ4RzBwdGtJTW1BbGFxZDJW?=
 =?utf-8?B?QXZMcmNIN09WL1pvSmVBZEVweFAwakxuQksxTmg4U2JkS3UxV0syM0NXUVgr?=
 =?utf-8?B?bXdmRkw5eCtZMGVFUXo0UUJMbW8raHRMQmxHMDVjTFJkM0p3dWMwb3JSdlVy?=
 =?utf-8?B?QUxnZGZ0T2FSRlhpN0Y3QzJVTW9kY0xLTjhpMkxodUtjRTBUMVZZN1NiVDdy?=
 =?utf-8?B?b3cvUGNLRHNIejJpNlg5bndTWUtwUDAxQllDS3hyMjZ5UFlIbkdaNHVXSlBV?=
 =?utf-8?B?dDQ3SlNXNVZvem5sRW0xbWdFWjliZEVQOFp3ZVB4Q3JUUlBlM1VoZUlaYkVX?=
 =?utf-8?B?aEdWTHdlNFJUSE0rRzkyZWUyQ0tPalJrY3hITVdpbjNHNlA5ZjN1YzByUzJX?=
 =?utf-8?B?NlJGZjNPd3I1YmNCOGhkVEZBbHRVenJaWDlsdmJyRms1MExYaWdsZ0hSVWRY?=
 =?utf-8?B?aDQ0VENadEJTS0tUbTBNWkgvVzZqTm5NWG5LV2dUd1RNV2JOTXR0SFBLaDNW?=
 =?utf-8?B?L01rLy9YN3lPVG1CMW9kYndHcUJURUFjVmNLWENYWHNMeWtwMmhYM0RjQjdH?=
 =?utf-8?B?VUhHRCtjTU4za2g0RlIyK0xpb3NDZUJzUG5ES1RGaGluUXZla0djWkxRS0JR?=
 =?utf-8?B?c0d0R0ZWandGazBYVkpJQUdrYUE1SWRiNkNZVjlNRzNoQ09oNVlabjdYWUhh?=
 =?utf-8?B?amJrZHg2bitWdWIxdmpENFNnSU05bzdsWnJybHdpb25BRkFBVFJVNStMVUxQ?=
 =?utf-8?B?WEc1ckdzdnRKNmgzeWZLOEtlM1JKb2o5ZG8vYVIrWFVDUmZEOGc1TFJTcDRB?=
 =?utf-8?B?VDkxb2M5cWIvUEFLeWxtcFZyMXBFVWVVK0QwNE9rTEV4M01rbkxCMVMzL0Vm?=
 =?utf-8?B?YnRrNXp5VUhjVWdOUEtUQkpDRWJYZTBWaUtoRnZqTFVXT2xMT1lISlZGcjBa?=
 =?utf-8?B?dW8wQzlGSnVSazR2ZmdlL0VSSGc0Tys3QkVQZndFNy84RFhBRHpibzUyYURz?=
 =?utf-8?B?cDFzWnZza21GdnBHVk5tN2lYKzRRK095VXIwME00WENnVzZrcEVvT2RocEx1?=
 =?utf-8?B?eGx2Q05GY1RyK1A4Q1NVTWtIQ2F4MnNqblMwaTZodTNMV3RQbEhzQUtiekpW?=
 =?utf-8?B?MHF1S2pCUjJiZSs4L2NCclpiQy9hbjlYLzRqd05xNFhEelp4Tyt0N05UYkdp?=
 =?utf-8?B?NFdZdHZxM1pOY1BLeVIyOFFnNnhINlk4SThrL0FGckVmUEs2cDA2TWUwc3Jm?=
 =?utf-8?B?aXZ0VWhGZHQ4Vm1OdUxrL3dhYVZXSzgxdUMvTGNCcXlSaDNYN2Q5NGwzcEtS?=
 =?utf-8?B?T3JEdWVkNkN3OS9oVHI2S1ErWUJhR0lsOUlvZDhZVHNENXRzMjNqMUplSnlj?=
 =?utf-8?B?YzByTFBocEQwR2RubEh1Z0N6c0xURmlHcHZxNVlRbnlUc05USmIybGZPd0dv?=
 =?utf-8?B?ZEVpTDBFa003eURXcElNU0Y3Z2JzaTUvcHh3RmIxSml5Z0FmS3hiUFVuZHU3?=
 =?utf-8?B?dWpJWFNaV0dpRmFTM2lDUTB5cmo4SmVMOEd5clEzVVlpMVJFMXcvcnNGNlB4?=
 =?utf-8?B?eDBpTXQwVklibGphdVFmQm1CWWovcEpUZGtMb2VDc0dZcHNnWFZiaU11Y01M?=
 =?utf-8?B?THdXT2cwQUFXOENSVUNuaG8rOXdycEhyUi96WFV2TzJyelBONFZlQm5WNXVp?=
 =?utf-8?B?SGM2NzM1YnFqVXkxVjQrVVIwWG1JaTQ2R29MbVUxa0NiVm1YcTJzNFFnSE0z?=
 =?utf-8?B?NzE5QThsMDZVOG5ZQWVzdTBWZ3YrUGphWEJtTU91NEhCcEZ3MEZCK1lIakl2?=
 =?utf-8?B?bUh5UDRxOGE1WmVkVWZZRXM0TnRHaG9LclVtbEhHbEpuMktzVGU0NW9wekc4?=
 =?utf-8?B?c0xISXgxeDF1aE5XSllYNHUwNVczZXpDczBKTFdGcndDencyV09lcWV0bHA3?=
 =?utf-8?B?Z0VUa0pnSFNKaW9qTm5PUk1ONy9hdG5NYWhKZXU0ZVA5UVZiWUtqbG40V3p6?=
 =?utf-8?B?L09iM0tLQUJ6R2pEbVJMV28wbkd4R1ZJTFpMWXZSTm8yQ25TYmtBbDc4eHVV?=
 =?utf-8?B?Q0lsZmx4Q3VEYU1DUFNISjBqYjJLSGxnSUQ1SGVubjNTZjlDQWpieTY3bkdY?=
 =?utf-8?B?MXc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fdbce92-9c27-47bf-2810-08db2172107f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 14:16:39.2157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 423ZjXdLMv11E4AEggiJRo3SaghAY0E6Aq9boiOjtG4GrDVZgif81RY6jXIFwiFAMcbC6QaqRLmXpi+njcftLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4520
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 3/7/23 02:32, Marc Zyngier wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Mon, 06 Mar 2023 01:31:48 +0000,
> Shanker Donthineni <sdonthineni@nvidia.com> wrote:
>>
>> The purpose of this patch is to address the T241 erratum T241-FABRIC-4,
>> which causes unexpected behavior in the GIC when multiple transactions
> 
> nit: "The purpose of this patch" is superfluous. Instead, write
> something like:
> 
> "The T241 platform suffers from the T241-FABRIC-4 erratum which
> causes..."
> 
I'll fix in v2 patch.

>> are received simultaneously from different sources. This hardware issue
>> impacts NVIDIA server platforms that use more than two T241 chips
>> interconnected. Each chip has support for 320 {E}SPIs.
>>
>> This issue occurs when multiple packets from different GICs are
>> incorrectly interleaved at the target chip. The erratum text below
>> specifies exactly what can cause multiple transfer packets susceptible
>> to interleaving and GIC state corruption. GIC state corruption can
>> lead to a range of problems, including kernel panics, and unexpected
>> behavior.
>>
>>  From the erratum text:
>>    "In some cases, inter-socket AXI4 Stream packets with multiple
>>    transfers, may be interleaved by the fabric when presented to ARM
>>    Generic Interrupt Controller. GIC expects all transfers of a packet
>>    to be delivered without any interleaving.
>>
>>    The following GICv3 commands may result in multiple transfer packets
>>    over inter-socket AXI4 Stream interface:
>>     - Register reads from GICD_I* and GICD_N*
>>     - Register writes to 64-bit GICD registers other than GICD_IROUTERn*
>>     - ITS command MOVALL
> 
> Does is also affect cross-chip traffic such as SPI deactivation?
> 
No, it is not impacted.

>>
>>    Multiple commands in GICv4+ utilize multiple transfer packets,
>>    including VMOVP, VMOVI and VMAPP.
>>
>>    This issue impacts system configurations with more than 2 sockets,
>>    that require multi-transfer packets to be sent over inter-socket
>>    AXI4 Stream interface between GIC instances on different sockets.
>>    GICv4 cannot be supported. GICv3 SW model can only be supported
>>    with the workaround. Single and Dual socket configurations are not
>>    impacted by this issue and support GICv3 and GICv4."
> 
> Do you have a public link to this erratum? This is really something
> that we should be go back to when changing things in the GIC code
> (should we ever use MOVALL, for example).
> 
https://developer.nvidia.com/docs/t241-fabric-4/nvidia-t241-fabric-4-errata.pdf

> But kudos for disclosing the problem -- this is a much better attitude
> than the usual "hide the crap under the carpet" upheld by the other
> platform vendors.
> 
>>
>> To fix this problem, the patch implements a workaround that ensures
> 
> s/this patch implements/implement/
> 
>> read accesses to the GICD_In{E} registers are directed to the chip
>> that owns the SPI, and disables GICv4.x features for KVM.
>>
>> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
>> Signed-off-by: Vikram Sethi <vsethi@nvidia.com>
> 
> This SoB chain looks wrong. It needs at least a Co-developed-by: tag.
> 
I'll fix in v2.

>> ---
>>   Documentation/arm64/silicon-errata.rst |   2 +
>>   drivers/irqchip/irq-gic-common.c       |  10 +-
>>   drivers/irqchip/irq-gic-common.h       |   3 +-
>>   drivers/irqchip/irq-gic-v3.c           | 124 +++++++++++++++++++++++--
>>   drivers/irqchip/irq-gic.c              |   3 +-
>>   drivers/irqchip/irq-hip04.c            |   2 +-
>>   6 files changed, 131 insertions(+), 13 deletions(-)
>>
>> diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
>> index ec5f889d76819..e31f6c0687041 100644
>> --- a/Documentation/arm64/silicon-errata.rst
>> +++ b/Documentation/arm64/silicon-errata.rst
>> @@ -172,6 +172,8 @@ stable kernels.
>>   +----------------+-----------------+-----------------+-----------------------------+
>>   | NVIDIA         | Carmel Core     | N/A             | NVIDIA_CARMEL_CNP_ERRATUM   |
>>   +----------------+-----------------+-----------------+-----------------------------+
>> +| NVIDIA         | T241 GICv3/4.x  | T241-FABRIC-4   | N/A                         |
>> ++----------------+-----------------+-----------------+-----------------------------+
>>   +----------------+-----------------+-----------------+-----------------------------+
>>   | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585         |
>>   +----------------+-----------------+-----------------+-----------------------------+
>> diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
>> index a610821c8ff2a..83b2187d342af 100644
>> --- a/drivers/irqchip/irq-gic-common.c
>> +++ b/drivers/irqchip/irq-gic-common.c
>> @@ -39,7 +39,8 @@ void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
>>   }
>>
>>   int gic_configure_irq(unsigned int irq, unsigned int type,
>> -                    void __iomem *base, void (*sync_access)(void))
>> +                   void __iomem *base, void (*sync_access)(void),
>> +                   void __iomem *base_read_alias)
>>   {
>>        u32 confmask = 0x2 << ((irq % 16) * 2);
>>        u32 confoff = (irq / 16) * 4;
>> @@ -52,7 +53,10 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
>>         * for "irq", depending on "type".
>>         */
>>        raw_spin_lock_irqsave(&irq_controller_lock, flags);
>> -     val = oldval = readl_relaxed(base + confoff);
>> +     if (base_read_alias == NULL)
>> +             base_read_alias = base;
>> +
>> +     val = oldval = readl_relaxed(base_read_alias + confoff);
>>        if (type & IRQ_TYPE_LEVEL_MASK)
>>                val &= ~confmask;
>>        else if (type & IRQ_TYPE_EDGE_BOTH)
>> @@ -73,7 +77,7 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
>>         * non-secure mode, and hence it may not be catastrophic.
>>         */
>>        writel_relaxed(val, base + confoff);
>> -     if (readl_relaxed(base + confoff) != val)
>> +     if (readl_relaxed(base_read_alias + confoff) != val)
>>                ret = -EINVAL;
> 
> Do we really need the two base addresses? For a given SPI range
> belonging to a given distributor, you should be able to use the same
> MMIO region for both read and writes.
> 
> This would save a lot of churn.
> 
When writing to the GICD_In{E} registers' chip alias region, except for
GICD_ICENABLERn, it has the same effect as writing to the global distributor.
To minimize code modifications, I will use the same base address for both
read and write operations within the gic_configure_irq() function.

> Or is there another requirement that writes always happen via the
> global alias?
> 
The hardware team has recommended to use a global distributor for writes
to GICD_ICENABLERn and GCD_CTRL.RWP poll.

>>
>>        raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
>> diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
>> index ..c955f83d1f8f2 100644
27e3d4ed4f328>> --- a/drivers/irqchip/irq-gic-common.h
>> +++ b/drivers/irqchip/irq-gic-common.h
>> @@ -19,7 +19,8 @@ struct gic_quirk {
>>   };
>>
>>   int gic_configure_irq(unsigned int irq, unsigned int type,
>> -                       void __iomem *base, void (*sync_access)(void));
>> +                   void __iomem *base, void (*sync_access)(void),
>> +                   void __iomem *base_read_alias);
>>   void gic_dist_config(void __iomem *base, int gic_irqs,
>>                     void (*sync_access)(void));
>>   void gic_cpu_config(void __iomem *base, int nr, void (*sync_access)(void));
>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>> index 997104d4338e7..f460f832c87e6 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -45,6 +45,13 @@ struct redist_region {
>>        bool                    single_redist;
>>   };
>>
>> +/* Distributor alias region for {E}SPIs registers */
>> +struct dist_base_alias {
>> +     u32             intid_start;
>> +     u32             intid_end;
>> +     void __iomem    *base;
>> +};
>> +
>>   struct gic_chip_data {
>>        struct fwnode_handle    *fwnode;
>>        void __iomem            *dist_base;
>> @@ -57,8 +64,12 @@ struct gic_chip_data {
>>        bool                    has_rss;
>>        unsigned int            ppi_nr;
>>        struct partition_desc   **ppi_descs;
>> +     struct dist_base_alias  *base_read_aliases;
>> +     u32                     nr_dist_base_aliases;
>>   };
>>
>> +static DEFINE_STATIC_KEY_FALSE(gic_nvidia_t241_erratum);
>> +
>>   static struct gic_chip_data gic_data __read_mostly;
>>   static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
>>
>> @@ -188,6 +199,26 @@ static inline bool gic_irq_in_rdist(struct irq_data *d)
>>        }
>>   }
>>
>> +static inline void __iomem *gic_dist_base_read_alias(irq_hw_number_t intid)
>> +{
>> +     struct dist_base_alias *base_alias;
>> +     int i;
>> +
>> +     if (static_branch_unlikely(&gic_nvidia_t241_erratum)) {
>> +             base_alias = gic_data.base_read_aliases;
>> +             for (i = 0; i < gic_data.nr_dist_base_aliases; i++) {
>> +                     if (base_alias->base &&
>> +                        (intid >= base_alias->intid_start) &&
>> +                        (intid <= base_alias->intid_end)) {
>> +                             return base_alias->base;
>> +                     }
>> +                     base_alias++;
>> +             }
>> +     }
> 
> Each distributor has the exact same number of SPIs. So why isn't this
> just a division that gives you a distributor number?
> 

I considered creating a generic function that could potentially be
utilized in the future for other Workarounds (WARs).

I'll change to this in v2.

static inline void __iomem *gic_dist_base_alias(irq_hw_number_t intid)
{
         u32 chip;

         if (static_branch_unlikely(&gic_nvidia_t241_erratum)) {
                 /**
                  *  {E}SPI mappings for all 4 chips
                  *    Chip0 = 32-351
                  *    Chip1 = 52-671
                  *    Chip2 = 672-991
                  *    Chip3 = 4096-4415
                  */
                 switch (__get_intid_range(intid)) {
                 case SPI_RANGE:
                         chip = (intid - 32) / 320;
                         break;
                 case ESPI_RANGE:
                         chip = 3;
                         break;
                 default:
                         unreachable();
                 }
                 BUG_ON(!t241_dist_base_alias[chip]);
                 return t241_dist_base_alias[chip];
         }

         return gic_data.dist_base;
}

>> +
>> +     return gic_data.dist_base;
>> +}
>> +
>>   static inline void __iomem *gic_dist_base(struct irq_data *d)
>>   {
>>        switch (get_intid_range(d)) {
>> @@ -346,7 +377,7 @@ static int gic_peek_irq(struct irq_data *d, u32 offset)
>>        if (gic_irq_in_rdist(d))
>>                base = gic_data_rdist_sgi_base();
>>        else
>> -             base = gic_data.dist_base;
>> +             base = gic_dist_base_read_alias(irqd_to_hwirq(d));
>>
>>        return !!(readl_relaxed(base + offset + (index / 32) * 4) & mask);
>>   }
>> @@ -580,6 +611,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
>>        enum gic_intid_range range;
>>        unsigned int irq = gic_irq(d);
>>        void __iomem *base;
>> +     void __iomem *base_read_alias;
>>        u32 offset, index;
>>        int ret;
>>
>> @@ -594,14 +626,17 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
>>            type != IRQ_TYPE_LEVEL_HIGH && type != IRQ_TYPE_EDGE_RISING)
>>                return -EINVAL;
>>
>> -     if (gic_irq_in_rdist(d))
>> +     if (gic_irq_in_rdist(d)) {
>>                base = gic_data_rdist_sgi_base();
>> -     else
>> +             base_read_alias = base;
>> +     } else {
>>                base = gic_data.dist_base;
>> +             base_read_alias = gic_dist_base_read_alias(irqd_to_hwirq(d));
>> +     }
>>
>>        offset = convert_offset_index(d, GICD_ICFGR, &index);
>> -
>> -     ret = gic_configure_irq(index, type, base + offset, NULL);
>> +     ret = gic_configure_irq(index, type, base + offset, NULL,
>> +                             base_read_alias + offset);
>>        if (ret && (range == PPI_RANGE || range == EPPI_RANGE)) {
>>                /* Misconfigured PPIs are usually not fatal */
>>                pr_warn("GIC: PPI INTID%d is secure or misconfigured\n", irq);
>> @@ -1719,6 +1754,70 @@ static bool gic_enable_quirk_hip06_07(void *data)
>>        return false;
>>   }
>>
>> +static bool gic_enable_quirk_nvidia_t241(void *data)
>> +{
>> +#ifdef CONFIG_ACPI
>> +     struct dist_base_alias *base_alias;
>> +     struct acpi_table_header *madt;
>> +     int i, intid, nchips = 0;
>> +     acpi_status status;
>> +     phys_addr_t phys;
>> +
>> +     status = acpi_get_table(ACPI_SIG_MADT, 0, &madt);
>> +     if (ACPI_FAILURE(status))
>> +             return false;
>> +
>> +     /* Check NVIDIA OEM ID */
>> +     if (memcmp(madt->oem_id, "NVIDIA", 6)) {
> 
> What guarantees do we have that this string will always be present?
> "oem_id" is usually updated to reflect the integrator, not the
> silicon vendor.
> 

Our company provides UEFI firmware porting guidelines to OEMs that
ensure the MADT table generation, along with the ACPI header, remains
unaltered. Thanks to your input, we are now looking into alternative
approaches for identifying platform types and removing our dependence
on ACPI. Specifically, we are interested in utilizing the SMCCC API
to detect the CHIP. Determine whether the individual chips are present
by referring to the GICR regions described in MADT.


>> +             acpi_put_table(madt);
>> +             return false;
>> +     }
>> +
>> +     /* Find the number of chips based on OEM_TABLE_ID */
>> +     if ((!memcmp(madt->oem_table_id, "T241x3", 6)) ||
>> +         (!memcmp(madt->oem_table_id, "T241c3", 6))) {
>> +             nchips = 3;
>> +     } else if ((!memcmp(madt->oem_table_id, "T241x4", 6)) ||
>> +                (!memcmp(madt->oem_table_id, "T241c4", 6))) {
>> +             nchips = 4;
>> +     }
> 
> Same question for these. This seems pretty fragile.
> 
This can be avoid for the SMCCC based platform detection.

>> +
>> +     acpi_put_table(madt);
>> +     if (nchips < 3)
>> +             return false;
>> +
>> +     base_alias = kmalloc_array(nchips, sizeof(*base_alias),
>> +                                GFP_KERNEL | __GFP_ZERO);
> 
> You are fully initialising the structures, right? So why the
> __GFP_ZERO?
Yes, not needed. will use the staic array since size is small after
removing INTID_start/end feilds.

> 
>> +     if (!base_alias)
>> +             return false;
>> +
>> +     gic_data.base_read_aliases = base_alias;
>> +     gic_data.nr_dist_base_aliases = nchips;
>> +
>> +     /**
>> +      * Setup GICD alias and {E}SPIs range for each chip
>> +      * {E}SPI blocks mappings:
>> +      *    Chip0 = 00-09
>> +      *    Chip1 = 10-19
>> +      *    Chip2 = 20-29
>> +      *    Chip3 = 30-39
> 
> What are these ranges? From the code below, I can (sort of) guess that
> each chip has 10 registers in the SPI/ESPI range, with chips 0-1
> dealing with SPIs, and chips 2-3 dealing with ESPIs.
> 
> It would be a lot clearer if you indicated the actual INTID ranges.
Agree.

> 
>> +      */
>> +     for (i = 0; i < nchips; i++, base_alias++) {
>> +             phys = ((1ULL << 44) * i) | 0x23580000;
> 
> Where is this address coming from? Can it be inferred from the MADT?
> It would also be a lot more readable if written as:
> 
> #define CHIP_MASK       GENMASK_ULL(45, 44)
> #define CHIP_ALIAS_BASE 0x23580000
> 
I'll define macros for constants. Use the offset, global GICD-PHYS,
and CHIP number to get the alias addressses.

#define T241_CHIPN_MASK                 GENMASK_ULL(45, 44)
#define T241_CHIP_GICDA_OFFSET          0x1580000

      phys = gic_data.dist_phys_base + T241_CHIP_GICDA_OFFSET;
      phys |= FIELD_PREP(T241_CHIPN_MASK, i);


>                  phys = CHIP_ALIAS_BASE;
>                  phys |= FIELD_PREP(CHIP_MASK, i);
> 
>> +             base_alias->base = ioremap(phys, SZ_64K);
>> +             WARN_ON(!base_alias->base);
>> +
>> +             intid = i < 3 ? 32 + i * 10 * 32 : ESPI_BASE_INTID;
>> +             base_alias->intid_start = intid;
>> +             base_alias->intid_end = intid + 10 * 32 - 1;
> 
> This really is obfuscated. And it also shows that we really don't need
> the INTID ranges in the data structure. You can easily get to the chip
> number with something like:
ACK

> 
>          switch (__get_intid_range(intid)) {
>          case SPI_RANGE:
>                  chip = (intid - 32) / 320;
>                  break;
>          case ESPI_RANGE:
>                  chip = (intid - ESPI_BASE_INTID) / 320;
>                  break;
>          }
> 
>          alias = base_alias[chip];
> 
> Bonus point if you add a #define for the magic numbers.
> 
ACK

>> +     }
>> +     static_branch_enable(&gic_nvidia_t241_erratum);
>> +     return true;
>> +#else
>> +     return false;
>> +#endif
>> +}
> 
> How about moving the whole function under #ifdef CONFIG_ACPI?
> 
  

If you're not satisfied with SMCCC-based platform detection, I'll
make the necessary changes. We value your input and would appreciate
your opinion on whether we should use SMCCC or ACPI-OEM-ID based
platform detection. Our preference is to go with SMC if that's
agreeable to you.


#define SMCCC_JEP106_BANK_ID(v)         FIELD_GET(GENMASK(30, 24), (v))
#define SMCCC_JEP106_ID_CODE(v)         FIELD_GET(GENMASK(22, 16), (v))
#define SMCCC_JEP106_SOC_ID(v)          FIELD_GET(GENMASK(15, 0), (v))

#define JEP106_NVIDIA_BANK_ID           0x3
#define JEP106_NVIDIA_ID_CODE           0x6b
#define T241_CHIPN_MASK                 GENMASK_ULL(45, 44)
#define T241_CHIP_GICDA_OFFSET          0x1580000
#define T241_CHIP_ID                    0x241

static bool gic_enable_quirk_nvidia_t241(void *data)
{
         unsigned long chip_bmask = 0;
         struct arm_smccc_res res;
         phys_addr_t phys;
         u32 i;

         if ((arm_smccc_get_version() < ARM_SMCCC_VERSION_1_2) ||
             (arm_smccc_1_1_get_conduit() == SMCCC_CONDUIT_NONE)) {
                 return false;
         }

         arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
                              ARM_SMCCC_ARCH_SOC_ID, &res);
         if ((s32)res.a0 < 0)
                 return false;

         arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 0, &res);
         if ((s32)res.a0 < 0)
                 return false;

         /* Check JEP106 code for NVIDIA T241 chip (036b:0241) */
         if ((SMCCC_JEP106_BANK_ID(res.a0) != JEP106_NVIDIA_BANK_ID) ||
             (SMCCC_JEP106_ID_CODE(res.a0) != JEP106_NVIDIA_ID_CODE) ||
             (SMCCC_JEP106_SOC_ID(res.a0) != T241_CHIP_ID)) {
                 return false;
         }

         /* Find the chips based on GICR regions PHYS addr */
         for (i = 0; i < gic_data.nr_redist_regions; i++) {
                 chip_bmask |= BIT(FIELD_GET(T241_CHIPN_MASK,
                                   gic_data.redist_regions[i].phys_base));
         }

         if (hweight32(chip_bmask) < 3)
                 return false;

         /* Setup GICD alias regions */
         for (i = 0; i < ARRAY_SIZE(t241_dist_base_alias); i++) {
                 if (chip_bmask & BIT(i)) {
                         phys = gic_data.dist_phys_base + T241_CHIP_GICDA_OFFSET;
                         phys |= FIELD_PREP(T241_CHIPN_MASK, i);
                         t241_dist_base_alias[i] = ioremap(phys, SZ_64K);
                         WARN_ON(!t241_dist_base_alias[i]);
                 }
         }
         static_branch_enable(&gic_nvidia_t241_erratum);
         return true;
}

>> +
>>   static const struct gic_quirk gic_quirks[] = {
>>        {
>>                .desc   = "GICv3: Qualcomm MSM8996 broken firmware",
>> @@ -1750,6 +1849,12 @@ static const struct gic_quirk gic_quirks[] = {
>>                .mask   = 0xe8f00fff,
>>                .init   = gic_enable_quirk_cavium_38539,
>>        },
>> +     {
>> +             .desc   = "GICv3: NVIDIA erratum T241-FABRIC-4",
>> +             .iidr   = 0x0402043b,
>> +             .mask   = 0xffffffff,
>> +             .init   = gic_enable_quirk_nvidia_t241,
>> +     },
> 
> and this as well?
> 
>>        {
>>        }
>>   };
>> @@ -2377,8 +2482,13 @@ static void __init gic_acpi_setup_kvm_info(void)
>>                vcpu->end = vcpu->start + ACPI_GICV2_VCPU_MEM_SIZE - 1;
>>        }
>>
>> -     gic_v3_kvm_info.has_v4 = gic_data.rdists.has_vlpis;
>> -     gic_v3_kvm_info.has_v4_1 = gic_data.rdists.has_rvpeid;
>> +     if (static_branch_unlikely(&gic_nvidia_t241_erratum)) {
>> +             gic_v3_kvm_info.has_v4 = false;
>> +             gic_v3_kvm_info.has_v4_1 = false;
>> +     } else {
>> +             gic_v3_kvm_info.has_v4 = gic_data.rdists.has_vlpis;
>> +             gic_v3_kvm_info.has_v4_1 = gic_data.rdists.has_rvpeid;
>> +     }
>>        vgic_set_kvm_info(&gic_v3_kvm_info);
>>   }
>>
>> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
>> index 210bc2f4d5550..73575bbf4df67 100644
>> --- a/drivers/irqchip/irq-gic.c
>> +++ b/drivers/irqchip/irq-gic.c
>> @@ -306,7 +306,8 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
>>                            type != IRQ_TYPE_EDGE_RISING)
>>                return -EINVAL;
>>
>> -     ret = gic_configure_irq(gicirq, type, base + GIC_DIST_CONFIG, NULL);
>> +     ret = gic_configure_irq(gicirq, type, base + GIC_DIST_CONFIG, NULL,
>> +                             NULL);
>>        if (ret && gicirq < 32) {
>>                /* Misconfigured PPIs are usually not fatal */
>>                pr_warn("GIC: PPI%d is secure or misconfigured\n", gicirq - 16);
>> diff --git a/drivers/irqchip/irq-hip04.c b/drivers/irqchip/irq-hip04.c
>> index 46161f6ff289d..dc19f48d6f5a5 100644
>> --- a/drivers/irqchip/irq-hip04.c
>> +++ b/drivers/irqchip/irq-hip04.c
>> @@ -130,7 +130,7 @@ static int hip04_irq_set_type(struct irq_data *d, unsigned int type)
>>
>>        raw_spin_lock(&irq_controller_lock);
>>
>> -     ret = gic_configure_irq(irq, type, base + GIC_DIST_CONFIG, NULL);
>> +     ret = gic_configure_irq(irq, type, base + GIC_DIST_CONFIG, NULL, NULL);
>>        if (ret && irq < 32) {
>>                /* Misconfigured PPIs are usually not fatal */
>>                pr_warn("GIC: PPI%d is secure or misconfigured\n", irq - 16);
>> --
>> 2.25.1
>>
>>
> 
> Thanks,
> 
>          M.
> 
> --
> Without deviation from the norm, progress is not possible.
