Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D915E5E74E0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiIWH3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 03:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiIWH3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:29:38 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93355DF94
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 00:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663918176; x=1695454176;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UNG97m6jNLp387XC0snpmXixW/cuDA7npd+bNv+P3Z0=;
  b=J0lCfvEoDbb/+aasnHUdtTw5QnP4TmeA2epbpVohdNXII5mh3CL8eUIo
   4k+cc/92v9qbQDNaWoD1mQVdnYcCT1lf/xBJtSfCjqE3/cjyH5ialkLo7
   sMpCnqFRrEAtorGPkPyUm/M1mxhx5a2nAqkkM7x/0WlRasAFlRcC5dkhK
   M+jy3Mccc301g2hYj2br/+5ZsxpwF7nn13S/0m0fQ0NEHr9UAywcJqmGn
   FDsTPmfP/86w3QUJsrRERHnBZIyFGNDsGuXePGBcousuffeFVjDJN16NC
   h/YBdO7olaFsIz1N3Ud8oE0s8Oi/dm9rAdvfrcT5juerDFbbaoxTMY25q
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="364548953"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="364548953"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 00:29:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="724029905"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 23 Sep 2022 00:29:20 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 00:29:20 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 00:29:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 23 Sep 2022 00:29:20 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 23 Sep 2022 00:29:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzzJFwKaSg7d9F53f/+KcuP50Ptq8h6L6AAxiqrb5qbMRGPpW8WvXLuD62+BaUBgI+l+EFbRwv5d45NRwWYcXpYBcnA2r6BIFqEM0mRgjr4sTq9R/n/sdQlVHTfcxeSqfui8cuCWn5ySA4yE9sWvRMtOBuLyFd9aXed5jVt3rf2tIZTcaPhbvLP1FaXhLhRO/Jk9S+3kXtm80pce/faJg7XhQDqRGJLI9X2zQZ6PIaEpejCY+8l5NEkhCKw4cS61Xpe3aMjyVlWn0V/wTsfohOUGBHTIdudsliQ6kIrvgUrFobqKapfoC516KOkqevITFOBcdkpme0RslVNHIYjInQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNG97m6jNLp387XC0snpmXixW/cuDA7npd+bNv+P3Z0=;
 b=XOjkUMnxGeTFeZQhCUZLLT1PCOxeEvVMhUx4IfXW9yGSS6VfDyIxfnRdcfeovXOHXuFkn/LRQJolCh9AfRj5lDwlvxhavDPwughcnJJD2B24ehmp2Pq9CQJ/m/wdmnbM6OLgF7x48hlNJ1H9TcR5tscYeL5PKUTAyXhL/mZ9ffwJjF6cIFu/gAmiDFY7qnzKYnsjqpcdt7j3fWTCGx8KMCkwVEuKki2KS0QYS8C8A5bYPBJJ+MJ3z+/kez2R7QfWsSfZhs+2Z6rNNCqUsctZemAatsSVsdWSJNKoGI5jGeZ0jQu02OUylvItlVnbEhxbx/HzQI8/UnmHZVJxFdZpVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB5342.namprd11.prod.outlook.com (2603:10b6:5:391::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 07:29:18 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7%6]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 07:29:18 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Remove pasid_set_eafe()
