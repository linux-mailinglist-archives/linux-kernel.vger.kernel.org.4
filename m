Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35AE70D190
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbjEWCp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbjEWCpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:45:53 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025AC11A
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 19:45:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBEx3xSWL7VnCUXC5lMgZi2V0g1aJdz6KeHXV0A1ThrFN4qsfgQV7kbxCNQfJiVPjD5aAYYy615k98NkhhcA4xXOweTTnAV1Xy4YGJ8FiSRQpssVjhHqWRZpkIjgZ8qrivsP/9esIXRu3DUiE2FyQ27oc9c8ditbeBNLLh6oufUFruTcMjtijs5yN4E2gswUvYui9LPZU9N9uzwsf2567YRAJD2A+8pY2VrGbtYqxZicaVbv4IGe3tzHwr+nzLH+0GNcmj2Q7e+MHcq07V9c6nRLmxbwZ3B4TuV3p7vxAL88EK0rtyziZVW3+AGDRSqM+Qbyd5d9bAhjAvP0Rjo3/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgRy+cQ64Qvi0DargZgd3Ol/r18cRTfUWC2YwNUHqYg=;
 b=jVS9gblKDydiFzxlKX90jz3S20/cAVrsCzMpArVq8rL37SetuCIbpv1fBmVgppCNKKZpezbwZZtb1PVNLrCY15hcwr4goNy3LoTe9SO7f81NS916bdUlpeLYJPFhRzgdrZSfZPeDqCokmLZncPdrUJNBSPwiMzhmPhI8rLNRFFwMH0YBIScaZznLLwM2hDXZAxlYS4GAMKPlbW0s32ZHcAIOQj57Obg5V4+9AMfEx+4ZjAcbIu7B2aMJbT7wroYKBrKJ8YGnde1NoXruXpcmIVX3Xf+Xzf2VsKhKMCF8PjJ8o+7gPHyFMjG+V8nfhZPp4/a+F1em2ZyWHUbJSyjA9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgRy+cQ64Qvi0DargZgd3Ol/r18cRTfUWC2YwNUHqYg=;
 b=ctcdxs131bRduZdaNI8RYFBTOa3CZBHHPEhq/7O9Fo6Q+2zj+p3SPm9vKjoyJreayXscjl43EZs2bxZ/H/ihoDlo2FJaIFkUk5ogVhLQAtTgj2ZGazBF9Bqj8Plkf8Uzd+VV0CUQKHGy1gR3zgEoDXziKOr9+PTo0MOOWnEK4tloZwhPt7aWQ+9Wc3yGJpHXWpOPpXujFeL0Lzvdg8g39potZiXBqgYTrOzDbLy1NqgywFxiZXkYsLeBoygcAmL5OSom1KoLmo87o5QvNxKpawvyPV5Orjx29c2PmbUSdew8fT1x4ZPBkdvdjuH/W4mYa60itn1IzkAEY4DU8tVH4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DS7PR12MB5887.namprd12.prod.outlook.com (2603:10b6:8:7a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28; Tue, 23 May 2023 02:45:48 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::f6e4:71a5:4998:e6b2]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::f6e4:71a5:4998:e6b2%5]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 02:45:47 +0000
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
 <2edc4657-b6ff-3d6e-2342-6b60bfccc5b@google.com>
 <0e3c5937-2f04-25d9-98eb-01e4c2b04150@linux.dev>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Qi Zheng <qi.zheng@linux.dev>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 13/31] mm/hmm: retry if pte_offset_map() fails
