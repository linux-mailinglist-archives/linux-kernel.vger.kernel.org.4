Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2885E5D14
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 10:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiIVIJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 04:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiIVIJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:09:07 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3646CC8CE;
        Thu, 22 Sep 2022 01:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663834146; x=1695370146;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6b7aMnfcwESnlj2ga2vGXP8udZeVqST7pEla4MaJ8gw=;
  b=ShtI7yRMqdhkoLy9VkYyef67tG9DAK+nDNS6PZPIAr8If4fyr1gfTr1T
   tIrdz2pd0a3vh/BVKcIMl/WtEtIPOj+/prrTcPrlaVRzaaWJrlSATO3ia
   2vZ6R7L7MG91tgjn9ISUdXH/pPcm40eEijQKusMuDLlbcByHQVPJ86wiX
   qeLTa/IPeKkyFD9DCfP+LqS87Da8LpBLNAQ2ojMHCVkzgq41avduWksQz
   J6d9PmvU5/0ZQklbNYywduBo5roDy50Zdh9nW0vIcOnKt8TICEKgnAM0q
   zUxnjLZDyyyu+25M1iMB2Mb5Sx4n4p3ujrJU9zKU7AqeWB/kSM0w+jKkt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="362000055"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="362000055"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 01:09:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="708784752"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Sep 2022 01:08:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 01:08:51 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 01:08:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 22 Sep 2022 01:08:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 22 Sep 2022 01:08:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1VVjoEE1MEPlW9WOngvfTh8JzLFQqmPdSZ5rHna1T7qgfjOO2UvIAjGSXjTKnpf/xFEVA1Q4ITkF8kZ8kShnENaeGxthlJ0kgTnU6whRep1mDVETpawo3KRdv6G6bn6LFFZ42pVlV9KnXLejyhvUxyVoeJegUqNGSfa1hgT5LoIbK15pZ9npJbdB6QdZ6GgHks8rXViAg1v5gcDOaXZqMSYQuo85ZrnXdBm6vBZpFYwfX5RMJjT0q8Faa2Mdb128MjGqjosF/bHtbDh+Dv7rb5ysrIq44jKIuMNjmrclZu6aHKaRcOk4t7MCETRbms+yctbhGbvlkhv9qI2v1VIZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6b7aMnfcwESnlj2ga2vGXP8udZeVqST7pEla4MaJ8gw=;
 b=NG+xqlx4OL2AkQlOJTKaqYEC4VRsMf/sfT8kXUgQbLjmG9+Wl1xKYkhCqkyJp5BtEYHjkqtQ6no9ng0kOSkxaK4hNHNwa8QIsMVPXNAj3dRS5sEuJYA3XGD09VK4hGJR3BX4alLlYXoDfHEnJlakdvdUa3I181wI7D1aZmWivmn/LYpjX8JkBdNfzNK7SzntrK3qahbcwYbJXnTQ1nC0W4hRtKR74GquEWVBs95kPtYtc5LIlahWC0uTmgZEUnerY/2Mkb+YSOr8Zpu9PkWS6/rTIDJlGTmYq0y9qWLk7WNmGMu9q5dqLZ5LcJWTbzP8TZPqYSO2rIkzGyhbj2DXlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB6166.namprd11.prod.outlook.com (2603:10b6:8:ad::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 08:08:48 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7%6]) with mapi id 15.20.5654.016; Thu, 22 Sep 2022
 08:08:48 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "konrad.dybcio@somainline.org" <konrad.dybcio@somainline.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "sricharan@codeaurora.org" <sricharan@codeaurora.org>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 1/6] iommu/msm: Fix error-out routine in
 msm_iommu_attach_dev()
Thread-Topic: [PATCH v4 1/6] iommu/msm: Fix error-out routine in
 msm_iommu_attach_dev()
Thread-Index: AQHYzZN1ruR77yrwv0GumE/6T8/ZN63rGcuw
Date:   Thu, 22 Sep 2022 08:08:48 +0000
Message-ID: <BN9PR11MB52762E13C04F703C4BBB2D8E8C4E9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1663744983.git.nicolinc@nvidia.com>
 <0ec6d333a98bb6a11e254ba49ecb385e50a52588.1663744983.git.nicolinc@nvidia.com>
