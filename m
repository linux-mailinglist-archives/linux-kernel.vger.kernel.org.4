Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6440E72EA1A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjFMRlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239881AbjFMRlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:41:14 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E9F1BD4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 10:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686678069; x=1718214069;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tGj/EPbDrO6qiRwcnhHnzR/tX5+oGt2KQHXUF+U2mjs=;
  b=EgILgNBn6WSh6PxLgoEc9bqhs99278IDFuDyuywa0gGSJF0oUk6YHZKi
   faUmx/+ZlIUcUf1vvp1JrmbdUcIEWKidONWiNyr4bRGSZXeBIMlxoSZxm
   yn9boC977OR464eLjgqKznTKuvFzDZyEu8L/fyRodnkAueH183bEZfZ34
   CZmm4OCq/2jJ66uXFg1QXyqcDLqc5MTlO0r72//Ssjz2AIIe9ww5GUu2c
   gRAAU3OAhj72MBbJqCl/0oS5J2kIln/9ukEpN6ipF4GD1QDxJ9TUUrU/T
   JQe/+UgO3gJKVy9qgqNBsrCbwkqaCtFCfLewJ25+Y7Dc4ac3LsIRzLFbh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="343097563"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="343097563"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 10:41:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="856196683"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="856196683"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jun 2023 10:41:08 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 10:41:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 10:41:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 10:41:07 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 10:41:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHmGkHLBfTY2wOMJPing7ym1wzyPxrnRdhVWvZvXtbDPBcTrmh+aVieMEnMjr5kmYf89robzv6FNlOpd7Ik0zfumJHXaV1OWB1lf+Eq0RoaXhiSRwVNB0ZK5Q72nt/I95ajKW+tOcQAsysv8IIeuJnG4UH0MjxP9l0vjMCL7Fv4RZP9eO37qATZWzBDxHEWzb5+0AQqQ3I7xspxXauw3jcZN6LTUmOKek8oWCAXeXvCDV42nWcUMjCi5UibqC6A9yXrSvAx46ojxb/lqAIpFcCzFgj86hlFMVkhhKrlLNy7RYwVH68G4qntbYdKaiLuPKQRIaAhbtFRwhbvAk/e2bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGj/EPbDrO6qiRwcnhHnzR/tX5+oGt2KQHXUF+U2mjs=;
 b=PwCbD+mFCjjST5AyiPaCOC6XX70H7sHbj4e6GNUWqWva/mQ/q0ii1+pGA9QDayVogclBXyEXVMxr/c+DgnKWjQmLNRlg7gwXqhWDsXK8KIm4ExVosaFgQKA4PgRguV565FHQiQcUXYfHIeHkT2CK/SmUi+bd66r5o+JPFIAXiJRz8LCyyTByVEBNDP6/BapWpSTzkCW/e2Ch70GDptZ8UAFooRY9505vDPG9cNGnr8jIahzjOpsCrE+TMJrhJgunanjEEbuiePIFdK0no5EkH+l5/blcpvpaTZUx0dCAJVV2EAQaToQfAYJTkxgG+UgJmXP1y0OHwshFw7Mk/AeSMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by SN7PR11MB7974.namprd11.prod.outlook.com (2603:10b6:806:2e7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Tue, 13 Jun
 2023 17:41:04 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::7f9a:95b2:479f:82ed]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::7f9a:95b2:479f:82ed%4]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 17:41:04 +0000
From:   "Ma, Yu" <yu.ma@intel.com>
To:     Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Zhu, Lipeng" <lipeng.zhu@intel.com>,
        "Deng, Pan" <pan.deng@intel.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "Li, Tianyou" <tianyou.li@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>
Subject: RE: [PATCH v3] percpu-internal/pcpu_chunk: Re-layout pcpu_chunk
 structure to reduce false sharing
Thread-Topic: [PATCH v3] percpu-internal/pcpu_chunk: Re-layout pcpu_chunk
 structure to reduce false sharing
Thread-Index: AQHZm0T+4yC2sgfKTU6V4/ytcwJHlq+Ht1KAgAADaQCAAS5fUA==
Date:   Tue, 13 Jun 2023 17:41:04 +0000
Message-ID: <SN7PR11MB7590C671036F43C0536E4D6DE155A@SN7PR11MB7590.namprd11.prod.outlook.com>
References: <ZINtij2HhIu9h9Wx@V92F7Y9K0C.lan>
 <20230610030730.110074-1-yu.ma@intel.com>
 <20230612144331.b1d069bce4ba3800fdd62738@linux-foundation.org>
 <ZIeUYNd8sAVm1xE8@V92F7Y9K0C.lan>
