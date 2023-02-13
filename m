Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA8D693CCF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 04:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjBMDOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 22:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMDOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 22:14:33 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA32A262
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 19:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676258072; x=1707794072;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q0hCbkIjpAAXbWK8nI+t6JVWKPTKE5AZ1iHXjjq/Vvg=;
  b=g2W+HbcEZwVdAgZhnRaRX1N26kfO/Fzv5nkcJU+wj03bUfcbWOKtcIwJ
   IYRAR9zuhBzCFl4Tiy91ROSPdJwMJPmBJqp2hNc5WekTnrOvqBdVS8c2n
   2hii6tDYnV4qF3LyBQ8+5YhF1J9BX1+sKteokVvgctVwgR6OFBBiXXaA7
   PlJf9mvNK0WhUZ6brmmzE4c4ZEN4MbXOvvEQ0Ic7C1yRTOD3Ii8YPT/M1
   UNDaBxiSvjv4HEBYkSfRf+SoFX1kwzIo3Q13uiDF9IKClSQJ5rnDTy5Nj
   EN2WOnXxID78svNLzVT30Uw1bq404HCSvV+NRYpfEb2OPfPeQgJsw+D4t
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="332103929"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="332103929"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 19:14:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="914158608"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="914158608"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 12 Feb 2023 19:14:29 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 12 Feb 2023 19:14:27 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 12 Feb 2023 19:14:27 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 12 Feb 2023 19:14:27 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 12 Feb 2023 19:14:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOQ9g075bk0iA8SlCZQZ/QGYy1urq1KYsmvU5YLEMq47/xMDVUuAjwlIw9YDqv5QN1xcz3g14YDgDSUG+SDrvVbY/nMNbyqeSN6CyzyL3QOZ+FCdlVKH9Mxd01pehM9/LwIc7ejNzqX9yt2mLOk2gth1y4RthPKLtxW6ozH2SuVTgm/E5Zr+XXgAgJ2MGooPI0vJlLErmoCdweu7NYNH6gXHANvcFN2F3SuSv8C/fiyE2L4vSZVrIoOkWFKvna5LJXLRsdQ3nnFnkJqcjvI+lhsqh/egqxiKsMpR+/6l0fshTGUCX+ID94l21d4eVCnl9N1nW7NwGaBlgGsqu6aHmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0hCbkIjpAAXbWK8nI+t6JVWKPTKE5AZ1iHXjjq/Vvg=;
 b=dFj8rNphNX6ARXVTq+QnxZ7uXpw6Wa45NJtFV8n14R6yvfMo01UVSQzzmj0rYRgbqN0I6sKvJp8qVvdwNIk95HzU/y6ETmEExctaUh4yDGqCnSUyS4lnq0jBNESyOVMdmHz6emQb0Pkw1Y+eH9vFFnPR68zNsEXz6I/5fapVutRfweK72rZGFIx8bWg9RgjQrimsdZ2kDZvYJa6yYlNjIpQ7dLubB4gNkNuWewy6Rf2Gw+YUxbMOBKCBkarg0RkfcBq/bLuXQDhqCwT/ErBxqZVDF6lJ9EB85V71Pp8uy6APB+GjZc/G6JhnawBBbedcl4tAQHa0Oed81C+xl+jxKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB7114.namprd11.prod.outlook.com (2603:10b6:806:299::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 03:14:20 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 03:14:20 +0000
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
Subject: RE: [PATCH 2/2] iommu/ioasid: Remove custom IOASID allocator
Thread-Topic: [PATCH 2/2] iommu/ioasid: Remove custom IOASID allocator
Thread-Index: AQHZPaM4X827KMb2AkC/Wtvslyhpl67MNy0A
Date:   Mon, 13 Feb 2023 03:14:20 +0000
Message-ID: <BN9PR11MB527675C04037838BC703AA818CDD9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230210230206.3160144-1-jacob.jun.pan@linux.intel.com>
 <20230210230206.3160144-3-jacob.jun.pan@linux.intel.com>
In-Reply-To: <20230210230206.3160144-3-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB7114:EE_
x-ms-office365-filtering-correlation-id: 457404b9-5491-48fb-9edc-08db0d706613
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DHaE7kv7ZbSWFt1nQ2YTC+lg4pztc4Mk3KhkDDiRfjuk77FYLD1CoJfK1+sFDF/FLjeLaScxgVn96r4AquhlK1pL6C1rX+5aH4D+LUN2Ly+Rj5gppl/rFmD21B4CuGdKYD+8/BhJpwd6Q8GdX6VXtDrndIgFwiI1/Pvhn9re13aWjkLOyHn1aMHc34xzvZFMkP6zQiHCKpsGkct88m1hD0UDMu6xnsOufVlXqsnt26wtwl6tXx6dIVfncxYfcqSpEzapYpQSjkkJBP3mOELQpQsQVTCcp/R3AuXxu59slIFC8uq8lGbBW8/qx1bwL/xuWhRZG+eR4t8lUuPOipgbqAfunBlRjmwg6Shd0ZwY6rSgJ3SvHd7VowT7CCdSY8PfS+e4CIA09A2p9eZ93l+KyWLk/OnZIwj3YGPwDZB5gyancOdJ69aPbJNOpbiceVbjWebAmv9AKmvnKn6ZO/3/+s5fQ794vNnh/X4Z1yjwaWnrj1bCkNcuaV6VTgzrtQFmiv1sJah4BTBmdzxlomYw1zSrgw5Rlc+psygJSfZGLqGT/mmQFB95Tc6NqYRw7czaGNpn4cvBiNjyxVG9nu8DJRkGOLgNNfrrbpMAKPGW1yQg4FjqtubGEikNmorqqsVwLKpsqe/Rp9Vb2DUJgB1tP4Y6gJXGV0qHEOy8lvVXYVKwGzt2PUUqqRKv6DcjA+3hh+P6WU8nYnGbRjSHht9FvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199018)(4744005)(26005)(9686003)(186003)(5660300002)(6506007)(8936002)(52536014)(478600001)(2906002)(316002)(7696005)(110136005)(71200400001)(54906003)(4326008)(41300700001)(64756008)(66446008)(66556008)(8676002)(66476007)(66946007)(38100700002)(55016003)(76116006)(38070700005)(82960400001)(86362001)(33656002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DEYUE8EmBlkrFLSdphEjE31FVn+OsGQSVK4lZezlk/jLVpVwEDjD1kZzaqu+?=
 =?us-ascii?Q?Ga05nKSD1SAyM1WDLoYKlCfKTo9/babPfofHWlSkQ38vavhnia7cE5frCiP1?=
 =?us-ascii?Q?vFHO7qFsqywOhR+193UH0mdLmU0T6Ye8Bh60zvHMryCIG699GIv6Ff5pbo5t?=
 =?us-ascii?Q?TJS4gMgivJoiYXTR+AVLEFrcTVK1U25ziGM+q52xSj9aaQrzKtqEZZ2s6c4t?=
 =?us-ascii?Q?pt3KkdyiZjkTIULzhNeqZyC2s4vFkvXfu8SyMv32QtTOl+SKzXqxEUH5mT0Y?=
 =?us-ascii?Q?5klzM7wvSBsHzU1qe3MNShEfEwRPfkotAuD+wLgfw7BA/wCFU6Ai7d1i6pFP?=
 =?us-ascii?Q?ohO1pidltPTb0RzuYOs9bhAi885jpa9dWcOVrVsR82LqHjHq7BuQ3DGTZgeG?=
 =?us-ascii?Q?En1/MRfSeyhUxgn22BRfYlDpXa/g1l3hkIwQ2WC5myn1oBpI4+S1DsCFCf0f?=
 =?us-ascii?Q?haiuu8xkggJWHCx6dbkAENodgk/MCqBpaH2GoOnlk8k1USCflXiBhNjlUIsc?=
 =?us-ascii?Q?BI1voNRBPbBCxXIrt/DOkGdnHT7SdvAG5t6UzYpFltcScfooXtwAYYFJGTNU?=
 =?us-ascii?Q?irhlsBqciaIdpFxHnKfez8BTDlCstd/NzArbb5xkdZZadjg9lK0N9fQGumf2?=
 =?us-ascii?Q?7gq5qytwEqRGDMIUqQgbpAI8RXe/M/h/jVpr8vqq/iiOGyahhhIrZjO8/TT7?=
 =?us-ascii?Q?HeHONMYR5LnFc7bDo6oXldfi/Rg5/W6WW7mAWp36ytpIE1pXPUbN1nk5qcRA?=
 =?us-ascii?Q?2dKh4u9r6ROHirlwLJhyxP4RdrZY0R2rVqp4xbRaC+J8w02unsmc1Eb1b/M6?=
 =?us-ascii?Q?QZDY8RWa63PYnenYalfsprywa+FjBlzLGj3v2IW7alGe69xsJKAqJ934P5ld?=
 =?us-ascii?Q?BQJIeAQDVSul9sjiTnS3fjojKxSjoK//J+zR8cAdkR5TGuoh2w30bqibNI/m?=
 =?us-ascii?Q?ddqW6A/tOLQxLdHIEkd6E9FsUsl/816sXedZQRtXvprl+3N4QdvdFp3DKbeN?=
 =?us-ascii?Q?tXMnIFdIlGiIlpF0+LrrpNjbyltWCu2rApZX+OSBN6fZ3CWbmNms63dN6BrR?=
 =?us-ascii?Q?kjEtthNaStkd2WC4Or+Eerlc4ljimD1e7eRyvEhqVM8UkwyYxngUIqX9eGlF?=
 =?us-ascii?Q?sbSLaz2WEKQ7jYtP+6N0NMB2VVY6IMX2j8iclNqoL4V2IC4+bfbtBCpkbYhk?=
 =?us-ascii?Q?SyghrL2AUHGPKimPW9q8PTpU3A8oC0AMBDa7jCAgj/uj+22zt5QPcaf4DY/q?=
 =?us-ascii?Q?4WsuXn2cmvagaaHsGxrTQIRq/6uEAIGHZx7f+A7eNKrSThYwA9rfcK63zhFS?=
 =?us-ascii?Q?vV/iWtJawWyQK+2DatNR9vFqLpBsWiLDjwI7MCNJJVbYwIRRlO9BKB3wjUBU?=
 =?us-ascii?Q?0SzBGq9WMNWLuLgm7X9ez85ylhyUJ06ULRP/jK3VCsuBYRyWFRXKTmhLWqvn?=
 =?us-ascii?Q?OFcach34slV/pb7XIXaCwuGAkzuCS1xuFGiPZT6vkd7ET0edSU/CTwm+LPIQ?=
 =?us-ascii?Q?zgrXD27AYfFkyqqglUpcHi/wMfOD2Fpm+LFSRvz+eE4WaTxX4dgb6lyTuDVU?=
 =?us-ascii?Q?8Q6VKJtRaorntZRNLt7xwt2qbVKiVSgbVusH46ms?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457404b9-5491-48fb-9edc-08db0d706613
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 03:14:20.2804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LaO0b53KTah7Fp8HN8c0YM2yhMfaYk3sHzKk3+CNC/d3ulPb+Pp+y70OMV5e9eZeW+AEH2cWUPXv9TDJib/DqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7114
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

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Saturday, February 11, 2023 7:02 AM
>=20
> Custom allocator feature was introduced to support VT-d's virtual
> command, an enlightened interface designed for VMs to allocate PASIDs
> from the host.
>=20
> As we remove/withdraw the VT-d virtual command feature, the sole user
> of custom allocator, we can safely remove the custom allocator as well.
> Effectively, this will return IOASID core to the original simple global
> namespace allocator.
>=20
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
