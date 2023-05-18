Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83B170858C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 18:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjERQFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 12:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjERQFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 12:05:00 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54A5EE
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 09:04:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJTbaV3VFrz16Gj3hy5X9fKe4ZvWdcBE/WNmI5B96l3woHjZ1gdOA5FFM+SHT/h9TxSfcKlQ680RsKHGsJhDe8RE74ENNQMQQ8ntz4J0xPjWJA1vZu3tlAbJ1zi5a70huqBVOD2lEvIBSp0c8SH/12xT7qcQxnmYS4EUQNuFw4rp7viFwSpZ1aRMtaNKnKRuMlqxnRCaCiRa7qqxhrrA/THEMRxGtqwP4AaYZY+XoUK+EchxjfW5fDrna6qyyGv+j7/C0bi92CFz/1pdPt4aTwpFHGCjeqRhAF4l2JAsFaTCl/hEDjeuGgAjGVPvtnr/8tKGWaaU8/5PWfXx/RjuhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmhS94bxiHLSG4J3NiUv4NWIfPkxrNFuBj+ppQLgHTI=;
 b=F1snaCqFDU/Q8Rb3E7yo95oJdyVNrTp3XGgoBt25db3cHKqco9Qayx5/lNG9SaqRcGGwoPoUM5XbjQlKN5NTnmrA1brIkMeqJCBRWhiTJxvHGzxH5JvC/08Vn07Tc6VmvoZm/f7qTw6P+fmkMHylUMCIAfWo/YlPr9g3cYJXeI1UFOiGDOcxp57niCFv6kMaZa1ttw/CIuH/obsjyRjfVSnXnSXD1xqjok843454icwQOKhn0TbabxIYtRed+ahDaHiXxBj5qlz8AB2s3B9We50qjOueaLvkopF5w41zpHWUdClvDeE6td34MU7SzDppv0YE+uamR1TzshRh+2BW2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmhS94bxiHLSG4J3NiUv4NWIfPkxrNFuBj+ppQLgHTI=;
 b=kqvM062ARY7M1h6rjoLHTubAxprlq2yaJiL1vcmCBYT0FygKaWirTzWB9HMN1fHFeRbRDDH/94rM7ifU/P/Eklekm4Iv9Az9WElq6mONYszRIog8iEYK5t8r6Nf67pmcdVCjWr3ITVmZyolZujXPe+7f821j0DPi5AEOepST+xI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 PH0PR12MB8798.namprd12.prod.outlook.com (2603:10b6:510:28d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 16:04:56 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::5a2a:9873:3192:6c1e]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::5a2a:9873:3192:6c1e%4]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 16:04:56 +0000
Message-ID: <81b4010d-d8c6-0915-2408-e6454e4d501d@amd.com>
Date:   Thu, 18 May 2023 23:04:44 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/5] iommu/amd: Introduce Disable IRTE Caching Support
Content-Language: en-US
To:     Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, jon.grimm@amd.com,
        santosh.shukla@amd.com, vasant.hegde@amd.com,
        kishon.vijayabraham@amd.com
References: <20230509111646.369661-1-suravee.suthikulpanit@amd.com>
 <20230509111646.369661-4-suravee.suthikulpanit@amd.com>
 <2d0ab154-596e-437f-1575-3d25fe421b86@oracle.com>
From:   "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <2d0ab154-596e-437f-1575-3d25fe421b86@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0135.apcprd02.prod.outlook.com
 (2603:1096:4:188::23) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|PH0PR12MB8798:EE_
