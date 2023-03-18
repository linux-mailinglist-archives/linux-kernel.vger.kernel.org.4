Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B7D6BF8DF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 09:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjCRIPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 04:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCRIPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 04:15:09 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574442F063
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 01:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679127308; x=1710663308;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1ro2WTX9ubbxU6tJ8fNauy+l3r5iq7nIqu5RJdE5Yu4=;
  b=Ou3eQjpUttyNaB3kxzE78rnqh5Q5UxLCjCMD7MdZT2kMgWCct85UUJbL
   uwfQk5CY0JTNrAFYgmOB2feeixcoAf244oD7QGR//Z+nkQMWSdUrH4fKw
   a+mXDi1198YoC1Ygq+SaGYpmkIR/TD0NvRGZcFQ43VCRR99vpkmmFWNAP
   amSyDL+Pi8B7RhleAIDRfd++0y2nvNnBiVoSwvAEDvEOklCUizi9VLC33
   zh8fQpyEFv+WUYyr4sBSSpLc/Z/KzsNVq4Q5/NEk01MT3wg+8cXB+oHyx
   d/1GX6HUchX7V4/MKcVZ9eXkTFlfCDoTGfKyv0Ip1IRRzQBpuzDa3QLB6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="338437337"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="338437337"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 01:15:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="769633750"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="769633750"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Mar 2023 01:15:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 18 Mar 2023 01:15:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 18 Mar 2023 01:15:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sat, 18 Mar 2023 01:15:06 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sat, 18 Mar 2023 01:15:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E938WEaWS97hE+7MYpO3In0p3FRhHZacLzcrfTYaiYn89ttnaIKpHGUCSWcTWqOSNDy6aGFNqz03rgLha2buFXQJIxnqlacRwEBWqBzz1i41YOXlOmrCBy4wKi06FHj8w/IS/pRe9Q6CDUk1OiqE4fpx6SjLSi5krD6MTqvW+LgbSoPi9JIlrHRhRS0lsf/lt+7vc+tLXijBR77pSMzQ8SjWtr8LY7KQX5To//7JRGX9FczJ+da8pD1MKVEb7oSv+JejIlNOO7qPLXz+XiY64wyTrdwuHAI3JPcgtf0BlUKMJYGPKaZDwetDd7VFxEG3qK/vvG3SOtZya1Yh3RxHqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ro2WTX9ubbxU6tJ8fNauy+l3r5iq7nIqu5RJdE5Yu4=;
 b=KaWvz5sHF1gaaksEOtbb6IfFocgk6txKQDQXL9cu9YmMUP4rRJJAx85yPAqGtN9fiFJ1rwM8+P1WqEChCDEAiNqjeKgqIRcq9SnyXX9HyaEwo88DWcBLV3olYR0vPO58xfLUWqD5D1JmD/fPKbUIlf8kDp+Z/hilA2PoQ5ZxmarvrXDki8dQyY1dKXFSoUrOCO/OjlTFWUlt746uF2qQV0whNhZ68I9If6apGwXummpaBMKHMQLu1QTLl5Wy9VtIdCar8WNFQ3N0YUvKsDeOR2bTFDCYhXkywnxx+3+s8vW4qfS2+og4bOpyyxnokD+QFiSYT//Cb8oOpeM2FfETcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by MN2PR11MB4567.namprd11.prod.outlook.com (2603:10b6:208:26d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Sat, 18 Mar
 2023 08:15:00 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::7576:1f4a:2a6c:72f7]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::7576:1f4a:2a6c:72f7%2]) with mapi id 15.20.6178.029; Sat, 18 Mar 2023
 08:15:00 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     "Li, Xin3" <xin3.li@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "Liu, Yujie" <yujie.liu@intel.com>,
        "Kang, Shan" <shan.kang@intel.com>
Subject: RE: [PATCH 1/1] x86/vdso: use the right GDT_ENTRY_CPUNODE for 32-bit
 getcpu() on 64-bit kernel
Thread-Topic: [PATCH 1/1] x86/vdso: use the right GDT_ENTRY_CPUNODE for 32-bit
 getcpu() on 64-bit kernel
