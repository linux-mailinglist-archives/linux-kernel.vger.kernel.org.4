Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8904C65E5B6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 07:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjAEGxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 01:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjAEGxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 01:53:50 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32EF48839
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 22:53:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4V9jiIJG2mSIiIAF1M878ztXh3djy5FB5b1JKVfza1hhMMrLlhLkFp1ZwWFY/5TjT/105azVT/4/1ddBfB8QdccnFZAxtFdP+JwM/oCnIU344sOF6Uo0g/8HtbEEa/HoEjybyAEqwZXGph6ixf7mCInpZ7fUN4ulpLcRF/AMOaSxA+K3T9D2d0xENJkBvLpHP3FKmkWYdUVVpOv2i8Hh8Pa8bIZejc1vEYgo4l6gthckkBsQSFp5wGJ16G9gUmdXBpsrpIO0OZyd8bwXWbQt1HRDtmREIwN7aJlEOe+kcYEEFxco+b7nBQpCgRZU+9sAA/wtcoXTEjODQ+9jdwwGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12pN60cFNCOYoUD5O6NItWAn8z1fc/cUYhZM83WJS2M=;
 b=kn6Rd/c0oLDyZFHJz1+efOkGJ5Ru7PVCBNICQAvQKmdGrjrjkzBMmbuw5splBvdmFIPMkG5vQfiH+TuKce/t/ombx0wWCYmcEpBF9F69rlydqelSrZXvziOapinAlMBhg0/adBLio1fGRX8lptMYswYPZ5BK+7Hqq9eoUYF/3hP+Bv+ecMDxJElqT/kbyeDDyAGwSnMUh8LJxPasZiKA1DAknCHzlsNapCnEdsjZGqm5FMZiRjTFNTkRu58xdApjirFM70H3Tl5GH+PFdvMi96cQDbh310SSK9FM+KhNjUsA5Lnehs67AhnEv5BysctNtj4EvCwePC6VV15TRLKmQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12pN60cFNCOYoUD5O6NItWAn8z1fc/cUYhZM83WJS2M=;
 b=QB0PrBiQF5ICRWJJdNZThX3nAv448bMoBjI9JA11VDu62AOOLISKxv6HNMsu6Ik1fF5GW4uBE59l25xW+gomf2HsW6//uw3ivqWp9bmGWYJUrX4TTfncPw/3kgsalbmD8HDJsRQyYZZm2pE1U/8Fesu1t7tDcufGPAoBK4rhYa4oaBHvslVhYRNcKsi+/mGtOErip2SizHobTHYUacUndas5ao8O5x2o/hdMGSTE85mXqZsZjKKruoMj1QCfEL9XU3JDZtbzXCj5nPkBUkfo0u8f1+a5N8LCRLhltYNNxCfglHiQCPsZlEIiiJXOs1/cFqsVMtI3FZun3Vshv8Eahw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM4PR12MB6061.namprd12.prod.outlook.com (2603:10b6:8:b3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Thu, 5 Jan 2023 06:53:45 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ecfb:a3ad:3efa:9df8]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ecfb:a3ad:3efa:9df8%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 06:53:45 +0000
References: <20221227002859.27740-1-ying.huang@intel.com>
 <20221227002859.27740-2-ying.huang@intel.com> <87y1qhu0to.fsf@nvidia.com>
 <87lemheddk.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        haoxin <xhao@linux.alibaba.com>
Subject: Re: [PATCH 1/8] migrate_pages: organize stats with struct
 migrate_pages_stats
Date:   Thu, 05 Jan 2023 17:50:14 +1100
In-reply-to: <87lemheddk.fsf@yhuang6-desk2.ccr.corp.intel.com>
Message-ID: <87358psc99.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0153.ausprd01.prod.outlook.com
 (2603:10c6:10:1ba::11) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|DM4PR12MB6061:EE_
