Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7225FAB6D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 05:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiJKDva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 23:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJKDvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 23:51:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8A3E027
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 20:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665460284; x=1696996284;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kGRvn3sR8reUXn3EHUmsaAX5fn/O5GTS0MgbhFzsUt8=;
  b=JZ0Qa7UL7FlWRdBkWLemYPlRDPHmx0k6gSZvDgycBq3ZRwQo4f5GOBsr
   65c/OX6SUYge7iEUge7BVe5pUekm0KVIuYMdJQgn6/RqxFdcEj8XqLoAa
   E2qV6EnC1u0PnuB5NDU7oh3kfhyZDbeFie91mg7medZPafyF6UfZweSoo
   KIczStMbCFDlVKuBw4njHeHYrsWmfYaKZ9GmIcME4xOilKxBRZSrCxje4
   wsURUo8b00LJaMIuLSTYXd/x8ZBYM7svNlngK6p8vGDBkQhbieNTTefgF
   V1vswPdawEd0o33wc9bhxDilTosrhG7GAoMm4qy1DXgu2OfaSk88UvDJp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="302009313"
X-IronPort-AV: E=Sophos;i="5.95,175,1661842800"; 
   d="scan'208";a="302009313"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 20:51:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="628535357"
X-IronPort-AV: E=Sophos;i="5.95,175,1661842800"; 
   d="scan'208";a="628535357"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 10 Oct 2022 20:51:23 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 20:51:23 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 20:51:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 10 Oct 2022 20:51:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 10 Oct 2022 20:51:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+mxqq+ZprVg/wjmc2fIe04B+ewn0p0s54ibw5RO6+ONvxzFUX+S1vx1hb/UaHay7ZJsW9e3baJ0Sh+PLTm5HQlce+gisAZ94jBwIa0gxx/yRcDhuvbkT9/toJbrFS3GYQimOZ5npBWe9HYyN1Y4HAxKwdXlxMNAWVZNdQuHTXHkbXkFVtJRuI2md2+y1+YAgbWxKFNQeDVBA+vJq0Ag2tB9tFqzB7rY0mU2+U/LrCQz6SbeT8kin456O9d2cpw9zOFpYmglJDghRtmasqZEMLRxNZSEz6XU0DE1hbh0hxQHn+zlu9ZzQ9OJGtQ5r8Zq93QQNoDL8w6yOQMek6ymQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGRvn3sR8reUXn3EHUmsaAX5fn/O5GTS0MgbhFzsUt8=;
 b=OlWFTZF5Nr1zfIe5T+sTAImOrM3UhNV8vcIlxi+a1IkEBLqbAy1eQOa9QU7ECev1frJoq5gc7wdTOJLTDzC2wDP4ZsAdEnGbK5MAxRqXFJOL3ZoBS6MxjJIC77q1/kIDuyIGyeW7VbpK5U/APvVVmo9zHfMXccXRTktsn7SBz8xwCBVkTutXzEk59g8JmGXPKR8DwoQ9gm3bsdkLZBHxxOa0B7rmM95WDp7z+o23AuVwWNCsfY3UEJJ7fK5C+SnsBe1MKBVXt2Uel2m5LTsVzrwCfipdlK6RuEN+K5v22RQtklhRxn5XJAu8ojA37E4/5j8RX3n6/BruPjOtgtqA0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 (2603:10b6:405:52::15) by PH0PR11MB4807.namprd11.prod.outlook.com
 (2603:10b6:510:3a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 03:51:21 +0000
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5]) by BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5%12]) with mapi id 15.20.5709.019; Tue, 11 Oct
 2022 03:51:21 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>
Subject: RE: [PATCH v2 0/6] Enable LKGS instruction
Thread-Topic: [PATCH v2 0/6] Enable LKGS instruction
Thread-Index: AQHY3OEhLA4PY0jm2EuV/fvQtOq+v64IX7IAgAAvIJA=
Date:   Tue, 11 Oct 2022 03:51:20 +0000
Message-ID: <BN6PR1101MB2161BB1E7BD9476DDB525530A8239@BN6PR1101MB2161.namprd11.prod.outlook.com>
References: <20221010190159.11920-1-xin3.li@intel.com>
 <4714a248-d80e-61fb-15a7-62ab247d2fe7@zytor.com>