X-MS-Office365-Filtering-Correlation-Id: c96daee5-1d31-402d-f674-08db57b99f48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 58C/j8uGgYuO9ilGjkLJB+Nbc4eBQ8OQIjUNMTXWQGACzy+RyanHPdo7BavyDZnzQtx+srAIdwnK0LD+Frbv5WTEaq3mgl5vvYFKATveIs+dRfCJq5x8TE7cZGxZnSMHmzdEtIKvN1bvUw25np6FIASH7hB2ilitDbRi7CQ4r26wAXumd06TAgIqwiJw8Sq1DCbsTKvxIGKUdiVZ2aOeqIQSxB3MQ6u9TgX46A1nx7THc/kI3HPL7u5mrbz29rWG7bmc1YKRi2MACwI54lo0ewfHCWHMHKf4IR5HsZyVx5qS0RMMX6lNIOYSNLdvrnuGgKkHYcMcFVjy0dGmH05pp17VfvJxWEkWKPNyha/o+SsSkeDq3VeoBi/7WfdbwDNvqDhKr+i+ymRwn4X6h4xhtEMfifRQiZMnGqr9+wfv7SMccYjca2CkH9ZvIo7WEz7M7/qQm2vZo417ySt3wvvubXQRcOJl0eGxoXefK9bDWkx0FXniAbw393STHYptMd3h0YZlfOpyg+WRTDarllO5T3InY7U11oGiNIhoIIRYpAkZ39OkNhjkVIE1DAkGZyxS6U1yWUa04AG+3ksR1c3GCcZmmYpB/XpgXN7v0qkaBGN+DFRo2TRb4b72d8WSqU6X17M0dMu8aPGXHVJG/FyUXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(451199021)(2906002)(478600001)(41300700001)(8936002)(8676002)(31686004)(316002)(6486002)(6666004)(4326008)(66946007)(66476007)(66556008)(5660300002)(6512007)(53546011)(6506007)(26005)(186003)(83380400001)(36756003)(86362001)(2616005)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUdmRnZac0FaSm03ODhkVldDdi9uZCs1YzU5cHBhK2RyN2ljVWJWVXYvQWp5?=
 =?utf-8?B?cWZKNVNHb0RBQ2VxWXBwb2cxRUNseDRQMWZRRDRReFJjV2c5VU8yOS9weTkx?=
 =?utf-8?B?cHg5cGpCbmlJUzVWVjFrTzQyZkNWUlM1RHJCQlNXUHl5U1N1MUFKR3pXdWtk?=
 =?utf-8?B?b3dDb3l5WFRNb1ppb3JCTDJiaUNyOXQ5L1lOK0habmpPU3l5Um1HRzNOUUJz?=
 =?utf-8?B?b3FzZ1c4cnpnc1pGOW45cURwVlM2Z1lweVFMYXl3ZHo0d2lnMkxRSGpFR1Vy?=
 =?utf-8?B?d3F3UFBUZWV0LzVjd0cyclJNVW45cGJiQVo1Ry8yWkZOdU1DUy8rSU92ZjY5?=
 =?utf-8?B?dDZSMG1hTnhGSDFKSEllV0Z3c21qQmQrdjhtaWxYTm1PZnMvY2dUdnc4OE42?=
 =?utf-8?B?R2IvcFBOdy9OZUEzaHFOeGVzNitjUXBJUk5qK0NyNEdHa2ZDbklldWRHd0ZF?=
 =?utf-8?B?am1HamFvNzE0dnEwVjg5cm03aStyK0pzUXZVRm5mRlFpaVhZNUswVUFFSEhK?=
 =?utf-8?B?Yy9uZWlDZUR1T2FMcXZLbjlGR1VJS1lwQ2VWOWZJcmJnRWUwNmxMZnZldDRQ?=
 =?utf-8?B?YVhQbkZtbm9IaWVpNml6bWtITWpaaGxKbm9tQ2diekpQMzVkQlFhakxlUXNm?=
 =?utf-8?B?S3ZvSkZKUE9zd0pXV2JJeDBOWW9XYVZmV3M5RU8yZEc0RXNWMWliVUdZNGhH?=
 =?utf-8?B?T01kNERTUXI1R2E5Wm5tNzNrSFBUalJ1eGw1R0t3blBERU0vQXd0eXZ6MFp0?=
 =?utf-8?B?WGkrMGNkSnZYRkk4ODVQZnk4Ull5aStLbHpWQW5pQjlqOGRHT05pdVpYTjhC?=
 =?utf-8?B?K2xBKzRiY1NNR3RPQVZwZUhjOGFxMGpCb2dPWkNrcHphM2tWQk1rTXU2ajNP?=
 =?utf-8?B?M0NJUDdEY2xQTk0zcW8rYktJdllPSlJybit2cXZxQytKQ0dqa05oZzF2UGxo?=
 =?utf-8?B?bkt4MDQvS3JLV0ZzZlZrcmtvT0dNVlN1ZjZKWXR1ZGNYbmxwOTZBV0JwZUlH?=
 =?utf-8?B?dHhjNnBrQU0zMjB6eGphSFJPNk9wb0ppSmt6akx0T1ZlS1F4ZGxqeUpRYkI0?=
 =?utf-8?B?Y3ZWcmJxRHVLNmJ0UWdUQ2hqSHZVQzhGc0JaZnhsQzFzZnE2bnZtb2M2RGtV?=
 =?utf-8?B?RlpuUXdjb3REeVhsMzhkZFIrVUVUV1NVQlk0dlRIenROa0xrb01XZ1B6V2Vp?=
 =?utf-8?B?UDIrN2ZBUm55OEc5L0k3THgrTGQ3NWV3S056QmZhVnBiaThXa1ZQU1VXNEw5?=
 =?utf-8?B?bmNEQ2x1dVBDaW4yVkxLZUQ3dU9DNTVzUGt3ZzI5UUptSG42SEFudXZPanhx?=
 =?utf-8?B?SkEvL3JPRFB2RnZURVJPVWkzMGMrakVycGc4aFU3WEdXY0lqaWZBVGdmZHhV?=
 =?utf-8?B?WUZXMUtMVEFwanY4NFlMM1M4NGQ3WmlaZDlkZWdUNkFKdFp3ZldVNnFFazJq?=
 =?utf-8?B?bU1vUXZPdU96UjhoNDBuUE5XVVkzenlKNUlQMnU4RjVDUzJHSE5xaXlmcHdz?=
 =?utf-8?B?WHdTVGMyR0I1NHFVdnM0cnUxRXdhaXZGbXBCTkp5WTFDVktUb0tJTHVjNUpu?=
 =?utf-8?B?SlJES1dpUU9ITkRuZGhhR2Z5L3Jxdllvd3J5bEp5MnRjNEROL0JGekdEYUhV?=
 =?utf-8?B?ZGtWUVJkYmdIZWw3NmR1ZjF4Rkpoa2FiVTRsSWMrdjVJdmxySW8rWWgzZkR4?=
 =?utf-8?B?R1kyWXh0OTEzRnBjQmJYQkoyQlF1Y3VQM3p6azFTMHNYZkh2QTd1L2w1M2hG?=
 =?utf-8?B?S0hVZjJhcDhNYm9OaFlNYnBHSWlVNFdYQTgrUEpxYVFtS1VhZ3N4NDRyZ2FB?=
 =?utf-8?B?MEkxVjRwWjVEZDZMbHBwVE5Sbm9QQ2dwL0ZEWUVJM2ZmTnJLS2VrbGRQWElu?=
 =?utf-8?B?dHA0WGo0eGViQUdTc21CNUg0OFRVNkE4ay9aci9VeGYzU1B0TU8zUlcwSDlS?=
 =?utf-8?B?SVI3YUYwWUlxdkpQZXc2T21JU2crK1NHdjEzakpxelNGNU1QUjVoUEpzb05Y?=
 =?utf-8?B?eWpoblByTXkvRUxRZERwKzcwL0pVRjlscUx4M3laWVhoMkU1QVR2QkJhNG5i?=
 =?utf-8?B?UUVmajE4b1dBUlAxYXF6ajdabUplQW1mU2ZidDU1L081cXNaQkxGS0lqL3dm?=
 =?utf-8?Q?sgUNQdoq4I1qJW04FyAoMO7/C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c96daee5-1d31-402d-f674-08db57b99f48
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 16:04:56.0269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3MqZ/xd+Spj3X3cx0DjhkQhxlod3iw9PN/iUrIBbQInvOgczU/rrofzPd24Jm7YjrJwLVRFHULhdg+ghV34vSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8798
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alejandro,

