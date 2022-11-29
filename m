Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590C163B8C6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 04:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbiK2DfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 22:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbiK2DfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 22:35:05 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1376422B2F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 19:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669692903; x=1701228903;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/7fb2IDdy2t+c6MqkmAOiypI2hRGy5KZ9WlFax5eLxg=;
  b=gOQ9ntgg0qLC5EzVl0dqUGLhBfrnckr85j08vwEfEBnZ6iW2nf9Nx4Vs
   +OL3M0HgpGPAcZX6e98hIA5WbTrQmaOOb03f0pFtl/zlvqEsuHDXK5x8q
   /v0T4S1Bkq2i2uUfQJ8Q4t2570NEaTE2SRV0izKEbai7uWPxCoipczu3o
   SQ/LPFeL5FZCFaMXmiXPz7QQ1+A0FVXnJcWPeZgTyhNuOCBdcgNsbjjBm
   09KLjoBRtiWucTIjcIw4KgHFw4U6F8NvY7UWNc8Ba0J/lwlxH2uVXKaHH
   4MiC9yH7pA8dBc48honODavwcDypxOV2B88yMRob0DTdsyuvhYrUk6il4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="316146027"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="316146027"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 19:35:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="676283274"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="676283274"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 28 Nov 2022 19:35:01 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 19:35:01 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 19:35:00 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 28 Nov 2022 19:35:00 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 28 Nov 2022 19:34:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDhAVQV8IEHjqr4mMynmbx98mmKtSaXshKUgeRok7l4+SkcUbAS1W4JxDhuxgIS9znZrZ8j7kAkV5rgMTeJS3XEJs5mC5paeLxCc2x17KwhOVzTVr4qjSwK3e+vvmfYjQqORetVuulXDF/Dq/VCW2/+ACm3rQ2dciHcbkwb6JwC3XEPjhPBWnNb4KIOohbhukzu5ICtLho//kijpJy2dvxmSyJED5eg3yD4PU4TD9hv/Dim6NcJpJK267g3w+k1E2E+VCkEhMf9v4n5CIp0pYQG6hFXnN1NOWzlUHfbb/4F2L50plumHC40EPubxXm7z48rT9DO6KGViwRqoVcRkNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iV1E7xAfd10eCjxLOtgMFIwvl+1V1i1DJw0nqOiMAv0=;
 b=BFqjMmwJVJF1uUe8h5LddbM8b5x5bp5uwKqy0FWCNY6KWNwsU+2jE8YCVJURcXW1E0vosnIWma3ZJ2PBvRDXs6WDxiP/4rltReO/q/cDPgs9RqvTCqttIa8qd4TjyWBssGAnHRpOvgypWXXJMFqk9XF+eRgaTY9sayA5WvNuJDgFA1CahWqSWmSPvW2xfEDm8j/Jnhl0eQWkHMkhFppiDHxGSFCjQmjNHhpY1JjcjQKOi4ZHw8zBSPmHH5ms4xNi2+trxP3zTcHTdQWNbBlp3ppBwSH3vMSQvX9w0g5u/9Bf2k11FrV477jRH8Ity896Tju0qLei3ExI6vqo3GlVTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by DM6PR11MB4756.namprd11.prod.outlook.com (2603:10b6:5:2a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 03:34:57 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::7a7f:9d68:b0ec:1d04]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::7a7f:9d68:b0ec:1d04%9]) with mapi id 15.20.5857.021; Tue, 29 Nov 2022
 03:34:57 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>
CC:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Rob Clark <robdclark@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Chunyan Zhang" <zhang.lyra@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 08/20] iommu/sprd: Remove detach_dev callback
Thread-Topic: [PATCH v3 08/20] iommu/sprd: Remove detach_dev callback
Thread-Index: AQHZAvZZiCOMgUZ45U6s9kgD0YOasK5VPdYw
Date:   Tue, 29 Nov 2022 03:34:57 +0000
Message-ID: <BL1PR11MB5271FF59EEAC72D3C4A04E538C129@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
 <20221128064648.1934720-9-baolu.lu@linux.intel.com>
