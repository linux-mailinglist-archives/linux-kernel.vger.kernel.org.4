Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4C969BAE0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 17:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjBRQLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 11:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBRQLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 11:11:46 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2522916AFC
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 08:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676736705; x=1708272705;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zOvQsB0n7ONciFAdHsyo8Dxxj7VZF7Ms0uAzJJCPuiA=;
  b=QDla/Z+V95D1dvgn/0U7djzWj2vflks84BXT+Wm1pSDrI4anKgytuRmd
   suu9WNGJJ0+qMwgBp2q+Daz3KQZ5fty+cdKq5OmRl2amV+z+R8f0KO6rj
   0Lg6DFrd0ykgXINN6qTmw/fk+S3xqsfwrHJEeCp9cKvWk3qqOrPH9D46Z
   7f5asnA9zoIC4bIHp/7sp5ieSiBtRIf3wsWKMlZxEiS/ythEvDIGB9Ige
   2jaFDi7XIzMbmOPoGAwFG5A/dBlaO7Zz7DCKvtooHiMKWoHM8J3bYCm5g
   G4LXtdDuZyzkVd6tqt+7Y6Rhom3R5IJ5t22EEFqj9AMKc82YZ3kMUXsDj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="396861445"
X-IronPort-AV: E=Sophos;i="5.97,307,1669104000"; 
   d="scan'208";a="396861445"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2023 08:11:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="780147592"
X-IronPort-AV: E=Sophos;i="5.97,307,1669104000"; 
   d="scan'208";a="780147592"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 18 Feb 2023 08:11:44 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 18 Feb 2023 08:11:43 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 18 Feb 2023 08:11:43 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 18 Feb 2023 08:11:43 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 18 Feb 2023 08:11:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzdPablwaQFvaG95lxCSugZpuqkjJXgGelfLoXZ0My70sN0G82/YC0Avvdk3/ZJy4zwQ5W+WnU6XOC3aaqQ8HLDNg0Fy/Fo6RAbXazFzTSz+HQqWzWj2GVCl9+Cypb3j2ctPArgChoO3HUAE4FnJc6/yrYdPRTu2Z7+YNYgwQb9hxHzYP5Xyj5xxnTJO1fRqWKFv01fNPzN88PBJOYsvf7zWxMwIWoARMFn2H7Aye/qJs+mj+5yPh4V8nGRweY1HprE6Ms3A5Rft7NFJPYAUgjbnz4yJMIOMOYrglJKdJGtmlceG2J/AL7UaCF2LWp0JvqvQPC2KlWKL7S5UH1gq4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOvQsB0n7ONciFAdHsyo8Dxxj7VZF7Ms0uAzJJCPuiA=;
 b=oOxj459lLrByGHtSDiQ4fXzB/rD6kYYYGAEqVsGJWDmqPBdNdQ+dWnku5U6zDq3pARTJLa7u1eo7mXF7R0OsW5HVl2k9EnFDw3d1xwQg/VMGuwsH819P9BnUZpxxIu6gmXDwqIXgSsdzxxQC28+ER4lRC4jihsFyp3fSYEq6p6ZiAc1lNOxT4zbZH5pSmvqC6Cd89rQy86tEJ6gClbvuyvug4kpFBWseA3rKUyJ25vod+b0iaoTzGkTLIiazWxJ/J3rjNoa2DkQsG+HyDUZ/RnaxslVDSkMQb0WQAdDbA5Ypt701oyNAI0PGj+xP4MhfyGoO7OHsUNFOHPQ63VkzrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by MN2PR11MB4760.namprd11.prod.outlook.com (2603:10b6:208:266::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Sat, 18 Feb
 2023 16:11:34 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837%8]) with mapi id 15.20.6111.018; Sat, 18 Feb 2023
 16:11:33 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "Brown, Len" <len.brown@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zhang.jia@linux.alibaba.com" <zhang.jia@linux.alibaba.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 1/1] x86/topology: fix erroneous smp_num_siblings on Intel
 Hybrid platform
Thread-Topic: [PATCH 1/1] x86/topology: fix erroneous smp_num_siblings on
 Intel Hybrid platform