X-MS-Office365-Filtering-Correlation-Id: f4097dd5-1c64-4ada-744d-08daeee996de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rq23BTvmbT1pqItDmTs2C5QIuay2G/GcGfLbmQCWGtHEeI8SQX9/mbRNi9Xwy4lT79gxUIDSmQyGO4B3b9+ZKwG+pok2RYUQ/+5JkGVBRQtPNHNKgW9mQ1bJbgOT2JB03z+6g8WiIS7SNroxvvOsx6WqGJ8ROM7NIlpU78PRLr4aA1b0TdEG8dqlOKmnKJ2bhRamZX3CO/I6JLSknAhXD4JFqawzt5nIYDgL5BgyuEh+3BxirCHDia4iUyUQp6QPu6gYRLV89cSMjDSLRBdwanaDvgGxETsiTJZE05fzSKJhXprbHAZmCarNAU0qPatxtqOhn1HmCOB7KHlc+YZMlYFC6MCBzpiqpebDSx/pFtvsPYIUCPXMB4b4+2tXupI6ueOCJ2ohnt8gFAjhwHj7uiCF9foIXQUtQ0bOV4XnWkTxHS/t3b7qq2gvxsgf7ngv/S/uc6cMG+DTLcwhDCwA8iLxLPSY0giQ1WbDRAggV81F3fnG3IirkOVFuAgzJPhJ8e1/p6Dq++IDoMJ+G1bKZerbW+4OWZpeGfE+vvo8Ywy+1nVLFmNHGlzfgKDIBSRXWoHRvwd93i03fLcoZlENeogVhj+g9TRMLqg9xqXTe625CbKwzvWUF/8Qxg1v8k2QHzGeVs6plxGSDLxwH4A9vQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199015)(5660300002)(8676002)(316002)(66476007)(66556008)(6666004)(66946007)(4326008)(41300700001)(8936002)(7416002)(2906002)(6916009)(54906003)(6486002)(478600001)(6506007)(38100700002)(26005)(6512007)(2616005)(186003)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hSop/gJ9XxDKFpYIc2+LkXssb9EeJJnbCzsF6XDdE5yiJ/oGViyLSeiJidL4?=
 =?us-ascii?Q?JB3dMFolUB4czOCzKbdq5QlQij0uPsTEfvlUpKbPfB51px+u9soQ4dq0f3d+?=
 =?us-ascii?Q?rIG8Q26183b04b/IxqEe0x1KrcTIIlRcwtus41OznYx923FbkcCESMbuyBxA?=
 =?us-ascii?Q?DuDLEQ+0v22tYz016MU97CjYfMslkjlETGIhugqhwSCL6cF2C+DEt/eEZdRp?=
 =?us-ascii?Q?5fXLDpp1GSf8bdJ0EYCk4PsEsbZrP1C7d3KNpjc/7UxDJYVyCGAtLiWDWPRe?=
 =?us-ascii?Q?NIT5NheB5WzoQ8yEqSc+qZLIWOH4tgnH4ZDRT3VAWBjcOGG3iwLr1xAsHHcU?=
 =?us-ascii?Q?zdYhxDNmbGKV2SZjUVdGrNVGUo0QRCjegiWMINRmGTnCGOks8iXgue3leNAe?=
 =?us-ascii?Q?k8D9YbvDeN4pu91oyY9bMhVisriMpwl9e6wx75QIB4bWORxGzJ9bUgKKuBIq?=
 =?us-ascii?Q?DotdNzhPP2UiMgxx3DwcSHnFu+vQmnrbP23lsv2j8LYcLtAgE9uJwQzAuwsh?=
 =?us-ascii?Q?mdlITzu1pAopWNxn8FqszyB1EeEdRLwR/A6ysjXksHtOJt67K+lU6muNgotH?=
 =?us-ascii?Q?OQXnjmB2bZVmpcWSRMGFJyDbjfG+SYSLLAGOUjhXMGS5WXcDunOECjPnvjip?=
 =?us-ascii?Q?yMetpABcX/PVR3wqjb7Tn3mRTNYF3DkVRWfQceyTDxwNHhwpLdX+ipaBrGMY?=
 =?us-ascii?Q?OeXqMnTOrkebaRaBqtBdVOOkZ3ZZMnHlrRCo28k+ARhqjdQsJ4vr2scK0oPS?=
 =?us-ascii?Q?XlWsbQNTz2BmwZMRDHZ1D/ir6oZPvH4LduYB+giM7MbXd4n9fEjHJQC3aZGJ?=
 =?us-ascii?Q?p71tLAlABNghRsO/paYJMDQsKG1BGhWbSkpAKcAnoyz0kxYoT7QdTaSXCGdH?=
 =?us-ascii?Q?DaGoQBMjsAd+Ngi5vvs+UWegz83KaNiEvK+oJbQj8H4oiAEKLHj5E8rJyPyT?=
 =?us-ascii?Q?dwVQJQq6qUdLC1Bz/t61MOE8+U4VUrd1VvmgwZizpg52OQ1MR91eYqznrOoF?=
 =?us-ascii?Q?6gfkjRXvcKvbJiWjYswQN1xjmxCRaghA3gsdfhS997pgv81+4u2jDQaAIJCQ?=
 =?us-ascii?Q?rDkGsYbC8RV6KMv3VYY7A4BoRA3lGN5XLSXOaXOhawb17H0eMKvc8bN5B4Im?=
 =?us-ascii?Q?oEt+0Z6jZTBdgFq1XpDiuMNFTL04tf81mz6XcCmAcIj/SXjRMz8T6yU9j+eL?=
 =?us-ascii?Q?546MJnBjLr2Vw3mZecqmhAr3TP89IlsFWyIGrbn9Y8jP2rGZTF/r3oq3tltg?=
 =?us-ascii?Q?GX6X9AezAX9ef8ZYJojRf0ya2ntXaARmzpBe74o7QIyXu1VJ+uN4qEMwFIUL?=
 =?us-ascii?Q?XHzLhssyR3EG/2NPi8QLcwxna2LW0vfwA7Ju63PxjYmPo44XxMPDUeenMpdq?=
 =?us-ascii?Q?Ta7gd22iLH/JhxLg+BLF73PY3oWrttyDOLaIWtpzeSuhQNM9pzZ3s8BcAWzN?=
 =?us-ascii?Q?n2qcvvpbA2W7UVQ8gijRDqhELg/gtoirQ05PpCZPrbEvNI/EE+AuC+FzufNZ?=
 =?us-ascii?Q?KL1Ldca8l8hcFFuWnXAyQmCz/5nW0GW/IeIpcpLc0/hZl6aP6kyor7oRzuXz?=
 =?us-ascii?Q?Y9ANjyhwYEmvVY7aWkGJIFvnuH/P5regRYWUoC1b?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4097dd5-1c64-4ada-744d-08daeee996de
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 06:53:45.3704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQg3wXR1fx/WMt1dF+lR1mDo6apWzYZrcuWn4YRME0z1d3k44/+SpmqIHzZShGDtZiy1uCq1vveZk3gB5pworg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6061
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


