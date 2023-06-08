Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DA5727C0F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbjFHJ7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235863AbjFHJ7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:59:06 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646472D52;
        Thu,  8 Jun 2023 02:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686218342; x=1717754342;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lQws4uprA9sr/zsoQh/AXbU7/jhzjZmrrt3upVrA6vA=;
  b=IG6t/eNOFgwM7kt2UtZ2RCaBRCVSsvnPnSwk6pXIPyolCi/pdbFN3jyz
   t9SvaqMRncVbQfdZ7L007K/Jf92P6+7clWya6AesqeiTMGGd8IqRWCxmj
   v6dRhb90T/xQaxnwYkKi0nv+BwLaQ0utFh1u8PAFxcfv8pOyPZ61QaC8w
   acMESdRR9hw+xPa52ttfCj4kNPJR+2TO4XAornyBy1OToAtZMXW40GkYr
   yrQdBkR9+j2Kv3BVeZmbJSSapXDuGYQgWmm+n+pyW1dH/zTjEnc9TCqxT
   OIrHruVryvXLGvGuByUKb2GQbe2U5T30laR4T+cXiQsumlLyIgBljiCRI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="357273381"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="357273381"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 02:59:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="660319355"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="660319355"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 08 Jun 2023 02:59:01 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 02:59:00 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 02:59:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 8 Jun 2023 02:59:00 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 8 Jun 2023 02:58:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jxe1S8319iha9WYBEZ4arYLSsJ5taRQx4zjxMUSQA01bFPnq0UC8TwDSGuZ7oExn187Bszt607/t51lVVMZFQqwHzi27r6GavBWjysu2UZWwEMTYb7ObdJGss4aoTw+40NLtQ83Q+pZ3xqnNAgY5TWwNrSjQUNpOIZcD83qOC2qKYejIvGK6dmOxXHLkSTkR1mtS9fYX216l+PCDWT7v1VmT9bQRmtHSZ3kKWLhsHTqXx2qFD4+/Zr9SgrGGjop0Dw/Humcb3sdss8zpdDU/Z+4oaLLUayCZJQJwKSIeawxAMt8b/t92dKh2m5iTNYWmOXDwlWDGdjSVJtGnlGrQwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQws4uprA9sr/zsoQh/AXbU7/jhzjZmrrt3upVrA6vA=;
 b=M+K48mLj/MjORhSv8QTgV+/2R50a6D+FBfQzO6xgK9XNxGym3httYMOXBOtbUASKYcsx2+4zLL8nOiAuwAzh6ytJglDmEOLmw65YIVr1r5VImhcrwfsOVQ7zvJ9RD+pr3aoJbgkVYnWsz/dTNp3ZHURB3JWcs+wd5PnFQM7tMxyai1KYVj2yV8E+0ne6eTf0hnJ6QGnJPKt2B+s6k/vW2CYEYrhTi/9uZ3XXSS5locWyIzO7pp6Vohs9+D6XKNixYU+zQPryNkQja8ljxSObH1cQ7RY8ghcMW/eMdBRe4gf/1a3PCPUdsOGQiu997/b5WDtx+m7FJECNj9xLjGd5Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by MW6PR11MB8340.namprd11.prod.outlook.com (2603:10b6:303:23e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 09:58:59 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::5486:41e6:7c9e:740e]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::5486:41e6:7c9e:740e%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 09:58:59 +0000
From:   "Liu, Yujie" <yujie.liu@intel.com>
To:     "ndesaulniers@google.com" <ndesaulniers@google.com>
CC:     lkp <lkp@intel.com>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "Li, Philip" <philip.li@intel.com>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        "guoren@kernel.org" <guoren@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ardb@kernel.org" <ardb@kernel.org>
Subject: Re: [PATCH] certs: buffer stderr from openssl unless error
Thread-Topic: [PATCH] certs: buffer stderr from openssl unless error
Thread-Index: AQHZiXLsaJQDawZJt0OZH6y+M8afcq9gn5aAgCAsWgA=
Date:   Thu, 8 Jun 2023 09:58:59 +0000
Message-ID: <6869338a02e108d9ed2c893f921c750ed1e00fb6.camel@intel.com>
References: <20230517-genkey-v1-1-b887424da4a8@google.com>
         <202305181712.xjvv1fbD-lkp@intel.com>
         <CAKwvOd=hoKFMC40U-Pd=2dBJ4zT4P60OgJpHvNmH+zdGAd_J-Q@mail.gmail.com>
