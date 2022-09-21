Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6B85BF7AE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiIUH2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiIUH2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:28:02 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08758832E8;
        Wed, 21 Sep 2022 00:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663745282; x=1695281282;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Di5ZpMhMWJP2n4IVDf9g3x5cztGdpJuF36iiUFy1Vrw=;
  b=oGeUotvLUP09SIBBdv5gXUZMH4VZE9K2ye/oj0yUHV9pLw/CY7spZfr6
   eOHmaFPw7wo5wOQThNmpahcRSecsFlEMqhFIyErR/rysJ/9wcL2JXRMZw
   R5H7kIQz2OzS49foyC15CwM9KyX6/ic9xnv+xHSQBE4KGjw1/5mCdFtBY
   mEiEQ1ipiWMzEBHBO2bD/91Sz12YUmuGHoK9b0ek2mVY6G7G657WyiOX2
   YODd574kKOzxnA4bFiDRazKtJdOSDqG2ZmQFEp5KnaWYXL1wObtJTSoZD
   CMaYjYKbGBb23Tasx1Bl+tc9Ri/6Q3N3iRhetyAeyN7IW+ytZ2bc+vBFp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="279652830"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="279652830"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 00:28:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="614701622"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 21 Sep 2022 00:28:01 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 00:28:00 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 00:28:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 21 Sep 2022 00:28:00 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 21 Sep 2022 00:28:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3W2PG9Doai1q/+QnwNf1siGfBs4XZhStBByXbbk4QH6/k/9BhniRlA2dm71Fk3bfbG0fBQB1EFixnhWRoUnPoitGTv4x8fiURX+T8QahoMPQgu594tCdfNFZ4ewbH7G8Ol7RDivq5sSLDI8VbKSa4LGqmcKXUARpoEaJuoH7Si++f85mtS0DI2RXrjtAmqFWB4aqFRvuEPEb9bgTS2IpbKBB23FQmS+Q49p1dLhp4xzSIaQliVuvKMNATtkYIpJ2yHJy3B+11sj6ek90KZpVXYIsuWiQknmQ47xiXZB4gxezpP+WWF7TvQUkWtfsdI98LO9Tb3FFRfm/faklDcfkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgMPFfmlHs9JXkoJmG5UXlruGDUxWdfhXrYRh4zFeDM=;
 b=Pm0OiykBTk3oOpcxU98iz4Zx5pne1DuiVaanIOvQYS2xjgwstYlbW5vXV6hnYWvjJBCMCu70fAaNIZzc/HCGMwlbSmS4sEAtGFqPf3xHaLUt1p/qQchsfgQGHgiBU+IEX0wx4UIBQDPMDuF17Dke76QRUAsMi1hQ6QbAj+gqnN/JIFXBZsslcXeevwFqJRgAPBREmlnEjQ2zVtspkdjE8bCJAdF4rqU8+gNa8gFxhZHsjEVxKlnEmj3xZeljNyznEB+bwO9CQ8pbOM2FGe/n5FNTF5s/EG6US29PccrZvMnlFq0jps81hIFWbRRbRJooFmMrgisuKRaY7OqFN08+0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB4817.namprd11.prod.outlook.com (2603:10b6:303:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 07:27:53 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7%6]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 07:27:53 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
CC:     "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "konrad.dybcio@somainline.org" <konrad.dybcio@somainline.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "sricharan@codeaurora.org" <sricharan@codeaurora.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/6] iommu/msm: Add missing __disable_clocks calls
Thread-Topic: [PATCH v3 1/6] iommu/msm: Add missing __disable_clocks calls
Thread-Index: AQHYyNituwz1+Ol9PE2n60Ec81TVG63n3XuQgADTdwCAANQQwA==
Date:   Wed, 21 Sep 2022 07:27:52 +0000
Message-ID: <BN9PR11MB52768EA44BDD08ADE7B5067E8C4F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1663227492.git.nicolinc@nvidia.com>
 <031c4ec032025a299d72665118d58dd48aa936ac.1663227492.git.nicolinc@nvidia.com>
 <BN9PR11MB52769AEAFD33D2501B6571538C4C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <YyoKkIjiou4kBwPm@Asurada-Nvidia>
