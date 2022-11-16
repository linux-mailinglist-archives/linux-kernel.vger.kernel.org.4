Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E9C62B1F1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 04:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiKPDuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 22:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKPDt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 22:49:56 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F34BCD4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 19:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668570594; x=1700106594;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3PNwaHV12Dm+zL38V1WUaFz+NATyAiZsDCRPKarDnC4=;
  b=aQrS+7aQK5a40wh0AffroHJGRxWbYb9AFnICUNiAolq8hTuk8CPXhen2
   5ksdzvzP1uBQn5gnQ0Qr2mrSnUNZslam+qUdzoLy2CKz+I5hcBmr7/vTr
   xzzEimWpXNF77juJKGNACGP0eb/OtL2zZVURPCE0Mynjj6HMov15l4sNm
   qudczNUWO0LDZ+0X6g0/wiyUqAH0cAlBTPBM8buJ56VEuXJQ7jS6ojliC
   tqc5omnbPZDsh4feAHBpGFjga5jM9NU5yjuZzrtrMNTafSZe0zPMI+Zlr
   x8oQrrmCJmX/Ts6PAW+FBX1DlQC2t29PVGXi6BDd8p4jX1u7sbyRT4IzH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="376709240"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="376709240"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 19:49:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="617007563"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="617007563"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 15 Nov 2022 19:49:53 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 19:49:53 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 19:49:53 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 19:49:53 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 19:49:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFxNKQn2BUR2WhskfQU2lovmCOUeGrcLlSIKIqsyBy3beHDY38pA3RvwlvkuHVODaqORra4TtVheSpgbsCGTKL8GR20a0QUgkBJbyAlnacOtz4ajRwlTyycBFq1tCBZdDJrQAUIAxG+VgyrVMyloSweWkOnTIZCuO8ccbw2lUU7K/OwWV4Ct30XvacTrP9zB975hnW0PTcWG/VatGi5Vgu4EEeZgmI8fmzEaKwWePzL3gJjbkl2aD6nwRelXBwkqd8bfHDzQMEzyscJY2JkVnh8smrmg6Ve7XK2WMptCBw3Ziqk/BNGioAoLRk6Dknyd72Mr96vIX7MNLPMX/7rrQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PNwaHV12Dm+zL38V1WUaFz+NATyAiZsDCRPKarDnC4=;
 b=CZ+fwCscglKRADem5UB0EEyABwaZrfY3ZFYR3zXw7hIwpERZPYGq0+tYAJLBALm+KOAlJuLLYkbuGMB9VV4b1QcPRYX3H/tPKHcoKXLXRq7NZCdzsYhPfTDDI4HHieKCucaawmoXzOz1t8J2Q+PRDB3uhXoyR0zLOcxtTKJ5SMZ9MKEojScSRFmYi8aEnsPgDpcuTzStjSGlqu+TQz5chxh5ePa8VLLXYBJG4UiAHdRfDxP+YAUvJ/30Ws4YjKBXxriOJi/9Ro+xSZX7cEoJBHsZ8wapIf2fBUH0t4l8u4ldSQr/hXNbhXiJWsWUf6VRenmY/QiW5vNcXKoJWUXeFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN0PR11MB6111.namprd11.prod.outlook.com (2603:10b6:208:3cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Wed, 16 Nov
 2022 03:49:51 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 03:49:51 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/7] iommu/vt-d: Add device_block_translation() helper
Thread-Topic: [PATCH v3 2/7] iommu/vt-d: Add device_block_translation() helper
Thread-Index: AQHY98sfvGVPqfgBt0advHwiZIFwxa5A7USg
Date:   Wed, 16 Nov 2022 03:49:51 +0000
Message-ID: <BN9PR11MB5276084177CBB231521AE2218C079@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221114014049.3959-1-baolu.lu@linux.intel.com>
 <20221114014049.3959-3-baolu.lu@linux.intel.com>
