Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A138874853B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjGENmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjGENmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:42:08 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2080.outbound.protection.outlook.com [40.107.15.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113469F;
        Wed,  5 Jul 2023 06:42:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4S38UltzVC39Jrwgyw5z29wzfIOiwLNf9/+cmX+CDVIcWWAcQX0yo5XZT69nS1Cnj26IvMJjIxEMQ/F7+M6SChMIhWiHhSpMogtny6NqB9ylMXVtEsJpAOmHUFuHEjJHDfci5x6JbJ+CzDqo7fgzZw9lAXZbZkOfbKLkkRfN5XmNBD8aRgstVLkvZZ2YI+/XdN0Q+oO3E3MhAfmVXnCjPgkz44NRTph9qQn9Hz55jtTU1WPJ+ou+tGIonNZUvENU3fFJWAP/1Avd82g2j/cSNwdffjEdbtOUf7TUx1IrtE1domWfLlZUUoW4QSQnJT5dQHD2ZRWBA4/fkxV+dsPig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPvDwvlEsOcyQrEm1dNyubx+uNYveI7PH4SUls43v+g=;
 b=VfiWUWXEi1wNBGcXvNeiNaHl748rVKqqz6ZH34HUZvcSyuCQoXQ9oLw1lFjswpwczHDhPXsi5zEWy7PYDjQD3SNuMxnzqRZHlQZv4CjG44e5iqWaPWUz3nQ5mn6E+fgAykQJ0/0CtgrQ9wBsJeQLFVc0AB5NJm7Cu4XfglQlNl7Y2a0bAIQ82c+eHaGfUP6gdx8xeQ/78GF02Y8ARCVCb3/38tjXBrtclkZlnNvJhs9JihMRdyGZXbzXUUGL8/wiUvmXP5CuFzu/6/VxQRo1qF1z8DlEdzBiJ2BtsysKf6fpkJ6dDf2dU3V9aG4+GG7aq+3QZlSJEOAmv00ieG4bFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=variscite.com; dmarc=pass action=none
 header.from=variscite.com; dkim=pass header.d=variscite.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=variscite.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPvDwvlEsOcyQrEm1dNyubx+uNYveI7PH4SUls43v+g=;
 b=QylPDi93KVd+gb//rD7VAj+Unx7lvhsLnUwfy+Fbwq2s+PPT4tFjswfZ9ckSa4bryLF0Y2EjvygVxtGaYcuMVO8ptvmwLDkwR0itN6yR1Du1Zuqig5r885i5pgC0H+VKVthUJlrHORhgC7otuImfOhfJYIBVNflkwzNMgiOK/hBKjG/jz82+OAhyw3zhsOdgviHySgMuZhjeCJSKnBSKV51Ob88kt48tcCemrscLgyPz6m7yT24jZmPi6P3LNsIPkLFx/4cbpMZpFzdtMxpBCy5OQBgPI0jqvrqgh3rqVJJtU4uMwcPXO4/kGeBZUu4G6dgzj5LvuRLW3Rj8iBIb3A==
Received: from AS2PR08MB8808.eurprd08.prod.outlook.com (2603:10a6:20b:5f4::14)
 by PAVPR08MB9401.eurprd08.prod.outlook.com (2603:10a6:102:302::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 13:42:03 +0000
Received: from AS2PR08MB8808.eurprd08.prod.outlook.com
 ([fe80::88d8:ddec:561b:c061]) by AS2PR08MB8808.eurprd08.prod.outlook.com
 ([fe80::88d8:ddec:561b:c061%6]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 13:42:03 +0000
From:   Nate Drude <Nate.D@variscite.com>
To:     Hugo Villeneuve <hugo@hugovil.com>,
        Fabio Estevam <festevam@gmail.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pierluigi Passaro <pierluigi.p@variscite.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: imx8mn-var-som-symphony: fix USB OTG
Thread-Topic: [PATCH] arm64: dts: imx8mn-var-som-symphony: fix USB OTG
Thread-Index: AQHZrpVBPm+/gN/VEkSHlntmlBO4DK+p05CAgAAByACAABF6gIAAK+EAgAAF7oCAAAcGgIAABiQAgAATnoCAAPRygIAAAK3A
Date:   Wed, 5 Jul 2023 13:42:03 +0000
Message-ID: <AS2PR08MB88082608DB46EC1287C6E54B852FA@AS2PR08MB8808.eurprd08.prod.outlook.com>
References: <20230704150240.2022020-1-hugo@hugovil.com>
        <1341ba38-35c1-1657-aed4-a3c11f584367@linaro.org>
        <20230704113124.f2830afe1d9df252afe5abdc@hugovil.com>
        <834a0679-7e0c-150f-68be-c75d7dac0bc8@linaro.org>
        <CAOMZO5CX8WzaNeHmE8ohT2_6F-ehRRNWGnF7Dji=uLGphY4q2A@mail.gmail.com>
        <20230704125541.f361cab8de3faacd830418ab@hugovil.com>
        <20230704130204.7ac64cbd76b3440fc351c373@hugovil.com>
        <CAOMZO5Dsp7YZfmpkBNsQgE4d3Ag-v2fpBAU=aZ9NGqGYoaOMWQ@mail.gmail.com>
        <20230704164140.824f6890dae5c87fc92531b4@hugovil.com>
        <CAOMZO5BNaQVMKbxU9rc5zOBwv9c+HayLnkjqrSgPKgMGzQ585A@mail.gmail.com>
        <20230704172801.f11422b3f947c625f53af871@hugovil.com>
        <CAOMZO5CWh0-5eMTBwjvNUrY-yOHE=daj6n-jAAfjWoV-H4rt0Q@mail.gmail.com>
        <CAOMZO5AZiuEAh6nJB8Oub83At6bsvLhzOhsT_yOniZSucrAUMQ@mail.gmail.com>
 <20230705093507.7458eada3ae05e0e1740a10e@hugovil.com>
In-Reply-To: <20230705093507.7458eada3ae05e0e1740a10e@hugovil.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=variscite.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR08MB8808:EE_|PAVPR08MB9401:EE_
x-ms-office365-filtering-correlation-id: d88e368d-6470-4cc9-8bfe-08db7d5d9dc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /CuU23ZKlz42+Fscx+qgMBbyPAVZwiyBtxDL2vVwxlGwUX18PGML9UwGkFHVljiZsvBfGf/cFxUORisac0R0A/gnIh8Djh7lHmOLRxXWHtiNH4hnOaE260YjyirbgPMVGBBuCKPO7xFUIZK5ifeo/oWqx+an3xaTGDSKUbZxXU2SpL/auGLo2i4oOy83vJ6VTaI69OQ5wH+WG7638ruuYSxjnoe0waIaZOP9t+a4v1eLQkTHe4CqZu+A0tEKXlhHLscUOnfD8eTJY3EgFqrrT6i6tYnMibLPcsClXRsFXqCQR+P2DhNATi2QXRTr0RmGDJA+/k/r3z+PjjwLjSiS2VkjmP92PULke2yzRBvRuQgrqyyvMk+GLCwNCELVWSMwVGATxE6bgDUCylrr3yvW0iX96yR09HXZ2Wjh8ViFHSL+UDC6h1FcXONawOHwMZG32sjoOI0ct8IA465o3QLhhIJjo4nRqJclbHwBuqlqK40ctQv93zAvl39WRDBmYoj/KSdAXVh66NCsShEZdk1u4K2175AWtrFMm6/wZdcp+4J2boT5E4ueufEe9BfLj8aQgo3rikaQ2q19F4NKAwVCcjcuFMFAfN+lK14Vkig4R5xOOrREOtDj1f8pycWzGqdf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB8808.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39850400004)(376002)(396003)(136003)(451199021)(4326008)(316002)(64756008)(86362001)(186003)(66556008)(91956017)(66946007)(76116006)(9686003)(26005)(66476007)(66446008)(6506007)(53546011)(83380400001)(966005)(122000001)(2906002)(38100700002)(33656002)(7696005)(71200400001)(5660300002)(52536014)(478600001)(8676002)(54906003)(110136005)(7416002)(38070700005)(8936002)(41300700001)(55016003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blczWUFLWG4zVGc5dzB3RlhCWnJpYzM3SXgyQjhYOXk0S24zRmlNNkhuQ1J5?=
 =?utf-8?B?QWFqQ3NmU01RdWg3NTNLSFcyTERXWkJadGZoTnNwTXJBdHdCbjdhUkRYODBq?=
 =?utf-8?B?dEJvakh4NjVIMXFPZkpEVmYxZ3RGMmtPY3pXWDN2TEJxYXRBMVZaaEgxd1Vs?=
 =?utf-8?B?c2c3dnZERzg4K3ovbUdoaVN6VDVzWC95SkxkUVFKQjFxZHJPbG40bnJOY1h3?=
 =?utf-8?B?QVk0U0dyNEZFMDhvZFpMdDN6eERRRkJnSjRJdTBCWkhGQTBlWFlHL3R6N0Q2?=
 =?utf-8?B?WStuangralBYbWxWazNmbGFNZDk1SGtVK0l6QlFTTVQwMndDQXFYNjEzWnVW?=
 =?utf-8?B?Q2ZXeWxUTW5UZHhRNmRnQ2xPakx4dzJkZDVHRVY1eXJDa095N1kydnVZNHps?=
 =?utf-8?B?STZwRng3ZkRDbUtGT2FmdzhLYm8rSkd2bjB4WjFCaS81REJIQWJBWWx2TWI4?=
 =?utf-8?B?K2U5VFpDNlFhRldEK2hGSTZJdHB5WnV6b1lDMk9aNktsNitFc05qSVgyRW40?=
 =?utf-8?B?OEhwL21TTEJuMDZrRzhqb0JYSysxWnlBOXhzeitnVEZkNURwRlpOUkhUd0My?=
 =?utf-8?B?dWhrcjdocGpIUGoxREZHaURpUEJsWmJmdytTZlNYTUtJVm44WVpSMEJ4Rk1k?=
 =?utf-8?B?RVR5ZXppQndnVmYyUlpGVVBYWFZrYkV3cFFrM0ozOHBXclMxOU9oMTg2cWdX?=
 =?utf-8?B?a01CaS9RaXFqNjlNRTU0bVJlczNZcXBmTFErRTFwMEswRnFLNmFRdkNLcWd4?=
 =?utf-8?B?WVlleFZhdDhzOENxaituQU9yWkJSanZsOE1WV2FuT1lDSkxudWJGRHQvdFBS?=
 =?utf-8?B?UmxMZjhTY3JGLzNZR0ZtSFZRdS9hckhPbWlFV2VFSGNieWJ2S0kwdkhPWVpv?=
 =?utf-8?B?NFVvWEQ3WG5vQnlyUDV6a0tRcDlsUWdKYTBNVGF3ZE4xNUdIellIeE5YR2cx?=
 =?utf-8?B?MjFNMDRlMEpBTTlUd2Z3QVNzdDArZ3R6K2hTWnlVdGtkdEcveWlSQ0Y5bnha?=
 =?utf-8?B?aXk4eldnQjJzdU1PSVB0Z28raE9UcHFWMDJhOU5pNnVHbnlUd3VEWkZHbUpJ?=
 =?utf-8?B?Z3hjSnlZdnFEdU5lSHUvVXdsSU0wUGZuY0xhVTV3UzF4WDRBOHVnKzljRzlM?=
 =?utf-8?B?VzlZRkNJVmt6anVObUErNmp2VGZtUHN2N1JSSWR5czZ4ZXdXdTBQSEl1UHBG?=
 =?utf-8?B?VnJhVDRPaHY3UVJiTTBBV2NreEdTZG9HVmh2ZzcxdE9ST1ZSK3dtZXRWU0Zu?=
 =?utf-8?B?S2h3RzM4cW5rekhHZCtEWjF2ZXJ4MHZlVGJFV00vRFJhVVBzTFhFM0N1dmFl?=
 =?utf-8?B?KzZuWUQ2NkxQbTRuY2k5Y1RVNk44UGtrUFU1Q3RzbzJWcUtqeFVVWksrUlRS?=
 =?utf-8?B?dkcwVG1tYjR3UDlPaW4rL2xKcVNZL2dkbENGMzJUOE5zejVrcjRzRUMvUXp2?=
 =?utf-8?B?VGIyVFBsdU5IU2wvcUdxY1c0dFpqWVBnYkhzaUtwUTZkeVpvanUxaDh2Y0JQ?=
 =?utf-8?B?RFBDLzdNQ0R0SVlrOVBjSVhyNkhWQnd3SERGSmZiYmFMZ1hNU3ZJZDM1NzVD?=
 =?utf-8?B?NHIyZEREMis1SzcwQ0s3T1d0dGdIUnFzcjJQTnp5dTkrUkhqb0Q3R2xKYkhs?=
 =?utf-8?B?aVVPL1Z6NUVRV1dMY09BN29GYWRkUklrYmtZb0xsaXBtdEpVN3AvWnB6aUd6?=
 =?utf-8?B?cVhXQTBmL0lxTjRrVzlUb0lRVHNySmtFT2RGem1LSDE0c1JoZ2Q1aitRVFFY?=
 =?utf-8?B?TEFsNURqSVFoVlE1aGozUmlFM3Boc1VGamJtZ0lydjNWMkYzbUdWZjNPUlQw?=
 =?utf-8?B?d2ZKNmFWaTBUblNNdnU5dXlhMlVHWWI5bm1vL09ia0xmaDkwQnEvQmRHVE1y?=
 =?utf-8?B?QmlhRVFRaHpsWFdHUTNuOG1Ka1dpaEdVZTRJMlpuTGo3Z1J6TmlxWFNQbFJj?=
 =?utf-8?B?bGRmVkppYmI2aFBpRHd1aXFFZ01mdzVrTC9zaFM4UUJsMjhKNE05aUVML3Yz?=
 =?utf-8?B?dXhESE1qamRSMis4WjA0NFd4eVdLYjR6eU52Zk5EM1FFYWY2d2RDRzRJZllv?=
 =?utf-8?B?SWxTZStLaDZhUUtwWWpLUUJtQUpnN3BEOHZBVG5TMXM0c0wzNENqZzY0bE5w?=
 =?utf-8?Q?JGbk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: variscite.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8808.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d88e368d-6470-4cc9-8bfe-08db7d5d9dc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 13:42:03.5345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 399ae6ac-38f4-4ef0-94a8-440b0ad581de
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JW2QyWjgZipAa1jQa/iH6lI9/sQhaA6KTZSKyyjojGnQqA2xVkxXStQsKuMd1cZ7Gf+Ek9jI3ZQZ77nr3p2Wow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9401
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpPbiA3LzUvMjMgODozNSBBTSwgSHVnbyBWaWxsZW5ldXZlIHdyb3RlOgo+IFtTb21lIHBlb3Bs
ZSB3aG8gcmVjZWl2ZWQgdGhpcyBtZXNzYWdlIGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIGh1
Z29AaHVnb3ZpbC5jb20uIExlYXJuIHdoeSB0aGlzIGlzIGltcG9ydGFudCBhdCBodHRwczovL2Fr
YS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQo+IAo+IE9uIFR1ZSwgNCBKdWwg
MjAyMyAyMDowMDoxMyAtMDMwMAo+IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4g
d3JvdGU6Cj4gCj4+IE9uIFR1ZSwgSnVsIDQsIDIwMjMgYXQgNjo1MOKAr1BNIEZhYmlvIEVzdGV2
YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4gd3JvdGU6Cj4+Pgo+Pj4gT24gVHVlLCBKdWwgNCwgMjAy
MyBhdCA2OjI44oCvUE0gSHVnbyBWaWxsZW5ldXZlIDxodWdvQGh1Z292aWwuY29tPiB3cm90ZToK
Pj4+Cj4+Pj4gSGkgRmFiaW8sCj4+Pj4gaXQgaXMgaW1wb3J0YW50IHRvIHJlbWVtYmVyIHRoYXQg
b24gdGhpcyBib2FyZCwgbGlrZSBJIGV4cGxhaW5lZAo+Pj4+IGJlZm9yZSwgdGhlIElOVEIgcGlu
IGlzIG5vdCBjb25uZWN0ZWQgdG8gYW55dGhpbmcuCj4+Pj4KPj4+PiBJdCBpcyBvbmx5IHRoZSBJ
RCBwaW4gKDkpIHRoYXQgaXMgY29ubmVjdGVkIHRvIHRoZSBHUElPMV8xMSBwaW4uCj4+Pgo+Pj4g
Tm93IEkgbG9va2VkIGF0IHRoZSBzY2hlbWF0aWNzIGFuZCB5b3UgYXJlIHJpZ2h0Lgo+Pj4KPj4+
IEluIHRoaXMgY2FzZSwgR1BJTzFfMTEgc2hvdWxkIG5vdCBiZSByZXByZXNlbnRlZCBhcyBpcnEg
dGhlbi4KPj4KPj4gVmFyaXNjaXRlIGFkZGVkIGFuICJpcnEtaXMtaWQtcXVpcmsiICBwcm9wZXJ0
eSBvbiB0aGVpciB0cmVlIHRvIGhhbmRsZSB0aGlzOgo+Pgo+PiBodHRwczovL2dpdGh1Yi5jb20v
dmFyaWdpdC9saW51eC1pbXgvY29tbWl0L2ZiZTZhYTJhOWMwMTRmZGIxMGIyOWE3MTVhMWJlNjk1
ZGFjNjA4MjgKPiAKPiBIaSBGYWJpbywKPiB3aGF0IGRvIHlvdSB0aGluayBvZiBWYXJpc2NpdGUn
cyBwYXRjaCwgaXMgaXQgc29tZXRoaW5nCj4gd29ydGggZG9pbmc/Cj4gCj4gQXQgbGVhc3QgdGhl
IGNvbW1lbnQgaXMgaW50ZXJlc3RpbmcgYWJvdXQgdGhlIGRpZmZlcmVudCBFVksgYm9hcmQKPiB2
ZXJzaW9uczogbWluZSBpcyB2MS42LCB3aGljaCBjb25maXJtcyB0aGUgY29ubmVjdGlvbiBvZiB0
aGUgSUQgcGluIHRvCj4gdGhlIEdQSU8xXzExIHBpbi4gVGhpcyBhbHNvIG1lYW5zIHRoYXQgb2xk
IGJvYXJkcyBoYXZlIGEgY29ubmVjdGlvbiBmcm9tCj4gdGhlIElSUSBwaW4gdG8gR1BJTzFfMTEs
IGFuZCBmb3IgdGhlc2Ugb2xkZXIgYm9hcmRzIHRoZSBEVFMgaXMgcHJvYmFibHkKPiBPayBhcyBp
dCBpcz8KPiAKPiBIb3cgY2FuIHdlIHN1cHBvcnQgYm90aCBjb25maWd1cmF0aW9ucz8KPiAKPiBI
dWdvLgo+IAo+IApUaGUgcGF0Y2ggJ2RyaXZlcnM6IGV4dGNvbjogcHRuNTE1MDogQWRkIGlycS1p
cy1pZC1xdWlyaycgcmVmZXJyZWQgdG8gYnkgRmFiaW8gaXMgcmVxdWlyZWQgZm9yIE9URyB0byB3
b3JrIGNvcnJlY3RseSBvbiBhbGwgdmVyc2lvbnMgb2YgdGhlIFN5bXBob255IGJvYXJkLgoKSSBj
YW4gc3VibWl0IHRoaXMgcGF0Y2ggbWFpbmxpbmUsIGRvIHlvdSB0aGluayBpdCB3aWxsIGJlIGFj
Y2VwdGVkIGFzIGlzPwoKVGhhbmtzLApOYXRl
