Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9692767583B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjATPMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjATPMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:12:33 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4344180BA6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:12:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWgU781w17lJqaKNR9LcmZehvILbslCSTM2KOPCtmFBufA1rgafW9rie/aC+Ey/+n+UuV9oZkLBbojUaSvzs2aUD0tyewcYDMHIbimps4DGMYuzQOlz4Rc89dnrilyqhcB+EUpyuvUm1cRGPa1F9+GaXlrd4pu9a4s/bwJdE2oIney9ax42W9q6UxuaTAYTuzuCU8AQUPB3aYnrILJHz9aF4jZ0NtmBywCU4MATyOP3fx8YJ5wUmEz4ydcMPEZU+3s6PnxDbTxvu4bj8lLlQ8qN7AMm4Cu9a6aKuNaTLqUVvguiXP1tQeTMKu7wU4AamjTeNr704bM8TcikiWzrEpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wU5mKrS0+eASvE2AwcVZJDzgl4tpgam2V2c3jVs9MGE=;
 b=SbNR152RSMrOoPSNYgclIfBO5Jm7yI9z4RJATXSjlyt7mxvP7voXlgX8XJLt/EFpDb2OUNcWQXqVkKaktHbZNNO4MPfvok7b5m1end5aRWlo+aTz5duhO2DqJcW+1CU+Y0sWa93NT/rrtFub9cx+qsmAPgUf+J+23Ekuh54bxXCstk7PzzHTcprZMJsk6X3y8nchBKPLqwACudAlCDuqLvxv+BKzuJeUN64bJrXNSkEOixraf/yuEnn3cSXDh07aBAY3ZZz6Se18ij4IFhVpa36kJzWzqGO+gXbVZh0Xmc1Vmm7EPNwt+8Hcgo09SCFZEsH08scq85QnqIIfPi4YyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wU5mKrS0+eASvE2AwcVZJDzgl4tpgam2V2c3jVs9MGE=;
 b=zIiBD75I3Ca3rwu4Iuh4PNoymHuRdzDuXO3N11dVQ3bmr9o/xRaNTUv5uw+O6iN/xh62wuyfjz9Ar93AcD6LfAGaeW8alxn1qF7ZC0O/I94FKpRQF8TqIiYu/ZAoBwPtffWrZ/j8DXvktdBPslNF7kAS5zXQ7PNxzumvMhcrH1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by DM6PR12MB4896.namprd12.prod.outlook.com (2603:10b6:5:1b6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Fri, 20 Jan
 2023 15:12:29 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::5317:fa3f:5cbe:45e9]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::5317:fa3f:5cbe:45e9%3]) with mapi id 15.20.5986.023; Fri, 20 Jan 2023
 15:12:29 +0000
Message-ID: <c3fbec52-1281-eb1c-40f8-588438146c14@amd.com>
Date:   Fri, 20 Jan 2023 09:12:26 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 1/4] iommu/amd: Introduce Protection-domain flag VFIO
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        joro@8bytes.org, robin.murphy@arm.com, thomas.lendacky@amd.com,
        vasant.hegde@amd.com, jon.grimm@amd.com
References: <20230110143137.54517-1-suravee.suthikulpanit@amd.com>
 <20230110143137.54517-2-suravee.suthikulpanit@amd.com>
 <Y8F53dzdebKLTlOy@ziepe.ca> <90762dee-1559-58ac-220d-a13635d5032e@amd.com>
 <Y8mBczFH/Hw6xot0@ziepe.ca>
