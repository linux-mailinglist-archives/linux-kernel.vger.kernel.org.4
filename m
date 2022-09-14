Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796065B7DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 02:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiINACa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 20:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiINACZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 20:02:25 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2040.outbound.protection.outlook.com [40.107.212.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D8B5FAF5;
        Tue, 13 Sep 2022 17:02:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1pqLu2n1B9pbPk4PLXJuP/Csxljy6qtQZrlh3KrKYiqY3i0l25hKO7PNnUxBLI1J0iy+MLeMgHyB/8IaT+HNYfrvajALj5vqzTInNTROeRRdcPS2ndzbQ0Neo/MLNDhCKDCGHLvl2q7wH/80B8uJF5WxUkdPAm2QYTiqNQ86TVJbq40/y/ie/B7mcI37D7g/YufLQYfdHbtrXIFxmo+GsFtRlFhHl2kvM2O48qIF/kv9E/5cDvwDxbP1G0uOyn0JIjHlBQHIxgXmEm7QYltfV1J+eFBHYbfDJuS05lmQZXpeAjvTGD+lnHcauaT411i+UiSdae7Up41z/eugpjzmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUD+xyL/Qe0RkWj61woTrh0/f0vU5V2V/+jo+fGraUc=;
 b=k7QaWPG0uaORWSoHYEttGujjFBUgCt9LzJyuhBYpoYlcilaz/0bp4XxqC7Yy4XTvXm6quU0+UK2S1fcLE80fi82uVrlG9VFHBtoaHVY/K2c6me2yf09ZHUp7e++IfB3zKrk6FXhXqx7598MRC7omb1mvnD79K2oOBosMTJZkzugS5xeo3KuqhUObf/fcdFjGBVZCWMQiSTbirVgOn6ZPOKl6BNqbdN8x+KUUXEk6TnSF+nKqqENlUwTxc3IxhIf9JZqXYrMgdhG4HtRPylu9OvLEIY7fmKik4+Bd51uTktneYY9WROABwZP8AR5CgYjtuCP5+5GpBJ5UwEb43twOqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUD+xyL/Qe0RkWj61woTrh0/f0vU5V2V/+jo+fGraUc=;
 b=lIXCggBNEVudU0AiypxkVj/nGhrFwIb6Hw/MIQ4nzen6+m+dq+jC7lYGBlhuARto/zq1QSDIk35HtPJDIuQo3EV9cWHYintm0hV9t6pDFsEdQDkHRoxQsxa1ZHU8Zd0UXx2C5zFVmD1+sWMDUbFiECGg/pwYvuobbJicHbcS0utUO+F3LSRviwzzBcV4KIHj29b/Cu1TnhFogpDml6hlfkB2TWBTk7XTtXXmE33P2DVDTici1Mxmma5M8fUkuK8PWIMMgqS3sKr44vYwjSerM3vslmXXoK9MdXcoz7q2Uz4AijVpnZbIVJkdpOrollLibthjtlE55nuvIh6wMBfdFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9)
 by SA1PR12MB6947.namprd12.prod.outlook.com (2603:10b6:806:24e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 00:02:22 +0000
Received: from BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::d0c0:3e8a:b8c8:44ca]) by BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::d0c0:3e8a:b8c8:44ca%7]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 00:02:22 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Doug Berger <opendmb@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Rapoport <rppt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        - <devicetree-spec@vger.kernel.org>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux.dev
Subject: Re: [PATCH 01/21] mm/page_isolation: protect cma from
 isolate_single_pageblock