In-Reply-To: <20221128064648.1934720-9-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|DM6PR11MB4756:EE_
x-ms-office365-filtering-correlation-id: 424dad79-1bb0-418c-1bc0-08dad1bab020
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XPQ/nTfLQ6aG8cvklpL20UHpN7Zn4kmjrTbvruq+xIQTcmcIfKWGInmOsV9pOYeMUmhOHfg5N0p+cVa2qd8zHmpU8VTKgy7d8dcUBsTxGmKpq/sJmvrvSc6myQrdGN8Y67MyDz/sJDyv6/RrJX5f/tnlxaRa1wQs1F5KX4YSpgZjnUVBeivh8+18kvIb/aYRG8LzfkX5igCw1BPmLY6XzVJe5Vz5nKgkQ+CTMaFrkyW6j37cDhtvbU76intFis3/Uv4owxOKpy63Cy+woHImptcCzvwFcatMS1BIQPjeXAmkOjO57OB5CQwKqj9MKqPWP3FGAior6qExNxSTZKXx2G0ZcMuCbRdcIZUWIHU/wkpH1Q0fJaOTubX7lnQWAuhDKESGwyAMWTbG6sIT8pRMspv5lP2OzN5f/Jvx10/DL/GnlAKtSaG4h5/j1YpB3SkqW/JCS2iAd/vKGaOBYh8PHJeyN6dHhRu99lDzgtPJR1yZ9z5PYzP0jj3Tp9Zcq/3Ohb4+9Q8gtXfXuHz8CzTUusElTiRWZzg6omXbMLkX4Q7ye50vRREVQ3NR0ONGtrPNRzyzIk+BoN8L0mWOE/YwSrHmZOeFpod60IoneMV73AQ9ZxuL63qukXGAcV9TjvR4RstxtjoY9MC+dUuq0EYrsChaiYWu3A7fsQcCV47H5md+Vy8RzKDaB57Nn8lXAeb1eL/ciQ6qbAnhBZa0NQQNow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199015)(38100700002)(83380400001)(33656002)(71200400001)(6506007)(9686003)(54906003)(7696005)(110136005)(55016003)(86362001)(38070700005)(122000001)(82960400001)(26005)(41300700001)(186003)(52536014)(8936002)(7416002)(5660300002)(478600001)(66446008)(4326008)(64756008)(2906002)(66476007)(66946007)(66556008)(76116006)(316002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QGQwyg8XgI2nnfRL3KRVisT2Z1rjmKq8PIhoiIz/vwZq1NvbTS/qI7Y7mAUe?=
 =?us-ascii?Q?4gNC4HjD1jIaprp3xGaD9jZmRLeglo1NM7BQzOjqbw/tK8xEGzEhe4Br925N?=
 =?us-ascii?Q?nHL128YCMksjzzw6aNfq5MK8E2hsgIDRJZEsLZm4EN4k3tYXVeXXM7exZLTa?=
 =?us-ascii?Q?aVvGsjM1yjKdw7e9PmzxzddzIBjY5kEL9xlrrrT51XX9csok4qEIkV+u4FrM?=
 =?us-ascii?Q?EU5bAfY1aGsjrAhoGtS9FWvLKM3jPQ5sj7elsvEkRBXA/pc8Gr6szFF301zI?=
 =?us-ascii?Q?OyqevV70vS1hgIKZjAbYCFyttH9RLWlDTWwGClo+l1EVFzjOvAMqL3b33Cyl?=
 =?us-ascii?Q?0xE5oOosSJkWvzpgX4VEk9w6DKrbR7QqwQX4/Ea0veWDYY310XB3QkXKcUo6?=
 =?us-ascii?Q?mjIUbTnCjNaCes0VkfZ9kCwl7TyTLbiEwAauHPhTy/WOwCaLyLdWY1t+UbTZ?=
 =?us-ascii?Q?1W3EaZ0xzwUb3jCW1qI2XzULsEvJx1EAyRQKaUft9V6lRLjJrUa0THtVPORr?=
 =?us-ascii?Q?htFhHcTm0fkoS7ZiFtr0RPLDp6GSn2is4W/lDQ2uc1wjBwDBddzoEksCHCSK?=
 =?us-ascii?Q?nSzYQZz75QVd6UPB4R6oIWp5NMU6yn3ZzjXxaiK+UVdf7k/iFTy1lCxNDcWp?=
 =?us-ascii?Q?I/HAPYDWGL/IZFBjhwwYPgiGUJPO4gxOcstu+HEwMwfdSyhJYMDe4O3SsHdr?=
 =?us-ascii?Q?CJ3jGcvBYDl+VriNX/9bI5OyLoJ1g4/H55D7YlNKkXl2cYXE4R1ODX7VBh0i?=
 =?us-ascii?Q?rPX56If0vBz0bmJK/QU6lbMeQT3OzDrBL+m6XVhMsQDM8fDNRKTPrYwdGJ0p?=
 =?us-ascii?Q?PWgo33OTwNlyNftV6zjQPoR9im36SlI6u7CREypIixT5V4yGZAP1GwZh3xbD?=
 =?us-ascii?Q?ZHN1wCbMPBH5O+Ni7cBFCnpjND85nG3s6qNMgUReWVgrWx/29DfH63irOAtK?=
 =?us-ascii?Q?ctOd1TcS4sRGIqcFoveFVgXfLpaKAOuEMhkLIoH0e1N9dtuGCCkbDgmc95H1?=
 =?us-ascii?Q?CEXhD+UnGGazAU6h6E8N9ax7tUHvilZ+t14ySkkwSVaC/Cw3dDTpVqi6kq9T?=
 =?us-ascii?Q?ULo6Vtd+FSX7qS3aKjp/quZgcLNxhT7LRpLxEO+3qxjllUDDMC1e7j/m2zy9?=
 =?us-ascii?Q?KXxIXkUqkXt2sHQQSXxpGd57UebwJoRs3Aj750mz7/VBcjJCfrQmu9YWDk26?=
 =?us-ascii?Q?0gTV7j00TVxy+DTD4ASuEqpy9xr/53HBebm7tm13Zz67T/90GajCNka4e4+8?=
 =?us-ascii?Q?CShBYVHAGSGA/CMIclYBa+luyjuZa8rrGzIssTtXvqPZI8aNdQdzqSMAEH4P?=
 =?us-ascii?Q?ztaelJ84C74c++1CQVYGM83g5YujInC6EvGKRpVUhlXbyNrFx34f6xOAPXOr?=
 =?us-ascii?Q?hCPRqZn9ICQZwy3bTwhGV8ZGBanG2cVGLaJfmWGkvmPmGQ0Q+w7d3ZZ8gZPm?=
 =?us-ascii?Q?TYxYcNLi2lUkAhuIm2EAuLw+hXdmCWigU11pdnhZWpTs3i8kjmx49BmO1+ib?=
 =?us-ascii?Q?6EgnfH6Tg3e81qVVNz+Zn5itK++JGfL99RIyxslsHU+lOTmXRtN9wUE8GSGs?=
 =?us-ascii?Q?fIbdBZ5S0djUQKrcP2MYEWyutnqTHul8LxTVIVlc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 424dad79-1bb0-418c-1bc0-08dad1bab020
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 03:34:57.4894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EFPR7GK7NzhEqm59L1CZUSFlPY9sctBhTigBTgkio/4x2ld2AL19WiMAnDJf+CgeUf85c6MxqGYg8E5rbCSutQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4756
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, November 28, 2022 2:47 PM
>=20
> The IOMMU driver supports default domain, so the detach_dev op will never
> be called. Remove it to avoid dead code.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/sprd-iommu.c | 16 ----------------
>  1 file changed, 16 deletions(-)
>=20
> diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
> index 219bfa11f7f4..ae94d74b73f4 100644
> --- a/drivers/iommu/sprd-iommu.c
> +++ b/drivers/iommu/sprd-iommu.c
> @@ -255,21 +255,6 @@ static int sprd_iommu_attach_device(struct
> iommu_domain *domain,
>  	return 0;
>  }
>=20
> -static void sprd_iommu_detach_device(struct iommu_domain *domain,
> -					     struct device *dev)
> -{
> -	struct sprd_iommu_domain *dom =3D to_sprd_domain(domain);
> -	struct sprd_iommu_device *sdev =3D dom->sdev;
> -	size_t pgt_size =3D sprd_iommu_pgt_size(domain);
> -
> -	if (!sdev)
> -		return;
> -
> -	dma_free_coherent(sdev->dev, pgt_size, dom->pgt_va, dom-
> >pgt_pa);
> -	sprd_iommu_hw_en(sdev, false);
> -	dom->sdev =3D NULL;
> -}
> -

Looks this reveals a bug in this driver (not caused by this removal).

sprd_iommu_attach_device() doesn't check whether the device has
been already attached to a domain and do auto detach.

It's written in a way that .detach_dev() must be called to free the
dma buffer but ignores the fact that it's not called when default
domain support is claimed.

Then the dma buffer allocated for the previous domain was left
unhandled, causing memory leak.
