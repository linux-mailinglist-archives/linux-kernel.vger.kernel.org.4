Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F8567FDE2
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 10:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjA2JhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 04:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjA2JhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 04:37:05 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EF522024
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 01:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674985023; x=1706521023;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lOPM2e0hngMlebv7AEBXpmBM5PE8VyNYjZ4jVtf5HAE=;
  b=KxsKWy25u5bQXNzFA3qfydQU2SzuzTuswzTVw4GXwtVdzES1rN0ksUw5
   E15EP3u/udL2BHva5/ZwCBmLIvZF6MTwU/UJVsDfgupjOYUgftro9c0oR
   cFlcBG+EM9hTtr82ZsxSnapdUFB8DATPnBddvkcbGkKzl+siBUjkCJR+/
   v7F5td+HapvB9+k4qBJ9jE6+m+0iFvWDU79yCeTYDYUTC1vDTLbWYZSPV
   V0tHRy/hO/AFSOH8Iut0IfcM65YErsmQWZ8OECcjxwaDx3Uge8AegFvWL
   HiedYgZX9yftu1zOaPFkSlOmK0QLUeJtM/nFUfMLU/kaZk0LCS3TYz0VY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="413600839"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="413600839"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 01:37:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="665743326"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="665743326"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 29 Jan 2023 01:37:03 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 29 Jan 2023 01:37:03 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 29 Jan 2023 01:37:02 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 29 Jan 2023 01:37:02 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 29 Jan 2023 01:37:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8t0m+Pss8X2fKHut/7VYqvx8HqNNyxNKsub1DsSJSLtORnumGJIDiA+/WKswbzHsMUC6VBZ2vz8HTNzz1w0T3Km/TgKXwqufH7QHs10XtVhBZT2B1eyXOj4BYHMQT9czh0RWMpD+sW9jBLltjsJAqFKdjNeDPm4fdTMEeU0GI8lNVcJ7D7P4DaWaFzsJB1uU8NMacoqP0pBs26Nqr+GbPxBp18CLtoq6sKldIX1eltK5runnkhs3vxOQAz4IyrjWfpg0fqATfh3+YSczi8qbvdInruRERiV/RjybKFc0vPaopHmuAm1qNXW8JoL90Ch4OTbp7bbbo/bRLkcYOYgcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kD4FO61J8EsoCkkT8CQhccWnAa8U7Bp9xXypMN+KlwU=;
 b=jZGoJ7E8YpAX3UM0Mdw6KC+yWnpi+NPUUGmYLtkRQalcnCvPqfM/Z3SbOP5AZxmZSh7oSBHymoZnTAbX8j1WoSEZWURh1LW8qDqYCV+j+ZjSGjHIgx6+hNgvoix3kxKExgAueVMoSEE3UKq0O7X6wSiihAAXcNCQ7Ej2zVy7QNlrp2wAnA6fgQv2/PtTfPmjUL2UKoDl53qkZ+tP7aRjsagpXgqbHTpKiJIEB6I5Iu4HTch1F6F+um6GcwZOx++iQlny1QKOAeRPVyihjDS66mrEJtrPnHcoDJfqTomoNlFYetp486jdKc1SdwR8US5O95UFkHP1D7mfrLTdByvSJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6956.namprd11.prod.outlook.com (2603:10b6:510:207::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Sun, 29 Jan
 2023 09:37:00 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6043.033; Sun, 29 Jan 2023
 09:37:00 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] iommufd/device: Change
 iommufd_hw_pagetable_has_group to device centric
Thread-Topic: [PATCH v2 3/3] iommufd/device: Change
 iommufd_hw_pagetable_has_group to device centric
Thread-Index: AQHZM14dxdHVToGJbUKK/xSgiTyXrK61IE4g
Date:   Sun, 29 Jan 2023 09:37:00 +0000
Message-ID: <BN9PR11MB527697E1E24784576C3FB7628CD29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1674939002.git.nicolinc@nvidia.com>
 <002911839dd30990d5e3135f8a0f8d41f14e856b.1674939002.git.nicolinc@nvidia.com>
