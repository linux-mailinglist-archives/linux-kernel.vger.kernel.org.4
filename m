Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB68A693C8B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 03:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjBMCxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 21:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjBMCxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 21:53:09 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D8CE070
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 18:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676256783; x=1707792783;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W0sm+/Fi09LonhoNwY+zqTSyeaeeMrqhUjW9Q0cxz7U=;
  b=nOjykvRDnTIMF1GIFAUU/eDpke/wmsaVmDiF7xeKXNK7G2REHYaxN4Go
   bKwtfAhk9edzuPORdWaNhyX8dQWVMSDMHfSVy7NeYFjcYwy2SLFSYI9gm
   VK/u86nH3//pvQlb1T0xWpW+Xn4h0UZgC57/df8Rzqv9M3gs8mXsopi5Z
   k/Iz9I81WCnfLWudVa+xBVmTn+E2wjyTfdzMDKn1HpJUPnR1cj8rEVaA2
   Y2JoXV1NIDgWJe6oQjlnDMNqNe3cKwrLs5Uf3qO49CfnK/yU6FPNYfYNR
   n2wti5RQN0GkKvGArJD+5fNXrbaqR4hSWwL/CV1bbhT920YH6OyMvrg7O
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="395404658"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="395404658"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 18:53:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="997538153"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="997538153"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 12 Feb 2023 18:53:01 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 12 Feb 2023 18:53:00 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 12 Feb 2023 18:53:00 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 12 Feb 2023 18:53:00 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 12 Feb 2023 18:52:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezxFQwVPx57To/w7QYSB2buyoJzT64B1K/gYeF3TiTyzW1i8lg7rKkNDYxrDW00zlMiqs0NLY4nb0Pwm1+5s8qnPW4wyvjJWugGXq0ZV1486vLJtWmdsQ3duIj+dg95hnYfn3sdNgfpJm4zJWsTl+ck0M76T9Nbqiot7gXiHNO28Eq7gS4/Kygsg0FNFhwP2QsQ0jX8K1rwVBBBdx3CO09z3a65E+8IuhxjpiiCVbDMIxv0DjLHMknYbeh0hK9DMyEWfldaYbJ4CGXmu2I41/bdKWfxfUxZQM+zXHdrSmYYvZfSLTh6M6vNcDei3lrAhqLH8Dar7aBf0fCC4jOAygA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0sm+/Fi09LonhoNwY+zqTSyeaeeMrqhUjW9Q0cxz7U=;
 b=Ihda+TCWbc0T9CKq46JepcGpUK8MUS2ouBsrnLv8I+t39KrS3FpIQveunolDJFagznFe9dD7YW7RKwbUpzCggTDPHYH//SAmLnbYQwm4+0jIGg8pBG8xMs2G8FfFkdy04z5NQoCwBgegX1XV8GRpb1vjnHjB29nhAbhhX4QgwP8pZFn0TO6FxJgHPco6Rm6Vx6DpxynIBebmrIFZlQBSqs3IBlO++mblY8bypr/2yn/QY+mynayE5ycywEyUFt+Ot4giwhLkZY7O7kt9PoP248G5ekYatXt7tMBKor9O7iEdO7Yx8lNosSPdz/enNK+hO2SnZcLK6p4vvGipxu3npA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by BL1PR11MB6051.namprd11.prod.outlook.com (2603:10b6:208:393::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 02:52:53 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::38d9:ca7f:b9fc:ef7f]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::38d9:ca7f:b9fc:ef7f%8]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 02:52:52 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Robin Murphy" <robin.murphy@arm.com>
