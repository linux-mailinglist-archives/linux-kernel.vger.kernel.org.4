Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038A8733C80
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 00:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbjFPWk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 18:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjFPWkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 18:40:25 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865192D6B
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 15:40:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlf77ZPkJT0LXe+H+0ftqjawdPfu/t9MiPTeB0QTDVn0RLe/vl9Nq/XigWJTE7vMe1/4jNkmwkOuVNLV3EPtaG7ubX4uT47lBUlmXCM3AMocIhck7L2k+qWDSGbv+fTNhheCFdzx1/J/+5eY3kwJtKvF6K4IKYHuluTkFg9ZJN4/VLLR43ArqaS4GfPVuPUVABz3Ohp77CruHcZoustkQm2CDPffc3lnac176ZWK8u/QiPn/cYRTA1qKUjSzUPxzlYxIugXaZeD5+3ZhdQjHxZ4LMdRIX4xMWGCeMuRIuDCsYHXO2L0U6M7odImlMGtsALA+unX4Mho2LImVLJbVCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvOsdAY6gGm4Rtv+3E3NpKHGFvxylQMnWXp0OvXi+i8=;
 b=iF3Tbm8qiYlNSZeZpmCGAUmvX4qKEsmdlx01dB9+KAwHdQtpLZJ06j54OG3QtvDrubidhj3swla3sTuvoGzl8QIXu6rogiLaIFGEsdb26p+x4yKhRer2ArflWSKKgFtS4GBBMYhEVIRRzqyTMljDEjcsWQ2NNdm92vbrpYYNurl53EE+1+XdLIKxy4Oqd6IRb3ofjkb/E7jttscNktWbFLgX4gewYFzP8Ei96YsXNxN/hYipIlWCQ8KUeCDCcGJMdrFbf2RAseJcVGcBF1TkJRB+lDATdt9f443wtlR7vGKoV78nmpL/+FQTXv4tbOwXhAxbC/6a6JA7wXg208mJDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=efficios.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvOsdAY6gGm4Rtv+3E3NpKHGFvxylQMnWXp0OvXi+i8=;
 b=dXB7bKieoVGRw6U+MGM6Ut9YF0mIHGR/WJrpEzE+jxJMVns/Iu95XCtA20dFJHUdSMWwd//mNnxwjCyAsBTsxLEBreA/r7EBD3peQqF6iCs9pyPXhr5HUZ1dmGQUZ0y8a+ZROSmwzyg+770HgQc5QbxQ8VmtsVVsRFVzTsDTl/vbXmDU7VCk7EuCl1zZk/mDlIxc+VzRYxbArjgDeA9mSxctR0wub7zejBua5INR+Rm28/oEx7yH6jbcBBPtmtSP4SEnz7Yi0CAluB3enejmYYivKaDNvYvrXsqzmjkGgAQQ5/6xif39jpstY/CuEfV/FPIbUjPViDzZNccM22yj5g==
