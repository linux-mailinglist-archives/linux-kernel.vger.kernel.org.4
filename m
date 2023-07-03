Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8CC7455CB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 09:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjGCHPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 03:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGCHPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:15:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6BACC
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 00:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688368508; x=1719904508;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IvlQrNnOyHi6Vg94dpZQwWqAR2Q7aPclv+eCXYP145M=;
  b=EHpTJQOAL3sN+j3mSHGYxBVUHjHIaHDT36WblVy0zcKBygo/j2Refznl
   Rdvaf31iezQjQ58qjDVuVWHmlcI7cW+TK2FQKnKLhc9lkIcgil6B08GXg
   /qp+TLtooTvcErTaHK+cNRE4dxIYLUXVx/Bw5JgmIpximHyCTCP3BFn4R
   zVtxYO9D6qkmdYamI114zLUD5LrYeojnYEdqGRgJSwBYMoQ0MLmmKnVS6
   oVYcfto2OBBhJy3uVtSjPPUdFBNuUFvhWZ1oj3zCfElNBqo6XwvxI9xhI
   ABfnD4y9Ghw30EPHbsat3EBk2cWRzDe0e7vVdUV634fIK/F3gLgIA15cJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="342403473"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="342403473"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 00:15:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="712466090"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="712466090"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 03 Jul 2023 00:15:08 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 00:15:07 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 00:15:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 00:15:06 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 00:15:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwiPb0A9S3SaagkzKEpeXerui8CGaKNfOCBvS8KvuVJ9NViwnVECQID4aSgdNarqhm7eH+ytk4bpFF199gVaiNmuAaBZ8mC6XLQ+ftcJjMsgAn2IGU/8pf/32iEeXRCtZfdn7JSgn2nI4z7mILR/WzrxkzRSCzY3poeI8wEYvdyDSYJN6dSsBA+y0A9FHwv79kKErNB0X5/fJS6L/xtaTS1DT+T4hq62/L6zYOgFLx6N+NgZ/9rkybQddYstTg7e1+q1aOjZsqGzVWulBbLFYkXoe26meLg0f1jp3r5B3AxozKU1q7Dy7V1Di1k5wEX/rVq/w6Y1Vfz/GiEzrN+fsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30Z1XKED9IKelF/wjI5jOSI2BJqsukiJUNf1IXGiWLY=;
 b=bFGk1yqjcVYjg1aG4fAXR25id1jxqfw75S8bcsJfk4/jEaoyPYghAGf6RIz/Wzr1fGS3zDPDkt10vTmKXqPEiCoTr1Ug4ir0LsuMftHXkNpU0GDU/1cvtHOzNo7JvalUjnPfaf+TC+VUVtCGWnJiy0RrDh+Wohy6JOfRIMdnt0k86z1qeNIFHu+rrQ8Q+jEXiI+p9QPGpLz2s9AsDZAcPmtlD+Ila2Zt/ywuUXW9g6g/CSZtJgspTGTIygdEq/tN/Xraj4AEHYduGgBc/CL+NeH+Vfpl9O/RZVlscAkRO9/fQhgTSITejFU34fazeoMM+9ahBarohPBdTfPMbCydNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB5873.namprd11.prod.outlook.com (2603:10b6:806:228::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 07:15:04 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb%7]) with mapi id 15.20.6544.019; Mon, 3 Jul 2023
 07:15:04 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Liu, Jingqi" <jingqi.liu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/5] iommu/vt-d: debugfs: Enhancements to IOMMU debugfs
