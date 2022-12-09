Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF826489F8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 22:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiLIVU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 16:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiLIVU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 16:20:56 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E57876820
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 13:20:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vs3evk+lklvYAevaDhy6Aq8an01luMSQ0610/cirTzOS3iRek3rMki9cAENNTMWJXaowMdG/Hue+cnkgIuTVSg68il7bEBlCwEfSlVxn8sm6nXqF31iVdzjBqVmqWL+pXuJ8f1IepfFzF5vZrZ+B7fdeXn2OmDUMw0OGjfdr0HJSH+cewcEmCucxj04puUslpHcD8kTwYTijkbK5mc1cu6o1PTO+z9yorCaalD/hR3Gro8sZzi7BTPtHbbTWWpd9Ay3r6q48gJA9qmHMxgcECyaARaKCEXRK116uPRb04M2TZkFoD5YQxtTeq3lfmUKVF10jwCQgJ5sFNeUZU+GPrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNnudE9wuWqqwKJrCxtiWSryedXlExOdQGMjt7KLjZM=;
 b=jOKd9R9/oEWsxGK7qYzINTrk+cNVpNAzWfI1pW1axG0+wRZWYEsHSYPwdVnGljZdk1WRlANl5NFYa40rmda1jFDNeVMQD3b/4uZHg+OdVV+pazS+h+uMcDWzYsDPx4KQtufMiatPRzUj6Gtw4R+jPCf3HvZnL5JCTtyUm8PwXH767tIPI2xKLRkb/VLyO1zBh+UIxOHwmu5GOwUpL4k+E/Mrz3A9l4hIc9DjsEEgVVEh67mzHO8CqbFrHaUvA+f3ksg8CDFZkVQOGf9oKlipdE7TBdf+C0IMtUiULWhk+WQo11Vm6quGGDrSWkN/ncizdVN0Wiakt0wkmWJz06jBYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNnudE9wuWqqwKJrCxtiWSryedXlExOdQGMjt7KLjZM=;
 b=LjJhhLQ7A1oJWgL78APwtTmvJu476YKe7mVYUrARmQuaMfrDXwVy/7sjBEFu2vY7tfenpJB29yNPJ+dQQoP+Yg2Wj+A96GXTC61zbOG/MPp6Waytlr6raI8TyVreptRsAMghbA+QRu6ViuW21tdzIG/eBxAa6rTK2Oe5cfZHCjDylzdjk/b+ouKaG6IDQ3Fv4bh2tWbYkeGJKutAg2mjG7nc5zhUwMMwiwwLxQJaNvkMmZA9cMtzVDbwjbB1tHFsGfVQurAeorCqfYuLzf+BQqxvV4ylF/5NWd9FF48OR1vjS8x4flTDY+S6eHPV3vbsTGXxJTYuN7suWPohSc6SEg==
