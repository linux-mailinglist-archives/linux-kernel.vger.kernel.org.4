Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB0467340A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 09:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjASIzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 03:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjASIyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 03:54:52 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2057.outbound.protection.outlook.com [40.107.100.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9C84FCC7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 00:54:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yy2zs7XC5cdYeem8x3TXw95H2Ubbiv9c3vOlHPuGvc6C4ItrYs6QniEXQLAlxjheeVrEDHZVdoLIBqTCPwjKRqrLVlHlWojJCyf0VBwao028OlZZ0mFl5Ho8dGXffJwpwQaZ4kVw5sMgcA58WwgcfVBT0CIS4Pv505Qbmg5C4r0FSgXA15xp98YqFy7sd01opLWDqKBLzlgFgDkhy9kXma+Hkbsv2h1Y/MIdGgcAzuXdWiTLtYzwqOgF7JZakI2Z1JdWTmi/4JfKyxzhpw3xL6GNLN2cQpfsFh97EvqSefgjz6zAES0J35J9QAikkvCX/UW9rDF0IYLDWXCXhaaQoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDoUC31Z5DzXwyZbXGyrKXVztTyVb024h8fXVKSXKok=;
 b=bLtohlPs786t5bjGMKYQquQ1G7wvkza2znPWVjnAQEeM+cStiNK/rEbtaRxUosAUxAWH1q8HWKVwwn30I8W5AzTYw69LgOxdK63ioXLtHT+xL6d106NHJ7k6zlilhCxD+p4ga9HRoXSr3peU52LJMzzyDCn6t45uynMikrgYos45u6ssyxK/1IpNFarAcNigRg9vAZ+G6CuBIPF/xa1TxEud26sRADI9lU6ZyXwNF4juMccyebkvskDjw+KT0Noy0gEpbi71OwTY+IMMvzgxdwoltcUlpVoMoJwIkep90TUZWQnMgt13ntctxWfPp5a6yWl5Q3Udmltc86+/BgPpHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDoUC31Z5DzXwyZbXGyrKXVztTyVb024h8fXVKSXKok=;
 b=pMjF8N2/zvALuCdL50+I45xdPPid3h4O/fqVRuHufz7L3xvZv5E1poczq1gQRpkEMreS6zSW6AQYEza/0d5iPGcuRWIlsCsu0fHC3k+j+m/h2W7mSL6NIS7wLUWpU+AmSKHZxPuyq05k9Q1h+9z3HmtIoyv+B8JPAKTPn3r9iuY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SA1PR12MB6993.namprd12.prod.outlook.com (2603:10b6:806:24c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Thu, 19 Jan
 2023 08:54:48 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::5317:fa3f:5cbe:45e9]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::5317:fa3f:5cbe:45e9%3]) with mapi id 15.20.5986.023; Thu, 19 Jan 2023
 08:54:47 +0000
Message-ID: <90762dee-1559-58ac-220d-a13635d5032e@amd.com>
Date:   Thu, 19 Jan 2023 02:54:43 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 1/4] iommu/amd: Introduce Protection-domain flag VFIO
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        joro@8bytes.org, robin.murphy@arm.com, thomas.lendacky@amd.com,
        vasant.hegde@amd.com, jon.grimm@amd.com
References: <20230110143137.54517-1-suravee.suthikulpanit@amd.com>
 <20230110143137.54517-2-suravee.suthikulpanit@amd.com>
 <Y8F53dzdebKLTlOy@ziepe.ca>
