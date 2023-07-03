Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D087E745A08
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjGCKTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjGCKTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:19:20 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9A39B;
        Mon,  3 Jul 2023 03:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688379557; x=1719915557;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Oid1n2+Yro+N8jsQcq2AIRAnye55cTS1FGMlMSYutJM=;
  b=hsIirpGQhSOvZrD3V6Q6FqfrC9QEoPi53qxRsVc10XQLgEuBG0fj1Mg/
   oNTDHuM1rdpdVlH2m5TG8aSkEXCUU/3XI64AVsBv/whbPdzsb4ztfD053
   59GdHStcXaDUMGzhYZwEbEycTlIT6YsHotix2Z15g15/tPaHgMF/k8379
   yVRtD38LPugUtO5Iv1dmK7946MoEagGhGZtr1KfvmeI/Ls1QrdgyNz+F2
   JZoPbCtvlm+xlvDd2Ggy09YmEExASBTG2sV1sTUlTq3Uv0ZnoYHvt/URz
   19rSrbdXXvn2jqQW2TnLVuhrfeXoObWlcsi8TbipdxvCsuiM4slk8drI3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="362883237"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="362883237"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 03:19:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="783854644"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="783854644"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 03 Jul 2023 03:19:16 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 03:19:15 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 03:19:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 03:19:15 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 03:19:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6An/knoRmRUlclE9F7nLuW1eQz4edfce9Iqh9egR2p5J2Q2gSxgCgxwb+9uX5r35dpz33XBSHwLwmgBRgiuwG4vG4ccTSCeO3yo0s6+MAfwSwZBUaOfoMzxEfylZGuar1T12cAzlnxNkv6l2VlgcOv9mteFg8fzsEJ7B7K91H9CP3XUDKlvjO0L4OjfgcCbtex462PxdQvhSdu2lN1pcQMCykOXDOeTEyNP9vZq0kV6RX1dcW1jB4qUyUoLoecQyDNPhNrDEb6+7O0uaP01f3mQUDYOVb+SNPP+sXngSa5a7kE9kYrBu2PZDBTDhi6zLLOwXBHZbT/iIzwx3Q7bQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oid1n2+Yro+N8jsQcq2AIRAnye55cTS1FGMlMSYutJM=;
 b=BPBbJskPtX4q6rDakHJf0cXrsGif/nqe6WW7a9LCY606GEhdF4CXuekPfl3Mv4BLgHJ6znI9OaWu6HHi1mGTBEHRxmVqd8Szv9E4qYFYT5PadBY5huE9Lz4/9Iniw1wakGSkX7skGLcvfKd60pvFWhc4lmVC8ouBC/9NnEwNWqomwIPYyTl4ViB6rhkCY5/kM4G2eWksagsYjL+YRD55ZhUzVYvbWfVQSqDxEcJsUPa/GiH7dpBnQzeurdzC0M95YVPVO84ycMWGUSWuFVS6dtgC0UuNxEhivJ+mlEXORoNz6Gq7OhZNw845EMp8KQDU5U0OR+xlp74WlXu6XpTs4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5673.namprd11.prod.outlook.com (2603:10b6:510:d6::7)
 by CY8PR11MB7339.namprd11.prod.outlook.com (2603:10b6:930:9f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 10:19:13 +0000
Received: from PH0PR11MB5673.namprd11.prod.outlook.com
 ([fe80::d756:c8e9:5904:d049]) by PH0PR11MB5673.namprd11.prod.outlook.com
 ([fe80::d756:c8e9:5904:d049%4]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 10:19:13 +0000
From:   "Lee, Kah Jing" <kah.jing.lee@intel.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>,
        Conor Dooley <Conor.Dooley@microchip.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        "Dinh Nguyen" <dinguyen@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Will Deacon" <will@kernel.org>
Subject: RE: [v4] arm64: dts: agilex/stratix10: Updated QSPI Flash layout for
 UBIFS
Thread-Topic: [v4] arm64: dts: agilex/stratix10: Updated QSPI Flash layout for
 UBIFS
Thread-Index: AQHZrZDPLTtHQ8CKs0K7r0z/bt/LMa+n06aA
Date:   Mon, 3 Jul 2023 10:19:13 +0000
Message-ID: <PH0PR11MB5673918AB1E9A01FE229ECB4CB29A@PH0PR11MB5673.namprd11.prod.outlook.com>
References: <20230703083626.1347969-1-kah.jing.lee@intel.com>
 <59da2f49-706f-0a08-df14-71ad0326da83@web.de>
 <a786b6b9-3923-0138-5738-dc20e14aa0f3@microchip.com>
 <b155011c-5e77-3e53-336c-53ad7d926f71@web.de>
In-Reply-To: <b155011c-5e77-3e53-336c-53ad7d926f71@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5673:EE_|CY8PR11MB7339:EE_
x-ms-office365-filtering-correlation-id: 0fe75886-24c7-45d7-2125-08db7baef2fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YNE+pF+7QjVYpQQHaEHPUBdGDr19bcl/MvoHOlFu46E6GkmEG3CsocZfFDUEMGCzBUTUiaxpGsAap8/pRUGmAvxlTH51DtfEv+vgaZtdzB5+/I4P7KJ4rSUUI9BzHrZLtsc0ig8XSRW0E7NIfIvRIDOvsoNT6W0PiEf3gdBQBHGR+xtg0hUcn1JcNF1TVm5JfgFpQ3NBudFCbm9ptOp6luaZPlkJ32vFZMPiDOROv4QMkflrFIZ/Oe+PsfvPibpXTwXXVNe33q8abNp+rgp87PgzWaTBZVLZuBJkFDngSY48twUCKUsQc+0IYOlhnIAbSftKzvkZ2mM/9YD54uIjRgAeWBHVtMT8fd6UUVhlc9+BS3Z3mQ/fszSPuSrRrnLPo/UTUIn1I459vXrI9z87EYfeTDH7qLSyFuZeg3/rx+qabHTptz4vio9tuyB3/yqtfz32sQ14HrwXp9feYPY/EtInp2uDJtfD4bhW1znDUH951P5FdmxMw21oHVRCZVmZw3l4Ru60q226pD+EyHlK9HvVaeDsMVRK3FZDoqKeS36qIuftPSTtRNOqchehDr58lZYSFXuF60Igd4XkBxcn9LDZXDyQToVseQL+pPTG2Z34xeC6K2i0S09BonULoPdX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199021)(38100700002)(71200400001)(33656002)(2906002)(4744005)(7696005)(8936002)(38070700005)(110136005)(54906003)(8676002)(55016003)(41300700001)(52536014)(7416002)(5660300002)(478600001)(76116006)(9686003)(66946007)(66556008)(66476007)(64756008)(66446008)(26005)(6506007)(86362001)(186003)(4326008)(316002)(966005)(122000001)(82960400001)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RithZlpKbVY3NGpiWVJiUkNVZ21GUGk3bFNRU0M0N3ZiSU5OeEFHTCtnaGVj?=
 =?utf-8?B?UlB1dVo4alVEa2dKbU1nV2RMSUxoMmtmTmI2NlRtaVEwejNxcGRMcWdTWjdq?=
 =?utf-8?B?ZDd0NkgvY1VSbHF2dEc2NWJIc0lwQU9oVWNpOXlJcHUwczk0TjEwY05zMlBt?=
 =?utf-8?B?amlzelJvMlFKYXFTdGd3QUwyQWVzbkd5QWJIQUg0N1JDd1FLWTlwbXhXekdr?=
 =?utf-8?B?Z1l6S3BvOGwreTByY1UvRHgyRzVDV0h6cTcvbnRrZUt1SWhXZW1QTmFkalBX?=
 =?utf-8?B?M25iK1lHQnNONjVHMTVzTnQxVU95cFdmbjlNYjdmNjY0NVdEVDZLOTlEK3lM?=
 =?utf-8?B?MVFLaDJ5UmpKVlpTcmttQWh4RU5WRjJWQ2wxeWpuaFNTajRXTXdad2hRZlhW?=
 =?utf-8?B?bmovOXJYSWZMWnhOeGZQRVhJMGkxMmlrTlh2RTZKd05odFZtalFtZkZjdEh1?=
 =?utf-8?B?TW4ySlQ1R096MUwwUXI1RVg1MllmelE3bU1HTW1oSmxEWFhsRUZKdk55bits?=
 =?utf-8?B?MEpicXpQaXJKaWJaK001dittZHQzWG5YTThGc1NucDZvZ3pZQUpoVEQzNVhN?=
 =?utf-8?B?QVVkdnpqa3c5bm95U1NWZmh0ZkdvL3U2Smw1WE1GZUpGeHpIT0hkWmp4Tklu?=
 =?utf-8?B?TjhJZzc1RWdWa3hKelB5SW1neXNZczF3WVA0dXhLUHowdHRWNXI1VkdxMnFu?=
 =?utf-8?B?MDFmNFJ6MnpiVlV4L3g1UkdwenNIaXVjU1NKN3R5MEg0YlcxSC96SDRVV3gz?=
 =?utf-8?B?c1MvZUVndzg2TWZlc1VsL3dKNUxWaVErTllOYWZkTUtnNTZCZnhHQ0g2L04y?=
 =?utf-8?B?Q0Nib0FVRTJhVVBPN3ZESnVYeDN6QlgwQk5vdlN2S0g4YWhyZ3Z4Q2xaSTN6?=
 =?utf-8?B?a1NmOTIvVklwemlWbnJyb1JxL1dhNlVLZVJnNENiSHpqam5aMEtsaExaK3VY?=
 =?utf-8?B?Qk1LbGNLcHlTTHhqZzJ2cGZ2UTR3Z0o2QzI1Y29TcHNML1piVkpyTTVZYWNI?=
 =?utf-8?B?WGVLSDQ1M1RVL2VROEhCOTF5eVV1Qjd0UmZRa0hwaWtLalJzamhjZnFHbWh2?=
 =?utf-8?B?bzZLMEtEZGRkOUFzT3BZWDlMMVdCdXE5REk2enlDWlkxK2ZTK3VZejFjUWhp?=
 =?utf-8?B?YlpzNVIvSFZkUUtBeEhNSnJWSjc1VzNtcklHMk9WNWkrbGU0VDV6N1F3VnlV?=
 =?utf-8?B?ejVsQ0ROeFZRVm1Rd2FGcUZicjVESDBxU2FIdU1KTHdJK2pFdjZKZXR2UDZk?=
 =?utf-8?B?VktHRWNmUmNGUWpKR0RTOTJJOUVjMG1WbXU1dkdXb3d1MGhTZGFsZExpZWpH?=
 =?utf-8?B?UWF1bGEwMEFUamxrZzJwS1BwaUljZ3JLVkVlK2UyditzUHdaamtjeWdtY0Mz?=
 =?utf-8?B?UXV6Z0hydlI2dFlSRGlkbmY0WDRpWnFWVlE0Q3pLSFdnRVFWb3hFMEt4SUFh?=
 =?utf-8?B?K2tLVUdvNHQ2UkpQTEl2UGRUa1gwZ08vc1ZHUllHS3krMGV2YVJWZXA5SFl6?=
 =?utf-8?B?Q3pIQlVoNlZuOFVaTXBESUY2aytlWDJaLzFzaVF5UExGTHNyaUJFY0hNZml4?=
 =?utf-8?B?Y0dPcDBjbTgxa2c5TUQ3bjYxV0dhc0lYczJZci9QcjA1a291VmpjZ2lXUWhU?=
 =?utf-8?B?L2UwU1h1RzRwaDVTSUF4LzNyZ2dhQXdudkMweWRwdzF4WmxyN1Jnc0FXZmMw?=
 =?utf-8?B?WlhwWnc0cm1kS0ZYbjdra05VMmhNRDhNS0JITmNqaXR2NncyOS9LNlVHQk50?=
 =?utf-8?B?enRFWTg4b09wVTlnN1F5TWJXaFlKYml4eDJqYUs0bXBuU0w4UG9HV2I2ODBY?=
 =?utf-8?B?MkVXRGhPVVYrZUZQMGJYc0FBcXpKaXFhQWdiUkZSSzVxdU1hMEUzVDBua3pL?=
 =?utf-8?B?dTNyblVtRDhBTWp4ZWZza0N5MDg4QVpTc2oxK1lXZUJ5STNvREUvQitFS3JV?=
 =?utf-8?B?eXpOdmJEMVc0Zjl4VnBHV0VFRW83Ri9vQk5rN1hOMk0wbzFLNHpPUHlBdVJL?=
 =?utf-8?B?ZlIyamNLYnBHdThhemJGTTkxRnkwZEVhRFk3K2NMeTVSVHpPYTY2WGNadXlp?=
 =?utf-8?B?eG5mNmdncGg4TlR6VFZBTzdXdkJIc1duWG5FNEZhWG14TzZlK29EV0VvU0tM?=
 =?utf-8?Q?tXVvRvOxUFHEULCFQmMiIV/H4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe75886-24c7-45d7-2125-08db7baef2fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 10:19:13.3742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aiGtvh5kLDqBUmwkwyVQ/URapwPOjZLQFTcWh13M0Y+F6oS/ZbZWfeV1ywwQFUSk6YzCXVGwhANHfbLUPW0apQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7339
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+PiAqIFdvdWxkIGFuIG90aGVyIGxpc3Rpbmcgc3R5bGUgYmVjb21lIG5pY2VyIGZvciB0aGUg
4oCccGF0Y2ggY2hhbmdlbG9n4oCdPw0KPiA+DQo+ID4gVGhpcyBpcyBhIGNvbXBsZXRlIHdhc3Rl
IG9mIGNvbnRyaWJ1dG9yIHRpbWUuDQo+IA0KPiBJIHdvdWxkIGxpa2UgdG8gcG9pbnQgZnVydGhl
ciBwb3NzaWJpbGl0aWVzIG91dCBvbmNlIG1vcmUuDQo+IA0KPiBUaGUgYXJyb3cgbm90YXRpb24g
aXMgYWxzbyBkZW1vbnN0cmF0ZWQgaW4gdGhlIExpbnV4IGRldmVsb3BtZW50DQo+IGRvY3VtZW50
YXRpb24uDQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL0RvY3UNCj4gbWVudGF0aW9uL3Byb2Nlc3Mvc3VibWl0
dGluZy1wYXRjaGVzLnJzdD9oPXY2LjQjbjY5OA0KPiANCj4gVmFyaW91cyBwYXRjaGVzIHNob3cg
dGhhdCBtb3JlIHN1Y2NpbmN0IHZlcnNpb24gaWRlbnRpZmllcnMgYXJlIGFsc28gYWNjZXB0ZWQu
DQo+IElmIGEgYml0IG9mIGR1cGxpY2F0ZSBkYXRhIGNhbiBiZSBhdm9pZGVkIGluIHRoZSB2ZXJz
aW9uIGhpc3RvcnksIHRoZQ0KPiBtYWludGVuYW5jZSBvZiBjb3JyZXNwb25kaW5nIHZlcnNpb24g
ZGVzY3JpcHRpb25zIGNhbiBiZSBpbXByb3ZlZA0KPiBhY2NvcmRpbmdseS4NCkhpIE1hcmt1cywg
DQpEbyB5b3Ugc3VnZ2VzdCB0byB1c2UgZm9sbG93aW5nPyANCkNoYW5nZWxvZzoNClYyOiBDaGFu
Z2VzIGluIHYyIHh4eA0KVjE6IENoYW5nZXMgaW4gdjEgeHh4DQoNCkEgYml0IGxvc3Qgb24gdGhl
IHN1Z2dlc3Rpb24gaGVyZS4gDQo+IA0KPiBSZWdhcmRzLA0KPiBNYXJrdXMNCg==