CC:     David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH 0/2] Remove VT-d virtual command interface
Thread-Topic: [PATCH 0/2] Remove VT-d virtual command interface
Thread-Index: AQHZPaM3VgQAfogEmEKOT5D57uzx1a7MMMnA
Date:   Mon, 13 Feb 2023 02:52:52 +0000
Message-ID: <BL1PR11MB52710ED111526C1CC580273E8CDD9@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20230210230206.3160144-1-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230210230206.3160144-1-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|BL1PR11MB6051:EE_
x-ms-office365-filtering-correlation-id: c981ac57-db16-44cb-e4ae-08db0d6d66b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uD3ttizUz9b/17CyzbXDggoWPfzHNiCXzuItr7FC0JwdZXcEEpCMM45raNg2JFSMJLoF45gWnPrP2uwezETEKGBeWL53oQG0UQPnRL/LNMIYvNdCaJmTO8K5jeloTpvOmHrRSAEpBOGkjLbCe92pQzLYS64i18xJitnJYMZbJg5N330j2U1ya6Pg43izH0NepPjw3zsxzb0neVn58FqTCIO25G9qunWz6iYlQNX1cn1SeEGa+VA4BMBUbXdXutViDp2rOMEnHavGh5qLxCSc4naY+dquyRcRsLd20YtFWZpydlXHnuy7wKjGWUEDMNgBerQRFyN/ALWPXN6VaNsoMjhj1beHnLc8i1iSdnroPkdCYRYcdYxMPyg15OkSJlO5S8wHoGMEG3maMOAqPMdFgPWIDMU94x6Ta+1eemDchpjXoQ2RyM0iVi4sOdcuWSRXcIoduI2SYvwK/84uI77N9/HK1pY0JYdMiBGIf5K47QTq2IuezEwotciTxiKkHmfY4zcee8OCec+FlCT2I79n9sGM1Kv6nOhrSPtmEyhVVKUJaRLhjLX54a/667fjj97bt5cjYvVKFmiVkmhsQsbzinFtk4DqAxiIqIfbc9Ke1t20BViqISNz2x/WygqrKd7XDf3wGSHSaJfDvz1LNiPYfAVQTEAYZcDKqpNcfMo/Wk8YycXdIttNxO4Z7u0pdKdvfEI3PIX0Ek5wTE/jU/xWK2BUdYNBalNpGQ5gBZk+/zg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199018)(5660300002)(8936002)(4744005)(52536014)(41300700001)(71200400001)(26005)(186003)(9686003)(6506007)(2906002)(38100700002)(38070700005)(478600001)(110136005)(7696005)(316002)(54906003)(8676002)(4326008)(76116006)(86362001)(66556008)(66446008)(66946007)(66476007)(64756008)(55016003)(33656002)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yIvGLKL6c28pytxXoQC9Hg96Y5JQUxeU4DOIJVc4St/IueK4chBhmddtSNCV?=
 =?us-ascii?Q?WStP9zbMgIkUrrDtyrsYZ60/fw9I6zWyX2fWa0vrGjavYEiFVdK0Wcj9C4MF?=
 =?us-ascii?Q?5Ko9iNQT2zOFjit75ZeGJzat/MmSUXX7rEXeKS2+ZhgGNsxzbmIJFD4/6Ydi?=
 =?us-ascii?Q?GPWv0fFeKrsb8rVMw9KMZ+BMkdM4MZf6mffqQk5ZYN2Xq+ZKQteEq0iBwLPv?=
 =?us-ascii?Q?6gPeb5U9NdmAOeZVWI/BkucPUN0fzyontecIiKETWsysI+phh8Deo/NytE9+?=
 =?us-ascii?Q?TQL4vt2ZGTZ2VOFYXobMrKuluWZEdaMw7OM80odeuQN1cSKNCz/iqMvjX5ZD?=
 =?us-ascii?Q?RmxBUcGwEOImAu/JfjyxHgLprK6jKrkoZ3665kSBN04rt2DbtFgeB815NboA?=
 =?us-ascii?Q?pe4tvwqKPlOxY6q171l2lQMm7a5qpeZQBE89a54VbjIdC63+RPaautNU6zbu?=
 =?us-ascii?Q?itNjbt3x6WRXyuA6tLLS9aB2GSbKyoktE9ZXDgNiVdNrvVWLhZ/vukXeqav7?=
 =?us-ascii?Q?MvBjK244kRMs1FdCop2TXbKQHbVuHbSpaSk1G86Eph6/f0viJC8IJg/j/hHT?=
 =?us-ascii?Q?n3aElGrfCIVqHAyI2qv8+ATuv7jJPYQPuV3dDxgdOCP/hk99jF8ju22qJRRj?=
 =?us-ascii?Q?KukDzblQRXpDdpOP4p2V8pyeH91a/i5pfMA/RwPvfux4Htjp6Q53BoDAFrcB?=
 =?us-ascii?Q?xG1lX2f+StuwpciPz8O5Z5SwzyWFyI/Kuzbrw9TepDLF4O8Dxr0zoIDoGDhk?=
 =?us-ascii?Q?ztkqdTs1UZa0IAZPn4Af88P4E77pqUjctYkbGoTe/0HQ6fqVI8morowvytKc?=
 =?us-ascii?Q?jtcvdI4+dGi4T4hO0tMgPKdUW8TMNx1GWz13+nlEiVmlCBWBzYhPkRaKWAAg?=
 =?us-ascii?Q?hDkbkaUSB9DmXgUxJZN319JOhHRLEDU2Kvx6tNxhnLb6GcLbnoOYVNdRW+JL?=
 =?us-ascii?Q?pfib3oolzRy0ZGnO6NZxTHc0JFZiyKd5Z0YYyvFu1qSn041LcFTdJFNZzUBG?=
 =?us-ascii?Q?l6wShR4aLbnNG0KY1GdOBlevbZ9Y5TWzEdTRd95h2urCN8sHC1lsw+NwkB+m?=
 =?us-ascii?Q?XsbwpRXuA53+UVgrqxbp9qqdXzKugkZBt+fy6mp88lkgimUZD3JjxHFfCm90?=
 =?us-ascii?Q?BFzdklquKHDGyLgh8MBZPcFnOOyAga1965ouqEBtEnqlCkkFDn63YD92vwaM?=
 =?us-ascii?Q?pQaso3hMAy6nlZbPrVHQRa5qAxh2PDaEQBaaC5WU5SXMgmki0SvqnPj+Wfis?=
 =?us-ascii?Q?e39wEX2jdXnZsT0yzUzFdYzW7pHIbwCbzpLUfujAhR1n094AYuAgrWVsjGl+?=
 =?us-ascii?Q?15fJj7aTo400YjH7uh8YoSPWVJql1KiMIE1gsycl4CDRW7qnpMa3IA30zMGe?=
 =?us-ascii?Q?5OrLj8A/5De7i/SdN2O5TVz39Q5DjA23rR1p0a8OI9dfJiuc/1f2GPWSwFn0?=
 =?us-ascii?Q?b5GYN0hAGGY2m5QSOLlA24pdUCcbTERRArx+JHlExR1dw8oVwNR1zcWpaRkD?=
 =?us-ascii?Q?xtHTRDbi5tMLoAzOzx4htBbCGpSGMt3W1bCZZndebkggg5MhjRXP0MtyuQn5?=
 =?us-ascii?Q?dMtFzESc7pKwxQbFcjSzcShhuHZYl7OAlSByem0C?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c981ac57-db16-44cb-e4ae-08db0d6d66b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 02:52:52.8578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3qfSPZ76pkypdrKktn1caNp7aXyJ1dEXdDXh8o6cC/ZTyx/ldeYhYcl3RNlrwHShX5vKYgJiCulzR+XYlZsMQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6051
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Saturday, February 11, 2023 7:02 AM
>=20
> Hi all,
>=20
> This patch set removes unused VT-d virtual command interface followed by
> clean up in the IOASID code.
>=20
> This has only been tested on x86 platforms, need help with testing on ARM
> SMMU and other architectures.
>=20
> I also hope to collect feedback on the upcoming clean up and enhancements
> below:
> 1. Consolidate VT-d private SVA PASID array with IOASID common code
> 2. As we retain the global IOASID allocator, we need some level of resour=
ce
> management. I want to restart the effort to include IOASID under misc
> cgroup.
> (https://lore.kernel.org/linux-iommu/20210303160205.151d114e@jacob-
> builder/)
>=20

this should go with adding global pasid allocator to iommufd.

before that we don't have such cgroup requirement.
