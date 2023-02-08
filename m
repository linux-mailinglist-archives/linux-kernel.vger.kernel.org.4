Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF1A68F845
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 20:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjBHTrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 14:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBHTrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 14:47:43 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227221C7E8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:47:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUgJn1PDkXJzljT3HKACuaFkht4dCY4RnUOvMmimHLPpd8A4kTD1AFaBrCC54QnsnlJVbjcwUpN3H2Gz8dH1cOnUBYUWfM7jhY6oAtKtk9Jt+0lSCYpwR1mwEDWTzaIQKpMNY9i1bGYcyj8+9N+QDwv/Mv3sngM9eZYfYthY/rn6Bk45q1LJAZ18Rdj2m8pu58+Rp2Q5zNa156v/v82Uxbz1EFzhyFcHCOjkUKMr0+3X9RwJBeMM0kcY+sX0upe1HpTmSKCDmsxOOXyU9O0FYZxpCCC62CMQTfCfnnyTydHfvKyRYYkfbw4GelxcZd7RPlfK6zupGw2eLjetp+y3VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMf44OITi7qD0yNlK+Ejc7aJaCOOjiRyeQ0CVVa/1eY=;
 b=BLsvlQBFWWSR1DQxVPXzH1qgTKd0BmrNZBD/Vq28anbMCBGcn93EzJOtd7d9+RPshgzwLk+K9BbETu30BD5mM2IvyghrOWS8ME7C5ElNIMFs/0Rh9cn9kXpl/QSyevtjcvz5+ymHCvYPGfy72dpeno9aiLXPdfFChbm8+m9NYp01+Jv6m/MhRxDq2hCmkHamfN0AWJScvE3dRLJXhMysQW4qxH3kGsZfv3wY8GbsjiJhW7fDGepvowaIq+gdQX5HOUa5YrzH6U7rOhcNyUreFPaskMHiA9uUk4qBbnLQM0E78HWaBLg54eODmLo5Pv1sWSZ1GTHcd9n6j8dLOX8kqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMf44OITi7qD0yNlK+Ejc7aJaCOOjiRyeQ0CVVa/1eY=;
 b=imTowIJsAMl1KJNjWzHTVf30qMnnihP6IVNG8ypc5xGlQRImia4D3cKXby2/IcanUBSM7DvIOhW19tpLkZi0I/vzTD7GAhmd0dGmOXTZFi1pLdpYDvR64D5k3GaWCewyHYrWlAHoFEklEIE+0f9V4nAqAA+HzCS5BeDshiWWJkGc1NxgEU6acd3SW8Gpv2hz70xqeDNLjWo8m415Sp6mmRHpYwvGcLiDSqsTcIxdrwQwvgjDOKuXQLI9tC69+zwRZLdGryKw6zy90DRLTFLYWcVVV/PNqIhve+XUrRAWLwJwZZRsXR5YfDZjsTQcusMVxhL9LqF6XY1QhX07n/zutg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.17; Wed, 8 Feb 2023 19:47:38 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::7f2e:5e8:9129:8663]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::7f2e:5e8:9129:8663%4]) with mapi id 15.20.6086.017; Wed, 8 Feb 2023
 19:47:37 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "Huang, Ying" <ying.huang@intel.com>
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
Date:   Wed, 08 Feb 2023 14:47:35 -0500
X-Mailer: MailMate (1.14r5937)
Message-ID: <475B26C7-8BA8-4647-BDB0-25C805FD5ACC@nvidia.com>
In-Reply-To: <87zg9ofjr9.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20230206063313.635011-1-ying.huang@intel.com>
 <20230206063313.635011-8-ying.huang@intel.com>
 <C4525F0D-C4DB-4584-A290-DFFC8F1BAE3C@nvidia.com>
 <87zg9ofjr9.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_0A286AA6-E1F6-4D70-9EEB-3CAAA3425B6F_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR19CA0054.namprd19.prod.outlook.com
 (2603:10b6:208:19b::31) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DM6PR12MB4251:EE_
