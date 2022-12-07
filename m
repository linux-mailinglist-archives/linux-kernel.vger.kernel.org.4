Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968EC6461B3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiLGT0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiLGT0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:26:25 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D51663E9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 11:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670441184; x=1701977184;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fIJoOYKW45uFyLPBxkchmcDJ2bmlq6655tq8SBSiUaU=;
  b=I1mJjUHeMQ6AXVyVZH0i2wsldqMckHCo7wf4pwyHy8EfncE1g8LAZMoZ
   ldiv/DysxkDQutn/peZSxEPhNSjhuWt9OX48+95WO6j6QDG9rLEgQLGev
   EmeAqQJNQ/oGkO/TqJKq9yZF+TE2UeabYcidhfmbndJ3zbDUZr25WEVBe
   yK2kZd9kgeFNuaumcXwl2NnQyfeoSBSbmW+y4GTerySXFPpJaRGhwdvQI
   ahcoXr1rPSDDk5bn9TReG2zIi7V/yL90NbYxltui8FYyYHmnrn3UX21XU
   Vb01QhZMh4aX0+4eLXwWEKJ7yrQdGspyKpYzWcxJAuhSqZ4R6CLvhuEHI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="381275144"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="381275144"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 11:26:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="975574681"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="975574681"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 07 Dec 2022 11:26:23 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 7 Dec 2022 11:26:23 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 7 Dec 2022 11:26:23 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 7 Dec 2022 11:26:23 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 7 Dec 2022 11:26:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fayHR2l8h6tX9KO2Y9MddmaVGvq5k30RhbDYMwongngai1ZNkBPp8glwd7Zp/FKYbkM1vpwwDuBgPvVM3HhFdw2bcc5i0EPKI8DdhFoBX+uadqQ3s7wkxxgtGJVc8xkihxKHLStFD7gbjVd8j9/8EMsVsAQCvgkSzAPYrOePsYu3nGTd+89KR9Wf9DFCOVZP8vLE+32U1vAP3+xAGCLhAPgpaKaBdEzl9AxiGl0MK5XMVE9zLL6gWNR+8+7vU7js52rygqnpfY8OSMSGonozIOvug2uZmKh2lbi+b44tOpkK7RYDVW/+hJXBUqdIgDKdIsjSECtWTRIZdEpDMqg8aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIJoOYKW45uFyLPBxkchmcDJ2bmlq6655tq8SBSiUaU=;
 b=YANOpVwzyI2k+3i6DchLs0jFLWbzMO3EHJv5n0SU5r6pCOe3VYJOVIXMf3uxXbpXeDJap5V4lusVVCKkq1TyVx46kmpcg4Aw9AZHT+TqTNrxRabhXp9581gNtI8U1n2kc3bSQzvfE0uYhuihiQYMCFmNTz5TglgiOC7q4mr3Pf+r1nGzS1uJJTYkUXaYQWicUF8wVGmVSc1i8m3U7hPEqHx1EgTymCkw0G3be7LrVJCwGM1XEFOWA2YR9GtsyLLBJ0hxxHK8kCrsDjGOyd8yqEdJFdkZY25yLXQE1VpABAp75MmfmsbbeVuTRKbLgdSP6qoMIVCapJkW2o159eOpVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by PH0PR11MB4789.namprd11.prod.outlook.com (2603:10b6:510:38::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 19:26:19 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%9]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 19:26:19 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Peter Newman <peternewman@google.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "James Morse" <james.morse@arm.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        "Jamie Iles" <quic_jiles@quicinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Eranian, Stephane" <eranian@google.com>
