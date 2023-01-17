Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0899B66D59F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 06:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbjAQFb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 00:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbjAQFbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 00:31:21 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA33B279AD
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 21:31:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZSqa9nKJGLWgF49Ti1Eza1OTsWl1RqeiiY2A0/M/RtsyfQeQa/WngZTR9EPald0gRkoc/8VlZ5HsghJ3u3n7oUtKb6ljm62ABPe6sk+VNZsfh2E9KpfaaMlVSi+XygEf5Y5ankA+Pou53SWDogi2DxFxwMDrd52cHeXJKtdaFLUyfonn+3FevMu/tF5mq+i+CJN7Rmmh5903T5obkvli4CnJUE2iXYKMRHvvXpLpys//eV0n2jnQRq5Zu9+lAlEJQQ92k58UctxApruMk1PNB2gl1ppwvvFLVeVi0lzS/fhQrrWbf3brp2VlHljb/mdIlDLDNFb41wZHhleSl1X0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRTg9xRvkbZdwpDWCV/D1cqH4hdrT5JC8ixTMT1sqg4=;
 b=PHLq3NgHK60J6Hvj3uVWAxjIhe0F2E+Y1PK/Qs0pNvpKbrg+tDdh1QO5GCdVb+beJpYP/7QkVvXz9Eb3PlNT6ODT60e04y1QbSV4wIXafe0PnFwIBURojR1ne0iIeeL9anZ2kYXGwN8mXDdu91GefzbqLA9dqtuGdAP23Jqlb5gAf+SbctJQvkj636b3gH7klU32gRB5exJIml/uspN4LVKJegYgm8XdnJmZqxcFgLPOnWrczdXvU+TocuRkoJgdn25Rr1Gc8lr3gdTlOctu9HV9HIeWTZyYWBdkCCYTPmNrMCGRO3TIwySTR5LqHaDADcK1NAy4w5E6ewhbz5QZ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRTg9xRvkbZdwpDWCV/D1cqH4hdrT5JC8ixTMT1sqg4=;
 b=5CgRq/kr/N7oAHWk4E0b02AWHwAdE6pKn6BNIjObo8BzksMjeIzXrY13IGINrye9aNxhPqQOKmSUegwpH/qcR9LMFxcbrgduWk0E8AtVXGBqDyuzuA/ga1yOWoKeHy8xhXqNrQYq0u3lGrKM1b8ya+JympMs8higCcaI5aNOJZQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 CY8PR12MB7489.namprd12.prod.outlook.com (2603:10b6:930:90::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13; Tue, 17 Jan 2023 05:31:18 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::6add:bbb2:9c75:c013]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::6add:bbb2:9c75:c013%3]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 05:31:18 +0000
Message-ID: <6d57350a-6d07-42d7-2b1d-153bf5847b0f@amd.com>
Date:   Tue, 17 Jan 2023 12:31:07 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/4] iommu: Introduce IOMMU call-back for processing
 struct KVM assigned to VFIO
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        joro@8bytes.org, robin.murphy@arm.com, ashish.kalra@amd.com,
        thomas.lendacky@amd.com, vasant.hegde@amd.com, jon.grimm@amd.com
References: <20230110143137.54517-1-suravee.suthikulpanit@amd.com>
 <20230110143137.54517-4-suravee.suthikulpanit@amd.com>
 <Y8F6Uoi73BK6R+mc@ziepe.ca>
