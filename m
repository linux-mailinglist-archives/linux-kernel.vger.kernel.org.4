Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70996318A2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 03:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiKUCcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 21:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKUCcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 21:32:01 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9EC2A961
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 18:32:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRl18NWk5I/r1xeI4Om9X0bDQGC5pUi/Ucpe/Jy58wWhVE2SktEgmcKWFc/ogvj6tfUMRQsJf0tA+vpJmaySu5lzFKhQRrnlmjFDcvxsbyvIDJ3AlfzYXxGB1c4o6w/LMFzwCDiu5/NFrxPZ9lJGu7BqTRPZCwSfhuOhFT97i+N6OSRkJHzhMbpELyk1YJoeTeV8RMUHKHzylJ1U1T5vSwcgYeYfCVqLv0b6Xbe8qTEtesRLjJzPQuXXAi499SqO/4p24tITqpyVqL/GO0QVeXNwLmGQ+BhiPoPW10FeCmIL5ZdB55Et4chX4s56WfBnZl6Iha3LWN8W7ddB2pABNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+udusmNOFgKR1ZzhVWxvVBUilfoX4BnXjfTDW69VY4=;
 b=cbnuS0Nuu7LzfqmuihoKYzu45iKqdVYMJnkyJ3qjeTi+vt7bnqKQ2n8AfDPpHrzi2KBp1Yb4zezIQh8PT7DpGY9qQqUC7wWktPGvGmsPWqGagm1KCn/oKIKIlydRMwXkS8FDbpTmpkM/XlIo2Icpag+c3/SsIgasrxA5z4L21uGjbzbv837Flg44CWeG629wzzmopPrdXkLWabsJDQItdD4MoPPVyK4S/sheNyQiI5PzBLs1x2xcPmj1Vy5BhlNxxL6ehpgWobZ56sElWtlpDEL1dwk54kVBX8wfeQcmoOZ/f+yz2kQ67vERdRSPmkukBnjmftWwueRJZn1paD0xzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+udusmNOFgKR1ZzhVWxvVBUilfoX4BnXjfTDW69VY4=;
 b=ZWlMaGm8nwQsJ9ZfZHPM6quX1liQdEjE4OQfiYRVELZggI1ZpburgWZW7hqcoLOFYq1vlXSkeLvcUq76IjkeiAhOweJvBhyPrSYuaoh/JvR0X1Yf0lg9IfBhqAI00hmC9YVrqvTRo7F8Gmb8npObN4wi9h2xUZMPajJXNJ94P4NFmrPkZDIRHh+uDzwdvf/Rs7REypSUQXRumYzq57pR28lzj9Lp+bu0M7aZFWaXM5RN0jnpa7M+l8RfJyXpbUWSBwlEkipbTU/b8YCM1Sumbi/A7b9nnpO6SRRd1Yw4AFX4LUieWZokQ+oNHdOXBGZnDD9AprTYoxdZ8MpyvvMaGQ==
Received: from DS7PR06CA0040.namprd06.prod.outlook.com (2603:10b6:8:54::28) by
 LV2PR12MB5992.namprd12.prod.outlook.com (2603:10b6:408:14e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Mon, 21 Nov
 2022 02:31:56 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::73) by DS7PR06CA0040.outlook.office365.com
 (2603:10b6:8:54::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Mon, 21 Nov 2022 02:31:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.8 via Frontend Transport; Mon, 21 Nov 2022 02:31:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 20 Nov
 2022 18:31:47 -0800
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 20 Nov
 2022 18:31:46 -0800
Message-ID: <380a57f3-d705-aedd-a0dd-6dab8b9f8e1d@nvidia.com>
Date:   Sun, 20 Nov 2022 18:31:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH mm-unstable v4 10/10] mm/hugetlb: change hugetlb
 allocation functions to return a folio
Content-Language: en-US
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <songmuchun@bytedance.com>,
        <mike.kravetz@oracle.com>, <willy@infradead.org>,
        <almasrymina@google.com>, <linmiaohe@huawei.com>,
        <hughd@google.com>
