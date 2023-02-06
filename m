Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D68768C29A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjBFQKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjBFQKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:10:45 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB8D2ED5B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 08:10:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q25gHrXayui9OGo0teuMBJm0sUqubOH+8Kt+212hneTq4GLx8fqb0sjHMgXiyR2akm050ElT1WCBa7ZLGc/9Dc8hG/o0Jt/wN71j9GDkfVlgxu9XeXSVKYE53AuwkDwOKzkIUmoJ9dlr98/kotQhTRvBX4J/e7m03BFbXpg4gCWaZxfjnZCLrujYE/PpP4jl0Z8xyHd6lmvAtTlRi8CIp5WybWXdswFmfHIhUz8lo58bW2diuSG3NZprBwbMcjltgOTAg7kl3a3XNpEU/VJK717R741jS8BSXrpYl6e0hv08adh4mEOZGm0vionUu37hpe4GU1y1fx1InRZA1HDOpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+CmimEZYjSj1qCcFR0m8PtvqpMa5T9TekoM5bE0VNU=;
 b=W+rKP7g0HrkfZwxOLmPXdG67AMUVNCHZCzlegjMR8B3xQ1H/X4p83ruYJKD8waNa9Dytn+gMvRVGDGJNv9ykdkbbdEIi7bvKHjmCVjIeOUwuPD+xBysYI2XxtA3Ls8H40t4aFT7N78StzKVkcWZn7J43oej3KpxAMYAANnUquYNXqWO9fiXaTNcZYPa9ceJQ2ph1rMr+Zv7DCmtLoq+yF7eDbPxhLDGppCS8tDcglSK+fHVooBu8CQPeLbmNjoC712Zu6cBOjj77KZHeCqpuDKNNWgjGLj2dTJV5ZE6qwHVbFUdztey03SctFsWhiHDIBC2hDmoUxd8/02UbDW5bkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+CmimEZYjSj1qCcFR0m8PtvqpMa5T9TekoM5bE0VNU=;
 b=HVlb1LbD0pjehEw4c6D5o6smaR215J1d3cEU6LyCpcau+D03dmeXPTW4cONiIGt7KSv61fHLffiBKww7H8WPmRb2HMOIJ/U162GRY+SF/r9cmJcO3WzcX2oSAqi7zqdiZiysDkAGtr7DLrv5EoCW4ys1FsNOXvljtgVCG+JyBFk7ljdTCApJs3YK/ZK5RqnDZCjjj3/y08FQa7c3U/jWdN9ZNhj7dxQSAEd8qZtpbPc5RINEO0ZrZ0fmz2BPVHLXWuwaCmc+5aDqmA2BhcXnKUnWO584ZnT011Q5UgZF5aS3ZP+K3Em4ki3JFobSYe079RF0FJDKTjmsMTewm5J/9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 IA1PR12MB6140.namprd12.prod.outlook.com (2603:10b6:208:3e8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 16:10:28 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::2585:153b:98ea:3e23]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::2585:153b:98ea:3e23%8]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 16:10:27 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH -v4 5/9] migrate_pages: batch _unmap and _move
