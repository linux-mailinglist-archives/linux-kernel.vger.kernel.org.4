Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC485C043D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiIUQd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbiIUQdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:33:41 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D940F9F1BE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:15:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rdt5HQowzRvRfGJEGmqb3qNjnsQpZgrZ5MQ80768hiJ0G9uIj2Z9lxybCFMy6K7hxsla82TPvTCQ504RiRK05dmlx8R4FBo/I5XCzQRAeqYkynxpdQoMpuUrLhMAqTJEXiwdZSZHXoRH65qQ6dLBfz8jp1vsC1hx3phe5axa45CnPmeYMfIC/qJmqpO1hgORJ/44xx5u5mBbIxDev0ngTRHz65u/fVerEkr4BNkM4Yu8n42Dq2R8iO4+YC2FzW3A8LunpYytq059ZvUpzFmvMOwkT08EYvQw9OVbVYYo+eM+/7KdNVHJaZV40hKf05CZW1Lalr6kZWNBS6/ZXGtMeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tv8/ZkJR8dUP2mQ7mGEYkwInBN7jCZMKacYVNsC1MAQ=;
 b=gwQEN2t96ySIAaVBybnA023mG5ZKaayWSTfJihfFkx2ESyDC9AEHmy4S7F2DAyKbouIIDdwfBx8HoA7BWvHO0Pqb0Ej9g/iIEmjwylYK6pgIV14rVMZ/Q011nFePYOLdD52+KM3v25aD9mjWAT5Qu9Wv5Higs7Jaj19/W+K6pl590ylzNXniaM1SQglaoZ3ZbzMNrv1SmKEOCUdZZI51RJhb82CC/Xy1JyR8FDCQJQxlfKxJrvW/sb37iotlO+yqfDU7kUVU3QPsM4+uwGnY4yvFFlvMN2ZVvhYVbcoFad1Wzcre+uh2nNJoO7ncsBIivx3te39VKtEfD7IqLpFLxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tv8/ZkJR8dUP2mQ7mGEYkwInBN7jCZMKacYVNsC1MAQ=;
 b=Vb5i9jpX+ZPuUObQC+brhMGsdHcFK/mkMvYb/PgaC0YhujC9jvYsX5AY4yanUknEzIMXPVlgvxpd50rQm7VjFUx3zfJ4GmbS58cSzkeoH6zFSFOnAnfNXV15WBX1IHGCZUeEenrLzsx0ket83cPj+5e3DfGqSCu3vaTgI7ZOZj+5KQvo9ZAqHlOycGYRnLDmVbHBmpDh/iBApEw8vS2LRr8KSZjvM0fm4/2xYLYaIC5N+XY5HBtFoQyc/HeAbwgo+8m+pwUPpwWouSuURxSTVscISb7/WdoWMkPnlhFzDuUx+/jzw+waZufF9IuaYIQxSLTrjMhHcWb25m/9DS547g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Wed, 21 Sep
 2022 16:15:23 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::94df:bc2b:6294:8cc6]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::94df:bc2b:6294:8cc6%6]) with mapi id 15.20.5612.022; Wed, 21 Sep 2022
 16:15:22 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 3/6] mm/migrate_pages: restrict number of pages to migrate
 in batch
