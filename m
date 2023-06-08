Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9479727CA6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbjFHKVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbjFHKVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:21:18 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429229E;
        Thu,  8 Jun 2023 03:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686219676; x=1717755676;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FBE0xFbOxqFK82MNL+QDTm+T/OTueckUqa/vjRjviVI=;
  b=c4T0E2TkDJst0LxxrylV7/RE3WOnuHWAj8+ynLiN4E9kvVdq1Qq+VgY+
   9P0ZEVeP8wWmHpYmRJAYqYzMRQ7LjQccDtVuRRDdAhveSJXOPXv1gyMTI
   fODfTE+KPhCD95EZx3BWFsFdvMYUqYrbMu4qo7+cakFyPgfqm/HUdad4v
   jS15U/eOi6BXQfOobbE299Yi1MZlgd9dHV90g2Y7NKEBeunqdS5cDH+b5
   xstvxcxRxT+75Hg4uP0H71mrA0Deqh2yVNFH5IhcnI1PpWS8qUbEj/8gM
   5Tx/va2lrTr+msgweosXsV2T7RK/prhx73utmWFRfPkjDO8/vTR4aa3nh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="385611560"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="385611560"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 03:21:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="1040066355"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="1040066355"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 08 Jun 2023 03:21:14 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 03:21:13 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 03:21:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 8 Jun 2023 03:21:12 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 8 Jun 2023 03:21:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvYxuVSzTJRfl1+Npd8rLy63x5bQQsmLodINdDub+VTWUQtQ8LpVf3MB+VBMq56FwRlWNCR+E3gLQB/HHjhIJ1F0TzE3hWplTHgPv79xL5GP7YqYgKK/F3yVucMUhR82tX5pB0+TmXZZZXnKXLB5vDfV8GeIFZebQeHm3XjQmngx8FTDpVau4+nRHosJ0zeFvTsm3Xvfb9xRMmrzXMnJM23TZIqEmsk5tRiui2idylKAC77vOVTJvZzL79FXy+kJZlMqO52l3sBCLfjEeYYV9xR2OMlRR7T+oWuNJ8ll+j3riCgZWAuQRoGi0vpFPy+u9z/60Tjio0qWiqC46SSpQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBE0xFbOxqFK82MNL+QDTm+T/OTueckUqa/vjRjviVI=;
 b=oABsfinCJnoTKTv756e14Rtiwrma1yyyGSftN5Agb/3MM7JELJDEYbwghrRiN55y20kybqxGfYkkQrcFoCC6aHuTUoh0aXYczk7+khTuGSy/GRBCCAh6I3oejpEI00J6ruiyXS2JGBh0be/WQKOpaZelmG9WzcXi/VU/XDz3gS4FWfdmepDQI7orJT3wNYrjUQUuL0YMuugcm/rTj4NLnwZFn1rDNybYowAj4LEdWFF0qB7fJMVrg0givcN+zVYv7N+/h1e+oxth5fmq8QBQ28mRRNLQG5Kqh4SYip5WLAh8PISmQwFV9AfiLyER/KKWRTu+JoyDUkvurpjXfQ4lUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2779.namprd11.prod.outlook.com (2603:10b6:5:c6::26) by
 BL3PR11MB6530.namprd11.prod.outlook.com (2603:10b6:208:38d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 10:20:59 +0000
Received: from DM6PR11MB2779.namprd11.prod.outlook.com
 ([fe80::5c56:cdad:30cb:c3de]) by DM6PR11MB2779.namprd11.prod.outlook.com
 ([fe80::5c56:cdad:30cb:c3de%4]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 10:20:59 +0000
From:   "Jadav, Raag" <raag.jadav@intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "N, Pandith" <pandith.n@intel.com>
Subject: RE: [PATCH v1 1/4] pinctrl: intel: optimize set_mux hook
Thread-Topic: [PATCH v1 1/4] pinctrl: intel: optimize set_mux hook
Thread-Index: AQHZmdcIfqWA9y7dVE6Njm3kWsbhEK+AjRmAgAAfhyA=
Date:   Thu, 8 Jun 2023 10:20:58 +0000
Message-ID: <DM6PR11MB2779B6863DA4A390EC68F4978C50A@DM6PR11MB2779.namprd11.prod.outlook.com>
References: <20230608070017.28072-1-raag.jadav@intel.com>
 <20230608070017.28072-2-raag.jadav@intel.com>
 <20230608080821.GF45886@black.fi.intel.com>
In-Reply-To: <20230608080821.GF45886@black.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2779:EE_|BL3PR11MB6530:EE_
x-ms-office365-filtering-correlation-id: 54c4421a-2a2f-45ec-f9ad-08db680a0d88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: spezASOGuEL0qRMwsG3iSvnevTKtPRVdtKg8U1V0AvNAsdkXmoXsg1shWEj0uOVhJho4XI8+RxLXxWF8Fk56IEC6xEUziJcViefe7eKP+YAOc8RziWm5H7IoMPeV0e1bj/zUybjB1mzVFvxsL5TT6+Rjg6+76gICJX00RK2r0YJ1DsDp+G1AgTQh8D5lfLdEEWHIHWcLVLG+i5bgnP8mv0ITk6YBbxCjtoFmklZ5aQ/2JrNenkf1SMTsdSKk3c5Wple7aohdJl2zte7WTIOwoL9oCTaZ2tm7hT4+i15KT19L1eCRsVeruQutJ+4C6NoNWmvyqBO187Hb0TUt2rTst8mrFMkTj+xQMg+23YEMQHbNKMT57qMXgnalRkp5rjc1CYgrrlvvU7oz/giX/eVuz2/IkvOhyxvNnBGf9wfkyZVaXgEP+SsXcwEGe04hgY9xvAsSL2DRbHOM9AbHW/yZCwjyZp/Zj8byq2RxEH4ZkVXTtgBVIoXY48hUrGLAZAETZ65p1kx2jTw73mUNvTD8A+YWJsWaRybHVckZD8M1JTOq8HbbkvvTT/DFWduOdiN2AgaCHtqOoQvRMepJk8VS2sYc7RmeyiHR3lxhfOrECjDjA1wT16NRg5t3jBBHQvoz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199021)(5660300002)(33656002)(38070700005)(2906002)(4744005)(52536014)(86362001)(55016003)(71200400001)(83380400001)(9686003)(26005)(6506007)(82960400001)(316002)(478600001)(54906003)(7696005)(64756008)(6916009)(66946007)(38100700002)(4326008)(41300700001)(66446008)(76116006)(186003)(122000001)(66556008)(66476007)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3VpZURNNWJuWGFoNWFuMkZOTHBEeDFYamRTMTZVSjBpWnlENnZKb29oZHBF?=
 =?utf-8?B?dmRMdVRxVldWWmxBcnZDbkpIL3ZPUkFJNUkzcEFrdmdtdzZVTnJQamxlOGhH?=
 =?utf-8?B?N0MyNjhBbVlaV2lnc3Q3V1RocmlPa3FUMWgyakYzVWVMeVFhbG56NUhnWlJu?=
 =?utf-8?B?dGlVZ2k3aGtZK2crNWZSVC93WHYzbWJ6M2JzMm01UmxDbTZkRGRZdnZlVE5D?=
 =?utf-8?B?N3pJYTdTV3RnUmx6RlZDcWRlTTlrSUxyNGJDdXdiaVhKQVYvZ1kwSHdLNmZr?=
 =?utf-8?B?ZFBVeTI2Z1lUQUJha2tPSHh2aHNsTWRPbzJ2NUl4a2NYdyt3VDF3WmJUR09R?=
 =?utf-8?B?Ni91eXBncjI5SVVVVGw4VnExb2tNQ0d0OWlQUzVNdDdjaHlwMFE5VkJGZHdK?=
 =?utf-8?B?Z0d1WVJBTWpZUzBldTdjR1Z6b1pDcUpjVDh4WkxrSHA4T3BBVkVIbzladjVP?=
 =?utf-8?B?RXgrWjg0TFVOLzczMStJYUFldlFJVzBienVieUtUZjFuMUI3MlV1eEpNVVpr?=
 =?utf-8?B?dkpzaW43bDFuWS9MdXZIQlJzSEpBdnM1a2o4U0RFc2psQUdOdEZpalBhWjZJ?=
 =?utf-8?B?QzVXRjExbDdvYlI5N3ZkT21ldjZzMVNMUVdjRlN5dk1zbGlQNUl2cU5JSy9R?=
 =?utf-8?B?eFIvTUpuK0J4YlA0T3VnOExSRHdma2YwMk5CUC9FWjZldVVVcjhycnZPN1NK?=
 =?utf-8?B?cHNCblBWd0tnSGlHeFRsQkZPVGJTa3BwZkxwZHdwenN6WGo2SjExU0xyeGVW?=
 =?utf-8?B?RVBDRmlvY0h3VFlWU1FrbFczUWFhNkVibHY5Q0hHeUJZWGdmajk4ci9ZekJq?=
 =?utf-8?B?WHRzdUFaYk5Jc1N6N0gzbkdPNnU5dXN1L2QrME1Ub1JBRmdCa3Yvczh1YUJQ?=
 =?utf-8?B?ejA0aEtFVlc4V0Z2V0VsSDA1TVI3MGxyTU1zTXN5SXJDL1hmTTFiRGUrK1FZ?=
 =?utf-8?B?anc4N3VyOFFReVBodjZIS0pEWmE4MzJjQXg0WUY5ZW5GVDVvRXovOUs2aTRQ?=
 =?utf-8?B?R3VlK25jZDE3M2FDWlpqbmFGVXBZN2taNWtGUlljTG5OSXdXMnNrYXNvUXN3?=
 =?utf-8?B?YnMwdGZpQ0Z4UDR5dUR1MzFXV3JCK2kvejBCc1dWc1NNVUhIdm1pdjAzQWFZ?=
 =?utf-8?B?emNwdkxQS0pIazZiWmVqNmY4dCtJUUF3Q0FHVGpZZi9KMXBjNTNhTEhNcTJi?=
 =?utf-8?B?WFJLNjhYUCtwdlppd2tqZThVK1JaV3hXRHBoc3VYcGsrdWNOWW1GbjV5M2to?=
 =?utf-8?B?RWNXTWE1VVROVlFMUXE5bWFZMEVYVlJKbjBCQXFta1RaR01iUFlpaTlSQ200?=
 =?utf-8?B?SUtFTlU5MmZpNDczTTc5ZUZCLzFlSmN1QXdRajZ5ZGorQW4rVmFQd0ZsSlVo?=
 =?utf-8?B?NE8rTzk4aitDNFBzdjdxTzIzNjJ2YzMxVzZtNFAvb2pJeFJGMkdKckIzUjRq?=
 =?utf-8?B?bU5tMXNWUWVmNkZtU0thRUFuQXZTd3h5Y3pKOHZjT0prNFJZV2dVclpsVXlX?=
 =?utf-8?B?THY0SU9YM0FqeHFPNVRTWnhmNGM1MERiNHNmckpHOEo5VERpWXI2ZFUxM1hZ?=
 =?utf-8?B?QTJuNjByTUFJbkFIbGtvdE5jWEZ5c1dDYlBFeFZlNjlVWFZYRU1SMS9wTHpN?=
 =?utf-8?B?VUpRaGlCSzh0dEpuaU1GQlNYTVV4L21oeVAraWZrOTVaL3NEWlJyY2pOZnI1?=
 =?utf-8?B?cUM1SndRTksxYXk3a29VeEVJS1paSmJWcWpXZ0lSNW5oUERJWGxqa3VLaGdj?=
 =?utf-8?B?aE9zRzhZYnJIbUduN1dCU1U3NTNDa0ZNdWZOTStLanVjazhKM1N1bEhOWDU0?=
 =?utf-8?B?S1B6a0tSSTcyY2pWSnNSZGZsMzNzcVViUlpjd2w3eStCYmRUd1ZBSVBiTWtK?=
 =?utf-8?B?S2NXSi8vblYyRmw1azMwQXJnazdORjZnVjYrL1J6c284VkhFY2dEeExxTEJQ?=
 =?utf-8?B?dFJ1YStvNURLUWpuS2NRdFJsZXA4WXVFaDAxMjRpZzVKR0NtcERQYS9hMVFa?=
 =?utf-8?B?YW5HenFKaWdybW0vZjJLU1ZEOFVtdHpmWG04VHpGSk1KaWh5Wll6b2EwczlU?=
 =?utf-8?B?VmtBTS9nRXVMRzZ1OUNDNld1OUdsNDkzM0o4RmxZblZXbEZkZGtBTVNQbmQx?=
 =?utf-8?Q?Lops=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c4421a-2a2f-45ec-f9ad-08db680a0d88
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 10:20:58.8605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h3VPqBGnbjnf4MCyZxgC/+MGvGyGWwTByUiJrIXG3QenEEQR7C+Pg1vVyyZjHozyUqsTSbMZPHq7XzpgQGKEMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6530
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBUaHUsIEp1biAwOCwgMjAyMyBhdCAxMjozMDoxNFBNICswNTMwLCBSYWFnIEphZGF2IHdy
b3RlOg0KPiA+IFV0aWxpemUgYSB0ZW1wb3JhcnkgdmFyaWFibGUgZm9yIGNvbW1vbiBzaGlmdCBv
cGVyYXRpb24gaW5zaWRlDQo+ID4gLT5zZXRfbXV4KCkgaG9vayBhbmQgc2F2ZSBhIGZldyBieXRl
cy4NCj4gPg0KPiA+IGFkZC9yZW1vdmU6IDAvMCBncm93L3NocmluazogMC8xIHVwL2Rvd246IDAv
LTMgKC0zKQ0KPiA+IEZ1bmN0aW9uICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IG9sZCAgICAgbmV3ICAgZGVsdGENCj4gPiBpbnRlbF9waW5tdXhfc2V0X211eCAgICAgICAgICAg
ICAgICAgICAgICAgICAyNDUgICAgIDI0MiAgICAgIC0zDQo+ID4gVG90YWw6IEJlZm9yZT0xMDQ3
MiwgQWZ0ZXI9MTA0NjksIGNoZyAtMC4wMyUNCj4gDQo+IFNob3VsZG4ndCB0aGUgY29tcGlsZXIg
YmUgYWJsZSB0byBvcHRpbWl6ZSB0aGlzIGlmIHlvdSBhc2sgd2l0aCB0aGUgLU94DQo+IG9wdGlv
bnM/DQoNCkZvcmdvdCB0byBhZGQuIFRoaXMgaXMgd2l0aCBkZWZhdWx0IC1PMi4NCklzIGl0IGEg
Z29vZCBpZGVhIHRvIG1lbnRpb24gaXQ/DQoNCj4gSSBkb24ndCByZWFsbHkgc2VlIG11Y2ggYmVu
ZWZpdCBmb3IgIm9wdGltaXphdGlvbnMiIGxpa2UgdGhpcy4gVGhhdCBzYWlkIHVzaW5nDQo+IHRl
bXBvcmFyeSB2YXJpYWJsZSBoZXJlIGltcHJvdmVzIHJlYWRhYmlsaXR5IHNvIHRoaXMgb25lIGlz
IGFjY2VwdGFibGUgYnkNCj4gbWUuIEFzIGxvbmcgYXMgeW91IGNoYW5nZSB0aGUgY29tbWl0IG1l
c3NhZ2UgYWNjb3JkaW5nbHkuDQoNCg==
