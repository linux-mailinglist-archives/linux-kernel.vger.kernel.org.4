Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915F57428D0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 16:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjF2OsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 10:48:08 -0400
Received: from mail-db5eur01on2049.outbound.protection.outlook.com ([40.107.15.49]:41989
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231208AbjF2OsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:48:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRvmyBZXQhA76FrOltzDKbwLonK1ItjjyROIKMEtRyl8PyWM23PSsM5xUiGCkUFAZL1oJDqI69Np8dhU93Gb+8ThbJ2CqDDU6wt6zqYBXJbthvfVIyXsN8ITrSM8rZMlRIyY31Tvedn2QZDQOFYP3/56ZVT9mbdT7BlL+X+9+BCmiscG+W1JH1ls7/jgSlpJxubD2N2n/m46+u7QVMQGrBqUM6X9qZ1v+8e4NSP4keOJciT8JuLfYdAd42+mp2RTN7ptA2FcJWeBlKy+7PEASYaM1uoUnVXrHeSqXG3p8Xuc6OAcvtB7EZG2OIxDRYwddYb1126PcJ8N5Y37MPZFTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XNp5vE7VepFB4E7tIiQ5RUDN6i24zV+WsVGQBfuuK8=;
 b=Wn9LVMtEhkyv4RSw12ZVsc4AIV96ihtbH1CsmmF5hC3hcT6sWpMJEYlICqzyptI7Y2fnYXtxjp/LyOQfDMraHxfcu96oIfV96ZebQYPbhkIpyiAcy5cVPDyqMzqci6JArq3gfk2h8GIfRKhGQqoOzzu8tWqOyDRMEuO9WGadmMpDVcvFy0Wwux84HEX8MTtjq7cBuFTJJxVPd7v4z7G8GwKZEzurT59lo3vJymrLBjdHyykfv7O/S+aqJssGtDpLeuexkqkAFSwbVaBTxeWu7ZTiGWccNvNHGMeUvGlRngGsebijP1R59DPk+rNxpDyj/z2ZiJdlYik+x8N1fwBuEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XNp5vE7VepFB4E7tIiQ5RUDN6i24zV+WsVGQBfuuK8=;
 b=K4KbB7OlTEXR3QZamHMt/wHkSj60gXA0ZKA7b55YqJbqJ53hfddkR4ulwaVA/XJ8dKtB0xhGi5w8dl5tOOsEIS7+0HyXHivA9+JhyKFHW29IJ3haiCwRWCt8PDr4LLNC3C10kHN16hCZjUjIKLwDnL54W4VOKVKMjmczeYEryYs=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9073.eurprd04.prod.outlook.com (2603:10a6:102:225::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 14:48:01 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 14:48:00 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>,
        "rogerq@kernel.org" <rogerq@kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        Jun Li <jun.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Elson Roy Serrao <quic_eserrao@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?utf-8?B?SsOzIMOBZ2lsYSBCaXRzY2g=?= <jgilab@gmail.com>,
        Prashanth K <quic_prashk@quicinc.com>,
        Peter Chen <peter.chen@kernel.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH 1/1] usb: gadget: call usb_gadget_check_config()
 to verify UDC capability
Thread-Topic: [EXT] Re: [PATCH 1/1] usb: gadget: call
 usb_gadget_check_config() to verify UDC capability
Thread-Index: AQHZqg9cJmDWJzO0YUW2RAkaqvNJkq+hPCYAgACeleA=
Date:   Thu, 29 Jun 2023 14:48:00 +0000
Message-ID: <AM6PR04MB483828D189E93F8215C2F5398825A@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230628222437.3188441-1-Frank.Li@nxp.com>
 <0da8f837-de99-0673-4af1-06efe4ce0a99@ti.com>
In-Reply-To: <0da8f837-de99-0673-4af1-06efe4ce0a99@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|PAXPR04MB9073:EE_
x-ms-office365-filtering-correlation-id: ca7d64ba-df33-441e-6a04-08db78afd607
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h6NL9tSwltZxzIFgDk7e7jj9QSRg5vdOgVsCYTemRZRAD6mn8FNwhYZ967cA9mwLeK+qalQA/fcnCAICliBo6hi7ojRAMzsQQ156kcYGwvd9hDW1BAA9Z0Xbve3Fo1K/qQqhO6yF3g+MIPXMFlhjJcLKx99NVVIjDZ1s6V6oVxtGNKCsMDObvYwj3paImIF6E98vFgIVVn8PXXjDBolii6dqFMfSCo/SHZsFjqVNQGRRiJkYzWY6x6Y+f6ZoU6anrkdqO/MB62T7mWoZl6B6I6dzIs0Ea5xP4IRpavMtW5S5y+ksBvhXptJCuz+F8RBzHUZhdODWeFLji1ys9rIRFbQaVrFq1qdpG5D+f0b1oLvja1WQJ538LxQbID2got6yBXtzcl1wTTPFoVRAEHusRG6V84fDLd1mp/lPJMdkFU4/ABnRgxShR9DbW+X4Q7EgsLCOXQD0pZ+/5EixUwDsU9LsYpLQbESyrMSFMLNGY+9se2wxQBIwRJ8WEkfWdhe8lsA2Eae9olHSGQjC4XcdN9GXact5kQ3GAjW1drXKUMznDCm3Xh9ZTPLON3CSZIXeD84b4a4DxfGD3Xcu/uLbmXkuaMZvQMBN92Dc3AqcAnVezznlONznaoZiiG8ubmlwvZ8Lye2JZZVUON68Z/VrKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199021)(7416002)(26005)(52536014)(5660300002)(66446008)(66946007)(66556008)(66476007)(316002)(64756008)(15650500001)(76116006)(33656002)(8676002)(8936002)(44832011)(478600001)(2906002)(55016003)(110136005)(86362001)(186003)(41300700001)(9686003)(7696005)(55236004)(53546011)(38070700005)(6506007)(921005)(83380400001)(38100700002)(122000001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmVHd0w2dEFob1RMeEtSUWtwNk5saWlabTRXM2cweUdpampRSWpzV3ZXN2tR?=
 =?utf-8?B?aTJSWXJjMjYxOExlNzNBd2h1VmNtME42b1kzeWFTekFpRC9NZnZaNklLbHNY?=
 =?utf-8?B?MnZFelVDNGc0QTVQY2RIaGNGZXlrbEFVVUJFb0toL00wZFJBdGMyU2lxUVpM?=
 =?utf-8?B?VmF1WC9HcjJtQlhjODVvUGV3ZzlqMHJDejMwN1BhN2pTMThPTGsvU3VqbnZ2?=
 =?utf-8?B?ZGRlN1ZlTGtxcURRYXBvMENhQ0xGclJNZXFBWVhhcENqMHRWekUybjJxRTA2?=
 =?utf-8?B?U3dJamlxNWtNQVRZbHNyRGIvejRRN2JPbVJ0Qy9xeDF3cVN6YWlJNUZob2JH?=
 =?utf-8?B?UE5KOWNGR1BxUTNKM0tDTVpwNUk4RkdRMk12c3p3VlNvRU44TlRuamVsWFdL?=
 =?utf-8?B?a2lFUW1PS1Q3SldBVGJFanlOSlN6ejd4a21zTXhGQ080TlJQeHdtbW9iUWtJ?=
 =?utf-8?B?ZnVtcTNZZU5renNrazMyWk8xT1dsM2dCTU5OYnNobHhHbWJTd3VXQUVTYmZC?=
 =?utf-8?B?L1V1c2puUXlIS1Fyc1BDWWMzYm5PVXZBcnRMRHIwLzVDMVZUQ292U2RWRUlB?=
 =?utf-8?B?U3kyTEI0NFVWSjFLcUxreVVDMk1sMmkyN3RSRFBrUFVQTGx2bzIxRXJVdXVD?=
 =?utf-8?B?bWZTYU5RbXR5V0x2aDVyOURBckkyU3B1V0tTTzZoWjFOTU9Dcml3c0VOazVO?=
 =?utf-8?B?NDB4dk5nUXArNUFXQnVQenlzWkxQclY5NHp2TzYwWnRxTVlSQnErZmE0cnVp?=
 =?utf-8?B?cU9XSHpkbGlERGl4U2xmKzMyeUdRbU9IL2RWSXlwMTYzUklsSDFpdkRHT2lZ?=
 =?utf-8?B?S0hpZnJ5YWdNR0lZbUVHTVRBQkVLMmJFSGxTN2lRWm5aN0toeDdQMkRRQTg1?=
 =?utf-8?B?R1JCcHlocXc3VU9rS2RoT3dJV244MXNJTFlHeUQyUXNiR1dUai9KR0F0S3FT?=
 =?utf-8?B?QndNdktlR2NYak1hSXpZRVUvQnJiazhNcGVZY2FML2RZVlR6QnVRMVVyc2sv?=
 =?utf-8?B?a0tYUTZQQ2t5UUFOL2hPbWI1L21DeUdOZ2RTZEJwYWhyMkk4a3FyTnUzTVdO?=
 =?utf-8?B?TGZUb0ZWMXhLRnh2dlFrMXY4UHlMZUNkVWJrZFNVR0JJdEIrUlZPUnY1dmZs?=
 =?utf-8?B?MmE0UC94YWZSOUpCbXcxbjNtcGlpL0JZakRLSXJRZXk5elJTSGczejZLRGJB?=
 =?utf-8?B?eSs4UWFVR014bmo5bUFCSXhYZ3A4d21YeFdwWjd4blpZQnZvQkJSYTE0Mkl2?=
 =?utf-8?B?ZW0xdVFPY2NiK3prbmR4MUxxRW4rbmxQWVBOK1I1aktzUDMwMlozSnNCU085?=
 =?utf-8?B?NTJ5bkFGaTdUVXRqeVMvRUdxb2c0KzRjc2svdTdXSTNCYVY4a2FJTXVmeGE2?=
 =?utf-8?B?OHFONTd3SzNhcUtPRk5TazhVZU1oNE03QVViZDdEbHVwRzIxUmNyaVY1eDB6?=
 =?utf-8?B?TnZUajhzNytNRnE3MzVjcXR1eUdkVlRCMTlUaXVDLzhQNXJtMHpDOVhQaFpv?=
 =?utf-8?B?a2d1Qnh1Vk95NWxqQmVWN3BOZi83ckwwNGxnVDJKSDd0T1Uyejd3Y0wydFlG?=
 =?utf-8?B?eHJiSml2ZG0yVjhWVmtEWGJwV3IveVJGNGJDKzVXdE5NNG1tU2FiTCt4ZEY0?=
 =?utf-8?B?dEpadGZ3V3JVZVJUd3RFWlpqUWNqTVZqTGdDaHcva2RPK3JZOGRka09rSEZL?=
 =?utf-8?B?eStBVFdRbzl5WHFmMnZsS0YzM1ZNTlNBN1dldFdOS296V3Z1VzhlSEhOWnl4?=
 =?utf-8?B?eW54bi9aUks0TUdYbTZsOW1BZi9hUG5UVElOcDNlWHBweVJKSm1udXJvZXhv?=
 =?utf-8?B?ZVhRbUJCVjBwMEVySzZSWXRCQ09mMUxoalIwUHlRUmZLRVF3TnlyWHNtQTJV?=
 =?utf-8?B?b2M5LzI4MEQ2RW9zWTYyTFBDNmRpM2hUdS9UdkpaWkwyLzBtUlMyVVJ0OVNQ?=
 =?utf-8?B?eDJHbmh4WWJTaWxtNjBHWXVTYzIvK2gra0swcHR5cmdjVEp3dWtVWTlDZnpv?=
 =?utf-8?B?WXVxcEZuQ0V0ZGpEaFRUbHlIS1kvMUVkQWtxUzBXb0Z5WENqdjBicDN0cHpu?=
 =?utf-8?B?Rk9vVVdLTis0OG10b0VrYTBpcXhxaXhKRTBMNEtHWkx5anRhdkNzSXBuUWll?=
 =?utf-8?Q?wlYg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7d64ba-df33-441e-6a04-08db78afd607
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 14:48:00.8409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hdnLGveDM0aeK7x0DYmQONUn5wnj+ig1eWwAMbK77jCsPVYWwSH9aj+UtV3ax1Gwvw3Sxix+9WSksjk2JQVRLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9073
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmF2aSBHdW5hc2VrYXJh
biA8ci1ndW5hc2VrYXJhbkB0aS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdW5lIDI5LCAyMDIz
IDEyOjExIEFNDQo+IFRvOiBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47IHJvZ2VycUBrZXJu
ZWwub3JnOyBpbXhAbGlzdHMubGludXguZGV2Ow0KPiBKdW4gTGkgPGp1bi5saUBueHAuY29tPjsg
R3JlZyBLcm9haC1IYXJ0bWFuDQo+IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IEVsc29u
IFJveSBTZXJyYW8NCj4gPHF1aWNfZXNlcnJhb0BxdWljaW5jLmNvbT47IFRoaW5oIE5ndXllbg0K
PiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT47IEFuZHkgU2hldmNoZW5rbw0KPiA8YW5kcml5
LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPjsgSsOzIMOBZ2lsYSBCaXRzY2ggPGpnaWxhYkBn
bWFpbC5jb20+Ow0KPiBQcmFzaGFudGggSyA8cXVpY19wcmFzaGtAcXVpY2luYy5jb20+OyBQZXRl
ciBDaGVuDQo+IDxwZXRlci5jaGVuQGtlcm5lbC5vcmc+OyBvcGVuIGxpc3Q6VVNCIFNVQlNZU1RF
TSA8bGludXgtDQo+IHVzYkB2Z2VyLmtlcm5lbC5vcmc+OyBvcGVuIGxpc3QgPGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggMS8xXSB1c2I6
IGdhZGdldDogY2FsbCB1c2JfZ2FkZ2V0X2NoZWNrX2NvbmZpZygpDQo+IHRvIHZlcmlmeSBVREMg
Y2FwYWJpbGl0eQ0KPiANCj4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxl
YXNlIHRha2UgY2FyZSB3aGVuIGNsaWNraW5nIGxpbmtzIG9yDQo+IG9wZW5pbmcgYXR0YWNobWVu
dHMuIFdoZW4gaW4gZG91YnQsIHJlcG9ydCB0aGUgbWVzc2FnZSB1c2luZyB0aGUgJ1JlcG9ydA0K
PiB0aGlzIGVtYWlsJyBidXR0b24NCj4gDQo+IA0KPiBPbiA2LzI5LzIzIDM6NTQgQU0sIEZyYW5r
IExpIHdyb3RlOg0KPiA+IFRoZSBsZWdhY3kgZ2FkZ2V0IGRyaXZlciBvbWl0dGVkIGNhbGxpbmcg
dXNiX2dhZGdldF9jaGVja19jb25maWcoKQ0KPiA+IHRvIGVuc3VyZSB0aGF0IHRoZSBVU0IgZGV2
aWNlIGNvbnRyb2xsZXIgKFVEQykgaGFzIGFkZXF1YXRlIHJlc291cmNlcywNCj4gPiBpbmNsdWRp
bmcgc3VmZmljaWVudCBlbmRwb2ludCBudW1iZXJzIGFuZCB0eXBlcywgdG8gc3VwcG9ydCB0aGUg
Z2l2ZW4NCj4gPiBjb25maWd1cmF0aW9uLg0KPiA+DQo+ID4gUHJldmlvdXNseSwgdXNiX2FkZF9j
b25maWcoKSB3YXMgc29sZWx5IGludm9rZWQgYnkgdGhlIGxlZ2FjeSBnYWRnZXQNCj4gPiBkcml2
ZXIuIEFkZHMgdGhlIG5lY2Vzc2FyeSB1c2JfZ2FkZ2V0X2NoZWNrX2NvbmZpZygpIGFmdGVyIHRo
ZSBiaW5kKCkNCj4gPiBvcGVyYXRpb24gdG8gZml4IHRoZSBpc3N1ZS4NCj4gPg0KPiA+IEZpeGVz
OiBkY2U0OTQ0OWUwNGYgKCJ1c2I6IGNkbnMzOiBhbGxvY2F0ZSBUWCBGSUZPIHNpemUgYWNjb3Jk
aW5nIHRvDQo+IGNvbXBvc2l0ZSBFUCBudW1iZXIiKQ0KPiA+IFJlcG9ydGVkLWJ5OiBSYXZpIEd1
bmFzZWthcmFuIDxyLWd1bmFzZWthcmFuQHRpLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBGcmFu
ayBMaSA8RnJhbmsuTGlAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy91c2IvZ2FkZ2V0
L2NvbXBvc2l0ZS5jIHwgNCArKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvY29tcG9zaXRlLmMN
Cj4gYi9kcml2ZXJzL3VzYi9nYWRnZXQvY29tcG9zaXRlLmMNCj4gPiBpbmRleCAxYjM0ODkxNDll
NWUuLmRkOWI5MDQ4MWI0YyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvY29t
cG9zaXRlLmMNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvY29tcG9zaXRlLmMNCj4gPiBA
QCAtMTEyNSw2ICsxMTI1LDEwIEBAIGludCB1c2JfYWRkX2NvbmZpZyhzdHJ1Y3QgdXNiX2NvbXBv
c2l0ZV9kZXYNCj4gKmNkZXYsDQo+ID4gICAgICAgICAgICAgICBnb3RvIGRvbmU7DQo+ID4NCj4g
PiAgICAgICBzdGF0dXMgPSBiaW5kKGNvbmZpZyk7DQo+ID4gKw0KPiA+ICsgICAgIGlmIChzdGF0
dXMgPT0gMCkNCj4gPiArICAgICAgICAgICAgIHN0YXR1cyA9IHVzYl9nYWRnZXRfY2hlY2tfY29u
ZmlnKGNkZXYtPmdhZGdldCk7DQo+IA0KPiBUaGlzIHdpbGwgd29yayBmb3IgbGVnYWN5IGdhZGdl
dHMgdGhhdCBzdXBwb3J0IG9ubHkgb25lIGNvbmZpZ3VyYXRpb25zLg0KPiBUYWtlIGZvciBleGFt
cGxlIGdfZXRoZXIuIEl0IGhhcyB0d28gY29uZmlndXJhdGlvbnMgd2hlbiBSTkRJUyBpcyBlbmFi
bGVkLg0KPiBBbmQgdXNiX2FkZF9jb25maWcoKSBpcyBpbnZva2VkIGZvciBlYWNoIGNvbmZpZ3Vy
YXRpb24uDQo+IA0KPiBjZG5zM19nYWRnZXRfY2hlY2tfY29uZmlnKCkgY2FsY3VsYXRlcyB0aGUg
dG90YWwgSU4gZW5kLXBvaW50cyBiYXNlZCBvbiB0aGUNCj4gZXAtPmNsYWltZWQgZmxhZy4NCj4g
DQo+ICAgICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeShlcCwgJmdhZGdldC0+ZXBfbGlzdCwgZXBf
bGlzdCkgew0KPiAgICAgICAgICAgICAgICAgaWYgKGVwLT5jbGFpbWVkICYmIChlcC0+YWRkcmVz
cyAmIFVTQl9ESVJfSU4pKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICBuX2luKys7DQo+ICAg
ICAgICAgfQ0KPiANCj4gVGhpcyBlcC0+Y2xhaW1lZCBmbGFnIGlzIGxhdGVyIGNsZWFyZWQgYnkg
dXNiX2VwX2F1dG9jb25maWdfcmVzZXQoKSB3aGljaCBpcw0KPiBpbnZva2VkIGluIHVzYl9hZGRf
Y29uZmlnKCkuIFNvIGZvciBtdWx0aS1jb25maWd1cmF0aW9ucywgYWN0dWFsIHRvdGFsIGluIGVu
ZA0KPiBwb2ludHMNCj4gaXMgbm90IHRha2VuIGludG8gY29uc2lkZXJhdGlvbiB0aHVzIHJlc3Vs
dGluZyBpbiBpbmNvcnJlY3QgZmlmbyBzaXplDQo+IGFsbG9jYXRpb24vY2hlY2suDQo+IA0KPiBn
X2ZmcyBpcyBhbm90aGVyIGdhZGdldCB3aGljaCBoYXMgbXVsdGlwbGUgY29uZmlndXJhdGlvbnMu
DQoNCkFjdHVhbGx5IGl0IGlzIGFub3RoZXIgcHJvYmxlbSB0aGF0IEkgYW0gdHJ5aW5nIHRvIGZp
Z3VyZSBvdXQuIENvbmZpZ2ZzIHNob3VsZCBoYXZlDQogc2ltaWxhciBQcm9ibGVtLiBXZSBuZXZl
ciB0ZXN0IG11bHRpIGNvbmZpZyBjYXNlIGluIGNvbmZpZ2ZzIGFsc28uICBHZW5lcmFsbHksDQpj
b21wb3NpdGUgZGV2aWNlIG9ubHkgaGF2ZSBtdWx0aSBpbnRlcmZhY2VzLiANCg0KY2RuczNfZ2Fk
Z2V0X21hdGNoX2VwIHdyb25nIGNhY2hlIGFsbCBlbmRwb2ludHMgZm9yIGFsbCBjb25maWdzLCAg
YnV0IGFjdHVhbGx5DQpvbmx5IG9uZSBjb25maWcgY2FuIGJlIGFjdGl2ZS4NCg0KRnJhbmsgDQoN
Cj4gDQo+IA0KPiA+ICsNCj4gPiAgICAgICBpZiAoc3RhdHVzIDwgMCkgew0KPiA+ICAgICAgICAg
ICAgICAgd2hpbGUgKCFsaXN0X2VtcHR5KCZjb25maWctPmZ1bmN0aW9ucykpIHsNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgc3RydWN0IHVzYl9mdW5jdGlvbiAgICAgICAgICAgICAqZjsNCj4g
DQo+IC0tDQo+IFJlZ2FyZHMsDQo+IFJhdmkNCg==