On 5/10/2023 5:47 AM, Alejandro Jimenez wrote:
> Hi Suravee,
> 
> A couple of additional comments below:
> 
> On 5/9/2023 7:16 AM, Suravee Suthikulpanit wrote:
>> An Interrupt Remapping Table (IRT) stores interrupt remapping 
>> configuration
>> for each device. In a normal operation, the AMD IOMMU caches the table
>> to optimize subsequent data accesses. This requires the IOMMU driver to
>> invalidate IRT whenever it updates the table. The invalidation process
>> includes issuing an INVALIDATE_INTERRUPT_TABLE command following by
>> a COMPLETION_WAIT command.
>>
>> However, there are cases in which the IRT is updated at a high rate.
>> For example, for IOMMU AVIC, the IRTE[IsRun] bit is updated on every
>> vcpu scheduling (i.e. amd_iommu_update_ga()). On system with large
>> amount of vcpus and VFIO PCI pass-through devices, the invalidation
>> process could potentially become a performance bottleneck.
>>
>> Introducing a new kernel boot option:
>>
>>      amd_iommu=irtcachedis
>>
>> which disables IRTE caching by setting the IRTCachedis bit in each IOMMU
>> Control register, and bypass the IRT invalidation process.
>>
>> Co-developed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>> [Awaiting sign-off-by Alejandro]
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> ---
>>   .../admin-guide/kernel-parameters.txt         |  1 +
>>   drivers/iommu/amd/amd_iommu_types.h           |  4 +++
>>   drivers/iommu/amd/init.c                      | 25 +++++++++++++++++++
>>   3 files changed, 30 insertions(+)
> [snip]
>> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
>> index fd487c33b28a..01d131e75de4 100644
>> --- a/drivers/iommu/amd/init.c
>> +++ b/drivers/iommu/amd/init.c
>> @@ -160,6 +160,7 @@ static int amd_iommu_xt_mode = IRQ_REMAP_XAPIC_MODE;
>>   static bool amd_iommu_detected;
>>   static bool amd_iommu_disabled __initdata;
>>   static bool amd_iommu_force_enable __initdata;
>> +static bool amd_iommu_irtcachedis __initdata;
> Lets drop the __initdata attribute above, since amd_iommu_irtcachedis is 
> used by early_enable_iommus(), which is in .text (causes modpost warning).

