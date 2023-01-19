Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B842D673BA8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjASOZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjASOZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:25:48 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C82E359B;
        Thu, 19 Jan 2023 06:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674138347; x=1705674347;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RQkbRxuHH+KKRb4qAybpJVi3iqXFBApsr+lX/PXNQIU=;
  b=jrIH2ViCKSxb5ckFbV7Zl+PcJ/zXmqYeAsnN7mdivn2+1nUz/yjFeUTH
   JpJYH9hBj9R2NmMRare0PBFWpCkkJ1dKnsca+nAjbLGI+yBCuMQdupq4Q
   7D7lB1ijcc3ZN8jSOOynbssnsIukc5X0hFIl1YsidI32iW53ShGkYsAuO
   +z4tpWxyTg+PYU7r/qwCvGJULuTV0Joj1vbCOlqfcxhbhuZAWSCC6D6si
   6J0LjOGJnNhpXwrgxqNORE+tvhFjJLXixfbYRudfIJ9aL+KwgGpTNmonF
   JcQQPVRE3GUcIznxcwVucay0M0XR/5FSbXiGTj6EPu2WxBIQE6cPFiWTe
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="313173687"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="313173687"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 06:09:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="748928221"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="748928221"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Jan 2023 06:09:21 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 06:09:21 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 06:09:20 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 19 Jan 2023 06:09:20 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 19 Jan 2023 06:09:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocT8b8KSgKNGb0owvHTQfjmCIPRzDWFYn0yvxUmnxObCqyVItDtBOUk8a02whBhswZf3UyhODoTLrgF6RqT3kTmftluufreGoOxOTc1qpN7ETYHi89gTPpQ0x7uGWEA8WD7AFnHYk6VYU0yIIgUX6r9UYBdIbs1COiVCWeVxc98uBH+p3lebQqVrUkWysfqA6PvYp5ft65YeVzMxujdM9bdEmuZqQJvV+qruDXfqXWcKSc764xiEhAOCOYD47JE25kuFj0PU5NZ/G0Pjo1/V+yP4ptbxkg15hvZEi/6MAqj+2H3lwNqfit2lZpbpihFm71yMH4giXCsYO/nzpIQrHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQkbRxuHH+KKRb4qAybpJVi3iqXFBApsr+lX/PXNQIU=;
 b=VWtPIyWQSZtkDR7nxpvC4bgaM2I6rBt7otjJH2ncZo97YAoacyLoN2JxJsBWDOjLqWQxm8rEsPe4Lew1iXGbTfl0AOLpoG9EnN7i+VA6z8YWz++/GMolGD8Ox96hzIFxSiqk/GoIuIvcbLUIaZ1GZ3PLggfAds1UUEt636xhztecMc2qfve9k6/IEkTNHtwCi7NjFb32jRZ54ZX7e0LCThcSBZBFaBxlwDFNQsdP3cFYUOgf7n2RB3hfthQ7Is47ELN9X9bA7Nrp2SRd4OBnfpkO56eLfgtJRWSubJ7gbTJd/aP7GM5ir+H18lLfNX6Kp5iF5e3BW11NcIuZ6IZ8rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8)
 by BL1PR11MB5477.namprd11.prod.outlook.com (2603:10b6:208:31f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 19 Jan
 2023 14:09:18 +0000
Received: from MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::1c42:3e93:5a97:a280]) by MN0PR11MB5987.namprd11.prod.outlook.com
 ([fe80::1c42:3e93:5a97:a280%5]) with mapi id 15.20.6002.013; Thu, 19 Jan 2023
 14:09:18 +0000
From:   "Greenman, Gregory" <gregory.greenman@intel.com>
To:     "chiluk@ubuntu.com" <chiluk@ubuntu.com>
CC:     "regressions@leemhuis.info" <regressions@leemhuis.info>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Coelho, Luciano" <luciano.coelho@intel.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>
Subject: Re: [regression] Bug 216753 - 6e 6 ghz bands are disabled since 5.16
 on intel ax211