Date:   Tue, 13 Sep 2022 20:02:19 -0400
X-Mailer: MailMate (1.14r5911)
Message-ID: <36E322BF-F052-4A8B-9FA5-4E0AA84E4AAF@nvidia.com>
In-Reply-To: <20220913195508.3511038-2-opendmb@gmail.com>
References: <20220913195508.3511038-1-opendmb@gmail.com>
 <20220913195508.3511038-2-opendmb@gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_E6BE9F10-9846-4B48-8CC5-6B56D4224A48_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:208:d4::42) To BL1PR12MB5730.namprd12.prod.outlook.com
 (2603:10b6:208:385::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5730:EE_|SA1PR12MB6947:EE_
X-MS-Office365-Filtering-Correlation-Id: 99945416-cd50-4309-0963-08da95e465dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RS/c69esPEO3YX1Y63rnso5OhNxjJO7eDlKCmaP54HOK7aK/2T4SHrBNQwo2Nbau44sw2oUjMasZL3fDX7ubfLXweNruPvpdfK3eoQgbmBx50BUcYvbyjlbo+vWtefNK1++FBEcmumn6P02Z1sj2nPLlHnepuhXbsTwnKJ2VPDgIWUzv4dqE2ODFgENJwv02ByoEQTdP6kt9h3nRT0kaI3g6ZD4pXaHR1xenaYqI6OLn/rw8NLeTibWlsebQxT5BzNQsesEH2PRGqj32IMGqcrJSVH0HmuMsHIPQikd0YCgNi+OVEl8uDqElpSNgoDHT+8IW7qg/VJ1j8385GyBX/0UkqDZa/XbwdoFE+M2TP+bSWbAZUaozhlrG8idSYpmAzkNU9dW/uxeNcoQtMzQE23UJg0DKgcyWSrSnpi8GW2qeqdB1pgOUuZWZbyTyNqCFHY8/qqTRz09yjY/U8Y41kmTPOSD/TSWhZ0JLyyQbM2sKD4Ut2l1OjPQ5L3r82sxA4qvawHKjQVeS8tBbSlGJ0ac8nl7SLRoWrelWrPs4dSBaOFfm016VPN9TZxe6pT9m9Ww0Ska5MobamVoDt7lRto+Bw1JYF6/JvOIrjoGcO4bxKot6MB5GxYC/upYawQp/IxAVS8kV8vpgIVcxYXbjZfnEc8Ut54VUyXXLeqr3LLLQ8N/xk7/DCcOr038sZEyBYxgdduNkPWokFxyKvdXrOorKkzOjRyEltt62p8OGMdkZ8gEOuKcZyHfvymUY4a7UTv5tCJ72wg0000Nrd8plukYEUoyDu7iv8+M8/ouuwdQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199015)(6916009)(53546011)(6506007)(66476007)(66556008)(7416002)(38100700002)(54906003)(33656002)(7406005)(4326008)(2616005)(6486002)(83380400001)(2906002)(6512007)(41300700001)(478600001)(26005)(316002)(8936002)(86362001)(36756003)(235185007)(6666004)(8676002)(5660300002)(66946007)(186003)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j00VbfZugdnvK8X/5sXtXo+dzlP0PCOTLwehWu8HCzwMWumX8ft8HxjFdkxc?=
 =?us-ascii?Q?7NySJhjHfJHjmomx3jbZ8eQUEWxG9d6KOhjg1RyiLImQiqiuIRuaL+P6uCwt?=
 =?us-ascii?Q?xcTjtC8T50wBS77lB2rxgDLuejjcEOh1wyObRYfGNVVkX0dMtfKjl+k4CHO1?=
 =?us-ascii?Q?n2kFIKqSNHQ53e40Et4IfDykezBEMXZRt7059CCGv9uJhUiVsSgWj/lEXmgE?=
 =?us-ascii?Q?e0OfTaE5IIyYFDlIk0NFqnnoiCu6M6c5m+ghDDi/SEr7MeV9TFXIvOUPYZKG?=
 =?us-ascii?Q?LEOPa4WOxZElCoEL7RcjNATTNFHXU5mRbSmtbbDWfzKohqstJ+NvrC6CIZoG?=
 =?us-ascii?Q?vyQV7AtvtcyUkcZ3U17PX/D5sG42OxabGjxgfnNbIj0c6mNmvi2ZsJsr5FWD?=
 =?us-ascii?Q?TbskS/WBNyUYE3rbichbOQkN5CfrI7CWelx75G2N+degmYIh6DhMaLZJRPNR?=
 =?us-ascii?Q?iYRByFXl8JYHX/At5+Xloue70AzW490gVmNWrgRwVbkFK+N+zNvExJsPA+U4?=
 =?us-ascii?Q?fGCIfj8z0MvzjSI3SU/fR5V6x8hO991VEPwZsiRDuK//qCu8vIxHr8Z7vJgV?=
 =?us-ascii?Q?RPR9zjqis/G1Dm6QoDZYgt6c5EpLIUR6bJm5qUptgMoBo5y+023O0JcWKqub?=
 =?us-ascii?Q?E4XGDcEuar/I7zI5EkRu697PtBI/zIloIDXosfPpIMAJRizOzQNmZPheFZ5f?=
 =?us-ascii?Q?VvJsqUo3qhBchKrtG0XwGro3WqL+9pFyxlBnpx/RHFThRTAzj4fIqGmBgEJH?=
 =?us-ascii?Q?hK4mFHxpHv1p8MQ4XgVdOCQfnIovR9Fy/bCMRzuBc2bShsR+dSZLqVYZ+v4P?=
 =?us-ascii?Q?CkH2V+5eCC0GBcltZEHM7jaNr6bUnuoD9iQ8LnLF1NUWYdS56+iiL7gWuT3s?=
 =?us-ascii?Q?u/5zKW2xJDD5JzGCLV+qm9uJk7H6y4wYG9IM7Hmb9hqHrBYYt8onEFtEuph1?=
 =?us-ascii?Q?VbLw8ZbPnSZQ9uf/DysmwkEwANE+mLePoELu/bd2FXo1Eo7KeEpCaIe9QrX7?=
 =?us-ascii?Q?qV+CteDIvcEvFFpQSDZ8+Mf6jQG73Pn+vrcgaHVnkcxKyxT398Io2ZGlDgYx?=
 =?us-ascii?Q?7/usdD74YwQmCh9zNej4XC5JqdaSwf7i0mnySdv+/gBWCu1r2CLZMVv3E6OU?=
 =?us-ascii?Q?XBv39Yyk0xFr4g4jPbn8fQ+bCICPEjPFVl9dEKxab5CCEEzW7huDtZgsmsWT?=
 =?us-ascii?Q?ZqtQjexJAZRWigDEkRGKuGwzhcgCxHZHjB9+rhsZNPyiYUHJOibmUngpDXfq?=
 =?us-ascii?Q?26gmuKL00TCMZvOYEgRzkKlLLq/WJcMj86ab36eKJJQd9I/Xnh7CpXCbq36I?=
 =?us-ascii?Q?3TKrvMU2W0ly9y6PQEXQZlS2WffECMqsNy/OAOzrPgkRYkib+4UZ5x/HAoOk?=
 =?us-ascii?Q?8DT+ghqcwVziS1LLtZA8pgL/z/AI2LEO5m2qlk3sp5AFCXy+/7zlQ/rO1wpX?=
 =?us-ascii?Q?Bi4uETZOBnT62fuCQjXC0iu2s2EBM76qLCxnD8YKGOtmAY109R0veX9NQrCQ?=
 =?us-ascii?Q?gGecSnGJrEc6NX/MTimXOQ3BjWgwqVt0sCx0KWQCHZLD69wNmc+A1jmzJEVS?=
 =?us-ascii?Q?sdrvYf4OE0qpIc3ruPFcFR7Si/E0NT0RsWppPQBf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99945416-cd50-4309-0963-08da95e465dd
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 00:02:22.2756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcqjFs8yNyiFuWc4FegfQzPrWl/me4K6KKV7vkmvcRRn5XunncRFXsX87InphHQi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6947
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_E6BE9F10-9846-4B48-8CC5-6B56D4224A48_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 13 Sep 2022, at 15:54, Doug Berger wrote:

> The function set_migratetype_isolate() has special handling for
> pageblocks of MIGRATE_CMA type that protects them from being
> isolated for MIGRATE_MOVABLE requests.
>
> Since isolate_single_pageblock() doesn't receive the migratetype
> argument of start_isolate_page_range() it used the migratetype
> of the pageblock instead of the requested migratetype which
> defeats this MIGRATE_CMA check.
>
> This allows an attempt to create a gigantic page within a CMA
> region to change the migratetype of the first and last pageblocks
> from MIGRATE_CMA to MIGRATE_MOVABLE when they are restored after
> failure, which corrupts the CMA region.
>
> The calls to (un)set_migratetype_isolate() for the first and last
> pageblocks of the start_isolate_page_range() are moved back into
> that function to allow access to its migratetype argument and make
> it easier to see how all of the pageblocks in the range are
> isolated.
>
> Fixes: b2c9e2fbba32 ("mm: make alloc_contig_range work at pageblock gra=
nularity")
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> ---
>  mm/page_isolation.c | 75 +++++++++++++++++++++------------------------=

>  1 file changed, 35 insertions(+), 40 deletions(-)

Thanks for the fix.

Why not just pass migratetype into isolate_single_pageblock() and use
it when set_migratetype_isolate() is used? That would have much
fewer changes. What is the reason of pulling skip isolation logic out?

Ultimately, I would like to make MIGRATE_ISOLATE a separate bit,
so that migratetype will not be overwritten during page isolation.
Then, set_migratetype_isolate() and start_isolate_page_range()
will not have migratetype to set in error recovery any more.
That is on my TODO.

>
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 9d73dc38e3d7..8e16aa22cb61 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -286,8 +286,6 @@ __first_valid_page(unsigned long pfn, unsigned long=
 nr_pages)
>   * @flags:			isolation flags
>   * @gfp_flags:			GFP flags used for migrating pages
>   * @isolate_before:	isolate the pageblock before the boundary_pfn
> - * @skip_isolation:	the flag to skip the pageblock isolation in second=

> - *			isolate_single_pageblock()
>   *
>   * Free and in-use pages can be as big as MAX_ORDER-1 and contain more=
 than one
>   * pageblock. When not all pageblocks within a page are isolated at th=
e same
> @@ -302,9 +300,8 @@ __first_valid_page(unsigned long pfn, unsigned long=
 nr_pages)
>   * the in-use page then splitting the free page.
>   */
>  static int isolate_single_pageblock(unsigned long boundary_pfn, int fl=
ags,
> -			gfp_t gfp_flags, bool isolate_before, bool skip_isolation)
> +			gfp_t gfp_flags, bool isolate_before)
>  {
> -	unsigned char saved_mt;
>  	unsigned long start_pfn;
>  	unsigned long isolate_pageblock;
>  	unsigned long pfn;
> @@ -328,18 +325,6 @@ static int isolate_single_pageblock(unsigned long =
boundary_pfn, int flags,
>  	start_pfn  =3D max(ALIGN_DOWN(isolate_pageblock, MAX_ORDER_NR_PAGES),=

>  				      zone->zone_start_pfn);
>
> -	saved_mt =3D get_pageblock_migratetype(pfn_to_page(isolate_pageblock)=
);
> -
> -	if (skip_isolation)
> -		VM_BUG_ON(!is_migrate_isolate(saved_mt));
> -	else {
> -		ret =3D set_migratetype_isolate(pfn_to_page(isolate_pageblock), save=
d_mt, flags,
> -				isolate_pageblock, isolate_pageblock + pageblock_nr_pages);
> -
> -		if (ret)
> -			return ret;
> -	}
> -
>  	/*
>  	 * Bail out early when the to-be-isolated pageblock does not form
>  	 * a free or in-use page across boundary_pfn:
> @@ -428,7 +413,7 @@ static int isolate_single_pageblock(unsigned long b=
oundary_pfn, int flags,
>  					ret =3D set_migratetype_isolate(page, page_mt,
>  						flags, head_pfn, head_pfn + nr_pages);
>  					if (ret)
> -						goto failed;
> +						return ret;
>  				}
>
>  				ret =3D __alloc_contig_migrate_range(&cc, head_pfn,
> @@ -443,7 +428,7 @@ static int isolate_single_pageblock(unsigned long b=
oundary_pfn, int flags,
>  					unset_migratetype_isolate(page, page_mt);
>
>  				if (ret)
> -					goto failed;
> +					return -EBUSY;
>  				/*
>  				 * reset pfn to the head of the free page, so
>  				 * that the free page handling code above can split
> @@ -459,24 +444,19 @@ static int isolate_single_pageblock(unsigned long=
 boundary_pfn, int flags,
>  				while (!PageBuddy(pfn_to_page(outer_pfn))) {
>  					/* stop if we cannot find the free page */
>  					if (++order >=3D MAX_ORDER)
> -						goto failed;
> +						return -EBUSY;
>  					outer_pfn &=3D ~0UL << order;
>  				}
>  				pfn =3D outer_pfn;
>  				continue;
>  			} else
>  #endif
> -				goto failed;
> +				return -EBUSY;
>  		}
>
>  		pfn++;
>  	}
>  	return 0;
> -failed:
> -	/* restore the original migratetype */
> -	if (!skip_isolation)
> -		unset_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt);=

