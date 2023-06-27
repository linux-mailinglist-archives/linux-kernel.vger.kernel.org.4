Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FF573F92A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjF0JyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbjF0Jx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:53:28 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2045.outbound.protection.outlook.com [40.107.9.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B1E273F;
        Tue, 27 Jun 2023 02:53:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGFdUzujgyhYKN7NT5rEyd/STNgJe9eCkeQ2Im96mCrnSze/iCtH4kPqLhcGlgCYPCFNm8v0+u2wpV/i1U8PQMvZ+FjPcgpqBpUMlFpqNj70ZQU75bBWtPHPiLrUBOMzfuAZGuXY4dmtmyBZvXUSy13cIZXK+Kulz7fif6sDTW5g4C7ONlVxScn8Ya42K/9wjJgralV7sYsFZ7Ub1rtwBzBv4Fvd+28o+4EbXGpWNeM8/zYA5MIl9cMTegMdLZAwsjkTzxkJTHy6+oxcA57TSFzUhz4I2+04PsB5AcMTGnGBLUhIukCk1XEBluI7Q6HX/Bnv1UszR1fg1QF8SK0bXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmoxI5k2ThMDk164sYCHrFi309hYf8i8sFkFIplCBHc=;
 b=R5IaMKl6Mt1HOPaCkrDNb8DbFNpk1pzEsGOGpLR6zVqzYhirze+S5HEre0417UuEgJvhVT7qxX/L1BNLRfVkI+RyM5Hbxo5In+SyN7jVtFt4xbroVI8vI5Yr/G+mJAu8/JOcr7BHoOL5Wyn1Ha43jBE8jCPeXld/c86RP/rw2TFnbOZtP5v+KIKsscChoGFcOudLEtOMlnZCmV3EjXRGYpdUWnM7LP2yuLKqkbSQyi4zby+hFI4DwXGVd93XIpo3yUN7FXqR55TwdeouQQ8A6HFLS6goXIEqIGLegraUm/49M+ySxnGN9Q+NZrG0gqphonTajfu7BH12IQhfHhmEeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmoxI5k2ThMDk164sYCHrFi309hYf8i8sFkFIplCBHc=;
 b=hSeu2YECCEdO7YWKffziP2Vx9rQouU5IPnqRlMSFITSqf9KPiRjJ/OfYD7s0CEhmUMA51BlrO1ub/1BGqmR7gb8DHulUeadOhW2xksugYm0naX5AOTLi2xaSoeuGClGPqXeOjc5WvUC/mky7tenCg+S2jka4urLNLQzKdT2Lb9gnn7waoZPe90FqZ5ILcARpETJBBd07psoNWKkH59FWs1cDiXXepTyus+Rrw97MJKcgbSEwYeTcL+jtPZqQGWYYfKhWEmT5cigdxTF7KOun9o+YSlplLavYcgVLxN4yK9sNwCC+qGPiJA5980foWouLuIbrcmXTpPiQsIEst58BuQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAYP264MB3319.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:18c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 09:53:18 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::802b:33:561c:4217]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::802b:33:561c:4217%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 09:53:18 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v6 02/13] ASoC: dt-bindings: simple-card: Add
 additional-devs subnode
Thread-Topic: [PATCH v6 02/13] ASoC: dt-bindings: simple-card: Add
 additional-devs subnode
Thread-Index: AQHZpbDqY3UCTr2AzEuZx47fLIXGb6+ebwKA
Date:   Tue, 27 Jun 2023 09:53:18 +0000
Message-ID: <27cdd1f0-b2ee-c90e-3071-00b8a16a1c21@csgroup.eu>
References: <20230623085830.749991-1-herve.codina@bootlin.com>
 <20230623085830.749991-3-herve.codina@bootlin.com>