X-MS-Office365-Filtering-Correlation-Id: 281fc17a-7b07-4db5-3aa2-08db0a0d54bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LTTITk4nRKKuYOJr50WQmBgk5HoKb/j6Cc3bYSQTXyixMNxwiDkz/nSWFS/DrGf1jB7aXHLgZCbnnpH5dSHnjo9dbGtkt7Q/U0vHgxLmarwjevMwPxOnJyCLXB6mg0sKlhyJyQk6PgfPDq8uugQ63TVC0ozegi/MILIHe0zUzz5nFS9e4SxEKNrwhjX/qXIjaKOntmyPIfboBCAiflixCfICLM8c3DfDAs0Kz2mu2swh7w0VnltEraozD/9PcdKNecbKsuQWuN/P5SbgjcXLN2qVHCuMIjIIbcMuaJq84taEf5dnVT6JqrJ1m0uF/pypZ8l4UWknOHIkMo5UqetDqp41B4lBgH/3JB+jvcgUzk7CIslGKeaWz/DwcCWZo5BD50NAUqDiAYGsH2dADNUXClGXc6f4wQxC1ulduERuvJIK8Qqsl5nfFaFRt4eklAKie+AW87JEcDze2fRJ4hETHXmjaVnl9ouMitD4ho7Avd2igjthxO0Uu5/ZlGoFS9Zw2B1Yy+LzAWQBmtYEvJmBZuPfJoQ0QL4k5BpQSA+X9AuxeRDDiWiGsATUzJJ6E9oR+apkNTMz2Bc7p3jE/HDhM0rOa2rxSi3qIq6f1kJU1OZLk3TG17Uh9Yd6Tnt9VtuFJzd4k0MCoSRcaANIabolHnxMRNjS7OJX6Z2WMidWYKoD4jBEAJ8DvAJOmwIg4MPPJNYJa1YjFcwE0tVJJll1cQR3g7qPWFE6KVNolQtB7fs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(451199018)(36756003)(83380400001)(33656002)(4326008)(6916009)(8676002)(66556008)(66476007)(2906002)(86362001)(30864003)(66946007)(38100700002)(41300700001)(478600001)(6486002)(53546011)(2616005)(6506007)(54906003)(316002)(235185007)(7416002)(8936002)(5660300002)(186003)(26005)(6512007)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?05U4NVEa8QbXTLRPy1d+a9zo9CWXX8YaDiJTEQuy0HGl7cKZhvoWgglFUdLr?=
 =?us-ascii?Q?v2Hy3j8JcHXR61HgF+Yj3D1uJPRc5n9cnGzmbtDokcDeNXE3kp7EE2UJQx4T?=
 =?us-ascii?Q?zpiJ0Hc8RstHSriqeM+8tjV2i639VUpoOUtW5ygBcUJk+FGJXrL+YaCSjn9o?=
 =?us-ascii?Q?oZC8YmjKYNQ+tFOe4s42A33hINXHv9G8VXCyQw1b/WP/2MCefu8nJ2vcSCch?=
 =?us-ascii?Q?pTtF5SPtKnX8BoE7hIaBWzSxh/cYGo2nAJGYiES455Nq5QiZRT+tGgzBfaRl?=
 =?us-ascii?Q?F439PvxmD2dv2sUTcgYG0dRfy+ST3AuYd3aD2tMGH0tKUe68JyDYXTjyNNjC?=
 =?us-ascii?Q?56SEHXcRUxtS9HO0dRfZANZCu8W2V8KFAXwJr6QIsYqOdl5Z9d5a19XEzO08?=
 =?us-ascii?Q?GG4Ib0SvM2AmLFmZul3aNyKyhg61WdlXGtjXZ2NT2NBCbxiU0Fge210Jm/wF?=
 =?us-ascii?Q?S1ObwbRUdqljC0e13cIg90ycKFkQdo7YQJAs+ja3FnyTfsJCygiQs8mY5gGl?=
 =?us-ascii?Q?eWvUzYEUDGjTx05NUebg5JG/jroCa4Qog/FDqCU0CtJV0ZuYKzznFOJhQaC0?=
 =?us-ascii?Q?6XlpCZyHMeYTOAA7BLm9ZXIQUiHsOiXL7+ztEfF14QMb2zpMVLi9WWfZi4+n?=
 =?us-ascii?Q?9oFGVu78LmS4Urip6oxDPv+dyO/gaCfPz466B8YwR1DvXpjxdNrXsxT0U4mm?=
 =?us-ascii?Q?rweI5iAB2ElIqREdsKs2fTN2W5ipwm5Up0+DQr8MWEOshr+Ac+6ffwUEdGTg?=
 =?us-ascii?Q?6/iQ8P/i9Ua0h9QIPcUk1r89VWtJiKQDxCjr0fnHp4i/LH9h94q4sJVwE2BG?=
 =?us-ascii?Q?AEw5fn/uPQR8Edo3TqSp39F6wLz+wuvxUjFnMe5+glBEnK8hqpzl/Gycrxg5?=
 =?us-ascii?Q?3CWWPZepptxxIIQXOofWISHLELA32lXWus8GAYXSSuwZqparRcvlhmeKHb7Z?=
 =?us-ascii?Q?nMaNbFfvatUtGLfOfAOLJTY3Ux9VeqyiQloTL1GARiQWtKB7qIJwJvfKFA/8?=
 =?us-ascii?Q?k4vA/qi1nvYmEjgdgwFADHAcNHzT2a3LzytcNaUuYqa8bz0GgK7/Pbfp1uR5?=
 =?us-ascii?Q?nOoYCPBFGdMTDhco6+uY24xT3hn2HKOFRP+BY5TSc2qWH64KxGlmJZGCxsvZ?=
 =?us-ascii?Q?JTv/s6IABDHttlQ9rhIfickdJfB10yxIfwUGtfwoa9Zhg04qxHFQWwve8Yya?=
 =?us-ascii?Q?un9zyOtpUM6qOBiFZEcYSqJsJhymMtpivVFvT24q/faJpFw/yd1IYw8+lUvd?=
 =?us-ascii?Q?WfZLPSQ+DApgnhxRsxPQmt1zvZY6tKZ3Syi3MRpPvTPm/RKz6dZbTiXICZpc?=
 =?us-ascii?Q?qgYCKzSScTfsP+F4NJWxWSZQpXMr1ThMJHi0gfZ0XzzbEP9fQaLTU+Az9E2y?=
 =?us-ascii?Q?8DuZo4wiXBi+ggP2Osq+rDilzKL1jl5sKDb6t+VFhRMeUjAP0eXemGOIJK59?=
 =?us-ascii?Q?mPCeEv8BdEYYPV59hkmrRW8C+EBFZFZuD3pEEOe1lU1AWyAln0j+H5UNzj4X?=
 =?us-ascii?Q?K3kKPTKVq5IMtRRfBK7X7XirPXlmQNGt3zMxYFUzxQJOI2OVUwpfPLODYuUr?=
 =?us-ascii?Q?Knw94I4GmH2JPvKg1PjLVmFpkg/20EOiIHyotUSI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 281fc17a-7b07-4db5-3aa2-08db0a0d54bd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 19:47:37.7784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/IJhIF9tpE8FgmVENAa2EujeEejhiglgu4poKaIpssULrE9iLKHyITDRy2FPYsZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4251
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_0A286AA6-E1F6-4D70-9EEB-3CAAA3425B6F_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 8 Feb 2023, at 7:02, Huang, Ying wrote:

> Zi Yan <ziy@nvidia.com> writes:
>
>> On 6 Feb 2023, at 1:33, Huang Ying wrote:
>>
>>> This is a code cleanup patch to reduce the duplicated code between th=
e
>>> _unmap and _move stages of migrate_pages().  No functionality change
>>> is expected.
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
>>> Cc: Minchan Kim <minchan@kernel.org>
>>> Cc: Mike Kravetz <mike.kravetz@oracle.com>
>>> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>>> ---
>>>  mm/migrate.c | 203 ++++++++++++++++++++-----------------------------=
--
>>>  1 file changed, 81 insertions(+), 122 deletions(-)
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index 23eb01cfae4c..9378fa2ad4a5 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -1037,6 +1037,7 @@ static void __migrate_folio_extract(struct foli=
o *dst,
>>>  static void migrate_folio_undo_src(struct folio *src,
>>>  				   int page_was_mapped,
>>>  				   struct anon_vma *anon_vma,
>>> +				   bool locked,
>>>  				   struct list_head *ret)
>>>  {
>>>  	if (page_was_mapped)
>>> @@ -1044,16 +1045,20 @@ static void migrate_folio_undo_src(struct fol=
io *src,
>>>  	/* Drop an anon_vma reference if we took one */
>>>  	if (anon_vma)
>>>  		put_anon_vma(anon_vma);
>>> -	folio_unlock(src);
>>> -	list_move_tail(&src->lru, ret);
>>> +	if (locked)
>>> +		folio_unlock(src);
>>
>> Having a comment would be better.
>> /* A page that has not been migrated, move it to a list for later rest=
oration */
>
> Emm... the page state has been restored in the previous operations of
> the function.  This is the last step and the page will be moved to
> "return" list, then the caller of migrate_pages() will call
> putback_movable_pages().

But if (rc =3D=3D -EAGAIN || rc =3D=3D -EDEADLOCK) then ret will be NULL,=
 thus the page
will not be put back, right? And for both cases, the src page state is no=
t
changed at all. So probably only call migrate_folio_undo_src() when
(rc !=3D -EAGAIN && rc !=3D -EDEADLOCK)? And still require ret to be non =
NULL.

>
> We have some comments for the function (migrate_folio_undo_src()) as
> follows,
>
> /* Restore the source folio to the original state upon failure */
>
>>> +	if (ret)
>>> +		list_move_tail(&src->lru, ret);
>>>  }
>>>
>>>  /* Restore the destination folio to the original state upon failure =
*/
>>>  static void migrate_folio_undo_dst(struct folio *dst,
>>> +				   bool locked,
>>>  				   free_page_t put_new_page,
>>>  				   unsigned long private)
>>>  {
>>> -	folio_unlock(dst);
>>> +	if (locked)
>>> +		folio_unlock(dst);
>>>  	if (put_new_page)
>>>  		put_new_page(&dst->page, private);
>>>  	else
>>> @@ -1078,13 +1083,42 @@ static void migrate_folio_done(struct folio *=
src,
>>>  		folio_put(src);
>>>  }
>>>
>>> -static int __migrate_folio_unmap(struct folio *src, struct folio *ds=
t,
>>> -				 int force, bool force_lock, enum migrate_mode mode)
>>> +/* Obtain the lock on page, remove all ptes. */
>>> +static int migrate_folio_unmap(new_page_t get_new_page, free_page_t =
put_new_page,
>>> +			       unsigned long private, struct folio *src,
>>> +			       struct folio **dstp, int force, bool force_lock,
>>> +			       enum migrate_mode mode, enum migrate_reason reason,
>>> +			       struct list_head *ret)
>>>  {
>>> +	struct folio *dst;
>>>  	int rc =3D -EAGAIN;
>>> +	struct page *newpage =3D NULL;
>>>  	int page_was_mapped =3D 0;
>>>  	struct anon_vma *anon_vma =3D NULL;
>>>  	bool is_lru =3D !__PageMovable(&src->page);
>>> +	bool locked =3D false;
>>> +	bool dst_locked =3D false;
>>> +
>>> +	if (!thp_migration_supported() && folio_test_transhuge(src))
>>> +		return -ENOSYS;
>>> +
>>> +	if (folio_ref_count(src) =3D=3D 1) {
>>> +		/* Folio was freed from under us. So we are done. */
>>> +		folio_clear_active(src);
>>> +		folio_clear_unevictable(src);
>>> +		/* free_pages_prepare() will clear PG_isolated. */
>>> +		list_del(&src->lru);
>>> +		migrate_folio_done(src, reason);
>>> +		return MIGRATEPAGE_SUCCESS;
>>> +	}
>>> +
>>> +	newpage =3D get_new_page(&src->page, private);
>>> +	if (!newpage)
>>> +		return -ENOMEM;
>>> +	dst =3D page_folio(newpage);
>>> +	*dstp =3D dst;
>>> +
>>> +	dst->private =3D NULL;
>>>
>>>  	if (!folio_trylock(src)) {
>>>  		if (!force || mode =3D=3D MIGRATE_ASYNC)
>>> @@ -1119,6 +1153,7 @@ static int __migrate_folio_unmap(struct folio *=
src, struct folio *dst,
>>>
>>>  		folio_lock(src);
>>>  	}
>>> +	locked =3D true;
>>>
>>>  	if (folio_test_writeback(src)) {
>>>  		/*
>>> @@ -1133,10 +1168,10 @@ static int __migrate_folio_unmap(struct folio=
 *src, struct folio *dst,
>>>  			break;
>>>  		default:
>>>  			rc =3D -EBUSY;
>>> -			goto out_unlock;
>>> +			goto out;
>>>  		}
>>>  		if (!force)
>>> -			goto out_unlock;
>>> +			goto out;
>>>  		folio_wait_writeback(src);
>>>  	}
>>>
>>> @@ -1166,7 +1201,8 @@ static int __migrate_folio_unmap(struct folio *=
src, struct folio *dst,
>>>  	 * This is much like races on refcount of oldpage: just don't BUG()=
=2E
>>>  	 */
>>>  	if (unlikely(!folio_trylock(dst)))
>>> -		goto out_unlock;
>>> +		goto out;
>>> +	dst_locked =3D true;
>>>
>>>  	if (unlikely(!is_lru)) {
>>>  		__migrate_folio_record(dst, page_was_mapped, anon_vma);
>>> @@ -1188,7 +1224,7 @@ static int __migrate_folio_unmap(struct folio *=
src, struct folio *dst,
>>>  	if (!src->mapping) {
>>>  		if (folio_test_private(src)) {
>>>  			try_to_free_buffers(src);
>>> -			goto out_unlock_both;
>>> +			goto out;
>>>  		}
>>>  	} else if (folio_mapped(src)) {
>>>  		/* Establish migration ptes */
>>> @@ -1203,74 +1239,26 @@ static int __migrate_folio_unmap(struct folio=
 *src, struct folio *dst,
>>>  		return MIGRATEPAGE_UNMAP;
>>>  	}
>>>
>>> -	if (page_was_mapped)
>>> -		remove_migration_ptes(src, src, false);
>>> -
>>> -out_unlock_both:
>>> -	folio_unlock(dst);
>>> -out_unlock:
>>> -	/* Drop an anon_vma reference if we took one */
>>> -	if (anon_vma)
>>> -		put_anon_vma(anon_vma);
>>> -	folio_unlock(src);
>>>  out:
>>> -
>>> -	return rc;
>>> -}
>>> -
>>> -/* Obtain the lock on page, remove all ptes. */
>>> -static int migrate_folio_unmap(new_page_t get_new_page, free_page_t =
put_new_page,
>>> -			       unsigned long private, struct folio *src,
>>> -			       struct folio **dstp, int force, bool force_lock,
>>> -			       enum migrate_mode mode, enum migrate_reason reason,
>>> -			       struct list_head *ret)
>>> -{
>>> -	struct folio *dst;
>>> -	int rc =3D MIGRATEPAGE_UNMAP;
>>> -	struct page *newpage =3D NULL;
>>> -
>>> -	if (!thp_migration_supported() && folio_test_transhuge(src))
>>> -		return -ENOSYS;
>>> -
>>> -	if (folio_ref_count(src) =3D=3D 1) {
>>> -		/* Folio was freed from under us. So we are done. */
>>> -		folio_clear_active(src);
>>> -		folio_clear_unevictable(src);
>>> -		/* free_pages_prepare() will clear PG_isolated. */
>>> -		list_del(&src->lru);
>>> -		migrate_folio_done(src, reason);
>>> -		return MIGRATEPAGE_SUCCESS;
>>> -	}
>>> -
>>> -	newpage =3D get_new_page(&src->page, private);
>>> -	if (!newpage)
>>> -		return -ENOMEM;
>>> -	dst =3D page_folio(newpage);
>>> -	*dstp =3D dst;
>>> -
>>> -	dst->private =3D NULL;
>>> -	rc =3D __migrate_folio_unmap(src, dst, force, force_lock, mode);
>>> -	if (rc =3D=3D MIGRATEPAGE_UNMAP)
>>> -		return rc;
>>> -
>>>  	/*
>>>  	 * A page that has not been migrated will have kept its
>>>  	 * references and be restored.
>>>  	 */
>>>  	/* restore the folio to right list. */
>>
>> This comment is stale. Probably should be
>> /* Keep the folio and we will try it again later */
>
> Good catch!  Will revise this in the next version.
>
> Best Regards,
> Huang, Ying
>
>>> -	if (rc !=3D -EAGAIN && rc !=3D -EDEADLOCK)
>>> -		list_move_tail(&src->lru, ret);
>>> +	if (rc =3D=3D -EAGAIN || rc =3D=3D -EDEADLOCK)
>>> +		ret =3D NULL;
>>>
>>> -	if (put_new_page)
>>> -		put_new_page(&dst->page, private);
>>> -	else
>>> -		folio_put(dst);
>>> +	migrate_folio_undo_src(src, page_was_mapped, anon_vma, locked, ret)=
;
>>> +	migrate_folio_undo_dst(dst, dst_locked, put_new_page, private);
>>>
>>>  	return rc;
>>>  }
>>>
>>> -static int __migrate_folio_move(struct folio *src, struct folio *dst=
,
>>> -				enum migrate_mode mode)
>>> +/* Migrate the folio to the newly allocated folio in dst. */
>>> +static int migrate_folio_move(free_page_t put_new_page, unsigned lon=
g private,
>>> +			      struct folio *src, struct folio *dst,
>>> +			      enum migrate_mode mode, enum migrate_reason reason,
>>> +			      struct list_head *ret)
>>>  {
>>>  	int rc;
>>>  	int page_was_mapped =3D 0;
>>> @@ -1283,12 +1271,8 @@ static int __migrate_folio_move(struct folio *=
src, struct folio *dst,
>>>  	list_del(&dst->lru);
>>>
>>>  	rc =3D move_to_new_folio(dst, src, mode);
>>> -
>>> -	if (rc =3D=3D -EAGAIN) {
>>> -		list_add(&dst->lru, prev);
>>> -		__migrate_folio_record(dst, page_was_mapped, anon_vma);
>>> -		return rc;
>>> -	}
>>> +	if (rc)
>>> +		goto out;
>>>
>>>  	if (unlikely(!is_lru))
>>>  		goto out_unlock_both;
>>> @@ -1302,70 +1286,45 @@ static int __migrate_folio_move(struct folio =
*src, struct folio *dst,
>>>  	 * unsuccessful, and other cases when a page has been temporarily
>>>  	 * isolated from the unevictable LRU: but this case is the easiest.=

>>>  	 */
>>> -	if (rc =3D=3D MIGRATEPAGE_SUCCESS) {
>>> -		folio_add_lru(dst);
>>> -		if (page_was_mapped)
>>> -			lru_add_drain();
>>> -	}
>>> +	folio_add_lru(dst);
>>> +	if (page_was_mapped)
>>> +		lru_add_drain();
>>>
>>>  	if (page_was_mapped)
>>> -		remove_migration_ptes(src,
>>> -			rc =3D=3D MIGRATEPAGE_SUCCESS ? dst : src, false);
>>> +		remove_migration_ptes(src, dst, false);
>>>
>>>  out_unlock_both:
>>>  	folio_unlock(dst);
>>> -	/* Drop an anon_vma reference if we took one */
>>> -	if (anon_vma)
>>> -		put_anon_vma(anon_vma);
>>> -	folio_unlock(src);
>>> +	set_page_owner_migrate_reason(&dst->page, reason);
>>>  	/*
>>>  	 * If migration is successful, decrease refcount of dst,
>>>  	 * which will not free the page because new page owner increased
>>>  	 * refcounter.
>>>  	 */
>>> -	if (rc =3D=3D MIGRATEPAGE_SUCCESS)
>>> -		folio_put(dst);
>>> -
>>> -	return rc;
>>> -}
>>> -
>>> -/* Migrate the folio to the newly allocated folio in dst. */
>>> -static int migrate_folio_move(free_page_t put_new_page, unsigned lon=
g private,
>>> -			      struct folio *src, struct folio *dst,
>>> -			      enum migrate_mode mode, enum migrate_reason reason,
>>> -			      struct list_head *ret)
>>> -{
>>> -	int rc;
>>> -
>>> -	rc =3D __migrate_folio_move(src, dst, mode);
>>> -	if (rc =3D=3D MIGRATEPAGE_SUCCESS)
>>> -		set_page_owner_migrate_reason(&dst->page, reason);
>>> -
>>> -	if (rc !=3D -EAGAIN) {
>>> -		/*
>>> -		 * A folio that has been migrated has all references
>>> -		 * removed and will be freed. A folio that has not been
>>> -		 * migrated will have kept its references and be restored.
>>> -		 */
>>> -		list_del(&src->lru);
>>> -	}
>>> +	folio_put(dst);
>>>
>>>  	/*
>>> -	 * If migration is successful, releases reference grabbed during
>>> -	 * isolation. Otherwise, restore the folio to right list unless
>>> -	 * we want to retry.
>>> +	 * A page that has been migrated has all references removed
>>> +	 * and will be freed.
>>>  	 */
>>> -	if (rc =3D=3D MIGRATEPAGE_SUCCESS) {
>>> -		migrate_folio_done(src, reason);
>>> -	} else if (rc !=3D -EAGAIN) {
>>> -		list_add_tail(&src->lru, ret);
>>> +	list_del(&src->lru);
>>> +	/* Drop an anon_vma reference if we took one */
>>> +	if (anon_vma)
>>> +		put_anon_vma(anon_vma);
>>> +	folio_unlock(src);
>>> +	migrate_folio_done(src, reason);
>>>
>>> -		if (put_new_page)
>>> -			put_new_page(&dst->page, private);
>>> -		else
>>> -			folio_put(dst);
>>> +	return rc;
>>> +out:
>>> +	if (rc =3D=3D -EAGAIN) {
>>> +		list_add(&dst->lru, prev);
>>> +		__migrate_folio_record(dst, page_was_mapped, anon_vma);
>>> +		return rc;
>>>  	}
>>>
>>> +	migrate_folio_undo_src(src, page_was_mapped, anon_vma, true, ret);
>>> +	migrate_folio_undo_dst(dst, true, put_new_page, private);
>>> +
>>>  	return rc;
>>>  }
>>>
>>> @@ -1897,9 +1856,9 @@ static int migrate_pages_batch(struct list_head=
 *from, new_page_t get_new_page,
>>>
>>>  		__migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
>>>  		migrate_folio_undo_src(folio, page_was_mapped, anon_vma,
>>> -				       ret_folios);
>>> +				       true, ret_folios);
>>>  		list_del(&dst->lru);
>>> -		migrate_folio_undo_dst(dst, put_new_page, private);
>>> +		migrate_folio_undo_dst(dst, true, put_new_page, private);
>>>  		dst =3D dst2;
>>>  		dst2 =3D list_next_entry(dst, lru);
>>>  	}
>>> -- =

>>> 2.35.1
>>
>> Everything else looks good to me, just need to fix the two comments ab=
ove.
>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>>
>> --
>> Best Regards,
>> Yan, Zi


--
Best Regards,
Yan, Zi

--=_MailMate_0A286AA6-E1F6-4D70-9EEB-3CAAA3425B6F_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmPj/FcPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUFJoP/iqamcUbGSretNovJNx9WMTsw8l/vujuGpeP
p2aocENaBbknc+d2/XDjwIjMaj2beuZLFZ4J/tYa6HXbbRvlhsge3jHg+8I8+dIv
lFfZNE0hsYqBYo+Woei6kntKTByAGWCjdlTwCcj/+OHS2JNhHrttyXX5SGM284yO
2dJLYcvlFYmbT8ACHtT9mw1RB8LsxeYRCF4U39azTU2uo0dUzTRMZX8AwY4zDzZ2
KK9HlTWtd8PwWju15WHp396irsLdlJQsC3inE9y3KHNJrud97LFMHGeDrTAuZR8F
sFuzhx0wo/jOparPw8l/wV1+hlcvvPF+6o33Rl8e+1oZJx1Bv2jYEOWhHzTtVc11
9nWDP/eZFLejWU5SJsmuhumDgZgtAXqpCLDYBzLMajtEy6DPx8cmNJkigvbuu6H6
3kG/PDtRbhP7edGGNgXp9Q3bxhowGAbamfIGhdSjmlAdzVQOzX5Xk4r9hy7BeSGq
lFHLsEUjyf/CyhrYKI7H2vVTd8TTyGeXRXXNYSpDsl0xcfuem8Hd8Ls4r2EPxPRs
Z3rmQy0aWkY3DfSxcfREi7hIowhZSPgeUGe2aEY56ZoDhiAvP0dJwz/SiJoZbUQY
y86uzINGdxkBkkhXhjiMV+qvlS9Sr0tPzDBkXn5N0dOjvdp7+ev1Vds+cRnBJl6l
zSj+D6Ms
=Rk35
-----END PGP SIGNATURE-----

--=_MailMate_0A286AA6-E1F6-4D70-9EEB-3CAAA3425B6F_=--
