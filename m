Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D9F6A5791
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjB1LNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjB1LN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:13:29 -0500
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2110.outbound.protection.outlook.com [40.107.135.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE2A1284A;
        Tue, 28 Feb 2023 03:13:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsfRNSX4vn6ZMMy5V/CeqPffWVjRzEfrR0wJYmMMl+mTzAuA7FJdiKGCJU/BR53vUrPbQvBVwby/Y3HmOAb9nvjwflUhdPh5B8xHwsRC6BSaNGjGPloCCiueuwLUZun6C5xsIYkYQXBgAqMdpUMHQZ1BQkakpE2ZQVLr+SDVdD0bku09L1JJ0nKE17F4VBci3a8cIkzX56iPuBrLtP36fRR86JROiJ78aVas/1Mp5Ot3AOYfhgRu7gHnzzoRvPPe2u/ZdYiwMoS3wMw8tPWRl591ZiYVRjNC0ShAq4sEsFFtpjYLLLxrHTSuQwLnyGLz/2wL/bR1M1JBXIn9MRcBnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sxgHK0hBxM1zQpOeQWiQyNZsFBTI7IjUypZMlO9k/Y=;
 b=RRWU34C79/oijF0r6nGzmKdSE8YkLPmWdKGL/YHEELT5cRfEvreWij2jWgqoloPcCvE/vxHaHDO8qoOudyFo/Qumm/JknKfinNrPldlq/Ark0tl/vBuiGtw4NkbBAAWLtnZYuwWV2R4o+b1FPAXG76mo7WLDZ+z7E+NSm31U5PTv2bnjYLOG8SybUIPkHAlEWCXsKjd0AvvQ7sj6dVrM4JbxuJJ0K8LV5qSjsnBSrNlj4MP7OmQxeIki8Q6WU0bCz6ERDXYODomRZxUfWLgnFD0/vA7qjYiC02nTdV1KTzykkIUax2KUrQmFRDvTiA+Asz3OoFfMun6mshOOyeIq4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sxgHK0hBxM1zQpOeQWiQyNZsFBTI7IjUypZMlO9k/Y=;
 b=bsMtoPEU97JOhHxMAlH+8dQ7V0MrsbtynnVRK6B8xltkWiDoi3agiitn3ckhnoE8Fp/4Uz3tPQzRSN1prssl9k/dLunCxpRmW3Fn0s6UUmDpeW0N9gSa8wdlmWDG9EUpy/uUilPvhzwRBOhCRx/ZpuWedZemnDyXSN6g8D3MId4=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by FR3P281MB1551.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:6c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Tue, 28 Feb
 2023 11:13:20 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::f504:16e7:71d4:2fd8]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::f504:16e7:71d4:2fd8%6]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 11:13:20 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
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
Subject: Re: [RFC PATCH 2/6] iio: light: Add gain-time-scale helpers
Thread-Topic: [RFC PATCH 2/6] iio: light: Add gain-time-scale helpers
Thread-Index: AQHZRtjRJ2RGNNtqq0+fFiw7bitmIK7hbyAAgALOgYA=
Date:   Tue, 28 Feb 2023 11:13:20 +0000
Message-ID: <914a94ac-934b-d268-0ddf-b00681fe42f8@fi.rohmeurope.com>
References: <cover.1677080089.git.mazziesaccount@gmail.com>
 <3de52eafbf085e8f0048647a1cc01cb73842f367.1677080089.git.mazziesaccount@gmail.com>
 <20230226162142.3642f456@jic23-huawei>
