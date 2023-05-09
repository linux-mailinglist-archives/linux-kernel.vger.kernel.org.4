Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330FA6FC8E4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbjEIO0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235906AbjEIO0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:26:17 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BEA359D
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 07:25:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FglMg66t4/S46rROrEbU16QX3/6yyXnZ5z1aXwFxdCFRsAcNsujRjrR/vIZ25qhaNHWHb3o6qeEnpSyv1bNsG+8aSwy+WtsGiqA5OmByThw3sQ+yRYMQLtWm9kYeWAyewrE26S3/cOlbZnAZvKADZ85qBETf9w9Z4aJl35CNUHC69Fi4iplCZ3IG/Yx/nUG0U+yxnaiUxOg+KmG/hxJktCOGsH3PlCx2bLBJXwXwiTnTaBXRk9Z9fMehZMq+d2NtgBTdFvr2ql6qHrvY0i3rLHXOdutjpAp1YJzHeS3VCLIeNstUsm9GTIbex7XImr7tk8ki6Fc6wL4FexUgVv14hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7wQ7cvystEx9HUeGeZ7Bv2urACEGyWoMD6puyBcNWc=;
 b=K+Y9G7o/D88OyemzDzzEzRILMC1Ee2HHu3f5/A6DKeUn+HrAhILAj1VTQknDzB6wDQX8sD7jzSPt/YiV1hAbivZBhfM4BA1nxUZAiS+m+tfMcJ69cSXoCIh7dKr995acjBdXoPkXF1Y3fWDcBWkqIGn2Ytj8hGaPRYyOAwdmHv00excNZnBQukNRbLeUpVu2tx05kAE/pbKyUzKAWyh6fC9p8bj3e1Q/WRs7VBCRJD30caqSALQvXEKB2URkc4NfjwI4T/gNsUJlhKnvSrS3djOA/ksLLJIy69LJnLCDaJz4TCeAR7kGcXFeNmMuqGBQZvBQYk72i1j6t2s/Mdk7wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7wQ7cvystEx9HUeGeZ7Bv2urACEGyWoMD6puyBcNWc=;
 b=MMrddurau8azFaN7RghCOMeXH9hwJkseAsIA4D7WC5ZilJQV3kBetmiQUDTMh7e8blrOz8OYwL5v5qFWKdNz9wQVGlF0//WiOGF4TYELwSUY5K9HOgGQX40HR1LAPu1LJX0gImpbqwVMYRcUHy6JD29Jqr3SRaKLVrVq+BLvCSH+OV+gOGV3LgjTVDbKNUNOSxD+vMxM4qISUdltCfcF9eBoHSLRBlTWXPZPVDPYmSixZj+mxtdSTOwT/WdXz0D5MU55By/4iZYIGkpKMpkir3ejPkCKNeIKZjHZBNmS7tI4E7ktdUySXy42fwqUZ9aFZVIrkvKsnZOIzQMP+0S5pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ2PR12MB9085.namprd12.prod.outlook.com (2603:10b6:a03:564::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 14:25:47 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::847b:988d:86fe:a0f8]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::847b:988d:86fe:a0f8%5]) with mapi id 15.20.6387.018; Tue, 9 May 2023
 14:25:47 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Xin Hao <xhao@linux.alibaba.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH 1/2] migrate_pages_batch: simplify retrying and failure
 counting of large folios
