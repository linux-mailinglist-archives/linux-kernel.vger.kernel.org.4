Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D1E5C0417
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiIUQ12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiIUQ1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:27:06 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::61a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0913CC62
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:09:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLlUFsoTG0vEmUlorbv9LOeIXXs+HoKQE0KzbiVBXXF9iXJKR+xYeaFeKxzFeVN2oiAFIbkKE5UkQ7eB4Yfe2KLY0RfFvsSUQfzxcst6JznrPyhDw5FlV7Powr0XJuP0g0tXpHomDc/FniWfOWJTt9AjXqbaVRQGcV8HcoYz51tycVItKkAhvU5nUsifR+OXNxbNewmZ5THWvOy5BEX4E0XrwmG1skhnQQTus+bdmlk+EqBfIyqlXqEh7dHEulISDH3ln29kc4aJkM1p9k7eknfAwe+BLAfF0GD5uIddqkPVhWj3FcW4uyhAfd7rsZA59bVq8hr6RoHB5UhXds/j9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yp7bjVszipn4UYc5UjWY4r6wn28vMYsRZL/1C1M1uhE=;
 b=i7VCkxHV0xRNq/7r2wZkUI1S8+AOKgYcR9hG8VJOeksMl58jxwWkUeELj3b/HOgJp7ih7pnAxC7aA8m0dpVqLteWAEoQJJKDi3sRsYlYLjAW5m5cMRRBHO9BuqVyBu8SW6Z6wlGp1S7BtrfQrvXRSIwSpnd8J2Dhx8YYTgzbJPiPHXUgajzBS0McSEe7nBzm6JQ6bASWYuueBAt/IWAltlzZvIcfxH7xv9ZvOul/HxgYi040O7xFPAl8zw1VTMXn3nEuJT1iiIvf7IouqSyN1HtKZS5631Wnq0wfuSTJFY7uxATXOMBhvQh8QkeMU6VnxfCK9JiiMF52IaNj/utv7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yp7bjVszipn4UYc5UjWY4r6wn28vMYsRZL/1C1M1uhE=;
 b=WO5YkyzwbwESU1uYHCTPwwXKdsQTccRxT88fjXApx9baOEvmRSJtTA34eZ39V45emiPgHkUaSvGMu1gB9XgcC81qZNfRVUayZrAPOmd4yk8fLxstQA+e6vMJ9c3jy1REdqh4jjwAZsghE5Q2bxTqK7Rsg0OqcemEIEW2Cm1zH8hDs4234yEHEcWWgZeR+P2rJaaCRUHxUn/0pRy5y8phj8alwM0ZLPelAfn4qQ75CqVtjr1C8M/jVU/Tw+8ptxbkM5yIWTdLJNe484TKuzRjOypHp3zN9cWrkkIuD00TAu5XdbeurmYSkEHmUsHJSHaKvOQ0Suyi/OYpe6h8hi7w1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DM4PR12MB5248.namprd12.prod.outlook.com (2603:10b6:5:39c::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.16; Wed, 21 Sep 2022 16:08:33 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::94df:bc2b:6294:8cc6]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::94df:bc2b:6294:8cc6%6]) with mapi id 15.20.5612.022; Wed, 21 Sep 2022
 16:08:32 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 2/6] mm/migrate_pages: split unmap_and_move() to _unmap()
 and _move()
Date:   Wed, 21 Sep 2022 12:08:29 -0400
X-Mailer: MailMate (1.14r5916)
Message-ID: <9AF1028D-D939-4F20-9830-F60FEAC6152C@nvidia.com>
In-Reply-To: <20220921060616.73086-3-ying.huang@intel.com>
References: <20220921060616.73086-1-ying.huang@intel.com>
 <20220921060616.73086-3-ying.huang@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_93062B52-8F8C-4D85-AA93-4F2AF62D3972_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0174.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::29) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DM4PR12MB5248:EE_
