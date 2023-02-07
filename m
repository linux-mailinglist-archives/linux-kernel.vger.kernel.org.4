Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5112D68DC17
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjBGOvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjBGOvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:51:06 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2051.outbound.protection.outlook.com [40.107.96.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57499D7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 06:51:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8sRYAetBoxj++j9ma27q0ocmyrv0xOWn2gHt2b+vWPSddVM/X6B88TJo47rQY8EK4HrwUhxIvgmiRYjr1ESvc4vng4YfArWPk0bj2sqggk8djzLodTTNaWCTvP8+/bo4eheuDAPEC9SqNQTIzyv7rJt1mWuD9t13GG2FoiCOAu6nYNeG+qX/1kB+CwiYFyjL7oDA1RtwQyM6CQ/k+N4L/CFnweZE5sqvSKTedBD/LB63qzzDoqbPWUw2+317Ho8MHL2q6tf2MDDh0JHxsIhb7xafP/5gfhob2SNbFfeGmMDHs4bmCmM7+sgM3y6fHaMW0AhXeXZ0oPEeOTvwu8bmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hyvz1piBgBWsDM4Q04jyi18/RUZKgaKxd3TnoIpYos4=;
 b=ZHRmQvHQNm7YDI7drmeYffm8mUWLJaYB3SbguEpaSYLbffYcea+uDLRUN5+lq1d96zMen4DKaMnxLUjan7aJjrfo73SIYwYLwStkZbO1DP9/uSLrEagNjavaAWGWEb9t9YlWC99yViEfteF99p0qA9mILiLYrG25iPV6XcgTnlemG9fJNf6BZp4r2lbb6PqdFj98VjXZXT4uolG2uf+oPUn8mok9RBw6MwpQjPSo2XyVWQDZmZuvV9aqZuXlE1XKiuZBOkIiu3YKGMQhWMHJYDhGcIkWtatOJud/B3imlvMdpKyujwCrf30bNDRD7SDZ01mVFMQQzoiaE3ZgOc+hYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hyvz1piBgBWsDM4Q04jyi18/RUZKgaKxd3TnoIpYos4=;
 b=CE2stsUXAhdyr18jz/4VLetw7UvVEc1lKyLaP52otP/ODUVk/w0FoYGTM6l3XVOKGiV6JFWLYNOc6XTt7y8cDeyboO4WoDnhV9CqC27FDGeRaDm7IBXIos6iaBPh/iLKHZVxQjJnY4R2QHiVbl+1uf6x4TUdSP7shI2EzPQp8uChXhpqAxJr0EvZSEfFoCJs6X/ELws6gZE1lVf6srEEoVndd/ZbipeHVmGAB++zsW+jTYf0mZ3W9bKUzfArypytxB59S8oVXuXn4DVIeWVAOz9DyfNycL9yA3MK3QMYVxn+eUF4WQxMSMvgiF4562ZDl+6lInxH3EoiQnp7jsiVJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MW4PR12MB7438.namprd12.prod.outlook.com (2603:10b6:303:219::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 14:51:00 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::2585:153b:98ea:3e23]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::2585:153b:98ea:3e23%9]) with mapi id 15.20.6064.036; Tue, 7 Feb 2023
 14:50:59 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH -v4 7/9] migrate_pages: share more code between _unmap and
 _move
