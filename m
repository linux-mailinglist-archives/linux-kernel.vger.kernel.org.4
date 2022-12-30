Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DB26588C6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 03:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbiL2C6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 21:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiL2C6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 21:58:38 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9061208D;
        Wed, 28 Dec 2022 18:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672282717; x=1703818717;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s7nWhtTZzV6djd0X6GgjNFh7xerN1rfydzBk5OO4eRE=;
  b=fQ90TKJhhiOphqfgeJPTahBJe27BH24Dnqn0m2AYB593qbbT7DG6UH/D
   HJ21mFk+OzTW4WeQXiy+QzJ+5o85JzJuRoylFxiZW7hPohBcGpL9PrQe1
   mz4I8I4pZUkKKmByQvcb8jz4KTYUvGOK0dvxAd2Rsm5Cc1qflKkN4wudS
   w+QedtetDORK4hVLbZu6YttDzmmtByabjUMprIDiq291SIcBJTx709fy4
   3BdF5B63o+EDY91G15piUOUgH4QkeX4tRwV5tOUiN3h5kP4Ze+dGjMb8y
   M3u9t1NrPwBuKFNxYoom9yqnnrjtmYBr7CDnjBpxPLjg6Q7UO0E7iV30b
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="383268412"
X-IronPort-AV: E=Sophos;i="5.96,282,1665471600"; 
   d="scan'208";a="383268412"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 18:58:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="982239658"
