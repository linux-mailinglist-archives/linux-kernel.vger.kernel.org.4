Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF5F6A02BE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 07:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbjBWGUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 01:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjBWGUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 01:20:23 -0500
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2096.outbound.protection.outlook.com [40.107.135.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF9033477;
        Wed, 22 Feb 2023 22:20:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvA1SLEbQyBB8YIANCTGSiDTZdQbLTzp19FpCt9U+2q0wzYI6DplCo9UetzAY+VAHuoj2sxOxLRd3Xk3woFb1Slme2PqPq2v1SDy+8knFgMPnAUVBNYEEH6rM0IaWBQbZ1fHBgmnmUDWr6fqEx1JFNpSvucnSvp775Rohxq3nMN95C28Vy9Eqr4LPngnNZ4YztFa9t4lf0UxZOkTv1/+wN6q6ysAEcNthBHeKrDMOHDe5MZPWKKkjSiyXe0kINsoPmQU94HOkcxNMo/G8M5xJKgmVNq+XEIsVKlNZM0v9Udr/tyiZj/s8YkfuL7/SswtJRqfNzcoxCJZjE/RaQhSwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ibcR8CalYh8WulXfojVh4ts8dDA4m0Y6MI6cGGROoU=;
 b=BvWImoOc4B2STRqqs3KEW88BY5YMs0L8fhI/BzttOkSL6VaLQvbN/G2pCFugbAL72VBqXhPmJcxC8sZOWWU01Qf1tovQxvMgOYkMUCvMD4pGEiKPapxc/IM0xEGbG+77/yg7igOvJTTiy4ngpwgjWkoygL8lRo9ZdTyGvRaOAkIl7e2O88/+uIOX70yXS+T/dAECzBXX6A++6hbI27SfPWtRDbhr838lWfK5zP4C2BjLe1UZktly6EUu9txhZaLGnhG9pCt2lRCTMEJbFodfkXSmqgsnwDfY18x/w3XmsY2erz0f3r9pcc+uMkI2Zco1cgJrp/c60UPA4k3cVbvWHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ibcR8CalYh8WulXfojVh4ts8dDA4m0Y6MI6cGGROoU=;
 b=JfCD9RsFyMJbXkJiTwKaR425wiA+VOET9mqKRBF2MXk9amD0Ts5ENt/Qf1UDM15wiheNdW+xx8gp/fCLTsvwHejPbGR40SlAqCT+QIog6ufXKQqdnAT5HQDilFC28nLaoSYLgE2nUwcoasK35+XZUIvjx/d6jSwA0pJJuwWXsJU=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by BEZP281MB3032.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:24::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Thu, 23 Feb
 2023 06:20:17 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::f504:16e7:71d4:2fd8]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::f504:16e7:71d4:2fd8%6]) with mapi id 15.20.6134.021; Thu, 23 Feb 2023
 06:20:17 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Liam Beguin <liambeguin@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/6] dt-bindings: iio: light: Support ROHM BU27034
Thread-Topic: [RFC PATCH 1/6] dt-bindings: iio: light: Support ROHM BU27034
Thread-Index: AQHZRtjt+FHEeq9ZRkmPMGATWZG5bK7bUXWAgAC+owA=
Date:   Thu, 23 Feb 2023 06:20:16 +0000
Message-ID: <101db5e2-e878-b751-9679-6ea45eb24c26@fi.rohmeurope.com>
References: <cover.1677080089.git.mazziesaccount@gmail.com>
 <af211ec180d91a13862630e635019ebe03d4be31.1677080089.git.mazziesaccount@gmail.com>
 <e6b2a6f4-d710-7f74-e85d-1cd3f5b96460@linaro.org>
