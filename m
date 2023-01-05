Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F4F65E5B5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 07:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjAEGto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 01:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjAEGtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 01:49:41 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD35817597
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 22:49:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7Y6CCsNnRWn8UFRvo7J+0LkWrXiKGIOUwwPuGuFMp1UP0HQ3+RsVUUj6T6xOnF3MCAHnb5ObP1SbFTnB6wNa68FEZfGQ9vAPhXTGAfCN2f/eJ5yhyXj7pHJouTBIkYiLQePKzIUh6bsTAE/Vfg3UafI8re7mHxqrJeHbdP8lP4RCPjEwG+ZX1dL41aHbX5fQrCf0iMlWMPZp87QxfWSx2FVtGcJOFbhLsMtu4uToc9U8Gpe6J6cTd0apF3SoZkOGBURpU17q6u2Kr0ToA8FbHgHyYpuxDWwSx6kxH9CojNXhVUnzzRGasHdJFPHwwpRIpgtteSFL3XRWfk+ZSSjSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCLo3uLA/3WSxYBgWy1IAedDDYh4JoXaOfKBsO2HSNo=;
 b=CG1OOIGrTVNML6umUB0zd4S/xbH4jjsgdf1d5tEt2oxLXPu3jr1KwL2z+/8i3gAPgv9JF1+0FvK0RqKoZoxN3ZXtFQ2Zy6L7zxtYpFDsm4PEdl947nC89qxeQylcz/Fdodxil3DvhDGQoQ3uFaO22Riami8HsejpsPX+VRSlntPfXI2sysBIbNt4seelDLlo5ZoBeI2fVP6K4Bwsx0eyAUUZsrAK2qD2ZLRSX09M4nrRQdko+5n+MFJXchiIVMrA6YsmAoXOcEvmVwFqW5pgGAS/wTrR//GNao0bxKKLJUGKQlIsNxPt97o6SM00Qb79lx/z27ksKH7Ifb8HkhCsHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCLo3uLA/3WSxYBgWy1IAedDDYh4JoXaOfKBsO2HSNo=;
 b=PEyjNKykBpnVL9YLFwLLKu/wOfPfF8e5pAC03f75SrIb8hg97FsJEWuiv/yMQu6TZR/q0TCdkBKU5aDC6A7ZX8cbXuR2wxq7Poi/35ltatrMYCUfZmSX7e6ijDTHwxIg1tRU9pKQlLwkNwLAsQOJcjkH7134aX36/ZYA72vln8yK+oPTPf7U1VjO/wYlw/Sk5GHAyR42KrO9wacObewKa3ElKMSgWkEFiSqKGTQ9R0xlbBHF7pl1/RpJudapv5Un28J57SBcRfpXo6ffDzWRIMFYpDyBesAiz0Rn0m/xiFXZw1fW/Zm5AhxIE04CJVeCu5Qg9Lf/PDwSsiRbmxkTnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by SA1PR12MB5640.namprd12.prod.outlook.com (2603:10b6:806:238::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 06:49:38 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ecfb:a3ad:3efa:9df8]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ecfb:a3ad:3efa:9df8%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 06:49:37 +0000
References: <20221227002859.27740-1-ying.huang@intel.com>
 <20221227002859.27740-3-ying.huang@intel.com> <87pmbttxmj.fsf@nvidia.com>
 <87pmbtedfp.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
