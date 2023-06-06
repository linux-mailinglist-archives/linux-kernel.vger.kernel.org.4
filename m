Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCA872453D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbjFFOG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237676AbjFFOGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:06:39 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7628F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:06:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fY5/ydAr8c4Fq4XZWPgsflUplPyQrxQDhrsYOdaLTcFbuNylCSXGsgZ+DBjix/d0h8EDSvGM9KensNyDWpDCnH0pkzCN8W1ce003iA8+B2bnE/itvsUxekggSagvFcMRDDDOAiYM3Anda+Ji9koT+xGsRVC2kQujCwkXuNshyUZwlwlMjClO4Bjha5Bd4qO9k+m0lO4Tbe7T0mRpJ2TaLj7oA4ht6Pgmu5PztefiilTHNonQjK3K7TbrERfQBvxbQ+jut6BkyLjTM2xAgN7OuSsyJ8o0bNN9Ma3BDWxnRimt8lIzGWaWCPs8RHIBQl2ipbJVG5PlgYAbXVKZhiLEHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yBUpBBumUgkcefOv8Xi0xj7ALGfCSRipS6thThi76I=;
 b=PYMS++rjRxXuwEufAkTszWkjjGrS5Zjn7aXRfCNNr2Rsd5/opyuWssoKsSdsnpP/hS1IZuNOO/lNsfDIe92AHDKEIhyKnubGmi/ZcHao7xnQhdEPTbkvw8ttOJF0wincr93tA0sKtaEFuMpcYFUEMw0vElgCTHsH+pLWJFGbojyIv0fEg+vR8AX80t5eQbZY3Dd1HlLXDfLNdR5FgEj7jdk+nyKaKcWM3pJYtlDK6S55SJZkVy0TpCdpJ9+lsjo5gg+9rfUgTlIBOdFe37oq0vIlOzbyUxK3t9iPjQwioWO8y9MzDWVFQ1qWnJ1yYDebnbVMecMHgX3rmhZSfkai8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yBUpBBumUgkcefOv8Xi0xj7ALGfCSRipS6thThi76I=;
 b=mxL1HEtvJKWyUECLlW1mK2TH8HWn6FP7GXnY5eBPCcIldmZMWttXChtxEhs+QIEB0FlqTVsy8HV4i7/VIbc0ClXzfKOJI4ES8MSezzcdqThmZL4lEz0pkL4AgO1qpleUFV6Om0Q3HJmdzAMpl6TRrahoaTeo8Fglf8dA38QhlGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 BL0PR12MB4931.namprd12.prod.outlook.com (2603:10b6:208:17e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 14:06:35 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::1f96:31ad:7de0:2175]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::1f96:31ad:7de0:2175%4]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 14:06:35 +0000
Message-ID: <f2e52440-6e8a-7438-cbc9-17933bf8d943@amd.com>
Date:   Tue, 6 Jun 2023 07:06:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 0/5] iommu/amd: AVIC Interrupt Remapping Improvements
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc:     joro@8bytes.org, joao.m.martins@oracle.com,
        alejandro.j.jimenez@oracle.com, boris.ostrovsky@oracle.com,
        jon.grimm@amd.com, santosh.shukla@amd.com, vasant.hegde@amd.com,
        kishon.vijayabraham@amd.com, jsnitsel@redhat.com
