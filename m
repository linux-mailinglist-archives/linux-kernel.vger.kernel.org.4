Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F8470BC04
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjEVLkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbjEVLjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:39:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E81FA1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684755585; x=1716291585;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=h0+v+rSUWwPYqok0owXdVe66EqbHm0RYkOXcV/Qja3Y=;
  b=nSwSXJ7RNsnrqf5N6+60lpmV1APrR2ghzVBHy2pCK1fSFXxxwXeQx+5B
   gpNlXYpjSAPRu2r4Q1zqngoGyaNuRsy220HBZwxlLPI4i9gRegWUdhVgE
   WutsE10SMeCORL8IzHdq2xTLZVqVFUqGNNVZuKBYA2y2uBbanMZ/dB4x0
   OEr4Fbp8wzAVwPZAewv7ADu0aLmyLwwVenKHuyEpfF776W8TKREgZfHpd
   y01Ru0AsasPf1LkbVlcQL4Fr2nYf2OKDyK5/E12aqIHe/MGx9WELfeUNr
   4fssWfth/Qoxc8CK9vT7RcUoIsjVQ9XwIwN94Lfme8MP7h8QurcJ6fx0h
   g==;
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="214308550"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 May 2023 04:39:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 22 May 2023 04:39:44 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 22 May 2023 04:39:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1bXIpXxq5pegNGZFslYGhhOzXruCkEkaKFlivqqMYhB45dvPzpOjV2gaYbtaHUk70FC4bUffe6PtBsbNXVdDWHpScHEF9E9xNRFZVYmBbPmrwDO4eLohoF/y3itK+50dR1FbKri+eDrNmvu9kERqjxgBCbXWF1mqFRGqNLXvSf8Y+MlFjElBetOZlhAecJ8icm/y2Fq0Uxh3SXOEk9tG3mZPVCydXYe5+Me+f/4PO+F5rg46HV2b40vvZh8u2/VUz2dnzii+nVElJZRU2nOpImkTmpeRWXfJo+ufa2PvBsDhIE9Xj/mctuqOX318IWy0zbuLRwpF/E6JxMJsGxQYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0+v+rSUWwPYqok0owXdVe66EqbHm0RYkOXcV/Qja3Y=;
 b=bVbxsdfUKW9RkdHwDUhAzQboYVLQLL5SogOkZBVF4nit1e9n7QztGRI+kdfRYUDxMOYNQx2YGK4ALt3IfRZzLjwPgDKjBI3y85Ku3XZ1swJgoKKOy4NtjVQOATRvzDXSZRZzO2n4+65R8Oui1ppP1yMdxgVXmFBNSrJRu1+HKv8i12ZENMZCffn3/Mb7M6QtXDzBfl13v6b9GhMuVEUqcZW06UsswoTwLHSoqxbd5KrmdbDswoJe8hjsZ0KqL/aHJgU9prLK9WxS1SK9UTYYWkw2tIyNZW9+FUHTrTLqgmFuMiNeS4emXNG8+HePK53bHUfU4lt+ctDlHkin2ZGwxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0+v+rSUWwPYqok0owXdVe66EqbHm0RYkOXcV/Qja3Y=;
 b=Bkkv4YKfbH2g6toJGra0/tvxt4haHrv2SKEPsHXPRtjbukh6j4pxz2+K4g65ZSSyxOlvX7AwJqWTeUAFonnKV4KBeK4oJtyPr3bl4dsx5gTLF0tFACcsXFGvjlc7CneL2b4gSLC4OKZzvG3sZxTrN6JvYHIJ0pplIVKPa4o8vqo=
