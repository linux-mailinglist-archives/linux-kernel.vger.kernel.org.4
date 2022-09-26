Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1051E5E989A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 07:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbiIZFC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 01:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiIZFCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 01:02:51 -0400
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2124.outbound.protection.outlook.com [40.107.135.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E702727FC5;
        Sun, 25 Sep 2022 22:02:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAeVsXw9DBjxs8tsTjMAf5F/kUX560TgUH6LNpbSZQCdbJjOa8onHtY1LcNiLBzPENTomIiZuJqlU9NYTcAc+KGonHBzG0Vw2uyMInOlc1O0iyU2Q9v6s231gv6K7XPPGkF95cwsnKWjKQRPIH/Xdu3m8DL0vzlifWOC1IC/HD9KEbFN1YFUJtAbPhfdoN/R555FSaKbKj05yw2wfZBPKTGOgrbjk9PUdZitGJjAuvxno6/WqxTR6J18tdlCktbkdmfvsi1a3naPeECXr9hp1e8Ipq+anid33we/Ek3Ac7115BYJL74+KLwoE5IZtUSmBxtrDdNEyT6qbGjTAI29DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F22Lm1eK/d8JYRtve10rqkD0iMyvetqXksOm6vS+oO4=;
 b=Lj1GhRkQ6AEJsRq8KhxIrjmTZHnOd2pwQpFev4o5ibqMaFOAvSt6bun0uvbrjMLSR0EOayDY/Y0F7kYU+bsWsVJhbUCkDUqEl7WL0O4i0xPtb4AQwFQLobSlgGoRyw75nYU7QrPBX2ucIZtadeKmE34KczxSl23SPs5U5IxNwYbZ8+UDlVs8oNFH5VkHHYpi/03QlxYv55CbwprjKG9tjAt4BwfnZ2lokHWNoWScZg8T3D7g9J7jQDM48esIOUOGLHmDdZXJMhE8waB7oTexqW17kDvCEOshO81+OZhVInu4iePQQdUhcKZ7yRNeejOTpjl/BU6t6z/G1obxFksvRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F22Lm1eK/d8JYRtve10rqkD0iMyvetqXksOm6vS+oO4=;
 b=e8k+UHhZldRGpu1zDAgvuuOQ3b21cUWsSTZdz/Z2S92y+qhq9iK3mVVBMCfbXg/VjVOVfV+ByuOqEXamltbTTw/BCPaWf24KClDETOK72n3Y4HoL7KrcyzoSFTA0hfta5PpIC8eyh6m3ccWKSRjhxaUzKpkXnqCZAuTbwrZy1Z8=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by FR0P281MB1756.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:6e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.14; Mon, 26 Sep
 2022 05:02:44 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::74b2:f96e:154d:8aa2]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::74b2:f96e:154d:8aa2%8]) with mapi id 15.20.5676.014; Mon, 26 Sep 2022
 05:02:44 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 4/5] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Thread-Topic: [RFC PATCH 4/5] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Thread-Index: AQHYza+y2hgGmsftnkiq37OGUqNqR63rryWAgADhoQCAAiVXAIACeO6A
Date:   Mon, 26 Sep 2022 05:02:44 +0000
Message-ID: <eb4e7420-a4f9-1ddb-3394-c478a3e1f32f@fi.rohmeurope.com>
References: <cover.1663760018.git.mazziesaccount@gmail.com>
 <fe1088cebb0de70bcb99af517004c1816b696825.1663760018.git.mazziesaccount@gmail.com>
 <20220922180339.30138141@jic23-huawei>
 <f0ef546a-0ec2-2a52-8f12-8f218960f177@gmail.com>
 <20220924161722.6d3e165c@jic23-huawei>