References: <20230530141137.14376-1-suravee.suthikulpanit@amd.com>
From:   "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20230530141137.14376-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::42) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|BL0PR12MB4931:EE_
X-MS-Office365-Filtering-Correlation-Id: c48e6832-e4f0-4e52-8810-08db66973d3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dbQS1b6G4HLzNkWWSvn56nbTr1pjNW2+tlFZKDCl84mNFjbKgW7DdTYocxfzQjfbS1wajzNsckFeQl4Hv7k+WGf1js2ygICRLttdfHX9DMPRvZDBNeNvdhUcuADT4WD3L2tACJjFrSW/g3AoqQj+Ioy85aMLTOKR+gGNupGpirNpnp2NJLI8dlcT5PzOktuv5u1ZWKd0Pczq8d7zJ4adbANAQYhr4z5ifI/6pWlwqwn2BtyUddFUBviPEn6/WTmqO4dSLCZJwaZAi/69shdSReL0N+JrVNYOpWkI3tsUP4n4H29aXtcB1A8+AllvqNqw/5smKOeLSEdAMcpJDYL1Uz6P5wY/FrfCLgVl2NWJIKWFp8hfbdPCKLUe+LKTagd9SayuIOSh8KH99Y1mHW/SjF4rGgjbA5VZs/VDKGhurqn2Gean4Oss7F658T1m+uVtRkNBE60E9MThK4KTnrBkzJ1VUajkeRoyFTR+C5wJAQn7PLeDGIp53VFsEr0w7xxPlVAWlfagGOw27YfapNpFgiewqG9uC5da5i1k/pDIdEMul9eQW0npDeASHmugTBolUNLN3/s3lHmqK+191toFB3yM4Y+XnVXyZhMhfjBu52eXXnpOyryONCNGUFIZiJwn9Tg5jn+LSZEK5c0XGKaHXnUL7DsbqrbJ/qUgDHCjd/g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(451199021)(186003)(478600001)(8676002)(8936002)(4326008)(41300700001)(66946007)(38100700002)(316002)(66556008)(66476007)(2616005)(83380400001)(6486002)(6512007)(26005)(6506007)(53546011)(31696002)(86362001)(5660300002)(2906002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2RwbDRDb1NSU0NEcnFvR3UwSDhtN3N5L0JMMHJpODlDUUV6cDBlSUZDdzFL?=
 =?utf-8?B?V3U3MkpHaVYrTEFXTFlxK2Vkb0s3dzUyM3VGbDFkK1p6Q29vd2ZraHB0R3ph?=
 =?utf-8?B?Qmd6VFR2Q0tySldVRlkyNkZ1bFhiRWNKYzhOOFk5QWM4Sko0QjZ6cllZUnd0?=
 =?utf-8?B?Um5wQnI2amJkOU5zM0h2WEdwWDNwaXlJVE9haFczczBlVS92R2ZLbHoyRUN1?=
 =?utf-8?B?bEpsVTFnZllpV0c4SCtWa3pEcHhJbXhjeGZpWEhFajNhSHk4QlQwNmk3Nk84?=
 =?utf-8?B?UWNKZndNczdFSmpoOHBFMDh5VTRIZGQvQytVZHk1M3pTZDJhd2NibklKTExT?=
 =?utf-8?B?VGVSejJVNE1wRFNjYlBzSHR2OStkKy9naFVxZTQ4NXVNb2xQbERXdDZXUHg2?=
 =?utf-8?B?cG5VQWhqblNNNy9KZy9hWDU0T2taVnh2NzJESWxyQU1DNVZZazk3OHJGY3Rz?=
 =?utf-8?B?aHlaN0xFYmt4T0J5d0FvQ2x2M09aYTlmUDBWV3N2eVhabVlIdCtIUmJKTGs2?=
 =?utf-8?B?ZmZuVzVDZTRpakozekdhOXJLU0lyd2cwNDc2YjZPNFVycXdpOXFmZk9CWndk?=
 =?utf-8?B?bGVSekpVTGV0VXZNcy9HbExqd3dVQ0xqV04wY2NaWWJGblhocytzdjBWZkJQ?=
 =?utf-8?B?a3pWcm5jcFd3S0srcy9sNUUxS0hLY2R1VFlsNlduTXJVbUdsVy9SWTdheGJD?=
 =?utf-8?B?RWdyOTNjMnFxMysrczJ4Y1NzK0pLRkpyclZiVThIR3kvWVZHZVI0MTdUUU0y?=
 =?utf-8?B?U0cwUTJRY2NWUFFXdTFUUkx2M2doMjJiRCs1RnEyK0pvUzdYeVJaeFBtbExR?=
 =?utf-8?B?OFYwQk1OT285SElTZ0pxUWllc2V4eWFZMnpHS2Uxa1kxMVZpUnpYNHJVd2Iz?=
 =?utf-8?B?M3ErMVZ0KzN2UTBFSHE1alp1eHArOTFJL0xtRVNSK3RsTUhrR2I1SFFubmJT?=
 =?utf-8?B?V2tnbldvcGdYdk5EdDEwTkhXbmRqazk5SHJoZzhOdGpzeTQ1bmtoVmxvUTZI?=
 =?utf-8?B?VWY2V1dVQ2tDOG13WEdaZjdFQXNMQXJUemdqc3R3RmcxTVU2YStkTFZSRjM3?=
 =?utf-8?B?ZVVkYjk0MldHd0hVcTZoVzJnS3VEeTRVelhMSnRTZlVXempEakJ0NXBFTWdw?=
 =?utf-8?B?RjBjN3FubTZiejY4YTdHdHhFTmRjZkhkc3hXdVIzOXRsN2FpN3ZEc25UTHFm?=
 =?utf-8?B?U001T0M0elpGL0lhc3FrRS96WHZ0dDZqNnhJaEtHcWtjMEozOWx0V2t0WW9a?=
 =?utf-8?B?bW1ocnN6QWVjcTkxUC85bWpod28rM3pIMnUrcXd2QUs3T0ZIKy9DZ09UZTMv?=
 =?utf-8?B?MzlYZlVhTWZMcDlESlFScFVmTUdrejAvRlc1TXlMMVJ1QTNHSnNrNlUwUjlL?=
 =?utf-8?B?Uy84a3pQZ3JKL1pKam0xOUM0TUpwWUpXNllQR1lyUmJWa0NvL2dzdW1mVEM2?=
 =?utf-8?B?OFlabDk3aXk3MVpTdkVJN3haQlIwV3gyZWV3NGlyNi9ZV0RMSEZNZ3dTYjhw?=
 =?utf-8?B?R0JRenVlY0RQcU5qNk0xd0F5cHA3UExjS0FMM0JYZ3kzeWNMYk5GNFBzL0Fj?=
 =?utf-8?B?dk1NUzcvVzE4ZkZuN2JqUThZNWQwQk42R1dnRE82VFhnNnVNQlJNUDN3Snpy?=
 =?utf-8?B?ck5DOVp2U29QMzNlSXJCaEp0ckZ4L1F3Q1BtZzZXYnpUQU92UnlReDRlMTA0?=
 =?utf-8?B?K2pQZzZwRmtjclEzS1BuUmlVVEhTMVkvV2ZyNWdXMlJRTFI5RW12N3p1M0RJ?=
 =?utf-8?B?dTZsVmEvSkFPL1FpMXgwZDArOHJGWmNId0dLNjVVakV6SHZQSlVCWE0xZTQ2?=
 =?utf-8?B?ZjFabVBtejQxWmRlRnhCZEFBSmRFeHhXQkM5UEpZVGowaWRXSmcvMmlkRlFw?=
 =?utf-8?B?cjZpQ1V4R1ZaWkIzTGllUU5RSnBjcWk3c25hYWtLb3QxZzJuQ3RFVmdxZXpu?=
 =?utf-8?B?aVhlN0d3VDFmdndPbWdmUUsyL29vTjRSRUhYNEhPV0xMZUJLRlJPckNlVmti?=
 =?utf-8?B?YmxvWFNMT2NPaUxrakkxemN0N3VHTlNmNGdCNnNqbStFK0hDVDBtM0lSekxL?=
 =?utf-8?B?aWczL3lTRytIMGVKdGtmRG5NUk5idkxZUncxVzdzR2dwZk1OODBIM3JTWVl1?=
 =?utf-8?Q?Fl7I/k/hN9FVJf1PWNlFETHBm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c48e6832-e4f0-4e52-8810-08db66973d3e
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 14:06:35.8375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUWURSE4YSpBKIn3gbJDTy89Xxt43JArySyN3jIJfDh/f4kXT0yO+yUnB0Wck7CgGk/UgHQ0M0hcwhJmFb0/HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4931
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Please let me know if you have any other concerns for this series.

Thanks,
Suravee

On 5/30/2023 9:11 PM, Suravee Suthikulpanit wrote:
> For IOMMU AVIC, the IOMMU driver needs to keep track of vcpu scheduling
> changes, and updates interrupt remapping table entry (IRTE) accordingly.
> The IRTE is normally cached by the hardware, which requires the IOMMU
> driver to issue IOMMU IRT invalidation command and wait for completion
> everytime it updates the table.
> 
> Enabling IOMMU AVIC on a large scale system with lots of vcpus and
> VFIO pass-through devices running interrupt-intensive workload,
> it could result in high IRT invalidation rate. In such case, the overhead
> from IRT invalidation could outweigh the benefit of IRTE caching.
> 
> Therefore, introduce a new AMD IOMMU driver option "amd_iommu=irtcachedis"
> to allow disabling IRTE caching, and avoid the need for IRTE invalidation.
> 
> Patch 1,2 prepare the AMD IOMMU driver to support IRT cache disabling.
> Patch 3,4 introduce IRT cache disabling support
> Patch 5 improves the code path in IOMMU driver for updating vcpu scheduling
> for AVIC.
> 
> Thank you,
> Suravee
> 
> Changes from V2
> (https://lore.kernel.org/linux-iommu/rlurmw6n6eyyhtnfr6wva6azur2gvgcrdn4mvykr3nvsosj5py@ieaivyv6cqrv/T/)
> * Added Reviewed-by and Sign-off-by.
> * Patch 4: Reword the commit summary (per Jerry suggestion).
> 
> Changes from V1
> (https://lore.kernel.org/lkml/20230509111646.369661-1-suravee.suthikulpanit@amd.com/T/)
> * Patch 3: Add logic to clean up the IRTE cache disabling
>    and handle kdump code path (per Alejandro)
> 
> Joao Martins (1):
>    iommu/amd: Switch amd_iommu_update_ga() to use modify_irte_ga()
> 
> Suravee Suthikulpanit (4):
>    iommu/amd: Remove the unused struct amd_ir_data.ref
>    iommu/amd: Introduce Disable IRTE Caching Support
>    iommu/amd: Do not Invalidate IRT when IRTE caching is disabled
>    iommu/amd: Improving Interrupt Remapping Table Invalidation
> 
>   .../admin-guide/kernel-parameters.txt         |  1 +
>   drivers/iommu/amd/amd_iommu_types.h           |  7 +-
>   drivers/iommu/amd/init.c                      | 38 +++++++-
>   drivers/iommu/amd/iommu.c                     | 97 ++++++++++---------
>   4 files changed, 94 insertions(+), 49 deletions(-)
> 
