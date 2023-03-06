Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A576AC1FA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjCFN4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjCFN4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:56:23 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E27305CD;
        Mon,  6 Mar 2023 05:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678110971; x=1709646971;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eOu8mLn1AJ6APxXkovPAFjpzd8mhG4d4dUgH+45FUQQ=;
  b=z6Xox++TwzajVEhhbDrbbiqDnj/BXjXQ/zs4a151NQHiYikzF8kpUXs0
   EzAxeA8w/B684C96DgvZMUELITSGbRh5BtP7PqI23yRxasNE7yWnGSVwn
   yhp1EU8cmmstCn834YITN34EFtCUtMjlYG3PBsp5fIEkRLMsvAvzE3ptF
   +hJH8v7wTV3kySLu18pglSry4qmUFuYJv/9A5RdSQWLEE4FfE4E/Uu39C
   oQ223WeltxGA8uSdqIStk/BptSGgml6t1PELOqraCsnRlJQ6J5hvIWKbS
   38YdhU9INcaRZoA0kESIjSEBoP3zjsqARh6ApoLjiaPXv4d6PR4QtWk+y
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,238,1673938800"; 
   d="scan'208";a="140488088"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Mar 2023 06:56:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Mar 2023 06:56:09 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Mon, 6 Mar 2023 06:56:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJ0jB+xHKbFHO176IITfoxf7Lc1aMVCuNuIXkl2gqGBcPPcCQOp6v7k0wZORfkh6rrDDwKUnK+pLMpjstr62CmI9BX6Re4YOaAzuP8NV46pA12RP59O8yRWfwQzicGyunihAoY0qVctDpq6vXKI95dqVMbB1HLAUhKx1dNABBvxWPKVs/SNg89qrzbe9f9P6B5d+EVKkjph2wD33lUZ0jullNDw77x8NaHD39EdFSSmuTY3jIIb9AO8EafOGOG+QqiBkX0is/RB+Wr1Q4wbuZnS0TwSE4T/A4lnXlF53haXm7Z8Xfqs0UUcy8S46PE6CLmWyjTSUEv6oC5lpXyc8Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOu8mLn1AJ6APxXkovPAFjpzd8mhG4d4dUgH+45FUQQ=;
 b=O0CiUhZG3Vi1BrE/PC99L6wZW4g5CBivUALUw77bq03zWaIfz7WFqvEZwOTPF9/ACNaGZSmDhJzfWZNz1cH61I+ndKg9V5VcwaeKBU7jAb8vOplRhtV00oyN0srwcSJOxleV6eM3a+04Qps/9eyJtiAEePblm84n971BZicyvBd+JO4pGKyo6tDEAphplwO5RO0b9MrCKlwyvzZRHHCnmVhvu6s4TPU1exlE7DUj31xPcQ778cqJpb7k9djyBBKTvoQP7zTiGslQXPzbxaiscurEXhmhVCYA+ZXrE3okmJopgNgyT1t+P0QDviK8fQmf09ipQJJzbA7cH01DJZzkRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOu8mLn1AJ6APxXkovPAFjpzd8mhG4d4dUgH+45FUQQ=;
 b=FwKG3+yNIEmqxm+i9h9D9nCLoU+eOBVElU4w0yz/8adWapreuYfifgvLvH85uJUFJnN1PBubH/ThlqFpi3PVwVkHdzSWrQqPdNuU+rbg8liSBQr1BHiY75im/WnYTI+JcH47Bee+R33I2kKnxRfLW0+BaA59Jv+XS3/DviHqtpw=
Received: from IA1PR11MB6395.namprd11.prod.outlook.com (2603:10b6:208:3ac::14)
 by IA1PR11MB6348.namprd11.prod.outlook.com (2603:10b6:208:3af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 13:56:06 +0000
Received: from IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::bd74:bb77:f00d:7524]) by IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::bd74:bb77:f00d:7524%4]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 13:56:06 +0000
From:   <Marius.Cristea@microchip.com>
To:     <jic23@kernel.org>, <krzk@kernel.org>
CC:     <devicetree@vger.kernel.org>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] iio: adc: adding support for pac193x
Thread-Topic: [PATCH v1 2/2] iio: adc: adding support for pac193x
Thread-Index: AQHZRSeCrijxJxjQlUenEfDaIA7ypK7Za2QAgAaFDQCAAADYgIAN6zAA
Date:   Mon, 6 Mar 2023 13:56:06 +0000
Message-ID: <149491f6acdfeb4f1a6da7798e27ca984aace19b.camel@microchip.com>
References: <20230220123232.413029-1-marius.cristea@microchip.com>
         <20230220123232.413029-3-marius.cristea@microchip.com>
         <8ad45f24-dc78-dfc4-23d2-ad5a5d0e42d4@kernel.org>
         <20230225171954.06d396f3@jic23-huawei>
         <20230225172255.7b79374a@jic23-huawei>
