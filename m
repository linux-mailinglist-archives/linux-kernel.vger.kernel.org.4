Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C5D675AA9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjATRBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjATRBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:01:32 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC6314492
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:01:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i28t9Ovr0IHjDFcAjbZxKeiGLywjIQtLdwx6q8xj7ZjqF2Sj2CddPL7mX+hY2rTWiHXy1a3mQgEdyixdQxkAfb+aBnpV9eafB4Bi/p1+F/3A01J2PrZMkhxc/YNAbDsHZ8gqsn6atyBVbnkOSbXUr14CENcI3+ZyIXVfoH6pXjMGF/5NkScaJmxPuaNf4D1lKTEIe0ocGNduVIbWoW4esLn3CPimdt9PZPAFZDMEfp+cywS9KSZl+J/LRWrXpAGrqmaz2TilJKgEn9YH1OkaLdJUwD6PlnDf830ht2d22O96TloRjI9UiojmF9NCOXmjbMfaDdadnWksiU9pVlC+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUrPpdDAwitKDNEoOJgdgd5TOrcqUgcRPjBnX6P/XcY=;
 b=MEW/+n5WecsWJ1Ihf0EfvZeI2qttY7dOzhBJ+sz3JUnx7lEW9x//KclbEs7JkmuWLi09zFJKl6kFrbpr3Gux7WAZapQzlEozOJZKa3xuxVApmm0fJnuTf13zmlYOfdhnbokujvP+3ATBAV/CVpEwCVe/FrwYQE13C/ueDeHNVh+9pJrntBwxiznuToO2F8EElW7kBywunSvCjCSGF/wBa1olWpi91lJEEhBropeB0k4i6EMNOzAQ9mH/VOl8VI20NuKucXstjYaLzQ/BkigN23p/KwwmUw74t5vQEXn/3MdgPff2RUo1s0ZIU3ylE2qmI+SqBjeh6MLi4ZqQqnjwAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUrPpdDAwitKDNEoOJgdgd5TOrcqUgcRPjBnX6P/XcY=;
 b=asC8Fjg9tIuJ7JnJeWPP7oSauBbwHbzREHLbL8Hs6V1cP1+1166FaB+msqzli3EJnnQWJfuB7IONupbU5KlQfTtHlEJ/DVp+W646WBW4QPqk5NywrI6VRL5eog2N6AHdgju5SSLPaV8mofQPi/SdPaoysqaZvRyEj891POjlc70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by PH7PR12MB6717.namprd12.prod.outlook.com (2603:10b6:510:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 17:01:24 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::5317:fa3f:5cbe:45e9]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::5317:fa3f:5cbe:45e9%3]) with mapi id 15.20.5986.023; Fri, 20 Jan 2023
 17:01:24 +0000
Message-ID: <1ba09b11-8a07-24dd-a99f-eeacb2f5c96c@amd.com>
Date:   Fri, 20 Jan 2023 11:01:21 -0600
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
 <Y8mBczFH/Hw6xot0@ziepe.ca> <c3fbec52-1281-eb1c-40f8-588438146c14@amd.com>
 <Y8q9ocj2IZB2r6Np@ziepe.ca>