Thread-Topic: [PATCH 0/5] iommu/vt-d: debugfs: Enhancements to IOMMU debugfs
Thread-Index: AQHZp3g/2UxT1hPuDU+fmpvlazmt86+nq2FQ
Date:   Mon, 3 Jul 2023 07:15:04 +0000
Message-ID: <BN9PR11MB5276885D6A142BC94D80C2618C29A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230625150442.42197-1-Jingqi.liu@intel.com>
In-Reply-To: <20230625150442.42197-1-Jingqi.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB5873:EE_
x-ms-office365-filtering-correlation-id: c3099e00-b67c-44df-5f5a-08db7b953968
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: id1MYflyCxyR2gN9HsFH5G4YZ2IwI808MbrTQ0+vmdbDO8UJd8GVvdN3lxxKB4hN8uXxXtAUHpdhEBOtvaMDumrQx9w39/fAF8+BTN/bITa6+hJKRVYzOZ96LAG9uDrqIYuKk+XlCHwzwIp3A3Uq4VL74jHBryNLOWPEizbft23227MvulVK8/2xXQu1Fr5FGCQQy7ccVXlty+UlIzUbwfe7KrVf6Z7Jax9R6CBHxcTHJ1w4/3eL9lbunIuaYUl3O6znXZ5Sbg61Z9eY25+AeEfIuBoNaY7gj+Ktijc2NwwRKz+2o93sF4v6Aw/QP+m83eA10K5nqhq7qjqmQgY/9djZfTo8FOI3NObslOvX4z+6HGqryvFJq5S3wHaxizeCB7RlUKrDnGafz2w9XEK+4VN58ATyFLzQ/9spLqP7AupEP2IMxFdi8ya9Kmu08FK/CiLcv3CYzQZkGl+zptUtyXC2IiZGJ/5g/LfTxF7axQB069DQVTxIkHFC20UPI33O8jVYwTwWZVjKh59xNkQtEbMoVUYrQUU4YZJA2oCqqxOcsWmA+/6CGVjub65UfqEGHyJFMj3ZNWJy2C21lxreoBGLkRK9uk3yxSovYVdcnCzZXm5LxHXbiF8q8PJrVN25
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199021)(83380400001)(110136005)(86362001)(41300700001)(8676002)(8936002)(52536014)(5660300002)(2906002)(33656002)(316002)(66946007)(76116006)(66556008)(66476007)(64756008)(66446008)(38070700005)(478600001)(7696005)(71200400001)(122000001)(38100700002)(55016003)(82960400001)(4326008)(6506007)(26005)(9686003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zOvKg6eSBwNXCefDcsPq3MVhF2KJfaTghlMNBaCznD9IuuhwTZCCkNK+m+Kl?=
 =?us-ascii?Q?YKFfzYbIP1YaluPFlpbG7hDIG1JbwBh46SrNLHR07lIKXplomQoDQZZGHPA4?=
 =?us-ascii?Q?avEZ7IdcPlc7+ppSBwzeKLbK0BEOpjFv1vs114W7OfuK2+vWbwrEDWY1YItc?=
 =?us-ascii?Q?VrlQVtHryf+h1IQYERxQyaJYVAHYq/TLrEVKwtHXewwNi7tnbE9YnZ7ZIWT7?=
 =?us-ascii?Q?bnT76qJCyYrDpQW0dZo8yTNXJtrwqgLnfEPNZrO2meWESTpyBvyx9DlfCr+k?=
 =?us-ascii?Q?JQqjKoGWT+kA2NJacNpUwlohD5EsZW/1qJHPnpG8u/iXntiWkl7tsmMTV/at?=
 =?us-ascii?Q?oeH94K+41ry7I+s/F20At4iimd+cLkJLAopC0JIzH1uXTS1aIVYsuA9AoL2E?=
 =?us-ascii?Q?5ZDhVuKSmxcT0hplrOBZvjKPgYQGDeadmSKR9mtXJveQ3/LMRkxWbgg0/li4?=
 =?us-ascii?Q?GtDHdHlwXPd6X2Oa59GyMqNrjUxnTt2MuszMy/Iek77gJvRNOZKrj9s5k4lJ?=
 =?us-ascii?Q?76O/P3fhYTgv2aHbjH1h8hnZdSqH4FqcZ+i8dDolSgi0XRn5SOJ2CUIDc0tA?=
 =?us-ascii?Q?mPEU4oTBfWvWS3xrL9e0tmlKA6eL5YqW08lNKBFwQNWr2LaCEq6mvv/B88fY?=
 =?us-ascii?Q?I4K8JlVzA498aToHLd5vPWFAuad/GVKJ3Ectx6H1uoiFGLJpwoSyxa7ZLhwQ?=
 =?us-ascii?Q?2x2vZqqStxvHTt0fWbCcxg0QOoOEICfHgC8XEk/NCkhxXV0JnZ7mxl91Wij9?=
 =?us-ascii?Q?aT3ox4t8pWG98u1kjU5pchd9eWqxDidINXu554BRKeUDTrDdkqoizaaeDEHl?=
 =?us-ascii?Q?FkOuz8mHACRhRyp+VIW9QWwBGdxXze1wL3D164FAz92/UOh/dcC+giBi+Fzr?=
 =?us-ascii?Q?BuQ2pEJKsosMdHbCzaL38EsNBxfoKGl3ZNjqmURYIKim1gobpLzjc8kssRfP?=
 =?us-ascii?Q?96YNpk1l2dWVqHKH0bfhrkyH2xknibf5R886leXotSIX8xLcAQwW7y+gJYHX?=
 =?us-ascii?Q?zFa5zrszmyTqhmT5MYukTTGetg4Lcmd8uO/N2gfK2nPHdaJm4KtDOpJ9Ed2G?=
 =?us-ascii?Q?usO+g16G0DZTZbUDIKzlRarqD0msAxfu9d8bFtI659km48m2n4s3GNd3b8ML?=
 =?us-ascii?Q?flpF8sX5zl27Y2S18CLsAZsrg1AGwAVZVy8PpVPE/22RpinjkRjMU9/GXzcK?=
 =?us-ascii?Q?bWwz9X7xH8xGjyt7uz+9vKBhu70V+sRtIzASbJEu+Ogp1CQtfirhGYu4mE63?=
 =?us-ascii?Q?TvhiNENcJFaKxeyQCbgMWlKd4W6AtQrro4m7QIL7WInxEN7B5aFOVKKbFaiF?=
 =?us-ascii?Q?Brz+7a7ReIZuHjkfCVKKJVhz7mZsa9ee+CROzcwZmiiJDMwkIIsVNqz9HVWO?=
 =?us-ascii?Q?xdq2eeG0WQ0PRC1L1A1GIG5Vy4Xs1NpIZ9DT8Bk1cEIc0IVYz0DZDD44oI5A?=
 =?us-ascii?Q?OmM9Yq2iqnKDFd+vl3tpKaqh18XN+OmBGz6M3ODwqIUrv7K1sxyoDv7wwzKf?=
 =?us-ascii?Q?PDpUJcbbofkrDhoHpp6vab9DbceSay3wCexfkv/LEe/wxKqDN7DOzVuXMxZC?=
 =?us-ascii?Q?9q1Ft8aonGp8CC467T9guE60KiokfTnYFP40/tAz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3099e00-b67c-44df-5f5a-08db7b953968
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 07:15:04.6323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: evqFxxRZxhsn4qIAOpmxjYz+hDY5DpAQ7cj5GcayalpaYxgasaDUw61ohkYYTcmiNqYhr9PecF+fZXgMsoHS1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5873
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Liu, Jingqi <jingqi.liu@intel.com>
> Sent: Sunday, June 25, 2023 11:05 PM
>=20
> The original debugfs only dumps all IOMMU page tables without pasid
> supported. It traverses all devices on the pci bus, then dumps all page
> tables based on device domains. This traversal is from software
> perspective.
>=20
> This series dumps page tables by traversing root tables, context tables,
> pasid directories and pasid tables from hardware perspective. By
> specifying source identifier and PASID, it supports dumping specified
> page table or all page tables in legacy mode or scalable mode.
>=20
> For a device that only supports legacy mode, specify the source
> identifier, and search the root table and context table to dump its
> page table. It does not support to specify PASID.
>=20
> For a device that supports scalable mode, specify a
> {source identifier, PASID} pair and search the root table, context table
> and pasid table to dump its page table.  If the pasid is not specified,
> it is set to RID_PASID.
>=20
> Switch to dump all page tables by specifying "auto".
>=20
> Examples are as follows:
> 1) Dump the page table of device "00:1f.0" that only supports legacy
> mode.
>=20
> $ sudo echo 00:1f.0 >
> /sys/kernel/debug/iommu/intel/domain_translation_struct
> $ sudo cat /sys/kernel/debug/iommu/intel/domain_translation_struct
> Device 0000:00:1f.0 @0x105407000
> IOVA_PFN                PML5E                   PML4E
> 0x0000000000000 |       0x0000000000000000      0x0000000105408003
> 0x0000000000001 |       0x0000000000000000      0x0000000105408003
> 0x0000000000002 |       0x0000000000000000      0x0000000105408003
> 0x0000000000003 |       0x0000000000000000      0x0000000105408003
>=20
> PDPE                    PDE                     PTE
> 0x0000000105409003      0x000000010540a003      0x0000000000000003
> 0x0000000105409003      0x000000010540a003      0x0000000000001003
> 0x0000000105409003      0x000000010540a003      0x0000000000002003
> 0x0000000105409003      0x000000010540a003      0x0000000000003003
>=20
> [...]
>=20
> 2) Dump the page table of device "00:0a.0" with pasid "2".
>=20
> $ sudo echo 00:0a.0,2 >
> /sys/kernel/debug/iommu/intel/domain_translation_struct
> $ sudo cat /sys/kernel/debug/iommu/intel/domain_translation_struct