In-Reply-To: <YyoKkIjiou4kBwPm@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB4817:EE_
x-ms-office365-filtering-correlation-id: d8964aa2-c7ba-4118-c691-08da9ba2cb9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8izE4B85JZd11CE2GsPgyqdgVeWEkEmcsB6w0QcU0gksb8yJQKWezXPfl+qNVrAJAm6XepTyNZC5d/RRHlReTkcn0C2odhCtLU+QMWNzNBwTeEGo9WPvF1DSzevI5mI+u2AwTtb7ueNDv9DTZYNdS6y8/3uXAZpnErKqofM1TR7vFRo9pLdFsqdCzxeYN91i4fWGVLkPiVg7nEOmQNBGMZyWsFz7PezDbMqv3UB6XLMBpUcszjPKKb3WCMBj0M/H8jdmj1DaO+hWB5ZkFmFoBOox2f0QBFUKRcajY+suJHclI4nyXrp5i3a39JIsH3mz36htuk/YIcQVmXM5tQ050zT4XUn0zpF0LpvTknj+tw94FErq2inXSWxTkE81RYlQFAs5g8ORg/7AsVhAcAqYbgR1wj/mefg/FOO8Fo6C10ZPdrWVBI/hOBrnY1mk2c6zDYL2oB5RWlnVtFzcXtg49VmeotuNrYHLhfaqZBQkBtTFUxyuFwhh2P9Rzp/e9pF/YuVSF1v9ifvHJiry+aJ4HP5siEpCLn1YfSoBrEhfMCzpiTzi2VqvPS4214/eOARiQ6N40c4dqLwBXnwP63GDEnOTlorIjSz8CISpNObiLuPjLHv30+sWrNdHBRX3n0hcyXGpCaNKZ2mpIpA+KaLOenbgpRS7Via9u+2YAmmfZVVpEhlifC6IDKHBAxNSMlVYQ9v5so7UzJ3lMbWJnDzbY+JxXqOO9jSCT4Tbrgf1viuc6lE5Q9EttytHFaoINZABLVgrGD4JzYF8aQi8ZOGjvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199015)(52536014)(2906002)(5660300002)(66946007)(66476007)(66556008)(64756008)(66446008)(8936002)(4326008)(76116006)(8676002)(316002)(33656002)(38100700002)(122000001)(41300700001)(55016003)(86362001)(82960400001)(6506007)(9686003)(26005)(7696005)(54906003)(6916009)(478600001)(71200400001)(7416002)(38070700005)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lUptaIEITzzH86zyKWYBDVENSn6cDDYEyhWyEcTX7FD+K345KykXPQBRqEyZ?=
 =?us-ascii?Q?jSzE+vB4Q2ftNSUPS/23pa214HnpLmcmFZBA2TxqvrSq6V5cGg/9D1433GaX?=
 =?us-ascii?Q?Pswf3m53iJMeszY+R3IKKXBOYkZogUY3jtRbQ9PZM4Ie7dgaMnTYtXAF2PK1?=
 =?us-ascii?Q?9T/YrKXJavLvQpoTlMbBed+HHNcjafbs0fZpzQ1yihf44FCHUSFumpInTV+Z?=
 =?us-ascii?Q?Ahly+1OXTdthtepaZuArmZSu+dXE3aKlrGsRJLxoODjvCAgnJuCsqpnN3WRd?=
 =?us-ascii?Q?UmaLFf8vd0nXyxQVpohHbQ46HmUf5UpiZe67bNgvsxRT3VU8O3PCLJF/nsma?=
 =?us-ascii?Q?IeXQi/Jjyxjk0fxsNhoeuMlhQRtO8h1dbRQfk9L/K5GObH1Mr9W82WVvA8fk?=
 =?us-ascii?Q?XoOOAUZZWmmXKqTcjGKq3JwrHlO6eORW0gO6oqjjUMwEaEQu6PR28g0S2qf1?=
 =?us-ascii?Q?uo7vfHb43SQoTTEI44s4Wf+BmsEXLcN9IQFNoitDjywryYQMAQhgon3GbgoA?=
 =?us-ascii?Q?YnDel4NCiJ6TFBPCm4pchMgNw9RbiTMi6Mfj23Bm8zHs7fgwP9/4Oe1/HLXN?=
 =?us-ascii?Q?c9TvuMNLu/aVNuTaEUPLPqFgNIJjihXrsxWIFNc6Q9oIUc0ed40f0t1Tu8ot?=
 =?us-ascii?Q?/1inIaSfGu3Or5/fGgD4MpBGwMX0neRprCek8iwVDpG6BaslJ7OCog+SK7W5?=
 =?us-ascii?Q?G5uJXebHvaC7vwNX5/CvbvllytwbJySWb/PDjeJc9yMPsERLthp6AfMHGL+l?=
 =?us-ascii?Q?vXlAvfW6OLEPEBb1EQs5dQ8fmkk2BBwoIT/WmQZAsmelsNWeHRPL3pF35PCL?=
 =?us-ascii?Q?ai0XsWEUc57ecSU8XQb8Uxc+18Xi2o9X4YzdpMIuRv2WS5gzzt2uut3ZCipL?=
 =?us-ascii?Q?KgOpIXIUfOLMA3474DEbKin9173f2+0LkqhREfuYNAHTN4Bjij9ldCGv4vgJ?=
 =?us-ascii?Q?XIABKr39x2dBDCWQXBPQNyH40EMaPCZldiRzfhY4eioD28Bw9ont0oM8W409?=
 =?us-ascii?Q?qf0cpD4++w4LSJtkh1W7tVZqcf3Vt5AWuEucfb8ld6mC8QmdsoWgUyMSt789?=
 =?us-ascii?Q?7yWvUU3VFrlyHWkNwTrJmYaollOAi+LljwtaxErRHEg7yrQF5pZ9LpnJouay?=
 =?us-ascii?Q?QsaDUAzXgiuNMsk81n2nMw/h8pFW6Fnk0uiSP3ts1KUgee+jF+p5viypzDr9?=
 =?us-ascii?Q?YvKm1p0/bycO+lj8U95e9J27HmrlTRL7mcCsmrOHMkcxAlkqUS/uBq3Ta+Y+?=
 =?us-ascii?Q?494XuiYbEIbl9UPGlWhLvJcAQFOT3Rbnd3We+BAzYD58shjk2hTBb6BLTcub?=
 =?us-ascii?Q?p8wx0sN+rg+jLZBFhHkUDG/yvOY76ctevNkiVl8Q0UMdbNMp6QtVujocm+Ox?=
 =?us-ascii?Q?PA2gePKbiy8uz33IdkuGaTguoy6WsCramLw/FEXAlFxsyMWcBz0tIERSU3lb?=
 =?us-ascii?Q?y1U7QGgVa/fQsXImxFTUEFszmtfUAeffnJPl2EsZMIZD4JthnL2xRO/0Rp6h?=
 =?us-ascii?Q?mD5VDX2FccMvO89Nmxme5oNGBa7kA1CFApD51QjE1Pntd8hyD1ke6VLSDLKm?=
 =?us-ascii?Q?mo306DBVbdtG/wA1Lnu9a11mqm3Ay7IaZoWVVQd0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8964aa2-c7ba-4118-c691-08da9ba2cb9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 07:27:52.9443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4XTARPKU5woLnFUHHEemCsCGiVy3pgUsXxXQvjOZi8d8sos0PGFyyg3KrgmILpCp/k/gSY8vgeAy1OzI+SUdSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4817
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, September 21, 2022 2:47 AM
>=20
> On Tue, Sep 20, 2022 at 06:15:21AM +0000, Tian, Kevin wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Thursday, September 15, 2022 3:56 PM
> > >
> > > The clock is not symmetrically disabled in the error-out routines.
> > >
> > > Fixes: 109bd48ea2e1 ("iommu/msm: Add DT adaptation")
> > > Cc: stable@vger.kernel.org
> > > Cc: Sricharan R <sricharan@codeaurora.org>
> > > Cc: Andy Gross <agross@kernel.org>
> > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
> > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > ---
> > >  drivers/iommu/msm_iommu.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/iommu/msm_iommu.c
> b/drivers/iommu/msm_iommu.c
> > > index 6a24aa804ea3..a7d41ba4a47b 100644
> > > --- a/drivers/iommu/msm_iommu.c
> > > +++ b/drivers/iommu/msm_iommu.c
> > > @@ -418,6 +418,7 @@ static int msm_iommu_attach_dev(struct
> > > iommu_domain *domain, struct device *dev)
> > >                       list_for_each_entry(master, &iommu->ctx_list, l=
ist) {
> > >                               if (master->num) {
> > >                                       dev_err(dev, "domain already
> > > attached");
> > > +                                     __disable_clocks(iommu);
> > >                                       ret =3D -EEXIST;
> > >                                       goto fail;
> > >                               }
> > > @@ -425,6 +426,7 @@ static int msm_iommu_attach_dev(struct
> > > iommu_domain *domain, struct device *dev)
> > >                                       msm_iommu_alloc_ctx(iommu-
> > > >context_map,
> > >                                                           0, iommu->n=
cb);
> > >                               if (IS_ERR_VALUE(master->num)) {
> > > +                                     __disable_clocks(iommu);
> >
> > also need to free_ctx() for already walked nodes.
>=20
> Oooo...yes. Probably could reuse the detach() -- [1].
>=20
> > btw it's a bit weird that although here is coded based on a list
> > in reality there is at most one node per list. According to
> > insert_iommu_master() a master object is allocated and inserted
> > to the ctx_list only if the ctx_list is currently empty...
>=20
> Yea. The insert_iommu_master() indicates that there would be only
> one master on a cts_list, while the rest part of the driver tries
> to take care of a potential multi-master per cts_list case, which
> practically won't happen by looking at the DT file. But the driver
> existed for the legacy platform data configuration too, so I don't
> intend to change too much...

it's also problematic that it assumes that the attached device
must be the first master in the list. But anyway I agree to not
change too much given that mess.

>=20
> Thanks!
> Nic
>=20
> [1]
> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index 6a24aa804ea3..30c5662e24bc 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -394,6 +394,33 @@ static struct iommu_device
> *msm_iommu_probe_device(struct device *dev)
>  	return &iommu->iommu;
>  }
>=20
> +static void msm_iommu_detach_dev(struct iommu_domain *domain,
> +				 struct device *dev)
> +{
> +	struct msm_priv *priv =3D to_msm_priv(domain);
> +	unsigned long flags;
> +	struct msm_iommu_dev *iommu;
> +	struct msm_iommu_ctx_dev *master;
> +	int ret;
> +
> +	free_io_pgtable_ops(priv->iop);
> +
> +	spin_lock_irqsave(&msm_iommu_lock, flags);
> +	list_for_each_entry(iommu, &priv->list_attached, dom_node) {
> +		ret =3D __enable_clocks(iommu);
> +		if (ret)
> +			goto fail;
> +
> +		list_for_each_entry(master, &iommu->ctx_list, list) {
> +			msm_iommu_free_ctx(iommu->context_map,
> master->num);
> +			__reset_context(iommu->base, master->num);
> +		}
> +		__disable_clocks(iommu);
> +	}
> +fail:
> +	spin_unlock_irqrestore(&msm_iommu_lock, flags);
> +}
> +
>  static int msm_iommu_attach_dev(struct iommu_domain *domain, struct
> device *dev)
>  {
>  	int ret =3D 0;
> @@ -418,13 +445,15 @@ static int msm_iommu_attach_dev(struct
> iommu_domain *domain, struct device *dev)
>  			list_for_each_entry(master, &iommu->ctx_list, list) {
>  				if (master->num) {
>  					dev_err(dev, "domain already
> attached");
> +					__disable_clocks(iommu);
>  					ret =3D -EEXIST;
>  					goto fail;
>  				}
>  				master->num =3D
>  					msm_iommu_alloc_ctx(iommu-
> >context_map,
>  							    0, iommu->ncb);
> -				if (IS_ERR_VALUE(master->num)) {
> +				if (master->num < 0) {
> +					__disable_clocks(iommu);
>  					ret =3D -ENODEV;
>  					goto fail;
>  				}
> @@ -439,37 +468,12 @@ static int msm_iommu_attach_dev(struct
> iommu_domain *domain, struct device *dev)
>=20
>  fail:
>  	spin_unlock_irqrestore(&msm_iommu_lock, flags);
> +	if (ret)
> +		msm_iommu_detach_dev(domain, dev);
>=20
>  	return ret;
>  }
>=20
> -static void msm_iommu_detach_dev(struct iommu_domain *domain,
> -				 struct device *dev)
> -{
> -	struct msm_priv *priv =3D to_msm_priv(domain);
> -	unsigned long flags;
> -	struct msm_iommu_dev *iommu;
> -	struct msm_iommu_ctx_dev *master;
> -	int ret;
> -
> -	free_io_pgtable_ops(priv->iop);
> -
> -	spin_lock_irqsave(&msm_iommu_lock, flags);
> -	list_for_each_entry(iommu, &priv->list_attached, dom_node) {
> -		ret =3D __enable_clocks(iommu);
> -		if (ret)
> -			goto fail;
> -
> -		list_for_each_entry(master, &iommu->ctx_list, list) {
> -			msm_iommu_free_ctx(iommu->context_map,
> master->num);
> -			__reset_context(iommu->base, master->num);
> -		}
> -		__disable_clocks(iommu);
> -	}
> -fail:
> -	spin_unlock_irqrestore(&msm_iommu_lock, flags);
> -}
> -
>  static int msm_iommu_map(struct iommu_domain *domain, unsigned long
> iova,
>  			 phys_addr_t pa, size_t len, int prot, gfp_t gfp)
>  {