In-Reply-To: <002911839dd30990d5e3135f8a0f8d41f14e856b.1674939002.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6956:EE_
x-ms-office365-filtering-correlation-id: a1315344-8915-4451-90b2-08db01dc5f32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AAjWMD5eQ4/Ct4HQvdqoUI40xm08Yj3pwcwN8wcXQsk6rhth8HsfJ/h7UhlDKDE9RSeqbWexI/N+/W2VSDV5GbfgMcm3fbNInJ09dQJjz9F9m5QY5juqNRGRbr4yolYm2RAS4v8Mj8o3SErK+rTOXRKm7xigK/dbmTnW3D/3lbXmiTNVGGD11W8mKVeIKkNxipi/O+iI9U7VjCQNrYtuNIKeKDfeFM2QEe19CYpn6TeYSY+uZwiy9ZOjG0dWqdC8JlepVA5yKdulcuiCqdM/pYpA9A+LoeD83hx6YSiXVZ/kscLubmQaRSaLqhBHbn84bSKDKILEvOWXypj3j7HElxcmL8395ekQGlU94XM4uCJSFt7VpvzC1WrXN047ArXQ7ZF64T6AZyAlc7XlHjppgrjj6vd5ns2J+mX4voK/ZtbOthN3/PNsrXZEjbxw1yoS/jTOH+6NVJ+I4CltvGdzeQtMIR2R10/+jqt9/1H/xSMNjs6rTJsdjiScvS8KFEAlN1vVti3R0xJ20NiigIIVoL8MeVYDZ78AfustlPWEP5k95AlenG/oMk9JWKidiRsf0vI19+aYeNMpo0dY9hYhxLNILJhPdsUGEteGMfCX2FMQpn2BIpFqUdvQZEqt0x03jInLsFZP728S5+CsWTS5sThu1G5uza6ygNMzr3fVfrZndQJBxxIDXiP2Mgz8Z6PJ5YkCEi20VCcHDQJc4ZtcuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199018)(66946007)(66476007)(64756008)(66556008)(76116006)(4326008)(82960400001)(38100700002)(122000001)(86362001)(52536014)(54906003)(316002)(5660300002)(110136005)(38070700005)(55016003)(2906002)(33656002)(83380400001)(71200400001)(8936002)(8676002)(41300700001)(9686003)(26005)(478600001)(186003)(6506007)(66446008)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?20PG6aHsPSBDmINr97KR7QbB53P23YhyQTj8NIlb6sXgIoME4lx9sJ6w97uI?=
 =?us-ascii?Q?vp5i9Z1E8E5V2jrjSYeLdXHrVNA2Tc2iqTD6mpDpnO1ETyyiNKYc4m7WTgvb?=
 =?us-ascii?Q?fOGYvkolj8z2/KXJ5vAbXJ3pxQO/5J12wncFSlibROJsunFNpFSUnfxC3KNn?=
 =?us-ascii?Q?VG5RY2MVsnx6/V/6D0mGbfNmPcgbbtVVARn+ryMMhrzHRBTgdDHdM9jR0UVE?=
 =?us-ascii?Q?rMl+elG9MSk29kHoDW2yhgj/z7/bnRPGSQZJ2NPk5jfDappmg+o4g8L+VGYA?=
 =?us-ascii?Q?sprApWmfOipj50GHRJAlPZcO+JKJpU39Ge2gIqqNEr40r7EKqoKgYOyhxSdh?=
 =?us-ascii?Q?Ci5D+s2q2CmY7hu4qmOUGtC+VHrEmF+opg7jEIT930yU57+R2FZjfigwGbV0?=
 =?us-ascii?Q?D76MYbgvVdUv0Nrr+7L+SM2byO5MlRWiNR/M2xK2V3ZkcSpciVezMeFLR37w?=
 =?us-ascii?Q?H+fUiq0GDQe873mgQvgJ9yCX5TB3oS4Dr1tUJJe25hD/RlgGvwotOl0InNtJ?=
 =?us-ascii?Q?C+TiG0UstTjdozBLWuOf++W/lbUuqLMEX77z+qxNnVMd4J+noJkarTnLrxBF?=
 =?us-ascii?Q?pIgy3ux56X3HzRhwnLzr1dibYbSmk01WoylpNrbPCLzBHMnEWFDR7SIrOE15?=
 =?us-ascii?Q?Ip6IB1KeTfcwgyqOlm8uEs6vEIr6aTwssyAQ3qR6HZIluBlQzQaZHX8OvaoP?=
 =?us-ascii?Q?WMqDWZ5wRgh+ZUsHLIptcmyqSLFKvhUOMLa+OnQF4ET1yOXbPaFVbN8vgtGk?=
 =?us-ascii?Q?+AaS0YGTF+SNdpq4JLM6odrJsm+xbJLF2RQm7IukotutJoQRBKaXrQ7XWm7R?=
 =?us-ascii?Q?cfd4JAUD477tkBui0dS8R/rHR2UTX7ipS1aH7aT+3CfPGLfsBg2PHWLtTzd2?=
 =?us-ascii?Q?AIcdaYhtmk6f++u8YVXap3415sYJR4DxIDRZevxrkw5A46Cq4ojkDcH1TPQR?=
 =?us-ascii?Q?MrTb1XM2equFUvbJ/u0XUd+d+BKHYD5HMfo+vYPt0vdzQs0ZYBPk1n+nu9YT?=
 =?us-ascii?Q?VCo6Z8B7EwJKqWV1cXeMO5/of43Q732LRyH1QH5lDf4RvSfmlGWyL20BGQJf?=
 =?us-ascii?Q?zcGgzAuBVKGQfejo2YMIrxRM3lHfn2SQaSabaGvS94UibXwk3N+/D4u2m3U5?=
 =?us-ascii?Q?XNnbGoVzo3fbZJF/5dwz0PvK4DVvdIkh+gIU7ByE41EIu0yAc+iERldQwn2g?=
 =?us-ascii?Q?gZB+aPGnROyuohkD/45Ij8mgI8/4DRgZdjQR78xq6qzIgQCn7NHrJfgLmbcR?=
 =?us-ascii?Q?AygERDEdNv59H7gC0IMZaZ1MFpMyHmeH60vCsP/3P5f3T/gkIq/XSl3z+FcM?=
 =?us-ascii?Q?hFnfH3Z3c19LLto+3/5mFflyGA0Z+mz+1xaO91ekJKn7ZxoL6pPHx3hMAOmS?=
 =?us-ascii?Q?ncIRNqrcJSiibIVJcInBOrTGKMe/tT32zh8oFR6ebKY4lGmoDCPDkPZInkJU?=
 =?us-ascii?Q?h091U/KG/gTJkB3afeNEA4SM6hW8IEPWqCNZdRYoawBq3BZaCvFYO5dN5SVz?=
 =?us-ascii?Q?Sxz3WYiEznQGjdq61uCCeHaD9K5Ou8wsZbYvI7l8lDvPGkBgTDXaToerBsEt?=
 =?us-ascii?Q?93UcEP+92+148hlNXBEesWghya6DgbXjWfAgnist?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1315344-8915-4451-90b2-08db01dc5f32
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2023 09:37:00.4014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X4rCmV+U1g1O8uMZqyx23GY7iUg5JQXq6o2br78SJn2BCaemjASmMHfzCTLk0ySk7LIMbICLt2nPsnCfmWd2DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6956
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Sunday, January 29, 2023 5:18 AM
>=20
> -static bool iommufd_hw_pagetable_has_group(struct
> iommufd_hw_pagetable *hwpt,
> -					   struct iommu_group *group)
> +static bool iommufd_hw_pagetable_has_device(struct
> iommufd_hw_pagetable *hwpt,
> +					    struct device *dev)
>  {
> -	struct iommufd_device *cur_dev;
> -
> -	list_for_each_entry(cur_dev, &hwpt->devices, devices_item)
> -		if (cur_dev->group =3D=3D group)
> -			return true;
> -	return false;
> +	/*
> +	 * iommu_get_domain_for_dev() returns an iommu_group->domain
> ptr, if it
> +	 * is the same domain as the hwpt->domain, it means that this hwpt
> has
> +	 * the iommu_group/device.
> +	 */
> +	return hwpt->domain =3D=3D iommu_get_domain_for_dev(dev);
>  }

