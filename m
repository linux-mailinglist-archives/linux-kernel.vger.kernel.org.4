Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9176FDA63
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 11:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbjEJJFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 05:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236991AbjEJJF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 05:05:27 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D844499
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 02:05:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYwtAa3eWnLGC9L4qqmbZ/UOG92ghi5PVu+9EExU7K0WeDSmM5sY6jaYa02SHMuSEbD0Z1ItHm42+b6x8t6FXuarpT8104rU0M6qHFaXR+3d7YtMI/D1MRtGhrbYkjg40Gj6/R+xmwy+xRpA3s+gGoLQOUN5/0QN81aiS1zqj0z3Tz6C+edpY4UGe3/x9cwmqcrV0jpdBpgsg6EjOjcGEybUDv4BepWuHlGH8hgPtzf3LxY+QCk0Z6fcIAyFN3kcbs96zR1QRo3i2nvWmDFBPiNi0mT3jqkEMWxfVaDrE4ZRWD2X8ohF52cdrBgoIJgyYZnyyt34AxBIDWee6xDVGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZNYhz6FsvLjaVNdhrTbnPCIQyTkJZP157oJ3QOwYWI=;
 b=UZGGCeFwdXtow7X7TmXuhwRzrbHiWS2KwwGlMDMk+O2PkYu7SXe6W1CgrjKyr1zGVnR/wdUNUTCVcRcR+hqbdADbrIwYNzgdADKpnhMnCC53cOJ6NzAosuVnrH82VbPp753mrNCbpp2xSfb6F1Izwwx931OaWIaTbEU+p7319/3Y77ztB9RpYGUyZrj7Mf6a+ZJ28NrIOB0Wyd21Pt7lpD/SNrFIWKZrKxmnGsWvUk3NqLHSZMnI+RaAWqv+iFuk7x0H6twqgdC7VUI6lH130tjQ5U/PYYomaKWEc3qOMYTn5yat62mgC7WwRXtHjepDWOS/icCxX1OitN93sTs+Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZNYhz6FsvLjaVNdhrTbnPCIQyTkJZP157oJ3QOwYWI=;
 b=YPmaYKgwbr6PmMe0bYb7IS20f22ZVOV8d/7kNNsSjep4yJCAPGmuYf/Nn/XfVifKLDHDM3Y8Dx6htZzEouN/PcHUExjfjC3yBPgQ9iQjybJY9mTL7lAvx4II9DAmxoqPl59LfGSHXdjY/897cC6aqFZc405YCX2klU0BAxSn5MQTEJvQfk210eaBdvSzMBaZgfu/g+1Skd43yf5kCFd0IsEkTzqxrw/+3fcZ9VAKCHeZBfYC7MPrM/ljQMAVtFRETQXDfr03nwnvN4SnJQ2R+7VWMpUjI0d1ZLnmtN5H2eyaDoJhUZcm1wehF4n46BgJKx10quYBfZJDnKvGvXia8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3179.namprd12.prod.outlook.com (2603:10b6:5:183::18)
 by SA3PR12MB8804.namprd12.prod.outlook.com (2603:10b6:806:31f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Wed, 10 May
 2023 09:05:00 +0000
Received: from DM6PR12MB3179.namprd12.prod.outlook.com
 ([fe80::ec36:a1bf:b279:6539]) by DM6PR12MB3179.namprd12.prod.outlook.com
 ([fe80::ec36:a1bf:b279:6539%6]) with mapi id 15.20.6363.022; Wed, 10 May 2023
 09:04:59 +0000
References: <20230510031829.11513-1-ying.huang@intel.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Xin Hao <xhao@linux.alibaba.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH -V2] migrate_pages_batch: simplify retrying and failure
 counting of large folios