References: <20221118222002.82588-1-sidhartha.kumar@oracle.com>
 <20221118222002.82588-11-sidhartha.kumar@oracle.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20221118222002.82588-11-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT015:EE_|LV2PR12MB5992:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e3aba17-23cd-45ae-c3d8-08dacb688efe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jiuz2pBFh7ahlqRhe0ZtfCvCO6T10SLTqlj/XZ7QtnO8+QhZg2pHfmgL/AfP+0sN6y5AQyJDKQC9NwopeB/eaonNQhEgeWd/mYgbwaIX2ZW/Q+FuIGlCdvM0xuOEsECaJW/ZoN2U5vwI81PxkDZzvgFK8B7o96yT/+OGLgd6PuvFIn979quBBmUE7bqJQI4n6r+NC5F748yvwUpH9+P2q9/W/8Yh6SnkZRZZ/3Knx/aP2CIboXuc8Ih+juUZ7YZ2EQJhbEpVvSKdleMrhAiZDPMhI9z391OjHxjoaZYPGp6uySfWADXwV89B5mlPHk03ZQdGC1sAlfvaeZEOujW62v4PDS/+CVVqz/4W7k67XYT9XyDU9hUzYC7ccGfUMS23+EDeyXuG3aYoobnvRdSIVZ70TvTtEAOq0I+IpOYfzKq5h1fEVMkCPgxfFVqCDtKqbFCC0lKi6dmTrAhf8cHBPdO7zfQ2cNOLH/h1m32u9fiLZmxyQrDZXeD7ZBotvEv/D0wiTYjhxazkCpS5zSpSJ6cskiqXm/bK43de1KyqZnrDDuxZPJokfYxOjIhhMwPEaaELY/Ge5EkyjdREy8y4o9oVrLpf7RpN/97QTNDorl05PBvUSBF8myOThiOOOK8BPYxNYmyDaVD3H0+u5sExUvQ0wMpU8lGV+eyVyjQYYUuCU3WaXjief2rP5x5MkBPvs6LQdlP6Nqi7UAO/DfLDJ+ckx99vU4ckmzXb/6n2TGUGYlsIgGF1zxdWDd4LR61t
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199015)(46966006)(40470700004)(36840700001)(82740400003)(7636003)(356005)(41300700001)(36860700001)(86362001)(31696002)(82310400005)(54906003)(8676002)(16576012)(70586007)(8936002)(316002)(70206006)(4326008)(478600001)(40480700001)(53546011)(2616005)(426003)(40460700003)(47076005)(26005)(83380400001)(2906002)(16526019)(336012)(110136005)(7416002)(186003)(5660300002)(36756003)(31686004)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 02:31:56.0882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3aba17-23cd-45ae-c3d8-08dacb688efe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5992
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/22 14:20, Sidhartha Kumar wrote:
...
> @@ -1950,7 +1949,7 @@ pgoff_t hugetlb_basepage_index(struct page *page)
>   	return (index << compound_order(page_head)) + compound_idx;
>   }
>   
> -static struct page *alloc_buddy_huge_page(struct hstate *h,
> +static struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
>   		gfp_t gfp_mask, int nid, nodemask_t *nmask,
>   		nodemask_t *node_alloc_noretry)
>   {
> @@ -2009,7 +2008,7 @@ static struct page *alloc_buddy_huge_page(struct hstate *h,
>   	if (node_alloc_noretry && !page && alloc_try_hard)
>   		node_set(nid, *node_alloc_noretry);
>   
> -	return page;
> +	return page_folio(page);

1. This causes a NULL pointer crash when the user requests too many hugetlb
pages (you can probably guess how I know this, haha), for example:

     echo 50000 > /proc/sys/vm/nr_hugepages

...because page_folio() doesn't have a NULL check in there. You will want
to do something like this, on top of this current patch:

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 629bb044f063..ffb0f052bbff 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1987,11 +1987,6 @@ static struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
                 page = NULL;
         }
  
-       if (page)
-               __count_vm_event(HTLB_BUDDY_PGALLOC);
-       else
-               __count_vm_event(HTLB_BUDDY_PGALLOC_FAIL);
-
         /*
          * If we did not specify __GFP_RETRY_MAYFAIL, but still got a page this
          * indicates an overall state change.  Clear bit so that we resume
@@ -2008,6 +2003,12 @@ static struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
         if (node_alloc_noretry && !page && alloc_try_hard)
                 node_set(nid, *node_alloc_noretry);
  
+       if (!page) {
+               __count_vm_event(HTLB_BUDDY_PGALLOC_FAIL);
+               return NULL;
+       }
+
+       __count_vm_event(HTLB_BUDDY_PGALLOC);
         return page_folio(page);
  }
  

2. And also, the tests should probably be augmented to run this simple
(but easy to overlook) test.

3. And finally, the basic method of replacing page with page_folio(page)
is not sufficient, as you can see here. So I'd suggest taking a look
through your series to see if you are checking for NULL first, before
calling page_folio(page).


thanks,
-- 
John Hubbard
NVIDIA
