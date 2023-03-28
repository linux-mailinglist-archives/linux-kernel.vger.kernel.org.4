Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82226CB46F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 05:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjC1DDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 23:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjC1DDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 23:03:22 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C00121
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679972601; x=1711508601;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wFtbcyESrOCrwPWUOkWjaZWnNr1WQT+6W4j3xok6+HA=;
  b=J1FCiX5pUH8jkdQEpihzfo16iPZ2FGrLb7we4/GeUxbjn+Yf73elYIQH
   v18AfFomu9sVxMg/5xs7XiVoAhTk+AmEitCmSZRLo0sQivzqYMTiD7TX5
   eg/g9n8WKMBY1+H+aC4xA1SswSuHL3ymmUZAn7PcwiSCnUvVO7GwqpYUT
   lEQ7mW6bMXh5pfz9zUBR4dtXcQjvHM4ucQ5cdMwC/88GcL3s08+NOR2/Q
   sE7VwYWXxQU9EW54td/jMD7lK2d9n539nAueH/KSTejJGY3RxxoD4lLuO
   ms/ECfRIWYJ7EQES42t5RDbXGNRZid50+pHpybHYclSVqCg/C3g4V8lhw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="337957892"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="337957892"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 20:03:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="748231651"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="748231651"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 27 Mar 2023 20:03:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 20:03:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 20:03:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 27 Mar 2023 20:03:19 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 27 Mar 2023 20:03:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4dvxKbXv1voXFJfQJzPj3NhnL1Y7K3NohX7N0DFpJUvjd27AS/V5PBXLKUR6LV6uikS0sXW75a5JX9GtLKbrfKyWDL8tGP9dLLRXWPmgNlPq/9M73ZcRa7BPYyBwnhAHZFfinJ5Ti+ZviM+W3pfkM3lvxepb4pbZSG50KXnLYlMMJzKDhDjcNIaxbb+/bayMY70fbQbWqCME7AHsSXlX1Y8pxbl6FlIMoj61gPpZWH5ccecUadgiY9LWOCNibrE2RH3TY7Vtu5JsmCCNizTeJH69+b4xG3bpULgjw3725QteRAZGdfNqKhf34wAamQE3OA+HM188x1RE285TCrFZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFtbcyESrOCrwPWUOkWjaZWnNr1WQT+6W4j3xok6+HA=;
 b=l+48Y+l2Qo+ZkpHJWyaVM6Es0qgAy/f8O+KJdhh1hQ1cnzEzcW1Fw5dsBbNE/37IQhq9Gk67ptxh8Ju13Q9G1B8g1B00wW/sqbYpvq+pTQKM8ZHuZeONz+6Xp9SumosTYBUc0AOKcfNsmHW28Ien2296kG4C5Rcc5pCjjKn8M1UkVMz0kvzSuGP4i1WT3pyCndVsA88/GwMfpsWc7jadSbZQI058E5YtvKXc+4JwU0CFBCyw5qqr/hG8lGj4BmMtSA95s4qZucxqDQWewLhKw5bRTnQz6CMUyo1e5Tq+SX/8+DsKo7RjZ0kyEB4KTxItLzj/WF9knEqigdjgBerIKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB7061.namprd11.prod.outlook.com (2603:10b6:806:2ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.32; Tue, 28 Mar
 2023 03:03:12 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%8]) with mapi id 15.20.6222.032; Tue, 28 Mar 2023
 03:03:12 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Thread-Topic: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Thread-Index: AQHZUnWe1bQRwtfhAUSI/T7BqHBa167yh7YAgAALsACAANbagIAAyRsAgAqMnjCABPKxgIAANdgAgAAeawCAAPG3IIAAOI6AgAE8z4CAA0qgoIAAZESAgAAsM4CABVH2EA==
Date:   Tue, 28 Mar 2023 03:03:11 +0000
Message-ID: <BN9PR11MB5276F4741682627DB4EE0A008C889@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <ZAtYphmOuEqQ1BiC@nvidia.com>
 <BN9PR11MB52768F4D3E21C5231C1A04D38CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBhYq8o4gqFZVb6k@nvidia.com> <ZBiF1hZVrp/aJRM6@Asurada-Nvidia>
 <ZBifWkY2Lt/U1Z7R@nvidia.com>
 <BN9PR11MB5276E6E3FCA90582AA61BDDE8C819@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBmZj2pscX0hx2kQ@nvidia.com> <ZBqjUeEjjtCclgLN@Asurada-Nvidia>
 <BN9PR11MB527622D86AE048D3394C12A28C849@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZB26RWV53wYtc2L2@nvidia.com> <ZB3fWVD/Addk70zY@Asurada-Nvidia>