Date:   Tue, 07 Feb 2023 09:50:56 -0500
X-Mailer: MailMate (1.14r5937)
Message-ID: <C4525F0D-C4DB-4584-A290-DFFC8F1BAE3C@nvidia.com>
In-Reply-To: <20230206063313.635011-8-ying.huang@intel.com>
References: <20230206063313.635011-1-ying.huang@intel.com>
 <20230206063313.635011-8-ying.huang@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_27184144-27EE-419B-AB28-1EEF7FEC04C9_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR20CA0051.namprd20.prod.outlook.com
 (2603:10b6:208:235::20) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MW4PR12MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: dadd9a81-1886-4550-ba3a-08db091ab9f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vrwc9JzgeG63xupDrZW8tv5XKi3rD9FUCaYi0ySDRthLyXA6WFbVNJZ8nrKYhKL+27oKP3iN5QDJV7QpRUz3ttFpXWjTBvblQNG+MR+H/XkaSmac4I3ZKKsq9ato1tq0WtZXSzeZL9CMPe014bXIeleY5VcpcyOxal/vxOz6G+YT6Z3yW3dTN9IsSfXf/AEDRNsU3dVY3qM2cNfUlYqy7cDTHwKEXN6G6LAltFGzOsci2LMXoadJMZOeyl6OvFIkNYbCRywYw70rWd+KadM0YXOpiBW+sGHHoRLioOl29jZcNDITKnZMRHI5W1k+qECGVG6/AJcXUI2fabx3KEa/Wp4Rdzm9WgqshgxkqlHyhChGOOpkANiWk/FSQsKDaIL34imXXtFb6wwvliKhL5kapUxnXqEdMqdQ21nzIVJdWcVNovozlS19Hsnokp9D2vH02vAw3SykcNSvol6oF7kLkOZxLB0gufY9JCXnHgVTnFO+ChJ5nkUfNi/QV6aV2TwhyLBX5t9QWccK+lQe0OliaxTDw3tn1jn/rwWZmh8qJeIuSepUUHZZz/thaN2DTfWzJlCNyKXQIs7BVxd+3hmvgrN4Mlr8LcIyT/OFinTVBmXH9BwuzwIOgVPP429PFAjuzGQgOswg9D1hiRC1ecHphaj/zgFI7TkeBEkuCI3kzZuU6+iWq3P1ZkTgimkns3sxGGg8Q6lk33ADccfahn96GZTsaG9I/NE1FkMDFeapOMU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(451199018)(478600001)(38100700002)(6666004)(186003)(53546011)(33656002)(6512007)(6506007)(36756003)(26005)(8676002)(6486002)(6916009)(4326008)(66946007)(83380400001)(2616005)(66556008)(66476007)(86362001)(316002)(41300700001)(7416002)(235185007)(30864003)(54906003)(2906002)(5660300002)(8936002)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s1Auf+bYEI9Cni24e6P4dRzkdJre9sg9VudkZ2j2ZP6MClY0gFffFUix1+t1?=
 =?us-ascii?Q?3N24TBaKCFG7oH9fYU+gD89ouKGvTL5HoQsx6OepY8QaLMed4Q3e9W6yVg8n?=
 =?us-ascii?Q?LxEn+/rzk45NlQLw3W5927QJSlDt6sSwPHlhNdD+s9v7QZqtDuQfv5E6rxFE?=
 =?us-ascii?Q?idM1akhIdYqEW54LxEudy0gIUqFiYKC2ByMealNO5iMH/0tD6z/EFb9PX9NR?=
 =?us-ascii?Q?cAZ2RHO4wGDsLGIe9cVzOBnoxlxTR55KNPR6yuOqLuFwG4eYTI5THC0ko5mi?=
 =?us-ascii?Q?ZMUZBjBSZ9rFFxtH9t5UaiWhiIzlQj+XR3ukBzOWFVvgtrTG5n0zcp4F0JV8?=
 =?us-ascii?Q?6rLerNJHQTsc5fF0NumZV1Wj9tJoxGZczLwUDwdMOce3w9N2aA0abwvJYDgK?=
 =?us-ascii?Q?AXJ2hTzgXhnHHY//GqJBOF5AZGcqApNh3548bKbC0gMKDFBItkieM741shgk?=
 =?us-ascii?Q?eALJxN63l0/LitvMvY3tdGPOmDHaIInnMbkEA2O8ROifyuIiocigYENPrMvj?=
 =?us-ascii?Q?F/ZKt6u8vUMJSYwjRAI7gxPreT6vv6Qb+CAYH+Yu8S3ipZ28Kd490n5ez+yW?=
 =?us-ascii?Q?ZtP08uItRgMfbnJUNTx94q/cs6l1VdDa6PHOKNIXXfnLhgoZzJBH6BzSEPWx?=
 =?us-ascii?Q?EWxj4vWW2cSYLvKgia/lQXkto0qpi4F4Ma9agoLBh1YOuuZc5EPOnfJmcXk8?=
 =?us-ascii?Q?2b7HiIUUjMcUKdD8kUyFqDunTmx/ZmRR8EfaO+vib26lC/4OoLD1joyHSU6J?=
 =?us-ascii?Q?FBfWw9Ahg+bMHTvMU3e+Jo08y92ivsfT4ClUzXnPD/Mhzgfu9eV+e/PLchyA?=
 =?us-ascii?Q?LgfQEzPLboVmv9rqpQizi13/HyA9OvJxBZlQPP3JNWpsVTPXr2MXqkFD8QdX?=
 =?us-ascii?Q?onv9lfrQ2rDP0y53qjzLJldED7tyaQcpDgoSCMMJyeJa9UAQnI/22jkhDY9A?=
 =?us-ascii?Q?fOfWDx4vtWe2HOzueLPsa/ucbaTYxxI7TacRUeSjSfya2PFpAZ4gAk+/o/Pa?=
 =?us-ascii?Q?tToLmmYJJTF3l25ARnUk1Wo/SKiK+yK32+atjpjwlHDakUshwxbAQEYBHeuO?=
 =?us-ascii?Q?mfegPNQGC8v6lLKxDgfol78ki3wsrr4NY2KN/k8XUIQV1jWPa7cZJdoWlCMe?=
 =?us-ascii?Q?RyP9pCniwHgWJo7sWEg2B9xyEfzkknRje0FCEQDLDy81EJ625G1ZIgy3VD07?=
 =?us-ascii?Q?A/UjuK1PnQpRPt9Se1aDFUxW08YqZpTE78uaw5A5B51fAAl//nMjyxM/WLW5?=
 =?us-ascii?Q?KFVNC8GQDcR0796Y1Atf9po5w8Y2A167tEzIdD7hXo5FO3YImUOdh4P0y7AV?=
 =?us-ascii?Q?CpqM41/3ba3RnNGDWYkOM+OlUsYoGgXPFqj5YGVx9naie/olDzxlffsRtTAK?=
 =?us-ascii?Q?Nh8udezQu29N2eHtnygRDgi7ooSiVhL+P639OwXzJlR2WZDb9t1tG4Jj9Dyx?=
 =?us-ascii?Q?gIymnZFczagVRKrYQ2/dLE7rMuSBYhbShciKtJ46L2VS3zZ+oE/HqIRhNiTl?=
 =?us-ascii?Q?yUsFjUidkgjZSZLDoymQeg6GRZ/a9EKyY4n8O6uFPrgP+4DfU3LAnDCuhnzB?=
 =?us-ascii?Q?Z8wZ6L4xwGHE5JJ96N5zvKyZvYfgSmeUf+aoz6CE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dadd9a81-1886-4550-ba3a-08db091ab9f3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 14:50:59.8645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISj5D7GNwG5vstHBSbuv4noASsPGi7qGk9gQVJbT5URxjv/XCKt6TBro0Pvy3dkv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7438
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_27184144-27EE-419B-AB28-1EEF7FEC04C9_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 6 Feb 2023, at 1:33, Huang Ying wrote:

> This is a code cleanup patch to reduce the duplicated code between the
> _unmap and _move stages of migrate_pages().  No functionality change
> is expected.
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
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>  mm/migrate.c | 203 ++++++++++++++++++++-------------------------------=

>  1 file changed, 81 insertions(+), 122 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 23eb01cfae4c..9378fa2ad4a5 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1037,6 +1037,7 @@ static void __migrate_folio_extract(struct folio =
*dst,
>  static void migrate_folio_undo_src(struct folio *src,
>  				   int page_was_mapped,
>  				   struct anon_vma *anon_vma,
> +				   bool locked,
>  				   struct list_head *ret)
>  {
>  	if (page_was_mapped)
> @@ -1044,16 +1045,20 @@ static void migrate_folio_undo_src(struct folio=
 *src,
>  	/* Drop an anon_vma reference if we took one */
>  	if (anon_vma)
>  		put_anon_vma(anon_vma);
> -	folio_unlock(src);
> -	list_move_tail(&src->lru, ret);
> +	if (locked)
> +		folio_unlock(src);

Having a comment would be better.
/* A page that has not been migrated, move it to a list for later restora=
tion */
> +	if (ret)
> +		list_move_tail(&src->lru, ret);
>  }
>
>  /* Restore the destination folio to the original state upon failure */=

>  static void migrate_folio_undo_dst(struct folio *dst,
> +				   bool locked,
>  				   free_page_t put_new_page,
>  				   unsigned long private)
>  {
> -	folio_unlock(dst);
> +	if (locked)
> +		folio_unlock(dst);
>  	if (put_new_page)
>  		put_new_page(&dst->page, private);
>  	else
> @@ -1078,13 +1083,42 @@ static void migrate_folio_done(struct folio *sr=
c,
>  		folio_put(src);
>  }
>
> -static int __migrate_folio_unmap(struct folio *src, struct folio *dst,=

> -				 int force, bool force_lock, enum migrate_mode mode)
> +/* Obtain the lock on page, remove all ptes. */
> +static int migrate_folio_unmap(new_page_t get_new_page, free_page_t pu=
t_new_page,
> +			       unsigned long private, struct folio *src,
> +			       struct folio **dstp, int force, bool force_lock,
> +			       enum migrate_mode mode, enum migrate_reason reason,
> +			       struct list_head *ret)
>  {
> +	struct folio *dst;
>  	int rc =3D -EAGAIN;
> +	struct page *newpage =3D NULL;
>  	int page_was_mapped =3D 0;
>  	struct anon_vma *anon_vma =3D NULL;
>  	bool is_lru =3D !__PageMovable(&src->page);
> +	bool locked =3D false;
> +	bool dst_locked =3D false;
> +
> +	if (!thp_migration_supported() && folio_test_transhuge(src))
> +		return -ENOSYS;
> +
> +	if (folio_ref_count(src) =3D=3D 1) {
> +		/* Folio was freed from under us. So we are done. */
> +		folio_clear_active(src);
> +		folio_clear_unevictable(src);
> +		/* free_pages_prepare() will clear PG_isolated. */
> +		list_del(&src->lru);
> +		migrate_folio_done(src, reason);
> +		return MIGRATEPAGE_SUCCESS;
> +	}
> +
> +	newpage =3D get_new_page(&src->page, private);
> +	if (!newpage)
> +		return -ENOMEM;
> +	dst =3D page_folio(newpage);
> +	*dstp =3D dst;
> +
> +	dst->private =3D NULL;
>
>  	if (!folio_trylock(src)) {
>  		if (!force || mode =3D=3D MIGRATE_ASYNC)
> @@ -1119,6 +1153,7 @@ static int __migrate_folio_unmap(struct folio *sr=
c, struct folio *dst,
>
>  		folio_lock(src);
>  	}
> +	locked =3D true;
>
>  	if (folio_test_writeback(src)) {
>  		/*
> @@ -1133,10 +1168,10 @@ static int __migrate_folio_unmap(struct folio *=
src, struct folio *dst,
>  			break;
>  		default:
>  			rc =3D -EBUSY;
> -			goto out_unlock;
> +			goto out;
>  		}
>  		if (!force)
> -			goto out_unlock;
> +			goto out;
>  		folio_wait_writeback(src);
>  	}
>
> @@ -1166,7 +1201,8 @@ static int __migrate_folio_unmap(struct folio *sr=
c, struct folio *dst,
>  	 * This is much like races on refcount of oldpage: just don't BUG().
>  	 */
>  	if (unlikely(!folio_trylock(dst)))
> -		goto out_unlock;
> +		goto out;
> +	dst_locked =3D true;
>
>  	if (unlikely(!is_lru)) {
>  		__migrate_folio_record(dst, page_was_mapped, anon_vma);
> @@ -1188,7 +1224,7 @@ static int __migrate_folio_unmap(struct folio *sr=
c, struct folio *dst,
>  	if (!src->mapping) {
>  		if (folio_test_private(src)) {
>  			try_to_free_buffers(src);
> -			goto out_unlock_both;
> +			goto out;
>  		}
>  	} else if (folio_mapped(src)) {
>  		/* Establish migration ptes */
> @@ -1203,74 +1239,26 @@ static int __migrate_folio_unmap(struct folio *=
src, struct folio *dst,
>  		return MIGRATEPAGE_UNMAP;
>  	}
>
> -	if (page_was_mapped)
> -		remove_migration_ptes(src, src, false);
> -
> -out_unlock_both:
> -	folio_unlock(dst);
> -out_unlock:
> -	/* Drop an anon_vma reference if we took one */
> -	if (anon_vma)
> -		put_anon_vma(anon_vma);
> -	folio_unlock(src);
>  out:
> -
> -	return rc;
> -}
> -
> -/* Obtain the lock on page, remove all ptes. */
> -static int migrate_folio_unmap(new_page_t get_new_page, free_page_t pu=
t_new_page,
> -			       unsigned long private, struct folio *src,
> -			       struct folio **dstp, int force, bool force_lock,
> -			       enum migrate_mode mode, enum migrate_reason reason,
> -			       struct list_head *ret)
> -{
> -	struct folio *dst;
> -	int rc =3D MIGRATEPAGE_UNMAP;
> -	struct page *newpage =3D NULL;
> -
> -	if (!thp_migration_supported() && folio_test_transhuge(src))
> -		return -ENOSYS;
> -
> -	if (folio_ref_count(src) =3D=3D 1) {
> -		/* Folio was freed from under us. So we are done. */
> -		folio_clear_active(src);
> -		folio_clear_unevictable(src);
> -		/* free_pages_prepare() will clear PG_isolated. */
> -		list_del(&src->lru);
> -		migrate_folio_done(src, reason);
> -		return MIGRATEPAGE_SUCCESS;
> -	}
> -
> -	newpage =3D get_new_page(&src->page, private);
> -	if (!newpage)
> -		return -ENOMEM;
> -	dst =3D page_folio(newpage);
> -	*dstp =3D dst;
> -
> -	dst->private =3D NULL;
> -	rc =3D __migrate_folio_unmap(src, dst, force, force_lock, mode);
> -	if (rc =3D=3D MIGRATEPAGE_UNMAP)
> -		return rc;
> -
>  	/*
>  	 * A page that has not been migrated will have kept its
>  	 * references and be restored.
>  	 */
>  	/* restore the folio to right list. */

This comment is stale. Probably should be
/* Keep the folio and we will try it again later */

> -	if (rc !=3D -EAGAIN && rc !=3D -EDEADLOCK)
> -		list_move_tail(&src->lru, ret);
> +	if (rc =3D=3D -EAGAIN || rc =3D=3D -EDEADLOCK)
> +		ret =3D NULL;
>
> -	if (put_new_page)
> -		put_new_page(&dst->page, private);
> -	else
> -		folio_put(dst);
> +	migrate_folio_undo_src(src, page_was_mapped, anon_vma, locked, ret);
> +	migrate_folio_undo_dst(dst, dst_locked, put_new_page, private);
>
>  	return rc;
>  }
>
> -static int __migrate_folio_move(struct folio *src, struct folio *dst,
> -				enum migrate_mode mode)
> +/* Migrate the folio to the newly allocated folio in dst. */
> +static int migrate_folio_move(free_page_t put_new_page, unsigned long =
private,
> +			      struct folio *src, struct folio *dst,
> +			      enum migrate_mode mode, enum migrate_reason reason,
> +			      struct list_head *ret)
>  {
>  	int rc;
>  	int page_was_mapped =3D 0;
> @@ -1283,12 +1271,8 @@ static int __migrate_folio_move(struct folio *sr=
c, struct folio *dst,
>  	list_del(&dst->lru);
>
>  	rc =3D move_to_new_folio(dst, src, mode);
> -
> -	if (rc =3D=3D -EAGAIN) {
> -		list_add(&dst->lru, prev);
> -		__migrate_folio_record(dst, page_was_mapped, anon_vma);
> -		return rc;
> -	}
> +	if (rc)
> +		goto out;
>
>  	if (unlikely(!is_lru))
>  		goto out_unlock_both;
> @@ -1302,70 +1286,45 @@ static int __migrate_folio_move(struct folio *s=
rc, struct folio *dst,
>  	 * unsuccessful, and other cases when a page has been temporarily
>  	 * isolated from the unevictable LRU: but this case is the easiest.
>  	 */
> -	if (rc =3D=3D MIGRATEPAGE_SUCCESS) {
> -		folio_add_lru(dst);
> -		if (page_was_mapped)
> -			lru_add_drain();
> -	}
> +	folio_add_lru(dst);
> +	if (page_was_mapped)
> +		lru_add_drain();
>
>  	if (page_was_mapped)
> -		remove_migration_ptes(src,
> -			rc =3D=3D MIGRATEPAGE_SUCCESS ? dst : src, false);
> +		remove_migration_ptes(src, dst, false);
>
>  out_unlock_both:
>  	folio_unlock(dst);
> -	/* Drop an anon_vma reference if we took one */
> -	if (anon_vma)
> -		put_anon_vma(anon_vma);
> -	folio_unlock(src);
> +	set_page_owner_migrate_reason(&dst->page, reason);
>  	/*
>  	 * If migration is successful, decrease refcount of dst,
>  	 * which will not free the page because new page owner increased
>  	 * refcounter.
>  	 */
> -	if (rc =3D=3D MIGRATEPAGE_SUCCESS)
> -		folio_put(dst);
> -
> -	return rc;
> -}
> -
> -/* Migrate the folio to the newly allocated folio in dst. */
> -static int migrate_folio_move(free_page_t put_new_page, unsigned long =
private,
> -			      struct folio *src, struct folio *dst,
> -			      enum migrate_mode mode, enum migrate_reason reason,
> -			      struct list_head *ret)
> -{
> -	int rc;
> -
> -	rc =3D __migrate_folio_move(src, dst, mode);
> -	if (rc =3D=3D MIGRATEPAGE_SUCCESS)
> -		set_page_owner_migrate_reason(&dst->page, reason);
> -
> -	if (rc !=3D -EAGAIN) {
> -		/*
> -		 * A folio that has been migrated has all references
> -		 * removed and will be freed. A folio that has not been
> -		 * migrated will have kept its references and be restored.
> -		 */
> -		list_del(&src->lru);
> -	}
> +	folio_put(dst);
>
>  	/*
> -	 * If migration is successful, releases reference grabbed during
> -	 * isolation. Otherwise, restore the folio to right list unless
> -	 * we want to retry.
> +	 * A page that has been migrated has all references removed
> +	 * and will be freed.
>  	 */
> -	if (rc =3D=3D MIGRATEPAGE_SUCCESS) {
> -		migrate_folio_done(src, reason);
> -	} else if (rc !=3D -EAGAIN) {
> -		list_add_tail(&src->lru, ret);
> +	list_del(&src->lru);
> +	/* Drop an anon_vma reference if we took one */
> +	if (anon_vma)
> +		put_anon_vma(anon_vma);
> +	folio_unlock(src);
> +	migrate_folio_done(src, reason);
>
> -		if (put_new_page)
> -			put_new_page(&dst->page, private);
> -		else
> -			folio_put(dst);
> +	return rc;
> +out:
> +	if (rc =3D=3D -EAGAIN) {
> +		list_add(&dst->lru, prev);
> +		__migrate_folio_record(dst, page_was_mapped, anon_vma);
> +		return rc;
>  	}
>
> +	migrate_folio_undo_src(src, page_was_mapped, anon_vma, true, ret);
> +	migrate_folio_undo_dst(dst, true, put_new_page, private);
> +
>  	return rc;
>  }
>
> @@ -1897,9 +1856,9 @@ static int migrate_pages_batch(struct list_head *=
from, new_page_t get_new_page,
>
>  		__migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
>  		migrate_folio_undo_src(folio, page_was_mapped, anon_vma,
> -				       ret_folios);
> +				       true, ret_folios);
>  		list_del(&dst->lru);
> -		migrate_folio_undo_dst(dst, put_new_page, private);
> +		migrate_folio_undo_dst(dst, true, put_new_page, private);
>  		dst =3D dst2;
>  		dst2 =3D list_next_entry(dst, lru);
>  	}
> -- =

> 2.35.1

Everything else looks good to me, just need to fix the two comments above=
=2E
Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_27184144-27EE-419B-AB28-1EEF7FEC04C9_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmPiZVEPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUboUP/03SZ9H12YwV38d7/vK8ZQZfEM6QvDnzRITb
7RTw1zocqJKguaxahlAT3vDZo6AUr+kClPgMnqlt/fx4BKUyKSsdZk4dhsxO5w0o
nEKNdbrYFqjwd0O3DT0FAPlED4rMD3IU5BGbBngxzMbb2Lpov4IZb/5+BxZxu2JS
7jLD4Gv9OyKfx3MYPGgCUhaUrBmRD9aUEZ9YOUFDmu77vPKtuxB5bgTXWSPfiefY
YjXpjIlHHTnvK+YsSAWSQ5ecXT0WXU62SANKPM6VuAQx8tbSIXy0VtLjik5BnzJk
8gOfuSD/ucaE0ZlwsaVXs9CvAOWhwdG2/2aAgmD9ykQqsllBWNpF5knea8R7KE09
wF1enl/1GSppiZjkGFUD82DNEvvKXzgIMI9myhe8oJGUciL6MStnE4BgIW/UMGjq
FXhlP7cefV5BA9pg4xchfR8lNSSZTnX4Nn9H6xkJGmN2FHoGpS7pTxlqb6l/hSoj
8cvUvh3sVWl4L7U4uEux/tIb1oTcRJ+/Xh0GLBl2xGtxcy19Wdi746FpvfTKlxWV
8/MnzAq6pY1ZnuxWWkV3P6e5qggdfRcn4lS/8B4fZ0PL9Y7WikdsXyEcyz4RCFMY
tigVSLeXxry90EsdNWcfVooDQGGKlGyJ9cGLwba5iQLaAnPZWr7noHk/iEipspzn
mDnbKGmT
=+b7n
-----END PGP SIGNATURE-----

--=_MailMate_27184144-27EE-419B-AB28-1EEF7FEC04C9_=--
