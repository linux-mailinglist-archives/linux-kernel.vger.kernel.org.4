Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D408A613949
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiJaOtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiJaOtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:49:02 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2095.outbound.protection.outlook.com [40.107.113.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71181F037;
        Mon, 31 Oct 2022 07:49:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWjqxxzIOj6Klh3EFogvvluvqowd+PeiclQc+oxAUWvG4xGic2+9SqgRwWYE6M5keU46b8Vrfnd7DTDhIyd+STjeS4EHSacvoaXfRPhtEyuE0QIb+1REvoGrBjFKVykaD2qgwu1Qi+WMkvdNl4WUl/LcP8p3yS5OL6ZFMfQtR7mqPyoq7PjPrjEMvt6VgBhZa1RZ6RxeE5Xa1UudZFS6iLrAc3Bee7/JXTOxxhjjdzCVrYafQsMptURuw0fMrPU/+CaZV3duThdY2Hu1taDmf5ZekNTuYJ9LBgNBHX32CR6ZCDgKRVY2Ohouapf1Lmzs9uy11MEOEpqvN2Mxjl/RdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wa38amSPPP46Yebg6pvWsyPaZqmA0LAmB+NqIe3Quxs=;
 b=lPzP3U8xGRH5cOy3HkM8LqnWdnJ4aTWtLkFJoa8qCSNL+dj0HzsYvFX63if1n7mTDaLqw8PyJOyQErYgJQcF8UrKIAW7fBTolKLWZ91sBq1Tsr4ZxK52cxMeqZ9yyK69oGwDJgzqw/Zcu3hcmlEJAdr5Esi29/MCEdGhZ0lYT6KowEYSRCYa7yFaX9UPvOqHDXmVNDHOfFVGfD9Y77INL3c82S1OphNrBptf+FFFsDE4AXYuAFbWI21QNkXyDY6xnWDkORm4ptyRRHWKmn9rhJlpvp5P2JD6LB6erBAoL9Uk4hxGHAkB8meqOyaijkDVmwhk3Wf7y0BE5PgI1dSk1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wa38amSPPP46Yebg6pvWsyPaZqmA0LAmB+NqIe3Quxs=;
 b=dUeQHV8PN+r9I5j2h/Ybtmn9u+Hhc+hwUtLEk8WIST+BE0mVKlPg9+SyVgMp28Wl/u2n8sg2/rXXZDpI0S6qiLiIln6fe4L2VluYXs+MXtCzW9QS4xMObneE444mcxWRRsddE+8+2NBEgkLnP5hGrz+vvRUFAx41oHY99r4oXzE=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB8432.jpnprd01.prod.outlook.com (2603:1096:400:173::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Mon, 31 Oct
 2022 14:48:59 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 14:48:58 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     jerome Neanne <jneanne@baylibre.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>, "nm@ti.com" <nm@ti.com>,
        "kristo@kernel.org" <kristo@kernel.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "tony@atomide.com" <tony@atomide.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "marcel.ziswiler@toradex.com" <marcel.ziswiler@toradex.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jeff@labundy.com" <jeff@labundy.com>
CC:     "afd@ti.com" <afd@ti.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "msp@baylibre.com" <msp@baylibre.com>,
        "j-keerthy@ti.com" <j-keerthy@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Subject: RE: [PATCH v5 4/6] mfd: tps65219: Add driver for TI TPS65219 PMIC
Thread-Topic: [PATCH v5 4/6] mfd: tps65219: Add driver for TI TPS65219 PMIC
Thread-Index: AQHYyENwfeSoLjmHiU+cGdhL0pREk64ooH3wgAA9tICAAABdYA==
Date:   Mon, 31 Oct 2022 14:48:58 +0000
Message-ID: <OS0PR01MB59225CD0FF691E169F25F56886379@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220914140758.7582-1-jneanne@baylibre.com>
 <20220914140758.7582-5-jneanne@baylibre.com>
 <OS0PR01MB59221A8415766E7E3615F39E86379@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <a2000dfa-6872-fdf5-c636-755ae5a82728@baylibre.com>
In-Reply-To: <a2000dfa-6872-fdf5-c636-755ae5a82728@baylibre.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB8432:EE_
x-ms-office365-filtering-correlation-id: 06067ab0-2fc2-4d31-2fd2-08dabb4f0b05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t1W6qGCALZ/bD5aJespB2D2lsM6bRnJ8kCHeq97d2ukCt5maheqwhABGOPo8iDTfOH/7yD+bQRc8s5j2cmzrD252y0t0h/PycuVzewKZEVVuSqW1kN8CTpV4qtezsIZ3l3N4egqTjJO/mW1ZHLlZNksztsppzFSOcp63f3jibADjd2p0GnTmw13vVhbsTef6z2VFz7FAi00DSBBC/sRhzL7+qYxmgM9fmZEpee1cvEGnXKc9/GSaAVp8TLHl1Ek5nttkuVSOA5csi16VN8Ia1zeJgvagrnQJMeROJ/EePfEIRJFZq5WnooZ/CppUDpOyk8TEOjhuiwho7BSW/ClcOomnCCiRfMKvIP7Eot4LrG/plVoLoEMTtUsunpnqDjYFK0FG2ScTW7ZfGUuqQ/I7TAHOlP1VJ/nBykWCQ0Nc/wwZ78mXVKqKCkqs4GqV0niEGazhQahbxmRJ/15Z7atdA3znDp+rZdyC9a3Y1SiQ92odrZp/OUIP8h5Kdk1GRH5b4XKtR3haEzf5xZoFFu0kO49Yk0muZbm/pwJrd0uPMTdiXVvD/rfee7AO17+Cy5VrzEmDqQ8F77cz2sGngtzW79mBbO30q+1/tmn0VCZThUHhJZZH4FIY+h39PrRVYRt0wj1I6TciVyCmvz4A2df5mPCWhSqkTvVXknAlaVyOJCY53tu03xVi1hBdVTk78x0FAUnoZFLpSrvuEKUhJ0iDFVEvVkxHAeZmX+xksPggPUIkjZ4E7Yr8QmgSN0tZ2cVMBZyGsMLjx52gHJctC+zeGT1tctVzMhphP6P2airuMM4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(451199015)(86362001)(2906002)(55016003)(83380400001)(8676002)(71200400001)(8936002)(52536014)(4326008)(921005)(41300700001)(7406005)(7416002)(5660300002)(33656002)(38070700005)(66946007)(66476007)(66446008)(64756008)(76116006)(66556008)(54906003)(110136005)(316002)(478600001)(26005)(53546011)(186003)(7696005)(6506007)(38100700002)(9686003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEYvOThwbTZvZG01ZFNJSWNtcWFmRFFHUExqdVBtVktuNWJKSHlEbG9USjhw?=
 =?utf-8?B?WktpeXdZOTZxU0I4VjFLK1hvbS9CaW1wM0cyeUxCYXFtNEd6VEtJZkZSclJa?=
 =?utf-8?B?bjF5MVBLRHVHUXFudlNxRS9Od0RXaFdrbHZPYXVZaEZ5YVFWaGNqb0Q5Z3lu?=
 =?utf-8?B?STA1SGNYeFJzSmNKVFNHc2gxMEVsWWQ4REcxMkNnR1JONkx3eFB0MGpudGt0?=
 =?utf-8?B?QzRDUkZuY2tWTy9qNWFvK2tSdlp4Yko1YmxBaTArOGJXWklYd2RseDkxOVZG?=
 =?utf-8?B?WmhVTDUxdlc5MFV6S1RZMkN6akhlMUd4ekRhb1lHVXhwaUllRytkOUNXV2RS?=
 =?utf-8?B?ci9iZWJWWkYxOGRQaWxJVzR0c0dONW81RFRGb0hFbWpRdS9qYWtsV1pvVHpK?=
 =?utf-8?B?SkprVkZxSmQ1NXFlSzUxU1pkZmd6RlExYnFnRktFSHlWeE5mcXdHUDBiUUhi?=
 =?utf-8?B?djhNWmE5KzN3bWgyMGFpbUJnYW80TklHMG9ERi82aVN3VHFuVURNN3Z2ZlJ6?=
 =?utf-8?B?Zy9yUlBHRTVxKzhTSlh3Z2plYUE2cGJTeFA0VFpNMWMzUnZtZGloODltcVp1?=
 =?utf-8?B?V3ZOVFczbmNjVUlHZ0lxQ3RZVDdJaURJSmh5OHh1VG9IL2tSa3BRTjIvVW9V?=
 =?utf-8?B?L0FhWHhaa0ZiL2Nja2gyc21kcXBMUGwwZmtyVWt2VE1hQ2sxdktMVkNROTVt?=
 =?utf-8?B?VitJbW9QdjF1U1dIbG5JajN5OUdaQWxUYVowZ01FZ2tEdzJmNjBxL3M0VmI1?=
 =?utf-8?B?UVJzT2l3VlhNcDNLTnJOUjZSektiaUpIU1lrblpBLzliem5vaWNSdHpFaC9J?=
 =?utf-8?B?d0o1NkprSG5jZEZVaDJaWXBQaFgyUUZNV3NqVnJuZys0U05PLzNrSHliRDRp?=
 =?utf-8?B?dWRMNVk5cGM1bmhwRXRkNkpWTkxhWnhtbC9mTkRUNUE2a1hGcmJlQ2xvOWF1?=
 =?utf-8?B?OCtyVzBvYVlXTkQxVnV0SnRrSWJlZFJuWC8yRXp2c25rWGlnbnNwNzYxdkhI?=
 =?utf-8?B?N3hTK3M3N2RnbHVtSFdMVkhFZm1hMzRTZUMxVmVVN2J6RHVDd1BySUo0aVNR?=
 =?utf-8?B?Q0pqaHo3L3p0MUNXWm9ZNkNjTk5tZUUyZmg1eEhzVisrMzJneCtWanVTQmFU?=
 =?utf-8?B?LzFMM1JEWGZNYm1LUk1qc282NWd0Vk8vS0haT1FrR1RVM3phbUFEN2xZekhJ?=
 =?utf-8?B?SkJmanpsVlhkRXNWZi8vN1kvRi9vUzMxUVlYNW9nYWRBbGdtL1JmZXM0ZWQv?=
 =?utf-8?B?ZERoYzRKS1Zkbmt5ZWpvYmMwak9yMFdZZGhSaVVjK2dHbEhvV3gyRzVvRUk3?=
 =?utf-8?B?a3VWVHN1a2VOK1JVT2tOMjU3Yko4eWVUMThjdERsYVRGKzZPc25IT3E0MVJC?=
 =?utf-8?B?eWh5Z09Zenljc24vTHBTMlRQQ0p1SHJUMlpnK3JYM3J3Tkh0YnhhZEg0cW0r?=
 =?utf-8?B?R1U3OGJFUU00Q0lFaDcyU2JQUExyMDFKS0ZrdmdpVWNJTXNHeXkybGhpVnRy?=
 =?utf-8?B?ajlma3RVVE9oVURkQjVjalRXcnJOQXpqd1ZncmNSMk5hbXFMRWh2Zk4yOURs?=
 =?utf-8?B?ZWFJc21oYkIrK2N6bEhTcTVnYmd2QzBoSjVkRlV2TmYxM2VVWHROTDZkSlRZ?=
 =?utf-8?B?UEJWUGFubHY0UmJhaEhmeHRVVG9DSlZyQ3pBS3ZBd3N0WVZ1a1o3d01WSUR2?=
 =?utf-8?B?dHlaTjlGbExxWVJyc2hFcGtLenNyOWc1c1hsR2UzK2M2OVlBOFVKeHV1bDk0?=
 =?utf-8?B?NWRWdHlNYzV0eWh2QzFmMXRscUo5VGRoUHR6c0dZTUhHdE51bjgxUFB1S3Bm?=
 =?utf-8?B?UHFPMy9IZUREdmgyTzFzM2pMYnk1QlJ1S1Y0Y3cxMWZyVW13MGtPZmx1YlVx?=
 =?utf-8?B?alNlYVBpaGpDa2lYa3BjYmIyZHZjSldIT2JEUE1RUmxyLzc0M2JQTWpCYXly?=
 =?utf-8?B?RjJIT3htd3YwR3d1ZWorVzZyMzFDbjBla3BWRFNlOU5hTGFCMENqUTMwdy82?=
 =?utf-8?B?eHJUSm9zVlF5dUs0WDFIY1NRaGFJeWhKdjhuWXZRSlN0YkNqWkU3Y2QyeStD?=
 =?utf-8?B?eHZTYlF3cjg2L3IwanIzOHVhQUxndGdTT2hXVi9ETXNEVUdYZC9HaTc1M1RL?=
 =?utf-8?B?WjFKbGJaUGsyNWIwTnRSRFdESm1xNHUvMWlXcTMzZXlNNGJWeW5MREF2bi9H?=
 =?utf-8?B?Y1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06067ab0-2fc2-4d31-2fd2-08dabb4f0b05
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 14:48:58.7422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zcQ4zhiiy7QMUSB8qGC7/YZFcOj6sN7dNHJBD/46C6702AYl1ThgQOWDkiFNmdS3xB0Sd9FtNRex7JUTjgiFDfU3NBoPIOR9CbfkJpBT0rg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8432
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDQvNl0gbWZkOiB0cHM2NTIxOTogQWRkIGRyaXZlciBm
b3IgVEkgVFBTNjUyMTkNCj4gUE1JQw0KPiANCj4gDQo+IA0KPiBPbiAzMS8xMC8yMDIyIDEyOjEz
LCBCaWp1IERhcyB3cm90ZToNCj4gPiBIaSwNCj4gPg0KPiA+PiBTdWJqZWN0OiBbUEFUQ0ggdjUg
NC82XSBtZmQ6IHRwczY1MjE5OiBBZGQgZHJpdmVyIGZvciBUSSBUUFM2NTIxOQ0KPiA+PiBQTUlD
DQo+ID4+DQo+ID4+IFRoZSBUUFM2NTIxOSBpcyBhIHBvd2VyIG1hbmFnZW1lbnQgSUMgUE1JQyBk
ZXNpZ25lZCB0byBzdXBwbHkgYQ0KPiB3aWRlDQo+ID4+IHJhbmdlIG9mIFNvQ3MgaW4gYm90aCBw
b3J0YWJsZSBhbmQgc3RhdGlvbmFyeSBhcHBsaWNhdGlvbnMuIEFueSBTb0MNCj4gPj4gY2FuIGNv
bnRyb2wNCj4gPj4gVFBTNjUyMTkgb3ZlciBhIHN0YW5kYXJkIEkyQyBpbnRlcmZhY2UuDQo+ID4+
DQo+ID4+IEl0IGNvbnRhaW5zIHRoZSBmb2xsb3dpbmcgY29tcG9uZW50czoNCj4gPj4gLSBSZWd1
bGF0b3JzLg0KPiA+PiAtIE92ZXIgVGVtcGVyYXR1cmUgd2FybmluZyBhbmQgU2h1dCBkb3duLg0K
PiA+PiAtIEdQSU9zDQo+ID4+IC0gTXVsdGkgRnVuY3Rpb24gUGlucyAoTUZQKQ0KPiA+PiAtIHBv
d2VyLWJ1dHRvbg0KPiA+Pg0KPiA+PiBUaGlzIHBhdGNoIGFkZHMgc3VwcG9ydCBmb3IgdHBzNjUy
MTkgUE1JQy4gQXQgdGhpcyB0aW1lIG9ubHkgdGhlDQo+ID4+IGZ1bmN0aW9uYWxpdGllcyBsaXN0
ZWQgYmVsb3cgYXJlIG1hZGUgYXZhaWxhYmxlOg0KPiA+Pg0KPiA+PiAtIFJlZ3VsYXRvcnMgcHJv
YmUgYW5kIGZ1bmN0aW9uYWxpdGllcw0KPiA+PiAtIHdhcm0gYW5kIGNvbGQgcmVzZXQgc3VwcG9y
dA0KPiA+PiAtIFNXIHNodXRkb3duIHN1cHBvcnQNCj4gPj4gLSBSZWd1bGF0b3Igd2FybmluZ3Mg
dmlhIElSUXMNCj4gPj4gLSBQb3dlci1idXR0b24gdmlhIElSUQ0KPiA+Pg0KPiA+PiBTaWduZWQt
b2ZmLWJ5OiBKZXJvbWUgTmVhbm5lIDxqbmVhbm5lQGJheWxpYnJlLmNvbT4NCj4gPj4gU2lnbmVk
LW9mZi1ieTogTWFya3VzIFNjaG5laWRlci1QYXJnbWFubiA8bXNwQGJheWxpYnJlLmNvbT4NCj4g
Pj4gLS0tDQo+ID4+ICAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ID4+
ICAgZHJpdmVycy9tZmQvS2NvbmZpZyAgICAgICAgICB8ICAxNCArKw0KPiA+PiAgIGRyaXZlcnMv
bWZkL01ha2VmaWxlICAgICAgICAgfCAgIDEgKw0KPiA+PiAgIGRyaXZlcnMvbWZkL3RwczY1MjE5
LmMgICAgICAgfCAzMjANCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPj4g
ICBpbmNsdWRlL2xpbnV4L21mZC90cHM2NTIxOS5oIHwgMzQ1DQo+ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+ID4+ICAgNSBmaWxlcyBjaGFuZ2VkLCA2ODEgaW5zZXJ0aW9u
cygrKQ0KPiA+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL21mZC90cHM2NTIxOS5jICBj
cmVhdGUgbW9kZSAxMDA2NDQNCj4gPj4gaW5jbHVkZS9saW51eC9tZmQvdHBzNjUyMTkuaA0KPiA+
Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUyBpbmRleA0KPiA+
PiBmMzViMjlmZmQ1ZmIuLjk2MGRmODc5YzYzNSAxMDA2NDQNCj4gPj4gLS0tIGEvTUFJTlRBSU5F
UlMNCj4gPj4gKysrIGIvTUFJTlRBSU5FUlMNCj4gPj4gQEAgLTE0OTI2LDYgKzE0OTI2LDcgQEAg
RjoJZHJpdmVycy9tZmQvbWVuZWxhdXMuYw0KPiA+PiAgIEY6CWRyaXZlcnMvbWZkL3BhbG1hcy5j
DQo+ID4+ICAgRjoJZHJpdmVycy9tZmQvdHBzNjUyMTcuYw0KPiA+PiAgIEY6CWRyaXZlcnMvbWZk
L3RwczY1MjE4LmMNCj4gPj4gK0Y6CWRyaXZlcnMvbWZkL3RwczY1MjE5LmMNCj4gPj4gICBGOglk
cml2ZXJzL21mZC90cHM2NTkxMC5jDQo+ID4+ICAgRjoJZHJpdmVycy9tZmQvdHdsLWNvcmUuW2No
XQ0KPiA+PiAgIEY6CWRyaXZlcnMvbWZkL3R3bDQwMzAqLmMNCj4gPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbWZkL0tjb25maWcgYi9kcml2ZXJzL21mZC9LY29uZmlnIGluZGV4DQo+ID4+IGFiYjU4
YWIxYTFhNC4uMWE4NDZjN2RkMGMyIDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL21mZC9LY29u
ZmlnDQo+ID4+ICsrKyBiL2RyaXZlcnMvbWZkL0tjb25maWcNCj4gPj4gQEAgLTE1NzYsNiArMTU3
NiwyMCBAQCBjb25maWcgTUZEX1RQUzY1MjE4DQo+ID4+ICAgCSAgVGhpcyBkcml2ZXIgY2FuIGFs
c28gYmUgYnVpbHQgYXMgYSBtb2R1bGUuICBJZiBzbywgdGhlIG1vZHVsZQ0KPiA+PiAgIAkgIHdp
bGwgYmUgY2FsbGVkIHRwczY1MjE4Lg0KPiA+Pg0KPiA+PiArY29uZmlnIE1GRF9UUFM2NTIxOQ0K
PiA+PiArCXRyaXN0YXRlICJUSSBUUFM2NTIxOSBQb3dlciBNYW5hZ2VtZW50IElDIg0KPiA+PiAr
CWRlcGVuZHMgb24gSTJDICYmIE9GDQo+ID4+ICsJc2VsZWN0IE1GRF9DT1JFDQo+ID4+ICsJc2Vs
ZWN0IFJFR01BUF9JMkMNCj4gPj4gKwlzZWxlY3QgUkVHTUFQX0lSUQ0KPiA+PiArCWhlbHANCj4g
Pj4gKwkgIElmIHlvdSBzYXkgeWVzIGhlcmUgeW91IGdldCBzdXBwb3J0IGZvciB0aGUgVFBTNjUy
MTkgc2VyaWVzIG9mDQo+ID4+IFBvd2VyDQo+ID4+ICsJICBNYW5hZ2VtZW50IElDcy4gVGhlc2Ug
aW5jbHVkZSB2b2x0YWdlIHJlZ3VsYXRvcnMsIEdQSU9zIGFuZA0KPiA+PiArCSAgcHVzaC9wb3dl
ciBidXR0b24gdGhhdCBhcmUgb2Z0ZW4gdXNlZCBpbiBwb3J0YWJsZSBkZXZpY2VzLg0KPiA+PiAr
DQo+ID4+ICsJICBUaGlzIGRyaXZlciBjYW4gYWxzbyBiZSBidWlsdCBhcyBhIG1vZHVsZS4gSWYg
c28sIHRoZSBtb2R1bGUNCj4gPj4gKwkgIHdpbGwgYmUgY2FsbGVkIHRwczY1MjE5Lg0KPiA+PiAr
DQo+ID4+ICAgY29uZmlnIE1GRF9UUFM2NTg2WA0KPiA+PiAgIAlib29sICJUSSBUUFM2NTg2eCBQ
b3dlciBNYW5hZ2VtZW50IGNoaXBzIg0KPiA+PiAgIAlkZXBlbmRzIG9uIEkyQz15DQo+ID4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL21mZC9NYWtlZmlsZSBiL2RyaXZlcnMvbWZkL01ha2VmaWxlIGlu
ZGV4DQo+ID4+IDg1OGNhY2Y2NTlkNi4uYThmZjNkNmVhM2FiIDEwMDY0NA0KPiA+PiAtLS0gYS9k
cml2ZXJzL21mZC9NYWtlZmlsZQ0KPiA+PiArKysgYi9kcml2ZXJzL21mZC9NYWtlZmlsZQ0KPiA+
PiBAQCAtMTAxLDYgKzEwMSw3IEBAIG9iai0kKENPTkZJR19UUFM2NTA3WCkJCSs9IHRwczY1MDd4
Lm8NCj4gPj4gICBvYmotJChDT05GSUdfTUZEX1RQUzY1MDg2KQkrPSB0cHM2NTA4Ni5vDQo+ID4+
ICAgb2JqLSQoQ09ORklHX01GRF9UUFM2NTIxNykJKz0gdHBzNjUyMTcubw0KPiA+PiAgIG9iai0k
KENPTkZJR19NRkRfVFBTNjUyMTgpCSs9IHRwczY1MjE4Lm8NCj4gPj4gK29iai0kKENPTkZJR19N
RkRfVFBTNjUyMTkpCSs9IHRwczY1MjE5Lm8NCj4gPj4gICBvYmotJChDT05GSUdfTUZEX1RQUzY1
OTEwKQkrPSB0cHM2NTkxMC5vDQo+ID4+ICAgb2JqLSQoQ09ORklHX01GRF9UUFM2NTkxMikJKz0g
dHBzNjU5MTItY29yZS5vDQo+ID4+ICAgb2JqLSQoQ09ORklHX01GRF9UUFM2NTkxMl9JMkMpCSs9
IHRwczY1OTEyLWkyYy5vDQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21mZC90cHM2NTIxOS5j
IGIvZHJpdmVycy9tZmQvdHBzNjUyMTkuYyBuZXcNCj4gZmlsZQ0KPiA+PiBtb2RlDQo+ID4+IDEw
MDY0NCBpbmRleCAwMDAwMDAwMDAwMDAuLmMxNjM4NDgzZTA2OQ0KPiA+PiAtLS0gL2Rldi9udWxs
DQo+ID4+ICsrKyBiL2RyaXZlcnMvbWZkL3RwczY1MjE5LmMNCj4gPj4gQEAgLTAsMCArMSwzMjAg
QEANCj4gPj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ID4+ICsvLw0K
PiA+PiArLy8gRHJpdmVyIGZvciBUUFM2NTIxOSBJbnRlZ3JhdGVkIFBvd2VyIE1hbmFnZW1lbnQg
SW50ZWdyYXRlZA0KPiBDaGlwcw0KPiA+PiArKFBNSUMpIC8vIC8vIENvcHlyaWdodCAoQykgMjAy
MiBCYXlMaWJyZSBJbmNvcnBvcmF0ZWQgLQ0KPiA+PiArDQo+ID4+ICsNCj4gPj4gK3N0YXRpYyBp
bnQgdHBzNjUyMTlfcmVzdGFydChzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKnRoaXMsDQo+ID4+ICsJ
CQkgICAgdW5zaWduZWQgbG9uZyByZWJvb3RfbW9kZSwgdm9pZCAqY21kKSB7DQo+ID4+ICsJc3Ry
dWN0IHRwczY1MjE5ICp0cHM7DQo+ID4+ICsNCj4gPj4gKwl0cHMgPSBjb250YWluZXJfb2YodGhp
cywgc3RydWN0IHRwczY1MjE5LCBuYik7DQo+ID4+ICsJaWYgKCF0cHMpIHsNCj4gPj4gKwkJcHJf
ZXJyKCJ0cHM2NTIxOTogUmVzdGFydGluZyBmYWlsZWQgYmVjYXVzZSB0aGUgcG9pbnRlciB0bw0K
PiA+PiB0cHM2NTIxOSBpcyBpbnZhbGlkXG4iKTsNCj4gPiBXaHkgbm90IGRldl9lcnJvcj8NCj4g
QmVjYXVzZSBJIGNhbid0IGdldCBjb3JyZWN0IGRldmljZSB0aGVuOiBpZiAhdHBzLCBJIGNhbid0
IGdldCB0cHMtPmRldg0KPiBUaGVuIGNhbid0IHJlZmVyZW5jZSBkZXZpY2UgaW4gZGV2X2Vycm9y
LiBEbyB5b3UgaGF2ZSBhIGJldHRlcg0KPiBzdWdnZXN0aW9uIHRoYW4gdGhpcyBwcl9lcnI/DQoN
CkhvdyBjb250YWluZXJfb2YgY2FuIGZhaWw/DQoNCkNoZWVycywNCkJpanUNCg==
