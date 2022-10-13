Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858F65FE2BC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 21:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiJMTfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 15:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiJMTf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 15:35:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32788C510C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 12:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665689727; x=1697225727;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D+uViaDeQvt/dEoSfl0odp6VgZoRXsKmQad/Lfg7DWU=;
  b=mk1pNgLFdJHve7AStbri7Zu8s29X6w33HpesaYAtKD8gmkduHyeHdUHv
   hEt0qkEwmCEck3Dx7aMDOats61lHsjNuaNUApNiVeKZ/F4b1Kwp5/lbwN
   pzd+72Ul53PyrlrCXH5hHiIuwsWkUs39syzWSB+V0Vc1GotJlyjtLz1w4
   lzXr1wgYNI3tcTKGRtjLx+tnWsUobfGccLjBdKNhaB9tcVvs6VTZ2Sky3
   Y9inwMCL2OpMJNk7KZEKotrmXtW+qPPErNhNCZy2FOJidKJLvBM8k5RrC
   rVDuwBBmgOMKNfkgtOesLm04YAcEGjfX0nG3JBBOYV6Iu4yWfiOD4e7Fs
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="285570586"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="285570586"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 12:35:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="732006440"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="732006440"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 13 Oct 2022 12:35:26 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 12:35:26 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 12:35:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 13 Oct 2022 12:35:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 13 Oct 2022 12:35:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l20q9KQlfUu03jL6piomfAqrC7sKRo4lLbPz8C98OVQYB+nKtm+XW43bbbbi4BjA1qH7PwBnSBWBeJPbiKNGYMoxNslt0g4fyisKYb/+sSb4zM3t7W6itgbHFhLvoI16M5/5O5SvFhDnDec+ZjAns0itHn5SnQ8zHSXfXqlu946hzrd8MxvT8sYdV8Kqf7QVJxb1ZFTlDgy7aK8U4yHfMhPxq7OehE1WYMem75G30OESAMRXIxjttyEniZqJZvpEiFGyzg/oOFhv+VLd3HScCUXuRouo0DcPvznzAPA1UXh6xlrqPKk6V1p7o1IBp5E7LR6XV6k4W0E8BK1VuWGxkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+uViaDeQvt/dEoSfl0odp6VgZoRXsKmQad/Lfg7DWU=;
 b=LFwbzUxTRptJbmXJRwHcA5hlFOO2OU0KE6K0g1b5msLS/n08F+4J478s8+InewL6mH5kzDVlOEWSUbNyOrN/+Xk5xpc9NaEFb3/OGE6u3uA34yzuPrLXbw+YPq1mguXR8d+v84Gar+VDW3ocSh1LRZR+7wfKoHbellMyy3qR9lE0C8PvA36PFZS+NJfcCo+3+8QhEl5dHdO5M0BMkjrlF2Db5bbhJnYzihKO0ZP7dv4otPwA+/rPXkEwtzJJTHKu3lspi6ioric0FAS2nYetk0YSDVQCUdcJsECkJ2UFKkEuplDFwhjLypNnKP9NfYWl0USQggy38hW+zvgzBs16Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 (2603:10b6:405:52::15) by MW4PR11MB6811.namprd11.prod.outlook.com
 (2603:10b6:303:208::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Thu, 13 Oct
 2022 19:35:24 +0000
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5]) by BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5%12]) with mapi id 15.20.5723.026; Thu, 13 Oct
 2022 19:35:23 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>
Subject: RE: [PATCH v2 1/6] x86/cpufeature: add cpu feature bit for LKGS
Thread-Topic: [PATCH v2 1/6] x86/cpufeature: add cpu feature bit for LKGS
Thread-Index: AQHY3N36LzFJM7IIAE+HeYouMzhRS64J/XgAgAK+lwA=
Date:   Thu, 13 Oct 2022 19:35:23 +0000
Message-ID: <BN6PR1101MB2161F6E79A6B123D9B0B53E9A8259@BN6PR1101MB2161.namprd11.prod.outlook.com>
References: <20221010190159.11920-1-xin3.li@intel.com>
 <20221010190159.11920-2-xin3.li@intel.com>
 <cca7e8ec-9fa0-7517-12d2-b0fd115bb9e9@intel.com>