From:   "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <Y8F53dzdebKLTlOy@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P221CA0040.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::20) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|SA1PR12MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: b66e1975-ce25-4a09-b893-08daf9fad108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BZdWOxJTkas68reGtXhzLvKudnuN2vOEONbE0zlqPusGXirS0lJdZF0WZA3adPuAjok7UyAPsNunJX9yICN52lY0V4eChZ7NwuZwtiF8YB4i1SdnENY/GlL1+D7kCHDW++qvfqI0mAo33onjiTyiQcMzo0clgJp4YREjtmbxCvg7LGfWepcTv0MJVQ+Yryyex4J/jxoWdBdi9UbeMRB8bjk/k3xbcLOl7U4y21E7B+sv1YU60atbAJivYzTVXQa5WOQs6QF3HHjOkK8kzts3OmBY4JU0cieT1S7Ug+cL+JPomZbmh0yWLYMFJGX3ozD9yjs6pT2xQqxKymNrFrmAC/t6ZBt6OB4YvlToGACe6Dha5XbUhE5SBjq/OM3g573/KMe7Cntq1Cg5AGeCGpSpty7qf8SASkn59TT0Pg9/+bSDQxvqefT1zIX9sf9+PIo7yuPu0Kdyyznpc4hurAwN5oJdCt/jSH2IDvFLebFtaZpxR7aarRXLZDLTRkhzbisCjXlCZWoi3LfZeD5HUSwPhd7fd9JbhiuGNQ1dJs6BBuVkeJ2/Hjw9ARYIbl/lhzd8GXvLRKbvesbaE4Tma5BW+Z4PeXfWZ2GtnZXVuzzu3jvGX04R7r62sUsQH4ZmQAnODYQLTLOYJdHtXCo61od+xbm/TZVJuhRnjKjRVB32NqiyjhTr3F9JT2UyvXC31dYiq7BeE6m+RWQpHHyMjJ1O8WrQMANR3UJKCO9tkfWaZrC25w8pfsBtpEBHqvZljiM5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199015)(478600001)(6512007)(316002)(966005)(86362001)(186003)(26005)(6486002)(31696002)(66476007)(66946007)(8676002)(4326008)(36756003)(41300700001)(31686004)(66556008)(2906002)(53546011)(5660300002)(83380400001)(38100700002)(6506007)(2616005)(6666004)(8936002)(110136005)(6636002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFl4KyszZ094NXdIcTI1MmQ0NndUN3FndHA4UEFSUXJaY1lyQUtWM0krSll4?=
 =?utf-8?B?dzV2VU9xWm5tVXNoWHRJa2swNTZsN2xoakp4VWZiMlpucUZXZE1yUXlCYjBx?=
 =?utf-8?B?aW1pTUV6a3ExVzcvWnpYN0hwanFNZkJUZ0NjK1ZaZHhzbTM2RmVNd3ZZY1cr?=
 =?utf-8?B?S2tCQmpvOEZ1VUhYazdVNlFPQjdlK3NXWDkrQ1dDVlJMSXBncktIV1NFZ0pi?=
 =?utf-8?B?UzUxQXBueWNZMVlLSW9heDVvSWxrbXBjeDRFYXF4VndjbzkrcFMyMWVnT2FM?=
 =?utf-8?B?ZS9MaTdQdzRrbWFCUElTYnFmQlJRMFlXelF2cU5pMC9ZUHRWYlh1dzI5eDVr?=
 =?utf-8?B?SUlYV1RYOTRtU3RWZVJNL2NxUm9pdnRWVS9PYXptcUovUWZHeEU1cTlzY2ZW?=
 =?utf-8?B?alpXZzNrb1QyUnJVN2hFamRBY3VMRXR3VVAyRVBKVFRmTnd2RGprZGFCSnVP?=
 =?utf-8?B?SVBtLzZxTXc5VmtBTVUxRllybkt6RHdkR25GdUhEMk1ZYVdCcklUTzhZa3d5?=
 =?utf-8?B?YXpRNnFJbUk3MUxFY1phSGtYVWpnRS90ZDBRWW9meFptOVBXcG40anhOdW1l?=
 =?utf-8?B?bC9ydWRBeVZwSDVCL0FZeXhuT0ZVbmVqOVNkczB2bXQ4SHRQVVJLRXI0VnZC?=
 =?utf-8?B?QXh0aWZtTENOc0M0MGVBTERZZVpLaEFvb2EvSi82YngwL3ZBZFNXYmtmeGlX?=
 =?utf-8?B?UGNtQThHWS94L0FTbk5jRC94amgySG53VmwvQWJKaXVIY3hiaTVBZ0p1blBj?=
 =?utf-8?B?M0NaMEUvQmJhZm83enhLUjE3alg1ekQyNTRSUTNTaW1iSkFCd3NGaFJucUR6?=
 =?utf-8?B?NUFyU1NvODkrS0VaelBXUGJ4Q1RHS1dKeDNMbzR4MSs2dVY4bGFBL1RsS0xn?=
 =?utf-8?B?VDlwTUpWcVdza0xEWGVXU0VESFpObHZZRW9tY2RKNWliTDViQ21KdFFjQVVh?=
 =?utf-8?B?RC84MDRwakp6d1dSejF4Mllic08vZ2hVcll6QTFKSXZUcGFZUlkrZmYvdCtL?=
 =?utf-8?B?dzA3QzlVakZTcGVmdGdqWW9GeXc4MGlWQUp0ZFJ2R3JWbk1zR3RSZXN2MjBR?=
 =?utf-8?B?TzB1Q0JDcW5vdFVVRk5kNFBPV1BqUHo2aEJjbW1UWHhQcUM3OU42eXAwaHRp?=
 =?utf-8?B?TzVXcGVHa2NTcTRxVjJpUFRpdmx3R2l6RHUxRDhwc3VzNldKZE44eDUzM3ox?=
 =?utf-8?B?UW9jM2hUNDZ4c1VxbXRBU21YU01EWXhwOEptVERSVFRVRDIzT0p0WXY5dVRt?=
 =?utf-8?B?N2xheGo2Q0FNQUJYRE9xcW05clNjSitwZDkrZkhHZXVpcWJibjExWnlnZXRv?=
 =?utf-8?B?WGVNWWdFNk9XSkNMaXpERzRyQXZrYUtDeUFhV3BteThkdzAra1Q1Wk1CUTlw?=
 =?utf-8?B?b0tuOWJTVkt0QUxGV2srY29JSzlDWEtzb3ZqRVlrK254TU5CaWxNS3FJRWh3?=
 =?utf-8?B?UTN3anF3YllqTmFEZWg0dVRibUR1Rk1VUXBEY1hPMnRBUzNiZTQwZ1B4eWhV?=
 =?utf-8?B?WWpGMWlQWkdJaWVBY2hlYWc5cjB2dUx3RHFjNThtV0YrUFpiQXpRbURxS3VR?=
 =?utf-8?B?aTMxUWlQUU9kck9WTXp4QlNMTVM2Z2lQdzhXY2lBVnpjTFJmK2xML3RVR0Zt?=
 =?utf-8?B?RXFMSzJONERFSVFuSExzN3FESUtleWM0OVkzbHVlTmdZVWVKcTIyVDRTbnV1?=
 =?utf-8?B?K1ZWNXN3UXVXWmZTbTZZczBEeXQ0VEc4Qld0dE5lUmU1b0E5NGtYb1dvT2tZ?=
 =?utf-8?B?c0d1VnNXNnBnVkw3aVNLYjdVQXhNSmNhZWJDVnQrZG5KOVJpaHlmSFN5SzFk?=
 =?utf-8?B?NGl5anFvcGI3bHlBTnVFZWxrM3IxRm9kZUdsT0xlaURWV3VoLzhrQUJRWkQ3?=
 =?utf-8?B?cVZMbkIwY1MvQ2xBL25GMzJ3VmVwcjMzYnpxdEZJOFE5N08zVG5BV3d2RkdM?=
 =?utf-8?B?Wk00U1I4NjMzU2dKKzF6WXRvWFZUVGEwR1FkeTFCMmlMMjFkTE85b0s5Z2Nx?=
 =?utf-8?B?a2R3ODZVU2V1aW9jWFJZbVVWOGR1ZHQyNStZNkphSVBld0JVc0wySzZINno4?=
 =?utf-8?B?Mm1xZUpTeWlETE5HWC9ZdW9hVzc5MERWZWRzTzFkUHJZRlQveXNEYUllWmxT?=
 =?utf-8?Q?x+lB0lE0qWCUOvrvKv9dTyhW+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b66e1975-ce25-4a09-b893-08daf9fad108
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 08:54:47.3621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5x0zZouqX3BlKReWjkeN2PIkIJ3qqH63Ofi9S4Ul7KtolUCLs6XCcFLjipHpYQnHB/UzFhl+0cbo80pFJ9rW7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6993
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jason,

