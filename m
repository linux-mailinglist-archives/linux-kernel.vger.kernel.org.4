Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE75B664616
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 17:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238828AbjAJQao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 11:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238331AbjAJQai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 11:30:38 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C472C7BDF1;
        Tue, 10 Jan 2023 08:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673368236; x=1704904236;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mFFkGl2QuMo5o9znjWXyrvCqapMZX98tmucjS2JgqAo=;
  b=A0GcCP4ONaIE7F2y5eGL4hVvWDi/bjnpcwYxYGSK1sQcXRUcsT2mkFdB
   +45cLIWXeKFSongVOtHZaEPQcAXLUX10v6rFCqWa+Lidb4svHvCy1wzp2
   /pWUEvWTAt69xBcWI00KHJ773UI8fWH37ataCQwuDoebnNCTXqAh4C8xf
   nyX84DcCcQig85S9B9J/FqP3yh4KwuVdKBrtyXAGSS6p3uhTcxo7N+dXx
   Ck9RcRI6qKmbWEAxlcYuljCMI0ngIzE1w1xSdSbTA9XUhr43WPolK+95X
   8TXcWfHnn9q5oRwSDLAGFdQAeTk5wG8xPZFomf+4WoaZaUBg7yxGClJ/7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="387642987"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="387642987"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 08:30:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="687623792"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="687623792"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 10 Jan 2023 08:30:25 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 10 Jan 2023 08:30:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 10 Jan 2023 08:30:24 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 10 Jan 2023 08:30:24 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 10 Jan 2023 08:30:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbSXxI3Ne1WkZ2Pn2z2RYrlADwjLvo5Ib/pS7c2O9KvPWGg1AAclozYzoBK+l22REk31iJYeHCYUmklb3UXOFdAc6w7Vh6yl2z3nWSms0v46spcHsxmNsOJtOMSCsj4cC8wcVDdHa/RmEjRSFCJ7aXObyahWlORtw8sNpGZq2vn6Y7DEURrSUPTO6FgsbKaldwKOIhgmdO6GnEaUO4gzatfMsCDFRGRZVYak2wBz/QsnSGLK8DGFVsfzr6GgWkE4UHMISx9awdFXAtH9MvDlt+CPohdG3ExgXmmu4sLAeUCmwESzbsp5t+h3+Llm2ql9YPKj5SjVtxxc8k8SCHzcaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFFkGl2QuMo5o9znjWXyrvCqapMZX98tmucjS2JgqAo=;
 b=C0B3u6mV1luXmfTYBS7yLWMgLDBFFIB0eyj2sJaU5lzPlsudCPf8jDRnDba2jm7+feDXReZm52aoynpKTELFRcLxfioDnHdBv622IiaPCYQBvjguOAPKIuOQa3JsyKl5ZHheBPX0Im2mQDnlpiCxO0BgzY66feYoN3dVA66pQiJJWrlzXlcXmBIO8If0KH/sRu22ObaX8k9pz9BsA13lpcj/ShI0DJcJm93fK5s+DBEOC4dDBkiuWabMzpgji1i7qYZW27zggjUU8wIGF9/D33iXoFWdWuDvNxNfJMBHxPsAFic+Puo10ZmrJeNwSlFRjBgdOZdwlRJcF29mr0cn3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by CH0PR11MB8165.namprd11.prod.outlook.com (2603:10b6:610:18e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:30:20 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2%6]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 16:30:20 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "xu.panda@zte.com.cn" <xu.panda@zte.com.cn>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "johan+linaro@kernel.org" <johan+linaro@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] generic trip points for the thermal framework
Thread-Topic: [GIT PULL] generic trip points for the thermal framework
Thread-Index: AQHZI57tdy+vzdqOY0yWb3v19D9b2q6Wh5KAgAEQNACAAEKiAA==
Date:   Tue, 10 Jan 2023 16:30:20 +0000
Message-ID: <6e84d3457f3a6adb6b0d599058e8afcfee8d863e.camel@intel.com>
References: <72fcddd3-0429-4e23-ab68-2a502f451966@linaro.org>
         <CAJZ5v0iSsg63KdfY79DHSeR+DnaQF2c7GoFZaUw3eHh4XNkWRA@mail.gmail.com>
         <CAJZ5v0gX0KttHGFWAJU5urTfTQVqZeXjFOBrrovygQamwYs_4A@mail.gmail.com>
