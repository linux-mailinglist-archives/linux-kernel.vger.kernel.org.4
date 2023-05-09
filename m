Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424E36FBBDA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 02:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbjEIAKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 20:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjEIAK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 20:10:28 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3573449DA
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 17:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683591027; x=1715127027;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N5c7hwTlSuT+1GaP7HrvM4ffsLs9qQ4M8wiJL/9rk8s=;
  b=Q+zrEl0Db+8peYRFw7rUwiLp1jQ83yvAhtsZ8RBDrfXTq2/PshynK2po
   O6fPzs5Slgh14Yyv+C/f0ZNjaXBtBYLKSs3tiKY0cG3P3JyRMi3znAzPx
   jWg27HstiQ3YTlmB8e7Bt94o/TPI/Ue6yfZ09yetGjU2ZbT+l+/j0mFVW
   x6z1mM6mam8qAuMmAgiShT+5ZUbb1ff27/eWrDgh+Cps+LbU1SVG9Odjy
   l4l1U/GGbBQ9wUhYdFUuDsuC9lAyVAtO2MsGHv2AlbO6nRoM/W7K8K6YF
   9iHgJP8WX/cF5JCqA+kZSXb7C+5uuBxAgtx4U96W3loDdLujCA3NDQ0nI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="347243702"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="347243702"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 17:10:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="649073929"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="649073929"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 08 May 2023 17:10:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 17:10:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 17:10:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 8 May 2023 17:10:25 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 8 May 2023 17:10:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLsHt3L6I/w7qDvEhfYRhpEnhqGkqzEOCmzrYWj6sR/t4xXBmG4bwarDLemShEdmoKek7aHlDc2T7NohGTBxR0ltnXB3doogrPA6mJAY79dSbjLGBcmPi/EPDVXXV/afXPCAoRkXGQgzMqeZeKCvVUI9rT0TPMT6T0zzADzAmdcnL1EmcUIfyqf4xm5bE+dU1y867x1TL/9t6DLTaOdIlwO/YxqMzWcazxTh3X1zwYT9fDVHM0HDTVdU9kehi9KiFtBWqJexfgejfwjAfRwkjdJ+ki+26P9lDIuXwQZlXqpy7+LDgWbbuByiyC+HDtimYo4vlx7gFlHZMOaFHQs0iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5c7hwTlSuT+1GaP7HrvM4ffsLs9qQ4M8wiJL/9rk8s=;
 b=TmRCnkj7nU8qd6iREgRdgZ3DZ8ZUQZDBBTDIlllrFI+ZIsqI8p5mNjA4Bux2mdezN2qdq3Tt0GDjv0BXV3CKQxUz4u12QBeNWe5uPf7ZUKco7UWJX8oWMA7lKr2H8umSThhYj8DcUiI32PhSheiYPuhKaSjQUWJK8Ss+m1UV79+mmqsN/mqdhv50fLUqSEXnoYvCGrT3gL/m46eh1SRwG3+0Z0IHHyvDB5WI8f2hVWWlvA7ThgEwTrdWMNoWzIYxpwxZ4RII++TV8fxYmg5FMilRDmjitCIAUCACRLeKsYpuJms+3/ymmYhL9r68dK2LW/1B8QAIngEtKq3S6g7SVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5268.namprd11.prod.outlook.com (2603:10b6:610:e3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 00:10:18 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%8]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 00:10:18 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: RE: [PATCH] iommu: Add Kconfig help text for IOMMU_SVA
Thread-Topic: [PATCH] iommu: Add Kconfig help text for IOMMU_SVA
Thread-Index: AQHZgB56n/zP0H2ZUUWJMwAk+LMxWq9NYqsAgABrcoCAAVu+AIABbW4AgAAAlACAAAPEgIAABi2AgABugdA=
Date:   Tue, 9 May 2023 00:10:17 +0000
Message-ID: <BN9PR11MB52760853B80C76F1427284138C769@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230506133134.1492395-1-jacob.jun.pan@linux.intel.com>
 <CAHk-=wgUiAtiszwseM1p2fCJ+sC4XWQ+YN4TanFhUgvUqjr9Xw@mail.gmail.com>
 <20230506150741.2e3d2dcc@jacob-builder>
 <CAHk-=wjmOAQnqJF-pW=fzMXb_Rk_J_Oi4ESBLmVPhxwBK4xfGg@mail.gmail.com>
 <20230508094014.53913cf3@jacob-builder>
 <CAHk-=wgobPe0U=Sc-PH08vF-ZbG00KrzftEpQMQ=n0LLNn7y6A@mail.gmail.com>
 <ZFkpk8y8mUZuZjkV@nvidia.com>
 <CAHk-=wiv=Dm5diw2N-4Mx3k8iYWNfyvjzrQxB3JxVLC_7cuY+g@mail.gmail.com>
