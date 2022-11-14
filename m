Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B316289DB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbiKNTxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiKNTxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:53:07 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2107.outbound.protection.outlook.com [40.107.114.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBDFBB3;
        Mon, 14 Nov 2022 11:53:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrXhbBvq/yEJIsx+GodVM5g0OrbAuASpqXT25ehTbw7o2qtHfAdtji0gVoJhCExf5aECSSPWVQfX35bLSCjFDzqVLvFdbDBGhLcRX4vf+z+24dqaOUIRZANc28i9khfg6JrD0uFoVn9f4f5OU+ju3lyO0tVpnkJjVk0EbnNIiVHYOZ1Lu3f6jxaGBAE56BZV+iH5+F02hrUzcHOuFRGBlweT1sA0DGN60GAiynVFKhwjfOKszmWIX9tdfvpCykW6G5l1jzalR0Tb4xcaHmhRHqlkyjp5GvHEN7jlwM9+3P802mceoBY7mChtCoOqtY8mYoi86aiWBPu/TMmAF7AMFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKZGAzg8QWbGDBrno8diMDcDMPGnytD/iV6aXoc3ARM=;
 b=cPJKVLR+jlT1hs9gld3oR1VCQKiPDYZ8D76Rpog/JT/c6b0TOgxvE9iGkJAFQU1JLYuTS/1aXM0A2VfEVzGICx/KFz7HcenypdF7t1mEsyoFB5m5UX8M0P5RGoX15JK4CtbNDnOMscGytW7JmRCliuw9vDH7EBWff+0RDwpN558uRI002Zb8eN2Q0GnmY/uR+zcvfzGDS9cTEz+J7fpfieuFE6kGeO5pISmVJ3YrVBQCYSGCk1+3uGol4NjjPD8lvYRbgHVsVHn7wqHLtQYPW5n2AERGT+nAdgHT5GDwo+1ac46cNAw8zMLLLkCHYqrt5SdGy7e1LzgJ9/XGVPhaPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKZGAzg8QWbGDBrno8diMDcDMPGnytD/iV6aXoc3ARM=;
 b=n4UZ/cMGssqoDNaVmGZvhg/+urz3HLR0UjVAPOZKQEagSZqCSfAVPAw8l9UKk91KcDWMXTe9oxq26Gqd+VgPdMLc1GZGJmrzvamLtYpkBKMQtgu5F3MIxmlZBP6sLUIeqmUC777na6kQQo1t4fY+tfhVBCM51KLaxmd2NlIR0Dk=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYYPR01MB8213.jpnprd01.prod.outlook.com (2603:1096:400:fe::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Mon, 14 Nov
 2022 19:53:02 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5813.018; Mon, 14 Nov 2022
 19:53:02 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH] watchdog: rzg2l_wdt: Issue a reset before we put the PM
 clocks
Thread-Topic: [PATCH] watchdog: rzg2l_wdt: Issue a reset before we put the PM
 clocks
Thread-Index: AQHY+FQ3i7+8G/jXAEWaK/AAUJtKua4+wHcggAASNwCAAAGycA==
Date:   Mon, 14 Nov 2022 19:53:02 +0000
Message-ID: <OS0PR01MB5922E8CB8DB680347BEB997C86059@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221114180843.1125308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB5922DDCE24ED6F6DD44B4B3F86059@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8tRKxpq4LiDDKd98MW27X7DnMEUw0FoL=8MLXK11tD-ng@mail.gmail.com>
In-Reply-To: <CA+V-a8tRKxpq4LiDDKd98MW27X7DnMEUw0FoL=8MLXK11tD-ng@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYYPR01MB8213:EE_
x-ms-office365-filtering-correlation-id: 9367188c-d2e7-4a95-0c9a-08dac679d6e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yor/7vcDyvg3TyEepUhCZmUZzr1FC7TULhixx2jTnGKqK/445IIA/8FAvYcfmlrnpLGAzDn8zR1GMDlEPPH4WdK/xR4obGR1mGImeQNlGEdAziU8IklXJyRdJ8ysmE427ztVWqSZpyz03RAJiPgiB/qtYZs1DDRZLsFQsvCjYRPqs6uYKPX3Ln4dl1T/Wghw4WYUHbo1bLxKKllipfBV/wH57FmJ3LJW3pyCTFF4dh35P72CDjWJDQlV3g3QgGg18qYTYJX3i0FK0LoFCZujk8IpTK+L+iHxqrDrG4unWIO7u0sz3KlajAcmOiaMYw6jPMzMsDgmA2XLpL694Gnyl/oKfqcKFrPXumgf7fpfJxjXNK3Q1ZppZLnYgmbFBpzawI35PNcMIQEst1Tr6+sR9NRcZ9JLoXaQTkxVYLEUp0BOzF8QoLkWxe7jvYD4TOJ9H08Qdc1yEMPAVMm1ZT7kXHYcMxCgaHrADpHhDKpdFB0NyoCE/kV0WvfMmkvq+wChWd1Et2ICi7gnNmx8a6YogPzqMEQg1zF9T3r07z/Yjvv6GmHCJia/g+o5Z3ZL80UI9zveIBaLR7WHSuoLs3brpE7IEIdLpx9WkM2+PML7rQlB3cFx3XqdOZZfQi59eqapxism6Bid3cEYD2ISiCSoYyiKb+OasX0s2IFC47PdFr/+DEGYxHIrdJzxt12Q8wu49qCjrAhUCfqLKJn36mpBrXrS7/f6+Oi2jXSoBaEqLbdA3ejwsxNkJ0A4HJjkAeNzgKHlTmqw/E0P/H00y/jXHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199015)(186003)(5660300002)(8936002)(52536014)(316002)(7696005)(6506007)(26005)(9686003)(76116006)(66946007)(66556008)(38070700005)(8676002)(64756008)(66446008)(66476007)(4326008)(53546011)(41300700001)(86362001)(38100700002)(55016003)(122000001)(2906002)(33656002)(83380400001)(107886003)(478600001)(71200400001)(54906003)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0prZlo2UTQ4QUZGanh2ZURwdTc0eVcvc09namNTRWo5WDc0L0REVmNyOFZZ?=
 =?utf-8?B?OXZBa055emY3SWZQcFdCZy96ZmRsSEI3RUlPa1owbE81Ym9VU1I0R0pKZTYw?=
 =?utf-8?B?YkpmNUpETGpuNWRxNGN1VTB5ajNXa1h1eXlJQytxTjV4c0E1RDRBRDNFMEJw?=
 =?utf-8?B?bWlxMnVKdllSaytNLytvVlpCTld6N3NLYnN2bWErcy9BSHM4Sk1WUUNwNm5j?=
 =?utf-8?B?WDlhVzVMSGxIOUUvbVRyTGJCMSsydDBPM0Q3aW9ZYS94ZUc3UnlocG1ZdFhU?=
 =?utf-8?B?OVJGSm5za1YwWDAvWEdNSXNYcm5TOVlvYnNzRXVJUkZLd0drT3h1Zmt5TXFD?=
 =?utf-8?B?WFNPcy9VRTBlS1pMT2VFRnlNbzNnbVZQd3pBd1ozYnVjc3l6dkthbHhPNVdx?=
 =?utf-8?B?MkFLR3k0WU9HRytvc25EK24vREFUMlZOWG5QTUpTQlhBbGNoRVAxWVozY0RB?=
 =?utf-8?B?U3k5bnRVVDdjL0cwdVB2dHJoc1YycGg2WUJ2NnRoa2lSdUNlZ2txbGMvZS9K?=
 =?utf-8?B?UjZvQ0t5bElyMFArMW11MElhTHlGZm5FcU90aGdFcVI5dFpDM09STEsvZ2dY?=
 =?utf-8?B?UG9meGdZSndxUFhFTFIrcERwSkVsVUszZklzMGV4R2thQTAyaS80d3VFYzVI?=
 =?utf-8?B?K1JVS0wvd2dkQWUxMTJWdzdIZW5DVlNXNnk3ZER0bmVlUVRZS0h0anNZcEVI?=
 =?utf-8?B?cjBUM0w2R1NqZEdRZjUvTm1Cbm9kSkpDUnUwMUZUWXBlK09pdkZUSmRzN3BR?=
 =?utf-8?B?RWU5VXpXM3JrTkVqRVJIUzcycnRSVU12c0E1b283N1NpUzhHd2VCVS93WjBm?=
 =?utf-8?B?UjgySXVFZllaNHJrYkcyN2hUdk5mRjkraWRUcFF5MjlsS3g5YlFUMjJETThS?=
 =?utf-8?B?Zi8yTWFIbFVjZHA3QnFMaDIzd1VXOTRkY3ZrTEY0S3NuWEgxN1VIeUFhWStI?=
 =?utf-8?B?a2hIWmhtNjRoNGpkNjVGajdUcDdqbjhSeFRvaVpIWGFrR3lSdTZGeEZBMmkz?=
 =?utf-8?B?YTArcGl5OFpKNktoNXRScjV4bk1peDR2MWo2bDZEeTRKcm9vYlNEb1VpYmhB?=
 =?utf-8?B?QkdTN29iZndncHBLKzBIcTNMUWhpclF6NjhUcHQ3R3lZOVR4RmJrM3JQRU9j?=
 =?utf-8?B?QXN0SXBlbE0zZjBIaU5KTG5pVGVwS2hSN093ditsVlJnbGFqdGd2Q2xDOHJm?=
 =?utf-8?B?UHl3MEFuUXBsb3hTM08wUjhzd0Y2bFhacEEyUnVxMi85MzVuZTFJc3pkR3FW?=
 =?utf-8?B?MmJEQXFvd3hFSkRYdWNkaEFzVUcwb3ArVVpTN1dHMVhtUkJKbS82ZkVPVjJN?=
 =?utf-8?B?dlE4ejZWblNJRDNyVkxVSWViY0J3WE9VSVFaYnE2OXZmbFJocDV4SVJJUWRv?=
 =?utf-8?B?RzlvcTQvbmJSYVFRTDkvTWV4QU1UVU5PakV6Q2xiaWVPZXVKUkdWa29oZ20z?=
 =?utf-8?B?TGxDRURJYVdjRkYzZHBNMlVjR1FlWVlSZzJMN05jbDRFakdVbmFnOC9UMjRG?=
 =?utf-8?B?cUQ2WE9zNCsyYjQ4bmxNdnY5cmZ4Qzl3SnNVRHVNcWw2L1R5dzA3Rk9NYXpZ?=
 =?utf-8?B?SVJFT2R0aXhlMDg3N1I3TzY5U25rMTV4UWpRMkIrS2J1ckZIejQ4cG1aQXlD?=
 =?utf-8?B?YUpORDJGaTBua3I3MmxOVXZtTzMvd05xNytuOWFPak90a1lOd0tpSUxGTGg3?=
 =?utf-8?B?c2gzV1pLZnV0eVhPUkVBRU9EL1N6NWlkL0ZVL2wzUElkbzlncFphVXpVNFpx?=
 =?utf-8?B?R0czMEVwQXRGc1djNlpWVG5waVVwdE9KOHZkSjY1NnFZUmJzY2wzbzVBaEZj?=
 =?utf-8?B?YTlRU1BLdU12OStGc2dGenlpc0ozTWxyOVZsT1g0ZERBRGgySGJIN005MDlm?=
 =?utf-8?B?UU9pMzVKL3VYcGNlWklZdWliYzgwUTM1OUhTcHRrTWZxVWk3RDBaRE5ZYURH?=
 =?utf-8?B?SWl2OWRNdXVVUCswWU10RzhXQWllS2ZtcEovenQwWCtlWEpDK3pxM2F2K01P?=
 =?utf-8?B?MGZWVGQxWFVNNDA1WHJSZS9YSldwUjFaVXlDYXd4YVVXREptWjZJbWVVcmZs?=
 =?utf-8?B?aXhaZTYyOU9hSzZ1Ykx0VkR6czY0Q3JmKzE1Si9nTDBkZksxUUx4dkdaRHU3?=
 =?utf-8?B?d21FdGZTOGgwU0k4dStyUDN0WDF6aUVEcU1pK2w3UHNRWThWZEZKNTNKcFNw?=
 =?utf-8?B?N2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9367188c-d2e7-4a95-0c9a-08dac679d6e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 19:53:02.4359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: foLo5WPylwkfkiPLswGpwmoUJ99PpHvBIN35Fntnm70E9sQNVWGGKi+QVSx5HeQpKtcwn191hpejSMLPwppLH6igWUPrSDcldmn6QxfCdls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8213
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGFkLCBQcmFiaGFrYXIg
PHByYWJoYWthci5jc2VuZ2dAZ21haWwuY29tPg0KPiBTZW50OiAxNCBOb3ZlbWJlciAyMDIyIDE5
OjQ2DQo+IFRvOiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IENjOiBH
ZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPjsgV2ltIFZhbiBTZWJy
b2Vjaw0KPiA8d2ltQGxpbnV4LXdhdGNoZG9nLm9yZz47IEd1ZW50ZXIgUm9lY2sgPGxpbnV4QHJv
ZWNrLXVzLm5ldD47IFBoaWxpcHANCj4gWmFiZWwgPHAuemFiZWxAcGVuZ3V0cm9uaXguZGU+OyBs
aW51eC13YXRjaGRvZ0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1yZW5lc2FzLXNvY0B2Z2VyLmtlcm5lbC5vcmc7IEZhYnJpemlvDQo+IENh
c3RybyA8ZmFicml6aW8uY2FzdHJvLmp6QHJlbmVzYXMuY29tPjsgUHJhYmhha2FyIE1haGFkZXYg
TGFkDQo+IDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIHdhdGNoZG9nOiByemcybF93ZHQ6IElzc3VlIGEgcmVzZXQgYmVmb3Jl
IHdlIHB1dA0KPiB0aGUgUE0gY2xvY2tzDQo+IA0KPiBISSBCaWp1LA0KPiANCj4gVGhhbmsgeW91
IGZvciB0aGUgcmV2aWV3Lg0KPiANCj4gT24gTW9uLCBOb3YgMTQsIDIwMjIgYXQgNjo0MiBQTSBC
aWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4N
Cj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFByYWJo
YWthciA8cHJhYmhha2FyLmNzZW5nZ0BnbWFpbC5jb20+DQo+ID4gPiBTZW50OiAxNCBOb3ZlbWJl
ciAyMDIyIDE4OjA5DQo+ID4gPiBUbzogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2Fz
QGdsaWRlci5iZT47IFdpbSBWYW4gU2Vicm9lY2sNCj4gPiA+IDx3aW1AbGludXgtd2F0Y2hkb2cu
b3JnPjsgR3VlbnRlciBSb2VjayA8bGludXhAcm9lY2stdXMubmV0PjsNCj4gPiA+IFBoaWxpcHAg
WmFiZWwgPHAuemFiZWxAcGVuZ3V0cm9uaXguZGU+Ow0KPiA+ID4gbGludXgtd2F0Y2hkb2dAdmdl
ci5rZXJuZWwub3JnDQo+ID4gPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtcmVuZXNhcy0NCj4gc29jQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+IFByYWJoYWthciA8cHJh
Ymhha2FyLmNzZW5nZ0BnbWFpbC5jb20+OyBCaWp1IERhcw0KPiA+ID4gPGJpanUuZGFzLmp6QGJw
LnJlbmVzYXMuY29tPjsgRmFicml6aW8gQ2FzdHJvDQo+ID4gPiA8ZmFicml6aW8uY2FzdHJvLmp6
QHJlbmVzYXMuY29tPjsgUHJhYmhha2FyIE1haGFkZXYgTGFkDQo+ID4gPiA8cHJhYmhha2FyLm1h
aGFkZXYtIGxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFtQQVRDSF0gd2F0
Y2hkb2c6IHJ6ZzJsX3dkdDogSXNzdWUgYSByZXNldCBiZWZvcmUgd2UgcHV0DQo+ID4gPiB0aGUg
UE0gY2xvY2tzDQo+ID4gPg0KPiA+ID4gRnJvbTogTGFkIFByYWJoYWthciA8cHJhYmhha2FyLm1h
aGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPiA+ID4NCj4gPiA+IE9uIFJaL0ZpdmUgU29D
IGl0IHdhcyBvYnNlcnZlZCB0aGF0IHNldHRpbmcgdGltZW91dCAodG8gc2F5IDEgc2VjKQ0KPiA+
ID4gd291bGRuJ3QgcmVzZXQgdGhlIHN5c3RlbS4gVG8gZml4IHRoaXMgd2UgbWFrZSBzdXJlIHdl
IGlzc3VlIGENCj4gcmVzZXQNCj4gPiA+IGJlZm9yZSBwdXR0aW5nIHRoZSBQTSBjbG9ja3MgdG8g
bWFrZSBzdXJlIHRoZSByZWdpc3RlcnMgaGF2ZSBiZWVuDQo+IGNsZWFyZWQuDQo+ID4gPg0KPiA+
ID4gV2hpbGUgYXQgaXQgcmUtdXNlZCByemcybF93ZHRfc3RvcCgpIGluIHJ6ZzJsX3dkdF9zZXRf
dGltZW91dCgpIGFzDQo+ID4gPiB3ZSB3ZXJlIGNhbGxpbmcgdGhlIHNhbWUgZnVuY3Rpb25zIGhl
cmUuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogTGFkIFByYWJoYWthcg0KPiA+ID4gPHBy
YWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4g
Tm90ZSwNCj4gPiA+IC0gVGhpcyBwYXRjaCBoYXMgYmVlbiB0ZXN0ZWQgb24gUlovRzJMLCBSWi9W
Mk0gYW5kIFJaL0ZpdmUuDQo+ID4gPiAtIE15IGluaXRpYWwgaW52ZXN0aWdhdGlvbiBzaG93ZWQg
YWRkaW5nIHRoZSBkZWxheSBhZnRlcg0KPiA+ID4gcG1fcnVudGltZV9nZXRfc3luYygpDQo+ID4g
PiAgIGFsc28gZml4ZWQgdGhpcyBpc3N1ZS4NCj4gPiA+IC0gRG8gSSBuZWVkIGFkZCB0aGUgZml4
ZXMgdGFnID8gd2hhdCBzaG91bGQgYmUgdGhlIG9wZXJhdGlvbiBQVVQtDQo+ID4gPiA+UkVTRVQv
UkVTRVQtPlBVVD8NCj4gPg0KPiA+IEl0IGxvb2tzIGxpa2UgdGltaW5nIGlzc3VlLCBOb25lIG9m
IHRoZSBwcmV2aW91cyBkZXZpY2VzIGFyZQ0KPiBhZmZlY3RlZCBieSB0aGlzLg0KPiA+DQo+IHll
cC4NCj4gDQo+ID4gPiAgIGluIGNhc2Ugd2UgbmVlZCB0aGUgdGFnIGlzOg0KPiA+ID4gICBGaXhl
czogNDA1NWVlODEwMDllNiAoIndhdGNoZG9nOiByemcybF93ZHQ6IEFkZCBzZXRfdGltZW91dA0K
PiA+ID4gY2FsbGJhY2siKQ0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy93YXRjaGRvZy9yemcy
bF93ZHQuYyB8IDcgKystLS0tLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDUgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvd2F0
Y2hkb2cvcnpnMmxfd2R0LmMNCj4gPiA+IGIvZHJpdmVycy93YXRjaGRvZy9yemcybF93ZHQuYyBp
bmRleCAwMDQzOGNlZWQxN2EuLmQxMjcxY2M3NzUwZg0KPiA+ID4gMTAwNjQ0DQo+ID4gPiAtLS0g
YS9kcml2ZXJzL3dhdGNoZG9nL3J6ZzJsX3dkdC5jDQo+ID4gPiArKysgYi9kcml2ZXJzL3dhdGNo
ZG9nL3J6ZzJsX3dkdC5jDQo+ID4gPiBAQCAtMTE1LDE2ICsxMTUsMTQgQEAgc3RhdGljIGludCBy
emcybF93ZHRfc3RvcChzdHJ1Y3QNCj4gPiA+IHdhdGNoZG9nX2RldmljZSAqd2Rldikgew0KPiA+
ID4gICAgICAgc3RydWN0IHJ6ZzJsX3dkdF9wcml2ICpwcml2ID0gd2F0Y2hkb2dfZ2V0X2RydmRh
dGEod2Rldik7DQo+ID4gPg0KPiA+ID4gLSAgICAgcG1fcnVudGltZV9wdXQod2Rldi0+cGFyZW50
KTsNCj4gPiA+ICAgICAgIHJlc2V0X2NvbnRyb2xfcmVzZXQocHJpdi0+cnN0Yyk7DQo+ID4gPiAr
ICAgICBwbV9ydW50aW1lX3B1dCh3ZGV2LT5wYXJlbnQpOw0KPiA+ID4NCj4gPiA+ICAgICAgIHJl
dHVybiAwOw0KPiA+ID4gIH0NCj4gPiA+DQo+ID4gPiAgc3RhdGljIGludCByemcybF93ZHRfc2V0
X3RpbWVvdXQoc3RydWN0IHdhdGNoZG9nX2RldmljZSAqd2RldiwNCj4gPiA+IHVuc2lnbmVkIGlu
dA0KPiA+ID4gdGltZW91dCkgIHsNCj4gPiA+IC0gICAgIHN0cnVjdCByemcybF93ZHRfcHJpdiAq
cHJpdiA9IHdhdGNoZG9nX2dldF9kcnZkYXRhKHdkZXYpOw0KPiA+ID4gLQ0KPiA+ID4gICAgICAg
d2Rldi0+dGltZW91dCA9IHRpbWVvdXQ7DQo+ID4gPg0KPiA+ID4gICAgICAgLyoNCj4gPiA+IEBA
IC0xMzIsOCArMTMwLDcgQEAgc3RhdGljIGludCByemcybF93ZHRfc2V0X3RpbWVvdXQoc3RydWN0
DQo+ID4gPiB3YXRjaGRvZ19kZXZpY2UgKndkZXYsIHVuc2lnbmVkIGludCB0aW1lDQo+ID4gPiAg
ICAgICAgKiByZWdpc3RlciBzbyB0aGF0IGl0IGlzIHVwZGF0ZWQgd2l0aCBuZXcgdGltZW91dCB2
YWx1ZXMuDQo+ID4gPiAgICAgICAgKi8NCj4gPg0KPiA+DQo+ID4gTWF5YmUgdXBkYXRlIHRoZSBj
b21tZW50IGFib3ZlIHdpdGggbmV3IGNvZGUgY2hhbmdlLg0KPiA+DQo+ICAgICAvKg0KPiAgICAg
ICogSWYgdGhlIHdhdGNoZG9nIGlzIGFjdGl2ZSwgcmVzZXQgdGhlIG1vZHVsZSBmb3IgdXBkYXRp
bmcgdGhlDQo+IFdEVFNFVA0KPiAgICAgICogcmVnaXN0ZXIgc28gdGhhdCBpdCBpcyB1cGRhdGVk
IHdpdGggbmV3IHRpbWVvdXQgdmFsdWVzLg0KPiAgICAgICovDQo+IA0KPiBUaGUgYWJvdmUgZXhp
c3RpbmcgY29tbWVudCBob2xkcyBnb29kIHdpdGggdGhpcyBjb2RlIGNoYW5nZS4gSWYgeW91DQo+
IHByZWZlciBzb21ldGhpbmcgZWxzZSBwbGVhc2UgbGV0IG1lIGtub3cgSSdsbCB1cGRhdGUgaXQg
YWNjb3JkaW5nbHkuDQoNCk1heWJlIG1lbnRpb24sIFRoZSByZXNldHRpbmcgb2YgdGhlIG1vZHVs
ZSBpcyBkb25lIGluIHdkdF9zdG9wIGZ1bmN0aW9uLg0KDQpDaGVlcnMsDQpCaWp1DQo=
