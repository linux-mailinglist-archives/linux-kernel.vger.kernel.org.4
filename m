Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA12064783A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 22:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiLHVug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 16:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiLHVuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 16:50:32 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA34F84241
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 13:50:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RE6UeJrS10LmQSfzcb1BVFNFSNga+5p56qJ6PTUUWN3V9g17Hv8a8Bv0L7eVBEov9IZQE7rh0opE9kbQzhzwOq2qjjdedLOkxAUtNkeP0YmnQzCEbIZtm17GrnQB/uTJL96kt0V9YEF5kjW7XI/OEtwBembR++uwSZm1z9s7ZLTeKDvCoxR+vhF4YtQZps9XGdOyzfbh9AomcAaweFGWQnh9g0F+7LIGDT4bn5dhfQOkiSYSAucUXajlgoukyrYVZTcL5Pabh67Drc33c2FkFRHbItdtKlsx2AMIpVAPQm6+cq7RBsxXIa6hStZ6TOSxtRc9MkVtLWqaz00hWDTneA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jsd69E6TSz0f9za5UqVevZ10QNPloJnIk3uphsyLLec=;
 b=DpYMMqiLlyTXFE3PvaKf/HhZq3l8+uEDW3NJCNZaw3T9KfS/VaGZbd96SBvXfKBOd355nK+PrdnPG24G8dKv3X3Dj/iHOpSycb90bMqf8EZrK9CEoMVvpHmrx2rWXFfN4PXI/NRjLjp+E7KRFviXH5aqvYNdzhRwoANg2shNkFACb0cReb1BL8UtCgzIWHcWHunoIhvSGfGeNWG2Y5s2+oeaCKTVuke3rH6aiJejfdtUNb/8ZGLBwWkyR4Qu9igR9leX6vBfb53qqnUBzUKMOs3zA/VLCjwgICf6vIJx0ELa5lqmBlJw2xuYKt40Sk0S30OuXkU/sV6e72THBupfwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jsd69E6TSz0f9za5UqVevZ10QNPloJnIk3uphsyLLec=;
 b=A33f/K6zDFtCDiYmjURn3p2Lcc3RvT1mmJ5TIP4dpONsb06sc9Abt0Kx9TjMJPxCjJ5N5v8BDu/5CogwWdVAGvYiHMGeFjqQIbzNgMki+SEmboiFUoxwUYWmZq1FKD1vCPBYG6W/zX+pSDlRQ4WbfpcDpVgX59HIGxNiZMQ8HA2w4TFrU5bva/FoNCmefTLeH5VZECl79WN8yp23bXZyKfwK8PGYLpUmjcDt7JhTpPwWDWziwZO1hKXWrqRM23rWOUDD9I1r0BDrx5xZRWpR8XAgdW85Svu4uAq8GJE4p1EG0SMpOZGR0jPHkzO6is8r8xZjREU/1UXAzlRKqCeGIg==
