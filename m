Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA946D5831
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 07:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbjDDFub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 01:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjDDFu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 01:50:28 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EAC1713
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 22:50:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRKVaMUXa4sSuQBz23pY/OOVOeHII+ouyTPQhqg6ygaXmY4tI2mERCm/WMAxqaolpd0pjXIQzdnyCZ/8y58nXUMXi/gZR58eD2E6ILTuLUa39m93cZMVi52/3/5sEfqTHbAwBNNvwginhEKcPionR3/nb4/HWHpRvbHE7RXmgdblB2sRujkG1KEGgVAcppY/5n8s6VWlQg4X+m5v5uPRGsQC2TN8OM8tfYGDMTUD65SPqHiOu2gZdDn+FRvirXE32nbNaQAG24NLyw7KWBLxFccs6iVPi6RFaDSejkF2Lgx75Dc7DPlmHjFU7hFPZj625yDUYr+zDfAAhn0KbIYuVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLSNres3gaUhZ7ldmDrFlF0Mk65SDX3k/Tlji4BaFlg=;
 b=PZDc0rJhY8oAxSDiyjyZkuZee1e3yq7JqOt419X4UG6YYuWWMcjeZvhsoz2NfcvUWMnA2t8iSIUqY6Pk47X2bhAmwW8anMGyXXsrL2AZ2h48DR3bx5uf/imI3/CkXD8IN5MjbvWA4OMXC95NYJ/quFZNAHiBp+mW8ltavN7npt11o2JWSSt7tWTyULv1XjJHAsStkxNLy5EWLxf3IIvltTvOQ4kszKsD4d584Ag0JkyXzexdSwXkoQEUNg1pyLv1scPLs/KkcrYw44YALdaAlo9EMVSKkEjPrMzh+w27DkdxPh/J0DvNUkBCPAE0ARv12tW/2P45/J1ljWvzgfBQaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLSNres3gaUhZ7ldmDrFlF0Mk65SDX3k/Tlji4BaFlg=;
 b=hxL0lA9MdAGhwSk/ivvroRdQTg7m/ojeRzsJvRkTq174V3jWjGqxMOAKw/loZ6jVTD26dxzwRTkq2wcO76dcZfQbrQ3lIR0WNyBS0Bs2zXuPQVBPa95vPQXOrV+oQ+KP2BNW92jZbVG2wNVrlNFtGy4cwV/sM/P7XoSeeebscxs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5827.namprd12.prod.outlook.com (2603:10b6:208:396::19)
 by IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 05:50:23 +0000
Received: from BL1PR12MB5827.namprd12.prod.outlook.com
 ([fe80::3f99:52bd:6b66:d22f]) by BL1PR12MB5827.namprd12.prod.outlook.com
 ([fe80::3f99:52bd:6b66:d22f%4]) with mapi id 15.20.6254.026; Tue, 4 Apr 2023
 05:50:23 +0000
Message-ID: <597158eb-3c16-adb4-9c4e-3b7519f6d200@amd.com>
Date:   Tue, 4 Apr 2023 11:20:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH] iommu/amd: Fix "Guest Virtual APIC Table Root Pointer"
 configuration in IRTE
Content-Language: en-US
To:     Joao Martins <joao.m.martins@oracle.com>,
        "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>,
        Kishon Vijay Abraham I <kvijayab@amd.com>
Cc:     Vasant Hegde <vasant.hegde@amd.com>,
        Santosh Shukla <santosh.shukla@amd.com>,
        "Nikunj A . Dadhania" <nikunj@amd.com>,
        Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        alejandro.j.jimenez@oracle.com, Joerg Roedel <joro@8bytes.org>
References: <20230331061723.10337-1-kvijayab@amd.com>
 <575ef405-9d43-b99c-cae7-f88cfd6063e2@amd.com>
 <12621587-41f2-7d62-a332-78ed3d3a5569@oracle.com>
