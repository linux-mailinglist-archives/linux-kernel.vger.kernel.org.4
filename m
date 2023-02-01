Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA27685DB5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 04:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjBADIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 22:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBADIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 22:08:39 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8417D619D
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 19:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675220918; x=1706756918;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GVximx8gJyblIdu355qEfvxpTd8G/Oz9X61b2KVoOms=;
  b=SAJe7AKL9Dym96Mwo3aSjTXatw3WMi/8o2xLO0zQK8LHqQkaSYvtbFvm
   UUoobOqmDMVc8yJ95itj91cyOCar5xP8R7Ypag7YApQUMjWNkI71QZimr
   gsaR/mqqLNm7MKO3w9GOdVSnzac70y90k39vvf4XhgB17wmV/mFgaEl2V
   HNyUFyrPJTF60rytXXimBuxGt653m1SI06eyQFPAgqNEv0KP2vvW4T8ke
   /oYErmbzu4W0HsZ3awAgzx56Y2qMmwIvqhNp2fHd2M1CMtFVMOyY6l2t4
   j6wpeoC5nKN7jFLOth+nt+nlYSWl4hnvRNGr+yBmxH8U3760s/HGGsID3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="414233101"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="414233101"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 19:08:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="695184483"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="695184483"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 31 Jan 2023 19:08:01 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 19:07:34 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 19:07:34 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 31 Jan 2023 19:07:34 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 31 Jan 2023 19:07:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYPinRfYj1cWRga4m/n+JfdJbUo4XJX3b4xlwsKHtR+JefCrj3xSk4Y7zveQuPI8+Vu/MTRzl6iDFg0KgfUADVce0EH0m2ht4a2o5Z/YG263S2zj/hSaBp4Rc+1WW9Y8oPkyqE6a0WQ5Yah87pD9HMyJe+h2xPBARTNQT1rlz/uSP1XGRTZ3EmYG4wzIJZIwPTPJgPQaJaV1eaFEQHYBe1751fBGcmDN6SnU27aUaUPo/Dnz6Knv7nJ/PDMINyfbJuqSboE4H9U5xl4mzmOwVoWFm7A1g+kIo3bdKwmXvd3g63I0SHX36tYHAe+KnqQ1nWg6o/GVEQ7cAoRbaUXRJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLGmYwi+FOz5SrEBv6Dl9Lio6tslc86tX7vmMZQWwGs=;
 b=gZxFS2JdcbMsqD6MMW2VmMIM6HwGYRfAvONHe7UEXn1Sb08s39fJyLWB44Fn2Zmqc3NjAcG5CHZQIZL/csVYiCTcucLh/JpTczJ7/ZCnEI2E+qg9JXKfV5R9GyfwsKcybLq0JVaC2A9TwTKYJaRUX+daXHUtC7MR1+xbKOcC0farEMCFUCv4pxvP1nsCagPE67PqzmGiq+BPbr5OdID3SQw659THe+X1qCIa16kIjNthh+jHIevd1EBt4re+Bbo7GeJs9ctwmrUx564BiWe29Y7XUoSAP5tluSdAWRQBNdti5aNV0SAkgKfG4cEOhfIUjliIju3VYx5OgHQ3HzqGHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW3PR11MB4585.namprd11.prod.outlook.com (2603:10b6:303:52::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.23; Wed, 1 Feb
 2023 03:07:32 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%8]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 03:07:32 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "Lu, Baolu" <baolu.lu@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] iommufd/device: Change
 iommufd_hw_pagetable_has_group to device centric
Thread-Topic: [PATCH v2 3/3] iommufd/device: Change
 iommufd_hw_pagetable_has_group to device centric
Thread-Index: AQHZM14dxdHVToGJbUKK/xSgiTyXrK61IE4ggAAUtQCAAY21gIACqcMQ
Date:   Wed, 1 Feb 2023 03:07:32 +0000
Message-ID: <BN9PR11MB52769883FEE25F0BA731220B8CD19@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1674939002.git.nicolinc@nvidia.com>
 <002911839dd30990d5e3135f8a0f8d41f14e856b.1674939002.git.nicolinc@nvidia.com>
 <BN9PR11MB527697E1E24784576C3FB7628CD29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y9ZMulxEyGvnvW0X@Asurada-Nvidia> <Y9eaLpD1XIvE/3Nh@Asurada-Nvidia>