Received: from DM6PR06CA0080.namprd06.prod.outlook.com (2603:10b6:5:336::13)
 by PH7PR12MB6561.namprd12.prod.outlook.com (2603:10b6:510:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 21:50:30 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::7f) by DM6PR06CA0080.outlook.office365.com
 (2603:10b6:5:336::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Thu, 8 Dec 2022 21:50:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.17 via Frontend Transport; Thu, 8 Dec 2022 21:50:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 8 Dec 2022
 13:50:19 -0800
Received: from [10.110.48.28] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 8 Dec 2022
 13:50:18 -0800
Message-ID: <a3e05607-f165-04d1-29e0-f25bbaa1667e@nvidia.com>
Date:   Thu, 8 Dec 2022 13:50:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 09/10] mm/hugetlb: Introduce hugetlb_walk()
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>
References: <20221207203034.650899-1-peterx@redhat.com>
 <20221207203156.651077-1-peterx@redhat.com>
 <3b5579e8-8e51-a2e2-4c93-6709f8833723@nvidia.com> <Y5JQvElUNz6yGsrT@x1n>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Y5JQvElUNz6yGsrT@x1n>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT040:EE_|PH7PR12MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d9e549f-31fe-419a-95d3-08dad9663977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EPnurG12CfNP6q5cl3Qw6joMxaWzLCbD1U7rz/xQE/HubL8zqRnhhzXWMaoII2GCV1mLCz7hOSdCrGubeyWKWN6e6gQUKZmDxw7GlWzrJii+MLTj1UgiHcUlg/HpFRMUeClTDOpfsitrglorIDT7NK5bGwZ1AnB+agXsztJmGo5b0U0Z1GAdXTGVmusv5lyrP/43+/FMxBWJG+x1Yp3kxAs/xCo5oydm34ef511438N0yHewQGoT+unrfRKXxRQ0P6YRe7IYTGJVCFCzORQrwVzkJso5Wbio0vp1n5fQszXp8jnYPSTtpMSNoQXl+aQSCyK4zi9vPEBR9LlPR/wO5qOJFvKqrBg1wHgFgtKJnUl+tbPkND28rpBSI/rb8iAOCov/zgt5uPToE3+7C77NjHsJejhrZYnALyFK7WSSYxZMoJDDwDcdGaYMovcNnzvVgayPV56uHCGLZyqKkwjqb45mrdWJZdKpEhKwzdbzUJI14+rnMBGemYODpXJ2ukXYrGxpSWHGiVB1a6OrtrZQqtoaMIudIPCNBclNV3mhm/Oz4H69WMy6shZv7C4BZMrYIwAUtnIGF7mr6T5WqAe2+p2qQJDOjvWNlHDCv9I/K0k7vlA7GXEXxF1uPu9LWYuoQQeqdAXw/eqL7k+v9GhutkVU2uS6tbeD7o2eHZhaiaPy8ZO/2m5a6jphqxu0S+5jfWN7MS3VnVluZG2JjgxUVJcanSqfpFUxbDm7z3RTsK0=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199015)(36840700001)(46966006)(40470700004)(41300700001)(40480700001)(53546011)(40460700003)(26005)(316002)(36860700001)(16576012)(5660300002)(6916009)(54906003)(86362001)(70586007)(4326008)(8936002)(36756003)(70206006)(8676002)(2906002)(7416002)(478600001)(356005)(7636003)(82310400005)(186003)(31696002)(47076005)(82740400003)(31686004)(426003)(336012)(83380400001)(2616005)(16526019)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 21:50:29.8970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9e549f-31fe-419a-95d3-08dad9663977
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6561
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/22 13:01, Peter Xu wrote:
>> At this point, it is very clear that huge_pte_offset() should be renamed.
>> I'd suggest something like one of these:
>>
>>      __hugetlb_walk()
>>      hugetlb_walk_raw()
> 
> We can.
> 
> Not only because that's an arch api for years (didn't want to touch more
> arch code unless necessary), but also since we have hugetlb_walk() that'll
> be the future interface not huge_pte_offset().
> 
> Actually it's good when that's the only thing people can find from its name
> when they want to have a huge pgtable walk. :)
> 
> So totally makes sense to do so, but I don't strongly feel like doing it in
> this patchset if you're okay with it.
> 

Sounds good.

>>
>>> +static inline pte_t *
>>> +hugetlb_walk(struct vm_area_struct *vma, unsigned long addr, unsigned long sz)
>>> +{
>>> +#if defined(CONFIG_HUGETLB_PAGE) && \
>>> +	defined(CONFIG_ARCH_WANT_HUGE_PMD_SHARE) && defined(CONFIG_LOCKDEP)
>>> +	struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
>>> +
>>> +	/*
>>> +	 * If pmd sharing possible, locking needed to safely walk the
>>> +	 * hugetlb pgtables.  More information can be found at the comment
>>> +	 * above huge_pte_offset() in the same file.
>>> +	 *
>>> +	 * NOTE: lockdep_is_held() is only defined with CONFIG_LOCKDEP.
>>> +	 */
>>> +	if (__vma_shareable_flags_pmd(vma))
>>> +		WARN_ON_ONCE(!lockdep_is_held(&vma_lock->rw_sema) &&
>>> +			     !lockdep_is_held(
>>> +				 &vma->vm_file->f_mapping->i_mmap_rwsem));
>>> +#endif
>>> +	return huge_pte_offset(vma->vm_mm, addr, sz);
>>> +}
>>
>> Let's please not slice up C functions with ifdefs. Instead, stick to the
>> standard approach of
>>
>> #ifdef X
>> functionC()
>> {
>> 	...implementation
>> }
>> #else
>> functionC()
>> {
>> 	...simpler or shorter or stub implementation
>> }
> 
> Personally I like the slicing because it clearly tells what's the
> difference with/without the macros defined.
> 

Ha, I think you have a higher tolerance for complexity on the screen.
The fact that you can see more of that complexity at once, is what
slows down human readers.

So when someone is working through the code, if they can look at one
config at a time, that's shorter and cleaner. This is why folks (I'm
very much not the only one) have this common pattern.

However, of course I won't insist here, as there are clearly preferences
in both directions. And the code is still small in either form in this
case so really a non-issue.

thanks,
-- 
John Hubbard
NVIDIA