Thread-Topic: [regression] Bug 216753 - 6e 6 ghz bands are disabled since 5.16
 on intel ax211
Thread-Index: AQHZH5oVr1pMlqTWAEqPlNzN20DJJK6PeNqAgAIRooCAFFWGgA==
Date:   Thu, 19 Jan 2023 14:09:18 +0000
Message-ID: <bc0b159321826c0336f074ca23244fc0cde507f2.camel@intel.com>
References: <14722778-dda0-cb9f-8647-892493d94a5c@leemhuis.info>
         <2026016246ef719605c9932feeb56b105833593b.camel@intel.com>
         <CAMfi-DTwX2nvP58FRb6NaGMyWO0SBo9W=Fpdtr=XfNRzkqAwHw@mail.gmail.com>
         <b5e9c8911a46802ddb017554f266c92a7a0b2605.camel@intel.com>
         <CAMfi-DQYU3WQk8x-GFieexEE_enRDe4J0AzyZHk9rtRykpUEnA@mail.gmail.com>
In-Reply-To: <CAMfi-DQYU3WQk8x-GFieexEE_enRDe4J0AzyZHk9rtRykpUEnA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5987:EE_|BL1PR11MB5477:EE_
x-ms-office365-filtering-correlation-id: a22d5ac8-ee15-4a6a-0125-08dafa26c163
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Nh8qei6Fm5rMUn58my1VR4nQ9/UlcS0HB6LwNYJbqpISwG2Ks9oE7eyFiviJ/rWUTKYZ9zG35pBgzeglCcVN53HsfJlo1uo/GiJyvr5lvuK8irg91A0olOHKXltWdy3rNiJfJjn6tOiTDHgIpKINTSWXhBV7wq/XIEFzkkMRWBSPi8gYsDiZpKoR9yTypLywmJRXZNsVKTxTgH8xnEB+VTgnrH+xKiSLgp7sP0RD4JtC9j5Ql179VM2Ecn/kBOg6qRVruRfUmjYIT2IflYvSWMSmH0IEjdrkaDhoD0s3fU1wycxOJ4SEQLDQYRDMpWUrihuaIw9xMrw3971mjkEKUb/RYDvNNP2kS/arzLalxofox1au5/qs5See9QRobMGlzLw2pWHoGFOi2nX/6hZoSBjKF8BgWqPQMffjut1g88m7Fg86mQsqcB6I+klFbHmeTFVL0rTMV+LxoeaTGTE4C+WCnRY0X2yGHHJa8PXu6JbTd5V9KPBWxybd6Q7AJkJESMrrBsUVBmKY5dnNSieNfRhgvJ0zYI2YogQsVyzlsEi3b7PBYgdDHKDoT0Vt//CwFUfwzaq6PNibudKJhRuKzTIQJLsMwi5dVeb2iLYungBfOUEBJm82TXq76JGBu4hgBZKuO6WeZVv0fZGhLRdyPCQnZJJHZ0WIA5asuTcCGfCyp7H1vHYzzjKQCmAzE79qRoiRQcUdN3dYlcXRx1+DA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5987.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199015)(82960400001)(122000001)(38100700002)(66946007)(38070700005)(2906002)(76116006)(66476007)(5660300002)(8936002)(91956017)(66556008)(64756008)(8676002)(6916009)(4326008)(41300700001)(2616005)(26005)(6512007)(186003)(66446008)(83380400001)(53546011)(54906003)(71200400001)(86362001)(478600001)(36756003)(6486002)(316002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2EwR3VjcGNxU1lQdEMyMDFua21uRTd0QkM0dUNzUTB5a09VR2ZWS3U0d1Bk?=
 =?utf-8?B?NEhYRzNnUEdjUWJkTitHUDNKM3VzWDdHM3VPQVhXUll0MzVuTjhHTk1vYjNM?=
 =?utf-8?B?RnhpalIrcWxXbmZjeFhZUnVUU05aamNmbDRqdXYwR25nQXhOQTBFbkY1WFBK?=
 =?utf-8?B?cXNjSWJSVzYrSnRCcmx5dHEvaDhOSWxtNjAzYWh1S3dTamRPNGpXMm8zd1ZO?=
 =?utf-8?B?M2orNzEyVzdaY3UyK2lxSGRVVDZMTHFWV1huYmY0MGFjOXY2SExrRGIxeDRY?=
 =?utf-8?B?RUxNVWluRkY0STl3cGN4OHEwRVZKVTZZMEU4OFE2NERuRHRPblRyb0tWTldS?=
 =?utf-8?B?YjhXSm95VDhVWThzc1Z4SjM5WlFvQUFUakRDZWhKR2o0Qm1NMU1XRStpODRQ?=
 =?utf-8?B?YXlDU2ZneFNTRXlhdXBWUWMyS2M0SU9pUnpHUmxUeC8rWG1Najk1V3dRWjU3?=
 =?utf-8?B?WGtpRHcxL2syM1ZrWlBpM3B6VWRFUTJJRDVUSFQxTEtLQ0VCYjROMkM0RzBX?=
 =?utf-8?B?Zk1hM0tFU3V5b0lwUnc2MWphTTZ2TDJabjNvVHRFUjdWeXZKUFlnMUFwWGRR?=
 =?utf-8?B?WDU5WkRQclpQMVJyQ0NNa3ViZlJndSt5RkNvRXUvek9BMDgyVjVmaVIyTEZO?=
 =?utf-8?B?OGlpWTM4RkRTVmwwQ1Btc1ltQzhyc3AvMGtZT3ZFTVZJRUxBcWpKY2c2cVdK?=
 =?utf-8?B?dGdZamJhdW1uQmEvNVQ5UDZOb2V1aC9DVnN3MG1HeCszbjRtQ25uQXd6ZTAr?=
 =?utf-8?B?WDRidnl0dzBMeVdlNVpXblRJMHBEcHZiTHV0ekg3bEtSTDI0TERyeHg1MFZm?=
 =?utf-8?B?R1ZOMkM0WHR0Tm8xVWE2Nm1LYmErQTNLclczWEtVaVpWcnlFYmhmcFlTVUd6?=
 =?utf-8?B?Zm4xajRNVDRpQTFrWmU5QllHcFNFcjBPM0VwdFZZZFFtdmthTUh0d3VrSVh2?=
 =?utf-8?B?VEVlWXhkQVRyODFObWpibUVweWRraGk2dXFqSXlwRk1FRDNnbXEzMnM3MlQ1?=
 =?utf-8?B?VFFhZVNYMEp4dnk3dHgwYjBjYnRYOW9MUlcxMjZJMmNZSWFoRS96aVBKWU0x?=
 =?utf-8?B?NDcrUE03aTh4KzY1MkJQa2ErKzdqdHBDdnJKV0pXVXl2SUdjSkZyZTloQVg2?=
 =?utf-8?B?b3dWNHZlWmNtMmZ6b0Q2RDFuQ2FrSTFpc1VoYXNUUFFqem45QTVyT2t5TmNZ?=
 =?utf-8?B?L1g2ZXI3VHZZYTNDendWUmFlQmp1MTBLdCtKZEQxYlluOXNqUWVRM1RBeStv?=
 =?utf-8?B?dGIranpGQmROalp1dG9aNTE1SlhiZGtQVDZ5cWU2ZkhvWXZVMGlyWXFMSnZt?=
 =?utf-8?B?TjRzRlA2YXVrWEswTzh5STEvcldwVVl2YUxuY0h1U3A2UW5FRXhLa2VaRVJB?=
 =?utf-8?B?Q1N4OWtHZkpMZjAvL29lQWhxT1FRRjR6NG9mSXh3aUpNRFhsazdsbWNrbC8z?=
 =?utf-8?B?dlBUcjdRUi96NGVheWk2TG1sWHhEWWpoMU9xZ2RIY0pWcHpxVXp5eEtSdE1F?=
 =?utf-8?B?cVZENWVvb0RicWNlYmVMa0kxN0JDUkJabkdscFozamZwSlh2RHhwRk84SVQx?=
 =?utf-8?B?dXZYMTdFdmVtODNjOUpRMGRvdUVpelJNMXJLaHQwdEJjTmZiNklJbldFL1Bo?=
 =?utf-8?B?TVc4Rmh4VXBWS1p3QitFUHdLNGErK3d3MWdqWmlaaStHdFV3ZGtRd0xkckd0?=
 =?utf-8?B?c3oySlFPNDlIcVExK09MM0dxclNod2tzVnU2U3liYnloeFd5ejdCelg1SmZr?=
 =?utf-8?B?bWUzV0FvSkdIN0Rab3N4UWFOQS9jdFM4c3VwZHRGZ00wUU5OeEVTdHVPN3ln?=
 =?utf-8?B?c3NrY3V4cEg1VnByZHZZSEFHSE1CaXowZkFpUWpwTHVMUkVJdmgyV1FNZkpZ?=
 =?utf-8?B?b044QmFGWS9hdm5YblJtWGFGUjl6bWVheUhMd00rYjh4cFByZjlGdlY1U090?=
 =?utf-8?B?N1FXR1VxNlVNQjR6Z2pXVllGaW5yTUptektqb1RNbHgxdGpObGU5NlZOMWpO?=
 =?utf-8?B?M2ZlU3grQisrTWx1c3BWNDJFQVpmOEt5Vi81eFl4bzd3eGZqaG1rdG5MaG9M?=
 =?utf-8?B?ZlljS3g2VkQwdm92bTk4N1d0NzhkYlNZbmNFQjA2RUhjZFk5aUhpbDRmU1RR?=
 =?utf-8?B?Tm5PWVVGWDdzck5VZDk0TVgxRzRzNnY5QllpTDNNckZzTVNVMVJ2a2twK0xy?=
 =?utf-8?Q?QinrLXA8iAuALidYPUwq5Tw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D55C1EA7D73E4748A8B4020182BCDEEA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a22d5ac8-ee15-4a6a-0125-08dafa26c163
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 14:09:18.6382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YiXgbvVdtQrIEWtqMbGW7THun6QXvPhTS2htJHmgbFv2G1UPOiWjIZX8GI7h2U59Qu+LiQ7qAEgwNO/UsV9e6FxYnTTf8mM6V9ncPfrAf6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5477
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

