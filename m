Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F45644E8F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 23:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiLFWbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 17:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiLFWbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 17:31:53 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160C14731F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 14:31:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsdnCcFUFTTRJ9CHO0yPPSrwCyDj8glQ088eTyerPb9TZV2yVSRM2xQyHG2usMhH2pGi2KoDlS1jbrkfL51MOhs/yxX/4UZgyaCvns4m/Fe+Y37kkxjGkKoFqG2i9+QpG2xc8yfdnusucitt7uvLxzZOQiNntF/8n8dYlLqOLDkXyl4XI/2fJjPQVr6SInUZ6t9FRl/etoUqS5qsXS/CRTxfVD/n07vOQzjVvGkB5HLUoQb02uCeZH8WydWEk5PBecQMBqi4aWFUEYNjcI0owNQ9CcSuoFfIDosbCXFtCNJi8v/51NTSNflqhpCVib6Ypv9NKXD3a7Y2DCgF7HVA9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efwqvTPr32bfUzD0udpRnveFzCPZTCWgoUPHNE+KFXo=;
 b=apNb3PlANM6DyfGMc3SYER89xed3Pv8qXVmFzzSFFlfCaXnJYoNeSBOl0k8Hiq8Aqryz0M46X5gYzzhDncgnc60sDAwL+Du2dFXbkJkzO+Y+t0IlMiKzxQX5dZz5JGO+Te0Lc2oN8u+9JuipqHE2TqsY/+jl/XnE56BzqhBm+2MDld9Kp1igxQqm3RJjvesprMAOfBnyXDv8u4duCaSLLTTAa1cCjL52tfjCDyWkw7RIf3HarKSY38VvOBpJYCbLuffY5ybOZYrenrnjtMSArt1m+LF2hE5g61vrIADlXXSQWz3/SJdChnkveCLDM2L3CuVXTgXBJIoVFSUZXGy0kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efwqvTPr32bfUzD0udpRnveFzCPZTCWgoUPHNE+KFXo=;
 b=npamHHb/izF4TbT/gkI2cAbWw5NNllFJ9aUbNEtxaQuSsSvay61BuU5Dgo0eFoyG0GRsK37PQ3sEXpYX3TD8wxwsqMHKWTM5Sh5uBizFX1AyZ5aePnN+N04o0ZwIxjlb+AQFFHO2NSdEFpkbTPIk/kZo0lSJlIazq7AAQobKI/bAhBgV43nwZp+j3A+jMiX3xbBKwO1HqEeUco31q4ngp6dZ6i5Lx/0Z0qDhKTk5DlQvpFXtQqL5psafuhvQgtWQwiGz2n9CzQVunmF5idNnxIt5VP4qLfpk58P6+U+/PnihIbrE5xwPbJNGxlqberf1jeCTLTgkMSdoh1AgRmL+PQ==
