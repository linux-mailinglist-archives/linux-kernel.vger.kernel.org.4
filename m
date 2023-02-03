Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342C668972F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 11:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjBCKoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 05:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjBCKob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 05:44:31 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2093.outbound.protection.outlook.com [40.107.93.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7278B443
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 02:44:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EV8+dd/KHx7pRki3Cd9eOkV9cGtp3Oe0rlFMRpGYcr2JnFMfSuFmkupNW21qKL6JCmGXGWw3tkw45vT/5kRAW56WNk6EaKlmhYO8Qm80fEcEW7Hy5JmQnu1lS5iRzqwFuMO8DOeYPX/o6SSUKOyoWnTRoZS23cDnLz2Wq82A0b75r3mOCouoDfeCXoOqheJLI0g3WgBwSfMN14wZ76K2dwAt64StGA2KpRYC5GPx8eswlYmD1kZ6DKye0sfLKAP4OV466EPzbIT16qQCaxtTAPXpvz1mORYLEffxFGI0Z4tdMPGdnQTu7ixfRaep9aXeY5PsufaMs8KAR62o8vDbxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d31ErOTvG9UnImDPY6/9OUPOdSMj1r/Vnk6ijDZGZbQ=;
 b=KRV8eHkzi3dwOEuDbWux6bdPT4rTQTL5VqIslxcasszws0vPyzGPVuPCfIqT6hL3pG1lBbuNXZKxzkZk4XMF+tNZTfW1nxxnIELbIzpvMExJ7u/l02EiUkE6BWLR9Fian5oJaRZXDFl1CeQCR5/QeZ5I/kUOJlrUEXh13zElNPLZh1Kw/NoUQMWRHOkqpe1yVt6SN6joA5I6MMDX4KM75Hs0kh0emWRoXkHklXTJMZpy3WfQ7TTVdmI9ZalSrTGf6AoUenMsAzJYikzD4+8FGwPloqnrHqmSVJV1TBo5SzDP67mMj3o1MaJOvcqtQowrIayvBM9rjiG+7OC7vER+GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d31ErOTvG9UnImDPY6/9OUPOdSMj1r/Vnk6ijDZGZbQ=;
 b=efYMgaJtm8Q0kl7vewUVe3GN2XBUWrNnk4bUyKZj2PQ5U7K5qYPd3J6oD1vmZPu4OibyF1Mos39fOJK1ipWIHFnQdik04WTZegMIPuFMeY38kgaf1R8QDWHM8v0A7KpTT5EiDw5hK8c/XGBMHcQjf1stu4JRB+fmYRGqaw5L44o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 BN6PR01MB3266.prod.exchangelabs.com (2603:10b6:404:d7::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.39; Fri, 3 Feb 2023 10:44:28 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::6b5b:1242:818c:e70d]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::6b5b:1242:818c:e70d%3]) with mapi id 15.20.6064.027; Fri, 3 Feb 2023
 10:44:28 +0000
Message-ID: <ddbea706-52dc-1505-988a-acc390add3bf@os.amperecomputing.com>
Date:   Fri, 3 Feb 2023 16:14:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] iommu/arm-smmu-v3: Enable PCI ATS in passthrough mode as
 well
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, will@kernel.org, joro@8bytes.org
Cc:     jean-philippe@linaro.org, darren@os.amperecomputing.com,
        scott@os.amperecomputing.com