Date:   Tue, 09 May 2023 10:25:44 -0400
X-Mailer: MailMate (1.14r5963)
Message-ID: <21078C33-2679-4C13-B46D-65858A4DC516@nvidia.com>
In-Reply-To: <20230509022014.380493-1-ying.huang@intel.com>
References: <20230509022014.380493-1-ying.huang@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_B85438C4-05FF-4E80-8A43-167667617C89_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR15CA0027.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::40) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ2PR12MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: 15145afe-8906-4677-f616-08db509947f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3H43gZkw+KXQjOLigvoetucJZRg8Ze6tUKIV5wz9fUhliSRuWuOiEMQ5/VDb8VDCGtYKoa641N+t9cwqGcDyxm2KTbrpSYS+TJZqqN5Bo1UcDhsDoPXbLRXLBI6wCnX4dTrh19hMQ4iKYT4oSgrKub8dlR3kOeO9M6bqimbDD3Zprh+HpUFr8ZZi/fyqGxBzIEDEuF0kvhQlc53JldY1LNeAc/1H71L6A9NTkFJJ8y86kv7gYtw7dt5M0Xnrcv6Q4ayRepiR4DibNj8R4RcAkM3G3dqK4OyehyemNGuI0gbbZY9DLkFdxjxyoarXAC9l62LdAgNuXhe5m+1+jVtVOgAShjFYSX7Ga06zLxNvtIzvvx21/ZgmShJCLwVAT8Sy6XmSdlzjuVBkiOuyXFplm0qVh6BwF5uIGp+Yv5WmJOye3bBazBZ8cdBde+gLzYJwgkFS4rghCEuZGEq0ZOTx190y85A4JL2a+vWAM5xayIWM1IJaJO8Q5+Sef/1SfRuDQr1Du/V3LuNGLVbY+yu6uZ4J12NYWCS+d8f0W+IJexSP03xZ7Rua7gqn4UyEYKF0+H6GKwyssMlo2l1bWYxf9Er0G4Tskc2q3fL/guX8ZROk+T4z91szgKRUUbUK6zezr5xvmtmidZEN7ucaioUXVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(451199021)(83380400001)(186003)(2616005)(36756003)(38100700002)(33656002)(86362001)(2906002)(6486002)(8936002)(316002)(6666004)(8676002)(41300700001)(5660300002)(6512007)(235185007)(54906003)(66556008)(4326008)(6916009)(66476007)(478600001)(66946007)(107886003)(53546011)(26005)(6506007)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q2ZpbHTJPD9yE9lKzZQRYkmT61IJuIYYRlklXiF65NmgItZASV5Qzm+asK12?=
 =?us-ascii?Q?QvgVR4r8YsR+iTDAEQjlXyaG/IZntjiJgEsH5RX549NSv9Ob0Uu1zZlyzwv2?=
 =?us-ascii?Q?ssqe092er59i6x5Hti5ljuf0rcsaACkPUP17LHTQeTwZ88dP5ARf6swJhZqZ?=
 =?us-ascii?Q?NmeDDEV+f9wUjSmiqY4ob4yuKa+eRLH89W86RmR3HYjTWgKxcCaxXocqsKU9?=
 =?us-ascii?Q?pT3J20n7qnyGyQwdIKP53TTbWhnGLqORM1Fr/uv9fKmMMC9VpFCNHwisafyY?=
 =?us-ascii?Q?ZjQwwfVuDV36qS6jWu396eiUr1WbhfHg02TK+rydSnn/Ux/QOMzNQ/It1CAu?=
 =?us-ascii?Q?erD+P0WcYDoLBCqQ9QmIaTUYpN28ICgVYxszotPUXaSezNjjAaY9Y0jIW17R?=
 =?us-ascii?Q?EpH7+nZUBOBUOFDQLHbgjlZDu2jX6GnfF8Pb0Ko9gj/arE9he233gZdp7OSR?=
 =?us-ascii?Q?jq6f9hrmocidRm37/RyOOWUSJ73Rl/KhBqbiswHzKLFsLOJMo/fJ/nRzenDM?=
 =?us-ascii?Q?5UljEhmgphHLhpzBami1w8JmF7ZCob76QyMCUNKORrzKgXUNbbQ/BOGJOZc4?=
 =?us-ascii?Q?0xMSJaBfQGAEwHSLjr64DPhmUOWc+CF5NDnGhQcpTT9IiIUqQ8iiBiQSlzp3?=
 =?us-ascii?Q?1ttmOWJ7krgVa8CfnPEtXpFro7omV8ES209JYDLBKTvoMucbMdeJ+JUhjNIw?=
 =?us-ascii?Q?z8wlDPf9AuVc5a6GudTDxNIrMehn2pf6Mc4QAFU3dtXkRbYGCHKs43XOkgdj?=
 =?us-ascii?Q?22pOe4qVrhUvIB1Jsi8v5YBPZs19fEJcg9Y8pp0jmmMdsMqhTxw5WCLjhsat?=
 =?us-ascii?Q?ynj/584Nqs6vdfaP8Jyqzxscbjl38UhWF4NdUA2ShfHzRf+LuyMSTO7RD3L4?=
 =?us-ascii?Q?BUFrrkFhjqS6HosLSPWGnTUs+OqpZG3NbHh5zvAgvF1EhuybE3JLTYUx6i5Z?=
 =?us-ascii?Q?l6/fu1Srzv7sP6QVyBG/fDsdhxO7wIO+VVQpSBRgHKr1rGy08gWiXzlq2jCs?=
 =?us-ascii?Q?BzBbu+Lust3shBnJv4M1Z5sBzC3PXOYHg8R8k7bRXaqhUGDMX1UEUYVVSTE8?=
 =?us-ascii?Q?utUX/IQjPo8fZYmgu7E+yF8DUYmK+wqXydn4wp1iGDVX6yH4toMVK1gTtcEU?=
 =?us-ascii?Q?proWDFX58KLSURMlZTZZQwDzXxTTrntU77c7wXUgxnOh7wsDrkMbEW1eEssd?=
 =?us-ascii?Q?bep/b6bdGdqTVc0p3xoF5sQQDozcFqe1LK6Xc6JvJMc2zOP/2qjRmhgdaUC3?=
 =?us-ascii?Q?mIKaBjnE/gIaoDT6c5g0qgxx75knLgAEDf3uBZjCqlYRnflh8HhTFMkwsRyI?=
 =?us-ascii?Q?b0T/XLdHwm4ylsrWFm5XQQaDqfvchZSSTGWUJLdslA/VBmqnG9N0YpMf6mSq?=
 =?us-ascii?Q?X3hN3w6TpfA324YQvc/iEDXDT/AnjkwrWDVMc+qBYUm6Ob+6ItEV7u3TDIqD?=
 =?us-ascii?Q?eGUJwLN9aXjgEcLVo4366aruduUBiWaYGrtgqw/IRAUOsc93dI4YJ5dDTJsq?=
 =?us-ascii?Q?Xa7Gu3cgCxVzWBV36wA7XsPkcy36aY4FNPyNVG0hLk4LPr5KJCtTorw/GBJm?=
 =?us-ascii?Q?E1glX9jcbfuDU9ojjGs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15145afe-8906-4677-f616-08db509947f8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 14:25:47.3088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4foQDy/WZZvx1O1kzkGY4dRHsfuLeoxOqZvMvFWcnApH31rw1/tHHRHGBJRLafXx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9085
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