From:   Kishon VijayAbraham I <kvijayab@amd.com>
In-Reply-To: <12621587-41f2-7d62-a332-78ed3d3a5569@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::6) To BL1PR12MB5827.namprd12.prod.outlook.com
 (2603:10b6:208:396::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5827:EE_|IA0PR12MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: e99e33f6-dcf6-4518-c642-08db34d07b76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uHX9EzS1V3Eke9YVr8Y+8LV3NCdKjC++SSF0zx5m05XPXtu39nwSwLquEmq71otEe8mQbg0y4wEXpMTJes4QymuXnMwR/jrA11hgrroH9fBG1MN1a3jl6N+inEHzx1UrD7+w6fOAIQ47lwIqECmhR8yxfqgSe1EAjDAYIygMAYbJvEOzw81o06yG965gVFmcxRnGfZ+ZWd4vWnMbgV2oY6PJEkBQLIdHSCgbmb+BIXUwz/P1JqlSUs0DwOD9nXplz8KKZKdvnG5W/KcX5tF05f2VurIhjDwpolrYcB4OVkMdlhMF6HokgFC3eCnjj60y+ighUEV01RL1cQ+jjqw3OrMojdFW64tDgHC992uGifLqGlU4TlKVpJIYQ7VgwUu2544X56WrGAJExm9w/NRQw8QcMOO0FUQaNh51f/SaqkasXi0ld3ewpfbLOQDc/t0tMxpg57pQnwQWlPFfEDoA5JxNLi3+ZuztnekFU9NdN38px8OdVCpPSe99Vz+guxjsuR8rCgJAPXCh9glUqtN2fyqtqXKW4aUaNYGR0k8ORUr2i23OPoavb7vHq2zUvYGDCnTYws5bJfkAuVQP1gucFLaa1YSPWFE5pu/M1MKL56p15GAr4D6qDTr9F6nig9510qQVoAEfVrAUJog+pErN6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199021)(31686004)(186003)(2906002)(6666004)(6512007)(26005)(53546011)(6506007)(2616005)(83380400001)(6486002)(5660300002)(8936002)(38100700002)(478600001)(36756003)(41300700001)(316002)(54906003)(110136005)(31696002)(66946007)(66556008)(66476007)(8676002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFMyOVVTbFg0T09rcjVOYzZuZEQyaFFXdVFZY3p4RXdYOEg2L2NuRVAzemZM?=
 =?utf-8?B?OXlDdFBnWjFhOWJWMGltNkJpM1NXUWxJQ0lQb2RxWlhtY0haclVTeVduOEtl?=
 =?utf-8?B?c0l0ME56NXJTb2R5em0zTXlLK2loQmRhYUFJMnEzQ2NUNy9xTHQ4NkY3cHhm?=
 =?utf-8?B?cmcyaEZvNjBZMi9nVWJ3RmF6cHA5NWNBdGRtdk1vUExrMjUvWkNsbkJKckM2?=
 =?utf-8?B?WXpWdW5ZN1N1UW8rZWtJd25qTWZwK0wwMVB0bzZWUmVzcmhNbXhjdVpRa2ZF?=
 =?utf-8?B?Yzg4RVI0L0NadjVUcW56T2h3QTEzTTRLTnhKa1A4SXR1NXpYVkJWNDAvWnQx?=
 =?utf-8?B?WFBOMXNKZURVWHZNUnJ6VXJyU3pxVXA4TDY5MmUraUVXaGxFQ3RrSWxmVTRv?=
 =?utf-8?B?TkFxRGxjNnhUcXJ5MHVhcDFsQ1hOQVZ1dU9PZlNnQjkwZU00WnhCbjN4NW96?=
 =?utf-8?B?U0VOZ1d6MWFoclBqbklXdGxvOWtqdndxVVRsd3I3bCtHL3A3YlY3T2szTmto?=
 =?utf-8?B?eU83TVorRkc4SWFINkdHT0RzR2JBVnhGSW5QS0xsU3ZmZ1BodDNOS0dZSmNU?=
 =?utf-8?B?SnZJSWE0QytzWm1tY2Uya2UvZmtmWUNVdE1rVHY2U1ZkcFg5bWhEWGwvUFhD?=
 =?utf-8?B?QzFPODFpUmtUclYxanZydHE1enlDOW5xaXdqSjA3N1RGTDByVEFFY0hMYWNC?=
 =?utf-8?B?WnRmS3laQm5VaEkxZlhkdG1kUFZLc0FoaGMzckNhYzQvWW12SkZxbHNNSVFO?=
 =?utf-8?B?NkxVSmk3cUdCWVo2Q1VBOEZySGhkcktOWDVDZ0I5T3VRR2VkWmY1ZkJGQU1m?=
 =?utf-8?B?SjdNM2hiclI1OHk4aGRpNFBucWZNaG5hZlRjdWplTkgxNHVVQk1BYkdzd1Nu?=
 =?utf-8?B?MHkwY3dKUGI4ZE5VaEZmcmI4d1hFSHBUNmllZzdZSlN6L2JMcDNWRkNDNHhw?=
 =?utf-8?B?bGEwM3hUUjUxai9ZR1Zna0FhY2hBeTdrdnVUUXpEVVdMNmtxbTRtdndMRS9X?=
 =?utf-8?B?RURWMjh1UURHaWNWaEZvTkE4RDFjU3d5QVVTT3VBdUJ2NFBFTDlsQUhJUENT?=
 =?utf-8?B?QmxnbHd4QkkveGJlSHpydlZrbU1xd3kvUXg0YkljS0pzckZYUDgrU3RoeHBl?=
 =?utf-8?B?dnhEWktNMXVRWnNPQzRsUTR4WndtNlZ4T01zc3UxSjQ0azdVeG1SZnl1Um8v?=
 =?utf-8?B?QVBldHVicUR0VVliUHlBcTdLaXE1L3llL0tPWmdrY0RFaFllMU95VlVUdW45?=
 =?utf-8?B?SmlJQzhWb2tHZUswZjBURkZXOXFYT01uQ0R5RmE0aU5tZkJMeVVQaGxVK1dF?=
 =?utf-8?B?ZkpNak5nQkJGeHlDSUpuSjh4b3huNndEMmRXYmNTK3BJajY5TWYzSzJ0QUkw?=
 =?utf-8?B?NW9na3A4ZHBWZXlZMEdLOGRtMzgzRXJNTTlmS1FWa1l0bWlCd1NWcXN1OGxT?=
 =?utf-8?B?Nng5SUpDUERpVXp2b0M1ZHh6bXZRb1VkS1czMHhpeTkybjVJUG1NU202Tm5h?=
 =?utf-8?B?VCtpTE5hSHoxMFNucHdhUlVJUzVKUTVMZkRLem1rQWNsVDNETTI5R3BPbEsw?=
 =?utf-8?B?VHJPYUtpYWozN2Z6THdzTDFlOC82QmIwVDROdGdIR0l1SytNenBVbGVuVGNM?=
 =?utf-8?B?dVU2ZWVuQmhHL1dxTGJhWFpCS3hZRE0zZWtuaE1FTkEzdmNtMFlnb2kzaVEx?=
 =?utf-8?B?NTdXaFl0TlMwQjI5SDRHNzVIcHhocnlEUjRhS1c1QVBXUytoZk5leS90b1NQ?=
 =?utf-8?B?aUVsd2I3eDBBbWwrRlZQSXU3VGRMUzFIY2hheDNJSTdGdTBlbG9TZEMyNGJD?=
 =?utf-8?B?ME9COENoRWdoTnZBTEltZk0xSyttZ2RJYlpDWWVPQzgyMVZZREZibTR2S3Fi?=
 =?utf-8?B?N2Q3bjdBZ1lRVTYwYUtGVmRJc01oQk03MFVnR0FRS1llMG9aSUNsWDNXT1JE?=
 =?utf-8?B?VzNDVzZKYmpORkdUODhrQzFwZEJZdDZCUWphQ0FNOHlKWkM2SU80WDZUTjln?=
 =?utf-8?B?SmdETXhCOXV3ak9XS0U0RmVyODZQZTNYNGJieDhDVXprVUE0cndqbUdQZ0pa?=
 =?utf-8?B?cE15RVhLK3NqWEphOHY4SVloajRwVVBaQWxYbkQrK1pvME02NHk2em1FOVpL?=
 =?utf-8?Q?aFfFlU0u9UBQnwfsq8X19xyWQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e99e33f6-dcf6-4518-c642-08db34d07b76
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 05:50:23.5553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u5Zs+Gf0CMAcpSs1zJ84d679KDopgIafa9hAY3HAJHFUrP+F7ETDkveH0e5orW0zkdSSWDj27zY/GnFhrrFeNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7555
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joao,

On 4/3/2023 3:41 PM, Joao Martins wrote:
> On 03/04/2023 05:29, Suthikulpanit, Suravee wrote:
>> Kishon,
>>
>> On 3/31/2023 1:17 PM, Kishon Vijay Abraham I wrote:
>>> commit b9c6ff94e43a ("iommu/amd: Re-factor guest virtual APIC
>>> (de-)activation code") while refactoring guest virtual APIC
>>> activation/de-activation code, stored information for activate/de-activate
>>> in "struct amd_ir_data". It used 32-bit integer data type for storing the
>>> "Guest Virtual APIC Table Root Pointer" (ga_root_ptr), though the
>>> "ga_root_ptr" is actually a 40-bit field in IRTE (Interrupt Remapping
>>> Table Entry).
>>>
>>> This causes interrupts from PCIe devices to not reach the guest in the case
>>> of PCIe passthrough with SME (Secure Memory Encryption) enabled as _SME_
>>> bit in the "ga_root_ptr" is lost before writing it to the IRTE.
>>>
>>> Fix it by using 64-bit data type for storing the "ga_root_ptr".
>>>
>>> Fixes: b9c6ff94e43a ("iommu/amd: Re-factor guest virtual APIC (de-)activation
>>> code")
>>> Cc: stable@vger.kernel.org # v5.4+
>>> Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>> Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>
>>
>> Please also add
>> Reported-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>> ---
>>   drivers/iommu/amd/amd_iommu_types.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
>> index 3d684190b4d5..990614b8a1fe 100644
>> --- a/drivers/iommu/amd/amd_iommu_types.h
>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>> @@ -1001,7 +1001,7 @@ struct amd_ir_data {
>>   	 */
>>   	struct irq_cfg *cfg;
>>   	int ga_vector;
>> -	int ga_root_ptr;
>> +	u64 ga_root_ptr;
>>   	int ga_tag;
>>   };
> 
> Nice catch. While at it I noticed the following:
> 
> * ga_tag: The conversion of uint (in kvm as they use proper u32 for gatag) to
> int will miss a bit thus at least VM IDs with the msb set will be stripped from
> vCPU wake ups? Fortunately the 24 bits for VCPU ID wouldn't be affected. But
> ga_tag should probably be a u32.
> 
> * ga_vector: this in principle should be u8 per spec, maybe it is OK to stay as
> is to prevent compiler warnings as IOMMU intremap struct vcpu_data is using a u32.

Thank you for reviewing. Will add fix for other data types in my v2 of 
this patch.

Regards,
Kishon