Received: from BY5PR04CA0020.namprd04.prod.outlook.com (2603:10b6:a03:1d0::30)
 by BY5PR12MB4035.namprd12.prod.outlook.com (2603:10b6:a03:206::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Fri, 16 Jun
 2023 22:39:18 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::8e) by BY5PR04CA0020.outlook.office365.com
 (2603:10b6:a03:1d0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27 via Frontend
 Transport; Fri, 16 Jun 2023 22:39:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.27 via Frontend Transport; Fri, 16 Jun 2023 22:39:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 16 Jun 2023
 15:39:03 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 16 Jun
 2023 15:39:03 -0700
Message-ID: <b0a24ce7-4dd1-a017-dd77-be284b87a34a@nvidia.com>
Date:   Fri, 16 Jun 2023 15:39:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mm: Move mm_count into its own cache line
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        kernel test robot <yujie.liu@intel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Olivier Dion <odion@efficios.com>,
        <michael.christie@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Feng Tang <feng.tang@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
        <linux-mm@kvack.org>
References: <20230515143536.114960-1-mathieu.desnoyers@efficios.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20230515143536.114960-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|BY5PR12MB4035:EE_
X-MS-Office365-Filtering-Correlation-Id: 46a123ac-82c7-45c3-a5d0-08db6eba83fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ogy0J6GQ9d+p8Wlzwb/FBZxFY3AFywpUKP5CbuvCHPafFLFfS192Bp92Tk9hVtCinArA2u2VW/H22f72beHZv+Wpnn29XXvJkqL2mYbWFglNmcdZ6+uNzBo0eTKweW+QHbQ1hbQz+QJr5r5TQuSkjm+9E4hCywL/h1+ANNPapkW9O35WD/9OZKgLDW4bA8x2QbY5deearl9NOstIkfABBb8lfJ0KG9mZboy08uEim2/9gqwlDhI/WG5KstSFdGQVi0N5NAQFPEjbX98ztoQTS+xWQ/Mi/f2gFR+GxEJ4BRvJl6G8oZM85Pwz/y5tkzDQ94G/lrG6vgbqfLD7XjwR7JqUrNyX92L2N1Z6TdzlND9IKL36XLnrb1VpGnpJM53BhSM5dNwK/w4OdfKCtbKOPtPYQkB7HDexJz0lAt/t4ORPueIeUqzovEm+6Uxw2roUl0avhCr7pXDfvsCMoACABTDNjGHK1Bex+gt4MDqL3qqlOI+D1RtALb8wBS3mkqETssYwSvxmmcm3uLwyUSgIThSYcMmDMqN+u7F2nHRaUkbDh5MILZlxjpW8gRJ4g4f42QdRRIsVJnP98y6UessYGWsOZY5IBh6uokNsdZaCQrdrpAeEcALX15dgs8oIT4axbBrKaELKgnSQyOuV/zc+GvpPviCSsMhxAqXWpCloxyb0TJM0ebGgjcRvOOSRMevjP/ASlBRVUpKPDgp5LY1++qxxdzEji79ddNyPmSOX4WGBU4OPhRO0aNaeCjfUZa1pso2FioErxxca8wB6FBlVNW9YVYkBZ6idlp0ZY3+r56y+9D1CjamrAOL2LNobJfFHXlt15zzQySGH8K852ogsi7pbVVi3WH3DV0sVW+X7V3U=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(36860700001)(26005)(2906002)(186003)(16526019)(40460700003)(336012)(83380400001)(426003)(47076005)(40480700001)(2616005)(70206006)(70586007)(356005)(7636003)(31686004)(4326008)(82740400003)(8936002)(41300700001)(8676002)(316002)(16576012)(54906003)(110136005)(31696002)(36756003)(478600001)(86362001)(82310400005)(7416002)(53546011)(966005)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 22:39:15.9530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a123ac-82c7-45c3-a5d0-08db6eba83fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4035
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/23 07:35, Mathieu Desnoyers wrote:
> The mm_struct mm_count field is frequently updated by mmgrab/mmdrop
> performed by context switch. This causes false-sharing for surrounding
> mm_struct fields which are read-mostly.
> 
> This has been observed on a 2sockets/112core/224cpu Intel Sapphire
> Rapids server running hackbench, and by the kernel test robot
> will-it-scale testcase.
> 
> Move the mm_count field into its own cache line to prevent false-sharing
> with other mm_struct fields.
> 
> Move mm_count to the first field of mm_struct to minimize the amount of
> padding required: rather than adding padding before and after the
> mm_count field, padding is only added after mm_count.

Oh, and I almost forgot to add:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> 
> Note that I noticed this odd comment in mm_struct:
> 
> commit 2e3025434a6b ("mm: relocate 'write_protect_seq' in struct mm_struct")
> 
>                  /*
>                   * With some kernel config, the current mmap_lock's offset
>                   * inside 'mm_struct' is at 0x120, which is very optimal, as
>                   * its two hot fields 'count' and 'owner' sit in 2 different
>                   * cachelines,  and when mmap_lock is highly contended, both
>                   * of the 2 fields will be accessed frequently, current layout
>                   * will help to reduce cache bouncing.
>                   *
>                   * So please be careful with adding new fields before
>                   * mmap_lock, which can easily push the 2 fields into one
>                   * cacheline.
>                   */
>                  struct rw_semaphore mmap_lock;
> 
> This comment is rather odd for a few reasons:
> 
> - It requires addition/removal of mm_struct fields to carefully consider
>    field alignment of _other_ fields,
> - It expresses the wish to keep an "optimal" alignment for a specific
>    kernel config.
> 
> I suspect that the author of this comment may want to revisit this topic
> and perhaps introduce a split-struct approach for struct rw_semaphore,
> if the need is to place various fields of this structure in different
> cache lines.
> 
> Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
> Fixes: af7f588d8f73 ("sched: Introduce per-memory-map concurrency ID")
> Link: https://lore.kernel.org/lkml/7a0c1db1-103d-d518-ed96-1584a28fbf32@efficios.com
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Link: https://lore.kernel.org/oe-lkp/202305151017.27581d75-yujie.liu@intel.com
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Aaron Lu <aaron.lu@intel.com>
> Cc: Olivier Dion <odion@efficios.com>
> Cc: michael.christie@oracle.com
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Feng Tang <feng.tang@intel.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: linux-mm@kvack.org
> ---
>   include/linux/mm_types.h | 23 +++++++++++++++--------
>   1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 306a3d1a0fa6..de10fc797c8e 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -583,6 +583,21 @@ struct mm_cid {
>   struct kioctx_table;
>   struct mm_struct {
>   	struct {
> +		/*
> +		 * Fields which are often written to are placed in a separate
> +		 * cache line.
> +		 */
> +		struct {
> +			/**
> +			 * @mm_count: The number of references to &struct
> +			 * mm_struct (@mm_users count as 1).
> +			 *
> +			 * Use mmgrab()/mmdrop() to modify. When this drops to
> +			 * 0, the &struct mm_struct is freed.
> +			 */
> +			atomic_t mm_count;
> +		} ____cacheline_aligned_in_smp;
> +
>   		struct maple_tree mm_mt;
>   #ifdef CONFIG_MMU
>   		unsigned long (*get_unmapped_area) (struct file *filp,
> @@ -620,14 +635,6 @@ struct mm_struct {
>   		 */
>   		atomic_t mm_users;
>   
> -		/**
> -		 * @mm_count: The number of references to &struct mm_struct
> -		 * (@mm_users count as 1).
> -		 *
> -		 * Use mmgrab()/mmdrop() to modify. When this drops to 0, the
> -		 * &struct mm_struct is freed.
> -		 */
> -		atomic_t mm_count;
>   #ifdef CONFIG_SCHED_MM_CID
>   		/**
>   		 * @pcpu_cid: Per-cpu current cid.


