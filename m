Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EAC618DE4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 03:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiKDCGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 22:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiKDCGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 22:06:43 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1C51C124
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 19:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667527602; x=1699063602;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vig1I1atZqlo7SLbaSWJMnNRgMzTydrsVPOg7nBseU4=;
  b=dG0pxRscholiaR12r+BTl+ezXWRJKE1SQbBoGfod7Wgq5mZWs2ZXKuDo
   zIL7eDixnK23o3JOU7S9lqYNO0KOhfMhZ3Xeo6z2inAIBGfXcrD3l6cB7
   tCCQtIVg6TZ3Ern9OHp+oamz3jj6+QSN2UBtSx/mLfb/ax4zdQ2SZ85TB
   JZy07Yi3VqGepvmv2YEp6I9pzZFof8LfZXTOo++UPLykXwO43GGIxz6vW
   Wm6L4tiq4TQk7UkT7I/ya1qXrxWFr+q4EwkxpbCtRoSGdyEPhkWeuE2qT
   2M5o1ShtVjBQwtdUjO5BImjHZdRcshFhLSt2VqymZ9lksDWAgXexAea5d
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="374092410"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="374092410"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 19:06:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="666199092"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="666199092"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 03 Nov 2022 19:06:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 19:06:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 19:06:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 3 Nov 2022 19:06:41 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 3 Nov 2022 19:06:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dj6LmISZLnCgvwKZLtpAT69AwhZJXjNJ+lh34t8krOQrzZRMFvTlRboPtqmot/9CyNuMMsOqR9mx8MpZXDxGCGyF3KGkzUL9qgPoxcd7BvKfhA6MND0lIrliOu1PMPDzAwIZq225KF5dfcVkrGlVVY/84os3KNdBCYaU5WbdkXokpwZcSDYn/O5eFp4twwyUJgqAtWWbhQY3daoik0sDcet5X2eE7RCoc9gw4lm0PbG6zqRc83UvA48lO7lclbijegGTT6Kf/bLrVOGcMI7rNqS3UYib5NxLgAJ/4i7sP4Rj9kp6IdGTOnV9TAS3qJR1el6TvKTwOPkceBSVEtCEgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXgl7FXM8gVMIWRplzDfvLGmxVe6zKJzqPHh0jxqFzM=;
 b=QyzFICQ4ec5sPiM+rQEeYv625lcFeslxX+m1CK3fvzkqyaluV7u1GjUKANZBWV7/cAv6k+zGvlbqyOqe17x8hQL44mP0m3dpZEi/88x0j8AVt30Rpo9+y66QicF8/3fz7Zc9UVZweGOL0VZTHay2tKnWw6NAa6tpGPYcAQl/U6oXYj7DSDsfiCfykvyhaqLKZzP0mfuAvcd0VzbRbdnOoFX4uI2DTf7HRHp5sLQaPlRwDCxlq5WCNVtRkSN7FWZjBEg7ZIp2pc6ZfD7wN5ZO39YYMf4qtzGKvTrgPrlXoKf/Yp/OqQBvpyHLqAIiQSAGjL0Z7wLXyVjg/Y7RcQzM4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5104.namprd11.prod.outlook.com (2603:10b6:a03:2db::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 02:06:10 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 02:06:09 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/7] iommu/vt-d: Allocate pasid table in device probe path
Thread-Topic: [PATCH 1/7] iommu/vt-d: Allocate pasid table in device probe
 path
Thread-Index: AQHY70mafo0sf+eGQk2VRBjKoctuoK4uBUSg
Date:   Fri, 4 Nov 2022 02:06:09 +0000
Message-ID: <BN9PR11MB52765902DF41858EF445E5BC8C3B9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221103055329.633052-1-baolu.lu@linux.intel.com>
 <20221103055329.633052-2-baolu.lu@linux.intel.com>