Received: from DM4PR11MB5358.namprd11.prod.outlook.com (2603:10b6:5:395::7) by
 CY8PR11MB6891.namprd11.prod.outlook.com (2603:10b6:930:5c::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28; Mon, 22 May 2023 11:39:42 +0000
Received: from DM4PR11MB5358.namprd11.prod.outlook.com
 ([fe80::4dbd:f6a5:4642:f17f]) by DM4PR11MB5358.namprd11.prod.outlook.com
 ([fe80::4dbd:f6a5:4642:f17f%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 11:39:42 +0000
From:   <Steen.Hegelund@microchip.com>
To:     <Conor.Dooley@microchip.com>, <soc@kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <Lars.Povlsen@microchip.com>,
        <conor@kernel.org>, <Claudiu.Beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Daniel.Machon@microchip.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v2] MAINTAINERS: update arm64 Microchip entries
Thread-Topic: [PATCH v2] MAINTAINERS: update arm64 Microchip entries
Thread-Index: AQHZjJEbPhoBuvEVk0SJt+9VBU9Xta9mKw+A
Date:   Mon, 22 May 2023 11:39:41 +0000
Message-ID: <e95873e2b110c42f8ac93c94a6570e2a45db0adb.camel@microchip.com>
References: <20230522-wagon-stencil-a164ec39322a@wendy>
In-Reply-To: <20230522-wagon-stencil-a164ec39322a@wendy>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5358:EE_|CY8PR11MB6891:EE_
x-ms-office365-filtering-correlation-id: 8327b9b4-e04d-4485-909c-08db5ab93baf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hKW/najj0+iU52+gUrxDonPCFHkv0E+EOYlA57ngUn6u2UZJBc69mvF7H8z+UdL3hWXTnpvG0H7N9UhVqwc3BMeD10plftKCS/k0vyGOEvO2VV2m+YUv8jsN1M0evUAjR8cU7enqOxOdFeMmhCc409/2jmYkDXOVC6Gv+pUatNSlXE7boy56i+Sw2Lf1aR174eeIk9m0+paGaAqm3jGyDdN0X4qZCV9SZoS5f2b1XwfEQY9WiboSSXeog2WsRuYTHosXvu9Iq5DnbOQAcjMVYYZu/ZtGKQ6Pyv9Gr9+XxehrCc6+R2lLAQqWrym7J01JYkqY4/2hoDkbbDT7WyH6ZhUrqUcmW8BtQYuAIKjfS6E86LC5RQ46j8a0U9qQfcUAwmgq2Z/897q57wrNV8ZS6JfUHm4SimZzCPptTso0AGGjkt8lsNXKRIv+CMR6MFmsAkP37dHARsw7BMGEf4NZc7AFf7CwK3LhtBJrS6KoL1Iu18F/Mib3Wr4BQ790e/626oQHOseVGd6KTnE5grshTQVisAHMjF1bV8b4z+k7zKFQzItvIi53yLG3Vowb/UxMg+L8TEqUcTH+u4WVq3M9LF6PXKLLLEPAkMJ5zHh+cwc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5358.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199021)(2906002)(110136005)(54906003)(15650500001)(5660300002)(8676002)(8936002)(41300700001)(91956017)(76116006)(316002)(66446008)(66476007)(66556008)(66946007)(478600001)(4326008)(36756003)(6486002)(64756008)(966005)(71200400001)(6506007)(6512007)(122000001)(38100700002)(86362001)(2616005)(26005)(186003)(83380400001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1BndTluYmVlTWg1VGR1QVpOV1d3WEFwNGJjMnE1QStVRVltcGl4Z3NnclI5?=
 =?utf-8?B?amFIbmhqNGkrZ0pYdHRONUNIRGkydG5vSC9GM2YxZTI2cnA3RFlGb1J3TXVq?=
 =?utf-8?B?N1k1TjFlNFNVSTVmTEdFYzBZZnN0MTlNaEM4NjJrZXlPZ2JlcXdjWDRLN0ha?=
 =?utf-8?B?VHdGR3BtNms5bHY2SXhtc1J3Z0YvVmVrU1RLTi8xbUwvbWpwcjl1K2o1bnUy?=
 =?utf-8?B?b2Nwa052OXJwdWk3QlNKYnZxazB1UjlMZTZmYXFTMExObXpYK0EwVUoyRVJY?=
 =?utf-8?B?SklmOGxLMUowQXdhVG9iU3hLVVE2WEo2NUd6bUFCS0ovSFBMSlhLQkpId3Bw?=
 =?utf-8?B?WGVRanplSENhRUdzeS83NXJZRUMwVVE0dkx0eGtQUGt3cjdINWhXR2tDRjhp?=
 =?utf-8?B?RjNYSTQwMnYxTWVyVm5yK1VXQVptalFHQzlaUHZxS1QvTzFPeUpFRWJWeVlP?=
 =?utf-8?B?RzNMYjRIcUtiNVN0T0ZIL0JuOVZwU0pFV1NWNFNJWlJ0ZEFDMTVNNkNjRzRL?=
 =?utf-8?B?SjNSZjYycnJJMUFHRGVva1YxWWNxTjhtK1dtRXViL3JIbVBGMTRNVVNpd283?=
 =?utf-8?B?NGxML3NoTW4yQXh0WldEeHhLNXhla09vL09SbUhleEtFcXRTNmFWMWlSeE9y?=
 =?utf-8?B?Qys0V3RLUU11NEI1TnZBVTN4a2tKb3dGc1FGVXZWSWpiNDh3Wlc5WWo4L25S?=
 =?utf-8?B?VU95THQ5RDRvaUJkdzAwUW5GL1ZYNzFTdVVCak5UancweTVzNXJpVWNIK2dO?=
 =?utf-8?B?akJxVzBNdnhtRnFPUHhTV0lsSjNZV1E5RXkrRWgwU3RoOE1sUWN0UXZUTlZO?=
 =?utf-8?B?RHJNOTJtZ2dhRlRPSlR4bE5NeWlGYTQxVVhRMC9QczhFV3JkbFJIUi9uVGpN?=
 =?utf-8?B?UVBmMnpMUVB4RjBVRHVFQXF1WTJLcEZPUjh4R3FWcmt6c2lvQzdMOGtrc1lK?=
 =?utf-8?B?V3dzcUZ4enVUNkJIbVQyeWhHdGwzSUVsNjlvcUthWktLL1hNVkh3Q3EyNVdS?=
 =?utf-8?B?UlRMcFprRVcydGNpeVV0RmJNTDdSSGlndEJwblpoR3lGOStwUGxIdEJSL1hL?=
 =?utf-8?B?YngxUXhmbGdKZEpVVXNLQmxuc29JcTlLYmRLRkdJKyt3dExTRWw0YmEybllj?=
 =?utf-8?B?YktQWUtpQkFqOE83RGFaNWxINmxxbjJZbmFvZ01TQkhFN0JETXkzQWNLU2Ur?=
 =?utf-8?B?TDg5QlB0NXlQaTdCZTVTZ2srditXRDIzVmVTc2ZTd1czZFlKUnJIVlBQY0g5?=
 =?utf-8?B?eW9XZk5wcDR1YVk0aUNBaFJTOElka3RjNUgycFJWd1Rnaks5Tk1RYzlJZ2Jr?=
 =?utf-8?B?dlhDRXdKekdGaE9rV1ZnUUlSSTVpdmdDMmIwQW9kOWFjUFk5NHE3LzRiRk9m?=
 =?utf-8?B?M25ESThvSm9WK2lTMk9QdmVPV21BOGZNVFovcGNwaGt2M2x4WGo3UStVOXpV?=
 =?utf-8?B?TGZNQkxWTHZlcmgvTHI0NEVEREs0SVlpRVpYdUhYTHlNcHV3ajRUcSttdEw4?=
 =?utf-8?B?U3BqU2wybVg0RUtBVERRMzRjRHF4UGZHYjR4K3hhYXdua1lyMWhFOUR0cXpq?=
 =?utf-8?B?QTk3VnNDSHZRR2VYTDNMR1ltYjJidExtbDIyckorWFU4NkdmRjE2dXd2ZUZl?=
 =?utf-8?B?MUdZNDYyNzRoVGVDSVpCV005d3VJS1gyMGlJWGUzdjZUWlA5Zkx4U0J1dWRx?=
 =?utf-8?B?TmJCZnlTeHQzdFFmdlhqckVuVDAxRHNMc1BBd0JpWGtWdUgyODBCTW91NG5z?=
 =?utf-8?B?ZEN1cmNYeEZPcEFlTWp5M25zWTAyR2RnUVc5ZDQ5UEVzYjlBT0Z2VXcxZjRM?=
 =?utf-8?B?U1dQUkE2eTNWa2xONzVzcTdKK2xubHA4WHBBbjBqS0xSRWZzQnZhZDJvM1RY?=
 =?utf-8?B?aktSQ0U1ZCs3eVlrS3hpUXphRmJHUzdibUo3b1ZqZnFvbE04YXJDNVY0OEhY?=
 =?utf-8?B?MjhOcnpMdXRScTVETkVCcGVqSmVoVCtOZWMycmcvWGxMSll4V2l2SmRUL3FD?=
 =?utf-8?B?MlRyTFJveWtiZmM2d2dJMWpHa1Y1Q2dKMEpkd0JRQVI4QWNNcXZ4U0RBaXpj?=
 =?utf-8?B?cUNMWS9xeldzUjJSR1FENkpHU0dWd3NoWFJhc1NUdHN1N2Z5NFFKMllzYlhB?=
 =?utf-8?B?Z04zVitFdUNoUkhpWVJpUUtBcTFsdWl1SEZTako4NFlHUzVQTVVlcHhwZnBH?=
 =?utf-8?Q?1PTZmxCcgAY5xwuW8DVGbA8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71583E7BCAE30C4F8ED8434B3F37B4E6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5358.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8327b9b4-e04d-4485-909c-08db5ab93baf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 11:39:41.9730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1odJewZBOmzU/YiUxOwiZR0UfYxh1E1QLk/XIzJZ48z07hJfG5MSYldWeZhbiWU10H1lZKr65uStUxVjRN52WVhxWiT6EhXjFDfQSswl+es=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6891
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ29ub3IsDQoNCk9uIE1vbiwgMjAyMy0wNS0yMiBhdCAxMDozNyArMDEwMCwgQ29ub3IgRG9v
bGV5IHdyb3RlOg0KPiBLcnp5c3p0b2Ygbm90aWNlZCB0aGF0IHBhdGNoZXMgZm9yIGFyY2gvYXJt
NjQvYm9vdC9kdHMvbWljcm9jaGlwIHdlcmUNCj4gZ2V0dGluZyBsb3N0ICYgdGhlIGxpc3RlZCB0
cmVlIHdhcyBpbmFjdGl2ZS4NCj4gDQo+IE5pY29sYXMgYW5kIEkgYXJlIHdpbGxpbmcgdG8gc2hl
cGhlcmQgcGF0Y2hlcyB0byBBcm5kLCB1c2luZyB0aGUNCj4gZXhpc3RpbmcgYXQ5MSB0cmVlLCBz
byBhZGQgYSBuZXcgZW50cnkgY292ZXJpbmcNCj4gYXJjaC9hcm02NC9ib290L2R0cy9taWNyb2No
aXAsIGxpc3RpbmcgdXMgYXMgbWFpbnRhaW5lcnMuDQo+IA0KPiBEcm9wIHRoZSB0cmVlIGZyb20g
dGhlIGV4aXN0aW5nIHNwYXJ4NSBlbnRyeSAmIG5hcnJvdyB0aGUgZGV2aWNldHJlZQ0KPiBwYXR0
ZXJuIHRvIGp1c3Qgc3BhcnggZGV2aWNlcywgbGVhdmluZyBMYXJzLCBTdGVlbiBhbmQgRGFuaWVs
IGxvb2tpbmcNCj4gYWZ0ZXIgc3VwcG9ydCBmb3IgdGhlaXIgU29Dcy4NCj4gDQo+IENDOiBSb2Ig
SGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPg0KPiBDQzogS3J6eXN6dG9mIEtvemxvd3NraSA8
a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPg0KPiBDQzogQ29ub3IgRG9vbGV5IDxj
b25vckBrZXJuZWwub3JnPg0KPiBDQzogTmljb2xhcyBGZXJyZSA8bmljb2xhcy5mZXJyZUBtaWNy
b2NoaXAuY29tPg0KPiBDQzogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hp
cC5jb20+DQo+IENDOiBzb2NAa2VybmVsLm9yZw0KPiBDQzogTGFycyBQb3Zsc2VuIDxsYXJzLnBv
dmxzZW5AbWljcm9jaGlwLmNvbT4NCj4gQ0M6IFN0ZWVuIEhlZ2VsdW5kIDxTdGVlbi5IZWdlbHVu
ZEBtaWNyb2NoaXAuY29tPg0KPiBDQzogRGFuaWVsIE1hY2hvbiA8ZGFuaWVsLm1hY2hvbkBtaWNy
b2NoaXAuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBt
aWNyb2NoaXAuY29tPg0KDQpBY2tlZC1ieTogU3RlZW4gSGVnZWx1bmQgPFN0ZWVuLkhlZ2VsdW5k
QG1pY3JvY2hpcC5jb20+DQoNCg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBhZGQgQ2xh
dWRpdQ0KPiAtLS0NCj4gwqBNQUlOVEFJTkVSUyB8IDEyICsrKysrKysrKystLQ0KPiDCoDEgZmls
ZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4gaW5kZXggMzE4Mjk5Mjc2OWFhLi45
YWUwN2NhYTRlNmIgMTAwNjQ0DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+ICsrKyBiL01BSU5UQUlO
RVJTDQo+IEBAIC0yNDMzLDYgKzI0MzMsMTUgQEAgWDrCoMKgwqDCoMKgwqDCoGRyaXZlcnMvbmV0
L3dpcmVsZXNzL2F0bWVsLw0KPiDCoE46wqDCoMKgwqDCoGF0OTENCj4gwqBOOsKgwqDCoMKgwqBh
dG1lbA0KPiDCoA0KPiArQVJNL01JQ1JPQ0hJUCAoQVJNNjQpIFNvQyBzdXBwb3J0DQo+ICtNOsKg
wqDCoMKgwqBDb25vciBEb29sZXkgPGNvbm9yQGtlcm5lbC5vcmc+DQo+ICtNOsKgwqDCoMKgwqBO
aWNvbGFzIEZlcnJlIDxuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb20+DQo+ICtNOsKgwqDCoMKg
wqBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4gK0w6wqDC
oMKgwqDCoGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZ8KgKG1vZGVyYXRlZCBm
b3Igbm9uLXN1YnNjcmliZXJzKQ0KPiArUzrCoMKgwqDCoMKgU3VwcG9ydGVkDQo+ICtUOsKgwqDC
oMKgwqBnaXQgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQv
YXQ5MS9saW51eC5naXQNCj4gK0Y6wqDCoMKgwqDCoGFyY2gvYXJtNjQvYm9vdC9kdHMvbWljcm9j
aGlwLw0KPiArDQo+IMKgQVJNL01pY3JvY2hpcCBTcGFyeDUgU29DIHN1cHBvcnQNCj4gwqBNOsKg
wqDCoMKgwqBMYXJzIFBvdmxzZW4gPGxhcnMucG92bHNlbkBtaWNyb2NoaXAuY29tPg0KPiDCoE06
wqDCoMKgwqDCoFN0ZWVuIEhlZ2VsdW5kIDxTdGVlbi5IZWdlbHVuZEBtaWNyb2NoaXAuY29tPg0K
PiBAQCAtMjQ0MCw4ICsyNDQ5LDcgQEAgTTrCoMKgwqDCoMKgwqDCoMKgRGFuaWVsIE1hY2hvbiA8
ZGFuaWVsLm1hY2hvbkBtaWNyb2NoaXAuY29tPg0KPiDCoE06wqDCoMKgwqDCoFVOR0xpbnV4RHJp
dmVyQG1pY3JvY2hpcC5jb20NCj4gwqBMOsKgwqDCoMKgwqBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmfCoChtb2RlcmF0ZWQgZm9yIG5vbi1zdWJzY3JpYmVycykNCj4gwqBTOsKg
wqDCoMKgwqBTdXBwb3J0ZWQNCj4gLVQ6wqDCoMKgwqDCoGdpdCBnaXQ6Ly9naXRodWIuY29tL21p
Y3JvY2hpcC11bmcvbGludXgtdXBzdHJlYW0uZ2l0DQo+IC1GOsKgwqDCoMKgwqBhcmNoL2FybTY0
L2Jvb3QvZHRzL21pY3JvY2hpcC8NCj4gK0Y6wqDCoMKgwqDCoGFyY2gvYXJtNjQvYm9vdC9kdHMv
bWljcm9jaGlwL3NwYXJ4Kg0KPiDCoEY6wqDCoMKgwqDCoGRyaXZlcnMvbmV0L2V0aGVybmV0L21p
Y3JvY2hpcC92Y2FwLw0KPiDCoEY6wqDCoMKgwqDCoGRyaXZlcnMvcGluY3RybC9waW5jdHJsLW1p
Y3JvY2hpcC1zZ3Bpby5jDQo+IMKgTjrCoMKgwqDCoMKgc3Bhcng1DQoNClRoYW5rcyBDb25vcg0K
DQpCUg0KU3RlZW4NCg==
