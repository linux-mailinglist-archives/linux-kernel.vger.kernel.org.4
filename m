Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A486E620BEA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 10:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbiKHJQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 04:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbiKHJQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 04:16:02 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2126.outbound.protection.outlook.com [40.107.114.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F16D2A279;
        Tue,  8 Nov 2022 01:16:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXh8Lqr6SylhsfcujvohklTafdFfrcQ0VwDyJuTXaBwP1fOassDK/kmzJmExM9IOTif55iRAbKPo1r8+1Vlt4VRYcUcJ1WUMyf2rPUuHJ/bP7Z+hBkg1PZVVoD11j3e9eY6fy/z3Siu0dql8XSrqYhnPTmNlalmjzp/RIhat49ytijLUFokPhRNex85jqPxXfYb+RJaYLNUxqBesYv/ayyBL1hy6VWTaBSenGWJiuSisPhJWWfnSxU3cKXNhaIyGVPnPWJ1C1dCfkbPBuhkGq6rVo2v4HytUzDZF4ZjXZUG1HT1w/zjm00qbWbDjkqWLr044nod1Vr4WYDS3HYKmYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxBfkvHi30f9VU51D4ZRKDXlOtNRxr/a7B68y08YP9I=;
 b=fj1NXjXLGSEaasSc1vLwFZdyM2lysaXlxxktizQIK9m04lJuaj6zCbDnaYlIZaVxd1Ew8Gl5/9MQJPINjLc+y1zk57mYiB29UMER52MyVQgFWjx69VLfc1SGV+PevCrqUqPBMlI8S4oYMm1PxRMD7gmcHabD3SPe5Pswj1ZysHZI0i85swnaXGsme+M46dMtyiKyQBXbwLH2+BG0Y9ftG+S7QipMjHExELAgzh4jXcb2o5Xrzr2cexp9pJ+XPMWIYYyi1jkVjktdIMVqOZPyeGb8Lhi2vRG1CJwNH+tj6gCwr3TSuPyCYjQpDjcljRk2ZmeWgrbrXpW7NcwmFq0d3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxBfkvHi30f9VU51D4ZRKDXlOtNRxr/a7B68y08YP9I=;
 b=nbyJpFg6neo0kv851IdDyjMQOyARVDdtQglDSlT0Rw9SWjBxmN0ZbTrbq8fZ7NaD2pc0anNDyz+EA26MERJEnx3GLxvecXuGqzdrgLxs/7jnydUXm7qGIKais5l6k7PetflhoLCf9+divJ1Rq66qfukrOduXvJBf962pee0CgHY=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYYPR01MB8261.jpnprd01.prod.outlook.com (2603:1096:400:115::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 09:15:58 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 09:15:58 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH RFC 2/5] pinctrl: renesas: rzg2l: Fix configuring the GPIO
 pins as interrupts
Thread-Topic: [PATCH RFC 2/5] pinctrl: renesas: rzg2l: Fix configuring the
 GPIO pins as interrupts
Thread-Index: AQHY8tHTw1YXCrAdj0KX+iZlhq0xQa40m+uwgAAiGoCAAADJIA==
Date:   Tue, 8 Nov 2022 09:15:58 +0000
Message-ID: <OS0PR01MB5922006090CFC5AAE4ED0D2C863F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221107175305.63975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221107175305.63975-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB592295C7DBA5E0A85B4D26AF863F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8u6J3+OkANOQYec9-Xe6voAiNTkLo_Zvy6dkC03EYp-4Q@mail.gmail.com>
In-Reply-To: <CA+V-a8u6J3+OkANOQYec9-Xe6voAiNTkLo_Zvy6dkC03EYp-4Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYYPR01MB8261:EE_
x-ms-office365-filtering-correlation-id: c47a1598-b38e-4cc8-5a1c-08dac169d93a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uRyLx9rO+8ioDpYV0bpdiZ27frKnMdmfF1s467r+ZmHEQZUa1FXFTFUD6DEZN5NU/7rX4yDxacGIvsegmmOYrjaKDaFo+XyQWQ+9JSXemnkVx/QFYPR/q9Z0ctdDvgFWlT3/iIId8ryiwu3JYPVhnieeVwqJAMAOqLwkMM/JUzxiTJxg/JKcQX+St+ShmiBgPNjUmMu3hYlOxg5Y2LCTU9MF8Z+vXAjl8NgEfmSZf6GGvbzrwygG7DRsjvGpbo/qiqYjqQPeC2Wo9b8eyPfTLTejmKRytKc8Z1N/YIetb+GCSBZuFoFusDc5fOnafvXtWTpdEa3pm2X2rXzx7RzcWzSf3ZyO5nIdA8G7I9P5xy3V8kxj5iD6h2vRNCDqhsCEH9qMyFEC18npkCSz1btUoz17bxXvD4Pa9mEAMoLyLlsF1wDth9EePXiZ5ZQ9kIh4xVBk8gHwwCienpKeDySO0UbKKV0+udYvdPq/h+kA+XoN57nq11nA/6tU6SCA6wUyTcFcDhxxwxLFxMQMs9LHIl3bth3tDGBkEXgjU7LyjSvrOpQVBTI6+8P71NIPWmTq3A38w6TmUPDu2Ku/hwz2orFjjbf4o5tgPM3mTfpvmbBeWv+3Hb5KZN8wW5CvrKQXaUy3uBf0sXV7HOJ10a0SOE2XfsbReWUJhH08YrWtUe7p/8pbjFtfV9Jr8xZlbq70F/uH4zw//97n41AjXOiomiriX6jhHETf7IZ97trqSgyekjktNgXJUInLn5hSiWqgmVYS6ra4FbRMF0v5XYLBbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199015)(38100700002)(38070700005)(107886003)(76116006)(6506007)(5660300002)(66446008)(66476007)(7696005)(122000001)(66946007)(33656002)(86362001)(2906002)(66556008)(7416002)(41300700001)(83380400001)(8936002)(4326008)(186003)(9686003)(53546011)(26005)(6916009)(478600001)(64756008)(8676002)(316002)(54906003)(52536014)(55016003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnZ1SXgreWpHOW9uejkwNHU2UE8wTGtXWXA3NkJXOEFtZDMwMXhEMWNFR1M4?=
 =?utf-8?B?NmZyczduK0FLanlTZENkVTdTT0t0QjBvbzEyYmQvM0Rtbm9rMk0vYS8wdW84?=
 =?utf-8?B?bWtCZXNYNmMvZUNDbjFsNmVNTjlTRnZnNjJ4aXpUVzlxYjRLQWpibWZrVHJX?=
 =?utf-8?B?SDFJQ3dLak9xd0NTYUN6Nkc4MVdXQ0w0NUM5VFYwVzFOWlNSdllPU2xiaEZt?=
 =?utf-8?B?RGJKTHd0V3V5dDZ1RjNNdklqd21ZR3dScHRiakdVZ2ZnNmovN0RmaXVlV3du?=
 =?utf-8?B?OUlqdnN1RFlqSDVSSk5sWHd5V3d4dVVwcmZtKzBCQm55anlnQnUzOTA1VFFq?=
 =?utf-8?B?QUw3UXg3M2gvZDVZU1pDZ1JQSm15aWVXbTV2UDQvN01ETWdXN1JXeG5JNTFM?=
 =?utf-8?B?QTdwN2ZDaGRYZDV6SnhOYi9uL3pTZm56M2xZMFBRVDlaM1Z6Mm5BM3JRb3ZM?=
 =?utf-8?B?eExEK0xUd2FHRkxieXBQQk5aMitVMFQ3U0tWS2ZMNHNJbmZpL1VQR3UzdndI?=
 =?utf-8?B?aHFpb25hcEo2RW1KakRvanM0OU1NcmQ1Qk84aGxIUlZjcFpGL0lRejVsU2tK?=
 =?utf-8?B?WlYzckhZeGU0MU81MC9WNEFNUEZ0THF2dGcrMVQrcERYMURLMHBFS214QXBM?=
 =?utf-8?B?eXVEZ3NEM3hGTWlBUEM1NjJqRTg4OVhINjk0RFNvcEkwMHZRTlFtSVM5SFJi?=
 =?utf-8?B?L2lPWDh0TnlzUjZkc3hFQmJpNm1QM1pXclFvSXBxRHpDSEZxellZTmIvV2NV?=
 =?utf-8?B?M0hGSWdFc3puWVlQa2VsaTUrM1AzV3JtNkYwaWZJNi9SV2JjNDlIRElTajd5?=
 =?utf-8?B?alJSYlB2M2NUckh6VlNDbnJqcndWTElmTmUxbnZjZkVVZ0RiOElLTWcwbWJp?=
 =?utf-8?B?dzZWYkRPdGllcEFkUGRXWG1MZ3hET1l1Tk4wUWFSelVSVnBBQjhTR3UwQWty?=
 =?utf-8?B?dVBoeWFSTjBBQVZZOEkrcjc2bDdRNXgxRjRuU2pRL3NwSnVrMmhDOFpTQThE?=
 =?utf-8?B?ZXI3TWo3Z3pUTDBiamxnaXVzK0YvMXZZdDhWNWtIQ0ZzeUN4NElQb3hLcUVJ?=
 =?utf-8?B?OURrSlRGY0xKM1VOdnQxbklvcThLNGhBL3FrVlVCTG1aNkNEaHViaytkU3N2?=
 =?utf-8?B?RlVHN1lEZjJ3TWV3WGVIUmJCaTRwZlFqa3FvYWN2RWswK25sWjJ3Z1lJS0NT?=
 =?utf-8?B?VWJyWU1lVW9ZNFFocm1KMDZuUEI5dDBnSmFtdXQzZ2ozZkhBR05oaVRjOTVD?=
 =?utf-8?B?TWxzQUo5amJWSzdFNWNoUTBaeHhsVE1ycm9VV0N4VjJQVUJONDRlcFFDOXJk?=
 =?utf-8?B?UVpOdTZ6Tkx0RXNxRVJuQUFzcDZTcjJmMnFqdFkzTGZoNkw3T2oyZC9Mclkw?=
 =?utf-8?B?cEhkb0c2TkpjeFJMMEVXMGhuYVJiUHVWS1pkdTg1NEZ1L0VFcHFJbWszZTVI?=
 =?utf-8?B?YTY3bk1qOVJ4V0lUU0xOcjNZMStBODlVNGxNMmZPaGFBNDU5N1R6S1RSaEla?=
 =?utf-8?B?YkhHU3V3ZXZydUR0VWVzMzBvVDk5RVFkNDRyb0hjaVJBK1hJUk1lTGV0bVR4?=
 =?utf-8?B?SElLQlRuRXVkc3U4Ym1qd1FkODlCV25adGtkMmtQblpPTjNHcWl3WW1VQTZr?=
 =?utf-8?B?T0s3b2dEbUN5OGpSaTVjS09NN1ZaekNFaDNDOFR4MXg1SDd1Qm5KelZ1WHJt?=
 =?utf-8?B?UXpaU1BHbjQ5cTZKOWMybjJ1MFd5RTYzMyt4OUlYWDY5YURrd3lGUUoxTkta?=
 =?utf-8?B?Ulp0bWtSdnhrbnJ0cy9xM2R2TEo3aHFHQWNrWWEzeWp1ZWw1d2NTNGF6dURa?=
 =?utf-8?B?eWVtUXFETEo0TFh3eWFNZlI4VjhvelhjOVJVNjdVdHN5T1FNNi9JS2JBdTRr?=
 =?utf-8?B?Y24xTVdVRTZ3QUltRTNUdE4wZ0Q4Q00yQWJld1RibzlSeXplMVMzcHZMWTlX?=
 =?utf-8?B?eC9UZUR5UlNIL3pTOGZ4NDliNG53SkI3bklxQlFrMGJTLzhaRVJmUDk2Zm5J?=
 =?utf-8?B?OHVDY09Jc29QbFg4Y1MwdWZUVXkxUXRlTjhWbE1tcCsvMWJCMC9aeDc1UlRB?=
 =?utf-8?B?NUhVL1ZqYWhyeWh3eXAxNFRtZk9GNWZ2MjdzS3lycjhJRkh3UzJzQ2xEbmwr?=
 =?utf-8?B?NGtJa1NGV1JGS3NGOFZlejBma1BxNWxzSzlYNXFPU2lwaTVKVjZ4MGg2b3hH?=
 =?utf-8?B?TVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c47a1598-b38e-4cc8-5a1c-08dac169d93a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 09:15:58.5928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ku9fwit3UmG5Fq7uATJ6P652dsDJ/McVAVJHuj1SRowvYPTgUSn8Jt6318OCncgPZXfi3/2GBkmXDhCUFLT5c8lFANI7UOaxoglQQN7xmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8261
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGFkLCBQcmFiaGFrYXIg
PHByYWJoYWthci5jc2VuZ2dAZ21haWwuY29tPg0KPiBTZW50OiAwOCBOb3ZlbWJlciAyMDIyIDA5
OjEwDQo+IFRvOiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+IENjOiBU
aG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT47IE1hcmMgWnluZ2llciA8bWF6QGtl
cm5lbC5vcmc+OyBSb2INCj4gSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgS3J6eXN6dG9m
IEtvemxvd3NraQ0KPiA8a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPjsgR2VlcnQg
VXl0dGVyaG9ldmVuDQo+IDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT47IE1hZ251cyBEYW1tIDxt
YWdudXMuZGFtbUBnbWFpbC5jb20+OyBMaW51cyBXYWxsZWlqDQo+IDxsaW51cy53YWxsZWlqQGxp
bmFyby5vcmc+OyBsaW51eC1ncGlvQHZnZXIua2VybmVsLm9yZzsgbGludXgtcmVuZXNhcy0NCj4g
c29jQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0K
PiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBQcmFiaGFrYXIgTWFoYWRldiBMYWQgPHByYWJoYWth
ci5tYWhhZGV2LQ0KPiBsYWQucmpAYnAucmVuZXNhcy5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggUkZDIDIvNV0gcGluY3RybDogcmVuZXNhczogcnpnMmw6IEZpeCBjb25maWd1cmluZyB0aGUN
Cj4gR1BJTyBwaW5zIGFzIGludGVycnVwdHMNCj4gDQo+IEhpIEJpanUsDQo+IA0KPiBPbiBUdWUs
IE5vdiA4LCAyMDIyIGF0IDc6MTQgQU0gQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMu
Y29tPiB3cm90ZToNCj4gPg0KPiA+IEhpIFByYWJoYWthciwNCj4gPg0KPiA+DQo+ID4gPiBTdWJq
ZWN0OiBbUEFUQ0ggUkZDIDIvNV0gcGluY3RybDogcmVuZXNhczogcnpnMmw6IEZpeCBjb25maWd1
cmluZw0KPiA+ID4gdGhlIEdQSU8gcGlucyBhcyBpbnRlcnJ1cHRzDQo+ID4gPg0KPiA+ID4gRnJv
bTogTGFkIFByYWJoYWthciA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29t
Pg0KPiA+ID4NCj4gPiA+IE9uIHRoZSBSWi9HMlVMIFNvQyB3ZSBoYXZlIGxlc3MgbnVtYmVyIG9m
IHBpbnMgY29tcGFyZWQgdG8gUlovRzJMDQo+ID4gPiBhbmQgYWxzbyB0aGUgcGluIGNvbmZpZ3Mg
YXJlIGNvbXBsZXRlbHkgZGlmZmVyZW50LiBUaGlzIHBhdGNoIG1ha2VzDQo+ID4gPiBzdXJlIHdl
IHVzZSB0aGUgYXBwcm9wcmlhdGUgcGluIGNvbmZpZ3MgZm9yIGVhY2ggU29DICh3aGljaCBpcw0K
PiA+ID4gcGFzc2VkIGFzIHBhcnQgb2YgdGhlIE9GDQo+ID4gPiBkYXRhKSB3aGlsZSBjb25maWd1
cmluZyB0aGUgR1BJTyBwaW4gYXMgaW50ZXJydXB0cyBpbnN0ZWFkIG9mIHVzaW5nDQo+ID4gPiBy
emcybF9ncGlvX2NvbmZpZ3NbXSBmb3IgYWxsIHRoZSBTb0NzLg0KPiA+ID4NCj4gPg0KPiA+IExv
b2tzIGxpa2UgeW91IGFyZSBtaXNzaW5nIGZpeGVzIHRhZy4NCj4gPiBGaXhlczogZGIyZTVmMjFh
NDhlZCAoInBpbmN0cmw6IHJlbmVzYXM6IHBpbmN0cmwtcnpnMmw6IEFkZCBJUlEgZG9tYWluDQo+
ID4gdG8gaGFuZGxlIEdQSU8gaW50ZXJydXB0IikNCj4gPg0KPiBJIGRpZCB0aGluayBhYm91dCBi
dXQgdGhlbiBJIHJlYWxpc2VkIHRoaXMgZml4ZXMgdGhlIEdQSU8gSVJRIGZ1bmN0aW9ucyBvbmx5
DQo+IGFuZCB3ZSBkaWRuJ3Qgc3VwcG9ydCBJUlFDIGFuZCBHUElPIGludGVycnVwdHMgdXAgdW50
aWwgbm93IHNvIEkgaGFkbid0IGFkZGVkDQo+IHRoZSBmaXhlcyB0YWcuDQoNClllcCB0aGF0IGlz
IHRydWUsIGV2ZW4gdGhvdWdoIHdlIGhhdmUgcGluY3RybCBzdXBwb3J0IGZvciBib3RoIFJaL0cy
TCBhbmQgUlovRzJVTC4NCkludGVycnVwdCBzdXBwb3J0IGFkZGVkIG9ubHkgZm9yIFJaL0cyTCBh
dCB0aGF0IHRpbWUuIE1heWJlIGNoYW5nZSB0byByZWZsZWN0DQpSWi9HMlVMIEdQSU8gaW50ZXJy
dXB0IHN1cHBvcnQuDQoNCkNoZWVycywNCkJpanUNCg==