In-Reply-To: <20230225172255.7b79374a@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6395:EE_|IA1PR11MB6348:EE_
x-ms-office365-filtering-correlation-id: 624bf417-4222-4e0b-8e61-08db1e4a87f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qVLnWw1MaJ28hZqdR4clz+cQFiBmw4P8SyOoDY9MKUNKyBDRFvNfGAVwIwUGKzRQBGGpBiv+ckIqTOOVE2Wf0E1BCxW3c6Et90hmaYO4WrdzF8FJKqpxB3jsmKd0V54JegZiNY1/RpQD3cDlu0EwtXxq7a9C5W9oSXW3ZwXs0TwyMRtFFNcTIyEE/LlMnsGt4cg39t+XMplj0DcThZvYZA+5z4EIGtTDFQYragnIv8PaqGZ/sez9gwjXHU4Hk+Arev/aljfXLCQUomXi0E4riM1ROYAYdh84eEzx7fdsj+O2czWb3EW3QAnuQOOQJJFafYLUg7hP/x7UNacyaVqUZJWl8x5uf6UqYoex8wUT5wO2sZWlQoJ731SUzPqcqT8Rpr5l9hhY5CUEz4NpkwSs0z2lHOgbBiE9PLQHmXc/bCuCOqb29u+jxQzqjhaG1R4eHP+sB84zgr9rjmvgsOoW/ve4bNOUjOtKVGFBkTmsNUEga5MryMbA4A49A9qoEgriWBEIAEQMBoSA54zYRCghtXTbITLU8ZmVOONezgUg6dI7Db+xR4FTbh71ukR/Aq4kEgTbr81frJHYI7sskAySISKZ0OaZ+BekW7cUpoIltZJdNURS02pn/ZjwmGXMSZkXQ9W1P17v0BYEmHMrkFCIeJCy6STwxbb1wzQwxF2sgEY9t3QHlDaBS+adaHfKZu8+rEWMpUDwy9/0f3Vectw/XA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6395.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199018)(5660300002)(8936002)(66446008)(91956017)(66946007)(76116006)(66556008)(66476007)(2906002)(8676002)(64756008)(4326008)(54906003)(110136005)(316002)(478600001)(71200400001)(36756003)(6512007)(6506007)(6486002)(53546011)(26005)(2616005)(41300700001)(186003)(122000001)(86362001)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjJFbUNUaFRUT29uUnR2bTZoVVQrMHVBVmlNdXNoQ1Ixc1dzdFZ6bjVNdEM3?=
 =?utf-8?B?dU91N3JPU2FPN3JzeGJTWGJINXd4bXIyQlBJbEdhdVpyS01UV2t5M2dOY1kr?=
 =?utf-8?B?MmFyUVllTU1XQW1iYjlRNEFtbzRGQTdwZUdDRDhVeTNGWnFDN3RSeXB0MVlL?=
 =?utf-8?B?ZnhuOEljdGFwemxwV0lVTnJTb01XWFBMUTgwanhiTE1TOVZWZDlCUEt3WUFJ?=
 =?utf-8?B?b3k4QXNUQURQdGJOYVhiR0lTZGhhQ2VzMGRjZzMyaW9yRmpvMWNYejVUNG53?=
 =?utf-8?B?bFUwbTl2MWNxbFpPSFpSVXZrT3M3MnROdXVUTGQxV1MwbnZXc01TbFFtbkdI?=
 =?utf-8?B?V0Q1emZ6ZWpnNGxGa2FVSUdrZjArdGhQZmswMnY2NHQ3c0RKU2hXUjdNdlZO?=
 =?utf-8?B?Uzc5YWxqLzBvaktTei8vcytIUXJ0TnpMUW1qVkZwdUJ1WEN2dHN5Mzg5QWZy?=
 =?utf-8?B?dmJHVGZjZUh1UU5iczBqeTRuY3B2WS9xQ3kyQWI4dDBHRTY1N1J5R3BWMW9y?=
 =?utf-8?B?YjFjVTZXMzE1NktHSkFjM04wTlVpRUE0WlZMamhJdEhuamFpWVgvRGtBWDVj?=
 =?utf-8?B?TUdDV29PR1dibXAzRVI1Mk9sM1ExTEszeEpIcjdTSTlLU1NZVnFJNlNDWjFR?=
 =?utf-8?B?VnNPTnMyNmdyT1k0cjJwUWNWT20reGlyMTZCaGEwa3R5VE9vUjFNTnRoUHdh?=
 =?utf-8?B?RTl3UTJkZXEzKzc2T25XWjNmUW9YMlA4RjRmZml1M0grZU1ScWJlMi85OWhn?=
 =?utf-8?B?MU1ycWN1Y1p3RlVCVGtRTTVESlVDZjZpVEtHRG1QVGREanhpMXFoZ2dqYXpZ?=
 =?utf-8?B?eWMyd3ZMYzZHZGdCTHVzZG00VVhDcEZrZStYckF5bHZnbHFHRnhkRUk2akJo?=
 =?utf-8?B?cWw1YmZIaGd6eGhHa0tRT2tDK1hUNFNuNVdOWFA5Y1RxcUlidWZleVlybEdn?=
 =?utf-8?B?UTljcW9xcmJ2ZDBtdlpPVUI5eTl0YWNEZVI5Z0RjNCtOa2I4eWVYQTBod3Vj?=
 =?utf-8?B?dDlMSnBpZTdldGl6TVEwQkhOZldJZXByZVd3aCtYeEdxZnhuVGxKV3RoWmFD?=
 =?utf-8?B?a0JHbjZ4YjQvb3Z4U3dQb2xUbkZ6dWd4ZkNtSmlHVlU1Z0RUSTNxSFJNc2V0?=
 =?utf-8?B?TnNxYlpFOXlRU3pHL1M4Sm05U1dxNjh2U2dEQ1ZlaEtEUHdaVEVkbDJEMGJp?=
 =?utf-8?B?SjJFQWxQbTZ2RVQ5RW5YWGY3eGZHZ1FrSHEreXJqbWN3YnFza0xONHIwNGlh?=
 =?utf-8?B?VWU2RDFrakVGbVhBblNKK0ordkhESkYzaVB2TE01dnA5blVVampSY0dROEZU?=
 =?utf-8?B?bkF0K1ZNRW9VVStmNHZJSUZHdStzVGpsUGkrYWJNa2pWbFZFcStvS1VJWWxC?=
 =?utf-8?B?YldkVnlkK1dIQmlIUzJpajJkSVFMa0h6aFRMY3hENTJDUjhFMk1aMDRsQUFy?=
 =?utf-8?B?ajdKcFp4VkducmlQVVZORFprSkxNRDhtZk9SbTNhOEVrVVg2TlBmWG4waWlF?=
 =?utf-8?B?ZnRaSEErK0swWW1PTXJQMW1SMU9TajFaalArQy9tbmd1NWFFRW1zbzIvU0x3?=
 =?utf-8?B?SkNFa09XU21yUEFEVHNvNXQ3cDhkQmxEZXcwUHQwYlBZWVZIT3BlZVdrV0Ez?=
 =?utf-8?B?KzBuS2s1WkwvU2JmNnJKR2lXN3ZrdWJiL3p3YTR6VXpUTTh4UDRRR21SK1Iw?=
 =?utf-8?B?d1FaL2d3YU5aay9ZOHB0TkZxVlN4ZndIdms3bVpBTTgvNm9pN1dkYWJINzcz?=
 =?utf-8?B?N2VWRlJqN2ljaWdXQlJsdFBzenpVNHpYdm9BY0VRUGo0WG9OdjlrZFNVZEhJ?=
 =?utf-8?B?L3RKS0FwejNnV1I2ZUp1VDY1dTZianZpR3R1WXoyeXRFWFFqRzhQUnNHTWRP?=
 =?utf-8?B?UUt5UjZiTEVnQTZLZnduOXhuWCtMWnZtUm1pR1doejFxMmNzdUlxdFl6Q3U1?=
 =?utf-8?B?TGNnU0JpaXVFRkZMbjNKeGNjYk4rS3JVZHR3dkxFbkE2VDdzUDhSRFk4L0lx?=
 =?utf-8?B?ZzZMdlg4OUFidjkwQWVOYmY5QVgxeUJoVlFGNDJWWEN0TUUzYkdMa2xZSGow?=
 =?utf-8?B?NUthQjBRR0xUeHRidC9VdEsvZU5CSFRVK1dIUzRQQU91dlY5eEk4ZU9ReSt4?=
 =?utf-8?B?ckFiNGYwd0lCMm92MDdVNG9KQTRXY3NzN21ldTNMTDNlQTgzWUVwZnNNUzk2?=
 =?utf-8?Q?saqUrtmKVkLNoq/Z5vWQeBk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4502BABEA5DB8C448FE9BAFBF47049C8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6395.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 624bf417-4222-4e0b-8e61-08db1e4a87f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 13:56:06.0371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Epb5mbPyQsqmOnAR8mS/NVQoLLqzPOmouOsjeN68Ig7cKeElCZdTzrB2vguYaHq9T2BEVtKUccGdhgjQRe6rdxMypceszhrsXHRtTXGc0Cg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6348
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBLcnp5c3p0b2YsDQoNCg0KICAgVGhhbmsgeW91IGZvciB5b3VyIHJldmlldyBjb21tZW50
cy4gSSB3aWxsIGhhbmRsZSBhbGwgb2YgdGhlbS4NCg0KVGhhbmtzLA0KTWFyaXVzDQoNCk9uIFNh
dCwgMjAyMy0wMi0yNSBhdCAxNzoyMiArMDAwMCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBTYXQsIDI1IEZl
YiAyMDIzIDE3OjE5OjU0ICswMDAwDQo+IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5v
cmc+IHdyb3RlOg0KPiANCj4gPiBPbiBUdWUsIDIxIEZlYiAyMDIzIDE0OjQ2OjA4ICswMTAwDQo+
ID4gS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPiB3cm90ZToNCj4gPiANCj4g
PiA+IE9uIDIwLzAyLzIwMjMgMTM6MzIsIG1hcml1cy5jcmlzdGVhQG1pY3JvY2hpcC5jb23CoHdy
b3RlOg0KPiA+ID4gPiBGcm9tOiBNYXJpdXMgQ3Jpc3RlYSA8bWFyaXVzLmNyaXN0ZWFAbWljcm9j
aGlwLmNvbT4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoaXMgaXMgdGhlIGlpbyBkcml2ZXIgZm9yIE1p
Y3JvY2hpcA0KPiA+ID4gPiBQQUMxOTNYIHNlcmllcyBvZiBQb3dlciBNb25pdG9yIHdpdGggQWNj
dW11bGF0b3IgY2hpcCBmYW1pbHkuDQo+ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBN
YXJpdXMgQ3Jpc3RlYSA8bWFyaXVzLmNyaXN0ZWFAbWljcm9jaGlwLmNvbT4NCj4gPiA+ID4gLS0t
DQo+ID4gPiA+IMKgTUFJTlRBSU5FUlPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKg
wqAgNyArDQo+ID4gPiA+IMKgZHJpdmVycy9paW8vYWRjL0tjb25maWfCoMKgIHzCoMKgIDEyICsN
Cj4gPiA+ID4gwqBkcml2ZXJzL2lpby9hZGMvTWFrZWZpbGXCoCB8wqDCoMKgIDEgKw0KPiA+ID4g
PiDCoGRyaXZlcnMvaWlvL2FkYy9wYWMxOTN4LmMgfCAyMDcyDQo+ID4gPiA+ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gwqA0IGZpbGVzIGNoYW5nZWQsIDIw
OTIgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2lp
by9hZGMvcGFjMTkzeC5jDQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IFRoYW5rIHlv
dSBmb3IgeW91ciBwYXRjaC4gVGhlcmUgaXMgc29tZXRoaW5nIHRvIGRpc2N1c3MvaW1wcm92ZS4N
Cj4gPiA+IA0KPiA+ID4gPiArDQo+ID4gPiA+ICsjZGVmaW5lIFBBQzE5M1hfTkVHX1BXUl9DSDFf
QklESSh4KcKgwqDCoMKgwqAgKCh4KSA/IEJJVCg3KSA6IDApDQo+ID4gPiA+ICsjZGVmaW5lIFBB
QzE5M1hfTkVHX1BXUl9DSDJfQklESSh4KcKgwqDCoMKgwqAgKCh4KSA/IEJJVCg2KSA6IDApDQo+
ID4gPiA+ICsjZGVmaW5lIFBBQzE5M1hfTkVHX1BXUl9DSDNfQklESSh4KcKgwqDCoMKgwqAgKCh4
KSA/IEJJVCg1KSA6IDApDQo+ID4gPiA+ICsjZGVmaW5lIFBBQzE5M1hfTkVHX1BXUl9DSDRfQklE
SSh4KcKgwqDCoMKgwqAgKCh4KSA/IEJJVCg0KSA6IDApDQo+ID4gPiA+ICsjZGVmaW5lIFBBQzE5
M1hfTkVHX1BXUl9DSDFfQklEVih4KcKgwqDCoMKgwqAgKCh4KSA/IEJJVCgzKSA6IDApDQo+ID4g
PiA+ICsjZGVmaW5lIFBBQzE5M1hfTkVHX1BXUl9DSDJfQklEVih4KcKgwqDCoMKgwqAgKCh4KSA/
IEJJVCgyKSA6IDApDQo+ID4gPiA+ICsjZGVmaW5lIFBBQzE5M1hfTkVHX1BXUl9DSDNfQklEVih4
KcKgwqDCoMKgwqAgKCh4KSA/IEJJVCgxKSA6IDApDQo+ID4gPiA+ICsjZGVmaW5lIFBBQzE5M1hf
TkVHX1BXUl9DSDRfQklEVih4KcKgwqDCoMKgwqAgKCh4KSA/IEJJVCgwKSA6IDApDQo+ID4gPiA+
ICsNCj4gPiA+ID4gKy8qDQo+ID4gPiA+ICsgKiBVbml2ZXJzYWwgVW5pcXVlIElkZW50aWZpZXIg
KFVVSUQpLA0KPiA+ID4gPiArICogMDMzNzcxRTAtMTcwNS00N0I0LTk1MzUtRDFCQkUxNEQ5QTA5
LCBpcw0KPiA+ID4gPiArICogcmVzZXJ2ZWQgdG8gTWljcm9jaGlwIGZvciB0aGUgUEFDMTkzWCBh
bmQgbXVzdCBub3QgYmUNCj4gPiA+ID4gY2hhbmdlZA0KPiA+ID4gPiArICovDQo+ID4gPiA+ICsj
ZGVmaW5lIFBBQzE5M1hfRFNNX1VVSUTCoMKgwqDCoMKgwqDCoMKgICIwMzM3NzFFMC0xNzA1LTQ3
QjQtOTUzNS0NCj4gPiA+ID4gRDFCQkUxNEQ5QTA5Ig0KPiA+ID4gPiArDQo+ID4gPiA+ICtlbnVt
IHBhYzE5M3hfaWRzIHsNCj4gPiA+ID4gKyBwYWMxOTM0LA0KPiA+ID4gPiArIHBhYzE5MzMsDQo+
ID4gPiA+ICsgcGFjMTkzMiwNCj4gPiA+ID4gKyBwYWMxOTMxDQo+ID4gPiANCj4gPiA+IEVudW1z
IGFyZSB1c3VhbGx5IHVwcGVyY2FzZS4NCj4gPiANCj4gPiBJJ20gbm90IHN1cmUgdGhlcmUgaXMg
YW55dGhpbmcgaW4gY29kaW5nIHN0YW5kYXJkIGFyb3VuZCB0aGF0IGFuZCBhDQo+ID4gZ3JlcCBm
aW5kcw0KPiA+IGEgbWl4dHVyZSBvZiB0aGUgdHdvIHdoZW4gaXQgY29tZXMgdG8gb25lcyB1c2Vk
IGZvciBJRHMuwqAgTWluZCB5b3UNCj4gPiB1cHBlcmNhc2UNCj4gPiBpcyBmaW5lIDopDQo+IEkg
dGFrZSBpdCBiYWNrLiBJcyBpbmRlZWQgaW4gY29kaW5nIHN0eWxlIGRvYy7CoCBHbGFkIGNoZWNr
cGF0Y2gNCj4gZG9lc24ndCBjaGVjayBmb3INCj4gdGhpcyB0aG91Z2ggYXMgd2UnZCBnZXQgMTAw
MHMgb2YgJ2ZpeGVzJyBpZiBpdCBkaWQgYW5kIGluIG1vc3QgY2FzZXMNCj4gaXQgZG9lc24ndA0K
PiBodXJ0IHJlYWRhYmlsaXR5LsKgIEknbGwgdHJ5IGFuZCBiZSBtb3JlIGNvbnNpc3RlbnQgb24g
dGhpcyBpbiByZXZpZXcNCj4gZ29pbmcgZm9yd2FyZHMhDQo+IA0KPiBUaGFua3MhDQo+IA0KPiBK
b25hdGhhbg0KPiANCj4gPiANCj4gPiANCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IEJl
c3QgcmVnYXJkcywNCj4gPiA+IEtyenlzenRvZg0KPiA+ID4gDQo+ID4gDQo+IA0KDQo=
