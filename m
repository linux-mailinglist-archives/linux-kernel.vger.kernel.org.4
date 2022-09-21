Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41F05C0428
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiIUQaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiIUQ3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:29:46 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::60f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16A7B5E4D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:11:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+s3GFQ18MzjWUjxI9TpRSIoDoaOzuhb+1Xn9xrxgnzXL7BWY9DVHPd0jMvoqFpVGyJGmFsngmne87xzCU7Rv7p6sLo1cU4B03qJpzbkTU1fBEDZnJI0U+Dis712vT29dn/HBEfyaHrQAVqCYaxO9NQMLI/8wOZlvHZjVXNa3H/zUAIIfCPpdwxpE5KDaLPUZDlNLJF2rjh884pMSfYPGluoR7SsR4VAMWZFX9OAjr0E89UMFHqqCcUWMBlGpvPVPA9zmNGkbg10ugA196iy1L7dAzIRLKc4bhYxL1zza/X1dlL4BJ2cRcHhgleNwkDWCJXqn2RBI6XTV+VYNrIxdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riSLAkl6rxNHdjeR2CG3Ds6WUJg+c2K2xL6W/ZABtaw=;
 b=c+wmTUfLMteZ4g6OT20d1VA9xo+nAzU0FsxdcABxAVMW1gRN4w1KA5OQ+Tu6nXoPcIUoE2JqG/hn1upOVpb8ndm0ndYlGzenYDYtRyMeZg5U+31W36ZQi56JlIdMJnJiLs2MEmduySJYGoC2/xe7mCldAWm/O8N5pt293lvPvyjqXycYGeu56ydqmWakY31dHNUY4MVOiS2+8CCrrOfld00y3FXTiBHTr2k46vYPdvX7e9AsrlS0FeWsdybFeMBSxr+PZVfgyILeIGkytnsyhX6YaW2bUjCmAogamwIINkv1kUS8GA5LLz/I1MAXmBtGduaZ5grTCO0mG9D89MNTFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riSLAkl6rxNHdjeR2CG3Ds6WUJg+c2K2xL6W/ZABtaw=;
 b=qzzHq3MKCsVgkksmF3TMtoBbAKNG9A2xLuHuxrtI/IgsBwuHEd8kjk++EyKpDoTczmbECEMJwec4ETGS/5SLJqDbGIcNTyA6MpPtn48lTfxS2GW5rQBXCeDJyUEOa+7gUZAj7fjsPSqvHK1omjGCao+q58cAWVQRcfJKgfkh0JRq9gXHtRBFlm2nlpSdVlLRNSDuDzvixdRk0vXdXauIHIMZmRsT8YBuo4S97uHj1seirQTmSpkCcvWyK193BH8pkoomxv9kHn+0zA+Pbg39IGu/TMn+UqK9/AZdAsTG90hrdAKXGACYfYIKDXlJJ+6oHwoz9k83aNIvichxs4kQTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.16; Wed, 21 Sep 2022 16:10:39 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::94df:bc2b:6294:8cc6]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::94df:bc2b:6294:8cc6%6]) with mapi id 15.20.5612.022; Wed, 21 Sep 2022
 16:10:39 +0000
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
Date:   Wed, 21 Sep 2022 12:10:37 -0400
X-Mailer: MailMate (1.14r5916)
Message-ID: <46D92605-FED0-4473-9CBD-C3CB7DD46655@nvidia.com>
In-Reply-To: <20220921060616.73086-4-ying.huang@intel.com>
References: <20220921060616.73086-1-ying.huang@intel.com>
 <20220921060616.73086-4-ying.huang@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_B915BCCE-90FA-437B-8AC6-7F71BE6D2230_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0136.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::21) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DM4PR12MB5248:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f4a83bb-dd07-4665-e261-08da9bebd397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yF5Q9koZOYsVWzAqU0pU43qVGCJ4xFiKiu7QUVa+aHt8RMGA0MCwZ75Jkiut/E3yaXORCtmIPA3uL6mHT1tESWHidDVZULQ7dwU7FrHgp2MWCTw73yP+Y/tvaGl++mr0NmBoUVwt7J9jzwNFyprVY2j0YJd1aFLTzLscn4o6ntxFaaIjLFTZNDFkx+UES/qBvea8X8aXW1XqlShLVtyPKooiTQfDAoPComjDFsF5fhYmYjtTGRcLc0kYRHAnzYJpfTRO5VeFlLTNg4C0J2CYnd0TqgfgzcvWWeEtHgwM+i2FJzraZojg+wU3+OekJGLu7TjSsENWqLgYRyTODJrDdXNjZYq1I7TLWqcaBwqvRupxu6W2nVmkCI7+53vjhji7Ns/yO0MA/9oB5djSeQRWvhEYQkShT1wIIwP1OoYQ8xI/HAAA3XkkkSxDMxs2aLrYdPzDkMg2PJMB/DVyIG/HmxDXJUxIS96jOgoHRkWOK6ADd0mpv+8/ZERaCjU14WdL1pa46EXaySGwOhLa2ZYsWbQ2d692jwtTMAOPIO9iv+7l2RKZGAu6zm2sYmY9htuBKjk9c7PccliKN3X8dAhrvswhJGzb151RXre4ggvLhebxdN6OOpqqidRja134rYBx3IyM6tACh/oL2Asp7AD4gj5/GOEGtaTSMfc3Jt4APUaJBWW+bmF+rukdFF9LK5UjlibMptBOz7v08/tN2tjbg27RG8Z5h2XlniSB+rEwlCFdZEdwOHWYD2dOny+ukoHgBX/hX3AdzHZoGcvA+YlHANyl3UrSWr7cwYd3ZFGU8I4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199015)(2616005)(83380400001)(6486002)(38100700002)(66556008)(5660300002)(2906002)(235185007)(41300700001)(8936002)(53546011)(478600001)(6506007)(26005)(6512007)(66946007)(8676002)(66476007)(4326008)(316002)(6916009)(54906003)(186003)(33656002)(86362001)(36756003)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bcksv8bJXPKGdKpJCTiipTE4COxkOEdpiUFPj7bvas1dSYkfktVy+jLYfsZl?=
 =?us-ascii?Q?VXsCiCxWDYVVJf/nmfkvWwlaUGitVoaxCytQTII4vEo8EZW19qig5oHpFhc5?=
 =?us-ascii?Q?m08X1gIijDVeIq2o2omEcl8aCAy7lh+arCrWGx/heDZh0XTFw44P/58mk0F3?=
 =?us-ascii?Q?U6eB89AWPMu9YctnY34MEbk4+V4bcMjLAWfrnlAD5Jrx2pbp3OYL1ZXQ0NEg?=
 =?us-ascii?Q?Rkm9VgpS+E4bpcKve/qjjE9AmZSFnJZ6aDE8mJgi77j1vkm7dEPDLKx9NZAR?=
 =?us-ascii?Q?Qim4vpMOHQ5/pM5R+wLdfkhfZk0QRFOU/zc+Qr7L+Y/N5NPsW9UVO0swAA9Z?=
 =?us-ascii?Q?XRJ2dbhDDMPmqSQvz5hPDwSDI3oSZX821wmRDeh6v1KsG3bUguPOYSDLPWwd?=
 =?us-ascii?Q?b+Ll0PKOB0IhLYmZyKUp7hecBiszBgwiYBtkHmi7XIYQ/K5Ih6xE8nJxNL5l?=
 =?us-ascii?Q?YNESemBzQ6IJjIpp/qioHZvt8G2rRMhrMFBxgj1qwhVPAhwbenPRVmqRxXBe?=
 =?us-ascii?Q?YEMloPdHWGbDxSwl3aNbTjmxArQqg9Hql0AtJzHwynY/5nvXtNaw0/cSjLSO?=
 =?us-ascii?Q?kmf0yF2EhEVJyvTCjWhV4zpLyVmYJkNaa81/5J7UgnZW4iMpp2v1S2uiy3Ak?=
 =?us-ascii?Q?izugic3KCAPvoKaSQwxNbBSSFxzf5C7uuKxh6FsT4l8jdjf/+vcnlfUSnAJ7?=
 =?us-ascii?Q?jYmyhY1/wZTXf0C8GrLKbYo5Nhyyev8tdO/GU6XKob91+OEZdSt7z+YQtPEN?=
 =?us-ascii?Q?0LCFb/33B9eyND9vjXXZE+32EhceUCNOlVJjF4L3+1z+4WVGyfGoJD0IScxp?=
 =?us-ascii?Q?lsykCWT8RpNOvD9T/feslHWHmfvmLIvPCjQf9cWuZznC8nf2NKGN9OJwrlUP?=
 =?us-ascii?Q?EyPqzW67VWi5LFpGg7SWgsMZGmfwzUFZNhgufXeO1JkKxY2MmN6EIeerS2DS?=
 =?us-ascii?Q?mmK283LbLvz3Rtj2MSBL9Nn7sgBYBtWz7letF08hfCJ0CtMBIgThm2i1jXhA?=
 =?us-ascii?Q?PcjE7zc5yCGj+/Of8X0gY1zFjngbAlfuxoQRQg43R/nsZt9ALDv7QUbhLqhe?=
 =?us-ascii?Q?DaQkHbKf6NCy16VjGLCWWAzE57KDFHrQcwMzv7Dnh6tIjMeSavFAuWdx+nkU?=
 =?us-ascii?Q?oLdxdvecnw8vxkQDvaiUCSDi/zA2YKrLMUa9a2oqYKQUl6Cv2ZrbCe6WYOxO?=
 =?us-ascii?Q?u1vEMl5eqsOxh3ESaNzsVQ6Do3eHKFjcyH7ZUJ1I32utBhncljhdoVoKr01n?=
 =?us-ascii?Q?2vsPUKajRNz34S6GxJjlo/xdC8omp1BZw7y6j8W5kZmdHKXogYc/a6sMkHE8?=
 =?us-ascii?Q?Whxbyf/UQ3HhIFH4dcz+bEb9VqSDHOEx9rvsN9YAw3O3u+DTGeN5LyRmRr69?=
 =?us-ascii?Q?tKndvQ/kj4bzaCMTYlMrAJ4fCpC33pBx4EWWxDur9MtV+PldHizm+6Gz10vU?=
 =?us-ascii?Q?MK5CIRTo/oMXqnwWRpzCj5UQV8yo1fck+Q2bMhAajpg093WaSignLuKPINM7?=
 =?us-ascii?Q?msWGrN/tOd0baP0TJfEt/O4wtUr5p59BrjF2nDkVFwUpgKqSO19k/R1LYGfb?=
 =?us-ascii?Q?3mCSkelTiOy+gA5TH1ujy+DIGdpKMxku478u6YrW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4a83bb-dd07-4665-e261-08da9bebd397
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 16:10:39.6850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFJ2Sv2mRph6FZyEkopVKm48OMel1Q3mZARGTVSupHssrPUPvU0/+wFX/I0BBf/E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5248
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_B915BCCE-90FA-437B-8AC6-7F71BE6D2230_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 21 Sep 2022, at 2:06, Huang Ying wrote:

