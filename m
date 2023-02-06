Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F0168B709
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 09:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjBFIFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 03:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBFIFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 03:05:34 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF45126E3;
        Mon,  6 Feb 2023 00:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675670732; x=1707206732;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JvEd60JqOHHQhyDJ+NDXe6LYLL/Z97TT2fvqp7a8vUA=;
  b=QHRoDlIonxoJ2pUfLzBrQeJk+neldR/B6swtqvq1W5PKL+7QofhYd46Q
   heWyi9coQDKG3PiTIFUHIOpNnS6Vb1AOYWUkekeiMlAbYfPFbt3lfSLuc
   2XylXyz5OFszulWEjrRe/eUzqTtyqSX6YBPdSWbwiZJi9D/fkBbS6Awqz
   4RMyzelxwxKg8nlzIR/jrcu+7FFgKbYYhWbZlpXoy8ntAO7GK8KQy+0Fk
   f+4eVyhtlyJK4rEWCl8SD6ksYqtIB3F7RtQQey/hIaFt8z22KKs9/cf/l
   Y9H/jThnLhWM4AKbcDYSkb1nR/YZwumwER+PF6mG/XjEgb0ycRO7EzvRO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="393750883"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="393750883"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 00:05:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="659765580"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="659765580"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 06 Feb 2023 00:05:28 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 00:05:27 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 00:05:27 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 00:05:27 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 00:05:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWgRHrfTwvdcQq+D9c3HRyaKYDY3uiKf2CtUBZ0ui+tI7Bp5xmtKAd3/R232rc/rJ1QJqoL1p+x6vVFGSqvMDVMj+CJx3+K0NdP5Xz1rFuUQkI59852IbMlJjBL361/vyR72e6FQ18ltP7YwFaVBYXd+ig3ctP+l0LoLGwejfk5ZtT0/i9jsZy/PTNtz8KrQCOl6Pyb7xmc8+tjo/V3srM0qu5MUBUMJ5Y2WE1ttNVTvCVU7fUNYEmNmvxywMY+EHve+dtpHd5YH7Jk+MdN+/Xs9pWxLDwzHWz2Gum6BzDsutVBwzU1LawXuvDu/0xA2M5vx87YTRNBgN+YIfBLL2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvEd60JqOHHQhyDJ+NDXe6LYLL/Z97TT2fvqp7a8vUA=;
 b=L78LpjTLDOQrxRYiz48UveYZBVB0XUETzBJke4HKCSSjyg3IxKJ0tRfy7qbu7GXmEbo7nwRfdmL8KFNUKmnKsXFNM//H9l1FQ1HG00RF6pVG6AigeFGZue0TU3mGDbeMel0I/+XaX00cYtgxDXT0uxN3m8OLxavNZPauo2T+ijxaFVd1t99UOw75IlCBtgzQevSq4T8ihkzzX18pwnorOB4WCf3FnBAwFOxrv+Lms+7oaXgkZMjzWtFVoTfVFglT+odDZNS1HPCdYg5ja1mVsqdG6VhdhgeA8C841DpUR49Az2Z6JKHeOt/86lyvzFRKoNBWfAuqA1h7GbtvMPLMHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by PH7PR11MB7719.namprd11.prod.outlook.com (2603:10b6:510:2b4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Mon, 6 Feb
 2023 08:05:24 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::1ff7:9b2e:56cd:9ee8]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::1ff7:9b2e:56cd:9ee8%9]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 08:05:24 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 0/2] intel_powerclamp: New module parameter
Thread-Topic: [PATCH v2 0/2] intel_powerclamp: New module parameter
Thread-Index: AQHZOQ3UaWBU+zkoFEWPd2N7/3LBpK7Agv+AgAC1AACAAFlrgA==
Date:   Mon, 6 Feb 2023 08:05:24 +0000
Message-ID: <468eedb9d8a839d22ffd18125d3104f8c014965c.camel@intel.com>
References: <20230205025902.2899734-1-srinivas.pandruvada@linux.intel.com>
         <a68a6f8c76cb719cd4865bd6aa726306772d4ee3.camel@intel.com>
         <60514763753f572f854f1bbf287c3c16fbbc12c3.camel@linux.intel.com>