References: <20230202124053.848792-1-gankulkarni@os.amperecomputing.com>
 <0833e426-d03d-b856-3cb3-8fe97adbb8c1@arm.com>
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <0833e426-d03d-b856-3cb3-8fe97adbb8c1@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::31) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|BN6PR01MB3266:EE_
X-MS-Office365-Filtering-Correlation-Id: a557d481-38f7-4bce-ce14-08db05d39ff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w2aX+zcufbJjUuvn5N70EM70TGGH1L4LlD8Z73izyEJhn4O6OdwFN/wA16U+0CX3ck+7Gr1wXqyHhOAzxet6kfJJmzZdl3xhDhLyYOAIobQWiXP9/CDZGfbWk2wCjZGSHBkOEVASmm72C3SX8pVFplsHm81EOV3IBjZJCPKH24h5rNRmKcejm6PghtHVF+BXnwtP1NY/nuF+JBGO3pyXdcL0/qAJKFbrDhKtesjWVtBdPN2IOKomPXy0BlREldCaO09D+5l99I2ZA/H3xYx/pD1mKTGeaUiNqW4++mV02BC3vwRKFFbEsBOjA0qUJNkuRSUp/hb9KotzfzkiKZONhKSdfMk2lF9Qyrh74/flVPLKFC7m2UQWqgZjmGFCaE00O3hCQFERYWRn4YRP0gCe64yrWs07yTXVR/o1dkMY07+6L2+76EbErbTbChNsVAT0LAljQcizUb4KpJtZqAIt2Ot4G2CmVc/DAGsenau5xM/GfS7eYIykXtrPf1tXvyoPo15hfxp+hbCy9JoaFffBhfnxcWD+grJ0nM99a5Nq+J4UqBkXq4uMBjlT/JkU+19zAN0KNqq7WHgDhcIX+RPR6FJXDvkOjn/xGA3ahkqodhEgh+aYhBBcEnaCs0h44i895fsCCNtyex6P4EJs4dBMlNPKfEpn4yUiRarn6J8KUC8svI3eEycQFSKRYX6ijgunJXreJo/3o7RBWMsbEr2/QA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(346002)(136003)(39850400004)(366004)(451199018)(41300700001)(316002)(66946007)(66556008)(66476007)(4326008)(478600001)(8676002)(26005)(6512007)(2616005)(53546011)(6486002)(186003)(6506007)(6666004)(107886003)(8936002)(83380400001)(31696002)(31686004)(38100700002)(2906002)(5660300002)(86362001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjlTcnZxOVNaTTdpUDc5SlBVNzRHTWdWaU5scDBhYm54YkJsWHljaW14OXBL?=
 =?utf-8?B?cGFsaWlyQjZ4bG5KZVk3VHNYV3ZEeFBtOG1hRC9WZzRiR2RTSFAwSFlBUjhv?=
 =?utf-8?B?bEwzc2wrQ0k5c2NpSGhNVlBaMmdNZjZCMUgyWSt1VEZaTEN3VzNvam9EWWp2?=
 =?utf-8?B?RlplVGZPVmYzQ2ZkMXphWTFLa1BUTjlhL0RtWjlTOXJUWEhOZDRGaW5oQ0la?=
 =?utf-8?B?amxYT2ZybmVVZktpeXpNd1NPNUpxcndTT3dRNUN6SmF0WU84VWVJaFNwMmQr?=
 =?utf-8?B?VE45M2JqNW1mR2FiaXJ5UFJLajRsR09zaFVzckViWmVvNU56WjdwQVYrVVc1?=
 =?utf-8?B?ZyttYmkwY3ZEanVSMkpTMlhWMjJMMEg1Qmk1Q0R3d3R0ZGxONTZmK0ZoU0hV?=
 =?utf-8?B?bmtUdGJteUI4Yk9JcnJzTGFxL3BPVlc1NmZoUzd5ZTdxakZTdWZWdHdheW1u?=
 =?utf-8?B?YUc5ZE0xaGk0VFF4Ky9NTXdTb05SYkVBRGJHbmtJZGIyaURGendpVTB4ODVF?=
 =?utf-8?B?TXE5RFhWWHFJV095U2RTSVdSM2Q5aDhwZzkrMWhOMFVxVHpacGREQThRZWdr?=
 =?utf-8?B?bnZXSW5Qa0gyRmZaQnhMZCsxcG1zeThHWTNTU1IrZk1JLytqbm9zajdHYVVo?=
 =?utf-8?B?RG9sSmhBZ2lwU1ovdzk5TlkrTVdWOGtjWFlWb3BTTHlQbFRoRzNzZEpZZHpO?=
 =?utf-8?B?OEplODZoNzFuNTRNNWtJSFZTTTJZLzFOYjdrc2FTbzExMy8xM2pmU1A2bFZt?=
 =?utf-8?B?c0d3YXE0UlpDUUpWVzcxcE12U203Q0Rxd0ZwQkRyaEJhUDhjcE9SVDRhaS80?=
 =?utf-8?B?b05KRFJSaE9iWDFIODlIRHY4VEVUZm00c1NsUkpqL1pjQUozQ1VBOW5wWDFF?=
 =?utf-8?B?MElYOXJ4c3d0UG9UZmpVUU1lRUVLTnBkTWRndk1HQ2RTVXpQYmdSQTN3ZkZC?=
 =?utf-8?B?UW1DUzlqVWM1czgvMHRjZXJtWWt4ZVk4SFhiMlRrNGVERVMwMFlPKzVYVWJp?=
 =?utf-8?B?Mm5QaERDWVU3d1gvaW55eW1Pd0Z5WmM3eW96NG41QVBMS1ZyNC9wNm1QcXlt?=
 =?utf-8?B?VjBjWldhZUQ0RUp5bDArbXdzQ0FBdVkzSE9zMUtzUjRMS09Xb2hhWk5iemZG?=
 =?utf-8?B?SU03MkxvcXR0bXdPL003c01uWXVPZ1I2TExMZTk5bnlmelB3R3p1U3phV3Ev?=
 =?utf-8?B?SW4yZEJUeUZUTlkvdmxiTWtMQW0xOFE2dnpNengxS09QbERBelhZam1jbzV0?=
 =?utf-8?B?RnNkU0lybDd3TFBiaWNXQzNWSzlIVG1ncXphS1hmc1B3aHdYUW0vbGZaNzFT?=
 =?utf-8?B?WTVDdkJ5MHJDU0pDSXI3TGxOYjRTbldhdExmNHFjcDc1MXJVTmR2L0xRNlla?=
 =?utf-8?B?NDlqUVczTzJiRi9YdHgvZFNJMzNITVBmZU9hdzRzbEZPaWZLVmgraFo4Mjcx?=
 =?utf-8?B?N0FSaVFtU1BPWjQyRVU4SkJ2N0VJdEJZOFhqZStWTzJFYVNBUWtiMEdoWnhD?=
 =?utf-8?B?c0NWWXV1R21wYUpRUUZTTFp1VmNoQ1ZvMi8rQVhwOU0wTXJUSVU1anhTcGlj?=
 =?utf-8?B?UXBkMVBJblVuNnZGN3A3cjlMZUJka2dMTGphRDM5em5qdEgzWTFkeWFBSWRG?=
 =?utf-8?B?YURmS1dLUnBOMnZaekc0L2dyUUN6Q1ErQlBHWkpWOWErL25vcitsV3ZkSnRl?=
 =?utf-8?B?SHFDNWt2WWtxdmFqWXMzajdDeGhobmg1d3hpblBjNmNFdGJRMitJTi90SEJz?=
 =?utf-8?B?TW9JcjhPb2x0MU9wOWhXS1dDVjRUdjF5Z1UvYVFtRGRrUW9Za1UwclAzYTVL?=
 =?utf-8?B?R3pUK20yOENZT0lSMWdpMGFCdGhpNm9qZlA1ekYrTTY5eXMxQzFRWnBkbUtJ?=
 =?utf-8?B?SHJZNGZOQTI2RjRpN1dEcEM4QjJ0QXZMTzdMSXhTb24wR0xBL2FCdmx5a1Zq?=
 =?utf-8?B?K3g3TU1jby8vSWNMWUt1aHV5K2N4L05NOGdTZXorVndzdjAxYUVwUmJKQkUx?=
 =?utf-8?B?cmFKVmVGOHQrUFg2Yysyc0RiS0cyd29RVlA3Y0N6ZldvMnl4SVZQWXhENUxJ?=
 =?utf-8?B?b2h1NGZESldIS1dvRVkwVjVVYm5BMEYwOElXUktNMHZmUUtINmFtNU5nMzN1?=
 =?utf-8?B?KzY4QjlwbkVyTmwrYnJDcE1NblZSdDh0M202SUZTQVRIZnhwUXBmU21IQjU0?=
 =?utf-8?Q?SyP7+Gx/egE9Xiq3riT9sh+1/cVGBWZB60cJWmH/ayPD?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a557d481-38f7-4bce-ce14-08db05d39ff8
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 10:44:28.4428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/ha8xVTQ7c8w05+TXK9F7zZNMyLpzvVNETjZaL0u6/sm9rUjfPGUnUEfWZiOzxvSKv2fbgXeRZrAQzPJj+pVZqbacPNFi4KqorMn63VopM1ycEXTow9PI7Dvw8xAP1D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR01MB3266
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02-02-2023 06:52 pm, Robin Murphy wrote:
> On 2023-02-02 12:40, Ganapatrao Kulkarni wrote:
>> The current smmu-v3 driver does not enable PCI ATS for physical functions
>> of ATS capable End Points when booted in smmu bypass mode
>> (iommu.passthrough=1). This will not allow virtual functions to enable
>> ATS(even though EP supports it) while they are attached to a VM using
>> VFIO driver.
>>
>> This patch adds changes to enable ATS support for physical functions
>> in passthrough/bypass mode as well.
>>
>> Also, adding check to avoid disabling of ATS if it is not enabled,
>> to avoid unnecessary call-traces.
>>
>> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c 
>> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 6d5df91c5c46..5a605cb5ccef 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -2313,11 +2313,16 @@ static void arm_smmu_enable_ats(struct 
>> arm_smmu_master *master)
>>   static void arm_smmu_disable_ats(struct arm_smmu_master *master)
>>   {
>>       struct arm_smmu_domain *smmu_domain = master->domain;
>> +    struct pci_dev *pdev;
>>       if (!master->ats_enabled)
>>           return;
>> -    pci_disable_ats(to_pci_dev(master->dev));
>> +    pdev = to_pci_dev(master->dev);
>> +
>> +    if (pdev->ats_enabled)
> 
> If the master->ats_enabled check above passes when ATS isn't actually 
> enabled, surely that's a bug?

IIUC, It means ATS feature is supported (just check for existence of ATS 
extended capability and smmu capability) and not necessarily enabled.
Function pci_enable_ats(called by arm_smmu_enable_ats) enables the ATS 
by setting bit 15 of ATS Control Register (Offset 06h).
If pci_enable_ats is not successful, it will not set dev->ats_enabled 
flag. So calling pci_disable_ats later results in call-trace, if 
dev->ats_enabled is not set.

Function arm_smmu_enable_ats already prints error message if ATS enable 
is failed.

> 
> Robin.
> 
>> +        pci_disable_ats(pdev);
>> +
>>       /*
>>        * Ensure ATS is disabled at the endpoint before we issue the
>>        * ATC invalidation via the SMMU.
>> @@ -2453,8 +2458,7 @@ static int arm_smmu_attach_dev(struct 
>> iommu_domain *domain, struct device *dev)
>>       master->domain = smmu_domain;
>> -    if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
>> -        master->ats_enabled = arm_smmu_ats_supported(master);
>> +    master->ats_enabled = arm_smmu_ats_supported(master);
>>       arm_smmu_install_ste_for_dev(master);

Thanks,
Ganapat