What about creating a directory layout per {dev, pasid} so the user can
easily figure out and dump?

e.g.

/sys/kernel/debug/iommu/intel/00:0a.0/0/domain_translation_struct
/sys/kernel/debug/iommu/intel/00:0a.0/2/domain_translation_struct

> Device 0000:00:0a.0 with pasid 2 @0x1083d7000
> IOVA_PFN                PML5E                   PML4E
> 0x0000000000000 |       0x0000000000000000      0x0000000106aaa003
> 0x0000000000001 |       0x0000000000000000      0x0000000106aaa003
> 0x0000000000002 |       0x0000000000000000      0x0000000106aaa003
> 0x0000000000003 |       0x0000000000000000      0x0000000106aaa003
>=20
> PDPE                    PDE                     PTE
> 0x000000010a819003      0x000000010a7aa003      0x0000000129800003
> 0x000000010a819003      0x000000010a7aa003      0x0000000129801003
> 0x000000010a819003      0x000000010a7aa003      0x0000000129802003
> 0x000000010a819003      0x000000010a7aa003      0x0000000129803003
>=20
> [...]
>=20
> 3) Dump all page tables:
> $ sudo echo "auto" >
> /sys/kernel/debug/iommu/intel/domain_translation_struct
> $ sudo cat /sys/kernel/debug/iommu/intel/domain_translation_struct
> [...]
>=20
> Device 0000:00:02.0 @0x103072000
> IOVA_PFN                PML5E                   PML4E
> 0x000000008d800 |       0x0000000000000000      0x0000000103073003
> 0x000000008d801 |       0x0000000000000000      0x0000000103073003
>=20
> PDPE                    PDE                     PTE
> 0x0000000103074003      0x0000000103075003      0x000000008d800003
> 0x0000000103074003      0x0000000103075003      0x000000008d801003
>=20
> [...]
>=20
> Device 0000:00:0a.0 with pasid 2 @0x10a0b6000
> IOVA_PFN                PML5E                   PML4E
> 0x0000000000000 |       0x0000000000000000      0x00000001072d2003
> 0x0000000000001 |       0x0000000000000000      0x00000001072d2003
>=20
> PDPE                    PDE                     PTE
> 0x0000000107d6e003      0x00000001161d4003      0x00000001bdc00003
> 0x0000000107d6e003      0x00000001161d4003      0x00000001bdc01003
>=20
> [...]
>=20
> Thanks,
> Jingqi
>=20
> Jingqi Liu (5):
>   iommu/vt-d: debugfs: Define domain_translation_struct file ops
>   iommu/vt-d: debugfs: Support specifying source identifier and PASID
>   iommu/vt-d: debugfs: Dump the corresponding page table of a pasid
>   iommu/vt-d: debugfs: Support dumping a specified page table
>   iommu/vt-d: debugfs: Dump entry pointing to huge page
>=20
>  drivers/iommu/intel/debugfs.c | 361 ++++++++++++++++++++++++++++++----
>  1 file changed, 326 insertions(+), 35 deletions(-)
>=20
> --
> 2.21.3

