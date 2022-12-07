Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8AA6464F1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 00:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiLGXUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 18:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLGXUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 18:20:12 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4ED303E8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 15:20:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMPJs/aHUmq/fTL0vpFzgJ1xVIK6dKbbMUX8nckrTsZ5JzHgEOTQqxw0WRbX7TsyNJdL7hUkHHGh5csVDUkGNcfC8s9buh8dFjBxgvJrstqIq9yeyPUin8gu6QZgux9I7MU3s2ZkymCq/M18RAlYjWaHXGEg7uzI/iYEtcjMAbOTh6qNsjZBT314XXzI738c38PjvXj0xQOcE5SwPXdiZsFAle9HfzwgVOw0HflaG88icNolDOQVJHfQALoaEk4GuzZnYpC4pgfx15Hi1/MAUQivBsKvjOClGtNXtGNLI5Fb4usYWN7Xxs5y4x0/OPs3+14zS2K3gmw7JYIQQOhCoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0u6qt9d92EPAbl+2E0FTWtVzB1y3ksNd00ibT8qkCic=;
 b=KyK9xWZlP4JYxgAW4AphMsg86bPqb60f0vPlo7J+P8qJhNQ1c69M8wKoUWJ8r+MSeHgv/vxREjwFIo57N+hbZpyccS3R65uzxLqbRThOc2EsJCpzYoEy+K1InwCiW/tR2QMXiWht46uI+yqZanCOY7MzPR4/gK/kqtLdxGfWaloYEPI4AgixK+9q5G4t1T0z8Dj5IT52/wwLGXl518BGl7bKFF4xF7PbmNE+wVzfs6QXyrxziHf2VB0TVgZbvI0sL+LxH/j3gMPjd87JMWCiQPSAUsM/+57rCrIZ5+9muM9GKIb5RzPAaDZ3WZnAj8k80iEkWCYKuRGX1H+tDG/lDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0u6qt9d92EPAbl+2E0FTWtVzB1y3ksNd00ibT8qkCic=;
 b=FRycLT1KfJLD07QCGaqLpMWp/qxJcyjvBLWTTZT3/3c0YKfNtMa9RI0CoNIHLmSBj//NYjUV9nB6a3lNvoMbbUCicgrqSv7NC5NOIz03IT8AylPpvUMZ2XNV0MIfmxMtuy5Ec7oHpwUfw+mi3j7A1nOoXmrvnTyfV3wfIDPWu/Zu/iCYVVld2euT1o6+Cgmej7cDkMlzs2O2RElCXbQd9HfiuSQxui9JZXxkuLHU7xePFCrV/rWmtUSUiMx/vb5/dcmjzriLwYuAfPihib4gdaK131CQC0M9MMXVPUmx/b4tuiOfRQVroVQTHxxl0IdZrRsvZJiwdf5cEnwnbcnDPQ==
