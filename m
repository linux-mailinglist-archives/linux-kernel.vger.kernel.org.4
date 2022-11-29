Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FA063C70D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 19:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbiK2SKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 13:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbiK2SKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 13:10:34 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E26664A15
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 10:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669745429; x=1701281429;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EyUeXWx2WZueU/ZaHirXw9BTHeK6PuIuTLpQUA9aH30=;
  b=bwIyhrpzvREwmu662qGrePJOsMXTWliZ5tMmSDqNZORHaTM7q4RKgV9D
   wx7eFK8yukL5SbzTfN93vtn3fX7qyXPVR5g0FIbSmhNylRjHCss2TO2rA
   T5+GtNXReSAE0NxuyIPqDBpDcs/4bT9W3JIDFoB5kqYSkvBWNN7gNCrUr
   8r82X8KzqEwhlg7Z6DhRSZSr+TljV80mRZp0vpj6sU3y4CUnhpU8GCfOg
   b9v/6FAWswsGrk8eAGj8agp3lLH8Q3zf8TriW1W+D4uwqdBDwloh4fmLL
   C4+r1ybItOzRoKlhZIJpdnMBf5wrKoDrLPEL7j2woXOaTYFYnaSEbc1tk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="315219483"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="315219483"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 10:10:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="972783439"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="972783439"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 29 Nov 2022 10:10:28 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 29 Nov 2022 10:10:28 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 29 Nov 2022 10:10:27 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 29 Nov 2022 10:10:27 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 29 Nov 2022 10:10:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRbp5jrxnwBqCCGVdsUwBlbzcnKsr2E3www87uc/QJenj2TFXjiCE/dx01BgelHYehCPVQegOfo0O3Gdxua46Fx/3lLHqaMLJmbmYAKV1l5Obxt5mfzT347nsH1MeBHKygeEzZcUOW32cgHRCmwLq8YuDNQqs5wwrLcUbCfptjdi+muK6sho+nAV5sfiDWV91uGAVf0YhcoVGlr8NtAT8kKBF8oK3mnVH7NLeCczku2AuQzZUZogHVx6FIWIEG8BZgqKByfscnijOguDucT3vCQD5mi7j1QofQT5D5SmnMTdgenxJ2HmZZPSoKTAQtSekWRmIs5MARoveHLucRVblw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyUeXWx2WZueU/ZaHirXw9BTHeK6PuIuTLpQUA9aH30=;
 b=hilrAR+wEqEM4B910a2eKKsTvHlDAOTnSZDM6YCDeDHayDgEs5sTFnlM475iz7Nesx8gBLuc7bvDWZzvQ/sgFw2lqXEUF8tjI9a2+q4ifc7BHBYE6b+6viFZSavu9Cun1ZgMnWgQuOhdP6B1VyxHMVDcFj0WSmhIc0rO6XP7eI3qxuqEhYtyHAO5q18yssGBDcxxZ44sRNNqMXhnlyyif4GR5qgguw/6qbscafcgTIEzSZlnUKcUKdQCrjJ9i6v5M1DVjzXMNDpa/Bj7Jp66StqbZBDOKAvXgb8gTlz7sJtKantV+dJOs8WETqWiRVh6jjsSFnb0aFgjZpW9DVdE/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3240.namprd11.prod.outlook.com (2603:10b6:a03:18::19)
 by SJ1PR11MB6228.namprd11.prod.outlook.com (2603:10b6:a03:459::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 18:10:25 +0000
Received: from BYAPR11MB3240.namprd11.prod.outlook.com
 ([fe80::4bae:9f39:e66:96cf]) by BYAPR11MB3240.namprd11.prod.outlook.com
 ([fe80::4bae:9f39:e66:96cf%4]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 18:10:25 +0000
From:   "N, Pandith" <pandith.n@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hall, Christopher S" <christopher.s.hall@intel.com>,
        "Gross, Mark" <mark.gross@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "timestamp@lists.linux.dev" <timestamp@lists.linux.dev>
Subject: RE: Intel timed i/o driver in HTE
Thread-Topic: Intel timed i/o driver in HTE
Thread-Index: Adj6qih2Gsi7knz7SkKtEKSdboc8IwBFScgAAOFR9zAAD0o4gAEm1x9g
Date:   Tue, 29 Nov 2022 18:10:25 +0000
Message-ID: <BYAPR11MB3240CE6547117D138B1A112DE1129@BYAPR11MB3240.namprd11.prod.outlook.com>
References: <BYAPR11MB3240F382BD180FF90C7DF0B9E1069@BYAPR11MB3240.namprd11.prod.outlook.com>
 <7de35859-97ab-8e88-f590-d5851b81773b@nvidia.com>
 <BYAPR11MB32405F4FA22BB47BD03C8F18E10C9@BYAPR11MB3240.namprd11.prod.outlook.com>
 <CACRpkdbY5aU3OTufA0q+N7Pwm0shGgnjScAGR_96oo9XdgBDhQ@mail.gmail.com>
In-Reply-To: <CACRpkdbY5aU3OTufA0q+N7Pwm0shGgnjScAGR_96oo9XdgBDhQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3240:EE_|SJ1PR11MB6228:EE_
x-ms-office365-filtering-correlation-id: 9bcaf1a4-5a6b-4b1c-4165-08dad234fd37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b+tMzZETSkBeYCReGImFTmPvsd7zifKtQGmYBdVPtFmsDvd5qq8accQ1CU8RjWjvzHkglugDvl7vc5tIYHiY/P0fJhEce4R5zPBx1WsRnLM+xMJbY2XfkJkU7tORgwKjkXqpZ8I9j7FkKFOIhu9R0IYBU+C9JyY5lQvaHzIIgGeghXfTGo2vDJP5vF8JV54dZ5By3Lbu1x213si35Kc3Ck+5yP3cLkODsIm5FMiZww3HduRcnYzonNk01x7wj4Ec+ncjK8rGNX6GjuVD6rer7EiykgWw0ofnCQ73gVLdBidWuSQPQ0bAfilYfSQQgm0FnAEZegYiV1CDMsKHzp79/JG7+d5yXirspydj6T3eyKnv3TkvvmRQviyhja95csjhZMlE/VH8vDiAHMSrMH3wq/LGYLjg9C82WMbUDOMnnJgP4sF7iQUvEEda2RhO0xba1Vfa71MPVnxqN6BVm7NiOLVkDm7Bz1KAdr9zSayWBuC+HxlW5UNoJ7xNETWTjKngfvTXYOL0u9AGSUgpVMhl1sSnwnIhXrbizrt1rX7rTNHeQ9p3VvaCzDbNa7FAnyViFpmf8ie+1D5cEn0LWFKplieRPKJQfsDuWIvu+vM6X6VnyJjqn4h2lFiJNhjVozz7ibf7K1J7k1zmCYm2ThbB460Q3PnUIg3h3xX58nA4laTiHTPm/wv07zbVPbUiHqEv15mYxSBKf2GJ3GP8sVN9Jw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3240.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199015)(186003)(54906003)(316002)(110136005)(38070700005)(33656002)(82960400001)(55016003)(86362001)(38100700002)(83380400001)(122000001)(26005)(6506007)(53546011)(9686003)(7696005)(478600001)(71200400001)(5660300002)(2906002)(64756008)(8676002)(41300700001)(52536014)(8936002)(66476007)(66446008)(4326008)(76116006)(66946007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkRwMEJiV21VTTAyYytBRzhMR3ZkOWdBU1JRSWlrWE9sa2thM2JpbjY4TEVG?=
 =?utf-8?B?S0ZvUXc1SUNIQTJzQTRzQWVETHZ2WjdDZ3pzZms2ZXJpcW9tdm5KR1pSejU5?=
 =?utf-8?B?b2pCM0UxclFXVmpMUjlvTmJleEtZNit6WXpJWkR5cktVMWZtLzZvdDN6SCs1?=
 =?utf-8?B?cTlXcXlOdkozMlR3dElidTMxbXNjZEtwODR1NlNmNlp5bjNCUHNsWk1BNUZW?=
 =?utf-8?B?SHRXTjB0MlBwaWZMb2xCN3JCMUx1a2tYVWF1THpIUmxEcWJ5b3EzWkJtWlVk?=
 =?utf-8?B?eW0rZkltajBxRWhNV1Ruay9lQlpndURLWVFMU3FGL0hydW96SmJYTXRhVTRZ?=
 =?utf-8?B?dkVxV1NZdTZlcHRCdkQwZGdtUFYrNlFmbHhzUEdvdDVzdmVmang1WFpBYjdH?=
 =?utf-8?B?RHFLUGk0ZW4rOWxwVXZ3Zm51aE8rR0puUVNMZ00vR3pockpSNjcvc2dHaitt?=
 =?utf-8?B?eCtCekhCb0VjajJ5WW0xNFNOeEJ5cFA0eFNoL0lSMXJOUy9TeWJwRHhCTU5Y?=
 =?utf-8?B?RTFBNk85SkUxeFI5MUc0M2cwZXk2LzFHZkhlVUlpand6TjAxZEpDV2RKb0M4?=
 =?utf-8?B?WkxDWDR0SmR0am1RaFBuaGpNZEQzYW9hc2duVExFM08zb1lKRG1GOGtYMzMr?=
 =?utf-8?B?Z3RiLzRBbUlIby9yaEhuaUFFV1hWYzZqODFIVGZjS0dQTDFtSmp5NmZhMkxT?=
 =?utf-8?B?QUVWM3lkQy9iUlhzSWdGU0RjVjJTTVAvTklpS1c4NHpwSDRWUFBycDd5Z1dG?=
 =?utf-8?B?MHc2dlpkSTdaZTl2QmNwOXNRbkZKbFVaUXJXTGxMSU1od2F3OWFqWEw2dThZ?=
 =?utf-8?B?VjRYNUtITUwwQWxMaDdNVS9Ldkxka3hPb1ZTUWNwVnV3SXpZV2plVjRhMWt3?=
 =?utf-8?B?djVQRU9ieVEyT0lDaWtxMWpFdHBKN0FIVVYvQzVFQ3plWkQ3MzVlQ3hpVmRw?=
 =?utf-8?B?SFlVUXBrN3B5NTQzYmdKekRLeUJiMXhxTnpGU3gxZDFWVjdVOGZwRHFhUlFq?=
 =?utf-8?B?VUpyYURveUlMVDVlblhJZG5wZEdocnY0WlBZSWFqVGtXVXVBT1lZaGZuYU56?=
 =?utf-8?B?R3hwdVh4MXpsbDM5bnl2UmJNRENmdUg1ZXdVZXAyRE9WeWhSLzF1V2ZsYS9T?=
 =?utf-8?B?MnhGTldtcHlmMDFqdHpGbWZFUjQxMjU2WElOYkJybHBwWDlXbGkyc1BzMWRz?=
 =?utf-8?B?R2dHSE1ZWkF3VU40V3FyUU9Fb0t2TXdYTVhsc2kxZUpVQXhObEJKcGMzNjRm?=
 =?utf-8?B?emh6TXlOQ0pSVnNFZWxFNnloVnd1TmI1NWFGK2t5YWhWS05jd2NkNWxxeXRm?=
 =?utf-8?B?WCsyQ0o0OXFyRWZtQmFpYy9ReFJ4K0p6b0tKR0M5bHZ4N09yOGNvY3A5MWlS?=
 =?utf-8?B?bFp1REpEVi91eE5VRU9FZ0hiTGIzbk9HTlUvTUZKS29aQ0VRR2hMeS9sVVgw?=
 =?utf-8?B?Y2hKeTFBajZydE43YkZMVkNxS2dPMXNXVnB0bE1qWmFTUTFRT0NTa2JrQ3NY?=
 =?utf-8?B?MWVNTWhFaUF3K2Znb3o5V0NPQmFlOG9DRlpqTnRRbno5d1BOVTJSWFNNQ0gy?=
 =?utf-8?B?anBEUnFIZzhDS0p5WHVNTi9ld2x2d21kUGxzU1VuNEhIYk5nUzNYdWNMMm5B?=
 =?utf-8?B?MzRQK2o0dHhUcHZpRTlaRzFRTjZBZDk5blROaFpvQlZZSVZyaXNwMlNpcUZv?=
 =?utf-8?B?VVgxVjBJdDNEdXUwWUxHcTE5UWpEZmM1WTR0NlRZVi83SHFkM3daQk5Ndm9F?=
 =?utf-8?B?aEFRM09tNUd1TW8zUXNuZy9xN250V1d3NlNIdVUvejcvTkhxZmdyZlVuWm1U?=
 =?utf-8?B?L04rbUo1UDZqWXZUMkZ5bStVbk1jWlp0eDJXMERFZ3l4NkZuTWRNaHZaaita?=
 =?utf-8?B?bFlaS0N4bFQ2REt3OW5vUjcwY25XUUVvVXlxeVZadkpJeFNYcHJOaENTcDJG?=
 =?utf-8?B?c1VMS3FXYzM4MFpMTVJXYjhkaVlCdDJJTFZEVXlqY0tMcCtNdVVTR1ZxVFI1?=
 =?utf-8?B?OEtoR1pEL2NkMzVkUzVQdGJJMk1lR2laWFV6V1FybE9lR1pnZ1B1ZmErOG5R?=
 =?utf-8?B?NmVIUkJpNFp6eC9PNHR5enFMSjAyQ20vanFNdGl2N043emZ2ZDVpaEtJR3R4?=
 =?utf-8?Q?f+pcfcA0z/K0sc7cb1wffws2b?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3240.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcaf1a4-5a6b-4b1c-4165-08dad234fd37
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 18:10:25.4110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vFADkOa+jzrtqhhwH5ygrBKtv2FDAiJ/BgbMtRZ2DtLkblTH7CPawXsh9FGMUKWk1hjcMfZfGujvQQR0CHnqtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6228
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExpbnVzIFdhbGxlaWogPGxp
bnVzLndhbGxlaWpAbGluYXJvLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDI0LCAy
MDIyIDI6NTMgQU0NCj4gVG86IE4sIFBhbmRpdGggPHBhbmRpdGgubkBpbnRlbC5jb20+DQo+IENj
OiBEaXBlbiBQYXRlbCA8ZGlwZW5wQG52aWRpYS5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBIYWxsLA0KPiBDaHJpc3RvcGhlciBTIDxjaHJpc3RvcGhlci5zLmhhbGxAaW50ZWwu
Y29tPjsgR3Jvc3MsIE1hcmsNCj4gPG1hcmsuZ3Jvc3NAaW50ZWwuY29tPjsgU2FuZ2FubmF2YXIs
IE1hbGxpa2FyanVuYXBwYQ0KPiA8bWFsbGlrYXJqdW5hcHBhLnNhbmdhbm5hdmFyQGludGVsLmNv
bT47IEQsIExha3NobWkgU293amFueWENCj4gPGxha3NobWkuc293amFueWEuZEBpbnRlbC5jb20+
OyBUIFIsIFRoZWplc2ggUmVkZHkNCj4gPHRoZWplc2gucmVkZHkudC5yQGludGVsLmNvbT47IGFu
ZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbTsNCj4gdGltZXN0YW1wQGxpc3RzLmxpbnV4
LmRldg0KPiBTdWJqZWN0OiBSZTogSW50ZWwgdGltZWQgaS9vIGRyaXZlciBpbiBIVEUNCj4gDQo+
IE9uIFdlZCwgTm92IDIzLCAyMDIyIGF0IDM6MzggUE0gTiwgUGFuZGl0aCA8cGFuZGl0aC5uQGlu
dGVsLmNvbT4gd3JvdGU6DQo+IA0KPiA+IFNpbmNlIHRoZSBjdXJyZW50IGdwaW8gZnJhbWV3b3Jr
IGlzIGluYWRlcXVhdGUgdG8gcGVyaW9kaWMgb3V0cHV0IG1vZGVzLg0KPiA+IEkgdGhvdWdodCB0
byBkaXNlbnRhbmdsZSBmcm9tIGdwaW8gYW5kIGRldmVsb3AgYSBuZXcgaHRlIGNvbnN1bWVyLg0K
PiA+IFNvbWV0aGluZyBsaWtlIGh0ZS1saWJjZGV2LmMNCj4gDQo+IE1heWJlLCBpZiBEaXBlbiB3
YW50cyBpdC4NCj4gT3IgbWF5YmUgaXQgbmVlZHMgaXRzIG93biBzdWJzeXN0ZW0uDQo+IE9yIG1h
eWJlIGl0IHNob3VsZCBiZSB3aXRoIHdoYXRldmVyIGlzIHVzaW5nIHRoZXNlIHB1bHNlIHRyYWlu
cy4NCj4gDQo+IEFnYWluOiB3aGF0IGlzIGl0IHVzZWQgZm9yPyBJZiB3ZSBoYXZlIG5vIGlkZWEg
d2hhdCBpdCBpcyBzdXBwb3NlZCB0byBiZSB1c2VkDQo+IGZvciwgd2UgY2Fubm90IHBsYWNlIGl0
IHJpZ2h0LCBldmVuIGxlc3MgdGVzdCBpdC4NCj4gDQpJbnRlbCAgdGltZWQgaS9vIGlzIG1haW5s
eSBpbnRlbmRlZCBmb3IgY291cGxlIG9mIGZ1bmN0aW9uYWxpdGllcy4NCg0KMS4gSW5wdXQgZXZl
bnQgY2FwdHVyZSB3aXRoIHRpbWVzdGFtcGluZyANCjIuIEdlbmVyYXRlIHNpbmdsZSBzaG90IG9y
IHBlcmlvZGljIHB1bHNlIHRyYWluDQoNClVzZSBjYXNlcyA6DQphLiBUaGlzIGhhcyBtdWx0aXBs
ZSB1c2VzIGxpa2UgY2FwdHVyaW5nIHRyaWdnZXIgdGltZSBhbmQgZXZlbnQgY291bnQNCmIuIENh
bGN1bGF0ZSBwZXJpb2RpY2l0eSBpbiBjYXNlIG9mIHBlcmlvZGljIHNpZ25hbCBvbiBpbnB1dCBw
aW4gDQpjLiBNb3N0IGltcG9ydGFudGx5LCBwcmVjaXNlIHRpbWUgc3luY2hyb25pemF0aW9uIGJl
dHdlZW4gZGV2aWNlcy9zdWItc3lzdGVtcyANCkV4IDogU2hhcmUgcHJlY2lzZSB0aW1lIGZyb20g
YSBHUFMgcmVjZWl2ZXIgdG8gdGhlIG5ldHdvcmsgb3INCiAgICAgICBTeW5jaHJvbml6ZSBwcm9j
ZXNzb3IgY2xvY2sgd2l0aCBleHRlcm5hbCBzaWduYWwuDQoNCj4gWW91cnMsDQo+IExpbnVzIFdh
bGxlaWoNCg0KUmVnYXJkcywNClBhbmRpdGgNCg==