In-Reply-To: <CAHk-=wiv=Dm5diw2N-4Mx3k8iYWNfyvjzrQxB3JxVLC_7cuY+g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH0PR11MB5268:EE_
x-ms-office365-filtering-correlation-id: a538f95a-810b-4d44-924c-08db5021c539
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pBs7RsF3IFDMIMGDPP6MvYIle/kBUhBoY3LQsT5x7fl0Cffff/2jy9Vg8JSFUjib9NSmRSxh6gkuFBHguSKmf0hOWOwPBzBd3+Qcc+hwWWERe3s6qHAHytzSQXHkxUKAqmscdZ4+QM2cNYBXMuZ9iNlAt9UHly+j05YYy7HZ6vMxuSani6bMQXixRqVS4JD56MlHMgPM/tS8ql8lpkoTQtFQ7ptDM4icxf+FUzcCe+lJM82d44MGRWntvKVDdsZ4JM/fqcZ50Hs82aX2h0GveEouALqa6WipWDg1vziEFOT65SBmPzeiDMNXuEjI3bAaVhUUime2i9B3DmWVUfVq0stD4h0aG/R5QPstMKdJQNiHLYblHXy1CAE8Z7hfOaEbuNZP//JJAjV7M5knDk99wiJiokyFN92p79QJLpuQgaqaioWe0ao7CRdg/5hOltekPlfqVmkY6JFXFoRZF9kq7prauLDCDmhRt41Wq/Pp34mauen81flWS28W+aOf5j0ZOL+Pa9gMaJCi25ieSFKSE3lMgG/Mch4aEK5krxHe4JdG+kRIK5DhvWG2a/mcncGP+XsIpzTMhZ06mtJyI9DZpAfq7uIOl0v/Hjn7st57bWA+0Je5K2aGu1ykhWg6HiYP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199021)(66899021)(66556008)(66476007)(64756008)(478600001)(76116006)(4326008)(110136005)(7696005)(66946007)(316002)(54906003)(66446008)(86362001)(33656002)(83380400001)(53546011)(9686003)(26005)(6506007)(52536014)(7416002)(8936002)(41300700001)(2906002)(5660300002)(8676002)(55016003)(82960400001)(38070700005)(186003)(38100700002)(122000001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWhIUnJ2ZmQreFNkVStPeGZ0TTVCUVlkN0Zxd0dNRUcyYVVGZVRjNFN4MW9R?=
 =?utf-8?B?SGFtVmp3c3ZERDUvRE1kd29KOWFWbTU4cVJWZ1ZZRG91d0F2RWZ5ekNaaXlw?=
 =?utf-8?B?bmhLUHBLVjlzdlRGbHM4U0drWmF3anpmVk9pSjZMekxyQ2R4azZZd1htb2Fx?=
 =?utf-8?B?dWpITVJrUUZDLzFaWktIMXY0bXQvS1NhZnhRKzBYNFhVcmxhczJaSWM1S2Zv?=
 =?utf-8?B?YXgzT1UwNjdEZStVTzFHZGhYRGI5S2pZMW9aL1QxQnY1bHBrWHVsLzVQSHA3?=
 =?utf-8?B?Tmo1blpnbmxaQStyRVN4VE00eGRSdGJXdThndGQyblBMemxjZi82QkxZb1VG?=
 =?utf-8?B?ZGhnUUc1TXJkcnRzdEgvcEUwU2ZLVFRwRmU2SnVkc0tmSkJCcFBBZ3U4U1dZ?=
 =?utf-8?B?SGNoTCtVamRUTFdOaTIweDdndzdGRm1yZVRja0ZOVmxQbkNzVTBSTHV5WU03?=
 =?utf-8?B?aE1xWWswaU56Wm41cXdDQzVGUGViL0VkdXZNY1l1dksyQnhwNGxnVVpod0I3?=
 =?utf-8?B?WXZ3YUxoVE9aMG5SYTlydlRDT3dBZU9VQUtDNGpURSs4N0hmWjRPYkIzSi9i?=
 =?utf-8?B?L0h0QmJkZ2w5UWJUcEl3RXhTSUY3eGQxSitRZmRncmMyK2VUSGJBeE5GUHYr?=
 =?utf-8?B?WVNtUTRwVWV4aDhreVdZUC9PVnJKanBDK1hWNEVWQU1QYTZ0bVhLbjg0UHM4?=
 =?utf-8?B?ZUV5WEljcnFNQXBWcWZibm1lWUwyeDBJcmtTTVR5UXBycUV2Vm43WEJDZzdh?=
 =?utf-8?B?RFJEcElTWHFBdTNxSElkb2UzQW5hRmNiVEdlazNqUENlMUJISWJMdEp5dWdV?=
 =?utf-8?B?akw4bmNrVDYxYTRNTGxJZ1pnQ3JheFR6UmJXRWI2QldTaEtLVTFxSUQzNTY0?=
 =?utf-8?B?elZ2aUp5eGw3aGJaRnowU2QrVnFxMkpqQXBXMlZhaExJR0xhQ2doK3RoUTkz?=
 =?utf-8?B?QXNNcmRzalRpVnRpWXJGc1JjZE1UQmJrM3VrOElOUjNld1RSSWt2aVV5OGdi?=
 =?utf-8?B?QlcvK2VTQWJNUTdDd2tRbVBIV1FNT0x4NlZXT1RzNTNZT3loc3JLYTNIK2FY?=
 =?utf-8?B?aEdFL05nL3Y2REdlQ0tpY2lmWVNET3dsdTJRL3N5cnU0a3BXMnBDK283ZHpi?=
 =?utf-8?B?N1gzUEdDQ21yRzlkbktKR2tsV25uampGTVdadjBTbWZQU09sbHJ0RnRhWUE0?=
 =?utf-8?B?dnpONHlyZURpdkh0MWVkc1NCUWRLNVQ4MVRZWStodEdZQUdOb0VKYXQwKy9y?=
 =?utf-8?B?NVdFcTE1em1xb05ydFU5QWh4RUtoRytkbDhrZGlvaEVvYzBUL083Y2JxUlV2?=
 =?utf-8?B?aVBHaEFXeFhHYXArN1M2KzU4VFY5dW9vQnNZWjhHNmJGeE5TU0tjUEtRMjgy?=
 =?utf-8?B?MU5FRzR1NFE3eXZJRVpnNXJMSVd2OXpTZVNpdzMrSloyMm4xeUx3Y1FvUzB5?=
 =?utf-8?B?NjAyT1VmS3J6TFB3ZWNvc3RVbDErZ0xkNnZ3SkFsTExoZXNzakJmbHN4NFBq?=
 =?utf-8?B?T3kvME13MkdxcWNpR0x5NWFaRC9PQTdPUnhCeVRoK2tnaDI4VVVkU2VVZlhU?=
 =?utf-8?B?dUlxMUdUUFpuV0FXSWx2OENiU2V2NWgveS9jbEZwS3NQTFROMGNXNm42U2pM?=
 =?utf-8?B?Q0RBS2k2cklxc2ZRYTc0Q0hhdCtrWnowM25aMDVlRFZLaGRnNXBOOHFwTU9l?=
 =?utf-8?B?UDVOUVl1dUw2b2RKaFhyRmFrY2dBcFpEOTI0MDRaaTAxWUFGZ0dLMDRZeGh6?=
 =?utf-8?B?ZFR6TXpaTlY5Nm12Snd4KzVaVWlpaFlNdUwxRXZTQmhLQ2ZXR3dpbUtjUDY5?=
 =?utf-8?B?VzBNOGhaQU9nU1hoZmNkQys2THFCb2ZBSlJwWDFQT3lDNDFYWTN0ZE5vU3ov?=
 =?utf-8?B?T2Npd0RjaURObXZvdG5kVGREdEdPNkVPOVNFR2YrZ0c2bitLWVhVeXo0QkFT?=
 =?utf-8?B?ZzBWaVp5WGFzVmlJTlQvK01zczk0TFFhVlhyWmdpR2hjOEdycDdTK2lJcnJP?=
 =?utf-8?B?VmVHckdmVWVKbStNWkZBKzNUZ1VKMWNJczU3SGlhTHVXMUNDVzBPWitsTmNJ?=
 =?utf-8?B?UWZ1RFd6aW9DK24xV3RScHBDd29DT2ZSdzNhN0xKeFhZRkVvbmJoUnRtZGRn?=
 =?utf-8?Q?TdZiwtWKAhKVLtL29TDsh8+Hf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a538f95a-810b-4d44-924c-08db5021c539
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 00:10:17.5784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zCGzppv/t/L3vqqmJNbvywfjIB2Vxf23cFj4cESPC6Hwt44eJ43b7RDWyRujNv2t/ggM+iVpL4reSps/Y4sHbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5268
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+DQo+
IFNlbnQ6IFR1ZXNkYXksIE1heSA5LCAyMDIzIDE6MTggQU0NCj4gDQo+IE9uIE1vbiwgTWF5IDgs
IDIwMjMgYXQgOTo1NeKAr0FNIEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+IHdyb3Rl
Og0KPiA+DQo+ID4gQ09ORklHX0lPTU1VX01NX1BBU0lEIHBlcmhhcHM/IFNheXMgd2hhdCBpdCBk
b2VzIHdpdGhvdXQgYSBjbHVlDQo+IGFib3V0DQo+ID4gd2h5IGl0IGRvZXMgaXQuIHg4NiBhcmNo
IGNvZGUgY291bGQgc2VsZWN0IGl0IGlkZWFsbHk/DQo+IA0KPiBNYXliZSB3ZSBkb24ndCBldmVu
IG5lZWQgdGhlICJJT01NVSIgcGFydC4gSXQncyBhIGNvcmUgeDg2DQo+IGFyY2hpdGVjdHVyZSBm
ZWF0dXJlLiBNYXliZSBpdCB1c3VhbGx5IChhbHdheXM/KSBnZXRzIHVzZWQgd2l0aGluIHRoZQ0K
PiBmcmFtZXdvcmsgb2Ygc29tZSBJT01NVSB3b3JrLCBidXQgSSBndWVzcyBFTkNRQ01EIGNvdWxk
IGJlIHVzZWQgaW4NCj4gc29tZSBoYXJkd2lyZWQgd2F5IGV2ZW4gd2l0aG91dCB0aGF0IChpZSBp
cyBpdCBwb3NzaWJsZSB0byBoYXZlIGp1c3QNCj4gc29tZSAiYmFzaWMgUEFTSUQgc2V0IHVwIGJ5
IFZNTSBlbnZpcm9ubWVudCIgdGhpbmc/KQ0KDQpUaGlzIG1ha2VzIHNlbnNlIHRvIG1lLiBBdCBs
ZWFzdCB0aGF0IGlzIG9uZSBwb3NzaWJsZSB3YXkgaW4gY29uY2VwdCwNCnRob3VnaCB3ZSBkb24n
dCBoYXZlIHN1Y2ggZXhhbXBsZSBub3cuDQoNCj4gDQo+IEkgZG9uJ3QgYWN0dWFsbHkga25vdyB3
aG8gdXNlcyBpdCBhbmQgaG93LCBzbyBJJ20gcHJvYmFibHkgbm90IHRoZQ0KPiByaWdodCBwZXJz
b24gdG8gbmFtZSBpdCwgYnV0IGp1c3QgbG9va2luZyBhdCB0aGUgeDg2IGNvZGUgdGhhdCBzZXRz
DQo+IGl0LCB0aGUgUEFTSUQgY29kZSB0ZWNobmljYWxseSBoYXMgbm8gY29ubmVjdGlvbiB0byBh
bnkgaW9tbXUgY29kZSwNCj4gaXQncyBsaXRlcmFsbHkgYSBjb3JlIENQVSBmZWF0dXJlIHdpdGgg
YW4gTVNSIGFuZCBzb21lIG1hZ2ljIGZhdWx0aW5nDQo+IHRoaW5nLCBhbmQgc2VlbXMgdG8gYmUg
cG9zc2libHkgdXNhYmxlIGFzLWlzLg0KPiANCj4gVGhhdCBleGlzdGluZw0KPiANCj4gICAgICNp
ZmRlZiBDT05GSUdfSU9NTVVfU1ZBDQo+IA0KPiBpbiB0aGUgeDg2IHRyYXBzLmMgY29kZSBqdXN0
IGxvb2tzIG9kZCwgYW5kIG1ha2luZyBpdCBiZQ0KPiBDT05GSUdfSU9NTVVfTU1fUEFTSUQgc291
bmRzIGJldHRlciB0byBtZS4gSSdtIGp1c3Qgbm90IHN1cmUgYWJvdXQNCj4gdGhlDQo+ICJJT01N
VSIgcGFydCBlaXRoZXIuIEp1c3QgIk1NX1BBU0lEIj8NCj4gDQo+IFRoYXQgc2FpZCwgdGhlIGFy
bS1zbW11LXYzLXN2YS5jIGNvZGUgY2xlYXJseSAqYWxzbyogdXNlcyBwYXNpZCwNCj4gZXhjZXB0
IGl0IHNlZW1zIHRvIHJlYWxseSB3YW50IHRvIGNhbGwgaXQgInNzaWQiLg0KPiANCj4gU28gImhh
dmluZyBhIHBlci1tbSBBU0lEIGZvciBJTyIgaXMgY2xlYXJseSBhIGNvbW1vbiBmZWF0dXJlLiBC
dXQNCg0KWWVzLiBDdXJyZW50bHkgUEFTSUQgZm9yIG1tIGlzIGdsb2JhbGx5IGFsbG9jYXRlZCBz
byBlYWNoIG1tIGlzDQphc3NvY2lhdGVkIHdpdGggYSBzaW5nbGUgdW5pcXVlIHBhc2lkLiANCg0K
PiBuYW1pbmcgc2VlbXMgaGFyZCwgd2l0aCB4ODYgY2FsbGluZyBpdCBQQVNJRCwgYXJtNjQgc2Vl
bWluZ2x5IGNhbGxpbmcNCj4gaXQgIlNTSUQiLg0KPiANCj4gUmlnaHQgbm93IHRoZSBvbmx5IHVz
ZXIgKmRvZXMqIHNlZW0gdG8gYmUgdGhyb3VnaCB0aGUgSU9NTVUgU1ZBIGNvZGUsDQo+IGJ1dCB0
aGF0IG1heSBvciBtYXkgbm90IGJlIGZ1bmRhbWVudGFsLg0KPiANCj4gTm93LCAiU1NJRCIgaXMg
YSBjb21wbGV0ZWx5IGhvcnJpYmxlIG5hbWUsIGFzIEkgaW1tZWRpYXRlbHkgcmVhbGl6ZWQNCj4g
d2hlbiBJIHRyaWVkIHRvIGdvb2dsZSBmb3IgaXQuIFNvIGFybTY0IGlzIGp1c3Qgd3JvbmcsIGFu
ZCB3ZSdyZSBtb3N0DQo+IGRlZmluaXRlbHkgY29udGludWluZyB0byBjYWxsIGl0IFBBU0lELg0K
DQpXZSBoYXZlIHVuZGVyZ29uZSB0aGlzIG5hbWluZyBnYW1lIHdoZW4gZW5hYmxpbmcgU1ZBIGJl
Zm9yZS4NCg0KQXQgdGhhdCBwb2ludCBJT0FTSUQgd2FzIGNvbnNpZGVyZWQgYXMgYSBnZW5lcmlj
IHRlcm0gdG8gY292ZXIgYm90aA0KUENJIFBBU0lEIGFuZCBBUk0gc3BlY2lmaWMgU1NJRC4gQnV0
IGluIHRoZSBlbmQgUEFTSUQvSU9BU0lEIGFyZQ0Kc3RpbGwgbWl4ZWQgaW4gbWFueSBjb21tb24g
Y29kZS4NCg0KSU1ITyBzdGlja2luZyB3aXRoIFBBU0lEIHNob3VsZCBiZSBmaW5lLiANCg0KPiAN
Cj4gSSdkIGxlYW4gdG93YXJkcyBqdXN0ICJDT05GSUdfTU1fUEFTSUQiIG9yIHNvbWV0aGluZywg
YnV0IGF0IHNvbWUNCj4gcG9pbnQgdGhpcyBpcyBiaWtlc2hlZGRpbmcsIGFuZCBJIGRvbid0IGtu
b3cgYWJvdXQgYW55IHBvc3NpYmxlDQo+IG5vbi1pb21tdSBkaXJlY3QgdXNlcz8NCj4gDQoNCkkg
YWdyZWUgdGhhdCBDT05GSUdfTU1fUEFTSUQgaXMgbW9yZSBhY2N1cmF0ZSBpbiBkZWZpbml0aW9u
Lg0K