In-Reply-To: <20221103055329.633052-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5104:EE_
x-ms-office365-filtering-correlation-id: e951465b-5e4b-46f6-186e-08dabe09240c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pUDtkgsicDC0xdfHJKZdjEW66hSSigsBB4n5cEGTGsHa8acsdYxmfYR/g+eAUBNv2IQNVBWWnDFgamZGAEVCEZwKKwOChOGKvuoDSNvC+IdL64fhvHqCqwxBIaucpimqzeihinRneCpkleWSdYl3IxHfGVzKFekpUcj+/PTACl6cTzgOJSLxn2q1zJYzOosj8snYLZdgqz87uUiyN031hr5hIIz4Hca8njm25CyYe03KEe/yLNzCiKXMAJe3svyYIMJkYbnRsb9++Bx5uVyvHmjICrEkhaYB+dnmScKMkTxbyFtWKJk8vwTAKBf92gCI1mM/zLPF8Uefujv0DaDqvFm09iMT4nQGxO4YFQIiBKDAKgKu9eiIYF9T9Lp1fswhxcQtiQvM6WvMTo87nLzASyPUHKcjFwfYimkdH/6rTjZDnj75aDR6s1i3TGSre6PRHLgD9ZEWcSjS0Kh5ExQYQWm0Pq80If7e9Kg52DGI39oph9RXfmPAy19muqWvNZqLXaqnBJvgkraKSX4t+5+Lcg/kbbfvqm9Py2oHHjtHuMkV9dzFWI9tnJmBr//kXb68Hbh1mPe/OwCLuJ9AGvciP0k/Cryh/AB2jUeTIVT2Qq+c1t79IJQNTr1cv3xEJf/YkZKSSUcn/MCdSISkhqSBtTi7EhcdDhGc5XujhPjX6HTX6AIGcZHyamjadLI0L2x4BjOHMwUdO+PYcXXYHQHb5DE7PpOhbB09zMyNnIRc17yIQ2bDNQsBvqQ2KHTBROjgA8b6YCwfY2wRQ9dNvqq+OA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199015)(2906002)(4326008)(38100700002)(5660300002)(66556008)(55016003)(4744005)(64756008)(122000001)(66476007)(66946007)(8676002)(66446008)(316002)(52536014)(54906003)(71200400001)(8936002)(41300700001)(33656002)(82960400001)(110136005)(7696005)(38070700005)(86362001)(76116006)(186003)(26005)(6506007)(9686003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CJROaTKQDwjbIGQL5J01M0GNBZyYG59DCvp2gfj37eqShasZm/KopD/NWK7D?=
 =?us-ascii?Q?rarwqLl80eRjIn9RSZGp3qJD+m02+SxcOlDlPdHIMphj9l6zzyIbvlpluRLW?=
 =?us-ascii?Q?rUUiAn1uGZSDQI2H5RkHAIV5qN1DwvodUu0CIbHaaoa91rxXsP5jY1AQMEwu?=
 =?us-ascii?Q?eA4V1GPo8BuZssZnNgAExUqvW1XRahLEqLk6tW51omh6p8n/IfkUWCfB18CQ?=
 =?us-ascii?Q?ptySdlgB1+fUJgdH451Lbj5Pen7h/3le9PWGVo9I+VF1PlwGZRYmZX1YnGBf?=
 =?us-ascii?Q?Z5YeoYra8ASViWayT7WfAWnKtqhRpN2atanX6Cb5pX2iSnKnxTZ+QU6b2x4u?=
 =?us-ascii?Q?4jZI8Uwf8zYDFugRVcAmZ5RiyUJ3Vn67uRJC+fuV94WSL4qP6slwxmsfevc3?=
 =?us-ascii?Q?LGCozEoBmE/WI6w7JABhb/MF5Kp9uL9/wSTG600Wj5qOFqhAXgrfNw147xbK?=
 =?us-ascii?Q?ZatqhiR5Q2J7xexc7N3NmCWNmQfjwb20b31D9XXu0KpWnW210WVPZePwdFjl?=
 =?us-ascii?Q?fd3/AAxl4NDoOO7hH4MSLsioWOug3w0eJA9OyG4kyXJMqwCvAI3mw+MwTpgl?=
 =?us-ascii?Q?Z9aKsAshheH0LNmPSnIbO7K3v1vuiqRZdmH9pB0FW93LWPzwLN8oN1qCiy1B?=
 =?us-ascii?Q?gHiWZp8Vdk7LgOZayScNY09jjNFVdn2gmu2P3/NSZrp63uiccNUJRG5DMH8k?=
 =?us-ascii?Q?LxEcIUD43OEfpvFW2zqbuYbbZAuHcG2tC/9V5k+2lH+qWHGWhXaKpzhtVWVN?=
 =?us-ascii?Q?XoXo7zP5UbDr/WFll9V7Xd8P1oKF94xGaXkx926zPxCr0KbZ/Tp+cFuVZula?=
 =?us-ascii?Q?jCPxb4kn5bHdKnRWkf4eXz6/BemfDx1dpD4Dm5Ef8bAVx0btc+9ikEV6UpWU?=
 =?us-ascii?Q?oVr3L7IKuTBJa8BoJHtmcBdpxk6tySomhNfGrgQHu8mTsz3w+OvgQeYflPAx?=
 =?us-ascii?Q?P2qn8RzfTSOaw9KIF8QdmosStu/PA6N4IeXRfb2bFOOWDVYWVnkcE8qmzUVC?=
 =?us-ascii?Q?s7vMo6yEU0RkTAfgWV0uY4j8y2HCj9BIp5RLnisc812gelHfv5p92gQwU6HU?=
 =?us-ascii?Q?Jb8NGmyJ3uYzUVCMQS13U9k8I7BVRYQrQktxLAVeBUOLg6azHrVTNHQgWO7f?=
 =?us-ascii?Q?5Pf76Q5UdeVZs/JvjuMbgMvU51m9fIyAqUCt5U1PtomkOwo34jQei4gbvCMs?=
 =?us-ascii?Q?bv1RA0PQ5OfK+prfhlw96rYoHDwr25Nvf8iWegt/GyeNkZ8kiUZErmT1e3QE?=
 =?us-ascii?Q?m7sNxADitHO7RWs90bZuYWeTNJ0AErN6gs0fHEVcDrTTTmUFOYehRZ0W62qJ?=
 =?us-ascii?Q?BARFm/f6bvUvuN3CWa1GQwR2A2R1zmHf1tg8VrCWCd5RXT5KBiXJZFwnIzpE?=
 =?us-ascii?Q?Qb61DeltoQZJpwn3rRCcHlHHyTztQyS1f0gAuvkztOz+F2JrpQmQBl5YfP/z?=
 =?us-ascii?Q?PWyZ7pwJTEfVh5RiXAi5n78ELrwAh98/muHfB04PaSIstSWPNgCSB6Va3N9D?=
 =?us-ascii?Q?h/p2K1tgAJd7lJJI6KkGXZO6KtRuSLzuFGx2T6QgEQa5kp8bW/eJo/0LHesZ?=
 =?us-ascii?Q?gI8LZIwmAAO6ktkSWusCZvwBb28W8499Mo8qRToR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e951465b-5e4b-46f6-186e-08dabe09240c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 02:06:09.4945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: soch3TBtleyFdp2uZPJQN5JTY7CIhia7InBBFgbvpGnsFy0d+0ZFQgs12wm3M4IOcXizrYexQHLfBZje5+sAPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5104
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, November 3, 2022 1:53 PM
>=20
> @@ -4513,6 +4506,16 @@ static struct iommu_device
> *intel_iommu_probe_device(struct device *dev)
>=20
>  	dev_iommu_priv_set(dev, info);
>=20
> +	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
> +		ret =3D intel_pasid_alloc_table(dev);
> +		if (ret) {
> +			dev_err(dev, "PASID table allocation failed\n");
> +			dev_iommu_priv_set(dev, NULL);
> +			kfree(info);
> +			return ERR_PTR(ret);
> +		}
> +	}
> +

move the added lines before dev_iommu_priv_set()