Here we could have three scenarios:

1) the device is attached to blocked domain;
2) the device is attached to hwpt->domain;
3) the device is attached to another hwpt->domain;

if this function returns false then iommufd_device_do_attach() will attach
the device to the specified hwpt. But then it's wrong for 3).

Has 3) been denied in earlier path? If yes at least a WARN_ON for
case 3) makes sense here.

> @@ -385,10 +372,8 @@ void iommufd_device_detach(struct
> iommufd_device *idev)
>  	struct iommufd_hw_pagetable *hwpt =3D idev->hwpt;
>=20
>  	mutex_lock(&hwpt->ioas->mutex);
> -	mutex_lock(&hwpt->devices_lock);
>  	refcount_dec(hwpt->devices_users);
> -	list_del(&idev->devices_item);
> -	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
> +	if (iommufd_hw_pagetable_has_device(hwpt, idev->dev)) {
>  		if (refcount_read(hwpt->devices_users) =3D=3D 1) {
>  			iopt_table_remove_domain(&hwpt->ioas->iopt,
>  						 hwpt->domain);
> @@ -397,7 +382,6 @@ void iommufd_device_detach(struct iommufd_device
> *idev)
>  		iommu_detach_group(hwpt->domain, idev->group);
>  	}

emmm how do we track last device detach in a group? Here the first
device detach already leads to group detach...