From:   "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <Y8q9ocj2IZB2r6Np@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR06CA0021.namprd06.prod.outlook.com
 (2603:10b6:208:23d::26) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|PH7PR12MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: 050045f8-5281-46b6-d0c7-08dafb07f616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oLAW3s2YPC9vZzcoEhV+VRrmOIyaZYmTfQSymOV/x+w/UcdYNAwGmQVoLG0rXpUD5XAPHt3NWv4/unJJNMmOZz6SzN6hICm1nZh8w3FdSRqLIhqBbKjHGbc177v1L2Vaf4qnsaPqjY4vD1KQftug9ynHim/cqqcN2x7fke/kpH3Ouxa93bEgduaKIcX5LQWk+wVID1Xa/3awHp2PlR9jKgwA96li4RuO7mfXPsGSOg6jrhMdgFpbp6KykzVbcqd0PvloZgBlQkd8TNeZmEOzOmnnnOODRe9fM13tqNxkTarIsudeiumTJfUR0oA4WVNpZYY80aXyQ5OuFVHL/lvqEuvLT4g30bJDnM0yBEO2IcVmJQ7MDFNMYJ+CYPB4g+6g06/D7PkCbaI4BTvji69SNyX66vUMrJriEdHhvFyeFLy49K0PJzkEQbPf976eRlQuufJ7+n2DKHWj3z2fUEGlo3RIRST1+/2nRHKlr5oxCYnbo7l/Xz7qGuJn1dpdX//nQLJT1QmYbCCJTiqZ4SfI/dBL/bvXJXzl5J0yhJ4LVi7i+TxHh6ly6Ffyl6bQU2dRvItXkxml2mq2iG5e0wCh88BibV8nmj9vpUaLm6N0bGLhPafB9XdeINhCRysd9EPYJwhiFohvGUtIzhOyJ86KKQaSawAJoWEnwFgdkDAEJljgpGj4YywKIbHtQnprXlOunRJ/7aUne7mtxzETpXnNeLNXKWMEyeGu6SLf9xkcyWzIVUp2NH69ORoSFx2CdQKUyOUlbzOMbnNHFojZqMgKLMiVSqFU+h+xVOJ6/SlyEKQ089jhFZvGifpl0bCxCspE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199015)(31696002)(6512007)(966005)(478600001)(6486002)(26005)(186003)(6666004)(6506007)(41300700001)(53546011)(2906002)(8936002)(5660300002)(4326008)(8676002)(2616005)(316002)(66476007)(66946007)(66556008)(6916009)(38100700002)(86362001)(36756003)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emc2QU9ia2ZkUkJzM2xjSmJ5Q2FXdWV4YmZuS0pXWnYxRDZoV2J3L0w4dktK?=
 =?utf-8?B?dHpVYkNnbG1aRGFNV2twS0lLUloxWnE0OHovdkZvUWR0azFvckY2SFpNaTlJ?=
 =?utf-8?B?SWxHc01uY0lFTGxhYklRS0xsSVpBemxPbFFhUmN4QmJEc0hmRkZka3VIZm9v?=
 =?utf-8?B?T09OdVVkYnhXYWE1NVNwK3JBMHlSQytaOXgxblI2cnlCTENHdUZKVUlUVnB4?=
 =?utf-8?B?OGdGK2JHa2dnY2V5MU5pU0xYdXprS0VuWkxwVXFzcFo4RXl0b1l2OEN0TGRX?=
 =?utf-8?B?N2d2bDZiR0VHZjQ5ck1vdWpkWThrbC93NTg4MTdsVWRBc1VSRThUV2k4dExR?=
 =?utf-8?B?K1h2S2tlQVdneXVYZHNNcktzcHFHdERiZnB0b3FkWFg5U09UNlpPTUU3VDlF?=
 =?utf-8?B?YVJrQmM2MGtlLzEwdTNGYXBXYnJ0MWZBcVUyY0pTbXhsWVY4RkpoanU5Y3RE?=
 =?utf-8?B?L1ZCUys0bTFPcnI1T0NUTFU0bmdld2hDcnBJRWxXWm1ydUVHUnZ0SzkvM2VE?=
 =?utf-8?B?OC9ZWkNzM3JZQzJGVURZaUZBT1owVVMyNDBqRi9SdnZPbFZEQkNFNS9VckUz?=
 =?utf-8?B?T1VzQUk4eTEzQXp6VXZId05nZjd2cGhkWVovOVZvQjFGYVhsWStEYXNERGpS?=
 =?utf-8?B?VkhQY2RtN0VnYTFtRWYxVG9HMlpKWXdsczdBN01sOVFHeTRVV1VSYmh3cjd0?=
 =?utf-8?B?ODN3emxReFZlWVJ2U2E5SERQREVZQWtJK0pFNnkvZmNuSE1mUTNIcHEybHlk?=
 =?utf-8?B?UFlUNDYwT0dtcm1odmRvMWIwbXgzODcreEhtT2JOMkxoM094ZTlLZ0JIUDJ1?=
 =?utf-8?B?NmF2d3lXZUVIcUhMMHFlN0NFdzVUbCtVQXY1R1cvUUh3SWtURjliQkdCeUwx?=
 =?utf-8?B?RnNZM3ppMEhSTHVpdDlPTy9zYzlDbjFIaU1CSFhtamdVZ0JwT3grK00rWUpP?=
 =?utf-8?B?eHRyZGdYT3pmUkkvU1F0QkhyNjNvZmJUOE51MjlZdmZ3ME12Q0hTOWg3cm9B?=
 =?utf-8?B?Y1RXVWlBYmxyK1VIcHVtZy9TaGNsVTRQZlZGZDhRWllGYys3cWhuOVBPQkhJ?=
 =?utf-8?B?b0JpUkd3UGJiVytmdU16VlVmekVubUowdXQ5YUhaQk92QkFRMDhEWDl6Rmlu?=
 =?utf-8?B?dEdFNFdIUXBaUWdGQ2RvUzBYQ0FYRWJiZzNLMG1qNWVWenN1T01CSS9rNTB3?=
 =?utf-8?B?QmtUQUROOGkyUUpsUHdiaHdxam9sZFJQVlBVVEFiUDZjT1R0TU83R2FTS2gr?=
 =?utf-8?B?YXl6ZUUzRFE4dy80OVFGUkJ6R1F4K0VSZSs2L2I0dnlVam9lZFgwYWh0YjBM?=
 =?utf-8?B?eHdLKzFwT0w1NFErSVhTVXNGNmZpandGeGhteTNIWXdRQWhScDRYdDBBRXN2?=
 =?utf-8?B?ZG42R3NaWGxHRkwreEZFZ21QYW5RR0lRYi9VOCtEWEwzSDVac3ZEVURKOG1B?=
 =?utf-8?B?dnpoRGJmZU50U3pUNlBkV3BTSnRqK0FKOVdQUXcrdnBDM3AvMGRqUUcxRVRm?=
 =?utf-8?B?cnhLNkRmN09QY3RhOHRIV29MQk1FbnMyanMzM0NYekY3dXI3VmtJeW1sUTI1?=
 =?utf-8?B?ODdkWHUvMStoMVk3OTlKYk1iVERycHA2b0RMKzVXVXpqVFFJRTNHbXJMQ3FS?=
 =?utf-8?B?SEpJa2E5ZHNSK3R3bjZtd3JRZVZJUzJHdXVhWG5jRmQwdWFybXlkRm5lanNC?=
 =?utf-8?B?endiUmd1cENJcVUyTzV4UW4xZXp0LzJLMXF6UjFvN3dmM1B6SlFQYmwxYThX?=
 =?utf-8?B?ZHVQK1JEaXFZR2ZwNE94M2ZxQ001Tkx2M0lyaTlEN21RbjN2bDJ6NXVsdUpk?=
 =?utf-8?B?djFpOG9icUJTRUE5c1NWcnBjTnRobGd0eXZiQzdDTnNlVmZpMXVTVXc4dmtj?=
 =?utf-8?B?djVqN2ErZVpvdlBlb29wQVlEVnVJa1JHREd5YTA0TXdnUzdnUllIR2d5UFp4?=
 =?utf-8?B?OWdmQzluN2ZKRy9kM3RHSjMrb0hWeExnSG1EYzVIajlkT0pyQldadEJOQWVH?=
 =?utf-8?B?UU52Y2xmQ1hNcGZhb3l5U2QzNTNTa21xNHQySkNUN04wSUU3dldtaEMwMXNs?=
 =?utf-8?B?L05wVW9Qc3JtclhLUktZSndsU1o0cVNkWWxCU0RCSVFjOS9mVEdvOFpkd2tH?=
 =?utf-8?Q?Im497MMQN4DmlhjtBrGheVWLT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 050045f8-5281-46b6-d0c7-08dafb07f616
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 17:01:24.1660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UFya3078V6imx5QetMsb+112vaH07xio5UA/9+/EV/vSHjLpp7d84o2BNCsgfi6sIx8oQMxinz8doKCvBnyrfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6717
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

