Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7216EC965
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjDXJuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjDXJuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:50:14 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2061.outbound.protection.outlook.com [40.107.255.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1214B1AD;
        Mon, 24 Apr 2023 02:50:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwP1ZeMHuClbcGBL8SRxAGuL3V/uSfP8o/s7sSxTPPTuOx0XDjHLmgWRrvWKMV4fTVpfCd0P6mziEWB77jwgq5J+AGokCpsPXHTKG3sAz63ojIvEG1YTHOGcwodcy8l8l2yesrrWm1iI8y3U8ss6s0ZznpxWAp1y+5YsFly7wPlfvYMxwCq2LlA2fTVJtToC/Mftd0DLrAX+mQeeqKLPirO8+JT4pLa/DyarJCNqzLoIBo6okUVzxi++Zq+b5bRPXKKcGrMQRXlsUIhk+7DTxDAqVVsRrEV0ivq+2DAmvboUIx6ImEj89IXOKy8m2mEMOjFjevp1zKKe2LqYOklcEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fz/iN2zCQ/k5zghyBV4onCkkKC/hKR3GcZvIvYS2Rs8=;
 b=KxxtlzDi5F7fAj2tF2+vzJX3sbwoZnpO+93Wn5okwO/vJWqkzNwnIk97SPCgesnDEp6x3n1AXTJORkiJt6MkYmbJC48jiPZeMlaQjEbkqkYwPS3uTwglE+ogCaA1Y0Gx02uTBZvVufIju6XtdhkM3Io+11p0ViDvL6hAUduwar6Y8qC0AhIZiGJtVnT2G9vWOe1+GZ8O0Etvbd7TaxoAbECLwSk1q96sIxZvNpKoZ4CBsaibZ1jtIZehKC5FyNcmF0n7YzQv3whNonDbXywm+Xn2hQwVQIrsOLANcIwLsMcJDcPQY7AruqpUEz7hETASQW5lEpfiQSbgMAaKSiYtIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fz/iN2zCQ/k5zghyBV4onCkkKC/hKR3GcZvIvYS2Rs8=;
 b=aR6A44S1AW252zPy7i++Ie+t1mDKDGfrxCdYQZ0K6SF7MLPHKo1JpCjoS7BId+5z1S7zTI24udZN1h2WK/zsLtl6YnV9cGLIYZLFxqxMF9SW/K7lBPm9z+lMdosSUOWHDbq84zswCWVzdCJ7Pa2IxR13caMgKPygFMJj5NL8Vwt0983pF8THM4FUite1NwsC6u/2pqsLM1v77/TAPop6jAyqrh2Kv8M365pNwL2VH24e8Mo0lOrlA/IE29XGGJZ3OzAKFiFOb276a5zaGVXRblBdoUp6q+5h6pmftRzLpEdkYDmhEdXeE7MUa6Fy2O5Ucm9cn4GBqTC9bio5AEuxaw==
Received: from PS2PR04MB3592.apcprd04.prod.outlook.com (2603:1096:300:61::21)
 by SI2PR04MB5896.apcprd04.prod.outlook.com (2603:1096:4:1ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Mon, 24 Apr
 2023 09:50:01 +0000
Received: from PS2PR04MB3592.apcprd04.prod.outlook.com
 ([fe80::3a95:b02b:4db1:83c8]) by PS2PR04MB3592.apcprd04.prod.outlook.com
 ([fe80::3a95:b02b:4db1:83c8%5]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 09:50:01 +0000
From:   Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>,
        "patrick@stwcx.xyz" <patrick@stwcx.xyz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/2] ARM: dts: aspeed: greatlakes: Add gpio names
Thread-Topic: [PATCH v1 1/2] ARM: dts: aspeed: greatlakes: Add gpio names
Thread-Index: AQHZYhkTutxhEWwlQkmbugxPVHPWKK8RbwYAgBLDDTCAAIngAIAVm6jw
Date:   Mon, 24 Apr 2023 09:50:01 +0000
Message-ID: <PS2PR04MB3592CAF72FE497CB1D6483B6B7679@PS2PR04MB3592.apcprd04.prod.outlook.com>
References: <20230329083235.24123-1-Delphine_CC_Chiu@Wiwynn.com>
 <20230329083235.24123-2-Delphine_CC_Chiu@Wiwynn.com>
 <b66f708c-5369-c1c9-5506-c609a245bf4c@linaro.org>
 <PS2PR04MB3592E90B033CA23F47CD02F2B7959@PS2PR04MB3592.apcprd04.prod.outlook.com>
 <44a7ee80-e770-4918-9caa-f606713fe584@linaro.org>
In-Reply-To: <44a7ee80-e770-4918-9caa-f606713fe584@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS2PR04MB3592:EE_|SI2PR04MB5896:EE_
x-ms-office365-filtering-correlation-id: 8f7d4da4-7bc2-462d-8a9d-08db44a945ae
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rc3Klzglq41+/yM1U2lmX2PQPn+PJBwTMSW+e07z9vYVtcwxUYv543jLn9gCPBwbhFb0BtbvggdvgmlI2YCy3ejZb8tJutIP70jiL1R2li22iadR3uiF5gtmnGoJixv24U4y5ogA4RPvGdXqDeyGbnpIEbTmzngwWTcOTBHRu7gFqXpLUUFJ9Wk5fBx4ss+loUF6vgB7mbURxZv+oGUUzLOFCUnp86ffBw/KBHDSXASmZLPjY7X8wt3k3J4vpdpGfJw0/McvXsOfzIzZc4AXVINhTm/MOdsZEgkIc+ciySTsQu1nwkU2p3NlGhxx8ha9EEicNFU6s56Ps/CE78U/t5HfhvwxIo9ngHQ5yMk2GUeBCPnX4fxN9dgyLDqKnhsl5hHSMWJYT9s/nDadXxwuZtusY1JWwEtMFC49Y7AdVjzthluhq9pMejsPatccLmqz6XzRnBhWLZgiJl4qb2tdAxhMRTSlQwIGuUVYXdo1k480qFDKeVfw0HRFLWAZx4MxRqyM4r/OUwAqjLEPvwHzE3uaJr12Zq1BEVjTRdlX/WfuoK+ArcHSv6pqH5k59umj7rxpQQbcLCEXZGD/5a17wfupt2WfNzdmkuyJeVgDS1JnirVyewkQNuW2pDglOmd7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR04MB3592.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199021)(2906002)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(316002)(4326008)(52536014)(7416002)(8676002)(8936002)(5660300002)(38070700005)(41300700001)(33656002)(86362001)(55016003)(9686003)(26005)(186003)(122000001)(71200400001)(53546011)(38100700002)(478600001)(7696005)(83380400001)(6506007)(110136005)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDQ4MDRVcjFSbkZwbTYwc05HVk9KUTI0Z2dvL0ZOdFhPTGVVZ0tlOGhKRWJC?=
 =?utf-8?B?SURISHFueUNxSGFOdGVCdDFEWGJrb3lRNGtkeWhQSTI5V3hubEFMVlc3VHZV?=
 =?utf-8?B?NjFPRHFsOFRsdFZabmRTYXFJVGZFSFVQUUdnYUF0Q2JpTzBIOTJDV2ZaTmY0?=
 =?utf-8?B?RWkzd1dqQjFnS0lBMW1HL1lCSVNmNEVOYTlUZFFFMVFxc3dEdnpMdTNUaGw2?=
 =?utf-8?B?NUcrY1NRUGZtR2tia0tkOVFQaXFNaFZwTkVYWUFYMzFzcUlMVFh6OFZsQWtW?=
 =?utf-8?B?NkNVZmVTbUFIdW1hR1BqZHdNdTc3UVpSYkEwLzRTWmZDSVRjUjdPQ0prL0VV?=
 =?utf-8?B?VmE4bDJsbSs2TmNlZmkvYXdHbXJJUVQyS2xxeDU5d0FZc0xzbGwxSFo3U05z?=
 =?utf-8?B?dEhmVkdVQktzTlM1K3FsUmZTbC9weHpkT1BJdzhyRmVqR0dsYjlhbUNoelRw?=
 =?utf-8?B?NmFKU3pkWFVadS9rTDRSN3ZiYldpT3JWbVZxZ1VUaEFrcENRRHFpZWloWmlB?=
 =?utf-8?B?cWc2SHc2bGdMMmdYeWdLUjJKTEV3dENqbkJmZEtxdm9qL29YS2MwZVdqMHBQ?=
 =?utf-8?B?YlBGN1p3Rk5JQ1ZjL2FUY09VSnYwTFhJeXdyUmoxQklybUJpcnpBSGVnai8v?=
 =?utf-8?B?VDN5TzV5WldqcElLakpnK0VUZStyOG8rYzM0cWxQNHBPeEkvNDB2dmlOdVVm?=
 =?utf-8?B?eU9sbHFMQTVjaStaNFBJL2tqVC84TmQzZWlLQmhyWUk4ZlJvTnBUN3VIeUJt?=
 =?utf-8?B?NFFuL3B3VGlkUnNuQndyTk1ZQnVHWUtqNXhWUkVBV3BnenJqbHBHaE4vNmRR?=
 =?utf-8?B?TkFUZDFSaFdXOUJxM1JZVWpWYktKbm5TRDRkcTNNNFZRT1F0ZE9OaDgwb2R1?=
 =?utf-8?B?QXFwTGtGdmR2VytscHVZRVRLbGNRbkFOOGc1SXpRT2x0UHJvZHpFNTVYaVVa?=
 =?utf-8?B?VlpIY2ZVWXY3Q0tTRnpLdHoxRVdYSVVpcnRXVkZENE5HdXBjUWp2YWcwbzBz?=
 =?utf-8?B?U2VsdmE0SXc1UlVDRkJlb25HYUpUUkorN21XeU92dmVFVG1BVjF6RFV4dnBr?=
 =?utf-8?B?ZTI1SHhrNklaRmpiSi9pS1BIVkZBd0ZzaWk2bjMyM0lIeGxKNVBUT2J2cVM0?=
 =?utf-8?B?RVNXdGk2c3J0SHAwZXltT0RYQlNuR1JacHE2NVZRaEhQV1dpZzZWQnhTR0hG?=
 =?utf-8?B?SXBrMUdCVVRFbWs2d0ptYVJlSUxhWER3TlB2N212akxCejErNDNKU0NXbUEy?=
 =?utf-8?B?VERqcEwvUmhtczRXQjNXWjJyZXpZMUp4N0F4NjJaN1RLS0cwZTZ3eThWMmRR?=
 =?utf-8?B?c3o5VU5XYUNNUkNRYjY5Y3o4RW02ZkNiamRWa2JmR0xVZUxiNi80K01FQUFm?=
 =?utf-8?B?Y1JzUm8wTGxjMHBnTklQNFUvVXFLcmlndUJsajI0bGQ5K1M5UlFGSExLbnZo?=
 =?utf-8?B?TkF6NmYzc1BSaEJ4SGp1alBRUHYwYkcwMi9OT2tPWVpKNzlDVW5Vb3E0dTVu?=
 =?utf-8?B?QU56bFhHczN2enladlNLNm1sTkZ2OGV0WHFMaEM0R2hXbnM4L2dCZ0RUWkhP?=
 =?utf-8?B?SGNQZHBCV2Z6dk5ONkJYR3Fkbjl4K0gzbjdoQ0RDYWF0akNGN2JsVjhEY2s5?=
 =?utf-8?B?YWlUUUVteEdNcDFZYmdHdlRlUUlZeFprVDJmZTRtcnJRYXcrczhBbzl4SWpk?=
 =?utf-8?B?clNtMkVMUys2djN5OGhVakJjb2RkRytSWTNITU80NlFDSjVpbDFKNkdMSm44?=
 =?utf-8?B?WVRKQXZZRXc5U2F4Nm1TSHZvSVEzdzdwbzFJcXBJSUd4VS9Rdi9FeEQwOHB0?=
 =?utf-8?B?YUgwODYwbk1xTkFXck1PSElFVVZaQnhIckVKclE4ZjdlRWg1YXQ0ODJiTlp2?=
 =?utf-8?B?YXMyNVpmRU1TS1FmaFdEMEVYT3U1eW0xdWhCaHhib1lDOVA3SnBCbENUL0dN?=
 =?utf-8?B?R2xNVnFvSWNaRWk3RW1PMFI4ZjhNa0JBdjJOd24zR2NIYW9rYUF2Z1RoOW44?=
 =?utf-8?B?czhxTGZKcitVUzE3S1BtYldEVFpRN25FSXVzMDlRMC9ndlVkcUJlQ0xVeTlP?=
 =?utf-8?B?enpqVWJPTE1BOGZIUDlUWTNkbGhPQVUyKzNRNVlTOEU0YzBocERHMzhSUXpx?=
 =?utf-8?Q?mJI1SVP2i+z+Fpm3L8LOAjCtG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2PR04MB3592.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7d4da4-7bc2-462d-8a9d-08db44a945ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 09:50:01.2101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WRY0myVsa2V5uCKzRp+LSKOnMq6/21TqH5S6Q4PYuX55SZLMDa8DuqdPJwQi2LN8i3hUuvMFeXbIOyXjZ3vWYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB5896
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgQXByaWwg
MTAsIDIwMjMgMTE6MjEgUE0NCj4gVG86IERlbHBoaW5lX0NDX0NoaXUvV1lIUS9XaXd5bm4gPERl
bHBoaW5lX0NDX0NoaXVAd2l3eW5uLmNvbT47DQo+IHBhdHJpY2tAc3R3Y3gueHl6OyBSb2IgSGVy
cmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraQ0KPiA8a3J6eXN6
dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPjsgSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5h
dT47IEFuZHJldw0KPiBKZWZmZXJ5IDxhbmRyZXdAYWouaWQuYXU+DQo+IENjOiBkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0K
PiBsaW51eC1hc3BlZWRAbGlzdHMub3psYWJzLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDEvMl0gQVJNOiBkdHM6IGFzcGVlZDogZ3Jl
YXRsYWtlczogQWRkIGdwaW8gbmFtZXMNCj4gDQo+ICAgU2VjdXJpdHkgUmVtaW5kZXI6IFBsZWFz
ZSBiZSBhd2FyZSB0aGF0IHRoaXMgZW1haWwgaXMgc2VudCBieSBhbiBleHRlcm5hbA0KPiBzZW5k
ZXIuDQo+IA0KPiBPbiAxMC8wNC8yMDIzIDA5OjExLCBEZWxwaGluZV9DQ19DaGl1L1dZSFEvV2l3
eW5uIHdyb3RlOg0KPiA+IFRoYW5rIHlvdSBmb3IgcmV2aWV3aW5nLg0KPiA+DQo+ID4+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGty
enlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gPj4gU2VudDogV2VkbmVzZGF5LCBNYXJj
aCAyOSwgMjAyMyA0OjM3IFBNDQo+ID4+IFRvOiBEZWxwaGluZV9DQ19DaGl1L1dZSFEvV2l3eW5u
DQo+IDxEZWxwaGluZV9DQ19DaGl1QHdpd3lubi5jb20+Ow0KPiA+PiBwYXRyaWNrQHN0d2N4Lnh5
ejsgUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IEtyenlzenRvZg0KPiA+PiBLb3ps
b3dza2kgPGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZz47IEpvZWwgU3RhbmxleQ0K
PiA+PiA8am9lbEBqbXMuaWQuYXU+OyBBbmRyZXcgSmVmZmVyeSA8YW5kcmV3QGFqLmlkLmF1Pg0K
PiA+PiBDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZzsNCj4gPj4gbGludXgtYXNwZWVkQGxpc3RzLm96bGFicy5vcmc7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAx
LzJdIEFSTTogZHRzOiBhc3BlZWQ6IGdyZWF0bGFrZXM6IEFkZCBncGlvDQo+ID4+IG5hbWVzDQo+
ID4+DQo+ID4+ICAgU2VjdXJpdHkgUmVtaW5kZXI6IFBsZWFzZSBiZSBhd2FyZSB0aGF0IHRoaXMg
ZW1haWwgaXMgc2VudCBieSBhbg0KPiA+PiBleHRlcm5hbCBzZW5kZXIuDQo+ID4+DQo+ID4+IE9u
IDI5LzAzLzIwMjMgMTA6MzIsIERlbHBoaW5lIENDIENoaXUgd3JvdGU6DQo+ID4+PiBGcm9tOiBE
ZWxwaGluZSBDQyBDaGl1IDxEZWxwaGluZV9DQ19DaGl1QHdpd3lubi5jb20+DQo+ID4+Pg0KPiA+
Pj4gQWRkIEdQSU8gbmFtZXMgZm9yIFNPQyBsaW5lcy4NCj4gPj4+DQo+ID4+PiBTaWduZWQtb2Zm
LWJ5OiBEZWxwaGluZSBDQyBDaGl1IDxEZWxwaGluZV9DQ19DaGl1QHdpd3lubi5jb20+DQo+ID4+
PiAtLS0NCj4gPj4+ICAuLi4vZHRzL2FzcGVlZC1ibWMtZmFjZWJvb2stZ3JlYXRsYWtlcy5kdHMg
ICAgfCA0OQ0KPiA+PiArKysrKysrKysrKysrKysrKysrDQo+ID4+PiAgMSBmaWxlIGNoYW5nZWQs
IDQ5IGluc2VydGlvbnMoKykNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9v
dC9kdHMvYXNwZWVkLWJtYy1mYWNlYm9vay1ncmVhdGxha2VzLmR0cw0KPiA+Pj4gYi9hcmNoL2Fy
bS9ib290L2R0cy9hc3BlZWQtYm1jLWZhY2Vib29rLWdyZWF0bGFrZXMuZHRzDQo+ID4+PiBpbmRl
eCA4YzA1YmQ1NmNlMWUuLjU5ODE5MTE1YzM5ZCAxMDA2NDQNCj4gPj4+IC0tLSBhL2FyY2gvYXJt
L2Jvb3QvZHRzL2FzcGVlZC1ibWMtZmFjZWJvb2stZ3JlYXRsYWtlcy5kdHMNCj4gPj4+ICsrKyBi
L2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC1ibWMtZmFjZWJvb2stZ3JlYXRsYWtlcy5kdHMNCj4g
Pj4+IEBAIC0yMzgsNCArMjM4LDUzIEBADQo+ID4+PiAgJmdwaW8wIHsNCj4gPj4+ICAgICAgIHBp
bmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ID4+PiAgICAgICBwaW5jdHJsLTAgPSA8JnBpbmN0
cmxfZ3BpdTFfZGVmYXVsdCAmcGluY3RybF9ncGl1N19kZWZhdWx0PjsNCj4gPj4+ICsgICAgIHN0
YXR1cyA9ICJva2F5IjsNCj4gPj4NCj4gPj4gV2FzIGl0IGRpc2FibGVkIGJlZm9yZT8NCj4gPj4N
Cj4gPiBZZXMsDQo+IA0KPiBSZWFsbHk/IENhbiB5b3UgcHJvdmlkZSBhbnkgcHJvb2YgZm9yIHRo
aXM/DQpDb3JyZWN0IHRoZSBhbnN3ZXIgYWZ0ZXIgdmVyaWZ5aW5nIC0gd2hlbiBncGlvMCBzdGF0
dXMgcHJvcGVydHkgaXMgbm90IGRlZmluZWQsIGl0IGxlYWRzIHRvIGRldmljZSBkZWZhdWx0IGVu
YWJsZWQuDQo+IA0KPiA+IHdlIGhhdmUgdG8gZW5hYmxlIGdwaW8gc3RhdHVzIGZvciBtZWV0aW5n
IGFzcGVlZC1nNiBkZXZpY2UgdHJlZSBzZXR0aW5nLA0KPiBhbmQgc2V0IG5ldCBuYW1lcyBmb3Ig
cHVsbGluZyBncGlvIHBpbiBmcm9tIGFwcGxpY2F0aW9uIGxheWVyLg0KPiANCj4gV2hhdCBpcyAi
ZW5hYmxlIGdwaW8gc3RhdHVzIj8gV2hhdCBkb2VzIGl0IG1lYW4gdG8gIm1lZXQgYXNwZWVnLWc2
DQo+IGRldmljZXRyZWUgc2V0dGluZyI/DQo+IFdoYXQgbmFtZXMgaGF2ZSBhbnl0aGluZyB0byBk
byB3aXRoIG15IHF1ZXN0aW9uPw0KPiANCj4gU29ycnksIEkgY2Fubm90IHBhcnNlIGl0IGF0IGFs
bC4NClRvIGRlc2NyaWJlIG1vcmUgcHJlY2lzZWx5LCBJIHN1cnZleWVkIHRoZSBpZGVudGlmaWNh
dGlvbiBvZiBvZl9kZXZpY2VfaXNfYXZhaWxhYmxlKCkgaW4gZHJpdmVycy9vZi9iYXNlLmMuDQpJ
dCByZXR1cm5zIHRydWUgaWYgdGhlIHN0YXR1cyBwcm9wZXJ0eSBpcyBhYnNlbnQgb3Igc2V0IHRv
ICJva2F5IiBvciAib2siLCBhbmQgZmFsc2Ugb3RoZXJ3aXNlLg0KQmVjYXVzZSBncGlvMCBzdGF0
dXMgcHJvcGVydHkgaGFzbuKAmXQgZGVmaW5lZCBpbiBhc3BlZWQtZzYuZHRzaSwgSSBzZXQgdG8g
Im9rYXkiIHRvIHByZXZlbnQgdGhhdCBpZiBpdCB3YXMgZGlzYWJsZWQgZnJvbSBvdGhlciBhc3Np
Z25tZW50Lg0KPiANCj4gPj4+ICsgICAgIGdwaW8tbGluZS1uYW1lcyA9DQo+ID4+PiArICAgICAv
KkEwLUE3Ki8gIiIsIiIsIiIsIiIsIiIsIiIsIiIsIiIsDQo+ID4+PiArICAgICAvKkIwLUI3Ki8g
InBvd2VyLWJtYy1uaWMiLCJwcmVzZW5jZS1vY3AtZGVidWciLA0KPiA+Pj4gKyAgICAgICAgICAg
ICAgICJwb3dlci1ibWMtc2xvdDEiLCJwb3dlci1ibWMtc2xvdDIiLA0KPiA+Pj4gKyAgICAgICAg
ICAgICAgICJwb3dlci1ibWMtc2xvdDMiLCJwb3dlci1ibWMtc2xvdDQiLCIiLCIiLA0KPiA+Pj4g
KyAgICAgLypDMC1DNyovICJwcmVzZW5jZS1vY3AtbmljIiwiIiwiIiwicmVzZXQtY2F1c2Utbmlj
LXByaW1hcnkiLA0KPiA+Pj4gKyAgICAgICAgICAgICAgICJyZXNldC1jYXVzZS1uaWMtc2Vjb25k
YXJ5IiwiIiwiIiwiIiwNCj4gPj4+ICsgICAgIC8qRDAtRDcqLyAiIiwiIiwiIiwiIiwiIiwiIiwi
IiwiIiwNCj4gPj4+ICsgICAgIC8qRTAtRTcqLyAiIiwiIiwiIiwiIiwiIiwiIiwiIiwiIiwNCj4g
Pj4+ICsgICAgIC8qRjAtRjcqLyAic2xvdDEtYm1jLXJlc2V0LWJ1dHRvbiIsInNsb3QyLWJtYy1y
ZXNldC1idXR0b24iLA0KPiA+Pj4gKyAgICAgICAgICAgICAgICJzbG90My1ibWMtcmVzZXQtYnV0
dG9uIiwic2xvdDQtYm1jLXJlc2V0LWJ1dHRvbiIsDQo+ID4+PiArICAgICAgICAgICAgICAgIiIs
IiIsIiIsInByZXNlbmNlLWVtbWMiLA0KPiA+Pj4gKyAgICAgLypHMC1HNyovICIiLCIiLCIiLCIi
LCIiLCIiLCIiLCIiLA0KPiA+Pj4gKyAgICAgLypIMC1INyovICIiLCIiLCIiLCIiLA0KPiA+Pj4g
KyAgICAgICAgICAgICAgICJwcmVzZW5jZS1tYi1zbG90MSIsInByZXNlbmNlLW1iLXNsb3QyIiwN
Cj4gPj4+ICsgICAgICAgICAgICAgICAicHJlc2VuY2UtbWItc2xvdDMiLCJwcmVzZW5jZS1tYi1z
bG90NCIsDQo+ID4+PiArICAgICAvKkkwLUk3Ki8gIiIsIiIsIiIsIiIsIiIsIiIsImJiLWJtYy1i
dXR0b24iLCIiLA0KPiA+Pj4gKyAgICAgLypKMC1KNyovICIiLCIiLCIiLCIiLCIiLCIiLCIiLCIi
LA0KPiA+Pj4gKyAgICAgLypLMC1LNyovICIiLCIiLCIiLCIiLCIiLCIiLCIiLCIiLA0KPiA+Pj4g
KyAgICAgLypMMC1MNyovICIiLCIiLCIiLCIiLCIiLCIiLCIiLCIiLA0KPiA+Pj4gKyAgICAgLypN
MC1NNyovDQo+ID4+ICIiLCJwb3dlci1uaWMtYm1jLWVuYWJsZSIsIiIsInVzYi1ibWMtZW5hYmxl
IiwiIiwicmVzZXQtY2F1c2UtdXNiLWh1Yg0KPiA+PiAiLCIiLCIiLA0KPiA+Pj4gKyAgICAgLypO
MC1ONyovICIiLCIiLCIiLCIiLCJibWMtcmVhZHkiLCIiLCIiLCIiLA0KPiA+Pj4gKyAgICAgLypP
MC1PNyovDQo+ID4+ICIiLCIiLCIiLCIiLCIiLCIiLCJmYW4wLWJtYy1jcGxkLWVuYWJsZSIsImZh
bjEtYm1jLWNwbGQtZW5hYmxlIiwNCj4gPj4+ICsgICAgIC8qUDAtUDcqLyAiZmFuMi1ibWMtY3Bs
ZC1lbmFibGUiLCJmYW4zLWJtYy1jcGxkLWVuYWJsZSIsDQo+ID4+PiArICAgICAgICAgICAgICAg
InJlc2V0LWNhdXNlLXBjaWUtc2xvdDEiLCJyZXNldC1jYXVzZS1wY2llLXNsb3QyIiwNCj4gPj4+
ICsNCj4gInJlc2V0LWNhdXNlLXBjaWUtc2xvdDMiLCJyZXNldC1jYXVzZS1wY2llLXNsb3Q0Iiwi
IiwiIiwNCj4gPj4+ICsgICAgIC8qUTAtUTcqLyAiIiwiIiwiIiwiIiwiIiwiIiwiIiwiIiwNCj4g
Pj4+ICsgICAgIC8qUjAtUjcqLyAiIiwiIiwiIiwiIiwiIiwiIiwiIiwiIiwNCj4gPj4+ICsgICAg
IC8qUzAtUzcqLyAiIiwiIiwicG93ZXItcDV2LXVzYiIsInByZXNlbmNlLWJtYy10cG0iLCIiLCIi
LCIiLCIiLA0KPiA+Pj4gKyAgICAgLypUMC1UNyovICIiLCIiLCIiLCIiLCIiLCIiLCIiLCIiLA0K
PiA+Pj4gKyAgICAgLypVMC1VNyovICIiLCIiLCIiLCIiLCIiLCIiLCIiLCJHTkQiLA0KPiA+Pj4g
KyAgICAgLypWMC1WNyovICJibWMtc2xvdDEtYWMtYnV0dG9uIiwiYm1jLXNsb3QyLWFjLWJ1dHRv
biIsDQo+ID4+PiArICAgICAgICAgICAgICAgImJtYy1zbG90My1hYy1idXR0b24iLCJibWMtc2xv
dDQtYWMtYnV0dG9uIiwNCj4gPj4+ICsgICAgICAgICAgICAgICAiIiwiIiwiIiwiIiwNCj4gPj4+
ICsgICAgIC8qVzAtVzcqLyAiIiwiIiwiIiwiIiwiIiwiIiwiIiwiIiwNCj4gPj4+ICsgICAgIC8q
WDAtWDcqLyAiIiwiIiwiIiwiIiwiIiwiIiwiIiwiIiwNCj4gPj4+ICsgICAgIC8qWTAtWTcqLyAi
IiwiIiwiIiwicmVzZXQtY2F1c2UtZW1tYyIsIiIsIiIsIiIsIiIsDQo+ID4+PiArICAgICAvKlow
LVo3Ki8gIiIsIiIsIiIsIiIsIiIsIiIsIiIsIiI7IH07DQo+ID4+PiArDQo+ID4+PiArJmdwaW8x
IHsNCj4gPj4+ICsgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4gPj4NCj4gPj4gU2FtZSBxdWVzdGlv
bi4uLg0KPiA+IFllcywgdGhlIGFuc3dlciBpcyBzYW1lIGFzIGFib3ZlLg0KPiANCj4gU28gdGhl
IHNhbWUgaW5jb3JyZWN0Pw0KVGhlIHN0YXR1cyBwcm9wZXJ0eSBvZiBncGlvMSB3YXMgYWxzbyBk
ZWZhdWx0IGVuYWJsZWQuDQpGb3Igc2FtZSByZWFzb24gYXMgZ3BpbzAsIEkgc2V0IHRvICJva2F5
IiBmcm9tIHRoaXMgcGF0Y2guDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YN
Cg0K