In-Reply-To: <20221114014049.3959-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN0PR11MB6111:EE_
x-ms-office365-filtering-correlation-id: 2fc07e28-b6a7-4e66-dd9e-08dac7859d91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lAZplW6iWyjoXOjGdiyjHQ56SQsS0yKyFIU3VWtclK52qOtE/8XACEC2iYiSt09k1Apf3VH2GBk8QW6KxrgEaVHY3Bt0V+46FJrDfJb/EIL3wh3HwIryBmY2sNvGaKk4NLISRMUefZjfCuoZslg/OnoP0hiTiJH/AiqVxGxKZSEqe3iWbv+mLZFrWkNd9/qLfH2sDsnHhQOYIwcrl/W29qo8ifJnRxZ+645ejlTjdQOxFKLXVyUIckaJCPr/X0U3A7L/515fibQQta6ieVexCKY7H8URUGD8GnkZbHtf/joB901ZGNqWeocYlJLutuS71BA3YT7fgKbNAsJTEhyQ6SMs3BO4QJEZliLZh9PwCv1E7MM6GIdWbhoSJGzwgG0Oqao0rfVuHlMLA3e6mP+JGF2Qpsziyx2y+CN9JzzOQ76h/OJ4oEuSYIjY4YdsDwr//y8JJ6SBTFJWJoCXKNIdn3DRzM5zupttAn7i7csYP6VPgXn398By9nFfLrw9z85euFQPmRFZ4+KscwjuFn2IVNHGoy5FD7CSLs5YktGnKorwXXqkJicu7tfR7nq6GKYCnqKztK2VAW8+jSgZmeSylHSPHfhrhvFRzB8E7C7YveUkzhtYkK5bfwgZT+GWGmTBlPxbPaYsZ1e6M22ihz7MjukSdpJWtHpUYP7IUVW+LLf6NkhQSlPM7cR5T5EFR+ZrE7+s+nsf60DH6wDKyhvi6taNBzIhAAutvvj71Vbcs9F+oh0NKRlZuy1UJpUoUL2YqoVC7Oit7NclSwUD6Bbotg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(346002)(396003)(136003)(366004)(451199015)(38100700002)(38070700005)(122000001)(4744005)(5660300002)(82960400001)(33656002)(2906002)(86362001)(478600001)(186003)(83380400001)(55016003)(8936002)(66476007)(66556008)(41300700001)(4326008)(8676002)(76116006)(66946007)(71200400001)(66446008)(64756008)(9686003)(7696005)(6506007)(26005)(316002)(110136005)(54906003)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lcCNO/UpAAHu9PYQeK5YTD2KLw4dJxxZYpqM+RLgxb0WUJWzb7mHUcy+IpNO?=
 =?us-ascii?Q?QyNsBaPBCxm84LHREF694ftieMitJmXsZJvqHIxGrsKatq6pCJAyvtcgFsYF?=
 =?us-ascii?Q?EJzPh0zu42MM/HeaWJKkf/9GaLeSnsMF2YFWOyuaEaGRc7pMXwJf8l8pzQtF?=
 =?us-ascii?Q?Jk8I/qADQmFItHU1LDBvVm9VkxdlfvLZ6mR5VIKwef6ueLFOr/Uv3L2kOZKp?=
 =?us-ascii?Q?3EGbdLeD5HYZUYmZ5yovsAH8UHYRyi4snJvBF6fmiA4NwXbZm1CEr+f4oj6W?=
 =?us-ascii?Q?btui2n7B4Efn0l69FJ8n9kDLBULAgfA46ijN15nSly6tUFySgDMtWIrFTorw?=
 =?us-ascii?Q?812JlEtDPNmwsJ+ja2vfkhVo/ZE5sJ3Drqm0+0Bkm/7hYeJ5bPV6hv01k+ow?=
 =?us-ascii?Q?NgITKW/C4VglA9AnPPXocO4skMBkg7Ge2/8WkKvW/ni9gefwsmdSRqB3eGVO?=
 =?us-ascii?Q?uJSsoDQCWnV0w4ekLwwqNlLBbDSsdEHq0kT6uTzZBGN9NlJj2XmqmV6Wtt4b?=
 =?us-ascii?Q?TMu9E4q3KiHr7Z+NRQ7PHYziRCjoQPagm4Y66PPB+y9YrNrJK1H7HealtGNW?=
 =?us-ascii?Q?T6QJIYeoO97hq/YgBKmCGAp2TCdc1nREwfm5wLILQ/mKvCuKryHzDri7rLYm?=
 =?us-ascii?Q?MGIcG+e7WFgsjt42ECiJdEcWXE2EdIJp7KbQ91rtIZ2Pslfzu1ThU19aZxf4?=
 =?us-ascii?Q?nGb5EvnFpyZBll1X0C0u6MgMNzvepsLI+jBlyv4+yTEwIMcZA8r4C/xAfLJz?=
 =?us-ascii?Q?rPL6V5QOnNoX4RAboCb6BcVcaJu8S2EMdNzY8qdn04n2GEbTuf7WGt/ZfEeJ?=
 =?us-ascii?Q?qv42o62BfG0N775LvQbHNJF5osWczFa/jgfRCCC2IML+rTjwhzFixe8L3nEE?=
 =?us-ascii?Q?dUKEokkplPoxlHRrxVBtEjodVmkIsk2dX41GUoVZS/NX0AdNhvms3KRl1FoP?=
 =?us-ascii?Q?qVaFX3WEyiMsC/PEitkBYNgnZP29t081HvRK8zpOM11q4cOaxx1ASFWe9uO9?=
 =?us-ascii?Q?AykSfWkKzSCUDEz759qjY/B+UQpsGgU5oYMjCNtLoGySQALB+dEWmxRzYS55?=
 =?us-ascii?Q?MoyfE4gxAqVWmswv2ebB68awvyZ5hsEnOm311dUDtYWZbQb7hwDvkLGpmzJ4?=
 =?us-ascii?Q?0WF//dWjAGGiTon2qnNK/dM4T37OyMyVLmIZV/LL7mSjylN0birQt2A0w/Yf?=
 =?us-ascii?Q?Sz7Z8wkRbWiXfz1gkGqnMDAhLKZbwv4iPJoYHmr/J/H8mG7IQBrqzunFyjzY?=
 =?us-ascii?Q?ixgF32LVXCYdNEatRI4QcrHC3hpH6PMMssxUcw0voH4XonMxH3RBaUmVKtYs?=
 =?us-ascii?Q?Zr94xnUynp+GHNslXqUTFRw/pZT88GAuwE0QYEScjIpHz9CX/SnsHrmR9vkt?=
 =?us-ascii?Q?LpaTvNi0+tzTA5rUVyogzxx/t5QpBC8sZbxpkk48SXdMSPruro6a3zvLdx/8?=
 =?us-ascii?Q?2+nBkjeMlqpq15oFjXneeKuONZDgtQE9b6VE5uBguTXXqg0MXYRReD6l6elT?=
 =?us-ascii?Q?h3h8rluMOmuriJCItyAzKiu0WfPj/aNM5/cSo1DuSHMpGW9Tefp3tUg8Ut5a?=
 =?us-ascii?Q?1fGYlZNUPcByZkTvmHe2Retgk3B8Wm5d61WrSTbT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc07e28-b6a7-4e66-dd9e-08dac7859d91
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 03:49:51.3879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q2fdFzjKrtR3HAHKmBqkhLMzWci3dXKR0XEGDVmZIoJMWQuoiyb2kgau9r2kZFiT/S9p93TPmUDSQdKEWdR0mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6111
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, November 14, 2022 9:41 AM
>=20
> If domain attaching to device fails, the IOMMU driver should bring the
> device to blocking DMA state. The upper layer is expected to recover it
> by attaching a new domain. Use device_block_translation() in the error
> path of dev_attach to make the behavior specific.
>=20
> The difference between device_block_translation() and the previous
> dmar_remove_one_dev_info() is that, in the scalable mode, it is the
> RID2PASID entry instead of context entry being cleared. As a result,
> enabling PCI capabilities is moved up.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
