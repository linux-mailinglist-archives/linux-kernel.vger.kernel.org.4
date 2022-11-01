Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1693614D29
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 15:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiKAOzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 10:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiKAOyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 10:54:53 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E97C2DD9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 07:54:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jokiAfalZm/yW0/2R/xyjqrtEMYP09uUdTdkTDb0QkrOmNU1J0phaD7W5v+6X0F6JfLwHkEoh32ja87GHChwtyxU7/qy5lcQCvI0XhOtuoSOnTXezOU94zFPsWTENo+hzqhZ5hqYIAq0aJPaUMmqCPEJHiJV32HogmKj258eSa3n2dhsYumtuQ3Jh98r0RbzCne/cwLe7+UF9wGymkwKGx6esqY+ZxXCduqmaUNq6SJBlRIj9qgD8xpZHzVdgagvSo61ZaN+BwHCKAWI2fEH52akySyA+l+iRE2aqMHbLQRBAWJCZTzMeClqaQ2MAoGLaOkP5EzsG+vY67I5ty7bHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWFG/WwQDy5ed6pNDxr3CjG1F8kTn02XpZOucMNgsdA=;
 b=G+Y7C6mtAEy1Lpu0n5aEXS/xYyOx5vxIlzV+N3f/TrRS/8nf8EbB4XQroZb7b7/64VK8hBsstbcvRQ2V45oUnms8fJh7lk4orge0SrUPJS1d1daM9PT9aXPQMRBdN2h7EcV+l+FBELCCUMQyXbSobNDsLNiklpy1h2vjddEpOEm/uT5IAfROE1mMhuwDGGiX360sCcsmDjmeilUZtL18AfQDai8ZBSVtIUCx6w4XENrENDtFqCstXwS0uS146w6SmC3iEdhbL2airKhq8OgZOe8QjhIObuqN+B8EcWdbvYjGPX4Fj+KCgyPSiCGRX0EDQQaL3tCm0pjPYiMewBraQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWFG/WwQDy5ed6pNDxr3CjG1F8kTn02XpZOucMNgsdA=;
 b=eIkZ5CSyYKOTBXDhyiUiwZ2VWm+Qab7zBMtXd1g5xgqMf7l1xrdGfNgJ++p/gjYmhvHWc0fzdPNiBWZ7hRLMPO/BlB34raj1/4su8kNmWfERvBNeo799XCJlYF+jeFNyClW4z1tS+dirE0blGnInS0zrtzUKAMh2AhW/XcxTyezwxwJPWDR0Pehkgd5IG2wAQbXS170raNJtKFYaB2Emr0Fri36KVc9nTuDD/rKryt/FDq/vPpFNauSkTgzKWrd3cRhYJ0+lUBBPZm7zK3r6CPnXqqhWQ2bQ3XcZed4u1EK6gzvx486HiLi06DLPdY4rj8FnM2c5DzCBXNS7TWKZTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MN0PR12MB6199.namprd12.prod.outlook.com (2603:10b6:208:3c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Tue, 1 Nov
 2022 14:54:50 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::7231:e0f8:d4b3:c99b]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::7231:e0f8:d4b3:c99b%5]) with mapi id 15.20.5769.015; Tue, 1 Nov 2022
 14:54:50 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [RFC 1/2] migrate: convert unmap_and_move() to use folios
