Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA9F65C67F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238138AbjACSkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbjACSkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:40:24 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2116911C10
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:40:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSToWXnfQD5PIFZj4emFivgf7cDgAj1lFvup9XLtrAbNI6w3T3Q3Y6iSKZU2C7Pw4lZae8pQhOvEthmG+z3mrFf+qeuGv1a+kj9C3d84YZYXLEL2GmHtK7iTHBcNsqWN+dBZBY1Ny0Rjdcabvk5rQPMVGMS+7CzjxuEUDOHjTzvgTYPguYb3G5edkazCdu8Wvldq0kSXvXWEu2OHJbggveM11V7NP4JNiBEQi/Ig5324GNV/dITE5P0xyoqoRddQHVYDvvyLEh83+cob8AQwAasKEQbPFoP99zx82ULr2ZrYS/3mXhAdaiHfoJMUXS50BGpN1Bzo6vST2GG8EJfk7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4KgL09C2hE+/M6SrbjKfbcOMEL1uzD1H0CKwalAHRs=;
 b=YzC2f372LoCLdNQ+hiOWfl6xduupCB4HFTlDf66sawxJiQuzs0ibFopTJb3Gj2If19Ptgu/5l+GOFa7mK1te2cMrcucNQDGpFRr2iinM4+YhZtlzr7D++1aMdcxI/gNejUL7cGJj/m3SONgBvwg71V/xfvNYBJbdj/YJKCPwS6R7pLC4X2pA4O0v7BfY6Fx5H81IKQCNpWI6scY+JYe+mG/TzioIkiWKMXPJy11E0g2zESqeRsL+7MTIl95Gey0qA5VSFOfloFeqsfM+BjE/8f3hjp6sbgTf65IKzl2BtcrHlC4hpvYP5cUQW72jY8kZWK6vT86U1g+S5UZdR1l0HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4KgL09C2hE+/M6SrbjKfbcOMEL1uzD1H0CKwalAHRs=;
 b=XsHpF6mnD5dvkN2/KecgoUKYMig6pDh7ksN73g98izdbvRfk1O8e14CUsDalTi1c5RHu5sso03YzYP8UqO5tcOrb64mpfwjiFRPL0bLfOEVtU9XgzSUBaaY4fp4Cmf6IU062nnpBebdmHLV7TeJlRRihfpNsqjbKCagaQ/tkyeze3aasLJDFNJLkXOZPgcRYYvJ4yavJC8JG0Kowvcfv/FzmEsnnN/wT4e24igsCCmsUMQdQ6v7Xq9pydlcXj4K0TAnctzRsgEIuZHurMHlAnPDCD1gxueQWgqgdE771ee0HBtMPiw2a5ezKlVhNRz+3XmPjw9kS2bRAnivgziIrXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DM4PR12MB5231.namprd12.prod.outlook.com (2603:10b6:5:39b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Tue, 3 Jan 2023 18:40:03 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::2585:153b:98ea:3e23]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::2585:153b:98ea:3e23%9]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 18:40:03 +0000
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
Subject: Re: [PATCH 3/8] migrate_pages: restrict number of pages to migrate in
 batch
Date:   Tue, 03 Jan 2023 13:40:00 -0500
X-Mailer: MailMate (1.14r5933)
Message-ID: <761F148B-555B-4C51-8A1E-F17ABA85D014@nvidia.com>
In-Reply-To: <20221227002859.27740-4-ying.huang@intel.com>
References: <20221227002859.27740-1-ying.huang@intel.com>
 <20221227002859.27740-4-ying.huang@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_7CF7EA83-11F6-4CF7-A656-25454E7612E3_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BN0PR04CA0109.namprd04.prod.outlook.com
 (2603:10b6:408:ec::24) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DM4PR12MB5231:EE_