Received: from CY5PR17CA0048.namprd17.prod.outlook.com (2603:10b6:930:12::9)
 by SJ1PR12MB6073.namprd12.prod.outlook.com (2603:10b6:a03:488::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 23:20:07 +0000
Received: from CY4PEPF0000C96F.namprd02.prod.outlook.com
 (2603:10b6:930:12:cafe::b0) by CY5PR17CA0048.outlook.office365.com
 (2603:10b6:930:12::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10 via Frontend
 Transport; Wed, 7 Dec 2022 23:20:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000C96F.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.8 via Frontend Transport; Wed, 7 Dec 2022 23:20:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 15:19:56 -0800
Received: from [10.110.48.28] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 15:19:56 -0800
Message-ID: <b3308387-464a-52ae-114b-34ab94e3b5c6@nvidia.com>
Date:   Wed, 7 Dec 2022 15:19:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 05/10] mm/hugetlb: Make userfaultfd_huge_must_wait()
 safe to pmd unshare
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Kravetz" <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
References: <20221207203034.650899-1-peterx@redhat.com>
 <20221207203034.650899-6-peterx@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20221207203034.650899-6-peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C96F:EE_|SJ1PR12MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aee8974-2d11-4e5c-b7b7-08dad8a99431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7dnc71bpfAtcKiiOBBgxwPiq3Oo2Sn74FZ8RNiszfjWEQ0ms5kCfwRxvOo6HB/HfZZj8xd0bFPazFK3Bd+LV7Sl9OAZn2XEMhJ6L5zbJwWtSavhW24rHzuMvMuo7Oy5Rb/+6Sn3O+IuXOg0kR75mV4ZYHbRDNevO7REqQ1N7XN+n1/qYRVlgIRoCD4Yal+sq1VFIDlzpZpNfxGW8jpBv7+vuGzxssgsHGeaAlQkvm6yj63H/4INP9GsUNFs05+29zRMzSPG4CWqm1BrWy15L5BK8f7Yh3mzInrTO3TlLHuZdc+mBgSbnh3TCD4CTDA5eEOrqUUlHYhl0DbRy/4KVHdI67V6RwdfowMapnnCA+2PNCrAkGq0odjETai4GCjrogiM4q1Qc++8jJ01nrul8RCKXutTW8UeAlMEpGYeF8eyI9RkSruL2qF9DI81VFiCE3Bl5H07gxbntNsxVyN3vrtcUcCB8iJ+jMhPz6DHrM7jipOJMoLW0BbgNSSff9HNepVyqdUEtu9FGaGbtYMHBmMwv692QQiJ9Pcz2uTxBgyq4H1XSBUl407QeidJl8yB642JvQ0S5TvhJGyIkO1+JwwRNd1GovXoGETCjF7LV5Y+d5JGU+Dh5ZOh1dzkH84cWRvvpnpI3LCYAOFJfJGSuvk5HsgsV1wJvkr1FAnkpK8YvN2BWyx0JeK6vMc5fGS6V64I0Qx4eEOiEiRyiZaQFHaySfV7C96NGzzltghu4P9Y8mcpTKlgEoJlle9imcAGSG05t6U+7W39aNWQ+g6/rGZ79Pz/khaQyPsqaOz6XbQQ=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199015)(36840700001)(46966006)(40470700004)(83380400001)(70206006)(36860700001)(41300700001)(7636003)(356005)(86362001)(70586007)(7416002)(8676002)(2906002)(31696002)(8936002)(40480700001)(5660300002)(53546011)(82310400005)(316002)(26005)(186003)(54906003)(426003)(478600001)(336012)(110136005)(16526019)(16576012)(47076005)(40460700003)(2616005)(4326008)(82740400003)(31686004)(36756003)(14583001)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 23:20:07.2299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aee8974-2d11-4e5c-b7b7-08dad8a99431
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C96F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6073
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/22 12:30, Peter Xu wrote:
> We can take the hugetlb walker lock, here taking vma lock directly.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   fs/userfaultfd.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 07c81ab3fd4d..a602f008dde5 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -376,7 +376,8 @@ static inline unsigned int userfaultfd_get_blocking_state(unsigned int flags)
>    */
>   vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>   {
> -	struct mm_struct *mm = vmf->vma->vm_mm;
> +	struct vm_area_struct *vma = vmf->vma;
> +	struct mm_struct *mm = vma->vm_mm;
>   	struct userfaultfd_ctx *ctx;
>   	struct userfaultfd_wait_queue uwq;
>   	vm_fault_t ret = VM_FAULT_SIGBUS;
> @@ -403,7 +404,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>   	 */
>   	mmap_assert_locked(mm);
>   
> -	ctx = vmf->vma->vm_userfaultfd_ctx.ctx;
> +	ctx = vma->vm_userfaultfd_ctx.ctx;
>   	if (!ctx)
>   		goto out;
>   
> @@ -493,6 +494,13 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>   
>   	blocking_state = userfaultfd_get_blocking_state(vmf->flags);
>   
> +	/*
> +	 * This stablizes pgtable for hugetlb on e.g. pmd unsharing.  Need
> +	 * to be before setting current state.
> +	 */

Looking at this code, I am not able to come up with a reason for why the
vma lock/unlock placement is exactly where it is. It looks quite arbitrary.

Why not, for example, take and drop the vma lock within
userfaultfd_huge_must_wait()? That makes more sense to me, but I'm not familiar
with userfaultfd so of course I'm missing something.

But the comment above certainly doesn't supply that something.


thanks,
-- 
John Hubbard
NVIDIA

> +	if (is_vm_hugetlb_page(vma))
> +		hugetlb_vma_lock_read(vma);
> +
>   	spin_lock_irq(&ctx->fault_pending_wqh.lock);
>   	/*
>   	 * After the __add_wait_queue the uwq is visible to userland
> @@ -507,13 +515,15 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>   	set_current_state(blocking_state);
>   	spin_unlock_irq(&ctx->fault_pending_wqh.lock);
>   
> -	if (!is_vm_hugetlb_page(vmf->vma))
> +	if (!is_vm_hugetlb_page(vma))
>   		must_wait = userfaultfd_must_wait(ctx, vmf->address, vmf->flags,
>   						  reason);
>   	else
> -		must_wait = userfaultfd_huge_must_wait(ctx, vmf->vma,
> +		must_wait = userfaultfd_huge_must_wait(ctx, vma,
>   						       vmf->address,
>   						       vmf->flags, reason);
> +	if (is_vm_hugetlb_page(vma))
> +		hugetlb_vma_unlock_read(vma);
>   	mmap_read_unlock(mm);
>   
>   	if (likely(must_wait && !READ_ONCE(ctx->released))) {

