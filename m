Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8349D6B67D5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjCLQJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjCLQJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:09:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16CF32E59;
        Sun, 12 Mar 2023 09:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678637348; x=1710173348;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Z5PW4DABCAcGfM1oUKjwbO5Y06EauExg7zCECy/x7vc=;
  b=JQge356l3QRk9ZnI0d072tWREYrKM9/jGj0CGkX0KiDS1pKOR1EnLR5i
   ES3D9AQvji+diWe6Ogra2YR6Blg6hj6ywSdVnjXoSrLescHESrU2DPEEK
   qUY9voalrbk/P0c+h/n9kqf4B9OpWFLjyNyv138hC+5lxRJxAvqR3zQA+
   OJ7Ybp+AH6K1yOyOeK3kfMl1lDmegJH04nKM6O3YywsSevnhg837PXi8J
   xYcuAIIhVGW5dYAkqtzPIUrFijYpVfw0tWi9klNKUVioKkcrseVaEds7o
   vUpXmS++6KKtu0LkOQlWG1ffncpzKLd8OM+lqeiGiU67CsT9NJzNcxFJO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="399599883"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="399599883"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 09:09:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="924224762"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="924224762"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 12 Mar 2023 09:09:04 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 12 Mar 2023 09:09:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 12 Mar 2023 09:09:03 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sun, 12 Mar 2023 09:09:03 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sun, 12 Mar 2023 09:09:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIMX+mbqRgg6CMderfDimGM4XeliZq3Xj/UenMvXH5MCgOBgvwN44No1YsYK/Pte/TnnpL7fuz9Tv5ECq/QSGimXStOc8QxPg32neMhIGmzv1mnmw220l6Tnl/JIbiPf9JbPmfuw+cYxwXmKD1aGyTZkO4HQysIle5HFvGhu7phPKaeHlfz1mSk/PlNe2gK/1iJ9o42/3DHPva84bidQ1yUDS2Q0Iu0TivJEXbUw45t5zOygUk9+Nfk674Y7AcDnTjVhitXeJTU+jdarTnU1Pd9bLUTZSTRNdmlKv9PYqvOZxvc6axx0JLNRGvkev8Iby2y677dS0OBJGScEmNHJFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5PW4DABCAcGfM1oUKjwbO5Y06EauExg7zCECy/x7vc=;
 b=XauXVMICnNj/9TAqN8Bgx6w8jkEhIRyvuF8boMiUa8fbkPMVJ5F/h4G+b8IZeBra9ny5eRCznBngNX+eypwmlD/dKFFbmWLFkMuvt2z1dmsUkP/TGf2ELJOLYUHxgyn8xuhU1zakUr51pSXRQu4whroh3veHHORSbPH2XtO1wE/4icjDm9AzVroTLuZufXhq6Jip3nap5CTrHJR4X8KGPLlpELko5X2n7C6ydAkGABCNqV/3bvaZDtjopMn24iWOEUMrQ0k+COm9JUX+HHoSPNpWdDEfgvMR5vgbPjuFpZHEhYnrPH+lndiLcVDzCrCi4nZVtNiPxxK5edVPdRgRFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6604.namprd11.prod.outlook.com (2603:10b6:806:270::18)
 by BL1PR11MB5301.namprd11.prod.outlook.com (2603:10b6:208:309::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Sun, 12 Mar
 2023 16:08:58 +0000
Received: from SN7PR11MB6604.namprd11.prod.outlook.com
 ([fe80::5b73:3a9f:9a7d:b456]) by SN7PR11MB6604.namprd11.prod.outlook.com
 ([fe80::5b73:3a9f:9a7d:b456%3]) with mapi id 15.20.6178.024; Sun, 12 Mar 2023
 16:08:58 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Wang, Quanxian" <quanxian.wang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1 1/4] ACPI: processor: Reorder
 acpi_processor_driver_init()
Thread-Topic: [PATCH v1 1/4] ACPI: processor: Reorder
 acpi_processor_driver_init()
Thread-Index: AQHZTgXV++ts3wGoK0aUxKpjfYeUSq73XdiA
Date:   Sun, 12 Mar 2023 16:08:58 +0000
Message-ID: <49cefdcb5d50c1920b9c9533d30e886e368f3fe7.camel@intel.com>
References: <2148907.irdbgypaU6@kreacher> <2885079.e9J7NaK4W3@kreacher>
In-Reply-To: <2885079.e9J7NaK4W3@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6604:EE_|BL1PR11MB5301:EE_
x-ms-office365-filtering-correlation-id: 02026a9f-4138-478d-2c3e-08db2314164c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KJdbGX7vt1Z7EugJLELPL13zkqeghV/pmUwV5Hs3+U3ae0u1tx4eKVKCXgLifN+iCZ490He3Oiyo1CfJ/NlNs+E0YtAJoDSKcs65yej4dUNhL4tpgvy6ywu0RcAdMajpNoucn/sE7R60myjLqPSootdBwpd24DtN5i8728SVskWOdW4+KHkf38k3TQdAf5efCavtIpc1uAedL8EBRTTDt/R+3O1FkU90823RMBfQu7pdjuiqOotLqJ1ELsk1JoXonDYqhckEdGq2dLwpDAlq4sgqM6m59DmubpbXZYg/KzU8Ym9CFLbyPpCj0c8a2xaktRoO1W55ZoaFqm8UGpTRgTXLT6Wtan3NBmCKQ1BqU3wMeSfN3RjhYcefBbGy2VmhkCA8IlDspk5KmQsPxiEbZRZXKUW6EJ3RsdfKGM7lOe6yZyfk2sBRNfHQhuCPYfDofGOs0MeK+Os3ME8U3r55I2hny6gUPjXKszxlx4rVc3Nbvww8dF6OvA3LMdm1/b6rJTjBs0anbqqjEzytN5fWGxjw9MIhdpVXGGTyEg1Ah41PkLgRmliVTIaAa6E+mpH7e8MsMircEc0KHiutpLjrmszYByTuyJD3YDs3rM2vqMrlACiLrO20MS4INcRNHnPnLbwDWH7ioOdw4WBMvpByIRQByUOS6bk3eT/IZXlI16EUWRcHhzO24wCwCCisBpCVhxNis6CGIOSxotHtOzOavGWL6FpiBvrt22Ucfw109jM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6604.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199018)(38100700002)(122000001)(38070700005)(82960400001)(36756003)(86362001)(2906002)(5660300002)(4326008)(66556008)(66476007)(66446008)(64756008)(76116006)(66946007)(8676002)(41300700001)(8936002)(91956017)(2616005)(186003)(83380400001)(54906003)(478600001)(110136005)(316002)(6512007)(6506007)(26005)(71200400001)(6486002)(966005)(84970400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QW1DamNOTkdPYTNta2d5cUlOSGo5RUZBNEhOY1VCUmFYeWdzcEtxNk15VVNW?=
 =?utf-8?B?TWY4VFFZd3QwTWc0UkNEUHBJaXFGOFZyNDk2eURzcFN0RHBiOGRZbFprV2Nu?=
 =?utf-8?B?TGVBRDZIdmp1OTJEMUJST0F0Z2xpZXp4bjZ5VTZYcERJekt4azl4NDMyZG0y?=
 =?utf-8?B?RUpycmM2RndXNXhIU2FjSXY3YWU4b05PQ1RlaXprTDYzaC82T2JjNkxUYVY1?=
 =?utf-8?B?QkErcXFpSkN4T2xmcW80Sy9oODlWYjYzODBqeXpPREs0cllCcG9sS2ZVODZY?=
 =?utf-8?B?WjlWRFNPTVcvS21GRlBEaUJVY1FkdUpHM1Z2VjRnUFp6VTJWTlFwMG0rNzZZ?=
 =?utf-8?B?ZnhBcTFhZCtGMEFJZjArb1BEYytla3luc1JqWTRMNllsZ2d2SEhDK1hTeEgv?=
 =?utf-8?B?L2NMTWRuaTdKTE53dW93RGJrdzZQWE5jL00ySzlwR2NTMFQweXJSMEp6OFZZ?=
 =?utf-8?B?ODNHOThVNEJkSzZpTFd4QzExSlN6OE1PRWwreGxETkJWSDg0MysvV29RRzZX?=
 =?utf-8?B?SGwyNWM5VmJ3TE1Nekw1ZjA2YmRndVA4M3dTM0NubldhQ3JtY3JvbXhWR2Jl?=
 =?utf-8?B?bTFsY3VmTGNXN3NpTkdvSnZFeW42TlFMamFseXQyOGRPamVTTitReVZsYVNW?=
 =?utf-8?B?azc1ajhMeDBvQlI5NXlpSGRTMFhwK1IwaVRpc0J1VGZQK1RncUZKRE1DRUF0?=
 =?utf-8?B?aElISGI1OTdrVW4yVnpaRWpXUHkzV3gzVUtmRC83Q2Y4bEgxdTd6cXd0Um9y?=
 =?utf-8?B?ejZ5K3FCOGJQRm16b3pLL1V6MDVBUHBUUVIxTFdzcTVEUkZES3A0bFF5d2V0?=
 =?utf-8?B?dUkraGIxMCtqK3BKa3J3Z0k1dXdXZ2RTdXhyL2pqbTdidjBxWkhwOTRHdStP?=
 =?utf-8?B?RFNqTTRiR2VzUUd4KzJEa3BMSzdLVmhkakppRmhNZm5jT0t2elZuWnczWkxi?=
 =?utf-8?B?anpxS2lpUWd0SjQ4MTNVcXdJanpYcnhybmVHdER2Y0FYenpRUnhMQWNxWmtE?=
 =?utf-8?B?KzUxMWxIMGlNWGxEZ3Q4TFl3cndMR215U3RramE0clZycUtydXgrYVVyNkRt?=
 =?utf-8?B?d2djVDZnV3V0bzdtR3JvN3JTNmdZekZCcUY0TlZ3UVBiV3ZvUFZKbkIreGRX?=
 =?utf-8?B?VU5IV21SQjRwdjllcVBXc2huRktOMnBNcXFMSXBmQk0rMkowVk53dWV0YitB?=
 =?utf-8?B?VW51cnN5Q0xRV3RDTlU2Ylh5VVhyU1JDMVpURXZYMkpmMVQwQ2IwUEVBOGRW?=
 =?utf-8?B?ckZsemlvUWk1TkNGUWdFeXN2VWJjejdtOVZENWxWQ0orTG9WRmN0LzhjeXMw?=
 =?utf-8?B?cHNza0xlS1lHZ2tTZDhXV2VDQmJPS3JaM3dRK2tiZ3MrQ25JVVdwMDYreDhk?=
 =?utf-8?B?cXpxWitHK0hCMEV6ZWc1U0NwTGZOS1VLaXZQaGNQUkFKRWNqWWtOOGFZRjIw?=
 =?utf-8?B?R0pWWDh0ZkdXaU5uT3lNQ0hIN055cFZ6RVBORzhBTGNRTjhNNEJTNlVVcTVn?=
 =?utf-8?B?Q2xVTitEUXQycitwbGFSV3hOb1pPTndQZVRhMzA5djJYZnNDQjZLRWorWGJj?=
 =?utf-8?B?dHpPNHBYajZXUmMwbGRTazdQa3RZb1ZUdkJmM1d6TWcxSFhpbjRQRGdzUlhX?=
 =?utf-8?B?dGhYQmZWb1Q2MTZNTlhSS0tIQjkwV3N2Q1ZJeE9XaUhmMW5tekowOGlXcGhL?=
 =?utf-8?B?KzdvQWUrMFFYVDUrUnJHSkp0aU1pZ0ZpclUyNmE0VGpGVHRDK0s5eXduOGNz?=
 =?utf-8?B?M1JRSU9EbGJzYS92TEZMcTRhZEpKTDg1VnpyNEdsOHRyZzlyQkd1YlBQc2Zu?=
 =?utf-8?B?MDcvMUk4UjJ6aEg2aW9mQkh3eFlKbjQ4RnZtcm9mVmFNdmhMblJ4L2tNZC9D?=
 =?utf-8?B?UWRkT0VLYXQ3Y2ZaL1N3MzVIb2dIUkNJWE53Q1hYTjljaytGcnZPM2pzb3Fk?=
 =?utf-8?B?cFBrL0xuaEsvT01xUlgxSHdLZlRiSnV2bGhuRXpmLzdVQ1VYZ2NvV1N1TEFQ?=
 =?utf-8?B?MVIrUWtJc3F1N0hpTUxDN2E5WW1FbEtMVUFGM2F2K3FHcWE1TFVwaUQ3bmVy?=
 =?utf-8?B?UW1PbEE2Q0JEVnBKOUZvZHF3OWtlMmlWMGdpQnp2RlRQYk5LYk9JWTZ5NWdz?=
 =?utf-8?B?dzRZN2Uzay9sSDdMMUIrWThnQkZ2QlhFaUU2MUJkZDdaL3dLVGUyam5Ka3pK?=
 =?utf-8?B?elE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <154457AFF944454785B783B86D6E0B1C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6604.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02026a9f-4138-478d-2c3e-08db2314164c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2023 16:08:58.2842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K6t1cgFih6mfiPMGH3i1pfaLHD87EQ7YZWnpt4g+TppkhOdi8C79pZ3FDvhuHieFMpqLbPr+5lMxbbEbGOYUHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5301
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTAzLTAzIGF0IDIwOjE5ICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gRnJvbTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29t
Pg0KPiANCj4gVGhlIGNwdWZyZXEgcG9saWN5IG5vdGlmaWVyIGluIHRoZSBBQ1BJIHByb2Nlc3Nv
ciBkcml2ZXIgbWF5IGFzDQo+IHdlbGwgYmUgcmVnaXN0ZXJlZCBiZWZvcmUgdGhlIGRyaXZlciBp
dHNlbGYsIHdoaWNoIGNhdXNlcw0KPiBhY3BpX3Byb2Nlc3Nvcl9jcHVmcmVxX2luaXQgdG8gYmUg
dHJ1ZSAodW5sZXNzIHRoZSBub3RpZmllcg0KPiByZWdpc3RyYXRpb24gZmFpbHMsIHdoaWNoIGlz
IHVubGlrZWx5IGF0IHRoYXQgcG9pbnQpIHdoZW4gdGhlDQo+IEFDUEkgQ1BVIHRoZXJtYWwgY29v
bGluZyBkZXZpY2VzIGFyZSByZWdpc3RlcmVkLCBzbyB0aGUNCj4gcHJvY2Vzc29yX2dldF9tYXhf
c3RhdGUoKSByZXN1bHQgZG9lcyBub3QgY2hhbmdlIHdoaWxlDQo+IGFjcGlfcHJvY2Vzc29yX2Ry
aXZlcl9pbml0KCkgaXMgcnVubmluZy4NCj4gDQo+IENoYW5nZSB0aGUgb3JkZXJpbmcgaW4gYWNw
aV9wcm9jZXNzb3JfZHJpdmVyX2luaXQoKSBhY2NvcmRpbmdseQ0KPiB0byBwcmV2ZW50IHRoZSBt
YXhfc3RhdGUgdmFsdWUgZnJvbSByZW1haW5pbmcgMCBwZXJtYW5lbnRseSBmb3IgYWxsDQo+IEFD
UEkgQ1BVIGNvb2xpbmcgZGV2aWNlcy4NCj4gDQo+IEZpeGVzOiBhMzY1MTA1YzY4NWMoInRoZXJt
YWw6IHN5c2ZzOiBSZXVzZSBjZGV2LT5tYXhfc3RhdGUiKQ0KPiBSZXBvcnRlZC1ieTogV2FuZywg
UXVhbnhpYW4gPHF1YW54aWFuLndhbmdAaW50ZWwuY29tPg0KPiBMaW5rOiANCj4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGludXgtcG0vNTNlYzFmMDZmNjFjOTg0MTAwODY4OTI2ZjI4MjY0N2U1
N2VjZmIyZC5jYW1lbEBpbnRlbC5jb20vDQo+IFNpZ25lZC1vZmYtYnk6IFJhZmFlbCBKLiBXeXNv
Y2tpIDxyYWZhZWwuai53eXNvY2tpQGludGVsLmNvbT4NCg0KVGhlIGZ1bGwgcGF0Y2ggc2VyaWVz
IGZpeGVzIHRoZSBwcm9ibGVtIGJ1dCB0aGlzIG9uZSBkb2VzIG5vdC4NCg0KVGhpcyBpcyBiZWNh
dXNlLA0KDQpzdGF0aWMgaW50IGNwdV9oYXNfY3B1ZnJlcSh1bnNpZ25lZCBpbnQgY3B1KQ0Kew0K
ICAgICAgICBzdHJ1Y3QNCmNwdWZyZXFfcG9saWN5ICpwb2xpY3k7DQoNCiAgICAgICAgaWYgKCFh
Y3BpX3Byb2Nlc3Nvcl9jcHVmcmVxX2luaXQpDQogICAgICAgICAgICAgICAgcmV0dXJuIDA7DQoN
CiAgICAgICAgcG9saWN5ID0gY3B1ZnJlcV9jcHVfZ2V0KGNwdSk7DQogICAgICAgIGlmIChwb2xp
Y3kpIHsNCiAgICAgICAgICAgICAgICBjcHVmcmVxX2NwdV9wdXQocG9saWN5KTsNCiAgICAgICAg
ICAgICAgICByZXR1cm4gMTsNCiAgICAgICAgfQ0KICAgICAgICByZXR1cm4gMDsNCn0NCg0KQWx0
aG91Z2ggYWNwaV9wcm9jZXNzb3JfY3B1ZnJlcV9pbml0IGlzIHNldCB0byB0cnVlIHdpdGggcGF0
Y2ggMS80LCBidXQNCndlIGRvbid0IGhhdmUgY3B1ZnJlcSBkcml2ZXIgcmVnaXN0ZXJlZCwgdGh1
cyBjcHVmcmVxX2NwdV9nZXQoKSByZXR1cm4NCk5VTEwuDQoNCnNvIGFjcGlfcHJvY2Vzc29yX2Nw
dWZyZXFfaW5pdCBpcyBub3QgdGhlIG9ubHkgZGVwZW5kZW5jeSBoZXJlLiA6KA0KDQp0aGFua3Ms
DQpydWkNCg0KPiAtLS0NCj4gIGRyaXZlcnMvYWNwaS9wcm9jZXNzb3JfZHJpdmVyLmMgfCAgIDEy
ICsrKysrKy0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxl
dGlvbnMoLSkNCj4gDQo+IEluZGV4OiBsaW51eC1wbS9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2Ry
aXZlci5jDQo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0NCj4gLS0tIGxpbnV4LXBtLm9yaWcvZHJpdmVycy9hY3BpL3By
b2Nlc3Nvcl9kcml2ZXIuYw0KPiArKysgbGludXgtcG0vZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl9k
cml2ZXIuYw0KPiBAQCAtMjYzLDYgKzI2MywxMiBAQCBzdGF0aWMgaW50IF9faW5pdCBhY3BpX3By
b2Nlc3Nvcl9kcml2ZXJfDQo+ICAJaWYgKGFjcGlfZGlzYWJsZWQpDQo+ICAJCXJldHVybiAwOw0K
PiAgDQo+ICsJaWYgKCFjcHVmcmVxX3JlZ2lzdGVyX25vdGlmaWVyKCZhY3BpX3Byb2Nlc3Nvcl9u
b3RpZmllcl9ibG9jaywNCj4gKwkJCQkgICAgICAgQ1BVRlJFUV9QT0xJQ1lfTk9USUZJRVIpKSB7
DQo+ICsJCWFjcGlfcHJvY2Vzc29yX2NwdWZyZXFfaW5pdCA9IHRydWU7DQo+ICsJCWFjcGlfcHJv
Y2Vzc29yX2lnbm9yZV9wcGNfaW5pdCgpOw0KPiArCX0NCj4gKw0KPiAgCXJlc3VsdCA9IGRyaXZl
cl9yZWdpc3RlcigmYWNwaV9wcm9jZXNzb3JfZHJpdmVyKTsNCj4gIAlpZiAocmVzdWx0IDwgMCkN
Cj4gIAkJcmV0dXJuIHJlc3VsdDsNCj4gQEAgLTI3NiwxMiArMjgyLDYgQEAgc3RhdGljIGludCBf
X2luaXQgYWNwaV9wcm9jZXNzb3JfZHJpdmVyXw0KPiAgCWNwdWhwX3NldHVwX3N0YXRlX25vY2Fs
bHMoQ1BVSFBfQUNQSV9DUFVEUlZfREVBRCwgImFjcGkvY3B1LQ0KPiBkcnY6ZGVhZCIsDQo+ICAJ
CQkJICBOVUxMLCBhY3BpX3NvZnRfY3B1X2RlYWQpOw0KPiAgDQo+IC0JaWYgKCFjcHVmcmVxX3Jl
Z2lzdGVyX25vdGlmaWVyKCZhY3BpX3Byb2Nlc3Nvcl9ub3RpZmllcl9ibG9jaywNCj4gLQkJCQkg
ICAgICAgQ1BVRlJFUV9QT0xJQ1lfTk9USUZJRVIpKSB7DQo+IC0JCWFjcGlfcHJvY2Vzc29yX2Nw
dWZyZXFfaW5pdCA9IHRydWU7DQo+IC0JCWFjcGlfcHJvY2Vzc29yX2lnbm9yZV9wcGNfaW5pdCgp
Ow0KPiAtCX0NCj4gLQ0KPiAgCWFjcGlfcHJvY2Vzc29yX3Rocm90dGxpbmdfaW5pdCgpOw0KPiAg
CXJldHVybiAwOw0KPiAgZXJyOg0KPiANCj4gDQo+IA0K