Received: from MW4PR03CA0348.namprd03.prod.outlook.com (2603:10b6:303:dc::23)
 by SA1PR12MB7365.namprd12.prod.outlook.com (2603:10b6:806:2ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 22:31:49 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::c8) by MW4PR03CA0348.outlook.office365.com
 (2603:10b6:303:dc::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Tue, 6 Dec 2022 22:31:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.14 via Frontend Transport; Tue, 6 Dec 2022 22:31:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 6 Dec 2022
 14:31:31 -0800
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 6 Dec 2022
 14:31:30 -0800
Message-ID: <c5d839da-cb7e-e887-11a6-30ccd1c3c845@nvidia.com>
Date:   Tue, 6 Dec 2022 14:31:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 08/10] mm/hugetlb: Make walk_hugetlb_range() safe to pmd
 unshare
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
CC:     Mike Kravetz <mike.kravetz@oracle.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        James Houghton <jthoughton@google.com>,
        "Jann Horn" <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-9-peterx@redhat.com> <Y45/5ezH6uwn7Cfy@monkey>
 <0813b9ed-3c92-088c-4fb9-45fb648c6e73@nvidia.com> <Y49xlV8I2/92Flha@x1n>
 <97e3a8f2-df75-306e-2edf-85976c168955@nvidia.com> <Y4+5R+nh0W0RUX9R@x1n>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Y4+5R+nh0W0RUX9R@x1n>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT007:EE_|SA1PR12MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: e36ce47f-8f0b-4963-a578-08dad7d9a9fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9F+hYtXPgrmZF1d8opjPjh0/xECqy1aphQ5TgskUFXpFc41qBJGqph8n3uTakm2TCJVogPgI0txYO3/qy4MTUEbdVjCVUSCmiglkjogupqw39DKUganFr31tLoWEbL3HO98xcUuJyOJWbgbdb1JeKQFKMwfq8eVvpbYeqj63tCD0l2pTIz/X2CAEW4RXlKMyMwLT/PpP4aAp//nSD8+ZpNtR9A2cMRUmb2CYM38B4IfKJPEldxdmpv9B3hzU5zuUURj+x+3skQPq2hNg3ol0OU3q0PVMrxtfgK6bRTUKfDkSOSTi7WbMPJ73UJ5oQi3+UADUI0ciLj3tFpRr3mnpFoyZTuBVLvsx2ExXlvBJkkf2OcVvNe1Bu8fhC0Lmtsl+cK1+koE+QqLHnv7D7b0JUklBJPdYvoojEb0AInhFhtfHOts8IkT1IPJfoAv1nIpEE7tPLiBrelBnP7D5QvaIC1kNrMa7a4evS9x/ER2jUyIgbbXk5dhDoyEOBSa9DgB2fwYkv2zF3tW2Q9Cf+ymHovlQGf61xdGj9RgIcCquVoz7uXgpVoAlqJu3IG6XqoJ0gp305JFYCmeUqd4/wG6+0t7CUEOEm4++BCdJBXm5wWRLzMAQYGR0fPryq5jWfaoVyZCHbodYDzRGpWFLcnd0c/gcObjIBaC/Jb/InPYVmhZ/HB0EcFh7PbdNNlUsgJVjZXfwwRXX3T37PrrIbbimpVJqW/5YOS79C5Qp12Q+cT9Lmt6OaWgy6niUYLwbTY3R+Sxw4zYjdIM6RJKbmATCU64LIwPKWy4wd2fsoU2F4cEp9nXTYyuAdZwM9RrOshLS
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199015)(40470700004)(46966006)(36840700001)(966005)(31686004)(66899015)(26005)(478600001)(70586007)(4326008)(8676002)(6916009)(16576012)(316002)(54906003)(40480700001)(70206006)(336012)(86362001)(426003)(53546011)(47076005)(5660300002)(7636003)(82740400003)(41300700001)(356005)(8936002)(2616005)(7416002)(16526019)(186003)(83380400001)(31696002)(2906002)(36860700001)(36756003)(82310400005)(40460700003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 22:31:48.5125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e36ce47f-8f0b-4963-a578-08dad7d9a9fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7365
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/22 13:51, Peter Xu wrote:
> On Tue, Dec 06, 2022 at 01:03:45PM -0800, John Hubbard wrote:
>> On 12/6/22 08:45, Peter Xu wrote:
>>> I've got a fixup attached.  John, since this got your attention please also
>>> have a look too in case there's further issues.
>>>
>>
>> Well, one question: Normally, the pattern of "release_lock(A); call f();
>> acquire_lock(A);" is tricky, because one must revalidate that the state
>> protected by A has not changed while the lock was released. However, in
>> this case, it's letting page fault handling proceed, which already
>> assumes that pages might be gone, so generally that seems OK.
> 
> Yes it's tricky, but not as tricky in this case.
> 
> I hope my documentation supplemented that (in the fixup patch):
> 
> + * @hugetlb_entry:     if set, called for each hugetlb entry.  Note that
> + *                     currently the hook function is protected by hugetlb
> + *                     vma lock to make sure pte_t* and the spinlock is valid
> + *                     to access.  If the hook function needs to yield the

So far so good...

> + *                     thread or retake the vma lock for some reason, it
> + *                     needs to properly release the vma lock manually,
> + *                     and retake it before the function returns.

...but you can actually delete this second sentence. It does not add
any real information--clearly, if you must drop the lock, then you must
"manually" drop the lock.

And it still ignores my original question, which I don't think I've
fully communicated. Basically, what can happen to the protected data
during the time when the lock is not held?

> 
> The vma lock here makes sure the pte_t and the pgtable spinlock being
> stable.  Without the lock, they're prone to be freed in parallel.
> 

Yes, but think about this: if the vma lock protects against the pte
going away, then:

lock()
    get a pte
unlock()

...let hmm_vma_fault() cond_resched() run...

lock()
    ...whoops, something else release the pte that I'd previously
    retrieved.

>>
>> However, I'm lagging behind on understanding what the vma lock actually
>> protects. It seems to be a hugetlb-specific protection for concurrent
>> freeing of the page tables?
> 
> Not exactly freeing, but unsharing.  Mike probably has more to say.  The
> series is here:
> 
> https://lore.kernel.org/all/20220914221810.95771-1-mike.kravetz@oracle.com/#t
> 
>> If so, then running a page fault handler seems safe. If there's something
>> else it protects, then we might need to revalidate that after
>> re-acquiring the vma lock.
> 
> Nothing to validate here.  The only reason to take the vma lock is to match
> with the caller who assumes the lock taken, so either it'll be released
> very soon or it prepares for the next hugetlb pgtable walk (huge_pte_offset).
> 

ummm, see above. :)

>>
>> Also, scattering hugetlb-specific locks throughout mm seems like an
>> unfortuate thing, I wonder if there is a longer term plan to Not Do
>> That?
> 
> So far HMM is really the only one - normally hugetlb_entry() hook is pretty
> light, so not really throughout the whole mm yet.  It's even not urgently
> needed for the other two places calling cond_sched(), I added it mostly
> just for completeness, and with the slight hope that maybe we can yield
> earlier for some pmd unsharers.
> 
> But yes it's unfortunate, I just didn't come up with a good solution.
> Suggestion is always welcomed.
> 

I guess it's on me to think of something cleaner, so if I do I'll pipe
up. :)

thanks,
-- 
John Hubbard
NVIDIA