In-Reply-To: <0ec6d333a98bb6a11e254ba49ecb385e50a52588.1663744983.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB6166:EE_
x-ms-office365-filtering-correlation-id: 3167d734-d539-4d04-c4a2-08da9c71adb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +E78YQFWmx7XBM1LnXHWuwuIXGgMd3UKOae7bZdobifc0CKfzd6KLGItXWs4EdTEVq+6LCy8DFRfNCHAiyQQsPOjgj35e8NJBrtmR9hQYiUz73Fd8IApJRvNnPAuAXlvk11vtRiUi5JRTWg49cMwT8/iD2BJpQc8jeozB1gv6RWQaa6k3ZItBBTeN5ohpLU0tvyV/ncFvfFL8QKHsWCMK5EBYM5GYdw6HPIfDzZER8buoFI6DoKbUiumcfrdEWeGxxicAMAn3KZM6w9POQKjpg2StcYRhaPxVeD5qA/xdAe1p88055Ubg5kSwTaNbe2HhG9aUwlUf6wm5lZ0yVJ9p0xGLOIz89STkgQA97JZ3Xz75EYk24/uwsxfAPcnOPwX68pSg5CIiNBriAQYvkwpwbR1RZ1ITjITPXtgBGXfRxLIeoebYMTIq+qZT4MDsDBSQB+57t7llTWBWdBR9sblJ0Ds2BSWhpB2QMxU86nKhdiR0bShHjSvPt5CE4U5t1Mlc3djb5bZfa/u6VHNr+IFjFylleZfGXWdPjiSR48ikW3rGN9Uc88F/kRJU1oPyc1i+bIOR9WHYobKAkvDvFc81NTDYHgDy7vzr/E1RJK/SjGqdmhphEaM+83A5YmBcTPi3uZvbi/oZhkFgU2o7tfP0dm0fV9YMRJjyCN5lxRBWVvqiSfY2+hEGMLcuk01ph7bw9Ja0Fxzo+NXUHE8phjZwQS8JoB8oqDTsiFTuoxWKrkG68NMbqlDwMZR18WPjI56i0BlWoNPB3xF8rwog8OArQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199015)(52536014)(71200400001)(41300700001)(5660300002)(8936002)(4744005)(54906003)(86362001)(110136005)(64756008)(316002)(8676002)(7416002)(66476007)(4326008)(33656002)(76116006)(66446008)(66556008)(66946007)(38070700005)(26005)(38100700002)(55016003)(82960400001)(122000001)(478600001)(186003)(7696005)(6506007)(9686003)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gY7avi9fvUhutQqd/rOtxCg/5sxrhCN0fbyKVBokMDzb078dxyn9LODhP4AA?=
 =?us-ascii?Q?Svlomes/Il7QGrcbnO6SUR2Bx4MqOu/GrWZn/QWxwgaE5fTEPj3UqJtUOyYh?=
 =?us-ascii?Q?JDj8YEw4jqSRB7nrptZLRJqYjHamvgg6Q1x02QYpPsvwPG8MmJZqPjRK+bx3?=
 =?us-ascii?Q?5OjOfG0/MHd2VyB7Fsc8lwcFkWMxNn6+rdffotEE38LjaOWY3zlDh8B2Yyzu?=
 =?us-ascii?Q?u1XYvmrxoedr6EO53q4+Te1fjqYOjnj+5m6m4F5Qq1fqn2USjL4Y7am9hSia?=
 =?us-ascii?Q?8SYseRHlhmrIQoaTMiEBaYH96DsnS3DOdFHTE4PV3j2GzEJrH+n0NP7X9LpN?=
 =?us-ascii?Q?bwSUTp5JkWlwNb9GLXakkvd11tmK/4bSE9Wd3zfhwUg0f1mBzr4XlnDnTV2s?=
 =?us-ascii?Q?EyN3JBIhzG4AQmHzwUDnoloqrESB1rzWDUozAZrk/qEL+Ls1QB7jDMERcNHm?=
 =?us-ascii?Q?DhOoh5gqnb50XElWQBJuTQep9kBEeo7XRQsqO9jjy2yV5l3uWy2whvUzlMei?=
 =?us-ascii?Q?8IParcZECDEaw3DOgnnAPfvS+n6KndjlulkyrZhqpNhEBbnrLMv9FpNwG2vL?=
 =?us-ascii?Q?jlumO4HKfQ3VXygm5EP0afOvJUBpiJz++Nlq6evi/6MzguV8MSCyJ3oq3aAe?=
 =?us-ascii?Q?s9FPDIxUuvkczWG6v4l8ON9yxH5niHoe1lWuTk0xVw8HoJAfuZwsvpS5baAg?=
 =?us-ascii?Q?oiPce/EPxmsndvmydnq2nq2Azqg2KPXurJNQqVnQUFHkqrejeQGN0IEoe409?=
 =?us-ascii?Q?LPBm+WUQ74r5gMAAbq8usN4jJbhuY2Vu8VvpImYjXLDRljpHUczhl3H9th+s?=
 =?us-ascii?Q?8Xy4HY2sDVfVwqmUBQb+53q4zOgUaDp6mMIo3yW6LLlE7fcbiQUHDDCjindl?=
 =?us-ascii?Q?iPqc4k/kjCDQWRfxwHwe9NytahvB/5xM23yP23evVPOFfIgZnlYXPxbsSYD/?=
 =?us-ascii?Q?svNq6nZWSskwR40xJjuTUHmGJlF9jabMfCV27/GzBR/4M8VAfd9d7VR9xjRD?=
 =?us-ascii?Q?1Giltd95+vfTdiQPBSOGpY8I2TbxzkVVSzFmoRG4QMMc64zvS7eDLWN5ufrr?=
 =?us-ascii?Q?ae6a5z5ipMGMCWR/FtYdox3JNg1qbReUsQ/Z7rq0Ci/0VZ5+g6iJCVDEIFvA?=
 =?us-ascii?Q?8WM0VohQyygXyNP7LZyLMGCWKv2hUcbUeeeQeqJAopZDlmf3vjeyVvAiZhfK?=
 =?us-ascii?Q?Z1PQR3il0a+1vlNIZweDJYAvdWgBe9G3XeXikUGdUlSfF8dMdzVHAfV2JjJJ?=
 =?us-ascii?Q?BDbUvKDcLlfcPcTvHbkXUVdMB0H/qg4I45nAvv0vH2YEmjQH3znsB1LQaiJu?=
 =?us-ascii?Q?3k8PrZGATGUOCzV7dhM16TVHEfIBR56Yss8C91HJZfOCpBj3+PVIFwOSBhA4?=
 =?us-ascii?Q?nE6U5TYCUYRfcdZAdVg6VBdwZ+g9zsOlf4pUVGYtKUHCAbIPqE+NNDi3X/Ai?=
 =?us-ascii?Q?/7NuS+FXvGP7i9GhgSgnKHtmqIE+oLeBkoZaj/7YgJGVbnw+9lEhY/g9+VkJ?=
 =?us-ascii?Q?s+TLKNJItAlfIKPb/zIVWdgHgUN9xxe8uN0ql29tGMFNVkxOXvHlzThlzqVB?=
 =?us-ascii?Q?fMLuAIeK+Cio2l5w5BPOklOwgoZExypgwhopG7yX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3167d734-d539-4d04-c4a2-08da9c71adb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 08:08:48.5833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Etb5wjQPqhUuvbAcIiBIljYL4FRaBfjjyKa6M1eGhAYP1QGOjvpzVSn0wl6NPL6dK30wYnbUTn8DAqPMOETtdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6166
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
> Sent: Wednesday, September 21, 2022 4:23 PM
>=20
> The error-out routine is missing all the reverting pieces for the iop and
> attached-ctx allocations. And clock enable/disable is unbalanced too.
>=20
> Fix it by adding __disable_clocks() and calling msm_iommu_detach_dev() at
> the end of the msm_iommu_attach_dev() if "ret" is non-zero. Also set the
> master->num to 0 in the detach_dev() since attach_dev() would check it.
>=20
> Fixes: 109bd48ea2e1 ("iommu/msm: Add DT adaptation")
> Cc: stable@vger.kernel.org
> Cc: Sricharan R <sricharan@codeaurora.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