In-Reply-To: <4714a248-d80e-61fb-15a7-62ab247d2fe7@zytor.com>
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
x-ms-traffictypediagnostic: BN6PR1101MB2161:EE_|PH0PR11MB4807:EE_
x-ms-office365-filtering-correlation-id: d36a2e7c-f720-45e4-7c06-08daab3bdc1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PBi90ZyT+BsfufjeMyFKkgnQBsshCTiTlmvsrtCmHhREweFppJOA36XEiahNB8pd03/3veqNmr0ikIJScwcbbFluG/fR14BWflpVbmCU8i/WyhISyuvwKMclZEPj9YlH4qv6QFhXro0J6xUzgaxEoPVr3NEbray2RE7zGdnWjoxQ/pYj+SD3EYN6VEC8LY7lq+h/ZbDoSXWMr7u4zIwVLhVW6J1Nny2XPoRxfoogzqBNZs5zLzMDQCjHYpRhFZJwemsNITM5zJRiPu+qvCCpVGmWgB1jVer012hAQu5tStBPIkHpNzyY3Hnf4ykzK5Nwa+l/j1ZHETnm6/2+cl9KT9K+K0elw491RgjWXGgCCNOMyyYfe9FpnTFtiJXJK2CRGkCBqjQQTyjP/T6ZAZhmdKJf3SPi7ciSrHiz+HW4x68d0QzFtixnbfdltIyg3Iv9bXHSxg4ww0ZdJvPLW199AcuxQE3NykfLmOvbKO178NWkBG3+VvxNXRn6DTJDeXxIrBuLdt71TMUxc687utr1PUyR/LUGrhME0NcHq+sq9IKXTLbbcTjoHT+w3qOnao0SoXh8jEmt+i18hQAN3cGVmNATYONGl3k43xNdO+oevWAgP0BJj/JnWS2t68voLk/OaCLpfu+P100KKaw6DICHgOSbu3D1FBdDn5MnyxP1J+09Te4Pz9mrz0k46Bpev7K1DGHocq5P8Jfp2suBwUtHq6KFoww4MveLjBkq3vqEau2pvGJ+uSMxfkZ6QjZt7UTsA1kElQhSOQBSeuhycrVYcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1101MB2161.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199015)(9686003)(38070700005)(54906003)(110136005)(316002)(82960400001)(55016003)(478600001)(71200400001)(122000001)(38100700002)(33656002)(86362001)(66476007)(186003)(6506007)(26005)(7696005)(4326008)(8676002)(64756008)(66446008)(8936002)(66556008)(52536014)(5660300002)(4744005)(2906002)(66946007)(41300700001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2hqMEk4RmtiSUdSTVBEeVQzU0FaeTBIRG1zNlltbENmNzlwekhXNEcwTlRx?=
 =?utf-8?B?bWhQOTVFZGZzZjdOK2h1UVZoU0tTSG8wWmdQVWtpcVFab3BYV0M2WG80K3Iv?=
 =?utf-8?B?U3NaRFdGWXRYWjU0SExzMW85aXd2NWhIVVp4ZUU3bHJVMGF2aGxsNHNvckZW?=
 =?utf-8?B?VnJQR2pLazA3RGlFR1NzeW16dlY5YkRORjdtVGZvWHVaSGxFSC9jY21GaTFN?=
 =?utf-8?B?V0ErMzV6aDhSVS9kL3lseWlYd2pnTHYvZjY5c1pqdDFrQlRWMmE5b3JZY09t?=
 =?utf-8?B?d0wwQ2ZleEhqQzVjVTk1KyswTlN2TGVzTmM3WktkZ0IyUTFWdDNqMVRDZWtp?=
 =?utf-8?B?dUxDaVNxT045VDA4S1JpbFY0aGloVE1zeUtROUZEQlFReDZyMGhLc0dPeldk?=
 =?utf-8?B?bVlSTko0VlExb21kSWJ5SlpSRGhBZ0tHd0RiSDUyWHVIU2s5eEphSTk2THZ3?=
 =?utf-8?B?eVJVZkxtSXRTdHdOYUEraWlSTjl4Mkt2TGpsOE1OLzdTdCtTMDVPRUFGakNn?=
 =?utf-8?B?ZlUzSEVxdmN5OWM2WlI1S1FjZWphdDlzWDdrM3hwTVMvR3hKTlUrcFM5cnk1?=
 =?utf-8?B?TG5IYUhJaE9TYStrYVc4ZVY5WGwrWEVOZHVRbnZsV2dCNUVoaVVJZHllbTZW?=
 =?utf-8?B?MjdLckxqM1FuekpVbkpEQ2ZzOGZPYWZMdjd5TkkxQkxmZ1BadHVHQy9TWHVE?=
 =?utf-8?B?a0xiczh0T3RJMmhwa2xBL2ovYlNBUTlheXZySGc2TVVReHpYYTB2Yk1PU3FY?=
 =?utf-8?B?V3J6eXVnQlFEaGttRVFVZm1HZ1I1NjJtU1V1Q0ZYY2JjdEc1d0h5c2o4RWc1?=
 =?utf-8?B?bUltaktKRHBJaGhTdkNBVUpSUWhabkdTNHlSTHllNThmb1FOQWxiZzhyYzdE?=
 =?utf-8?B?WFphb2trUEx4SW5Lb01qZ2t0dlNqS21sd0h1eGRRTktLVzJLOStUZ0FqVnlz?=
 =?utf-8?B?ZFh1bUFPVCtUSVE0QjNzZVRVcW5EdENZcW51eXh1MmRuazBuYUZmaFpTd1Jo?=
 =?utf-8?B?dXp1cm94b3JORzk0TEJVWVVlK2FaekdsQzI3S2p6M3hQbUxVVFVyR0UwWmxm?=
 =?utf-8?B?YmtrRmYybTcrdTRzd0tjZTlJMmpQWXpSYUNDWkhJTERld2lqYXQzcmw4bDlI?=
 =?utf-8?B?Z1ZmQjNqK0w0ZmtVelgvdm5FN0dqMW51SWZjd01EOW9SVWdZK0RkdkZlcnZZ?=
 =?utf-8?B?cmdPUDhEeGVmY2VxcDc3enBHdm5ndzhyeHFKWU90NmNyUE9POGdneTBZUDIw?=
 =?utf-8?B?eWlSaUlEc2JaZkJmLy8yNlQvdWZteTZ4a3NHODFVRTRKWFh2dGtrNU9iN29k?=
 =?utf-8?B?aDE4NUVpMnVad1c5eS9iTlMxRE8vT1JlRWhCMHk1cURKNWVkUmI4VGJ1VnBZ?=
 =?utf-8?B?WTZUdlFPVHQ3Z1RSMThEZjJPeUR1cDZpV1BoYUxzNE5LbmxaSWtHWVk5dEVV?=
 =?utf-8?B?QkJRNkRrZXlQSEtzWTBYalYybWw0bjk1QnhjY0xud2lPY25hVlNPNjFXeGJr?=
 =?utf-8?B?U0U5ZS8yQ3FaUGl3MkgxWWlMckg2ci8ydnp2b29Gb2hyWXdsQjBqZmJIZGRY?=
 =?utf-8?B?Qnp0Tyt1R0VKOXRGemZoUkROU3RJN0FsUFQ0YVZjUGtDNmxFOVNCdGxvcnRw?=
 =?utf-8?B?ZmtxOGdVTmt3TGZQeE9ZM0hFN0tiaGZEZlVGbXRhVE9HVndOR2tCVFZDbU9Q?=
 =?utf-8?B?TGpEVUdRYXJEd1FwWUtTNXFtQllWdjJGTUp5aDkxd1BKK2RoNVA3V2kwL1Zv?=
 =?utf-8?B?WjAxdHZVaXdrZnZ6ZTdnemNBVEVabzJPTjhOMHFvNlBXYXVVVitxbWJCK2pz?=
 =?utf-8?B?UXFtZStBUHhlQm1KMU9Rc1pZQlJWc2FZdm9MQlVqTEsvUlR3aW05K1lidkND?=
 =?utf-8?B?SVB1N2hUNTRPMUZYaVFHamFvbWd5SHl6anVuaEpjNVNsK0d1SnJRblkzWC9I?=
 =?utf-8?B?OXlEb0dyTGRIbnI5OW1JMDRSQ3FGNGEyZWFvUlhLaG5zRjE5RDVGSTZvWUNt?=
 =?utf-8?B?S2lJTkNaOStxb0ZoUEFDSisyZ01LdDdndnJRelprS3g5TnpVWnZFUE5PTWdm?=
 =?utf-8?B?aStoYW1jM0FHVlI5NzlpWVhwYnhkNjRkdUdvZDBKaGpQY3hDQkRaNEZPTDFG?=
 =?utf-8?Q?ddAM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1101MB2161.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d36a2e7c-f720-45e4-7c06-08daab3bdc1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 03:51:21.0177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YEThgzcmjgTpcKVHZpBY9INb3cwNX3LwaqjGNgqc4vUdnwIM401w2tUcJ/9xFtOx2BY4td5uQnjWWRccshUeLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4807
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICogcGxhY2UgZml4dXAgY29kZSBpbnRvIGNvZGUgc2VjdGlvbiAiX19leF90YWJsZSIgaW5z
dGVhZCBvZiB0aGUgb2Jzb2xldGVkDQo+ID4gICAgImZpeHVwIiBzZWN0aW9uLg0KPiA+DQo+IA0K
PiBDb3JyZWN0aW9uOiBfX2V4X3RhYmxlIGlzIE5PVCBhIGNvZGUgc2VjdGlvbiAoc2NhcmVkIG1l
IHRoZXJlIGZvciBhIHNlY29uZC4uLikuDQoNClJpZ2h0LCBteSBiYWQuDQoNCj4gV2l0aCB0aGUg
bmV3IGZpeHVwIGhhbmRsaW5nIGNvZGUgRVhfVFlQRV9aRVJPX1JFRyB0YWtlcyBjYXJlIG9mIGFs
bCB0aGUNCj4gd29yaywgYW5kIHRoZXJlIHNpbXBseSBpcyBubyBuZWVkIGZvciBhbnkgZml4dXAg
Y29kZSBhdCBhbGwgKHRoZSBleGNlcHRpb24gZml4dXANCj4gaXMgZnVsbHkgZGF0YS1kcml2ZW4u
KQ0KPiANCj4gU28gSSB3b3VsZCBzYXkgInVzZSBFWF9UWVBFX1pFUk9fUkVHIGluc3RlYWQgb2Yg
Zml4dXAgY29kZSBpbiB0aGUgb2Jzb2xldGUNCj4gLmZpeHVwIGNvZGUgc2VjdGlvbi4iDQo+IA0K
PiAJLWhwYQ0K
