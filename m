Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593427101DE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 02:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbjEYAB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 20:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjEYABz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 20:01:55 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2064.outbound.protection.outlook.com [40.107.105.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF5F99
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 17:01:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuT+sXWTAjPX86nFne+OwbWgKuhygpNx8hxihhH7CAIG8DTEXIEkThR664iS3dLDueJwyMseS7UJpYMHEYwLbio3PrLA/I5PFCpNTIFoTrrhHBJoQ+9frvikKAUFYsvQMXDZ5tNTk9TYVrWtq1C5MqCvURv5iDP5nkn0YXXUrN1phaAxYOKtxVFx6OWklmPU4NDz8PJA60thZb0owjBpIG0tlRQlE9TEoa4ZF0ss7OnAgKZGITwyZML0EfwG8v29G9VPN5fBl+RUcXFOLvP0YuvpeCtsICjpybG9+qgBhAQP0ZyluZ1g+9OR6g9aFO7V8YQyX30vivO9gxRLKy6Emw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g62U83LEqSOnmL70b+28spygLhJzuWqTnfTyLYHGHqU=;
 b=ienMbeDdH7/GshXvAKBD6d6YWW52CiezovnUz64b7Y6n4oXuyxC1rH1nJ/Z0toGAAFJ54Y6kxaCQzajoP+lnB0XMDlZma8Yp7RN9iy5HPqttQ4YwUfjbw3dfjQkQwe05TSHxUqVSpB3lr4t/dr1iUczlH0IDrwBc9Uz2BeVY+8gIIaPz8gyaZ5bd83XX5nJpgkQjuKYGL9OnNTGZXWQPs24rYkRRMpb2/FjRXkRJoGCS9Sm5g+qlq4y+lhfIgW4cZIYzgX0O9gCRbr9KDdlQpJKrizAzrBFJ+6NX8MnS5zQ8gPSuEgkAiIRulvgLmyUxJ4MXeXKdSOaJrw3vLufSRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g62U83LEqSOnmL70b+28spygLhJzuWqTnfTyLYHGHqU=;
 b=jJcHNP99U5TVfzFbNs6saqzHzGaBBa1UCxxl1KRKsfKl+ciDyx8ueJusz1LyQmRGkl9xsEp9fDJzv6WSvAET9KezfqjHeKS3d5fIjMVoLI9iZ5tOajIXwJ9bjqbrObRxc4uNLLObhAqe+WJM40WNYXC6oKBcRCqnJwf2v39dq9A=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7759.eurprd04.prod.outlook.com (2603:10a6:102:c6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Thu, 25 May
 2023 00:01:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%7]) with mapi id 15.20.6411.029; Thu, 25 May 2023
 00:01:50 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V3] soc: imx: support i.MX93 soc device
Thread-Topic: [PATCH V3] soc: imx: support i.MX93 soc device
Thread-Index: AQHZhvcGw2nYob3zLEmYd1JxpO1fJq9pecCAgACu3zA=
Date:   Thu, 25 May 2023 00:01:50 +0000
Message-ID: <DU0PR04MB94170FE393AEE4A86ACE386588469@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230515063730.2042715-1-peng.fan@oss.nxp.com>
 <33d57180-aa13-4178-86e1-c4cf6ef29a6e@prevas.dk>