X-MS-Office365-Filtering-Correlation-Id: 22730f8f-0693-407d-c1eb-08da9beb8784
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uTal6ofHUW6ECknYcJWcUwjcBw5sg9h1vN+kEvhM7HkQsdmP65KQRtdRHpOUXJboXS7zbefvffZ8c1MJJCbZ+m73JblCDGTQM3NCBcjMbZd5cPNsPo4ch8aFJbqPVbpjK/e8Uxv0bBi5j+tA6ma6lzDN13nfpWgDnNTNG+IMcIuBDZMpWV2ncFdp+kvomDUtEuDBcQwocvMDOl4jjv8CIowg6tbIvxyLD079EBqRPz3IMRNXa84iP4m3iQx5ZANrClR59mqJO1/op+NIKmIxuV5xC4FwEez/LPOOeyLFURx2petyJiKxFnvUZMoH+rYFT1w26jpLIzCOj6+D+xBG4QAVG7RHRhT+YWuh18QikJxkfJS5l/SAHefgruvZ9Et+BTa9y9YUuHBOxa1Z/NykzsJMSaWs86PparsWfU0n0CjBS7rCZvADv3W6syZZ94YRvh0T+yCowPgu95atfoSH08Mwmua3/dkJmTQ/zcTTsYzmhjZ7HNVfjnr1hraXsDrVwjsLXuL3xLPi8yhhSDB8Mw50ggncrD5LPzFVIsnQft0CrwcNcMRBbp5SJ5segPvje1TQikAq6NnCzfvrHHlha95FxmcYblMtoD5gyb7ynz9gKymJL+TISLV2/nhyBcdMkZAbkx70yCYLZERNyPryieh1o4Zxw186VQOnvRQJgHQiZo+1wrQhL49pt3ONTHjkUoidw4Bqc3VqBGWsuGCHin+EMQ1DPrC6OHMFlTdZUP/KwbfbhlKzTINkORVdiNMnY6StqtxU9/277t+o9RZEx59K2gZkn0NWy/pVuQLqezA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199015)(2616005)(83380400001)(6486002)(38100700002)(66556008)(5660300002)(2906002)(235185007)(41300700001)(8936002)(53546011)(478600001)(6506007)(26005)(6666004)(6512007)(66946007)(8676002)(66476007)(4326008)(316002)(6916009)(54906003)(186003)(33656002)(86362001)(36756003)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tIRimlADHenntM9mS0EAT0zkMig+WLVnOZeDF2+BQrhT1T57r/Vi8rvsdm2X?=
 =?us-ascii?Q?1zovt9RTNpXJ6yMymymZFbCCoPsmXq7TyMo2LTkvMIqVMV45oCdC5hwwRgOl?=
 =?us-ascii?Q?iJeaJkx4IzoWs+14Cq5fra3cVaLMeijrT7T/q1FD5QYderfiO7XQYCW1nmPX?=
 =?us-ascii?Q?isOgCa/0hee82Wu7lZB1Ycpmm+bGCOYmKRnKw8e6MX22iDECb5rvtGSoWXtt?=
 =?us-ascii?Q?DwCITzNfTawRQf9mIUobFgh5ww6l08ub7dP5pufe2SjhdU1hlQIrUxY/DOf9?=
 =?us-ascii?Q?miNY7upNrqwC4WaSBDtXoydIfnqsnz/4aS23ow+2n/v0KLoFqtPF8gBdhuDn?=
 =?us-ascii?Q?X72/qHhMZaAVdPUjpS65vt3RjbFgeaI5boZ4WzfhbAFB/13Uv1k7mi+ujTg3?=
 =?us-ascii?Q?t3H8El+hxAIEwFaR+b8TFFjJtkzwHLVzVhbri35yuommQEP4lJ+0f5nMeJc5?=
 =?us-ascii?Q?zETYiSmyuqzpKshdwPaFbb/UPvBy9uXAWopL7UbNaR9xzh7lPiu094t0m44+?=
 =?us-ascii?Q?fhSFKcgXCMnk6sSW5+fbcd5VsKgBQPdAZvEVJC1QUpd9vZB/KziSncxKObI6?=
 =?us-ascii?Q?7jgm9XOrex3bnzmGASHpkK6WyyvvSFdSyDxw4v6pS3OIeWVwsYuWWs/33Itn?=
 =?us-ascii?Q?iXli6LzriM51vXhOGfutNMIa1rHbNWr3iRxsTrC7tVVphtv7nEp76S95QodV?=
 =?us-ascii?Q?vIpZ+/Y6xYwoqSMNnH/QJH8GETPmSZgUIKsBU3sga7F9masLOROsRfgxFlAC?=
 =?us-ascii?Q?G1iwbkkRJBlei6GTqJvqrvP5tNHuOZXHjYGGtAxUsxu9+P7z4li3hgXkRN9a?=
 =?us-ascii?Q?ohEYNuw9RW6q+Bo+aIdnMbjI5/bl8hat/+TtHwn4JFo3qhmMhtVEjaZWz+r1?=
 =?us-ascii?Q?CGg3fL82fRoCfHDnitnJa4tzks7d3U/SZccbQnSPKrWtr8dZKpg8kZJfE9Qy?=
 =?us-ascii?Q?HXcupGCl/1BfClvbGLjjQl4nU+Zs4InQrT1QTdEdRz4BzvjOPOZOzYi6vwT+?=
 =?us-ascii?Q?qiWkrxV6TKHLvpRThRAFAyhpyC3dauIir5p1tE/uEQVuDyZ0gLlWfqri0PcT?=
 =?us-ascii?Q?xZ0YpFJu4rtlNU2fuT/EmMXWX7pc96dfdBDMrhFV9ceeV/bWVDXP/obt1vY9?=
 =?us-ascii?Q?gjbpuIQxzFkE7mqZNEwyFyVHMpi3xvj3s2lFz1Ef3MXM66gbZDFg3SAsz+qa?=
 =?us-ascii?Q?6Ed/cTJLkLXoDytL+NwI0JzQBuzfIDmnY6lN8tftreSFxH9KStr49S4UbzQ7?=
 =?us-ascii?Q?h9K/vag/I7td1aDyHyFF/1oCJpGKhC4SOEcdd4HEsPsFvzfayZWatouIM/L/?=
 =?us-ascii?Q?w/YloL8RGLwRFzsoVEBcPCfC2GpnJOKegOecXlAJl5s+4oc8zvhblPmFGNKN?=
 =?us-ascii?Q?Wxx+LdT4WIP4JgCq7WIZUWNJ8UwjCcEXg+w3sj5sNoQ6YfmoWIenvRnN011a?=
 =?us-ascii?Q?umiIppGDMTtw6ElLt7om8GHWgaFsj+QTpRt3RRMt2k2Oprx6RAcPlQTjPjE4?=
 =?us-ascii?Q?SMVm28O56u+2trJNlHE+2ItntSdaS9bakDrSCzbvbNhBFWWZ3rUyL7pVGf/q?=
 =?us-ascii?Q?W2NPr4YM2gItBAvfzQJN0iwGt+JwuQlG1+4OP/f6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22730f8f-0693-407d-c1eb-08da9beb8784
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 16:08:32.0528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJgtQFkXtBpv7ZMNAumXV1oUdWlzZTWFtZsEKiQqMZgoupncAJx8OprqEMzzGgun
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5248
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_93062B52-8F8C-4D85-AA93-4F2AF62D3972_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 21 Sep 2022, at 2:06, Huang Ying wrote:

> This is a preparation patch to batch the page unmapping and moving
> for the normal pages and THP.
>
> In this patch, unmap_and_move() is split to migrate_page_unmap() and
> migrate_page_move().  So, we can batch _unmap() and _move() in
> different loops later.  To pass some information between unmap and
> move, the original unused newpage->mapping and newpage->private are
> used.
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Matthew Wilcox <willy@infradead.org>
> ---
>  mm/migrate.c | 164 ++++++++++++++++++++++++++++++++++++++-------------=

>  1 file changed, 122 insertions(+), 42 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 117134f1c6dc..4a81e0bfdbcd 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -976,13 +976,32 @@ static int move_to_new_folio(struct folio *dst, s=
truct folio *src,
>  	return rc;
>  }
>
> -static int __unmap_and_move(struct page *page, struct page *newpage,
> +static void __migrate_page_record(struct page *newpage,
> +				  int page_was_mapped,
> +				  struct anon_vma *anon_vma)
> +{
> +	newpage->mapping =3D (struct address_space *)anon_vma;
> +	newpage->private =3D page_was_mapped;
> +}
> +
> +static void __migrate_page_extract(struct page *newpage,
> +				   int *page_was_mappedp,
> +				   struct anon_vma **anon_vmap)
> +{
> +	*anon_vmap =3D (struct anon_vma *)newpage->mapping;
> +	*page_was_mappedp =3D newpage->private;
> +	newpage->mapping =3D NULL;
> +	newpage->private =3D 0;
> +}
> +
> +#define MIGRATEPAGE_UNMAP		1

It is better to move this to migrate.h with MIGRATEPAGE_SUCCESS and
make them an enum.

> +
> +static int __migrate_page_unmap(struct page *page, struct page *newpag=
e,
>  				int force, enum migrate_mode mode)
>  {
>  	struct folio *folio =3D page_folio(page);
> -	struct folio *dst =3D page_folio(newpage);
>  	int rc =3D -EAGAIN;
> -	bool page_was_mapped =3D false;
> +	int page_was_mapped =3D 0;
>  	struct anon_vma *anon_vma =3D NULL;
>  	bool is_lru =3D !__PageMovable(page);
>
> @@ -1058,8 +1077,8 @@ static int __unmap_and_move(struct page *page, st=
ruct page *newpage,
>  		goto out_unlock;
>
>  	if (unlikely(!is_lru)) {
> -		rc =3D move_to_new_folio(dst, folio, mode);
> -		goto out_unlock_both;
> +		__migrate_page_record(newpage, page_was_mapped, anon_vma);
> +		return MIGRATEPAGE_UNMAP;
>  	}
>
>  	/*
> @@ -1085,11 +1104,41 @@ static int __unmap_and_move(struct page *page, =
struct page *newpage,
>  		VM_BUG_ON_PAGE(PageAnon(page) && !PageKsm(page) && !anon_vma,
>  				page);
>  		try_to_migrate(folio, 0);
> -		page_was_mapped =3D true;
> +		page_was_mapped =3D 1;
> +	}
> +
> +	if (!page_mapped(page)) {
> +		__migrate_page_record(newpage, page_was_mapped, anon_vma);
> +		return MIGRATEPAGE_UNMAP;
>  	}
>
> -	if (!page_mapped(page))
> -		rc =3D move_to_new_folio(dst, folio, mode);
> +	if (page_was_mapped)
> +		remove_migration_ptes(folio, folio, false);
> +
> +out_unlock_both:
> +	unlock_page(newpage);
> +out_unlock:
> +	/* Drop an anon_vma reference if we took one */
> +	if (anon_vma)
> +		put_anon_vma(anon_vma);
> +	unlock_page(page);
> +out:
> +
> +	return rc;
> +}
> +
> +static int __migrate_page_move(struct page *page, struct page *newpage=
,
> +			       enum migrate_mode mode)
> +{
> +	struct folio *folio =3D page_folio(page);
> +	struct folio *dst =3D page_folio(newpage);
> +	int rc;
> +	int page_was_mapped =3D 0;
> +	struct anon_vma *anon_vma =3D NULL;
> +
> +	__migrate_page_extract(newpage, &page_was_mapped, &anon_vma);
> +
> +	rc =3D move_to_new_folio(dst, folio, mode);
>
>  	/*
>  	 * When successful, push newpage to LRU immediately: so that if it
> @@ -1110,14 +1159,11 @@ static int __unmap_and_move(struct page *page, =
struct page *newpage,
>  		remove_migration_ptes(folio,
>  			rc =3D=3D MIGRATEPAGE_SUCCESS ? dst : folio, false);
>
> -out_unlock_both:
>  	unlock_page(newpage);
> -out_unlock:
>  	/* Drop an anon_vma reference if we took one */
>  	if (anon_vma)
>  		put_anon_vma(anon_vma);
>  	unlock_page(page);
> -out:
>  	/*
>  	 * If migration is successful, decrease refcount of the newpage,
>  	 * which will not free the page because new page owner increased
> @@ -1129,18 +1175,31 @@ static int __unmap_and_move(struct page *page, =
struct page *newpage,
>  	return rc;
>  }
>
> -/*
> - * Obtain the lock on page, remove all ptes and migrate the page
> - * to the newly allocated page in newpage.
> - */
> -static int unmap_and_move(new_page_t get_new_page,
> -				   free_page_t put_new_page,
> -				   unsigned long private, struct page *page,
> -				   int force, enum migrate_mode mode,
> -				   enum migrate_reason reason,
> -				   struct list_head *ret)
> +static void migrate_page_done(struct page *page,
> +			      enum migrate_reason reason)
> +{
> +	/*
> +	 * Compaction can migrate also non-LRU pages which are
> +	 * not accounted to NR_ISOLATED_*. They can be recognized
> +	 * as __PageMovable
> +	 */
> +	if (likely(!__PageMovable(page)))
> +		mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
> +				    page_is_file_lru(page), -thp_nr_pages(page));
> +
> +	if (reason !=3D MR_MEMORY_FAILURE)
> +		/* We release the page in page_handle_poison. */
> +		put_page(page);
> +}
> +
> +/* Obtain the lock on page, remove all ptes. */
> +static int migrate_page_unmap(new_page_t get_new_page, free_page_t put=
_new_page,
> +			      unsigned long private, struct page *page,
> +			      struct page **newpagep, int force,
> +			      enum migrate_mode mode, enum migrate_reason reason,
> +			      struct list_head *ret)
>  {
> -	int rc =3D MIGRATEPAGE_SUCCESS;
> +	int rc =3D MIGRATEPAGE_UNMAP;
>  	struct page *newpage =3D NULL;
>
>  	if (!thp_migration_supported() && PageTransHuge(page))
> @@ -1151,19 +1210,48 @@ static int unmap_and_move(new_page_t get_new_pa=
ge,
>  		ClearPageActive(page);
>  		ClearPageUnevictable(page);
>  		/* free_pages_prepare() will clear PG_isolated. */
> -		goto out;
> +		list_del(&page->lru);
> +		migrate_page_done(page, reason);
> +		return MIGRATEPAGE_SUCCESS;
>  	}
>
>  	newpage =3D get_new_page(page, private);
>  	if (!newpage)
>  		return -ENOMEM;
> +	*newpagep =3D newpage;
>
> -	newpage->private =3D 0;
> -	rc =3D __unmap_and_move(page, newpage, force, mode);
> +	rc =3D __migrate_page_unmap(page, newpage, force, mode);
> +	if (rc =3D=3D MIGRATEPAGE_UNMAP)
> +		return rc;
> +
> +	/*
> +	 * A page that has not been migrated will have kept its
> +	 * references and be restored.
> +	 */
> +	/* restore the page to right list. */
> +	if (rc !=3D -EAGAIN)
> +		list_move_tail(&page->lru, ret);
> +
> +	if (put_new_page)
> +		put_new_page(newpage, private);
> +	else
> +		put_page(newpage);
> +
> +	return rc;
> +}
> +
> +/* Migrate the page to the newly allocated page in newpage. */
> +static int migrate_page_move(free_page_t put_new_page, unsigned long p=
rivate,
> +			     struct page *page, struct page *newpage,
> +			     enum migrate_mode mode, enum migrate_reason reason,
> +			     struct list_head *ret)
> +{
> +	int rc;
> +
> +	rc =3D __migrate_page_move(page, newpage, mode);
>  	if (rc =3D=3D MIGRATEPAGE_SUCCESS)
>  		set_page_owner_migrate_reason(newpage, reason);
>
> -out:
>  	if (rc !=3D -EAGAIN) {
>  		/*
>  		 * A page that has been migrated has all references
> @@ -1179,20 +1267,7 @@ static int unmap_and_move(new_page_t get_new_pag=
e,
>  	 * we want to retry.
>  	 */
>  	if (rc =3D=3D MIGRATEPAGE_SUCCESS) {
> -		/*
> -		 * Compaction can migrate also non-LRU pages which are
> -		 * not accounted to NR_ISOLATED_*. They can be recognized
> -		 * as __PageMovable
> -		 */
> -		if (likely(!__PageMovable(page)))
> -			mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
> -					page_is_file_lru(page), -thp_nr_pages(page));
> -
> -		if (reason !=3D MR_MEMORY_FAILURE)
> -			/*
> -			 * We release the page in page_handle_poison.
> -			 */
> -			put_page(page);
> +		migrate_page_done(page, reason);
>  	} else {
>  		if (rc !=3D -EAGAIN)
>  			list_add_tail(&page->lru, ret);
> @@ -1405,6 +1480,7 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
>  	int pass =3D 0;
>  	bool is_thp =3D false;
>  	struct page *page;
> +	struct page *newpage =3D NULL;
>  	struct page *page2;
>  	int rc, nr_subpages;
>  	LIST_HEAD(ret_pages);
> @@ -1493,9 +1569,13 @@ int migrate_pages(struct list_head *from, new_pa=
ge_t get_new_page,
>  			if (PageHuge(page))
>  				continue;
>
> -			rc =3D unmap_and_move(get_new_page, put_new_page,
> -						private, page, pass > 2, mode,
> +			rc =3D migrate_page_unmap(get_new_page, put_new_page, private,
> +						page, &newpage, pass > 2, mode,
>  						reason, &ret_pages);
> +			if (rc =3D=3D MIGRATEPAGE_UNMAP)
> +				rc =3D migrate_page_move(put_new_page, private,
> +						       page, newpage, mode,
> +						       reason, &ret_pages);
>  			/*
>  			 * The rules are:
>  			 *	Success: page will be freed
> -- =

> 2.35.1


--
Best Regards,
Yan, Zi

--=_MailMate_93062B52-8F8C-4D85-AA93-4F2AF62D3972_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmMrNv0PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUq+MP/j/tBF76jJp+Gl1WU8/VYcnIduWiAf0A/BmQ
qMaFGnmsagdI6d2Ur1583Nr+QD84wGDs6scbI6Eo4G3/Rz9TErEwG1lag9sQN4hg
5IO+sshBK5yr7rF2SfyFJuOSu2i5sJRadGufvLrmRiEp3N7+4/Qzpf88uk3chdV0
Xw/xlLoqQX4amMT7LCMxpBGTlUiDHw9Itfkc5uhuS/Ojws7fgQoUwH7703jluEdp
TXtpdXgEAk7oIjYBvsEsKS5SyjE/W8dAPzV21sRk31LnEnf57FpKpbK+2JsdNndV
VoL5HPanjWbEKf+0NqIsNtaD26rTRo17S16mutYscn6KhQTF8/YENeOScFw/+3dG
rZLBIEV90lr52YEMrhH5QjCnKp9ldk3BPQViIdU5b+hzmRDAB/psBIX1FD4bOPdq
ujfrkkS51PFkcCaSgP7KZPncqMock2kTyBcfgyYbO5pF1kXiDidR1R+APZ5Gguaq
QWNiTZJRSnU5RMh+/sOAPI+h1VYCbEvBQVIdccZnXwUwWBsOXFE6wUpO84ir2jJT
kP2EnTTD7WLs+68bUZmQgkvoe4pYe2JXD9Gsp4eVAX0/GzFJZAOej2OJ6Q0LhCiy
OoZmgd3FifOpz5XhpIIyvg8A8Qq6z3exAhqjA3t7g+WsE1kgYXIpKCS78de9rfK7
V7lRqveR
=fshO
-----END PGP SIGNATURE-----

--=_MailMate_93062B52-8F8C-4D85-AA93-4F2AF62D3972_=--