Date:   Wed, 21 Sep 2022 12:15:20 -0400
X-Mailer: MailMate (1.14r5916)
Message-ID: <7E60DC05-0BA0-4761-A431-95A5D0E3B27B@nvidia.com>
In-Reply-To: <46D92605-FED0-4473-9CBD-C3CB7DD46655@nvidia.com>
References: <20220921060616.73086-1-ying.huang@intel.com>
 <20220921060616.73086-4-ying.huang@intel.com>
 <46D92605-FED0-4473-9CBD-C3CB7DD46655@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_402F0F89-FD62-4C8C-9AA1-998CE1644208_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:208:256::19) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|IA1PR12MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c19ce85-1183-4486-0e6a-08da9bec7c59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dLy10Gd4a3Lun6QL1segfexMSAJLojE5oGxUPz6160Y10MhUcj3fRokGpnWLjYlLA8jioHcRUPUnk5EOJbGT8KIRdlYXN50Jm1PXB18uBHw8oYtHi9/Mrwz8o02X2MLMfhPxbSy7iljc88LmZa+lOuXn9xlDRfqwGHotRQHXlElN7uY4eidFEsYOKXXtPhGO5v+8KukxPQljVccEi22xMwPFd/BwkXV7nRXKiuSu9WJBnW9Wk2FM8VbnF3koQjuhFyGt630uwfGjho03dRBGBsozUKTEWNJnHus1D+Jny066cbOmS/rvSwCNWq/v6cJMDfAFqF++EyACKUWWJQwVrE1VOiGCweapU43lqzkr0H7mXt5MaajoKuMhk2uSzRJ8JRpuclJ7viQXwwl4rzqg2ZIz+KLLD+XNbhiw4qah+NZJAmQXHaCzprKZ/fonlOajQrnMgBFWuO4QJo90tE3EpievTBMFJv34C0qtzxljK+sK0aazyFyDqbenh1o+E563wLYKOKEJI+xQkYmAHfu6fyiOVU692p8ElpIQ+ylb36O30DXYbCM4iZkW7tXffy0NqvdMRv6UDkcuiSdewHlPOBYH5z6LWKPLM02OHz0b4orI8SwPqCS3BRIPkFsGm+jypWIg1yKSSvtopDvG5jLoGIv24CJvbRHFAolPjTNMr4b8GWk04RA5RjAtpVcoOQxmDy8jjsSQFrlde9aYxobD9olFhoF7iOO7XSX81j9c2elRKctu1JD5dcPFJ9iY94i8rnt9LHdcBIM7IDqSPvVGuTjhH4ZwuR9YqywonpWCuE4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199015)(53546011)(6506007)(86362001)(4326008)(26005)(8936002)(66476007)(54906003)(66556008)(6486002)(478600001)(36756003)(6916009)(33656002)(186003)(66946007)(8676002)(2616005)(2906002)(5660300002)(6512007)(316002)(235185007)(38100700002)(83380400001)(41300700001)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U3F2haP1YIpds/0JNVTBc41O+nVwaP6yo7zxT/LGa4lnghunP6Ted1HSz6jH?=
 =?us-ascii?Q?nZGQ3HeFclPQLRNu6DqNGrBHeUgBdGOphbSRbOSU4l2bP8Hbwz8vP+3rN1X9?=
 =?us-ascii?Q?7o/9Tdxj3290x4jUOQLSNJqYu4FKvOWu55qRpvGh8gwtGrU8P0Af/Bi09EbD?=
 =?us-ascii?Q?bIwrm+cNZ33Ik7aPF6zz8y0sTKPbQOCB5x114CoLYxlYsPtPSfh+qxNXOPkR?=
 =?us-ascii?Q?1aRQBMRxj3TVbWWmnDW2ihM1CVzzTFWkFeuMNpCdGLthjQYypSkSqG4AUi8/?=
 =?us-ascii?Q?zQlHE2z4l2RiF9RB19VOiUH+PmOhSPI8ZAwlKi4iiyHo3nuMBhst6SiNA4Oy?=
 =?us-ascii?Q?n6n0x6lf6Xeyabsu+VfossuHjipAN4V3bcjKp54vqPGQK7RLWsyDMvGIM44X?=
 =?us-ascii?Q?B4n5vu2mUw10YYrK7Z5AUhO7sv4G7EAGyiQU8NtbuI+aiCU7AUnZD/C2djAH?=
 =?us-ascii?Q?2AfUfrci+nn4WYbcKTNA9IwVu/CRE6xaHkSB69w1u0cc2wSShpsvJK5jS+JA?=
 =?us-ascii?Q?x8jxOWr19OAVV3SPcoC66t/TKToX5m5abWz2GFZQYF+MYgLvXcUS6Li135D6?=
 =?us-ascii?Q?EHAEbvXUfNn8am4bCihYMM8OMXLloTSnmCq4A+CyeqsNoIXWZBaMN+J5rijZ?=
 =?us-ascii?Q?UNShHjycZuF+0TwMJkrJ+rBY+GA5Z/L+qIK9taINvZEZaRn0Fa+DislJJgJJ?=
 =?us-ascii?Q?EVrc9QDJhdQFNacKEeysQ6aXzSYy2vBhIvpPSeylPNJkMmavs840+/PE5Ukv?=
 =?us-ascii?Q?0LcMWUsmJ9ZQyzM74wc3DBrMphz2yD2lQ1VvoI8fxGD+xSa40NAVd/VPHdoj?=
 =?us-ascii?Q?7KnW5fXYcNDeZzNo54jBlOJaQDbIpwWJCveaotZwDKjiJOKuGhVJXOoPgky7?=
 =?us-ascii?Q?lJzE7T66bR29PjOc4o07iiINP8h17LIXIruXQsJTzzQfB9uIqy0VrkYQqQx6?=
 =?us-ascii?Q?py/vP9BWRSgbzMbjicLLK6UJHG7xzrr5wMiHAWc5QtWepc+53sflFyCYjMA8?=
 =?us-ascii?Q?5RPNtpwkTj78nPPF0Au/vJu+kdUxjwVTPS3as9FoPXpagKSdMyH72i0zwJ5p?=
 =?us-ascii?Q?i67c4je4SVoRWm2hK78JISsVK442VTgm0rDZntAYkyAYD9SJdxa/keD2Whu1?=
 =?us-ascii?Q?pP54kQ0ExZj4eFpxbIbjWn/4iw5jwJZVhion4Y0weSXMT1UQ2wNLTqJJzxSK?=
 =?us-ascii?Q?jPlIAQyc1hFI7FEfEfemK7+C9k1j4usA1m3iZxMk7zMDVWrf4lJn0T+apUaR?=
 =?us-ascii?Q?1I/SodL7IQZUyDK+PzmkuOpThzBGGZ1N+1MMD3knEOxdFWFocNTiaandW4Y0?=
 =?us-ascii?Q?MyFAi4052q8ArA/8I8WjAmPggxZ1MwnEmqBj1jHrgYYcW4Meu1d4oncWKbT1?=
 =?us-ascii?Q?bkrHdZREgsd4amNXcv8wA+L7h0LB42rgx0CrNRAHpbVDhK66sRcWZ26y8iDT?=
 =?us-ascii?Q?gdO9r6XAkYde9C8ZTLj8yA16Qsoi+j5F0FxtKWEp/e3WZpeZA+bG6NhDSzj6?=
 =?us-ascii?Q?Z45w7jKOkbmQ+H+M0T6BmpxROFkoye9BQJlnSCDGrf3e4kFshLDV476zss5m?=
 =?us-ascii?Q?Kp6oAq10BdtMLgJBzk3U8qP8q03ikVVgd5zwwPBw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c19ce85-1183-4486-0e6a-08da9bec7c59
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 16:15:22.8706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0kUE8Fy2ieBJiwG4J5fX7SpeRmPyQnIowpGCgY+7BQPdFZC6isJzB6uJXi4Wvatm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7541
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_402F0F89-FD62-4C8C-9AA1-998CE1644208_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 21 Sep 2022, at 12:10, Zi Yan wrote:

> On 21 Sep 2022, at 2:06, Huang Ying wrote:
>
>> This is a preparation patch to batch the page unmapping and moving
>> for the normal pages and THP.
>>
>> If we had batched the page unmapping, all pages to be migrated would
>> be unmapped before copying the contents and flags of the pages.  If
>> the number of pages that were passed to migrate_pages() was too large,=

>> too many pages would be unmapped.  Then, the execution of their
>> processes would be stopped for too long time.  For example,
>> migrate_pages() syscall will call migrate_pages() with all pages of a
>> process.  To avoid this possible issue, in this patch, we restrict the=

>> number of pages to be migrated to be no more than HPAGE_PMD_NR.  That
>> is, the influence is at the same level of THP migration.
>>
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Yang Shi <shy828301@gmail.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> ---
>>  mm/migrate.c | 93 +++++++++++++++++++++++++++++++++++++--------------=
-
>>  1 file changed, 67 insertions(+), 26 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 4a81e0bfdbcd..1077af858e36 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1439,32 +1439,7 @@ static inline int try_split_thp(struct page *pa=
ge, struct list_head *split_pages
>>  	return rc;
>>  }
>>
>> -/*
>> - * migrate_pages - migrate the pages specified in a list, to the free=
 pages
>> - *		   supplied as the target for the page migration
>> - *
>> - * @from:		The list of pages to be migrated.
>> - * @get_new_page:	The function used to allocate free pages to be used=

>> - *			as the target of the page migration.
>> - * @put_new_page:	The function used to free target pages if migration=

>> - *			fails, or NULL if no special handling is necessary.
>> - * @private:		Private data to be passed on to get_new_page()
>> - * @mode:		The migration mode that specifies the constraints for
>> - *			page migration, if any.
>> - * @reason:		The reason for page migration.
>> - * @ret_succeeded:	Set to the number of normal pages migrated success=
fully if
>> - *			the caller passes a non-NULL pointer.
>> - *
>> - * The function returns after 10 attempts or if no pages are movable =
any more
>> - * because the list has become empty or no retryable pages exist any =
more.
>> - * It is caller's responsibility to call putback_movable_pages() to r=
eturn pages
>> - * to the LRU or free list only if ret !=3D 0.
>> - *
>> - * Returns the number of {normal page, THP, hugetlb} that were not mi=
grated, or
>> - * an error code. The number of THP splits will be considered as the =
number of
>> - * non-migrated THP, no matter how many subpages of the THP are migra=
ted successfully.
>> - */
>> -int migrate_pages(struct list_head *from, new_page_t get_new_page,
>> +static int migrate_pages_batch(struct list_head *from, new_page_t get=
_new_page,
>>  		free_page_t put_new_page, unsigned long private,
>>  		enum migrate_mode mode, int reason, unsigned int *ret_succeeded)

We are not batching hugetlb page migration, right? migrate_pages_batch() =
should
not include the hugetlb page migration code. migrate_pages() should look =
like:

migrate_pages()
{
        migrate hugetlb pages if they exist;
        migrate_pages_batch();
}

>>  {
>> @@ -1709,6 +1684,72 @@ int migrate_pages(struct list_head *from, new_p=
age_t get_new_page,
>>  	return rc;
>>  }
>>
>> +/*
>> + * migrate_pages - migrate the pages specified in a list, to the free=
 pages
>> + *		   supplied as the target for the page migration
>> + *
>> + * @from:		The list of pages to be migrated.
>> + * @get_new_page:	The function used to allocate free pages to be used=

>> + *			as the target of the page migration.
>> + * @put_new_page:	The function used to free target pages if migration=

>> + *			fails, or NULL if no special handling is necessary.
>> + * @private:		Private data to be passed on to get_new_page()
>> + * @mode:		The migration mode that specifies the constraints for
>> + *			page migration, if any.
>> + * @reason:		The reason for page migration.
>> + * @ret_succeeded:	Set to the number of normal pages migrated success=
fully if
>> + *			the caller passes a non-NULL pointer.
>> + *
>> + * The function returns after 10 attempts or if no pages are movable =
any more
>> + * because the list has become empty or no retryable pages exist any =
more.
>> + * It is caller's responsibility to call putback_movable_pages() to r=
eturn pages
>> + * to the LRU or free list only if ret !=3D 0.
>> + *
>> + * Returns the number of {normal page, THP, hugetlb} that were not mi=
grated, or
>> + * an error code. The number of THP splits will be considered as the =
number of
>> + * non-migrated THP, no matter how many subpages of the THP are migra=
ted successfully.
>> + */
>> +int migrate_pages(struct list_head *from, new_page_t get_new_page,
>> +		free_page_t put_new_page, unsigned long private,
>> +		enum migrate_mode mode, int reason, unsigned int *pret_succeeded)
>> +{
>> +	int rc, rc_gether =3D 0;
>> +	int ret_succeeded, ret_succeeded_gether =3D 0;
>> +	int nr_pages;
>> +	struct page *page;
>> +	LIST_HEAD(pagelist);
>> +	LIST_HEAD(ret_pages);
>> +
>> +again:
>> +	nr_pages =3D 0;
>> +	list_for_each_entry(page, from, lru) {
>> +		nr_pages +=3D compound_nr(page);
>> +		if (nr_pages > HPAGE_PMD_NR)
>
> It is better to define a new MACRO like NR_MAX_BATCHED_MIGRATION to be
> HPAGE_PMD_NR. It makes code easier to understand and change.
>
>> +			break;
>> +	}
>> +	if (nr_pages > HPAGE_PMD_NR)
>> +		list_cut_before(&pagelist, from, &page->lru);
>> +	else
>> +		list_splice_init(from, &pagelist);
>> +	rc =3D migrate_pages_batch(&pagelist, get_new_page, put_new_page, pr=
ivate,
>> +				 mode, reason, &ret_succeeded);
>> +	ret_succeeded_gether +=3D ret_succeeded;
>> +	list_splice_tail_init(&pagelist, &ret_pages);
>> +	if (rc =3D=3D -ENOMEM) {
>> +		rc_gether =3D rc;
>> +		goto out;
>> +	}
>> +	rc_gether +=3D rc;
>> +	if (!list_empty(from))
>> +		goto again;
>> +out:
>> +	if (pret_succeeded)
>> +		*pret_succeeded =3D ret_succeeded_gether;
>> +	list_splice(&ret_pages, from);
>> +
>> +	return rc_gether;
>> +}
>> +
>>  struct page *alloc_migration_target(struct page *page, unsigned long =
private)
>>  {
>>  	struct folio *folio =3D page_folio(page);
>> -- =

>> 2.35.1
>
>
> --
> Best Regards,
> Yan, Zi


--
Best Regards,
Yan, Zi

--=_MailMate_402F0F89-FD62-4C8C-9AA1-998CE1644208_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmMrOJgPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUY4QQAJZtQrAj5oqsbzIDrEZww/pfiIxf1O6q/YEN
JvrnqScELpG7Yz14s28haEzx6OntajK/tIHKvoypYr9dP3cKULQ8re6+mHZaO1NQ
KWKAytsBTF/38XWuqCLNDOjeaxLqEdMufbKo0YekRMVoC4DUNUaQlnQH9xMRkznm
nbMd6S08qYv8TlLPG+SnXpgmtwMLsNc7oK6A00FwnOzLldcEGqbyWkH0yGlBfLQ3
ZIEzKTXCh4fhuBr+QIHevYrhG4ZjCsgpkR6raBOxAs2IpOnjwEOMkvcIoivPFnEC
jbiA3BE8I7/YQvMgzH5Jqja4UvkLOhiM1j9uo+u/EtrG9WT2pcu+Jkwkm69rXsk6
KekyzVDp25nKOEJrYBIqn1wFNzgZ8f2dlzgEeaE4s6DFeEQRndEl5m+3u5+0B6x/
wCdgtVkavQqGETmQy6SPB0chBYHlQ18fWkxIcVDGUDHJkwHWRH/oynA1mQO5Ztp8
m7DiI9p31fXzJabj+05EM3K83hODjzGCVdeS3qSnFheanD5mxNrclkcU3+yBDPD0
FxKwb5Q7E6OiciZquj28GAcMFi08LlmyAt+O+ieAogy5mLZ+uNc3iwAG4tmSXBNa
7Vb33yn5xzny8Pdkj2w8e6KsTJRA0NHSAVkanIGtu4+bd201wWDg9FwcEohuwV1h
cCfkcRFI
=yB4e
-----END PGP SIGNATURE-----

--=_MailMate_402F0F89-FD62-4C8C-9AA1-998CE1644208_=--