On 1/20/2023 10:13 AM, Jason Gunthorpe wrote:
> On Fri, Jan 20, 2023 at 09:12:26AM -0600, Kalra, Ashish wrote:
>> On 1/19/2023 11:44 AM, Jason Gunthorpe wrote:
>>> On Thu, Jan 19, 2023 at 02:54:43AM -0600, Kalra, Ashish wrote:
>>>> Hello Jason,
>>>>
>>>> On 1/13/2023 9:33 AM, Jason Gunthorpe wrote:
>>>>> On Tue, Jan 10, 2023 at 08:31:34AM -0600, Suravee Suthikulpanit wrote:
>>>>>> Currently, to detect if a domain is enabled with VFIO support, the driver
>>>>>> checks if the domain has devices attached and check if the domain type is
>>>>>> IOMMU_DOMAIN_UNMANAGED.
>>>>>
>>>>> NAK
>>>>>
>>>>> If you need weird HW specific stuff like this then please implement it
>>>>> properly in iommufd, not try and randomly guess what things need from
>>>>> the domain type.
>>>>>
>>>>> All this confidential computing stuff needs a comprehensive solution,
>>>>> not some piecemeal mess. How can you even use a CC guest with VFIO in
>>>>> the upstream kernel? Hmm?
>>>>>
>>>>
>>>> Currently all guest devices are untrusted - whether they are emulated,
>>>> virtio or passthrough. In the current use case of VFIO device-passthrough to
>>>> an SNP guest, the pass-through device will perform DMA to un-encrypted or
>>>> shared guest memory, in the same way as virtio or emulated devices.
>>>>
>>>> This fix is prompted by an issue reported by Nvidia, they are trying to do
>>>> PCIe device passthrough to SNP guest. The memory allocated for DMA is
>>>> through dma_alloc_coherent() in the SNP guest and during DMA I/O an
>>>> RMP_PAGE_FAULT is observed on the host.
>>>>
>>>> These dma_alloc_coherent() calls map into page state change hypercalls into
>>>> the host to change guest page state from encrypted to shared in the RMP
>>>> table.
>>>>
>>>> Following is a link to issue discussed above:
>>>> https://github.com/AMDESE/AMDSEV/issues/109
>>>
>>> Wow you should really write all of this in the commmit message
>>>
>>>> Now, to set individual 4K entries to different shared/private
>>>> mappings in NPT or host page tables for large page entries, the RMP
>>>> and NPT/host page table large page entries are split to 4K pte’s.
>>>
>>> Why are mappings to private pages even in the iommu in the first
>>> place - and how did they even get there?
>>>
>>
>> You seem to be confusing between host/NPT page tables and IOMMU page tables.
> 
> No, I haven't. I'm repeating what was said:
> 
>   during DMA I/O an RMP_PAGE_FAULT is observed on the host.
> 
> So, I'm interested to hear how you can get a RMP_PAGE_FAULT from the
> IOMMU if the IOMMU is only programmed with shared pages that, by (my)
> definition, are accessible to the CPU and should not generate a
> RMP_PAGE_FAULT?

