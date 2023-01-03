Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA0565C6DB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238247AbjACTBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbjACTBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:01:45 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445D1DB3
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 11:01:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqwqK7LHdcIBXWY/VTl+7QChNkYx80J42eAKN9nbWUoxwXfkWc/0oqGxEOr2ELuDM7qtu6tDhKkngvb829XC3nQgQDri6AA7EGILqzK+jYMeCVtRERrXKRhGPoi4Gd8/A5qtWsLeoWzfMejma1J14ufL/PZZwsSmCjJcYf4TFUG1K4g1w6ZMSDTDjgnCLiSciSxEqEBd+VJSBIzMqW+17viRK/BvIzZ+X6uiSpbU9feMnra3wXapUVhLL4GObUaYwbNTevCqee+m0vDA39NUOBWmr8a3Vu5AhSe1XptT17RI26jPsEtvQFH/VRsjTCYFN1zDIRdLmhsxUQshePIxMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALKIYllm5FtSxrPYWF6xyr59QzEps8bKMDhRcTr7SnI=;
 b=Sp0iE71yR0wppudO1bIgOa4SnqxH9G4pEsdSVDyb2BvGCf3PwRt/pxiu0/hZ0n6h3W7Z2lhj0B9vMU1zS8MhY+5YCVRE4mbQuPXumUVirvseZmwRPDrdo+ldYrm3HSA3mWO7EtRkxMfppkNIYas/+N9+jr0aiTDAUXwaMQjSXMwXKyUHHG9zlQ2+vyqAOxnXeL2+vUZ7o5MMGUc6emQWRMj3W7NQPtdPiVNyd1nLMHcwvNGFG7Z7F5/P0nfNAz+LkL6GPjgVbtMXoBBZxYN2GuV1QqsarVQtMhckLnUKTzrEi9niLBlVKt0TzV0UTsBQE+wbAtVqPg8GySnBV+A7+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALKIYllm5FtSxrPYWF6xyr59QzEps8bKMDhRcTr7SnI=;
 b=I7Oc2QGFgzVQ4d1qW+CQ2og1w12rTvXdpWQ2MbBuO+/v6JrisUqY3dGCwzW4eR/PS/I32Q2IIrE83O2R/zF9fECV9p4uZjY/E/P+LnaIwarBb9OIcShARYCng4WSKEzBZQUvrjQYY1LQWlwnmb4CcN0vktXpKZ+w7ly9FOkc8nyG3EkgD1G5DczPbBCfLOWKeJbq1AXmK8cB8uNCtagrJr10AdvzDQSKgj77e0d5Ulw5NWXrhmT3SPvJn5q9GBc5qqaEgmwfLRN7mefVwBe7HbuXUYg+N4jmg7FIsDT4lhy4k4RlO8LSSKwJuDbOjJia2kKiDCRWTUzAOlYJHJPWFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH0PR12MB8050.namprd12.prod.outlook.com (2603:10b6:510:26e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Tue, 3 Jan 2023 19:01:41 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::2585:153b:98ea:3e23]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::2585:153b:98ea:3e23%9]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 19:01:41 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>
Subject: Re: [PATCH 5/8] migrate_pages: batch _unmap and _move
Date:   Tue, 03 Jan 2023 14:01:37 -0500
X-Mailer: MailMate (1.14r5933)
Message-ID: <05A09BF6-A30C-45A5-952D-0CCFC43FE2D7@nvidia.com>
In-Reply-To: <20221227002859.27740-6-ying.huang@intel.com>
References: <20221227002859.27740-1-ying.huang@intel.com>
 <20221227002859.27740-6-ying.huang@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_F2ED55BD-5B4D-48E7-A882-31477CE57A7C_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR0102CA0065.prod.exchangelabs.com
 (2603:10b6:208:25::42) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH0PR12MB8050:EE_