In-Reply-To: <e6b2a6f4-d710-7f74-e85d-1cd3f5b96460@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2454:EE_|BEZP281MB3032:EE_
x-ms-office365-filtering-correlation-id: 5c2528bd-4ff9-4531-a539-08db15660819
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O/igxVHrnt/WZ4pYbdWfqd2asunyXYWKxIHO8898UOqCInwscQy08d2UN4K7SAp+WTNRdxqcPZaDGgtD8B1VLI6ynvyzkpj2uorvHer6O76/ZQGos2RMy3pA/wRPfbtqX9OIWSIKvSmyQc2iPXOpjxwdzpA/7arzX+MXhO++VrB6XqJyHNqXEuIOVKuY2UeguIODztJv2vwJmGzouvml2s4NwfrOaXY/IqvCeOE10G7+EVkeEBBoPV5qbVB8jJhJLYSAxlWjGZvuEwrx6/gxflR6kfXo7FPqCuD0AGmok3AaRoq9L9pcLhTE4ignHOJSDy5bzC5oo8WNR9MPHep5HyEWk/4vnSxhbI5MOkPK6kxrL7Yox9fSNuUrFTvPi44vKyUDJCfOdzbBxbp+wMlcOkOrwRiYhi+DJtN/4RCLK2w602eSMkQF9jgyOng01zh+w+x3Zp0rqWwnWtw/MHEi3ZOyPjD7zMV0YBAhwHWln+60JnEZxFapXx6Y8oYVnz65P0en4Bo7H7zozKTXNeZE/NvbmOJEbb9xey7J0Rj0Da+MjsjyXXzjpql/kqTu9A8HhOUBrOPQ9JWU/jaOUl4iykYthz4ZhBxwryn5CDuxvwTutiL3xlHoBoGKKPmTs16lHnfX6dsFo6wqegk3l3kEpa2r5DNc+P/uHT2sX69pT834g82vacpYixJWKZLuTY1/LNDi9Khcf5XgxDtmHP6FZ5waSJXSngWM0RZcLrZD7ssBQooAVJNGxQQX3WTVFPaQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(136003)(39850400004)(366004)(451199018)(64756008)(66446008)(66476007)(66946007)(76116006)(91956017)(66556008)(83380400001)(54906003)(110136005)(316002)(8676002)(8936002)(5660300002)(4326008)(41300700001)(6506007)(6512007)(2616005)(53546011)(186003)(478600001)(966005)(6486002)(71200400001)(38070700005)(31696002)(86362001)(2906002)(7416002)(122000001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWZJOHNHMkJnbVB0N0VGeFRuMy85SG1sTUVjaW0rSktpdGxCV2I1anZaRW9E?=
 =?utf-8?B?bGtLL3g5cDAxWDh2WmpuaHdiNVBINFpON1NpSUs4WHkzNVplREFTOURTNkoz?=
 =?utf-8?B?dmJPak5BUU8zdHJiTzl0WVUzemdnLzNuTmZpUDJqb0hPZEQ1bHZlQllmTFVp?=
 =?utf-8?B?WGNjM1BQRFRNTVJYdDRaQ3diTHU3czE5OW1veFNlc1o2ci9mN3BKWExHUVhw?=
 =?utf-8?B?eDVqSzcvU3E4V2htOWV5bmdQV1liandScDQxRm55SGpmZndJd24wWGNHRk42?=
 =?utf-8?B?ODBRM0JMS3FjZGRQSURlVVIzeUk1QU9pZllrVVdESjJzeFFmOXBpYi9WZDFj?=
 =?utf-8?B?Z3J3VjBPRTZ1VEVOdG14dm5HWVRhbjZ3UUYyeHRLREhvdGxFc2hXb0k3bEdN?=
 =?utf-8?B?WXA4V0FVcUdqZDZiQ1lRMkZQa2NmRmhDNEpBSGtSNWdMS2lLaUo0dmcrZEFU?=
 =?utf-8?B?eGoxSmhiN3FaQUI4V1h2c3g1eWVzTDFoWjNXMFd4RG96a2xZSytMc1ZGV2dR?=
 =?utf-8?B?eVBrSld4WkdSbHFOMGl5czNjcm5EL2xmZHNUR1F0U3VnUHdycjdmZVNYY0dM?=
 =?utf-8?B?dGg4cW8xWHN6ZXV4a0tXNS9NQm43ZCtSOG80cldTTm45elVpNDhMaUJHSDRI?=
 =?utf-8?B?K3VWajVhTTNyYzBTS3ZiTXRHNU81c3I0WkpmbjhpR3NyQ0owVlVhelFJOGpv?=
 =?utf-8?B?UWxYOUlkdXNXbmJpTWlUaGRuTVJHMHB6MDZYVHpsQXdaV3BjZCtlRW1xV3Fs?=
 =?utf-8?B?UHo4MjJDWDJzV2NZQmtnZTE5T01xeDFTYWlJRDg4KzhxNEhoRkRqa1hzdTY3?=
 =?utf-8?B?dTBQSXBBSHoxQVVVSW1PSzFiVnNvbEhUV1BKbDVlYUFFWU5SaFVPc1lQMjZF?=
 =?utf-8?B?VVlLL0oyQk56d3lNRzNka0xZN08zR253OUVLTkZFZW1XWUJlMUFGOUgvYVdl?=
 =?utf-8?B?TUV4ZzBhWERnZW51Y0xybm9ONzY5anh0Z2o2dGo3Mk5EWnQxTkJUTDRMdTBV?=
 =?utf-8?B?VXppSCt4SmsxWVByMXNhc3UrR3AvOUtINCsrbGxuVXptK3EwaTFVVnJHcW04?=
 =?utf-8?B?cDUyS2RKVnZQMVQxNTAvOEhzN0FGMVlHRDJQUFp2ME9Ld1pPWEJWUDkrQVU5?=
 =?utf-8?B?OFhXTEMrZHFFMlFkZW94Sm5iTE9UcEV3U3lRNEpDMWFrZFFtekJpekM3YkRO?=
 =?utf-8?B?OHAwV1FvVUNzQ3lyMElLd2IvKzJaNUZtbjVvNUhTS2RwdjlwUW9kR1loSnY3?=
 =?utf-8?B?ZjlRaEhsZTlRUEt6dVpnZ0paVnVnOENzQ1VKWEN6RkRMSUNVbVNaQXVyUDlK?=
 =?utf-8?B?TjZGemlqdjl4NkVwNGFISTZidXlTSXJ5cGgydVpORkVNWU8rQVBaZ2ErcXVG?=
 =?utf-8?B?SmR6cnd5dEFyQWlqbmlzckNwTzhTdXI1QmRaOU0yVXUyQVdZOG8zd3prUUYw?=
 =?utf-8?B?ajIxY2FSd2xVK3krMlVSNXNFU1hLL3IrNjZDcW9tMHVpL3NDYmJLS2pTd3NI?=
 =?utf-8?B?QmtiOWVaZnJ5b1YyT0NXUEVFZWFhWXI2L3NBTkdKUjJTSG96UVg2T2c5TWRr?=
 =?utf-8?B?UEJKaGNrRnh1R2ZwUEFaSStRSEZuMTNqcit2SHBYYkRSUXhDRW9Uamw5TmxK?=
 =?utf-8?B?Ty90RGdhM2ZqTGY0R1NpWXZVMUJCRjNJbHN4OWluWEE3bTJPNVFUVVJYVVJu?=
 =?utf-8?B?TGlOby9wVWQ3NDlDSkJTR1lYZFVnQnJhOEVaTWl3WVE0TDNXM1lGc3hHUHRo?=
 =?utf-8?B?OTZhYm1BSXBQa25IM01UZDBYOExyY0RUbFd2dkQ1aXEzUzZZc3VENFhMSUI1?=
 =?utf-8?B?c1V0ZEtSUHpqRnNqYUZMY0M3Wms2L1NONFpSSVJzVkQ2bldERk1RdWtGWWxS?=
 =?utf-8?B?enN1blhjQW1EQlc4NDRyaUp4OWlNRXEvNkthL1dTTElOTTB2UUtYR210S0tG?=
 =?utf-8?B?REhBNlpaR0hoOWNGMHZodWhCb0lZbVJId3FWVjFMWnpPb2ZpSWJLU1NlT2xq?=
 =?utf-8?B?bGpFMFVaR1dtVCttYjRVMWppTmNZSWc1V1pMMVdlcytCNVd6RTl4R0FCeVB0?=
 =?utf-8?B?Y2tWbk91V09MUURsVDFicWJEVXlMOERHcXpxa25ROXc2SFN0VmJOaGk5WHdK?=
 =?utf-8?B?TUVQREovK0JqSHowNlZOZ1NpaXJ3d2RZRHFGUVIwWTBkK1FuMHNiQ0ZmbHh4?=
 =?utf-8?Q?tdIZCL+ZOMbD7fbX5xXrpX8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E591B3FACC118B45BBF9E5E7B2327B21@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2528bd-4ff9-4531-a539-08db15660819
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 06:20:16.9491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s8Atz29C60p43tC9rF8MGoioVLbGslE8eheO8wQmWl6tjbSlle6dlWnU1ITXShfepFuj+O3QlnA3qPllPnSZPKeJ5F1uVfYEdJ0lZHFITUYcJ6DV5hyUsIF87if6ZquS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB3032
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgZGVlIEhvIEtyenlzenRvZiwNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3ISBJdCdzIG5pY2Ug
eW91IGhhZCB0aGUgdGltZSB0byB0YWtlIGEgbG9vayBvbiBSRkMgOikNCg0KT24gMi8yMi8yMyAy
MDo1NywgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gMjIvMDIvMjAyMyAxNzoxNCwg
TWF0dGkgVmFpdHRpbmVuIHdyb3RlOg0KPj4gUk9ITSBCVTI3MDM0IGlzIGFuIGFtYmllbnQgbGln
aHQgc2Vzbm9yIHdpdGggMyBjaGFubmVscyBhbmQgMyBwaG90byBkaW9kZXMNCj4+IGNhcGFibGUg
b2YgZGV0ZWN0aW5nIGEgdmVyeSB3aWRlIHJhbmdlIG9mIGlsbHVtaW5hbmNlLiBUeXBpY2FsIGFw
cGxpY2F0aW9uDQo+PiBpcyBhZGp1c3RpbmcgTENEIGFuZCBiYWNrbGlnaHQgcG93ZXIgb2YgVFZz
IGFuZCBtb2JpbGUgcGhvbmVzLg0KPj4NCj4+IEFkZCBpbml0aWFsIGR0LWJpbmRpbmdzLg0KPiAN
Cj4gRHJpdmVyIGNhbiBiZSAiaW5pdGlhbCIsIGJ1dCBiaW5kaW5ncyBiZXR0ZXIgdG8gYmUgY2xv
c2VyIHRvIGNvbXBsZXRlLA0KPiBldmVuIGlmIG5vdCB1c2VkIGJ5IHRoZSBkcml2ZXIgY3VycmVu
dGx5Lg0KDQpPdXQgb2YgdGhlIGN1cmlvc2l0eSAtIHdoeSBpcyB0aGF0PyAoUGxlYXNlLCBkb24n
dCB0YWtlIG1lIHdyb25nLCBJIGFtIA0Kbm90IHRyeWluZyB0byBhcmd1ZSBhZ2FpbnN0IHRoaXMg
LSBqdXN0IGxlYXJuIHRoZSByZWFzb24gYmVoaW5kKS4gSSANCmNhbid0IGltbWVkaWF0ZWx5IHNl
ZSB0aGUgaGFybSBjYXVzZWQgYnkgYWRkaW5nIG5ldyBwcm9wZXJ0aWVzIGxhdGVyIA0Kd2hlbiB3
ZSBsZWFybiBtb3JlIG9mIGhhcmR3YXJlLiAoYW5kIG5vLCBJIGRvbid0IGV4cGVjdCB0aGlzIHNp
bXBsZSBJQyANCnRvIGdhaW4gYXQgbGVhc3QgbWFueSBwcm9wZXJ0aWVzKS4NCg0KPj4gU2lnbmVk
LW9mZi1ieTogTWF0dGkgVmFpdHRpbmVuIDxtYXp6aWVzYWNjb3VudEBnbWFpbC5jb20+DQo+PiAt
LS0NCj4+ICAgLi4uL2JpbmRpbmdzL2lpby9saWdodC9yb2htLWJ1MjcwMzQueWFtbCAgICAgIHwg
NDYgKysrKysrKysrKysrKysrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNDYgaW5zZXJ0aW9u
cygrKQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2lpby9saWdodC9yb2htLWJ1MjcwMzQueWFtbA0KPj4NCj4+IGRpZmYgLS1naXQgYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2xpZ2h0L3JvaG0tYnUyNzAzNC55
YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9saWdodC9yb2htLWJ1
MjcwMzQueWFtbA0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAw
MC4uYTNhNjQyYzI1OWU4DQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2xpZ2h0L3JvaG0tYnUyNzAzNC55YW1sDQo+IA0KPiAN
Cj4gQ29tbWEgYXMgYSBzZXBhcmF0b3IsIHNvOg0KPiByb2htLGJ1MjcwMzQueWFtbA0KDQpPaCwg
eWVzLiBTbyBpdCBzZWVtcy4NCg0KU3RyYW5nZSwgSSBjb3VsZCBoYXZlIHN3b3JuIEkgdXNlZCBo
eXBoZW4gaW4gYmluZGluZyBmaWxlIG5hbWVzIA0KcHJldmlvdXNseSBhbHRob3VnaCB0aGUgY29t
bWEgaGFzIGJlZW4gdXNlZCBpbiB0aGUgY29tcGF0aWJsZS4gSSBoYWQgdG8gDQpnbyBiYWNrIGlu
IHRpbWUgKGxvcmUsa2VybmVsLm9yZykgdG8gY2hlY2sgbXkgZWFybGllciBzdWJtaXNzaW9ucy4g
V2VsbCwgDQpteSBtaW5kIHNlZW1zIHRvIGJlIHBsYXlpbmcgdHJpY2tzIG9uIG1lIEBfQC4gSSds
bCBmaXggdGhpcyBiZWZvcmUgDQpzZW5kaW5nIG91dCBub24gUkZDIHNlcmllcyA6KQ0KDQpHb29k
IGNhdGNoIChhcyBhbHdheXMpISBUaGFua3MhDQoNCj4+IEBAIC0wLDAgKzEsNDYgQEANCj4+ICsj
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMCBPUiBCU0QtMi1DbGF1c2UpDQo+PiAr
JVlBTUwgMS4yDQo+PiArLS0tDQo+PiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1h
cy9paW8vbGlnaHQvcm9obS1idTI3MDM0LnlhbWwjDQo+IA0KPiBXaXRoIGZpbGVuYW1lIGFuZCAk
aWQgZml4Og0KPiANCj4gUmV2aWV3ZWQtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRv
Zi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlz
enRvZg0KPiANCg0KLS0gDQpNYXR0aSBWYWl0dGluZW4NCkxpbnV4IGtlcm5lbCBkZXZlbG9wZXIg
YXQgUk9ITSBTZW1pY29uZHVjdG9ycw0KT3VsdSBGaW5sYW5kDQoNCn5+IFdoZW4gdGhpbmdzIGdv
IHV0dGVybHkgd3JvbmcgdmltIHVzZXJzIGNhbiBhbHdheXMgdHlwZSA6aGVscCEgfn4NCg0K
