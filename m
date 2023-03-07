Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409036AD6B7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 06:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjCGFUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 00:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjCGFUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 00:20:13 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A07F34F54
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 21:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678166411; x=1709702411;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hcp6LAPaOmU4/S9LEnB/kNRBt2uNX6usjtZwQ2WqXhU=;
  b=gjFYJn+UWSr2VPysZbnjmNTB/ZNFb/bMxOSZPT5lSYjODiWpyrjSND7Z
   Xvmj02tturXEge9Ny9dDU25BaXWRJBlZEt3qQhDRCDgKsE06Rbh+f7R8X
   PAXT5wY/+YT4zdQx931+1D5JbVOZ9gGcAqHipfXikxnbNkietPpP/0mxv
   w49M3PmNamWa0uGNwrqwRAnokgOWZCk2JX4jdgUjGo0qG9z1ZURJ/iW4a
   NHJ4insukZRhIKnaTVMQjQK2C59Jv9PA06Ov1ZU4Vffnbpori+sDhNAjX
   zLHzXTnGZIRTPwM0Jnko3zbSfRjxVucbqtjnmaXtJ49rAMlvP9rULZI/X
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="315419393"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="315419393"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 21:20:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="850566371"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="850566371"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 06 Mar 2023 21:20:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 21:20:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 21:20:09 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 6 Mar 2023 21:20:09 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 6 Mar 2023 21:20:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2JSAe5ihsnSAmx+96WkRkORbi7S5LyF50nB8ShbvUDoj0yKIg3myh5ONRf3aHk1FD5FCl6J1oNPjqZvi+T7/67AjBfnik4wSN632ZUsLrmg55beTMobHLn0u5hTMbpTqfwTxduZF1cdSm7staHWl+1k4G8sSM3djaMK9yrzym0DCSDnpaJ4OZkyFw0Vh3rtZLSTPCLhBQJMt5X/xzxvCNZKvTd1iyD+/V1oHIPk+o6cR/lbU0whVxAdRO9TxF5B+K0y1iGNNWCaCzXsGXGLqOQG5YhfuTwV4OPr5fdPRpRpccD+p08oDqGQzd4PXaOS0FXCv5SGziKn+48BODsF/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hcp6LAPaOmU4/S9LEnB/kNRBt2uNX6usjtZwQ2WqXhU=;
 b=ZbXsqbyw0H3V31NCK8Je2kNmI/3hBrXuJe/EwafvHrkiI/uhzDWkslqghkXPph6BM26tgp+lRr87Sn/cInvUh0hW49MfGrBzsseSpOxD634I6pbUbgqmB+hOrT9ME62S6e9nvWrGDgJL3obR9wniKWHfcHvsvj4j8pYjA7D8giR5vJqzdflWddSyYRrIFi6/kbRpKsX6gJDOfMgrno++jHBgzx35vBG4RhXXOvSLAk2irRE7s9EjGgLC3M6ry3X0tbBnz//ZZLjWT/6UH8EvqXeiV2Np6VqJwMy9gmJKlVDZw/+mekVmCvav9IAPMrjJsjOTi/MLraGjVYNPzsB0Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB7593.namprd11.prod.outlook.com (2603:10b6:510:27f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 05:20:08 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 05:20:08 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Add opt-in for ATS support on discrete
 devices
Thread-Topic: [PATCH 1/1] iommu/vt-d: Add opt-in for ATS support on discrete
 devices
Thread-Index: AQHZSx5LcCU69hURF0uHJo/owYzpfa7kSKKAgAEL+ICAAKKKAIAANXuAgAAHqICAAnwhUIAAXoIAgAXDkEA=
Date:   Tue, 7 Mar 2023 05:20:07 +0000
Message-ID: <BN9PR11MB527661960D45F58A8C17AC548CB79@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230228023341.973671-1-baolu.lu@linux.intel.com>
 <Y/3yNaQD5Pkvf61k@nvidia.com>
 <3891a9a8-c796-2644-9473-aafc9ecea64e@linux.intel.com>
 <Y/9bWMoAYF10ynO3@nvidia.com> <0f162421-479e-6ab3-bbaf-0090b1a2472c@arm.com>
 <Y/+OobufnmGhg/R7@nvidia.com>
 <BN9PR11MB5276F192BCECE567DBFE21C08CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZAHziAcvAozFJ3Cq@nvidia.com>