Yes, sorry i got confused with your use of the word private as you 
mention below.

We basically get the RMP #PF from the IOMMU because there is a page size 
mismatch between the RMP table and the IOMMU page table. The RMP table's 
large page entry has been smashed to 4K PTEs to handle page state change 
to shared on 4K mappings, so this change has to be synced up with the 
IOMMU page table, otherwise there is now a page size mismatch between 
RMP table and IOMMU page table which causes the RMP #PF.

Thanks,
Ashish

> 
> I think you are confusing my use of the word private with some AMD
> architecture deatils. When I say private I mean that the host CPU will
> generate a violation if it tries to access the memory.
> 
> I think the conclusion is logical - if the IOMMU is experiencing a
> protection violation it is because the IOMMU was programed with PFNs
> it is not allowed to access - and so why was that even done in the
> first place?
> 
> I suppose what is going on is you program the IOPTEs with PFNs of
> unknown state and when the PFN changes access protections the IOMMU
> can simply use it without needing to synchronize with the access
> protection change. And your problem is that the granularity of access
> protection change does not match the IOPTE granularity in the IOMMU.
> 
> But this seems very wasteful as the IOMMU will be using IOPTEs and
> also will pin the memory when the systems *knows* this memory cannot
> be accessed through the IOMMU. It seems much better to dynamically
> establish IOMMU mappings only when you learn that the memory is
> actually accesisble to the IOMMU.
> 
> Also, I thought the leading plan for CC was to use the memfd approach here:
> 
> https://lore.kernel.org/kvm/20220915142913.2213336-1-chao.p.peng@linux.intel.com/
> 
> Which prevents mmaping the memory to userspace - so how did it get
> into the IOMMU in the first place?
> 
> Jason
> 