From:   "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <Y8F6Uoi73BK6R+mc@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|CY8PR12MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: 381498eb-4fb4-4f54-6c40-08daf84c0ed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: scAUcaP9/T6uwiNFVVFGXBTjbCOlwSANfy4P2eFdPV03gUEBlGuNSUesaqsi6eiglDNkFA7871aGfiPkSFaxJvpWMIlw9paU/RDgELNho746wjR6uDm0Uf9XRqL3fqIGHLqXIc28CbNhrz9e+IDiF0FN53m8bv+p8J41p45nZauHcArKZXNJmIQiCci9IqdelOezRRBX9lbsF9NnnHWbQrhmVnubRIHlwo8/0fxAZRK6J9cTcWomXMSwlX3Qrr1HSkIvBCRVBzYdtx3/uvfbfuxW77GwALKBJsCFaIC/iXAUW6y+iGNafoFQkTlAEIdWeSV4vmNneHRPPu6bwi2lPFlzwGSewPeRMAG6KBW6WEQQgAPbQCM69m1E7DJWbrbR4LdQAT+KM+dX055VZqu5UP9jeFN6VjLshLT0eVWlJb6TJggs6q0du4SF+s9GuzyJdZf1O1EdUkDnLz1NUI0ObAS/2+YsEsp8gEp6IPka/mn/Q8We7cThYYYUiXjuD1KLSelDFLX+4XbbmYuD53greFkMsOd6tDtq/NM2/Nh25+2WAD0ombcnttHx03jUDwr7s00xLtsOTWABvDeuojaMxPNfHAwB/6YPu88L0UIlmVC9yT1zuNOfcnYhYATXWpu55Xjmc/6da8bdniGd/egBUspxI80qjcRW4PQMtE5jO0lxGPmYrTfjB5zcxG+H1uOKqTWIyYyjoV44xBX2Jr/mYmoHNGNxnxweE84x0U8qB1k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199015)(31686004)(6486002)(6666004)(38100700002)(478600001)(6506007)(316002)(53546011)(6916009)(26005)(66476007)(186003)(66556008)(4326008)(66946007)(8676002)(6512007)(8936002)(31696002)(36756003)(2616005)(83380400001)(2906002)(5660300002)(41300700001)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFNWejZ6OW9WYWJodmdBaEVocnFPU3dETDZ1bDVmd1FHRzk3di9UQytDc1Nk?=
 =?utf-8?B?UFBtZUJGbVdwc1drOG04Ym5Xb2R2YmFIK2pjcm1lTTFRV1k3YStaMlhSbEd3?=
 =?utf-8?B?L2tSa0FYcmpXLytyMGVZY3l6OHNQcjhxeXV0Vjg2bkNHQm9SeVAyMDYxRHhD?=
 =?utf-8?B?d2dqWDVwdk1SSGZRVkJ2MmJRSHhkU1M0OW5NYVV2RGpjcnRiSFN2U0xPekwv?=
 =?utf-8?B?TGZOajNSSk53d3IxMWNSMGJLVDljVm5lNFZnVHJiZjVkYTFFWGJsNEVFVEU0?=
 =?utf-8?B?ZDViMi9CQlZzcUVvU0k5ME5QYjhOWFdpYjNqOGlnaHJDQTZiejF2eEluaXJ0?=
 =?utf-8?B?SzRTSjljOHhPSEl1UTRYRGkrRDJTZlVJOC9Yd1pvbThHK1NvUjlPRnNWYjhy?=
 =?utf-8?B?YnBnRmd4N0tuZURZclNoSUROakVvVklNbzBYTFhMcXczS1NaSWE4bUVmQy9E?=
 =?utf-8?B?MkdTNGE5V3VEMFh0djV5SXRvVXBMbDdlR3VMa2ZVOUN1V0o1MkN0Y0pOK1RD?=
 =?utf-8?B?N3VuOXdQVWliQTBxZ1F4dFFIMi9abElsM0lKRVFkdkptVUpXZEFYMmJiVFEv?=
 =?utf-8?B?Ni9veVdSaE4vVXBoVENWbXJHVWdVL2VJZjZXT0JDKzdlUUNudURQR0NoZ01z?=
 =?utf-8?B?QUMrOEtOZGJQVllIRHgrb2pmbW1yODN0bkZLUDgzQ2k3SlNuNjVNaTkxU2Iz?=
 =?utf-8?B?NE1WZXQxeHJzV1FOQzVDd2ptc2g2VjJqbTRKQ0VRRU5IRVRRYThtSnBKYVZH?=
 =?utf-8?B?RWdKbk81Y0ttaFFMamxsb0Nta2Y1TE9nUGh5bnRuS0hzdEJDY3ZKaUdLQTdi?=
 =?utf-8?B?TFVnNjNuVTBwNVFPSm4vdVdoVkRaZk9QWm1wK0pUUHJHRFhsRjFGcW9aREx1?=
 =?utf-8?B?UzIzTnA1eHVmMmpyVE5uY2dxSCtWUmVYVnpxc3EyRVhVSzYrbno3WEY3RHcw?=
 =?utf-8?B?QVQvSnRYS0Y0RkxnMjJUcmFIdnNHQWYyaktpeXN3NWRHWkFOQkVyVWNrajdZ?=
 =?utf-8?B?NkMzTkhvVmhWR2k0VkVrLzVoMDBhbnUrd3U3aDhKL2oyYk5CSnFDYitNTjZa?=
 =?utf-8?B?ajFQeU9YRlZYUUNjNExOOG12aXJUMWgxc2J3YXRNc3UzUnB5NTBiS2RNUTNv?=
 =?utf-8?B?bFZRSDV3eFlvR2VRMHBKUytZTDgweGZJTFNKVFhlRDRhSW94Z3VsbjZCM25p?=
 =?utf-8?B?TUtPekxRdnVONGt4aEdaVnl4ZVRHNVhFSGlLL25uM0tzNHBDanI5OG1ESVVa?=
 =?utf-8?B?ZHI5Z3FYaVB1dUVaQitONkVLSWszdE02OWdhRHVPSEJuVEJ3UkRTRnZBbm9F?=
 =?utf-8?B?U3BIaUxuRFRpUEZTanF6MTRaYU4wdmN0WUhIdWpwRWtkUWl0amQ1Y0J6ZmZH?=
 =?utf-8?B?elRYejdhMno4dWVCeTMybVZWbUhacU9yTGhxYlVBNGtyYVoxNW03U2FkYmx1?=
 =?utf-8?B?ZjkrZjN1SXFrOU1BTzRlUGJVV21TWGtyZzlJdDEvT0p5TW1GR0FNNzYvUFd2?=
 =?utf-8?B?bEttWm9qMlcyVmFmYm9kRzZJM2drbW15WGl6cFJ2V1JtZFA5K2k3dDE4WDNE?=
 =?utf-8?B?U0xJMGZqYlpwN3RkL3FxM21CUmFoVzE5ekM2UFBURHQ1VUo5U0I4MTQwU0Ux?=
 =?utf-8?B?Rm91TzVYTGxUN0JnN0xjcTNnUHlFbDhwT2lMaTRiK1JIaFVJbGQyK3ZTYlQ0?=
 =?utf-8?B?Z3dBM3RlWHpjbDlFRGV4b3hpUDVTeGEwVHB3ZytFL0VLcE9PNmtWU2ZRSlR3?=
 =?utf-8?B?QVo5c3IxaDRkSEM4OHBiY2xUUFZFbEZEeWVld0NtaFBRWG4zaUdicEJISzli?=
 =?utf-8?B?Rkp1SXVnZEE1OGNzaXdGSjlsRFBQZ1hReE5hbml1d2tTMVJKazBxdEJmSVN5?=
 =?utf-8?B?ZENpQ2IzcFl4VEk0RGtvcDF4S3FkNmh5MUswY3N5TXRicWVYMkRnbk10U0Rr?=
 =?utf-8?B?T2tkTEgrOU5heFYxcXUvSHl6d1YvTDEwYTVvL0szT0h1S0EzZVNkSEw2Yjda?=
 =?utf-8?B?TFo0eGhvbE1sSnh3clVyK1JvTGR2TlhsTzFyb05wRjdMdFduVVlwbC9qdXAr?=
 =?utf-8?B?aVJCYVpMaStTcERubHUrTEVtYm5kZnN3UVEycVNvZ09GN1VORG5URnpCcmwr?=
 =?utf-8?Q?Cf+Xbf3tPzDKcw9bBupi4UURJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 381498eb-4fb4-4f54-6c40-08daf84c0ed2
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 05:31:17.9970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: haACUWwN6EdV0GHP0CZWSQZ30Dt0LiTTAGl5tACSoUDbnZkrtLYWYiyNwhccK14/SedqyN8PN8KHOrCQHO1gtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7489
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On 1/13/2023 10:35 PM, Jason Gunthorpe wrote:
> On Tue, Jan 10, 2023 at 08:31:36AM -0600, Suravee Suthikulpanit wrote:
>> Currently, VFIO provide an kvm_vfio_file_set_kvm() interface for assigning
>> a KVM structure to a VFIO group. The information in struct KVM is also
>> useful for IOMMU drivers when setting up VFIO domain.
>>
>> Introduce struct iommu_domain_ops.set_kvm call-back function to allow
>> IOMMU drivers to provide call-back to process the struct KVM
>> assigned.
> 
> Also NAK
> 
> Connecting the iommu driver to KVM has to be properly architected
> though iommufd.
> 

My understanding is the kvm_vfio_file_set_kvm() from the following 
call-path:

* kvm_vfio_group_add()
* kvm_vfio_group_del()
* kvm_vfio_destroy()

to attach/detach KVM to/from a particular VFIO domain. This is an 
existing interface from kvm_vfio_set_group()

Here is the call-path:

kvm_vfio_file_set_kvm()
	vfio_file_set_kvm()
		iommu_set_kvm() <-- New interface
			amd_iommu_set_kvm()

Could you please elaborate what you have in mind for a properly 
architected interface via iommufd?

>> @@ -1652,6 +1652,7 @@ void vfio_file_set_kvm(struct file *file, struct kvm *kvm)
>>   
>>   	mutex_lock(&group->group_lock);
>>   	group->kvm = kvm;
>> +	iommu_set_kvm(group->iommu_group, kvm);
>>   	mutex_unlock(&group->group_lock);
>>   }
> 
> This also has obvious lifetime bugs

Could you please also elaborate on this part? For detaching case, KVM is 
NULL, and the same information is passed to the IOMMU driver to handle 
the detaching case. Am I missing anything?

Thanks,
Suravee

> 
> Jason