Thread-Index: AQHZU/pnrQNA4Qs8TE+zA+Udtp/Txa74104AgAAkKCCABz5hsA==
Date:   Sat, 18 Mar 2023 08:14:59 +0000
Message-ID: <SA1PR11MB6734106794B247091E84D1CFA8829@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20230311084824.2340-1-xin3.li@intel.com>
 <5e84fd48-459d-8850-d26f-860c6d34a9ad@intel.com>
 <SA1PR11MB6734CF1607F263CB8389F5F2A8B99@SA1PR11MB6734.namprd11.prod.outlook.com>
In-Reply-To: <SA1PR11MB6734CF1607F263CB8389F5F2A8B99@SA1PR11MB6734.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|MN2PR11MB4567:EE_
x-ms-office365-filtering-correlation-id: 2a6fa962-30ce-46bf-fedd-08db2788de33
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v5btN4l+X6JfEs4/p31BUECJF9POMIKGHs+eJeOhFQC81xDEab0RfAl8WSXj5/m4LE66xJ78dcADu0V3Fgr4UCsoUOwDiLN92qbVdhHCrLOTww9WF9EMFkb6/Oxm9iD+PISE3he7nxcrqDOV/uBNSAiC11tZ4WwZaeT1ryvupGvBUBbZYxacllHwXh3bfyNhDA2g8JF2goa+MME3YHtEDvWwYM98gsFjmiI+xQL13+XUZhcp3iBBzTpPrfPtXeXH8KGqQMgK/yPt6vH9NKhzwNKRS1sLx8Dr1x8w3OCvKUOL/6gwnZ6v0S62I8MWlkwcJ92uBf7jHg8p7iDCz805GV/4QUV1qVHfXpxevp0NiotPpDVbEDUfQYr7NXb9sP8iZbhZavjDpSXT9/6lV9KgxFS4dcZqf6Ozm2ujoC/sjx3s0R8AgvMoZ4+V/X3L4O06xQRHHCENuDjhMkBg4CLDbYnRLkLgW66NBWSlA+mGUhqHgexa0y+2h4raN+J6IrL9OQw8xW8BVhNksEOWJbRSLHO81+VZIVZl9U7yrFKX8cY2r4FQj0mRAz2uHRf8xXJLtvqC8Sn7fXND6a+T9hAjZvgIyFxD22v6QbfiZ4B+/bmMGNra9Vn/+7s7hYgSHL3r96/SRc4AHVmGYV6K+mKzBc0cUW8CYfEb4u9ncmUQDMNqzTabR4YNZuSlCTWmX9j2twHJC60KAC/nxaU/ALJpjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199018)(4744005)(52536014)(5660300002)(41300700001)(8936002)(4326008)(55016003)(86362001)(33656002)(38070700005)(38100700002)(82960400001)(122000001)(2906002)(83380400001)(478600001)(71200400001)(7696005)(9686003)(6506007)(26005)(186003)(316002)(8676002)(76116006)(66946007)(66556008)(110136005)(54906003)(64756008)(66446008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWFUM1EyMnF1TG5ITmhQaWs4aXdFQnBIb3QyMTc0Yi8vaUhscCtMTlV0THZZ?=
 =?utf-8?B?cUthTDkwZmV1cklscDhBTnpBS1kvdFdXdkxtRmptdEg4Qm1nMEZIM0VZcXdq?=
 =?utf-8?B?dGFKcjViOW1nNkFGOFFRNWw5dEZCSFVzM3dUTVhRU0FnUTlySDVVOGxLbldQ?=
 =?utf-8?B?MU5ubXQwSVJYT3UybjJpbjJEcjlMN1BsRlZEbkNSQzk1bldpdHE0aFdnNXVM?=
 =?utf-8?B?UmtVdjRIZGJxaUM1dmZaSmtDeUxFZDlmaFF3MjRlRGJpR2RPL0doY1JXd21Q?=
 =?utf-8?B?UEZnQnVhMUo4RmhRejB0MnBPb09LVnJEZE9IbU0vYjRQeFllc2xUMFJxN21N?=
 =?utf-8?B?cENzQXBWWWU2VTNUazlVdkxkeE5uM0RVWWo3M01ZNXZJbE1DOGl3MWYrWUxY?=
 =?utf-8?B?WWUwM1VuTkU5TWtrZitRTzg2a2xXUDlDMGJNUUVXWFBMNTg0Mys0V1ZnVFV6?=
 =?utf-8?B?S2pUKytzVU1zelpaZDRHWFc0b2ppNkNkUVNBbDRXYkJJT20vZEdsSjBVUXdC?=
 =?utf-8?B?UnljS0UySndRNHA5VVdxV3FsNDc3bnpGblJoZnJ5MEc1L1U2dkhsM1liQ1BN?=
 =?utf-8?B?ckFWT1BmbkRJcythc2J5NnVKTkhYTjBFM3ptczhJV3V1Sk1mT0xkVExQUDhq?=
 =?utf-8?B?c1ZhSXViSVRMeENZRHR6bHB5N0NFZzNFYVpodi9HZXJ6WE5MYXBmRVY2UTVE?=
 =?utf-8?B?bkJVWHpRVSt0a3ZBQmYvc2hXV3dxRjdHU1ZldWg2R2V1WWJ2WS9waE5UUTBN?=
 =?utf-8?B?cWx5TjJhR0l6ZWZTZUhwN0c2MjRwVHorUTEzeEFzeGRGUzJ6UnpzYW81UHVu?=
 =?utf-8?B?NVlEb0ZVWWxYV2RaNDltL01uOStjZEZlSExBTmxuR3gzOHdNYWhLVXFtTjNW?=
 =?utf-8?B?bllvQmRRY0IzQklVbnBrU3RXc1lhdU12aTBwRW5KejVGYU93QlpzVXM0YVdz?=
 =?utf-8?B?dFdBRWpxdDlkbi94WHd1TU1zeTM0b3Z2R1lodlFQNzFrSkxEL1VhZWR4M1dn?=
 =?utf-8?B?cGREUWt1NWFoQlNMa3ptTkQ5ZFZtMytFamRma0hhNlRvM2JtVUpCNGJFQWNq?=
 =?utf-8?B?cGZHWlJKYVJGc1I1TnJlbitxd0lIZEZYdm5qMVQrSkR5NjNGcm9pK255OWhk?=
 =?utf-8?B?ZDZmaE9qcXJ6elRKM3dFS1BKS1VKZHhYZjEzQ2tGZW5Sa2pQcVh0N2oxeEJm?=
 =?utf-8?B?c0M4eXhRNWtOOVdmRUJSUE05ckUyN2pGRmppV1FsWGpyQTVVa3hRdnd4VGJD?=
 =?utf-8?B?dzlja1F5cDh2ZDZRcDlHd2NVeG5lTTFjOWtCVU5SNHdycVBKU01Zc01XSlFL?=
 =?utf-8?B?QkkrMmJvZ0ZYWTF1dS9aOTUzOWFFeUMxUjVyMFU3TUhQdGtyd0p1L3pqMkxZ?=
 =?utf-8?B?VlpEeER1R3BKeVpuK3I4c3ZtWEVBSjhqdkcvQm1oSWZ0SGhVWklCcVFWdWFk?=
 =?utf-8?B?T1BhSkRVSXR0Tk50RU5ybEllK0hTbG9MbTVzUzVoK284K0U1OUY3c01QL2Np?=
 =?utf-8?B?RW0xNy9Bb3ByWitlbEZka3NPZCt1NWtIb3ZpeFB1TzZsK0dOL2d2SzVrdlpa?=
 =?utf-8?B?aGNBNDFUc2ZxT2pxSlNDbmtXVk11M003Q0Vsck9TQXRBTlFxMTRDR3FLeDRS?=
 =?utf-8?B?R1JibEJwNEJta255MWV4WUQ0SHljQ244cmc2ZnhUVVVnUjI5M1VocHM0eWFC?=
 =?utf-8?B?cEVEb0h4ck1xOHgvNmlXZGdXUDJGdW9qd1JQVFpobGZFU21vZTliTC9nSkx1?=
 =?utf-8?B?OSs5SWdsVzBvekNnR1o1d0U5REd3c3JseDFOQmVkWk55YUtaekFERjRCRnhY?=
 =?utf-8?B?RUdvWW9WaS9paTRaZDV3MU51azRjU2xrRmxEUGJDZzNsajl5QkJFRVBJaU5r?=
 =?utf-8?B?M0p0bVJQTDdCSThYZFF1TnRkOTMvRjZXTnNrS2N3bk85bzRBTG1SL2J3NDlU?=
 =?utf-8?B?aG1RcWZtSXE1VkxCTldoV1JSRXVHRjZqVlpiZ1JScFE3RC9iVzFLQlhZVDk0?=
 =?utf-8?B?Q25IVXN6RzBuK0k4OFF3T3N1clN6ajZ2ZnBVd0FVRFl6elJlMkVZOWpBT05S?=
 =?utf-8?B?OGVaKzE3SjZ3SmQyV3N1YTZhSkxsMmVBSWJ0MG1jb2FjcldONHdNS0dLOEZ3?=
 =?utf-8?Q?o0Vc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6fa962-30ce-46bf-fedd-08db2788de33
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2023 08:14:59.9885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fRvGwWNd4fKNKp1yrXKkcfVQrM0D54olJOlJb7jxY2qvAo1Wcy2NJnwhomxD29zlOZnSQH9gtUKRLku1IIxYHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4567
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IEkgdGhpbmsgSSdkIG11Y2ggcmF0aGVyIGlmIHdlIGRlZmluZSBhbGwgb2YgdGhlIEdEVF9F
TlRSWV8qIG1hY3JvcyBpbg0KPiA+ICpvbmUqIHBsYWNlLCB0aGVuIG1ha2UgdGhhdCAqb25lKiBw
bGFjZSBkZXBlbmQgb24gQlVJTERfVkRTTzMyXzY0Lg0KPiANCj4gU291bmRzIGEgYmV0dGVyIHdh
eSwgbGV0IG1lIHRyeS4NCg0KSGkgRGF2ZSwNCg0KSSB0cmllZCB0aGUgZm9sbG93aW5nIHBhdGNo
LCBhbmQgaXQgd29ya3M6DQoNCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zZWdt
ZW50LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zZWdtZW50LmgNCmluZGV4IDc5NGY2OTYyNTc4
MC4uOWQ2NDExYzY1OTIwIDEwMDY0NA0KLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vc2VnbWVu
dC5oDQorKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zZWdtZW50LmgNCkBAIC01Niw3ICs1Niw3
IEBADQoNCiAjZGVmaW5lIEdEVF9FTlRSWV9JTlZBTElEX1NFRyAgMA0KDQotI2lmZGVmIENPTkZJ
R19YODZfMzINCisjaWYgZGVmaW5lZChDT05GSUdfWDg2XzMyKSAmJiAhZGVmaW5lZChCVUlMRF9W
RFNPMzJfNjQpDQogLyoNCiAgKiBUaGUgbGF5b3V0IG9mIHRoZSBwZXItQ1BVIEdEVCB1bmRlciBM
aW51eDoNCiAgKg0KDQoNCkl0J3Mgc2ltcGxlciBhbmQgbG9va3MgcmVhc29uYWJsZSB0byBtZS4g
SXMgaXQgd2hhdCB5b3Ugc3VnZ2VzdGVkPw0KDQpUaGFua3MhDQogIFhpbg0KDQoNCj4gDQo+ID4g
QWxzbywgYWJvdXQgdGhlICpzaWxlbnQqIGZhaWx1cmUuLi4gIERvIHdlIG5vdCBoYXZlIGEgc2Vs
ZnRlc3QgZm9yIHRoaXMNCj4gc29tZXdoZXJlPw0KPiANCj4gV2hlbiBsc2wgaXMgdXNlZCwgd2Ug
c2hvdWxkIGNoZWNrIFpGIHdoaWNoIGluZGljYXRlcyB3aGV0aGVyIHRoZSBzZWdtZW50IGxpbWl0
IGlzDQo+IGxvYWRlZCBzdWNjZXNzZnVsbHkuICBTZWVtcyB3ZSBuZWVkIHRvIHJlZmFjdG9yIHZk
c29fcmVhZF9jcHVub2RlKCkgYSBiaXQuDQo+IA0KPiAgIFhpbg0KDQo=