From:   "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <Y8mBczFH/Hw6xot0@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0223.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::18) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|DM6PR12MB4896:EE_
X-MS-Office365-Filtering-Correlation-Id: 46630e71-35b0-402e-e40b-08dafaf8bef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WfRDvHJRpIYRIAR3RW8wHEsNjNF/842dyYp/90h2r6WXVF8PUnBZl/h1PbpbnKi/MZvf6ieFrcNO5whLgLiKq2jNi3OorzsFM3vnYm4PJrYnAazIJ6qIH7yLARxGPpvvhUfsnJqvEoNIunBXbqXXRaMw2GMUAdisaGyQnugTqjzJNEt4qGSHIgdWhN5p8HJQuQmHQgGbPZ9v348kqvWiut6Qg5shxOyF4C+7emBKnY+vlfr2msPHA79gHaWozJD3FhMKDEkz/ZRiGHWv6PrJy6EzE2tbyU6aLYTnlbIZUVXoIzN5f0i5dHHEtJDBrUJ33yoE4nZ6s3NhMggBd+xUHPP6BoFcE/3v6CCcOB0rjoiUIOxmiAHkakeP6mGi9yObIS2Vnl+A8hvOMkvCY7g3UhUmCXMKAY3Ofgnnpe6KRZOFacphDE4E0vdjPDOK/hfIicey2U+qartYxdVPZ200v4KvNkuRy7wNsQ7XKFPi6ux2p/JXrespjT3/a6mhZWuYwBmpu1rRxaDiR1E7fPHxUxFJa6GjLpQ/L+U9ULEV6UaZ+aDXAgkAVEXxTz49K3EGKqTEUyTldery6GgO+7Ry03BbJxUKiD/grulcVYJiTnF7BWdvzreySnLtuMAlPI7b5ZS/95x4AE7PQy5PEzZtdjYyEXxbBrJSAOJXNLAAMihWlaPlDLpGsYIS6yEmPAVAJEFH2eVWLFUmXecHSBtUGu4tBSiUK3+2VImJRiD0WkfgoYHjWjf0zvctfUyd0tnWnVuDOhWWhC5A9O/09eJ5hA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199015)(38100700002)(31696002)(36756003)(86362001)(6512007)(6666004)(2616005)(186003)(53546011)(6506007)(6486002)(26005)(478600001)(966005)(5660300002)(2906002)(31686004)(66476007)(66946007)(8676002)(4326008)(8936002)(66556008)(41300700001)(6916009)(316002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TW1LTk93TmVmam5rTmZrRkw4L0MvNWpWZVpwd1RhQ3Fva0EvS1k0T0FDd0gz?=
 =?utf-8?B?YVNsaUQ2L25zTTgvd0FCUHhVVEVVeENRM1JINGRwS1dFUHk0aEZHQ1piMzc1?=
 =?utf-8?B?ekV6dEcwWW9aSFRFR2dRVmZOS2NVSHl5S1U3VmcwZ09oVml1WFBSUUU1RFhJ?=
 =?utf-8?B?aGJyVnFRRkI2SDVvNFFOc1RmYXBTdGRQMlArUVAzb3FZOGNiaGZSdkJwMDFN?=
 =?utf-8?B?Smg1cm52SkFiOXRpYnoxT1lQTWJ6RjNRcEFJVG5ZTCt1VUt2ZXVQRFhDS0hK?=
 =?utf-8?B?TWtob3hPa2FmdFkrWUtBTGZDT2VaY2puM0JPRVZQdjBIaE5xZ3RWQVczL1V2?=
 =?utf-8?B?eUtMSklQMForVFBuNmdZbTluRTkyZnVzQWlQVHl0LytsbzYyNnhJTFZpVTBl?=
 =?utf-8?B?L0dtL2crTi9YdCtrMzNrRlRRR2QwNnlKNGRESWR2My9DV20vUkVlRXpXa3RI?=
 =?utf-8?B?MW52ajg4M0ZiQm5ERlZpYnNud3A2SkJNQ1ArZENRcTNZYnRyaldzWFlQb05M?=
 =?utf-8?B?aStKUlRjWEl2SHdXdG9HalFsbmhDVEppNFJKcWxNWmkycUdod29QaVVXR0Mv?=
 =?utf-8?B?QmhoUnByVjk5Y1IwWmVBczUvWnFBVmRqTVBVdWlQZUYxYTVtbE1WQVQvS3Bw?=
 =?utf-8?B?d3hSUDh2cXdDM3kraVlwQk4rQW0vTkxlN2V4YjMzbGVvaWdEZFRlcnhUWml5?=
 =?utf-8?B?VWlzeUd0UnlQcHR1enU2MklmZjVzZFNwS214c0FoNzZMak05bHI1c1FIazZI?=
 =?utf-8?B?anhSQlBReEErOU55bEdmUDVYcnJ3VjhpaDZWeWFvc25FNkYrUEYwd1oxeW13?=
 =?utf-8?B?RjIvWUlUQm4xTXVjZUo1YnUweGRndmcvdjRITTJCWUVQazdVS3FyY2lyUmRI?=
 =?utf-8?B?MFRmZ0ZiRmlCMWVvMWR4Qjdwd0xaTlpFN0Q2WHVNLzVHbTZmV2NxSW9kM0tT?=
 =?utf-8?B?QXcxRXB4NmVQZUJ2a3UwVTM3UDZZV1FzM01IbVZzMWJOWmZ2c2ROem55cDdQ?=
 =?utf-8?B?VU1SQnFyeE4rSkRyelZxQVdvS3NWQ0JKSVVvbWtpNk9MVlo5SUN6UUppQ3dW?=
 =?utf-8?B?TSs1N0xlL29sSm9TdFlmYnFVODNweWpGRTdrWlNUY1lWN0Q0NWlDWnBmVXJI?=
 =?utf-8?B?cHluYThKVjhDMzNjbklYM28zKzZQempZVmJTcmhZRjBYWEhHVmE0bG5JbG5Y?=
 =?utf-8?B?M1c2WlM4K1hFZ0FFVml3QTl3UzRSem9Ld1NmOE9TOW5jTnZaYkdHZG50dm1a?=
 =?utf-8?B?U21IWmwxZWNoeUVEd1Y4anVYV09xbXpML1NhRnUwTS9YQ2s0TDJDQ1E2WEFW?=
 =?utf-8?B?eWtwTVRrZ3NjUStiZk45WGI5YzBNTFNWQzJmSmQrUTdPMlljN2F1VmRpcTVT?=
 =?utf-8?B?bHlVWVV6Si82b0VGOVBLNjFPcU5pb3RSR2c0b1ZoQStoZ0dzNm5TTDhWTlEv?=
 =?utf-8?B?VjhxL3VoZ2FWcnpTYVkvR3BpenQ4VGVFRlRENGdnSm1pdFgxUGx5YjcxM2o2?=
 =?utf-8?B?MEo1UTdsODM0YnVhN2U5QnBqVk5iWnVMcWloNzQ1em9ySmJ6ZUl3YW8xZkZE?=
 =?utf-8?B?K21zUVh4Q0VETlFPdEUyY2hUVUFxQzdCZHhPY3lmaVBUUTdjeXVKUmx6RHlR?=
 =?utf-8?B?Q3VyN0xHQjBMMzQyaGRpQlVpYnVSbDh6aWgrWWhEb0VMWmRHaTRSbjhNY1RQ?=
 =?utf-8?B?dGdEM3J2T1lIYmFoRW9Ma1hnSlFnV041WUNObmE2eXB2YU1HNFZDbGcxa3dJ?=
 =?utf-8?B?YmJiOTVwT0VlVDQ2eGVHMXh3ZVBHYnRWWjVySTJHT2RyaUpGTTQ2WEkxOVlK?=
 =?utf-8?B?aGhSZnV2Vkw0WWFSRmpFRkxhL3R5Vk9KU1ErQVM1YzZqWDdiWlk5V0tZUnR5?=
 =?utf-8?B?Y1FGbmJGZ0ZsQ3hJWGQySkhNSDFrbE80WXhTSUVFU3ZZdWdSN1NzbExDOFdp?=
 =?utf-8?B?dThBVEkrNUhIbHd6TnlRWjNjMkJXQkxHYWpUbnpROW9UL3h0bTY4M2puc2Uy?=
 =?utf-8?B?c29WeHhhTW5VRklKY3ZqSEoyN1dvUnhyOG1GZ0NnZUdGU3JnUEU2bHVXajkx?=
 =?utf-8?B?d0QyQzlEUUdLTTVGY3d4MTJxWnZ4T1FNYnNkN3FLNEoxQVZzTGFuVnJVbkZE?=
 =?utf-8?Q?ZAagNdxaMzIomiyEiFLHTUmP+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46630e71-35b0-402e-e40b-08dafaf8bef0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 15:12:29.0669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YwirKHKJzvyC8uITAUHCbdDX+0In+Mf+U6hL+YoXAeJAEUO1i7bYsD5v0IdPPb6M2Du18istrKBv2lyPg0m7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4896
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/2023 11:44 AM, Jason Gunthorpe wrote:
> On Thu, Jan 19, 2023 at 02:54:43AM -0600, Kalra, Ashish wrote:
>> Hello Jason,
>>
>> On 1/13/2023 9:33 AM, Jason Gunthorpe wrote:
>>> On Tue, Jan 10, 2023 at 08:31:34AM -0600, Suravee Suthikulpanit wrote:
>>>> Currently, to detect if a domain is enabled with VFIO support, the driver
>>>> checks if the domain has devices attached and check if the domain type is
>>>> IOMMU_DOMAIN_UNMANAGED.
>>>
>>> NAK
>>>
>>> If you need weird HW specific stuff like this then please implement it
>>> properly in iommufd, not try and randomly guess what things need from
>>> the domain type.
>>>
>>> All this confidential computing stuff needs a comprehensive solution,
>>> not some piecemeal mess. How can you even use a CC guest with VFIO in
>>> the upstream kernel? Hmm?
>>>
>>
>> Currently all guest devices are untrusted - whether they are emulated,
>> virtio or passthrough. In the current use case of VFIO device-passthrough to
>> an SNP guest, the pass-through device will perform DMA to un-encrypted or
>> shared guest memory, in the same way as virtio or emulated devices.
>>
>> This fix is prompted by an issue reported by Nvidia, they are trying to do
>> PCIe device passthrough to SNP guest. The memory allocated for DMA is
>> through dma_alloc_coherent() in the SNP guest and during DMA I/O an
>> RMP_PAGE_FAULT is observed on the host.
>>
>> These dma_alloc_coherent() calls map into page state change hypercalls into
>> the host to change guest page state from encrypted to shared in the RMP
>> table.
>>
>> Following is a link to issue discussed above:
>> https://github.com/AMDESE/AMDSEV/issues/109
> 
> Wow you should really write all of this in the commmit message
> 
>> Now, to set individual 4K entries to different shared/private
>> mappings in NPT or host page tables for large page entries, the RMP
>> and NPT/host page table large page entries are split to 4K pte’s.
> 
> Why are mappings to private pages even in the iommu in the first
> place - and how did they even get there?
>

You seem to be confusing between host/NPT page tables and IOMMU page 
tables.

There are no private page mappings in the IOMMU page tables, as i 
mentioned above currently all DMA to SNP guest is to/from shared memory.

> I thought the design for the private memory was walling it off in a
> memfd and making it un-gup'able?
> 
> This seems to be your actual problem, somehow the iommu is being
> loaded with private memory PFNs instead of only being loaded with
> shared PFNs when shared mappings are created?
> 

The IOMMU page tables are loaded with shared PFNs and not private memory 
PFNs.

> If the IOMMU mappings actually only extend to the legitimate shared
> pages then you don't have a problem with large IOPTEs spanning a
> mixture of page types.
> 
>> The fix is to force 4K page size for IOMMU page tables for SNP guests.
> 
> But even if you want to persue this as the fix, it should not be done
> in this way.
> 
>> This patch-set adds support to detect if a domain belongs to an SNP-enabled
>> guest. This way it can set default page size of a domain to 4K only for
>> SNP-enabled guest and allow non-SNP guest to use larger page size.
> 
> As I said, the KVM has nothing to do with the iommu and I want to
> laregly keep it that way.
> 
> If the VMM needs to request a 4k page size only iommu_domain because
> it is somehow mapping mixtures of private and public pages, 

Again, there is no mixture of private and public pages, the IOMMU only 
has shared page mappings.

Thanks,
Ashish

>then the
> VMM knows it is doing this crazy thing and it needs to ask iommufd
> directly for customized iommu_domain from the driver.
> 
> No KVM interconnection.
> 
> In fact, we already have a way to do this in iommufd generically, have
> the VMM set IOMMU_OPTION_HUGE_PAGES = 0.
> 
> Jason
> 