X-MS-Office365-Filtering-Correlation-Id: b4069709-fdeb-4b5d-bf0c-08daedb9ed46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0BdYRM4tQKArO5vCZhmYk6yPG8l3XeTjqdSkmCZFexpN2CWyHUJtn+NO2m9z+l7U1gStBkUob7THCTszA17Fk0WlE5NFfn6xq94dZxFmx1nqTx6HufkvTcyCJaiHkyqYCRCzO9Z/6MdpaXFMg2OOkcoOBlLFAEyg5TNr4rbQgMjcZ0ZOG4XM4NEHUO5eb4lTvIzsthRqmf/TFJmW7aJBYcyw8COkT8PoYWJGFwTdyRCF+ZEwx8AN5rVSwfmcjrZeXGHf258Oc/KFabLozXraMyrvJFaalAzn8l44/3TeSCRgM9b4HX/vwmlO6K1AxCNhtRlVGPv7AH/uaFwzqmkNtF7GAxFCVBTLpD5Q+XmeKQOmxtlZCjhQCAnHK6I2BeBcE6lZsDdKKcxkIdGQCsZZkuF1LGGv5DeA2+Wgk34SbGdJOa1/asilqcX3ptTGo0W+Sh+Fg9VmX1WlKhYFLBeBYvE5M+CPPN7uHHIP9NqOPZps9dFLpE5QNy7pv1BIsUz79iPl9CqvVd0/lpwhFTilLYnbv/1yW+OnSH3PNthN4XdB0KFSt0EnpfVDY3gcrbMk1UUH7KL97L/UlXxytrvtV1mbm13KSD16YIPkBQPCtrN/d+kKEUgfs86UQHSiTgYhg4kkdrj52pzb43Z23RxmMQ6qkCXdSWP297iQZJDouuecEe5xHHvprDX5VjHVEtvgrpg5xvW3NT0Rq14gGwnLkrGDa/vGMRpmUbanloWsbRozaNFZ79XhU7XboJpgAQEg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199015)(54906003)(316002)(6916009)(8936002)(26005)(6512007)(36756003)(186003)(4326008)(66946007)(86362001)(41300700001)(8676002)(66476007)(66556008)(83380400001)(33656002)(6506007)(2616005)(53546011)(478600001)(6486002)(2906002)(5660300002)(7416002)(30864003)(235185007)(38100700002)(22166006)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SFu6MNHK8NjSRrT09pZ+eMMBLIJaYsquCOoLIh4A6aMam6d1YfLhdly+PaoZ?=
 =?us-ascii?Q?moDTO3XOTwth83w1AZLI2WXvLEEv73nCb4WPy+oSSYKY1lpI8gmCsgPJYgbz?=
 =?us-ascii?Q?EBRWHg4OjngcPNd824CeqVOA4gqw6FZQvInTcuE0912y5NGTeWZlZFGQHliS?=
 =?us-ascii?Q?pv77iadkSaERQ/lTQcaLXBftL9a6+H6xraYGnDRPIXrXthtQ3KKJHfEbiB/9?=
 =?us-ascii?Q?Dmjsnh3mseCbLwN3gZjR+xS9Fwto4hOLnNSQQO1hZp6FfADls1AvEOljbhL9?=
 =?us-ascii?Q?iJos4j779I/WDlOD2mOGsCmScShUKZzzL5ZbTJdTTEUwNrFq6sdj8njISX4X?=
 =?us-ascii?Q?HPPLKXJOxtktVjc9Suupq1G0L8clBGOxTGuwlSmfDcHXvGv/ETx7+w5x6iYn?=
 =?us-ascii?Q?pOchYhJw1KjxyQCHMDeu+uIl8WEbNPrQzTaxz4Wld3Y4lwv+KiDlo7Gx1Qo1?=
 =?us-ascii?Q?2EfAFFnm6061TDstzjDfBUwWzTh1OqWZSlDzQRAWQQtGNF5HRNQA0FMIX+RB?=
 =?us-ascii?Q?074C1coJimjtsbFW/X5Ifo09EJIVII6Ax5yzWVw8x2J/iADru+lqcDMXQF+f?=
 =?us-ascii?Q?US8BmpqAZzYThv+Ge9DrKsN+KyiL03kwZX7H0pAuOrzGWXmapwcM34o+3ule?=
 =?us-ascii?Q?aCBWum8NccAT5lWyfPtNV8PQy71W3LNUo2fdZWNi8g4iSqtt6qFgU3wyjLTx?=
 =?us-ascii?Q?WtVf9J+maFwPie2M7HbVu/qtXO0C8j1KJp3KqqUcBig8lK7xpwI8GUbXB5mO?=
 =?us-ascii?Q?X3HDS/4nEoYbD4mvL0sgF1rnrBVlwXJIxNXboURxHcBbd2mBuGhu2KuuC4R0?=
 =?us-ascii?Q?0d5mjiilDedS/5LFv6VUCqrABWjSiOkXt2x40kMJLHprjEXpfF104zT2XSPO?=
 =?us-ascii?Q?GxR+nyeOufi/1DxXdro7XcLLTUn/ydFxIvlPy/DWcDptgKTHBLxHiJ2O54v3?=
 =?us-ascii?Q?FXWygIC8lD859oxX1FFLqyUKAFO5tbcQRyoUw+zEw5BC1Y27Yx5BzFWTkT2e?=
 =?us-ascii?Q?LtCpULf6MzKGPfVDMM58EIEhBGehDhavTQGa6QlK5rkNGhV04kdBi1Ngu09v?=
 =?us-ascii?Q?70e1GRWZjPKRbNuhQn8IacbR/5dqTDWGgZG6udB4KgKofrRt8K8Vl+k+1Ktb?=
 =?us-ascii?Q?wpI7hyMtm5spdu/WN4Mt//2YarQ4dx3cDgBmmqLNWbitA7Y3ny81A1JU3tP1?=
 =?us-ascii?Q?i1NjagnfcC0iob0ZvDoUQIyvQ+oxlspSOatk2bcqn38uQG/U/VAvRSFpjEKC?=
 =?us-ascii?Q?bpwUuzSHGE7opks3EYE1la09exlQKoUfxvsFxrmTFOmf08Qh/hsgcl1Ds5cQ?=
 =?us-ascii?Q?7t6ZSDz6x6FiFN3Uh7yNEYx/FfmRh99m+6us0O6YoGqmJ0+GUtt2x+qf4pml?=
 =?us-ascii?Q?RCga2ci747sFp76PEBq5L/IEn4Gm/KB6SYqYH02vWQoy03vZnDsPLyiAqRk4?=
 =?us-ascii?Q?K+Qmh1uMCJaW24cHqQCzTWkD68ThoCFYo+r0J8tGsOnzz/Fk3QcHrolhrw0Z?=
 =?us-ascii?Q?sBGuiF4Pbat4eBuAdz8q+MQAGigGR3yw/e5cmoyMM8Y4G7twjcU+GiKLjvFq?=
 =?us-ascii?Q?xiPc21ECFpfnGyLrowE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4069709-fdeb-4b5d-bf0c-08daedb9ed46
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 18:40:03.3178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aThIN0E3HbJKpB95lA2E/+dibSvpfI/q5qiTtg9bU+Zfe/5jyfdFDCcxyZUZ5N4C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5231
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_7CF7EA83-11F6-4CF7-A656-25454E7612E3_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 26 Dec 2022, at 19:28, Huang Ying wrote:

> This is a preparation patch to batch the folio unmapping and moving
> for non-hugetlb folios.
>
> If we had batched the folio unmapping, all folios to be migrated would
> be unmapped before copying the contents and flags of the folios.  If
> the folios that were passed to migrate_pages() were too many in unit
> of pages, the execution of the processes would be stopped for too long
> time, thus too long latency.  For example, migrate_pages() syscall
> will call migrate_pages() with all folios of a process.  To avoid this
> possible issue, in this patch, we restrict the number of pages to be
> migrated to be no more than HPAGE_PMD_NR.  That is, the influence is
> at the same level of THP migration.
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
>  mm/migrate.c | 173 +++++++++++++++++++++++++++++++--------------------=

>  1 file changed, 106 insertions(+), 67 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index bdbe73fe2eb7..97ea0737ab2b 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1485,40 +1485,15 @@ static int migrate_hugetlbs(struct list_head *f=
rom, new_page_t get_new_page,
>  	return rc;
>  }
>
> -/*
> - * migrate_pages - migrate the folios specified in a list, to the free=
 folios
> - *		   supplied as the target for the page migration
> - *
> - * @from:		The list of folios to be migrated.
> - * @get_new_page:	The function used to allocate free folios to be used=

> - *			as the target of the folio migration.
> - * @put_new_page:	The function used to free target folios if migration=

> - *			fails, or NULL if no special handling is necessary.
> - * @private:		Private data to be passed on to get_new_page()
> - * @mode:		The migration mode that specifies the constraints for
> - *			folio migration, if any.
> - * @reason:		The reason for folio migration.
> - * @ret_succeeded:	Set to the number of folios migrated successfully i=
f
> - *			the caller passes a non-NULL pointer.
> - *
> - * The function returns after 10 attempts or if no folios are movable =
any more
> - * because the list has become empty or no retryable folios exist any =
more.
> - * It is caller's responsibility to call putback_movable_pages() to re=
turn folios
> - * to the LRU or free list only if ret !=3D 0.
> - *
> - * Returns the number of {normal folio, large folio, hugetlb} that wer=
e not
> - * migrated, or an error code. The number of large folio splits will b=
e
> - * considered as the number of non-migrated large folio, no matter how=
 many
> - * split folios of the large folio are migrated successfully.
> - */
> -int migrate_pages(struct list_head *from, new_page_t get_new_page,
> +static int migrate_pages_batch(struct list_head *from, new_page_t get_=
new_page,
>  		free_page_t put_new_page, unsigned long private,
> -		enum migrate_mode mode, int reason, unsigned int *ret_succeeded)
> +		enum migrate_mode mode, int reason, struct list_head *ret_folios,
> +		struct migrate_pages_stats *stats)
>  {
>  	int retry =3D 1;
>  	int large_retry =3D 1;
>  	int thp_retry =3D 1;
> -	int nr_failed;
> +	int nr_failed =3D 0;
>  	int nr_retry_pages =3D 0;
>  	int nr_large_failed =3D 0;
>  	int pass =3D 0;
> @@ -1526,20 +1501,9 @@ int migrate_pages(struct list_head *from, new_pa=
ge_t get_new_page,
>  	bool is_thp =3D false;
>  	struct folio *folio, *folio2;
>  	int rc, nr_pages;
> -	LIST_HEAD(ret_folios);
>  	LIST_HEAD(split_folios);
>  	bool nosplit =3D (reason =3D=3D MR_NUMA_MISPLACED);
>  	bool no_split_folio_counting =3D false;
> -	struct migrate_pages_stats stats;
> -
> -	trace_mm_migrate_pages_start(mode, reason);
> -
> -	memset(&stats, 0, sizeof(stats));
> -	rc =3D migrate_hugetlbs(from, get_new_page, put_new_page, private, mo=
de, reason,
> -			      &stats, &ret_folios);
> -	if (rc < 0)
> -		goto out;
> -	nr_failed =3D rc;
>
>  split_folio_migration:
>  	for (pass =3D 0; pass < 10 && (retry || large_retry); pass++) {
> @@ -1549,11 +1513,6 @@ int migrate_pages(struct list_head *from, new_pa=
ge_t get_new_page,
>  		nr_retry_pages =3D 0;
>
>  		list_for_each_entry_safe(folio, folio2, from, lru) {
> -			if (folio_test_hugetlb(folio)) {
> -				list_move_tail(&folio->lru, &ret_folios);
> -				continue;
> -			}
> -
>  			/*
>  			 * Large folio statistics is based on the source large
>  			 * folio. Capture required information that might get
> @@ -1567,15 +1526,14 @@ int migrate_pages(struct list_head *from, new_p=
age_t get_new_page,
>
>  			rc =3D unmap_and_move(get_new_page, put_new_page,
>  					    private, folio, pass > 2, mode,
> -					    reason, &ret_folios);
> +					    reason, ret_folios);
>  			/*
>  			 * The rules are:
>  			 *	Success: folio will be freed
>  			 *	-EAGAIN: stay on the from list
>  			 *	-ENOMEM: stay on the from list
>  			 *	-ENOSYS: stay on the from list
> -			 *	Other errno: put on ret_folios list then splice to
> -			 *		     from list
> +			 *	Other errno: put on ret_folios list
>  			 */
>  			switch(rc) {
>  			/*
> @@ -1592,17 +1550,17 @@ int migrate_pages(struct list_head *from, new_p=
age_t get_new_page,
>  				/* Large folio migration is unsupported */
>  				if (is_large) {
>  					nr_large_failed++;
> -					stats.nr_thp_failed +=3D is_thp;
> +					stats->nr_thp_failed +=3D is_thp;
>  					if (!try_split_folio(folio, &split_folios)) {
> -						stats.nr_thp_split +=3D is_thp;
> +						stats->nr_thp_split +=3D is_thp;
>  						break;
>  					}
>  				} else if (!no_split_folio_counting) {
>  					nr_failed++;
>  				}
>
> -				stats.nr_failed_pages +=3D nr_pages;
> -				list_move_tail(&folio->lru, &ret_folios);
> +				stats->nr_failed_pages +=3D nr_pages;
> +				list_move_tail(&folio->lru, ret_folios);
>  				break;
>  			case -ENOMEM:
>  				/*
> @@ -1611,13 +1569,13 @@ int migrate_pages(struct list_head *from, new_p=
age_t get_new_page,
>  				 */
>  				if (is_large) {
>  					nr_large_failed++;
> -					stats.nr_thp_failed +=3D is_thp;
> +					stats->nr_thp_failed +=3D is_thp;
>  					/* Large folio NUMA faulting doesn't split to retry. */
>  					if (!nosplit) {
>  						int ret =3D try_split_folio(folio, &split_folios);
>
>  						if (!ret) {
> -							stats.nr_thp_split +=3D is_thp;
> +							stats->nr_thp_split +=3D is_thp;
>  							break;
>  						} else if (reason =3D=3D MR_LONGTERM_PIN &&
>  							   ret =3D=3D -EAGAIN) {
> @@ -1635,17 +1593,17 @@ int migrate_pages(struct list_head *from, new_p=
age_t get_new_page,
>  					nr_failed++;
>  				}
>
> -				stats.nr_failed_pages +=3D nr_pages + nr_retry_pages;
> +				stats->nr_failed_pages +=3D nr_pages + nr_retry_pages;
>  				/*
>  				 * There might be some split folios of fail-to-migrate large
> -				 * folios left in split_folios list. Move them back to migration
> +				 * folios left in split_folios list. Move them to ret_folios
>  				 * list so that they could be put back to the right list by
>  				 * the caller otherwise the folio refcnt will be leaked.
>  				 */
> -				list_splice_init(&split_folios, from);
> +				list_splice_init(&split_folios, ret_folios);
>  				/* nr_failed isn't updated for not used */
>  				nr_large_failed +=3D large_retry;
> -				stats.nr_thp_failed +=3D thp_retry;
> +				stats->nr_thp_failed +=3D thp_retry;
>  				goto out;
>  			case -EAGAIN:
>  				if (is_large) {
> @@ -1657,8 +1615,8 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
>  				nr_retry_pages +=3D nr_pages;
>  				break;
>  			case MIGRATEPAGE_SUCCESS:
> -				stats.nr_succeeded +=3D nr_pages;
> -				stats.nr_thp_succeeded +=3D is_thp;
> +				stats->nr_succeeded +=3D nr_pages;
> +				stats->nr_thp_succeeded +=3D is_thp;
>  				break;
>  			default:
>  				/*
> @@ -1669,20 +1627,20 @@ int migrate_pages(struct list_head *from, new_p=
age_t get_new_page,
>  				 */
>  				if (is_large) {
>  					nr_large_failed++;
> -					stats.nr_thp_failed +=3D is_thp;
> +					stats->nr_thp_failed +=3D is_thp;
>  				} else if (!no_split_folio_counting) {
>  					nr_failed++;
>  				}
>
> -				stats.nr_failed_pages +=3D nr_pages;
> +				stats->nr_failed_pages +=3D nr_pages;
>  				break;
>  			}
>  		}
>  	}
>  	nr_failed +=3D retry;
>  	nr_large_failed +=3D large_retry;
> -	stats.nr_thp_failed +=3D thp_retry;
> -	stats.nr_failed_pages +=3D nr_retry_pages;
> +	stats->nr_thp_failed +=3D thp_retry;
> +	stats->nr_failed_pages +=3D nr_retry_pages;
>  	/*
>  	 * Try to migrate split folios of fail-to-migrate large folios, no
>  	 * nr_failed counting in this round, since all split folios of a
> @@ -1693,7 +1651,7 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
>  		 * Move non-migrated folios (after 10 retries) to ret_folios
>  		 * to avoid migrating them again.
>  		 */
> -		list_splice_init(from, &ret_folios);
> +		list_splice_init(from, ret_folios);
>  		list_splice_init(&split_folios, from);
>  		no_split_folio_counting =3D true;
>  		retry =3D 1;
> @@ -1701,6 +1659,87 @@ int migrate_pages(struct list_head *from, new_pa=
ge_t get_new_page,
>  	}
>
>  	rc =3D nr_failed + nr_large_failed;
> +out:
> +	return rc;
> +}
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#define NR_MAX_BATCHED_MIGRATION	HPAGE_PMD_NR
> +#else
> +#define NR_MAX_BATCHED_MIGRATION	512
> +#endif
> +
> +/*
> + * migrate_pages - migrate the folios specified in a list, to the free=
 folios
> + *		   supplied as the target for the page migration
> + *
> + * @from:		The list of folios to be migrated.
> + * @get_new_page:	The function used to allocate free folios to be used=

> + *			as the target of the folio migration.
> + * @put_new_page:	The function used to free target folios if migration=

> + *			fails, or NULL if no special handling is necessary.
> + * @private:		Private data to be passed on to get_new_page()
> + * @mode:		The migration mode that specifies the constraints for
> + *			folio migration, if any.
> + * @reason:		The reason for folio migration.
> + * @ret_succeeded:	Set to the number of folios migrated successfully i=
f
> + *			the caller passes a non-NULL pointer.
> + *
> + * The function returns after 10 attempts or if no folios are movable =
any more
> + * because the list has become empty or no retryable folios exist any =
more.
> + * It is caller's responsibility to call putback_movable_pages() to re=
turn folios
> + * to the LRU or free list only if ret !=3D 0.
> + *
> + * Returns the number of {normal folio, large folio, hugetlb} that wer=
e not
> + * migrated, or an error code. The number of large folio splits will b=
e
> + * considered as the number of non-migrated large folio, no matter how=
 many
> + * split folios of the large folio are migrated successfully.
> + */
> +int migrate_pages(struct list_head *from, new_page_t get_new_page,
> +		free_page_t put_new_page, unsigned long private,
> +		enum migrate_mode mode, int reason, unsigned int *ret_succeeded)
> +{
> +	int rc, rc_gether;

rc_gether -> rc_gather?

> +	int nr_pages;
> +	struct folio *folio, *folio2;
> +	LIST_HEAD(folios);
> +	LIST_HEAD(ret_folios);
> +	struct migrate_pages_stats stats;
> +
> +	trace_mm_migrate_pages_start(mode, reason);
> +
> +	memset(&stats, 0, sizeof(stats));
> +
> +	rc_gether =3D migrate_hugetlbs(from, get_new_page, put_new_page, priv=
ate,
> +				     mode, reason, &stats, &ret_folios);
> +	if (rc_gether < 0)
> +		goto out;
> +again:
> +	nr_pages =3D 0;
> +	list_for_each_entry_safe(folio, folio2, from, lru) {
> +		if (folio_test_hugetlb(folio)) {
> +			list_move_tail(&folio->lru, &ret_folios);
> +			continue;
> +		}
> +
> +		nr_pages +=3D folio_nr_pages(folio);
> +		if (nr_pages > NR_MAX_BATCHED_MIGRATION)
> +			break;
> +	}
> +	if (nr_pages > NR_MAX_BATCHED_MIGRATION)
> +		list_cut_before(&folios, from, &folio->lru);
> +	else
> +		list_splice_init(from, &folios);
> +	rc =3D migrate_pages_batch(&folios, get_new_page, put_new_page, priva=
te,
> +				 mode, reason, &ret_folios, &stats);
> +	list_splice_tail_init(&folios, &ret_folios);
> +	if (rc < 0) {
> +		rc_gether =3D rc;
> +		goto out;
> +	}
> +	rc_gether +=3D rc;
> +	if (!list_empty(from))
> +		goto again;
>  out:
>  	/*
>  	 * Put the permanent failure folio back to migration list, they
> @@ -1713,7 +1752,7 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
>  	 * are migrated successfully.
>  	 */
>  	if (list_empty(from))
> -		rc =3D 0;
> +		rc_gether =3D 0;
>
>  	count_vm_events(PGMIGRATE_SUCCESS, stats.nr_succeeded);
>  	count_vm_events(PGMIGRATE_FAIL, stats.nr_failed_pages);
> @@ -1727,7 +1766,7 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
>  	if (ret_succeeded)
>  		*ret_succeeded =3D stats.nr_succeeded;
>
> -	return rc;
> +	return rc_gether;
>  }
>
>  struct page *alloc_migration_target(struct page *page, unsigned long p=
rivate)
> -- =

> 2.35.1


--
Best Regards,
Yan, Zi

--=_MailMate_7CF7EA83-11F6-4CF7-A656-25454E7612E3_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmO0doAPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUlZ8P+wa0JWsTt+xUAtunSo+aINJPJmlBovNUyJ6L
8jrymGFlZXtqEBY8HhtVokdL+YufYu1mT/zPYurZM8XshJq9pZg7V1bajwIo22A5
oCQBGA37Cj6YLC6eIg5aY3ZSZVIdVZPFMuDRv4beMdEAYqjHTEDzxo7lM5GAJs3h
3XB/v64wbgnncvUbJOvgasMf4+W6RdaG2/sFshSfSaaXHqAOxdt87vVXGd3Rr0BQ
px+DJhn+SvnYY/xCprNHZfIS0WcQUivgnxwmSoQYpSwgjxgP8jlm5hdlrJmsbQsI
QHU8nEXpgMcVmEmPi56G7Lro+qC4bAQUEO7wTIoqZefPSjz4E/krPE0M2sQhv42f
mBk4tS+o9dIA+VmfFp+ttNIPf3Jgr2GD/hedEbbFUTVHQ9PxZHqVNdc/mFXcIX8z
SbmqI9/ZIZuEN4psEnBf2d79ub3qHFxvZKPsbjD/d0buCMBAdAkU0Qr8UVb8LqFZ
xdmzZAQmO50vYNc9Ae5kTqSKfYNdioohI5G2hLtKQ6FxaJDi3BqM/XPx/KTaq+qa
SOHTXE/RS0qfrLOp2vr0CLyu5LkHY7eep17MOxyZ6puBQT0FRwENYxFEtMBb7A48
aHr5wk8E+IRYy7e9Qc4JP5RgZYdL09GBmFSdD1x7DzcyozRry1V5Flt8IpRpvDxZ
29tCILum
=U2ZX
-----END PGP SIGNATURE-----

--=_MailMate_7CF7EA83-11F6-4CF7-A656-25454E7612E3_=--