Thread-Topic: [PATCH 1/1] iommu/vt-d: Remove pasid_set_eafe()
Thread-Index: AQHYyNyBaLJRVVP6yU+S0hnzzdYPlK3sqpAw
Date:   Fri, 23 Sep 2022 07:29:17 +0000
Message-ID: <BN9PR11MB5276D1FED7619AD52FF68ADA8C519@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220915081645.1834555-1-baolu.lu@linux.intel.com>
In-Reply-To: <20220915081645.1834555-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB5342:EE_
x-ms-office365-filtering-correlation-id: 79c51314-6960-4fe4-65cf-08da9d35531c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2vSgAUCknp4qSq06W2IuYa01FeQsauNJ7quP0atAtAb8Bsu1iVEfL0b2z+FqifA2phz2P6JNIh7T6du7J3p6sXgakSnm+9D9ueKIheIRF1CvOMQjKV0kJsS60GbLdSPHEEsU/hdcZrzWRE8jVMwPpTSIX81uvc9QfTjvGMWJhqlp2bPkNflS88kli2hgBs1Ceqa97jBhsBU1HyQvIBAvtuaCXf+i0VnvOEX4/1UAZX8yAS9ipICLX88Wo9eNHFor3/bsDvpBNGlV9EEmR52n6w09SWCRJgQdf4H5eRweEKGi/ZtlG6i7QCActbHVY4XMj515s5oO7GbEgyp3I3GlxNXzEMa4nZM1+GqIDIY0fXPy/74YP24PvQ32UFAdJeu4GKO5Acl/N8andgpB4Ujkwxan0VDTfY82IHo7o89SorTC5eZKeFMJ5cXmHKE3gKBownz47odtTghF35jt9qHkoP6cnB+0tK3erCnR43t345peV743XoWqf4MPVWH3m+M4F7LPz7kVjI9sDAZWN89HGQ5eQw2yVCl13bB4vAYeyniQgt9tgJafZ9mhcsm7LYPLXlueP3R062GYkIc5dhj85W8WBUsahexmPZNuMNatrdVz1ZKVUMYvmLrmxj8N0r35XS4CL6ehyB4Gs/Yv/+FkJEwurlm6b+uz6PPY7fnFv/Mk7fR+qQD/pkyigQn3ySrXNEq7VUh5pgWyuzaivbI+zvU6+HwQMWjfNBRfVJhlOJFnvLcBSq1oayUW8rEPnaLIwF6MQ2WB6FVOsoP2VH9rIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199015)(7696005)(33656002)(26005)(9686003)(186003)(6506007)(66446008)(64756008)(66556008)(55016003)(82960400001)(86362001)(38070700005)(558084003)(52536014)(8936002)(2906002)(71200400001)(8676002)(66476007)(76116006)(4326008)(5660300002)(66946007)(110136005)(122000001)(38100700002)(478600001)(41300700001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u9tXz+JJMKxc57cDQiFV983irj/i5LhrRMFhmkRO+I/t2fYjNXX04KdL1/co?=
 =?us-ascii?Q?lLAdo9phA33WPpfbcBuKuZOau3BTfsdx1q8FSREaVHxA2z1XeB8OxXR7S1h9?=
 =?us-ascii?Q?C3y0M3dkEvIwyxnpBgaKm+btnNTF4WY3ilkgFGFDd4B7Zl9vDMpNFzK8ie8s?=
 =?us-ascii?Q?b13aphLU7oep6FG+YmDn7o5tTYlnbXArmiOr77ZRWd5kkfoddoLG/cvOUjdf?=
 =?us-ascii?Q?p8J/oQQ+ExsFPd7D/W6AvZ26MJnfo6IAP5Ngv7lup/Dacwv2zng8vQ0mABJI?=
 =?us-ascii?Q?ZQYs5xVjwSgy9l5dd6N2zrKvdHFjVvKx/dOCtGV5M+WOSov5KEOc3j7oX/P2?=
 =?us-ascii?Q?98kYfhcAwr13v/0Jdpm9s7Z8Ti/IIbfff4F/98PsOpi3BwsUS/RcbLMjtppo?=
 =?us-ascii?Q?4K6VYBZLxhO9NblXEwVN7/CxiP1y99rctzXj21P4qoeP43rpTEOdnwavn46S?=
 =?us-ascii?Q?C0tVmZiC1ltFczAdmRxjoVYEoG2KZjd4RovzPwUhcEpD5vm0C/SusNIe+hSo?=
 =?us-ascii?Q?KN7o3rdd5HbUdZ5APK9GACIGRyJwfyb0ifcaoomjhKR3pz7M3e5uT7BEeha6?=
 =?us-ascii?Q?GpMs9QO3NSN5LVIvu88E7pgrXitzILOZCnXVe6V7R6AVffxv/UCqLVGHr12+?=
 =?us-ascii?Q?rX661ZHhOFWYPbLOmT9WL9bjrLvyNq8PsapLCLinEQnDqLJuugd5F9bHH4wV?=
 =?us-ascii?Q?eaw1c1IjlFqDla2cYSHqfHUfDbBaJfBxrwdJN/XoL/9wb07Nh0Q85O7HhoWm?=
 =?us-ascii?Q?7VMxapOQM3O+Bw5en1sZavsTOH7ljcUHSfJMVu26V8i7p0xBiDZq7I8gQt0z?=
 =?us-ascii?Q?0NjBrpQgZ3VJmy6YDJp3bYucnGXZMy9CehgjL08DGjF/Pz7MHn+Hkbn2/QM8?=
 =?us-ascii?Q?DVEVf9Zt4y4M0NFY3/wP5WloFSMaUKvH1LgbjP5m/XwaCeQlBJmEWekgJFfV?=
 =?us-ascii?Q?7AspSOQ5pLcrkOcaAdsXZN9oQkL5u2fTdQhB5tdz/mAPgXNwnY3oxnlKCovv?=
 =?us-ascii?Q?Tyjy9TCl75yAW9zbKGo91AjeXnjM9wabhQZhARsn0yOJqLGVwVucYSOcUw5T?=
 =?us-ascii?Q?lRKvEzJIuMObKoymjCRL4CLACmxSRZ7TPfQt2/8sv/IqVmGUpytdhkpjMcD2?=
 =?us-ascii?Q?QTkZxPFxTwh0Cdf1Mp8HhKRRwAg3/0GcbmeCnOcG5nVjBbzaC4xsYnAWp6O1?=
 =?us-ascii?Q?YxSxEb2eDSu/aJErrZOYI95qVK6LMbkL72t2jvcmrokCt6Pei79x5xHFEmNW?=
 =?us-ascii?Q?fFqX3q6OsyYD20aWXbfYSG5xRSMWtU5RWbkuPPljABAmfDCmEf8646wH4p1e?=
 =?us-ascii?Q?tu829/YAO6X6lRSAwZ9Uee9dstrttNuC/dYbbLEOUHbqlRYfkn9eDRd2U8Ag?=
 =?us-ascii?Q?7NZ8wEmt7wxr+nJtIpAsGNbmrA3q+k61JlIHe6DsnGbWx9xOWsTylY0wu7VF?=
 =?us-ascii?Q?ieEiOIpUUU9I2fmM36rL2uTerEh8YD3QmHsnKA9ZFvxKawjaJutiZCBfdeba?=
 =?us-ascii?Q?A2PE+NpdOhXPwr98hNPqJ2fwiN6oeByY1AGO4rnYnEDFROiJfTOzDaDpySa0?=
 =?us-ascii?Q?LXRCZiY7rdGh3GjOJ7Kd121xKithlemzPvVIrHnV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c51314-6960-4fe4-65cf-08da9d35531c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2022 07:29:17.9388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J7J9eGayOUpoKVSUh1jla8u2FjpmLjFoH3UB+r2evr+s3BVwL4YtvgLqpz45VQbN4adAPTO+V2DA5f77Mwt4/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5342
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
> Sent: Thursday, September 15, 2022 4:17 PM
>=20
> It is not used anywhere in the tree. Remove it to avoid dead code.
> No functional change intended.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