Date:   Tue, 01 Nov 2022 10:54:48 -0400
X-Mailer: MailMate (1.14r5922)
Message-ID: <E53AAFFD-C10D-44AE-BD20-47BC7037BCC1@nvidia.com>
In-Reply-To: <20221101062137.83649-2-ying.huang@intel.com>
References: <20221101062137.83649-1-ying.huang@intel.com>
 <20221101062137.83649-2-ying.huang@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_CC157EDB-1B20-497A-9ECB-091CEF7F20B1_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR10CA0036.namprd10.prod.outlook.com
 (2603:10b6:208:120::49) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MN0PR12MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ec1a6c1-c149-4ecd-01e8-08dabc1906c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FJHqPFijzQ8m+YcjHTVU5fDDYuCp3eUSapnwlG7Flxe2NWIEM/jp27Kbm8uBjAdznnjsH/gm3jH1dGbNuacMIK2t7efgLlFsbaSUITTg6RPIEN8lXSRhCR28z6vRqFyCUUeLCAVN16Arz2rafjFz/rIa6os/x9U1lpU/2zIVWQfkA2Y7ysEunJp+3apuoGMItu7kHIdxPvp6e1RTanXtMeJ6qpa/IPJV0iDSHFwo1OPSNcKln5puWt9DMfzDKcL+3K8yABsBfwUFoENTpXxiAeR7PmVCbyw0Vp/fKtZ6DjGJ6z/O1ayRGAH80cerI3Kl62ayMYikWjKbkBBx+nS3B0STbJb+lwbhTfqmeIRBoYWUhYXTXHrkUOevf9D82NEiPfCkBSjE8f2dDqeS+iPQM6fxfhofgExg3aq7O7D0dHsgR1IWHHUTxg8xTUth3jM/OKZW3Et4HLnu4VaASFUBotI6n5BMLyB7vywJ0xiGm5mzjAm+wCpG8XLzlDRBj9HJ5SSawEmYs4obz+kXzdj1+aOuiZ2GLe1SO8uTZ+NXoIg67OuzyIlsQWEUlHzF6NIzbNkKLXnixQ1gAdTGyztsVgnQ0Z2u9lKKUBFXKtY/j12bp/4q+mYmSsWMKcKOTsEBMsM9jfpuxD8dFpu8BUNEufdAp/5vEHz2w3Af/7TFCgNfCxdRyobdHeW+ZX+Y+iNjRqME+qFF/FbwNK1gCIjRmnUiBllfReVDOpEp8z3rR8xRqSe2BzFr0gvS5BeVeEMO/lP19/mq4XIBzpQZazVJNh2bT6jUOXnYg+dXC/91J1Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199015)(33656002)(36756003)(86362001)(38100700002)(2906002)(83380400001)(6512007)(2616005)(26005)(6506007)(478600001)(186003)(53546011)(4326008)(66556008)(316002)(6916009)(235185007)(6486002)(54906003)(66946007)(66476007)(8676002)(41300700001)(8936002)(5660300002)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wdUzngS5pHECiikmyvWb0JsjFyTd5XAbp2Ac9F1CNKkAEWfHAh8c5O/vKG+X?=
 =?us-ascii?Q?z0iRt6vZtW5RJJW7U0ZhdoMCJPDyK9rQu0/aWzo3/tvGGFXWkrJTtBj3GuDn?=
 =?us-ascii?Q?gJoo0CsRj93Z/xmpbVqCTpFIRbwXAaPZ02pAGCCYB4q0RnJ+cePWf5eIDV1p?=
 =?us-ascii?Q?03pqwgl/A8SI/XnuqTKiOopnhJVeFk+RKpYxXPGFHIlXbFAaoBduTM6xeA41?=
 =?us-ascii?Q?7WWJG6TvVAZjhu8M2D4CLucR6p0LL/vEBSr3xW5oAv6RX1ICPLvedIRA+Nse?=
 =?us-ascii?Q?M7DAQo66khI8b1pF9Jpd5OW3iZjSftZAQYTkJDZrO4HtBZTg27P1VBoH7dGv?=
 =?us-ascii?Q?VVSSUaXQ4RGO1gEjvi04JGUwFept9q2F31X+f2fRWaW8eGME7xmqH2NkiiP2?=
 =?us-ascii?Q?spe2MKj3BUpcSwNEY49hmPnoW+RK3ehY0DuhvkMJCA0lBFtW4bYIo3DXIEA8?=
 =?us-ascii?Q?L+1dVxqQcdxSwCJSrFtDoRLidvRWjjor4EBw752O7QE6HrC0ojKpvRGNf1nD?=
 =?us-ascii?Q?yh5gPkPBjc68fdCGg2tMTJUv8HOBhWYoWXki3sPo//2FYlOwbEzW/VlVILs6?=
 =?us-ascii?Q?ziY8IaBpf+pbzMQWCjLx4O0FeEHOkPDNiqtxYl3kg75PIOTQHDTLrXtvl8f7?=
 =?us-ascii?Q?Bl1SVNo3WC1ccXjDNfQ5lOWU3QJNRTdhv7foj6L/qr/LdWvERgx1AAQC/qVy?=
 =?us-ascii?Q?o3KTV4ieQHoFBn50NRtQ/ZR2eKDwmSVh6J8buIvlZAAPiyPJWlgHZOArdr5p?=
 =?us-ascii?Q?R9RrSjjxko+1zh85LYkH0HG2ex0UDlUGDtGhvESK/wJqEvWuzpX3kuw1bo8v?=
 =?us-ascii?Q?RaLfFWVr520WVE1dl7X7Ti1XXxYgUeJheNXasI9/+6ByDHAgI7uXEIs+31iQ?=
 =?us-ascii?Q?cgLaCl/piRmzUmCsZtLh9Wax2aIc9ZJaz+bdkrziWxDFF6pWrnEduIpciSom?=
 =?us-ascii?Q?CbuE2hDCm2+xXIhTmKy1lEy6z3f8BwalX63cHd8xDeyfslGi0DJi8DCpV9PR?=
 =?us-ascii?Q?3syTKKJQL5lqffME0QA3ZiPIFcuhEnpM4A3mQB5Xe2viWVwK8ua8wPKVHX2V?=
 =?us-ascii?Q?UYwNVjELe8bnV7ySKsSY7zvKqWcwW5vA/pW6sgWLnug6IpzKwKDt7sWpAW7T?=
 =?us-ascii?Q?PI6E5TVJSlVYVmyYnOhIK0/1DZZshGqNHtduk3CtIl5jgQkwwB8rc7DF83Vt?=
 =?us-ascii?Q?aJpIlq92035XQbeJhY7JRDgjRwI5bP26gNAnlLo5aY4V8xZV27pUMD0QwiZm?=
 =?us-ascii?Q?xIVrq8jNV7NpC1Vd6Ai8HRKHcGqdkz3QKW4YvZWf2Ges0KDU+xi1+4LLN3UV?=
 =?us-ascii?Q?Ved6f979n3jCKQmgv/T0PZ+HalNwguwPiVVPmyVUA0idr8gLfDa8jY1ByHT5?=
 =?us-ascii?Q?gUnvEH0oqvIrngwVsl1Z2Ew90oPeA3Czjm+Tlf1cosRzHmUTRxRy4g5Ja1vo?=
 =?us-ascii?Q?PuIL3nV+aZ8SoE0PHl1rsu2NLAJj2eA1TQXssbi+uf3UQGJkCk0fxU0+aPr2?=
 =?us-ascii?Q?tQy0bTLBpnvxVIk/Qk+BoaygCQQ185J8ETnqv0FakamyNewHw/ott23DDuJS?=
 =?us-ascii?Q?+042Qo2ey3QFO+n/6tMCVcGQZ5G3yGYXm1r/Hjrt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec1a6c1-c149-4ecd-01e8-08dabc1906c7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 14:54:50.1662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJKdhiG3O2BXZ/+cUiwDQ46FNpPyP3lfVPEpW5oJ1Z/eRljEUxTLSnQ0XLFFVUbl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6199
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_CC157EDB-1B20-497A-9ECB-091CEF7F20B1_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 1 Nov 2022, at 2:21, Huang Ying wrote:

> Quite straightforward, the page functions are converted to
> corresponding folio functions.  Same for comments.
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Matthew Wilcox <willy@infradead.org>
> ---
>  mm/migrate.c | 54 ++++++++++++++++++++++++++--------------------------=

>  1 file changed, 27 insertions(+), 27 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index dff333593a8a..e625fd84b824 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1150,79 +1150,79 @@ static int __unmap_and_move(struct folio *src, =
struct folio *dst,
>  }
>
>  /*
> - * Obtain the lock on page, remove all ptes and migrate the page
> - * to the newly allocated page in newpage.
> + * Obtain the lock on folio, remove all ptes and migrate the folio
> + * to the newly allocated folio in dst.
>   */
>  static int unmap_and_move(new_page_t get_new_page,
>  				   free_page_t put_new_page,
> -				   unsigned long private, struct page *page,
> +				   unsigned long private, struct folio *src,
>  				   int force, enum migrate_mode mode,
>  				   enum migrate_reason reason,
>  				   struct list_head *ret)
>  {
> -	struct folio *dst, *src =3D page_folio(page);
> +	struct folio *dst;
>  	int rc =3D MIGRATEPAGE_SUCCESS;
>  	struct page *newpage =3D NULL;
>
> -	if (!thp_migration_supported() && PageTransHuge(page))
> +	if (!thp_migration_supported() && folio_test_large(src))

folio_test_transhuge() should be used.

>  		return -ENOSYS;
>
> -	if (page_count(page) =3D=3D 1) {
> -		/* Page was freed from under us. So we are done. */
> -		ClearPageActive(page);
> -		ClearPageUnevictable(page);
> +	if (folio_ref_count(src) =3D=3D 1) {
> +		/* Folio was freed from under us. So we are done. */
> +		folio_clear_active(src);
> +		folio_clear_unevictable(src);
>  		/* free_pages_prepare() will clear PG_isolated. */
>  		goto out;
>  	}
>
> -	newpage =3D get_new_page(page, private);
> +	newpage =3D get_new_page(&src->page, private);
>  	if (!newpage)
>  		return -ENOMEM;
>  	dst =3D page_folio(newpage);
>
> -	newpage->private =3D 0;
> +	dst->private =3D 0;
>  	rc =3D __unmap_and_move(src, dst, force, mode);
>  	if (rc =3D=3D MIGRATEPAGE_SUCCESS)
> -		set_page_owner_migrate_reason(newpage, reason);
> +		set_page_owner_migrate_reason(&dst->page, reason);
>
>  out:
>  	if (rc !=3D -EAGAIN) {
>  		/*
> -		 * A page that has been migrated has all references
> -		 * removed and will be freed. A page that has not been
> +		 * A folio that has been migrated has all references
> +		 * removed and will be freed. A folio that has not been
>  		 * migrated will have kept its references and be restored.
>  		 */
> -		list_del(&page->lru);
> +		list_del(&src->lru);
>  	}
>
>  	/*
>  	 * If migration is successful, releases reference grabbed during
> -	 * isolation. Otherwise, restore the page to right list unless
> +	 * isolation. Otherwise, restore the folio to right list unless
>  	 * we want to retry.
>  	 */
>  	if (rc =3D=3D MIGRATEPAGE_SUCCESS) {
>  		/*
> -		 * Compaction can migrate also non-LRU pages which are
> +		 * Compaction can migrate also non-LRU folios which are
>  		 * not accounted to NR_ISOLATED_*. They can be recognized
> -		 * as __PageMovable
> +		 * as __folio_test_movable
>  		 */
> -		if (likely(!__PageMovable(page)))
> -			mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
> -					page_is_file_lru(page), -thp_nr_pages(page));
> +		if (likely(!__folio_test_movable(src)))
> +			mod_node_page_state(folio_pgdat(src), NR_ISOLATED_ANON +
> +					folio_is_file_lru(src), -folio_nr_pages(src));
>
>  		if (reason !=3D MR_MEMORY_FAILURE)
>  			/*
> -			 * We release the page in page_handle_poison.
> +			 * We release the folio in page_handle_poison.
>  			 */
> -			put_page(page);
> +			folio_put(src);
>  	} else {
>  		if (rc !=3D -EAGAIN)
> -			list_add_tail(&page->lru, ret);
> +			list_add_tail(&src->lru, ret);
>
>  		if (put_new_page)
> -			put_new_page(newpage, private);
> +			put_new_page(&dst->page, private);
>  		else
> -			put_page(newpage);
> +			folio_put(dst);
>  	}
>
>  	return rc;
> @@ -1459,7 +1459,7 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
>  						&ret_pages);
>  			else
>  				rc =3D unmap_and_move(get_new_page, put_new_page,
> -						private, page, pass > 2, mode,
> +						private, page_folio(page), pass > 2, mode,
>  						reason, &ret_pages);
>  			/*
>  			 * The rules are:
> -- =

> 2.35.1

Everything else looks good to me.

--
Best Regards,
Yan, Zi

--=_MailMate_CC157EDB-1B20-497A-9ECB-091CEF7F20B1_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmNhMzgPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUHIMP/2pN1o/oNVJJfSOrxcNbrPm0XFgye1M0Hcam
sIJIrLgObtbcGCEaS2e5QUNEQwj71GIZ8F/jp66jjEbRZ7KMzfnmaPg3e/hPmP3y
7pQAzLLMrMPn0w0V0r36EDQaKt/pqUaf225CT8Khd9dkelMwxQbzo3quZagOD0s9
Yz8Nk5WsjABkyV5eaG0MW2y2lbh81Ycik3wXgHNoYLaEkbAtteh8DCpnirHa50Td
0td+eZSO+O2VaFsdIJtbLde+vwhvscmXUoFwWVuK3hzjF0vUqHu9x8ktPrHyGA9u
+ti5u7vmnfZl/KrBcWpJAB0nXUyn/qMUqUM67LhDBJ+qM12BNAh1MTJvLk39uNRa
d0d037frUJ1zq4XSiMKEPqXT6n1TD9ozPECbgbyH99vbQBvz3piu7cjYv/7ihJxu
i9UyBliFeihnRJ5CWgnRGcMvJyBI5vGPC/DrVB3nT5utqdAx54nIKA3mRiidFiUV
RZSrsKnjmuEmKiOF86iB92Jnjm43mI7/ldKQfE7arpUUKP6QazAVjTirMo4SutBn
25yt1tHYn3AnRFf3Ka1uQhw0Mf7K4CyRbRS89+eeH7KEwwFCLCgC7xCZgF6u4T6+
rfv9QYH7ZMY8RM635MnkKxpPskq9x2rEG5thqBO+WKFOcdC0kYd0R5aptMKgbP7H
loq80Wk3
=Tv9F
-----END PGP SIGNATURE-----

--=_MailMate_CC157EDB-1B20-497A-9ECB-091CEF7F20B1_=--
