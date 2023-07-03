Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459B77455B0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 09:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjGCHAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 03:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjGCHAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:00:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABC1D1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 00:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688367634; x=1719903634;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EB5Arsd3IyKo6Jcpn69u8atOC49BxFbJcDEKlLm5jUY=;
  b=MvzO3BDHSXdoEwbPoTt9T0AmoZuBzmPHfDKa7PMCFq19PGUj45CJzHIM
   BfVRg05iHeKCKdyXZDqSTHVQTC05b5bNFNv99e75cGU12IYlJsllEAvXE
   IalvVnrLwLqZXMymvAKwfRz952z0FTr7OygN/XWwP2HooMkcTHyM08d80
   f/pQdn6UugAvhntTVJATo2ZMBuVmZmgKwVp+Z5Di/A1sNlsYxABx6QBC5
   T0uvc+b7EsyroJ4pCOf7i9M6pqPDNnA5P81nVVwFo4tb3fEOTbUSslom6
   BAB5NfyaplpXhAb9DprAf0TIOXKfOaeY5JfQeZi+w7kIjqcRAbg/NSHBM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="352634293"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="352634293"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 00:00:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="842552897"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="842552897"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 03 Jul 2023 00:00:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 00:00:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 00:00:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 00:00:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 00:00:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NY1SE0KfrjrYvV/JD7pyJlmfTRBiqbgMfxp4bus7bTZ/bA1iYoAOl7MNss1QDlnvLFg2dmoYcEUClFAD8QWr8xhpxtFIviKecR6fupsWZM8rBNyWrKXr/NKTacgsKOh1lQ30AUv6BNcMFZrdSpZWlZkGyalqvG7+LaJX2tZlMGISNNJ0tHGfR/LMoM6OjqC8SUyLWzkGaHHgJXSRuFlGtimHbHZr2gLMKsAHnUY8CWeU2/UH8t+0pL/d8pWreGB9TSG4ycokSGm+c+/doOFruTpuKJwPVUboTdY+bRpymg59+DBxrrbxHAfwXVYa56so95rrhSNqV4Cnv9CJc8oLjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=er497K6vJg4EIO5odwEAdXyd/R2Tz8d2JrIrZblsqJc=;
 b=IysSFrdnTEriIzinQlAc7L8/gwil7bVTmKj0Z4gUl7x7NBk7d2UA+mQ7SgOZ51MyO2EVs/g1bTO5GkrApWJ9GehvSbMLN6oUIPmb/JaucGsfeaMGK5n1Qe27W6FKM9c4wmxCATeHbLMtwi3jLldFewI8AbMcWBPPtlFrOwf9BAY0yohTEfn+QoOVTs7Ur5U3lsMb52iaSItQsKfWl0ltgWndPigLK1VdHeBsjhrEVgbn9SSh0dPgbZV04Zf/36ytbezU7nc72rCol/p+KioEdtT2EmvMU5mAUDY8cdb8elUw6awcOszaFdvUBjT9z3I07iqtVgUR2Tpi+mQPht8Slw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB5203.namprd11.prod.outlook.com (2603:10b6:303:98::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 07:00:26 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb%7]) with mapi id 15.20.6544.019; Mon, 3 Jul 2023
 07:00:25 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Liu, Jingqi" <jingqi.liu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iommu/vt-d: debugfs: Increment the reference count of
 page table page
Thread-Topic: [PATCH] iommu/vt-d: debugfs: Increment the reference count of
 page table page
