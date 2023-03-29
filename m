Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DF66CD2C4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjC2HQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjC2HQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:16:25 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2040.outbound.protection.outlook.com [40.107.247.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22183ABB;
        Wed, 29 Mar 2023 00:16:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAY3RLX9YWnn+MJoEyJA/IdXoWo5laMxIgMOXIPMt9soAROGZB0RHN9sxvvrbEV7JYdGar56ZC4Yb5EHp2AZXlMEn3mD2PM80b+XucL6+JtkyJH3xN2e92c8yrHoN5IqDSIvI3pT5X9jWenkMHm7qbpwJENxmO/c+QKx1ldaMV5izzhQiJxkDqWJZMaSJoJu5RASd4UtjhbrpvCBUrcR+B/GVk0Wd7rh6sKsioE1uCxR0xjf6mKG0QJMLtTEfIrYaAut1nLIn0EI0ukp/0qQB1AllCmTAdtaofsLDQeS5kTUfp6T6O1A8DpjxYeglz9wKWO27+Wh80c4QZJxUFjnHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qhbN9XniCauROpX0SIIXfqTZRnFOA19UnypfdjwceU=;
 b=mizH7+iHzqioHmJFvSsMkIamBwawE7A64p6yMcXv/cyWndrxK42ZEg2xvLanFtzGbque1+XqlsgrepmLxVe9XEBbTbdWGND0CTW+5OjqJHdZkSdOr00JrPXSPdKphCN6IhP38TNq32JirYH2tt5z6zRfX1NMKEhSKnRW/6SSxFUaoWVN52h/44vrxbjtYEu6U+YUdvbqDXcKRa/Jwpxc0GXRkWjVhWzk9C8nKZ8p8fY7XSDW7gcWtLLER8by8sSXxgj0HsQ4wwMr8zfJrFvpW2H7h2edcv6fiGcPRDEwoi34to1ucnPhn61V9vaAhanew1cxVBCBo1HIifUY4fTYtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qhbN9XniCauROpX0SIIXfqTZRnFOA19UnypfdjwceU=;
 b=p9dImjAcpFlEsS3WQ9f1zvEmhn3QiOqvFZ8mj+rWb7R/ayk3OTlMkVM9V1N5u3omjO1QVbymBsVcw/LchyfGNZq5QfCBEvtno+GorD7qfPJWjNn4pufI9dRsnVgT8x76sb9FytL+/X5rE0k//LVK+L6tw/WLCGEC4xvLJs5/Slk=
Received: from PA4PR04MB9640.eurprd04.prod.outlook.com (2603:10a6:102:261::21)
 by DBBPR04MB7676.eurprd04.prod.outlook.com (2603:10a6:10:20e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 07:16:17 +0000
Received: from PA4PR04MB9640.eurprd04.prod.outlook.com
 ([fe80::5c99:52d9:e4c3:3318]) by PA4PR04MB9640.eurprd04.prod.outlook.com
 ([fe80::5c99:52d9:e4c3:3318%5]) with mapi id 15.20.6222.033; Wed, 29 Mar 2023
 07:16:14 +0000
From:   Jun Li <jun.li@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: RE: [PATCH] dt-bindings: usb: typec-tcpci: convert to DT schema
 format
Thread-Topic: [PATCH] dt-bindings: usb: typec-tcpci: convert to DT schema
 format
Thread-Index: AQHZXVQoc6CE6PVfa0OMBVFP1XlRAa8ORFEAgAGnVtCAAB3bAIABTwcg
Date:   Wed, 29 Mar 2023 07:16:14 +0000
Message-ID: <PA4PR04MB9640866667BFFF292F06388589899@PA4PR04MB9640.eurprd04.prod.outlook.com>
References: <20230323065824.3857573-1-peng.fan@oss.nxp.com>
 <5675373c-af4f-906f-9906-7853a85f8ed6@linaro.org>
 <PA4PR04MB96405A3B0B5158561D9E068F89889@PA4PR04MB9640.eurprd04.prod.outlook.com>
 <aec9e01b-c358-0982-3090-ef980d4a5623@linaro.org>
In-Reply-To: <aec9e01b-c358-0982-3090-ef980d4a5623@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9640:EE_|DBBPR04MB7676:EE_
x-ms-office365-filtering-correlation-id: 8e041af7-0e7e-4910-715b-08db30257b4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ERpk139wvqHVGwiSBBsAt6L2F514/8Pw7lRhnP2WQ8xWOcJLF/jrio0eNoqNqflL7B2CWTNkJLkI64xcLoLlDCngJw+OFswaGsexNQoO8hpA1vrC0fT5O2b4rGI9zy+nAFyCSdU/Lh9DQKf/uKlyT0U1jtN0xKZ1SlvmiAcHi/dGjoI7GLZevKBD3aj9OLagt+T+UTb6FEW5KLE05IlJ+fEHuoKOfNGH40mp1QkgRn78CqRcGSaeKknmtyy+Tgk4wjBvkXs+fcp3Sod2G7q0HsJBQibrpR/tZJSe+EGc15tyPUaQ2u3I+q7FUR2UFtX8a558VtTUhRKewJLpIVlO4mzEKZ1qyVPWTnD2b6k0BEFCHgpKyf2ypZFvDC0QMlv3ojmZC3X5/5B39ZLhRT5PtwErq9jzn+U3AVKABAkdXO/9vrlQZQo5VODSt5hwws+5fP+HFuWtSaPhB+2x8hQlxqwUxZecZPR9C9f6Cp3TiII7gllBYwNN37uF9iqTD4OkBkUQe2eVQQCasgUbXGhz4acFdJdYUnyXbeyJncxlVVgqk4IVXLBpY9fciPUsPcYWJe43Of8zTfZIVcX23YuZD4Bj8Pg3hXH5V0OoZpkOCkZD8eyqIsoJhyc/9VMxxHik
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9640.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199021)(83380400001)(6506007)(122000001)(26005)(53546011)(54906003)(478600001)(52536014)(38070700005)(316002)(71200400001)(7696005)(110136005)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(8676002)(55016003)(86362001)(41300700001)(9686003)(38100700002)(33656002)(44832011)(5660300002)(8936002)(2906002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTBNamVERjJUREpvK1Z4RXpJQml0V2kvQTQwdis5N3J5NUJkeTYvSzVWSmFn?=
 =?utf-8?B?ek02dFRRNTRZeHhWbFF2cDlWVGhaOTJJZ1BzbndQNURpV2N4L3JxSTE0cFlv?=
 =?utf-8?B?SzFlelEvNlJTZ3JKUHpxVmlWWGJqN0p0cnFZMlQrSEQ4SzdyRkxsRHo2aTVm?=
 =?utf-8?B?ejVLcDhVVjd2dmUzMDJDRDBCQnMyVnQwUjZRNmVMd2pmbENTL0NmSUR6MkxT?=
 =?utf-8?B?bENHVVczYm1GY2dRSDBiU0VZTTZ0RExScXdDeG5QS2JXL1prN0hsRy80eDF3?=
 =?utf-8?B?WW9rNFM4RGUzQ3NQaFRpSEFycExNVWlHNTQyd0d0TGE5YkNqdkk1L2JFV05h?=
 =?utf-8?B?TW9iRFFDZVZCdWxNQVpjTm5hTEJraTVZODJqeERaNm43Nkp2dzAxK3c3eUpw?=
 =?utf-8?B?S1F6RDFoWlpEUW1rZnUrTGRNWGRvdlFRMUQ5c0drd29iM2owR1NxMHNzRG91?=
 =?utf-8?B?L05nOEdqRWtCc0tSOHZSd2FJS0dsSFdCT3JBRFlXOVhaWlhlbTFJUWg4MUtP?=
 =?utf-8?B?VWpkMXBQZWFZd3NqbUJkZnpPVlpuWkVtTCtaU2hXR3YrdXVhMzVoTkMvMmZy?=
 =?utf-8?B?VUlUQ0ZmS0VyL2VQZ1R1cUlCbXM3YkZIRkdndEJhZTR1aVZycWhiZEZYNk0x?=
 =?utf-8?B?TlczZ2xmeHJjeUhhc29BNGxoNlVIRTRiTml3dGZOYnJVR0hLaExBbzFRcUVV?=
 =?utf-8?B?UFZnTVhkMHpIbnNna2FGWjE2OTNsaTVWRkdkdW5IVWVMNkM3Yi9mVUUvLzZ6?=
 =?utf-8?B?UDZrOFliMWhFSU9uUE9vamVzT1ozTXRpZ1RpMS9WZGZQeXpSR0dJUi9uL1Fq?=
 =?utf-8?B?bjlvSElrSVdZS20xWkhteklqODFIK2daNStydkxMcGJwRmVGNmdGaXdQay9V?=
 =?utf-8?B?RUI3QXRBVU44dW1yS1NUTWoyYzFJU1c4MUtQSkxqUkl5Wmhvd09zcnQ3bzV6?=
 =?utf-8?B?VWlGa3V4dFdlakQwM3BCWS9TTFdiQkZiT2lNcWpzbkdoUGpEWVJNeVA1NWlW?=
 =?utf-8?B?SC9xSTdQaVdHWmFMOFFqaXA5c2IrQnlFbkVtY09tRFpYTlZUQnFSUHFwcEpx?=
 =?utf-8?B?MXZNdG1FQlIwcFZRMWJpc3IxcFBGajYyaU9EdWw5S1VVQUN1cWNnSEljdWYz?=
 =?utf-8?B?cjU1TnhKWUswVThJUUthTDFXSzFlNFJjU0lEb0d3YVgwanFvM1ZLSUtVUFhK?=
 =?utf-8?B?QXRoOUoyNlBWci9NTURKYldBLzRnVVNIZHkwM0hKeVFDUnR0V0U1SW9QcTVw?=
 =?utf-8?B?d0x2Z2tWclpZNXd0amN5dXpEaTFiZ0RUdDdXK0oxYmVVcEFRMUlvT29aQXZ1?=
 =?utf-8?B?ZW9wMlRjcGZMaDBIVElUaXV2Kyt4d3ZUZFVjRlZTZjI3Vm5MdFE2Qnc3WVRn?=
 =?utf-8?B?V3drZ0gzRlI1MmlralVGSSs4amVteS9ERk5QUVkzc3dsNjROZ0h0aWN2aXVi?=
 =?utf-8?B?clNyWkpUQUhSWXAwVjFSdzhoZ1l4NUhiMWZUM3lBaGx0eE5BRnp6VUlzS0Rt?=
 =?utf-8?B?N1FER3BFcnhVeHAxa0pRVlN5R05qTGlhNUFaL1huQTNkbU1wYjhPYkVKL29Y?=
 =?utf-8?B?Rk9BaGR6dnVTRzhsVmJhT2xKWEtadkpHdEM0R3pqem4xRzNHVzFJVXRndE4v?=
 =?utf-8?B?U2xsU2NZN05Cd212Y3k4RDNQQmJaeW5BTlhmbTNyU3lNZ21ERkczdTJYN052?=
 =?utf-8?B?RTFNYjBOQXBzdU1WckljbEdmNmZIaVp1MGlNZ0RkUDU5VEdDS3RURGVXZFp0?=
 =?utf-8?B?bmloUjJBOU1iZ2UvQkQ5MC9WS2FOSW02TXBTODJkNWxTQlJkNnZ4R0dCVlFy?=
 =?utf-8?B?WDRHOTQ3R3lyQjJvUk0zV0YxQllWMzFsR3U1MWNIWk9RRitTeWIzdEU2Ly9G?=
 =?utf-8?B?bkFOK3NCZEN3MUhkZ1VqNmJZMHc0aUtjbnk0OHRVRVVZVWJHS3Z4NWVKM2I3?=
 =?utf-8?B?Y21UVzU4VXlGTWJWeHpTRW5aVG5MTFVhS3ZmS29TQXZzekF4bkFhRDdFQ0xp?=
 =?utf-8?B?dFJhRzd1TnlJa2VnN2s1azBqRVBHYnM1M1ptSVZRbjB3ZCtMRmVwUXFDYzdN?=
 =?utf-8?B?ZkRvdE9iNS94dWc1UVlLZWlUdlRnbnE0eWxjVWQ3bDRzbWtFdzBqVC8vN0ZD?=
 =?utf-8?Q?3GJE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9640.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e041af7-0e7e-4910-715b-08db30257b4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 07:16:14.3359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rZoXIJ5Ev1S8TtwPyV1Sim7EfWi5IlR6gnsr6IwIbsC/Z6Rh+gnr4oaSIgWrsJWR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7676
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBN
YXJjaCAyOCwgMjAyMyA2OjQzIFBNDQo+IFRvOiBKdW4gTGkgPGp1bi5saUBueHAuY29tPjsgUGVu
ZyBGYW4gKE9TUykgPHBlbmcuZmFuQG9zcy5ueHAuY29tPjsNCj4gcm9iaCtkdEBrZXJuZWwub3Jn
OyBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7DQo+IGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnDQo+IENjOiBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgUGVuZyBGYW4g
PHBlbmcuZmFuQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGR0LWJpbmRpbmdzOiB1
c2I6IHR5cGVjLXRjcGNpOiBjb252ZXJ0IHRvIERUIHNjaGVtYQ0KPiBmb3JtYXQNCj4gDQo+IE9u
IDI4LzAzLzIwMjMgMTE6MjQsIEp1biBMaSB3cm90ZToNCj4gPiBIaSBLcnp5c3p0b2YsDQo+ID4+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gPj4gU2VudDogTW9uZGF5LCBN
YXJjaCAyNywgMjAyMyAzOjQxIFBNDQo+ID4+IFRvOiBQZW5nIEZhbiAoT1NTKSA8cGVuZy5mYW5A
b3NzLm54cC5jb20+OyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+ID4+IGtyenlzenRvZi5rb3psb3dz
a2krZHRAbGluYXJvLm9yZzsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IEp1biBMaQ0KPiA+
PiA8anVuLmxpQG54cC5jb20+DQo+ID4+IENjOiBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnOyBk
ZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gPj4gbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFU
Q0hdIGR0LWJpbmRpbmdzOiB1c2I6IHR5cGVjLXRjcGNpOiBjb252ZXJ0IHRvIERUDQo+ID4+IHNj
aGVtYSBmb3JtYXQNCj4gPj4NCj4gPj4gT24gMjMvMDMvMjAyMyAwNzo1OCwgUGVuZyBGYW4gKE9T
Uykgd3JvdGU6DQo+ID4+PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPj4+
DQo+ID4+PiBDb252ZXJ0IHRoZSBiaW5kaW5nIHRvIERUIHNjaGVtYSBmb3JtYXQuIFRoZSBkZWZh
dWx0IHNwZWVkIGlzIEhTLCBzbw0KPiA+Pj4gYWRkIGEgZHVtbXkgcG9ydEAwIGluIHRoZSBleGFt
cGxlLg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAu
Y29tPg0KPiA+Pj4gLS0tDQo+ID4+Pg0KPiA+Pj4gVjE6DQo+ID4+PiAgVGhlIGRlZmF1bHQgc3Bl
ZWQgaXMgSFMsIHNvIHBvcnRAMCBpcyBub3QgYWRkZWQgZm9yIHNvbWUgZGV2aWNlDQo+ID4+PiB0
cmVlLCBob3dldmVyIHRoZSB1c2ItYy1jb25uZWN0b3IgcmVxdWlyZXMgcG9ydEAwLiBOb3Qgc3Vy
ZSB3ZQ0KPiA+Pj4gc2hvdWxkIGRyb3AgdGhlIHJlcXVpcmVkIHBvcnRAMCBmcm9tIHVzYi1jLWNv
bm5lY3RvciBzY2hlbWEgb3IgYWRkIGENCj4gPj4+IGR1bW15IHBvcnRAMCBmb3IgdGNwY2kgYXMg
d2hhdCB0aGlzIHBhdGNoIGRvZXMuDQo+ID4+DQo+ID4+IGlteDhtcS1saWJyZW01LWRldmtpdCBo
YXMgZnVsbCBwb3J0QDAgc28ganVzdCB1c2Ugc2ltaWxhciBhcHByb2FjaC4NCj4gPj4NCj4gPj4+
DQo+ID4+PiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3R5cGVjLXRjcGNpLnR4dCAgIHwg
NDkgLS0tLS0tLS0tLS0tDQo+ID4+PiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3R5cGVj
LXRjcGNpLnlhbWwgIHwgODANCj4gPj4+ICsrKysrKysrKysrKysrKysrKysNCj4gPj4+ICAyIGZp
bGVzIGNoYW5nZWQsIDgwIGluc2VydGlvbnMoKyksIDQ5IGRlbGV0aW9ucygtKSAgZGVsZXRlIG1v
ZGUNCj4gPj4+IDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3R5
cGVjLXRjcGNpLnR4dA0KPiA+Pj4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+Pj4gRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi90eXBlYy10Y3BjaS55YW1sDQo+ID4+Pg0KPiA+
Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvdHlw
ZWMtdGNwY2kudHh0DQo+ID4+PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91
c2IvdHlwZWMtdGNwY2kudHh0DQo+ID4+PiBkZWxldGVkIGZpbGUgbW9kZSAxMDA2NDQNCj4gPj4+
IGluZGV4IDIwODI1MjJiMWMzMi4uMDAwMDAwMDAwMDAwDQo+ID4+PiAtLS0gYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3R5cGVjLXRjcGNpLnR4dA0KPiA+Pj4gKysrIC9k
ZXYvbnVsbA0KPiA+Pj4gQEAgLTEsNDkgKzAsMCBAQA0KPiA+Pj4gLVRDUENJKFR5cGVjIHBvcnQg
Y290cm9sbGVyIGludGVyZmFjZSkgYmluZGluZw0KPiA+Pj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+Pj4gLQ0KPiA+Pj4gLVJlcXVpcmVkIHByb3Bl
cnRpZXM6DQo+ID4+PiAtLSBjb21wYXRpYmxlOiAgICAgICBzaG91bGQgYmUgc2V0IG9uZSBvZiBm
b2xsb3dpbmc6DQo+ID4+PiAtCQkgICAgLSAibnhwLHB0bjUxMTAiIGZvciBOWFAgVVNCIFBEIFRD
UEMgUEhZIElDIHB0bjUxMTAuDQo+ID4+PiAtDQo+ID4+PiAtLSByZWc6ICAgICAgICAgICAgICB0
aGUgaTJjIHNsYXZlIGFkZHJlc3Mgb2YgdHlwZWMgcG9ydCBjb250cm9sbGVyIGRldmljZS4NCj4g
Pj4+IC0tIGludGVycnVwdC1wYXJlbnQ6IHRoZSBwaGFuZGxlIHRvIHRoZSBpbnRlcnJ1cHQgY29u
dHJvbGxlciB3aGljaA0KPiBwcm92aWRlcw0KPiA+Pj4gLSAgICAgICAgICAgICAgICAgICAgdGhl
IGludGVycnVwdC4NCj4gPj4+IC0tIGludGVycnVwdHM6ICAgICAgIGludGVycnVwdCBzcGVjaWZp
Y2F0aW9uIGZvciB0Y3BjaSBhbGVydC4NCj4gPj4+IC0NCj4gPj4+IC1SZXF1aXJlZCBzdWItbm9k
ZToNCj4gPj4+IC0tIGNvbm5lY3RvcjogVGhlICJ1c2ItYy1jb25uZWN0b3IiIGF0dGFjaGVkIHRv
IHRoZSB0Y3BjaSBjaGlwLCB0aGUNCj4gPj4+IGJpbmRpbmdzDQo+ID4+PiAtICBvZiBjb25uZWN0
b3Igbm9kZSBhcmUgc3BlY2lmaWVkIGluDQo+ID4+PiAtICBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvY29ubmVjdG9yL3VzYi1jb25uZWN0b3IueWFtbA0KPiA+Pj4gLQ0KPiA+Pj4g
LUV4YW1wbGU6DQo+ID4+PiAtDQo+ID4+PiAtcHRuNTExMEA1MCB7DQo+ID4+PiAtCWNvbXBhdGli
bGUgPSAibnhwLHB0bjUxMTAiOw0KPiA+Pj4gLQlyZWcgPSA8MHg1MD47DQo+ID4+PiAtCWludGVy
cnVwdC1wYXJlbnQgPSA8JmdwaW8zPjsNCj4gPj4+IC0JaW50ZXJydXB0cyA9IDwzIElSUV9UWVBF
X0xFVkVMX0xPVz47DQo+ID4+PiAtDQo+ID4+PiAtCXVzYl9jb246IGNvbm5lY3RvciB7DQo+ID4+
PiAtCQljb21wYXRpYmxlID0gInVzYi1jLWNvbm5lY3RvciI7DQo+ID4+PiAtCQlsYWJlbCA9ICJV
U0ItQyI7DQo+ID4+PiAtCQlkYXRhLXJvbGUgPSAiZHVhbCI7DQo+ID4+PiAtCQlwb3dlci1yb2xl
ID0gImR1YWwiOw0KPiA+Pj4gLQkJdHJ5LXBvd2VyLXJvbGUgPSAic2luayI7DQo+ID4+PiAtCQlz
b3VyY2UtcGRvcyA9IDxQRE9fRklYRUQoNTAwMCwgMjAwMCwgUERPX0ZJWEVEX1VTQl9DT01NKT47
DQo+ID4+PiAtCQlzaW5rLXBkb3MgPSA8UERPX0ZJWEVEKDUwMDAsIDIwMDAsIFBET19GSVhFRF9V
U0JfQ09NTSkNCj4gPj4+IC0JCQkgICAgIFBET19WQVIoNTAwMCwgMTIwMDAsIDIwMDApPjsNCj4g
Pj4+IC0JCW9wLXNpbmstbWljcm93YXR0ID0gPDEwMDAwMDAwPjsNCj4gPj4+IC0NCj4gPj4+IC0J
CXBvcnRzIHsNCj4gPj4+IC0JCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gPj4+IC0JCQkjc2l6
ZS1jZWxscyA9IDwwPjsNCj4gPj4+IC0NCj4gPj4+IC0JCQlwb3J0QDEgew0KPiA+Pj4gLQkJCQly
ZWcgPSA8MT47DQo+ID4+PiAtCQkJCXVzYl9jb25fc3M6IGVuZHBvaW50IHsNCj4gPj4+IC0JCQkJ
CXJlbW90ZS1lbmRwb2ludCA9IDwmdXNiM19kYXRhX3NzPjsNCj4gPj4+IC0JCQkJfTsNCj4gPj4+
IC0JCQl9Ow0KPiA+Pj4gLQkJfTsNCj4gPj4+IC0JfTsNCj4gPj4+IC19Ow0KPiA+Pj4gZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvdHlwZWMtdGNwY2ku
eWFtbA0KPiA+Pj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3R5cGVj
LXRjcGNpLnlhbWwNCj4gPj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4+PiBpbmRleCAwMDAw
MDAwMDAwMDAuLjA2N2QzYjAzMmUzZA0KPiA+Pj4gLS0tIC9kZXYvbnVsbA0KPiA+Pj4gKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi90eXBlYy10Y3BjaS55YW1sDQo+
ID4+DQo+ID4+IElzIHRoaXMgYSBiaW5kaW5nIGZvciBQVE41MTEwIG9yIGZvciBnZW5lcmljIHRj
cGNpPyBMb29rcyBsaWtlIHRoZQ0KPiA+PiBmaXJzdCwgdGh1cyBuYW1lIHNob3VsZCBiZSByYXRo
ZXIgZGV2aWNlIHNwZWNpZmljLCBzbyBueHAscHRuNTExMC4NCj4gPj4gU3BlY2lhbGx5IHRoYXQg
dGhlcmUgYXJlIG90aGVyIHRjcGNpIGNoaXBzIGluIHNlcGFyYXRlIGJpbmRpbmdzLg0KPiA+DQo+
ID4gVGhpcyBiaW5kaW5nIGRvYyBpcyB0YXJnZXQgZm9yIGdlbmVyaWMgdGNwY2ksIHB0bjUxMTAg
aXMgdGhlIG9uZQ0KPiANCj4gDQo+IERvZXMgdGhpcyBtZWFuIHRoYXQgVENQQ0kgcmVxdWlyZXMg
ZXZlcnkgZGV2aWNlIHRvIGhhdmUgZXhhY3RseSBvbmUgaW50ZXJydXB0DQo+IChubyAwLCBubyAy
LCBleGFjdGx5IDEpLCANCg0KUGVyIHNwZWMgYmVsb3csIFRDUENJIGRvZXMgbmVlZCBpbnRlcnJ1
cHQgZm9yIGFsZXJ0LCBidXQgbm8gbGltaXQgb24gdGhlIG51bWJlci4NCg0KIlRoZSBUQ1BDIHVz
ZXMgSTJDIHRvIGNvbW11bmljYXRlIHdpdGggdGhlIFRDUE0uIFRoZSBUQ1BDIGlzIGFuIEkyQyBz
bGF2ZQ0Kd2l0aCBBbGVydCMgc2lnbmFsIGZvciByZXF1ZXN0aW5nIGF0dGVudGlvbi4iDQoNCj4g
bm8gc3VwcGxpZXMgYW5kIG5vIGFkZGl0aW9uYWwgR1BJT3MgKGxpa2UgcmVzZXQNCj4gR1BJTyk/
DQoNClRob3NlIGFyZSBvdXQgb2Ygc2NvcGUgb2Ygc3BlYywgSSB0aGluayBpdCBjYW4gYmUgYWRk
ZWQgYXMgb3B0aW9uYWwuDQoNCj4gDQo+IEJlY2F1c2UgdGhpcyBpcyB3aGF0IHRoaXMgYmluZGlu
ZyBpcyBzYXlpbmcuDQo+IA0KPiA+IGZ1bGx5IGNvbXBsaWFuY2Ugd2l0aCB0Y3BjaSBzcGVjLCBp
ZiBjaGFuZ2UgaXQgdG8gYmUgb25seSBzcGVjaWZpYyB0bw0KPiA+IG54cCxwdG41MTEwLCBteSB1
bmRlcnN0YW5kaW5nIGlzIHRoZW4gb3RoZXIgY2hpcHMgbmVlZCBkdXBsaWNhdGUgYQ0KPiA+IGJp
bmRpbmcgZG9jIGV2ZW4gY29tbW9uIHRjcGNpIGJpbmRpbmcgYW5kIGRyaXZlciBpcyBlbm91Z2gg
Zm9yIHRoZW0uDQo+IA0KPiBEZXBlbmRzLiBVc3VhbGx5IHdlIGhhdmUgY29tbW9uIHNjaGVtYSB1
c2VkIGJ5IGFjdHVhbCBkZXZpY2Ugc2NoZW1hcy4gSWYNCj4gVENQQ0ktY29tcGxpYW50IGRldmlj
ZSBjYW5ub3QgaGF2ZSBhZGRpdGlvbmFsIHByb3BlcnRpZXMsDQoNCk15IHVuZGVyc3RhbmRpbmcg
d2FzIFRDUENJLWNvbXBsaWFudCBkZXZpY2UgY2FuIGhhdmUgYWRkaXRpb25hbCBvcHRpb25hbA0K
cHJvcGVydGllcy4NCg0KPiB0aGVuIHRoaXMgb25lIGhlcmUNCj4gbG9va3MgZmluZS4NCj4gDQo+
IE9uZSBtb3JlIHRoaW5nIC0gdHlwZWMtdGNwY2kgaXMgYSBiaXQgcmVkdW5kYW50ICJ0YyIgbWVh
bnMgdHlwZWMsIHNvIGJhc2ljYWx5DQo+IHlvdSBzYWlkICJ0eXBlYy10eXBlYy1wY2kiLiBUaGlz
IHNob3VvbGQgYmUgdGhlbiBqdXN0IHR5cGVjLXBjaSBvciB0Y3BjaS4NCg0KTWFrZXMgc2Vuc2Us
ICJ0Y3BjaS55YW1sIiBsb29rcyBiZXR0ZXIgZm9yIG1lLg0KDQpUaGFua3MNCkxpIEp1bg0KPiAN
Cj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