Subject: Re: [PATCH 2/8] migrate_pages: separate hugetlb folios migration
Date:   Thu, 05 Jan 2023 17:43:05 +1100
In-reply-to: <87pmbtedfp.fsf@yhuang6-desk2.ccr.corp.intel.com>
Message-ID: <877cy1scg5.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0046.ausprd01.prod.outlook.com
 (2603:10c6:10:4::34) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|SA1PR12MB5640:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe5c4a4-af0f-4963-707d-08daeee902d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EcWwRCwLfrKeaHz5N7bgfK9RDXWS4wok672/1IwVj+DuWbXLfZnLTw4wQjIxiIteU6jyMXPM9DAT2mogtLsfPyTc8psoJEgBvO24jvVDnOnn86vHTWgkzi93tCidOjcppXqFdc024y1OSWWniAOuSPCviG9brdszkTDJXdA1okItOD4efjUGNM0yS0ogXPHTPeTkmnCgSRJqHxHh9yHmIvC3xJUBufgeuGoFoglmptth6QO+dvP6cMxmY8Er6sBuo+YizKhFsj6VWid/aKqQWDCf0TpX131ldw5RYpbBliH1CKJagUsH25S9llw9NVTUC0Kj2YrPxkUYlfOmv3XsWNqFHSDmufacyCJjtgLt8L7y7wGIpnO7qgb1+JxWZSWz3qrkzSRUanbxg0/x4RO/oI8PuYf4R8YoTrpHI5Mz7d0/HQ89jMlfbV7pWTpYoTzWaxW4di2hPOqp9Hx9jZhjLvC2XmmrUxXE9B2YbE7Iie8+d9QkdnQwWSnSi9d+e8bRn9YUMawPbMWwN4Cc0cgvYNaL8iDplGgsnfOR+8U1uQoU1jiBsrCahPqTYA9XMkZqgia8cNRG26U73qnchoushj8HdXIffeMUDoaka/jmOgTUWfNMC3X4Tg6BNUTEt7bKGieFtOJ3GJFGoUReQ4Rxvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199015)(83380400001)(5660300002)(2906002)(86362001)(41300700001)(8936002)(7416002)(66476007)(4326008)(6506007)(186003)(316002)(2616005)(6512007)(8676002)(6666004)(26005)(478600001)(66556008)(54906003)(6916009)(66946007)(6486002)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iRVf09ndjh/BUdmbckg2zcLRKt2JbSPhB39K81u1digj/9ZiGUqYtcQvmONu?=
 =?us-ascii?Q?2mxZIz3tgziRsDRzGI6T0ERdjrB5HmAyD+ZyNs0bdHRnRN3H6tIK3+5x4gO+?=
 =?us-ascii?Q?8mSDXXOfGl6OteNnTmrFStosy0w2gzr7PojlDItvEgv8ALLYHYx/PSzHso4s?=
 =?us-ascii?Q?iJdthaeTsrcqaztofRztdLd5A1H7eF/T07F4ZNrF7SFAMmtFkslUAxkdnApV?=
 =?us-ascii?Q?mLSPbMMpKVGh1zDJ/K5H/eHB5U8GNjPrL79ked5xjIF9nTZgmOBzfMYy6XFK?=
 =?us-ascii?Q?HTp4n0fqJwoNxH84H9URQZbQOmyDMd6bbNA9mn2bCaSW9+fUje1SI6NgwZ6U?=
 =?us-ascii?Q?zhmBfNPMvAZI9//S5HCeaXM/MbtBTwGIMbmosF3+YtKKWGk0sDNBKNl6J5jL?=
 =?us-ascii?Q?X17YGWrhhGiJciO4G/QD5kEiYsGN+NVpGloVqPc8CvY32hogqesf/rI2MRBs?=
 =?us-ascii?Q?POJThZYuZg4TLuiJXGbXIQhX0SKAtXrCpQXW5Et0euQbBVfo7zIiIA+eD7Ft?=
 =?us-ascii?Q?9/9ZxKj3AD7eVIv7Ci2JWa6mkv5yukUx4iAwh3vj1D5a40gKQLSf0lOfNFXD?=
 =?us-ascii?Q?msl03GPHbpQno1zE0RWgCOCi3W7qlWtwuD7jNpJFcO10VV4EJHpJ9aBuFPyY?=
 =?us-ascii?Q?TYT79d638ksdR2smDl72aTdLCGQyBvRVZNf6P8IvBdwWfY9Ocx1src8EQjY/?=
 =?us-ascii?Q?HokzKafstAmMjEILbkmstfSpeg2Rv6mUnV6UVZBsGSOpgQs4r4Rui+VDfhXA?=
 =?us-ascii?Q?JPrLRCn4UkYhAzCUGDGW/cB9dbHDD8jdsFK/WevQDnl3fioC2ONiEwiEefnq?=
 =?us-ascii?Q?G17OrtGCgBx/LXL9SNldaDC/PZjRam9StrEHfHxG7EMkqF9p9uJ8cpwB2Etj?=
 =?us-ascii?Q?AFdIR0SV/wFmoTizAysXcSjelLIFg+TjEmQw45eqq4Qb0Euw8NoD/6EJfKLM?=
 =?us-ascii?Q?iTSEJOar0Q2oyzZotLlvgtbEzqdzuacGjPIX7ExT4ikCUA50MmuuANpcs4V9?=
 =?us-ascii?Q?Wltc42MQ+hDTlcYHWdTO+qiM/ERUq4zOOCAeC5mnuom8LR/lLv6KA7Bm94qi?=
 =?us-ascii?Q?QRbvjIdtNOuLXanf0HEysCI02lvAL/RJxIBMvcUcYFUL+TGhuAgWhs4WXx4E?=
 =?us-ascii?Q?ifkenkuGLAi9A5FNHXyrnd0AlkKvCl9GzsWj2/JP9FUEs79RfLdmfQqtqRRZ?=
 =?us-ascii?Q?y6tEZO8Nmd1CnTjrV3Y3CW8R5BA4y0IJ4oqlfp4of5sukBjiWqsVA5mFraz7?=
 =?us-ascii?Q?9lM4ploutjIpZLYIo5e5LJWt4kNj39PvcPumaEUzVK1IXSBXZejm8NwbGSyo?=
 =?us-ascii?Q?QEmNLzvc4NR7tM5tkvWOKUhLlP5pI/U7cq2JivxA5sQhW4ZKeetc5Xjx+Efq?=
 =?us-ascii?Q?1otbn70uUTun2G44zRgORqZhbptE/AbaPoA1UoxSGnI13A/tj8PBtqHphDHY?=
 =?us-ascii?Q?JAEkV55Wz1ppf62Ls8redAWyT/iPgwT1IrZYvMV8X76LSNg6vnTLwEbcoyHz?=
 =?us-ascii?Q?pldBY+DGyNE+LQYY22I3rI4iif1ctyow5lWPgzPE6bKEVkow6E3uxuOh1Nv/?=
 =?us-ascii?Q?BwA5MKhVsZDkBHUAvmvj36cZYPSXoYSYi51n+mo7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe5c4a4-af0f-4963-707d-08daeee902d6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 06:49:37.0151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PDuMHmhmriRJGlBo4RVC6y1S/l9MWMqPHmdELGsVxaRbfI6E+3QFfDROebw8dCNI1WwZgFQm7pUXF3BaG9CFFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5640
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
>>> This is a preparation patch to batch the folio unmapping and moving
>>> for the non-hugetlb folios.  Based on that we can batch the TLB
>>> shootdown during the folio migration and make it possible to use some
>>> hardware accelerator for the folio copying.
>>>
>>> In this patch the hugetlb folios and non-hugetlb folios migration is
>>> separated in migrate_pages() to make it easy to change the non-hugetlb
>>> folios migration implementation.
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
>>>  mm/migrate.c | 114 ++++++++++++++++++++++++++++++++++++++++++++-------
>>>  1 file changed, 99 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index ec9263a33d38..bdbe73fe2eb7 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -1404,6 +1404,87 @@ struct migrate_pages_stats {
>>>  	int nr_thp_split;
>>>  };
>>>  
>>> +static int migrate_hugetlbs(struct list_head *from, new_page_t get_new_page,
>>> +			    free_page_t put_new_page, unsigned long private,
>>> +			    enum migrate_mode mode, int reason,
>>> +			    struct migrate_pages_stats *stats,
>>> +			    struct list_head *ret_folios)
>>> +{
>>> +	int retry = 1;
>>> +	int nr_failed = 0;
>>> +	int nr_retry_pages = 0;
>>> +	int pass = 0;
>>> +	struct folio *folio, *folio2;
>>> +	int rc = 0, nr_pages;
>>> +
>>> +	for (pass = 0; pass < 10 && retry; pass++) {
>>> +		retry = 0;
>>> +		nr_retry_pages = 0;
>>> +
>>> +		list_for_each_entry_safe(folio, folio2, from, lru) {
>>> +			if (!folio_test_hugetlb(folio))
>>> +				continue;
>>> +
>>> +			nr_pages = folio_nr_pages(folio);
>>> +
>>> +			cond_resched();
>>> +
>>> +			rc = unmap_and_move_huge_page(get_new_page,
>>> +						      put_new_page, private,
>>> +						      &folio->page, pass > 2, mode,
>>> +						      reason, ret_folios);
>>> +			/*
>>> +			 * The rules are:
>>> +			 *	Success: hugetlb folio will be put back
>>> +			 *	-EAGAIN: stay on the from list
>>> +			 *	-ENOMEM: stay on the from list
>>> +			 *	-ENOSYS: stay on the from list
>>> +			 *	Other errno: put on ret_folios list
>>> +			 */
>>> +			switch(rc) {
>>> +			case -ENOSYS:
>>> +				/* Hugetlb migration is unsupported */
>>> +				nr_failed++;
>>> +				stats->nr_failed_pages += nr_pages;
>>> +				list_move_tail(&folio->lru, ret_folios);
>>> +				break;
>>> +			case -ENOMEM:
>>> +				/*
>>> +				 * When memory is low, don't bother to try to migrate
>>> +				 * other folios, just exit.
>>> +				 */
>>> +				nr_failed++;
>>
>> This currently isn't relevant for -ENOMEM and I think it would be
>> clearer if it was dropped.
>
> OK.
>
>>> +				stats->nr_failed_pages += nr_pages;
>>
>> Makes sense not to continue migration with low memory, but shouldn't we
>> add the remaining unmigrated hugetlb folios to stats->nr_failed_pages as
>> well? Ie. don't we still have to continue the iteration to to find and
>> account for these?
>
> I think nr_failed_pages only counts tried pages.  IIUC, it's the
> original behavior and behavior for non-hugetlb pages too.

Hmm, I agree it seems this is the original behavior but that behaviour
seems arbitrary and wrong IMHO. The page failed to migrate, therefore it
should count as such. The fact we didn't even try seems irrelevant.

Indeed it looks like this was introduced because it was confusing to see
no failures even though migrate_pages() was called - see dfef2ef4027b
("mm, migrate: increment fail count on ENOMEM").

But that seems inconsistent - why count this one folio as failed because
of the allocation failure while other folios which would also likely
cause allocation failures don't get counted? Fixing it is probably
outside the scope of this series so I won't insist, but it would be nice
as it could still lead to confusion in some scenarios.

[...]

>>> @@ -1462,30 +1549,28 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>  		nr_retry_pages = 0;
>>>  
>>>  		list_for_each_entry_safe(folio, folio2, from, lru) {
>>> +			if (folio_test_hugetlb(folio)) {
>>
>> How do we hit this case? Shouldn't migrate_hugetlbs() have already moved
>> any hugetlb folios off the from list?
>
> Retried hugetlb folios will be kept in from list.

Couldn't migrate_hugetlbs() remove the failing retried pages from the
list on the final pass? That seems cleaner to me.

>>> +				list_move_tail(&folio->lru, &ret_folios);
>>> +				continue;
>>> +			}
>>> +
>>>  			/*
>>>  			 * Large folio statistics is based on the source large
>>>  			 * folio. Capture required information that might get
>>>  			 * lost during migration.
>>>  			 */
>>> -			is_large = folio_test_large(folio) && !folio_test_hugetlb(folio);
>>> +			is_large = folio_test_large(folio);
>>>  			is_thp = is_large && folio_test_pmd_mappable(folio);
>>>  			nr_pages = folio_nr_pages(folio);
>>> +
>>>  			cond_resched();
>>>  
>>> -			if (folio_test_hugetlb(folio))
>>> -				rc = unmap_and_move_huge_page(get_new_page,
>>> -						put_new_page, private,
>>> -						&folio->page, pass > 2, mode,
>>> -						reason,
>>> -						&ret_folios);
>>> -			else
>>> -				rc = unmap_and_move(get_new_page, put_new_page,
>>> -						private, folio, pass > 2, mode,
>>> -						reason, &ret_folios);
>>> +			rc = unmap_and_move(get_new_page, put_new_page,
>>> +					    private, folio, pass > 2, mode,
>>> +					    reason, &ret_folios);
>>>  			/*
>>>  			 * The rules are:
>>> -			 *	Success: non hugetlb folio will be freed, hugetlb
>>> -			 *		 folio will be put back
>>> +			 *	Success: folio will be freed
>>>  			 *	-EAGAIN: stay on the from list
>>>  			 *	-ENOMEM: stay on the from list
>>>  			 *	-ENOSYS: stay on the from list
>>> @@ -1512,7 +1597,6 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>  						stats.nr_thp_split += is_thp;
>>>  						break;
>>>  					}
>>> -				/* Hugetlb migration is unsupported */
>>>  				} else if (!no_split_folio_counting) {
>>>  					nr_failed++;
>>>  				}
>
> Best Regards,
> Huang, Ying