"Huang, Ying" <ying.huang@intel.com> writes:

> Alistair Popple <apopple@nvidia.com> writes:
>
>> Huang Ying <ying.huang@intel.com> writes:
>>
>>> Define struct migrate_pages_stats to organize the various statistics
>>> in migrate_pages().  This makes it easier to collect and consume the
>>> statistics in multiple functions.  This will be needed in the
>>> following patches in the series.
>>>
>>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>>> Cc: Zi Yan <ziy@nvidia.com>
>>> Cc: Yang Shi <shy828301@gmail.com>
>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> Cc: Oscar Salvador <osalvador@suse.de>
>>> Cc: Matthew Wilcox <willy@infradead.org>
>>> Cc: Bharata B Rao <bharata@amd.com>
>>> Cc: Alistair Popple <apopple@nvidia.com>
>>> Cc: haoxin <xhao@linux.alibaba.com>
>>> ---
>>>  mm/migrate.c | 58 +++++++++++++++++++++++++++++-----------------------
>>>  1 file changed, 32 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index a4d3fc65085f..ec9263a33d38 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -1396,6 +1396,14 @@ static inline int try_split_folio(struct folio *folio, struct list_head *split_f
>>>  	return rc;
>>>  }
>>>  
>>> +struct migrate_pages_stats {
>>> +	int nr_succeeded;
>>> +	int nr_failed_pages;
>>> +	int nr_thp_succeeded;
>>> +	int nr_thp_failed;
>>> +	int nr_thp_split;
>>
>> I think some brief comments in the code for what each stat is tracking
>> and their relationship to each other would be helpful (ie. does
>> nr_succeeded include thp subpages, etc). Or at least a reference to
>> where this is documented (ie. page_migration.rst) as I recall there has
>> been some confusion in the past that has lead to bugs.
>
> OK, will do that in the next version.

You should add that nr_failed_pages doesn't count failures of migrations
that weren't attempted because eg. allocation failure as that was a
surprising detail to me at least. Unless of course you decide to fix
that :-)