In-Reply-To: <ZB3fWVD/Addk70zY@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB7061:EE_
x-ms-office365-filtering-correlation-id: bcfab895-9721-4f66-0b44-08db2f38f755
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: itosEMtsrpUMPrXL8lEs/0/ZxeOL4MlsAQMwJxzWBbIaahMxlqcpzABOIq/UTsEbhyAyrGG+yd+1xAt08ZUqWBRF6bwDrLWC7afOJm+Ahh/8TFfyeLTuqt38ODfpFBZJACXtLJluQfQNSfuQMbVe4vll3lzKW1zSrkCS4a8YEbrJ4G2QQLCpxjwwZUh4oZ0+sgdRVWkJrd66pKriWk83IyuXIrOkIOFx+h8QUA+XGLakMykBZOPiYdlQkeEAVa45RyJG+FAk6Hvo7s2CuipTssjdtPO1pKluDiAnWWFtRwWjgZmRSsewa6qCwmDiwUOc+lWCXjNNcaINwLgR1lhrZab08+0hzu9OIzuwQpkcxkZYrJHjYv9tro1jHhgqRzs9G/Wh1DVQm42P3jnPzY3ND+KhW9Pf7NS+O8T09gP1AfljHSpA9Z/XYBf+eBfX/Wvdt3hZNVPOaONcDE+8nhsMUIQTQyxnubv5v6C/eK5NdiQzfC3Y6pUwYvfS3dRkfAAFH2PibW5wnj74O2BVQWe+J8wGXS0UG1eBGVust57GXS6BlAVgnJiK2uDjVLhm+DVDMEAqyn5V2gsAl0JKTmhZv9HfDnMh2ZONZEvfJ5aaPhAYIEg6lwNgnHhdIKr9JA+L
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199021)(2906002)(86362001)(38070700005)(55016003)(33656002)(478600001)(7696005)(71200400001)(38100700002)(54906003)(9686003)(110136005)(76116006)(6506007)(8676002)(66946007)(66446008)(66556008)(66476007)(64756008)(122000001)(316002)(4326008)(8936002)(52536014)(186003)(26005)(82960400001)(7416002)(5660300002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5ZMEy+qJEtB8Ki74khRMwa2UpthINA3a8ZI0AoAZvvBO+a2QOsjH7AGVpqL/?=
 =?us-ascii?Q?YZJsN1cprwgON+BH3/43BEYSGU5KgGUMEbX9l9pxpJUSgt7R5ru2N68fMGg4?=
 =?us-ascii?Q?521A2v22sqNl1nDInekRyFd7xrUD1MSdZValSdQ6tj7vYnInPWcVvXN+IzA1?=
 =?us-ascii?Q?Ms63ZsGSeAT1UV6iVFoGCvxp7X7yWrKSr+YCrY9zT6XhFEBlSIqzmcuxTn+R?=
 =?us-ascii?Q?fq76rhMiNBaZ3QDrl7D2FdeHmvWNWSRxjvVsz+KBlY81r0qQFpNoZPmhE+F2?=
 =?us-ascii?Q?V8g6VFZBCPlT+Ye3+GtD2Z2lWrfvHtNVm1XoNEm+DI9grAf6Ukx9RTASU6VJ?=
 =?us-ascii?Q?OB12sfDREXHJ8g1JI1gP3gijX1FDdxnNPmaoNdXVt5fj/SklUhLNlQoxUaZH?=
 =?us-ascii?Q?Bj3t25z8inS43wOeBHBzjeq4TCxILWm5FJRt+/m92xX3HjknBfi/Io3RE+ei?=
 =?us-ascii?Q?sgLQMCqGmcbyCMAcuL6TmaGjN62FoU438m/xHkTZkVj1mam2yGzpPvh6DYVN?=
 =?us-ascii?Q?Hf/JgY2essz8ZlkYsUxVmcogE27/9WH5OeMxctjlnLYtY25b2+KK2mkA6zTE?=
 =?us-ascii?Q?TFJT9OEfeqwe2CMbWj52D53tUJzEBPqAsVgZUb5fJJWvO/RnDT4arcnq0HVN?=
 =?us-ascii?Q?zP0eA5E+QphoLQrm3NRwhARBw333l3CtyCC4Y2krsRz8NLPX7h0talSCIW16?=
 =?us-ascii?Q?K4Nl1iMp6FnfK2ksJfxSyTTiLoTgABwxzzLEhyF35sU1GPfTlkvKE/21vrco?=
 =?us-ascii?Q?vCpJhB9G7Vken2Zn7+89DfJ0ufJZB9LwEA7cbOCg3f7nmgg8YZgryM78jJZW?=
 =?us-ascii?Q?XmwdBmYTUy9ZEuupCqvngcb28lvwTLePt9Crl7xWRsn6tezh4t3tAlHEOYY9?=
 =?us-ascii?Q?cT7KapTKDqQ/lmhMDl+yMNtibPqk4kWRuu/2doy9b2X+kQ1hHS+7uUpJckqk?=
 =?us-ascii?Q?9oznKwTtWhx688s1CSYeoizS+2241D8x+KEHdQDw3A8vjpIFQo+fdGpCKWty?=
 =?us-ascii?Q?PKYWPDxi2Mya4E+I/ENsaoj+8UngP1q1eWpvScl/N33OcgGuV/yZ0p4clYjs?=
 =?us-ascii?Q?aj4MFBHV9eiQGl561Gt//d7VzXEEokirGFF+LX7LyAkZQ7dVJwtmxzsiHRTt?=
 =?us-ascii?Q?bEGwJ9/DZPbmNN1X+MpC4HomiaJha0VXVS6HCjl/Yqh6DHXhuQTwpCWHjPqK?=
 =?us-ascii?Q?6zCeOvpPMy8XAAA0AGlCbzGqrYzeaCVAj7cb+0MBXfIGGNZ0zVXNWZLrr68y?=
 =?us-ascii?Q?pDovwqDnFq39R1k78tYBH5dynfCYk9sqtTn6pikv6pn8hXCS9TkNMsmBc4jJ?=
 =?us-ascii?Q?5Tc5cBFphQmTA3srOM2330GbXu6KrRJJfBKHFrJJk2zl/eG7naTYNoJ6AdK4?=
 =?us-ascii?Q?aEllV20WsAqY/0c3ejfozKq4YM5nkgkiL1+DUIA9FzzhnjltjT2zlgohmuRX?=
 =?us-ascii?Q?c8CtUBeRyzwlvp4v80ptvGgQpt3Iq1Coj8Fm76kKBhB63ln1PkcTM+JxzgOY?=
 =?us-ascii?Q?kbUKxbCcXOGsXgkJtbtj38GMNq412Bd4J6sfgf4B6nZMEuzaYqAhK6meb9IG?=
 =?us-ascii?Q?r7pHzmsAgDaXcr4SkAuI2rzoo9oWzIhKXH+Q4w7e?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcfab895-9721-4f66-0b44-08db2f38f755
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 03:03:11.6665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rW5RCX3ivGVW6dtjrW+1dzyD4Wq/dbkQehuQNdbwIVYhweADzkj6gu9yXN5+v53FpIYnHNwyMCKG+WE1mXWe7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7061
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, March 25, 2023 1:35 AM
>=20
> On Fri, Mar 24, 2023 at 11:57:09AM -0300, Jason Gunthorpe wrote:
> >
> > If you suggest to overlay the main cmdq with the vcmdq and then don't
> > tell the guest about it.. Robin suggested something similar.

yes, that's my point.

>=20
> Yea, I remember that too, from the email that I received from
> Robin on Christmas Eve :)
>=20
> Yet, I haven't got a chance to run some experiment with that.
>=20
> > This idea would be a half and half, the HW would run the queue and the
> > doorbell and generate error interrupts back to the hypervisor and tell
> > it that the queue is paused and ask it to fix the failed entry and
> > restart.
> >
> > I could see this as an interesting solution, but I don't know if this
> > HW can support it..
>=20
> It possibly can, since an unsupported command will trigger an
> Illegal Command interrupt, then the IRQ handler could read it
> out of the CMDQ. Again, I'd need to run some experiment, once
> this SMMU nesting series is settled down to certain level.
>=20

also you want to ensure that error is a recoverable type so
once sw fixes it the hw can continue to behave correctly.
