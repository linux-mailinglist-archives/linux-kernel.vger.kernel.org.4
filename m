Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC45D65D782
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 16:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239702AbjADPrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 10:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239777AbjADPrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 10:47:00 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2139.outbound.protection.outlook.com [40.107.113.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E2719C30;
        Wed,  4 Jan 2023 07:46:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6OzleH8qbDWYfI6x9p1yWo7/YNzPUc6sxGSBNQEbniw4kX6rZcuQNKahE3idIxB33r54vjeBUZKUqpLBihoBV2siJjIXunHmDO9cRvNeyLDYr2e5Vdp+uAgUwjGXyT+Sun9HnILIxUeRouposLn7t+U1jnM9H3Qtxgfun8ulCqU8LQ/iheeXW5bs0R6vrUdqo7N39pXIOV9d9v+wskZQUq2WFA+OH1Hbw1TKG9BMZGl7bpWM2+xRn5n9hFnH52dfmFP+TG7LNQjkfxPiLmfwZLSnm5Thg9q3yDdR+bl0/ArKnN6xlxbgMJTlvPJyeMMaAtGcmYZWObJ21K5De6nRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1LKIDZh2XpSwqSPPZOV6oJEgE4EEKHaNWtY4yZ/3aA=;
 b=f6cBuVF0dOw3lGhtk4Y8e1PdY4BNY7WzTrkOT/BghI2rtJymL+2ao1u7/D0F2oo9l35yoMyuFU6t5Mc50+pt89t/hEFcEItyGuaiXy0Nxcn4/uBErqkgBo/WYnvtwO5BGl2isE+a5vB42YiG765ELHQf77mTi24spF8BdwbyoLRBfET+nrNZlivvS+ZGWXJzVS0hWjGRpN68frmezLtMYGAmYHAmFKe+3S8wZEA7Whq3CcW+zTZFOjNMW4H8Nh2UbpXQ6SxWxZ7R+eSCFUsMHiLHEBgBQizfK3pnj7Mbr/aBNl4osOu38+k8KE20Cc9hMiiafosbYBvZ/SWp+D+a/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1LKIDZh2XpSwqSPPZOV6oJEgE4EEKHaNWtY4yZ/3aA=;
 b=eRiNg+TyCr4YklkEofKpeLoXI+mMeNskHhBhj/Wp7yx1j5jXKjeaa439UY8PzCPzNfEP1sxVmmGk7cjBsM0lVGWK2gPYRxsiAj6WJAtQNBYHUV13lfWtWhj0Downgo8mwy0FckUFM9yM8UnZyq1pbjdmSnS5Ds6jReaNV6YOYoo=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by OSZPR01MB8799.jpnprd01.prod.outlook.com (2603:1096:604:15b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 15:46:56 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e%3]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 15:46:56 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Lee Jones <lee@kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: RE: [PATCH v2 2/4] mfd: Add RZ/V2M PWC core driver
Thread-Topic: [PATCH v2 2/4] mfd: Add RZ/V2M PWC core driver
Thread-Index: AQHZFYCNlCsLkG/3E0Cexn6vTGGaoK6McgmAgAAOnPCAADi/AIAAI8DggAGLH4CAAA0MIA==
Date:   Wed, 4 Jan 2023 15:46:56 +0000
Message-ID: <TYWPR01MB877591E80CE112429DE3FC9BC2F59@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20221221210917.458537-1-fabrizio.castro.jz@renesas.com>
 <20221221210917.458537-3-fabrizio.castro.jz@renesas.com>
 <CAMuHMdXDwEUzBpG+w_G6=CzKo=n92cdVw6v8JwOwf9o86HnOZQ@mail.gmail.com>
 <TYWPR01MB87758FB15ED12D396AE738DDC2F49@TYWPR01MB8775.jpnprd01.prod.outlook.com>
 <Y7Qk/EgOI9mkJIjn@google.com>
 <TYWPR01MB87753C261831519F4D6788E5C2F49@TYWPR01MB8775.jpnprd01.prod.outlook.com>
 <Y7WObZFfsCJuMdLW@google.com>
In-Reply-To: <Y7WObZFfsCJuMdLW@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|OSZPR01MB8799:EE_
x-ms-office365-filtering-correlation-id: c4f470f8-47fe-4369-21b5-08daee6ae8c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3kYTmDq1yaRsgRdTAHiuK15nbrv6D0KUkyv+ReOc2WuR8wYuWhg3Wk2S1ws1niryBlIrpe0q/tzyp94ORw4P21ZnDx6IzfNMQLNeGs8Pj00tGZRmXH48Km8eG2HPlj2cq5O1kbL2qehSmS9w1gYflHCS1yv781M57UenDR0EediSoLNeMXGgNd+ku4J75MS30G8Rp3bUbe1rMwj74ArnudGQidUz20Gm8YG5l+6p6/EzL8F+PQla4cq1MpNzCEXbpnueQUv+qh1FzmPAuuPFQQh04+RxTRrt/l4gi2nXgQMSlEu2Pj04nw5eYNY0iNv7dMSQYk0Ie1dNOTwM18JhUNGXJyaTSv7KygB5uqlUs4FWHkQcV2V+z9A/XubQtfLI5T8nyPIAHpK7PSPefsvvKbB8ryJlD3q5twfxFYDvjmTfcXJO3/dH8vrw9dR+DYwTQUSLeKi6555DvSwuL3eTg9e+GcQ1otw4vGiUIX/TWo3uydghSzigLIqGD8XBXmp+qb2jkC6yjlnPpUBhrekIONV3fUiW0821wi3cwCXuCJnzqeQ41Aw3GKFPfnMruf/qDESY+hSdr4GsAe9TvmPCstK+LNwv1ewuYEBWGE63vJCK8DM6SuqfHYcPGTOZQCIujPQlJ9DZXy/txxfba0g8Oj7uV0tkyYbOySPmOVKVKQcVROQyy+LD0mXvHeSWuZnlh4x/a33yocVLSF3Y4qgHJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199015)(5660300002)(2906002)(7416002)(8936002)(8676002)(4326008)(41300700001)(66556008)(54906003)(316002)(66946007)(76116006)(64756008)(6916009)(66446008)(71200400001)(478600001)(66476007)(52536014)(6506007)(26005)(186003)(9686003)(7696005)(33656002)(55016003)(83380400001)(122000001)(38100700002)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0w1UlNmY0FwcW1mNnM2ZHVkell1d1pxc3dwUEdDQlJqMi9NTnpURWg3ekhk?=
 =?utf-8?B?MGMwVTEzWnpEUG4zOC9XS2p3TW4vY3FpcjZuRDZVMko5V0trK2pyaWVpYzlT?=
 =?utf-8?B?elEvVXZ2VzFSdGh4K2NSZ3RmVndYNzN1Q3p6ZXloaWorVWNQSHJEZ1JSRHA5?=
 =?utf-8?B?Yld4M0s5Q3ZpazRaOVNqN2kvdGFvTHh6N1l6eW5iV0tMbi95WUFlTDE5eGRR?=
 =?utf-8?B?K1BMWndURlR6b0dNWjgvTXc4dUFkQnQ4OWZiNTVzY0hPR2ZyWUhWNkVsVGZY?=
 =?utf-8?B?Mjk2WDdhVG5VSmpJKzdaZGF2Qm5Qcm5MZ0l0dWxrcnN4U2w1Q3lRZEZ0NVZj?=
 =?utf-8?B?bWpMbW9CUHk0eEJOeXJXNFA3aFkxR1MvUkRaSDEvVWxBUGpkZFJVU29ZL0I4?=
 =?utf-8?B?WU9RMmFlRmRKUDcvS1FVVTdUTExpV0ljVE9sUGcxNXVEYUFXK01Ld3FRMk9t?=
 =?utf-8?B?VEtaYk5KQXFXT1pKbFRyMmRXaWY1Y1lFSGRvT0pvbnQ1MU9oQ3ptekpZc0c0?=
 =?utf-8?B?a1BydlZKTHB2TXJ3UGdsMXlXek9CQ0lpc2dncS8vTURBZDQ1Ny83TFgvRGpp?=
 =?utf-8?B?SDZSc1BIcWhwZC9GRmVzWWQ4SE1KakZUZmNuMm50UGhjNTNLTVdkdVFyODc1?=
 =?utf-8?B?QS81SkkxRzg2S3lHdnYzTy9pRmhPWFh1V0NFNWRVZkUrNTAxVnZhdzltRm9E?=
 =?utf-8?B?c25hWW9UQ0RxNks1b0E4VVBzZW1yVlczRnFVQkIzL2Z6K1BFeFJsQyt3MFAr?=
 =?utf-8?B?N2RHa2JZaVRXYkdpb1MwZjVtZGl5MFVkY0xqWWozcEU5QnhuWkVaZ243dmJT?=
 =?utf-8?B?QkovYjg1aUlFLzBCczBxZk5KT0QvSUxMUGFUeTFYRnlvbjdQWExTN1RBTnYv?=
 =?utf-8?B?bEtTbVdPZ1M5VnUxM1dPSi9IVmRKQktlNm02YWJBbDR4MVRiNHdPZW50ZVFt?=
 =?utf-8?B?ZnhmaG55SEFzSmVTUGFabENTL2FuRjE2OVIySlZwdlR5MFl6S3B5SEE3cnhh?=
 =?utf-8?B?ZnpTTWlzR1B1ZVVHSklIZktONzFxcmNsalh5bWRjTm1SOVppSU9SZ1hnSDhS?=
 =?utf-8?B?cHBFTDJsU3I4TkZDUjYzOTdmVW5qZ005clJScHY4bFVOMjluVlZUeHAzY0lF?=
 =?utf-8?B?U3VvV011c2JDVnlicUVDR1p3SVR4dE5UN0lWNE1rMW1tRkhOOTNRVDdGSjVV?=
 =?utf-8?B?dzlqTUFheHhGUWFSSjhSdW81UmpqOG9ZclNkamlsL1JMMHJpZURuNXdYd3hE?=
 =?utf-8?B?ZmovZWQ1M1AwNmlNdjlSM1lwMi9sdENJVXF2eURBQmJWZkYxc1hHVi96a04v?=
 =?utf-8?B?TGR4OXJMQWt1RENNWGE3U0NDdmV2YlZNN3BGVGZFaG82eWtlR2R4Z1Zxc0hE?=
 =?utf-8?B?bE9RajlLMjdhOTFyc25kSWJ6aytWbUhPTW1vcUo4ZWFrV1hPU3dJOERYQWJY?=
 =?utf-8?B?ajdLZEdYbmlFd0pSUnY0RlY3Sk8wUG5ReHpURENncVBNZUtIMzNyTzMyWWxQ?=
 =?utf-8?B?dmdTUmJKWVlyMnZ6QzhIWEIvSmNDVlFZRWlTVG0yYkZJb3kvMmk4V2U0UTdm?=
 =?utf-8?B?ZTNVMGIrbWxZZm5vdXFjZEwyaFFVT2IwR3B6VlZ1SHBUaHpSVTRZcGhEYm1C?=
 =?utf-8?B?bjNvUnYvNXJCRlFiSy8xT1dZT1FMU0psWHhmSHRYVU9OckNrSXpyaWFtTGRw?=
 =?utf-8?B?c3ZydFhpa0VFYWduK1VKRGRjM2lhWXF4Y0JDOGdpWVpiRFUwMnY1bmt5aTJJ?=
 =?utf-8?B?R2JDQmhKQTZLL3VSQ3JnOURaS29naXBqQmtJdk0wc0FNNlppUWN0Ty9Kb1VF?=
 =?utf-8?B?V3IyTmZ5R0NuOVA4eTJ3Qm4wNHJUUGMvL3c0djZJTWtQU3BzbFovRm0zRmZD?=
 =?utf-8?B?dExDS3VtbDU4cisxaFF1eGNYYnorSkVuTm1uWWVRcmtMQVFWeUE0ZG5Tb3lD?=
 =?utf-8?B?Nko4Q2pHWjFQUnV2YXNmMmJZam92UEw0Q1ZQa2swMC8rKzVGaE5sLzFXV3NL?=
 =?utf-8?B?cmFra2N5WHZRZlJtT1lzSmhXb05RWktwMC9ySjlaTURha1ZyYUtpR2lNLzJk?=
 =?utf-8?B?bXV3SXBsdE1MQjlOb1FaL1VmbWhISjB2WG9uZGlrOU5RK0Zvb2JDMEtPYTJz?=
 =?utf-8?B?WnRWYWNHa0Zqa1JjTjF3ZHRwMlN4ZXlWYnZveS9EZFNtVmZWbHUvQnVOTk13?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f470f8-47fe-4369-21b5-08daee6ae8c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2023 15:46:56.4883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BEIjnfKI+3tuLXuOWj0tdYHWHjv3ulqzCriXxKWM6KKe2tE+gvBpCGv1oZKson7lg1N6PuQBhjepvNbB774sN5B6ksppHY6pcx0beX6JzoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8799
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGVlLA0KDQpUaGFua3MgZm9yIHlvdXIgcmVwbHkuDQoNCj4gDQo+IE9uIFR1ZSwgMDMgSmFu
IDIwMjMsIEZhYnJpemlvIENhc3RybyB3cm90ZToNCj4gDQo+ID4gSGkgTGVlcywNCj4gPg0KPiA+
IFRoYW5rcyBmb3IgeW91ciBmZWVkYmFjayENCj4gPg0KPiBDb3VsZCB5b3UgcGxlYXNlIHRlbGwg
eW91ciBtYWlsZXIgdG8gcmVtb3ZlIG1haWwgaGVhZGVycyBmcm9tIHRoZSBib2R5DQo+IHBsZWFz
ZS4NCg0KSSB3aXNoIG15IG1haWxlciBjb3VsZCB0aGF0IGF1dG9tYXRpY2FsbHkuIEkgbmVlZCB0
byByZW1lbWJlciB0byBtYW51YWxseQ0KcmVtb3ZlIGl0LCBhbmQgc29tZXRpbWVzIEkgZm9yZ2V0
LCBzYWRseS4NCg0KPiA+ID4NCj4gPiA+IENvdWxkIHlvdSBib3RoIGVsYWJvcmF0ZSBmdXJ0aGVy
IHBsZWFzZT8NCj4gPg0KPiA+IEkgaGF2ZSBub3RoaW5nIGFnYWluc3QgTUZEDQo+IA0KPiBPa2F5
LCBqdXN0IGNoZWNraW5nLiAgSSdsbCB3aXRoZHJhdyBteSBuZXh0IGNvbW1hbmQgdGhlbi4gOikN
Cj4gDQo+ICQgcm0gLXJmIGRyaXZlcnMvbWZkDQoNCjopDQoNCj4gDQo+ID4gPiBJZiB5b3UgZG8g
bm90IGhhdmUgYW55IHJlc291cmNlcyB0byBzaGFyZSwgeW91IGNhbiBzaW1wbHkgcmVnaXN0ZXIN
Cj4gZWFjaA0KPiA+ID4gb2YgdGhlIGRldmljZXMgdmlhIERldmljZSBUcmVlLiAgSSBkbyBub3Qg
c2VlIGEgdmFsaWQgcmVhc29uIHRvIGZvcmNlDQo+IGENCj4gPiA+IHBhcmVudCAvIGNoaWxkIHJl
bGF0aW9uc2hpcCBmb3IgeW91ciB1c2UtY2FzZS4NCj4gPg0KPiA+IFRoZXJlIHdvdWxkIHByb2Jh
Ymx5IGJlIG92ZXJsYXBwaW5nIG9uIHRoZSBzYW1lIG1lbW9yeSByZWdpb24sIHdoaWNoDQo+IHdv
dWxkDQo+ID4gbGVhZCB0byBpb3JlbWFwcGluZyB0aGUgc2FtZSByZWdpb24gbXVsdGlwbGUgdGlt
ZXMsIHdoaWNoIGlzIHNvbWV0aGluZw0KPiA+IEkgd291bGQgcHJlZmVyIHRvIGF2b2lkIGlmIHBv
c3NpYmxlLg0KPiANCj4gT2theSwgc28geW91ICpkbyogaGF2ZSBzaGFyZWQgcmVzb3VyY2VzLg0K
PiANCj4gSW4gd2hpY2ggY2FzZSwgd2h5IGlzIHNpbXBsZS1tZmQgbm90IHdvcmtpbmcgZm9yIHlv
dT8NCg0KVGhlIGNvcnJlc3BvbmRpbmcgZHQtYmluZGluZ3MgZ290IHJlamVjdGVkLCB1bmZvcnR1
bmF0ZWx5LiBJIGhhZCB0byBkcm9wDQpzaW1wbGUtbWZkIGFzIGEgcmVzdWx0IG9mIGRyb3BwaW5n
IHRoZSBjaGlsZHJlbiBvZiBteSBzaW1wbGUtbWZkIERUIG5vZGUuDQoNCj4gDQo+ID4gPiBNYW55
IHBlb3BsZSBhdHRlbXB0IHRvIHVzZSBNRkQgYXMgYSBkdW1waW5nIGdyb3VuZCAvIHdvcmthcm91
bmQgZm9yIGENCj4gPiA+IGJ1bmNoIG9mIHJlYXNvbnMuICBTb21lIHZhbGlkLCBvdGhlcnMgbm90
IHNvIG11Y2guDQo+ID4NCj4gPiBBcyBpdCB0dXJucyBvdXQsIGl0IGxvb2tzIGxpa2UgSSBkb24n
dCBoYXZlIHZhbGlkIHJlYXNvbnMgdG8gdXNlIE1GRCwNCj4gPiB0aGVyZWZvcmUgSSdsbCBzd2l0
Y2ggdG8gYSBzaW5nbGUsIG5vbiBNRkQsIGRyaXZlci4NCj4gPg0KPiA+IFRoYW5rIHlvdSBmb3Ig
dGFraW5nIHRoZSB0aW1lIHRvIGxvb2sgaW50byB0aGlzIHRob3VnaCEgUmVhbGx5DQo+ID4gYXBw
cmVjaWF0ZWQuDQo+IA0KPiBBbHRob3VnaCBpdCBpcyBjb25zaWRlcmVkIG9rYXkgdG8gaGF2ZSBh
IG11bHRpLXB1cnBvc2UgZHJpdmVyIGluIGFueSBvbmUNCj4gb2YgdGhlIHN1YnN5c3RlbXMsIGl0
J3Mgc29tZXRpbWVzIG5pY2VyIHRvIHNwbGl0IHRoZSB2YXJpb3VzDQo+IGZ1bmN0aW9uYWxpdHkg
dG8gYmUgbG9va2VkIGFmdGVyIChtYWludGFpbmVkKSBieSB0aGVpciByZXNwZWN0aXZlDQo+IHN1
YmplY3QgbWF0dGVyIGV4cGVydHMuDQoNCkkgYW0gMTAwJSB3aXRoIHlvdS4gVGhhdCB3b3VsZCBi
ZSBteSBwcmVmZXJlbmNlLCB0b28uDQoNCj4gWW91IGhhdmUgdG8gZG8gd2hhdCdzIHJpZ2h0IGlu
IGFueSBnaXZlbg0KPiBzaXR1YXRpb24uDQo+IA0KPiBVbHRpbWF0ZWx5IGl0J3MgYSBjYWxsIHlv
dSBuZWVkIHRvIG1ha2Ugd2l0aCB0aGUgbWFpbnRhaW5lcihzKS4NCg0KWWVhaCwgdGhhdCdzIHdo
eSB0aGUgY2hhbmdlIG9mIGRpcmVjdGlvbi4NCg0KVGhhbmtzLA0KRmFiDQoNCj4gDQo+IC0tDQo+
IExlZSBKb25lcyBb5p2O55C85pavXQ0K
