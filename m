Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7986FBD5B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 04:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbjEICpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 22:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjEICpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 22:45:42 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735F47685
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 19:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683600339; x=1715136339;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fzwTZIoj9K4+Fy2JBRS0bToa1FVCU+4Fae8ojG/pv9U=;
  b=RtyWgBEaeH+3Q2CtKPL7IBAhisRiWTAbPrjdG8jMCLyXjbWdZPLUnPU9
   4qN6HRj8ns5gudyL23NT3/5bMqf/BChzUYa2uHAHsXrTvB67/D0OEy6Eo
   bVpPd6BHXjzmJ8HPCVa1rksHDiGpapJEePzYk9c/IOsS2Yf572y1gkq/D
   74/QMF2JvFRUhs/xMl3WLzYMN1sj4FO+dzgl6IMrrYYhsO5Pj0cgwMH9+
   kZtzVxNVYRX49WhPFksZQab70q5zQ3z9ocxTfp3GQKzfUroSSdQP0DXaL
   zd3xo7eA6fzdDjfFxr0D/VKAb744DEp6XO1D17a5+o4IwswSO8QirERpj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="329419487"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="329419487"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 19:45:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="692805389"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="692805389"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 08 May 2023 19:45:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 19:45:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 19:45:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 8 May 2023 19:45:36 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 8 May 2023 19:45:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cB+iYDhYQnRQtbd6NgIJ148XlbQAqNq2ENlPlNXlWq10yezzlYA1oIy50XA/02fcsmuoXww4itZ6/JghkbBfIX9e2s1bXnhfx1ZOAp0kvPrkasmsaf4daC0IRKfRLD7oafVmYqkKYIwKea9Nasu5lZXJNjrNvNq3qzlViq2gFJa82YdMysmFtfjTJfZgkpJQ+pYxSF+V+qCNfoyernnpyBr7I+nsPDb2Onu8u3EvAM5FR7AL+fzB63kR7pJcuJIQ6VOC0yRjQ8F6z8Mxi8pE3UkVbGDLhhdjMkwcLzT96rKJyMhSUjsCEpq9UebuG7qm+KqIf/ezThXV31mLCvhfJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzwTZIoj9K4+Fy2JBRS0bToa1FVCU+4Fae8ojG/pv9U=;
 b=QN8OTcLRum71eqbx0m5MKiStu11WZUVwwLbPlkE4ZgESQw9SNTO+9eOFedbPq3f+GrRj58RZosy3eiZmMRW9F6pRzBYUO3pBInjegODrr+CWhfj2tRLSsuYJdy1US7ejtBB0LCLwrobRnZeEqRIEarJzNU5rR3QQZc2r4B623xEjYHGg5wb+WATL525PHcNcwGXIKlE0iC9PXlZcc1XbBM5V2Pe2VcSLXH9prDNyKQg/r+1O1Zk3RpghriSh/O499SIYpoVrReahwg6S1MVB5hkWe0DjnR1AGlYHWSSQYy+0a/Y/gUWSRp6ISM4xfinux8/okWCj26VUbdDYiORVYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by MN2PR11MB4661.namprd11.prod.outlook.com (2603:10b6:208:26b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 02:45:35 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::48a9:8a81:560f:4982]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::48a9:8a81:560f:4982%4]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 02:45:35 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
CC:     Boqun Feng <boqun.feng@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] locking/qspinlock: Make the 1st spinner only spin on
 locked_pending bits
Thread-Topic: [PATCH 1/1] locking/qspinlock: Make the 1st spinner only spin on
 locked_pending bits
Thread-Index: AQHZgYVXNOgy8IoOo0K7W+BWXJKqna9QgTkAgACz4HA=
Date:   Tue, 9 May 2023 02:45:34 +0000
Message-ID: <IA1PR11MB617102EB293516D2DC81F28089769@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <20230508081532.36379-1-qiuxu.zhuo@intel.com>
 <29297e16-2c79-8367-cd6c-efedd0a8d9ed@redhat.com>