--=_MailMate_B85438C4-05FF-4E80-8A43-167667617C89_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 8 May 2023, at 22:20, Huang Ying wrote:

> After recent changes to the retrying and failure counting in
> migrate_pages_batch(), it was found that it's unnecessary to count
> retrying and failure for normal, large, and THP folios separately.
> Because we don't use retrying and failure number of large folios
> directly.  So, in this patch, we simplified retrying and failure
> counting of large folios via counting retrying and failure of normal
> and large folios together.  This results in the reduced line number.
>
> This is just code cleanup, no functionality changes are expected.
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Xin Hao <xhao@linux.alibaba.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Alistair Popple <apopple@nvidia.com>
> ---
>  mm/migrate.c | 103 +++++++++++++++++----------------------------------=

>  1 file changed, 35 insertions(+), 68 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 01cac26a3127..10709aed76d3 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1614,11 +1614,9 @@ static int migrate_pages_batch(struct list_head =
*from, new_page_t get_new_page,
>  		int nr_pass)
>  {
>  	int retry =3D 1;
> -	int large_retry =3D 1;
>  	int thp_retry =3D 1;
>  	int nr_failed =3D 0;
>  	int nr_retry_pages =3D 0;
> -	int nr_large_failed =3D 0;
>  	int pass =3D 0;
>  	bool is_large =3D false;
>  	bool is_thp =3D false;
> @@ -1631,9 +1629,8 @@ static int migrate_pages_batch(struct list_head *=
from, new_page_t get_new_page,
>  	VM_WARN_ON_ONCE(mode !=3D MIGRATE_ASYNC &&
>  			!list_empty(from) && !list_is_singular(from));
>
> -	for (pass =3D 0; pass < nr_pass && (retry || large_retry); pass++) {
> +	for (pass =3D 0; pass < nr_pass && retry; pass++) {
>  		retry =3D 0;
> -		large_retry =3D 0;
>  		thp_retry =3D 0;
>  		nr_retry_pages =3D 0;
>
> @@ -1660,7 +1657,7 @@ static int migrate_pages_batch(struct list_head *=
from, new_page_t get_new_page,
>  			 * list is processed.
>  			 */
>  			if (!thp_migration_supported() && is_thp) {
> -				nr_large_failed++;
> +				nr_failed++;
>  				stats->nr_thp_failed++;
>  				if (!try_split_folio(folio, split_folios)) {
>  					stats->nr_thp_split++;
> @@ -1688,38 +1685,33 @@ static int migrate_pages_batch(struct list_head=
 *from, new_page_t get_new_page,
>  				 * When memory is low, don't bother to try to migrate
>  				 * other folios, move unmapped folios, then exit.
>  				 */
> -				if (is_large) {
> -					nr_large_failed++;
> -					stats->nr_thp_failed +=3D is_thp;
> -					/* Large folio NUMA faulting doesn't split to retry. */
> -					if (!nosplit) {
> -						int ret =3D try_split_folio(folio, split_folios);
> -
> -						if (!ret) {
> -							stats->nr_thp_split +=3D is_thp;
> -							break;
> -						} else if (reason =3D=3D MR_LONGTERM_PIN &&
> -							   ret =3D=3D -EAGAIN) {
> -							/*
> -							 * Try again to split large folio to
> -							 * mitigate the failure of longterm pinning.
> -							 */
> -							large_retry++;
> -							thp_retry +=3D is_thp;
> -							nr_retry_pages +=3D nr_pages;
> -							/* Undo duplicated failure counting. */
> -							nr_large_failed--;
> -							stats->nr_thp_failed -=3D is_thp;
> -							break;
> -						}
> +				nr_failed++;
> +				stats->nr_thp_failed +=3D is_thp;
> +				/* Large folio NUMA faulting doesn't split to retry. */
> +				if (is_large && !nosplit) {
> +					int ret =3D try_split_folio(folio, split_folios);
> +
> +					if (!ret) {
> +						stats->nr_thp_split +=3D is_thp;
> +						break;
> +					} else if (reason =3D=3D MR_LONGTERM_PIN &&
> +						   ret =3D=3D -EAGAIN) {
> +						/*
> +						 * Try again to split large folio to
> +						 * mitigate the failure of longterm pinning.
> +						 */
> +						retry++;
> +						thp_retry +=3D is_thp;
> +						nr_retry_pages +=3D nr_pages;
> +						/* Undo duplicated failure counting. */
> +						nr_failed--;
> +						stats->nr_thp_failed -=3D is_thp;
> +						break;
>  					}
> -				} else {
> -					nr_failed++;
>  				}
>
>  				stats->nr_failed_pages +=3D nr_pages + nr_retry_pages;
>  				/* nr_failed isn't updated for not used */
> -				nr_large_failed +=3D large_retry;
>  				stats->nr_thp_failed +=3D thp_retry;
>  				rc_saved =3D rc;
>  				if (list_empty(&unmap_folios))
> @@ -1727,12 +1719,8 @@ static int migrate_pages_batch(struct list_head =
*from, new_page_t get_new_page,
>  				else
>  					goto move;
>  			case -EAGAIN:
> -				if (is_large) {
> -					large_retry++;
> -					thp_retry +=3D is_thp;
> -				} else {
> -					retry++;
> -				}
> +				retry++;
> +				thp_retry +=3D is_thp;
>  				nr_retry_pages +=3D nr_pages;
>  				break;
>  			case MIGRATEPAGE_SUCCESS:
> @@ -1750,20 +1738,14 @@ static int migrate_pages_batch(struct list_head=
 *from, new_page_t get_new_page,
>  				 * removed from migration folio list and not
>  				 * retried in the next outer loop.
>  				 */
> -				if (is_large) {
> -					nr_large_failed++;
> -					stats->nr_thp_failed +=3D is_thp;
> -				} else {
> -					nr_failed++;
> -				}
> -
> +				nr_failed++;
> +				stats->nr_thp_failed +=3D is_thp;
>  				stats->nr_failed_pages +=3D nr_pages;
>  				break;
>  			}
>  		}
>  	}
>  	nr_failed +=3D retry;
> -	nr_large_failed +=3D large_retry;
>  	stats->nr_thp_failed +=3D thp_retry;
>  	stats->nr_failed_pages +=3D nr_retry_pages;
>  move:
> @@ -1771,17 +1753,15 @@ static int migrate_pages_batch(struct list_head=
 *from, new_page_t get_new_page,
>  	try_to_unmap_flush();
>
>  	retry =3D 1;
> -	for (pass =3D 0; pass < nr_pass && (retry || large_retry); pass++) {
> +	for (pass =3D 0; pass < nr_pass && retry; pass++) {
>  		retry =3D 0;
> -		large_retry =3D 0;
>  		thp_retry =3D 0;
>  		nr_retry_pages =3D 0;
>
>  		dst =3D list_first_entry(&dst_folios, struct folio, lru);
>  		dst2 =3D list_next_entry(dst, lru);
>  		list_for_each_entry_safe(folio, folio2, &unmap_folios, lru) {
> -			is_large =3D folio_test_large(folio);
> -			is_thp =3D is_large && folio_test_pmd_mappable(folio);
> +			is_thp =3D folio_test_large(folio) && folio_test_pmd_mappable(folio=
);

Should this be part of patch 2? Or maybe just merge two patches?

>  			nr_pages =3D folio_nr_pages(folio);
>
>  			cond_resched();
> @@ -1797,12 +1777,8 @@ static int migrate_pages_batch(struct list_head =
*from, new_page_t get_new_page,
>  			 */
>  			switch(rc) {
>  			case -EAGAIN:
> -				if (is_large) {
> -					large_retry++;
> -					thp_retry +=3D is_thp;
> -				} else {
> -					retry++;
> -				}
> +				retry++;
> +				thp_retry +=3D is_thp;
>  				nr_retry_pages +=3D nr_pages;
>  				break;
>  			case MIGRATEPAGE_SUCCESS:
> @@ -1810,13 +1786,8 @@ static int migrate_pages_batch(struct list_head =
*from, new_page_t get_new_page,
>  				stats->nr_thp_succeeded +=3D is_thp;
>  				break;
>  			default:
> -				if (is_large) {
> -					nr_large_failed++;
> -					stats->nr_thp_failed +=3D is_thp;
> -				} else {
> -					nr_failed++;
> -				}
> -
> +				nr_failed++;
> +				stats->nr_thp_failed +=3D is_thp;
>  				stats->nr_failed_pages +=3D nr_pages;
>  				break;
>  			}
> @@ -1825,14 +1796,10 @@ static int migrate_pages_batch(struct list_head=
 *from, new_page_t get_new_page,
>  		}
>  	}
>  	nr_failed +=3D retry;
> -	nr_large_failed +=3D large_retry;
>  	stats->nr_thp_failed +=3D thp_retry;
>  	stats->nr_failed_pages +=3D nr_retry_pages;
>
> -	if (rc_saved)
> -		rc =3D rc_saved;
> -	else
> -		rc =3D nr_failed + nr_large_failed;
> +	rc =3D rc_saved ? : nr_failed;
>  out:
>  	/* Cleanup remaining folios */
>  	dst =3D list_first_entry(&dst_folios, struct folio, lru);
> -- =

> 2.39.2

Otherwise LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>


--
Best Regards,
Yan, Zi

--=_MailMate_B85438C4-05FF-4E80-8A43-167667617C89_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmRaV+gPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUkNgP/2+mcTY8HRSNgqirL/LxAcnUMcrf/A8wxzLf
2Di0j3auhBGJFa2EgKkK8yvCHC9JkH/KBdMOlkNndXosRNwo8UCUtBMYK/jwVhjw
47hLiYMVYaSg2kQbMEAQia9H/S6tCefINZDVV2jvDn9mDGaRnPh8JT+vua1Ise4d
eMZ/vYqcRu8xDHCzt473BqBeFCELQSDFpGeBCP8eRauXhqsh7L7+zytjOcy9GaNi
BUxwjUArC18YKDJzhxdfOQ+5rVwXounF9P8JClguVM3xV/oteXavB/9Ke5XSTY+7
u5Rwb6Xq5nDGr96WHifoIk7zAmWZymglyEdllpxCYKhIaROdnDyD3EJnGVGFySqY
RaenRTjG6zBPMqAsbX0/YG+MdbA56GhcQv4tPaLZJ2UiLVBFlONVhzh/a5xLknEd
ukwnpvDSnuQ699C1yM2Sg5Tq5PmApeVFo6DIhtZ1JbpJ+GXL/Xi/a2ciMB5mtsiX
Kzmv5Nf0BMv30doZ5Vf+1hSOs3Y7fRIErWEcbHM2+9AhRWCJ1m3OcZHQbobf0fu3
TsVQynl8hd7qedlCTRRyuQnM/AQdyjCT+guBchny/bNgMvYc8xiM4/gMrNBVh4UG
G9CMoSbMcS84Ph/9Kbw9XiijR+Wj/a0hRTZwVvTYK6jy3yU1ckuyYz9yjX6ooEKs
+ABXKRDV
=oV65
-----END PGP SIGNATURE-----

--=_MailMate_B85438C4-05FF-4E80-8A43-167667617C89_=--
