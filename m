Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBDE69EE7B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 06:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjBVFlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 00:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjBVFlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 00:41:14 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE0A3524B;
        Tue, 21 Feb 2023 21:41:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvmpxzZqUQLYNQC+ECWCjWW+QuOKwl0AqEuU7NYnByRlNmU6/T2w6nn6aZQCfrgykNqgoNVXU8gqKXkjlCeD5HFy8vPiplUDtor2H7KQlKBd4UMxzGTyzfM5FtkK0MpdMpwDzvOuPhTpnOUSUWVYMDuTyJtmdMlyVMz+elOHAU9JBRSEfDc5TX4Ydm/CrE4YCwgd2AQyg8Ckcaw3zWh0B6u68V2JKrpKqVp8GK+inIBKm5pcjXslurpbP90Gv+mS4CHtouILw3ETap8EdFlTg8YyD7YzSAAG1f7Vm3o26RdsDjolMyCxtWiz1ed1MfWXtlDx/EzBTw88rP71rwKESQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1d7dF65/z7pY+/NlzLH5SrVEOV96HPK9A4PZMExfq4=;
 b=NZcEBpk5Va8dRQ4JlwY2ZYC6uceeLjp8re5eDgggCyXlOc5qfwqI2y4l0yCV0C5rPfdp0Lzbk7D9idQVeYLEOiLU1Due1LlcaeyUlZMfmX9Cveqc35QYUnFvCUjyNeaQqiyGlCwputPqFnH37p5WhWB25o5scnm+iAoHHhxVIPHxMs/02oDpEHBnayaSFRiAEIyEMJKSWjYYrAFXvPr6MtTYqkTv3iEJ4M7+JtBQKrx21DBuUZ/3BR08fJ0X/WpwysrTXOePd3dY8OZcxoQ1JmzT9DSNkCnmGpb3uVcIj/yCDHXRmi6hPMZ6uGtJbkRpvW1z0paQBEBk2/Da9m9Vpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1d7dF65/z7pY+/NlzLH5SrVEOV96HPK9A4PZMExfq4=;
 b=SiJciVSRKrkl0yWiA0oB5KZi4VsmGGEoVhsvIvWMsnjhtAssCThuef98mRstKk1vCF+ByFqzc3OzgWGVWlzbiWjlT92xqnlkWlWMRIV3io+TVNoDRI2Z23QZ6q/s3MH6DGdfdEYvycFusAoUWQhlHsYc6h538Rp6J9COoDAgZgA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3082.namprd12.prod.outlook.com (2603:10b6:5:11b::12)
 by CH3PR12MB8534.namprd12.prod.outlook.com (2603:10b6:610:15a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 05:40:58 +0000
Received: from DM6PR12MB3082.namprd12.prod.outlook.com
 ([fe80::8d69:5417:b5e9:92a1]) by DM6PR12MB3082.namprd12.prod.outlook.com
 ([fe80::8d69:5417:b5e9:92a1%7]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 05:40:58 +0000
Message-ID: <36b429ab-401c-b0de-3331-ba72246bc270@amd.com>
Date:   Wed, 22 Feb 2023 11:10:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v8 2/7] iommu/arm-smmu-v3: support ops registration for
 CDX bus
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, eric.auger@redhat.com,
        alex.williamson@redhat.com, cohuck@redhat.com,
        song.bao.hua@hisilicon.com, mchehab+huawei@kernel.org,
        maz@kernel.org, f.fainelli@gmail.com, jeffrey.l.hugo@gmail.com,
        saravanak@google.com, Michael.Srba@seznam.cz, mani@kernel.org,
        yishaih@nvidia.com, jgg@ziepe.ca, jgg@nvidia.com, will@kernel.org,
        joro@8bytes.org, masahiroy@kernel.org, ndesaulniers@google.com,
        rdunlap@infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     okaya@kernel.org, harpreet.anand@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, git@amd.com
References: <20230217132830.3140439-1-nipun.gupta@amd.com>
 <20230217132830.3140439-3-nipun.gupta@amd.com>
 <4cc935e2-8b24-8060-5070-fd6eb85f07b6@arm.com>
From:   Nipun Gupta <nipun.gupta@amd.com>
In-Reply-To: <4cc935e2-8b24-8060-5070-fd6eb85f07b6@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0221.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::17) To DM6PR12MB3082.namprd12.prod.outlook.com
 (2603:10b6:5:11b::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3082:EE_|CH3PR12MB8534:EE_
X-MS-Office365-Filtering-Correlation-Id: 85934b07-6d16-4444-2f77-08db14975f48
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zTd6prrDXwmGfJvc8xjVgu5BfpgvnVJnpVy3AND8dkOYjuIqMj9cckSiU2kbB6z9s5JsPw1l8Qk31rx+NXAhsDhLh+AY54cb6BtzX2wSM/I3VXrJNMWmSEJ08W6r8uJFf8er6zEPaWW9KtirF5oLcwk+2AaE7+a0QFOca3f+DjQB+yvlMZxgsEbmWsYv/JvI7NocX1AiwB8qU08dw9aTLV/DaCX7f03fpc8Z3rfPyj0dJQkl7cR0HcPNbVEiqtV/K3ReSj6RusTxkhApAUffPzhaneFBFplFTh+A6UBi+HJKBcIl2QnNsZOyJp/PjqE9H5tXI1nUSo5Pu5Dbnpz2HdWZzq1RQNxZqM9nQcsQZOpXei/8Mmo/3u877q2R9PvCaQaxFvf9kYZApZ/dK05Qz1rd2vH9HdHEnSw3R+cEgrtWm7PhlgvhZhNgjdgl68Ds+iNfopcKBgpywwSM0bLSkBl2a5UathHinzw/1PPnSsHZT6XGoNtNnL7tkQJJbVsMRLvIUfkNOZjp6hdfcfEP3ZdcOWEJzX6jMuHH4Av3d7Ay35Ivf0fSutLbstZ39gdN2bODKssSc1fXWwqI0se0B+UBdAFJq/N80PupOXX7QuabQFUvtzHhndn8F3LU9FbqhjVHZJJ2sBTQOW0D947J2XhMCRjlTkXA1OJmk/FMYyEbxqlokPKWjIV0yEZviJZupkYG0Wp5IWtf1XLP+I4KweFzWm+XjbvCaByqVtSYjk/aEexfrIP75wfHwLrsZRow
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3082.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199018)(83380400001)(26005)(316002)(36756003)(6486002)(6666004)(186003)(6506007)(6512007)(53546011)(2616005)(478600001)(8936002)(921005)(38100700002)(31696002)(44832011)(86362001)(31686004)(7406005)(7416002)(5660300002)(2906002)(41300700001)(8676002)(66476007)(66556008)(4326008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0lWcExyVC9kZEs0dEM4MGE2WEoyNTZMY3cycTdWVUl2TTg5Q1BhSVM2TUxF?=
 =?utf-8?B?R1JCQW94WGFyNU9TcFh0Sk9Qc3l3T3hMaHVObUZtbU9vVmZFc0VyTXdHYnZa?=
 =?utf-8?B?a2ZCRW9maFZiSEMyN3pCQ1ZWdjBUZFJJUXFDdzdybDN2NHUwcDdsWElQd1U5?=
 =?utf-8?B?UTJnbmRyS0s4ZlJSRklvVUdMTHJhLzlyM3hYR0lFd0N5c1VOU2NBMTJTQld5?=
 =?utf-8?B?dWQzaVdtVm5wMnVTUkpLeGY1cVlWRnk0QUM5OENjWjhDbEVMS0R2U1gyano3?=
 =?utf-8?B?Z0Q3R0ZYME9hMWlMMGcxUjBmR0NVWlNUcExrV2krQVhCY1ZIR0ZrOGtXS013?=
 =?utf-8?B?Z1F5eE1tNi80aDQzOGs1QnE4K1NPMVhkRDhqeHpqWDdYV3Z5MGZ1OUNQY0lx?=
 =?utf-8?B?NWxhZngvMzRKcnB2cUIwZXowRFo1U2FpWkk2U0VqWUdScVhWOVQzM0VpMmhi?=
 =?utf-8?B?U1Q3TThTUlFGZ3VaUklzT3pvbk5wbGF0L0JrclgvbG5RaW51YWZQRE1uMjZt?=
 =?utf-8?B?aGxSek1LVU9EbVB0UndjaGNxNjJGd21VcUxzbHUwT05hWDlLb0lSZm5RN3hM?=
 =?utf-8?B?eExjR21BY2JRdWxHd0VHbzBnUzlQbTk2dzlCUERuK2trN0NNTlhUbklsWHVP?=
 =?utf-8?B?ZG1nRTNtNUVNL3JFWmNUSVZaZmJMWW1nZU5HOC83ZDNZM2hXeUc5MklIZUdj?=
 =?utf-8?B?dHFpWXRoaGpadmFCUXdBNHRFTmZ6am5GTVJ4dFp2ZzEvNGVyd0gvRXZQZjBC?=
 =?utf-8?B?WXpLbmkyd3pwVDVCVUJSeWxvYlFWWGNpVXUrK3FaNkJwcFdZcEpma3RaQ0VT?=
 =?utf-8?B?SG9OUjllUmZNQzBvenZvYVUraUYxbC9wYW1yeWFmZ2drVTF2M3g0TlZsRFVr?=
 =?utf-8?B?bndaZDRXend1RlVJaVdHMUlZNk92NERKMWhEN3AxalYwOFRKSTVaWSszazEz?=
 =?utf-8?B?NjNJQWZsYnh3a1A1N0NsTzZpVEZmZjVzUU9qMEdDc3VFTFVJVGhCSjFWaUs2?=
 =?utf-8?B?bjJhUEhubkpXMEF1d0lBb1Y0RWhzZU05bkgvZmh4SGE4eFBNM3RWNURWVXND?=
 =?utf-8?B?cElkd1V4SkMzbnFJSFlDbDRVUTZOcEcya05ucW5OR0dkenQ5TlNydGdLMlNo?=
 =?utf-8?B?amdFWHBOZFNscXhMSzV0QU5sWHU4VHJnaDllOE83b1A5TGVTNHFralFxQWpC?=
 =?utf-8?B?V3BRU09XNEd2NjhPNXBqbE12SzMxd0RxbDhhY3VQSnVITjRHWXNSZEFPZ0lh?=
 =?utf-8?B?QU01S0FEWDB2ckEzU1ZvMFdtaFhGVHBwUndlV0ZSOG1WeHVIV0xvVTQ5N2VN?=
 =?utf-8?B?Q3B1TGpHalhHUUxFYUR3aFYxWUhicTQyUms2ME9tVGhEQnE0NmNmN1ZOb3Nk?=
 =?utf-8?B?aG9VSW94cHBXSXJUTlhnajFCU2N5Tks1emxwUWJ6TytGbHErWW9pVDMwd240?=
 =?utf-8?B?d2ZaWVFGRWF4akdUR1pDTVZsYm42MDNjZXNHRytwTlVvQkNVMkp6TTFnMk9P?=
 =?utf-8?B?MXF2OWJqclFHMjhhem16TFdUZlk2R2Z5UENUczBKS1Z6VnZPejQzZzdrSCtx?=
 =?utf-8?B?ZHdCeENITVRiMm1pRG9scU15TVhrdmNiSFZ5ZTJBdzR3dXUzUGtpTFZuS0VH?=
 =?utf-8?B?dldIN3pJa0F6b0xYTDRlR1E0SHRVN3ZGYjRadzhjTGtIdGVwSHF1ekV1ZFYz?=
 =?utf-8?B?bzBvaHF0WWVmNlJHVXhzaEdNclVIWmdrdDVhUHRLU1ZySXlBUFFnRTN1bGpV?=
 =?utf-8?B?OHRBYXZwVmRkWmUvSGZUZk1tWEpWK3JmMkdreCtPcTFFN2IvZW9CcUFMNVJP?=
 =?utf-8?B?c3pST2t0SmpOdnVUV3ZXekR4Y1hKQ3J6NGw2L05XSnc5eUVFYTlXZzNNN2F1?=
 =?utf-8?B?L0RobmxSaFNyZEhNQXQzaUkrcU8wSHp2TXZUN0tsUXA1bXB1ZDVmRkhVeTRZ?=
 =?utf-8?B?Mk5IcitJd3RFWlBKUW1scUdLMVdsdTNrc3J1ZSswZ1g1ekhocXRZNWZGNUl1?=
 =?utf-8?B?OWFHQTdqTTg1Y1ByNThCclVUNFNHdUhJaWFSdXNOU3VJcmx0cndnZ3F2LzBI?=
 =?utf-8?B?anN6WVVNak1haG4vaEVrWUxzcnhORHVuOGpmOGJua1kzV0VBVy9JN25XUzRq?=
 =?utf-8?Q?wJVxCQH5cYLx6F4nsqzjZBZjk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85934b07-6d16-4444-2f77-08db14975f48
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 05:40:57.7990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kyZo5ReX9xd0b4f/9TR7m0UR9y6AFg6j8w7zxsB9wsk8jhqaPAqvmmn1z9QLHHhe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8534
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/21/2023 5:26 PM, Robin Murphy wrote:
> Caution: This message originated from an External Source. Use proper 
> caution when opening attachments, clicking links, or responding.
> 
> 
> On 2023-02-17 13:28, Nipun Gupta wrote:
> 
> Nit: subject should be "iommu: Support ops registration for CDX bus",
> since this is no longer a driver-specific thing.

Sure, will update the subject in the next spin.

Thanks,
Nipun

> 
> Thanks,
> Robin.
> 
>> With new CDX bus supported for AMD FPGA devices on ARM
>> platform, the bus requires registration for the SMMU v3
>> driver.
>>
>> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
>> Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
>> ---
>>   drivers/iommu/iommu.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 1fbe53354532..c2ff7754a4b3 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -28,6 +28,7 @@
>>   #include <linux/fsl/mc.h>
>>   #include <linux/module.h>
>>   #include <linux/cc_platform.h>
>> +#include <linux/cdx/cdx_bus.h>
>>   #include <trace/events/iommu.h>
>>   #include <linux/sched/mm.h>
>>   #include <linux/msi.h>
>> @@ -129,6 +130,9 @@ static struct bus_type * const iommu_buses[] = {
>>   #ifdef CONFIG_TEGRA_HOST1X_CONTEXT_BUS
>>       &host1x_context_device_bus_type,
>>   #endif
>> +#ifdef CONFIG_CDX_BUS
>> +     &cdx_bus_type,
>> +#endif
>>   };
>>
>>   /*