In-Reply-To: <60514763753f572f854f1bbf287c3c16fbbc12c3.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|PH7PR11MB7719:EE_
x-ms-office365-filtering-correlation-id: 6203c720-8c1b-497b-2589-08db0818e6aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VUOft5NiLgP8wWmOUFNCdzTfCbPCrNDIo4gul+imukYe9odbmcY1wrzu82n5yeK7KXYoad9aWBlhzhpfThgNJMKCpG3fxywKRJj0q80rQdoSrMPByeXmF65gRtzjU1LeADWWz/j7651DV4JjmQ5PtBxcDj0LQl6xWZCUeTwx5TIY06Mf5b0AmKb0MLj6IC2MXC0SeZGI8TOQ6a89naUJBYWHsfZsrLH335iRfZh9BvXA/RmDg1ZwAsWwihCQ0rOzAFirwJJx/Hupi5zoPisSxn9tKBBfYCKyiEkEn/C6I2q3t3XcDmWCq+QV0XVePsb6cyw/cGgWkekoO5+lNra0GDcRklkYA8tWDER9F65BtWvCIBKpeC7qOAlYh9wwYpWC9oSPvnEYG8uLBJJe+wxZFTA7Buu6snRN1hEUjG86MR8MUwhTP1sYm5/osQnM6JzIdlHJ0QyqWg4RqGCZljPK4EXrW5AbuIHClS6iCnRCZkI95iZPN6OigiQn97HhZPDtyQmI6zq0PSqmcmD46gRzI99tv/9FYYFuqurkunitT/EzPt6OMnFgli5JovRYSIObywgUZ7Xhx6xp97PyBM42s2/XWp/faqUNpVIvSb46iOcXbqp6zlIzdH0ndbaiYc5NXMNUQii/WhZB4Os8i0gKQ7cTvDwRg3zQCxxkjd0oGrXLdmaiVR+op4TlQpzstFRSC9IUzhSJJNjzTcENQAEyaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199018)(38100700002)(26005)(6512007)(82960400001)(83380400001)(122000001)(36756003)(38070700005)(86362001)(186003)(2616005)(6506007)(41300700001)(66946007)(76116006)(66476007)(91956017)(4326008)(8936002)(2906002)(8676002)(66446008)(64756008)(66556008)(316002)(478600001)(71200400001)(6636002)(110136005)(54906003)(6486002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dG0wS1k1M1Z4MDE2WGoySWFkaU9GVUpLQytJRzdWYVhXRXlnRi9sKzFtMWZS?=
 =?utf-8?B?elNhbTc5VUppYURIeFJETFp4K1lXNUhteGozY01FUTFqY1pKQVQzYmRvZUNL?=
 =?utf-8?B?cWhjZ3RrbWU2ekVuNXNCcDNZUzRnUTZ5OUNPS3c4MHd6UkxscWRjeE9ZbzRO?=
 =?utf-8?B?eklyVFJFK3RSRG1WMVIwaDdDc2Q0L1hXamwxazlJaEtJTGRvTjM4bFNvQld1?=
 =?utf-8?B?dFJyelRVbzJJSUpFeE5LVmNndjladTRYM0RuTjQ4TkpVVUN5NlRLdlo5VjA0?=
 =?utf-8?B?emUvOUhHTkZidDNYOXBSNURST2pnczJDbnJ1bVljQmZtMnhqcVdiNUJkOU1D?=
 =?utf-8?B?LzViV0dTamN3MksxcElZWm1BRTB5UnRDd2tnc2wrTElZQUVVZmpSbnpjcEt4?=
 =?utf-8?B?aFJKV09hSFFtVStTVVMzWWhORHc0WmxrZFB6d1gyekhSQzVjcC9DN2Y2eWwr?=
 =?utf-8?B?VUg1V2dLVkhEbWQzdTd5cHlCNFgxZjR0TjBBMXFaYU4zajc5QnNzeHg5T0lM?=
 =?utf-8?B?UGtjaE9yKzdEUWVFZGwxT1Jub1RON1NBdEp2bVB4TXpzUGdMT0UxNTN0RFp3?=
 =?utf-8?B?NE9JdkNwT0V1aWJxUjBCRVpMdFpLWVg3Mzd0RmN2eGYvVlByM3RiY0grOFhW?=
 =?utf-8?B?dWVCK3hlL3hhNTBHVld2ZTM1aFZpMm5LSklxNlNNelNNQmJHWjIwYm1TTEs3?=
 =?utf-8?B?R0RBdWRpSjZmYWh4Sldic243N25XRm0veTFNak9EVFRqUVFqQTVGbWNYTGEy?=
 =?utf-8?B?cGlIUHVieDFCNjYrblFUbWwxVUp6Z0E2dWliM1VaWkZMZStjbFpwNk85SmJ6?=
 =?utf-8?B?dFQ0VVk4WHVVYVF3U0c4T05WbzlXYU9rL3RKTHlTLzJkR1AvTmVQTSt6TjJR?=
 =?utf-8?B?MHpESW5DU0RDcFdNZjRsK0FPdEdxN1oxRUJmWll0UlgrTHI0MGJTcjBacm1R?=
 =?utf-8?B?TExZL0c0T2RtVXNwK2FlNlJJdlAzVXdXU091Y2N6eEM2ZDRvaGl1dHBjSlRw?=
 =?utf-8?B?R1AwUlJJREQ2ZmdHcnhoUFpnMkhtRnJ6TGlKOFhxenZrUEJ3eHEyZ2J3bkZD?=
 =?utf-8?B?cDd6VE1XT0JvNlBxdStnR0Nhc3R3Ym1HZnM4QXJOaGZKMHdrNXllWjd2TFdD?=
 =?utf-8?B?bzBCVTVJS21DUzIyUDIreG02ZWNKbU9aN2ErOWJLZ0pHVUNvNm56dXpHN1hS?=
 =?utf-8?B?Tm1MR2pLZlJ3RmtLZW85Y0xOQ0dYWktaVjBUQlJIMjhSOW0vbGJvRkh2aVhM?=
 =?utf-8?B?Sk9XVDRQeUdKL2pYa3VYMkRDTzBBV1BRZmRZOG5GRmRmR0xtaksxYkZYTUF4?=
 =?utf-8?B?dTIzQUZJajRTZW1aY0lhb1pqNFhuQVZ3a1FxdVd0VDFmZlllQ3B1NVQxUXVH?=
 =?utf-8?B?VGsraDB0aHkyS1YzWFI3aENRSjJyVVh1aHJjSzY3WXJtUDc4K1FpcDcxbWU2?=
 =?utf-8?B?UGNxaVpFOGwyNUdtNWVkUk1mR2QyRFJaZ252VGhMeTgzcXRnMmxJS2g3Q09k?=
 =?utf-8?B?R09QbUFmMTdLcFJTNkJ2MlZnSURHYmdQclplMG94ODNERXlmUkwrTkNEU0dK?=
 =?utf-8?B?TkJQYmEvclZFQjBxVjVoQXluZGd4dEdzc25zMXFoYSswSTRjQmxETzlXWUg4?=
 =?utf-8?B?Q3RyZHlOcGpVdmVsRlFkU3diOWxzemYzK0NFMUhLczFFMVFTcUNIK2F3cEhr?=
 =?utf-8?B?WmdZVm5jcmdJVVN5ZDRMdXVnRnBuV3RxQU8xSzdEVkY4RFl0L0tkamZ2SURT?=
 =?utf-8?B?RllrYVByU2dDSFMzcDFXRG15SGh2QWxSZkRXMjNob0dabStwcWgxRGt2VWc0?=
 =?utf-8?B?R3c0WjdkcmFrcFREbmxOL2hBUlMzTDVGdUJ4MEN0R3lxeXJPNy9zNURwZmVB?=
 =?utf-8?B?VStXRDlJYk11YkIzWE15K2NIQWVxZWtNR1lDM2hnejV6MUE0bnR5UEhKOSth?=
 =?utf-8?B?NlI4V0RGUkNLWDRTR2N6OWpDRGJQalVIYkFySGJVbzNyRkpua3FxMWVQaUx0?=
 =?utf-8?B?VVVIRnVpQ1R4dXBKWGN2enVWcDJXOXlOUjdXZkVMYUQyc2NmRmtiU2dHRnR4?=
 =?utf-8?B?NHpTemxibmdZa2taNjAzUFRTUW5yOVlOdHdFby9mWGF3cUgyR1BHZDBtTzk0?=
 =?utf-8?B?R0FmSjdzMzdXcndROXhmc1R1SjVjayt3OFFUaGRNWGpnWFRaekFQM2d6eDll?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B72C3E4430EF8C4C913E46A0BB1BBCF0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6203c720-8c1b-497b-2589-08db0818e6aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 08:05:24.4892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yxAmE5TNCdVsKw019YD56OU3xNOr6/S+1zV/0OWdvdimrQQd6VJD38fRcT1tYRU0sii0s8LnAwDdAWLmWPW4LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7719
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIzLTAyLTA1IGF0IDE4OjQ1IC0wODAwLCBzcmluaXZhcyBwYW5kcnV2YWRhIHdy
b3RlOg0KPiBIaSBSdWksDQo+IA0KPiBPbiBTdW4sIDIwMjMtMDItMDUgYXQgMTU6NTcgKzAwMDAs
IFpoYW5nLCBSdWkgd3JvdGU6DQo+ID4gSGksIFNyaW5pdmFzLA0KPiA+IA0KPiA+IEZpcnN0IG9m
IGFsbCwgdGhlIHByZXZpb3VzIGJ1aWxkIGVycm9yIGlzIGdvbmUuDQo+ID4gDQo+ID4gU2Vjb25k
LCBJIGZvdW5kIHNvbWV0aGluZyBzdHJhbmdlLCB3aGljaCBtYXkgYmUgcmVsYXRlZCB3aXRoIHRo
ZQ0KPiA+IHNjaGVkdWxlciBhc3ltLXBhY2tpbmcsIHNvIENDIFJpY2FyZG8uDQo+ID4gDQo+IEkg
dGhvdWdodCB5b3UgZGlzYWJsZSBJVE1UIGJlZm9yZSBpZGxlIGluamVjdGlvbiBhbmQgcmVlbmVi
YWxlIGFmdGVyDQo+IHJlbW92YWwuDQoNCk5vLg0KDQpJIGNhbiByZXByb2R1Y2UgdGhpcyBieSBw
bGF5aW5nIHdpdGggcmF3IGludGVsX3Bvd2VyY2xhbXAgc3lzZnMga25vYnMNCmFuZCBJVE1UIGVu
YWJsZWQuDQoNCj4gDQo+IA0KPiANCj4gPiBUaGUgdGVzdCBpcyBkb25lIHdpdGggcG0gbGludXgt
aW50ZWwgYnJhbmNoDQoNCnNvcnJ5LCBJIG1lYW4gbGludXgtbmV4dCBicmFuY2guDQoNCj4gPiAg
KyB0aGlzIHBhdGNoIHNlcmllcyBvbiBhbg0KPiA+IEFETCBzeXN0ZW0uDQo+IENhbiB5b3UgZG8g
dGVzdCBvbiBibGVlZGluZyBlZGdlIGJyYW5jaCBvZiBMaW51eC1wbT8NCj4gDQo+ID4gIGNwdTB+
Y3B1NyBhcmUgUGNvcmUgY3B1cywgY3B1OC1jcHUxNSBhcmUgRWNvcmUgY3B1cywgYW5kDQo+ID4g
aW50ZWxfcG93ZXJjbGFtcCBpcyByZWdpc3RlciBhcyBjb29saW5nX2RldmljZTIxLg0KPiA+IA0K
PiA+IDEuIHJ1biBzdHJlc3MgLWMgMTYNCj4gPiAyLiB1cGRhdGUgL3N5cy9tb2R1bGUvaW50ZWxf
cG93ZXJjbGFtcC9wYXJhbWV0ZXJzL2NwdW1hc2sNCj4gPiAgICBlY2hvIDkwID4gL3N5cy9tb2R1
bGUvaW50ZWxfcG93ZXJjbGFtcC9wYXJhbWV0ZXJzL21heF9pZGxlDQo+ID4gMy4gZWNobyA5MCA+
IC9zeXMvY2xhc3MvdGhlcm1hbC9jb29saW5nX2RldmljZTIxL2N1cl9zdGF0ZQ0KPiA+IDQuIGVj
aG8gMCA+IC9zeXMvY2xhc3MvdGhlcm1hbC9jb29saW5nX2RldmljZTIxL2N1cl9zdGF0ZQ0KPiA+
IEkgdXNlIHR1cmJvc3RhdCB0byBtb25pdG9yIHRoZSBDUFUgQnVzeSUgaW4gYWxsIDQgc3RlcHMu
DQo+ID4gDQo+ID4gSWYgJ2NwdW1hc2snIGRvZXMgbm90IGluY2x1ZGUgYWxsIHRoZSBFY29yZSBD
UFVzLCBhbGwgQ1BVcyBiZWNvbWVzDQo+ID4gMTAwJQ0KPiA+IGJ1c3kgYWZ0ZXIgaWRsZSBpbmpl
Y3Rpb24gcmVtb3ZlZCBpbiBzdGVwIDQuDQo+ID4gDQo+IHRoYXQgc2hvdWxkIGJlIHRoZSBjYXNl
Lg0KPiANCj4gPiBJZiAnY3B1bWFzaycgaW5jbHVkZXMgYWxsIHRoZSBFY29yZSBDUFVzLCBpLmUu
IGNwdW1hc2sgPSBGRnh5LCBpbg0KPiA+IHNvbWUNCj4gPiBjYXNlcywgdGhlIEVjb3JlIENQVXMg
d2lsbCBkcm9wIHRvIGFuIEJ1c3klIG11Y2ggbG93ZXIgdGhhbiAxMCUsDQo+ID4gYW5kDQo+ID4g
dGhlbiB0aGV5IGRvbid0IGNvbWUgYmFjayB0byBidXN5IGFmdGVyIGlkbGUgaW5qZWN0aW9uIHJl
bW92ZWQgaW4NCj4gPiBzdGVwDQo+ICBEbyB5b3Ugc2VlIHRoYXQgaWRsZSBpbmplY3Rpb24gaXMg
cmVtb3ZlZCBtZXNzYWdlIGluIGRtZXNnPw0KDQp5ZXMuDQoNCj4gV2UgY2FuIGFsc28gY2hlY2sg
cG93ZXJjYXAgaWRsZS1pbmVqY3QsIGlmIHNvbWUgQ1BVcyBzdGlsbCBub3Qgd2FrZSANCj4gZnJv
bSBwbGF5X2lkbGUuDQoNCiJwcyIgY29tbWFuZCBzaG93cyB0aGUgdGhlIGlkbGVfaW5qZWN0aW9u
IHRocmVhZHMgdGltZSBpcyBub3QNCmluY3JlYXNpbmcgYW55IG1vcmUuDQoNCj4gDQo+IA0KPiA+
IDQsIGFsdGhvdWdoIHdlIGhhdmUgMTYgc3RyZXNzIHRocmVhZHMuIEFuZCB0aGlzIGFsc28gcmVs
YXRlcyB3aXRoDQo+ID4gaG93DQo+ID4gbG9uZyB3ZSBzdGF5IGluIGlkbGUgaW5qZWN0aW9uLg0K
PiA+IA0KPiA+IFNheSwgd2hlbiBjcHVtYXNrPWZmZjMsIHRoZSBwcm9ibGVtIGNhbiBiZSB0cmln
Z2VyZWQgb2NjYXNpb25hbGx5DQo+ID4gaWYNCj4gPiB0aGVyZSBpcyBhIDEwIHNlY29uZCB0aW1l
b3V0IGJldHdlZW4gc3RlcCAzIGFuZCBzdGVwNCwgYnV0IGl0IGlzDQo+ID4gbXVjaA0KPiA+IGVh
c2llciB0byByZXByb2R1Y2libGUgaWYgSSBpbmNyZWFzZSB0aGUgdGltZW91dCB0byAyMCBzZWNv
bmRzLg0KPiA+IA0KPiA+IEl0IHNlZW1zIHRoYXQgUGNvcmUgY2FuIGFsd2F5cyBwdWxsIHRhc2tz
IGZyb20gRWNvcmVzLCBidXQgRWNvcmUNCj4gPiBjYW4NCj4gPiBub3QgcHVsbCB0YXNrcyBmcm9t
IFBjb3JlIEhUIHNpYmxpbmdzLg0KPiA+IA0KPiBUaGF0IHdpbGwgYmUgcmVndWxhciBsb2FkIGJh
bGFuY2UgdGhyZWFkcyBzaG91bGQgZG8uDQo+IEJldHRlciB0byB0cnkgdXBzdGVhbSBrZXJuZWwg
Zmlyc3QuDQoNCkknbSBhbHJlYWR5IHJ1bm5pbmcgd2l0aCBsaW51eC1wbSB0cmVlIGxpbnV4LW5l
eHQgYnJhbmNoICsgdGhpcyBwYXRjaA0Kc2VyaWVzLg0KDQp0aGFua3MsDQpydWkNCg0KPiANCj4g
VGhhbmtzLA0KPiBTcmluaXZhcw0KPiANCj4gDQo+ID4gdGhhbmtzLA0KPiA+IHJ1aQ0KPiA+IA0K
PiA+IE9uIFNhdCwgMjAyMy0wMi0wNCBhdCAxODo1OSAtMDgwMCwgU3Jpbml2YXMgUGFuZHJ1dmFk
YSB3cm90ZToNCj4gPiA+IFNwbGl0IGZyb20gdGhlIHNlcmllcyBmb3IgcG93ZXJjbGFtcCB1c2Vy
IG9mIHBvd2VyY2FwIGlkbGUtDQo+ID4gPiBpbmplY3QuDQo+ID4gPiANCj4gPiA+IHYyDQo+ID4g
PiAtIEJ1aWxkIHdhcm5pbmdzIHJlcG9ydGVkIGJ5IFJ1aQ0KPiA+ID4gLSBNb3ZlZCB0aGUgcG93
ZXJjbGFtcCBkb2N1bWVudGF0aW9uIHRvIGFkbWluIGd1aWRlIGZvbGRlcg0KPiA+ID4gLSBDb21t
aXQgbG9nIHVwZGF0ZWQgYXMgc3VnZ2VzdGVkIGJ5IFJhZmFlbCBhbmQgb3RoZXIgY29kZQ0KPiA+
ID4gc3VnZ2VzdGlvbg0KPiA+ID4gDQo+ID4gPiBTcmluaXZhcyBQYW5kcnV2YWRhICgyKToNCj4g
PiA+ICAgRG9jdW1lbnRhdGlvbjphZG1pbi1ndWlkZTogTW92ZSBpbnRlbF9wb3dlcmNsYW1wIGRv
Y3VtZW50YXRpb24NCj4gPiA+ICAgdGhlcm1hbC9kcml2ZXJzL2ludGVsX3Bvd2VyY2xhbXA6IEFk
ZCB0d28gbW9kdWxlIHBhcmFtZXRlcnMNCj4gPiA+IA0KPiA+ID4gIERvY3VtZW50YXRpb24vYWRt
aW4tZ3VpZGUvaW5kZXgucnN0ICAgICAgICAgICB8ICAgMSArDQo+ID4gPiAgLi4uL3RoZXJtYWwv
aW50ZWxfcG93ZXJjbGFtcC5yc3QgICAgICAgICAgICAgIHwgIDIyICsrKw0KPiA+ID4gIERvY3Vt
ZW50YXRpb24vZHJpdmVyLWFwaS90aGVybWFsL2luZGV4LnJzdCAgICB8ICAgMSAtDQo+ID4gPiAg
TUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4g
PiA+ICBkcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50ZWxfcG93ZXJjbGFtcC5jICAgICAgfCAxNzcN
Cj4gPiA+ICsrKysrKysrKysrKysrKy0NCj4gPiA+IC0tDQo+ID4gPiAgNSBmaWxlcyBjaGFuZ2Vk
LCAxODAgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pDQo+ID4gPiAgcmVuYW1lIERvY3Vt
ZW50YXRpb24ve2RyaXZlci1hcGkgPT4gYWRtaW4tDQo+ID4gPiBndWlkZX0vdGhlcm1hbC9pbnRl
bF9wb3dlcmNsYW1wLnJzdCAoOTMlKQ0KPiA+ID4gDQo=
