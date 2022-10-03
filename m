Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2315F371B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 22:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiJCU3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 16:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiJCU3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 16:29:12 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58E128E03
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 13:29:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6e0yOPcn8EJWePMqgoOjHPcScKRePxIkRfTACKbwzX6NdLTVrQL6L/nRIEThAUBql/BssAoETO4B1q57HpzX6FDxQFqlDzz7vL+pwDhLbhP/ahMeX5knK7TAbAivtY6Y6pu2IcNM/t1rBs9VXcdetqz6NnS0QguFQScL0sTzmOUudDedq9wa7qaq5KyoclyqvcuUSbh84nsb6hhhsrCuMEDDOWiXaqFaW6TIthzO3/8gY1GrEbHq1mn+4s2h7XAzUg9YQuyeVkFPBwyy1+CwVZiBxBn5qpzVOiY41CoxEXCRcNKfA74TkFwSM8A7CfjOFz+SWzW8zela19CbhPGfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnu/I1gx8E5ujL+R2A/mecZBenTjSLYR86g82dWxK3s=;
 b=LBcTQnRsxHdBnP9eUoiD+Bcv+XJqtqtb1OdaUWIynI3xvIl4ddE19kij+Duz+SNzhXYiMcj3oaxrFgqdnkizlvv4GP9Gw9wxIJEeJA1PTjmJTtCUlqYg+kQDRUpisESRdZHv2u1ls9vPY55IiGGY43uIZbmPYjfp+gQ9Duvx8c+N+Y0SU3PnYRs2IHQ2unxQ5tIcUjElKkuukfJd+Y89eyGKP8urD/42hZwweo2lOIZChRP6qVpB+Oi7qLMH5wQ4weCQ/Qyc05ccX/eSsmDAJQaqxwZsCO/4j1muNrnoHFEBUqaZIrbXSXpObioGBoaRZ1Jxj8gvY7KVVl4YsBlr2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnu/I1gx8E5ujL+R2A/mecZBenTjSLYR86g82dWxK3s=;
 b=Le5r0OXwIlOKRWgHWCVHqklr8ozljy31tpG2/8OLK3Mc6c4S9EouTmX0SInrSIBk8yGgqWdL4Bo9AlHg0Ui0Fj8OpsWj08tpGGW1rxFlimLBXEeeF6qjdJdYmCCgrTo4sgpH5AD4RZdvuttvSV/v0BGJNWug1O0e7oBUvzK3+M6yu4a2HrxUefbGo8bKyZ9y47OIEZ9849W6ZLY3UVjIbYydancOWHh5Hum97Br5GW93KEiJ4hne0IEQlbHk7KIX/3jH7n8HnfIyWjOlufRcz9mx4MlkkBBI9bm0KjA1ARt7MxHZHvL1AsnLh1PoEdndoCR8qeq+4GNsXjncEmMcvg==
Received: from MW4PR03CA0346.namprd03.prod.outlook.com (2603:10b6:303:dc::21)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Mon, 3 Oct
 2022 20:29:08 +0000