Date:   Wed, 10 May 2023 19:04:13 +1000
In-reply-to: <20230510031829.11513-1-ying.huang@intel.com>
Message-ID: <871qjoblqg.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0259.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::24) To DM6PR12MB3179.namprd12.prod.outlook.com
 (2603:10b6:5:183::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3179:EE_|SA3PR12MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: 66bbdedb-c98e-40a8-3c1a-08db5135a1e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bpshKfeo2iRaO+xss665GYEdnCkdOSfCTyLdUQZIzIJhdWf693lTwwsnpEJMvaV91YLxWoyOSa8hfxZztWEcfL+NJI76M8J7dINs8qwuifSkQAlzm01piZI5UwksoxjwIz4Uf1wRWhKUxnwLofVszXT8cinVkm8IZ8dspYW02EHl8o9fWTxY6Y+7dM4UYqQevKaIjJ4VkAfUIVkFe4PMZSS3MAkZyPgtidc9SSHiKOdCg2Lv7AdDS2Yy1W8O4e1ID1f4xXdEAsT6UIM6v/cJKxZnhv6icVQeVcuOzqYwIDopuGBOIjoVTVfqRGEb8kpHzIYPGvX69BDCFGjp3gQcraNpCbM40VO5SfZLK5hlcMItukVpBl46YVLZgQzWfOgmSRz4XzufYycd/TUbRMmmciCbQ575w7AUZHHaJDfRiQZv/fhQb4FqpSmcWhBSoxASIIyGf9/nyYIFfDNy8gNBzh4etXgRax8jUqfHNRyailfZbi1CCVH5FLNu1vM54XcPI7yWPugTuW+TG/ZusV//CEuCQGiGMrugGuEUND9nYbCKVYf6k5/pYBuqmdSlB0ZH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(451199021)(26005)(478600001)(6506007)(6512007)(316002)(41300700001)(66946007)(6916009)(66476007)(4326008)(66556008)(54906003)(83380400001)(38100700002)(6486002)(2616005)(86362001)(8676002)(6666004)(8936002)(2906002)(36756003)(186003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wn0LJ2GteYc1oH2QIk03pHDov0OqVKYZm4Fid23k/2zzhiDVB3izBjGxtWzT?=
 =?us-ascii?Q?auQBqDPOjtawdU98fgaJcLwCVDf0U/D9mp1PzwZwlsDWE9+wh1a37Un2iTFc?=
 =?us-ascii?Q?P2nFmhCPrjqr1Mn9sTcRjDCBd1aeUEpzsuXf8bcP8V1MkvwxFdliiruc2J+U?=
 =?us-ascii?Q?dWgTXPjX/5hoLadDS4T2XKH/3iS56vc4+E6GiOQeIXT7PM7WBW+nJryneEkc?=
 =?us-ascii?Q?SibjGrha0XRTtpdyMqyHqYRtTXHt+bnd2kOB83ufNYkcwHZdaucVqr75lxJt?=
 =?us-ascii?Q?WvfgfYR3LlDxJb1J+xh85Ba+UueqBctCGqfCIHdbICn+0BAeu8N2wex9ZI1J?=
 =?us-ascii?Q?yhTmJCx0iRTlKl1K9ziki1ws7dyuyM0KYAbY4rXc8CDAcL5h9KKQnM6+wdps?=
 =?us-ascii?Q?uxwQgiEIg9lIfHw0JhgXZNhdrmc5XL9W1EEs0eabJnG3Lbep78m+1LuHjc91?=
 =?us-ascii?Q?PUZ6NN9cvVOVc9PhDTinZ+TA420uRaRfTWuD6FnHT/z4UZIEDImHESv60IHL?=
 =?us-ascii?Q?EYfkr6Y2MnkAJA5Byo6KwaV3HUbBBYomjVFFlUO1TPhp6sghAJFZH5kDBrjW?=
 =?us-ascii?Q?y/GG38xUty41ja1bRNaSpEhnfUTvv4wsKIJpE6js6flYCyAg+qK86VLeQId1?=
 =?us-ascii?Q?Kl46XZLJAPAnTC3Qg5opPQvjMvKTqjmg0ulrnZbA66v1TUdf1G3Oow99CvL/?=
 =?us-ascii?Q?90TslBVFrMwSi2LtdpL72wdm29Bid+f+MQHQqteKTzJ+wNYarDS6QNvRXVeh?=
 =?us-ascii?Q?cn4hXqCvk8HPNaAfNdsBHJagpSVFxNHTiiQFrMM5PD9ELhGd93B0tA5w/WZg?=
 =?us-ascii?Q?LaZuW2Gpc9jtgehZxpAa1dpostF47o/sTBjSKA6RbPDvlhdDFvpSWuvDZFKH?=
 =?us-ascii?Q?5L16mTE1Vz5XdSorLz8+ipMe5RAHSr9H4fH2QPvxln13sHGv0UNlJ9E+Obp5?=
 =?us-ascii?Q?jTVnAILhvyWQUpKWxVowvBB/La16e48w4Dvw9/EVdRsItW3VLcodfFPDQNyl?=
 =?us-ascii?Q?Sc9KeGbpoZ0hqZNsQfvX6AK89Dg+UE0y+GKol72l+eTcdPKPW5WdQ7wyL1OM?=
 =?us-ascii?Q?6k9N9sOzo+VBqjv6I8Q+kel6/NfPC9HU3iRe5HTbe0r39HLyUx7UHLeIBeVq?=
 =?us-ascii?Q?WeiP0TNIhSU3Jyi9dDp4BLDimaGfXSuvErmJYDCfKBH9/kyqsnCwqOs5xToM?=
 =?us-ascii?Q?votT92S5CAaERubZTEZJW8SrdXxX4JkBLdrhge4MA4eQZxCkxAvoIix8BTMc?=
 =?us-ascii?Q?IBERiG6yK99lfOHQw/VYjI7nAYXpxtwsxqgFq7H/kNsdHNiIK5o0aU/6iM6d?=
 =?us-ascii?Q?rlN1qEEU+w9GTOuhoFTOVGgewrRqYUHaGpFZnGKuSZJI5Ztu+GTkvaNmGAa0?=
 =?us-ascii?Q?0/XqagK0Ilfvo/TAUyaDKNnJPjHTWmSK47t4n8YkSc1YberwmC/lQl+lCB1U?=
 =?us-ascii?Q?Ky5kaS9ZiSl1p8Ll/bWDI88kxc1gbfPQdNUHceKgiCaAjZjwCU2ZvSxgJQGR?=
 =?us-ascii?Q?1t4TiJ2faCZeX3vgijDnNnzawxwpu0iMlFukgSXQ7HeQj9zSMv6i88qiuP10?=
 =?us-ascii?Q?bzCAyC3iwpZDSROHLFyGz4SZrsUUWrPErNUr2bcH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66bbdedb-c98e-40a8-3c1a-08db5135a1e6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 09:04:59.6252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00fHSdBC+85Po60qRQ8DJ20FWgK1oqAwv/FgNOjLwYopYLEldC9S7whP7GWnY9s3+sKKuJCFo2PdZsMtsj1Q8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8804
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Looks good. Please add my reviewed by from v1 as well:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

Huang Ying <ying.huang@intel.com> writes:

> After recent changes to the retrying and failure counting in
> migrate_pages_batch(), it was found that it's unnecessary to count
> retrying and failure for normal, large, and THP folios separately.
> Because we don't use retrying and failure number of large folios
> directly.  So, in this patch, we simplified retrying and failure
> counting of large folios via counting retrying and failure of normal
> and large folios together.  This results in the reduced line number.
>
> Previously, in migrate_pages_batch we need to track whether the source
> folio is large/THP before splitting.  So is_large is used to cache
> folio_test_large() result.  Now, we don't need that variable any more
> because we don't count retrying and failure of large folios (only
> counting that of THP folios).  So, in this patch, is_large is removed
> to simplify the code.
>
> This is just code cleanup, no functionality changes are expected.
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Xin Hao <xhao@linux.alibaba.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Alistair Popple <apopple@nvidia.com>
> ---
>  mm/migrate.c | 110 ++++++++++++++++-----------------------------------
>  1 file changed, 35 insertions(+), 75 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 01cac26a3127..2ac927a82bbc 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1614,13 +1614,10 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>  		int nr_pass)
>  {
>  	int retry = 1;
> -	int large_retry = 1;
>  	int thp_retry = 1;
>  	int nr_failed = 0;
>  	int nr_retry_pages = 0;
> -	int nr_large_failed = 0;
>  	int pass = 0;
> -	bool is_large = false;
>  	bool is_thp = false;
>  	struct folio *folio, *folio2, *dst = NULL, *dst2;
>  	int rc, rc_saved = 0, nr_pages;
> @@ -1631,20 +1628,13 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>  	VM_WARN_ON_ONCE(mode != MIGRATE_ASYNC &&
>  			!list_empty(from) && !list_is_singular(from));
>  
> -	for (pass = 0; pass < nr_pass && (retry || large_retry); pass++) {
> +	for (pass = 0; pass < nr_pass && retry; pass++) {
>  		retry = 0;
> -		large_retry = 0;
>  		thp_retry = 0;
>  		nr_retry_pages = 0;
>  
>  		list_for_each_entry_safe(folio, folio2, from, lru) {
> -			/*
> -			 * Large folio statistics is based on the source large
> -			 * folio. Capture required information that might get
> -			 * lost during migration.
> -			 */
> -			is_large = folio_test_large(folio);
> -			is_thp = is_large && folio_test_pmd_mappable(folio);
> +			is_thp = folio_test_large(folio) && folio_test_pmd_mappable(folio);
>  			nr_pages = folio_nr_pages(folio);
>  
>  			cond_resched();
> @@ -1660,7 +1650,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>  			 * list is processed.
>  			 */
>  			if (!thp_migration_supported() && is_thp) {
> -				nr_large_failed++;
> +				nr_failed++;
>  				stats->nr_thp_failed++;
>  				if (!try_split_folio(folio, split_folios)) {
>  					stats->nr_thp_split++;
> @@ -1688,38 +1678,33 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>  				 * When memory is low, don't bother to try to migrate
>  				 * other folios, move unmapped folios, then exit.
>  				 */
> -				if (is_large) {
> -					nr_large_failed++;
> -					stats->nr_thp_failed += is_thp;
> -					/* Large folio NUMA faulting doesn't split to retry. */
> -					if (!nosplit) {
> -						int ret = try_split_folio(folio, split_folios);
> +				nr_failed++;
> +				stats->nr_thp_failed += is_thp;
> +				/* Large folio NUMA faulting doesn't split to retry. */
> +				if (folio_test_large(folio) && !nosplit) {
> +					int ret = try_split_folio(folio, split_folios);
>  
> -						if (!ret) {
> -							stats->nr_thp_split += is_thp;
> -							break;
> -						} else if (reason == MR_LONGTERM_PIN &&
> -							   ret == -EAGAIN) {
> -							/*
> -							 * Try again to split large folio to
> -							 * mitigate the failure of longterm pinning.
> -							 */
> -							large_retry++;
> -							thp_retry += is_thp;
> -							nr_retry_pages += nr_pages;
> -							/* Undo duplicated failure counting. */
> -							nr_large_failed--;
> -							stats->nr_thp_failed -= is_thp;
> -							break;
> -						}
> +					if (!ret) {
> +						stats->nr_thp_split += is_thp;
> +						break;
> +					} else if (reason == MR_LONGTERM_PIN &&
> +						   ret == -EAGAIN) {
> +						/*
> +						 * Try again to split large folio to
> +						 * mitigate the failure of longterm pinning.
> +						 */
> +						retry++;
> +						thp_retry += is_thp;
> +						nr_retry_pages += nr_pages;
> +						/* Undo duplicated failure counting. */
> +						nr_failed--;
> +						stats->nr_thp_failed -= is_thp;
> +						break;
>  					}
> -				} else {
> -					nr_failed++;
>  				}
>  
>  				stats->nr_failed_pages += nr_pages + nr_retry_pages;
>  				/* nr_failed isn't updated for not used */
> -				nr_large_failed += large_retry;
>  				stats->nr_thp_failed += thp_retry;
>  				rc_saved = rc;
>  				if (list_empty(&unmap_folios))
> @@ -1727,12 +1712,8 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>  				else
>  					goto move;
>  			case -EAGAIN:
> -				if (is_large) {
> -					large_retry++;
> -					thp_retry += is_thp;
> -				} else {
> -					retry++;
> -				}
> +				retry++;
> +				thp_retry += is_thp;
>  				nr_retry_pages += nr_pages;
>  				break;
>  			case MIGRATEPAGE_SUCCESS:
> @@ -1750,20 +1731,14 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>  				 * removed from migration folio list and not
>  				 * retried in the next outer loop.
>  				 */
> -				if (is_large) {
> -					nr_large_failed++;
> -					stats->nr_thp_failed += is_thp;
> -				} else {
> -					nr_failed++;
> -				}
> -
> +				nr_failed++;
> +				stats->nr_thp_failed += is_thp;
>  				stats->nr_failed_pages += nr_pages;
>  				break;
>  			}
>  		}
>  	}
>  	nr_failed += retry;
> -	nr_large_failed += large_retry;
>  	stats->nr_thp_failed += thp_retry;
>  	stats->nr_failed_pages += nr_retry_pages;
>  move:
> @@ -1771,17 +1746,15 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>  	try_to_unmap_flush();
>  
>  	retry = 1;
> -	for (pass = 0; pass < nr_pass && (retry || large_retry); pass++) {
> +	for (pass = 0; pass < nr_pass && retry; pass++) {
>  		retry = 0;
> -		large_retry = 0;
>  		thp_retry = 0;
>  		nr_retry_pages = 0;
>  
>  		dst = list_first_entry(&dst_folios, struct folio, lru);
>  		dst2 = list_next_entry(dst, lru);
>  		list_for_each_entry_safe(folio, folio2, &unmap_folios, lru) {
> -			is_large = folio_test_large(folio);
> -			is_thp = is_large && folio_test_pmd_mappable(folio);
> +			is_thp = folio_test_large(folio) && folio_test_pmd_mappable(folio);
>  			nr_pages = folio_nr_pages(folio);
>  
>  			cond_resched();
> @@ -1797,12 +1770,8 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>  			 */
>  			switch(rc) {
>  			case -EAGAIN:
> -				if (is_large) {
> -					large_retry++;
> -					thp_retry += is_thp;
> -				} else {
> -					retry++;
> -				}
> +				retry++;
> +				thp_retry += is_thp;
>  				nr_retry_pages += nr_pages;
>  				break;
>  			case MIGRATEPAGE_SUCCESS:
> @@ -1810,13 +1779,8 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>  				stats->nr_thp_succeeded += is_thp;
>  				break;
>  			default:
> -				if (is_large) {
> -					nr_large_failed++;
> -					stats->nr_thp_failed += is_thp;
> -				} else {
> -					nr_failed++;
> -				}
> -
> +				nr_failed++;
> +				stats->nr_thp_failed += is_thp;
>  				stats->nr_failed_pages += nr_pages;
>  				break;
>  			}
> @@ -1825,14 +1789,10 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>  		}
>  	}
>  	nr_failed += retry;
> -	nr_large_failed += large_retry;
>  	stats->nr_thp_failed += thp_retry;
>  	stats->nr_failed_pages += nr_retry_pages;
>  
> -	if (rc_saved)
> -		rc = rc_saved;
> -	else
> -		rc = nr_failed + nr_large_failed;
> +	rc = rc_saved ? : nr_failed;
>  out:
>  	/* Cleanup remaining folios */
>  	dst = list_first_entry(&dst_folios, struct folio, lru);

