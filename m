Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94A56478B2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 23:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiLHWPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 17:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiLHWO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 17:14:57 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87090DF20
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 14:14:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5o/2ebltraFpPYxQU6bTdxEOR9nQF+NsNlwRPrutwPWS9Wveci79the4qcJ7LQCD+8w85DcSEdpbNLHsn2WR9KCXWt77EhA016X/G2N+XkU7eQK+m/kNxvZ5VkrKZp+cKpesK8mXW59eFWEcDGlHqybBL1dleP2rTACmg35mRCcYgoE1qS096b9Y2mtHJijP8YaB0wTS23yCxuIlJYaIIDMLKgCbViQ2urIgkecfkuw2wi61utmy1ypldjqAtB5aA7lQdoK/fF7eXDL9diecZv4R2E26IRLQYrY78gG/f/MAYOYKCpobkqU2BkyVTp7aJoYk34xrhVXJcgJxrxs9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psf4uNW6ODi+Ra5KQ2zddpsm88Lmp53hoG74POQ9mec=;
 b=NsZc96pNF47cpPEmHwSEGbT7X5Zkt72yNuuIux779KMLw4o5D0cpplmt+gXi5IZqzR4WkDdh6X8Fj44/FWfde6HY3RYcBZJ2HPcD/Bi/YTwcm4z1x88vfgFmjgSEhVRJVzshz7EGtADO8CxyubBW2Y3n7P3fLvvbnHyNXv2FKZuW/S/Mq2PdusD7BiKB55H0wXsulA90/v9HJLVsPwCFfw84lSUVAYfCT/JFxna9LvL+CpF06jIEe+z2wA1ncfigndSXvxgregWP8HS4PhhufcEn/s73rYbiiWjRMf0+6Jd+ddTk5rJ1W4cQq9/A1LeGPNC9eSgCEhdjkpA0x/09qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psf4uNW6ODi+Ra5KQ2zddpsm88Lmp53hoG74POQ9mec=;
 b=RMS8DeWDtTpdqLjF6Na0B/gwAv6w1CZMEc1eNNflyeKaC7Ul76zgZAPAczguj1tyv4SZTekcEkzlI3tw6A1lwM+c5ZfhvtLUyFF9Kx2aCqHBHyYVFe8UQ9wApHbutvloi2UjnTMdTJhE9EefBZ2B1up3UnjkUa7o8rAMeO3EHIxZTzpNtjFcNA8BxkCX5Rjrsf3uBue3gCWJATlc6xlUNIFFDla3F3o2C+V8A2ji+Jgo3g9oYIFxDLYbRXL+uqSr7X/Rjs8NULCHuIWqz6QzCsVeIgJB8rs6Th1Ycqp7rW0Fgomr4xQl6mxCXJlDKBSK+lYcew+xqacpk5zuA2y7Tg==
Received: from DM6PR03CA0089.namprd03.prod.outlook.com (2603:10b6:5:333::22)
 by IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 22:14:54 +0000
