Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922A7672C99
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjARXaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjARXaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:30:23 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673834AA52;
        Wed, 18 Jan 2023 15:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674084622; x=1705620622;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rx7N/zn/gJW/FREp/7H9EemumRESXAfl3eWf9qsuu/w=;
  b=HpBUKpr2BnN1RXJ6RGU5QPhvhVBFLyM4Bi2f996nRFuPMWbG5zWszv1E
   haVFCBD51XEhMugrZKDLP5LcCd8iiznm9tpC6FHstoYRN2VcJ8qWzC0hM
   B8+eh+TVqMBqPdZH6ayGmnSp2wxU+G/8DLChxv1HIHkfAjozK/ylLi9ac
   dVrUFuJsK7BmU5jXZsgPBaYerNhyzbmLRCO6MlnWL2Vo7DPol50iu4cgK
   /y3ILDI7pw/hjNzjqbgiqIPaGw3XsPaymEPnqzlxd1Vqqc3aW7Z/AgwHO
   4i+rgEZfa9wNKTjQM3OruY/LkGYXLeo7O/NYaiPgo39iXqc2QgxRRid9I
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="389631388"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="389631388"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 15:30:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="728433226"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="728433226"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 18 Jan 2023 15:30:20 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 15:30:20 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 15:30:20 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 18 Jan 2023 15:30:20 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 18 Jan 2023 15:30:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdPavBjvloW+i1ZLCiuyvo4nmqhPwzm9acUM8dEC0K0Fwg+vnK0hLKoD+r2Ju/4gAIx3VbGyAHla1McbnIBjxSXE29QCtnE8zM7u8PcASNalcdwQARu5Z70EfIzATl5CZN36d54kd5ESLRm3kQUDmkgs4JttVlOnuuVmYoTZWclpI+TjtiDVQ3ovui5PX0svX11zrn6qGX+p2os5H7isLY4WTXeJSEMI1N0tAW5HqqcU07JaU1syc3RLBhSSHsMNPebjqpla0PQZ8FrXiqUkGOQECsylH/8xO/sYeL/FwChW/voZlLSW3/ksdZwsiSsKUuXdkaqpgtk7GGWsmaUI5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rx7N/zn/gJW/FREp/7H9EemumRESXAfl3eWf9qsuu/w=;
 b=BffrXKqRb04PDOs3QBT1pmSmMTdwfBdiqSIYJskCb8HuMn6K1C4nrVvhQ9NW928MPgJu9SfEcre1IeEDV40k06ckggrv/pP8yYQsp2cRaVFY8DLinZofuNi/75Oi4mtP2gER+aoN/XvyVrtsdkvnfgk1CDLWzal8o2EeYjPb8L1CWn3deOQduW1cEBH/sbtuTp3TEXIHnLcaUGA6kLmGE5nTHeoPvWh0sg73uPtJQaQYGdeRn1X59rogr31RtC3OvRwt4st/1LVoH0DHsLP5Q778R/PD6fdR2uzQlgDevEaiac5Tz2L3xqXUbwVgYy2BNKJh8UAf4wNPBwuhQyS53w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by CO1PR11MB5011.namprd11.prod.outlook.com (2603:10b6:303:6d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 18 Jan
 2023 23:30:04 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018%4]) with mapi id 15.20.5986.023; Wed, 18 Jan 2023
 23:30:04 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] rcu: Remove impossible wakeup rcu GP kthread action
 from rcu_report_qs_rdp()
Thread-Topic: [PATCH v3] rcu: Remove impossible wakeup rcu GP kthread action
 from rcu_report_qs_rdp()
Thread-Index: AQHZKxIPnor+2NW260uOVFogeINpU66keT4AgABZaBA=
Date:   Wed, 18 Jan 2023 23:30:04 +0000
Message-ID: <PH0PR11MB5880C93D16EFAB301A548CDEDAC79@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230118073014.2020743-1-qiang1.zhang@intel.com>
 <20230118180714.GD2948950@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230118180714.GD2948950@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|CO1PR11MB5011:EE_