Date:   Tue, 23 May 2023 12:39:54 +1000
In-reply-to: <0e3c5937-2f04-25d9-98eb-01e4c2b04150@linux.dev>
Message-ID: <87353n9354.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0144.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::29) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|DS7PR12MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: eb58bdf7-6c81-4c73-c422-08db5b37cfb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2swIqZBbIpOaQrtVPW61/THqiajlp4YdT5Uv8BC3TZ5fQli73oIyZb+7ivcm9UOG6qUyjbxKBsFkAg8+gY6YzNeEoG9sYexwu5Zu+Ux1eI0C2utgYZDcbV+b3dTVNXEvmyiN8QsljD0m4fH3iPe72IfQRV9vpXIAQhcssZXBKh+DWgttY3mAvGt8oFKh+srKNwZFwGG2e/CBjlUeYqAPb1lqqn4HwVnamsuiD7gfAZ+HqQ8RIiN9qMLLsss1Z0UN1BMKFuoXngUofKAVNr6S2Vbp4UmchewH2w3LWGCHFKpZg1iKCS5WQvzXL5Mvgs7K8mBvypvW0owtP9+uqvRVZl2XyKNG9aDSR4OZnC5zRdCUfBPKnz2OLwyWdEATmFUB5QFDZAFW84wGaFY/w6A1f5mO3Tn5gW6cLhmPWJbncYrj4zY4VwLNuTCbYZbaOkblPNgnVRP6j6icGuKj5wg0K93ZwqPPw12GHFirZTdZrosGSwy4TXWChvfPmh03va02ma2mYEg6R/GC5zD1iunfQmw4Q/+pL38sJOmlDn/vce2oC2Ayym2TdRf6wTLiDXaN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199021)(8936002)(8676002)(7416002)(7406005)(5660300002)(6512007)(186003)(6506007)(26005)(2616005)(86362001)(53546011)(38100700002)(6666004)(41300700001)(478600001)(66476007)(6916009)(4326008)(66946007)(6486002)(36756003)(66556008)(316002)(54906003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DRGEyy9K8T1DNExGhqQGif79WXEuRu1cQ6TYY++9jkCSqDRGkEfCqxz2CZlP?=
 =?us-ascii?Q?D271Adgq+cI+l1miszk4TACiLGgH35DztX77seQO50Xb84H4PDCqUJseA4AF?=
 =?us-ascii?Q?ekgM5dF0YMzd3bIIXdKUR9bQFbBmo+C1c0GBd3A0lncGSCRslTHz3dG+ZZpO?=
 =?us-ascii?Q?6D0qUlwgSA2pBD0FN5/QY2Sr8YvouPCV8iZz/NdKkQJd0bAz4tMtxl2qFAAo?=
 =?us-ascii?Q?qjkwT1Vc7QW/DbHUx0SGEum7q71flsduZ8pdc5G538bFEnLiKnsqWMkXXual?=
 =?us-ascii?Q?sEfWxA6PMcv1S6cPaZEv6eKnStYqNBeQHVAQrFomP0AUzbUvSNxWOs8hAJt3?=
 =?us-ascii?Q?JFo8zHXx+ZpSSpeI9elIHUzifSTplheoP2YwWQxsHTsfLXJl6JDOIU6ZU5SO?=
 =?us-ascii?Q?OcqOkY2elHsNBTnZ/Hq+Fe+SNT5bnkj50jJlOffkDnbVkAhSAA4/vsmhQwqc?=
 =?us-ascii?Q?SYXdyUlBWuU9s+R+Q6uObRaJkzw0EdamFKvxlM0tkgJ4DYn2j46uRDITp3pK?=
 =?us-ascii?Q?O7A4+utt4lHI32JfGV0gWLVhqcG8/TfKzdGorw39vuVcY17jyfEGi760HKVY?=
 =?us-ascii?Q?a1ue/EHCNXOz7zw4qsrCfHgOfkEi4HOnFshjcfZkH4Pwx7f69kxksqIKqZE5?=
 =?us-ascii?Q?dwGCQLgyMcVaJqaZmylUQQH7QvfmzSNnWivP9/v4t8vCXNBmKLFGKOorB6Tp?=
 =?us-ascii?Q?S0W8zk0mgmbyj5FRAJqKIHhEas+M8i7Ov9ua6jCXltRKQkGIDEHq/Nw1z5vJ?=
 =?us-ascii?Q?UeTZFHKzMAeuSV1Ly1jUgne5+tKydtc+LWieS6tWU2Y5vVqQcfagu0PHrIqC?=
 =?us-ascii?Q?ro+5NywQPmMAtpDGNxlJXe21rHDK27F+eQ9fX2kuQ8W0BrmZTwrETyYusS5O?=
 =?us-ascii?Q?0utK4oYXGAbekLdSp0VLGry8xXZIzik1jPbFtCffiJcu1QhTb3qPhNR7M+6Z?=
 =?us-ascii?Q?MUJlDuAnEQAA7lbVwxOBBGuk9WvNkoBXx77NqSEvXEn123fuGsN6D6NJ+kgZ?=
 =?us-ascii?Q?GIlWcTT1a4UAbkVyUVPw0wPZPdtGYTQh7f4CGAalc46y6tILGCMPxLbFL4cp?=
 =?us-ascii?Q?2KzX0hkC9Irv+MZuiipUeEHD8CmN2Uy+3Y0xeLltEPi5G6PLqiya6h7tAnE1?=
 =?us-ascii?Q?qsB8IT3alJz/1oGZKsHYOoeTxmqts/7yCdOJcJlPo4UU5uzsliwOp0H3yh0z?=
 =?us-ascii?Q?P2xrFbtG1xvBO5j2Ht5obfbny2vKTtJIuOiHfAwI6aBGk+eF1v5PpfS0DFEf?=
 =?us-ascii?Q?Jttk52LKZb3+PSxhMraCX1JAsebqUwBWpgASVIk8alKUVCOzsl0g2ylkKlP1?=
 =?us-ascii?Q?6oXY5aW/YvWIGUmv44WW0fNqWFSKCDAW/x0W2BSEMFMa9ivA4wWZhKbzHtm4?=
 =?us-ascii?Q?j8a8/QSOhX1uW4Knx0CIHGeq9XI34yG4JFJ3kBYPEYgeuf/TVYoC/RDEW8Tj?=
 =?us-ascii?Q?fInIY+gxMlBGpWoc18DBaQ67N+GbAT/U7o1JhhGLfXti5Sr78Eqbu+BdR58P?=
 =?us-ascii?Q?mYgy8A+o97/r7D5lzy4ySQRHJ7hy9LhW3fcWsNd7l041PuXOxwg3Y1C7cOWS?=
 =?us-ascii?Q?zTBmEwKeSgbw4Af58i/PnDL70DYdc4Rmc7d4G81D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb58bdf7-6c81-4c73-c422-08db5b37cfb1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 02:45:47.0951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74IY+tUsBbVrRRAvvZEEi0yQ3nySoulOqd7TiVDW9GxC328yKOr1MVslAHLM8kcJMwQo9gHE2iWxeK1Ef/rZ5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5887
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Qi Zheng <qi.zheng@linux.dev> writes:

> On 2023/5/22 13:05, Hugh Dickins wrote:
>> hmm_vma_walk_pmd() is called through mm_walk, but already has a goto
>> again loop of its own, so take part in that if pte_offset_map() fails.
>> Signed-off-by: Hugh Dickins <hughd@google.com>
>> ---
>>   mm/hmm.c | 2 ++
>>   1 file changed, 2 insertions(+)
>> diff --git a/mm/hmm.c b/mm/hmm.c
>> index e23043345615..b1a9159d7c92 100644
>> --- a/mm/hmm.c
>> +++ b/mm/hmm.c
>> @@ -381,6 +381,8 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>>   	}
>>     	ptep = pte_offset_map(pmdp, addr);
>> +	if (!ptep)
>> +		goto again;
>>   	for (; addr < end; addr += PAGE_SIZE, ptep++, hmm_pfns++) {
>>   		int r;
>>   
>
> I haven't read the entire patch set yet, but taking a note here.
> The hmm_vma_handle_pte() will unmap pte and then call
> migration_entry_wait() to remap pte, so this may fail, we need to
> handle this case like below:

I don't see a problem here. Sure, hmm_vma_handle_pte() might return
-EBUSY but that will get returned up to hmm_range_fault() which will
retry the whole thing again and presumably fail when looking at the PMD.

> diff --git a/mm/hmm.c b/mm/hmm.c
> index 6a151c09de5e..eb726ff0981c 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -276,7 +276,8 @@ static int hmm_vma_handle_pte(struct mm_walk
> *walk, unsigned long addr,
>                 if (is_migration_entry(entry)) {
>                         pte_unmap(ptep);
>                         hmm_vma_walk->last = addr;
> -                       migration_entry_wait(walk->mm, pmdp, addr);
> +                       if (!migration_entry_wait(walk->mm, pmdp, addr))
> +                               return -EAGAIN;
>                         return -EBUSY;
>                 }
>
> @@ -386,6 +387,8 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>
>                 r = hmm_vma_handle_pte(walk, addr, end, pmdp, ptep,
>                 hmm_pfns);
>                 if (r) {
> +                       if (r == -EAGAIN)
> +                               goto again;
>                         /* hmm_vma_handle_pte() did pte_unmap() */
>                         return r;
>                 }
>
> Of course, the migration_entry_wait() also needs to be modified.