In-Reply-To: <20230623085830.749991-3-herve.codina@bootlin.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PAYP264MB3319:EE_
x-ms-office365-filtering-correlation-id: d2aab3d0-26f3-41b0-0f46-08db76f45587
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ld5kxdRbZ4h3w0OAENjykHX7U/l0+f58RPAsTvcwf3nMToHF1sIOAolA0TsKpfSUSsctZGc08CI1FvV8mpZ3k2YEcZifMKks3x3N98JAfdNcOrTXXNHBb+BDKHSUuDIzWyi6AtOJnWY6h6SI1bJhqJ3QO/m2zJkIlXJrPXxZvSbYEcfrK5ZdxDKVmjutRXOoMPIxIKShbD+ooJYX9c9QOeuoz0lND/XBWA4dUJAEwTfYGxaf1wyn6vZxYW/lSEMG69pydn4tOHrPy/f/KZwsUu84jX6DhQMKAcwkqUJd/I3PPbABIYTCUkG7b3cP3YSgnUawGtmAkosPqINfcimGFA0azpbBmEUQQ9Z0wIFeegcvDYCwfe6waV6MvaWniTlKQpD6ko7aleKAvEC/I4UzDq/tTBRIXx13gACa4JzSO1KOd4+OTUSCOjSDjLDXF7YbIr+DuxI9m7Bd6j+IH3M6+vJkEXo0Lb+6UPQclfcoW+9tGxWatGVHlIWNPyoDFZtiZOMTaVpb7T0c3U/pCDMbmB0D29jKS/Kxk+senJnndqN4O14q3mHF7wKEIdKPNO+prgHxooVhXb6d0RhX0irJZfyy82qPTwVBbIMQ6zy3C8+P+USlXdM8dv1YOXuViDtGHBIInh2xmxIvWiRhlFp1Wixq73nhhlTcYlEDpn40JOPjUaVJh4H8cpNeSDkIJQ1/gcMqyy9+4PyGfCI0pXVqnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199021)(66446008)(66574015)(54906003)(110136005)(83380400001)(6486002)(71200400001)(26005)(2906002)(6512007)(2616005)(6506007)(478600001)(186003)(5660300002)(44832011)(36756003)(921005)(7416002)(4326008)(122000001)(38100700002)(76116006)(316002)(66946007)(38070700005)(31696002)(66476007)(41300700001)(8936002)(8676002)(66556008)(91956017)(64756008)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVdUY0svbDJrSGxSQndMTGM4VmpmY25KOGJXT241VjM4bG8vYW1ISHZOL2I0?=
 =?utf-8?B?YUhTampvQlpOTG1YcDBoRE5mMWliTXZCR1RlMGZJbG1kT3V1NXRneDRSUzVC?=
 =?utf-8?B?d3Q4N2NMT1owcDE0N0V1WEJZRlhJS0RBTkswUWRkUlc1TVNLc24ydXIrejVC?=
 =?utf-8?B?aFNBZ1FoRTgvUkNGYytWWkZYbllWWXVSdm1KQXZjcHBwWHViYzJySEV5M3Vm?=
 =?utf-8?B?QnkzTUZqSGZYUjhyMkFDSXlUODlJcERNZTRURGphT2hRR0FIMGlkUVM5b2Zl?=
 =?utf-8?B?dkhFMVgyZ2lJTDNqV29IOCtYUG5laFovUVdtOERRZ05BQVk5ZERMOVYycGVM?=
 =?utf-8?B?OTAxOS9FVXdPaTZ5QWhDcGV4Y3NVOHpVeVBaYllVY3RaQldxL2FvaWZtMkZi?=
 =?utf-8?B?RU9ReVNHdHJRbkdkakpHb3g3Mit6bHI5bk1GS2hMaVhxSW1RZGg0N3dzMjA3?=
 =?utf-8?B?OE1hbEdRN2NwZmtCT3JQTmZ4M09DbFVHV01zUko3NDUxaVpRWHpwc09Nbzlo?=
 =?utf-8?B?SmtHRUI5TFNTaC9BNEI3VUg4RHNrdnVqNjMwS0tsWnJwa1BoUlkyOTJUZTZQ?=
 =?utf-8?B?cUdFRGpTWFhqSkVNbXFnNFRkdCtUZzZVSEp2TXBReU9SbEwwaUZGQUczTURX?=
 =?utf-8?B?K1crOS9sWEYrSUhQQ2pabWtEeHo4SzZpWjlVLzJEVFdzbnlKMHhEU1FIRnZs?=
 =?utf-8?B?T1dtM2FFc0luSksvM2ZuVTlGOWRwWkRJazg4RTZMKytlVVBYOTZXaVlVREdt?=
 =?utf-8?B?dWJGa1crVVk1ay9pRDM5VGo1ZHhsajdnWlYwQ0wxN0NaNGRTWExYMzhobW1J?=
 =?utf-8?B?VERLN2RicHZ0VmtTQnFDVjhjQmw3VGx4c0U2clpLaVhuNFAzMHJHc29oZFAx?=
 =?utf-8?B?a0R6c0thTHU5blg1KzBQa0NmUDZpaVhORWhjWUlOQUJvc21TQVZIOG40R092?=
 =?utf-8?B?SEdTK2hMM2c4ZWdOQjRoaDgyVDExTGo3aHRVVThrSGlkNFFJdzU4ODBBN2xM?=
 =?utf-8?B?dVA5bG1mM2N5bWhiVWtyVW5rMFFXOGJFK2FldWVhMm8zd3ZtVVRuMXc3dFh3?=
 =?utf-8?B?YjFsY0QxcGpDT0lnbUN4NjZ1dHNFZklQb3RJRFpUWTVFbVRtbC9zbHlqbW1K?=
 =?utf-8?B?ZklaeUdyeEZ0MTBHcGhjaXF6ZDA1Q1JvZ1VROVRsMjZNbXR4NjF0Z01lM3NQ?=
 =?utf-8?B?NTdyMm9RQ1duaXNNMWdtNS9zc2xtR1VHZzhsQzlRM280UG1EVnBHVEg4L0dE?=
 =?utf-8?B?ZE4xNWpLZUdZWC9jVmZFMmF6YTZJejRoSnhiTDl6T283T052QTUwaGorOGNY?=
 =?utf-8?B?NjRwSHZKaUQ0SzRvcnBXYXIrbHYwdHFuQnI3Q1R0M3ZCYVdzNHVFcVRlakkx?=
 =?utf-8?B?WnVGa2tTSjFBdjZndUFySW8vRVN1cGlpS0dIY2ZmZnoxNWltNml6QjdMUlpO?=
 =?utf-8?B?SWVnNVVHdjlqbEpIclU3YkdXcVJETGtYMjJMZm1nV1YrRml2Q0V2OE02YllJ?=
 =?utf-8?B?a0tKSTVIdmJwaXRkMEIyd3dMSUdSV0MzNTAvL21jNTYzYWJ5R0Nta0RCTjI1?=
 =?utf-8?B?cHU1dDBQZXBGYjMrejBNOUo3YUU3eWJDS0xPR2lwTjFlL280M1NTUExmQUVp?=
 =?utf-8?B?anFFbkQ3U0NraURpZzFWNG9oUXJCUXRWZ3d5M1FHQjBWYWFuR0w2RGpLQVlD?=
 =?utf-8?B?bk41RCtaVTZ4eEZtUmN6aVdQNTlTemtvMWJsT1VIZmVQb2xzVGtqRnVnaFNX?=
 =?utf-8?B?ZnZibTF4bWh0Y2t1WXpySFZYblJiVStGNElBeGpxRzBZWnBFVlFlZ1UraE9G?=
 =?utf-8?B?WTFMak5iNXFNVzZsR25wQXY3aE1pUm5pOUxZUFkzZmxlZzZydTJzYUE1UHhl?=
 =?utf-8?B?ZUZYMTRONHpBL01hUGQvL0RSZlNiQnhOcnExbFlWU1NCL3Z3UmFwYmh1RUdL?=
 =?utf-8?B?ZVorZEJxdmVjajVqTDhkQ00ydFdVNGtSd1czSWpmMHNFb2IrR1hhVnRqaGkx?=
 =?utf-8?B?aFJUOGdmTEdFRlk1d3dncHNDaUlhWm5JblVkcWlCWiswREN1c0NJWG0weG5j?=
 =?utf-8?B?eUpaMVFwTHBNZDNTVGRFeThudjRudXN2UWdXV1luZXlJOFQ4TEJzSHFhMzNP?=
 =?utf-8?Q?/CVx1d3f+SS9oXcGc50p2ZCg8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16DF9766A6C013419BEA2D8A0AEDD9EE@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d2aab3d0-26f3-41b0-0f46-08db76f45587
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 09:53:18.2064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hmx37vOT8IEsSHPk7T/XAPT2HFtPIJVD1/XKb5PNxojTC6ySVMqS/rtbaCNfRy3pT+Odm6l22RoQNTBB85ehA2y6114i/SlEkid63oUeyOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAYP264MB3319
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDIzLzA2LzIwMjMgw6AgMTA6NTgsIEhlcnZlIENvZGluYSBhIMOpY3JpdMKgOg0KPiBU
aGUgYWRkaXRpb25hbC1kZXZzIHN1Ym5vZGUgYWxsb3dzIHRvIGRlY2xhcmVkIHNvbWUgdmlydHVh
bCBkZXZpY2VzDQo+IGFzIHNvdW5kIGNhcmQgY2hpbGRyZW4uDQo+IFRoZXNlIHZpcnR1YWwgZGV2
aWNlcyBjYW4gdGhlbiBiZSB1c2VkIGJ5IHRoZSBzb3VuZCBjYXJkIGFuZCBzbyBiZQ0KPiBwcmVz
ZW50IGluIHRoZSBhdWRpbyBwYXRoLg0KPiANCj4gVGhlIGZpcnN0IHZpcnR1YWwgZGV2aWNlIHN1
cHBvcnRlZCBpcyB0aGUgYXVkaW8gSUlPIGF1eGlsaWFyeSBkZXZpY2UNCj4gaW4gb3JkZXIgdG8g
c3VwcG9ydCBhbiBJSU8gZGV2aWNlIGFzIGFuIGF1ZGlvIGF1eGlsaWFyeSBkZXZpY2UuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBIZXJ2ZSBDb2RpbmEgPGhlcnZlLmNvZGluYUBib290bGluLmNvbT4N
Cj4gUmV2aWV3ZWQtYnk6IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2Vp
LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IENocmlzdG9waGUgTGVyb3kgPGNocmlzdG9waGUubGVyb3lA
wqlzZ3JvdXAuZXU+DQoNCj4gLS0tDQo+ICAgLi4uL2JpbmRpbmdzL3NvdW5kL3NpbXBsZS1jYXJk
LnlhbWwgICAgICAgICAgIHwgNTMgKysrKysrKysrKysrKysrKysrKw0KPiAgIDEgZmlsZSBjaGFu
Z2VkLCA1MyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL3NpbXBsZS1jYXJkLnlhbWwgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvc2ltcGxlLWNhcmQueWFtbA0KPiBpbmRleCBiMDVl
MDVjODFjYzQuLjU5YWMyZDFkMWNjZiAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3NvdW5kL3NpbXBsZS1jYXJkLnlhbWwNCj4gKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL3NpbXBsZS1jYXJkLnlhbWwNCj4gQEAgLTE0
OCw2ICsxNDgsMTUgQEAgZGVmaW5pdGlvbnM6DQo+ICAgICAgIHJlcXVpcmVkOg0KPiAgICAgICAg
IC0gc291bmQtZGFpDQo+ICAgDQo+ICsgIGFkZGl0aW9uYWwtZGV2czoNCj4gKyAgICB0eXBlOiBv
YmplY3QNCj4gKyAgICBkZXNjcmlwdGlvbjoNCj4gKyAgICAgIEFkZGl0aW9uYWwgZGV2aWNlcyB1
c2VkIGJ5IHRoZSBzaW1wbGUgYXVkaW8gY2FyZC4NCj4gKyAgICBwYXR0ZXJuUHJvcGVydGllczoN
Cj4gKyAgICAgICdeaWlvLWF1eCgtLispPyQnOg0KPiArICAgICAgICB0eXBlOiBvYmplY3QNCj4g
KyAgICAgICAgJHJlZjogYXVkaW8taWlvLWF1eC55YW1sIw0KPiArDQo+ICAgcHJvcGVydGllczoN
Cj4gICAgIGNvbXBhdGlibGU6DQo+ICAgICAgIGNvbnRhaW5zOg0KPiBAQCAtMTg3LDYgKzE5Niw4
IEBAIHByb3BlcnRpZXM6DQo+ICAgICAgICRyZWY6ICIjL2RlZmluaXRpb25zL21jbGstZnMiDQo+
ICAgICBzaW1wbGUtYXVkaW8tY2FyZCxhdXgtZGV2czoNCj4gICAgICAgJHJlZjogIiMvZGVmaW5p
dGlvbnMvYXV4LWRldnMiDQo+ICsgIHNpbXBsZS1hdWRpby1jYXJkLGFkZGl0aW9uYWwtZGV2czoN
Cj4gKyAgICAkcmVmOiAiIy9kZWZpbml0aW9ucy9hZGRpdGlvbmFsLWRldnMiDQo+ICAgICBzaW1w
bGUtYXVkaW8tY2FyZCxjb252ZXJ0LXJhdGU6DQo+ICAgICAgICRyZWY6ICIjL2RlZmluaXRpb25z
L2NvbnZlcnQtcmF0ZSINCj4gICAgIHNpbXBsZS1hdWRpby1jYXJkLGNvbnZlcnQtY2hhbm5lbHM6
DQo+IEBAIC0zNTksNiArMzcwLDQ4IEBAIGV4YW1wbGVzOg0KPiAgICAgICAgICAgfTsNCj4gICAg
ICAgfTsNCj4gICANCj4gKyMgLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gKyMgcm91dGUgYXVkaW8g
dG8vZnJvbSBhIGNvZGVjIHRocm91Z2ggYW4gYW1wbGlmaWVyDQo+ICsjIGRlc2lnbmVkIHdpdGgg
YSBwb3RlbnRpb21ldGVyIGRyaXZlbiBieSBJSU86DQo+ICsjIC0tLS0tLS0tLS0tLS0tLS0tLS0t
DQo+ICsgIC0gfA0KPiArICAgIHNvdW5kIHsNCj4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJzaW1w
bGUtYXVkaW8tY2FyZCI7DQo+ICsNCj4gKyAgICAgICAgc2ltcGxlLWF1ZGlvLWNhcmQsYXV4LWRl
dnMgPSA8JmFtcF9pbj4sIDwmYW1wX291dD47DQo+ICsgICAgICAgIHNpbXBsZS1hdWRpby1jYXJk
LHJvdXRpbmcgPQ0KPiArICAgICAgICAgICAgIkNPREVDIExFRlRJTiIsICJBTVBfSU4gTEVGVCBP
VVQiLA0KPiArICAgICAgICAgICAgIkNPREVDIFJJR0hUSU4iLCAiQU1QX0lOIFJJR0hUIE9VVCIs
DQo+ICsgICAgICAgICAgICAiQU1QX09VVCBMRUZUIElOIiwgIkNPREVDIExFRlRPVVQiLA0KPiAr
ICAgICAgICAgICAgIkFNUF9PVVQgUklHSFQgSU4iLCAiQ09ERUMgUklHSFRPVVQiOw0KPiArDQo+
ICsgICAgICAgIHNpbXBsZS1hdWRpby1jYXJkLGFkZGl0aW9uYWwtZGV2cyB7DQo+ICsgICAgICAg
ICAgICBhbXBfb3V0OiBpaW8tYXV4LW91dCB7DQo+ICsgICAgICAgICAgICAgICAgY29tcGF0aWJs
ZSA9ICJhdWRpby1paW8tYXV4IjsNCj4gKyAgICAgICAgICAgICAgICBpby1jaGFubmVscyA9IDwm
cG90X291dCAwPiwgPCZwb3Rfb3V0IDE+Ow0KPiArICAgICAgICAgICAgICAgIGlvLWNoYW5uZWwt
bmFtZXMgPSAiTEVGVCIsICJSSUdIVCI7DQo+ICsgICAgICAgICAgICAgICAgc25kLWNvbnRyb2wt
aW52ZXJ0LXJhbmdlID0gPDEgMT47DQo+ICsgICAgICAgICAgICAgICAgc291bmQtbmFtZS1wcmVm
aXggPSAiQU1QX09VVCI7DQo+ICsgICAgICAgICAgICB9Ow0KPiArDQo+ICsgICAgICAgICAgICBh
bXBfaW46IGlpb19hdXgtaW4gew0KPiArICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYXVk
aW8taWlvLWF1eCI7DQo+ICsgICAgICAgICAgICAgICAgaW8tY2hhbm5lbHMgPSA8JnBvdF9pbiAw
PiwgPCZwb3RfaW4gMT47DQo+ICsgICAgICAgICAgICAgICAgaW8tY2hhbm5lbC1uYW1lcyA9ICJM
RUZUIiwgIlJJR0hUIjsNCj4gKyAgICAgICAgICAgICAgICBzb3VuZC1uYW1lLXByZWZpeCA9ICJB
TVBfSU4iOw0KPiArICAgICAgICAgICAgfTsNCj4gKyAgICAgICAgfTsNCj4gKw0KPiArICAgICAg
ICBzaW1wbGUtYXVkaW8tY2FyZCxjcHUgew0KPiArICAgICAgICAgICAgc291bmQtZGFpID0gPCZj
cHU+Ow0KPiArICAgICAgICB9Ow0KPiArDQo+ICsgICAgICAgIHNpbXBsZS1hdWRpby1jYXJkLGNv
ZGVjIHsNCj4gKyAgICAgICAgICAgIHNvdW5kLWRhaSA9IDwmY29kZWM+Ow0KPiArICAgICAgICAg
ICAgY2xvY2tzID0gPCZjbG9ja3M+Ow0KPiArICAgICAgICB9Ow0KPiArICAgIH07DQo+ICsNCj4g
ICAjIC0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgIyBTYW1wbGluZyBSYXRlIENvbnZlcnNpb24N
Cj4gICAjIC0tLS0tLS0tLS0tLS0tLS0tLS0tDQo=