Thread-Index: AQHZpw6LRkGTCiKG3EuD2FnSmcqBlq+no0dA
Date:   Mon, 3 Jul 2023 07:00:25 +0000
Message-ID: <BN9PR11MB527672460238BCBA63CD3CA58C29A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230625022808.42942-1-Jingqi.liu@intel.com>
In-Reply-To: <20230625022808.42942-1-Jingqi.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB5203:EE_
x-ms-office365-filtering-correlation-id: 2302feb0-dd21-4162-4337-08db7b932d33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tVX1kdOJkUUHpVXcLmcpOYPkAdLGmwzj8HKPpscRP/tMuu61iCI4kF3tFtt0DpaPlek1Sy7ELrF0d0Yv9wHidgfFyyHp8QW9FW9qd3WJ5qROZBaEcC57Fuc/UikvYCBlHSoGcayVSkEpyJZZu9EXagVPiXQvjTbW1SzhENOJl9hgJMrPs5MzyXEJ4YXP3RNIBw7izbT+o6oPZ0hFIMIeWXYKJDKkbpsQ+qfhTdLCJYGA0w/deaJerZ27ABgVJRJPbPENKaPN7lees7eVFslJvso/9UyVc/ORMuq432Rakf4gvyxjL6dEyhjvIFyCT7eyEt3qbqV/F2JZy3D9OsUshmV8weeX1hNuglXRAjukXmXQI9Wc1jr8y6y+SbKp+AqXI5Dj16Cn6j3g8Rg+DNi3YxcPf5QnDu8KWpNfsulGlQduUUXXj1yJ7zc1rjAayun/+VfhnCEHnzpnypyDLCTdvsPoVeiuEBxAxfG6sRjGdmaNKSBwdwXuK4q39apg4M3avQGjA/Ne0riXUxlsg+AR0P9BMowtLekJy2ErA32c4Iwp1RhNQ2CyRQEPNou8oTm12dcn2IJeEMJUGJf1d/yba3VoG65NZ6cAzWBg6iApiDmXb8+4nKYf7KvloDrJcbIq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199021)(38070700005)(2906002)(41300700001)(5660300002)(52536014)(8676002)(8936002)(33656002)(55016003)(86362001)(186003)(82960400001)(478600001)(26005)(6506007)(9686003)(71200400001)(7696005)(76116006)(122000001)(316002)(4326008)(66476007)(64756008)(66446008)(66556008)(66946007)(38100700002)(110136005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gCpeByJ+5dgqPP35aO+R8feWzI1dB9k9b0WWWkdU5cCeKlUIbYuuz0By6cCo?=
 =?us-ascii?Q?8xqblSTUPbBYc0ZaFo2ozanMlZGjQ0yAz6keftX8b0cht94+Xj/hu7s+32l7?=
 =?us-ascii?Q?dvJoFMK8j7TmgUpKFmCKLZEHKzoLCR0NHnpvw0Wwm/yQ53zJP9YiELYxGLZC?=
 =?us-ascii?Q?EiZbzXhMPJJ4cQcoYwzamPU3J42hOrX9lBeB2u6AaBeBP+nazArSCeBEGOIe?=
 =?us-ascii?Q?YVcYwtSKHE2tqbw2fz6t+p982UXc3WZR5LQEWkUft7P1ihUoCchNH7XMpCJW?=
 =?us-ascii?Q?r3FC172iSc0QqEu3t2rMjW9E1HwM+I8rzZ7OzIZtfTQNxi0xVzbrTOUmsfCr?=
 =?us-ascii?Q?uBgevB8y1xEkXjwzOrc4TtHZmQZ132nOlmcB/MCcLUGjmW48tcV/Rlru3d1v?=
 =?us-ascii?Q?E0JL/GtMfebcxPUlWxKv2+wMTXTKfntZH2JZT0VxT8gLnfwFoJcnu+igLZgG?=
 =?us-ascii?Q?xZZ8AJYsRztNCYrFuyBQklTQOqDZzOtShfCIAvA60Q/ZzfxOeK/kxehznH96?=
 =?us-ascii?Q?XfBsbJjyA89ttscc+fSweBy7O8wfIYZNk7LF0IpvFiy/FaJOsxt/f/MGcagz?=
 =?us-ascii?Q?/tpPVGD7VDSb8WbD0+K/SIwleTn7nM0Mqg4h1LuM4OZluQgBfSc8Fln9XZ8D?=
 =?us-ascii?Q?3qPKKkZXBW3yCUM/W3AxCamli3aOhHZAzighJzoRutMzSGKrkBvbTzEmMM6p?=
 =?us-ascii?Q?gKurFUEciNb+pT6FZVStg4qpVFMEGtgfuE0be1WNw01vIPoqKDYEzLer0yft?=
 =?us-ascii?Q?QLxlWCWaQBV+lhBhP2x5PzS4FsirjWHKcecz5NV19UBrkzwTbScuWsroy5o7?=
 =?us-ascii?Q?gKAOeCAaYXS+u91XUibsi5TP71pSHWrl8LW1Q9SdGJtDVhgCkH+gRSAkpPDX?=
 =?us-ascii?Q?LdiEHXHdRGJ2R/Et+KK49c/9g3vshpUpeeFZjm0N1BdJMZ9sipWSRPkeRs8g?=
 =?us-ascii?Q?dX4FsQZxyrRNjzzLMzkNiBWu9tUtzcA/H+9IdpGwWlo5HA4l5XydyL7kmesr?=
 =?us-ascii?Q?s/ln5CL729cxPMXuWnANbt5ywwcAEtEM96azDaQSovsSIRs4Zjr9EOr9q+b7?=
 =?us-ascii?Q?/VFhF49cbRbw9h7PgDPH4EFIUbrWEmVt0GPw9LA+xvlrtfrKqDfHxUV2ydeI?=
 =?us-ascii?Q?0tacZ9MwX9yhltxNU7R0H0MvTTP2jyNxQQmtYmgtIetZ2EV5YRz+sWNBLLJA?=
 =?us-ascii?Q?i5IR48KCYYQDFSfCGGb54JrdglSCXgPh6ODI2VcqRySNQGUrHRzHUjXXBSbu?=
 =?us-ascii?Q?U8mhElFRjr4FJB2w4/4wRxmlMYj1wWC6R2MRTWIrqGUr4piUClhQw/v+ijkc?=
 =?us-ascii?Q?BOEFJXm+ynjn3vXJNELic5VpVIGrSPxzm/LiP2Us+SF3Xl08tcxHxmEU5Qae?=
 =?us-ascii?Q?y0iLa1ztlli7MMJZhLK4tMr7Yn6s8iy3yibpFduYAJV/s+sdY+tV9Wbeo6VE?=
 =?us-ascii?Q?o6+sJA62zK6JIjWpHUUmPnKzoB/ZQgLucY1RRzG2bcX0H5QLhVXFEAIPJm3M?=
 =?us-ascii?Q?gIRMtG+AksAK6kutAaecEq/Urg/U9bIOA7NZr2kdzx0ueU6He8+W6IoW0aop?=
 =?us-ascii?Q?WJFIRAdLHFFqqcZeGyUtP5JMn8AAJcTb/HFFN7qM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2302feb0-dd21-4162-4337-08db7b932d33
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 07:00:25.1688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sWnLvFzCvVr5qM5z6rwqV4qw3hVZqgt22maFQioPHORGtZb0+HYVCnf4+swhWc1sbtVahKX7f4+9bxZrPgKfbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5203
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Liu, Jingqi <jingqi.liu@intel.com>
> Sent: Sunday, June 25, 2023 10:28 AM
>=20
> There may be a race with iommu_unmap() interface when traversing a page
> table.
>=20
> When debugfs traverses an IOMMU page table, iommu_unmap() may clear
> entries and free the page table pages pointed to by the entries.
> So debugfs may read invalid or freed pages.
>=20
> To avoid this, increment the refcount of a page table page before
> traversing the page, and decrement its refcount after traversing it.

I'm not sure how this race can be fully avoided w/o cooperation in the
unmap path...

>=20
> Signed-off-by: Jingqi Liu <Jingqi.liu@intel.com>
> ---
>  drivers/iommu/intel/debugfs.c | 36 +++++++++++++++++++++++++++++++++-
> -
>  1 file changed, 34 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.=
c
> index 1f925285104e..d228e1580aec 100644
> --- a/drivers/iommu/intel/debugfs.c
> +++ b/drivers/iommu/intel/debugfs.c
> @@ -333,9 +333,41 @@ static void pgtable_walk_level(struct seq_file *m,
> struct dma_pte *pde,
>  		path[level] =3D pde->val;
>  		if (dma_pte_superpage(pde) || level =3D=3D 1)
>  			dump_page_info(m, start, path);
> -		else
> -			pgtable_walk_level(m,
> phys_to_virt(dma_pte_addr(pde)),
> +		else {
> +			struct page *pg;
> +			u64 pte_addr;
> +
> +			/*
> +			 * The entry references a Page-Directory Table
> +			 * or a Page Table.
> +			 */
> +retry:
> +			pte_addr =3D dma_pte_addr(pde);
> +			pg =3D pfn_to_page(pte_addr >> PAGE_SHIFT);
> +			if (!get_page_unless_zero(pg))
> +				/*
> +				 * If this page has a refcount of zero,
> +				 * it has been freed, or will be freed.
> +				 */
> +				continue;
> +
> +			/* Check if the value of the entry is changed. */
> +			if (pde->val !=3D path[level]) {
> +				put_page(pg);
> +
> +				if (!dma_pte_present(pde))
> +					/* The entry is invalid. Skip it. */
> +					continue;
> +
> +				/* The entry has been updated. */
> +				path[level] =3D pde->val;
> +				goto retry;
> +			}
> +
> +			pgtable_walk_level(m, phys_to_virt(pte_addr),
>  					   level - 1, start, path);

What about pde->val getting cleared after phys_to_virt(pte_addr) leading
to all the levels below 'pg' being freed? In that case this code still walk=
s
the stale 'pg' content which however all point to invalid pages then.

It's probably simpler to just check the format of each PTE (e.g. whether=20
any reserved bit is set) and if abnormal then break the current level of
walk.=20

> +			put_page(pg);
> +		}
>  		path[level] =3D 0;
>  	}
>  }
> --
> 2.21.3