> -	return -EBUSY;
>  }
>
>  /**
> @@ -534,21 +514,30 @@ int start_isolate_page_range(unsigned long start_=
pfn, unsigned long end_pfn,
>  	unsigned long isolate_start =3D ALIGN_DOWN(start_pfn, pageblock_nr_pa=
ges);
>  	unsigned long isolate_end =3D ALIGN(end_pfn, pageblock_nr_pages);
>  	int ret;
> -	bool skip_isolation =3D false;
>
>  	/* isolate [isolate_start, isolate_start + pageblock_nr_pages) pagebl=
ock */
> -	ret =3D isolate_single_pageblock(isolate_start, flags, gfp_flags, fal=
se, skip_isolation);
> +	ret =3D set_migratetype_isolate(pfn_to_page(isolate_start), migratety=
pe,
> +			flags, isolate_start, isolate_start + pageblock_nr_pages);
>  	if (ret)
>  		return ret;
> -
> -	if (isolate_start =3D=3D isolate_end - pageblock_nr_pages)
> -		skip_isolation =3D true;
> +	ret =3D isolate_single_pageblock(isolate_start, flags, gfp_flags, fal=
se);
> +	if (ret)
> +		goto unset_start_block;
>
>  	/* isolate [isolate_end - pageblock_nr_pages, isolate_end) pageblock =
*/
> -	ret =3D isolate_single_pageblock(isolate_end, flags, gfp_flags, true,=
 skip_isolation);