Date:   Mon, 06 Feb 2023 11:10:24 -0500
X-Mailer: MailMate (1.14r5933)
Message-ID: <6324EC7A-5D44-49EB-82A8-89B0114FC5E6@nvidia.com>
In-Reply-To: <20230206063313.635011-6-ying.huang@intel.com>
References: <20230206063313.635011-1-ying.huang@intel.com>
 <20230206063313.635011-6-ying.huang@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_83E6CE06-7886-4CF5-A90C-D9FB5B7021FC_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR03CA0131.namprd03.prod.outlook.com
 (2603:10b6:208:32e::16) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|IA1PR12MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: b2920dbc-624b-4936-7aeb-08db085ca955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aVnmEHYR00FLOZk70zNZJlhtZ6z7v+eeWJ0XWeu/WqxhKC2p+VvHa3FYoiAxH/oyGYp5rVAy4EoxzxxnBgjEJYDQuDZ69NcB2fGMYcT6tAxJoQs36dAu73YWXGMzwE/P9x9X36i+Y89CTxqlwEQgLi5XKKNPaUhM/jsfnepZZ2WvObFUq/LjD2sCX92Qkjir7n+hFESSbgFH/KNtgdWl4n/Z1X+6twPHyvO9cwf+eMxpCUus/d+15Ei7LcgleZGiKh6F2RTYpo0axDashRWAmrhi5bNUUjodjNe3vQqh2HvA9g+DFzL8llvQrd5yHsuRRexnXjkD+PP3l35rggMPomqfC/tDUWTF2WnqT6sE6s//pwfWMH5DcIWjmS7To5Hv8hk4rTNTvJCZGXT+1a4LhPyt6CQXbcSzG3mVnRSrTj7Fq++7YTh+TprWetffMBfCyOLdsozdklauMZx0k0F2C/jwexqyGKJHondDDDApdvEduU8S8qHx6rncT2WS1S1ZGM5B6BOXMfSNjbMxNLb3IqafgDMxi7R0uHa6+ICnjyWbn908ujtMTcIBWLrXBnGIKbnLqDSo3fMzis0M73799x0m5A5zVhAJFf9eByEFDXWHkEZIM7OxJ4RSVz7Wq4QYtcU+yYZIBP4ErRpfQxtYNa7bgBPD1Sh0NXTdImkLHXBots3UjZhYlMpvRkbpUp3Yu0evJqd8p0DKPdvzmFRW0eTemF01kDDPR5pe+e8rUEg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199018)(83380400001)(38100700002)(66476007)(66556008)(41300700001)(8936002)(6916009)(66946007)(8676002)(4326008)(2906002)(53546011)(30864003)(6506007)(7416002)(186003)(26005)(6512007)(6666004)(2616005)(54906003)(478600001)(316002)(6486002)(36756003)(86362001)(235185007)(33656002)(5660300002)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/uBPUfdeawUUZ9iktNkEhrWnOvjo3kfPG/EFUxjVSqzsswPvhF25ovfqfoPs?=
 =?us-ascii?Q?fvjTMPNfwjoJNgSdPdRKhW770ygA/gE1F3MXRTK0P4dpzxiIDYgr5NfgLqFK?=
 =?us-ascii?Q?Mw2hU1W/ppoYWIaYODYnes/LQvJiYqPCZR9TICfb0UDjvCDKRqyaUCLQgHeO?=
 =?us-ascii?Q?FyQEBTQHGsodqhaMjjOj7G34m1QEa6rvCPSVStsOG8F0xAJvpiaEdvHvUt1u?=
 =?us-ascii?Q?4pAtJfLvU/a0rsZeLc1NAli0JUTYcUyXoCT2ObahwHISYr2td0Nxt5/0IkBB?=
 =?us-ascii?Q?YH0TbUmUgitLSjVaMg3+cSyAWYOA8VnthykBLI/QmIMM8BcMzfsJkK6AB3X/?=
 =?us-ascii?Q?e04U9w66z6e/VpznxCoo52y1HpcVwimKeTg4wu7+UbLL2472I+kJzicxFQYu?=
 =?us-ascii?Q?edaP+vnVPSVGyj0/o5TQub/38bAB/xUZNKUVceHgEvu8w1C090KD6HL3sb14?=
 =?us-ascii?Q?bcKq8Euy2oq5z4pyYZ5A+7T20yZeAObeT64rsY+IBBzyRISYJbDy3xVHZplZ?=
 =?us-ascii?Q?YSNYAs4P2RmFgBsQxtqTC+3sKcAtLFnjbfaAOEiTgxjjGQz6bx+mFidrdTtN?=
 =?us-ascii?Q?n6qHkQT0OF3isZsoNBB0fcKvktDNyVP+wzoyVylW7AzcfnmnRGs1gxjVcXF/?=
 =?us-ascii?Q?+0+sbLdg2gTwIoQsa04SF3ao4YM8IeZAb+y6UFGKnhEH9Nx1p5ZT5hwaIqHc?=
 =?us-ascii?Q?f+n0lzVsjHD9hfedWYDzKBdkxcE6JFPoX7M/vR5La1EGAkhmJTlfaDQgHm+a?=
 =?us-ascii?Q?QUhV6dNOpBo1b6aYP/L4Dgvsjld8K355hR38fY71n1esKzEHaMtvCK+aq04C?=
 =?us-ascii?Q?NViRedKZeaDkyCUFN4CD6MXLw4kW2nler07MX21CSZfBalugB7eARE40Eh1X?=
 =?us-ascii?Q?3lFkuHIY+qYxVfA7GlIEx5tZPKil1DRTSHbcfl/DikxA/dDo3h03vidQKnBF?=
 =?us-ascii?Q?fo57JBoh0MRws6S8yCRIG0Lsx3y90h/rJQcvhk5O5U1HAXnnH4cJen+gtzVF?=
 =?us-ascii?Q?RsPzSVbVkFk4CTBONiiEDO4FisPYpmdD8oe7+jIevnNUgYu0rhy3zi6OsFj1?=
 =?us-ascii?Q?vXTyJ+ZZscqAGGctU3vBdA5zH7szNn9Wpn41AAQHY3Pbj8ocSkST1M+SYmT3?=
 =?us-ascii?Q?wPQRcg1vV/tm2dvSLv7bRE8S8ACU0bmZUp6QEwTE4DvkkOSwHW1Zlgw7Glk4?=
 =?us-ascii?Q?mjSiTxuA0cToe5ku3TOBHLICo78TDaQIbdX8wu1o8udO096yYx/vlcpvRTk5?=
 =?us-ascii?Q?isXRPswoExgwdIHiqlWLfrcHy1vCuT/6YoGgzAMFGxmvDz29AsFptsY9z7gm?=
 =?us-ascii?Q?ES9iZ1bpiZ1eUdXWf+FayY8lF1uwkiDUxJfxtdeTM45qncdVP3sBJRbRQf/N?=
 =?us-ascii?Q?p7eEIUA8H0tUrjOQ6lqjwA7XGS4YD4mz4xP1SWZsC0vbf7xBHjsrjaEPRnX7?=
 =?us-ascii?Q?ge8fbGBNlpwOHFwOc8dZJ49htG0vrZeAnkFz4zMZyBkLpQ+dIjvm5eptZWeX?=
 =?us-ascii?Q?H5GUZ2Kf82I9BrwgveVDfnhqTu738xNY07qcwCc5Rnnhg9NyQi9wJI5NbbGa?=
 =?us-ascii?Q?aAyuj73tJobuGJvuig8OcLBrDKZWhXV3mk3MJTlt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2920dbc-624b-4936-7aeb-08db085ca955
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 16:10:27.6834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zxzLpY0nDh5L6NDr+KSuKfv10yxVlEdN6SipcjaL2qy8SKDzl/UKlGQ9cLa5U3ak
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6140
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_83E6CE06-7886-4CF5-A90C-D9FB5B7021FC_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 6 Feb 2023, at 1:33, Huang Ying wrote:

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
>
> Based on this, we can batch the TLB flushing and use some hardware
> accelerator to copy folios between batched _unmap and batched _move
> stages.
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
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
> ---
>  mm/migrate.c | 208 +++++++++++++++++++++++++++++++++++++++++++++------=