In-Reply-To: <20230226162142.3642f456@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2454:EE_|FR3P281MB1551:EE_
x-ms-office365-filtering-correlation-id: 0702d8c9-f91d-4758-70ea-08db197ccc8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FRMdSRjm5S4cWQY3CqYe57XrIWWiyxH78QpLhnxWELrlatk4KzxWwg2blcRMvfWAj7PpXA1WiOkFSoLJHN0VdpoYwgZ4aowwOESFsZCWikXg0wbFwOlrY7XpmR3iyL2BxeeqDAsr14BrRwZzMlnRonH9+UAdz7KDBEs971umO5vPJnUgjuqjYVEuETMFCj6i9osV8ExkhmoYKuQDJGXEx9s104vJIL6JpkOZHwXQRhvHKNQqrVJHah+by14QAUBay6KMWs4aDq45BuKWPpJD0PbBqWwwdUTM4PRs4XT9T6AIXC0HxeIF6YZi4IZMuWX13RqUSx9eTD7XTh8c9ufdCj283HsExtfU8WwqquO1s+wX34c/NgBrrs4UQ8hBXWAJsau6VCXWJevMlzYBfVqAhkSG7l8zmbAd5ZikxS61jgd23SrwpJRP9/rUoDUg4Ry4js/r+q4iLqNBf3rwzM9X18zUbNjdTwCZ4+wzMPFRoAl1vK/rJHMSckdjnaNTT0zr/IrbnY2uvCXLjU2nY93R1cBApJ1jKcpTMTiJPslq0N8/RaJRY0RLfauu064K6HdgvExYqMdrnddImUp0BIflUomDkljxJC64psHwOv2W23eHhm6SkNT7e6vfiZRUgCP0PnwHuUY0J07b1pM1CE6zAS47P/adwv1+ETFxKDIjq99maKk2+/HI13mFc0Fyz8neNRBoiW/OIUiKoPa0xDjPUA1xj2S1e5gFbUzudeCO7vc9lqGUFGJCsnehGRmFRQ2FBZubPJDB54DxHYqjDc2FCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(376002)(366004)(39850400004)(451199018)(122000001)(38070700005)(86362001)(31696002)(38100700002)(2616005)(71200400001)(110136005)(478600001)(316002)(6486002)(54906003)(7416002)(5660300002)(66446008)(76116006)(64756008)(91956017)(66946007)(66476007)(41300700001)(2906002)(8676002)(83380400001)(8936002)(186003)(4326008)(66556008)(53546011)(6512007)(31686004)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEVpUXFJaURKL29kOGlOZGF5ejg0VFBKMUZLV1BDQkxlcnZZaWxKRTVBV25l?=
 =?utf-8?B?bHY2bXc3M3lpamNRbklaZk8wcVYvTEtlZVlyT3NJMmtBcml5VGhaNGdOczd1?=
 =?utf-8?B?dkRlR0h0aEtSZWhVY0VKSDlCSERnSlMwSFUyYVc3dm5xMEJGWlQ5OEhlVU94?=
 =?utf-8?B?OE9ydnQ4SGZBRjg5ejkvTGxFeFdPaFAzU1NlUlBySmNEbmNYaDYwblhRditn?=
 =?utf-8?B?ak5VbHk4VElUbmRBeVVtVFRmbi9zaDljVmx5Mnd5elhUdlNLTGlOR1N2YUwz?=
 =?utf-8?B?dXkxcnRieU04U0FlSmJNcElIckgvOS9uaTA3QXVhTUQ0SlNQcDc0NVFrQjFQ?=
 =?utf-8?B?Q0JFcldrQzFRWi9wOEx2NElOK2NGNVd5Q3dLVk1CaS9lVzlwYnJvNG9XVFQx?=
 =?utf-8?B?RmJoR0gzV3RZdm5XZGI5MzlrdFkxMWZHM0RRcHJhdi9aY0FBSDgva3RkQkti?=
 =?utf-8?B?TnlCelI3YmFwdzlRWTZOMFZualpySjBoVGhQUWJ3ZEVKWUxmbStqL1dKajhl?=
 =?utf-8?B?SGtPUENENVZ4dGY1RnlZdjc3Y1lPNWpoRStQMElidTFhM2RPRzh2d0xQVzdP?=
 =?utf-8?B?ZXJCVUdwRExCbzVnOVZ2bHpXWm9XL3ZCNjA0L3FpeXhDaXdrWk9aMHdxclpO?=
 =?utf-8?B?KzRHZGVEWlJ2bk9Va1p3eXJOaS8wK2htR1BEOEdhM1NLSnFvMVNlV290MWI1?=
 =?utf-8?B?aG1HOXdtUjJYcFQxSUh6cDFYd1NzdHlINlpnS3F1WityQlkrQzhGOHhCaC83?=
 =?utf-8?B?NlNZZWlNZG5SZnNuaGJIMTdKQkJpdS9SaDlUaUdDNlVCbFFiYVV4TzFsV3hS?=
 =?utf-8?B?YXM1M0cxeE5oNm9XK3JETExDanFkSkhaZk02RXNXM09HbWlTU1c3S2ExbFhx?=
 =?utf-8?B?eHZTSEtNTE1RdmVyemdaa04xUEJQa2lpOVVaZFNqclN6YVNMWFd4blR4Tk9T?=
 =?utf-8?B?Sm5UTFNab2NNSUhaQXB5ME5abFZQaUxsWkhoZTJNb20zNnpEQTNsSkZ4VklO?=
 =?utf-8?B?SFV2MzJBRkp0RUJCV1NERzZib1duYkYzUndaWXBmZElUbHM0Sk5VTGhUcFY3?=
 =?utf-8?B?b1Z1aVNBSVBENEh3bTZvUzNJUTVmNk5BMkFubVlieWQ4d0VQK1ZrRmI3SXh0?=
 =?utf-8?B?M1JRU1JnT01tQzF6aFplTW9rY1c2eTA1K3FSUGxRdlMwbkRTSWNNVEZkWHRm?=
 =?utf-8?B?UXdOYnVEQzEvSUhzV1Nvck1RMWJyUklKRTNMMzNydVdjR3lBSDlJNWxQb0Vk?=
 =?utf-8?B?UDUzRDQza0MyY0JYcGlGV0hTdWRWZ3o5cUVUcGZqcklCbGZzU2JBSWRGUVoy?=
 =?utf-8?B?dHNIdlpESTJCS1dwUUNrU0tCN1RnT1FqRlpjTHVERHJlMmFJaTMvbFhtZGJ2?=
 =?utf-8?B?MXlYYXAxaFBuUVdhc0ZLQzJTdkhnazRpdUttSW1Tc0djZnpCOWZscW53YlRS?=
 =?utf-8?B?b3VJUWY5NDUzd2pyRXhBTm1OM291dzQ2UFJFQ1ZzTGFLcHEvQnZRQ3R0MzEr?=
 =?utf-8?B?TVl6eW9CUXhseUlVOE84czBvUWdKa1VudTlPeG5wc2lEVWFuQTZOOXk5Tmlh?=
 =?utf-8?B?MmJUcjNBeW83TnlUclRhSHFxL0xwZW92T3lqZys5WW11V3hqS3BsU0ZJTGRW?=
 =?utf-8?B?RzgrcklvSXBOOUxmOVBXVUQrMythdUhxem8wbVBjZDY1WHhjbXd2dDRNOWlS?=
 =?utf-8?B?bGlra2w0TlliYktFWml5clVkNkM0MDdzYWpwVnJWbURpMnJnS05CTWJ6b3ZT?=
 =?utf-8?B?M29BaFYybDl5alBWdmVOLzRpdExxRk9wOFMwZ0pINHNlK2xuQmhEVkNQWGgw?=
 =?utf-8?B?M0gzUjFHcWhSOWNQV3A3RENVbUVWcVFla3JYZ1AyUDBRRTFKSEFQUmhlcXA1?=
 =?utf-8?B?VHlCZ0pjeVI4RmlUcW9ueDloc0paRmpMNXpEZmg5ZGx2ZTRIekNhelNTRmlG?=
 =?utf-8?B?YUdZYS9rTUo0QkVnaXRNdkdIUGx5VUhwL1JUQ2M1ZFBoK1lqRFBkcGowUHRW?=
 =?utf-8?B?QjFGZ1gyRmlPSVRyYjhYQ3BOOHMvYnhZVVlyelJsNzJXeEtPRXFKVU5iVkQ5?=
 =?utf-8?B?T3VIZ0x1MkppL0YzWDlGbnEwaHRxY3hBbm9XdjJKWG1jQWpyRHc3OElvOXNo?=
 =?utf-8?B?MDBtSXBNVUdwQzIvTWN3M3VLZzd4VGROZUxaTW91cnVabjBtL0NwMmc2UWNJ?=
 =?utf-8?Q?QJMu8WUXUk010TPPOv1gJhY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB0A6717C00BB2468CCA0DCAE0A809C1@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0702d8c9-f91d-4758-70ea-08db197ccc8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 11:13:20.1270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ijIgtScSZVtrBqRMnDlcuCp+2USJid5C/xRQn12q5oQqLCqRKX4AfeVBvBb3joTHzO4h6EWSJpzFVklE0FMDx0NcrViLtls3+6IAzo4VRrPs0mkZcH/hCEcgWZk3gPal
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB1551
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9uYXRoYW4sDQoNCkkgc3RhcnRlZCBmaXhpbmcgdGhlIGNvbW1lbnRzLiBJIHRoaW5rIEkg
aGF2ZSBqdXN0IG9uZSB0aGluZyB0byBkaXNjdXNzIDspDQoNCk9uIDIvMjYvMjMgMTg6MjEsIEpv
bmF0aGFuIENhbWVyb24gd3JvdGU6DQo+IE9uIFdlZCwgMjIgRmViIDIwMjMgMTg6MTQ6NDUgKzAy
MDANCj4gTWF0dGkgVmFpdHRpbmVuIDxtYXp6aWVzYWNjb3VudEBnbWFpbC5jb20+IHdyb3RlOg0K
PiANCj4+ICsNCj4+ICtzdGF0aWMgaW50IGlpb19ndHNfZ2V0X2dhaW4oY29uc3QgdTY0IG1heCwg
dTY0IHNjYWxlKQ0KPiANCj4gdHJpdmlhbCBidXQgc2NhbGUgZXF1YWxseSBjb25zdCBpbiBoZXJl
Lg0KDQpZZXMuIEZvciB0aGlzIGZ1bmN0aW9uIHRoYXQncyB0cnVlLiBJJ2xsIHVwZGF0ZSB0aGUg
c2lnbmF0dXJlLiBTdGlsbCwgDQp0aGUgcmVhc29uIHdoeSBtYXggaXMgbWFya2VkIGNvbnN0IGlz
IHRoYXQgdGhlIG1heCBzaG91bGQgcmVtYWluIGNvbnN0IA0KaW4gZ2VuZXJhbCwgdGhyb3VnaG91
dCB0aGUgbGlmZXRpbWUgb2YgdGhlICJoZWxwZXIgb2JqZWN0Ii4gSXQgaXMgDQpmdW5kYW1lbnRh
bGx5IGNvbnN0IHZhbHVlIHdoZXJlIGFzIHRoZSBnYWluLCBzY2FsZSBhbmQgaW50ZWdyYXRpb24g
dGltZSANCm1heSBhbGwgY2hhbmdlIG92ZXIgdGhlIGNvdXJzZS4NCg0KPiBOb3QgaW1tZWRpYXRl
bHkgb2J2aW91cyB3aGF0IHRoaXMgZnVuY3Rpb24gZG9lcyBmcm9tIG5hbWUsIHNvIGFkZA0KPiBz
b21lIGRvY3MuDQoNCkkgYWRkZWQgZG9jIChidXQgbm90IGtlcm5lbCBkb2MpIGFzIEkgaG9wZSBp
dCBoZWxwcyB0aGUgcmVhZGVycyAtIGJ1dCANCndvdWxkIGxpa2UgdG8gcG9pbnQgb3V0IHRoYXQg
dGhpcyBpcyBtZWFudCB0byBiZSBpbnRlcm5hbCBvbmx5IGZ1bmN0aW9uLg0KDQo+PiAraW50IGlp
b19pbml0X2lpb19ndHMoaW50IG1heF9zY2FsZV9pbnQsIGludCBtYXhfc2NhbGVfbmFubywNCj4+
ICsJCSAgICAgY29uc3Qgc3RydWN0IGlpb19nYWluX3NlbF9wYWlyICpnYWluX3RibCwgaW50IG51
bV9nYWluLA0KPj4gKwkJICAgICBjb25zdCBzdHJ1Y3QgaWlvX2l0aW1lX3NlbF9tdWwgKnRpbV90
YmwsIGludCBudW1fdGltZXMsDQo+PiArCQkgICAgIHN0cnVjdCBpaW9fZ3RzICpndHMpDQo+PiAr
ew0KPj4gKwlpbnQgcmV0Ow0KPj4gKw0KPj4gKwlyZXQgPSBpaW9fZ3RzX2xpbmVhcml6ZShtYXhf
c2NhbGVfaW50LCBtYXhfc2NhbGVfbmFubywNCj4+ICsJCQkJICAgJmd0cy0+bWF4X3NjYWxlLCBO
QU5PKTsNCj4+ICsJaWYgKHJldCkNCj4+ICsJCXJldHVybiByZXQ7DQo+PiArDQo+PiArCWd0cy0+
aHdnYWluX3RhYmxlID0gZ2Fpbl90Ymw7DQo+PiArCWd0cy0+bnVtX2h3Z2FpbiA9IG51bV9nYWlu
Ow0KPj4gKwlndHMtPml0aW1lX3RhYmxlID0gdGltX3RibDsNCj4+ICsJZ3RzLT5udW1faXRpbWUg
PSBudW1fdGltZXM7DQo+IA0KPiBJIHRoaW5rIGFsbCB0aGVzZSBuZWVkIHRvIGJlIHByb3ZpZGVk
IGZvciB0aGlzIHRvIGRvIGFueXRoaW5nIHVzZWZ1bC4NCg0KSSB3YXMgYWxzbyBwb25kZXJpbmcg
dGhpcy4gSSBhY3R1YWxseSB0aGluayBJIGF0IHNvbWUgcG9pbnQgaGFkIGEgVE9ETyANCmNvbW1l
bnQgc29tZXdoZXJlIGFib3V0IGRlY2lkaW5nIGlmIHRoZSBpbnRlZ3JhdGlvbiB0aW1lIHRhYmxl
KHMpIHNob3VsZCANCmJlIHJlcXVpcmVkLg0KDQpXZWxsLCBkdXJpbmcgbXkgJ3RyaWFsIGFuZCBl
cnJvcicgY2hhbmdlIGZvciBidTI3MDM0IGRpc2N1c3NlZCBpbiB0aGUgDQpvdGhlciB0aHJlYWQg
KGF0dGVtcHRpbmcgdG8gc2hpZnQgdGhlIGRhdGEgdG8gaGlkZSB0aGUgc2NhbGUgaW1wYWN0IG9m
IA0KaW50ZWdyYXRpb24gdGltZSkgSSBzdGlsbCBlbmRlZCB1cCB1c2luZyB0aGVzZSBoZWxwZXJz
IGZvciB0aGUgZ2Fpbi4gSSANCmxpa2VkIHRoZSBhYmlsaXR5IG9mIHByb3ZpZGluZyB0aGUgZ2Fp
biB0YWJsZSB3aXRob3V0IHJlLWludmVudGluZyB0aGUgDQp0YWJsZSBzdHJ1Y3RzIGFuZCBpbml0
aWFsaXphdGlvbiBtYWNyb3MgaW4gZHJpdmVyLiBBZGRpdGlvbmFsbHkgSSBzdGlsbCANCnVzZWQg
dGhlIHNlbGVjdG9yIDw9PiBnYWluIGNvbnZlcnNpb25zLiBGaW5hbGx5IEkgZGlkIGFkZCBhIHNj
YWxlIDw9PiANCiJ0b3RhbF9nYWluIiBoZWxwZXJzIC0gd2hpY2ggYWxsb3dlZCBtZSB0byBkbyB0
aGUgZ2V0L3NldCBzY2FsZSANCmZ1bmN0aW9ucyBpbiBhIHNpbXBsZSB3YXkuDQoNCkkgc3RpbGwg
ZW5kZWQgdXAgaGF2aW5nIGFsc28gdGhlIGludGVncmF0aW9uIHRpbWUgdGFibGVzIGZvciB0aGUg
dmVyeSANCnNhbWUgcmVhc29uIC0gYnV0IGp1c3Qgc2V0IHRoZSBtdWx0aXBsaWNhdGlvbiBmYWN0
b3IgdG8gMSBmb3IgYWxsIHRpbWVzIA0KKGJlY2F1c2UgZGF0YSBzaGlmdGluZyB3YXMgc3VwcG9z
ZWQgdG8gaGlkZSB0aGUgc2NhbGUgaW1wYWN0IHVudGlsIEkgDQpmaW5hbGx5IHVuZGVyc3Rvb2Qg
d2hhdCB5b3UgbWVhbnQgd2l0aCB0aGUgc2F0dXJhdGlvbiBkZXRlY3Rpb24gDQpwcm9ibGVtLi4u
IDxpbWFnaW5lIGEgZmFjZXBhbG0gZW1vamkgaGVyZT4pLg0KDQo+IFNvIGNoZWNrIHRoZW0gaGVy
ZSBhbmQgZHJvcCB0aGUgY2hlY2tzIGluIHRoZSB2YXJpb3VzIG90aGVyIGZ1bmN0aW9ucy4NClRo
ZSByZWhlYXJzYWwgZGVzY3JpYmVkIGFib3ZlIG1hZGUgbWUgdG8gdGhpbmsgdGhhdCAoc29tZSBv
ZikgdGhlc2UgDQpoZWxwZXJzIGNhbiBiZSB1c2VmdWwgYWxzbyB3aGVuIHRoZXJlIGFyZSBvbmx5
IGdhaW4gdGFibGVzIHByb3ZpZGVkLg0KDQoNCllvdXJzLA0KCS0tIE1hdHRpDQoNCi0tIA0KTWF0
dGkgVmFpdHRpbmVuDQpMaW51eCBrZXJuZWwgZGV2ZWxvcGVyIGF0IFJPSE0gU2VtaWNvbmR1Y3Rv
cnMNCk91bHUgRmlubGFuZA0KDQp+fiBXaGVuIHRoaW5ncyBnbyB1dHRlcmx5IHdyb25nIHZpbSB1
c2VycyBjYW4gYWx3YXlzIHR5cGUgOmhlbHAhIH5+DQoNCg==