Received: from CY5PR19CA0067.namprd19.prod.outlook.com (2603:10b6:930:69::11)
 by SN7PR12MB7881.namprd12.prod.outlook.com (2603:10b6:806:34a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 21:20:54 +0000
Received: from CY4PEPF0000C969.namprd02.prod.outlook.com
 (2603:10b6:930:69:cafe::e3) by CY5PR19CA0067.outlook.office365.com
 (2603:10b6:930:69::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10 via Frontend
 Transport; Fri, 9 Dec 2022 21:20:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000C969.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.8 via Frontend Transport; Fri, 9 Dec 2022 21:20:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 9 Dec 2022
 13:20:42 -0800
Received: from [10.110.48.28] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 9 Dec 2022
 13:20:42 -0800
Message-ID: <23fa4ffa-965a-da80-e8b5-73ae92dc5767@nvidia.com>
Date:   Fri, 9 Dec 2022 13:20:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH mm-unstable] mm: clarify folio_set_compound_order() zero
 support
Content-Language: en-US
From:   John Hubbard <jhubbard@nvidia.com>
To:     Muchun Song <muchun.song@linux.dev>
CC:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>, <tsahu@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
References: <20221207223731.32784-1-sidhartha.kumar@oracle.com>
 <92965844-c430-8b8e-d9f1-705d7578bceb@nvidia.com>
 <ec8f46ca-9ea6-4567-2038-22f6d3000ed5@oracle.com>
 <d17530ad-8e12-8069-d619-a2d72fe80e15@nvidia.com>
 <0187f9c2-e80a-9cde-68bc-c9bdbd96b6fe@oracle.com>
 <Y5I78soNmAFv7pi8@casper.infradead.org> <Y5JCi3h8bUzLf3cu@monkey>
 <2723541a-79aa-c6b5-d82c-53db76b78145@oracle.com>
 <e86ca90f-e59e-3851-7225-b5f596ad04b9@nvidia.com>
 <36ddac45-ecd0-e2d2-e974-8c85ca503053@oracle.com>
 <20cc2088-b66e-28d1-a529-414e82146336@nvidia.com>
 <434a111c-7f1a-0018-6bd2-561cb382deea@oracle.com>
 <7d72778e-7305-18e9-edf4-ed55a98aa7e2@nvidia.com>
 <00222280-DBDD-49A3-92A5-05112359AE30@linux.dev>
 <f4909342-eaca-8c55-ad95-359ab7a5e6db@nvidia.com>
In-Reply-To: <f4909342-eaca-8c55-ad95-359ab7a5e6db@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C969:EE_|SN7PR12MB7881:EE_
X-MS-Office365-Filtering-Correlation-Id: b51cd755-bb49-4cb0-97dd-08dada2b4137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3NCvYVk/Xuvs9GdXgnRhy/YLT6gRoSLAFV8dE6kuUMcY3jcxNGTWP8tmrlfNe6ScGD1am3rsWC3sMjX5wq1pMV6r3aRb5Ddh2DcIxI6dVoJ4F04Jsc+a/ExHF1+NbrrdQS9mpuG5d8vR6FGRevYf9CTkgfX7E6k+ImuPs43E2r0Rd+8mQCityx4bjXCbye5MFtFm/KCh6DS7gnGIFi5fmsAVSEugLAQP8uTyjePVCzbttvkD/oQEVxt9jfp7nFqeaVwVsqe8/XrVYFawMLRCphNc8emGTut3flanrsSrnJBfL6TtJdieRtMxh6M1jYZcVc6EyQuKevXTIyln+D3rS0GDMwNj49bsORXFzh4s7XB63h9Yjv7PCZiVOXLq9/fd6uXAs8MjIEttFOwHPibfFLu2DRdmNy1d+YhUUnSA3bgAygQB0unKZ/D0+6miN8tVQBiTSHnBcHSr0KebJXlwImbPvSEA/5nbEoT9puvlkNHpr89pHM+e9jHZ+EiaNv7biIaOvX15T7LFVxW+WxbL7WOg1BgN4eWt0JzOnJolcXXREiKoD5A8rdKQfQ27qCFzud6fUYyUHm6jCjzfG8ECeiV0xdsjzaOvdK/yOl5zIAAF9y6sLIJa5bUhYaWI8/BRO0wxKajEfL9l2+Z2vG3wskoyEZVwoIRsnPcfaHAWpYQ8qliNP15Igq6OqdUwdeSHNqaD/1vwUZH+AaWtYJ+AMebIDuBC7i7waclJXzDhDus=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199015)(40470700004)(36840700001)(46966006)(7636003)(70206006)(82310400005)(316002)(8676002)(54906003)(70586007)(6916009)(356005)(16576012)(36860700001)(4326008)(26005)(41300700001)(40460700003)(47076005)(31696002)(426003)(86362001)(31686004)(8936002)(7416002)(186003)(53546011)(83380400001)(82740400003)(36756003)(16526019)(2906002)(478600001)(40480700001)(5660300002)(336012)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 21:20:53.7395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b51cd755-bb49-4cb0-97dd-08dada2b4137
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C969.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7881
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/22 13:10, John Hubbard wrote:
> On 12/9/22 06:27, Muchun Song wrote:
>>  From you advise, I think we can remove VM_BUG_ON and handle non-zero
>> order page, something like:
> 
> Yes, and thanks for summarizing all the individual feedback into a
> proposed solution.
> 
> If we go this route, then I'd suggest a little note above the function,
> such as:
> 
> /*
>   * For non-large folios, this will have no effect, other than possibly
>   * generating a warning, if the caller attempts to set a non-zero folio order
>   * for a non-large folio.
>   */
> 
>> static inline void folio_set_order(struct folio *folio,
>>                            unsigned int order)
>> {
>>     if (!folio_test_large(folio)) {
>>         WARN_ON(order);

Although, on second thought...I'm still a little confused about why
keeping the same name is so important?

A very direct approach that has more accurate naming (and therefore no
need for a strange comment explaining the behavior) would be:


static inline void large_folio_set_order(struct folio *folio,
					 unsigned int order)
{
	if (WARN_ON_ONCE(!folio_test_large(folio)))
		return;

	folio->_folio_order = order;
#ifdef CONFIG_64BIT
	folio->_folio_nr_pages = order ? 1U << order : 0;
#endif
}


thanks,
-- 
John Hubbard
NVIDIA
