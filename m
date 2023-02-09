Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70931690D9A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjBIPvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjBIPvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:51:12 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE095D3E8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 07:50:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkAur7IR/Gl7UnjyPBvpW7Qm8IFIDgCFXID813OF0OYlquBGyaz/ZNfNZMR0OSxBF1LAP1aO1NcfY1HzI+FDEzwjA97NLhawcUScIwCM29X/ba+XrwaS+GCfchKP6RNTUAAme0CXeTWnJ/UHfQ1v7IrJBGlJNlkt3gLhFLRMZsGHiUOc/7glcMkavV4pgWwfaecd+UoaVrlaAb7MpaD7j/SfOk+DyQOYRVHLZGWskF1bJzbOUvh9+2GJiOUlSh1RGDmFsGXj0F7rrOKJN2zAlk0kLBu4jR6HfSF5Vtj21j5KDGKp4q15Q5a2RGJmEE0lqEXtCJd5iwikPNP9kemcaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jErkD+ejIH/vnqxMCA78ExKcfBHp4EedOfmSTplFaI=;
 b=FC6lHUeSMLkgO4Rt7HeGP6bpuuxv0s3c09WhRiGlUDNU2lgPNadHNXyQS0AAXDxoVHoP5eiIaW0oJgBmS1P/G+AXFGlPlIM8Q6mCEpp+G/oS/Asp3uYwsdBPSI0mummBPlqycbPPiuHEGWJ1ictpG4vSqtuysO6GVcEoskpDQ3PaGHAFqN9AQ6khfEjcFnKUe1t8/aTQTUFLM67De5fqcseYAUsSzDiU10Pvf1FEJJdUemYAv0sN6s4Kc0vGvff1LZ+EKw9vv0mvIN5w87t6s/1NXoQFh9fpKEGjI5Fn5UQoEfRMC6vsCRKYZy+akNLjjmiUQb0SQNPxcr6wICD3HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jErkD+ejIH/vnqxMCA78ExKcfBHp4EedOfmSTplFaI=;
 b=Z/DjCTqNATRus85efB3+Sym1SfW1mmXQjOOcRO6PlZ4NRpgAhMdJdgF8JqB+kMsQNEnNzb2/Kyo2sB7FdE+VeM+NG+Sr2uHPEg1ES0x57zVgKw4Uh76HH0b5RCr6DZ2WGfglgQBlGWqSR6jk9RyxDK4jxdo2Kxq6OkgjhN+WyIB+DORGtbEsOH6bOd0X6trs5P8o1J3AQtffoKm7oeIojjhdKmV9yzqGY1tFWfNIr0zxXpJyBPYhK44LWdcXE3vzV5NbLZo3BtJJdOmb1WU5UntFGod2G0FAEU49cHxmuPiR4W6Sx9bWp213RbZec1TAglTut8akwtgJ6SOd7zfTag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DM6PR12MB4187.namprd12.prod.outlook.com (2603:10b6:5:212::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.19; Thu, 9 Feb 2023 15:50:54 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::7f2e:5e8:9129:8663]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::7f2e:5e8:9129:8663%4]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 15:50:54 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        david@redhat.com, vbabka@suse.cz, rppt@linux.ibm.com,
        osalvador@suse.de, rppt@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_alloc: optimize find_suitable_fallback() and
 fallbacks array
Date:   Thu, 09 Feb 2023 10:50:48 -0500
X-Mailer: MailMate (1.14r5937)
Message-ID: <4C196D76-49A9-4B06-A51F-D8A13109DF3B@nvidia.com>
In-Reply-To: <20230209101144.496144-1-yajun.deng@linux.dev>
References: <20230209101144.496144-1-yajun.deng@linux.dev>
Content-Type: multipart/signed;
 boundary="=_MailMate_471C45A4-9EC4-47CF-BDA9-3C0ED117E94A_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:208:d4::20) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DM6PR12MB4187:EE_