Received: from CO1NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::c2) by MW4PR03CA0346.outlook.office365.com
 (2603:10b6:303:dc::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Mon, 3 Oct 2022 20:29:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT115.mail.protection.outlook.com (10.13.174.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Mon, 3 Oct 2022 20:29:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 3 Oct 2022
 13:28:56 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 3 Oct 2022
 13:28:56 -0700
Message-ID: <dd67e7c5-a2e1-40a9-335d-c35aa6e32955@nvidia.com>
Date:   Mon, 3 Oct 2022 13:28:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 4/4] mm: Remove get_kernel_pages()
Content-Language: en-US
To:     <ira.weiny@intel.com>, Jens Wiklander <jens.wiklander@linaro.org>,
        "Sumit Garg" <sumit.garg@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Mel Gorman <mgorman@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        <op-tee@lists.trustedfirmware.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20221002002326.946620-1-ira.weiny@intel.com>
 <20221002002326.946620-5-ira.weiny@intel.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20221002002326.946620-5-ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT115:EE_|MN2PR12MB4534:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c2245b8-6745-4af1-59f9-08daa57deca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QSlrhW+DDLX8zMLPFXiNEQ9Fu31npOewjM2WLMWbOTo0nx1oRugD1FQfBcTErqoAR+6QI/6+WFccMMVmdc1FEIiAvqpjrrRn0WM6Gr87cf+2sR5+47/6o32v+eIlWVCUHA22C9Jp5z8Fnq+Yl2H5dQyTbZl31KlddfkVSh33cmd2iJC9+WZJ8DL2GygRK+a8yKMIgbNGqUiN5mmR5s6ffgWwaxT/LnU3UBuaNUevHaWwQ2k5C8ooa/Fycbup6YnqsA+9SgbXvbv5bGRHgfehFfblzsJqQtyMUZewlkkziBC3EKm9GEhLpFxMn2lJXA432IigitOLEM7UudUoM9+ElcfbYhFGIK6S0/xdh7kQTFkDpYa6lh1lz9l7PlNGmrlk+xo63xv3TxKENLEVlhkWobOTYrO/BIjAwAfU3Tvk4Pv0tEjGbrJo5KxmK5e9DPwwpYghrJYQ9GLZDPpRx/MXFYw1AWJgcz6Hg9mBRFEmvvDWKI3nGDMtyOSvztmNP5maFSUQTG+vznYPleVn4SywnQKfEcprkIjXDUN4T5in8ZTscfBzn/XDd6Q9Wcpi6FHx9QRQU5vtcB9u2oKwFBtLzF9f8YoYV3DClpDfE35+Y48osSlxUpERyhIAizB0qojeZDy1vJfRqtSWi9kUtLG9wVbVJxCqDAKjgdy9mBio2g+vzqwWSJCK6a2/84u9ThhfLnjJcFAUa+5A3/ixsDnF+L++fj5vA++pqkJnH8lNUxSv1miJaoK5EQJBIPs1CVnE4g8vVM0U23i1LPoqf064EpFdXR5alvegdgP7qYyPkL1P088AKUhec4/itIcA5LQT
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199015)(40470700004)(46966006)(36840700001)(31686004)(54906003)(478600001)(316002)(110136005)(16576012)(70206006)(70586007)(4326008)(8676002)(36756003)(36860700001)(82310400005)(40480700001)(7416002)(86362001)(5660300002)(41300700001)(83380400001)(26005)(31696002)(53546011)(8936002)(40460700003)(2906002)(2616005)(47076005)(356005)(7636003)(336012)(82740400003)(186003)(426003)(16526019)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 20:29:08.4800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2245b8-6745-4af1-59f9-08daa57deca9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4534
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/22 17:23, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The only caller to get_kernel_pages() [shm_get_kernel_pages()] has been
> updated to not need it.
> 
> Remove get_kernel_pages().
> 
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>   include/linux/mm.h |  2 --
>   mm/swap.c          | 30 ------------------------------
>   2 files changed, 32 deletions(-)
> 

Good to see this removed (including the EXPORT), even if the
functionality still remains in a less obvious form, over in shm.

The fewer "all your page are pinned" calls we need, the simpler things
get. :)


Acked-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 8bbcccbc5565..9a06df4f057c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1969,8 +1969,6 @@ int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
>   			struct task_struct *task, bool bypass_rlim);
>   
>   struct kvec;
> -int get_kernel_pages(const struct kvec *iov, int nr_pages, int write,
> -			struct page **pages);
>   struct page *get_dump_page(unsigned long addr);
>   
>   bool folio_mark_dirty(struct folio *folio);
> diff --git a/mm/swap.c b/mm/swap.c
> index 955930f41d20..a9aa648eb0d0 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -157,36 +157,6 @@ void put_pages_list(struct list_head *pages)
>   }
>   EXPORT_SYMBOL(put_pages_list);
>   
> -/*
> - * get_kernel_pages() - pin kernel pages in memory
> - * @kiov:	An array of struct kvec structures
> - * @nr_segs:	number of segments to pin
> - * @write:	pinning for read/write, currently ignored
> - * @pages:	array that receives pointers to the pages pinned.
> - *		Should be at least nr_segs long.
> - *
> - * Returns number of pages pinned. This may be fewer than the number requested.
> - * If nr_segs is 0 or negative, returns 0.  If no pages were pinned, returns 0.
> - * Each page returned must be released with a put_page() call when it is
> - * finished with.
> - */
> -int get_kernel_pages(const struct kvec *kiov, int nr_segs, int write,
> -		struct page **pages)
> -{
> -	int seg;
> -
> -	for (seg = 0; seg < nr_segs; seg++) {
> -		if (WARN_ON(kiov[seg].iov_len != PAGE_SIZE))
> -			return seg;
> -
> -		pages[seg] = kmap_to_page(kiov[seg].iov_base);
> -		get_page(pages[seg]);
> -	}
> -
> -	return seg;
> -}
> -EXPORT_SYMBOL_GPL(get_kernel_pages);
> -
>   typedef void (*move_fn_t)(struct lruvec *lruvec, struct folio *folio);
>   
>   static void lru_add_fn(struct lruvec *lruvec, struct folio *folio)