In-Reply-To: <CAJZ5v0gX0KttHGFWAJU5urTfTQVqZeXjFOBrrovygQamwYs_4A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|CH0PR11MB8165:EE_
x-ms-office365-filtering-correlation-id: 697d6b0b-9689-4b5d-2cbe-08daf327f712
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /9hNsCfYks/kglFovmypguegTNUAIgDWm/2Fu9xRxBMQ7npIhW4cryzEztcC2PNLDQOuhF/N7B7KkCA/y/SdW86w0C8jSrz1ASwxZ0mKwNNu5Ygp4DTELabeOe/aKm4QuXRqQ/01VuoEHQpSoLBM+gCXwBDKrdktNFi1sodXjmulcnT219mAtzoiTplnBQxPb+FenA7g3HuYAatwDxnQ9DU6vDl5uD+baUPD6Jp4PrAB/S4FSGVtXAczMlGPFLaVAhv7AVH4omEqjTM5jruAdECzLlCSOneGJQp54l14c77pjrIzSaK0xrZfTxbD6TO38t9v20F0vlvr9XYhhspNWAIr1zAf1Mxe5Rmpw8pjubWmfhyrl/iuzB00AugIbf//nFSqP/xdbPuxAJVnwajLv14FaaPsbZXyrnqVjWPQe/d+kPCQGhn6EkcxUgdEToTvAiCVxhA2nbt7x4A57FOyTIZoLZAs9DX+5EjlnTaTBEY2CNzJXg8xezMOjrSqKinBtipiHlWG0zG1mUIrB5u74xSenJQUEvgOv8PgtHkK5TwWPMSZxeL3V5vs+hX5XAznHWaB9JVNwzYJHniace2QhCgN4yznrXO2k/lM/7X0hetGUuWkN7h2ry+wDVLKkohh2MwpzCMLKGmjFPVVOsA1gIw1nO0dWAdhK7Yu2z0wd9Q6lbSyluSBBcf1au7+JZYvIXOMjNUXik2MWFespuMEScQIr1AXckYrO+Egny6LtsQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(39860400002)(396003)(376002)(136003)(451199015)(8936002)(2906002)(5660300002)(4001150100001)(41300700001)(71200400001)(66446008)(4326008)(91956017)(316002)(8676002)(64756008)(66556008)(66476007)(66946007)(76116006)(110136005)(38070700005)(54906003)(26005)(6512007)(2616005)(122000001)(38100700002)(86362001)(186003)(83380400001)(36756003)(53546011)(478600001)(82960400001)(6506007)(6486002)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1lyOHNnY09pTlRjQjQySlF3ZzNKa3oxQWJyMWgzZ09mNkw1U2tBdW1pZ3lk?=
 =?utf-8?B?Q3o1b0NiUTIySGJCL2NoaEZOejk0ODJ1VHZSWE5kem9ZeStlUzdka3MydXRL?=
 =?utf-8?B?cDFqazVtWStnWCtpd1RnNEFnY1VKaUdnTEpaMzd2bVhGV0V1azFtL2l6YnZk?=
 =?utf-8?B?MkFNT3pmVkFzTlAwUHNYUGJ5dG94SXFzTmtqdlZrQ2t5dDNVUHFhRkFQcjFM?=
 =?utf-8?B?OHdXdFZxaUVOaGw1VEIxa0hra1I0THdpeUp1azFRcXNvb2JWYStDdVc2RWVy?=
 =?utf-8?B?SjBKSm1zNWM0aFpwWlFON0xmaStNaDVXdC8vLyt2YnJJbXdFWjhVWlh0L2lT?=
 =?utf-8?B?b3RudE1CT2FaUWlTYnoweHRlM21nYmVGWWlhQ1A4ait0UlFkZzQ4dnhJdWpr?=
 =?utf-8?B?SEFJZlJoc1NybVNjemlvVTEwNENQaVdNKzh3L3Q2ZDlLSG80S2h5L25HTGor?=
 =?utf-8?B?aS9SajlwVGN1WDZNbjJVMHp4dytaS3ZtQWN5dTNoLzVUZm10TytlSjJCazFT?=
 =?utf-8?B?c21lUngvWFduR1BzTDJFTWd1ZWpFSFE1MFB1OWVOZ0dJV3VkOUJGMUo4ZWdp?=
 =?utf-8?B?QkFadFBYMFowZTdyNHJ0cStUdG4vUmJkWnlteUZwUFN5Tm1kNStaT2dUZTVh?=
 =?utf-8?B?a2tLVFlLakFTaXUwbURWM25lTURSZDNGU2dZY2I2Wlh3UXVId05wVDVIbGRV?=
 =?utf-8?B?Tmdscll1enU5V21Vc0lNNnFtaVFROTBMR0U5Z3lZc2NXdExsUWJWamh4RjVY?=
 =?utf-8?B?Z1N6YTFCTlRteHEvdk8zZE9QTEN2aU15MmgyWFlOSURqU0txcVVzOE00RjhR?=
 =?utf-8?B?OWhjMVZYZ0pZbncxNG1GYTBob0JlNWZELzBZczRnQ25hMEh2MkI1ZG1wOElI?=
 =?utf-8?B?bVlJUEdjNXpNT2ZwSFpBYVc4aUhaUHYrTkhTcUhyZy9qOWMrM1hWZnF1cTJ6?=
 =?utf-8?B?Z0gwY3JtQTNZVktqVkZrTEFnQ0xwVHVnOG8vaTFMdWVteHRLcFN0UTFMY1lk?=
 =?utf-8?B?eWlxSitSOHlrNnhaTkJhM2hxNGpFc1dzVWtENkpEU0NyVWR4OW9pQW1Fa2Vn?=
 =?utf-8?B?MWhJUnpaUUR3Q2NhdUpCWDNyM1dWTmtMYzVCZE1JR3JqZE5aM3VHc1d3OWM2?=
 =?utf-8?B?NXlZM29zeFBoVWxtUStPTkJoRVdxREU4TjhhNVJHZEhTcW5LN0tONXdycElm?=
 =?utf-8?B?OWdCY3hRZHZDWTliZThyNU1aa3ZwRmtSblloWWtmeng0STZzK0JHWVJISkNn?=
 =?utf-8?B?K1V4TisrWXZqUGxpclZlaXRTZzRKeEEvTDRJU0tNYkNXSVBEeTNPUUYveU4r?=
 =?utf-8?B?NTJPVXRsYktDV3lUaEwwUmVpUzJROEhKZTl1ck0zRUhNRGNGeitPZVdsWitG?=
 =?utf-8?B?SnhKWkJDeHo1U1FUTStxODZneE55dGNuNkpGUUY4QnltR00ySG8vbEhocklC?=
 =?utf-8?B?Q1BScHVnbTNiSTRKT243VlpFOWo3bEwvTHJFb2gwdmtVeENxWHNPQ1RKVWFI?=
 =?utf-8?B?UURGK25qZW5rUjBjajhZV2RmTndRaWU2WDhsOEtUZVM2T09YU1J5eHV5ZDZP?=
 =?utf-8?B?ckRXSzVRdDhReTVrckNyTUZYT0pCWGZHK2VZZHhkV2NsTG5nVFM5WmN6R3kr?=
 =?utf-8?B?VWR0blYrL3k3RW0wK25EcC95bVU3SkkrY1pGRkJZc0tWQ2FDRDdLNFNOMitY?=
 =?utf-8?B?ZVRjYkNTQ0JxUTh2Z2FyNVJxcHdQTSswbCs1aVoxRlZTWWx0TzVSMGluazlT?=
 =?utf-8?B?THh3RlRMUGJYbzBlUGs2eHNvMWQ3REVoMHc0OExPdGkvU1Z5REJpUUVORDZZ?=
 =?utf-8?B?QlM5WUZlNlFpcTVNcDF6Mk5EVit3VFZtTCtoT0dTT3E1ZG0xeDMxTXkyTFJv?=
 =?utf-8?B?ZmxZazQ2L2NEZVFNRnJJdVRaUHdjTVBma2ZIdWs2a0xPRzR1Umtic2xRQkZD?=
 =?utf-8?B?aTRaaklOS1BhaE1Pa1NWYVBqUzk3alh3eGlLeE9CUG14V3JtaGw2TlBTQkto?=
 =?utf-8?B?bGM3UUQ0N0hFOGg4TTdjWEpEUmpmdklRT2c3VG5pV09CZThuZU5JMjdVS2Iz?=
 =?utf-8?B?MVJQMFVkU1E1d2JUN2Uxc1hVUmZZYmVoNHB5am1ZL3BhaTZTL29qWkpjWWIw?=
 =?utf-8?B?UllZNmxEdjBLZXM0NTFGdGtITUpaU2dxNEcrRXlsSmhtVXNKNXJ3SGlXQlNl?=
 =?utf-8?B?Q3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E58B9B7D6D04A41824EF638B894C8FF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 697d6b0b-9689-4b5d-2cbe-08daf327f712
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 16:30:20.0627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XCKdrNJKh80NgnXr06Rs0hID1eNZ5Fqp6kdk5goEgmBUR2vL7PLWvbaJlYD2sXqYrSEUu2zFv3QyumYvT+rDVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8165
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTAxLTEwIGF0IDEzOjMxICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gTW9uLCBKYW4gOSwgMjAyMyBhdCA5OjE3IFBNIFJhZmFlbCBKLiBXeXNvY2tpIDxy
YWZhZWxAa2VybmVsLm9yZz4NCj4gd3JvdGU6DQo+ID4gT24gU3VuLCBKYW4gOCwgMjAyMyBhdCA5
OjIyIFBNIERhbmllbCBMZXpjYW5vIDwNCj4gPiBkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPiB3
cm90ZToNCj4gPiA+IA0KPiA+ID4gSGkgUmFmYWVsLA0KPiA+ID4gDQo+ID4gPiBoZXJlIGFyZSB0
aGUgY2hhbmdlcyBmb3IgdGhlIGdlbmVyaWMgdHJpcCBwb2ludHMgd2hpY2ggd2VyZQ0KPiA+ID4g
cG9zdHBvbmVkDQo+ID4gPiBkdXJpbmcgdGhlIGxhc3QgcmVsZWFzZS4gVGhleSBoYXZlIGJlZW4g
aW4gdGhlIGxpbnV4LW5leHQgYnJhbmNoDQo+ID4gPiBzaW5jZQ0KPiA+ID4gTm92ZW1iZXIuDQo+
ID4gPiANCj4gPiA+IFRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQNCj4gPiA+IGI4
NzhkM2JhOWJiNDFjZGRiNzNiYTRiNTZlNTU1MmYwYTYzOGRhY2E6DQo+ID4gPiANCj4gPiA+ICAg
IHRoZXJtYWw6IGludDM0MHg6IEFkZCBtaXNzaW5nIGF0dHJpYnV0ZSBmb3IgZGF0YSByYXRlIGJh
c2UNCj4gPiA+ICgyMDIyLTEyLTMwIDE5OjQ4OjM3ICswMTAwKQ0KPiA+ID4gDQo+ID4gPiBhcmUg
YXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoNCj4gPiA+IA0KPiA+ID4gDQo+ID4g
PiBzc2g6Ly9naXRAZ2l0b2xpdGUua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQv
dGhlcm1hbC9saW51eC5naXQNCj4gPiA+IHRhZ3MvZ2VuZXJpYy10cmlwLXBvaW50DQo+ID4gPiAN
Cj4gPiA+IGZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0bw0KPiA+ID4gM2ExNTE0OTRkYzA0
Yzc2YWRkNTc3YWU2NmU4YTA0ZjkwMDYzOGFhZjoNCj4gPiA+IA0KPiA+ID4gICAgdGhlcm1hbC9k
cml2ZXJzL2FybWFkYTogVXNlIHN0cnNjcHkoKSB0byBpbnN0ZWFkIG9mIHN0cm5jcHkoKQ0KPiA+
ID4gKDIwMjMtMDEtMDYgMTQ6MTQ6NDggKzAxMDApDQo+ID4gPiANCj4gPiA+IC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4g
PiA+IC0gUmV3b3JrIGEgbGFyZ2UgYnVuY2ggb2YgZHJpdmVycyB0byB1c2UgdGhlIGdlbmVyaWMg
dGhlcm1hbCB0cmlwDQo+ID4gPiAgICBzdHJ1Y3R1cmUgYW5kIHRoZSBvcHBvcnR1bml0eSB0byBk
byBtb3JlIGNsZWFudXBzIGJ5IHJlbW92aW5nDQo+ID4gPiB1bnVzZWQNCj4gPiA+ICAgIGZ1bmN0
aW9ucyBpbiB0aGUgT0YgY29kZSAoRGFuaWVsIExlemNhbm8pDQo+ID4gPiANCj4gPiA+IC0gRml4
IHNvbWUgbG9ja2luZyBpc3N1ZXMgcmVsYXRlZCB0byB0aGUgZ2VuZXJpYyB0aGVybWFsIHRyaXAN
Cj4gPiA+IHJld29yaw0KPiA+ID4gICAgKEpvaGFuIEhvdm9sZCkNCj4gPiA+IA0KPiA+ID4gLSBG
aXggYSBjcmFzaCB3aGVuIHJlcXVlc3RpbmcgdGhlIGNyaXRpY2FsIHRlbXBlcmF0dXJlIG9uIHRl
Z3JhLA0KPiA+ID4gdGhpcw0KPiA+ID4gICAgZml4IGlzIHJlbGF0ZWQgdG8gdGhlIGdlbmVyaWMg
dHJpcCBwb2ludCAoSm9uIEh1bnRlcikNCj4gPiA+IA0KPiA+ID4gLSBVc2Ugc3Ryc2NweSgpIHRv
IGluc3RlYWQgb2Ygc3RybmNweSgpIChYdSBQYW5kYSkNCj4gPiA+IA0KPiA+ID4gLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
PiA+ID4gRGFuaWVsIExlemNhbm8gKDMyKToNCj4gPiA+ICAgICAgICB0aGVybWFsL2NvcmU6IEFk
ZCBhIGdlbmVyaWMgdGhlcm1hbF96b25lX2dldF90cmlwKCkNCj4gPiA+IGZ1bmN0aW9uDQo+ID4g
PiAgICAgICAgdGhlcm1hbC9zeXNmczogQWx3YXlzIGV4cG9zZSBoeXN0ZXJlc2lzIGF0dHJpYnV0
ZXMNCj4gPiA+ICAgICAgICB0aGVybWFsL2NvcmU6IEFkZCBhIGdlbmVyaWMgdGhlcm1hbF96b25l
X3NldF90cmlwKCkNCj4gPiA+IGZ1bmN0aW9uDQo+ID4gPiAgICAgICAgdGhlcm1hbC9jb3JlL2dv
dmVybm9yczogVXNlIHRoZXJtYWxfem9uZV9nZXRfdHJpcCgpDQo+ID4gPiBpbnN0ZWFkIG9mDQo+
ID4gPiBvcHMgZnVuY3Rpb25zDQo+ID4gPiAgICAgICAgdGhlcm1hbC9vZjogVXNlIGdlbmVyaWMg
dGhlcm1hbF96b25lX2dldF90cmlwKCkgZnVuY3Rpb24NCj4gPiA+ICAgICAgICB0aGVybWFsL29m
OiBSZW1vdmUgdW51c2VkIGZ1bmN0aW9ucw0KPiA+ID4gICAgICAgIHRoZXJtYWwvZHJpdmVycy9l
eHlub3M6IFVzZSBnZW5lcmljDQo+ID4gPiB0aGVybWFsX3pvbmVfZ2V0X3RyaXAoKSBmdW5jdGlv
bg0KPiA+ID4gICAgICAgIHRoZXJtYWwvZHJpdmVycy9leHlub3M6IG9mX3RoZXJtYWxfZ2V0X250
cmlwcygpDQo+ID4gPiAgICAgICAgdGhlcm1hbC9kcml2ZXJzL2V4eW5vczogUmVwbGFjZSBvZl90
aGVybWFsX2lzX3RyaXBfdmFsaWQoKQ0KPiA+ID4gYnkNCj4gPiA+IHRoZXJtYWxfem9uZV9nZXRf
dHJpcCgpDQo+ID4gPiAgICAgICAgdGhlcm1hbC9kcml2ZXJzL3RlZ3JhOiBVc2UgZ2VuZXJpYyB0
aGVybWFsX3pvbmVfZ2V0X3RyaXAoKQ0KPiA+ID4gZnVuY3Rpb24NCj4gPiA+ICAgICAgICB0aGVy
bWFsL2RyaXZlcnMvdW5pcGhpZXI6IFVzZSBnZW5lcmljDQo+ID4gPiB0aGVybWFsX3pvbmVfZ2V0
X3RyaXAoKQ0KPiA+ID4gZnVuY3Rpb24NCj4gPiA+ICAgICAgICB0aGVybWFsL2RyaXZlcnMvaGlz
aTogVXNlIGdlbmVyaWMgdGhlcm1hbF96b25lX2dldF90cmlwKCkNCj4gPiA+IGZ1bmN0aW9uDQo+
ID4gPiAgICAgICAgdGhlcm1hbC9kcml2ZXJzL3Fjb206IFVzZSBnZW5lcmljIHRoZXJtYWxfem9u
ZV9nZXRfdHJpcCgpDQo+ID4gPiBmdW5jdGlvbg0KPiA+ID4gICAgICAgIHRoZXJtYWwvZHJpdmVy
cy9hcm1hZGE6IFVzZSBnZW5lcmljDQo+ID4gPiB0aGVybWFsX3pvbmVfZ2V0X3RyaXAoKSBmdW5j
dGlvbg0KPiA+ID4gICAgICAgIHRoZXJtYWwvZHJpdmVycy9yY2FyX2dlbjM6IFVzZSB0aGUgZ2Vu
ZXJpYyBmdW5jdGlvbiB0byBnZXQNCj4gPiA+IHRoZQ0KPiA+ID4gbnVtYmVyIG9mIHRyaXBzDQo+
ID4gPiAgICAgICAgdGhlcm1hbC9vZjogUmVtb3ZlIG9mX3RoZXJtYWxfZ2V0X250cmlwcygpDQo+
ID4gPiAgICAgICAgdGhlcm1hbC9vZjogUmVtb3ZlIG9mX3RoZXJtYWxfaXNfdHJpcF92YWxpZCgp
DQo+ID4gPiAgICAgICAgdGhlcm1hbC9vZjogUmVtb3ZlIG9mX3RoZXJtYWxfc2V0X3RyaXBfaHlz
dCgpDQo+ID4gPiAgICAgICAgdGhlcm1hbC9vZjogUmVtb3ZlIG9mX3RoZXJtYWxfZ2V0X2NyaXRf
dGVtcCgpDQo+ID4gPiAgICAgICAgdGhlcm1hbC9kcml2ZXJzL3N0OiBVc2UgZ2VuZXJpYyB0cmlw
IHBvaW50cw0KPiA+ID4gICAgICAgIHRoZXJtYWwvZHJpdmVycy9pbXg6IFVzZSBnZW5lcmljIHRo
ZXJtYWxfem9uZV9nZXRfdHJpcCgpDQo+ID4gPiBmdW5jdGlvbg0KPiA+ID4gICAgICAgIHRoZXJt
YWwvZHJpdmVycy9yY2FyOiBVc2UgZ2VuZXJpYyB0aGVybWFsX3pvbmVfZ2V0X3RyaXAoKQ0KPiA+
ID4gZnVuY3Rpb24NCj4gPiA+ICAgICAgICB0aGVybWFsL2RyaXZlcnMvYnJvYWRjb206IFVzZSBn
ZW5lcmljDQo+ID4gPiB0aGVybWFsX3pvbmVfZ2V0X3RyaXAoKQ0KPiA+ID4gZnVuY3Rpb24NCj4g
PiA+ICAgICAgICB0aGVybWFsL2RyaXZlcnMvZGE5MDYyOiBVc2UgZ2VuZXJpYw0KPiA+ID4gdGhl
cm1hbF96b25lX2dldF90cmlwKCkgZnVuY3Rpb24NCj4gPiA+ICAgICAgICB0aGVybWFsL2RyaXZl
cnMvdGk6IFJlbW92ZSB1bnVzZWQgbWFjcm9zDQo+ID4gPiB0aV90aGVybWFsX2dldF90cmlwX3Zh
bHVlKCkgLyB0aV90aGVybWFsX3RyaXBfaXNfdmFsaWQoKQ0KPiA+ID4gICAgICAgIHRoZXJtYWwv
ZHJpdmVycy9hY2VyaGRmOiBVc2UgZ2VuZXJpYw0KPiA+ID4gdGhlcm1hbF96b25lX2dldF90cmlw
KCkgZnVuY3Rpb24NCj4gPiA+ICAgICAgICB0aGVybWFsL2RyaXZlcnMvY3hnYjQ6IFVzZSBnZW5l
cmljIHRoZXJtYWxfem9uZV9nZXRfdHJpcCgpDQo+ID4gPiBmdW5jdGlvbg0KPiA+ID4gICAgICAg
IHRoZXJtYWwvaW50ZWwvaW50MzQweDogUmVwbGFjZSBwYXJhbWV0ZXIgdG8gc2ltcGxpZnkNCj4g
PiA+ICAgICAgICB0aGVybWFsL2RyaXZlcnMvaW50ZWw6IFVzZSBnZW5lcmljIHRoZXJtYWxfem9u
ZV9nZXRfdHJpcCgpDQo+ID4gPiBmdW5jdGlvbg0KPiA+ID4gICAgICAgIHRoZXJtYWwvZHJpdmVy
cy9leHlub3M6IEZpeCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2Ugd2hlbg0KPiA+ID4gZ2V0dGlu
Zw0KPiA+ID4gdGhlIGNyaXRpY2FsIHRlbXANCj4gPiA+ICAgICAgICB3aWZpOiBpd2x3aWZpOiBV
c2UgZ2VuZXJpYyB0aGVybWFsX3pvbmVfZ2V0X3RyaXAoKQ0KPiA+ID4gZnVuY3Rpb24NCj4gPiA+
ICAgICAgICB0aGVybWFsL2RyaXZlcnMvbWVsbGFub3g6IFVzZSBnZW5lcmljDQo+ID4gPiB0aGVy
bWFsX3pvbmVfZ2V0X3RyaXAoKQ0KPiA+ID4gZnVuY3Rpb24NCj4gPiA+IA0KPiA+ID4gSm9oYW4g
SG92b2xkICgzKToNCj4gPiA+ICAgICAgICB0aGVybWFsL2RyaXZlcnMvcWNvbTogRml4IHNldF90
cmlwX3RlbXAoKSBkZWFkbG9jaw0KPiA+ID4gICAgICAgIHRoZXJtYWwvZHJpdmVycy90ZWdyYTog
Rml4IHNldF90cmlwX3RlbXAoKSBkZWFkbG9jaw0KPiA+ID4gICAgICAgIHRoZXJtYWwvZHJpdmVy
cy9xY29tOiBGaXggbG9jayBpbnZlcnNpb24NCj4gPiA+IA0KPiA+ID4gSm9uIEh1bnRlciAoMSk6
DQo+ID4gPiAgICAgICAgdGhlcm1hbC9kcml2ZXJzL3RlZ3JhOiBGaXggY3Jhc2ggd2hlbiBnZXR0
aW5nIGNyaXRpY2FsDQo+ID4gPiB0ZW1wDQo+ID4gPiANCj4gPiA+IFh1IFBhbmRhICgxKToNCj4g
PiA+ICAgICAgICB0aGVybWFsL2RyaXZlcnMvYXJtYWRhOiBVc2Ugc3Ryc2NweSgpIHRvIGluc3Rl
YWQgb2YNCj4gPiA+IHN0cm5jcHkoKQ0KPiA+ID4gDQo+ID4gPiAgIGRyaXZlcnMvbmV0L2V0aGVy
bmV0L2NoZWxzaW8vY3hnYjQvY3hnYjQuaCAgICAgICAgIHwgICAyIC0NCj4gPiA+ICAgZHJpdmVy
cy9uZXQvZXRoZXJuZXQvY2hlbHNpby9jeGdiNC9jeGdiNF90aGVybWFsLmMgfCAgMzkgKy0tLQ0K
PiA+ID4gICBkcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHhzdy9jb3JlX3RoZXJtYWwu
YyB8IDIwOQ0KPiA+ID4gKysrKystLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiAgIGRyaXZlcnMvbmV0
L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL212bS5oICAgICAgIHwgICAyICstDQo+ID4gPiAg
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvbXZtL3R0LmMgICAgICAgIHwgIDcx
ICsrLS0NCj4gPiA+IC0tLQ0KPiA+ID4gICBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9hY2VyaGRmLmMg
ICAgICAgICAgICAgICAgICAgICB8ICA3MyArKystLS0NCj4gPiA+IC0NCj4gPiA+ICAgZHJpdmVy
cy90aGVybWFsL2FybWFkYV90aGVybWFsLmMgICAgICAgICAgICAgICAgICAgfCAgNDAgKystLQ0K
PiA+ID4gICBkcml2ZXJzL3RoZXJtYWwvYnJvYWRjb20vYmNtMjgzNV90aGVybWFsLmMgICAgICAg
ICB8ICAgOCArLQ0KPiA+ID4gICBkcml2ZXJzL3RoZXJtYWwvZGE5MDYyLXRoZXJtYWwuYyAgICAg
ICAgICAgICAgICAgICB8ICA1MiArLS0tLQ0KPiA+ID4gICBkcml2ZXJzL3RoZXJtYWwvZ292X2Jh
bmdfYmFuZy5jICAgICAgICAgICAgICAgICAgICB8ICAzNyArKy0tDQo+ID4gPiAgIGRyaXZlcnMv
dGhlcm1hbC9nb3ZfZmFpcl9zaGFyZS5jICAgICAgICAgICAgICAgICAgIHwgIDE4ICstDQo+ID4g
PiAgIGRyaXZlcnMvdGhlcm1hbC9nb3ZfcG93ZXJfYWxsb2NhdG9yLmMgICAgICAgICAgICAgIHwg
IDUxICsrKy0tDQo+ID4gPiAgIGRyaXZlcnMvdGhlcm1hbC9nb3Zfc3RlcF93aXNlLmMgICAgICAg
ICAgICAgICAgICAgIHwgIDIyICstLQ0KPiA+ID4gICBkcml2ZXJzL3RoZXJtYWwvaGlzaV90aGVy
bWFsLmMgICAgICAgICAgICAgICAgICAgICB8ICAxMSArLQ0KPiA+ID4gICBkcml2ZXJzL3RoZXJt
YWwvaW14X3RoZXJtYWwuYyAgICAgICAgICAgICAgICAgICAgICB8ICA3MiArKystLS0NCj4gPiA+
IC0NCj4gPiA+ICAgLi4uL2ludGVsL2ludDM0MHhfdGhlcm1hbC9pbnQzNDB4X3RoZXJtYWxfem9u
ZS5jICAgfCAgMzMgKystLQ0KPiA+ID4gICAuLi4vaW50ZWwvaW50MzQweF90aGVybWFsL2ludDM0
MHhfdGhlcm1hbF96b25lLmggICB8ICAgNCArLQ0KPiA+ID4gICAuLi4vaW50MzQweF90aGVybWFs
L3Byb2Nlc3Nvcl90aGVybWFsX2RldmljZS5jICAgICB8ICAxMCArLQ0KPiA+ID4gICBkcml2ZXJz
L3RoZXJtYWwvaW50ZWwveDg2X3BrZ190ZW1wX3RoZXJtYWwuYyAgICAgICB8IDEyMA0KPiA+ID4g
KysrKysrLS0tLS0tDQo+ID4gPiAgIGRyaXZlcnMvdGhlcm1hbC9xY29tL3Fjb20tc3BtaS10ZW1w
LWFsYXJtLmMgICAgICAgIHwgIDQ0ICsrLS0tDQo+ID4gPiAgIGRyaXZlcnMvdGhlcm1hbC9yY2Fy
X2dlbjNfdGhlcm1hbC5jICAgICAgICAgICAgICAgIHwgICAyICstDQo+ID4gPiAgIGRyaXZlcnMv
dGhlcm1hbC9yY2FyX3RoZXJtYWwuYyAgICAgICAgICAgICAgICAgICAgIHwgIDUzICstLS0tLQ0K
PiA+ID4gICBkcml2ZXJzL3RoZXJtYWwvc2Ftc3VuZy9leHlub3NfdG11LmMgICAgICAgICAgICAg
ICB8ICA2MiArKystLS0NCj4gPiA+ICAgZHJpdmVycy90aGVybWFsL3N0L3N0X3RoZXJtYWwuYyAg
ICAgICAgICAgICAgICAgICAgfCAgNDcgKy0tLS0NCj4gPiA+ICAgZHJpdmVycy90aGVybWFsL3Rl
Z3JhL3NvY3RoZXJtLmMgICAgICAgICAgICAgICAgICAgfCAgMzUgKystLQ0KPiA+ID4gICBkcml2
ZXJzL3RoZXJtYWwvdGVncmEvdGVncmEzMC10c2Vuc29yLmMgICAgICAgICAgICB8ICAxNyArLQ0K
PiA+ID4gICBkcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMgICAgICAgICAgICAgICAgICAg
ICB8IDE1NA0KPiA+ID4gKysrKysrKysrKysrLS0tDQo+ID4gPiAgIGRyaXZlcnMvdGhlcm1hbC90
aGVybWFsX2NvcmUuaCAgICAgICAgICAgICAgICAgICAgIHwgIDI0ICstLQ0KPiA+ID4gICBkcml2
ZXJzL3RoZXJtYWwvdGhlcm1hbF9oZWxwZXJzLmMgICAgICAgICAgICAgICAgICB8ICAyOCArLS0N
Cj4gPiA+ICAgZHJpdmVycy90aGVybWFsL3RoZXJtYWxfbmV0bGluay5jICAgICAgICAgICAgICAg
ICAgfCAgMTkgKy0NCj4gPiA+ICAgZHJpdmVycy90aGVybWFsL3RoZXJtYWxfb2YuYyAgICAgICAg
ICAgICAgICAgICAgICAgfCAxMTYgLS0tLS0tDQo+ID4gPiAtLS0tLS0NCj4gPiA+ICAgZHJpdmVy
cy90aGVybWFsL3RoZXJtYWxfc3lzZnMuYyAgICAgICAgICAgICAgICAgICAgfCAxMzUgKysrKyst
DQo+ID4gPiAtLS0tLS0tDQo+ID4gPiAgIGRyaXZlcnMvdGhlcm1hbC90aS1zb2MtdGhlcm1hbC90
aS10aGVybWFsLmggICAgICAgIHwgIDE1IC0tDQo+ID4gPiAgIGRyaXZlcnMvdGhlcm1hbC91bmlw
aGllcl90aGVybWFsLmMgICAgICAgICAgICAgICAgIHwgIDI3ICsrLQ0KPiA+ID4gICBpbmNsdWRl
L2xpbnV4L3RoZXJtYWwuaCAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxMiArKw0KPiA+
ID4gICAzNSBmaWxlcyBjaGFuZ2VkLCA2MTggaW5zZXJ0aW9ucygrKSwgMTA0NiBkZWxldGlvbnMo
LSkNCj4gPiA+IA0KPiA+ID4gLS0NCj4gPiANCj4gPiBQdWxsZWQgYW5kIHB1c2hlZCBvdXQsIHRo
YW5rcyENCj4gPiANCj4gPiBJJ3ZlIG1lcmdlZCBteSB0aGVybWFsLWludGVsIGJyYW5jaCBvbiB0
b3Agb2YgdGhpcyBhbmQgcHVzaGVkIG91dA0KPiA+IHRoZQ0KPiA+IHJlc3VsdCBpbnRvIHRoZSBi
bGVlZGluZy1lZGdlIGJyYW5jaC4gIFBsZWFzZSBjaGVjayBteSBtZXJnZQ0KPiA+IGNvbmZsaWN0
DQo+ID4gcmVzb2x1dGlvbiB0aGVyZS4NCj4gDQo+IEl0IHdvdWxkIG5vdCBidWlsZCBkdWUgdG8g
dGpfbWF4IGJlaW5nIHVuZGVmaW5lZCBpbg0KPiBwa2dfdGVtcF90aGVybWFsX2RldmljZV9hZGQo
KS4NCg0KSSBtaXNzZWQgeW91ciBvcmlnaW5hbCBtZXJnZSBjb21taXQuDQoNCj4gDQo+IFNob3Vs
ZCBiZSBmaXhlZCBpbiBibGVlZGluZy1lZGdlIG5vdy4NCj4gDQo+IFJ1aSwgcGxlYXNlIGhhdmUg
YSBsb29rIGF0IHRoYXQgdG9vLg0KPiANClllYWgsIGNvbW1pdCA4Yzk0NTE0NWMxMDUgKCJNZXJn
ZSBicmFuY2ggJ3RoZXJtYWwtaW50ZWwnIGludG8gYmxlZWRpbmctDQplZGdlIikgbG9va3MgZ29v
ZCB0byBtZS4gRGFuaWVsJyBwYXRjaCBkZXBlbmRzIG9uIHRqX21heCwgYW5kIHdlIHNob3VsZA0K
aGF2ZSB0aGF0IHZhcmlhYmxlIGJhY2suDQoNCnRoYW5rcywNCnJ1aQ0K