Received: from DM6NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::1) by DM6PR03CA0089.outlook.office365.com
 (2603:10b6:5:333::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16 via Frontend
 Transport; Thu, 8 Dec 2022 22:14:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT075.mail.protection.outlook.com (10.13.173.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.17 via Frontend Transport; Thu, 8 Dec 2022 22:14:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 8 Dec 2022
 14:14:44 -0800
Received: from [10.110.48.28] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 8 Dec 2022
 14:14:43 -0800
Message-ID: <20cc2088-b66e-28d1-a529-414e82146336@nvidia.com>
Date:   Thu, 8 Dec 2022 14:14:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH mm-unstable] mm: clarify folio_set_compound_order() zero
 support
Content-Language: en-US
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>, <songmuchun@bytedance.com>,
        <tsahu@linux.ibm.com>, <david@redhat.com>
References: <20221207223731.32784-1-sidhartha.kumar@oracle.com>
 <92965844-c430-8b8e-d9f1-705d7578bceb@nvidia.com>
 <ec8f46ca-9ea6-4567-2038-22f6d3000ed5@oracle.com>
 <d17530ad-8e12-8069-d619-a2d72fe80e15@nvidia.com>
 <0187f9c2-e80a-9cde-68bc-c9bdbd96b6fe@oracle.com>
 <Y5I78soNmAFv7pi8@casper.infradead.org> <Y5JCi3h8bUzLf3cu@monkey>
 <2723541a-79aa-c6b5-d82c-53db76b78145@oracle.com>
 <e86ca90f-e59e-3851-7225-b5f596ad04b9@nvidia.com>
 <36ddac45-ecd0-e2d2-e974-8c85ca503053@oracle.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <36ddac45-ecd0-e2d2-e974-8c85ca503053@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT075:EE_|IA0PR12MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: dae7b43d-8844-40a8-f289-08dad969a285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M2sypDj+wls1aZrVWiHC1Hpbtgw6GEMNfoyShF7jsqL63iUuau5uflFczc84LIWhsrSLdoVL0Qy1pVmnqAUyZ5Lo+J7O+bLpv9qSZHPVTkHtT7IeqDVLW4tstP3btHdi8kURY0huGgHo43dqAUdFcB+D+LIBOBDcIdmXe1b++We44cqqyy5W63SE9No/ug8zPR1RNpXEB5eSSuwQUUWewXHNJgg06ZxDYlrq0ncFU3CRe49gN1BefJQithsbu5lphcPGxQf6Z65LAz2ZC6d6Hs6aTfhDOB9yo8vazQIVQo26UJhBGroriH4XdS374jL/J/ooMFndkEbsc2XXDb24gfA+WMs0YWvhAawRplYER+YGeCWjdV444hPDvauJnjriBbTpZBXF61tk6oK6J0xojW1hzqFdP1kEURPNMKoelFH6EQ2/y1a2uQ/BQHOvMncG67hcFQ1A10hpzpdGlrx02lGL9V+IwNtPDg9GzWDo9aEH5Aw2YapueVqcZxPK94ERtlbIY8pLM4UoQhvW9zz071iX2KVxnNh/G9CI3lRLSCvVCowoWw/SgSfJf8UZHPB8Z5gAoZ/0LJfHagTfzqkTLsCpMMjTrFhUNZb2yw6XBZSWV2qj0tFjKe2+8TNDGCh1E7xOZpEdCISIS+0QgklCs0QSUYoHSJ33upfX1I6zThpppS2ilZaBq40b0NaO7idOEr5xarRDNFTzcZw1vlO0KdXMn5zOq0y+yZybEPwA2PI=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199015)(46966006)(40470700004)(36840700001)(41300700001)(16526019)(5660300002)(336012)(426003)(478600001)(8936002)(47076005)(186003)(40460700003)(36756003)(7636003)(26005)(82310400005)(16576012)(316002)(110136005)(83380400001)(36860700001)(82740400003)(40480700001)(54906003)(356005)(31696002)(86362001)(70586007)(70206006)(53546011)(2616005)(2906002)(31686004)(4326008)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 22:14:54.6421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dae7b43d-8844-40a8-f289-08dad969a285
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8376
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/22 14:12, Sidhartha Kumar wrote:
> On 12/8/22 2:01 PM, John Hubbard wrote:
>> On 12/8/22 13:58, Sidhartha Kumar wrote:
>>> Thanks John, Mike, Matthew, and Muchun for the feedback.
>>>
>>> To summarize this discussion and outline the next version of this patch, the changes I'll make include:
>>>
>>> 1) change the name of folio_set_compound_order() to folio_set_order()
>>> 2) change the placement of this function from mm.h to mm/internal.h
>>> 3) folio_set_order() will set both _folio_order and _folio_nr_pages and handle the zero order case correctly.
>>> 4) remove the comment about hugetlb's specific use for zero orders
>>> 5) improve the style of folio_set_order() by removing ifdefs from inside the function to doing
>>>
>>> #ifdef CONFIG_64BIT
>>>   static inline void folio_set_order(struct folio *folio,
>>>                   unsigned int order)
>>>   {
>>>       VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>>
>> Sounds good, except for this part: why is a function named
>> folio_set_order() BUG-ing on a non-large folio? The naming
>> is still wrong, perhaps?
>>
> 
> This is because the _folio_nr_pages and _folio_order fields are part of the first tail page in the folio. folio_test_large returns if the folio is larger than one page which would be required for setting the fields.

OK, but then as I said, the name is wrong. One can either:

a) handle the non-large case, or

b) rename the function to indicate that it only works on large folios.


thanks,
-- 
John Hubbard
NVIDIA