In-Reply-To: <CAKwvOd=hoKFMC40U-Pd=2dBJ4zT4P60OgJpHvNmH+zdGAd_J-Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6392:EE_|MW6PR11MB8340:EE_
x-ms-office365-filtering-correlation-id: 65c3aabe-32d8-4cdf-09bf-08db6806fadb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u3w+a9YT84zRXxf0cPY8HsMLje2SW/b7heP0tSRFAVXxHFSeDtJOGOtp00EKdW52ZHcxZKpvfric+sCXg6kVonaI5MQKcO8VZPpVXzUD7Sg7+1N457LIlzcqv/pD3qHEGQMzTXMZ40+OWKhRLsLsYaGuN1lTV7KqroPb1CLfOFZaxtEaRBV5mz2iAllMZ1tJdhVrVHfKMbBpxF6/RQ8A5yvvyCWJCtncykTQT3o/qA1uLlonvkIDuTi4Gr45dLl9gL8wzLkER342WlCBpcwqs/cLMxiyJ6aMgAtYQlZ+WECQyQiisateDWR8V2uSeTwiwG3xyY/gf0Xe5P+6Nw4kndbahAXoCCGJIJrs7Ll587+zA9NKfRzjBIP/8oE+oG21sQirKtvMZDND4yOrYsZWqyuMt8Euy7yiNXjM4HBy+530LNKPcCVH1R4fcj1R88S+E1TXv6Yxeus/1wmlH/9FgaCmTyGLMeqguThQogO+maDQ9KLDTKmtrr1pjaHk4tEfszEca2mPoKzcHiVDeNHiWnZz+GO6Yz4c/YIRtqTLI3iY4GQf28km2Bx7k4g0H6/3JiaVDBjgEJNiRKSs9UYOUlWkrFSSlCTeeLu+MRpdlIh70eP+maZj5wMbaT4ykpWen4Fak5CT5v1XCo6wDmkKhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199021)(54906003)(71200400001)(478600001)(66446008)(5660300002)(122000001)(8936002)(8676002)(4326008)(2906002)(36756003)(86362001)(38070700005)(66476007)(76116006)(91956017)(66556008)(66946007)(82960400001)(6916009)(316002)(64756008)(6506007)(38100700002)(41300700001)(2616005)(53546011)(6512007)(26005)(186003)(966005)(83380400001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGx5enhKVnBCWnJTa2FYNjB1VDZVaWsxMlZXY2tobjFDeGRFbUwraVdLb1l4?=
 =?utf-8?B?VzFuUDlreUQrdytEVzRHS2FPZ3RhUE1FMkd4ZGJwM2g0blpka2dWcE5HNTJ3?=
 =?utf-8?B?ZnBZcVFXcTB2OUlQZnVjZDlUYWsyZ3R5Vm9JcG5US0NsaDFwL1dJNE9oZTR6?=
 =?utf-8?B?KzVlbzRuYm95bzVOR3U3VjgwaVNQRE9JV1BKK2YrTnE3aXlNSlBVcnYwdU5Z?=
 =?utf-8?B?NjFPbFEwdEFsMFRhaDE5eXYwWXoxUWhJKzVpRW5JVkxPTnAxRnlybmRURGM2?=
 =?utf-8?B?cXE0eUNuTVFGTERWcHY0NVcwZ3A1NVVxYzdsMEwrSXcrdFRJOTR2NUpqUHRD?=
 =?utf-8?B?d2Q1RnZNTXM3UHE2S2ZMOFk3K25Od0REUzB4TGQ4VW5iMGI5YXd5eXpnYUlN?=
 =?utf-8?B?NmkwV1JOSTBIRjNFT0ZQbWtmM1pKN2gzVUlPaWppSlE5cnlBazlLQjUyT2Jw?=
 =?utf-8?B?bnduTDlDOFVTSzFqQWc4REdVN3E5QlJpcUY5bmhkN2lhS052OWhMamkvTi9R?=
 =?utf-8?B?YkFYZHY3YXBFV2ZLRXlDQ3hCRVNpbjRJbmM5Qm05Vjd3cWFNckIxRHp0N2lm?=
 =?utf-8?B?Ui8vUC9rK0s5Z2E0UVo4YlExbnpPMXpBZ2Yvc3NwZEhiNU5QYWVRaEl5TUpl?=
 =?utf-8?B?SlF2cGYyTUR2ZDNwbUE3cERTcGplYW12d2JWWUNxcUNpbnlpRTNyc0c2NDFq?=
 =?utf-8?B?Q1c5S1hQcThyQ2VTYVpHcFBoUzVJT0R5emhOMVBxaUlNVzZhVWYrdVNZZXh3?=
 =?utf-8?B?VG9oRnJaZEw2S2J1emNMSGJsdUcvKzBudHowRmwyTE9VZnVWOVBHWEJ6SDNC?=
 =?utf-8?B?Unl1UU5rUmJXTkpKbkcxMFJtU1R2WG40Q0ptYVBLbFVRVzFVM0RSQ1loTUt1?=
 =?utf-8?B?S1o3YzlHbk1YMjhKSUwvSWlHcjc2cWRqV051MjhEaHBzdjRwL1V0SWtGN0hu?=
 =?utf-8?B?dkhRVDNHblNRVnlqZ2dXU1FuNTBObG9JVHdvVm9xWi9lanFmakVKYnYvT3dB?=
 =?utf-8?B?WHpPOUJLeFkwRE9hbWtJRVNxYjFuelp2UzFXVi9KYVcyWmQ5UGJQM1lqM2pv?=
 =?utf-8?B?dUM1ZExzRDJRWjlnTnRkdWsvTjFLRGZLeW5yMXlEWkowZGRETG9kQUdMVFBr?=
 =?utf-8?B?YU9qQysrSW9Xcm52QjEwSVkwbnpiU2VRd3NreDYrMjVsOHFwcGUrcDBwUVVJ?=
 =?utf-8?B?bnNxTjVTdU56a2pTOTBiQ3BEOHBqdlJLblJkMmZ5Q01Tbk5hNFovMk01V0t4?=
 =?utf-8?B?NHZmL3NYRHMvMXVwYTdPQ2FHVjhkWkJsRFlCVEdRK1hCUXNlNEh1dEg5d1dx?=
 =?utf-8?B?N3dmZGp4Sk45MzlHRFZjZWlpcEg0M2F2Q3ZWdGdvbHg4OGhJQ3dOK3g2VXJ0?=
 =?utf-8?B?S1JpWUNKSzhKcjlBK1lTbWhDUHJtZE02QmpkdzJrUHFlK2paaWZSdWRYcGNs?=
 =?utf-8?B?bnZ4eHlrUitRdi9yWGgxbk5ZRnNkMEFCMGI3aVp5NU9yYWI0KzZoZUxTMXAx?=
 =?utf-8?B?ZzR6ZkZYaHFVUndSWXBZM3EwRUhqUG9VRUs5VFBvL0xYNmNXK3dlRkJGOTdz?=
 =?utf-8?B?emlGVXIwSjB4NEplMy9DV0VnekhESnJQMmprb0FLeW5KUlVhNmd6YUpySWdU?=
 =?utf-8?B?bGhML2g0NzR1ZG1KUS9HVUV6RkdGczdFdUZvYnZid2Q4d2crUGlMd1RVSmU0?=
 =?utf-8?B?K3kxZXBoNnZmNGk4ekhkU29taytuRjRHOHNGczlOVU1WVTlIN2U0Sk54VWNL?=
 =?utf-8?B?VUxCeW84bGtuSXlZNUk1Q1Qva2VjOERPR01hSEVPOEVYc0pHb2tpSkNGN0Ix?=
 =?utf-8?B?SlZ1bDNNZU5Fd1FsZXgva01sSGxyL0ZFSERVYnJjTXZkejdhY09tRWZoajkx?=
 =?utf-8?B?MmpjdTBzWElPYkhJT1V1cFdGd0ZHajBHSUMyejJhckxTSTQzazBReURZTVpq?=
 =?utf-8?B?QTJuSm9FaWVvbFhNZ2w1bm1PcmZoMGxGNkJINVpnenByc3JpeEUvSzFNR0pu?=
 =?utf-8?B?bGxkMXV3dGp3cmx6bnd6RGRJdTBkSFMyVTBGeWx2b1NqcHVNRmxPN1pndE0w?=
 =?utf-8?B?VUVKTkRMTDMzWVQyRjYzeW1rSDI0cWN3M00vTUsvUm9QWE5TNUZoV0pKWVB0?=
 =?utf-8?Q?OQxBvO+3WdWA6XtZUzhbu2dVh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <85507672B71016418C52B7CADD37553E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c3aabe-32d8-4cdf-09bf-08db6806fadb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 09:58:59.0426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tFCgcYwcvKXyvGCCi/mAXI2iphpN6gNi8sPA3D2AJMzY4q0Ufh2VoPiJoqcXD+IXYPsE9MMSxGiz8z/lbkoM7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8340
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTmljaywNCg0KT24gVGh1LCAyMDIzLTA1LTE4IGF0IDE1OjM2IC0wNzAwLCBOaWNrIERlc2F1
bG5pZXJzIHdyb3RlOg0KPiBPbiBUaHUsIE1heSAxOCwgMjAyMyBhdCAzOjIz4oCvQU0ga2VybmVs
IHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IEhpLA0KPiA+IA0K
PiA+IGtlcm5lbCB0ZXN0IHJvYm90IG5vdGljZWQgdGhlIGZvbGxvd2luZyBidWlsZCBlcnJvcnM6
DQo+ID4gDQo+ID4gW2F1dG8gYnVpbGQgdGVzdCBFUlJPUiBvbiBmMWZjYmFhMThiMjhkZWMxMDI4
MTU1MWRmZTZlZDNhM2VkODBlM2Q2XQ0KPiA+IA0KPiA+IHVybDrCoMKgwqAgaHR0cHM6Ly9naXRo
dWIuY29tL2ludGVsLWxhYi1sa3AvbGludXgvY29tbWl0cy9uZGVzYXVsbmllcnMtZ29vZ2xlLWNv
bS9jZXJ0cy1idWZmZXItc3RkZXJyLWZyb20tb3BlbnNzbC11bmxlc3MtZXJyb3IvMjAyMzA1MTgt
MDA0NzUzDQo+ID4gYmFzZTrCoMKgIGYxZmNiYWExOGIyOGRlYzEwMjgxNTUxZGZlNmVkM2EzZWQ4
MGUzZDYNCj4gPiBwYXRjaCBsaW5rOsKgwqDCoCBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIw
MjMwNTE3LWdlbmtleS12MS0xLWI4ODc0MjRkYTRhOCU0MGdvb2dsZS5jb20NCj4gPiBwYXRjaCBz
dWJqZWN0OiBbUEFUQ0hdIGNlcnRzOiBidWZmZXIgc3RkZXJyIGZyb20gb3BlbnNzbCB1bmxlc3Mg
ZXJyb3INCj4gPiBjb25maWc6IGNza3ktcmFuZGNvbmZpZy1tMDQxLTIwMjMwNTE3DQo+ID4gY29t
cGlsZXI6IGNza3ktbGludXgtZ2NjIChHQ0MpIDEyLjEuMA0KPiA+IHJlcHJvZHVjZSAodGhpcyBp
cyBhIFc9MSBidWlsZCk6DQo+ID4gwqDCoMKgwqDCoMKgwqAgd2dldCBodHRwczovL3Jhdy5naXRo
dWJ1c2VyY29udGVudC5jb20vaW50ZWwvbGtwLXRlc3RzL21hc3Rlci9zYmluL21ha2UuY3Jvc3PC
oC1PIH4vYmluL21ha2UuY3Jvc3MNCj4gDQo+IF4gc2hvdWxkIGVuY291cmFnZSBgbWtkaXIgfi9i
aW5gOyB0aGUgZGViaWFuIGRvY2tlciBjb250YWluZXIgZG9lc24ndA0KPiBoYXZlIGB+L2JpbmAu
DQo+IA0KPiA+IMKgwqDCoMKgwqDCoMKgIGNobW9kICt4IH4vYmluL21ha2UuY3Jvc3MNCj4gPiDC
oMKgwqDCoMKgwqDCoCAjIGh0dHBzOi8vZ2l0aHViLmNvbS9pbnRlbC1sYWItbGtwL2xpbnV4L2Nv
bW1pdC8wZTQzN2E0MWZkYjQxYzg0ODM0ZGU2Nzc2YmYzODk1MWIxOTc3OTJhDQo+ID4gwqDCoMKg
wqDCoMKgwqAgZ2l0IHJlbW90ZSBhZGQgbGludXgtcmV2aWV3IGh0dHBzOi8vZ2l0aHViLmNvbS9p
bnRlbC1sYWItbGtwL2xpbnV4DQo+ID4gwqDCoMKgwqDCoMKgwqAgZ2l0IGZldGNoIC0tbm8tdGFn
cyBsaW51eC1yZXZpZXcgbmRlc2F1bG5pZXJzLWdvb2dsZS1jb20vY2VydHMtYnVmZmVyLXN0ZGVy
ci1mcm9tLW9wZW5zc2wtdW5sZXNzLWVycm9yLzIwMjMwNTE4LTAwNDc1Mw0KPiANCj4gXiBob2x5
IGNyYXAgdGhhdCB0YWtlcyBmb3JldmVyLiBtYXliZSByZWNvbW1lbmQgYGI0IHNoYXphbSA8bG9y
ZSBsaW5rPmA/DQo+IA0KPiA+IMKgwqDCoMKgwqDCoMKgIGdpdCBjaGVja291dCAwZTQzN2E0MWZk
YjQxYzg0ODM0ZGU2Nzc2YmYzODk1MWIxOTc3OTJhDQo+ID4gwqDCoMKgwqDCoMKgwqAgIyBzYXZl
IHRoZSBjb25maWcgZmlsZQ0KPiA+IMKgwqDCoMKgwqDCoMKgIG1rZGlyIGJ1aWxkX2RpciAmJiBj
cCBjb25maWcgYnVpbGRfZGlyLy5jb25maWcNCj4gPiDCoMKgwqDCoMKgwqDCoCBDT01QSUxFUl9J
TlNUQUxMX1BBVEg9JEhPTUUvMGRheSBDT01QSUxFUj1nY2MtMTIuMS4wIG1ha2UuY3Jvc3MgVz0x
IE89YnVpbGRfZGlyIEFSQ0g9Y3NreSBvbGRkZWZjb25maWcNCj4gDQo+IF4gc2hvdWxkIHVzZSBg
fi9iaW4vbWFrZS5jcm9zc2Agc2luY2UgYH4vYmluYCBtYXkgbm90IGV4aXN0IGluICRQQVRILg0K
PiANCj4gPiDCoMKgwqDCoMKgwqDCoCBDT01QSUxFUl9JTlNUQUxMX1BBVEg9JEhPTUUvMGRheSBD
T01QSUxFUj1nY2MtMTIuMS4wIG1ha2UuY3Jvc3MgVz0xIE89YnVpbGRfZGlyIEFSQ0g9Y3NreSBT
SEVMTD0vYmluL2Jhc2gNCg0KV2UndmUgdXBkYXRlZCB0aGUgInJlcHJvZHVjZSIgc2VjdGlvbiBp
biBib3QncyByZXBvcnRzIHRvIGJlIG1vcmUNCnByZWNpc2UuIFRoYW5rcyBhIGxvdCBmb3IgdGhl
IGlucHV0cy4NCg0KPiBIaSBQaGlsaXAsDQo+IEkndmUgcnVuIGludG8gc29tZSBpc3N1ZXMgd2l0
aCBtYWtlLmNyb3NzIHdoZW4gdHJ5aW5nIHRvIGluc3RhbGwgdGhlDQo+IGNza3kgdG9vbGNoYWlu
LiBNYXliZSB5b3UgY2FuIGhlbHA/DQo+IA0KPiBgYGANCj4gJCBDT01QSUxFUl9JTlNUQUxMX1BB
VEg9JEhPTUUvMGRheSBDT01QSUxFUj1nY2MtMTIuMS4wDQo+IH4vYmluL21ha2UuY3Jvc3MgVz0x
IE89YnVpbGRfZGlyIEFSQ0g9Y3NreSBvbGRkZWZjb25maWcNCj4gQ29tcGlsZXIgd2lsbCBiZSBp
bnN0YWxsZWQgaW4gL3Jvb3QvMGRheQ0KPiBtYWtlOiBnY2M6IE5vIHN1Y2ggZmlsZSBvciBkaXJl
Y3RvcnkNCj4gbGZ0cGdldCAtYyBodHRwczovL2Rvd25sb2FkLjAxLm9yZy8wZGF5LWNpL2Nyb3Nz
LXBhY2thZ2UvLi9nY2MtMTIuMS4wLW5vbGliYy94ODZfNjQtZ2NjLTEyLjEuMC1ub2xpYmNfY3Nr
eS1saW51eC50YXIueHoNCj4gL2xpbnV4DQo+IHRhciBKeGYgL3Jvb3QvMGRheS9nY2MtMTIuMS4w
LW5vbGliYy94ODZfNjQtZ2NjLTEyLjEuMC1ub2xpYmNfY3NreS1saW51eC50YXIueHoNCj4gLUMg
L3Jvb3QvMGRheQ0KPiBQbGVhc2UgdXBkYXRlOiBsaWJjNiBvciBnbGliYw0KPiBsZGQgL3Jvb3Qv
MGRheS9nY2MtMTIuMS4wLW5vbGliYy9jc2t5LWxpbnV4L2Jpbi9jc2t5LWxpbnV4LWdjYw0KPiAv
cm9vdC8wZGF5L2djYy0xMi4xLjAtbm9saWJjL2Nza3ktbGludXgvYmluL2Nza3ktbGludXgtZ2Nj
Og0KPiAvbGliL3g4Nl82NC1saW51eC1nbnUvbGliYy5zby42OiB2ZXJzaW9uIGBHTElCQ18yLjMy
JyBub3QgZm91bmQNCj4gKHJlcXVpcmVkIGJ5IC9yb290LzBkYXkvZ2NjLTEyLjEuMC1ub2xpYmMv
Y3NreS1saW51eC9iaW4vY3NreS1saW51eC1nY2MpDQo+IC9yb290LzBkYXkvZ2NjLTEyLjEuMC1u
b2xpYmMvY3NreS1saW51eC9iaW4vY3NreS1saW51eC1nY2M6DQo+IC9saWIveDg2XzY0LWxpbnV4
LWdudS9saWJjLnNvLjY6IHZlcnNpb24gYEdMSUJDXzIuMzMnIG5vdCBmb3VuZA0KPiAocmVxdWly
ZWQgYnkgL3Jvb3QvMGRheS9nY2MtMTIuMS4wLW5vbGliYy9jc2t5LWxpbnV4L2Jpbi9jc2t5LWxp
bnV4LWdjYykNCj4gc2V0dXBfY3Jvc3N0b29sIGZhaWxlZA0KPiANCj4gJCBsZGQgLXYgL2xpYi94
ODZfNjQtbGludXgtZ251L2xpYmMuc28uNg0KPiAvbGliNjQvbGQtbGludXgteDg2LTY0LnNvLjIg
KDB4MDAwMDdmMTFmMzQ3ODAwMCkNCj4gbGludXgtdmRzby5zby4xICgweDAwMDA3ZmZjZjQ1YjIw
MDApDQo+IA0KPiBWZXJzaW9uIGluZm9ybWF0aW9uOg0KPiAvbGliL3g4Nl82NC1saW51eC1nbnUv
bGliYy5zby42Og0KPiBsZC1saW51eC14ODYtNjQuc28uMiAoR0xJQkNfMi4zKSA9PiAvbGliNjQv
bGQtbGludXgteDg2LTY0LnNvLjINCj4gbGQtbGludXgteDg2LTY0LnNvLjIgKEdMSUJDX1BSSVZB
VEUpID0+IC9saWI2NC9sZC1saW51eC14ODYtNjQuc28uMg0KPiANCj4gJCBjYXQgL2V0Yy9kZWJp
YW5fdmVyc2lvbg0KPiAxMS42DQo+IGBgYA0KPiBQZXJoYXBzIEkgTVVTVCB1cGRhdGUgbXkgZGVi
aWFuIGNvbnRhaW5lciB0byAxMS43Pw0KPiANCj4gQXJlIHRoZSAwZGF5IHRvb2xjaGFpbnMgbm90
IHN0YXRpY2FsbHkgbGlua2VkPw0KPiBDYW4gdGhleSB1c2UgdGhlIG9uZXMgZnJvbSBrZXJuZWwu
b3JnIHdoaWNoIGFyZT8NCj4gaHR0cHM6Ly9taXJyb3JzLmVkZ2Uua2VybmVsLm9yZy9wdWIvdG9v
bHMvY3Jvc3N0b29sLw0KDQpQbGVhc2UgZm9sbG93IGJlbG93IHN0ZXBzIHRvIHVzZSB0aGUgdG9v
bGNoYWlucyBwcm92aWRlZCBieSBrZXJuZWwub3JnLg0KV2UndmUgdGVzdGVkIHRoaXMgYW5kIGl0
IGNhbiB3b3JrIGluIGEgZGViaWFuIDExLjYgZG9ja2VyIGVudi4NCg0KJCBjYXQgL2V0Yy9kZWJp
YW5fdmVyc2lvbiANCjExLjYNCg0KJCBsZGQgLXYgL2xpYi94ODZfNjQtbGludXgtZ251L2xpYmMu
c28uNiB8IGdyZXAgR0xJQkMNCgkJbGQtbGludXgteDg2LTY0LnNvLjIgKEdMSUJDXzIuMykgPT4g
L2xpYjY0L2xkLWxpbnV4LXg4Ni02NC5zby4yDQoJCWxkLWxpbnV4LXg4Ni02NC5zby4yIChHTElC
Q19QUklWQVRFKSA9PiAvbGliNjQvbGQtbGludXgteDg2LTY0LnNvLjINCg0KJCBleHBvcnQgVVJM
PWh0dHBzOi8vbWlycm9ycy5lZGdlLmtlcm5lbC5vcmcvcHViL3Rvb2xzL2Nyb3NzdG9vbC9maWxl
cy9iaW4veDg2XzY0DQoNCiQgQ09NUElMRVJfSU5TVEFMTF9QQVRIPSRIT01FLzBkYXkgQ09NUElM
RVI9Z2NjLTEyLjEuMCAuL21ha2UuY3Jvc3MgVz0xIEFSQ0g9Y3NreSBvbGRkZWZjb25maWcNCkNv
bXBpbGVyIHdpbGwgYmUgaW5zdGFsbGVkIGluIC9yb290LzBkYXkNCmxmdHBnZXQgLWMgaHR0cHM6
Ly9taXJyb3JzLmVkZ2Uua2VybmVsLm9yZy9wdWIvdG9vbHMvY3Jvc3N0b29sL2ZpbGVzL2Jpbi94
ODZfNjQvLi8xMi4xLjAveDg2XzY0LWdjYy0xMi4xLjAtbm9saWJjLWNza3ktbGludXgudGFyLnh6
DQovcm9vdC9saW51eCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQp0YXIgSnhmIC9y
b290LzBkYXkvMTIuMS4wL3g4Nl82NC1nY2MtMTIuMS4wLW5vbGliYy1jc2t5LWxpbnV4LnRhci54
eiAtQyAvcm9vdC8wZGF5DQptYWtlIC0ta2VlcC1nb2luZyBDT05GSUdfT0ZfQUxMX0RUQlM9eSBD
T05GSUdfRFRDPXkgQ1JPU1NfQ09NUElMRT0vcm9vdC8wZGF5L2djYy0xMi4xLjAtbm9saWJjL2Nz
a3ktbGludXgvYmluL2Nza3ktbGludXgtIC0tam9icz0xNDQgVz0xIEFSQ0g9Y3NreSBvbGRkZWZj
b25maWcNCi4uLg0KDQoNClRoYW5rcyBhIGxvdCBmb3IgdGhlIHN1Z2dlc3Rpb25zLiBXZSB3aWxs
IGZ1cnRoZXIgaW1wcm92ZSB0aGUgMGRheQ0KbWFrZS5jcm9zcyB0b29sIHN1Y2ggYXM6DQoNCiog
UHJvdmlkZSBzdGF0aWNhbGx5IGxpbmtlZCB0b29sY2hhaW5zIHRoYXQgZG9uJ3QgZGVwZW5kIG9u
IHRoZSBsaWJjIGluDQp0aGUgZGlzdHJpYnV0aW9uDQoqIEFkZCBoaW50IHRvIGhlbHAgdXNlciBk
ZWNpZGUgd2hldGhlciB0byB1c2UgMGRheSBvciBrZXJuZWwub3JnDQp0b29sY2hhaW5zLg0KDQpC
ZXN0IFJlZ2FyZHMsDQpZdWppZQ0KDQo+ID4gDQo+ID4gSWYgeW91IGZpeCB0aGUgaXNzdWUsIGtp
bmRseSBhZGQgZm9sbG93aW5nIHRhZyB3aGVyZSBhcHBsaWNhYmxlDQo+ID4gPiBSZXBvcnRlZC1i
eToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+ID4gPiBDbG9zZXM6IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL29lLWtidWlsZC1hbGwvMjAyMzA1MTgxNzEyLnhqdnYxZmJELWxr
cEBpbnRlbC5jb20vDQo+ID4gDQo+ID4gQWxsIGVycm9ycyAobmV3IG9uZXMgcHJlZml4ZWQgYnkg
Pj4pOg0KPiA+IA0KPiA+IMKgwqAgQXQgbWFpbi5jOjE1MjoNCj4gPiDCoMKgIC0gU1NMIGVycm9y
OkZGRkZGRkZGODAwMDAwMDI6c3lzdGVtIGxpYnJhcnk6Ok5vIHN1Y2ggZmlsZSBvciBkaXJlY3Rv
cnk6IC4uL2NyeXB0by9iaW8vYnNzX2ZpbGUuYzo2Nw0KPiA+IMKgwqAgLSBTU0wgZXJyb3I6MTAw
MDAwODA6QklPIHJvdXRpbmVzOjpubyBzdWNoIGZpbGU6IC4uL2NyeXB0by9iaW8vYnNzX2ZpbGUu
Yzo3NQ0KPiA+ID4gPiBleHRyYWN0LWNlcnQ6IGNlcnRzL3NpZ25pbmdfa2V5LnBlbTogTm8gc3Vj
aCBmaWxlIG9yIGRpcmVjdG9yeQ0KPiA+IA0KPiA+IC0tDQo+ID4gMC1EQVkgQ0kgS2VybmVsIFRl
c3QgU2VydmljZQ0KPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9pbnRlbC9sa3AtdGVzdHMvd2lraQ0K
PiANCj4gDQo+IA0KDQo=