In-Reply-To: <cca7e8ec-9fa0-7517-12d2-b0fd115bb9e9@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR1101MB2161:EE_|MW4PR11MB6811:EE_
x-ms-office365-filtering-correlation-id: d7563787-f642-4abd-eb37-08daad521295
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IfGcKPpcugzv/SrCRxu/ctbJVWaSVxDhaIj2PhtIA/u+PibZ8mcgNy3+bBMuzxdDLlPDIxfSAPVKvxDIVmhTDGYAFIK6nC7q0hcw/y5mxygDbwQox0HidHBZuZasbt/oBmhxVLXPL7mSOL2/AxnVW00d9OjBwVU47yMBjFNBs1+xKB0LAXHdnGrnAkYP2IabYTr3lNBYqqNXdR1RJEWPF9qnDM0uVmeecW7bZ6KXnuLG8fXMvE2DPIdr3zX+LsjmwYErDUKXQjGJYr6+eRVSmZ2yLIolRs2c6FouSqMyQ2DUzfzaQwVCXWInHO/5Bq9XkOkxnW+KPSPwxKW/5v5oU4fLzTjhtZauQs3Qw+6w4qi7i9u5bCR5oiUQzLYMseGpmBxflxHeT4v9Z1U9biNyFjf8q7tsZMgnhtBEuEHhfONKOIK5R8Ko6qH6H+RBIERVeyk8RBfFWtGGvt+CxIVVrpxv7PyZqimLqoM6zPEenAaUmrA+dSpss2nQb0znpdeuDWsFk2epV3hWg/8Z9PV7Z7pR/WC2VS4E4P8gePPqrn6uoWSOHjC7QXhkS29JsiLcS6fdKvM6bzueJMyH8tTLEKFfen3RskcTjZhhBFS7chjOI5sAgKNg9OBNkdoed2kyTGVYdPFPMIIT0NvIGqFcLQe8eoW9JNTSX30orEyS7d7a5Tvh8frGsdl2SpHLFVw94Zr5waC57hk0SGWsGHAlxGIyE8yhAPXS495aSyDOSVCoVZNnDFUfCObejAry1l2Vco4HJ8+0BFnAb/fycR9O0KZOC2QP+DzC5EUQHxYhFx8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1101MB2161.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199015)(38100700002)(82960400001)(26005)(2906002)(7696005)(33656002)(66946007)(316002)(186003)(38070700005)(122000001)(55016003)(6506007)(5660300002)(4744005)(76116006)(966005)(66476007)(8936002)(8676002)(66556008)(64756008)(86362001)(4326008)(66446008)(478600001)(71200400001)(54906003)(9686003)(41300700001)(110136005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NE8zZlNDemY4TTFPUFdrYXZrelVSelFkT3owdEgzUW1hcjA2cnRncGkwTWdU?=
 =?utf-8?B?a3NVcHNCSlVZSGluZjV4Z2tMY0hDcmNJb1FkeDRKQ0MySGFORy9sMGxKN1BF?=
 =?utf-8?B?bnowZmZrcjRWQ2FMVTd4ZGNZTXR4cFVteVR1ZW43U3pOVVJ6ZXhTYkJ5ckVU?=
 =?utf-8?B?aFNSZ2NMa0pmUWpaRmJaTzdDc0RoT0JYbktDckJRb0FaTFRqem5RT2lGNFNt?=
 =?utf-8?B?bVp5bFQ1M0hHSjAxanhXL1NEbFdEajc2MkQ0Q3p6Mi9BVGxKQnBiMlJkMmZO?=
 =?utf-8?B?dVFRcDRxZjFLdzFsVmtCT3ZmOE1tTml4a0dtaXg1VjVqb1YyRlltUEV0c0Q2?=
 =?utf-8?B?U0lHTXdIL0xQZnpJNjVBWHlyZ0ZrZjVndThMOGlMQnpYOERYZTZFQmVjQ1h5?=
 =?utf-8?B?bEZQZnQwSWcrMGlrWlZEdVc0REVJSWVhcEVXZmU5ZERBN2JMaG85NUNmT2pz?=
 =?utf-8?B?RXRBTDVZTnh6eXZ6TGpCeHMwOWp6UFlQM1NwbGFOOG40aUNJOVBFK2VzZGYw?=
 =?utf-8?B?bGU1SEdML0kvNzVtbzBPa3RlMVJvaGszZSsxSnV3QmFtNWJHTlJobHVMa1ph?=
 =?utf-8?B?cHJFQUFhODJvNnpEY0Y1SDZaaWpsNUlqS0NoY21Sbnd2MVMrYnFLeTRlQUM4?=
 =?utf-8?B?WDNEQzIyeVphdE5za2Z3OHR4QnJQdCtIREFvckt0c3FWUFk0czVSemFZa2I3?=
 =?utf-8?B?WDhBTHdWUHV6Y3dmUWxsTlk2TGFyN2RUbFh2OHNxOGJoR0RHN1NHQVpkNnVu?=
 =?utf-8?B?M29vRjYrS1JpbzdkQlMwcWFCYktoZUtMVm9KaXRSMVpnK25xUU9JSVZLWWdj?=
 =?utf-8?B?d0F2QW00U2NrTnoydGNQRWpIc01EV3JkSEwvT0l1bTcySDgrcnZ4ekZoYW9M?=
 =?utf-8?B?ejlBNzRQOVVWTkdMS2NvUUdQdldyZnFXR3V5eFFWeTRFOTk1Z1hXL3JwSS9G?=
 =?utf-8?B?NitxSE9WeElJdWc1VmVIcVVzcUJvSWtZdFF1Q1FvQThVekxxQVFlZXNmTjYz?=
 =?utf-8?B?RGVyLys4dFgwenNSdVBGQ0JYNHBRbHVkbWs1SDRZUVVRN00wTUY1Nkxjd25y?=
 =?utf-8?B?WU1xUCswcGdqeXE3VkVFNVdHbisrMGs4c3pQUS9EZkk2U3VHbDJyZElHSmd2?=
 =?utf-8?B?NmlIRWg0SFMwaXhHVHNmcVkxTFZhWkNadXg3d1FZS2pySUJlRVI5VXdsaHA2?=
 =?utf-8?B?UjZTejNKSzFuSWNvWHp6REIyTjVTWkdlN3AwVElTQlAzcG8veGEzRnlhdmdw?=
 =?utf-8?B?aWtqdlFvWHkrblcxZTBMUEE2VGRaT1RIVW0zenpTTDkxWXUvU295eS9xVXBy?=
 =?utf-8?B?NG96VW1UemNFMDVzN0xJanJ0WS80UkQ1azRUZERLTVEwbWRIWXdCUXh0U2RP?=
 =?utf-8?B?V3FCQ2RleVdMa0Fvd1FsVDl6T2I3TGJjR2Nsd1JDN2tHaTVUdEpQRGlxUHJu?=
 =?utf-8?B?czFTNmdweGFaTVhlaVgwSUFlS0tFZWV0LzVXb3hTRmxYSVRDbnF2SVhYTE1J?=
 =?utf-8?B?cDJTeVBTYTJzNkVaMDh0ZVFOTko1UFdPS2VYRXBzYm4yNm1vZEMwemlQWEda?=
 =?utf-8?B?Tmtxclo1Nk5YSEtWL1laR2d4UWRCeXFJVnZXZEZqajdybU15VVFEcjhmd3Q5?=
 =?utf-8?B?UU55OG9QNGV2MTZneSsvQVFHQkpuRVRWaTJQaFpHd2YrSUVvSTM1TXFXNUJm?=
 =?utf-8?B?TEpONyt6Y0Q1TlhPdmpHaDEzZVBnWThQOGMwVy8zdDQ2dC8xT2hiT0tlTUZk?=
 =?utf-8?B?Q3IvN1FPUFd6WjVwUkgyTWVka1c5clpPaEp6K1BmOFhJbGR1ZEVXRElzWW9v?=
 =?utf-8?B?bDY3U2dpNmU5MHNKUG5sdHlNUWxvU0kxWEt4SHN2d2xKT1pSeXN6QmlvQlZa?=
 =?utf-8?B?NHloRC9TbWpNR3E4SVRZRFMrZlJvdWwySzVBRkd4cTdwMG5IblNPWXVxdmtC?=
 =?utf-8?B?TnV1T0RkNjc0OFBibnRvbDVIdnkxL3BhbHdqRXd6VVFTdWQveEd2a0d2aXJ1?=
 =?utf-8?B?blNGL0lWYTQzNStxay92MkxwTEZtdG52dkwyamZEYmdhODRFUEpjVzJtNWRp?=
 =?utf-8?B?dDl0cm1zUS8vMHFGcTQ3di9IcjZaNzNPWW9panhvME83RlFuU28rNUpuT3ZD?=
 =?utf-8?Q?kyog=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1101MB2161.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7563787-f642-4abd-eb37-08daad521295
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2022 19:35:23.6772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3zjOgA/269fQaWxzUqL2C0SpzU/rkTWcuqIE1i5HRFa63vRHf1yG6+nWwJxfqRVcZ37zyQz5nk5ebRMK8TVxFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6811
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2NwdWZlYXR1cmVzLmgNCj4g
PiBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2NwdWZlYXR1cmVzLmgNCj4gPiBpbmRleCBlZjQ3NzVj
NmRiMDEuLjQ1OWZiMGMyMWRkNCAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9jcHVmZWF0dXJlcy5oDQo+ID4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vY3B1ZmVhdHVy
ZXMuaA0KPiA+IEBAIC0zMDgsNiArMzA4LDcgQEANCj4gPiAgIC8qIEludGVsLWRlZmluZWQgQ1BV
IGZlYXR1cmVzLCBDUFVJRCBsZXZlbCAweDAwMDAwMDA3OjEgKEVBWCksIHdvcmQgMTIgKi8NCj4g
PiAgICNkZWZpbmUgWDg2X0ZFQVRVUkVfQVZYX1ZOTkkJCSgxMiozMisgNCkgLyogQVZYIFZOTkkN
Cj4gaW5zdHJ1Y3Rpb25zICovDQo+ID4gICAjZGVmaW5lIFg4Nl9GRUFUVVJFX0FWWDUxMl9CRjE2
CQkoMTIqMzIrIDUpIC8qIEFWWDUxMg0KPiBCRkxPQVQxNiBpbnN0cnVjdGlvbnMgKi8NCj4gPiAr
I2RlZmluZSBYODZfRkVBVFVSRV9MS0dTCQkoMTIqMzIrIDE4KSAvKiBMb2FkICJrZXJuZWwiDQo+
ICh1c2Vyc3BhY2UpIGdzICovDQo+IA0KPiBUaGUgc3BlYyBzYXlzIFsxXToNCj4gICAgICAiRXhl
Y3V0aW9uIG9mIExLR1MgY2F1c2VzIGFuIGludmFsaWQtb3Bjb2RlIGV4Y2VwdGlvbiAoI1VEKSBp
ZiBDUEwgPg0KPiAgICAgICAwLiINCj4gDQo+IFBlcmhhcHMgdXNlcnNwYWNlIGhhcyBubyBpbnRl
cmVzdCBpbiB0aGlzLiBUaGVuLCB3ZSBjYW4gYWRkICIiIG5vdCB0byBzaG93DQo+ICJsa2dzIiBp
biAvcHJvYy9jcHVpbmZvOg0KPiAgICAgICsjZGVmaW5lIFg4Nl9GRUFUVVJFX0xLR1MJCSgxMioz
MisgMTgpIC8qICIiIExvYWQgImtlcm5lbCINCj4gKHVzZXJzcGFjZSkgZ3MgKi8NCg0KR29vZCBw
b2ludCENCg0KPiANCj4gVGhhbmtzLA0KPiBDaGFuZw0KPiANCj4gWzFdIGh0dHBzOi8vY2RyZHYy
LmludGVsLmNvbS92MS9kbC9nZXRDb250ZW50LzY3ODkzOA0K