Subject: RE: [PATCH] x86/resctrl: Fix event counts regression in reused RMIDs
Thread-Topic: [PATCH] x86/resctrl: Fix event counts regression in reused RMIDs
Thread-Index: AQHZCi9C4oOZlvbDzkC+8A+fPjkoya5iykxQ
Date:   Wed, 7 Dec 2022 19:26:19 +0000
Message-ID: <IA1PR11MB6097B274AB8223D44CAFF4899B1A9@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20221207112924.3602960-1-peternewman@google.com>
In-Reply-To: <20221207112924.3602960-1-peternewman@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|PH0PR11MB4789:EE_
x-ms-office365-filtering-correlation-id: c48aa8d3-8363-45cc-17f9-08dad888eaf9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ODKECsr+nyTMsxANvDhjZBSIFCgwMr9WFKwxlHM6435/vZfruvJQxW4uFGG4STYzzMKqjdjffxJmF6+Rj5Y5jaO7rkanxUakZPa4mQaQVICLsUjH874xWtyX4BWdQ1XLXW1dr9HM4ZRhZQWnJjZakvFPddstCpZvuZo0yPcE+qk/udyghSZUS3hQSpwFQEGm505+otUhBp8rRtQDEFXgsOrNBmb50Aub9zikWbkSCtpzCNe2VZ2zma2WsD+iSWR8trFVbrSkidoijoB3/0EQyO5dJtGRowjE5WOgFFl4U1rB4e6QGBLgTXD7DRp1IWeZHvvYf5SzHUJYCdZS4qD+zbXHNT5DlsJe2dqc+dWyTLBTXgS5TWWqw1dSOnuxlUpiMeBEYnb2K6qWW7z5+2UlQFoOmS0gK6sZ2BynggkwP7d5AC5FaM0MqbutNYZSGfsrM3cJa/Nazq0fl0rTTDKTeHShFrC8a1ORk/aM/SY2xf0walgNQN1oaWsk8z0+Q476DNOGjr7N1B6v1VoGIN0MgTJeBh04y+LK0y/Kx5K8qIG/thZUdNk0WSZ6sCCMjOertQgoGHzHjkCJ3MYgqqHZPSIPaMVUzKfIU+sZ+y0r0mQC68Jjv63Nokd3Vury4T95lytkZeeXek00P0QW+7qWkJvXKhKDFUN+Lniy9GUrP+akefhlxYjvZBQ0Ed+3wfQDOcesAdgJyQElDdGEI6DXxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199015)(83380400001)(122000001)(8936002)(86362001)(82960400001)(2906002)(5660300002)(7416002)(41300700001)(38070700005)(4326008)(33656002)(52536014)(186003)(478600001)(55016003)(26005)(7696005)(9686003)(64756008)(6506007)(66946007)(8676002)(66556008)(6636002)(110136005)(54906003)(66476007)(76116006)(316002)(66446008)(38100700002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YytPOWtUZkxFTm5xaU11QnBpa2U0QnlnS29Odyt5YUFSR0phb1Fpc1FNemVP?=
 =?utf-8?B?VEJmYWNXVHl6Zm02VmhGUnpCMW9XTHFuZCt2SHM5TEdWWmkwbHRxQ2RCd0tS?=
 =?utf-8?B?SjNQeS9uaS8zWmdaRHhrYjdSVnk2b0g3dGJCcTUzdEduS2d2aktHZ2RORysv?=
 =?utf-8?B?bzlubHhNN09TK2dINnVoaGtkRGIzQXhmeUxXOENIVTBzVEE5eFJKdlpMRHhV?=
 =?utf-8?B?MUJVaUJ1RkRXcm5wWFBUT1p4MzNCUEVHS0F2S244ZnVldlhjcFFoejgvVXQr?=
 =?utf-8?B?QnFlS0RDZm8ySnpuNnpkb0lvZzM1akVGWTBKMWQvbVhpd2ZJQVZUUGJmYkxN?=
 =?utf-8?B?Nk9wS2V4cElaRWZ1RWZTYWFLWlhTQmRKQVFSSlVTZjNQYkdvMGNrbkdVdXV6?=
 =?utf-8?B?R0lkSTR5Uzg4empSMGlsdXFDamR6K1Q5czRFT3VMT3gzeXVja25tT1VreUFO?=
 =?utf-8?B?WXdNSTBheHJFK3pFYmhxVDBHRElaKzY2eTBCS2ROL0lmQ3hudjRzUU05V3Ft?=
 =?utf-8?B?T24wOTRQKzFUdE5hQnlmc2ovSXJnVG9kajlVZjR1dWxweXYySVZBNW93c25B?=
 =?utf-8?B?U0paeGhFOUNxMmZCeFJJZGlZWkJUYmFiV3YrSVZ1VnBvQXlHenIxeDYzR2o4?=
 =?utf-8?B?TkNVak5aVWJkUUR3bzlXUjFIdWM0aHduNGZWMkY1OEIzUG9KdkJMYUNmYWlH?=
 =?utf-8?B?MGUwcEZ1NWtSSDRsUEMxSmxVazY4M1ZkUEZOeXBGbC9uUFdmT1F4VGI2cEFi?=
 =?utf-8?B?dm5SbmFXMXdYMFVMenl6N1g4MGQ5OXVJSUJ6VVhWQmMrUzdCenYvOE9jaEpV?=
 =?utf-8?B?Z1o3R1N1QlZETVc3d0dwU1o1Y09ZZm5VenNZRzI0dTREbHlBdkY1cnp2T08x?=
 =?utf-8?B?Zi9paWZpS1liY3A4dGthaUpucmNmcHpSZTdIREU5dmdGSkFUczRPR0NkVlpz?=
 =?utf-8?B?WWErU1MxbktxOGw4bnQrNGpiN2tNK3VrQmZMZ1UweXBtK1BZaDZYT3VlV0dF?=
 =?utf-8?B?cGNzWnVRSWVhWnUrYWpuOWg4M29DNHZhMzRZbnJHNjVrS3ZwK1UyNCtzT1p4?=
 =?utf-8?B?b0N5Z05YVE1Ta1RJYi9GS3VQSnF5eEo5aWp2KytBOTIwcHNnY0NtaXRpL1dm?=
 =?utf-8?B?T3hNaWJYTU1VM3BUWFBQenpuTDhuQ2lneXNRdXpFVmZZZXZibWkrNWttL3V2?=
 =?utf-8?B?cUQyNG83QWxmeTdRcjVmbVQveStZMXhlYTl2ZUdnMVRzU2w0RzBIR2ZIc0d5?=
 =?utf-8?B?Q0JxOVpvellWN1pzSEgwMWYraXFxUmw5em8wak9mdnd0ZFB5WTg3T2lJZXM5?=
 =?utf-8?B?UGdIQmw3V1pnUjRieGlZR3k2UFduQ24wZXl6a0tUcUlTUnZFRktoNGtJeWs2?=
 =?utf-8?B?RG84L2R6V1FUNnl5VnROM3drVWpPVytjQ2hQWEMxa0Yrem5BYS9aK0p0NFhB?=
 =?utf-8?B?ZEl6ZUYzYTgxNTFyRmdzUXpLWWlpYVZoSVhwcVZFeHFXY0l6bjBXcUE0Snh0?=
 =?utf-8?B?cGpBc3dFWlNMUldvSndkRnZZaHZkTzNPaERPaXhOL3B5MFB0Y0ExQVdHVmhT?=
 =?utf-8?B?bkJvKzBkdGJGZmR0em1OMGhyUVVMRnpVbjI1cXN5RUdEL0h1VGYvZVh4Nkk5?=
 =?utf-8?B?QWcyRkRBY3dnYitrcDRDejRjb25ia3EvbkYySVpTTFdxMjZmSmF6a2pBb0N6?=
 =?utf-8?B?UGN6eC80Yk8ramtpVHZNMzk2SUR5cURvclQxZGlIQkt2bFpRMkN1Q2U1M1BQ?=
 =?utf-8?B?TWhRSVhjcW0rQ2wwT2krT2RSN0JGekVqZmhKQThZQ1RPUm0rREc2b3ZSM2xl?=
 =?utf-8?B?SURzNzE2Nk1PM1ZxMDVRK21iY0RwektIYXhSRDE5Vm0ranhLVExpMktqd1V5?=
 =?utf-8?B?dHhOOGcybU5wRWRzZ1NpRGF0NzBtR2Y2OXp0ZE42ZmZVVGFIUXd4Vm1iMlZh?=
 =?utf-8?B?K2F5ckk2OFpnVWVIOHl3S1U4Nkl1dWJGUGJVRE9xNVJZbGtpdHAyK3pmSjBu?=
 =?utf-8?B?cEhabVRoVi9mcndlMnluRXJuZWl3OTQ5STFJSklIZUY5cXNwcTAwY21WTE94?=
 =?utf-8?B?MEVjb1Z1SFJQYTBUcDZjR2s4a0c3c3c5Q1YvSk1HK0VDaHprYlRpNkRDR3lI?=
 =?utf-8?Q?wC8SXJV/GR6K4+YKaeL+jjcuy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c48aa8d3-8363-45cc-17f9-08dad888eaf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 19:26:19.5066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CcoD0vRD8YiGcgcDboJl3wVlQTjgNcyL5m8cNsaUIqRDgNNK70RcowQnrqr0pCjbOI6GxrOxPop23yttmeA1YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4789
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFBldGVyLA0KDQo+IFdoZW4gY3JlYXRpbmcgYSBuZXcgbW9uaXRvcmluZyBncm91cCwgdGhl
IFJNSUQgYWxsb2NhdGVkIGZvciBpdCBtYXkgaGF2ZQ0KPiBiZWVuIHVzZWQgYnkgYSBncm91cCB3
aGljaCB3YXMgcHJldmlvdXNseSByZW1vdmVkLiBJbiB0aGlzIGNhc2UsIHRoZSBoYXJkd2FyZQ0K
PiBjb3VudGVycyB3aWxsIGhhdmUgbm9uLXplcm8gdmFsdWVzIHdoaWNoIHNob3VsZCBiZSBkZWR1
Y3RlZCBmcm9tIHdoYXQgaXMNCj4gcmVwb3J0ZWQgaW4gdGhlIG5ldyBncm91cCdzIGNvdW50cy4N
Cj4gDQo+IHJlc2N0cmxfYXJjaF9yZXNldF9ybWlkKCkgaW5pdGlhbGl6ZXMgdGhlIHByZXZfbXNy
IHZhbHVlIGZvciBjb3VudGVycyB0byAwLA0KPiBjYXVzaW5nIHRoZSBpbml0aWFsIGNvdW50IHRv
IGJlIGNoYXJnZWQgdG8gdGhlIG5ldyBncm91cC4gUmVzdXJyZWN0DQo+IF9fcm1pZF9yZWFkKCkg
YW5kIHVzZSBpdCB0byBpbml0aWFsaXplIHByZXZfbXNyIGNvcnJlY3RseS4NCj4gDQo+IEZpeGVz
OiAxZDgxZDE1ZGIzOWMgKCJ4ODYvcmVzY3RybDogTW92ZSBtYm1fb3ZlcmZsb3dfY291bnQoKSBp
bnRvDQo+IHJlc2N0cmxfYXJjaF9ybWlkX3JlYWQoKSIpDQoNCkFyZSB5b3Ugc3VyZSB0aGUgcGF0
Y2ggZml4ZXMgMWQ4MWQxNWRiMzljPyBUaGlzIGNvbW1pdCBpcyBqdXN0IGEgcmVmYWN0b3Jpbmcg
cGF0Y2ggYW5kIGRvZXNuJ3QgY2hhbmdlIHJlc2N0cmxfYXJjaF9yZXNldF9ybWlkKCkuDQoNClNo
b3VsZG4ndCB0aGUgcGF0Y2ggZml4IGNvbW1pdCBmZWE2MmQzNzBkN2E/DQoJDQo+IFNpZ25lZC1v
ZmYtYnk6IFBldGVyIE5ld21hbiA8cGV0ZXJuZXdtYW5AZ29vZ2xlLmNvbT4NCj4gLS0tDQo+ICBh
cmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvbW9uaXRvci5jIHwgMzkgKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMTIgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJs
L21vbml0b3IuYw0KPiBiL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9tb25pdG9yLmMNCj4g
aW5kZXggZWZlMGMzMGQzYTEyLi40MDRkZDljNDcyYzcgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2
L2tlcm5lbC9jcHUvcmVzY3RybC9tb25pdG9yLmMNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL2Nw
dS9yZXNjdHJsL21vbml0b3IuYw0KPiBAQCAtMTQ2LDYgKzE0NiwyNCBAQCBzdGF0aWMgaW5saW5l
IHN0cnVjdCBybWlkX2VudHJ5ICpfX3JtaWRfZW50cnkodTMyIHJtaWQpDQo+ICAJcmV0dXJuIGVu
dHJ5Ow0KPiAgfQ0KPiANCj4gK3N0YXRpYyB1NjQgX19ybWlkX3JlYWQodTMyIHJtaWQsIGVudW0g
cmVzY3RybF9ldmVudF9pZCBldmVudGlkKSB7DQo+ICsJdTY0IHZhbDsNCj4gKw0KPiArCS8qDQo+
ICsJICogQXMgcGVyIHRoZSBTRE0sIHdoZW4gSUEzMl9RTV9FVlRTRUwuRXZ0SUQgKGJpdHMgNzow
KSBpcyBjb25maWd1cmVkDQo+ICsJICogd2l0aCBhIHZhbGlkIGV2ZW50IGNvZGUgZm9yIHN1cHBv
cnRlZCByZXNvdXJjZSB0eXBlIGFuZCB0aGUgYml0cw0KPiArCSAqIElBMzJfUU1fRVZUU0VMLlJN
SUQgKGJpdHMgNDE6MzIpIGFyZSBjb25maWd1cmVkIHdpdGggdmFsaWQgUk1JRCwNCj4gKwkgKiBJ
QTMyX1FNX0NUUi5kYXRhIChiaXRzIDYxOjApIHJlcG9ydHMgdGhlIG1vbml0b3JlZCBkYXRhLg0K
PiArCSAqIElBMzJfUU1fQ1RSLkVycm9yIChiaXQgNjMpIGFuZCBJQTMyX1FNX0NUUi5VbmF2YWls
YWJsZSAoYml0IDYyKQ0KPiArCSAqIGFyZSBlcnJvciBiaXRzLg0KPiArCSAqLw0KPiArCXdybXNy
KE1TUl9JQTMyX1FNX0VWVFNFTCwgZXZlbnRpZCwgcm1pZCk7DQo+ICsJcmRtc3JsKE1TUl9JQTMy
X1FNX0NUUiwgdmFsKTsNCj4gKw0KPiArCXJldHVybiB2YWw7DQo+ICt9DQo+ICsNCj4gIHN0YXRp
YyBzdHJ1Y3QgYXJjaF9tYm1fc3RhdGUgKmdldF9hcmNoX21ibV9zdGF0ZShzdHJ1Y3QgcmR0X2h3
X2RvbWFpbg0KPiAqaHdfZG9tLA0KPiAgCQkJCQkJIHUzMiBybWlkLA0KPiAgCQkJCQkJIGVudW0g
cmVzY3RybF9ldmVudF9pZCBldmVudGlkKQ0KPiBAQCAtMTcwLDEwICsxODgsMTcgQEAgdm9pZCBy
ZXNjdHJsX2FyY2hfcmVzZXRfcm1pZChzdHJ1Y3QgcmR0X3Jlc291cmNlICpyLA0KPiBzdHJ1Y3Qg
cmR0X2RvbWFpbiAqZCwgIHsNCj4gIAlzdHJ1Y3QgcmR0X2h3X2RvbWFpbiAqaHdfZG9tID0gcmVz
Y3RybF90b19hcmNoX2RvbShkKTsNCj4gIAlzdHJ1Y3QgYXJjaF9tYm1fc3RhdGUgKmFtOw0KPiAr
CXVpbnQ2NF90IHZhbDsNCg0KUGxlYXNlIG1vdmUgdGhpcyBsaW5lIHRvIGJlbG93Og0KDQo+IA0K
PiAgCWFtID0gZ2V0X2FyY2hfbWJtX3N0YXRlKGh3X2RvbSwgcm1pZCwgZXZlbnRpZCk7DQo+IC0J
aWYgKGFtKQ0KPiArCWlmIChhbSkgew0KDQpoZXJlOg0KKwl1NjQgdmFsOw0KDQpBbmQgaXQncyBi
ZXR0ZXIgdG8ga2VlcCB0aGUgc2FtZSB0eXBlIG5hbWUgInU2NCIgYXMgb3RoZXIgdmFsdWVzLg0K
DQo+ICAJCW1lbXNldChhbSwgMCwgc2l6ZW9mKCphbSkpOw0KPiArDQo+ICsJCS8qIFJlY29yZCBh
bnkgaW5pdGlhbCwgbm9uLXplcm8gY291bnQgdmFsdWUuICovDQo+ICsJCXZhbCA9IF9fcm1pZF9y
ZWFkKHJtaWQsIGV2ZW50aWQpOw0KPiArCQlpZiAoISh2YWwgJiAoUk1JRF9WQUxfRVJST1IgfCBS
TUlEX1ZBTF9VTkFWQUlMKSkpDQo+ICsJCQlhbS0+cHJldl9tc3IgPSB2YWw7DQo+ICsJfQ0KPiAg
fQ0KPiANCj4gIHN0YXRpYyB1NjQgbWJtX292ZXJmbG93X2NvdW50KHU2NCBwcmV2X21zciwgdTY0
IGN1cl9tc3IsIHVuc2lnbmVkIGludCB3aWR0aCkNCj4gQEAgLTE5NSwxNyArMjIwLDcgQEAgaW50
IHJlc2N0cmxfYXJjaF9ybWlkX3JlYWQoc3RydWN0IHJkdF9yZXNvdXJjZSAqciwNCj4gc3RydWN0
IHJkdF9kb21haW4gKmQsDQo+ICAJaWYgKCFjcHVtYXNrX3Rlc3RfY3B1KHNtcF9wcm9jZXNzb3Jf
aWQoKSwgJmQtPmNwdV9tYXNrKSkNCj4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+IA0KPiAtCS8qDQo+
IC0JICogQXMgcGVyIHRoZSBTRE0sIHdoZW4gSUEzMl9RTV9FVlRTRUwuRXZ0SUQgKGJpdHMgNzow
KSBpcyBjb25maWd1cmVkDQo+IC0JICogd2l0aCBhIHZhbGlkIGV2ZW50IGNvZGUgZm9yIHN1cHBv
cnRlZCByZXNvdXJjZSB0eXBlIGFuZCB0aGUgYml0cw0KPiAtCSAqIElBMzJfUU1fRVZUU0VMLlJN
SUQgKGJpdHMgNDE6MzIpIGFyZSBjb25maWd1cmVkIHdpdGggdmFsaWQgUk1JRCwNCj4gLQkgKiBJ
QTMyX1FNX0NUUi5kYXRhIChiaXRzIDYxOjApIHJlcG9ydHMgdGhlIG1vbml0b3JlZCBkYXRhLg0K
PiAtCSAqIElBMzJfUU1fQ1RSLkVycm9yIChiaXQgNjMpIGFuZCBJQTMyX1FNX0NUUi5VbmF2YWls
YWJsZSAoYml0IDYyKQ0KPiAtCSAqIGFyZSBlcnJvciBiaXRzLg0KPiAtCSAqLw0KPiAtCXdybXNy
KE1TUl9JQTMyX1FNX0VWVFNFTCwgZXZlbnRpZCwgcm1pZCk7DQo+IC0JcmRtc3JsKE1TUl9JQTMy
X1FNX0NUUiwgbXNyX3ZhbCk7DQo+IC0NCj4gKwltc3JfdmFsID0gX19ybWlkX3JlYWQocm1pZCwg
ZXZlbnRpZCk7DQo+ICAJaWYgKG1zcl92YWwgJiBSTUlEX1ZBTF9FUlJPUikNCj4gIAkJcmV0dXJu
IC1FSU87DQo+ICAJaWYgKG1zcl92YWwgJiBSTUlEX1ZBTF9VTkFWQUlMKQ0KPiANCj4gYmFzZS1j
b21taXQ6IDc2ZGNkNzM0ZWNhMjMxNjhjYjAwODkxMmMwZjY5ZmY0MDg5MDUyMzUNCj4gLS0NCj4g
Mi4zOS4wLnJjMC4yNjcuZ2NiNTJiYTA2ZTctZ29vZw0KDQpUaGFua3MuDQoNCi1GZW5naHVhDQo=