Thread-Index: AQHZQu4viqmX7AvvFECTb3pBjtABuq7TbnAAgAFzBQA=
Date:   Sat, 18 Feb 2023 16:11:33 +0000
Message-ID: <a0242c82631b19f3de7a223d8dd38f21308cd3cc.camel@intel.com>
References: <20230217163724.581513-1-rui.zhang@intel.com>
         <20230217163724.581513-2-rui.zhang@intel.com>
         <fcd46e9d-c6d0-4a01-141b-11173602475e@intel.com>
In-Reply-To: <fcd46e9d-c6d0-4a01-141b-11173602475e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|MN2PR11MB4760:EE_
x-ms-office365-filtering-correlation-id: b2675655-fe43-4a3f-3d93-08db11cacdb0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RsudIGcspXLFO6JbkQ+pF3omDHbbSKg16hdhLF9nOGLrZNc87eyHCkjFeT1m8Vn33SLeHzONIF5WgmSSuFDrXbbdEYY3gpl4iXfnTEHd9cFAJCCY/8I//E1Ueg6PFrbTsbE7AnLpZiEiLKXZNe1V5pUUCS3K9zOhHIt4BCKVLYIVaYZeDBOyNe9bwn0sFtDKpszBQQGsgsPx19VoBgHalPkjT/edPSEEa+TNq3XNcJFD2PoJpHCXN5hlbg1t3VYF37MRpq0LyoYCRwbgCBUgIPxxagYSafHloFnn0lWJOx03QFiLcYSJSSsqSuy8u3CFzzuDXPqScLhZZMYYoLE/2WHEuGaAuTGIr3vTzYe0RQKwFwPGB+ZKcbZ0o6waVf14dVKRvPpXwkBzmvQHqzDua/ICf0pwjO/MGij1coqXyVwCHdgYz2H9XwY464WOw/SQRGNTkbBwluhMDG9CMhACMRilSdYEzJ0w0Fxm4K2cYHZQgLos36n+Wamtxd1onWupYTaFIcyLjUCPqBpbp4Owi7Vx1yjay8mYZBCfghobi1dqwf66p38MaccSCpt5Fsy+y9VQV8L2BikHPCLYKZya8Uby9OU0TRKHO3pgfxjt8Wz5Q3uDJDBSRF7q04fslrgHDJ3pRGec+Hx7qT9a7n9c2fMhXC7Co0+BXF/6oDxkJyrFPDwHotcchikrxjzNmkiXImKgkxx6NW8I6BM3gOwNyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199018)(2906002)(83380400001)(38100700002)(38070700005)(53546011)(2616005)(122000001)(86362001)(82960400001)(316002)(110136005)(66946007)(8936002)(91956017)(76116006)(54906003)(36756003)(66556008)(5660300002)(66446008)(66476007)(8676002)(64756008)(4326008)(41300700001)(478600001)(6512007)(6506007)(26005)(186003)(71200400001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mkhlc3gvRElmYit0dHFTbWw4RDBqRHJ2RmprNVVRaHRjdUk2ZjNTY1hsNXpt?=
 =?utf-8?B?UEtXNFZiRmxrQm1wSXVBcTdBQkxnZjhRK3FQVnhOaFhNWXQ0UUJaejN5UkU5?=
 =?utf-8?B?SkljRDBhalpiNGY4ci83cGtwVWRpNC9IdEpHZlZoSDFaUzhkRVllREhVa3kw?=
 =?utf-8?B?a1V2Vmt2Tk1VTHh4VysvOWJGM3Z1ekJ2UkgrUG1EY0k2MlBZb3RIZm1MTnZ5?=
 =?utf-8?B?Vzk3Mlpta2JBemtPWnFVSHZRckd6RnJ6UGJScjVaWHpxTS9NckFPZG1uVnp0?=
 =?utf-8?B?SFRnaTAvWHFkMkdkVXBmNlBNRnRyTDN0b2dPekhxOG5qa3NkcC9oTTU2WUk2?=
 =?utf-8?B?aG1zQXA2Mk55bVZWaHJRRWk3REw0QlV0RnFIQlpMUG9sUFoyY1dNT0ZGQmh6?=
 =?utf-8?B?OGtzV1lOZG5MYTBoR2ZvdWkwUjdFQk02VHpHbjhrOXdXWHpYTzBEV052L0tw?=
 =?utf-8?B?R1RuaWZsdnJTUGJDT0x6ajQ0S0FFWlFpa1lmUzk5QXBxVDhEQTBxTklyNmUz?=
 =?utf-8?B?VCtkdHRKb29nUGRZeHl3NWsrSmZRcnVVMmNwVUwrZC93SnJSNWphblVERzZ2?=
 =?utf-8?B?OEJYZ1dBbmJzL0lDMi9CWGg3eTV0cUdUcDhCVXhzTWNWWWNyNVJjWXNnM2tL?=
 =?utf-8?B?c3A4V3EwUW1qTktGMU5DNDRFTHNCUm9jaHQrbWMrbGg2U1FTQkpYSFc5bE1H?=
 =?utf-8?B?TXJWQUowSHJYdUZxaEpyM04veUdIcXAyT2w5SjZtL051cUpvV05KZlZOUVUz?=
 =?utf-8?B?ejhMeFJHM1AyUWdkcklJbS94bzNkUUZuNmNURVkzNnI3RVZERENmRzIvcW9D?=
 =?utf-8?B?dndzK3dWZDRoQndvVU94T1pwQzVidzBndzRFZE90TzR2WG45N2p6M2Z0VC8v?=
 =?utf-8?B?dEM4WjhaWHBGT21VMzhGQ0haRFI5K0I0bVdkeVlBY3BuR1kyZ3BTYjFaY1Nq?=
 =?utf-8?B?RDBmY1p0RU96M0t5cjlXVW9ReWdzWHZGTUh4ZzBxajgrZHMyUkhNVnk0dElZ?=
 =?utf-8?B?ZFgyb0NWMEJpTHRFQ1lYVkVJREJCVGxVQjFCSkJtZ2MzKzZUVTF6SnNhRWtO?=
 =?utf-8?B?M2h2eklNeXY4Ni9NWXRsNkROOS9SYjJmWG84cVh4WitLQWpzRWdJeGpZay9h?=
 =?utf-8?B?UmJKbk9JemRrRG5JYkQ2bnFLNmhpYUZKdG1WRHlmU1JsVHV6T2QrWjhJSzBj?=
 =?utf-8?B?Unh1T0dRdTAxVTEzVWdYZVJTamJ6ZzVrcWtBcDAxTHZqOXBNNnVjY0JXT1Qz?=
 =?utf-8?B?UW5uN25VT1daLzRteU1RWjlhSzZuUURwMGhxUCt5TGF1UGVNWTJuZUl5ZVZ1?=
 =?utf-8?B?cmlMM0hiVWpKNml1UitFQnpqWXRkU0kvVTVKRWFudUpWWWNqYVQ0ZWM1Q25V?=
 =?utf-8?B?dWNWb3h6WmxuRlozS2J3N1gwS0drZFU0RFQvTFl5dWRKMEFRMVZadjUyejdm?=
 =?utf-8?B?bTc4NFZvOTdFUUF4OUdGenl5dmVIYWVOR3puY2c3STRyeW5wV0RES0VPQU91?=
 =?utf-8?B?aEJCRzczcnRUVk4rZUVtSkFHYWd2bDIwUVp2ZTZVdlYxbHppemdOa0dRSTVy?=
 =?utf-8?B?ejhoRkxva1dhdHpnT0xrcURlK1A2THlRRk9zWnZpZUI1SThlQWhRWHhVM3Jp?=
 =?utf-8?B?Mk1lSndvYXdWZ3lBNVBOOU16WGkxUSt3NWRONzFuSFRpL2tDUjBUUGFNOGNE?=
 =?utf-8?B?ckhrTGRMSzJEblVrU00vVk0zZ29IVHZHbzlmTzArd0xUT2NyZVhac3dSREJR?=
 =?utf-8?B?YTRGSm13clNUTW0rdS9RMFYyRVdrSjdwZ0dXQkRQNzkzaFZta00vRU4rZk5z?=
 =?utf-8?B?c2VHelNTbDZvRUxmOTlTRWJjdmFya2hUSHBnQXlHSS9TTU5PM0JyR1liUklz?=
 =?utf-8?B?SlhnQko3KzZOY1lyaGtwTExpVEJyZUI5TWVyYitORWRqa25hMm1yQUtUSnJ4?=
 =?utf-8?B?V0NqdzRpc1JpdUNCZzRlNk0rd1ZLblJVb29SZC81YSs4TXNySEw0OXA0VmRN?=
 =?utf-8?B?dDJ2Wm5talZ1dndqcEFQK05ibDZ6dVkwdTQ1K3I0Mm1FZW55d2N0VkJsTnRI?=
 =?utf-8?B?WFB6U0xHaDRUTTJXb3pwYkRFN1ZDVGdtSTBFN2dFMFVYN1JZQ1hpSVQ2ZW0x?=
 =?utf-8?B?emhXUXV2V1RWblM1WkV1V0RPRmpINzBsbmJSSEs3OVowQjcwcExGUEhBRTd1?=
 =?utf-8?B?MWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE60EC85D7E06142AE46774F14BBC486@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2675655-fe43-4a3f-3d93-08db11cacdb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2023 16:11:33.4690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yPc9O5sL+S+MB80HJYjiR2WRTH/uJke6yTaPeFmVAJYewTmLJC/YPI3NbYRxbTtoU8Nl+U2eRgfxZK/KHBy96g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4760
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERhdmUsDQoNClRoYW5rcyBmb3IgcmV2aWV3aW5nIHRoaXMuDQoNCk9uIEZyaSwgMjAyMy0w
Mi0xNyBhdCAxMDowMyAtMDgwMCwgRGF2ZSBIYW5zZW4gd3JvdGU6DQo+IE9uIDIvMTcvMjMgMDg6
MzcsIFpoYW5nIFJ1aSB3cm90ZToNCj4gPiBUaGUgU01UIHNpYmxpbmdzIHZhbHVlIHJldHVybmVk
IGJ5IENQVUlELjFGIFNNVCBsZXZlbCBFQlggZGlmZmVycw0KPiA+IGFtb25nIENQVXMgb24gSW50
ZWwgSHlicmlkIHBsYXRmb3JtcyBsaWtlIEFsZGVyTGFrZSBhbmQgTWV0ZW9yTGFrZS4NCj4gPiBJ
dCByZXR1cm5zIDIgZm9yIFBjb3JlIENQVXMgd2hpY2ggaGF2ZSBTTVQgc2libGluZ3MgYW5kIHJl
dHVybnMgMQ0KPiA+IGZvcg0KPiA+IEVjb3JlIENQVXMgd2hpY2ggZG8gbm90IGhhdmUgU01UIHNp
YmxpbmdzLg0KPiA+IA0KPiA+IFRvZGF5LCB0aGUgQ1BVIGJvb3QgY29kZSBzZXRzIHRoZSBnbG9i
YWwgdmFyaWFibGUgc21wX251bV9zaWJsaW5ncw0KPiA+IHdoZW4NCj4gPiBldmVyeSBDUFUgdGhy
ZWFkIGlzIGJyb3VnaHQgdXAuIFRoZSBsYXN0IHRocmVhZCB0byBib290IHdpbGwNCj4gPiBvdmVy
d3JpdGUNCj4gPiBpdCB3aXRoIHRoZSBudW1iZXIgb2Ygc2libGluZ3Mgb2YgKnRoYXQqIHRocmVh
ZC4gVGhhdCBsYXN0IHRocmVhZA0KPiA+IHRvDQo+ID4gYm9vdCB3aWxsICJ3aW4iLiBJZiB0aGUg
dGhyZWFkIGlzIGEgUGNvcmUsIHNtcF9udW1fc2libGluZ3MgPT0NCj4gPiAyLiAgSWYgaXQNCj4g
PiBpcyBhbiBFY29yZSwgc21wX251bV9zaWJsaW5ncyA9PSAxLg0KPiA+IA0KPiA+IHNtcF9udW1f
c2libGluZ3MgZGVzY3JpYmVzIGlmIHRoZSAqc3lzdGVtKiBzdXBwb3J0cyBTTVQuICBJdCBzaG91
bGQNCj4gPiBzcGVjaWZ5IHRoZSBtYXhpbXVtIG51bWJlciBvZiBTTVQgdGhyZWFkcyBhbW9uZyBh
bGwgY29yZXMuDQo+IA0KPiBJIHdhcyB3aXRoIHlvdSB1bnRpbCBoZXJlLCBidXQgSSdtIGhhdmlu
ZyBhIGhhcmQgdGltZSBwYXJzaW5nIHRoaXM6DQo+IA0KPiA+IE9uIEFsZGVyTGFrZS1QL1MgcGxh
dGZvcm1zLCBpdCBkb2VzIG5vdCBjYXVzZSBhbnkgZnVuY3Rpb25hbCBpc3N1ZXMNCj4gPiBzbw0K
PiA+IGZhci4NCj4gPiBCdXQgb24gTWV0ZW9yTGFrZS1QIHBsYXRmb3JtLCB3aGVuIHByb2Jpbmcg
YW4gRWNvcmUgQ1BVLA0KPiA+IGEpLiBzbXBfbnVtX3NpYmxpbmdzIHZhcmllcyBsaWtlIEFsZGVy
TGFrZSBhbmQgaXQgaXMgc2V0IHRvIDEgZm9yDQo+ID4gRWNvcmUuDQo+ID4gYikuIHg4Nl9tYXhf
Y29yZXMgaXMgdG90YWxseSBicm9rZW4gYW5kIGl0IGlzIHNldCB0byAxIGZvciB0aGUgYm9vdA0K
PiA+IGNwdS4NCj4gPiBBbHRvZ2V0aGVyLCB0aGVzZSB0d28gaXNzdWVzIG1ha2UgdGhlIHN5c3Rl
bSBiZWluZyB0cmVhdGVkIGFzIGFuIFVQDQo+ID4gc3lzdGVtIGluIHNldF9jcHVfc2libGluZ19t
YXAoKSB3aGVuIHByb2JpbmcgRWNvcmUgQ1BVcywgYW5kIHRoZQ0KPiA+IEVjb3JlDQo+ID4gQ1BV
cyBhcmUgbm90IHVwZGF0ZWQgaW4gYW55IGNwdSBzaWJsaW5nIG1hcHMgZXJyb25lb3VzbHkuDQo+
IA0KPiBMZXQncyB0cnkgYW5kIGZvY3VzIHRoaXMgY2hhbmdlbG9nIG9uIHRoZSBwcm9ibGVtIGF0
IGhhbmQgd2hpY2ggaXMgYQ0KPiBicm9rZW4gc21wX251bV9zaWJsaW5ncyBvbiBNZXRlcm9yTGFr
ZS4gIFJpZ2h0Pw0KDQp5ZXMuIEkgdG90YWxseSBhZ3JlZSB3aXRoIHRoaXMuDQoNCkJ1dCB3aGVu
IHNob3dpbmcgdGhlIChjcHUgdG9wb2xvZ3kgaW5mbyBhbmQgbHNjcHUpIHByb2JsZW0gYmVsb3cs
IEkNCndhbnQgdG8gZGVsaXZlciBhIGNsZWFyIG1lc3NhZ2UgdGhhdA0KMS4gdGhlcmUgYXJlIHR3
byBidWdzIGFuZCAqYm90aCogb2YgdGhlbSBhcmUgcmVxdWlyZWQgaW4gb3JkZXIgdG8NCiAgIHRy
aWdnZXIgdGhlIHByb2JsZW0NCjIuIHRoaXMgcGF0Y2gganVzdCBmaXhlcyBvbmUgb2YgdGhlIGJ1
Z3MNCg0KRG8geW91IG1lYW4gdGhhdCBJIGRvbid0IG5lZWQgdG8gbWVudGlvbiB0aGUgeDg2X21h
eF9jb3JlcyBpc3N1ZSBoZXJlPw0KDQo+IA0KPiA+IEJlbG93IHNob3dzIHBhcnQgb2YgdGhlIENQ
VSB0b3BvbG9neSBpbmZvcm1hdGlvbiBiZWZvcmUgYW5kIGFmdGVyDQo+ID4gdGhlDQo+ID4gZml4
LCBmb3IgYm90aCBQY29yZSBhbmQgRWNvcmUgQ1BVIChjcHUwIGlzIFBjb3JlLCBjcHUgMTIgaXMg
RWNvcmUpLg0KPiA+IC4uLg0KPiA+IC0vc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHUwL3RvcG9s
b2d5L3BhY2thZ2VfY3B1czowMDBmZmYNCj4gPiAtL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1
MC90b3BvbG9neS9wYWNrYWdlX2NwdXNfbGlzdDowLTExDQo+ID4gKy9zeXMvZGV2aWNlcy9zeXN0
ZW0vY3B1L2NwdTAvdG9wb2xvZ3kvcGFja2FnZV9jcHVzOjNmZmZmZg0KPiA+ICsvc3lzL2Rldmlj
ZXMvc3lzdGVtL2NwdS9jcHUwL3RvcG9sb2d5L3BhY2thZ2VfY3B1c19saXN0OjAtMjENCj4gPiAu
Li4NCj4gPiAtL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1MTIvdG9wb2xvZ3kvcGFja2FnZV9j
cHVzOjAwMTAwMA0KPiA+IC0vc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHUxMi90b3BvbG9neS9w
YWNrYWdlX2NwdXNfbGlzdDoxMg0KPiA+ICsvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHUxMi90
b3BvbG9neS9wYWNrYWdlX2NwdXM6M2ZmZmZmDQo+ID4gKy9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1
L2NwdTEyL3RvcG9sb2d5L3BhY2thZ2VfY3B1c19saXN0OjAtMjENCj4gPiANCj4gPiBBbmQgdGhp
cyBhbHNvIGJyZWFrcyB1c2Vyc3BhY2UgdG9vbHMgbGlrZSBsc2NwdQ0KPiA+IC1Db3JlKHMpIHBl
ciBzb2NrZXQ6ICAxDQo+ID4gLVNvY2tldChzKTogICAgICAgICAgIDExDQo+ID4gK0NvcmUocykg
cGVyIHNvY2tldDogIDE2DQo+ID4gK1NvY2tldChzKTogICAgICAgICAgIDENCj4gDQo+IEhlaCwg
eWVhaCwgMTEgc29ja2V0cyBpcyBhIHRpbnkgYnVnLg0KPiANCj4gPiBUbyBmaXggdGhlIGZpcnN0
IGlzc3VlLCBlbnN1cmUgdGhhdCBzbXBfbnVtX3NpYmxpbmdzIHJlcHJlc2VudHMgdGhlDQo+ID4g
c3lzdGVtLXdpZGUgbWF4aW11bSBudW1iZXIgb2Ygc2libGluZ3MgYnkgYWx3YXlzIGluY3JlYXNp
bmcgaXRzDQo+ID4gdmFsdWUuDQo+ID4gTmV2ZXIgYWxsb3cgaXQgdG8gZGVjcmVhc2UuDQo+ID4g
DQo+ID4gTm90ZSB0aGF0IHRoaXMgZml4IGlzIHN1ZmZpY2llbnQgdG8gbWFrZSBzZXRfY3B1X3Np
YmxpbmdfbWFwKCkgd29yaw0KPiA+IGNvcnJlY3RseS4gQW5kIGhvdyB0byBmaXggdGhlIGJvZ3Vz
IGNwdWluZm9feDg2Lng4Nl9tYXhfY29yZXMgd2lsbA0KPiA+IGJlDQo+ID4gYWRkcmVzc2VkIHNl
cGFyYXRlbHkuDQo+IA0KPiBIYXZpbmcgdGhpcyBub3RlIGhlcmUgaXMgcHJvYmFibHkgT0suICBC
dXQsIEknbSBub3Qgc3VyZSBldmVuDQo+IG1lbnRpb25pbmcNCj4geDg2X21heF9jb3JlcyBpcyB3
b3J0aCBpdC4gIERvZXNuJ3QgaXQganVzdCBhZGQgY29uZnVzaW9uPw0KDQpFdmVuIHdpdGhvdXQg
dGhlIENQVSB0b3BvbG9neSBwcm9ibGVtIHdlIHNlZSwgY2hhbmdpbmcgc21wX251bV9zaWJsaW5n
cw0KZnJvbSBhIGxhcmdlciB2YWx1ZSB0byBhIHNtYWxsZXIgdmFsdWUgaXMgd3JvbmcuIEluIHRo
YXQgc2Vuc2UsIEkgY2FuDQpyZW1vdmUgdGhpcyBmcm9tIHRoZSBjaGFuZ2Vsb2cuDQoNCnRoYW5r
cywNCnJ1aQ0KDQo=
