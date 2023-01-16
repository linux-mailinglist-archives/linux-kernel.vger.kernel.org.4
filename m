Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F9266C3FE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 16:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjAPPdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 10:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjAPPcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:32:35 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2099.outbound.protection.outlook.com [40.107.114.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6289C152;
        Mon, 16 Jan 2023 07:29:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxETrBEPN2n1RCAkZIZXRUXm+7chyd35omsmi0SXxiWm6Up/ivrKUwQOVrONoSM3udZxXHbLjktLSdm4MDxqPBYL5D0jSCdU6W51LFjwEoY3TUZ70d1jjLsIeplcz2gABvzCgwzOkNWiWhM9BkTXPtECYWBg5AatQOoJFKS4ILI8dXpfw4yCds6BjNqMKHShCfwAsJ6dk9bdQbm4JJZlZxNXrzzzf+qzf1YFYCEwlk5a4kXYItJS0m17CcUvb6nfpPZDIgjKoqEgxqtYgX+nYgf/o7Ce7do1Kvo0xpAQCcQtSIQR2hFLlXTy5bBdBh8/mdWNFjy0IspfiEbndyrgwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97dLzx9vtmV9o+H97gl+Az8odlnNlYrrNMeBpX72bNk=;
 b=k0SPcSJa6Gwz4CGBUfBO3+/VRqMBCCnsDkMYZ8OvrW4VEDB6EB8xk8/rVoWQwyJVnuoCRDlY8NE7cZjtdH0/ZhBjt+lO33FTFtKi+9km/ABib7lF50W80J+Qpl8llOu/I5xMeeE1kiUg/0BhMWBGhM55vxyMb3zNz3oDeWM+vfCpdo7ZZYF/i31Mi4eo6Fy8JdtZs1NWYfATiv+5a1/yqJFYEgVuizU9tUWMpZmV3xefML8vzR40vd4yi4NPliiKKVvrW01V+iet+ELMxy5LZo4OPYS84QoTzDSjK60hUTK+vHage5VGata9TbwzEQfYGYUSDZaw1mNR86d7ECWz5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97dLzx9vtmV9o+H97gl+Az8odlnNlYrrNMeBpX72bNk=;
 b=Tt8TfZIm6TY/AFpopDgmXIMB1wTmLFz9d1XFIzqUqPPr/D9LHhS4gelS3L8CwP4wYmXPQptJZlKHaxMVm6q70ufjt/L5vsCtDlbcYxESAx4Axa3+OyQAdmeAbbNeCJv7hJMmoHa99f6mUZi3g2I1zI7iSZXePYkhWX2Mhoo2Q/U=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by OSZPR01MB7841.jpnprd01.prod.outlook.com (2603:1096:604:1b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Mon, 16 Jan
 2023 15:29:27 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e%3]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 15:29:27 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC:     Biju Das <biju.das.jz@bp.renesas.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: RE: [PATCH 2/2] watchdog: rzg2l_wdt: Handle TYPE-B reset for RZ/V2M
Thread-Topic: [PATCH 2/2] watchdog: rzg2l_wdt: Handle TYPE-B reset for RZ/V2M
Thread-Index: AQHY+nqpy1QulZVqxE28XPYMi1eo7K5VaGCAgEwg/1A=
Date:   Mon, 16 Jan 2023 15:29:27 +0000
Message-ID: <TYWPR01MB87756C88E5F099C02D3F5CA6C2C19@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20221117114907.138583-1-fabrizio.castro.jz@renesas.com>
 <20221117114907.138583-3-fabrizio.castro.jz@renesas.com>
 <69ab58fe-b3cf-3649-d55b-f43173ff5ab0@roeck-us.net>
In-Reply-To: <69ab58fe-b3cf-3649-d55b-f43173ff5ab0@roeck-us.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|OSZPR01MB7841:EE_
x-ms-office365-filtering-correlation-id: 869455ac-2960-456e-3a3e-08daf7d674a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o9HvJie1C/iUTqJzyfXkYw+q7o71mQlnvC2gnrcNik5ZhctGU6IEc1SDzBqDDw41PKWhxh77pDM+3xBcGXPxQxJzGjy/LsmPrM3CGcLquVGNdm/wu/ClxH3umPyN5+xF2JfoK7oXCzIag2F3oAEL76yhWzIGrNVoYIh/20h8KIvGYImlqgfgCPG7h6FOndv9Fl6Q/KadR7/Eb1VgNEZQdWPzZ06VNOhcD+wIq43zc5bHBSiHlhsIEF91qze4SAtLjxEiREyscE/kdtTOWQMQa8jDvpm5rs5l9gr5LURTXxIrjvSSAbox58gGKgu9HlbyioU29LafEVnXfjvoj5x12Z2qggPMlshy7Qikj7N7IrMNh4IyUz8EkKUy1woUh0b2efKuzNIo617gMCI+RQdduv8ozOvCrT4bcN8k7hxnlhF5zzZFIX953kGB6YgAI8oqNKxxW3Hg86gOekt/QP9FVLV/Nt2yckAy2vp0xlR4bsh2x+dBfebMzGOIkkXC54itaUN3WmKWVaFLg5wdUahM0hD31a8jrtDQSM1ppnxBg5VR9F6To+N7vUQR2ZPZSlqr26+RG4yfm7HckG63gy71DKvgndIFeKsEV0U+oL6jXcRTWH0vYcvUwWLZ//pN1LOnuAjIKiV628fIVQ0xp7pDgwjpvuqP5BJo2hd2UZARBwvEYBmj+9rKQxDY/2+va/qA6k+8t7baqV84YD9io70pLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199015)(6506007)(5660300002)(2906002)(76116006)(64756008)(53546011)(66446008)(8676002)(8936002)(52536014)(122000001)(83380400001)(66476007)(66556008)(38100700002)(478600001)(4326008)(33656002)(41300700001)(38070700005)(66946007)(26005)(9686003)(86362001)(186003)(55016003)(7696005)(71200400001)(54906003)(110136005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3ZlMWFCM3lTNVRaN3NIUUVMdjhxZ01TRkVUWTN5TVpaZS9UM1NOTVZOcDZo?=
 =?utf-8?B?M1hNbkdhdC9TWE8vdVJxS3dkRWxPVEsvTXB4UmEvMkVhLy9KQ2pwT3NWVFM3?=
 =?utf-8?B?cmxjM2t3U21YTktrTzBxZkEzQ3ZJZlhsZDFQS3YrODRORGMvakRWbmp1NmRa?=
 =?utf-8?B?VDJ0QjVVVmd2bFYzMHJURjA0TVpOUzY2cElwR3hwTUZUNHR0SkJuSmlVYVBH?=
 =?utf-8?B?blJUUlFDNVBENmo3dWlUdXNNN2N2dGRLeE1jbnAzdXB0cnhJQWhxcG9TN3h2?=
 =?utf-8?B?eW00ZjJYYlJnc1ludVZFQVR2eUUzaEppdlN5eTFQUmFsVlIybFZRWlQxeGFr?=
 =?utf-8?B?OUJLVFIyREw3SktMVmFuK1cxZStrOFR1RDRLVzBwQUcycmg0TTliUHBIYXh1?=
 =?utf-8?B?Z3M2L05Dd1Brejk2dDYxZEVnbmxxOE1HMGhVK0JqRVh6czRyY3NadlVXd0Z1?=
 =?utf-8?B?N2dhU1grSGFjVTVoc2FaZVJyUzVleThrMFJWd3dWdTJWNjV3emduNCtJNlZR?=
 =?utf-8?B?Yi8wbE5GVmFaK1ZlR21haDIvdlVjU2xkOUVROWwvQ2s0ZHBHV0gyc0ltblYr?=
 =?utf-8?B?OXpvUzNKNlBUL3ZidGJ4L0wwQXR1cmZZeHgyWEU0YmRQbXhxaGV3Z1VCRnlr?=
 =?utf-8?B?Z1RvWGI2UmJzTXFweTZGWldWaVAvNmVacVE3Z0VydGJlOU5GSHljOU1CWDFo?=
 =?utf-8?B?QjJyUEJCMW4rdlFUc2xsSE5ia1dCMFNiLzJvSlk4eWxaMG12V0xZWjMrcy9F?=
 =?utf-8?B?NCttVUdCaWtUMEYrWW9BT3VXQzBzeDVNTlBhVzhIUmVpa2Z3bzRoSUxONjd1?=
 =?utf-8?B?dnhnaVJ0Vjk1UmpRQXdWY1laaGppclN2aEIxR0x4QytvTXFib2tNOWg0eTlj?=
 =?utf-8?B?TEl6aW44OFMwajV4MjJLOGE4blhwVzJjaTFQbVFWalZpL2EwWDRZL0xkWDUy?=
 =?utf-8?B?Vy9RZHdTRXZnOXJZd0JMRkJOMVg4QUlHUVphN0tRNHc5akRhNi9uK2FEL2h3?=
 =?utf-8?B?di9DSWJ0TTQwc3RzUjVDeDR0MHp3RXoyQis1dnJHYmRrN3pXWjRmU1lpcUkr?=
 =?utf-8?B?blROeGMrSWx0SWNBNXcxS1A4WDU3UHhjSTBDTEJsdUZEdFh5bHo3cDRBZXpW?=
 =?utf-8?B?RTRjRVdNZy9UR3oyTU5RTllob0RjTnFsb3V6eHZuOGRkcVlYak1zRkVROURM?=
 =?utf-8?B?UWhNRnppYi9xUHh3VjhrZlVydFRyN0RQcGg4TTVwRTNla2hzNGNyV2xxNng0?=
 =?utf-8?B?THlGOWVoL2plTWRVZUt0Y2laSm9lRkRFb2dpL1F2U0JXRnRQU0IyVTFYNTJE?=
 =?utf-8?B?ZUZHSW5vb1NqV25vbmFVejVxT1lYU2tTcmdHU24zRjBTT3FHaENtZEtjTERR?=
 =?utf-8?B?ZGJ1S2N1dnNwRWp5SytvSHBYT2xhbEVTSklBYk0rb01qUGx1YlgzZFNtempR?=
 =?utf-8?B?VGQ5VC90d05qb3BqYXpiMWMwZHdBd0FYTFZBNW54bG0xUWVsdGRqZWRUaGk2?=
 =?utf-8?B?SHF6YmQvb0J3TGVpOGF0T3NYUHpaQk9TbURlWTRHb01FRVliRGtveitTRGFT?=
 =?utf-8?B?UHlaQXYyM2thUmh0MzlXWXNSMnNQazFkS2hzU096NFVwYTcvZkNFai9RL2xy?=
 =?utf-8?B?YUs4c2RJQlFVeHlaMG4weGRHaDladURCbEx2MHhxSHRPTFEwcnhHdEp1VnZR?=
 =?utf-8?B?SWZpdWlsemxDQXJuWDFFSzZRWkZVRjlGZEtuNEthOHB6UVd1WW8yMzBzQkF5?=
 =?utf-8?B?YjAxNXl3OGh3RnhuQ01RZWhIMTE3d2xkdU53NGVRNzlONlQ3Uy9Dam5vZlVx?=
 =?utf-8?B?MFpwZTQyR3JucWxzbk9rWEpqZDRWTGdhSy9QT0o4Z1ZQZEgvWnpqWWJTdnJN?=
 =?utf-8?B?S2Y3ZFFxWk5HaEpUbmJ5d0h2Ty9OcENJOWx3eHIvWFd1Z0wzc1RvbUN4QkQ3?=
 =?utf-8?B?QTVuOWNPN3pCT3lMZC9SczV5VDM3cEtqUFkxZWZEU3I2VnQ1eldjYlM1WWRy?=
 =?utf-8?B?M3l2SjV0SHhTOVN4NGE2blRnMmNRME1GbE05cFZDODZwYnQ3dEsrSWl4R0ll?=
 =?utf-8?B?Rk1oVnBXZlV3QXhvczZzOXRNM0wyNTdiZEJvcjBpZlNnckdDd281bEhCS2Rq?=
 =?utf-8?B?b2pvczcyT1V5QzBHSzIvbXhIZThTL2xmWFBaK3dIVlhRcUJtV3lpRzdtOGZX?=
 =?utf-8?B?eHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 869455ac-2960-456e-3a3e-08daf7d674a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 15:29:27.7442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uwSJ022vRNZQL4hrvGA63dUOdSQN44TAfB1zML5ECsWFE7JnRi1BMGT5wfK7c5DBKseMVKs5JOv5QiRcQ5cgTSO/e0LOJMDObUIIlU/WsZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7841
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNCkhhdmUgeW91IGhhZCB0aGUgY2hhbmNlIHRvIGxvb2sgaW50byB0aGlzIHBh
dGNoPw0KSSB3YXMgaG9waW5nIGl0IGNvdWxkIGdldCB0YWtlbiBmb3IgdjYuMz8NCg0KVGhhbmtz
LA0KRmFiDQoNCj4gDQo+IE9uIDExLzE3LzIyIDAzOjQ5LCBGYWJyaXppbyBDYXN0cm8gd3JvdGU6
DQo+ID4gQXMgcGVyIHNlY3Rpb24gNDguNCBvZiB0aGUgSFcgVXNlciBNYW51YWwsIElQcyBpbiB0
aGUgUlovVjJNDQo+ID4gU29DIG5lZWQgZWl0aGVyIGEgVFlQRS1BIHJlc2V0IHNlcXVlbmNlIG9y
IGEgVFlQRS1CIHJlc2V0DQo+ID4gc2VxdWVuY2UuIE1vcmUgc3BlY2lmaWNhbGx5LCB0aGUgd2F0
Y2hkb2cgSVAgbmVlZHMgYSBUWVBFLUINCj4gPiByZXNldCBzZXF1ZW5jZS4NCj4gPg0KPiA+IElm
IHRoZSBwcm9wZXIgcmVzZXQgc2VxdWVuY2UgaXNuJ3QgaW1wbGVtZW50ZWQsIHRoZW4gcmVzZXR0
aW5nDQo+ID4gSVBzIG1heSBsZWFkIHRvIHVuZGVzaXJlZCBiZWhhdmlvdXIuIEluIHRoZSByZXN0
YXJ0IGNhbGxiYWNrIG9mDQo+ID4gdGhlIHdhdGNoZG9nIGRyaXZlciB0aGUgcmVzZXQgaGFzIGJh
c2ljYWxseSBubyBlZmZlY3Qgb24gdGhlDQo+ID4gZGVzaXJlZCBmdW5jaW9uYWxpdHksIGFzIHRo
ZSByZWdpc3RlciB3cml0ZXMgZm9sbG93aW5nIHRoZSByZXNldA0KPiA+IGhhcHBlbiBiZWZvcmUg
dGhlIElQIG1hbmFnZXMgdG8gY29tZSBvdXQgb2YgcmVzZXQuDQo+ID4NCj4gPiBJbXBsZW1lbnQg
dGhlIFRZUEUtQiByZXNldCBzZXF1ZW5jZSBpbiB0aGUgd2F0Y2hkb2cgZHJpdmVyIHRvDQo+ID4g
YWRkcmVzcyB0aGUgaXNzdWVzIHdpdGggdGhlIHJlc3RhcnQgY2FsbGJhY2sgb24gUlovVjJNLg0K
PiA+DQo+ID4gRml4ZXM6IGVjMTIyZmQ5NGVlYiAoIndhdGNoZG9nOiByemcybF93ZHQ6IEFkZCBy
enYybSBzdXBwb3J0IikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBGYWJyaXppbyBDYXN0cm8gPGZhYnJp
emlvLmNhc3Ryby5qekByZW5lc2FzLmNvbT4NCj4gDQo+IFJldmlld2VkLWJ5OiBHdWVudGVyIFJv
ZWNrIDxsaW51eEByb2Vjay11cy5uZXQ+DQo+IA0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy93YXRj
aGRvZy9yemcybF93ZHQuYyB8IDM3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3dhdGNoZG9nL3J6ZzJsX3dkdC5jIGIvZHJp
dmVycy93YXRjaGRvZy9yemcybF93ZHQuYw0KPiA+IGluZGV4IGNlY2E0MmRiMDgzNy4uZDQwNDk1
M2QwZTBmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvd2F0Y2hkb2cvcnpnMmxfd2R0LmMNCj4g
PiArKysgYi9kcml2ZXJzL3dhdGNoZG9nL3J6ZzJsX3dkdC5jDQo+ID4gQEAgLTgsNiArOCw3IEBA
DQo+ID4gICAjaW5jbHVkZSA8bGludXgvY2xrLmg+DQo+ID4gICAjaW5jbHVkZSA8bGludXgvZGVs
YXkuaD4NCj4gPiAgICNpbmNsdWRlIDxsaW51eC9pby5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgv
aW9wb2xsLmg+DQo+ID4gICAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQo+ID4gICAjaW5jbHVk
ZSA8bGludXgvbW9kdWxlLmg+DQo+ID4gICAjaW5jbHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+DQo+
ID4gQEAgLTM1LDYgKzM2LDggQEANCj4gPg0KPiA+ICAgI2RlZmluZSBGMkNZQ0xFX05TRUMoZikJ
CQkoMTAwMDAwMDAwMCAvIChmKSkNCj4gPg0KPiA+ICsjZGVmaW5lIFJaVjJNX0FfTlNFQwkJCTcz
MA0KPiA+ICsNCj4gPiAgIHN0YXRpYyBib29sIG5vd2F5b3V0ID0gV0FUQ0hET0dfTk9XQVlPVVQ7
DQo+ID4gICBtb2R1bGVfcGFyYW0obm93YXlvdXQsIGJvb2wsIDApOw0KPiA+ICAgTU9EVUxFX1BB
Uk1fREVTQyhub3dheW91dCwgIldhdGNoZG9nIGNhbm5vdCBiZSBzdG9wcGVkIG9uY2Ugc3RhcnRl
ZA0KPiAoZGVmYXVsdD0iDQo+ID4gQEAgLTUxLDExICs1NCwzNSBAQCBzdHJ1Y3QgcnpnMmxfd2R0
X3ByaXYgew0KPiA+ICAgCXN0cnVjdCByZXNldF9jb250cm9sICpyc3RjOw0KPiA+ICAgCXVuc2ln
bmVkIGxvbmcgb3NjX2Nsa19yYXRlOw0KPiA+ICAgCXVuc2lnbmVkIGxvbmcgZGVsYXk7DQo+ID4g
Kwl1bnNpZ25lZCBsb25nIG1pbmltdW1fYXNzZXJ0aW9uX3BlcmlvZDsNCj4gPiAgIAlzdHJ1Y3Qg
Y2xrICpwY2xrOw0KPiA+ICAgCXN0cnVjdCBjbGsgKm9zY19jbGs7DQo+ID4gICAJZW51bSByel93
ZHRfdHlwZSBkZXZ0eXBlOw0KPiA+ICAgfTsNCj4gPg0KPiA+ICtzdGF0aWMgaW50IHJ6ZzJsX3dk
dF9yZXNldChzdHJ1Y3QgcnpnMmxfd2R0X3ByaXYgKnByaXYpDQo+ID4gK3sNCj4gPiArCWludCBl
cnIsIHN0YXR1czsNCj4gPiArDQo+ID4gKwlpZiAocHJpdi0+ZGV2dHlwZSA9PSBXRFRfUlpWMk0p
IHsNCj4gPiArCQkvKiBXRFQgbmVlZHMgVFlQRS1CIHJlc2V0IGNvbnRyb2wgKi8NCj4gPiArCQll
cnIgPSByZXNldF9jb250cm9sX2Fzc2VydChwcml2LT5yc3RjKTsNCj4gPiArCQlpZiAoZXJyKQ0K
PiA+ICsJCQlyZXR1cm4gZXJyOw0KPiA+ICsJCW5kZWxheShwcml2LT5taW5pbXVtX2Fzc2VydGlv
bl9wZXJpb2QpOw0KPiA+ICsJCWVyciA9IHJlc2V0X2NvbnRyb2xfZGVhc3NlcnQocHJpdi0+cnN0
Yyk7DQo+ID4gKwkJaWYgKGVycikNCj4gPiArCQkJcmV0dXJuIGVycjsNCj4gPiArCQllcnIgPSBy
ZWFkX3BvbGxfdGltZW91dChyZXNldF9jb250cm9sX3N0YXR1cywgc3RhdHVzLA0KPiA+ICsJCQkJ
CXN0YXR1cyAhPSAxLCAwLCAxMDAwLCBmYWxzZSwNCj4gPiArCQkJCQlwcml2LT5yc3RjKTsNCj4g
PiArCX0gZWxzZSB7DQo+ID4gKwkJZXJyID0gcmVzZXRfY29udHJvbF9yZXNldChwcml2LT5yc3Rj
KTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gZXJyOw0KPiA+ICt9DQo+ID4gKw0KPiA+
ICAgc3RhdGljIHZvaWQgcnpnMmxfd2R0X3dhaXRfZGVsYXkoc3RydWN0IHJ6ZzJsX3dkdF9wcml2
ICpwcml2KQ0KPiA+ICAgew0KPiA+ICAgCS8qIGRlbGF5IHRpbWVyIHdoZW4gY2hhbmdlIHRoZSBz
ZXR0aW5nIHJlZ2lzdGVyICovDQo+ID4gQEAgLTExNSw3ICsxNDIsNyBAQCBzdGF0aWMgaW50IHJ6
ZzJsX3dkdF9zdG9wKHN0cnVjdCB3YXRjaGRvZ19kZXZpY2UNCj4gKndkZXYpDQo+ID4gICB7DQo+
ID4gICAJc3RydWN0IHJ6ZzJsX3dkdF9wcml2ICpwcml2ID0gd2F0Y2hkb2dfZ2V0X2RydmRhdGEo
d2Rldik7DQo+ID4NCj4gPiAtCXJlc2V0X2NvbnRyb2xfcmVzZXQocHJpdi0+cnN0Yyk7DQo+ID4g
KwlyemcybF93ZHRfcmVzZXQocHJpdik7DQo+ID4gICAJcG1fcnVudGltZV9wdXQod2Rldi0+cGFy
ZW50KTsNCj4gPg0KPiA+ICAgCXJldHVybiAwOw0KPiA+IEBAIC0xNTQsNiArMTgxLDcgQEAgc3Rh
dGljIGludCByemcybF93ZHRfcmVzdGFydChzdHJ1Y3Qgd2F0Y2hkb2dfZGV2aWNlDQo+ICp3ZGV2
LA0KPiA+ICAgCQlyemcybF93ZHRfd3JpdGUocHJpdiwgUEVFTl9GT1JDRSwgUEVFTik7DQo+ID4g
ICAJfSBlbHNlIHsNCj4gPiAgIAkJLyogUlovVjJNIGRvZXNuJ3QgaGF2ZSBwYXJpdHkgZXJyb3Ig
cmVnaXN0ZXJzICovDQo+ID4gKwkJcnpnMmxfd2R0X3Jlc2V0KHByaXYpOw0KPiA+DQo+ID4gICAJ
CXdkZXYtPnRpbWVvdXQgPSAwOw0KPiA+DQo+ID4gQEAgLTI1MSw2ICsyNzksMTMgQEAgc3RhdGlj
IGludCByemcybF93ZHRfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4g
Pg0KPiA+ICAgCXByaXYtPmRldnR5cGUgPSAodWludHB0cl90KW9mX2RldmljZV9nZXRfbWF0Y2hf
ZGF0YShkZXYpOw0KPiA+DQo+ID4gKwlpZiAocHJpdi0+ZGV2dHlwZSA9PSBXRFRfUlpWMk0pIHsN
Cj4gPiArCQlwcml2LT5taW5pbXVtX2Fzc2VydGlvbl9wZXJpb2QgPSBSWlYyTV9BX05TRUMgKw0K
PiA+ICsJCQkzICogRjJDWUNMRV9OU0VDKHBjbGtfcmF0ZSkgKyA1ICoNCj4gPiArCQkJbWF4KEYy
Q1lDTEVfTlNFQyhwcml2LT5vc2NfY2xrX3JhdGUpLA0KPiA+ICsJCQkgICAgRjJDWUNMRV9OU0VD
KHBjbGtfcmF0ZSkpOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiAgIAlwbV9ydW50aW1lX2VuYWJsZSgm
cGRldi0+ZGV2KTsNCj4gPg0KPiA+ICAgCXByaXYtPndkZXYuaW5mbyA9ICZyemcybF93ZHRfaWRl
bnQ7DQoNCg==