In-Reply-To: <ZIeUYNd8sAVm1xE8@V92F7Y9K0C.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|SN7PR11MB7974:EE_
x-ms-office365-filtering-correlation-id: bd0e8548-37e9-4259-d871-08db6c355c65
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aapO6i7tUMT09VquewuJd1IvMIro+8BaN8ZsijMN1gqQgQ3jJsEDCmKL/Lt+Akv+rB5AunPgiVjK79SmEJWzlaaoCVsBBxXSvp+kvWeCu9S4IhnHWbfcRPPQSFOxQQVUgS70dDvhQ7rr2B7DiXnxlG3lfGE2SHaOdCgr6FfP1FuU8lHwtKvyUX2VzNuzvuGIVtOqUMA7Kox8lMULJpTx0qAJ1h7UpXl9vxkjVnT5vJjzaiDrzGoGn9IDHPVewd+sqiXGx0T8xYJW2MuiyLdBB6SEogIgVQoE8//V7f65ya1aAeMjr0TlieFk8jnYnUsKsgabECiJ8OKz75Ul5sudpba/6GP7XCNabxa2QNjIr7LEL5xn3UW8hVvSqnSo4L4ilqxJL9V1gEIIYeoL2FJORN/snignMBTv8GioNCIa4Z1YZezcC7gVUqyasWM15f5akmf26WlOds/Qm4YPFttWbNS+9xuz2bXQ+ahm8AsPjvb9+J5gMtWqegHznsslbdoE+5om5pGHt73TXPQWz8tGwdxZ3xY4/1V6RL5NI3fJJ0TUjNCu6vIv00zowVA90HRi67WLpqmJV/Xyc+nCQ2B+d13pE/FRhMaw6rHTq3BvICZEkTIUMMOpcvz7G8kjAQWWcl5qpodwdZYStya5Vgz3zw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(4326008)(316002)(8936002)(66446008)(66946007)(64756008)(66476007)(41300700001)(66556008)(52536014)(76116006)(186003)(54906003)(2906002)(110136005)(478600001)(8676002)(5660300002)(71200400001)(7696005)(9686003)(33656002)(6506007)(55016003)(122000001)(26005)(83380400001)(86362001)(38070700005)(82960400001)(38100700002)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVU3VFZMbzJzMGsxWTczR1JIK3dVbUViaHlGcVdlTWRLNlhRSWE0NDI2aXRR?=
 =?utf-8?B?czlmK2xmL3ZKamEyZ3RMMkwzRW9KQUxxZ2hFYU5RTGUycDVNUkNMdXQ1ajlI?=
 =?utf-8?B?Z0tHdVB1cTRUUVRjbTNrMTQvZDNqeFlUZWM0ayt3NTVrZDZwTHlZay9GcXJo?=
 =?utf-8?B?dHFHSEFSc0tBZ1J1dURMeUt2cHVWVWVRMnY5TTZGZVpsSEZBcFBZWk1tMUFz?=
 =?utf-8?B?SDRnTUMrU1JvSGNaNktESS9WUmhWVzJhb1BMc1JSazVGb3VrbkNhLzRRbzZX?=
 =?utf-8?B?SCtoa2x2WG1MRDJFNUZHOHBKR1l2eGpaSzg2S0thVnovRDlkQUpOUTV3dks2?=
 =?utf-8?B?MUxMVDIxWTcxMVF0ajQ0aG5HNDhyU0ZxMWtzU0R1ZEdQYWFNdzFvbmRLNGVH?=
 =?utf-8?B?MUdJYjJ4dHFQZ21FM0N6anRtblltTzJ1ZjlHeXNXUVAyeU5KTWpEbDZmb2Qx?=
 =?utf-8?B?MUgxeGM2MTNGeldkN0xtNTJabmRxMERtc3pOU0UzL0tSRTVvTHdCVjlydWJ1?=
 =?utf-8?B?YmxjSElqSkEybUhSaVJGM0plaG52L3lDWmJ4NUR0dUNVZTFtMk11ektEcXl1?=
 =?utf-8?B?blBVeUJha2J2MGdxQmtTNitweHBpNU1UMkNmcGVDSzlSM05Jbm8vNXZuQ3Y3?=
 =?utf-8?B?WmtjL0trTlRQMXAycU82NnFycnkyQ21HMHRIQlNUT2NldzVab0JhcFFDbHIx?=
 =?utf-8?B?dHRoSVZaeW9zYWEzcXoyNFlkZ1JwcU81UmJSQlIwSXVGamhvQXZHaFh3Z0s5?=
 =?utf-8?B?QXoyZlJmTFRBMkZSdmdnTm1XQXMrbzM2TDJ1RVA1eXpENVZ3V2NJelp4Z05m?=
 =?utf-8?B?VVVCOE9zZjBPUndqdXBybTJSSnZFNHBseVhwWlBKOHpJTGNsMm4wOFVpRXdt?=
 =?utf-8?B?dWs2dUE5M3dqUjE1alB0VU14b2JNN3NkRU84dklEcWFGUUNpK0hJN1N1RXE5?=
 =?utf-8?B?R2xVenVQZk5OOHdaekNFcG1vUmdEUnZQMC9mL3M1djdDTHZMS2NMV2FTcjBX?=
 =?utf-8?B?YVlhMmZXMDU1R2l5b2xhRlNZK2ZIVXJ1aE9hd2pjMlBlRit1angwRCtXYUtk?=
 =?utf-8?B?WkFla2oyVWNTK05FQnZDR0pkUUM0djVUREVjUzR4TjAyMm52amt4RXpQUDR5?=
 =?utf-8?B?L1hQR1hlVTZnWjlMdjZrM2psdjhiS243RitwMlp2QXNyU0lweDBNbUdaOVY2?=
 =?utf-8?B?dERRcHBwa1NUVXdJOHFhWFNmY2h2SHlaeHdaZ2E2eno1UWtWa2IvNkozam9o?=
 =?utf-8?B?UTVqWTNXTmh5aHRnR3FlcGRLSk1rbzFHK2E4dTM5c0E3MTg5YmQ0Ui94TVRt?=
 =?utf-8?B?QUVJSE13ajhQYzU4L29zbzB2STVnVWRWdHpqVjdCSkVoSTNtWmZJVUllQjg1?=
 =?utf-8?B?YmFlYWhTMFlKVTJGK25qTFFYaWF2NUdqR2R2WlNWd1pwNFBFaWFhRlMzckdI?=
 =?utf-8?B?VjlxekxlWWZvV2dRT0Nvc0I0NE5ONGpwTkJnUld3SjVOVUpSVXlJWlcvSFhK?=
 =?utf-8?B?K3hyNW9IOEFyWnA5S0VZRkw2TUFJWkhRR2puSDlWaFN5YUlkSlpWdVR5Vkkz?=
 =?utf-8?B?aThhQmY4eDBES0FQSU5jQzA3dXR5WGYrK2xGQ01QTElXNFV2UlYySDdVbXpz?=
 =?utf-8?B?bEdqajhCREEvcWJveUZrbEVUZkZyTkZ4MGczQjdCaFRQQUtnTGY1RFYwSTJY?=
 =?utf-8?B?dDU0OFhiR0xQWU1Pek9yMExFZ1crdldjM09aOVNFRGNKYm9MbG02cFllbVlx?=
 =?utf-8?B?ZXVSWCtXUkZxM2ovQ0ladkV3Sy9IWmlud3p3OGpQek5BOVc5aXc0Z0g4Qk1r?=
 =?utf-8?B?ZTN2YTVtSW5OYnhFSnpZYUVPbHhWU1loUllJWGhsSjJ0Wnp1VVl3NFNPZjhT?=
 =?utf-8?B?bVlCcmR4Sm1IOGpYb1c4UGh0M3d3cXVyanBFUFJCSStLUmI4MUpvWXpxM1N2?=
 =?utf-8?B?aWlCY2VuM0U2eFZCY2YwSlRyS1V1Qmo5SzM2ZW40azd5REVqMzc5a2M5SHA0?=
 =?utf-8?B?Yk1aRWFEYTVMSytCc2F4WU1TOTZLaXh0bzJ0RlBXOUF3WU1qU3hONjR4dHdW?=
 =?utf-8?B?Q1dZRnptMktqVFY4eEhzK1dUSDZJK1dyWHRMZW1OREF6TWZQRnVZcGlmcjNk?=
 =?utf-8?Q?1jCw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0e8548-37e9-4259-d871-08db6c355c65
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 17:41:04.1742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bXDSKYTI9YJ16XZ/56QZ0estdhZqzHm3N2PjjQfZAV1yZOVj/kDYitIp0i2mAt0g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7974
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IEhpIEFuZHJldywNCj4gDQo+IE9uIE1vbiwgSnVuIDEyLCAyMDIzIGF0IDAyOjQzOjMxUE0g
LTA3MDAsIEFuZHJldyBNb3J0b24gd3JvdGU6DQo+ID4gT24gRnJpLCAgOSBKdW4gMjAyMyAyMzow
NzozMCAtMDQwMCBZdSBNYSA8eXUubWFAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+ID4gV2hl
biBydW5uaW5nIFVuaXhCZW5jaC9FeGVjbCB0aHJvdWdocHV0IGNhc2UsIGZhbHNlIHNoYXJpbmcg
aXMNCj4gPiA+IG9ic2VydmVkIGR1ZSB0byBmcmVxdWVudCByZWFkIG9uIGJhc2VfYWRkciBhbmQg
d3JpdGUgb24gZnJlZV9ieXRlcywNCj4gY2h1bmtfbWQuDQo+ID4gPg0KPiA+ID4gVW5peEJlbmNo
L0V4ZWNsIHJlcHJlc2VudHMgYSBjbGFzcyBvZiB3b3JrbG9hZCB3aGVyZSBiYXNoIHNjcmlwdHMN
Cj4gPiA+IGFyZSBzcGF3bmVkIGZyZXF1ZW50bHkgdG8gZG8gc29tZSBzaG9ydCBqb2JzLiBJdCB3
aWxsIGRvIHN5c3RlbSBjYWxsDQo+ID4gPiBvbiBleGVjbCBmcmVxdWVudGx5LCBhbmQgZXhlY2wg
d2lsbCBjYWxsIG1tX2luaXQgdG8gaW5pdGlhbGl6ZQ0KPiA+ID4gbW1fc3RydWN0IG9mIHRoZSBw
cm9jZXNzLiBtbV9pbml0IHdpbGwgY2FsbCBfX3BlcmNwdV9jb3VudGVyX2luaXQNCj4gPiA+IGZv
ciBwZXJjcHVfY291bnRlcnMgaW5pdGlhbGl6YXRpb24uIFRoZW4gcGNwdV9hbGxvYyBpcyBjYWxs
ZWQgdG8NCj4gPiA+IHJlYWQgdGhlIGJhc2VfYWRkciBvZiBwY3B1X2NodW5rIGZvciBtZW1vcnkg
YWxsb2NhdGlvbi4gSW5zaWRlDQo+ID4gPiBwY3B1X2FsbG9jLCBpdCB3aWxsIGNhbGwgcGNwdV9h
bGxvY19hcmVhICB0byBhbGxvY2F0ZSBtZW1vcnkgZnJvbSBhDQo+IHNwZWNpZmllZCBjaHVuay4N
Cj4gPiA+IFRoaXMgZnVuY3Rpb24gd2lsbCB1cGRhdGUgImZyZWVfYnl0ZXMiIGFuZCAiY2h1bmtf
bWQiIHRvIHJlY29yZCB0aGUNCj4gPiA+IHJlc3QgZnJlZSBieXRlcyBhbmQgb3RoZXIgbWV0YSBk
YXRhIGZvciB0aGlzIGNodW5rLiBDb3JyZXNwb25kaW5nbHksDQo+ID4gPiBwY3B1X2ZyZWVfYXJl
YSB3aWxsIGFsc28gdXBkYXRlIHRoZXNlIDIgbWVtYmVycyB3aGVuIGZyZWUgbWVtb3J5Lg0KPiA+
ID4gQ2FsbCB0cmFjZSBmcm9tIHBlcmYgaXMgYXMgYmVsb3c6DQo+ID4gPiArICAgNTcuMTUlICAw
LjAxJSAgZXhlY2wgICBba2VybmVsLmthbGxzeW1zXSBba10gX19wZXJjcHVfY291bnRlcl9pbml0
DQo+ID4gPiArICAgNTcuMTMlICAwLjkxJSAgZXhlY2wgICBba2VybmVsLmthbGxzeW1zXSBba10g
cGNwdV9hbGxvYw0KPiA+ID4gLSAgIDU1LjI3JSA1NC41MSUgIGV4ZWNsICAgW2tlcm5lbC5rYWxs
c3ltc10gW2tdIG9zcV9sb2NrDQo+ID4gPiAgICAtIDUzLjU0JSAweDY1NDI3ODY5NmU1NTJmMzQN
Cj4gPiA+ICAgICAgICAgbWFpbg0KPiA+ID4gICAgICAgICBfX2V4ZWN2ZQ0KPiA+ID4gICAgICAg
ICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUNCj4gPiA+ICAgICAgICAgZG9fc3lzY2Fs
bF82NA0KPiA+ID4gICAgICAgICBfX3g2NF9zeXNfZXhlY3ZlDQo+ID4gPiAgICAgICAgIGRvX2V4
ZWN2ZWF0X2NvbW1vbi5pc3JhLjQ3DQo+ID4gPiAgICAgICAgIGFsbG9jX2Jwcm0NCj4gPiA+ICAg
ICAgICAgbW1faW5pdA0KPiA+ID4gICAgICAgICBfX3BlcmNwdV9jb3VudGVyX2luaXQNCj4gPiA+
ICAgICAgICAgcGNwdV9hbGxvYw0KPiA+ID4gICAgICAgLSBfX211dGV4X2xvY2suaXNyYS4xNw0K
PiA+ID4NCj4gPiA+IEluIGN1cnJlbnQgcGNwdV9jaHVuayBsYXlvdXQsIOKAmGJhc2VfYWRkcuKA
mSBpcyBpbiB0aGUgc2FtZSBjYWNoZSBsaW5lDQo+ID4gPiB3aXRoIOKAmGZyZWVfYnl0ZXPigJkg
YW5kIOKAmGNodW5rX21k4oCZLCBhbmQg4oCYYmFzZV9hZGRy4oCZIGlzIGF0IHRoZSBsYXN0IDgN
Cj4gPiA+IGJ5dGVzLiBUaGlzIHBhdGNoIG1vdmVzIOKAmGJvdW5kX21hcOKAmSB1cCB0byDigJhi
YXNlX2FkZHLigJksIHRvIGxldA0KPiA+ID4g4oCYYmFzZV9hZGRy4oCZIGxvY2F0ZSBpbiBhIG5l
dyBjYWNoZWxpbmUuDQo+ID4gPg0KPiA+ID4gV2l0aCB0aGlzIGNoYW5nZSwgb24gSW50ZWwgU2Fw
cGhpcmUgUmFwaWRzIDExMkMvMjI0VCBwbGF0Zm9ybSwgYmFzZWQNCj4gPiA+IG9uIHY2LjQtcmM0
LCB0aGUgMTYwIHBhcmFsbGVsIHNjb3JlIGltcHJvdmVzIGJ5IDI0JS4NCj4gPg0KPiA+IFdlbGwg
dGhhdCdzIG5pY2UuDQo+ID4NCj4gPiA+DQo+ID4gPiAuLi4NCj4gPiA+DQo+ID4gPiAtLS0gYS9t
bS9wZXJjcHUtaW50ZXJuYWwuaA0KPiA+ID4gKysrIGIvbW0vcGVyY3B1LWludGVybmFsLmgNCj4g
PiA+IEBAIC00MSwxMCArNDEsMTcgQEAgc3RydWN0IHBjcHVfY2h1bmsgew0KPiA+ID4gIAlzdHJ1
Y3QgbGlzdF9oZWFkCWxpc3Q7CQkvKiBsaW5rZWQgdG8gcGNwdV9zbG90IGxpc3RzICovDQo+ID4g
PiAgCWludAkJCWZyZWVfYnl0ZXM7CS8qIGZyZWUgYnl0ZXMgaW4gdGhlIGNodW5rICovDQo+ID4g
PiAgCXN0cnVjdCBwY3B1X2Jsb2NrX21kCWNodW5rX21kOw0KPiA+ID4gLQl2b2lkCQkJKmJhc2Vf
YWRkcjsJLyogYmFzZSBhZGRyZXNzIG9mIHRoaXMgY2h1bmsNCj4gKi8NCj4gPiA+ICsJdW5zaWdu
ZWQgbG9uZwkJKmJvdW5kX21hcDsJLyogYm91bmRhcnkgbWFwICovDQo+ID4gPiArDQo+ID4gPiAr
CS8qDQo+ID4gPiArCSAqIGJhc2VfYWRkciBpcyB0aGUgYmFzZSBhZGRyZXNzIG9mIHRoaXMgY2h1
bmsuDQo+ID4gPiArCSAqIFRvIHJlZHVjZSBmYWxzZSBzaGFyaW5nLCBjdXJyZW50IGxheW91dCBp
cyBvcHRpbWl6ZWQgdG8gbWFrZSBzdXJlDQo+ID4gPiArCSAqIGJhc2VfYWRkciBsb2NhdGUgaW4g
dGhlIGRpZmZlcmVudCBjYWNoZWxpbmUgd2l0aCBmcmVlX2J5dGVzIGFuZA0KPiA+ID4gKwkgKiBj
aHVua19tZC4NCj4gPiA+ICsJICovDQo+ID4gPiArCXZvaWQJCQkqYmFzZV9hZGRyIF9fX19jYWNo
ZWxpbmVfYWxpZ25lZF9pbl9zbXA7DQo+ID4gPg0KPiA+ID4gIAl1bnNpZ25lZCBsb25nCQkqYWxs
b2NfbWFwOwkvKiBhbGxvY2F0aW9uIG1hcCAqLw0KPiA+ID4gLQl1bnNpZ25lZCBsb25nCQkqYm91
bmRfbWFwOwkvKiBib3VuZGFyeSBtYXAgKi8NCj4gPiA+ICAJc3RydWN0IHBjcHVfYmxvY2tfbWQJ
Km1kX2Jsb2NrczsJLyogbWV0YWRhdGEgYmxvY2tzICovDQo+ID4gPg0KPiA+ID4gIAl2b2lkCQkJ
KmRhdGE7CQkvKiBjaHVuayBkYXRhICovDQo+ID4NCj4gPiBUaGlzIHdpbGwgb2YgY291cnNlIGNv
bnN1bWUgbW9yZSBtZW1vcnkuICBEbyB3ZSBoYXZlIGEgZmVlbCBmb3IgdGhlDQo+ID4gd29yc3Qt
Y2FzZSBpbXBhY3Qgb2YgdGhpcz8NCj4gPg0KPiANCj4gVGhlIHBjcHVfY2h1bmsgc3RydWN0IGlz
IGEgYmFja2luZyBkYXRhIHN0cnVjdHVyZSBwZXIgY2h1bmssIHNvIHRoZQ0KPiBhZGRpdGlvbmFs
IG1lbW9yeSBzaG91bGQgbm90IGJlIGRyYW1hdGljLiBBIGNodW5rIGNvdmVycyBiYWxscGFyayBi
ZXR3ZWVuDQo+IDY0a2IgYW5kIDUxMmtiIG1lbW9yeSBkZXBlbmRpbmcgb24gc29tZSBjb25maWcg
YW5kIGJvb3QgdGltZSBzdHVmZiwgc28gSQ0KPiBiZWxpZXZlIHRoZSBhZGRpdGlvbmFsIG1lbW9y
eSB1c2VkIGhlcmUgaXMgbm9taW5hbCBhdCBiZXN0Lg0KPiANCj4gV29ya2luZyB0aGUgI3Mgb24g
bXkgZGVza3RvcDoNCj4gUGVyY3B1OiAgICAgICAgICAgIDU4NjI0IGtCDQo+IDI4IGNvcmVzIC0+
IH4yLjFNQiBvZiBwZXJjcHUgbWVtb3J5Lg0KPiBBdCBzYXkgfjEyOEtCIHBlciBjaHVuayAtPiAz
MyBjaHVua3MsIGdlbmVyb3VzbHkgNDAgY2h1bmtzLg0KPiBBZGRpbmcgYWxpZ25tZW50IG1pZ2h0
IGJ1bXAgdGhlIGNodW5rIHNpemUgfjY0IGJ5dGVzLCBzbyBpbiB0b3RhbCB+MktCIG9mDQo+IG92
ZXJoZWFkPw0KPiANCj4gSSBiZWxpZXZlIHdlIGNhbiBkbyBhIGxpdHRsZSBiZXR0ZXIgdG8gYXZv
aWQgZWF0aW5nIHRoYXQgZnVsbCBwYWRkaW5nLCBzbyBsaWtlbHkNCj4gbGVzcyB0aGFuIHRoYXQu
DQo+IA0KPiBBY2tlZC1ieTogRGVubmlzIFpob3UgPGRlbm5pc0BrZXJuZWwub3JnPg0KPg0KDQpU
aGFua3MgQW5kcmV3IGFuZCBEZW5uaXMgZm9yIGFncmVlbWVudCBvbiB0aGUgcGF0Y2guIA0KVGhl
IGxheW91dCBvZiB0aGlzIHN0cnVjdHVyZSAocHJpbnRlZCBieSBwYWhvbGUpIGJlZm9yZSBhbmQg
YWZ0ZXIgdGhpcyBwYXRjaCBpcyBhcyBiZWxvdyBmb3IgcmVmZXJlbmNlLiANClRoZSBkZWZhdWx0
IHNpemUgaXMgMTM2IEJ5dGVzIHdpdGggMyBjYWNoZWxpbmVzLiBXaXRoIHBhdGNoIHYzLCBpdCBp
cyAxOTIgQnl0ZXMgd2l0aCA1NiBleHRyYSBwYWRkaW5nLg0KRm9yICJfX19fY2FjaGVsaW5lX2Fs
aWduZWRfaW5fc21wICIsIGluaXRpYWxseSBpdCB3YXMgbm90IGFkZGVkIHdpdGggdGhlIHNhbWUg
Y29uY2VybiBvbiBtZW1vcnksIA0KYXMgaXQgY2FuIG9idGFpbiB0aGUgc2FtZSBwZXJmb3JtYW5j
ZSBnYWluIHdpdGggcmVzaHVmZmxlIG9uIGJhc2VfYWRkciBvbmx5LiBUaGFua3MgdG8gRGVubmlz
IHdpdGgNCmV4cGVydGlzZSBvbiB0aGUgb3ZlcmFsbCB1c2FnZSwgaXQgaXMgYWRkZWQgdG8gYmUg
bW9yZSBjbGVhciBhbmQgYnJpbmcgY29udmVuaWVuY2UgZm9yIGZ1dHVyZSBjaGFuZ2VzLg0KDQot
LWRlZmF1bHQgdjYuNC1yYzQtLQ0Kc3RydWN0IHBjcHVfY2h1bmsgew0KICAgICAgICBzdHJ1Y3Qg
bGlzdF9oZWFkICAgICAgICAgICBsaXN0OyAgICAgICAgICAgICAgICAgLyogICAgIDAgICAgMTYg
Ki8NCiAgICAgICAgaW50ICAgICAgICAgICAgICAgICAgICAgICAgZnJlZV9ieXRlczsgICAgICAg
ICAgIC8qICAgIDE2ICAgICA0ICovDQogICAgICAgIHN0cnVjdCBwY3B1X2Jsb2NrX21kICAgICAg
IGNodW5rX21kOyAgICAgICAgICAgICAvKiAgICAyMCAgICAzMiAqLw0KDQogICAgICAgIC8qIFhY
WCA0IGJ5dGVzIGhvbGUsIHRyeSB0byBwYWNrICovDQoNCiAgICAgICAgdm9pZCAqICAgICAgICAg
ICAgICAgICAgICAgYmFzZV9hZGRyOyAgICAgICAgICAgIC8qICAgIDU2ICAgICA4ICovDQogICAg
ICAgIC8qIC0tLSBjYWNoZWxpbmUgMSBib3VuZGFyeSAoNjQgYnl0ZXMpIC0tLSAqLw0KICAgICAg
ICBsb25nIHVuc2lnbmVkIGludCAqICAgICAgICBhbGxvY19tYXA7ICAgICAgICAgICAgLyogICAg
NjQgICAgIDggKi8NCiAgICAgICAgbG9uZyB1bnNpZ25lZCBpbnQgKiAgICAgICAgYm91bmRfbWFw
OyAgICAgICAgICAgIC8qICAgIDcyICAgICA4ICovDQogICAgICAgIHN0cnVjdCBwY3B1X2Jsb2Nr
X21kICogICAgIG1kX2Jsb2NrczsgICAgICAgICAgICAvKiAgICA4MCAgICAgOCAqLw0KICAgICAg
ICB2b2lkICogICAgICAgICAgICAgICAgICAgICBkYXRhOyAgICAgICAgICAgICAgICAgLyogICAg
ODggICAgIDggKi8NCiAgICAgICAgYm9vbCAgICAgICAgICAgICAgICAgICAgICAgaW1tdXRhYmxl
OyAgICAgICAgICAgIC8qICAgIDk2ICAgICAxICovDQogICAgICAgIGJvb2wgICAgICAgICAgICAg
ICAgICAgICAgIGlzb2xhdGVkOyAgICAgICAgICAgICAvKiAgICA5NyAgICAgMSAqLw0KDQogICAg
ICAgIC8qIFhYWCAyIGJ5dGVzIGhvbGUsIHRyeSB0byBwYWNrICovDQoNCiAgICAgICAgaW50ICAg
ICAgICAgICAgICAgICAgICAgICAgc3RhcnRfb2Zmc2V0OyAgICAgICAgIC8qICAgMTAwICAgICA0
ICovDQogICAgICAgIGludCAgICAgICAgICAgICAgICAgICAgICAgIGVuZF9vZmZzZXQ7ICAgICAg
ICAgICAvKiAgIDEwNCAgICAgNCAqLw0KDQogICAgICAgIC8qIFhYWCA0IGJ5dGVzIGhvbGUsIHRy
eSB0byBwYWNrICovDQoNCiAgICAgICAgc3RydWN0IG9ial9jZ3JvdXAgKiAqICAgICAgb2JqX2Nn
cm91cHM7ICAgICAgICAgIC8qICAgMTEyICAgICA4ICovDQogICAgICAgIGludCAgICAgICAgICAg
ICAgICAgICAgICAgIG5yX3BhZ2VzOyAgICAgICAgICAgICAvKiAgIDEyMCAgICAgNCAqLw0KICAg
ICAgICBpbnQgICAgICAgICAgICAgICAgICAgICAgICBucl9wb3B1bGF0ZWQ7ICAgICAgICAgLyog
ICAxMjQgICAgIDQgKi8NCiAgICAgICAgLyogLS0tIGNhY2hlbGluZSAyIGJvdW5kYXJ5ICgxMjgg
Ynl0ZXMpIC0tLSAqLw0KICAgICAgICBpbnQgICAgICAgICAgICAgICAgICAgICAgICBucl9lbXB0
eV9wb3BfcGFnZXM7ICAgLyogICAxMjggICAgIDQgKi8NCg0KICAgICAgICAvKiBYWFggNCBieXRl
cyBob2xlLCB0cnkgdG8gcGFjayAqLw0KDQogICAgICAgIGxvbmcgdW5zaWduZWQgaW50ICAgICAg
ICAgIHBvcHVsYXRlZFtdOyAgICAgICAgICAvKiAgIDEzNiAgICAgMCAqLw0KDQogICAgICAgIC8q
IHNpemU6IDEzNiwgY2FjaGVsaW5lczogMywgbWVtYmVyczogMTcgKi8NCiAgICAgICAgLyogc3Vt
IG1lbWJlcnM6IDEyMiwgaG9sZXM6IDQsIHN1bSBob2xlczogMTQgKi8NCiAgICAgICAgLyogbGFz
dCBjYWNoZWxpbmU6IDggYnl0ZXMgKi8NCn07DQoNCi0td2l0aCBwYXRjaCB2My0tDQpzdHJ1Y3Qg
cGNwdV9jaHVuayB7DQogICAgICAgIHN0cnVjdCBsaXN0X2hlYWQgICAgICAgICAgIGxpc3Q7ICAg
ICAgICAgICAgICAgICAvKiAgICAgMCAgICAxNiAqLw0KICAgICAgICBpbnQgICAgICAgICAgICAg
ICAgICAgICAgICBmcmVlX2J5dGVzOyAgICAgICAgICAgLyogICAgMTYgICAgIDQgKi8NCiAgICAg
ICAgc3RydWN0IHBjcHVfYmxvY2tfbWQgICAgICAgY2h1bmtfbWQ7ICAgICAgICAgICAgIC8qICAg
IDIwICAgIDMyICovDQoNCiAgICAgICAgLyogWFhYIDQgYnl0ZXMgaG9sZSwgdHJ5IHRvIHBhY2sg
Ki8NCg0KICAgICAgICBsb25nIHVuc2lnbmVkIGludCAqICAgICAgICBib3VuZF9tYXA7ICAgICAg
ICAgICAgLyogICAgNTYgICAgIDggKi8NCiAgICAgICAgLyogLS0tIGNhY2hlbGluZSAxIGJvdW5k
YXJ5ICg2NCBieXRlcykgLS0tICovDQogICAgICAgIHZvaWQgKiAgICAgICAgICAgICAgICAgICAg
IGJhc2VfYWRkcjsgICAgICAgICAgICAvKiAgICA2NCAgICAgOCAqLw0KICAgICAgICBsb25nIHVu
c2lnbmVkIGludCAqICAgICAgICBhbGxvY19tYXA7ICAgICAgICAgICAgLyogICAgNzIgICAgIDgg
Ki8NCiAgICAgICAgc3RydWN0IHBjcHVfYmxvY2tfbWQgKiAgICAgbWRfYmxvY2tzOyAgICAgICAg
ICAgIC8qICAgIDgwICAgICA4ICovDQogICAgICAgIHZvaWQgKiAgICAgICAgICAgICAgICAgICAg
IGRhdGE7ICAgICAgICAgICAgICAgICAvKiAgICA4OCAgICAgOCAqLw0KICAgICAgICBib29sICAg
ICAgICAgICAgICAgICAgICAgICBpbW11dGFibGU7ICAgICAgICAgICAgLyogICAgOTYgICAgIDEg
Ki8NCiAgICAgICAgYm9vbCAgICAgICAgICAgICAgICAgICAgICAgaXNvbGF0ZWQ7ICAgICAgICAg
ICAgIC8qICAgIDk3ICAgICAxICovDQoNCiAgICAgICAgLyogWFhYIDIgYnl0ZXMgaG9sZSwgdHJ5
IHRvIHBhY2sgKi8NCg0KICAgICAgICBpbnQgICAgICAgICAgICAgICAgICAgICAgICBzdGFydF9v
ZmZzZXQ7ICAgICAgICAgLyogICAxMDAgICAgIDQgKi8NCiAgICAgICAgaW50ICAgICAgICAgICAg
ICAgICAgICAgICAgZW5kX29mZnNldDsgICAgICAgICAgIC8qICAgMTA0ICAgICA0ICovDQoNCiAg
ICAgICAgLyogWFhYIDQgYnl0ZXMgaG9sZSwgdHJ5IHRvIHBhY2sgKi8NCg0KICAgICAgICBzdHJ1
Y3Qgb2JqX2Nncm91cCAqICogICAgICBvYmpfY2dyb3VwczsgICAgICAgICAgLyogICAxMTIgICAg
IDggKi8NCiAgICAgICAgaW50ICAgICAgICAgICAgICAgICAgICAgICAgbnJfcGFnZXM7ICAgICAg
ICAgICAgIC8qICAgMTIwICAgICA0ICovDQogICAgICAgIGludCAgICAgICAgICAgICAgICAgICAg
ICAgIG5yX3BvcHVsYXRlZDsgICAgICAgICAvKiAgIDEyNCAgICAgNCAqLw0KICAgICAgICAvKiAt
LS0gY2FjaGVsaW5lIDIgYm91bmRhcnkgKDEyOCBieXRlcykgLS0tICovDQogICAgICAgIGludCAg
ICAgICAgICAgICAgICAgICAgICAgIG5yX2VtcHR5X3BvcF9wYWdlczsgICAvKiAgIDEyOCAgICAg
NCAqLw0KDQogICAgICAgIC8qIFhYWCA0IGJ5dGVzIGhvbGUsIHRyeSB0byBwYWNrICovDQoNCiAg
ICAgICAgbG9uZyB1bnNpZ25lZCBpbnQgICAgICAgICAgcG9wdWxhdGVkW107ICAgICAgICAgIC8q
ICAgMTM2ICAgICAwICovDQoNCiAgICAgICAgLyogc2l6ZTogMTkyLCBjYWNoZWxpbmVzOiAzLCBt
ZW1iZXJzOiAxNyAqLw0KICAgICAgICAvKiBzdW0gbWVtYmVyczogMTIyLCBob2xlczogNCwgc3Vt
IGhvbGVzOiAxNCAqLw0KICAgICAgICAvKiBwYWRkaW5nOiA1NiAqLw0KfTsNCg0KDQpSZWdhcmRz
DQpZdQ0KDQo+IFRoYW5rcywNCj4gRGVubmlzDQo=