In-Reply-To: <Y9eaLpD1XIvE/3Nh@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW3PR11MB4585:EE_
x-ms-office365-filtering-correlation-id: 4d523003-969d-4312-033e-08db040175e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TdzwfQ9fyI2Q2NRUluc35dK3urwbs3WYouerKcHMRJoQlfrT+FvyVTWoe+O+RISROK0APF79YuPhgfoeRK6JTej4L7NnnB9msfoIhQrYBFHriAd0N8D0r0qTg4Si9iCym/7AnZA5wkP3kwMpIDEPRtwjpCWONlYl4jF0GkfJaA0UWRfu2QA54f+O9t9GXR/8UW4428IZJdr5hLbG77LRUASXVru6TyhZra4dluwfo+M81mhyu0drOFDV/Vpa4cI5ZueMtT6+/ZxvClTLeNT1KI6D8m9taS2YE6IsVnt7wQpeF9Y+Ev1jNYOvckvExHD0USdaV/Re/kxVggaUCsCarkZ3JA10doBv+nGIb4hYzhpZP5bMj+o7Wzg0T3ZucFKsDv73/vVCWGWyoRR8YL0GF3iPGkt77mil4df/1RZ9z6XmTlEPmcfBFxwlrqwKqwfeu/i2cdSZ2Pax5ek+AV+j4TCZWjtYifh55SQ2x9wBuSRMQHP1W7lpxyyTQovYnTZnx1ZkpZFaLAhT/y3v/cO5rTUZNngfk0OYvmd69oAcN47FCkrPS9tRAKwzWIFke16Q/pQnmBEVJWCP+V9Ra9NNlI/WXW9HptWsij8fnu9MHR8spMwF1jHnagLXHwDs2dCw0YaZmh1XOmk9ncFGOXwYIg843uz9tS0BKTkezuJwmtB+0LxTyyDPHrk8UufSaX7vzI29lsc38b+Vva+luLJn1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(376002)(366004)(39860400002)(136003)(451199018)(5660300002)(110136005)(54906003)(55016003)(316002)(8676002)(38100700002)(76116006)(66476007)(66556008)(66446008)(64756008)(66946007)(122000001)(52536014)(4326008)(8936002)(38070700005)(41300700001)(82960400001)(478600001)(33656002)(26005)(9686003)(6506007)(186003)(86362001)(7696005)(83380400001)(2906002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZLPM6esuKvw1BFCenHlIBr+MSLalZJAGbZzJCiwTVKS6ihYTBsXQYeYQQRrT?=
 =?us-ascii?Q?bfItKRxvvSZxevlYD649Sd4x2/6K2XFUCeK2fdT3bQLwD3GZTveF5BpSoenM?=
 =?us-ascii?Q?QJ9F9GIeaqpT8r+ZOzqJ1t6k6ndO4vx5xES4NBju3X+oX6MhJch7A1RFcln/?=
 =?us-ascii?Q?RmXQb4+okyfHCjSPSfKnUFmXhjztkZmpcqeoQFwFVypiwWPTHzPsoqhPPSyy?=
 =?us-ascii?Q?XrX3qxwjZZei5+Worhr9DhSOw1uHS8K4vX7kSLywxfvZC01nmQR1QcZPnwEG?=
 =?us-ascii?Q?BnhhjlKClPIEfMDmkdb0DFVAUXoJ/x7gHuhsXRW8MHxwfH5W7CqwAT5PwGrs?=
 =?us-ascii?Q?unWL/AqE6TPv8OnYl6bSUhNBmO8IFd9hhhdiAN++vh/DUxAUrHlZ3cIlvrHV?=
 =?us-ascii?Q?vG2wIYDZZ/q2If3t6U7M8aCBdUc4ENdpS15AOh89wbshVArCiO8PZ7BJMEkL?=
 =?us-ascii?Q?VSDV7hNZVwzTXe9zlm6irBBRt14rLHUaeh7YBaasstpj9wiWDCbTzckp0lgs?=
 =?us-ascii?Q?FVDqcuM2zqwFdtu2LtMD26IGvVYvUNWCC3xK5xCGSLFas/dfRAcMninN0sEi?=
 =?us-ascii?Q?QC4n3RvGAcxEPZfn7ksdLf8S+FZ7j3+FH+I4opg/AzRTZBq7dl+l7wjWqWso?=
 =?us-ascii?Q?J+L8t23z5jH1DIFw7p35mLltO5SNBUQ5SqS8SkQu4b6mSgiM7V0V4S5cNRKQ?=
 =?us-ascii?Q?NhjlRoSoH2qBdvqeM7G2ODzyI6jQ1PwvIzGJM6P2tATb4aJwbokbn59poc/q?=
 =?us-ascii?Q?f9qKBeZGBcVgPrJV9dKMSco9o/SVNSUek8n1/5bje2h8+9ROK1YWFNt0wcUi?=
 =?us-ascii?Q?Ty1nUHlpsGP9z2X7P77kOHRao2+vn6fnUqi/fH1+cgWRpQ/xAYZZDCiB5JQo?=
 =?us-ascii?Q?ihUBR/StDs7tcoTxZqMh6Tkqu6lyh0eurkglF4o7ZesIxqAraN18f/3RNcFJ?=
 =?us-ascii?Q?yd/Dx8Ll2MPuYjAN4lZcr3aZ7n8aKc4qNt6q0BsmMAPOYDyf9B/ojn4kcbIj?=
 =?us-ascii?Q?s0ATmlQhdPhh2sFZdpMvc8WlZReGBtimI8RR2lLYdjraks1A7Hku22HsW+4A?=
 =?us-ascii?Q?t2z8p8jWF7yZS/rL2Sra2MHVzJHgLf+dV/Z5N/iNjmPP0sYwF0iYHRhaJkHg?=
 =?us-ascii?Q?o85ZqBHd0AJ4uMJrHIkT3B7twmBg++HA4Kje8/d3oifXU25psQnhFH+p5PcB?=
 =?us-ascii?Q?Wq7RB1icd3GS0FyaTAI3iuI3kJAaCizFK1tFHMdF3ozvUKtrNH7+eiVY5yYw?=
 =?us-ascii?Q?igdPLp9d2ea9FK4mrWzJ7DBXREixZy2HGnrtd/l2Bx3alvKIARhRZQvMeIPK?=
 =?us-ascii?Q?T0rcjZ2i9yt4PQXwvvvPIfHz1gV5KQvQvtBIw3L3b+mYUz525ZiS8PGFlSqh?=
 =?us-ascii?Q?/cnV7NH+gSfBp4p4n+rEk5UqFH650Kq9HPtibEoIzCbPqWKXokYOFjFnsLpa?=
 =?us-ascii?Q?kq6+5q4ZlMBL8DS2xWzoFTHUodpw5T61nKvrwjbEtsSXl4TZUerYHAmLrmLb?=
 =?us-ascii?Q?XCtxXQwMGfBRG5qtJMwOJUERmyg5lpVWbnXedZkJVTGaASmsp26FpeAgshOg?=
 =?us-ascii?Q?gdNjW4iGXIcV3g/UJax52C0H6KlFlZbmyITBZVCj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d523003-969d-4312-033e-08db040175e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 03:07:32.2256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M3ydMezYP3nX9Z3sA8CAR6WL7a4HwzzfMGvRp61FeuvHYGEEDEaSXjpiM1UKYR/upYcKaHZ3+aiKiLznzfqoog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4585
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
> Sent: Monday, January 30, 2023 6:22 PM
>=20
> On Sun, Jan 29, 2023 at 02:38:55AM -0800, Nicolin Chen wrote:
>=20
> > > > @@ -385,10 +372,8 @@ void iommufd_device_detach(struct
> > > > iommufd_device *idev)
> > > >       struct iommufd_hw_pagetable *hwpt =3D idev->hwpt;
> > > >
> > > >       mutex_lock(&hwpt->ioas->mutex);
> > > > -     mutex_lock(&hwpt->devices_lock);
> > > >       refcount_dec(hwpt->devices_users);
> > > > -     list_del(&idev->devices_item);
> > > > -     if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
> > > > +     if (iommufd_hw_pagetable_has_device(hwpt, idev->dev)) {
> > > >               if (refcount_read(hwpt->devices_users) =3D=3D 1) {
> > > >                       iopt_table_remove_domain(&hwpt->ioas->iopt,
> > > >                                                hwpt->domain);
> > > > @@ -397,7 +382,6 @@ void iommufd_device_detach(struct
> iommufd_device
> > > > *idev)
> > > >               iommu_detach_group(hwpt->domain, idev->group);
> > > >       }
> > >
> > > emmm how do we track last device detach in a group? Here the first
> > > device detach already leads to group detach...
> >
> > Oh no. That's a bug. Thanks for catching it.
> >
> > We need an additional refcount somewhere to track the number of
> > attached devices in the iommu_group.
>=20
> Wondering if we can let iommu_attach/detach_device handle this:
>=20

that is the desired way to fully remove group awareness in iommufd.

but iirc there were some concerns on changing their semantics. But
I don't remember the detail now. Jason might know. also +Baolu/Robin.

otherwise as long as the group attach/detach continues to be used
then identifying last device in the group always needs some hack
within iommufd itself.