>> Otherwise the patch looks good so:
>>
>> Reviewed-by: Alistair Popple <apopple@nvidia.com>
>
> Thanks!
>
> Best Regards,
> Huang, Ying
>
>>> +};
>>> +
>>>  /*
>>>   * migrate_pages - migrate the folios specified in a list, to the free folios
>>>   *		   supplied as the target for the page migration
>>> @@ -1430,13 +1438,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>  	int large_retry = 1;
>>>  	int thp_retry = 1;
>>>  	int nr_failed = 0;
>>> -	int nr_failed_pages = 0;
>>>  	int nr_retry_pages = 0;
>>> -	int nr_succeeded = 0;
>>> -	int nr_thp_succeeded = 0;
>>>  	int nr_large_failed = 0;
>>> -	int nr_thp_failed = 0;
>>> -	int nr_thp_split = 0;
>>>  	int pass = 0;
>>>  	bool is_large = false;
>>>  	bool is_thp = false;
>>> @@ -1446,9 +1449,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>  	LIST_HEAD(split_folios);
>>>  	bool nosplit = (reason == MR_NUMA_MISPLACED);
>>>  	bool no_split_folio_counting = false;
>>> +	struct migrate_pages_stats stats;
>>>  
>>>  	trace_mm_migrate_pages_start(mode, reason);
>>>  
>>> +	memset(&stats, 0, sizeof(stats));
>>>  split_folio_migration:
>>>  	for (pass = 0; pass < 10 && (retry || large_retry); pass++) {
>>>  		retry = 0;
>>> @@ -1502,9 +1507,9 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>  				/* Large folio migration is unsupported */
>>>  				if (is_large) {
>>>  					nr_large_failed++;
>>> -					nr_thp_failed += is_thp;
>>> +					stats.nr_thp_failed += is_thp;
>>>  					if (!try_split_folio(folio, &split_folios)) {
>>> -						nr_thp_split += is_thp;
>>> +						stats.nr_thp_split += is_thp;
>>>  						break;
>>>  					}
>>>  				/* Hugetlb migration is unsupported */
>>> @@ -1512,7 +1517,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>  					nr_failed++;
>>>  				}
>>>  
>>> -				nr_failed_pages += nr_pages;
>>> +				stats.nr_failed_pages += nr_pages;
>>>  				list_move_tail(&folio->lru, &ret_folios);
>>>  				break;
>>>  			case -ENOMEM:
>>> @@ -1522,13 +1527,13 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>  				 */
>>>  				if (is_large) {
>>>  					nr_large_failed++;
>>> -					nr_thp_failed += is_thp;
>>> +					stats.nr_thp_failed += is_thp;
>>>  					/* Large folio NUMA faulting doesn't split to retry. */
>>>  					if (!nosplit) {
>>>  						int ret = try_split_folio(folio, &split_folios);
>>>  
>>>  						if (!ret) {
>>> -							nr_thp_split += is_thp;
>>> +							stats.nr_thp_split += is_thp;
>>>  							break;
>>>  						} else if (reason == MR_LONGTERM_PIN &&
>>>  							   ret == -EAGAIN) {
>>> @@ -1546,7 +1551,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>  					nr_failed++;
>>>  				}
>>>  
>>> -				nr_failed_pages += nr_pages + nr_retry_pages;
>>> +				stats.nr_failed_pages += nr_pages + nr_retry_pages;
>>>  				/*
>>>  				 * There might be some split folios of fail-to-migrate large
>>>  				 * folios left in split_folios list. Move them back to migration
>>> @@ -1556,7 +1561,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>  				list_splice_init(&split_folios, from);
>>>  				/* nr_failed isn't updated for not used */
>>>  				nr_large_failed += large_retry;
>>> -				nr_thp_failed += thp_retry;
>>> +				stats.nr_thp_failed += thp_retry;
>>>  				goto out;
>>>  			case -EAGAIN:
>>>  				if (is_large) {
>>> @@ -1568,8 +1573,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>  				nr_retry_pages += nr_pages;
>>>  				break;
>>>  			case MIGRATEPAGE_SUCCESS:
>>> -				nr_succeeded += nr_pages;
>>> -				nr_thp_succeeded += is_thp;
>>> +				stats.nr_succeeded += nr_pages;
>>> +				stats.nr_thp_succeeded += is_thp;
>>>  				break;
>>>  			default:
>>>  				/*
>>> @@ -1580,20 +1585,20 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>  				 */
>>>  				if (is_large) {
>>>  					nr_large_failed++;
>>> -					nr_thp_failed += is_thp;
>>> +					stats.nr_thp_failed += is_thp;
>>>  				} else if (!no_split_folio_counting) {
>>>  					nr_failed++;
>>>  				}
>>>  
>>> -				nr_failed_pages += nr_pages;
>>> +				stats.nr_failed_pages += nr_pages;
>>>  				break;
>>>  			}
>>>  		}
>>>  	}
>>>  	nr_failed += retry;
>>>  	nr_large_failed += large_retry;
>>> -	nr_thp_failed += thp_retry;
>>> -	nr_failed_pages += nr_retry_pages;
>>> +	stats.nr_thp_failed += thp_retry;
>>> +	stats.nr_failed_pages += nr_retry_pages;
>>>  	/*
>>>  	 * Try to migrate split folios of fail-to-migrate large folios, no
>>>  	 * nr_failed counting in this round, since all split folios of a
>>> @@ -1626,16 +1631,17 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>  	if (list_empty(from))
>>>  		rc = 0;
>>>  
>>> -	count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
>>> -	count_vm_events(PGMIGRATE_FAIL, nr_failed_pages);
>>> -	count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
>>> -	count_vm_events(THP_MIGRATION_FAIL, nr_thp_failed);
>>> -	count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
>>> -	trace_mm_migrate_pages(nr_succeeded, nr_failed_pages, nr_thp_succeeded,
>>> -			       nr_thp_failed, nr_thp_split, mode, reason);
>>> +	count_vm_events(PGMIGRATE_SUCCESS, stats.nr_succeeded);
>>> +	count_vm_events(PGMIGRATE_FAIL, stats.nr_failed_pages);
>>> +	count_vm_events(THP_MIGRATION_SUCCESS, stats.nr_thp_succeeded);
>>> +	count_vm_events(THP_MIGRATION_FAIL, stats.nr_thp_failed);
>>> +	count_vm_events(THP_MIGRATION_SPLIT, stats.nr_thp_split);
>>> +	trace_mm_migrate_pages(stats.nr_succeeded, stats.nr_failed_pages,
>>> +			       stats.nr_thp_succeeded, stats.nr_thp_failed,
>>> +			       stats.nr_thp_split, mode, reason);
>>>  
>>>  	if (ret_succeeded)
>>> -		*ret_succeeded = nr_succeeded;
>>> +		*ret_succeeded = stats.nr_succeeded;
>>>  
>>>  	return rc;
>>>  }