On 1/13/2023 9:33 AM, Jason Gunthorpe wrote:
> On Tue, Jan 10, 2023 at 08:31:34AM -0600, Suravee Suthikulpanit wrote:
>> Currently, to detect if a domain is enabled with VFIO support, the driver
>> checks if the domain has devices attached and check if the domain type is
>> IOMMU_DOMAIN_UNMANAGED.
> 
> NAK
> 
> If you need weird HW specific stuff like this then please implement it
> properly in iommufd, not try and randomly guess what things need from
> the domain type.
> 
> All this confidential computing stuff needs a comprehensive solution,
> not some piecemeal mess. How can you even use a CC guest with VFIO in
> the upstream kernel? Hmm?
> 

Currently all guest devices are untrusted - whether they are emulated, 
virtio or passthrough. In the current use case of VFIO 
device-passthrough to an SNP guest, the pass-through device will perform 
DMA to un-encrypted or shared guest memory, in the same way as virtio or 
emulated devices.

This fix is prompted by an issue reported by Nvidia, they are trying to 
do PCIe device passthrough to SNP guest. The memory allocated for DMA is 
through dma_alloc_coherent() in the SNP guest and during DMA I/O an 
RMP_PAGE_FAULT is observed on the host.

These dma_alloc_coherent() calls map into page state change hypercalls 
into the host to change guest page state from encrypted to shared in the 
RMP table.

Following is a link to issue discussed above:
https://github.com/AMDESE/AMDSEV/issues/109

Now, to set individual 4K entries to different shared/private mappings 
in NPT or host page tables for large page entries, the RMP and NPT/host 
page table large page entries are split to 4K pte’s.

The same split is required in iommu page table entries to remain in sync 
with the corresponding RMP table entry. If the iommu entry is covering a 
range with a large page entry and the individual 4K mappings in that 
range have now changed, the RMP checks during IOMMU page table walk will 
cause a RMP page fault to be signaled.

The fix is to force 4K page size for IOMMU page tables for SNP guests.

This patch-set adds support to detect if a domain belongs to an 
SNP-enabled guest. This way it can set default page size of a domain to 
4K only for SNP-enabled guest and allow non-SNP guest to use larger page 
size.

Hopefully, this explains the usage case for this patch-set.

Thanks,
Ashish


