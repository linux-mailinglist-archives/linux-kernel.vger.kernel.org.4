Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCC67323C6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 01:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236884AbjFOXoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 19:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjFOXoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:44:04 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62BF2951
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686872643; x=1718408643;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XALUK8CxrqvXblZukmBJYltTIdhKDKAp+59PwWhfawg=;
  b=B0RJUu4BZ8A3ltsT9ZGPzCg5Wj7sJuyysbMKKR/b1NZOjjushpIT6Tpa
   SDmFHET0TXj6+TOonnfcY8wEK6xqbKl9AkmpeqKc5TDJdHrzbmxo/YHgk
   XJyVU5rmBg+8iUB2NCrDsp03uGqrOFsBXEkSHyrm7478Uav8sTAt+OKj1
   YY4j8tHVABWf/YJJ5mTMNdfD4sm9L2wEDoo99hhp+AXJnCMOM0Ko/bABs
   1qYGeQWb8kK1ZRWydup5nJlYxPIJKdy077370Hgzd1tcSZeoT6JnX8DGH
   dMDL60Rfq+8bk7wDLX+Zta5tTGNGQg42ZMJghIJ6D3zAUaGwZNduH35BC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="348776054"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="348776054"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 16:44:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="742431326"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="742431326"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 15 Jun 2023 16:44:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 16:44:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 16:44:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 16:44:02 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 16:44:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvCF54REskVT6UK7OlXFXxUY12diyAki7JGn1pzQGe+qSbBUAq8lbHlyE0xf146LHgoTevWRWPXoYkvhPlZtkNd+GP98K3t/DrwOBrFUwyhTEFNmjz8bUclhGv/OdG8pHZqm2suyhFoTUD9xupst2jM6wGQYYLbxOuJODEDZndWnIND9B9Ec8cFlevmYtqxyk/B2kXM+AiiWDTCoeJvzKOYGkvoAh2iBzG0TXrIPU0bpJ2+FVxg1ZK5RLdmCpzywReQWw0I37xo4Nn4XujfjC4qb4OQcM9H67DNuSEN7/51HCtB7fUusFL5FsR/p+LbZpEc9Gp8Rp1Me/M7pONetQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFzgceNh2SIWfh9SoXFa0oz2A4RmsPd6ko5zanol178=;
 b=QCwFAFpd//ERM83jE72fHCRph5OekjWVjXR3+RSCatx3MFZfdVNNR51UdD7+/SXMybmRcmidY/95Zu0SiQEyHxorUUO5NffoygOa1NXV56XRRq3K8UlHTlvZ0lkw6TlTYwqIS6+D7Mh+/uRIXxXOOf0lLGXDdzHhGje1l3KnvN52s0oiAbc2jIEKumy+e/nd1Q3yXA1bPZf3A3dO9VbkF7e/vRjBq+t0mbqU6d3TV8+ygVNKa1JXbWm4ebsD2CnQgj9x3h+Z8Fg6uk7MdVfIWFfLKf0v0aobV6hnYwOMo/hcuH2I+N9YQitmxm5WTHb8s/GUGywPansSXfwytRLE2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by BL1PR11MB5383.namprd11.prod.outlook.com (2603:10b6:208:318::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 23:43:59 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::a284:d072:336c:f233]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::a284:d072:336c:f233%4]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 23:43:59 +0000