In-Reply-To: <33d57180-aa13-4178-86e1-c4cf6ef29a6e@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PA4PR04MB7759:EE_
x-ms-office365-filtering-correlation-id: fff43fcd-f7bf-40c9-1278-08db5cb33dc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E+gb1H/8Y8XMM3I9hxRXXgWB/UY27biKs1q8kS14Hrmrx27cTS6ATkeDiRANyRBOHPuUGis9+128XyA5ozBkX8gEo+rnGIFUIDV39qIkVNiMX59fgKgQyFlfGW9wLdpzk4+FeCvB+6Y2j5Iyw1UbCldO3xKf1x7E0OefRGfEM7R2aIXwvqvng0J5ouBp5X8Q/e7yZoAHFy2ZDHzWZExjx/2mzZIDXwO4UatMyPGsst7YzrdW7UwpqHjYOHO4+iAJ5PTL9oQFwN6nUQPJ149Z3AKZHDYaNmlOZiI9uE9mbtLv7XR924uT0Ps4nXZR6XKD4bzJv3kyxqYA2tJQXhxWM2r6zs/uYEMfvVqP+OoN9HUccvFPW+AZVaGrctbxCvM5XhIytIZV0yWuEi+dElFiMDFd7jcM92Wdjo36KpjAbbc9CMzR8PvZYNE1LBTTUb/lh1FFxrYJMJGOyhrmh7fRnqBeuwFuTWuhb8UKUoVG9wwHPoHzAYcNPsT8rRk6sYp3ZTPP0eLrSmbpWkrENdF9YyR4wauzgsbpjJwPBQtmVFBjNFfov0zbVMNJlEqaf5yPR4NGsEUTIKem9fW5RgIWh4WO0DEzvCubU5PMAthIsqqTrTmYYwRx94duNhonspae
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199021)(76116006)(66946007)(66446008)(64756008)(478600001)(66476007)(66556008)(41300700001)(7696005)(54906003)(71200400001)(316002)(110136005)(38070700005)(52536014)(4326008)(86362001)(8676002)(5660300002)(8936002)(44832011)(26005)(186003)(55016003)(33656002)(9686003)(6506007)(122000001)(83380400001)(2906002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2M2c29BcVVSaUJlemhSZHEwQzlmTWx4S2VvQTdEdDRoUk9GOHZ0Um5tWDRo?=
 =?utf-8?B?TGhqYUo0clBheEtVZ2FBbzNOOUhhRC9mWklkY3dUVUx5WjFVcHVPbDBIVVQ4?=
 =?utf-8?B?eUJVREJ5b2xwVFdvVkdmcjFJb1FlS1dlNFZzZ1RJMDczNUhWSUJnaVBtTVB1?=
 =?utf-8?B?MHNkOFZNNkt2Si84cC80UkhHRGtxeWg4bFZsaklmbDFZT2lMU0pxRlI0OTdG?=
 =?utf-8?B?NXBsMVFRYWFVem1adjRRamVwVmJXQzUrbkpNZ2s3SWhOR1pvT2Q0ZkdPbUdw?=
 =?utf-8?B?ZVVhWnU1ZWo1VnV0Z004WUNnYmFEaG9nS0dIZHdyTk9CM0V3Z1NVWG5UN0RQ?=
 =?utf-8?B?TVpYZ1pZZGxWdDdMTEFUMFBmK21kMGtPcXI5L2ZDTkx5UEN2MmxxWWRMK1kz?=
 =?utf-8?B?UEVaYWZEOTFnb2kvSkt6ZHljc1c5MUh4TUJlcUd2NU5YREdyemFwNVA0V2l6?=
 =?utf-8?B?TjZhQkpFQ25DeEV4Z2x4T09uTDhsWnNpYTFYQVlVZC8rWFg4OE5vMldDUHNm?=
 =?utf-8?B?bnZyM2lnaDZadW9XVk8wdldUVDBUMXNFaTdvNytlekhsRXBRZU1CRzVKSVhq?=
 =?utf-8?B?VnZxWEJhUnA4Wm9JdmJSbEpnTUYyUHM3SnBEZ1g2RWhFWHRFdWxlL3pnRXcw?=
 =?utf-8?B?S0tFSHhxY2tOOUlTRzczVVZaZTZ2SVB0bnVuT1JoOVR5cStSVHhISUNGR2dw?=
 =?utf-8?B?TlJlZG9SUTcrUE55enNBYlhyMGFQL0x0clVLVDJrQ3ZHNWw0dDNhalVKRHBn?=
 =?utf-8?B?alFsc3JYUFRCZVlrWVVEQVFYdUpqQnZUdlA1YU5pNWo5cExVTHZJYXNpQXpT?=
 =?utf-8?B?MEdqaXFmTDZIWExUWHFEWk90eVRRR2gyL01JRFkyVm5qanBlS2hZWFJDUm9Z?=
 =?utf-8?B?MGl4bHJtQlNiNDJCbENwVjZDQWs0cllPcmtmYmdhOHlRZUpabFZ4ejRzZkZr?=
 =?utf-8?B?Q2tpMzNxYlFsRnQwdnlkMS91dWo4bVY4T1djYzF2cUFwRE5KS2xMSW53V2VY?=
 =?utf-8?B?bXRDR2JaK0M4Z3cra0Y3TTRMUGExTGxHMk5GazhxWTlXUzJsM0NCd2tMZGV4?=
 =?utf-8?B?VGJacWZwaUEzOWNmQ1kvallwZEtiS2ZnVVJrVUM2ZzgvTjF4UmZPNHlhWTht?=
 =?utf-8?B?OENna2xyeFRCbTNpZG9zYStMeGdMOFlCL2l6Z1JxYXRmb0lGSFFBR0ovVjQx?=
 =?utf-8?B?MzdjczIrVU1lOUFIY2ZLbXhWMEpuaTlhUW15VkwwMFFMUmVwNitzUTljam04?=
 =?utf-8?B?SEhtS1AzOWdMeHpGUXhNeldHODVicUlEZmlMYUZLN2laRnBsUFNYTmZsaXRE?=
 =?utf-8?B?U2FtMDIyN1VSa1RFS2tGTkdEZ3huOFRabUFCV2QrcjJSN0oyU2drc2tqUjd2?=
 =?utf-8?B?UHpmYk1POFZWWFJlMkZwa1plR1laTUJ4bWwyVjh5UVN0TGlCMTRIUjU3eW1t?=
 =?utf-8?B?RkxqYnJ4bGU3c0tHKzgzM3dXWGIvWUxxd0JaTjE0bG9Yc3hpdFd4anM0Nzhs?=
 =?utf-8?B?QzhMZUsxa1J2RFFLditUYTJqM2FITHo4MjVJRHRua01QNm9HT0JkcnQweCtp?=
 =?utf-8?B?cDR0RTNieDhTdDJzT3BNT0Z6N2p1ZGk2S2VGelM1S3JBTm8vMnJYZktYdmt5?=
 =?utf-8?B?VHMzZzl1WW1MM1l5TWV3T0R4OW1KN2NZcDhzSFlVT3FyVWxmQnZaSVZoRTVq?=
 =?utf-8?B?S1hmWEQxZzB1UXJuMmhYM1RucUtqVnZhbUF1MlhFb0lIRHY3SzZ2ZWtmNmht?=
 =?utf-8?B?VnlJMmRoNXEvbGNJRG93RGlSSnk5UmZHa2tLcUtjdGhoV1hVU21vSVRXWS9a?=
 =?utf-8?B?YmpnTUMzU0tUc1owZWh3a3dNcVZDenV4d2gyR29OUGFkMVdSNTJJQWpYNldp?=
 =?utf-8?B?aktWWU9zS2htdzRnRU9mZERGMjhFT2FmUUliaEtRUnptWXgyZlQ2SXFSaHBL?=
 =?utf-8?B?ZGRTWWRFWnhndnVxN2xhcHlwa1NieXg0ekZwU2RtbXh4NDlQSWtnUXBtN2VN?=
 =?utf-8?B?UXBRSkhSSDBqZVJYdlBYNlBGc3UwNTVkNzdiMTRXVkVIMGdMRjJZejJaNzBm?=
 =?utf-8?B?TlBHVTkxbkFYTEc0QXZ5M1UxY1BqL1BQR0RsejQ1YWN1SnhIU1dsWDlaMU9p?=
 =?utf-8?Q?vKjc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fff43fcd-f7bf-40c9-1278-08db5cb33dc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 00:01:50.8050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t1e7k8ZtOxyOu0c1yhTmMXFN5jp6Y7O3unaJfLSpebcUmiUIMXq27UmRawnTB12lAlsCU2iC0QIp+llhGM5Dqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7759
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIFYzXSBzb2M6IGlteDogc3VwcG9ydCBpLk1YOTMgc29jIGRl
dmljZQ0KPiANCj4gT24gMTUvMDUvMjAyMyAwOC4zNywgUGVuZyBGYW4gKE9TUykgd3JvdGU6DQo+
ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4NCj4gPiBpLk1YOTMgRGV2
aWNlIFVuaXF1ZSBJRChVSUQpIGlzIGluIGVGdXNlIHRoYXQgY291bGQgYmUgcmVhZCB0aHJvdWdo
DQo+ID4gT0NPVFAgRnVzZSBTaGFkb3cgQmxvY2suIGkuTVg5MyBVSUQgaXMgMTI4IGJpdHMgbG9u
Zywgc28gaW50cm9kdWNlDQo+ID4gc29jX3VpZF9oaWdoIHRvIGluZGljYXRlIHRoZSBoaWdoZXIg
NjRiaXRzLg0KPiANCj4gU28gYXBwYXJlbnRseSwgdGhlIGlteDhtcCBhbHNvIGhhcyAxMjggYml0
cywgYXQgbGVhc3QgYWNjb3JkaW5nIHRvIHRoZQ0KDQpJdCBpcyA2NGJpdHMuIFRoZSBSTSBtYXli
ZSB3cm9uZy4NCg0KPiByZWZlcmVuY2UgbWFudWFsLCB3aGljaCBtZW50aW9ucyBhICJVTklRVUVf
SURbMTI3OjY0XSIgYXQgb2Zmc2V0IDB4ZTAwIC0NCj4gMHhlMTAgKGkuZS4gYmFuayA0MCwgd29y
ZHMgMCBhbmQgMSkuDQoNCldoaWNoIGNoYXRwZXI/DQo+IA0KPiBIb3dldmVyLCBubyBmdXJ0aGVy
IG1lbnRpb24gb2YgdGhlc2UgdXBwZXIgYml0cyBjYW4gYmUgZm91bmQgYW55d2hlcmUgaW4NCj4g
dGhlIFJNLCBvciBpbiBsaW51eCBvciB1LWJvb3QsIG1haW5saW5lIG9yIGRvd25zdHJlYW0gTlhQ
LiBGdXJ0aGVybW9yZSwNCj4gcXVpY2sgZXhwZXJpbWVudHMgb24gYm90aCBhbiBpbXg4bXAtZXZr
IGFuZCBhIGN1c3RvbSBpbXg4bXAgYm9hcmQNCj4gcmV2ZWFscyB0aGF0IHRob3NlIHdvcmRzIGFy
ZSBub3QgbG9ja2VkIGRvd24gKHRoZXkgZG8gc2VlbSB0byBoYXZlIHNvbWUNCj4gY29udGVudHMg
ZnJvbSB0aGUgZmFjdG9yeSwgYnV0IEkgY2FuIHN0aWxsIHNldCBtb3JlIGJpdHMgaW4gdGhlbSku
DQo+IA0KPiBDb3VsZCBzb21lb25lIGZyb20gTlhQIHBsZWFzZSBleHBsYWluIHdoYXQgZXhhY3Rs
eSBiYW5rIDQwLCB3b3JkcyAwIGFuZA0KPiAxLCBvbiBpbXg4bXAgYXJlIGZvcj8gV2hhdCBkbyB0
aGVpciBpbml0aWFsIHZhbHVlIG1lYW4sIHdoeSBhcmUgdGhleSBub3QNCj4gbG9ja2VkIGRvd24s
IGFuZCB3aHkgZG9lcyB0aGUgUk0gaW5kaWNhdGUgdGhhdCB0aGV5IHNob3VsZCBiZSBwYXJ0IG9m
IGENCj4gdW5pcXVlX2lkPw0KDQpSTSBzaG91bGQgYmUgd3JvbmcuIFVJRCBpcyBpbiBCYW5rIDAu
DQoNCj4gDQo+IEFsc28sIGFzc3VtaW5nIHRoYXQgdGhlIFJNIGlzIGp1c3Qgd3JvbmcgKHdvdWxk
bid0IGJlIHRoZSBmaXJzdCB0aW1lOyB0aGUNCj4gZGVzY3JpcHRpb24gb2YgdGhlIGxvd2VyIDY0
IGJpdHMgaXMgYWxzbyB3b25reSBpbiBpdHMgb3duIHNwZWNpYWwgd2F5KSwgYW4NCj4gb2J2aW91
cyBmb2xsb3ctdXAgcXVlc3Rpb24gaXM6IEFyZSB0aGUgY3VycmVudGx5IGV4cG9zZWQNCj4gKGxv
d2VyKSA2NCBiaXRzIHVuaXF1ZSBhbW9uZyBhbGwgaW14OG1wIFNPQ3MsIGkuZS4gZG9lcyB0aG9z
ZSA2NCBiaXRzIGJ5DQo+IHRoZW1zZWx2ZXMgYWN0dWFsbHkgd29yayBhcyBhIHVpZD8NCg0KSnVz
dCBhcyB3aGF0IHRoZSBkcml2ZXIgaW5kaWNhdGVzLCBVSUQgaXMgYXQgcmVnaXN0ZXIgYWRkcmVz
cyAweDQyMCBhbmQgMHg0MzAuDQoNCkZvciBiYW5rIDB4NDAsIEkgY291bGQgbm90IHJldmVhbCBp
bmZvcm1hdGlvbiBpZiBSTSBvciBTZWN1cmUgUk0gbm90IHNheQ0Kc29tZXRoaW5nLg0KDQpZb3Ug
Y291bGQgcmFpc2UgdGlja2V0cyBpbiBjb21tdW5pdHkubnhwLmNvbSB0byBhc2sgcGVvcGxlIGZv
bGxvdyB1cA0Kb24gUk0gaXNzdWUgb3IgZWxzZS4NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiANCj4g
UmFzbXVzDQoNCg==