X-MS-Office365-Filtering-Correlation-Id: 57f3f7f0-aabd-4159-6a6c-08daedbcf2d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tQDzr/zH5M+m2eiPjRGawmJsN8coUKQ2cA87fgF4nC2aV/iTzVQDQ7EGzjZvW4M/IjtVJpquWvQIn8OIsY4gPF1piK/+OGY9hweRSjPJsI68RutkefuqGMrJ2WlvpII9wLMMw3hv+q5+NB2p8Qd0g/pTHhKtuvoAdiO+RXG+/BnRVbw0wmP5qns11Z6B8IcVmjFWbIRwBFjyBlPYookBM7aIe5VXf7Lr1XV/CT+3F7V4ACGzAU4n/cjf6y8wa+at5H93YgIIJaUQ5G3GhuyTbJyimaIdgX2au88rZ/X2QbMLc2iQm29UOnUZplNHWIxl1CBoe30QgWCG8Nd75c3x+S9+CAwo3/GPiAYrS52dh4+JWS8abYOJm4RMmBFlzWWcRDl6qpROQG3izrCRLncdizZJ+9QCX3auDRa7g0V9mbeOsh/uW7dJo+0xBaKfrhsLQPoVOrQ18qtk4NCb+gW4GIUzopu5Kuu2pEe1z4JOTli7pBNlNtg3eTQH/kQEDe7cQj6hp174mkovrjZTg1QjWVH4x8KsiVjdPPT2MUkYXjzSwNCP7c68t+QyhHl38YDv96F7JGfl3Fr5f4TkKEOxelHjLUXp6++YKWlGx1phu74t4i70LQ4MLk4T5YS78Y3bE5HJU9TGDoBxvbW39zeQjVKpuOMQsjF6UuxSGc19l1XNh2AnKtMOdGv1ejkl8HjUELsqS+MkpZjb6OB6B3JWHNHmt73a/x5N1luYxvJjW2Hx6jHJ+61jcVI5HKGuo0mr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199015)(6512007)(6666004)(186003)(2906002)(6486002)(53546011)(478600001)(6506007)(26005)(6916009)(54906003)(8676002)(66476007)(66556008)(66946007)(2616005)(4326008)(41300700001)(316002)(33656002)(83380400001)(7416002)(5660300002)(235185007)(30864003)(8936002)(38100700002)(36756003)(86362001)(22166006)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gJIz219qgIFpht/yP55HGbI8tVe0+RB/ARPRqmtD/x8NIGpYSFrlpvapR6ad?=
 =?us-ascii?Q?O4KBlBRrZFFZ/6065Obwuz+PZenCiGRS+B9PmM4sWkYZsXiuOEoCqViWAjl9?=
 =?us-ascii?Q?MrCGoCGtu+uPf4kZAGSN2TcxQaoBzvrCY56Iv4UC+nuID0Ms1mtmmvau+XK2?=
 =?us-ascii?Q?6l9Yll+EfOsdPh6/ZNUd/6mJgrDNmAEv6Wi+fUfjKo9Wr9m+dqk2pFX0i7Fj?=
 =?us-ascii?Q?zil/vjDdGrh1oLjIiKdB+1NbdmDnsCedQFr/yeGplULxMXfdyxdkwbJgEmY0?=
 =?us-ascii?Q?LB0fdcKTtCkZC0GSF1uTbRZ2AMjKlVxv0ZKGCYsuUFaE3I7QvCdXKnBpcf4C?=
 =?us-ascii?Q?jj2o7/0/DRZZcYol7PoR93lHIlsxQouir23p8d+s6nSMYvfhtUi6361qKeoO?=
 =?us-ascii?Q?3E1zQhp7VNCawdcUN8hO5XJMYHlVfm9vDQ4qEcTi1Ep1Um356Ze3Y0zjAL1l?=
 =?us-ascii?Q?3mlwy68KMXx59x1AEvWaqKHLV0tCyzskbNW5PKIr1MZEoutMjkTBYCV3i3OA?=
 =?us-ascii?Q?Yn/Xo53j8SsOU/cBR+0jgFNQSwedgjGX3ieszF4V2QWulbR10sHjHjOKuKMp?=
 =?us-ascii?Q?OD/u2SdEosmhepiI18eitNBcgN2r0wPbXYrbaJeQNKiFTz5mCouGGZ9fQkm6?=
 =?us-ascii?Q?UWoVTm1QNXF0vEPTSejoH+oM1mifHyCbhnumzK1OXfjbRC8JJ5pSwJkdFKOI?=
 =?us-ascii?Q?e9l7cTNXRnC9FrY5G7hho4l5jR9TwM9faj1eNJ9bxPbFc1BqFO00OW1LfEYi?=
 =?us-ascii?Q?rQDUVylXdl1gFtJC7hh3vb7Kpm/aeI4G6W2A1PePfl3aP42DgJ13NVaSM3vC?=
 =?us-ascii?Q?ttRR/a4PPxC4eHV/zVJ2zkPjkYd7nP1LkbwTQfZZsLgifZM2a3Mlj0joWtsS?=
 =?us-ascii?Q?Ns8Cf2sBZpTPetWcOdRQqcXrZHKd4aHwS+d9IFjqpt7Bn/Cr7nk/s+iRvG2S?=
 =?us-ascii?Q?klkoyIvKCG7Faq+ngEt7G2JuwdH0YlwuCzpdZ/6XC7vVYW67vI/wiJUpAXV7?=
 =?us-ascii?Q?UaeJz7VcMwRMKJSSDzRQCqyCsq8aiChnjOGUvyQUv2LVRwvvCM8ER6Niujej?=
 =?us-ascii?Q?1rrhm6QbeQtyPZsE+W6lIrILlKbQ3M2KE0IZgtE8tkroyDCQSt4XjeX75fRQ?=
 =?us-ascii?Q?p5ZFCw+zKNEKfY6uRPvou/GXi6IcxOEjPCZJtEyfm39cI2iYH1FWYJceJV4B?=
 =?us-ascii?Q?QENwAvD775z1CxD7hDWOjNhk9gGgGiVYwrQd7mwkI7JnACqbfhtBOtkY+QDB?=
 =?us-ascii?Q?yHs4kSM03otmToOeHJO3F9ieU5dR5LkYXSaBZ4oqVhuRF72jni1s9JFx0eQl?=
 =?us-ascii?Q?TS30q4Z/A26v1RBZSQVXDeYM2/wT46jMjC/MIO26ReKWi0UAgB6w4zr5TriL?=
 =?us-ascii?Q?nIrRQaSGxg43OqO3xX0Ny9MITKuBL16+SXuMhBahuMO9gKeavsNlGX3PhwfD?=
 =?us-ascii?Q?TJSrG4y7Lxba5R3h/ljncZ9IVO7Psaa3AOzZkTWCW2YldP7Y4fmuaIgGbIJX?=
 =?us-ascii?Q?SuNV3ZJBrsaCknsSX5ezMLTK0ogk9PshAv1CMiRts4JFUcMMRj2n9Y9eAiip?=
 =?us-ascii?Q?9t0q76ln4uK7NsO/PEY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f3f7f0-aabd-4159-6a6c-08daedbcf2d0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 19:01:41.1132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ukX79c11UhBzkvAWNElesNmTH+dvmwT8PXeWF78WdBPU2eydwmhFpdl8MyMmUk3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8050
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_F2ED55BD-5B4D-48E7-A882-31477CE57A7C_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 26 Dec 2022, at 19:28, Huang Ying wrote:

> In this patch the _unmap and _move stage of the folio migration is
> batched.  That for, previously, it is,
>
>   for each folio
>     _unmap()
>     _move()
>
> Now, it is,
>
>   for each folio
>     _unmap()
>   for each folio
>     _move()

Also worth adding some notes here, we need extra code to undo the _unmap(=
)
if _move() fails. Andrew has asked for comments on *_undo_src/dst(),
but I think it would be better to provide a high level new workflow,
in the form of pseudo code, in git log and the comment for migrate_pages(=
).
The extra cleanup code for a failed _move() with a previously successful
_unmap() might not be obvious to everyone.

>
> Based on this, we can batch the TLB flushing and use some hardware
> accelerator to copy folios between batched _unmap and batched _move
> stages.
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Bharata B Rao <bharata@amd.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: haoxin <xhao@linux.alibaba.com>
> ---
>  mm/migrate.c | 189 ++++++++++++++++++++++++++++++++++++++++++++-------=

>  1 file changed, 165 insertions(+), 24 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index e2383b430932..dd68c3de3da8 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1027,8 +1027,32 @@ static void __migrate_folio_extract(struct folio=
 *dst,
>  	dst->private =3D NULL;
>  }
>
> +static void migrate_folio_undo_src(struct folio *src,
> +				   int page_was_mapped,
> +				   struct anon_vma *anon_vma,
> +				   struct list_head *ret)
> +{
> +	if (page_was_mapped)
> +		remove_migration_ptes(src, src, false);
> +	if (anon_vma)
> +		put_anon_vma(anon_vma);
> +	folio_unlock(src);
> +	list_move_tail(&src->lru, ret);
> +}
> +
> +static void migrate_folio_undo_dst(struct folio *dst,
> +				   free_page_t put_new_page,
> +				   unsigned long private)
> +{
> +	folio_unlock(dst);
> +	if (put_new_page)
> +		put_new_page(&dst->page, private);
> +	else
> +		folio_put(dst);
> +}
> +
>  static int __migrate_folio_unmap(struct folio *src, struct folio *dst,=

> -				int force, enum migrate_mode mode)
> +				 int force, bool force_lock, enum migrate_mode mode)
>  {
>  	int rc =3D -EAGAIN;
>  	int page_was_mapped =3D 0;
> @@ -1055,6 +1079,11 @@ static int __migrate_folio_unmap(struct folio *s=
rc, struct folio *dst,
>  		if (current->flags & PF_MEMALLOC)
>  			goto out;
>
> +		if (!force_lock) {
> +			rc =3D -EDEADLOCK;
> +			goto out;
> +		}
> +
>  		folio_lock(src);
>  	}
>
> @@ -1168,6 +1197,8 @@ static int __migrate_folio_move(struct folio *src=
, struct folio *dst,
>
>  	rc =3D move_to_new_folio(dst, src, mode);
>
> +	if (rc !=3D -EAGAIN)
> +		list_del(&dst->lru);
>  	/*
>  	 * When successful, push dst to LRU immediately: so that if it
>  	 * turns out to be an mlocked page, remove_migration_ptes() will
> @@ -1183,6 +1214,11 @@ static int __migrate_folio_move(struct folio *sr=
c, struct folio *dst,
>  			lru_add_drain();
>  	}
>
> +	if (rc =3D=3D -EAGAIN) {
> +		__migrate_folio_record(dst, page_was_mapped, anon_vma);
> +		return rc;
> +	}
> +
>  	if (page_was_mapped)
>  		remove_migration_ptes(src,
>  			rc =3D=3D MIGRATEPAGE_SUCCESS ? dst : src, false);
> @@ -1223,7 +1259,7 @@ static void migrate_folio_done(struct folio *src,=

>  /* Obtain the lock on page, remove all ptes. */
>  static int migrate_folio_unmap(new_page_t get_new_page, free_page_t pu=
t_new_page,
>  			       unsigned long private, struct folio *src,
> -			       struct folio **dstp, int force,
> +			       struct folio **dstp, int force, bool force_lock,
>  			       enum migrate_mode mode, enum migrate_reason reason,
>  			       struct list_head *ret)
>  {
> @@ -1251,7 +1287,7 @@ static int migrate_folio_unmap(new_page_t get_new=
_page, free_page_t put_new_page
>  	*dstp =3D dst;
>
>  	dst->private =3D NULL;
> -	rc =3D __migrate_folio_unmap(src, dst, force, mode);
> +	rc =3D __migrate_folio_unmap(src, dst, force, force_lock, mode);
>  	if (rc =3D=3D MIGRATEPAGE_UNMAP)
>  		return rc;
>
> @@ -1260,7 +1296,7 @@ static int migrate_folio_unmap(new_page_t get_new=
_page, free_page_t put_new_page
>  	 * references and be restored.
>  	 */
>  	/* restore the folio to right list. */
> -	if (rc !=3D -EAGAIN)
> +	if (rc !=3D -EAGAIN && rc !=3D -EDEADLOCK)
>  		list_move_tail(&src->lru, ret);
>
>  	if (put_new_page)
> @@ -1299,9 +1335,8 @@ static int migrate_folio_move(free_page_t put_new=
_page, unsigned long private,
>  	 */
>  	if (rc =3D=3D MIGRATEPAGE_SUCCESS) {
>  		migrate_folio_done(src, reason);
> -	} else {
> -		if (rc !=3D -EAGAIN)
> -			list_add_tail(&src->lru, ret);
> +	} else if (rc !=3D -EAGAIN) {
> +		list_add_tail(&src->lru, ret);
>
>  		if (put_new_page)
>  			put_new_page(&dst->page, private);
> @@ -1564,7 +1599,7 @@ static int migrate_pages_batch(struct list_head *=
from, new_page_t get_new_page,
>  		enum migrate_mode mode, int reason, struct list_head *ret_folios,
>  		struct migrate_pages_stats *stats)
>  {
> -	int retry =3D 1;
> +	int retry;
>  	int large_retry =3D 1;
>  	int thp_retry =3D 1;
>  	int nr_failed =3D 0;
> @@ -1573,13 +1608,19 @@ static int migrate_pages_batch(struct list_head=
 *from, new_page_t get_new_page,
>  	int pass =3D 0;
>  	bool is_large =3D false;
>  	bool is_thp =3D false;
> -	struct folio *folio, *folio2, *dst =3D NULL;
> -	int rc, nr_pages;
> +	struct folio *folio, *folio2, *dst =3D NULL, *dst2;
> +	int rc, rc_saved, nr_pages;
>  	LIST_HEAD(split_folios);
> +	LIST_HEAD(unmap_folios);
> +	LIST_HEAD(dst_folios);
>  	bool nosplit =3D (reason =3D=3D MR_NUMA_MISPLACED);
>  	bool no_split_folio_counting =3D false;
> +	bool force_lock;
>
> -split_folio_migration:
> +retry:
> +	rc_saved =3D 0;
> +	force_lock =3D true;
> +	retry =3D 1;
>  	for (pass =3D 0; pass < 10 && (retry || large_retry); pass++) {
>  		retry =3D 0;
>  		large_retry =3D 0;
> @@ -1599,16 +1640,15 @@ static int migrate_pages_batch(struct list_head=
 *from, new_page_t get_new_page,
>  			cond_resched();
>
>  			rc =3D migrate_folio_unmap(get_new_page, put_new_page, private,
> -						 folio, &dst, pass > 2, mode,
> -						 reason, ret_folios);
> -			if (rc =3D=3D MIGRATEPAGE_UNMAP)
> -				rc =3D migrate_folio_move(put_new_page, private,
> -							folio, dst, mode,
> -							reason, ret_folios);
> +						 folio, &dst, pass > 2, force_lock,
> +						 mode, reason, ret_folios);
>  			/*
>  			 * The rules are:
>  			 *	Success: folio will be freed
> +			 *	Unmap: folio will be put on unmap_folios list,
> +			 *	       dst folio put on dst_folios list
>  			 *	-EAGAIN: stay on the from list
> +			 *	-EDEADLOCK: stay on the from list
>  			 *	-ENOMEM: stay on the from list
>  			 *	-ENOSYS: stay on the from list
>  			 *	Other errno: put on ret_folios list
> @@ -1643,7 +1683,7 @@ static int migrate_pages_batch(struct list_head *=
from, new_page_t get_new_page,
>  			case -ENOMEM:
>  				/*
>  				 * When memory is low, don't bother to try to migrate
> -				 * other folios, just exit.
> +				 * other folios, move unmapped folios, then exit.
>  				 */
>  				if (is_large) {
>  					nr_large_failed++;
> @@ -1682,7 +1722,14 @@ static int migrate_pages_batch(struct list_head =
*from, new_page_t get_new_page,
>  				/* nr_failed isn't updated for not used */
>  				nr_large_failed +=3D large_retry;
>  				stats->nr_thp_failed +=3D thp_retry;
> -				goto out;
> +				rc_saved =3D rc;
> +				if (list_empty(&unmap_folios))
> +					goto out;
> +				else
> +					goto move;
> +			case -EDEADLOCK:
> +				rc_saved =3D rc;
> +				goto move;
>  			case -EAGAIN:
>  				if (is_large) {
>  					large_retry++;
> @@ -1696,6 +1743,15 @@ static int migrate_pages_batch(struct list_head =
*from, new_page_t get_new_page,
>  				stats->nr_succeeded +=3D nr_pages;
>  				stats->nr_thp_succeeded +=3D is_thp;
>  				break;
> +			case MIGRATEPAGE_UNMAP:
> +				/*
> +				 * We have locked some pages, don't force lock
> +				 * to avoid deadlock.
> +				 */
> +				force_lock =3D false;
> +				list_move_tail(&folio->lru, &unmap_folios);
> +				list_add_tail(&dst->lru, &dst_folios);
> +				break;
>  			default:
>  				/*
>  				 * Permanent failure (-EBUSY, etc.):
> @@ -1719,12 +1775,93 @@ static int migrate_pages_batch(struct list_head=
 *from, new_page_t get_new_page,
>  	nr_large_failed +=3D large_retry;
>  	stats->nr_thp_failed +=3D thp_retry;
>  	stats->nr_failed_pages +=3D nr_retry_pages;
> +move:
> +	retry =3D 1;
> +	for (pass =3D 0; pass < 10 && (retry || large_retry); pass++) {
> +		retry =3D 0;
> +		large_retry =3D 0;
> +		thp_retry =3D 0;
> +		nr_retry_pages =3D 0;
> +
> +		dst =3D list_first_entry(&dst_folios, struct folio, lru);
> +		dst2 =3D list_next_entry(dst, lru);
> +		list_for_each_entry_safe(folio, folio2, &unmap_folios, lru) {
> +			is_large =3D folio_test_large(folio);
> +			is_thp =3D is_large && folio_test_pmd_mappable(folio);
> +			nr_pages =3D folio_nr_pages(folio);
> +
> +			cond_resched();
> +
> +			rc =3D migrate_folio_move(put_new_page, private,
> +						folio, dst, mode,
> +						reason, ret_folios);
> +			/*
> +			 * The rules are:
> +			 *	Success: folio will be freed
> +			 *	-EAGAIN: stay on the unmap_folios list
> +			 *	Other errno: put on ret_folios list
> +			 */
> +			switch(rc) {
> +			case -EAGAIN:
> +				if (is_large) {
> +					large_retry++;
> +					thp_retry +=3D is_thp;
> +				} else if (!no_split_folio_counting) {
> +					retry++;
> +				}
> +				nr_retry_pages +=3D nr_pages;
> +				break;
> +			case MIGRATEPAGE_SUCCESS:
> +				stats->nr_succeeded +=3D nr_pages;
> +				stats->nr_thp_succeeded +=3D is_thp;
> +				break;
> +			default:
> +				if (is_large) {
> +					nr_large_failed++;
> +					stats->nr_thp_failed +=3D is_thp;
> +				} else if (!no_split_folio_counting) {
> +					nr_failed++;
> +				}
> +
> +				stats->nr_failed_pages +=3D nr_pages;
> +				break;
> +			}
> +			dst =3D dst2;
> +			dst2 =3D list_next_entry(dst, lru);
> +		}
> +	}
> +	nr_failed +=3D retry;
> +	nr_large_failed +=3D large_retry;
> +	stats->nr_thp_failed +=3D thp_retry;
> +	stats->nr_failed_pages +=3D nr_retry_pages;
> +
> +	if (rc_saved)
> +		rc =3D rc_saved;
> +	else
> +		rc =3D nr_failed + nr_large_failed;
> +out:
> +	/* Cleanup remaining folios */
> +	dst =3D list_first_entry(&dst_folios, struct folio, lru);
> +	dst2 =3D list_next_entry(dst, lru);
> +	list_for_each_entry_safe(folio, folio2, &unmap_folios, lru) {
> +		int page_was_mapped =3D 0;
> +		struct anon_vma *anon_vma =3D NULL;
> +
> +		__migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
> +		migrate_folio_undo_src(folio, page_was_mapped, anon_vma,
> +				       ret_folios);
> +		list_del(&dst->lru);
> +		migrate_folio_undo_dst(dst, put_new_page, private);
> +		dst =3D dst2;
> +		dst2 =3D list_next_entry(dst, lru);
> +	}
> +
>  	/*
>  	 * Try to migrate split folios of fail-to-migrate large folios, no
>  	 * nr_failed counting in this round, since all split folios of a
>  	 * large folio is counted as 1 failure in the first round.
>  	 */
> -	if (!list_empty(&split_folios)) {
> +	if (rc >=3D 0 && !list_empty(&split_folios)) {
>  		/*
>  		 * Move non-migrated folios (after 10 retries) to ret_folios
>  		 * to avoid migrating them again.
> @@ -1732,12 +1869,16 @@ static int migrate_pages_batch(struct list_head=
 *from, new_page_t get_new_page,
>  		list_splice_init(from, ret_folios);
>  		list_splice_init(&split_folios, from);
>  		no_split_folio_counting =3D true;
> -		retry =3D 1;
> -		goto split_folio_migration;
> +		goto retry;
>  	}
>
> -	rc =3D nr_failed + nr_large_failed;
> -out:
> +	/*
> +	 * We have unlocked all locked pages, so we can force lock now, let's=

> +	 * try again.
> +	 */
> +	if (rc =3D=3D -EDEADLOCK)
> +		goto retry;
> +
>  	return rc;
>  }
>
> -- =

> 2.35.1


--
Best Regards,
Yan, Zi

--=_MailMate_F2ED55BD-5B4D-48E7-A882-31477CE57A7C_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmO0e5EPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUN6kP/jf5dMw6xAcy0i2p59Z6ngqf+61L7ZKgzS9m
AnH55IHIvxI0F/Q+KtAfO36NGFZ0Xd1I7/lqJ+4IHRMB0XpQbIOtfPhN8vNyL+Vu
byBFo4YdWf+BQaWK+Ix2EU4pbFXiJvVezlVTnWQ9uEwI5rZtmz6mKxhMPEPsVy6s
nLK61tGgYt/crXnxa/zB5m2c50u5jQIlCGl5EqldkWqzdA6EQSfAPlTHQXkKPx5L
BV/e+RlRf7TVyfDNO26fp71ixYDLZiVX0MWIJsu9fD7kOD6Q8qO2Q2Hm5VkPg0Bk
e7Lrep9wjPL+KH3HdtztO0zTqhf+gsszEPfL6JAJMcYKF/CJQ28QsGr6PbZe+NET
23zIPCWiARx4OcsWXPRk/a+1KVgNAaGKD+ay0Pbq9Ppq2j7JN3WlpPV9sYQcz8Ff
nFV24LWmQ6/KGJVfvQllcp8KzBTIWvm7MsOPqoaewjcNvVQk535TU7qInQPjuVfW
+dAYQjCkawW8h03VA+kXueOJXJmhKAs+7cx7UxhNqcLZ8jEjSRY3S8RhZdAfOwgJ
cfxEXufXzqc0xOaT76kx9iOFdmeMpt+FaBI9x5bgkRyTOMX7uLr6JRunt4K8aNQO
ItpoAYoFYlXj5zocrrcpLlJWPsyvpxlEeETGyn2mK/wa3fO2WkmvyjtN3C0LnzmP
6Zwwgp97
=1LwL
-----END PGP SIGNATURE-----

--=_MailMate_F2ED55BD-5B4D-48E7-A882-31477CE57A7C_=--