From:   "Zhang, Tina" <tina.zhang@intel.com>
To:     "Xu, Yanfei" <yanfei.xu@intel.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xu, Yanfei" <yanfei.xu@intel.com>
Subject: RE: [PATCH] iommu/vt-d: Fix to flush cache of PASID directory table
Thread-Topic: [PATCH] iommu/vt-d: Fix to flush cache of PASID directory table
Thread-Index: AQHZn1m2Yu+6fSI1tEWmXm/q0t2Ghq+Mg/Aw
Date:   Thu, 15 Jun 2023 23:43:59 +0000
Message-ID: <MW5PR11MB5881C833CBC14D106DD9A8B5895BA@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20230615071613.690639-1-yanfei.xu@intel.com>
In-Reply-To: <20230615071613.690639-1-yanfei.xu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|BL1PR11MB5383:EE_
x-ms-office365-filtering-correlation-id: 822d2485-4d6a-4c35-7a7c-08db6dfa6438
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1OWjrXV/KUR4Uq5S3GqONMrMf8wnsHbWQcXWu+X4b2MsRlH0pCRmIWJhloYjkMjNZzxzYIZmtEYBqIQ9D9vOr+TAcoKWIfCi5O6q4rsi00gjuUvUe4mL9aAA/BAMmLu0Y0XbLuXsldASeH04qRCjQSoFn10DB0mujMsu+++PwrZUc7ZRYGtydt0I79TkHOKAg9IKW/NdA9GMqnL8Wzvkuelha6VLvHTKi0HvT9CdMQzChDQOogdOM0K1bvgisbk16zv3dtGKcE7U+31SDMzENN/s59pVHv7e1N7JpIy/RSWlslQ5+vr8XDAFseEHZcqGomeiaDzhVNLI0J6YZLsuSa3Y/BUF+t5wIbHvjch6Kz4XKWNrsZ9mV+qYDRDAPDf7PUsLbA/u3zAovHMQZuITx+i1/lVPZtv4FeVzHuqXrpdORARvIrt36lJn43Wo95AG4TV5OlcgqAICzradBIOgWboNoeLxlydclTwj696mSgj4e7l+MEfLSvLdTwKsPWgjQMG7DI+uG5qEzwWI9ie/krMVerx7D+gxp+pE36VYyXq0Djq+9Pxk6txM4UrzxtbDh2nFqx4giZikw8eoxqITU28jQ2dsx2sYJcMGk1JgUjqwCm5SWkQNu25UaBEoZ3D4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(33656002)(38070700005)(38100700002)(86362001)(122000001)(478600001)(7696005)(8676002)(8936002)(41300700001)(4326008)(82960400001)(110136005)(54906003)(316002)(52536014)(5660300002)(6506007)(53546011)(186003)(9686003)(26005)(2906002)(55016003)(64756008)(66476007)(76116006)(66946007)(71200400001)(66446008)(66556008)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?prBGf0e0M/8YsIkvvnDEGUHfxYavrpj3KSkXU9oPomVwqQRvV985rdP9Edzw?=
 =?us-ascii?Q?iDVZCrAbP/AfKvW/Gyh3ZLvAzg33M/H8vmvSQVLhNtg5OHoUWAtjOj/gADj0?=
 =?us-ascii?Q?hceyK9Er2OjqcWTs702UfKebqI1AaalwJk2VQpf7O+JoB5kBbeTLjW3trQ2/?=
 =?us-ascii?Q?K9Vk75Q+OwIYf77tECGJDtOq7IY8mCKUfVvMSVdepFNVxy3IkXBLEnwjKahE?=
 =?us-ascii?Q?MLXZ29Wuco4lc3ASn4LOMtqnsqBPUNL6mzWu1pU/nFKqTzFA8n/fyEWf4k8g?=
 =?us-ascii?Q?DN75NvwVV+Fnnvj4eWBSGFjHogDt+KM9+rxMKBRqAItlrxxMBsgYH8B5teKv?=
 =?us-ascii?Q?/RLrVkmQW0Dgm3WpbmJYxFhGMfMZT/eezOoi5YsckETs2Vnj+qNchN4ydQOJ?=
 =?us-ascii?Q?PkuU+Gp3aThMu6K6g/Xk/+XmIlJCduZmalg65Ccpl72kv+4+woNYMlAJLd7Z?=
 =?us-ascii?Q?N/oWcAvWAbJbj6aGVyuNT8WMP6WkO7WK6wYCSBKolYYoNSTCtDFqU/PqJCmU?=
 =?us-ascii?Q?Qj6ASrBepBYhj2JhqcaeYa1zWyEoHXDuIHPe+gQuCThHG5hdICQmsD9Z8Jx4?=
 =?us-ascii?Q?6DD6RYxbxwxVNkiMgguppCRAgxZ256rqo7OL/iR02R+xzmG7NXyb1zrrb7y0?=
 =?us-ascii?Q?Cu+7cOQR4t07JpPuRh7MUpScfsjHH3Zn4bKy3TT3qBYM4/gW1hqXb0SyQnNU?=
 =?us-ascii?Q?ZBcYZXNb+yop0ndygzJpB1oisResmdqU7XXU8hoxDcFd0cirTs1YUI92pSd+?=
 =?us-ascii?Q?jWeuK9SfU6uliFVSiQ32chxpTG7WU/ZWVcaMWTuA7FzlWdeYwZvI/cTH1vWc?=
 =?us-ascii?Q?H+eSP5BHqD8HqArVQkTB0dPYGxJnbF76zXgxENOXBS0milCpXVh2Pyu+EeNz?=
 =?us-ascii?Q?PWBxMIAPRbkvcdjOhzJ3qYWRghlD5mOjlFD4AubVFBjNMRx+u/ABdixKrdxW?=
 =?us-ascii?Q?0QaxJl6DaBHQ1OqEABbE+E528qCRByvviGg2TuVjNizJHJzoEfe3+54OFy3S?=
 =?us-ascii?Q?pmy7seYwOj4eE+Q3AYK4Vh1mU9E45rXKxdUyYtSoza0YYn5UsKOnIof18rDj?=
 =?us-ascii?Q?r3rXK3bJp7yonKdzVWDQ8DGO+09vL7oyaRJKDwb8GDpKP2jjZben4FBVcmMX?=
 =?us-ascii?Q?GCKCBczqeGNy1pxPtbdhupD7Ju1IAHO0+Phd4gfUUcvUAOFB8jBQNvvypArh?=
 =?us-ascii?Q?PjkN4zZ9NbObFk2wD9EZKGR+ubjr/wilzCvoLERHQ/hH2PyweXbLoq+hevCl?=
 =?us-ascii?Q?7NQhF4ARAmbwnnAf+kWjZCEaCdVy8eP7nTiy7y99ZhDQeMU0YnWG38rxiKFT?=
 =?us-ascii?Q?+K1+w+JrYNDBjz5UGrTGozRD3wZ15SyidFy0JJAjuVSU8bhZImV8AVeIX1rG?=
 =?us-ascii?Q?XL/WBaoNFpJ27BiZgPnB6ojaciQVnREaT79x/hbHia/PkKQ3fwLYpltXcPAm?=
 =?us-ascii?Q?7DuMj3d7f6AKv9EXgunTpFYE21WFVzqeDlf5Jwveza1W8TF9IbjxDWLZY0Xs?=
 =?us-ascii?Q?sHxOnP7Oi4lefD2dpe698rFP7hbyYN+6umPZJE00oBp//lnf9wAjUl/QD8f0?=
 =?us-ascii?Q?b7f70Gyn1hzfxc+Oe9JKYlhK/dCh+IX3VneRi0vn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 822d2485-4d6a-4c35-7a7c-08db6dfa6438
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 23:43:59.3728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UDJlRB82XKRcZ/7hVvTDiT0ZcQTOkdmdNRaowHfNQFpQ+H8ZjsrtK8L2bbgtpaxLL9QyMDyY3QKsoBYuw/EhJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5383
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

