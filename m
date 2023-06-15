Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605F67317F8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241700AbjFOL5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239640AbjFOL5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:57:23 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2041.outbound.protection.outlook.com [40.107.22.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1B94481;
        Thu, 15 Jun 2023 04:51:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LL8mtkJqbYcU7CNzGfUYJQUt8I2rzPV69xqaQrFIUgNQCmRPlPeZxxCsuqzg3ODd4pNNxcuR83tY8Dx2t784ElM+6lJydqfu7AkFxsHf1GPZqNKuf7KqgPm8sN0YCkJBiLplukI3aOT78nANdN88pcUqRwkYXOALaIiLcwlPE2G+h4PvBYVk5sHdhkMeNnZPaw5a9IUZMv7BQ82aIkVssKo74xBFRe8oqtrEhK74AD2pZo3NU0WEMW8Gu8QC+BzTmUtO1PDbIfvaZhbfITKbu9osDgcI/DHLt4BW0vOk9dqUzrGrLE8dMP/HNrQOBWq7cp0QmcnluUyj59bS4qK3Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHQyFkwM8mkfOb2/dQnsBd/dPkhdShKzOuoR82iF1Nc=;
 b=A2Iql3HJHGo+n+v6dX0r32+OznLuvHH3FXKg/hWtvlx6oxCrKqiJ7B+JoIIClvE2BYApE1a8jGtQii3GHsKX+UvVbTHeP/PW069mAfDIwlBHUI6Cgt0Fu1SE4o5NQLanwchZ2iGf37oJlQqGr7NBeg5tP2nF3RS9Bi2yGzMGFTTAW+2j6zrFasFHOb4NR0i1Y9ia0fv7lXQmr1WD/76IpqEcpZO7iCA973jc+rmI59Uvf6KeHbWrs3iay7i06ZRfDi8iPXD8nFqGUxFRcmUpHkERSL//rJY76IqQHo5xSMppOJ7vUiXcgN+6BFbkgUCpbfuPTSHfn+x7QQ8IJhPYdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHQyFkwM8mkfOb2/dQnsBd/dPkhdShKzOuoR82iF1Nc=;
 b=BRkK2jBnxikgjG+C51yvwX6XS2kI+6ouazAEZKqFivAUPRI3+NtqMsEfre+9+8PZCkIYf+lExXpgilfXBnBj8vBPuSMkhpE7pnqWhFuT6uhgBpNb+z/trrsBk4NSFHGDEGpE9CUP7AnO+dx83YgCFENdt4lYokqAU1xC9dKj3Mk=
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by AM9PR04MB7540.eurprd04.prod.outlook.com (2603:10a6:20b:283::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 11:51:01 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::eb27:f73a:5829:ae0e]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::eb27:f73a:5829:ae0e%4]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 11:51:01 +0000
From:   Gaurav Jain <gaurav.jain@nxp.com>
To:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] crypto: caam - optimize RNG sample size
Thread-Topic: [PATCH] crypto: caam - optimize RNG sample size
Thread-Index: AQHZnQg44uWk40FYJ0SCLmaOaBNuN6+LxSHA
Date:   Thu, 15 Jun 2023 11:51:01 +0000
Message-ID: <AM0PR04MB60046158ED0C52AC730CAFA1E75BA@AM0PR04MB6004.eurprd04.prod.outlook.com>
References: <20230612083042.1256966-1-meenakshi.aggarwal@nxp.com>
In-Reply-To: <20230612083042.1256966-1-meenakshi.aggarwal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6004:EE_|AM9PR04MB7540:EE_
x-ms-office365-filtering-correlation-id: f70a7545-5167-4c22-28a7-08db6d96caa2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8lNCfFIWOlXNBxr2VJxMO6xjiIip/Or/kIAJujKW42lXcxkJcYuox6dugQ2PO+rpi81D5bMn7PUI1dbL+uqgNi1ZLlmn6R/IKs5sL7urYyZ3PWZyEYS2FtLq5rRhNaGPKzGAtjjtjujxrc/UwTcJF2fISh5pXEAP4uDtG33UlGGCRQ2vk8ob0ndf+pTHSHTzXCWvyZaee0PcQPvbvHp4hSX+wlCkk+cdpEywUI/ZmBHO403hEmSyT0U6UHaGll533MzubJQlV5q+S/I+r5MIGc+lT0Y4dZSabqTveVS1F5GcijBor360As5DfXXlmRDrNP6VIN26MbjHeKSK8J9WcseFkuZJMfP70GyFLVc9+sXllwiUOxSLc9FRmjcSTjw3g71OzTjGmJVgmyKoVuvhT9vhZUbuY4OIony2OjC9b9ZwxqPA46tVgx1WcYQISVzJzY/iWQq4H6HibOjHzto6H3uw8ovHN95SIv3gBP8qILypLwRwBxuIastlCGeFyZzJPyIP+U2zckNbDy0B9uwBgPSbFGkdnDHqZStDYi0nJ0gXbvVchRebz49eusoZHIcxpGruyokVySpEq049j1E7JyAU9MvgzvMN77+GNii+znTip/XHKzpjViYOVr5l2Kr5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199021)(2906002)(9686003)(26005)(55236004)(186003)(83380400001)(55016003)(66946007)(76116006)(66476007)(64756008)(66446008)(66556008)(71200400001)(41300700001)(7696005)(8936002)(8676002)(316002)(110136005)(86362001)(33656002)(38100700002)(478600001)(122000001)(38070700005)(44832011)(53546011)(6506007)(52536014)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTF1UjNzeEcybkxLVmgvZVU3ZXhEMlhrdlhEY093ZnNTcWhxUTJHSFNZaUJj?=
 =?utf-8?B?c0hlNk56cVhDRXBrQWRoSHVlQnBkT256TC9jMU1sWSsvY3Frc0RPTE1QSk1I?=
 =?utf-8?B?Smw2V3VpREdBOWR2TmEyNG5nSGljcGZEMjlNR0cxSWlwbUdkaXV3cTNPaUlU?=
 =?utf-8?B?eU1ldDhwRVJQeUJ3L3pqTlRsb3I5MTZvNko1KytHenBDaUZhbllpdXVlSzZh?=
 =?utf-8?B?b2JhMFJUSHQ5czBIN1A5cUFWMm9DSjdUV3RnUC9tMjM2TUtYUktPQmV3U3hh?=
 =?utf-8?B?OFZoTHBqcGIrV0kxL0Z4UkxRRysva1drN0pmTHY3bkl0ekZNcVlJQ2dGOEhl?=
 =?utf-8?B?eVoza0N3eHM4K3cwMzY5R1IwVzRDR0ljbkZHeUVVV3ozdDRwTS9aMW0ySDhL?=
 =?utf-8?B?WHNNOEZKdmg0aGYrMFRHMDhkb3lnOFYvNnlQSnFoc0NBWGRnV1NFOUFMZm1Z?=
 =?utf-8?B?TUpNSW9VbHdtUFBlZ3o0dVlsVFdvZCtMNXkrT2hvU24ydWI4QUlhQVRLeEVD?=
 =?utf-8?B?K1oybkpsQmtueklwbXhjVE5mWFBQUkhkWm5TTW5GeTFjZXREQnZxQXVXN2N1?=
 =?utf-8?B?WmJzL1ZXZC90ZG9HUUNPYjRSS1BzeXVpNmNxZUtqODYzWEdIanJxd0J1VVo4?=
 =?utf-8?B?TGY2eHdhMVpBWkpZWFBNSGlpL3VOZS9kL2wwZFpJa0ZUQnhWenBhUXkrejVP?=
 =?utf-8?B?OTRKSzh4V2JXYStCbkMvb0d4YmlCdGNKem9OcWlmWm93QXpiMnNGLzIrQ2U1?=
 =?utf-8?B?RktFcHUxL2JBRzZ4ZjZXNVRUdmx5WU5lYW1sQ1FxTk10Qmo0Q1ZLdm9uMFhI?=
 =?utf-8?B?OGlvRmVpSjh5M01Qd0doMFIrQzFqVHhTV1ltckJVWXVwaWRxZlFoR1RmUEh1?=
 =?utf-8?B?RnRWNnUrZzBTNnNPczd1SWRUTXB5UVJDQjREMWhzSVlzdXFGL0ZMWVRBOUV1?=
 =?utf-8?B?cTYyd0lTNkIzOWxROHBOQzJWZzNpY3JWTjlvZVJBaE8yMGRLTzZxaWlRUGZL?=
 =?utf-8?B?eFNzeUU3TFUxZHhwZ0I3Qi9xYUVxWm5LRkNzZGdZcGN5VWlDWTVEbjArclMr?=
 =?utf-8?B?K3Jya011bUtRN3Y5d1hXRUJKMHZYNnQwSEQzWG1mNXYwR0RYSi85aFo4SjdQ?=
 =?utf-8?B?TGdSYWlKbTNCTTUxcXROcDBhVTlPV0EyK0lPTi9aRWpla2hWcC9qSWxvM0dh?=
 =?utf-8?B?VEVHZWJPR0EzRlNyQWppUllTN3lOZk1XRUZxR3hYUGRCeUNRR2xNMk14d2R0?=
 =?utf-8?B?RGNjQTAvWHdVZ0RLTWtZem44MnRYUDNPdDdsUVJId25MTEpicHBhZk9MTDFO?=
 =?utf-8?B?ZGphWWlRNCtnU2dGWDVMOGlXaEJJM0xEZHdyUmhmQTIzSkRFWFI3dUx4UGtz?=
 =?utf-8?B?S1IrNHlrZHlkYmRVZFdpMG9qMVo3WUk4alpDRk5XNGwrMVI4TmJEWkRyUVU2?=
 =?utf-8?B?czBWeko3cFlBVGdQcVJmWjdOTHVKeStQZW4xc3RDN3pKV2lEbWdRL0hkSXd1?=
 =?utf-8?B?bHBFQ0hjczRRWnJSelRLTytkUkVNM29WRW52WjhzMWxWbEhOWlY1aE82YzhX?=
 =?utf-8?B?YXVtblNSck0wTHh5b1c3THBjT0lWeWx2dnBzS2w0ek53bkphbjh2dHlxcmdF?=
 =?utf-8?B?WFBFOWdITEsyQ01YcEszWmR2R2VYMlBzZjBtK0JjZjJMZG5UYUhBK1hiV0pU?=
 =?utf-8?B?aDF4dTNkcVNMdmY5WDJqWklKYStVd3RSbi9hQW8wc3gwdHFTSzZ0a3dlQnQ1?=
 =?utf-8?B?STBPZkNxMEEzS2I3N1JyZ2hEeFZXMHIrTlZRNFNCcklFck9LMW0vcWVPT0J3?=
 =?utf-8?B?YUdERE4yUGZUYjRLYVZNOERFbUZzOUhVMjN5YXFwYkVkN3B1R2hyYnNRUjZI?=
 =?utf-8?B?cDRMZ2V3UDhPbU1TaG4wWlBZWG1ua015QWw3VlBmRW5KVHo2OWhSOGRaQkFi?=
 =?utf-8?B?elNEaTA0TEpUOWxlY3FVZDRPSkx4TWVLSHUwTExSZGlZTm1Xa1VqZlI0KzRk?=
 =?utf-8?B?em5aMUFBWlBTSWdRKzBac0p2Y3R2OFFyTTBkZ1Y5eEo4V0hST2J2TWlTTXQ0?=
 =?utf-8?B?bVNvTXNrQVY3U0U4MHV2dW9DaktJMDJEVmprMGtXMnZkSkdkeUp4WjJJdCtW?=
 =?utf-8?Q?XCszuw1vyMJDnLLWW72hsrdZo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70a7545-5167-4c22-28a7-08db6d96caa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 11:51:01.4906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KICt7odNl9GzeU4gv8eQSnMPeXuq3o8R1h9f3Jw+4IuDz/vGNFbDEIBsO8lemeTuKcsmvjeKyz53iE0QJd1N0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7540
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmV2aWV3ZWQtYnk6IEdhdXJhdiBKYWluIDxnYXVyYXYuamFpbkBueHAuY29tPg0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1lZW5ha3NoaSBBZ2dhcndhbCA8bWVlbmFr
c2hpLmFnZ2Fyd2FsQG54cC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgSnVuZSAxMiwgMjAyMyAyOjAx
IFBNDQo+IFRvOiBIb3JpYSBHZWFudGEgPGhvcmlhLmdlYW50YUBueHAuY29tPjsgVmFydW4gU2V0
aGkgPFYuU2V0aGlAbnhwLmNvbT47DQo+IFBhbmthaiBHdXB0YSA8cGFua2FqLmd1cHRhQG54cC5j
b20+OyBHYXVyYXYgSmFpbiA8Z2F1cmF2LmphaW5AbnhwLmNvbT47DQo+IGhlcmJlcnRAZ29uZG9y
LmFwYW5hLm9yZy5hdTsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgbGludXgtDQo+IGNyeXB0b0B2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IE1lZW5ha3No
aSBBZ2dhcndhbCA8bWVlbmFrc2hpLmFnZ2Fyd2FsQG54cC5jb20+DQo+IFN1YmplY3Q6IFtQQVRD
SF0gY3J5cHRvOiBjYWFtIC0gb3B0aW1pemUgUk5HIHNhbXBsZSBzaXplDQo+IA0KPiBGcm9tOiBN
ZWVuYWtzaGkgQWdnYXJ3YWwgPG1lZW5ha3NoaS5hZ2dhcndhbEBueHAuY29tPg0KPiANCj4gVFJO
RyAic2FtcGxlIHNpemUiICh0aGUgdG90YWwgbnVtYmVyIG9mIGVudHJvcHkgc2FtcGxlcyB0aGF0
IHdpbGwgYmUgdGFrZW4NCj4gZHVyaW5nIGVudHJvcHkgZ2VuZXJhdGlvbikgZGVmYXVsdCAvIFBP
UiB2YWx1ZSBpcyB2ZXJ5IGNvbnNlcnZhdGl2ZWx5IHNldCB0byAyNTAwLg0KPiANCj4gTGV0J3Mg
c2V0IGl0IHRvIDUxMiwgdGhlIHNhbWUgYXMgdGhlIGNhYW0gZHJpdmVyIGluIFUtYm9vdA0KPiAo
ZHJpdmVycy9jcnlwdG8vZnNsX2NhYW0uYykgZG9lcy4NCj4gDQo+IFRoaXMgc29sdmVzIHRoZSBp
c3N1ZSBvZiBSTkcgcGVyZm9ybWFuY2UgZHJvcHBpbmcgYWZ0ZXIgYSBzdXNwZW5kL3Jlc3VtZQ0K
PiBjeWNsZSBvbiBwYXJ0cyB3aGVyZSBjYWFtIGxvc2VzIHBvd2VyLCBzaW5jZSB0aGUgaW5pdGlh
bCBVLWJvb3Qgc2V0dHRpbmdzIGFyZSBsb3N0DQo+IGFuZCBrZXJuZWwgZG9lcyBub3QgcmVzdG9y
ZSB0aGVtIHdoZW4gcmVzdW1pbmcuDQo+IA0KPiBOb3RlOiB3aGVuIGNoYW5naW5nIHRoZSBzYW1w
bGUgc2l6ZSwgdGhlIHNlbGYtdGVzdCBwYXJhbWV0ZXJzIG5lZWQgdG8gYmUNCj4gdXBkYXRlZCBh
Y2NvcmRpbmdseS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhvcmlhIEdlYW50xIMgPGhvcmlhLmdl
YW50YUBueHAuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBNZWVuYWtzaGkgQWdnYXJ3YWwgPG1lZW5h
a3NoaS5hZ2dhcndhbEBueHAuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvY3J5cHRvL2NhYW0vY3Ry
bC5jIHwgNTIgKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0NCj4gIGRyaXZl
cnMvY3J5cHRvL2NhYW0vcmVncy5oIHwgMTQgKysrKysrKystLQ0KPiAgMiBmaWxlcyBjaGFuZ2Vk
LCA0NCBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2NyeXB0by9jYWFtL2N0cmwuYyBiL2RyaXZlcnMvY3J5cHRvL2NhYW0vY3RybC5jIGlu
ZGV4DQo+IDYyZGQwNjk5NDJlNC4uYjA2YmI2NGM2YzIzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2NyeXB0by9jYWFtL2N0cmwuYw0KPiArKysgYi9kcml2ZXJzL2NyeXB0by9jYWFtL2N0cmwuYw0K
PiBAQCAtMzUyLDcgKzM1Miw3IEBAIHN0YXRpYyB2b2lkIGtpY2tfdHJuZyhzdHJ1Y3QgZGV2aWNl
ICpkZXYsIGludCBlbnRfZGVsYXkpDQo+ICAJc3RydWN0IGNhYW1fZHJ2X3ByaXZhdGUgKmN0cmxw
cml2ID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICAJc3RydWN0IGNhYW1fY3RybCBfX2lvbWVt
ICpjdHJsOw0KPiAgCXN0cnVjdCBybmc0dHN0IF9faW9tZW0gKnI0dHN0Ow0KPiAtCXUzMiB2YWw7
DQo+ICsJdTMyIHZhbCwgcnRzZGN0bDsNCj4gDQo+ICAJY3RybCA9IChzdHJ1Y3QgY2FhbV9jdHJs
IF9faW9tZW0gKiljdHJscHJpdi0+Y3RybDsNCj4gIAlyNHRzdCA9ICZjdHJsLT5yNHRzdFswXTsN
Cj4gQEAgLTM2OCwyNiArMzY4LDM4IEBAIHN0YXRpYyB2b2lkIGtpY2tfdHJuZyhzdHJ1Y3QgZGV2
aWNlICpkZXYsIGludCBlbnRfZGVsYXkpDQo+ICAJICogUGVyZm9ybWFuY2Utd2lzZSwgaXQgZG9l
cyBub3QgbWFrZSBzZW5zZSB0bw0KPiAgCSAqIHNldCB0aGUgZGVsYXkgdG8gYSB2YWx1ZSB0aGF0
IGlzIGxvd2VyDQo+ICAJICogdGhhbiB0aGUgbGFzdCBvbmUgdGhhdCB3b3JrZWQgKGkuZS4gdGhl
IHN0YXRlIGhhbmRsZXMNCj4gLQkgKiB3ZXJlIGluc3RhbnRpYXRlZCBwcm9wZXJseS4gVGh1cywg
aW5zdGVhZCBvZiB3YXN0aW5nDQo+IC0JICogdGltZSB0cnlpbmcgdG8gc2V0IHRoZSB2YWx1ZXMg
Y29udHJvbGxpbmcgdGhlIHNhbXBsZQ0KPiAtCSAqIGZyZXF1ZW5jeSwgdGhlIGZ1bmN0aW9uIHNp
bXBseSByZXR1cm5zLg0KPiArCSAqIHdlcmUgaW5zdGFudGlhdGVkIHByb3Blcmx5KS4NCj4gIAkg
Ki8NCj4gLQl2YWwgPSAocmRfcmVnMzIoJnI0dHN0LT5ydHNkY3RsKSAmIFJUU0RDVExfRU5UX0RM
WV9NQVNLKQ0KPiAtCSAgICAgID4+IFJUU0RDVExfRU5UX0RMWV9TSElGVDsNCj4gLQlpZiAoZW50
X2RlbGF5IDw9IHZhbCkNCj4gLQkJZ290byBzdGFydF9ybmc7DQo+IC0NCj4gLQl2YWwgPSByZF9y
ZWczMigmcjR0c3QtPnJ0c2RjdGwpOw0KPiAtCXZhbCA9ICh2YWwgJiB+UlRTRENUTF9FTlRfRExZ
X01BU0spIHwNCj4gLQkgICAgICAoZW50X2RlbGF5IDw8IFJUU0RDVExfRU5UX0RMWV9TSElGVCk7
DQo+IC0Jd3JfcmVnMzIoJnI0dHN0LT5ydHNkY3RsLCB2YWwpOw0KPiAtCS8qIG1pbi4gZnJlcS4g
Y291bnQsIGVxdWFsIHRvIDEvNCBvZiB0aGUgZW50cm9weSBzYW1wbGUgbGVuZ3RoICovDQo+IC0J
d3JfcmVnMzIoJnI0dHN0LT5ydGZycW1pbiwgZW50X2RlbGF5ID4+IDIpOw0KPiAtCS8qIG1heC4g
ZnJlcS4gY291bnQsIGVxdWFsIHRvIDE2IHRpbWVzIHRoZSBlbnRyb3B5IHNhbXBsZSBsZW5ndGgg
Ki8NCj4gLQl3cl9yZWczMigmcjR0c3QtPnJ0ZnJxbWF4LCBlbnRfZGVsYXkgPDwgNCk7DQo+IC0J
LyogcmVhZCB0aGUgY29udHJvbCByZWdpc3RlciAqLw0KPiAtCXZhbCA9IHJkX3JlZzMyKCZyNHRz
dC0+cnRtY3RsKTsNCj4gLXN0YXJ0X3JuZzoNCj4gKwlydHNkY3RsID0gcmRfcmVnMzIoJnI0dHN0
LT5ydHNkY3RsKTsNCj4gKwl2YWwgPSAocnRzZGN0bCAmIFJUU0RDVExfRU5UX0RMWV9NQVNLKSA+
PiBSVFNEQ1RMX0VOVF9ETFlfU0hJRlQ7DQo+ICsJaWYgKGVudF9kZWxheSA+IHZhbCkgew0KPiAr
CQl2YWwgPSBlbnRfZGVsYXk7DQo+ICsJCS8qIG1pbi4gZnJlcS4gY291bnQsIGVxdWFsIHRvIDEv
NCBvZiB0aGUgZW50cm9weSBzYW1wbGUgbGVuZ3RoDQo+ICovDQo+ICsJCXdyX3JlZzMyKCZyNHRz
dC0+cnRmcnFtaW4sIHZhbCA+PiAyKTsNCj4gKwkJLyogbWF4LiBmcmVxLiBjb3VudCwgZXF1YWwg
dG8gMTYgdGltZXMgdGhlIGVudHJvcHkgc2FtcGxlDQo+IGxlbmd0aCAqLw0KPiArCQl3cl9yZWcz
MigmcjR0c3QtPnJ0ZnJxbWF4LCB2YWwgPDwgNCk7DQo+ICsJfQ0KPiArDQo+ICsJd3JfcmVnMzIo
JnI0dHN0LT5ydHNkY3RsLCAodmFsIDw8IFJUU0RDVExfRU5UX0RMWV9TSElGVCkgfA0KPiArCQkg
UlRTRENUTF9TQU1QX1NJWkVfVkFMKTsNCj4gKw0KPiArCS8qDQo+ICsJICogVG8gYXZvaWQgcmVw
cm9ncmFtbWluZyB0aGUgc2VsZi10ZXN0IHBhcmFtZXRlcnMgb3ZlciBhbmQgb3ZlciBhZ2FpbiwN
Cj4gKwkgKiB1c2UgUlRTRENUTFtTQU1QX1NJWkVdIGFzIGFuIGluZGljYXRvci4NCj4gKwkgKi8N
Cj4gKwlpZiAoKHJ0c2RjdGwgJiBSVFNEQ1RMX1NBTVBfU0laRV9NQVNLKSAhPSBSVFNEQ1RMX1NB
TVBfU0laRV9WQUwpDQo+IHsNCj4gKwkJd3JfcmVnMzIoJnI0dHN0LT5ydHNjbWlzYywgKDIgPDwg
MTYpIHwgMzIpOw0KPiArCQl3cl9yZWczMigmcjR0c3QtPnJ0cGtycm5nLCA1NzApOw0KPiArCQl3
cl9yZWczMigmcjR0c3QtPnJ0cGtybWF4LCAxNjAwKTsNCj4gKwkJd3JfcmVnMzIoJnI0dHN0LT5y
dHNjbWwsICgxMjIgPDwgMTYpIHwgMzE3KTsNCj4gKwkJd3JfcmVnMzIoJnI0dHN0LT5ydHNjcmxb
MF0sICg4MCA8PCAxNikgfCAxMDcpOw0KPiArCQl3cl9yZWczMigmcjR0c3QtPnJ0c2NybFsxXSwg
KDU3IDw8IDE2KSB8IDYyKTsNCj4gKwkJd3JfcmVnMzIoJnI0dHN0LT5ydHNjcmxbMl0sICgzOSA8
PCAxNikgfCAzOSk7DQo+ICsJCXdyX3JlZzMyKCZyNHRzdC0+cnRzY3JsWzNdLCAoMjcgPDwgMTYp
IHwgMjYpOw0KPiArCQl3cl9yZWczMigmcjR0c3QtPnJ0c2NybFs0XSwgKDE5IDw8IDE2KSB8IDE4
KTsNCj4gKwkJd3JfcmVnMzIoJnI0dHN0LT5ydHNjcmxbNV0sICgxOCA8PCAxNikgfCAxNyk7DQo+
ICsJfQ0KPiArDQo+ICAJLyoNCj4gIAkgKiBzZWxlY3QgcmF3IHNhbXBsaW5nIGluIGJvdGggZW50
cm9weSBzaGlmdGVyDQo+ICAJICogYW5kIHN0YXRpc3RpY2FsIGNoZWNrZXI7IDsgcHV0IFJORzQg
aW50byBydW4gbW9kZSBkaWZmIC0tZ2l0DQo+IGEvZHJpdmVycy9jcnlwdG8vY2FhbS9yZWdzLmgg
Yi9kcml2ZXJzL2NyeXB0by9jYWFtL3JlZ3MuaCBpbmRleA0KPiA2NjkyOGY4YTBjNGIuLjE4OWU3
NGMyMWYwYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jcnlwdG8vY2FhbS9yZWdzLmgNCj4gKysr
IGIvZHJpdmVycy9jcnlwdG8vY2FhbS9yZWdzLmgNCj4gQEAgLTMsNyArMyw3IEBADQo+ICAgKiBD
QUFNIGhhcmR3YXJlIHJlZ2lzdGVyLWxldmVsIHZpZXcNCj4gICAqDQo+ICAgKiBDb3B5cmlnaHQg
MjAwOC0yMDExIEZyZWVzY2FsZSBTZW1pY29uZHVjdG9yLCBJbmMuDQo+IC0gKiBDb3B5cmlnaHQg
MjAxOCBOWFANCj4gKyAqIENvcHlyaWdodCAyMDE4LCAyMDIzIE5YUA0KPiAgICovDQo+IA0KPiAg
I2lmbmRlZiBSRUdTX0gNCj4gQEAgLTUyMyw2ICs1MjMsOCBAQCBzdHJ1Y3Qgcm5nNHRzdCB7DQo+
ICAjZGVmaW5lIFJUU0RDVExfRU5UX0RMWV9NQVNLICgweGZmZmYgPDwgUlRTRENUTF9FTlRfRExZ
X1NISUZUKQ0KPiAjZGVmaW5lIFJUU0RDVExfRU5UX0RMWV9NSU4gMzIwMCAgI2RlZmluZSBSVFNE
Q1RMX0VOVF9ETFlfTUFYIDEyODAwDQo+ICsjZGVmaW5lIFJUU0RDVExfU0FNUF9TSVpFX01BU0sg
MHhmZmZmDQo+ICsjZGVmaW5lIFJUU0RDVExfU0FNUF9TSVpFX1ZBTCA1MTINCj4gIAl1MzIgcnRz
ZGN0bDsJCS8qIHNlZWQgY29udHJvbCByZWdpc3RlciAqLw0KPiAgCXVuaW9uIHsNCj4gIAkJdTMy
IHJ0c2JsaW07CS8qIFBSR009MTogc3BhcnNlIGJpdCBsaW1pdCByZWdpc3RlciAqLw0KPiBAQCAt
NTM0LDcgKzUzNiwxNSBAQCBzdHJ1Y3Qgcm5nNHRzdCB7DQo+ICAJCXUzMiBydGZycW1heDsJLyog
UFJHTT0xOiBmcmVxLiBjb3VudCBtYXguIGxpbWl0IHJlZ2lzdGVyICovDQo+ICAJCXUzMiBydGZy
cWNudDsJLyogUFJHTT0wOiBmcmVxLiBjb3VudCByZWdpc3RlciAqLw0KPiAgCX07DQo+IC0JdTMy
IHJzdmQxWzQwXTsNCj4gKwl1bmlvbiB7DQo+ICsJCXUzMiBydHNjbWM7CS8qIHN0YXRpc3RpY2Fs
IGNoZWNrIHJ1biBtb25vYml0IGNvdW50ICovDQo+ICsJCXUzMiBydHNjbWw7CS8qIHN0YXRpc3Rp
Y2FsIGNoZWNrIHJ1biBtb25vYml0IGxpbWl0ICovDQo+ICsJfTsNCj4gKwl1bmlvbiB7DQo+ICsJ
CXUzMiBydHNjcmNbNl07CS8qIHN0YXRpc3RpY2FsIGNoZWNrIHJ1biBsZW5ndGggY291bnQgKi8N
Cj4gKwkJdTMyIHJ0c2NybFs2XTsJLyogc3RhdGlzdGljYWwgY2hlY2sgcnVuIGxlbmd0aCBsaW1p
dCAqLw0KPiArCX07DQo+ICsJdTMyIHJzdmQxWzMzXTsNCj4gICNkZWZpbmUgUkRTVEFfU0tWVCAw
eDgwMDAwMDAwDQo+ICAjZGVmaW5lIFJEU1RBX1NLVk4gMHg0MDAwMDAwMA0KPiAgI2RlZmluZSBS
RFNUQV9QUjAgQklUKDQpDQo+IC0tDQo+IDIuMjUuMQ0KDQo=
