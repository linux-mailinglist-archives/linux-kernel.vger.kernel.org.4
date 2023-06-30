Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E8D743286
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 04:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjF3CHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 22:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjF3CHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 22:07:21 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9685B3C15
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 19:07:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUbAigwp/Zk1d/XaJOCZR5yEllX0kAqFhYNanWaVtJ5KU3wMjq22nKvtXBvSu/HOQpfJC94n8UpjhJOOJh0TTtFWIEQHJq6n/NmK87zMCdralC6w026eKfdwQiyLVJF3dUpElsv9h2LaT9RrHsqtIFefEVpobTFn4mf52whjWJJrBcnR7BSvyzMC4dYxh3Z74LB2EcFpG8NG8KLz2mG8tpHJqbI7opEt3GnuKqoauJhQoSK48TD11QfwalNYsjNXYU9jgaVQ5yWHJ/00ZR1Qq20j6sMie4RZF9+/bSqKGRU57mxxS182PPoMsa/ON9/hPl06bgzs2Q+kZng475hJ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZkx6qWxbKJsVlnfQIBnHdnI5XBEfNyrD+6bZbNIENU=;
 b=mL/xli4FwWdhiRNSz4/zOlhjivGfhDzx76qv1ttTnJ/kAGo5l1hLk47amyJnnBwYsgohCzb/XicFbizeoWmC3qf6G/WPUwCNb7qvmJd5wf+L1YTp3S73Q6UZqsbWlSJu+DOMvykJ5HEpVAYdNFlxWe9x6w84GkjlSQv7/xskgzWeTJnUfO5Zl4k3iafA5SrmcqQLJJr371a1fkS/j/dmZOAxqFT4pVzHHZRj/4QVlsMp8W0oIBxFBw5bJGri+6A11P/aD1w3GHGB3rJS+HonVGacYA21vrFYT4ubFlAu1TENc0UL97obhE5eZz4BGhajcR1HG99zENcafBd/DDzRzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZkx6qWxbKJsVlnfQIBnHdnI5XBEfNyrD+6bZbNIENU=;
 b=ZXl/QfCOe9d9fnTMKg29dnbalvPLrtK+kDoruYWWSlO2tjgw7asFEmnO85f5XZbxphqSRVmogsCB0tS8SGfkcelMucYCruXw5V16/mlXZuzcSPCoiumo9uq0DoZjqfD6+eXoX3iOftqj6MGMMfKSZfaSxxhcFOKqbG3SfK2YTgDvR/HMRh4dGkg/dHHanEVXV/2xHsXMRO/q9Xz1zIlao6pzgZ/A/z3H5u7InMJ0cWz2p+gjUjtwg59kk6xcXZIDFAfiTrckGg3nm8QfJLViE7vQLADOXTGw121qgRXo3LcxJAvgUVtiIS+8VVhi41KwNPok6XQfjcrJvWy5mkO0BQ==
Received: from DM6PR08CA0019.namprd08.prod.outlook.com (2603:10b6:5:80::32) by
 CH3PR12MB8283.namprd12.prod.outlook.com (2603:10b6:610:12a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 30 Jun
 2023 02:07:06 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::72) by DM6PR08CA0019.outlook.office365.com
 (2603:10b6:5:80::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 02:07:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.49 via Frontend Transport; Fri, 30 Jun 2023 02:07:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 29 Jun 2023
 19:06:52 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 29 Jun
 2023 19:06:52 -0700
Message-ID: <4de7fead-d0b8-8916-026d-79f37a559cde@nvidia.com>
Date:   Thu, 29 Jun 2023 19:06:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mm/hugetlb.c: fix a bug within a BUG(): inconsistent pte
 comparison
Content-Language: en-US
To:     James Houghton <jthoughton@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
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
        "Ryan Roberts" <ryan.roberts@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Yu Zhao <yuzhao@google.com>
References: <20230630013203.1955064-1-jhubbard@nvidia.com>
 <CADrL8HUwxLU-UvTLbzp-JM5EqQ2u-91UU4VfAhRrPiu7i3Jhkg@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CADrL8HUwxLU-UvTLbzp-JM5EqQ2u-91UU4VfAhRrPiu7i3Jhkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT030:EE_|CH3PR12MB8283:EE_
X-MS-Office365-Filtering-Correlation-Id: bc7e1432-a386-4369-6643-08db790eb44d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: liKbjnjr1EwoCJ8Uv350Qn41TE417Q1LtDPS36HmysnP9pNrf3Xdl5s0u6Y/Kf7D1ApmUtxgzlh8Wx4h1NFiLFWZi2xL00QyzgKCmStHJe58El6bU+0w9z1GN1K3Hutpnns1KxSVCYhqJ0MidNZuWhR7nCYO55W2g8zIkY2z6UZz9ONQH4oGarjo/6IoilasHbj7QKvAh6aFm13xulJXcRhwV2OoPZIOwTsqsMwdWPFbaUph4g4xz2K5OLPfBZVsAuJIXkg1RD6G+9fl//MvVadVmrsVCLsgq9A28xja5ZCNXLO9OeHv5Yi0MP2Lbn+HwaszEZenGs//PZhVPVYenPtzZ7z69VxKdaCvEjtzrWkwfvwOVBsXgXDKpsPM+NeQ+Z18FwCE3R6uQazArOFqEFQASGhF24PZoU6d9sP7bk2/7/j0a7zgRvVrn7RNeyWDmbbgFl2iHj+h1f4kjoHvaxqt5+291NtTs05zH42KTgJt71eu0Ks1w9WCELfZtyi2L0TAttGyUEhuyFPbI/QFYfjNaEM/3804jevAQqOK2VBEffEGsaQ3ZwTxiLZEGPXRTV1s3eS9ClJzd30uh3zVSgezxl3QWLiHZbudba622EErKqHIKJ5loqQ77LnEX5ETRWKxgEQMIERVwQuzeLWnQelJMYNEeiJ9YYdmOhDG/CIonEO6zG0v1s3mjPywyB6l1JF7ejEPG5H3fSFeNIA949pk9pXpFL1Dprzwm77Hufn9ZtbqGt49ktpidtkzUYdfzMqnQ85E8P2OWHpQ1s92aw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(36756003)(4326008)(70206006)(16576012)(54906003)(70586007)(478600001)(6916009)(186003)(26005)(82310400005)(40480700001)(4744005)(41300700001)(2906002)(8936002)(8676002)(53546011)(16526019)(5660300002)(7406005)(7416002)(7636003)(356005)(40460700003)(316002)(82740400003)(426003)(31686004)(86362001)(2616005)(31696002)(36860700001)(47076005)(336012)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 02:07:06.2969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7e1432-a386-4369-6643-08db790eb44d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8283
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

On 6/29/23 18:50, James Houghton wrote:
> Hi John,
> 
> Good catch, and thanks for the detailed explanation. It looks like
> riscv and powerpc have equivalent problems in their huge_pte_alloc
> implementations, perhaps it's worth taking a look at those. (riscv
> looks like it has precisely the same problem except it's a WARN, but
> powerpc looks more interesting.)
> 
> Either way,
> 
> Acked-by: James Houghton <jthoughton@google.com>

Thanks for the ack, and yes, riscv and powerpc do look like the
same problem to me, too. I'm glad you thought to look there, as
I have fallen into tunnel vision while investigating this, heh.

OK, as long as I'm here, let me fix those up, too. I'll make those
a separate patch, because they are still in the "fragile" state,
rather than actually at the full crash state. :)


thanks,
-- 
John Hubbard
NVIDIA

