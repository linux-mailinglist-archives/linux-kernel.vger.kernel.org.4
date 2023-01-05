Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA3565F2F9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbjAERkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjAERkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:40:21 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2101.outbound.protection.outlook.com [40.107.113.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889601B1F2;
        Thu,  5 Jan 2023 09:40:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTM0baJwDVU/9tM76t8AYE50rrA5DiNlPoK2uEQsP/y+PjvbOji6l9vzyKPWBheUXWTk+bsgl9aYvI7Xl4HO2A405HO13Ybz2V1tvQ8bQxGzUZd7HevkCpvw5C1MnQyFnZFyAkZ/Ft4smzH+YAFR4pOC4LMJ7/cm5memkD/PSH5c4q3j2k/JB1/Kl3HZVKJ0sjPciX3doI+d1TmP/bHrkdY81d4462aE2FRGSHTDvDeBLIPtTFqggVhXAh6rS5yloAz/MAisHX4NxWmpwuTAIBcJxU/NFYIeGCh98I3t6fqMCGDHwHSWeW/TqXKnB4cMDEG2jbfhhFzDFK2U+sHqKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wX/G8ghT+HhTOSnITWnyV2Jtu5/+0cvWM6wH+xaaHY=;
 b=Dx5BYufrBsoQOWWVOjIRIvUL46lMf366iWdDjCLt+ETUQE6EUj8QTtcBsiWVCARghkq69UDnQsDJ1uODvGU73mdALYF8hDLGw4ohA5k0S7BPVgBS2lYO5YwtVUs/YCYavdO7xnlNNyZp5kpdYatjPHm4rhX1DAPqchn9tC+9RYGuT/VUm1ZVljhIebEki9KdNI/bmoy72qHoUjn74KOIejvv7JUfZJa7ssrP7h7CG8ENeTeR6KQ7DNYJtqraKy2MR/m17ftuHkkA3MGoylvaIiy2uU4wVxgRjaIWr3UxAJyb9tS8hOvE69SqRYwryeFnUmL2GQuWrOJlkJddE1TF2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wX/G8ghT+HhTOSnITWnyV2Jtu5/+0cvWM6wH+xaaHY=;
 b=TuX63DSSZboYJR0IKAXumhZtK2IL9LTdLa8/r8HAj6/bi0SrzgfBsUQLvzk7hRixJhmdipdbiWCeF/HIfqih17CC6QxeJd9t0YpVO4ZqX1zY9+4BfPEa0s/i6H/Wn46OfJqxLg69pQdw0Q8F7bSc4bB9uHPUumJ+tXvxpZuEE6s=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TYWPR01MB8676.jpnprd01.prod.outlook.com (2603:1096:400:179::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 17:40:17 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 17:40:17 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: RE: [PATCH 4/5] gpio: Add support for Renesas RZ/V2M PWC
Thread-Topic: [PATCH 4/5] gpio: Add support for Renesas RZ/V2M PWC
Thread-Index: AQHZD0RaGSS+/EHuvUSLJvuz51upRq6LMwqAgAUHO7A=
Date:   Thu, 5 Jan 2023 17:40:16 +0000
Message-ID: <TYWPR01MB8775A3C7B2FB748348D6A7F1C2FA9@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20221213224310.543243-1-fabrizio.castro.jz@renesas.com>
 <20221213224310.543243-5-fabrizio.castro.jz@renesas.com>
 <CAMRc=MdmtzynWR22Cyzm-vzt_g0g9aAmNX4fYbnB4invDq3+Fg@mail.gmail.com>
In-Reply-To: <CAMRc=MdmtzynWR22Cyzm-vzt_g0g9aAmNX4fYbnB4invDq3+Fg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TYWPR01MB8676:EE_
x-ms-office365-filtering-correlation-id: 70bcf03d-e9fe-419f-4b75-08daef43e895
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uL54V6OsmCVh94z3oY9vvECH2ZhWLKcHqN9ZKY3e+WXKPLWlVi31uUmBV1vXvkudeeAzE/h0zaEwJlNgewjyC85NbEvLSmrAwFNoH92ZkKBrKYO09GDHpQ7XnqkDOUJEfXZJqk8kC/f0v8zOyADpN3HCTeAtlNSK/FPdFn3WzkaAitiJl1/Ax6z7+6wyyPu+t8jMQLCByw6rxETxu8H4zk1O28yVdULc6ADtJy4CYuhx1EX42LTmr2U3cBD1/hdEK1VA4AzifHjJbl1OCrF5B6hB91o5gdC5dgLOuk0avlGJkuyMNd4hgdi2esX/NOuSBNv5SF/1gkXDfXbm7UtGDzaCVF4dxeQgUEBw0RAEYz/LRDFdvKOeynDAa4q7/BY+uWJYooQ5jS1uJrfsYHvavRiCkeammsofwiNVW9Nz/o/DdFc6mT5WT53af6iMiUEIgWGBUQ/IslZsFMwKbQUiZ/MlQ49g4T45/xoo5l8mqAJbwYVEb4OvkEIRMvOOne4c79lNbYmZ9VBsbBwAt+sSU5oDRUbtylMdA937oCJ4IB0jh7U+MgwjrcNhP+gZIy9ckFnm+py3IwxB2cSaZ6AGize4JEj8V1P9X1+yqg1LC9Y/W0Rsc2TeY73RWR1JEvmROxSXFK9yWMPKXrew0By9je+B2sfyxIrWV8dGhplsNhrxKQVNJrQ5zqB2x8sfPeBk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199015)(38100700002)(8936002)(7696005)(6506007)(76116006)(122000001)(54906003)(71200400001)(33656002)(86362001)(52536014)(26005)(186003)(9686003)(55016003)(38070700005)(478600001)(6916009)(316002)(53546011)(2906002)(107886003)(41300700001)(7416002)(66946007)(5660300002)(64756008)(8676002)(4326008)(66556008)(66476007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Skdqb3lBd2l4TTREem8yYkhxVVY0dVNKVmtIQUxuR1lvclJqZVNURzJoOC9E?=
 =?utf-8?B?Tmd0M1BJMktFNkJ1WW1VQ0VYeVZaRTVMdkREeStBM0xKMjA5R1UrOGwzSFJO?=
 =?utf-8?B?ODhIdHVsbGFCWnhlVGFMT0twZHByd084bFk5dFRHMExPL1hJMUJRK3Y0RVBu?=
 =?utf-8?B?QWJOK2RzSW9CWmRORXlxWTZqRmhGckdGV2t4aGxtUXhjdWdkQzZ6Tk1yaVFu?=
 =?utf-8?B?WXdqU1ZMN3JRRDl1M2VjMnVWY2VXZWFvU3pvSzVBU3duelBUajcrNHBCd21Y?=
 =?utf-8?B?MTh0Zmo2dWk4aXlFV3RtV0ZxdXkrYXJUdmpJcG5jQkc5YlpJMlFyUFZ5cnBZ?=
 =?utf-8?B?M3F4T3E0OVVHYStMTnpuRkdaUnlGSUkrUC9mc2NzVC9IKzQ1NW92VnhZRG4y?=
 =?utf-8?B?S2JGTk0vTHRGbkVNN280OVI0OHdhcndWNmd6dGVYMG5VQUNhK2kvZkpZQVI1?=
 =?utf-8?B?TWdZTjhZbkJSZUZFaSs0NVdmakMrSU8yZFBBZEZLWkVITGpQMEhSQ1NqaXlv?=
 =?utf-8?B?aWFjQWNtTVlnd3ZWemlneUpodXJXdE5YVzc5NXgwRFU4di9XSWQ3YkMzNHpn?=
 =?utf-8?B?N0FBS3NYcEU5dGpHcmFwM0ZJSmlkOHZwbUpFSlZTYlpMWmtkMW0reUVVQk5o?=
 =?utf-8?B?YUxXM09HelRuS1E1VlYwS21NY0FKUDNBdTFBOVF4cDJndnkyMGZUUklRcmFC?=
 =?utf-8?B?UjArb3NEeUVPSGZqQTVDbTNuai95QmFCVEtvTDlUdHZXNUlxTDc1RnMvRHpv?=
 =?utf-8?B?WmZVY05TZTVoTWwwUXNpUlFGUit4NDRrOHMrRzErcUh5cEJmVXFCSnA3MkFV?=
 =?utf-8?B?UlNneFpGZWhUbCtvWXRsNkpZeFpYYmUwQVo1b01oNDcxc0FCSUdCV1VVeHFi?=
 =?utf-8?B?bGU4VWk1WTZvVU1WNDVjRUMvMHAxbS85OU5uNVIzeThiazM0R2pNWTlvTFBy?=
 =?utf-8?B?OUZrZkIzS09ham1ac1loN1BtQ0k5NTVkc3g5elM3VXdWbVM4ekF0by94S2kv?=
 =?utf-8?B?aWxpTGtXZ2o3V2paK1BnQ25IUUgyVUlTV1pMWTFiMk1NNUJSQlhlR0FVNXBU?=
 =?utf-8?B?RkR4cGRoMUxSNjZOU2N6OEpUcHlGRy9UeEMvc3RpWkNLK2w0RC9tNk9JMWc0?=
 =?utf-8?B?K0tYR0NDRHhRdUVScDRxNFBHMnlDS01JT2UvcHZsM2NYaEUzTDk1cXpDaFBW?=
 =?utf-8?B?TERYWTk4SGNsUERjb1lQYU9yL1JYZUFkbTFyVHhQeTU5UWQ5MlVrYnBFcER2?=
 =?utf-8?B?ckliNTdkbmdibGI2cFlSQm5SSlhCNWNWWisxb2RiUm1pSXkvMExCTjRIQTVP?=
 =?utf-8?B?Nm9RN0QraFFOSktBUGY5bFZBT2VKNXRheURIQkFMei9iVENWWDJTT2FKTk12?=
 =?utf-8?B?dldSMzhKMWJxRXBMY2x6SnBuRXVRYTZnUUdEQWxzanpYT212d0hqK2NjditJ?=
 =?utf-8?B?WnU5WHQwbTJHT1JLOWw0bjF1OW1KczRjbGhPMXhrMFlrZVVVbWVEb3VhZjY1?=
 =?utf-8?B?N0RFOEFrL1I2M2Y5QVA5T2xkR0NUd2gwcXZ3N0loU1ZPczY5QWdSNzdCb0s5?=
 =?utf-8?B?c0FOSlo4S1J2cFFpMENPazRuVlZSd1F1Y201UWVla3pJSTNJejA4SVJPMWtw?=
 =?utf-8?B?QXpkbFlPUGt2eEFBbmFDbFBvZjhYM0YwVTRnR3gzUzE0Z3VURW9kUWF3Vjg4?=
 =?utf-8?B?dU9lOGM1RUlhRXY4SDU4cVNQQlBqOGU1T0VwM01EL1pPL0FsY1NqN1JzR1NM?=
 =?utf-8?B?QnBWZ21Ud2EwZnZsV1NnLzFRSk0rS1ZiNzJiOXNnbTdkbzlNMmY4MW40TTlS?=
 =?utf-8?B?U1lWb3paOGh3WUtPdFNUSzNtdFgzOFpMbFg4UmU0SnBvdHpyUlEwMm9qTDE1?=
 =?utf-8?B?bHBIWVNWbjViTHprYzBvRmI3RGVBZWRMcXExUnY2OHI2ckJyQTVLNzhIbUpF?=
 =?utf-8?B?VGd0Z1VWNlFONXd4Q09vaS9FVkFsU0Z5Ym92eWNQYms0WlFyY251bTdMcEVp?=
 =?utf-8?B?TUxjNzMrcFd0ckkrcGtNamIwOS9jckVBVWhINllqMjNxc0VxT0NQbkx5VmI2?=
 =?utf-8?B?SG96d0V3YVVuM2xUL3FOeWlNT05sU3oya3FYN3FPcXlTWDNOQUlpanZ5M1JC?=
 =?utf-8?B?V011WkdDakI2L2FveklWbDd3bVVTb01tYUhPcGl6TjlQa3FBT0hlenRoLzVs?=
 =?utf-8?B?MUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bcf03d-e9fe-419f-4b75-08daef43e895
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 17:40:16.9979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D+le/cXKSsbiPxYmUcF4a1WeMlyTx1ipX1zCZSrJZ94uQ84TIPMgYGHR/P3DqwK5H2w8PkDjUTfgLS7KjSc3tV/ZlQ9tKsooF6cN8pZk720=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8676
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmFydG9zeiwNCg0KVGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrIQ0KDQo+IA0KPiBPbiBUdWUs
IERlYyAxMywgMjAyMiBhdCAxMTo0MyBQTSBGYWJyaXppbyBDYXN0cm8NCj4gPGZhYnJpemlvLmNh
c3Ryby5qekByZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBUaGUgUlovVjJNIFNvQyBjb250
YWlucyBhbiBFeHRlcm5hbCBQb3dlciBTZXF1ZW5jZSBDb250cm9sbGVyIChQV0MpDQo+ID4gbW9k
dWxlLiBUaGlzIG1vZHVsZSBwcm92aWRlcyBhbiBleHRlcm5hbCBwb3dlciBzdXBwbHkgb24vb2Zm
IHNlcXVlbmNlLA0KPiA+IG9uL29mZiBzaWduYWwgZm9yIHRoZSBMUEREUjQgY29yZSBwb3dlciBz
dXBwbHksIGNvbnRyb2wgc2lnbmFscyBmb3INCj4gPiBleHRlcm5hbCBJL08gcG93ZXIgc3VwcGxp
ZXMgb2YgdGhlIFNEIGhvc3QgaW50ZXJmYWNlcywgYW5kIGtleSBpbnB1dA0KPiA+IHNpZ25hbHMu
DQo+ID4gUFdDIGlzIGVzc2VudGlhbGx5IGEgTXVsdGktRnVuY3Rpb24gRGV2aWNlIChNRkQpLg0K
PiA+DQo+ID4gVGhlIGRyaXZlciBqdXN0IGltcGxlbWVudHMgdGhlIGNvbnRyb2wgc2lnbmFscyBm
b3IgZXh0ZXJuYWwgSS9PDQo+ID4gcG93ZXIgc3VwcGxpZXMgb2YgdGhlIFNEIGhvc3QgaW50ZXJm
YWNlcyBhcyBncGlvcywgYW5kIGl0IHJlbGllcyBvbg0KPiA+IHN5c2NvbiBhbmQgc2ltcGxlLW1m
ZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBoaWwgRWR3b3J0aHkgPHBoaWwuZWR3b3J0aHlA
cmVuZXNhcy5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogRmFicml6aW8gQ2FzdHJvIDxmYWJyaXpp
by5jYXN0cm8uanpAcmVuZXNhcy5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3Bpby9LY29u
ZmlnICAgICAgICAgIHwgICA4ICsrKw0KPiA+ICBkcml2ZXJzL2dwaW8vTWFrZWZpbGUgICAgICAg
ICB8ICAgMSArDQo+ID4gIGRyaXZlcnMvZ3Bpby9ncGlvLXJ6djJtLXB3Yy5jIHwgMTIzICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAxMzIg
aW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncGlvL2dwaW8t
cnp2Mm0tcHdjLmMNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwaW8vS2NvbmZpZyBi
L2RyaXZlcnMvZ3Bpby9LY29uZmlnDQo+ID4gaW5kZXggZTZlYmM0YzkwYTVkLi5lMDE2OTE5Yjk2
NDMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncGlvL0tjb25maWcNCj4gPiArKysgYi9kcml2
ZXJzL2dwaW8vS2NvbmZpZw0KPiA+IEBAIC01NTMsNiArNTUzLDE0IEBAIGNvbmZpZyBHUElPX1JP
Q0tDSElQDQo+ID4gICAgICAgICBoZWxwDQo+ID4gICAgICAgICAgIFNheSB5ZXMgaGVyZSB0byBz
dXBwb3J0IEdQSU8gb24gUm9ja2NoaXAgU29Dcy4NCj4gPg0KPiA+ICtjb25maWcgR1BJT19SWlYy
TV9QV0MNCj4gPiArICAgICAgIHRyaXN0YXRlICJSZW5lc2FzIFJaL1YyTSBQV0MgR1BJTyBzdXBw
b3J0Ig0KPiA+ICsgICAgICAgZGVwZW5kcyBvbiBNRkRfU1lTQ09ODQo+ID4gKyAgICAgICBkZXBl
bmRzIG9uIEFSQ0hfUjlBMDlHMDExIHx8IENPTVBJTEVfVEVTVA0KPiA+ICsgICAgICAgaGVscA0K
PiA+ICsgICAgICAgICBTYXkgeWVzIGhlcmUgdG8gc3VwcG9ydCB0aGUgRXh0ZXJuYWwgUG93ZXIg
U2VxdWVuY2UgQ29udHJvbGxlcg0KPiAoUFdDKQ0KPiA+ICsgICAgICAgICBHUElPIGNvbnRyb2xs
ZXIgZHJpdmVyIGZvciBSWi9WMk0gZGV2aWNlcy4NCj4gPiArDQo+ID4gIGNvbmZpZyBHUElPX1NB
TUE1RDJfUElPQlUNCj4gPiAgICAgICAgIHRyaXN0YXRlICJTQU1BNUQyIFBJT0JVIEdQSU8gc3Vw
cG9ydCINCj4gPiAgICAgICAgIGRlcGVuZHMgb24gTUZEX1NZU0NPTg0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwaW8vTWFrZWZpbGUgYi9kcml2ZXJzL2dwaW8vTWFrZWZpbGUNCj4gPiBpbmRl
eCAzNDYyYTEzODc2NGEuLjVmNjU1Njg0NjAzZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dw
aW8vTWFrZWZpbGUNCj4gPiArKysgYi9kcml2ZXJzL2dwaW8vTWFrZWZpbGUNCj4gPiBAQCAtMTMy
LDYgKzEzMiw3IEBAIG9iai0kKENPTkZJR19HUElPX1JEQzMyMVgpICAgICAgICAgICs9IGdwaW8t
DQo+IHJkYzMyMXgubw0KPiA+ICBvYmotJChDT05GSUdfR1BJT19SRUFMVEVLX09UVE8pICAgICAg
ICAgICAgICAgICs9IGdwaW8tcmVhbHRlay1vdHRvLm8NCj4gPiAgb2JqLSQoQ09ORklHX0dQSU9f
UkVHKSAgICAgICAgICAgICAgICAgKz0gZ3Bpby1yZWcubw0KPiA+ICBvYmotJChDT05GSUdfR1BJ
T19ST0NLQ0hJUCkgICAgKz0gZ3Bpby1yb2NrY2hpcC5vDQo+ID4gK29iai0kKENPTkZJR19HUElP
X1JaVjJNX1BXQykgICAgICAgICAgICs9IGdwaW8tcnp2Mm0tcHdjLm8NCj4gPiAgb2JqLSQoQ09O
RklHX0FSQ0hfU0ExMTAwKSAgICAgICAgICAgICAgKz0gZ3Bpby1zYTExMDAubw0KPiA+ICBvYmot
JChDT05GSUdfR1BJT19TQU1BNUQyX1BJT0JVKSAgICAgICArPSBncGlvLXNhbWE1ZDItcGlvYnUu
bw0KPiA+ICBvYmotJChDT05GSUdfR1BJT19TQ0gzMTFYKSAgICAgICAgICAgICArPSBncGlvLXNj
aDMxMXgubw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwaW8vZ3Bpby1yenYybS1wd2MuYyBi
L2RyaXZlcnMvZ3Bpby9ncGlvLXJ6djJtLQ0KPiBwd2MuYw0KPiA+IG5ldyBmaWxlIG1vZGUgMTAw
NjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi42NzJkODY4Y2I4YzkNCj4gPiAtLS0gL2Rldi9u
dWxsDQo+ID4gKysrIGIvZHJpdmVycy9ncGlvL2dwaW8tcnp2Mm0tcHdjLmMNCj4gPiBAQCAtMCww
ICsxLDEyMyBAQA0KPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5
DQo+ID4gKy8qDQo+ID4gKyAqIENvcHlyaWdodCAoQykgMjAyMiBSZW5lc2FzIEVsZWN0cm9uaWNz
IENvcnBvcmF0aW9uDQo+ID4gKyAqDQo+ID4gKyAqIEdQSU8gZHJpdmVyIGZvciBSZW5lc2FzIFJa
L1YyTSBFeHRlcm5hbCBQb3dlciBTZXF1ZW5jZSBDb250cm9sbGVyDQo+IChQV0MpDQo+ID4gKyAq
Lw0KPiA+ICsNCj4gPiArI2luY2x1ZGUgPGxpbnV4L2dwaW8vZHJpdmVyLmg+DQo+ID4gKyNpbmNs
dWRlIDxsaW51eC9tZmQvc3lzY29uLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9k
ZXZpY2UuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3JlZ21hcC5oPg0KPiA+ICsjaW5jbHVkZSA8
bGludXgvc3BpbmxvY2suaD4NCj4gPiArDQo+ID4gK3N0cnVjdCByenYybV9wd2NfZ3Bpb19wcml2
IHsNCj4gPiArICAgICAgIHN0cnVjdCBncGlvX2NoaXAgZ3A7DQo+ID4gKyAgICAgICBpbnQgb2Zm
c2V0Ow0KPiA+ICsgICAgICAgc3RydWN0IHJlZ21hcCAqcmVnbWFwOw0KPiA+ICsgICAgICAgREVD
TEFSRV9CSVRNQVAoY2hfZW5fYml0cywgMik7DQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMg
dm9pZCByenYybV9wd2NfZ3Bpb19zZXQoc3RydWN0IGdwaW9fY2hpcCAqY2hpcCwgdW5zaWduZWQg
aW50DQo+IG9mZnNldCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IHZh
bHVlKQ0KPiA+ICt7DQo+ID4gKyAgICAgICBzdHJ1Y3Qgcnp2Mm1fcHdjX2dwaW9fcHJpdiAqcHJp
diA9IGdwaW9jaGlwX2dldF9kYXRhKGNoaXApOw0KPiA+ICsgICAgICAgdTMyIHJlZzsNCj4gPiAr
DQo+ID4gKyAgICAgICAvKiBCSVQgMTYgZW5hYmxlcyB3cml0ZSB0byBCSVQgMCwgYW5kIEJJVCAx
NyBlbmFibGVzIHdyaXRlIHRvDQo+IEJJVCAxICovDQo+ID4gKyAgICAgICByZWcgPSBCSVQob2Zm
c2V0ICsgMTYpOw0KPiA+ICsgICAgICAgaWYgKHZhbHVlKQ0KPiA+ICsgICAgICAgICAgICAgICBy
ZWcgfD0gQklUKG9mZnNldCk7DQo+ID4gKw0KPiA+ICsgICAgICAgcmVnbWFwX3dyaXRlKHByaXYt
PnJlZ21hcCwgcHJpdi0+b2Zmc2V0LCByZWcpOw0KPiA+ICsNCj4gPiArICAgICAgIGlmICh2YWx1
ZSkNCj4gPiArICAgICAgICAgICAgICAgc2V0X2JpdChvZmZzZXQsIHByaXYtPmNoX2VuX2JpdHMp
Ow0KPiA+ICsgICAgICAgZWxzZQ0KPiA+ICsgICAgICAgICAgICAgICBjbGVhcl9iaXQob2Zmc2V0
LCBwcml2LT5jaF9lbl9iaXRzKTsNCj4gDQo+IFlvdSBjYW4gdXNlIGFzc2lnbl9iaXQoKSBoZXJl
IGFuZCBwYXNzIHZhbHVlIHRvIGl0Lg0KDQpHb29kIHBvaW50LCBJIHdpbGwgZml4IGl0IGluIHYz
Lg0KDQo+IA0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IHJ6djJtX3B3Y19ncGlvX2dl
dChzdHJ1Y3QgZ3Bpb19jaGlwICpjaGlwLCB1bnNpZ25lZCBpbnQNCj4gb2Zmc2V0KQ0KPiA+ICt7
DQo+ID4gKyAgICAgICBzdHJ1Y3Qgcnp2Mm1fcHdjX2dwaW9fcHJpdiAqcHJpdiA9IGdwaW9jaGlw
X2dldF9kYXRhKGNoaXApOw0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiB0ZXN0X2JpdChvZmZz
ZXQsIHByaXYtPmNoX2VuX2JpdHMpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IHJ6
djJtX3B3Y19ncGlvX2RpcmVjdGlvbl9vdXRwdXQoc3RydWN0IGdwaW9fY2hpcCAqZ2MsDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCBu
ciwgaW50IHZhbHVlKQ0KPiA+ICt7DQo+ID4gKyAgICAgICBpZiAobnIgPiAxKQ0KPiA+ICsgICAg
ICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiArDQo+ID4gKyAgICAgICByenYybV9wd2Nf
Z3Bpb19zZXQoZ2MsIG5yLCB2YWx1ZSk7DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0dXJuIDA7DQo+
ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZ3Bpb19jaGlwIHJ6djJtX3B3
Y19nYyA9IHsNCj4gPiArICAgICAgIC5sYWJlbCA9ICJyenYybV9wd2NfZ3BpbyIsDQo+ID4gKyAg
ICAgICAub3duZXIgPSBUSElTX01PRFVMRSwNCj4gPiArICAgICAgIC5nZXQgPSByenYybV9wd2Nf
Z3Bpb19nZXQsDQo+ID4gKyAgICAgICAuc2V0ID0gcnp2Mm1fcHdjX2dwaW9fc2V0LA0KPiA+ICsg
ICAgICAgLmRpcmVjdGlvbl9vdXRwdXQgPSByenYybV9wd2NfZ3Bpb19kaXJlY3Rpb25fb3V0cHV0
LA0KPiA+ICsgICAgICAgLmNhbl9zbGVlcCA9IGZhbHNlLA0KPiA+ICsgICAgICAgLm5ncGlvID0g
MiwNCj4gPiArICAgICAgIC5iYXNlID0gLTEsDQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMg
aW50IHJ6djJtX3B3Y19ncGlvX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ID4gK3sNCj4gPiArICAgICAgIHN0cnVjdCByenYybV9wd2NfZ3Bpb19wcml2ICpwcml2Ow0KPiA+
ICsgICAgICAgaW50IGVycjsNCj4gPiArDQo+ID4gKyAgICAgICBwcml2ID0gZGV2bV9remFsbG9j
KCZwZGV2LT5kZXYsIHNpemVvZigqcHJpdiksIEdGUF9LRVJORUwpOw0KPiA+ICsgICAgICAgaWYg
KCFwcml2KQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gPiArDQo+ID4g
KyAgICAgICBwcml2LT5yZWdtYXAgPSBzeXNjb25fcmVnbWFwX2xvb2t1cF9ieV9waGFuZGxlKHBk
ZXYtDQo+ID5kZXYub2Zfbm9kZSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgInJlZ21hcCIpOw0KPiA+ICsNCj4gPiArICAgICAgIGlm
IChJU19FUlIocHJpdi0+cmVnbWFwKSkNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIGRldl9l
cnJfcHJvYmUoJnBkZXYtPmRldiwgUFRSX0VSUihwcml2LT5yZWdtYXApLA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiQ2FuJ3QgZmluZCByZWdtYXAgcHJvcGVydHki
KTsNCj4gPiArDQo+ID4gKyAgICAgICBlcnIgPSBvZl9wcm9wZXJ0eV9yZWFkX3UzMihwZGV2LT5k
ZXYub2Zfbm9kZSwgIm9mZnNldCIsICZwcml2LQ0KPiA+b2Zmc2V0KTsNCj4gDQo+IFBsZWFzZSBk
b24ndCB1c2UgT0YgQVBJcyBpbiBkcml2ZXJzIGFueW1vcmUsIHVzZQ0KPiBkZXZpY2VfcHJvcGVy
dHlfcmVhZF91MzIoKSBpbnN0ZWFkLg0KDQoNCkdvdGNoYSwgSSdsbCBmaXggaXQgaW4gdjMuDQoN
ClRoYW5rcyENCkZhYg0KDQo+IA0KPiBPdGhlcndpc2UgbG9va3MgcHJldHR5IGdvb2QhDQo+IA0K
PiBCYXJ0DQo+IA0KPiA+ICsgICAgICAgaWYgKGVycikNCj4gPiArICAgICAgICAgICAgICAgcmV0
dXJuIGRldl9lcnJfcHJvYmUoJnBkZXYtPmRldiwgLUVJTlZBTCwNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIkNhbid0IGZpbmQgb2Zmc2V0IHByb3BlcnR5Iik7DQo+
ID4gKw0KPiA+ICsgICAgICAgLyoNCj4gPiArICAgICAgICAqIFRoZSByZWdpc3RlciB1c2VkIGJ5
IHRoaXMgZHJpdmVyIGNhbm5vdCBiZSByZWFkLCB0aGVyZWZvcmUNCj4gc2V0IHRoZQ0KPiA+ICsg
ICAgICAgICogb3V0cHV0cyB0byB0aGVpciBkZWZhdWx0IHZhbHVlcyBhbmQgaW5pdGlhbGl6ZSBw
cml2LQ0KPiA+Y2hfZW5fYml0cyBhY2NvcmRpbmdseS4NCj4gPiArICAgICAgICAqIEJJVCAxNiBl
bmFibGVzIHdyaXRlIHRvIEJJVCAwLCBCSVQgMTcgZW5hYmxlcyB3cml0ZSB0byBCSVQgMSwNCj4g
YW5kIHRoZQ0KPiA+ICsgICAgICAgICogZGVmYXVsdCB2YWx1ZSBvZiBib3RoIEJJVCAwIGFuZCBC
SVQgMSBpcyAwLg0KPiA+ICsgICAgICAgICovDQo+ID4gKyAgICAgICByZWdtYXBfd3JpdGUocHJp
di0+cmVnbWFwLCBwcml2LT5vZmZzZXQsIEJJVCgxNykgfCBCSVQoMTYpKTsNCj4gPiArICAgICAg
IGJpdG1hcF96ZXJvKHByaXYtPmNoX2VuX2JpdHMsIDIpOw0KPiA+ICsNCj4gPiArICAgICAgIHBy
aXYtPmdwID0gcnp2Mm1fcHdjX2djOw0KPiA+ICsgICAgICAgcHJpdi0+Z3AucGFyZW50ID0gcGRl
di0+ZGV2LnBhcmVudDsNCj4gPiArICAgICAgIHByaXYtPmdwLmZ3bm9kZSA9IGRldl9md25vZGUo
JnBkZXYtPmRldik7DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0dXJuIGRldm1fZ3Bpb2NoaXBfYWRk
X2RhdGEoJnBkZXYtPmRldiwgJnByaXYtPmdwLCBwcml2KTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAr
c3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgcnp2Mm1fcHdjX2dwaW9fb2ZfbWF0Y2hb
XSA9IHsNCj4gPiArICAgICAgIHsgLmNvbXBhdGlibGUgPSAicmVuZXNhcyxyenYybS1wd2MtZ3Bp
byIgfSwNCj4gPiArICAgICAgIHsgLyogc2VudGluZWwgKi8gfQ0KPiA+ICt9Ow0KPiA+ICtNT0RV
TEVfREVWSUNFX1RBQkxFKG9mLCByenYybV9wd2NfZ3Bpb19vZl9tYXRjaCk7DQo+ID4gKw0KPiA+
ICtzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciByenYybV9wd2NfZ3Bpb19kcml2ZXIgPSB7
DQo+ID4gKyAgICAgICAucHJvYmUgPSByenYybV9wd2NfZ3Bpb19wcm9iZSwNCj4gPiArICAgICAg
IC5kcml2ZXIgPSB7DQo+ID4gKyAgICAgICAgICAgICAgIC5uYW1lID0gInJ6djJtX3B3Y19ncGlv
IiwNCj4gPiArICAgICAgICAgICAgICAgLm9mX21hdGNoX3RhYmxlID0gb2ZfbWF0Y2hfcHRyKHJ6
djJtX3B3Y19ncGlvX29mX21hdGNoKSwNCj4gPiArICAgICAgIH0sDQo+ID4gK307DQo+ID4gK21v
ZHVsZV9wbGF0Zm9ybV9kcml2ZXIocnp2Mm1fcHdjX2dwaW9fZHJpdmVyKTsNCj4gPiArDQo+ID4g
K01PRFVMRV9MSUNFTlNFKCJHUEwiKTsNCj4gPiArTU9EVUxFX0FVVEhPUigiRmFicml6aW8gQ2Fz
dHJvIDxjYXN0cm8uZmFicml6aW8uanpAcmVuZXNhcy5jb20+Iik7DQo+ID4gK01PRFVMRV9ERVND
UklQVElPTigiUmVuZXNhcyBSWi9WMk0gUFdDIEdQSU8iKTsNCj4gPiAtLQ0KPiA+IDIuMzQuMQ0K
PiA+DQo=