X-IronPort-AV: E=Sophos;i="5.96,282,1665471600"; 
   d="scan'208";a="982239658"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 28 Dec 2022 18:58:36 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 28 Dec 2022 18:58:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 28 Dec 2022 18:58:35 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 28 Dec 2022 18:58:35 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 28 Dec 2022 18:58:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmb44Sr3zotvjAli3rwjlXg3rq3Xdpz4FoTuHaeuUopxpA83931N9Y2F8Ztjs3EKjiPnwd2AJB8pyD96NZe/MEfq5MZfdEqtT53pKZlOf5bcAJI7ISTtJHs5zpC5d2iqDp2LAxLzoB1H62uUAGqrScxHKtkzWNRCJmUURZhisSwG4u3M5WORyeQjeer3Ki53uZTADJC7qMsVnM0b8OBaku1E2U/Kykzc21nTfXrQaClVDurbdAKN7UaBs+v2J0FwTnDaVDgoOjh+CD04UrzSEjM6zXWUoEdYKwhu6rBYtPjuMizHjM5/jvb7eCArr+e8HmJt2ymj03nozpGxN4k1/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7nWhtTZzV6djd0X6GgjNFh7xerN1rfydzBk5OO4eRE=;
 b=IOWJUxBYKbfAIVV1vkIhBmQLZ7gc0PUqs8rZoVoAFbmODTG7uwb15AqlRf6c+aN0qAUvgS5qj2EMExHvL5+s70Fr9EaRma+JzX0BoJQSfRup9k8UfAtHWVEbRk1WTNnWsALzaqQcXQ9oir79eoDo8QxQrAWh21NQD71F5crSDDomV55b6cKROX9uF71WKknfwEFOOgKZVWKb7DujZE983d3HHiqwBhE6pEkuOJF5o+mIdSCNSOJzfbKPUvWS0AT2MOItr2Nno/nv6I/gR6lE64LOCZb6zES2ty8Gx4Z8IpNteJNbu/NejpblIjRyyJWvfQukUZbV97PtiZjLW60rhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0031.namprd11.prod.outlook.com (2603:10b6:301:69::37)
 by SA1PR11MB7064.namprd11.prod.outlook.com (2603:10b6:806:2b7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 29 Dec
 2022 02:58:30 +0000
Received: from MWHPR11MB0031.namprd11.prod.outlook.com
 ([fe80::b05:c765:b545:78c5]) by MWHPR11MB0031.namprd11.prod.outlook.com
 ([fe80::b05:c765:b545:78c5%7]) with mapi id 15.20.5944.016; Thu, 29 Dec 2022
 02:58:29 +0000
From:   "Zhang, Chen" <chen.zhang@intel.com>
To:     "Yang, Weijiang" <weijiang.yang@intel.com>
CC:     "Gao, Chao" <chao.gao@intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: RE: [RFC PATCH 6/9] kvm/x86: Add ARCH_CAP_VIRTUAL_ENUM for guest
 MSR_IA32_ARCH_CAPABILITIES
Thread-Topic: [RFC PATCH 6/9] kvm/x86: Add ARCH_CAP_VIRTUAL_ENUM for guest
 MSR_IA32_ARCH_CAPABILITIES
Thread-Index: AQHZDLMiQbmbfwYsK06hcLGAwsuJI653yRSAgAsc9kA=
Date:   Thu, 29 Dec 2022 02:58:29 +0000
Message-ID: <MWHPR11MB0031EEA971FDA614271C22449BF39@MWHPR11MB0031.namprd11.prod.outlook.com>
References: <20221210160046.2608762-1-chen.zhang@intel.com>
 <20221210160046.2608762-7-chen.zhang@intel.com>
 <d4dec151-553f-e762-7fcc-81ae82b5c211@intel.com>
In-Reply-To: <d4dec151-553f-e762-7fcc-81ae82b5c211@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0031:EE_|SA1PR11MB7064:EE_
x-ms-office365-filtering-correlation-id: 3207f079-11bd-474d-b280-08dae9489083
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OzPVWfQxLGuFCQ65FF1BH5fs+NnB0Y0Gqd+8+Et5vRTRh4GhoNqFKKMyquR+hMeNajsVbshTlQIWk68f5NhP1PZ02AbM1/AFSjRGMX2hLIVXIwYzuiRx/wgRQPE/q3ZEAfF9ibovTnyh0ioSI2BSRAMUfXcO3gtVp4CL3eaF/J/Ep6eJAKKyc8MMq+v1u4v72lzZMEgCvCL3nZOXQVivgcgoL8cDqabcDqumip3oG6aKEhQjJgfuMsBGOcEgZd05W6xyvISJRa4kOKfovcefPEQtV5FgfnJjccTxPof4Xn2Ya2W7s/ZMRdytuok9sv/7H9QmfP1wJ79BZSLBxeLj3S/4pZ5CMKxWEVVwo5TKOegYTvv4AjyCRuTPgh1xd3cAoy8+C9ngqJen+noHRy8OFdZP/DW0361sF31+ociiP3XzW5yv3tFyhxH/vb3B2UZDxRcCHcTzy2DxLOCqO3MD0+TNaGcqd8v+rI3PnobPWKvE8OvY1icd6JxRk0qqWrUOzn+ltmo0IV6oJ+yDI9TVUmFAM+vYKmedSTwNdAtFZEpTOVZjz5uwoor0QHoAGEYXToNJoIBVAErYsnjjnz9bgpxBP5KfvhfPlns8faNyOvYDIuID5vHCYW5VOS+NEVI+gUYzjAb43scbWSh3LlU+cjpcLK/gvGBydaMs+yF6T3HCwNpHLSosvPKXg8TYzGhLm9Y5YAH1h6+p+XtQ3Iba72jhYJxLd8slZ6FiBmINRwE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0031.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199015)(26005)(186003)(6506007)(478600001)(53546011)(8936002)(6636002)(7696005)(54906003)(4326008)(66476007)(66446008)(76116006)(66556008)(41300700001)(66946007)(8676002)(64756008)(83380400001)(7416002)(2906002)(6862004)(316002)(71200400001)(9686003)(5660300002)(52536014)(33656002)(55016003)(966005)(38100700002)(86362001)(122000001)(38070700005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVluaFRLd0dZdnc2M2J5aFhpenpmbEg5clJhYzR5Ni83RHUrRHIvOTJaVlMy?=
 =?utf-8?B?WWJkNTJzRmNQRDZ2QmZ6SlZRYVU4b01URkdmeWxKV0xmYXVka01XRWtLYVM2?=
 =?utf-8?B?eXhTSWR6RWg2TGFBd0QrdnZsNVBIdnhQLzVzVmU0RGlUN0FXK1EzdGJ6REZ2?=
 =?utf-8?B?M1p0QW5zQXBQWHdJZHQ3cEFaYUtDckRwNUZVN3hXRVAzT3ZPT3JXY1RwVmxt?=
 =?utf-8?B?bXZOeFRJeHhPamdrOXZaem9uM2NuZTJTZHB1VTltVmxabjZGMFpnUWZsNk9Q?=
 =?utf-8?B?SXNjNFpSS25TR1ZPMGtOUG5jTHFnSk42VGlyRnp2dktHMjQxdE1VelZmZk1I?=
 =?utf-8?B?a1AxSzBPQVorakttS1IwanhZWlVmU0ZxZVhjOTZCZ0FHWDJCaGFXNkVLcC83?=
 =?utf-8?B?c1pGcDhBT2hpWEZEOG0wTTU0M1NCdk9IM1Bibk8vZjMvak5FdWhMT21MZ3FK?=
 =?utf-8?B?TkNUSWp2U2FOK0ZtNlRwcDFxTy9rdW1aSjBDY0FqWGYrYnFqNHRDQXR0RmhW?=
 =?utf-8?B?SWZZK000VFhjWGk1SXBDMXp5VmxjTnlvT0YwTTF3U3pRVnZDcWh1c3FOejFv?=
 =?utf-8?B?WS93UzNYL1RuRXBHRjhvUmJRTHhFZ1BEVW5QSngxYTdHendXRFNma2UveGMz?=
 =?utf-8?B?MUJKMkdvZmg4K1NDaFl1clVqemZnbWRESEZqRnU0WUwvYkdLRjFoNzF5UFdu?=
 =?utf-8?B?OE1CMlZhbGd4dG5PSHZwdkVOenpVZU45eHNhUjFXYWtpRDZkWXBOMmdOTGVS?=
 =?utf-8?B?Rld1SjFyZEgveHZKaWhsYTYzQjhKVUdyL2tkOXFUOVVwNVZEQS8ycGZlbUJ4?=
 =?utf-8?B?dXgrR2gvWStlYVNUY3BCT1A0QkkyL2kyRFFFRkdDOHVWUTUzZFlOSlZjNWZx?=
 =?utf-8?B?S2E0aUllc3ZIZ2xlQUdFTDJBTGFtTlNqWURxT3YrVm9tS0dkdmZTQ3NMQllm?=
 =?utf-8?B?TWpnaS9xMmswQXlRU2FhL3Jnb21raDR1UWF0VjRHRWhjWjBjSENNTTJ3bWhJ?=
 =?utf-8?B?UDVoRWtFZWJDQTQ5UEJFSTdPTzkvcDVKY2g0SEtsRk9uajA5Q1g5N0dkVXg2?=
 =?utf-8?B?TGx4OVVqTUpjTlE5b2FYT2ZKcUhZMTVhRnV3VGxrYk5RYUM3bXp6ZmRhSFhl?=
 =?utf-8?B?ekduUFpjaHNxWTdkRVNhRlFWeWhHNlpIQ1NZNFRwbUZ3c0Z6Sm43Sm0vWkxl?=
 =?utf-8?B?Z0JaUktUaUR4aGZEMTNxaXN1TzNwMFZPSGlwa2ZlQVNhYS9YZ2JYZFJYdXJU?=
 =?utf-8?B?REw4SDJHOXVJMEFzYnFsWmw4ejZ2UWhHMlEwaUJGOU03Q2RmUEN0U1FydFA1?=
 =?utf-8?B?RDBnLzV2T0JzRXZ5RTRnbjExY0tLbTh2MllmQWIybFFYZmoyT0MvSHdmUkpO?=
 =?utf-8?B?S0pxSEpXbHZ0Mm5oam5ocWRRaGZacHZIY1B1dDZhRVA1ZlN6ZUo0V1BYcXNY?=
 =?utf-8?B?eUJaTi9ORFlkdnVWMWE5bXJTQUhIRjI1eDh3NndlOTJ6ZENDeFNubWxJNEky?=
 =?utf-8?B?ZWdLOWVwdEZ5THE5M0RaT1dJa1IvM3d5b3ZkK01JVnVIMnNFZVp2Umdtbm0z?=
 =?utf-8?B?RG83OVR0Qy8xbmQzQklkWEpWMnZUNG9PcUFYcEYrNTlEZmdNZHNZYTY1WURs?=
 =?utf-8?B?L1g3d3ZpVGRUMjVjcHkrQXpPWXFkQjloMU81LzQ3K0FVOEQxSEx0V1VQQjVm?=
 =?utf-8?B?RCtwU2FsN2VQc0UrRTlLUThNcGNtRnRSajBtOGFjMVU4TXpsMGtWRHlUWVMv?=
 =?utf-8?B?OUVKTVFBL0pPZUNLU0Z6dnZ6aDcyNVV0SnoyMUY4YnpaOGJHLzNJZUpCRTVT?=
 =?utf-8?B?cEVNR0lxWU9BaVd2cXlmMHViaXZDV0JsRmYxZ2tKbmFrK2kwNXRKQy9yY21V?=
 =?utf-8?B?K0N5OG4rTkNXdWRPR09QcVlEQnQzUHhzOEtlVGNxSlVGMUJvekJpK3h3Y1lw?=
 =?utf-8?B?U0tJZjlxNzVuS3dGVllpNzdwV1dESmRhNEROQTV6Q0FneU1UdVNLWW9wOTRU?=
 =?utf-8?B?dkJ4WGVoWkc3R1Z4VDhka3R6ZXJZdXgrV0tpYi9tUldxOSt3Z0tvbTJNTlU1?=
 =?utf-8?B?SUE2Y3laTlppT2pTeTJGUGR6ckRpMEhLbXd6UTVPWG5BNE9teFpOMGY5dWVQ?=
 =?utf-8?Q?/CrymQMbtdtXfzuOE3D47CNsd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0031.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3207f079-11bd-474d-b280-08dae9489083
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2022 02:58:29.7657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PoO5kLrspTlaZCryJliTuk7kmd+vBb203ToXPPqdNgZ98B5F2NOjVLVads/LYdxKWQuA1WGvOEw+iiX7SmtASw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7064
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWWFuZywgV2Vpamlhbmcg
PHdlaWppYW5nLnlhbmdAaW50ZWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIERlY2VtYmVyIDIx
LCAyMDIyIDEyOjA0IFBNDQo+IFRvOiBaaGFuZywgQ2hlbiA8Y2hlbi56aGFuZ0BpbnRlbC5jb20+
DQo+IENjOiBHYW8sIENoYW8gPGNoYW8uZ2FvQGludGVsLmNvbT47IFBhd2FuIEd1cHRhDQo+IDxw
YXdhbi5rdW1hci5ndXB0YUBsaW51eC5pbnRlbC5jb20+OyBQYW9sbyBCb256aW5pDQo+IDxwYm9u
emluaUByZWRoYXQuY29tPjsgQ2hyaXN0b3BoZXJzb24sLCBTZWFuIDxzZWFuamNAZ29vZ2xlLmNv
bT47IEguDQo+IFBldGVyIEFudmluIDxocGFAenl0b3IuY29tPjsgRGF2ZSBIYW5zZW4gPGRhdmUu
aGFuc2VuQGxpbnV4LmludGVsLmNvbT47DQo+IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRl
PjsgSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+OyBUaG9tYXMNCj4gR2xlaXhuZXIgPHRn
bHhAbGludXRyb25peC5kZT47IHg4NkBrZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOw0KPiBrdm1Admdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENI
IDYvOV0ga3ZtL3g4NjogQWRkIEFSQ0hfQ0FQX1ZJUlRVQUxfRU5VTSBmb3INCj4gZ3Vlc3QgTVNS
X0lBMzJfQVJDSF9DQVBBQklMSVRJRVMNCj4gDQo+IA0KPiBPbiAxMi8xMS8yMDIyIDEyOjAwIEFN
LCBaaGFuZyBDaGVuIHdyb3RlOg0KPiA+IEFkZCB0aGUgNjMgYml0IGluIE1TUl9JQTMyX0FSQ0hf
Q0FQQUJJTElUSUVTIGZvciBlbmFibGUgdGhlIHZpcnR1YWwgTVNScy4NCj4gPiBWaXJ0dWFsIE1T
UnMgY2FuIGFsbG93IGd1ZXN0cyB0byBub3RpZnkgVk1NIHdoZXRoZXIgb3Igbm90IHRoZXkgYXJl
DQo+ID4gdXNpbmcgc3BlY2lmaWMgc29mdHdhcmUgbWl0aWdhdGlvbiwgYWxsb3dpbmcgYSBWTU0g
dG8gZW5hYmxlIHRoZXJlDQo+ID4gaGFyZHdhcmUgY29udHJvbCBvbmx5IHdoZXJlIG5lY2Vzc2Fy
eS4NCj4gPiBBcyBJbnRlbCBzcGVjIGRlZmluYXRpb24sIGV4cG9zZSB2aXJ0dWFsIE1TUiBmb3Ig
Z3Vlc3QuDQo+ID4gTWFrZSBndWVzdCBoYXZlIGFiaWxpdHkgdG8gY2hlY2sgdmlydHVhbCBNU1Ig
MHg1MDAwMDAwMC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFpoYW5nIENoZW4gPGNoZW4uemhh
bmdAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICAgYXJjaC94ODYva3ZtL3ZteC92bXguYyB8IDE1
ICsrKysrKysrKysrKysrKw0KPiA+ICAgYXJjaC94ODYva3ZtL3ZteC92bXguaCB8ICAxICsNCj4g
PiAgIGFyY2gveDg2L2t2bS94ODYuYyAgICAgfCAxNiArKysrKysrKysrKysrKystDQo+ID4gICAz
IGZpbGVzIGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vdm14L3ZteC5jIGIvYXJjaC94ODYva3ZtL3ZteC92
bXguYyBpbmRleA0KPiA+IDQwNzA2MWIzNjliNC4uNmVkNmI3NDNiZTBlIDEwMDY0NA0KPiA+IC0t
LSBhL2FyY2gveDg2L2t2bS92bXgvdm14LmMNCj4gPiArKysgYi9hcmNoL3g4Ni9rdm0vdm14L3Zt
eC5jDQo+ID4gQEAgLTIwMDEsNiArMjAwMSwxMiBAQCBzdGF0aWMgaW50IHZteF9nZXRfbXNyKHN0
cnVjdCBrdm1fdmNwdSAqdmNwdSwNCj4gc3RydWN0IG1zcl9kYXRhICptc3JfaW5mbykNCj4gPiAg
IAljYXNlIE1TUl9JQTMyX0RFQlVHQ1RMTVNSOg0KPiA+ICAgCQltc3JfaW5mby0+ZGF0YSA9IHZt
Y3NfcmVhZDY0KEdVRVNUX0lBMzJfREVCVUdDVEwpOw0KPiA+ICAgCQlicmVhazsNCj4gPiArCWNh
c2UgTVNSX1ZJUlRVQUxfRU5VTUVSQVRJT046DQo+ID4gKwkJaWYgKCFtc3JfaW5mby0+aG9zdF9p
bml0aWF0ZWQgJiYNCj4gPiArCQkgICAgISh2Y3B1LT5hcmNoLmFyY2hfY2FwYWJpbGl0aWVzICYN
Cj4gQVJDSF9DQVBfVklSVFVBTF9FTlVNKSkNCj4gPiArCQkJcmV0dXJuIDE7DQo+ID4gKwkJbXNy
X2luZm8tPmRhdGEgPSB2bXgtPm1zcl92aXJ0dWFsX2VudW1lcmF0aW9uOw0KPiA+ICsJCWJyZWFr
Ow0KPiA+ICAgCWRlZmF1bHQ6DQo+ID4gICAJZmluZF91cmV0X21zcjoNCj4gPiAgIAkJbXNyID0g
dm14X2ZpbmRfdXJldF9tc3Iodm14LCBtc3JfaW5mby0+aW5kZXgpOyBAQCAtMjM3NSw2DQo+ICsy
MzgxLDE1DQo+ID4gQEAgc3RhdGljIGludCB2bXhfc2V0X21zcihzdHJ1Y3Qga3ZtX3ZjcHUgKnZj
cHUsIHN0cnVjdCBtc3JfZGF0YQ0KPiAqbXNyX2luZm8pDQo+ID4gICAJCX0NCj4gPiAgIAkJcmV0
ID0ga3ZtX3NldF9tc3JfY29tbW9uKHZjcHUsIG1zcl9pbmZvKTsNCj4gPiAgIAkJYnJlYWs7DQo+
ID4gKwljYXNlIE1TUl9WSVJUVUFMX0VOVU1FUkFUSU9OOg0KPiA+ICsJCWlmIChtc3JfaW5mby0+
aG9zdF9pbml0aWF0ZWQgJiYNCj4gPiArCQkgICAgISh2Y3B1LT5hcmNoLmFyY2hfY2FwYWJpbGl0
aWVzICYNCj4gQVJDSF9DQVBfVklSVFVBTF9FTlVNKSkNCj4gPiArCQkJcmV0dXJuIDE7DQo+ID4g
KwkJaWYgKGRhdGEgJiB+VklSVF9FTlVNX01JVElHQVRJT05fQ1RSTF9TVVBQT1JUKQ0KPiA+ICsJ
CQlyZXR1cm4gMTsNCj4gPiArCQl2bXgtPm1zcl92aXJ0dWFsX2VudW1lcmF0aW9uID0gZGF0YSAm
DQo+ID4gKw0KPiAJVklSVF9FTlVNX01JVElHQVRJT05fQ1RSTF9TVVBQT1JUOw0KPiA+ICsJCWJy
ZWFrOw0KPiA+DQo+ID4gICAJZGVmYXVsdDoNCj4gPiAgIAlmaW5kX3VyZXRfbXNyOg0KPiA+IGRp
ZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vdm14L3ZteC5oIGIvYXJjaC94ODYva3ZtL3ZteC92bXgu
aCBpbmRleA0KPiA+IGM1YTQxYWUxNDIzNy4uZmM4NzNjZjQ1ZjcwIDEwMDY0NA0KPiA+IC0tLSBh
L2FyY2gveDg2L2t2bS92bXgvdm14LmgNCj4gPiArKysgYi9hcmNoL3g4Ni9rdm0vdm14L3ZteC5o
DQo+ID4gQEAgLTI5OCw2ICsyOTgsNyBAQCBzdHJ1Y3QgdmNwdV92bXggew0KPiA+ICAgCSAqIElB
MzJfU1BFQ19DVFJMX01TUi4NCj4gPiAgIAkgKi8NCj4gPiAgIAl1NjQJCSAgICAgIHNwZWNfY3Ry
bF9tYXNrOw0KPiA+ICsJdTY0CQkgICAgICBtc3JfdmlydHVhbF9lbnVtZXJhdGlvbjsNCj4gPiAg
IAl1MzIJCSAgICAgIG1zcl9pYTMyX3Vtd2FpdF9jb250cm9sOw0KPiA+DQo+ID4gICAJLyoNCj4g
PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL3g4Ni5jIGIvYXJjaC94ODYva3ZtL3g4Ni5jIGlu
ZGV4DQo+ID4gMjgzNWJkNzk2NjM5Li42YmUwYTNmMTI4MWYgMTAwNjQ0DQo+ID4gLS0tIGEvYXJj
aC94ODYva3ZtL3g4Ni5jDQo+ID4gKysrIGIvYXJjaC94ODYva3ZtL3g4Ni5jDQo+ID4gQEAgLTE1
MzIsNiArMTUzMiw4IEBAIHN0YXRpYyBjb25zdCB1MzIgZW11bGF0ZWRfbXNyc19hbGxbXSA9IHsN
Cj4gPiAgIAlNU1JfSUEzMl9WTVhfRVBUX1ZQSURfQ0FQLA0KPiA+ICAgCU1TUl9JQTMyX1ZNWF9W
TUZVTkMsDQo+ID4NCj4gPiArCU1TUl9WSVJUVUFMX0VOVU1FUkFUSU9OLA0KPiA+ICsNCj4gPiAg
IAlNU1JfSzdfSFdDUiwNCj4gPiAgIAlNU1JfS1ZNX1BPTExfQ09OVFJPTCwNCj4gPiAgIH07DQo+
ID4gQEAgLTE1NjcsNiArMTU2OSw3IEBAIHN0YXRpYyBjb25zdCB1MzIgbXNyX2Jhc2VkX2ZlYXR1
cmVzX2FsbFtdID0gew0KPiA+ICAgCU1TUl9JQTMyX1VDT0RFX1JFViwNCj4gPiAgIAlNU1JfSUEz
Ml9BUkNIX0NBUEFCSUxJVElFUywNCj4gPiAgIAlNU1JfSUEzMl9QRVJGX0NBUEFCSUxJVElFUywN
Cj4gPiArCU1TUl9WSVJUVUFMX0VOVU1FUkFUSU9OLA0KPiA+ICAgfTsNCj4gPg0KPiA+ICAgc3Rh
dGljIHUzMiBtc3JfYmFzZWRfZmVhdHVyZXNbQVJSQVlfU0laRShtc3JfYmFzZWRfZmVhdHVyZXNf
YWxsKV07DQo+ID4gQEAgLTE1ODgsNyArMTU5MSw4IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgbnVt
X21zcl9iYXNlZF9mZWF0dXJlczsNCj4gPiAgIAkgQVJDSF9DQVBfU0tJUF9WTUVOVFJZX0wxREZM
VVNIIHwgQVJDSF9DQVBfU1NCX05PIHwNCj4gQVJDSF9DQVBfTURTX05PIHwgXA0KPiA+ICAgCSBB
UkNIX0NBUF9QU0NIQU5HRV9NQ19OTyB8IEFSQ0hfQ0FQX1RTWF9DVFJMX01TUiB8DQo+IEFSQ0hf
Q0FQX1RBQV9OTyB8IFwNCj4gPiAgIAkgQVJDSF9DQVBfU0JEUl9TU0RQX05PIHwgQVJDSF9DQVBf
RkJTRFBfTk8gfA0KPiBBUkNIX0NBUF9QU0RQX05PIHwgXA0KPiA+IC0JIEFSQ0hfQ0FQX0ZCX0NM
RUFSIHwgQVJDSF9DQVBfUlJTQkEgfCBBUkNIX0NBUF9QQlJTQl9OTykNCj4gPiArCSBBUkNIX0NB
UF9GQl9DTEVBUiB8IEFSQ0hfQ0FQX1JSU0JBIHwgQVJDSF9DQVBfUEJSU0JfTk8gfA0KPiBcDQo+
ID4gKwkgQVJDSF9DQVBfVklSVFVBTF9FTlVNKQ0KPiA+DQo+ID4gICBzdGF0aWMgdTY0IGt2bV9n
ZXRfYXJjaF9jYXBhYmlsaXRpZXModm9pZCkNCj4gPiAgIHsNCj4gPiBAQCAtMTYwNyw2ICsxNjEx
LDEzIEBAIHN0YXRpYyB1NjQga3ZtX2dldF9hcmNoX2NhcGFiaWxpdGllcyh2b2lkKQ0KPiA+ICAg
CSAqLw0KPiA+ICAgCWRhdGEgfD0gQVJDSF9DQVBfUFNDSEFOR0VfTUNfTk87DQo+ID4NCj4gPiAr
CS8qDQo+ID4gKwkgKiBWaXJ0dWFsIE1TUnMgY2FuIGFsbG93IGd1ZXN0cyB0byBub3RpZnkgVk1N
IHdoZXRoZXIgb3Igbm90DQo+ID4gKwkgKiB0aGV5IGFyZSB1c2luZyBzcGVjaWZpYyBzb2Z0d2Fy
ZSBtaXRpZ2F0aW9uLCBhbGxvd2luZyBhIFZNTQ0KPiA+ICsJICogdG8gZW5hYmxlIHRoZXJlIGhh
cmR3YXJlIGNvbnRyb2wgb25seSB3aGVyZSBuZWNlc3NhcnkuDQo+ID4gKwkgKi8NCj4gPiArCWRh
dGEgfD0gQVJDSF9DQVBfVklSVFVBTF9FTlVNOw0KPiANCj4gDQo+IElNTywgdGhpcyBpczrCoCBk
YXRhICY9IEFSQ0hfQ0FQX1ZJUlRVQUxfRU5VTTsgYmVjYXVzZSBpdCByZXF1aXJlcw0KPiBwbGF0
Zm9ybSBzdXBwb3J0Lg0KDQpJbnRlbCBkZWZpbmVkIHRoZSB2aXJ0dWFsIE1TUnMgZm9yIHNvZnR3
YXJlIG1pdGlnYXRpb25zIGZvciBhbGwgcGxhdGZvcm1zLg0KS1ZNIHNob3VsZCBiZSB1bmNvbmRp
dGlvbmFsbHkgb3BlbmVkIGl0IGZvciB0aGUgc29mdHdhcmUgbWl0aWdhdGlvbiBpbiBtaWdyYXRp
b24gcG9vbHMuDQpGb3IgZXhhbXBsZSBtaWdyYXRpb24gZnJvbSB0aGUgb2xkIHBsYXRmb3JtIHRv
IHRoZSBuZXcgcGxhdGZvcm0uDQpQbGVhc2UgY2hlY2sgdGhlIFNvZnR3YXJlIE1pdGlnYXRpb25z
IGluIE1pZ3JhdGlvbiBQb29scyBzZWN0aW9uIGluIGRvY3VtZW50czoNCmh0dHBzOi8vd3d3Lmlu
dGVsLmNvbS9jb250ZW50L3d3dy91cy9lbi9kZXZlbG9wZXIvYXJ0aWNsZXMvdGVjaG5pY2FsL3Nv
ZnR3YXJlLXNlY3VyaXR5LWd1aWRhbmNlL3RlY2huaWNhbC1kb2N1bWVudGF0aW9uL2JyYW5jaC1o
aXN0b3J5LWluamVjdGlvbi5odG1sDQoNCj4gDQo+IA0KPiA+ICsNCj4gPiAgIAkvKg0KPiA+ICAg
CSAqIElmIHdlJ3JlIGRvaW5nIGNhY2hlIGZsdXNoZXMgKGVpdGhlciAiYWx3YXlzIiBvciAiY29u
ZCIpDQo+ID4gICAJICogd2Ugd2lsbCBkbyBvbmUgd2hlbmV2ZXIgdGhlIGd1ZXN0IGRvZXMgYSB2
bWxhdW5jaC92bXJlc3VtZS4NCj4gPiBAQCAtMTY1Nyw2ICsxNjY4LDkgQEAgc3RhdGljIGludCBr
dm1fZ2V0X21zcl9mZWF0dXJlKHN0cnVjdA0KPiBrdm1fbXNyX2VudHJ5ICptc3IpDQo+ID4gICAJ
Y2FzZSBNU1JfSUEzMl9VQ09ERV9SRVY6DQo+ID4gICAJCXJkbXNybF9zYWZlKG1zci0+aW5kZXgs
ICZtc3ItPmRhdGEpOw0KPiA+ICAgCQlicmVhazsNCj4gPiArCWNhc2UgTVNSX1ZJUlRVQUxfRU5V
TUVSQVRJT046DQo+ID4gKwkJbXNyLT5kYXRhID0gVklSVF9FTlVNX01JVElHQVRJT05fQ1RSTF9T
VVBQT1JUOw0KPiANCj4gDQo+IE5lZWQgdG8gY2hlY2sgYml0IDYzIG9mIGhvc3QgTVNSX0FSQ0hf
Q0FQQUJJTElUSUVTIGJlZm9yZSBleHBvc2UgdGhlDQo+IGZlYXR1cmUuDQoNClJlZmVyIHRvIHRo
ZSBhYm92ZSBjb21tZW50cy4NCg0KVGhhbmtzDQpDaGVuDQoNCj4gDQo+IA0KPiA+ICsJCWJyZWFr
Ow0KPiA+ICAgCWRlZmF1bHQ6DQo+ID4gICAJCXJldHVybiBzdGF0aWNfY2FsbChrdm1feDg2X2dl
dF9tc3JfZmVhdHVyZSkobXNyKTsNCj4gPiAgIAl9DQo=