In-Reply-To: <ZAHziAcvAozFJ3Cq@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB7593:EE_
x-ms-office365-filtering-correlation-id: 3ae0dfbc-d6a7-4556-150a-08db1ecb9df5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OSWIIB1tSGGBLplkJmjt+BYFswlfPcT4qiMu/eIiivXmP/uwVnuOlfZ3f88Js+/bm1ZXxcIPu0mEcaEhn8UuyNV9faWB89yz82viJYdWHfs9cYM8QiIZR4i3z/vFmRx21APdw3dwyNnh9EjZSxpP5jdZJYUYnQyeUP+DgjXQ9Yf7k35GGrY+sEtHxs9dOPx9nfm6Qff81XNq/chMtOsOivtyNEIvvZ1Rxv1abM8WOmM6ApTsubaBDLHA8/gjACYft6s1gNqzmj81C1PQYc9akXCcjKK/YMxewcyNPtO8xta5W+uYrr5kGtcIC67U1d3uyubOOabrgcy9NLsD2DFtjLXq5AI/nvPo7TRrNv3uIjYvn5yg+QOX+p2VGfG9I7h7WjG+cDdZYYO1NpM6pRpkZSTzmzGMQ2WhTjOZdTy5ATcKZSLzk6nd7/NCgFrVELkP+h55CzC9P/bnvdmiVgTBQpiPEx1xWNV5KMA4pZyb4Jzkw79JEBgO4oNOKVo2e4IqjHD38RDAPlryGbnWNHvR2cqp4zO8+z6VDNmzU19WHFLnWkswrIhz9y+3R8vLHrf9974a+xiFO/qE7GXXZv6uarvbpqfrZzRZ91EuW71Wox0gVW3cVYILZv18RMrk6tikF5qWmHfEXBFB7QwXbahKbHEneYGOv7dA/Ym7S10ZF7WUE7gzTyFxNleZJ3Gi3ClT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199018)(316002)(54906003)(83380400001)(55016003)(86362001)(33656002)(64756008)(9686003)(186003)(82960400001)(5660300002)(76116006)(66946007)(66556008)(8936002)(66476007)(8676002)(2906002)(41300700001)(4326008)(478600001)(6506007)(66446008)(71200400001)(26005)(7696005)(6916009)(122000001)(38100700002)(52536014)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s1nrpReSJXReRo5XTaS6Tu72t0BZeEQt3DFlrtSAdPcOmc7Rev6K2FLi9shn?=
 =?us-ascii?Q?SkoyEK0YWcIl5La3K8CiCFw1RR1HixOw3N6suelK9oavDOt4jlxXiOlO/rLs?=
 =?us-ascii?Q?1/oTuF/QodlX3lsX/rX5enEgMuUcIPSFiAsLCkcQtAOwEBf8lcuO1I+pulFF?=
 =?us-ascii?Q?dsGH6oT99GRQg8X3j9oDXFET9iUBpXd9llE5VC5y+dyq8uLL3P4w4XGiY054?=
 =?us-ascii?Q?kqshw98AIZi45dPH6MMUryCDDygYI91tCm82BqN+GD4KxdHvGzyTvURcrcbR?=
 =?us-ascii?Q?8Pbfx8I0vahp5eomd8DNG0nn//hWdZ0IPlQnqC3jAJENuBhHzcPHbp2Z+HW5?=
 =?us-ascii?Q?1Z7Ft8D+eaSXwnZzzArQq/Us3T+HIhv/Plh16/tl/obcojaq55RmyN4W6ZPq?=
 =?us-ascii?Q?fpPQY3aiz6MOsQ+4kfEaqXP3lBJ37Jd4rv32M5lms7R5NeQkGVv7IebxpEWP?=
 =?us-ascii?Q?kJ4Lv7TfdQrn9/fGyZ1TtwJMesF4qkpp6aSaniejD+yHNpvBdzue5vSFsOzf?=
 =?us-ascii?Q?YOvE4UOzZ918L17ALAoEiFE/pCJzym2E3UBCs+qA/yCAHR6BCRjpZjdY1fL7?=
 =?us-ascii?Q?isD233Bonqo1VWXLAfucpyES7goJ2mYHsRGsHQRVLQkcLVP8h+MMv/gB+0nR?=
 =?us-ascii?Q?ZVqoH8oiqO0q83Fs6zKIf0TKQeZPf/Gih6psQQs6T67OWLGTEbGdRG+m4sWE?=
 =?us-ascii?Q?mUShhuY/D9FmW8rBT9CuM5Yk3mQWCnWrg3ihbEWV79tHH//cJ6GNRXE9tEqT?=
 =?us-ascii?Q?9xdViaq86WvJGG9qNVZNFOMDmxmdoX5oy3riUM6S9mFwPm5FAblVYCNhqjlP?=
 =?us-ascii?Q?1OKDdZgcwrV2T/IqoBwJTh6ZdhKgxKvV6xzOrcwOEdtCqXHhyQv8w0zpdLt8?=
 =?us-ascii?Q?Ds49DFzNZdDpCNup0VMHkvLDmF1vNcsJ+ltNNW3Amhd2SwgYUvO093t+yYpW?=
 =?us-ascii?Q?DBaW48xHdc16bk0CItUTPWzIVvlQiwdkoGWruE3ZqVUvZejs0YQ+afF8WBcX?=
 =?us-ascii?Q?0CBxjl3ScvCzhnkymu+Sw7OI1XwExOWeyW538PYk98gT3lE6qo4y7pdAifIn?=
 =?us-ascii?Q?PeXizIGroGoVf3UihgVgaiPKOjREJoh5Po/XOQmR826YjcIkJG/rL/9XBR7C?=
 =?us-ascii?Q?9zByd7X0Bvpj6Di8wvdoPLLgXdsvSO7s8Pxs8b+lhf31pKOQvRpxe1bz5QtU?=
 =?us-ascii?Q?83xerlELbIFndR5BABcCdUqDalE20dfOFh2u5Ls9s0JNtqW/IYNHPNJOCNIq?=
 =?us-ascii?Q?qPiuVoUlPzktOxPER4T27dAwO7g8rOPOkRY+WdzL/c/ZdAgcLqvOM7QvK9Dt?=
 =?us-ascii?Q?HoTV9Y4gkbBjIvvvbgAQkXTmx4AA4m5X+mINixQfiuqhtVwFGQl0nWDQKHjr?=
 =?us-ascii?Q?AknNNQQrD/IMg/6vuuz7L9v/WUR8Ym3zebkGpIQ3uGQAOqla78Z6p1+kOWL8?=
 =?us-ascii?Q?AqdIphbwoywfG/2s8b/orsxDknDRxfRyHK+ZXVUXxYXIKNULspKz0KXdhtRZ?=
 =?us-ascii?Q?23s9cOIstPokUrbJXCJmH7g8PPDfb0nqOMr7y/YFOxnyRqd99j8E77IO6zp4?=
 =?us-ascii?Q?i0C3ef8uGwGOM9pxc+BH+7J65NlHYp/cg/mhzKNi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae0dfbc-d6a7-4556-150a-08db1ecb9df5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 05:20:07.9867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ygmTm/fuEWBDo1dEqwKCqac4yS1Pygo55tu5h7QVL1R5NNOwE3U/fKMDag5Al/4RpBWnEwH+CHZhgp5m+IiTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7593
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, March 3, 2023 9:18 PM
>=20
> On Fri, Mar 03, 2023 at 08:19:29AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Thursday, March 2, 2023 1:43 AM
> > >
> > > If Intel BIOS's have populated the "satcu" to say that ATS is not
> > > supported by the HW when the HW supports ATS perfectly fine, then get
> > > the BIOS fixed or patch the ACPI until it is fixed. The BIOS should
> > > not be saying that the HW does not support ATS when it does, it is a
> > > simple BIOS bug.
> > >
> >
> > That is not the purpose of SATC.
> >
> > The ATS support in VT-d side is reported in two interfaces:
> >
> > 1) "Device-TLB support" in Extended Capability Register;
> > 2) Root port ATS capability in ACPI ATSR structure;
> >
> > A device gets ATS enabled if 1/2 are true and !pdev->untrusted. Same
> > as SMMU does.
> >
> > The main purpose of SATC is to describe which ATS-capable integrated
> > device meets the requirements of securely using ATS as stated in VT-d
> > spec 4.4.
>=20
> Then it should be mapped to pdev->untrusted and possibly
> pdev->untrusted to be enhanced to be more descriptive.
>=20
> iommu driver and BIOS should have no role in security policy beyond
> feeding in data to a common policy engine.
>=20

That makes sense.
