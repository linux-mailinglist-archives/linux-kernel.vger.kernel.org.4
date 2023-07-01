Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9144744584
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 02:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjGAAWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 20:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGAAWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 20:22:13 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8183D110
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 17:22:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOmKMeUQD+RH/nbtRPJfF9dX02G6A9SzOCgN3MeU8I16egt65KjpexIVgXw1tGhIM4JEtJIyG2wIicTVwpxAfXF86HuJ6zdCjipNnbEDZ9NAvE/A/+qi2rMfaR0Qy8xvEE5Dpg5wa+RvQtQT/np3B7l7ckFiyuqcUP0sVIbUgz4AEuMnmnAiM11LAJBZAYGHUUlhlooeNuk8Ddv+q2pJ7W3sTtbmapDTreYuV/Z7EaX8h6xGPtC6acDywq1FlhMhyescBIMpFvGRlR9r8LIS0w3t0e4a3LM4Xy0CuRcTR1zNeMusz9VKwjt1XFIe+scbRAA5DjDnrPwJgkJvOQn3Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ooq3MQzmKRmXdQM/907lnst5vBUUKH3HCCuxooMDUOM=;
 b=E6ice91VbQA8jTm4RgCfOCJzerythrJuDtOJS+QfqI83PpjoLvOvqg7MWxqqlnK6hu4ZkaN+dOLjTkwtlELNincL6kPSVW7E+qjsFJjuqfgVyPHbC0bZB/eHR5Mfo3V6hDMtVvv59N5VG3VeGUoLK+i5g3m4kH4lK06mW4AtakPdZpTL0PZI5Xu+836QwO1YUnqFsQhX8PzRx3B7X+CeeOC+MGR7KdoLKfwZ+pEHvF8LdrIGVlBIY8zXZHzfq60RQwq9zi7Ns/3jSEaFE0SYiIeidqdBmQ/fqZnCbJGTouEYONq5tQy18mjus3PQE7bLyddkDB38/r6bJvn14H6v5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooq3MQzmKRmXdQM/907lnst5vBUUKH3HCCuxooMDUOM=;
 b=OKBgkdnaBW/q5I9KDnTOIjWIlTkl1f3+IGppY3xyPrwv2QWyE6WzTyacH6ffo7UirZvO0oRi8GmGMyaDp2m7ZP1+Tsy+wpmdx/2rG1w00Zg1SEr6bGut/8MUJQLYD8bZITEBwJVuwWCIHVfnR1l9R7py7kAG2L2vB9NneEzspPkpPOGjKVx9+APA7wLJ8n4gpNmUHs1xrV24SzAd7PW7/3pIM5FzX+0QPZr1r9FhbHed8PQ+MQU94EAaUl4XDwVRRF3N6FfbokJSSiiYv5zQAybVZIY5Y8s3MGmraWMehmvA3j2cwQ9BK+tBebdUYWs1GWQia3xJ+jas52VKFJterQ==
Received: from MW4PR04CA0034.namprd04.prod.outlook.com (2603:10b6:303:6a::9)
 by BL1PR12MB5850.namprd12.prod.outlook.com (2603:10b6:208:395::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Sat, 1 Jul
 2023 00:22:08 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::21) by MW4PR04CA0034.outlook.office365.com
 (2603:10b6:303:6a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Sat, 1 Jul 2023 00:22:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.43 via Frontend Transport; Sat, 1 Jul 2023 00:22:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 30 Jun 2023
 17:21:57 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 30 Jun
 2023 17:21:56 -0700
Message-ID: <e6801255-238d-5c16-fe65-945de10952ce@nvidia.com>
Date:   Fri, 30 Jun 2023 17:21:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mm/hugetlb.c: fix a bug within a BUG(): inconsistent pte
 comparison
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        "Christian Brauner" <brauner@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Daniel Vetter" <daniel@ffwll.ch>, Dave Airlie <airlied@gmail.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ian Rogers <irogers@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jiri Olsa <jolsa@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Namhyung Kim <namhyung@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        SeongJae Park <sj@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Uladzislau Rezki" <urezki@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "Yu Zhao" <yuzhao@google.com>
References: <20230630013203.1955064-1-jhubbard@nvidia.com>
 <05ea6668-3dca-23ed-56c8-bbf8079d93cd@arm.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <05ea6668-3dca-23ed-56c8-bbf8079d93cd@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT057:EE_|BL1PR12MB5850:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a687684-f882-4d4d-1cd3-08db79c9346a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nr/XuLYTk8l/ge0JmmzYH1+sdDVJERszdiU1tXJSkbMErqEpU8goGxa25Gm15iPjLkGJLg2VW9wWWIyU/cgYHZFXMEZZ6nH51JCUiSsH0ISe9n7qu/9yBnblofhT3mMiY6A4SodwMPWj1OW8bscr9sJvUr/278vOzmXeixtbxL5eJvGmmNua9P99/nHVqpmt+k7+skI7a5EvLuQQq5b2KV7CcadmYGAwAuAQhcSelTuv5lZikbVJ+wD2h3dnGSlHlHTXJM7CPJPlqoyB7ZchEtlaRPOq/Y+YNuWhPKJOxSL7vhkc8naTdHCnu15RM4b+nSXZ7mXFoElc4LBeIKnjUPPnyOyFggPmo/B3xtWbk1lGOI+BLimUf4uBqkKW9/T/CSoUYSopB78MGlbsAjvi81Xx378BcPFjcvGos9W9IutpNy2Ah6IIQneuIskMPjajPrrP//sgKJMwMA+luVZGzhw7C83r3BEIgMsWBf2WiOb+BRF4QFST7y26gAp8A7JK8z3XkiIGTxSQRzN+e9aLbRxJm/YYZQomNMKsN5I57vaDTJMBW6sY1cgPtmghfw9yRaJVEefPMXRittvhE7c5d0QoMi0cqX32ncOX9bw18wWYs0kw6vVu/vMFTKM+bjhIi4zAqcN9w8Tjon+7JrLrPTJO7nBd+vSEy75d7zXahsD+cBNDqz1XMpkxWfuAfKjdIHH5qV/4kXF9VVaJtDWQsvXdKPVAALlY3VIYPlH2XnSJxmn/8RAFOxIwq+v2vLhgHWPv9JnBmN1D394RD4te9w==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(53546011)(82310400005)(36860700001)(47076005)(110136005)(478600001)(54906003)(83380400001)(336012)(16576012)(2616005)(26005)(2906002)(16526019)(426003)(4744005)(86362001)(70206006)(41300700001)(7406005)(7416002)(36756003)(4326008)(8676002)(356005)(5660300002)(31696002)(82740400003)(7636003)(40480700001)(70586007)(40460700003)(316002)(8936002)(186003)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 00:22:07.6251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a687684-f882-4d4d-1cd3-08db79c9346a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5850
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

On 6/30/23 03:07, Ryan Roberts wrote:
...
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index bce28cca73a1..73fbeb8f979f 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -7246,7 +7246,12 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>>   				pte = (pte_t *)pmd_alloc(mm, pud, addr);
>>   		}
>>   	}
>> -	BUG_ON(pte && pte_present(ptep_get(pte)) && !pte_huge(ptep_get(pte)));
>> +
>> +	if (pte) {
>> +		pte_t pteval = ptep_get(pte);
> 
> Given the PTL is not held here, I think this should technically be
> ptep_get_lockless()?
> 

Oh yes. I'll change it to that and send a v2, thanks!


thanks,
-- 
John Hubbard
NVIDIA