T24gRnJpLCAyMDIzLTAxLTA2IGF0IDA5OjM3IC0wNjAwLCBEYXZlIENoaWx1ayB3cm90ZToNCj4g
T24gVGh1LCBKYW4gNSwgMjAyMyBhdCAxMjoxNSBBTSBHcmVlbm1hbiwgR3JlZ29yeQ0KPiA8Z3Jl
Z29yeS5ncmVlbm1hbkBpbnRlbC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IEknbGwgdHJ5IHRvIGV4
cGxhaW4sIHRoZSBwcm9ibGVtIGhlcmUgaXMgbm90IHRlY2huaWNhbC4gQWZ0ZXIgc29tZQ0KPiA+
IGludGVybmFsIGNoZWNrcywgaXQgYXBwZWFycyB0aGF0IHdlICh3aWZpIGRyaXZlcikgYXJlbid0
IGFsbG93ZWQgdG8NCj4gPiBkZWNpZGUgaWYgNkUgc2hvdWxkIGJlIGVuYWJsZWQgb3Igbm90LiBC
ZWNhdXNlIG9mIHRoZSBsZWdhbCByZXN0cmljdGlvbnMsDQo+ID4gT0VNIHNob3VsZCBtYWtlIHRo
aXMgZGVjaXNpb24gYW5kIGVuYWJsZS9kaXNhYmxlIDZFIGluIHRoZSBCSU9TLiBUaGlzDQo+ID4g
Y29tbWl0IG9ubHkgZ2V0cyB0aGUgdmFsdWUgZnJvbSB0aGUgQklPUyBhbmQgY29uZmlndXJlcyB0
aGUgZmlybXdhcmUNCj4gPiBhY2NvcmRpbmdseS4gU28sIHVuZm9ydHVuYXRlbHksIGxlZ2FsIHJl
c3RyaWN0aW9uIGlzIHRoZSByZWFzb24gd2UgY2Fubm90DQo+ID4gcmV2ZXJ0L292ZXJ3cml0ZSA2
RSBlbmFibGVtZW50Li4uDQo+ID4gDQo+IFRoYW5rIHlvdSBHcmVnb3J5LCBJJ3ZlIGJlZW4gcmVh
ZGluZyBiZXR3ZWVuIHRoZSBsaW5lcywgYW5kIHRoaXMgaXMNCj4gcHJldHR5IG11Y2ggd2hhdCBJ
IGV4cGVjdGVkIHlvdSB0byBzYXkuwqAgU28gaW4gdGhlIHBhc3Qgd2hlbg0KPiBPRU1zL3N5c3Rl
bXMgbWFudWZhY3R1cmVycyBoYXZlIGJlZW4gaXJyZXNwb25zaWJsZS9pbmVwdCBsaWtlIHRoaXMg
d2UNCj4gaGF2ZSBpbXBsZW1lbnRlZCBmbGFncyB0byBmb3JjZSBpZ25vcmUgdGhlIHZhbHVlcyBj
b21pbmcgb3V0IG9mIHRoZQ0KPiBiaW9zLsKgIEFzIGl0J3Mgbm93IG9idmlvdXMgdGhhdCB0aGUg
cHJvYmxlbSBoZXJlIGlzIGEgbGVnYWwvcmVndWxhdG9yeQ0KPiBpc3N1ZSwgSSdkIGhvcGUgdGhh
dCBoYXZpbmcgYSBmb3JjZSBmbGFnIHdvdWxkIGJlIGFjY2VwdGFibGUgZnJvbSBhDQo+IHRoYXQg
cGVyc3BlY3RpdmUuwqAgSSdtIG5vIGxhd3llciwgYnV0IEkgZXhwZWN0IG9uY2UgYSB1c2VyIGRl
Y2lkZXMgdG8NCj4gZXhwbGljaXRseSBzZXQgYSBmb3JjZSBmbGFnIHRvIGlnbm9yZSB0aGUgYmlv
cyB2YWx1ZXMgSSdkIHN1c3BlY3QgdGhlDQo+IHJlc3BvbnNpYmlsaXR5IHdvdWxkIHNoaWZ0IGZy
b20gdGhlIG1hbnVmYWN0dXJlcnMgYW5kIGJhY2sgb250byB0aGUNCj4gdXNlci4NCj4gDQo+IFdv
dWxkIHN1Y2ggYSBwYXRjaCBiZSB0aGVvcmV0aWNhbGx5IGFjY2VwdGFibGU/wqAgSWYgc28gSSds
bCB3cml0ZSB1cCBhDQo+IHBhdGNoIHRvIGRvIHRoaXMgYW5kIHN1Ym1pdCBpdCBuZXh0IHdlZWsg
aG9wZWZ1bGx5Lg0KDQpTb3JyeSBmb3IgdGhlIGxvbmcgZGVsYXkuLi4NCldlIGxvb2tlZCBhdCBp
dCBhZ2FpbiBhbmQgdGhpcyBwYXJ0aWN1bGFyIHNjZW5hcmlvIGxvb2tzIG1vcmUgbGlrZSBzb21l
DQpidWcgbWF5YmUgaW4gdGhlIGZpcm13YXJlIHNpbmNlIGluIFVTIGl0IHNob3VsZCBiZSBlbmFi
bGVkIGJ5IGRlZmF1bHQuDQpDYW4gSSBhc2sgdG8gY29sbGVjdCBhIHRyYWNlLWNtZCBkdW1wIGZv
ciB0aGUgY2FzZSB3aGVuIGl0IGRvZXNuJ3QNCndvcmsgd2l0aCAiLWUgaXdsd2lmaSAtZSBtYWM4
MDIxMSAtZSBjZmc4MDIxMSAtZSBpd2x3aWZpX21zZyI/DQoNCg==