Hi,

> -----Original Message-----
> From: Yanfei Xu <yanfei.xu@intel.com>
> Sent: Thursday, June 15, 2023 3:16 PM
> To: dwmw2@infradead.org; baolu.lu@linux.intel.com; joro@8bytes.org;
> will@kernel.org; robin.murphy@arm.com
> Cc: iommu@lists.linux.dev; linux-kernel@vger.kernel.org; Xu, Yanfei
> <yanfei.xu@intel.com>
> Subject: [PATCH] iommu/vt-d: Fix to flush cache of PASID directory table
>=20
> Even the PCI devices don't support pasid capability, PASID table is manda=
tory
> for a PCI device in scalable mode. However flushing cache of pasid direct=
ory
> table for these devices are not taken after pasid table is allocated as t=
he "size"
> of table is zero. Fix to assign it with a page size.
>=20
> Fixes: 194b3348bdbb ("iommu/vt-d: Fix PASID directory pointer coherency")
> Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
> ---
>  drivers/iommu/intel/pasid.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c in=
dex
> c5d479770e12..bde7df055865 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -115,7 +115,9 @@ int intel_pasid_alloc_table(struct device *dev)
>  				  intel_pasid_max_id);
>=20
>  	size =3D max_pasid >> (PASID_PDE_SHIFT - 3);
> -	order =3D size ? get_order(size) : 0;
> +	if (!size)
> +		size =3D PAGE_SIZE;
How about merging the logic of the above few lines into this one:
size =3D info->pasid_supported ? max_pasid >> (PASID_PDE_SHIFT - 3) : PAGE_=
SIZE;

Though the logic is about the same, the suggested one seems more intuitive.

Regards,
-Tina

> +	order =3D get_order(size);
>  	pages =3D alloc_pages_node(info->iommu->node,
>  				 GFP_KERNEL | __GFP_ZERO, order);
>  	if (!pages) {
> --
> 2.34.1
>=20