Good point.

> [snip]
>> +static void iommu_enable_irtcachedis(struct amd_iommu *iommu)
>> +{
>> +    u64 ctrl;
>> +
>> +    if (amd_iommu_irtcachedis) {
>> +        /*
>> +         * Note:
>> +         * The support for IRTCacheDis feature is dertermined by
>> +         * checking if the bit is writable.
>> +         */
>> +        iommu_feature_enable(iommu, CONTROL_IRTCACHEDIS);
>> +        ctrl = readq(iommu->mmio_base +  MMIO_CONTROL_OFFSET);
>> +        ctrl &= (1ULL << CONTROL_IRTCACHEDIS);
>> +        if (ctrl)
>> +            iommu->irtcachedis_enabled = true;
>> +        pr_info("iommu%d (%#06x) : IRT cache is %s\n",
>> +            iommu->index, iommu->devid,
>> +            iommu->irtcachedis_enabled ? "disabled" : "enabled");
>> +    }
>> +}
>> +
>>   static void early_enable_iommu(struct amd_iommu *iommu)
>>   {
>>       iommu_disable(iommu);
>> @@ -2710,6 +2732,7 @@ static void early_enable_iommu(struct amd_iommu 
>> *iommu)
>>       iommu_set_exclusion_range(iommu);
>>       iommu_enable_ga(iommu);
>>       iommu_enable_xt(iommu);
>> +    iommu_enable_irtcachedis(iommu);
>>       iommu_enable(iommu);
>>       iommu_flush_all_caches(iommu);
>>   }
> I need to understand better the code flow around kdump, and it is not 
> clear from my reading of the spec that this is required, but shouldn't 
> iommu_enable_irtcachedis() also be called in the else{} block of 
> early_enable_iommus()?

Actually, you are correct. There are a few things that I missed.

First, we need to ensure that the bit is cleared when disable the IOMMU 
when the system is shutting down. Otherwise, when we do kexec, the bit 
might still be set unintentionally.

When booting into kdump kernel, we need to evaluate the variable 
amd_iommu_irtcachedis and setup the CONTROL_IRTCACHEDIS bit in control 
register accordingly.  Otherwise, we could end up with a situation where 
the CONTROL_IRTCACHEDIS bit is inconsistent with the 
amd_iommu_irtcachedis in the kdump kernel causing the kdump kernel to 
skip IRT invalidation process when it is needed.

I'll fix this and send out v2.

Thanks,
Suravee