> +	pfn =3D isolate_end - pageblock_nr_pages;
> +	if (isolate_start !=3D pfn) {
> +		ret =3D set_migratetype_isolate(pfn_to_page(pfn), migratetype,
> +				flags, pfn, pfn + pageblock_nr_pages);
> +		if (ret)
> +			goto unset_start_block;
> +	}
> +	ret =3D isolate_single_pageblock(isolate_end, flags, gfp_flags, true)=
;
>  	if (ret) {
> -		unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);
> -		return ret;
> +		if (isolate_start !=3D pfn)
> +			goto unset_end_block;
> +		else
> +			goto unset_start_block;
>  	}
>
>  	/* skip isolated pageblocks at the beginning and end */
> @@ -557,15 +546,21 @@ int start_isolate_page_range(unsigned long start_=
pfn, unsigned long end_pfn,
>  	     pfn +=3D pageblock_nr_pages) {
>  		page =3D __first_valid_page(pfn, pageblock_nr_pages);
>  		if (page && set_migratetype_isolate(page, migratetype, flags,
> -					start_pfn, end_pfn)) {
> -			undo_isolate_page_range(isolate_start, pfn, migratetype);
> -			unset_migratetype_isolate(
> -				pfn_to_page(isolate_end - pageblock_nr_pages),
> -				migratetype);
> -			return -EBUSY;
> -		}
> +					start_pfn, end_pfn))
> +			goto unset_isolated_blocks;
>  	}
>  	return 0;
> +
> +unset_isolated_blocks:
> +	ret =3D -EBUSY;
> +	undo_isolate_page_range(isolate_start + pageblock_nr_pages, pfn,
> +				migratetype);
> +unset_end_block:
> +	unset_migratetype_isolate(pfn_to_page(isolate_end - pageblock_nr_page=
s),
> +				  migratetype);
> +unset_start_block:
> +	unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);
> +	return ret;
>  }
>
>  /*
> -- =

> 2.25.1


--
Best Regards,
Yan, Zi

--=_MailMate_E6BE9F10-9846-4B48-8CC5-6B56D4224A48_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmMhGgsPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUXhwP/jRZWxGpSgHBpXv4SWOrjilrF6k/Xxj5qoRC
Ndxp9JHAYgxD472j53CXaht8NY3oqyKHOFwTeISEGLYirQjlTvJKiW17bjtCSrY3
kCclXgEdI9+ReWadY9Npn4+LOQ1dW+VPxlnQHVtl1NlX0ErMDNfQZcow7tjoJkOS
eiPSFxCjHn/msIivYcT9v4mRxYdraup5xCDK+FLy48FjBkVpeSdNlM/HFLfVXitf
z/KRVDt0PC8cXdeX+T1j7l/iBKmCfFhVGvXIpAYWKD84rzTG0O3feLCCWUvG/eZZ
Jep5mRR6jg2kS1qZOPkbMdHhaxpBEGyiWbXPGOV4m0Dy94qi8+aOtDc6SN/SHb3s
tZSN5p0t8xYC8KqboRCuhBI/uTEdovCpADyxxaZ0etZJaJGB42oNf9+quwI4dg1D
PSSGxMdse1AgfVnpphzSrRDC0OFvPtLHNE1/oaJmo0+weezkdnU7rxzhFPryBqAD
yc9zKhdwIHNa2DcwuJiXGMWl6VAou2V4kaOTlxZOKyKsHLAEOLlXvhTdd1arzLgt
sq3E0vvlupEvb/qErCTfBCYzmg+Jtsh2OUYRpK4z6PUA22mZfmDCFqo+hUJiE6uP
/zETn916ZdC+jnomoGMYS6Ci/GhPT8MOscbpDs+xgNAWDu3QTAakCgFnxu5Cc+I/
BHD6uwQ5
=v0DW
-----END PGP SIGNATURE-----

--=_MailMate_E6BE9F10-9846-4B48-8CC5-6B56D4224A48_=--