X-MS-Office365-Filtering-Correlation-Id: b72bcc4b-40fc-4e22-3210-08db0ab56d3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KzDkeVYzO3HDDPQmIZuNpL5jx/Yk+vY/0dwHYJjTRVJ0upM+O1v3hAcr1cmJYMATEyXJYpI2VneFqDf5U9+CllOWsT6exjku1NyJ+X0MuX2oOdkAF5MEmHIcZGCYfUT67okznPftP0bqGadGfBQII6CB+1/kshR9SYd+b6DKRNpgT1aVfuxpmQew9CcnWN/BoxGH2+5xsKi78SKeEs1qe+NSbdWaQaGOZ1JNnI5V18j2dnA+ffyYVl7y5aWe8ccTOQBpLM1orpfAffRqvU1dFQDz32v+WW7hJqhX0JFFPf2Tv0FmyBbPoiGGsoRPBXZLNRl00BZXuUhXOyMo6mryLPs4RKgOYER2EnBDMIpDPGusFCytXe4oxLxEC9mXTe7hatdixCeTw1G2yRvzIQgeyVHh2f/+Zgluv+91v2fyoqG/BLEtNBvIkDpppvKErbxolAIaGJGjBnfVppl2gu61QTX6gQ4ZK9X9lwp+cl1gLY13V3r5UDbXlJIL8vTtX4e4+UimyTkMBW0znmer3MKFxfmIkOMkuMBCt0fcQgiYIfbBQrtFZcn+/UvhXT6gY4A0nMZRjGjh7GWTC9PpuTQZ7Rkw5tTBc/1P3aSTRN3tW/yyCWudxGgjnRht1k8AK04Ai6KLRQWit4rjrtmrztnXPD51+Ub/dZNkLy5bJYWFwOTyOhMRYAAi1GGTF0XW02sfRNljbwVAVMicjpfViMikg1tzxKCmzl1U8PyAbAMTXWsl2MvVweRt+rI4IbJEB83moeJj2bD9SdJ6/2lcTsWsJcz3DdgrkedcgWkcmde9JB5y0QHjySwcakWFNODJNUIa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199018)(36756003)(2906002)(7416002)(83380400001)(2616005)(38100700002)(316002)(66946007)(66556008)(66476007)(235185007)(33656002)(5660300002)(4326008)(8936002)(8676002)(41300700001)(6916009)(26005)(186003)(6506007)(6666004)(53546011)(6512007)(478600001)(966005)(6486002)(86362001)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fXTrsRZYhmMKzDufEMYclInrktGzGUhoNIanF/l42FPWYYzLSdhfD9FMgSfI?=
 =?us-ascii?Q?wfGMUKyUpGEevaTbZFy9vB9l0VJy4ulP3c8IZXW5Lv5qGeteWe2uGJWU1a34?=
 =?us-ascii?Q?U+f2jGZyXoEvN+rGIRVP/YmlQGBuvsUrLh08EGdlK0RAqnJkgNexukFTt1HF?=
 =?us-ascii?Q?HJRABJ6W6JDoYfNjwh3Ot/+Vo63uugkDcRBpWWkMBmmQDKJLyhsaGRkU083O?=
 =?us-ascii?Q?keFerqSRPXofaE8nqUbp62JqxIn2/AG91WplwukgKxYD3EDomNlsCdEOtAjJ?=
 =?us-ascii?Q?LfObSxRgHm8YsO3qjozOBZLFHEuHrgXo2DZvL1uMDBDSk4xf0W849pj9YLvR?=
 =?us-ascii?Q?0L5002thT6CkyyAJ6sb2/Kvf5To+IETis52wtFK+2iOKZdAUsRysAg7gCLkA?=
 =?us-ascii?Q?Zyfjw+mwYODc8vtdyxZwYJY8emQV5eAWD20MSLc2+EKqveVoHbFx+9N8AhX+?=
 =?us-ascii?Q?f2YegeiKI0jXmHH38nouVJDx9YHnbEOjlmei8wjJCVi04Gap1gn+nPijUqGe?=
 =?us-ascii?Q?erdblmdW2yrVC4XnCTQOuyYErilg0Xhdngv7A7ibxpmzEVsuA4apjLXU9vE0?=
 =?us-ascii?Q?z4rRnevMIVbfdB+FOrjBsLIAnhoLLrxOb76AyfShZy2QdYrFlht36gbstOR0?=
 =?us-ascii?Q?fc6yNLS/YAqGt+8q2W/vk85a4YiGWInje6VXiRsNOjqq5Gyxs2kqUJAb23eU?=
 =?us-ascii?Q?F74K6wfuJ7PFH3G4jTQ1G+d0nIm3/r2b1l9dzcn/kzga8BiElt5DzOyWO7Md?=
 =?us-ascii?Q?3YeEa8Qf5o+eXZ7XmT94ipzJfIPu2Fxr9nL5S3/ejJ5m/R9hw3bviznMNxJw?=
 =?us-ascii?Q?WKvvt2QxmMR3LGWdxei4NnvX/gwQCh6Zh/ZFpXf/rx8ke+bvLoyfa052AWA2?=
 =?us-ascii?Q?JehKSam95uy914d2hcdAFhO5Iq+/lhdQj9rjcUnBlr+BgAFDuyu/QyEtdhTB?=
 =?us-ascii?Q?do9UxGJ/upE6RoIGghwiFNyr7QqKAbeKiHOGHupKnvG1xEwBzxpXpkTfRc2F?=
 =?us-ascii?Q?SRdSE/JP4vRvhW8+D9l8ULOP7XTVLs9xVnQ1mKieLn7IqMRNbBqYKT1vMzW5?=
 =?us-ascii?Q?g6s1Ri3x4dTfBa4eMuozTiEA8OxZ/CCjZ6TzuOb+XOOjNGJwqPmGYINXkTYF?=
 =?us-ascii?Q?fgaKoPzggsIEJpfPpUN2uRw0AKeW8Kn+6N+nLdgDtLIb05wCIwzj+xo2fGgo?=
 =?us-ascii?Q?PmIyp7eTCio3+6sACyVyCwdgfPyFHOKXel0DTxcvXbiEl2MzCQKJDMwRN41z?=
 =?us-ascii?Q?Wb7yRB3gFJ01MIPkrhDD9WfYUeMxeLJCxbBnifsQeprySoxYbGLYgmZ+NKoa?=
 =?us-ascii?Q?ie3wlntn6N5rNykl9Njq4bVorsUCheuHfUjmg2hOv3XpbKS+zKJWAUlf+wXw?=
 =?us-ascii?Q?UrFYtejT5hbvMlgP0QVfwN2xf3j6XTS28Be3ju9LoWd3jWOpJLiPOlg8XSmc?=
 =?us-ascii?Q?RAsqa8XZEpU1AuxcU0RNz7tZFGfA5bnwemUWQPLt0zYbi19ihfe9FXchqNJO?=
 =?us-ascii?Q?pBXXJMQfM4R/jA0ebZVTlykg1jl9I9yJcii0PMg2HkPU4yeq0bRztl/YpUS9?=
 =?us-ascii?Q?xy+HywH57R7aLqNffbdRIhLh10D4X3k+MqAhoU7o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b72bcc4b-40fc-4e22-3210-08db0ab56d3e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 15:50:54.3707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: frlBQaiY2w8FPdSFGr8vAyne6pBNVPMG+B9kzwp6gddHCeQaOtGP1qMlCv/LJM0y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4187
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_471C45A4-9EC4-47CF-BDA9-3C0ED117E94A_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 9 Feb 2023, at 5:11, Yajun Deng wrote:

> There is no need to execute the next loop if it not return in the first=

> loop. So add a break at the end of the loop.

Can you explain why? If it is the case, MIGRATE_UNMOVABLE cannot fall bac=
k
to MIGRATE_MOVABLE? And MIGRATE_MOVABLE cannot fall back to MIGRATE_UNMOV=
ABLE?
And MIGRATE_RECLAIMABLE cannot fall back to MIGRATE_MOVABLE?

>
> At the same time, add !migratetype_is_mergeable() before the loop and
> reduce the first index size from MIGRATE_TYPES to MIGRATE_PCPTYPES in
> fallbacks array.

You sent a patch: https://lore.kernel.org/all/20230203100132.1627787-1-ya=
jun.deng@linux.dev/T/#u, why not squash this one into that? Why do
we need two separate small patches working on the same code?

Thanks.
>
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/mmzone.h |  2 +-
>  mm/page_alloc.c        | 11 +++++------
>  2 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index ab94985ee7d9..0a817b8c7fb2 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -85,7 +85,7 @@ static inline bool is_migrate_movable(int mt)
>   * Check whether a migratetype can be merged with another migratetype.=

>   *
>   * It is only mergeable when it can fall back to other migratetypes fo=
r
> - * allocation. See fallbacks[MIGRATE_TYPES][3] in page_alloc.c.
> + * allocation. See fallbacks[][] array in page_alloc.c.
>   */
>  static inline bool migratetype_is_mergeable(int mt)
>  {
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 1113483fa6c5..536e8d838fb5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2603,7 +2603,7 @@ struct page *__rmqueue_smallest(struct zone *zone=
, unsigned int order,
>   *
>   * The other migratetypes do not have fallbacks.
>   */
> -static int fallbacks[MIGRATE_TYPES][MIGRATE_PCPTYPES - 1] =3D {
> +static int fallbacks[MIGRATE_PCPTYPES][MIGRATE_PCPTYPES - 1] =3D {
>  	[MIGRATE_UNMOVABLE]   =3D { MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE   },=

>  	[MIGRATE_MOVABLE]     =3D { MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE },=

>  	[MIGRATE_RECLAIMABLE] =3D { MIGRATE_UNMOVABLE,   MIGRATE_MOVABLE   },=

> @@ -2861,7 +2861,7 @@ int find_suitable_fallback(struct free_area *area=
, unsigned int order,
>  	int i;
>  	int fallback_mt;
>
> -	if (area->nr_free =3D=3D 0)
> +	if (area->nr_free =3D=3D 0 || !migratetype_is_mergeable(migratetype))=

>  		return -1;
>
>  	*can_steal =3D false;
> @@ -2873,11 +2873,10 @@ int find_suitable_fallback(struct free_area *ar=
ea, unsigned int order,
>  		if (can_steal_fallback(order, migratetype))
>  			*can_steal =3D true;
>
> -		if (!only_stealable)
> -			return fallback_mt;
> -
> -		if (*can_steal)
> +		if (!only_stealable || *can_steal)
>  			return fallback_mt;
> +		else
> +			break;
>  	}
>
>  	return -1;
> -- =

> 2.25.1

--
Best Regards,
Yan, Zi

--=_MailMate_471C45A4-9EC4-47CF-BDA9-3C0ED117E94A_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmPlFlgPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUGpoP/01J4MmTPXSU5BrbKW6Rv/wZo1pPBMsV1Mke
P6NWz4qVVtr9V82fw+XYIeWJaY3AooXU7N59qTQzZjYcari265Eg7iZCf8QtZI3j
33j+Bf/cqKxcvV5I/cxmIiUE35b4Y+62ndM/KwrqaZ+0NDuDfhTIdPrnvZrC8/wS
3jMciKdivVc1JRvLOU+Lc251ekv67wNgdJR4Jz9tfUearb32H2xewdt6flW1HBuf
Zfo5pUhFloAfVa7PIR/uvqgyXsi+Ug/WWSDX/oL3inFV5gEFwNHWDZb66ytmACwc
OVGVe6G5ZCZM8MWvpl+ykPg3aMWmtSAJakvZE3SiR0Zd57IqCLqrzMLhJ2ED6tSf
nTvLaNjUsLsGUVR7KMo1UmXteLgG52ZNCimiVKIyvR8+CK29fsAJujBGHUL+WvGc
unSw+VysN5gLSzxlq18SMcn25jguvrAaGyFgIcvPrfAup0Cemp5ywLZRqmKa/YHN
+NuXLI2Mh9+GWGLT82c5i/PVshTglHhgcwU+w/3VT+m0Be67F/0536AN5URxmoQs
Ccv8iOsncD8a3gisoHwAQN/mTBobOO6MkxuMlkZvoLBTmwDGK7bFdiqQXgVIqQ6Y
bMmVzIGT0um6Iq+vQr9tuvsF+EERvT1XPXTQRHbLYdgyRd2fwSkYVyPy/sFCNL18
KdcGFglm
=rmFP
-----END PGP SIGNATURE-----

--=_MailMate_471C45A4-9EC4-47CF-BDA9-3C0ED117E94A_=--