x-ms-office365-filtering-correlation-id: abc71be1-7fd1-47a2-35a8-08daf9abed7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q/1SvNvK+xCrzGeJXaxIQn9udDIx8ZJShsn8V8JukYvhemx8g84eaRhQPCBDrScahqEXxMhHmTXsN/IKC/ZMfpgFsOET7GubStPz8HT6sU3qLA3o52gWVbeTUl3AzZBj2w07JEtg8VfrruzmSr3LC0wxAtfApz36oYlDugLT5/W8qcADCwQfIlyzaJioxufA4J3LPabz4N+6UQquJvsNYWsJhCGzRzdBCYHDJtXFm1sNFEdDW6vbBuBtm+50BkwepOwfTVceP/kDHylPVwJvdbosprZu/+81+UT3xAtj5tUZBpK4VHAh/f5k1N5pe8Oz0//l+au9l+ywKtYlwzh1bN9E7CTyq0ogM+jJvLoskl/2sPJz9tzfDV7Qu57cF2ar719opGPqmpyqmCfotC9qXpVNY5rcDcARDAjuF79PKYsHYPdk1ViUUw3qVPdLiLBoL8NZcRyShCzNF1sDRNz3LJ25YxMs3eubwmy+Rej47DwFqY4pWwwIeNmm93+lsanIjMJ/WjcI7lvdXXuc1p+z8dEeAZUKHNzyPLntm9Hc3YvA/Flio5Sr+NvuOxTrWyO7SWhkQIhJXIBQB4j8z/JnMu1Hj6yplQW/5Klvu503zq1zF2sQcYYvlXRmSu0BOXuDZnOCbS01F52ld0B6AFT4FoSB1xHf8MhVDbdO8LDCXuQif2qZtf/cfe7C23sXkiPDVzUDAT3+cX+fidkXPsRCVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199015)(66899015)(86362001)(122000001)(2906002)(55016003)(66556008)(66946007)(52536014)(8936002)(5660300002)(33656002)(82960400001)(76116006)(66476007)(38100700002)(316002)(71200400001)(7696005)(54906003)(6506007)(38070700005)(66574015)(478600001)(26005)(8676002)(66446008)(64756008)(4326008)(6916009)(41300700001)(186003)(83380400001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clBSMFlYcXlJdWYvaUp6dk1iaVZNelpNMHcrQU5RWVhiRmdVOEIxV0ZOaGhY?=
 =?utf-8?B?c0pUSCtZUzNNUFRIdkRMeDVGNVYvZVVZWUhvQU1LN1NNaTFyb1JwWVJheFI5?=
 =?utf-8?B?VlZuV3hsaDFyV3RLWkVxbXdmbWtRNkdlZ0ova2NXaGJtZldCT3JhUzY3eDJK?=
 =?utf-8?B?a0JaRmVoOGNTbCtrVjEvUlpxcHloRGwrdTJPS2E5SWZzd29tZ2FKTmhXekgr?=
 =?utf-8?B?U2NhcllUc2JTNGZkVVQwSjZNSjFGNGdpV0gyelhucVRBblovSzdPNzN3OGU4?=
 =?utf-8?B?K0R5cGNPdjlmUDNPVllwaHNWWkFXYzhiaEtNYkNSZzhwTzRNMHp5cCt5eHFE?=
 =?utf-8?B?SmRiZUwyYUZlaTh0bG91NjZEejl0MEk4R1BOTGVoVmFDY1BPYmVGQ0ZBSlhs?=
 =?utf-8?B?ZDZVNS9EZUU0NlF1WnpFU3F4blBUNi84VDVsaERWVnlSL1ZhUEFscHRycWRp?=
 =?utf-8?B?WHFkc01VMlJ6TE1aSHlabWpzWFgwVFVNMFdvTmJHdkJYWm1HdmxNVm93VGdH?=
 =?utf-8?B?UlFwak1NclBKZ3doWlRwVzRmTzA5NTdTc25kOG5rUjZvS1doYituSW5hdW93?=
 =?utf-8?B?UlRzVnpYZ08xTVhaUG42Y1UyeHMyZlF6ajdUUHVPOEsrcmgxTlNQVEdDU0VP?=
 =?utf-8?B?NFRVd1doWlJEaWcxVXIrL21iNFhuVjkyV0hiYUJJZXZHaS9OWEhtUk16OUZj?=
 =?utf-8?B?RDNITWRmYXRaNE1iWHh5VXljeENWREduS2NBRGhERWVOdHdSUXFRdnlrZE9w?=
 =?utf-8?B?amdGUTAzOUxVODF4cHVvV0thVWpWL3NpVTdTdXIyMldmUUErWmFoTWFLdEZ4?=
 =?utf-8?B?OTVGNy9LTWIxTHFlZDY0amxHK0x1TjArclhxMzFDcnZQYlYzeExmL1VTbVMx?=
 =?utf-8?B?SHB3d1N5VGZLRHkvcGluU29UVUtYdXJyOUxkUG5lSGlhRkZBMVNSelUrNzVU?=
 =?utf-8?B?UnlMTGNUL3VRMXhTSm5SODhlaVVZenRUZG9pZ2o2Z2pFSnhoUkJXUXp2eTVr?=
 =?utf-8?B?Uk9KVTFBTVdkeGxqczRrdXU3ejNxZXlZY1BrVm1qcmxma0ZLbkhNZ2JtUzZt?=
 =?utf-8?B?VzQxODhYRUczaWRhLzg2SEtMVG9RWHJYUlJ0UEx3RWZ1YVNiM3VYZTBHUVRW?=
 =?utf-8?B?NnR3eEZhZ3prQkVDN3IxeXo1YXpKOG9Zd21wYnBGVmVlRDFFVGprTERNb3BL?=
 =?utf-8?B?a2pJYjduNHBUeGlNdVRhNDlRY1B6Yyt4MHVJRmFuaWpyMXRkNU9JUzR3NEZH?=
 =?utf-8?B?L1FVSGFxQ0FRbW9DaGYxQU5YTWFnUjZ4TmZyS2owK2k0dTZQQmJ3THNYT0Na?=
 =?utf-8?B?bUE3YWJxVUsyWlBvVkU0NkxDY2hOYmtnSyt0OWdPZ0ZwZmsySnZIdzhpbmZs?=
 =?utf-8?B?SlUxbVFiTnlSRHlSRXB4TklsZk5uZEsxblBtUi8yMHhlMmJnNTBpQVlUZTJO?=
 =?utf-8?B?M0NUa2VLRzBjQS9wZDZNVWViNEloVXRhdllhMlVTa042TXFEMGs5RUlYTlFp?=
 =?utf-8?B?bi9nZXh1UGNoZktiOHlxMzI2TzBJMkttem83b2FwTnR1alArYzl2Y1FVNkFQ?=
 =?utf-8?B?OVNGUGpmUXE0TDFWb3BNVkpITFRQaHovN0paZEhqZTRyZWVkV0RVTFJYMUlD?=
 =?utf-8?B?V0ZpY2xxT2lZM3RCaXVNTDNMZmJsSjVKc2dMN1Vlc3k1d2R4UHJoakVFenVU?=
 =?utf-8?B?NzJDOVE1MWJFUlRyM091TVhWd29iRlRrd1AybnQ5THhWVHpVdjUwcG80NFBu?=
 =?utf-8?B?ZDRwc004R01WVFR4ek5oSXB5SXhKTzFQaVlkWlhpc0d3ODV5MkF5WDcxUDJT?=
 =?utf-8?B?bVd5cUNOZGRFL3lBMVBtUGJ1dVQyU3BVamcyWXJ5MnJYNURaQ3l6OE0ra081?=
 =?utf-8?B?NTRVOXRXeExTeWhhaEdHRldHdks5d0R3eDdIZEdTMDl2MzJ6WW1BRkpna3hG?=
 =?utf-8?B?UXpFMEZpRW53TmlVMndCck9Da1J4UHZBNDBXQkpBRTFSUjFyVXhmTVZ4U2lR?=
 =?utf-8?B?ODRjYkUrNVFwSEN0WlVHNW9kbVBiTldMSW90VGxDRmdsZnVBMXBYeHRsZHZn?=
 =?utf-8?B?RGxaSU9SOGFoaDVMTk4rdHpsR00vbzRTWUpTdmRwbEwraWs0UDZnWEhrOTdF?=
 =?utf-8?Q?zouAvTEDiwK6jWEzG1LVDQSPN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abc71be1-7fd1-47a2-35a8-08daf9abed7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 23:30:04.5032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OEY/3UTwjK19kBXnrYJjRZLpz95mb/n9B0w512WlflDo0AmvgTufO+LW3HD58P0A0jCy7WR/MAJykihkyV+YQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5011
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBKYW4gMTgsIDIwMjMgYXQgMDM6MzA6MTRQTSArMDgwMCwgWnFpYW5nIHdyb3RlOg0K
PiBXaGVuIGlub3ZrZSByY3VfcmVwb3J0X3FzX3JkcCgpLCBpZiBjdXJyZW50IENQVSdzIHJjdV9k
YXRhIHN0cnVjdHVyZSdzIC0+DQo+IGdycG1hc2sgaGFzIG5vdCBiZWVuIGNsZWFyZWQgZnJvbSB0
aGUgY29ycmVzcG9uZGluZyByY3Vfbm9kZSBzdHJ1Y3R1cmUncw0KPiAtPnFzbWFzaywgYWZ0ZXIg
dGhhdCB3aWxsIGNsZWFyIGFuZCByZXBvcnQgcXVpZXNjZW50IHN0YXRlLCBidXQgaW4gdGhpcw0K
PiB0aW1lLCB0aGlzIGFsc28gbWVhbnMgdGhhdCBjdXJyZW50IGdyYWNlIHBlcmlvZCBpcyBub3Qg
ZW5kLCB0aGUgY3VycmVudA0KPiBncmFjZSBwZXJpb2QgaXMgb25nb2luZywgYmVjYXVzZSB0aGUg
cmN1X2dwX2luX3Byb2dyZXNzKCkgY3VycmVudGx5IHJldHVybg0KPiB0cnVlLCBzbyBmb3Igbm9u
LW9mZmxvYWRlZCByZHAsIGludm9rZSByY3VfYWNjZWxlcmF0ZV9jYnMoKSBpcyBpbXBvc3NpYmxl
DQo+IHRvIHJldHVybiB0cnVlLg0KPiANCj4gVGhpcyBjb21taXQgdGhlcmVmb3JlIHJlbW92ZSBp
bXBvc3NpYmxlIHJjdV9ncF9rdGhyZWFkX3dha2UoKSBjYWxsaW5nLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogWnFpYW5nIDxxaWFuZzEuemhhbmdAaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogRnJl
ZGVyaWMgV2Vpc2JlY2tlciA8ZnJlZGVyaWNAa2VybmVsLm9yZz4NCj4NCj5RdWV1ZWQgKHdvcmRz
bWl0aGVkIGFzIHNob3duIGJlbG93LCBhcyBhbHdheXMsIHBsZWFzZSBjaGVjaykgZm9yIGZ1cnRo
ZXINCj50ZXN0aW5nIGFuZCByZXZpZXcsIHRoYW5rIHlvdSBib3RoIQ0KPg0KPgkJCQkJCQlUaGFu
eCwgUGF1bA0KPg0KPi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPg0KPmNvbW1pdCBmYmUzZTMwMGVjOGIzZWRk
MmI4Zjg0ZGFiNGRjOTg5NDdjZjcxZWI4DQo+QXV0aG9yOiBacWlhbmcgPHFpYW5nMS56aGFuZ0Bp
bnRlbC5jb20+DQo+RGF0ZTogICBXZWQgSmFuIDE4IDE1OjMwOjE0IDIwMjMgKzA4MDANCj4NCj4g
ICAgcmN1OiBSZW1vdmUgbmV2ZXItc2V0IG5lZWR3YWtlIGFzc2lnbm1lbnQgZnJvbSByY3VfcmVw
b3J0X3FzX3JkcCgpDQo+ICAgIA0KPiAgICBUaGUgcmN1X2FjY2VsZXJhdGVfY2JzKCkgZnVuY3Rp
b24gaXMgaW52b2tlZCBieSByY3VfcmVwb3J0X3FzX3JkcCgpDQo+ICAgIG9ubHkgaWYgdGhlcmUg
aXMgYSBncmFjZSBwZXJpb2QgaW4gcHJvZ3Jlc3MgdGhhdCBpcyBzdGlsbCBibG9ja2VkDQo+ICAg
IGJ5IGF0IGxlYXN0IG9uZSBDUFUgb24gdGhpcyByY3Vfbm9kZSBzdHJ1Y3R1cmUuICBUaGlzIG1l
YW5zIHRoYXQNCj4gICAgcmN1X2FjY2VsZXJhdGVfY2JzKCkgc2hvdWxkIG5ldmVyIHJldHVybiB0
aGUgdmFsdWUgdHJ1ZSwgYW5kIHRodXMgdGhhdA0KPiAgICB0aGlzIGZ1bmN0aW9uIHNob3VsZCBu
ZXZlciBzZXQgdGhlIG5lZWR3YWtlIHZhcmlhYmxlIGFuZCBpbiB0dXJuIG5ldmVyDQo+ICAgIGlu
dm9rZSByY3VfZ3Bfa3RocmVhZF93YWtlKCkuDQo+ICAgIA0KPiAgICBUaGlzIGNvbW1pdCB0aGVy
ZWZvcmUgcmVtb3ZlcyB0aGUgbmVlZHdha2UgdmFyaWFibGUgYW5kIHRoZSBpbnZvY2F0aW9uDQo+
ICAgIG9mIHJjdV9ncF9rdGhyZWFkX3dha2UoKSBpbiBmYXZvciBvZiBhIFdBUk5fT05fT05DRSgp
IG9uIHRoZSBjYWxsIHRvDQo+ICAgIHJjdV9hY2NlbGVyYXRlX2NicygpLiAgVGhlIHB1cnBvc2Ug
b2YgdGhpcyBuZXcgV0FSTl9PTl9PTkNFKCkgaXMgdG8NCj4gICAgZGV0ZWN0IHNpdHVhdGlvbnMg
d2hlcmUgdGhlIHN5c3RlbSdzIG9waW5pb24gZGlmZmVycyBmcm9tIG91cnMuDQo+ICAgIA0KDQpU
aGFua3MgUGF1bCwgdGhpcyBpcyBtb3JlIGNsZWFyIGZvciBtZfCfmIouDQoNClRoYW5rcw0KWnFp
YW5nDQoNCj4gICAgU2lnbmVkLW9mZi1ieTogWnFpYW5nIDxxaWFuZzEuemhhbmdAaW50ZWwuY29t
Pg0KPiAgICBSZXZpZXdlZC1ieTogRnJlZGVyaWMgV2Vpc2JlY2tlciA8ZnJlZGVyaWNAa2VybmVs
Lm9yZz4NCj4gICAgU2lnbmVkLW9mZi1ieTogUGF1bCBFLiBNY0tlbm5leSA8cGF1bG1ja0BrZXJu
ZWwub3JnPg0KPg0KPmRpZmYgLS1naXQgYS9rZXJuZWwvcmN1L3RyZWUuYyBiL2tlcm5lbC9yY3Uv
dHJlZS5jDQo+aW5kZXggYjJjMjA0NTI5NDc4MC4uN2EzMDg1YWQwYTdkZiAxMDA2NDQNCj4tLS0g
YS9rZXJuZWwvcmN1L3RyZWUuYw0KPisrKyBiL2tlcm5lbC9yY3UvdHJlZS5jDQo+QEAgLTE5NTYs
NyArMTk1Niw2IEBAIHJjdV9yZXBvcnRfcXNfcmRwKHN0cnVjdCByY3VfZGF0YSAqcmRwKQ0KPnsN
Cj4gCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+IAl1bnNpZ25lZCBsb25nIG1hc2s7DQo+LQlib29s
IG5lZWR3YWtlID0gZmFsc2U7DQo+IAlib29sIG5lZWRhY2MgPSBmYWxzZTsNCj4gCXN0cnVjdCBy
Y3Vfbm9kZSAqcm5wOw0KPiANCj5AQCAtMTk4OCw3ICsxOTg3LDEyIEBAIHJjdV9yZXBvcnRfcXNf
cmRwKHN0cnVjdCByY3VfZGF0YSAqcmRwKQ0KPiAJCSAqIE5PQ0Iga3RocmVhZHMgaGF2ZSB0aGVp
ciBvd24gd2F5IHRvIGRlYWwgd2l0aCB0aGF0Li4uDQo+IAkJICovDQo+IAkJaWYgKCFyY3VfcmRw
X2lzX29mZmxvYWRlZChyZHApKSB7DQo+LQkJCW5lZWR3YWtlID0gcmN1X2FjY2VsZXJhdGVfY2Jz
KHJucCwgcmRwKTsNCj4rCQkJLyoNCj4rCQkJICogVGhlIGN1cnJlbnQgR1AgaGFzIG5vdCB5ZXQg
ZW5kZWQsIHNvIGl0DQo+KwkJCSAqIHNob3VsZCBub3QgYmUgcG9zc2libGUgZm9yIHJjdV9hY2Nl
bGVyYXRlX2NicygpDQo+KwkJCSAqIHRvIHJldHVybiB0cnVlLiAgU28gY29tcGxhaW4sIGJ1dCBk
b24ndCBhd2FrZW4uDQo+KwkJCSAqLw0KPisJCQlXQVJOX09OX09OQ0UocmN1X2FjY2VsZXJhdGVf
Y2JzKHJucCwgcmRwKSk7DQo+IAkJfSBlbHNlIGlmICghcmN1X3NlZ2NibGlzdF9jb21wbGV0ZWx5
X29mZmxvYWRlZCgmcmRwLT5jYmxpc3QpKSB7DQo+IAkJCS8qDQo+IAkJCSAqIC4uLmJ1dCBOT0NC
IGt0aHJlYWRzIG1heSBtaXNzIG9yIGRlbGF5IGNhbGxiYWNrcyBhY2NlbGVyYXRpb24NCj5AQCAt
MjAwMCw4ICsyMDA0LDYgQEAgcmN1X3JlcG9ydF9xc19yZHAoc3RydWN0IHJjdV9kYXRhICpyZHAp
DQo+IAkJcmN1X2Rpc2FibGVfdXJnZW5jeV91cG9uX3FzKHJkcCk7DQo+IAkJcmN1X3JlcG9ydF9x
c19ybnAobWFzaywgcm5wLCBybnAtPmdwX3NlcSwgZmxhZ3MpOw0KPiAJCS8qIF5eXiBSZWxlYXNl
ZCBybnAtPmxvY2sgKi8NCj4tCQlpZiAobmVlZHdha2UpDQo+LQkJCXJjdV9ncF9rdGhyZWFkX3dh
a2UoKTsNCj4gDQo+IAkJaWYgKG5lZWRhY2MpIHsNCj4gCQkJcmN1X25vY2JfbG9ja19pcnFzYXZl
KHJkcCwgZmxhZ3MpOw0K