In-Reply-To: <29297e16-2c79-8367-cd6c-efedd0a8d9ed@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|MN2PR11MB4661:EE_
x-ms-office365-filtering-correlation-id: 8d1cb366-7973-4d2d-0563-08db503776c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sr4tjtVmGllR7hAQrkM4gv5kXrK/mxG0kL1Ut8O01jaueUY7KsIhsPU+yAJroLmrr0nGlou9vI/yueQnLGzOjHPs+WMwCC8BV70tBFTwVRITIDsJLn8D8gsUcFlJXLoT1l9BuvuDaVsB4Htw6V6j051ojNV1vK6bJHQ0EGjqwnkBFAQ9HdZyIkAH/Uq4DuIzKO2kZgkb/V1HDOLK/KDOZMAFMnSotXIeOZuxMRjmAONCgMXwdza4Oup6OLqrLEpLFDt4QdOP26lyrReCp6NTztJnOrpZnKH3wkWmuJmuLvMtD5IWVskpwt+r8TX/w2lKumsyK5JZiY1mmB1edZA/tK9oGz5h1JFqfX52ZQ/oZ73srWL4g4sjQQO0wNTuJw60tjr4FFCs37n85qXCAiCcgqbMfFCnMpUPhG99cIYs5XsoRlbVFw7MZXns2YQpBbNa9vk83Y0AbONADsSu6RhAoOFikdnQW5KNmfVfD1dGs8nnBBqeqLvNnry/SWGsrdAohRdL+zqmqmDtUryfhuQT2XoOpb6Mc/XcjuHrfqSLuBn2EPXYlNnlw2dISDqV5hCfHHadZ34aPxWW/n8grhuYrUKYIbgOh54KjGcBY24lY/rREUOo4K63fsIMLJpHWZrOH0b/MJZRz9k8Vv9V+C7jdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199021)(966005)(26005)(186003)(71200400001)(7696005)(38070700005)(6506007)(53546011)(9686003)(64756008)(54906003)(86362001)(66946007)(66556008)(66476007)(66446008)(478600001)(110136005)(76116006)(82960400001)(38100700002)(122000001)(83380400001)(5660300002)(2906002)(8676002)(8936002)(52536014)(41300700001)(33656002)(55016003)(316002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWgwekJYM25NZ2k0VW03SExlTUNvWVhab2dCaU4wcElVaGxSNmVHeDhHV0d6?=
 =?utf-8?B?REZnN21teEZFUTlGOVozYVZLcjNTRHJoVUFpMHRTUzN6a3REbVBNeWhvbTlG?=
 =?utf-8?B?UEF2dEtuTEJ6RG9NSUYzQkFKdnJ1YzM0NnJEdmF5QmpYRGVCOVFrdzcyckgw?=
 =?utf-8?B?VDlWSzB0MysrU3M4TFdtQ2xncXFnWjBCTHlUOVRYRmo3SS8xandXUDhaNVBy?=
 =?utf-8?B?cjVNR2Z6Y3J4RC9adlBybFQ3UTJBZUxMejFxYm81cU1kemV4Y0dTOHVJTFhw?=
 =?utf-8?B?VUJBUXFIS2Zxb0JMOElYNWZKdUdPbVoraG5zZUJBNHF5K2V0UUxWeU1BNDNO?=
 =?utf-8?B?L0xjUmczTjhZUmxXL0RNbkZkaXJTL3ZNUjRybSsyOHpzNmg1NFBVaCt6aXYy?=
 =?utf-8?B?bGtGbUtlclNTdHBCRWFBVTVLUS9IYnh0MEZrR3V1UDRQRWFJWUVNSVVabGIx?=
 =?utf-8?B?b1FrRi9IZk5QVTgvbGdUQis5bVFYc3dQT0FjSThLTkwwdlpudm5WQ1hzWGxR?=
 =?utf-8?B?d0NBUzFlRGU4Z09ZUHdxblRvaDlIa3Y0TmU1UlF0NDFscG5yMXJnQitYVUtQ?=
 =?utf-8?B?OXArd2FRWXpDdTg5K2tOOVdhZzduZ1ZoRXltdUdVVDN3Njk2T21jV3pkQmxS?=
 =?utf-8?B?WFFaVk5mMVNxQTFMdTNVS2U4UW9DaGN4WkdFSk91Sk1SQTcrOFEremdzWVRh?=
 =?utf-8?B?Z29lN0oyaHAvQVFYdm5nM0wybjJyYUdHOEhpdnl6UW1jYXFNb0hDRXg2K0Zz?=
 =?utf-8?B?U01HUWpleXBhVmkwVWxYYmx0MjV3TkZjZlFXa0NHSlcvc1ZGQ25DeWlNSHF1?=
 =?utf-8?B?dms3aXlWcmdLZnM5YmZjUFpYTlNNZkZFVE9hdDFTZ3JxODBkVUVwUWo1YTdO?=
 =?utf-8?B?RHMvWHVBMlhib2VyS3FiQytzSVdCaGQvWWd6RlI1UlpNOEFRaFBuNmJaempw?=
 =?utf-8?B?M21VR3V0cVlKWmQ1aEpUKzlyZnVlZjVwYzl0ejdvTDVlVFBlVG9wcFlBcDdr?=
 =?utf-8?B?N3RUUWxBdnE2ZE9ZOXNTVkYxb0d4UGxNRDlKeXl5SHIwOWV2RThyVzZEVUp4?=
 =?utf-8?B?L1FxTXhTQ2hta3NraDhBaXcwQ1NQUVNQWHdBdVFzWi9XcWxhZVBUaWQya0dG?=
 =?utf-8?B?UmtXOWFnTnhGQnF4RE5vRHNuVnluSHZBTnh5ejNOa1JjU1pJbS9QT01hakxl?=
 =?utf-8?B?TGNhdjFXaDdiRzh6S3hUek9wSWw3Sk16MjBLZVZDdFJmWFlJaVVqV1hLNnJK?=
 =?utf-8?B?SEo0ck1FWEF4VWQxYnoyaFpLUXd6NVZ2QXpFVEFVb01MT3lXOXVaeCtwcnkw?=
 =?utf-8?B?WURpV1pWRlZJWTFRczMzeDg0anZPMGUzTEk4cnhkcFoycFVNVEsxQ3BES2Nq?=
 =?utf-8?B?a1lCZ3lkVENsQW4xRE5maTRpRHRUTmU2a1U0ZlNaK0pnMWlmSXdqbDVucHRh?=
 =?utf-8?B?MHlMQ2YxSXRZZ0dqQzduWkZLdWMzMUxMRDNoUGRDdUxRdm5WT1ZqNXpqTFhw?=
 =?utf-8?B?bDhNRGlOcEltWm5UWXl5U3YydmtnMDE2RURCYVVHL2pJd3dMdzhkRzNsUXpN?=
 =?utf-8?B?Zlc3UnJtbDZDaTJHY1JWNUpLblhWSTZOaXJvZ3lydkhDcWhrSWdqODFjL3lq?=
 =?utf-8?B?K2dxajYzQzF1YmlDTHFTL09nUE1FQnRNbTlKbUFGZVJGWFkvNU9Qb21xci9U?=
 =?utf-8?B?L2FMYUQyVGhiK1VIekx3UXZYNVpMMkpVTUsyWjNCL2JnM1RZQXdnbzNTOG9V?=
 =?utf-8?B?Qm9EZGduYndXL2JkVDdqQndhaG05LzhBVTBYN2twem40RS8vdGJ6dXB3S0ds?=
 =?utf-8?B?QTJXbE9STmgyMzZvOXNsYTRyU1JGMjdaamRIMVBJR1AzOEFQb3BiK05OTG1m?=
 =?utf-8?B?NjFjYzFtRXFkWHdXTzZhQzVmZ3BYelF3Rld4T25uQVVxNm8xaUtqckM5dWho?=
 =?utf-8?B?MjJSQkVYb0NVT0tGbFlneWh0MDdZOStDb2xSbmpib2Fwem54VXFtRDFjQzM4?=
 =?utf-8?B?VjZDZExybVJDVVMrRmZ5QmpORVVZNy9ZbmdrMW9VVnZFbTgwekFldDJvMUQ4?=
 =?utf-8?B?VFo0R2pVZmhUS3N2VHJrVkFMcnhnSStRZmUvS2JlUXl3SXQrQUZQY0dpdUdk?=
 =?utf-8?Q?Zbfi07BazPPJ4tfnl+NictSdm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1cb366-7973-4d2d-0563-08db503776c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 02:45:34.9031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9TM1j6Tr10NMXOV3ndNAffV3hXvL9CdWPW5zHqGptMob2750IsTzs8+DqTMrbHEbB2Zy2CKvx89uBQFZKvsBbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4661
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgV2FpbWFuLA0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3IG9mIHRoaXMgcGF0Y2guIA0KUGxl
YXNlIHNlZSB0aGUgY29tbWVudHMgYmVsb3cuDQoNCj4gRnJvbTogV2FpbWFuIExvbmcgPGxvbmdt
YW5AcmVkaGF0LmNvbT4NCj4gU2VudDogTW9uZGF5LCBNYXkgOCwgMjAyMyAxMTozMSBQTQ0KPiBU
bzogWmh1bywgUWl1eHUgPHFpdXh1LnpodW9AaW50ZWwuY29tPjsgUGV0ZXIgWmlqbHN0cmENCj4g
PHBldGVyekBpbmZyYWRlYWQub3JnPjsgSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+OyBX
aWxsIERlYWNvbg0KPiA8d2lsbEBrZXJuZWwub3JnPg0KPiBDYzogQm9xdW4gRmVuZyA8Ym9xdW4u
ZmVuZ0BnbWFpbC5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggMS8xXSBsb2NraW5nL3FzcGlubG9jazogTWFrZSB0aGUgMXN0IHNwaW5uZXIg
b25seSBzcGluIG9uDQo+IGxvY2tlZF9wZW5kaW5nIGJpdHMNCj4gDQo+IA0KPiBPbiA1LzgvMjMg
MDQ6MTUsIFFpdXh1IFpodW8gd3JvdGU6DQo+ID4gVGhlIDFzdCBzcGlubmVyIChoZWFkZXIgb2Yg
dGhlIE1DUyBxdWV1ZSkgc3BpbnMgb24gdGhlIHdob2xlIHFzcGlubG9jaw0KPiA+IHZhcmlhYmxl
IHRvIGNoZWNrIHdoZXRoZXIgdGhlIGxvY2sgaXMgcmVsZWFzZWQuIEZvciBhIGNvbnRlbmRlZA0K
PiA+IHFzcGlubG9jaywgdGhpcyBzcGlubmluZyBpcyBhIGhvdHNwb3QgYXMgZWFjaCBDUFUgcXVl
dWVkIGluIHRoZSBNQ1MNCj4gPiBxdWV1ZSBwZXJmb3JtcyB0aGUgc3Bpbm5pbmcgd2hlbiBpdCBi
ZWNvbWVzIHRoZSAxc3Qgc3Bpbm5lciAoaGVhZGVyIG9mDQo+IHRoZSBNQ1MgcXVldWUpLg0KPiA+
DQo+ID4gVGhlIGdyYW51bGFyaXR5IGFtb25nIFNNVCBoL3cgdGhyZWFkcyBpbiB0aGUgc2FtZSBj
b3JlIGNvdWxkIGJlICJieXRlIg0KPiA+IHdoaWNoIHRoZSBMb2FkLVN0b3JlIFVuaXQgKExTVSkg
aW5zaWRlIHRoZSBjb3JlIGhhbmRsZXMuIE1ha2luZyB0aGUNCj4gPiAxc3Qgc3Bpbm5lciBvbmx5
IHNwaW4gb24gbG9ja2VkX3BlbmRpbmcgYml0cyAobm90IHRoZSB3aG9sZSBxc3BpbmxvY2spDQo+
ID4gY2FuIGF2b2lkIHRoZSBmYWxzZSBkZXBlbmRlbmN5IGJldHdlZW4gdGhlIHRhaWwgZmllbGQg
YW5kIHRoZQ0KPiA+IGxvY2tlZF9wZW5kaW5nIGZpZWxkLiBTbyB0aGlzIG1pY3JvLW9wdGltaXph
dGlvbiBoZWxwcyB0aGUgaC93IHRocmVhZA0KPiA+ICh0aGUgMXN0IHNwaW5uZXIpIHN0YXkgaW4g
YSBsb3cgcG93ZXIgc3RhdGUgYW5kIHByZXZlbnRzIGl0IGZyb20gYmVpbmcNCj4gPiB3b2tlbiB1
cCBieSBvdGhlciBoL3cgdGhyZWFkcyBpbiB0aGUgc2FtZSBjb3JlIHdoZW4gdGhleSBwZXJmb3Jt
DQo+ID4geGNoZ190YWlsKCkgdG8gdXBkYXRlIHRoZSB0YWlsIGZpZWxkLiBQbGVhc2Ugc2VlIGEg
c2ltaWxhciBkaXNjdXNzaW9uIGluIHRoZSBsaW5rDQo+IFsxXS4NCj4gPg0KPiA+IFsxXQ0KPiA+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMzAxMDUwMjE5NTIuMzA5MDA3MC0xLWd1b3Jl
bkBrZXJuZWwub3JnDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBRaXV4dSBaaHVvIDxxaXV4dS56
aHVvQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGtlcm5lbC9sb2NraW5nL3FzcGlubG9jay5j
IHwgMTMgKysrKysrKysrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMo
KykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9rZXJuZWwvbG9ja2luZy9xc3BpbmxvY2suYyBiL2tl
cm5lbC9sb2NraW5nL3FzcGlubG9jay5jDQo+ID4gaW5kZXggZWZlYmJmMTlmODg3Li5lN2I5OTBi
Mjg2MTAgMTAwNjQ0DQo+ID4gLS0tIGEva2VybmVsL2xvY2tpbmcvcXNwaW5sb2NrLmMNCj4gPiAr
KysgYi9rZXJuZWwvbG9ja2luZy9xc3BpbmxvY2suYw0KPiA+IEBAIC01MTMsNyArNTEzLDIwIEBA
IHZvaWQgX19sb2NrZnVuYw0KPiBxdWV1ZWRfc3Bpbl9sb2NrX3Nsb3dwYXRoKHN0cnVjdCBxc3Bp
bmxvY2sgKmxvY2ssIHUzMiB2YWwpDQo+ID4gICAJaWYgKCh2YWwgPSBwdl93YWl0X2hlYWRfb3Jf
bG9jayhsb2NrLCBub2RlKSkpDQo+ID4gICAJCWdvdG8gbG9ja2VkOw0KPiA+DQo+ID4gKyNpZiBf
UV9QRU5ESU5HX0JJVFMgPT0gOA0KPiA+ICsJLyoNCj4gPiArCSAqIFNwaW5uaW5nIG9uIHRoZSAy
LWJ5dGUgbG9ja2VkX3BlbmRpbmcgaW5zdGVhZCBvZiB0aGUgNC1ieXRlDQo+IHFzcGlubG9jaw0K
PiA+ICsJICogdmFyaWFibGUgY2FuIGF2b2lkIHRoZSBmYWxzZSBkZXBlbmRlbmN5IGJldHdlZW4g
dGhlIHRhaWwgZmllbGQgYW5kDQo+ID4gKwkgKiB0aGUgbG9ja2VkX3BlbmRpbmcgZmllbGQuIFRo
aXMgaGVscHMgdGhlIGgvdyB0aHJlYWQgKHRoZSAxc3QNCj4gc3Bpbm5lcikNCj4gPiArCSAqIHN0
YXkgaW4gYSBsb3cgcG93ZXIgc3RhdGUgYW5kIHByZXZlbnRzIGl0IGZyb20gYmVpbmcgd29rZW4g
dXAgYnkNCj4gb3RoZXINCj4gPiArCSAqIGgvdyB0aHJlYWRzIGluIHRoZSBzYW1lIGNvcmUgd2hl
biB0aGV5IHBlcmZvcm0geGNoZ190YWlsKCkgdG8NCj4gdXBkYXRlDQo+ID4gKwkgKiB0aGUgdGFp
bCBmaWVsZCBvbmx5Lg0KPiA+ICsJICovDQo+ID4gKwlzbXBfY29uZF9sb2FkX2FjcXVpcmUoJmxv
Y2stPmxvY2tlZF9wZW5kaW5nLCAhVkFMKTsNCj4gPiArCXZhbCA9IGF0b21pY19yZWFkX2FjcXVp
cmUoJmxvY2stPnZhbCk7ICNlbHNlDQo+ID4gICAJdmFsID0gYXRvbWljX2NvbmRfcmVhZF9hY3F1
aXJlKCZsb2NrLT52YWwsICEoVkFMICYNCj4gPiBfUV9MT0NLRURfUEVORElOR19NQVNLKSk7DQo+
ID4gKyNlbmRpZg0KPiA+DQo+ID4gICBsb2NrZWQ6DQo+ID4gICAJLyoNCj4gDQo+IFdoYXQgaGFy
ZHdhcmUgY2FuIGJlbmVmaXQgZnJvbSB0aGlzIGNoYW5nZT8gRG8geW91IGhhdmUgYW55IG1pY3Jv
LQ0KPiBiZW5jaG1hcmsgdGhhdCBjYW4gc2hvdyB0aGUgcGVyZm9ybWFuY2UgYmVuZWZpdD8NCg0K
aSkgIEkgZG9uJ3QgaGF2ZSB0aGUgaGFyZHdhcmUgdG8gbWVhc3VyZSB0aGUgZGF0YS4gDQogICAg
QnV0IEkgcnVuIGEgYmVuY2htYXJrIFsxXSBmb3IgdGhlIGNvbnRlbmRlZCBzcGlubG9jayBvbiBh
biBJbnRlbCBTYXBwaGlyZSBSYXBpZHMgDQogICAgc2VydmVyICgxOTIgaC93IHRocmVhZHMsIDJz
b2NrZXRzKSB0aGF0IHNob3dlZCB0aGF0IHRoZSAxc3Qgc3Bpbm5lciBzcGlubmluZyB3YXMgDQog
ICAgYSBob3RzcG90IChjb250cmlidXRlZCB+NTUlIGNhY2hlIGJvdW5jaW5nIHRyYWZmaWMgbWVh
c3VyZWQgYnkgdGhlIHBlcmYgQzJDLg0KICAgICBJIGRvbid0IGFuYWx5emUgdGhlIGNhY2hlIGJv
dW5jaW5nIGhlcmUsIGJ1dCBqdXN0IHNheSB0aGUgc3Bpbm5pbmcgaXMgYSBob3RzcG90KS4NCg0K
aWkpIFRoZSBzaW1pbGFyIG1pY3JvLW9wdGltaXphdGlvbiBkaXNjdXNzaW9uIFsyXSAobG9va2Vk
IGxpa2UgaXQgd2FzIGFjY2VwdGVkIGJ5IHlvdSDwn5iJKSB0aGF0IA0KICAgIGF2b2lkaW5nIHRo
ZSBmYWxzZSBkZXBlbmRlbmN5IChiZXR3ZWVuIHRoZSB0YWlsIGZpZWxkIGFuZCB0aGUgbG9ja2Vk
X3BlbmRpbmcgZmllbGQpIA0KICAgIHNob3VsZCBoZWxwIHNvbWUgYXJjaGVzIChlLmcuLCBzb21l
IEFSTTY0Pz8/KSB0aGUgaC93IHRocmVhZCAoc3Bpbm5lcikgc3RheSBpbiBhIA0KICAgIGxvdy1w
b3dlciBzdGF0ZSB3aXRob3V0IHRoZSBkaXNydXB0aW9uIGJ5IGl0cyBzaWJsaW5nIGgvdyB0aHJl
YWRzIGluIHRoZSBzYW1lIGNvcmUuIA0KDQpbMV0gaHR0cHM6Ly9naXRodWIuY29tL3lhbWFoYXRh
L2lwaV9iZW5jaG1hcmsuZ2l0DQpbMl0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIzMDEw
NTAyMTk1Mi4zMDkwMDcwLTEtZ3VvcmVuQGtlcm5lbC5vcmcNCg0KVGhhbmtzDQotUWl1eHUNCg0K
PiBDaGVlcnMsDQo+IExvbmdtYW4NCg==