In-Reply-To: <20220924161722.6d3e165c@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2454:EE_|FR0P281MB1756:EE_
x-ms-office365-filtering-correlation-id: 8fc4217c-ac8e-4d89-3e50-08da9f7c58cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5BVNNR15FuQtq5yVay04dzTYGwDeFPRTPfeeSGCVmPzh/oMwkT0zu63hAU43O1a9Dn1nNWXr+v+Cy2pxLC0It40VUYl6mjlBat/ghQHZ81egH82WGgwLFiabdj3rmaJHO/93EGFWUT38roCwqXu6ak5HRWzumDl6DCRTL+UN6xU7RZFWwswqNPzMwlSZg577sfWbVuabPx3/FmCyavOjbCVJmcdgFOBQMap5sUTA09cqD6znzA9UlqNzqX60tOSW2CltQz3FsHaUCXhqvpoBu6ufp1H7Rg+tbM3826YpABc02mt9KpFDFmJBUsBcU0NH/ffkLXCR7A7RaGqYNu0agVP50lEq79/taRCzn3xaYsSdejGKAe9poBT7q5pui4XcymNuR8seA3dznFEAnrEOHmCjFXdq9aAgompi9Zmyx4e2y6wYR3yfDcVccolrGhq+t3knFXRx1KF50UA3CseLvWw74OlEytCaIV3e5QjLSEaGVNWQWr9foKCRf7pMEn6JXKUkBM3k2PBc8SrV6z9TPGYsjau/unFCFir6qYHh6ht23UxkZf2LpQ6TFJ9m4mK8KwnjW2JxBDVpKF9Kc4aADwfv0sc002NbvAftP+vhdW8sXTJuY7TR2abmR2kyo3jySEFGgHNSBdXQzBjLHJ3phrBCY1G+mZM0apNdB82EimMl9MWBWzCXlax1x0RvgWUdy+JPtcOxmLlAJck04y1TeLhbWYw+DGuKGBdn/fvqm7y4lgbRG1uXjRHfB9mMSNZYMPOt5SmO7QnbiqnlTtHRgsusk6J6p1LULkNq/kX1BUbCv1nhc+2OQMayVSEm8LjC+oCeXAO5ifizIDLbKG+imw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39830400003)(396003)(346002)(366004)(451199015)(2906002)(186003)(2616005)(41300700001)(5660300002)(26005)(7416002)(6512007)(53546011)(8936002)(6506007)(38100700002)(122000001)(31696002)(86362001)(38070700005)(83380400001)(54906003)(31686004)(6486002)(110136005)(478600001)(71200400001)(316002)(8676002)(76116006)(4326008)(91956017)(66476007)(66446008)(64756008)(66946007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eC9nVC9oWEx1Wm15RTdiMFZCa3RjekRxVUVDY3d3bnhpeE5NZTF4SVN1WDND?=
 =?utf-8?B?ak1YdldMZ1cveEFtdXlKUTVNWjlkaDRZSEVQTVZBdGZSeGc4WW4xSkI0aVh1?=
 =?utf-8?B?VlQ3azJzaXpLRXI3cytvMjhkVmEwem56ZVlHSVkvY0Z4MnBLTzMrWjhiUmsy?=
 =?utf-8?B?Uzg5SDk2TTRFRUQ1bk9NV3I3L201OFJkMm5vVkd3TzVubmxwSTg0TDVEMGhv?=
 =?utf-8?B?TGVMYitIUVZMTUtENklrRFE5cWt3R2VENTZ0Yy9YWGlRN0tBSnpXK3U5Y1Mx?=
 =?utf-8?B?aGFndFdmWFJGaFNRYUFqMUxpZnpLMWFnYlFxbjZ4RVpBdUVXU2pPWXlOaDdh?=
 =?utf-8?B?K2JweEdjdm5pbUNZbnhkdTlocTJyUW1YcmlqdzRBUzNpbXNtQjV1bUdPdnIx?=
 =?utf-8?B?OTlLQU5yWGt3LytvTlg5L2dkQUNFNi8rL0doRk95WkNuZEorQXNueFdiUHVy?=
 =?utf-8?B?NWluMVBuek9GVmRCT3NvckwySWxOUDQ5Y0ZCNnBWaldpSGRnMjZveHZuSERR?=
 =?utf-8?B?TzhRcUlPVzJ1bXYvSmc4elBuZlZuaVpXL0xxRVVQNlZDUlkxTzVhN0tZajds?=
 =?utf-8?B?VFRoM1VpVlJ3OCtwdjV4MGttRGp1ZDZBZjNnMnIvdnRBd3NndVdiZEk3WUhS?=
 =?utf-8?B?UG1nazhCS1pRcyt3amdtc1U0RFpiWk1VdjhzM0g4Wk93bmtsS3JMbWdtTTNa?=
 =?utf-8?B?Y3dOcTYvY0tITkxyeEVNT055ZmxTM1RCMHhSR3BVZ1dkVE54TG9CVDV3T0lH?=
 =?utf-8?B?SHNyakRJVjFVcHgwM0o5d0thaEpTcEpjdWRVMDhaUEZSdmRJK29YVDBINU01?=
 =?utf-8?B?RzlyQXFHZzZ1WXlJMjdSb2ZiN1FnandPTllhSWlZWGJ3RGVkb292N1FGU25D?=
 =?utf-8?B?QmttMVNuU0h3c3Q3RTlKd1Nqbis0YVlBT0Y4L2FUN09jRWJrY1BlcWNGQVE4?=
 =?utf-8?B?bFBXbmtXMGU1SVpTdExtS3FMVEs1d2dwdzVUalozQVhPUmEwZGN4SklHQi92?=
 =?utf-8?B?aUh1UGlvY2YwSEtobFRmZlE3aS9kWkZBZ0ZMZmdaN2ZLY1U4aGIyeFc4RWs2?=
 =?utf-8?B?bWhjZGJvSHNuQmtMa0RXN2tDRlRJQjBuSnB1UFlZdDVKcmVHOWFicUhQdDky?=
 =?utf-8?B?NmFzeGF0OVRPZmM3WHRWZWNkR1UzMVYvMk1LYlNmUEltOEREVXFEZVVjYzVo?=
 =?utf-8?B?K3BSaDlZSW1MSFB4dy9Nc2wvOXVweUtlRGVKUGN0RXRCUVJyRXlqRGo3VE5h?=
 =?utf-8?B?VDYwYTA2ZFgwN2FaTnZiYUx3WStQU1BkSlhuV3lieUF2K3NnT3F3SWVPcVRv?=
 =?utf-8?B?TStadzdQZ3JJN0Fwam9iU3ZueXhyRDM3bmRBaG1pY0t2b1k3RVQ4YmFVWGF6?=
 =?utf-8?B?MWNCMGgvQythRExlbmwwOE9xUklhZ3N1d0lnNlM5ZmVDWGVub0tWYk14cHN4?=
 =?utf-8?B?ckFDOEZMa3d4eE1uR1E0OXNuQ3A5SEQ0dHBJSFhEUy9jSUtFMFpVZUpYWkZW?=
 =?utf-8?B?UGdNTExFZGVRUkpVVUd4U2ZTWWNzM1hKVC9TbVNBWVZXaWZXa05SS1owaHNC?=
 =?utf-8?B?dzhHNU11Sm9tQVNQVDc0RzN6cVJUY2J0cXlGTjhkUDh2S3d1TWlrOU8yNitX?=
 =?utf-8?B?Kzh0NEhxTjc4MCs3MzUxUU9qN0c5ZWZyVkZuRmpVUUZrYzIzVERvZFNaYlhh?=
 =?utf-8?B?b00zVjUrVGdDKy8zS2MwMUgxQkFiYk9JM2hqV3JCcTVxOEkxcnBzalhyK2hH?=
 =?utf-8?B?aENkUEF5TGNQN3hXemlVbGNKWGx0cnNEajBERXBiSktFbWEzUERUV0ZKTy9F?=
 =?utf-8?B?L3JicXJrR3h3VWdoTFlpNTFUdVlKWFpFN3NTbnoranJQTFIweFZLbmhreWZz?=
 =?utf-8?B?S0dLM0t0WlZsMysyQTIyam9ScExTOHNCcXVzTVE4WmxCVkFYYVlCcFh1OWlQ?=
 =?utf-8?B?a1BXZWdyV0hoT3RsS0FmdVg5UzdpOFNDSUdhWjF3UldpS2dJb21ZMXpvbVpI?=
 =?utf-8?B?QW5BZHh1SEhlMnYvN0tYYm01Tk1ub2ROdE9XVnZ3R2pxWFJyUFh4cWtQKzF6?=
 =?utf-8?B?V0hITkRSb25iTCtOVnFKQ3QwR21sT0tzeXdhN2xidDVlZXlVcnlEWVRxYjYr?=
 =?utf-8?B?eXlRWkUxS0xCVHVpRmRYL1FHL3BTSFJsTDdsbkZzT2wvSEd1SXF6V2ttZlM2?=
 =?utf-8?B?OWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A49971506D9BB40826117FD01CB3A7A@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc4217c-ac8e-4d89-3e50-08da9f7c58cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 05:02:44.0640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mCuW202SS9dxsWJaD7nabnsw4fAOgTrdCbwGc3xI52hCdmR853y+4LcsEJXvSsvlvInDwujqjCiYr+ow/jw4I1fzDfnk7cHah6G0v9yVQxSSuvLEs8TbsJMqjMKSRBh8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB1756
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8yNC8yMiAxODoxNywgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gT24gRnJpLCAyMyBT
ZXAgMjAyMiAwOTozMToxMiArMDMwMA0KPiBNYXR0aSBWYWl0dGluZW4gPG1henppZXNhY2NvdW50
QGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPj4gT24gOS8yMi8yMiAyMDowMywgSm9uYXRoYW4gQ2Ft
ZXJvbiB3cm90ZToNCj4+PiBPbiBXZWQsIDIxIFNlcCAyMDIyIDE0OjQ1OjM1ICswMzAwDQo+Pj4g
TWF0dGkgVmFpdHRpbmVuIDxtYXp6aWVzYWNjb3VudEBnbWFpbC5jb20+IHdyb3RlOg0KPj4+ICAg
IA0KPj4+PiBLWDAyMkEgaXMgYSAzLWF4aXMgQWNjZWxlcm9tZXRlciBmcm9tIFJPSE0vS2lvbml4
LiBUaGUgc2Vub3IgZmVhdHVyZXMNCj4+Pj4gaW5jbHVkZSB2YXJpYWJsZSBPRFJzLCBJMkMgYW5k
IFNQSSBjb250cm9sLCBGSUZPL0xJRk8gd2l0aCB3YXRlcm1hcmsgSVJRLA0KPj4+PiB0YXAvbW90
aW9uIGRldGVjdGlvbiwgd2FrZS11cCAmIGJhY2stdG8tc2xlZXAgZXZlbnRzLCBmb3VyIGFjY2Vs
ZXJhdGlvbg0KPj4+PiByYW5nZXMgKDIsIDQsIDggYW5kIDE2ZykgYW5kIHByb2JhYmx5IHNvbWUg
b3RoZXIgY29vbCBmYXR1cmVzLg0KPj4+Pg0KPj4+PiBBZGQgc3VwcG9ydCBmb3IgdGhlIGJhc2lj
IGFjY2VsZXJvbWV0ZXIgZmVhdHVyZXMgc3VjaCBhcyBnZXR0aW5nIHRoZQ0KPj4+PiBhY2NlbGVy
YXRpb24gZGF0YSB2aWEgSUlPLiAocmF3IHJlYWRzLCB0cmlnZ2VyZWQgYnVmZmVyIFtkYXRhLXJl
YWR5XSBvcg0KPj4+PiB1c2luZyB0aGUgV01JIElSUSkuDQo+Pj4+DQo+Pj4+IEltcG9ydGFudCB0
aGluZ3MgdG8gYmUgYWRkZWQgaW5jbHVkZSB0aGUgZG91YmxlLXRhcCwgbW90aW9uDQo+Pj4+IGRl
dGVjdGlvbiBhbmQgd2FrZS11cCBhcyB3ZWxsIGFzIHRoZSBydW50aW1lIHBvd2VyIG1hbmFnZW1l
bnQuDQo+Pj4+DQo+Pj4+IE5PVEU6IEZpbGxpbmctdXAgdGhlIGhhcmR3YXJlIEZJRk8gc2hvdWxk
IGJlIGF2b2lkZWQuIER1cmluZyBteSB0ZXN0aW5nDQo+Pj4+IEkgbm90aWNlZCB0aGF0IGZpbGxp
bmcgdXAgdGhlIGhhcmR3YXJlIEZJRk8gbWlnaHQgbWVzcy11cCB0aGUgc2FtcGxlDQo+Pj4+IGNv
dW50LiBNeSBzZW5zb3IgZW5kZWQgdXAgaW4gYSBzdGF0ZSB3aGVyZSBhbW91bnQgb2YgZGF0YSBp
biBGSUZPIHdhcw0KPj4+PiByZXBvcnRlZCB0byBiZSAweGZmIGJ5dGVzLCB3aGljaCBlcXVhbHMg
dG8gNDIsNSBzYW1wbGVzLiBTcGVjaWZpY2F0aW9uDQo+Pj4+IHNheXMgdGhlIEZJRk8gY2FuIGhv
bGQgbWF4aW11bSBvZiA0MSBzYW1wbGVzIGluIEhpUmVzIG1vZGUuIEFsc28sIGF0DQo+Pj4+IGxl
YXN0IG9uY2UgdGhlIEZJRk8gd2FzIHN0dWNrIGluIGEgc3RhdGUgd2hlcmUgcmVhZGluZyBkYXRh
IGZyb20NCj4+Pj4gaHdhcmR3YXJlIEZJRk8gZGlkIG5vdCBkZWNyZWFzZSB0aGUgYW1vdW50IG9m
IGRhdGEgcmVwb3J0ZWQgdG8gYmUgaW4gdGhlDQo+Pj4gc3BlbGwgY2hlY2sgdGhpcy4NCj4+PiAg
ICANCj4+Pj4gRklGTyAtIGVnLiBGSUZPIHdhcyAic3R1Y2siLiBUaGUgY29kZSBoYXMgbm93IGFu
IGVycm9yIGNvdW50IGFuZCAxMA0KPj4+PiByZWFkcyB3aXRoIGludmFsaWQgRklGTyBkYXRhIGNv
dW50IHdpbGwgY2F1c2UgdGhlIGZpZm8gY29udGVudHMgdG8gYmUNCj4+Pj4gZHJvcHBlZC4NCj4+
PiBPdWNoIC0gdGhhdCdzIG5hc3R5Lg0KPj4NCj4+IEluZGVlZCBpdCBpcy4gQXMgdGhpcyBjb21t
aXQgc3RhdGVzLCB0aGlzIGlzIHByZXR0eSBpbml0aWFsIHN1cHBvcnQgZm9yDQo+PiB0aGUgYWNj
ZWxlcm9tZXRlci4gSSB3YW50IHRvIGVuYWJsZSBwZW9wbGUgdG8gZG8gYmFzaWMgZXhwZXJpbWVu
dGluZyBhbmQNCj4+IGFsc28gdXNlIHRoZSBjb21wb25lbnQgdG8gc29tZSBzbG93IE9EUiBzb2x1
dGlvbnMuIEJlc2lkZXMsIGhhdmluZyBldmVuDQo+PiBhIGJhc2ljIHN1cHBvcnQgaW4tdHJlZSBl
bmFibGUgcGVvcGxlIHRvIGFkZCBmdXJ0aGVyIGltcHJvdmVtZW50cyA6KSBTbywNCj4+IEkgYW0g
aG9waW5nIC8gZXhwZWN0aW5nIHRvIHNlZSBpbXByb3ZlbWVudHMgYWRkZWQgYWxzbyBieSBvdGhl
ciBwZW9wbGUNCj4+IHVzaW5nIHRoaXMuIEkgdGhpbmsgdGhhdCBhZnRlciB0aGlzIGluaXRpYWwg
c3VwcG9ydCBtYW55IHBlb3BsZSBzdGlsbA0KPj4gX25lZWRfIGZvciBleGFtcGxlIHRoZSBydW50
aW1lIFBNLiBNYXliZSB3ZSB3aWxsIGFsc28gZW5kIHVwIHdpdGggc29tZQ0KPj4gbmljZXIgc29s
dXRpb24gdG8gdGhlIEZJRk8gaXNzdWVzLg0KPiANCj4gTXkgaW5pdGlhbCBndXQgZmVlbGluZyBp
cyB0aGF0LCBpZiB0aGF0IGZpZm8gaXNzdWUgZG9lc24ndCBoYXZlIGEgY2xlYW4NCj4gc29sdXRp
b24sIHdlIGRvbid0IGRvbid0IHN1cHBvcnQgdGhlIGZpZm8gKGJ5IGRlZmF1bHQgYW55d2F5IC0N
Cj4gY291bGQgaGF2ZSBhIG1vZHVsZSBwYXJhbWV0ZXIgb3Igc29tZXRoaW5nIHRvIHR1cm4gaXQg
b24pLiAgTGF0ZSBoYW5kbGluZw0KPiBvZiBpbnRlcnJ1cHRzIGlzIHNvbWV0aGluZyB0aGF0IGNh
biBoYXBwZW4gZm9yIGxvdHMgb2YgcmVhc29ucy4gSXQgc2hvdWxkDQo+IG5ldmVyIGJlIGZhdGFs
IQ0KDQpUZWxsIG1lIGFib3V0IGl0Li4uIE1vcmUgdGhhbiAxMC15ZWFycyBhZ28gSSAiaW5oZXJp
dGVkIiBtYWludGVuYW5jZSBvZiANCmEgdGltaW5nIGNvZGUgd2hpY2ggd2FzIGJ1aWx0IG9uIHBl
cmlvZGljIDEwbXNlYyBJUlEgd2hpY2ggaW5jcmVtZW50ZWQgYSANCmNvdW50ZXIuIChBbmQgYWZ0
ZXIgdGhhdCB0aGVyZSB3ZXJlIG1hbnkgbmV3IGdlbmVyYXRpb25zIG9mIExpbnV4IGJhc2VkIA0K
ZGV2aWNlcyB3aXRoIHZhcmlvdXMgInJ0Ii1yZXF1aXJlbWVudHMpLiBNaXNzaW5nIGFuIElSUSB3
YXMgZmF0YWwgYXMgDQp0aGVyZSB3ZXJlIG5vIGhhcmR3YXJlIHdoZXJlIHdlIGNvdWxkIHJlYWQg
dGhlIGNvcnJlY3QgdGltZXN0YW1wIGFuZCANCm90aGVyIHVuaXRzIGluIHRoZSBzeXN0ZW0gd2Vy
ZSBubyBsb25nZXIgaW4gc3luYyBpZiB0aGUgY291bnRlciB3YXMgDQp3cm9uZy4gT25seSByZWNv
dmVyeSB3YXMgY29tcGxldGUgc3lzdGVtIHJlc3RhcnQgZm9yIGFsbCB1bml0cyAtIHdoaWNoIA0K
aW4gdGhhdCB1c2UgY2FzZSB3YXMgcmVhbGx5IGJhZC4gSSBsZWFybmVkIHRvIGFic29sdXRlbHkg
aGF0ZSB0aGUgc2VyaWFsIA0KcHJpbnRzIG92ZXIgc2xvdyBVQVJUIC0gYW5kIEkgbGVhcm5lZCB0
byBsb3ZlIGlycXNvZmYgdHJhY2VyLiBJIGRvbid0IA0Kd29yayBmb3IgdGhhdCBjb21wYW55IGFu
eW1vcmUgYW5kIEkgYmVsaWV2ZSB0aGUgcHJvZHVjdCBoYXMgYWxyZWFkeSANCnJldGlyZWQuIFll
dCwgSSBzdGlsbCBnZXQgKnNocnVncyogd2hlbiBJIHNlZSBoYXJkIHRpbWUgbGltaXRzIGZvciAN
CnNlcnZpbmcgSVJRcyBvbiBMaW51eC4gKE90aGVyIHRoYW4gdGhhdCBJIGtpbmQgb2YgbGlrZSBw
b25kZXJpbmcgdGhlIA0KcnQtY2hhbGxlbmdlcykuDQoNCkFueXdheXMsIEkgZG9uJ3Qgc2VlIGEg
cmVhbCByaXNrIGZvciBleGFtcGxlIHdoZW4gdXNpbmcgdGhlIE9EUnMgPCAyIEh6IA0KYW5kIHNl
dHRpbmcgdGhlIHdhdGVybWFyayB0byBzb21ld2hlcmUgbmVhciAyMCBzYW1wbGVzLg0KDQpJdCdz
IHJlYWxseSB1bmZvcnR1bmF0ZSB0aGUgSFcgaGFzIHRoZXNlICJoaWNrdXBzIiAtIGJ1dCBJIHRo
aW5rIGl0IGlzIA0Kc3RpbGwgcGVyZmVjdGx5IHVzYWJsZSBmb3IgbWFueSBjYXNlcyAtIHdlIGp1
c3QgcmVhbGx5IG5lZWQgdG8gZG9jdW1lbnQgDQp0aGUgY29ybmVyIGNhc2VzIHNvbWV3aGVyZS4N
Cg0KPiBTaW1wbGUgZmlyc3QuICAgRGlmZmVyZW50IG1hdHRlciBpZiB5b3UgYWRkIHRoZSBvdGhl
ciB0cmlnZ2VycyBsYXRlciBpbg0KPiB0aGUgc2FtZSBwYXRjaCBzZXJpZXMsIGJ1dCBoaXN0b3J5
IHNheXMgaGFsZiB0aGUgaW50ZXJlc3RpbmcgZmVhdHVyZXMNCj4gd2UgcGxhbiB0byBhZGQgbmV2
ZXIgZ2V0IGFkZGVkLg0KDQphY2suDQoNCj4+PiBNdXN0IGVpdGhlciBoYW5kbGUgYm90aCBwaW5z
IG9yIGF0IGxlYXN0IGtub3cgaWYgaXQgaXMgaXJxMiBhbmQNCj4+PiB0cmVhdCB0aGF0IGFzIG5v
IGlycSBmb3Igbm93Lg0KPj4NCj4+IEkgZG9uJ3Qgd2FudCB0byB0cnkgc3VwcG9ydGluZyBib3Ro
IHBpbnMgZm9yIG5vdy4gSXQgbWFrZXMgdGhpcyBzb21ld2hhdA0KPj4gbW9yZSBjb21wbGV4IC0g
ZXNwZWNpYWxseSBpZiB3ZSB3YW50IHRvIHN1cHBvcnQgdXNpbmcgdHdvIElSUXMuIFRoYXQNCj4+
IHdpbGwgcmVxdWlyZSBzb21lIHRob3JvdWdoIHRoaW5raW5nIHdoaWNoIEkgZG9uJ3QgaGF2ZSB0
aW1lIHRvIGRvIHJpZ2h0DQo+PiBub3cgOigNCj4+DQo+PiBJIGNhbiBhZGQgdGhlIGlycS1uYW1l
cyB0byB0aGUgYmluZGluZ3MgYW5kIGFkZCBjaGVjayB0byB0aGUgcHJvYmUgc28NCj4+IHRoYXQg
aWYgdGhlIGlycTIgaXMgdXNlZCB3ZSBlcnJvciBvdXQgd2l0aCBuaWNlICdub3Qgc3VwcG9ydGVk
JyBtZXNzYWdlLg0KPj4NCj4gDQo+IEEgc2xpZ2h0bHkgbmljZXIgdGhpbmcgdG8gZG8gaXMgc3Vw
cG9ydCBvbmUgaXJxLCBidXQgbGV0IGl0IGJlIGVpdGhlciBpcnExIG9yDQo+IGlycTIuIElmIGJv
dGggYXJlIHN1cHBsaWVkIGp1c3QgaWdub3JlIHRoZSBzZWNvbmQgb25lLiAgUGVvcGxlIGhhdmUN
Cj4gYW4gJ2FtdXNpbmcnIGhhYml0IG9mIG9ubHkgd2lyaW5nIHVwIGlycTIgb24gYm9hcmRzLg0K
PiANCg0KT2suIEl0IHNob3VsZG4ndCBiZSBzdWNoIGEgYmlnIGNoYW5nZSBmb3IgdGhlIGNvZGUu
IEknbGwgc2VlIHdoYXQgaXQgDQp3aWxsIGxvb2sgbGlrZS4NCg0KPj4+PiArDQo+Pj4+ICtzdGF0
aWMgaW50IGt4MDIyYV9jaGlwX2luaXQoc3RydWN0IGt4MDIyYV9kYXRhICpkYXRhKQ0KPj4+PiAr
ew0KPj4+PiArCWludCByZXQsIGR1bW15Ow0KPj4+PiArDQo+Pj4+ICsJLyoNCj4+Pj4gKwkgKiBE
aXNhYmxlIElSUXMgYmVjYXVzZSBpZiB0aGUgSVJRcyBhcmUgbGVmdCBvbiAoZm9yIGV4YW1wbGUg
YnkNCj4+Pj4gKwkgKiBhIHNodXRkb3duIHdoaWNoIGRpZCBub3QgZGVhY3RpdmF0ZSB0aGUgYWNj
ZWxlcm9tZXRlcikgd2UgZG8NCj4+Pj4gKwkgKiBtb3N0IHByb2JhYmx5IGVuZCB1cCBmbG9vZGlu
ZyB0aGUgc3lzdGVtIHdpdGggdW5oYW5kbGVkIElSUXMNCj4+Pj4gKwkgKiBhbmQgZ2V0IHRoZSBs
aW5lIGRpc2FibGVkIGZyb20gU09DIHNpZGUuDQo+Pj4+ICsJICovDQo+Pj4+ICsJcmV0ID0gcmVn
bWFwX3dyaXRlKGRhdGEtPnJlZ21hcCwgS1gwMjJBX1JFR19JTkM0LCAwKTsNCj4+Pg0KPj4+IFVu
dXN1YWwgdG8gZG8gdGhpcyByYXRoZXIgdGhhbiBhIHJlc2V0LiAgUXVpY2sgbG9vayBzdWdnZXN0
cyB0aGVyZSBpcw0KPj4+IGEgc3VpdGFibGUgc29mdHdhcmUgcmVzZXQgKENOVEwyKQ0KPj4NCj4+
IFNhbWUgdGhpbmcgd2FzIGp1c3QgdG9sZCBtZSBieSBhIGNvbGxlYWd1ZSBvZiBtaW5lIHllc3Rl
cmRheS4gUmVzZXQNCj4+IHNpbXBsaWZpZXMgdGhpcyBxdWl0ZSBhIGJpdC4gKEkganVzdCB3b25k
ZXIgaWYgd2UgY2FuIHRydXN0IHRoZSByZXNldA0KPj4gYWx3YXlzIGluaXRpYWxpemVzIHRoZSBJ
QyB0byBzYW1lIGRlZmF1bHRzIG9yIGlmIHRoZXJlIG1heSBiZSBPVFANCj4+IGRpZmZlcmVuY2ll
cy4gSSBhbSBuZXcgdG8gdGhlc2Ugc2Vuc29ycykuDQo+Pg0KPiANCj4gSSByZWFsbHkgaG9wZSB3
ZSBjYW4gcmVseSBvbiBhbnkgZG9jdW1lbnRlZCByZXNldCB2YWx1ZXMhDQoNClRoYXQgaXMgYSBz
YW5lIGFzc3VtcHRpb24gdG8gZG8gLSBidXQgaW4gbXkgZXhwZXJpZW5jZSB3ZSBkb24ndCBsaXZl
IGluIA0KYSBzYW5lIHdvcmxkIDspIEkndmUgc2VlbiB3YXkgdG9vIG1hbnkgY2FzZXMgd2hlcmUg
dGhlIGRlZmF1bHRzIGFyZSANCmNoYW5nZWQgZm9yIElDcyBmb3IgZXhhbXBsZSBieSBjaGFuZ2lu
ZyBPVFAuIEFuZCBzb21ldGltZXMgdGhlIE9UUCANCmNoYW5nZSBoYXMgbm90IGJlZW4gdmlzaWJs
ZSB0byB0aGUgZHJpdmVycyBmcm9tIGFueSByZXZpc2lvbiByZWdpc3RlcnMgDQpvciBzdWNoLg0K
DQpJJ20gbm90IHRhbGtpbmcgYWJvdXQgS2lvbml4IHNlbnNvcnMgdGhvdWdoIGFzIEkndmUgbmV2
ZXIgd29ya2VkIHdpdGggDQpLaW9uaXggc2Vuc29ycyBiZWZvcmUgLSBzbyBsZXQncyBqdXN0IHRy
eSBvdXQgdGhlIHJlc2V0IGFuZCBmaXggdGhpbmdzIA0KaWYgcHJvYmxlbXMgZW1lcmdlLiBJIGFt
IHByb2JhYmx5IGp1c3QgYSBiaXQgcGFyYW5vaWQgOikNCg0KVGhhbmtzIGZvciBhbGwgdGhlIGhl
bHAhDQoNCllvdXJzLA0KCS0tIE1hdHRpDQoNCi0tIA0KTWF0dGkgVmFpdHRpbmVuDQpMaW51eCBr
ZXJuZWwgZGV2ZWxvcGVyIGF0IFJPSE0gU2VtaWNvbmR1Y3RvcnMNCk91bHUgRmlubGFuZA0KDQp+
fiBXaGVuIHRoaW5ncyBnbyB1dHRlcmx5IHdyb25nIHZpbSB1c2VycyBjYW4gYWx3YXlzIHR5cGUg
OmhlbHAhIH5+DQo=