> This is a preparation patch to batch the page unmapping and moving
> for the normal pages and THP.
>
> If we had batched the page unmapping, all pages to be migrated would
> be unmapped before copying the contents and flags of the pages.  If
> the number of pages that were passed to migrate_pages() was too large,
> too many pages would be unmapped.  Then, the execution of their
> processes would be stopped for too long time.  For example,
> migrate_pages() syscall will call migrate_pages() with all pages of a
> process.  To avoid this possible issue, in this patch, we restrict the
> number of pages to be migrated to be no more than HPAGE_PMD_NR.  That
> is, the influence is at the same level of THP migration.
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Matthew Wilcox <willy@infradead.org>
> ---
>  mm/migrate.c | 93 +++++++++++++++++++++++++++++++++++++---------------=

>  1 file changed, 67 insertions(+), 26 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 4a81e0bfdbcd..1077af858e36 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1439,32 +1439,7 @@ static inline int try_split_thp(struct page *pag=
e, struct list_head *split_pages
>  	return rc;
>  }
>
> -/*
> - * migrate_pages - migrate the pages specified in a list, to the free =
pages
> - *		   supplied as the target for the page migration
> - *
> - * @from:		The list of pages to be migrated.
> - * @get_new_page:	The function used to allocate free pages to be used
> - *			as the target of the page migration.
> - * @put_new_page:	The function used to free target pages if migration
> - *			fails, or NULL if no special handling is necessary.
> - * @private:		Private data to be passed on to get_new_page()
> - * @mode:		The migration mode that specifies the constraints for
> - *			page migration, if any.
> - * @reason:		The reason for page migration.
> - * @ret_succeeded:	Set to the number of normal pages migrated successf=
ully if
> - *			the caller passes a non-NULL pointer.
> - *
> - * The function returns after 10 attempts or if no pages are movable a=
ny more
> - * because the list has become empty or no retryable pages exist any m=
ore.
> - * It is caller's responsibility to call putback_movable_pages() to re=
turn pages
> - * to the LRU or free list only if ret !=3D 0.
> - *
> - * Returns the number of {normal page, THP, hugetlb} that were not mig=
rated, or
> - * an error code. The number of THP splits will be considered as the n=
umber of
> - * non-migrated THP, no matter how many subpages of the THP are migrat=
ed successfully.
> - */
> -int migrate_pages(struct list_head *from, new_page_t get_new_page,
> +static int migrate_pages_batch(struct list_head *from, new_page_t get_=
new_page,
>  		free_page_t put_new_page, unsigned long private,
>  		enum migrate_mode mode, int reason, unsigned int *ret_succeeded)
>  {
> @@ -1709,6 +1684,72 @@ int migrate_pages(struct list_head *from, new_pa=
ge_t get_new_page,
>  	return rc;
>  }
>
> +/*
> + * migrate_pages - migrate the pages specified in a list, to the free =
pages
> + *		   supplied as the target for the page migration
> + *
> + * @from:		The list of pages to be migrated.
> + * @get_new_page:	The function used to allocate free pages to be used
> + *			as the target of the page migration.
> + * @put_new_page:	The function used to free target pages if migration
> + *			fails, or NULL if no special handling is necessary.
> + * @private:		Private data to be passed on to get_new_page()
> + * @mode:		The migration mode that specifies the constraints for
> + *			page migration, if any.
> + * @reason:		The reason for page migration.
> + * @ret_succeeded:	Set to the number of normal pages migrated successf=
ully if
> + *			the caller passes a non-NULL pointer.
> + *
> + * The function returns after 10 attempts or if no pages are movable a=
ny more
> + * because the list has become empty or no retryable pages exist any m=
ore.
> + * It is caller's responsibility to call putback_movable_pages() to re=
turn pages
> + * to the LRU or free list only if ret !=3D 0.
> + *
> + * Returns the number of {normal page, THP, hugetlb} that were not mig=
rated, or
> + * an error code. The number of THP splits will be considered as the n=
umber of
> + * non-migrated THP, no matter how many subpages of the THP are migrat=
ed successfully.
> + */
> +int migrate_pages(struct list_head *from, new_page_t get_new_page,
> +		free_page_t put_new_page, unsigned long private,
> +		enum migrate_mode mode, int reason, unsigned int *pret_succeeded)
> +{
> +	int rc, rc_gether =3D 0;
> +	int ret_succeeded, ret_succeeded_gether =3D 0;
> +	int nr_pages;
> +	struct page *page;
> +	LIST_HEAD(pagelist);
> +	LIST_HEAD(ret_pages);
> +
> +again:
> +	nr_pages =3D 0;
> +	list_for_each_entry(page, from, lru) {
> +		nr_pages +=3D compound_nr(page);
> +		if (nr_pages > HPAGE_PMD_NR)

It is better to define a new MACRO like NR_MAX_BATCHED_MIGRATION to be
HPAGE_PMD_NR. It makes code easier to understand and change.

> +			break;
> +	}
> +	if (nr_pages > HPAGE_PMD_NR)
> +		list_cut_before(&pagelist, from, &page->lru);
> +	else
> +		list_splice_init(from, &pagelist);
> +	rc =3D migrate_pages_batch(&pagelist, get_new_page, put_new_page, pri=
vate,
> +				 mode, reason, &ret_succeeded);
> +	ret_succeeded_gether +=3D ret_succeeded;
> +	list_splice_tail_init(&pagelist, &ret_pages);
> +	if (rc =3D=3D -ENOMEM) {
> +		rc_gether =3D rc;
> +		goto out;
> +	}
> +	rc_gether +=3D rc;
> +	if (!list_empty(from))
> +		goto again;
> +out:
> +	if (pret_succeeded)
> +		*pret_succeeded =3D ret_succeeded_gether;
> +	list_splice(&ret_pages, from);
> +
> +	return rc_gether;
> +}
> +
>  struct page *alloc_migration_target(struct page *page, unsigned long p=
rivate)
>  {
>  	struct folio *folio =3D page_folio(page);
> -- =

> 2.35.1


--
Best Regards,
Yan, Zi

--=_MailMate_B915BCCE-90FA-437B-8AC6-7F71BE6D2230_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmMrN34PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUAHsP/1DBmrl21abDmdQMo4HFo5hvoWrLeQcMg6bc
ncYV9KThXJu7cZJ6zsj9dikxQuHmclzbAfRZAZT0L19NysWOtXHccAyWe1eH2tET
xaFEDWSEZdhZGCG+OwK78Y4JdIpf2seZ72YEsARa/u4VxDfcc55ntv4wok8GplWn
dqaljqdT/EhhSMJIygT+3626ixY9L/MarL9lVprVz+UBujlQITDtj+UGmhowv+oI
E2UX64aeKkc9BX9ToR7pVGd4GE5uaYNU6jBXnH0u4l+sIaalUIYqKWeF3VvZ462z
Q2XGJx0wt8krboLIH+hpD70krkBkG5NGjLoidbva8h0PqmuHW1RVGZ3wmMZUslDn
GaqiKhfcmMWSKYXJkIM7RjVM73hMeUTn3hIgvzd8t2DPegx8INq1z19HPi6to+Ji
Bq9qwGteThZlSjsq/2Bz1XacW6i1fxrq/6VvkrTmjsIbyopToTnIWgMVJT6OcPkl
Hq6I/tFx8k/I2ZjLa+VLKMxLzue19A2Hm5hnGGGsD3BhMngiNixJMQPRIfIwAcMf
k7A9pN/cdU8wS65xvR9oafwNdObgXmyCycj8Sv2dJxG7xmee8RFQqKyEfl4LbAmJ
TqfTqkrQHfmSutyxZNkGtFEHebG5mabSlU398CJHzL9URZ4OiSlfW9XTMp4iaaTt
XDmoS5XH
=kx4N
-----END PGP SIGNATURE-----

--=_MailMate_B915BCCE-90FA-437B-8AC6-7F71BE6D2230_=--
