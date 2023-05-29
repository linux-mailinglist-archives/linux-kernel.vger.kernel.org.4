Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE9A714794
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 12:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjE2J77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 05:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjE2J72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 05:59:28 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2098.outbound.protection.outlook.com [40.107.113.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3587EB5;
        Mon, 29 May 2023 02:59:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncICftG4icS99t7/sXMeZtAk5DlXvUmNUq+b+P+gtJCh1tqAZKLEy9OAycIZpu0cJMwZ5a4TcbE+kc0XTRSo3tWsRJN35tOdEqnnfYwV2QCjdIdnLezYOvop0B+Q9HJCcNbx5JSZfVqm30skjzmXPsjcagIyvorJiyBVyFCANMhczazBA9SZoc7q1nx5+lOveHzGPYCtCN80vLLANOTPC2J6BZCt5gZrg3S9lOS6SCgO9LKU+qZIGyehk1xIe03I0yfjT/I3fJ6Yg8EFptH+HSS+q/4uLj/keUgZDFlQES5HuiZ55FCk0VNPyrHw30QazzRKecQByYeSJAAvCFFeRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4jWpfeG7cBQYZ87vQaLOI6X+zzDEEQSMpywuRarIFo=;
 b=e4FxXSsdAPxwE2wZnsDTaVG0y9yl2xrWvpN8GJnHvWhFZY5eoKvEHR5DFfzwQ2a1YW+79zeqMb6VFLsyxOFpVuvPCH4xln30o1V93yqbHw+7FTCAV7BDi6TnCRMWMVtj3DH1GL9/iszPsHVqpUWRKVqrgkWJMNI2uaq/mtAowX1t8eFj+dR4Dz+N+Eczpp/0i++y+HKbFmtBrphpxbOzduoV76mvDR0zz/sFOIwM3agjhV+3FJsOksyYs5Oc8+nXNac5wmT9dGRvEili3fy5LA183X/lgeeH9J4l6rzpftZOsnn709h1VYSoas4EuWylhP7mVFE/kVLuKK9oYUkp4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4jWpfeG7cBQYZ87vQaLOI6X+zzDEEQSMpywuRarIFo=;
 b=GOkqn+iygwjOL5OgcP/DyZBe++XejkKOxC3FaYvF7dSay8lvwAqTZwPOOazePjsP55xpNlh2snsnAOqdsXSuaKDv5l0z6FaZIs2SaNNVRhnv6En2eWNKFudijShUo/3pE6HpIDcCyC2I3VO1XPIGr95fkikwlA3y7d+ggYXxq1s=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB7697.jpnprd01.prod.outlook.com (2603:1096:604:1b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 09:59:23 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6433.020; Mon, 29 May 2023
 09:59:23 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zheng Wang <zyytlz.wz@163.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] usb: gadget: udc: renesas_usb3: Fix RZ/V2M
 {modprobe,bind} error
Thread-Topic: [PATCH] usb: gadget: udc: renesas_usb3: Fix RZ/V2M
 {modprobe,bind} error
Thread-Index: AQHZj99wvrGBFYOn5Ea9mIuOTwGccK9wyqwAgAAi9sCAAA05gIAAAIqAgAAJpICAAACv8A==
Date:   Mon, 29 May 2023 09:59:23 +0000
Message-ID: <OS0PR01MB5922B52C4B2E5A55B6E4B6DD864A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230526143615.372338-1-biju.das.jz@bp.renesas.com>
 <20230529061714.GA25984@pendragon.ideasonboard.com>
 <OS0PR01MB592296756992262EC6D382D0864A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <86bki3cxm2.wl-maz@kernel.org>
 <OS0PR01MB59227E69FF1DE67327BDEF77864A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20230529094607.GN25984@pendragon.ideasonboard.com>
In-Reply-To: <20230529094607.GN25984@pendragon.ideasonboard.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB7697:EE_
x-ms-office365-filtering-correlation-id: befabfb0-8211-4be5-972c-08db602b6139
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zg9CMBram4LTIuCU1Ac86zU44SL1jxPs6vKfF4eTCYW+AvR/WW2r72p3aWyaww+OjU8fBF1U77zOD9544Oc/fxyf0GNLRvjcM6Vi9W9Wysu33myjJJ3Mj6ALNv84x02Xd8BLlbMiRltLB6sjY7Dz42aT+Qs8orNgWhBWJOjLfz0FFKYTTPCB/m6XwFrw233ryxPxBH46FvXWZP1VHnNscny5JGiast3uQNm7wTR/4VMhLr+DwRWncI9bLSCbY5B/REjNdM8SbwyxmW9xc/7ONVWrBjTjh+adAbiJp+eJYV0I6EnPs6B1NFNOdcI4ipwO5RPcX26YJgxouwc66AnQ4VWrEzjAdSVwf29sWeW4fUCkmhQJ/4v9mqj/MIr43/ykjnpJGD84rCQWP7EIn6ZEnRu6EcpnMGGcRQwZlksd/ZDqvdE1+TSnpKkjkai26SuPEyOzmwMe4YRc5q13thbvp10wZA4+YRMQgHd6a3Ups8DUgNwnXw0+2PRfKVL6KSZ97TbIFti/PIYD2ksEd3i7aIvMuAcB7zIvSrZLY2gjQL9png2s5UdHW2auVAPMG76dOn4Plc+QmAzas0NVRjScJQFQqjG3gMw7eeMrr9V5hwC60B2+SV2pZY7BZvOWCog8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199021)(83380400001)(71200400001)(33656002)(5660300002)(316002)(66946007)(66556008)(76116006)(64756008)(66446008)(66476007)(7416002)(52536014)(4326008)(6916009)(122000001)(38100700002)(41300700001)(8676002)(8936002)(7696005)(86362001)(55016003)(54906003)(2906002)(6506007)(38070700005)(9686003)(186003)(478600001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnNrbDhsak0rSmZyT3lpcEJxODNRenZQa2RxRFhZK1VzdVhQUllReW93Rk5J?=
 =?utf-8?B?QU1Oa3ZEeUJtWmVUaTczSHhEZytMbWovdnhOSGx2NGx5STFobkNaOUxYeEtn?=
 =?utf-8?B?V0Rka1ZyQTE1TGxBK0RWZjJ0Kys5Z3MvbVJZSWl3aU94d2xIWjVUSXo3d2Zw?=
 =?utf-8?B?aHc1WHl3VmhNZGZieUw5aE1HcytCWWkrR2dkeVdzZFNLaXd1c2g3dTdOMFdE?=
 =?utf-8?B?TkJVUUVkSE43R1ovWXpNMzUwRU9kTERvUVJHMWU1ZXZTUVU2V1JQOUNyNXd0?=
 =?utf-8?B?L0xacTd6VElVV083RGVaYk92eHZ3TFdOV3k2OVlWdkRoVmE5RkJ6eHhEbitr?=
 =?utf-8?B?RlpRME9hbmU0K2Y4NUdDRTZhWCt6dGhDenB0UkR5bzIycUtMZHZ6RFRBNG1p?=
 =?utf-8?B?ZDBwdTl2cE5QdGR0a0ZyeWRxZ2o2QmJtcVE5cUdnUHZBUkxNYWxtUTM5Y2Rp?=
 =?utf-8?B?bWRPeDAxTmtNWHhadTlIZnVFemllQ2l3VTJmczRLblRQQ0pNbUU1dW5rZDJm?=
 =?utf-8?B?OXdaOFRaRW0vMW9jaFZPSytmNVYweWN5WG42bDNHUXIzUFdFZUNMVXlTa1Mw?=
 =?utf-8?B?bThXUXcvNUE5Z2VZTnZ0Vlk3citQazNaV04vTW1jQXk0OVBJanRuR1hLMHNv?=
 =?utf-8?B?bkJ1ZDF1M2tTZjh4bU5IUHVZOXhFRFg2VmVRMnJJM09rOW5XcXdybTF3eG14?=
 =?utf-8?B?SlFDblNZZHI1SWNWeXA2N0hCUHJ1KzdXVTRYYnZGVlBuS2FKeEhqeXk2bTJi?=
 =?utf-8?B?Zit4UEVHZ1lSdXNvYWdQeGlxYkdQbEY1UE9TckdiVlExOU1ldmU1bnFTanJY?=
 =?utf-8?B?S2s0YWc2M1laWWpmK0NIcGVZL09JS0p1NGpoYjdtcnB5dHpmNUkxK3l0Ty9F?=
 =?utf-8?B?aVVSSnpOVitzc2thSlVYNHRzbnVnK2IrN2FacWhlK2xRaGsrMmQ5Q2gvTnlG?=
 =?utf-8?B?Mk5va2xWTTkzaHRRTkFYcEZCYWU3U1R2elJlQlNaVGlaR1NBMHdCcXQ0SzE0?=
 =?utf-8?B?VTM4UlRMUVJBaG5Fbzc0a29Xc0dwbCtVU1VJMU5xZzlYdy9neHdPRG1rbW5V?=
 =?utf-8?B?YitsMU1HN3RabFoxMmN3aWZYUk1BUzRuSVJBVzU2TlhMSnRHWC9XTzVvK1Fv?=
 =?utf-8?B?b0VBTktaWnpnbHluQklBVGFoL3dGaFZybm54UUk3N1I4aUxWeXNpM2xQeW8r?=
 =?utf-8?B?MUM2VU5XbGJaVFBQR0FOb1FhK2VIakVxLzZPd3o2WldkbkxYemtGZUNybmda?=
 =?utf-8?B?VzBmSTFZMy9IVnZNVVBLYVJPTHladFBlMk5kUlFTaVJZU3owUkN6bmpuZzM2?=
 =?utf-8?B?ZEZJN0wrRGtHRWlBQ2YzRm9RZUwyeXJxL3ZSQXhIcm5FNWRHSENsTmNHck8y?=
 =?utf-8?B?bUtoMjhPejdqdUl2Yzdia3BuM1pPTzEwQ2hNV0xYSDdlcStmMzdkdTZEOEcz?=
 =?utf-8?B?VGY5UTFUaFZjcmh1ZU5rQUY3cUY1Ujh4a0tHTW5uSEJPYzF5K0JjVlFXanFn?=
 =?utf-8?B?UThOcjJIUTljeUVUYitkamtPMkRuQmQ0aTNISGRudCtxWlVCMCsvdGp4NDJt?=
 =?utf-8?B?UXNTam5vbFdLOU1sZ3o0MlZmcERETFlxa0dUVkVEL1dYcUhrMEFhb0NsamI2?=
 =?utf-8?B?VWdJMElzY0ZVeHVqSWpJdGNWbUhIT3N1UUR5aVpjNmJRcDZCWWwzWEtabGZ4?=
 =?utf-8?B?VXdveVZNNmEzakxKa05iVFNzM0NuWlNocEZnbmlDSmFpOTlRMjNjUlpmdyts?=
 =?utf-8?B?NTlQNzJmYnZTZUljMG1qSWI4WEZseSttVEJKRnRFMnJiaHBMMVhRN2FQN0hC?=
 =?utf-8?B?ODdQRWVDM1k0Ti96YU1rcjN5WGwzYS9keUZJUTgvcEFHSHFuaVEwSnlGMVNt?=
 =?utf-8?B?QStZMFJLVyszNmphV2RkTy9RTFNUNUUyKzd0UzdaSDYraEZUbnUrRFZucUpQ?=
 =?utf-8?B?M2toNnpJR2Jacnpzd2p6T0pRREg4VGRhRjBNcXJjSzAzTzRqRWJsS01XNFl5?=
 =?utf-8?B?eWM3amFQaWEyYlIySkV2R0JxYy9jbUt4RUZHTFNHaHd2QjRQaVI3aWNlK0NS?=
 =?utf-8?B?N1M2cjh6OVIyNENMdlhtYjFPUFJpajdrTHdjY3NOUDhodGJBVlArWnU3Sjdp?=
 =?utf-8?Q?rkojnWkKQosAYgnNWYrtDhpt2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: befabfb0-8211-4be5-972c-08db602b6139
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2023 09:59:23.3722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qJqmGSL6+u8BiKlkU0cFtxh+sz8vH82sMi3a8be2dYyyL5oE6TEdgGA1Fy8XIRsBG3UXG06Aq3/xIg9I671SXlO8tkX4T4wOSnGHdxhNIbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7697
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGF1cmVudCwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4gU3ViamVjdDogUmU6
IFtQQVRDSF0gdXNiOiBnYWRnZXQ6IHVkYzogcmVuZXNhc191c2IzOiBGaXggUlovVjJNDQo+IHtt
b2Rwcm9iZSxiaW5kfSBlcnJvcg0KPiANCj4gT24gTW9uLCBNYXkgMjksIDIwMjMgYXQgMDk6Mzk6
NTBBTSArMDAwMCwgQmlqdSBEYXMgd3JvdGU6DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSB1
c2I6IGdhZGdldDogdWRjOiByZW5lc2FzX3VzYjM6IEZpeCBSWi9WMk0NCj4gPiA+IHttb2Rwcm9i
ZSxiaW5kfSBlcnJvcg0KPiA+ID4NCj4gPiA+IE9uIE1vbiwgMjkgTWF5IDIwMjMgMDk6NDI6MzQg
KzAxMDAsIEJpanUgRGFzIHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiA+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIHVzYjogZ2FkZ2V0OiB1ZGM6IHJlbmVzYXNfdXNiMzogRml4IFJaL1YyTQ0KPiA+ID4g
PiA+IHttb2Rwcm9iZSxiaW5kfSBlcnJvcg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT24gRnJpLCBN
YXkgMjYsIDIwMjMgYXQgMDM6MzY6MTVQTSArMDEwMCwgQmlqdSBEYXMgd3JvdGU6DQo+ID4gPiA+
ID4gPiBDdXJyZW50bHkge21vZHByb2JlLCBiaW5kfSBhZnRlciB7cm1tb2QsIHVuYmluZH0gcmVz
dWx0cyBpbg0KPiBwcm9iZSBmYWlsdXJlLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IGdlbmly
cTogRmxhZ3MgbWlzbWF0Y2ggaXJxIDIyLiAwMDAwMDAwNCAoODUwNzA0MDAudXNiM2RyZCkgdnMu
DQo+ID4gPiA+ID4gPiAwMDAwMDAwNCAoODUwNzA0MDAudXNiM2RyZCkNCj4gPiA+ID4gPiA+IHJl
bmVzYXNfdXNiMzogcHJvYmUgb2YgODUwNzAwMDAudXNiM3BlcmkgZmFpbGVkIHdpdGggZXJyb3Ig
LTE2DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gRml4IHRoaXMgaXNzdWUgYnkgcmVwbGFjaW5n
ICJwYXJlbnQgZGV2Ii0+ImRldiIgYXMgdGhlIGlycQ0KPiA+ID4gPiA+ID4gcmVzb3VyY2UgaXMg
bWFuYWdlZCBieSB0aGlzIGRyaXZlci4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IElmIHRoZSBkZXYg
cG9pbnRlciBwYXNzZWQgdG8gZGV2bV9yZXF1ZXN0X2lycSgpIGlzIG5vdCB0aGUNCj4gPiA+ID4g
PiBjb3JyZWN0IG9uZSwgaG93IGRvZXMgaXQgd29yayB0aGUgZmlyc3QgdGltZSB0aGUgZHJpdmVy
IGlzDQo+IGxvYWRlZCA/DQo+ID4gPiA+DQo+ID4gPiA+ICsgTWFyYy8gS2VybmVsLm9yZyB0byBn
aXZlIHNvbWUgZmVlZGJhY2sgb24gdGhpcyBpc3N1ZQ0KPiA+ID4gPg0KPiA+ID4gPiBJIGJlbGll
dmUgdGhlcmUgbWF5IGJlIGEgYnVnIGluIHRoZSBnZW5pcnEgKGtlcm5lbC9pcnEpIGRyaXZlci4N
Cj4gPiA+ID4gZmlyc3QgdGltZSBpdCB3b3JrcyBvay4gTWF5YmUgdGhpcyBkcml2ZXIgaXMgY2Fj
aGluZyBvbiB1bmxvYWQNCj4gPiA+ID4gd2l0aCBudWxsIHZhbHVlIGFuZCBjb21wYXJpbmcgd2l0
aCBhY3R1YWwgb25lIChpcnEgMjIpIGR1cmluZw0KPiByZWxvYWQ/Pw0KPiA+ID4gPg0KPiA+ID4g
PiBNYXliZSBnZW5pcnEgZXhwZXJ0IGNhbiBjb21tZW50IHdoYXQgd2VudCB3cm9uZyBoZXJlPz8N
Cj4gPiA+DQo+ID4gPiBZb3UgZ2V0IHNob3V0ZWQgYXQgYmVjYXVzZSB5b3UgYXJlIHJlZ2lzdGVy
aW5nIGFuIGludGVycnVwdCBoYW5kbGVyDQo+ID4gPiBmb3IgdGhlIHNhbWUgSVJRIHR3aWNlLA0K
PiA+DQo+ID4gVGhpcyBub3QgdHJ1ZS4gSXQgaXMgcmVnaXN0ZXJpbmcgb25seSBvbmUgSVJRLCBi
dXQgd2l0aCBwYXJlbnQgZGV2aWNlDQo+IGhhbmRsZS4NCj4gDQo+IEl0IHVzZXMgZGV2bV9yZXF1
ZXN0X2lycSgpIHdpdGggdGhlIHBhcmVudCBkZXZpY2UsIHNvIHRoZSBpbnRlcnJ1cHQNCj4gaGFu
ZGxlciB3b24ndCBiZSB1bnJlZ2lzdGVyZWQgd2hlbiB0aGUgdXNiMy1wZXJpIGRldmljZSBpcyB1
bmJvdW5kLiBUaGUNCj4gbmV4dCBwcm9iZSB3aWxsIHJlZ2lzdGVyIHRoZSBzYW1lIGludGVycnVw
dCBoYW5kbGVyIGEgc2Vjb25kIHRpbWUuIFRoaXMNCj4gaGFzIG5vdGhpbmcgdG8gZG8gd2l0aCBn
ZW5pcnEsIGl0J3MgcmVsYXRlZCB0byBkZXZtXyouDQoNCkkgYWdyZWUuDQoNCj4gDQo+ID4gPiBh
bmQgdGhlIGludGVycnVwdCBpcyBub3QgY29uZmlndXJlZCB3aXRoIHRoZSBTSEFSRUQgZmxhZy4N
Cj4gPg0KPiA+IEkgaGF2ZW4ndCBhZGRlZCBTSEFSRUQgZmxhZyBhcyB0aGVyZSBpcyBvbmx5IG9u
ZSBJUlEgcmVnaXN0cmF0aW9uLg0KPiA+DQo+ID4gIElmLCBhcyBJIHVuZGVyc3RhbmQgaXQsIHlv
dSBvbmx5IGhhdmUgYSBzaW5nbGUgZGV2aWNlIHVzaW5nIHRoaXMNCj4gPiA+IGludGVycnVwdCwg
dGhlbiBpdCBtZWFucyB5b3VyIGRyaXZlciBpcyBub3QgZnJlZWluZyBpdHMgaW50ZXJydXB0IG9u
DQo+ID4gPiB1bmxvYWQuDQo+ID4NCj4gPiBZb3UgbWVhbiBkZXZtX3JlcXVlc3RfaXJxKGRkYXRh
LT5kZXYuLikgIGRvZXNuJ3QgZnJlZSB0aGUgcmVzb3VyY2UgYXMNCj4gPiB3ZSBoYXZlIHVubG9h
ZGVkIG9ubHkgY2hpbGQgZGV2aWNlIHJhdGhlciB0aGFuIHBhcmVudC4NCj4gPg0KPiA+IEJ1dCB3
aGlsZSBwYXJlbnQgaXMgYWN0aXZlLCB3aHkgZ2VuaXJxIGlzIGdpdmluZyBlcnJvciBkdXJpbmcg
cmVsb2FkPw0KPiA+IEl0IHNob3VsZCBzaG93IHNhbWUgYmVoYXZpb3VyIGxpa2UgaW5pdGlhbCBw
cm9iZS4NCj4gPg0KPiA+ID4gQW5kIHRoYXQncyBwcm9iYWJseSBiZWNhdXNlIHRoZSBkZXZpY2Ug
b2JqZWN0IHVzZWQgd2hlbiByZXF1ZXN0aW5nDQo+ID4gPiB0aGUgaW50ZXJydXB0IGlzbid0IHRo
ZSBvbmUgeW91IGxvYWQvdW5sb2FkLCBhcyBpbmRpY2F0ZWQgYnkgdGhlDQo+IG1lc3NhZ2UuDQo+
ID4gPiBPbiB0aGUgZmlyc3QgbG9hZCBvZiAidXNiM3BlcmkiLCB5b3UgcmVnaXN0ZXIgYW4gaW50
ZXJydXB0IHdpdGgNCj4gPiA+ICJ1c2IzZHJkIiBhcyB0aGUgcmVxdWVzdGVyIGRldmljZS4gWW91
IHRoZW4gdW5sb2FkICJ1c2IzcGVyaSIsIHdoaWNoDQo+ID4gPiBvZiBjb3Vyc2UgaGFzIG5vIGVm
ZmVjdCB3aGF0c29ldmVyIG9uIHRoZSBpbnRlcnJ1cHQuDQo+ID4gPg0KPiA+ID4gWW91IGNvdWxk
IHNpbXBseSBoYXZlIGRvbmUgYSAiY2F0IC9wcm9jL2ludGVycnVwdCIgYW5kIHNlZSB0aGF0DQo+
ID4gPiBpbnRlcnJ1cHQgd2FzIHN0aWxsIHRoZXJlIGFmdGVyIHVubG9hZC4NCj4gPg0KPiA+IFll
cywgaW50ZXJydXB0IHN0aWxsIHRoZXJlIGFmdGVyIHVubG9hZC4NCj4gPg0KPiA+IFdpdGggZGV2
bV9yZXF1ZXN0X2lycShkZGF0YS0+ZGV2Li4pLCBhZnRlciB1bmxvYWQNCj4gPiA9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID4NCj4gPiByb290QHJ6
djJtOn4jIGNhdCAvcHJvYy9pbnRlcnJ1cHRzIHwgZ3JlcCB1c2INCj4gPiAgMjI6ICAgICAgICAg
IDAgICAgIEdJQ3YyIDI3NCBMZXZlbCAgICAgODUwNzA0MDAudXNiM2RyZA0KPiA+ICAyODogICAg
ICAgICAgMCAgICAgR0lDdjIgMjc4IExldmVsICAgICA4NTA3MDAwMC51c2IzcGVyaQ0KPiA+IHJv
b3RAcnp2Mm06fiMgbHNtb2QNCj4gPiBNb2R1bGUgICAgICAgICAgICAgICAgICBTaXplICBVc2Vk
IGJ5DQo+ID4gaGQzc3MzMjIwICAgICAgICAgICAgICAxMjI4OCAgMA0KPiA+IHR5cGVjICAgICAg
ICAgICAgICAgICAgNzM3MjggIDEgaGQzc3MzMjIwDQo+ID4gcmVuZXNhc191c2IzICAgICAgICAg
ICAzMjc2OCAgMQ0KPiA+IGkyY19yenYybSAgICAgICAgICAgICAgMTIyODggIDANCj4gPiBjcmN0
MTBkaWZfY2UgICAgICAgICAgIDEyMjg4ICAxDQo+ID4gaXB2NiAgICAgICAgICAgICAgICAgIDQ1
MDU2MCAgMTYNCj4gPiByb290QHJ6djJtOn4jIHJtbW9kIGhkM3NzMzIyMA0KPiA+IHJvb3RAcnp2
Mm06fiMgcm1tb2QgcmVuZXNhc191c2IzDQo+ID4gcm9vdEByenYybTp+IyBjYXQgL3Byb2MvaW50
ZXJydXB0cyB8IGdyZXAgdXNiDQo+ID4gIDIyOiAgICAgICAgICAwICAgICBHSUN2MiAyNzQgTGV2
ZWwgICAgIDg1MDcwNDAwLnVzYjNkcmQNCj4gPiByb290QHJ6djJtOn4jDQo+ID4NCj4gPiBXaXRo
IGRldm1fcmVxdWVzdF9pcnEoJnBkZXYtPmRldi4uKSwgYWZ0ZXIgdW5sb2FkDQo+ID4gPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID4NCj4gPiByb290
QHJ6djJtOn4jIGNhdCAvcHJvYy9pbnRlcnJ1cHRzIHwgZ3JlcCB1c2INCj4gPiAgMjI6ICAgICAg
ICAgIDAgICAgIEdJQ3YyIDI3NCBMZXZlbCAgICAgODUwNzA0MDAudXNiM2RyZA0KPiA+ICAyODog
ICAgICAgICAgMCAgICAgR0lDdjIgMjc4IExldmVsICAgICA4NTA3MDAwMC51c2IzcGVyaQ0KPiA+
IHJvb3RAcnp2Mm06fiMgbHNtb2QNCj4gPiBNb2R1bGUgICAgICAgICAgICAgICAgICBTaXplICBV
c2VkIGJ5DQo+ID4gaGQzc3MzMjIwICAgICAgICAgICAgICAxMjI4OCAgMA0KPiA+IHR5cGVjICAg
ICAgICAgICAgICAgICAgNzM3MjggIDEgaGQzc3MzMjIwDQo+ID4gcmVuZXNhc191c2IzICAgICAg
ICAgICAzMjc2OCAgMQ0KPiA+IGNyY3QxMGRpZl9jZSAgICAgICAgICAgMTIyODggIDENCj4gPiBp
MmNfcnp2Mm0gICAgICAgICAgICAgIDEyMjg4ICAwDQo+ID4gaXB2NiAgICAgICAgICAgICAgICAg
IDQ1MDU2MCAgMTYNCj4gPiByb290QHJ6djJtOn4jIHJtbW9kIGhkM3NzMzIyMA0KPiA+IHJvb3RA
cnp2Mm06fiMgcm1tb2QgcmVuZXNhc191c2IzDQo+ID4gcm9vdEByenYybTp+IyBjYXQgL3Byb2Mv
aW50ZXJydXB0cyB8IGdyZXAgdXNiIHJvb3RAcnp2Mm06fiMNCj4gPg0KPiA+ID4gU28gdGhlIG9u
bHkgYnVnIGhlcmUgaXMgaW4gdGhlIGhhbmRsaW5nIG9mIHRoZSBpbnRlcnJ1cHQgcmVxdWVzdC4N
Cj4gPiA+IEFuZCB0aGF0IGJ1ZyBmaXJtbHkgbGllcyBpbiB5b3VyIGNvZGUuIE15ICJleHBlcnQi
IGFkdmlzZSBpcyB0bw0KPiA+ID4gZGVidWcgdGhlIHByb2JsZW0gcmF0aGVyIHRoYW4gc3VzcGVj
dGluZyBzb21lIHJhbmRvbSBmYWlsdXJlIG1vZGVzLg0KPiA+DQo+ID4gV2l0aCBkZXZtX3JlcXVl
c3RfaXJxKCZwZGV2LT5kZXYuLikgdGhlIGFib3ZlIGlzc3VlIGlzIGZpeGVkLg0KPiA+DQo+ID4g
T3INCj4gPg0KPiA+IHRoZSBjb3JyZWN0IHdheSBpcyBwYXNzaW5nIFNIQVJFRCBmbGFnIHdpdGgg
ZGV2bV9yZXF1ZXN0X2lycShkZGF0YQ0KPiA+IC0+ZGV2Li4pLCBhcyB0aGUgcmVzb3VyY2UgaXMg
b3duZWQgYnkgdGhlIHBhcmVudD8/DQo+IA0KPiBObyB5b3Ugc2hvdWxkbid0IHBhc3MgdGhlIFNI
QVJFRCBmbGFnLiBUaGlzIHBhdGNoIGlzIGEgc3RlcCBpbiB0aGUgcmlnaHQNCj4gZGlyZWN0aW9u
LCBidXQgdGhlIHByb3BlciBmaXggd291bGQgYmUgdG8gcmVnaXN0ZXIgdGhlIGludGVycnVwdCBo
YW5kbGVyDQo+IGluIHRoZSB1c2IzZHJkIGRyaXZlci4NCg0KSSBiZWxpZXZlLCBpZiB3ZSByZWdp
c3RlciB0aGUgaW50ZXJydXB0IGhhbmRsZXIgaW4gdGhlIHVzYjNkcmQgZHJpdmVyLCB3ZSBuZWVk
IHRvDQpkdXBsaWNhdGUgdGhlIGNvZGUgdG8gYXZvaWQgY3Jvc3MgZGVwZW5kZW5jaWVzLg0KDQpD
dXJyZW50bHkgVVNCM2RyZCBkcml2ZXIgZXhwb3NlIHJlc2V0IEFQSSBmb3IgYm90aCBob3N0L3Bl
cmkuDQoNCklmIHdlIHdhbnQgdG8gcmV1c2UgdGhlIGNvZGUsIG1lYW5zIHdlIG5lZWQgdG8gZXhw
b3J0IGEgY2FsbCBmcm9tIHBlcmkgZHJpdmVyDQp0aGlzIHdpbGwgcmVzdWx0IGluIGNyb3NzIGRl
cGVuZGVuY3kuDQoNClRoYXQgaXMgdGhlIHJlYXNvbiBmb3IgcmV1c2luZyB0aGUgY29kZSwgdGhp
cyBoYW5kbGVyIGlzIG1hbmFnZWQgYnkgdGhlDQpwZXJpIGRyaXZlci4NCg0KQ2hlZXJzLA0KQmlq
dQ0KDQo=