>  1 file changed, 184 insertions(+), 24 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 0428449149f4..fa7212330cb6 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1033,6 +1033,33 @@ static void __migrate_folio_extract(struct folio=
 *dst,
>  	dst->private =3D NULL;
>  }
>
> +/* Restore the source folio to the original state upon failure */
> +static void migrate_folio_undo_src(struct folio *src,
> +				   int page_was_mapped,
> +				   struct anon_vma *anon_vma,
> +				   struct list_head *ret)
> +{
> +	if (page_was_mapped)
> +		remove_migration_ptes(src, src, false);
> +	/* Drop an anon_vma reference if we took one */
> +	if (anon_vma)
> +		put_anon_vma(anon_vma);
> +	folio_unlock(src);
> +	list_move_tail(&src->lru, ret);
> +}
> +
> +/* Restore the destination folio to the original state upon failure */=

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
>  /* Cleanup src folio upon migration success */
>  static void migrate_folio_done(struct folio *src,
>  			       enum migrate_reason reason)
> @@ -1052,7 +1079,7 @@ static void migrate_folio_done(struct folio *src,=

>  }
>
>  static int __migrate_folio_unmap(struct folio *src, struct folio *dst,=

> -				int force, enum migrate_mode mode)
> +				 int force, bool force_lock, enum migrate_mode mode)
>  {
>  	int rc =3D -EAGAIN;
>  	int page_was_mapped =3D 0;
> @@ -1079,6 +1106,17 @@ static int __migrate_folio_unmap(struct folio *s=
rc, struct folio *dst,
>  		if (current->flags & PF_MEMALLOC)
>  			goto out;
>
> +		/*
> +		 * We have locked some folios, to avoid deadlock, we cannot
> +		 * lock the folio synchronously.  Go out to process (and
> +		 * unlock) all the locked folios.  Then we can lock the folio
> +		 * synchronously.
> +		 */
The comment alone is quite confusing and the variable might be better
renamed to avoid_force_lock, since there is a force variable to force
lock folio already. And the variable intends to discourage force lock
on a folio to avoid potential deadlock.

How about? Since "lock synchronously" might not be as straightforward
as wait to lock.

/*
 * We have locked some folios and are going to wait to lock this folio.
 * To avoid a potential deadlock, let's bail out and not do that. The
 * locked folios will be moved and unlocked, then we can wait to lock
 * this folio
 */

> +		if (!force_lock) {
> +			rc =3D -EDEADLOCK;
> +			goto out;
> +		}
> +
>  		folio_lock(src);
>  	}
>
> @@ -1187,10 +1225,20 @@ static int __migrate_folio_move(struct folio *s=
rc, struct folio *dst,
>  	int page_was_mapped =3D 0;
>  	struct anon_vma *anon_vma =3D NULL;
>  	bool is_lru =3D !__PageMovable(&src->page);
> +	struct list_head *prev;
>
>  	__migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
> +	prev =3D dst->lru.prev;
> +	list_del(&dst->lru);
>
>  	rc =3D move_to_new_folio(dst, src, mode);
> +
> +	if (rc =3D=3D -EAGAIN) {
> +		list_add(&dst->lru, prev);
> +		__migrate_folio_record(dst, page_was_mapped, anon_vma);
> +		return rc;
> +	}
> +
>  	if (unlikely(!is_lru))
>  		goto out_unlock_both;
>
> @@ -1233,7 +1281,7 @@ static int __migrate_folio_move(struct folio *src=
, struct folio *dst,
>  /* Obtain the lock on page, remove all ptes. */
>  static int migrate_folio_unmap(new_page_t get_new_page, free_page_t pu=
t_new_page,
>  			       unsigned long private, struct folio *src,
> -			       struct folio **dstp, int force,
> +			       struct folio **dstp, int force, bool force_lock,
>  			       enum migrate_mode mode, enum migrate_reason reason,
>  			       struct list_head *ret)
>  {
> @@ -1261,7 +1309,7 @@ static int migrate_folio_unmap(new_page_t get_new=
_page, free_page_t put_new_page
>  	*dstp =3D dst;
>
>  	dst->private =3D NULL;
> -	rc =3D __migrate_folio_unmap(src, dst, force, mode);
> +	rc =3D __migrate_folio_unmap(src, dst, force, force_lock, mode);
>  	if (rc =3D=3D MIGRATEPAGE_UNMAP)
>  		return rc;
>
> @@ -1270,7 +1318,7 @@ static int migrate_folio_unmap(new_page_t get_new=
_page, free_page_t put_new_page
>  	 * references and be restored.
>  	 */
>  	/* restore the folio to right list. */
> -	if (rc !=3D -EAGAIN)
> +	if (rc !=3D -EAGAIN && rc !=3D -EDEADLOCK)
>  		list_move_tail(&src->lru, ret);
>
>  	if (put_new_page)
> @@ -1309,9 +1357,8 @@ static int migrate_folio_move(free_page_t put_new=
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
> @@ -1591,7 +1638,7 @@ static int migrate_pages_batch(struct list_head *=
from, new_page_t get_new_page,
>  		enum migrate_mode mode, int reason, struct list_head *ret_folios,
>  		struct migrate_pages_stats *stats)

Like I said in my last comment to this patch, migrate_pages_batch() funct=
ion
deserves a detailed comment about its working flow including the error ha=
ndling.
Now you only put some in the git log, which is hard to access after sever=
al code
changes later.

How about?

/*
 * migrate_pages_batch() first unmaps pages in the from as many as possib=
le,
 * then migrates the unmapped pages. During unmap process, different situ=
ations
 * are handled differently:
 * 1. ENOSYS, unsupported large folio migration: move to ret_folios list
 * 2. ENOMEM, lower memory at the destination: migrate existing unmapped =
folios
 *    and stop, since existing unmapped folios have new pages allocated a=
nd can
 *    be migrated
 * 3. EDEADLOCK, to be unmapped page is locked by someone else, to avoid =
deadlock,
 *    we migrate existing unmapped pages and try to lock again
 * 4. MIGRATEPAGE_SUCCESS, the folios was freed under us: no action
 * 5. MIGRATEPAGE_UNMAP, unmap succeeded: set avoid_force_lock to true to=
 avoid
 *    wait to lock a folio in the future to avoid deadlock.
 *
 * For folios unmapped but cannot be migrated, we will restore their orig=
inal
 * states during cleanup stage at the end.
 */

>  {
> -	int retry =3D 1;
> +	int retry;
>  	int large_retry =3D 1;
>  	int thp_retry =3D 1;
>  	int nr_failed =3D 0;
> @@ -1600,13 +1647,19 @@ static int migrate_pages_batch(struct list_head=
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
>  	for (pass =3D 0;
>  	     pass < NR_MAX_MIGRATE_PAGES_RETRY && (retry || large_retry);
>  	     pass++) {
> @@ -1628,16 +1681,15 @@ static int migrate_pages_batch(struct list_head=
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
> @@ -1672,7 +1724,7 @@ static int migrate_pages_batch(struct list_head *=
from, new_page_t get_new_page,
>  			case -ENOMEM:
>  				/*
>  				 * When memory is low, don't bother to try to migrate
> -				 * other folios, just exit.
> +				 * other folios, move unmapped folios, then exit.
>  				 */
>  				if (is_large) {
>  					nr_large_failed++;
> @@ -1711,7 +1763,19 @@ static int migrate_pages_batch(struct list_head =
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
> +				/*
> +				 * The folio cannot be locked for potential deadlock.
> +				 * Go move (and unlock) all locked folios.  Then we can
> +				 * try again.
> +				 */
> +				rc_saved =3D rc;
> +				goto move;
>  			case -EAGAIN:
>  				if (is_large) {
>  					large_retry++;
> @@ -1725,6 +1789,15 @@ static int migrate_pages_batch(struct list_head =
*from, new_page_t get_new_page,
>  				stats->nr_succeeded +=3D nr_pages;
>  				stats->nr_thp_succeeded +=3D is_thp;
>  				break;
> +			case MIGRATEPAGE_UNMAP:
> +				/*
> +				 * We have locked some folios, don't force lock
> +				 * to avoid deadlock.
> +				 */
> +				force_lock =3D false;
> +				list_move_tail(&folio->lru, &unmap_folios);
> +				list_add_tail(&dst->lru, &dst_folios);
> +				break;
>  			default:
>  				/*
>  				 * Permanent failure (-EBUSY, etc.):
> @@ -1748,12 +1821,95 @@ static int migrate_pages_batch(struct list_head=
 *from, new_page_t get_new_page,
>  	nr_large_failed +=3D large_retry;
>  	stats->nr_thp_failed +=3D thp_retry;
>  	stats->nr_failed_pages +=3D nr_retry_pages;
> +move:
> +	retry =3D 1;
> +	for (pass =3D 0;
> +	     pass < NR_MAX_MIGRATE_PAGES_RETRY && (retry || large_retry);
> +	     pass++) {
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
>  		 * Move non-migrated folios (after NR_MAX_MIGRATE_PAGES_RETRY
>  		 * retries) to ret_folios to avoid migrating them again.
> @@ -1761,12 +1917,16 @@ static int migrate_pages_batch(struct list_head=
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
> +	 * We have unlocked all locked folios, so we can force lock now, let'=
s
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

After rename the variable (or give it a better name) and add the comments=
,
you can add Reviewed-by: Zi Yan <ziy@nvidia.com>

Thanks.

--
Best Regards,
Yan, Zi

--=_MailMate_83E6CE06-7886-4CF5-A90C-D9FB5B7021FC_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmPhJnAPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUjiYP+QGk3+OHXFIWSlL/pyZaFUneYzF7++wVNbMT
8GHixIhhhnTnd4gk3rztMWjM1q3un4cs6Z+k6sRzzI1KUwnjcskKme96Thz3i8W/
cmfVOETqaSLR+lUOMKILdDUREqAHrPlyQeN81zAcAZoRWhHhybDXxYkGEP/8WpFJ
Ik7+ca807npFBI8lreZn4HyqZj+EpIV3ItUvzdQbf5xrRWzFoqAnl031HlJeeseQ
W613zE/tSojg4gJCxeZkfLufQZK7EHKlSa95qt4SPfmh/FIvjkesMxJ5xACfulA5
nwUvvBy9sH4kX4O8n+hsYEuiamooUS68LtBnlzF/V1ZiOnshFj+rHVCwK9lAjKXc
5q7hjhSz/tPqThhljtBXknhDt5zIoXcDVSaz+ZtaTo//9Q8MrXNKseSrccaRzWRQ
65XF78dYSQlBgxIqzmrRJJ6LJECzi7WGPgr4c2QoCDTYNIHvHAkBGyFn5PRnqH95
Xk13BzdoDyF/hcIhbu/VO79wqLPuCuYcCIjuxHMdaZ2c20wUy559P1hQVpPYb4KP
5uHlfVAoD9zTLOlka+BEhjyNHCH01XFMF3BXw9NMCtTAdCXKUNItSI1pDOdDmOyh
d2thrOF+MCUMzffH3f/cyADb5f8/qGB8DgsJULSAvFojLuDFhp/eMBxzktHO5K1E
X4OYiTAR
=1UoN
-----END PGP SIGNATURE-----

--=_MailMate_83E6CE06-7886-4CF5-A90C-D9FB5B7021FC_=--
