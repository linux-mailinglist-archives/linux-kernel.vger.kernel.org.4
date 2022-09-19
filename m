Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BB85BD46E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 20:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbiISSG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 14:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiISSGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 14:06:42 -0400
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2137.outbound.protection.outlook.com [40.107.135.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E40845F55;
        Mon, 19 Sep 2022 11:06:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIZPmJxVoMZTmKdDric1rBZT0GYo3oXeR/Tl+nWc8MfT3H2MqbRkrbttqtDt/TRgtzV3IWyzkBBkL2LsThksLY/Yzp9S3qJ/fi1KUj0WMzYxzT6x/PaecJvr8wOOROdSrWGeJidDOP8e7S+YPoHfeifvwgLLuN0yqnDjDX42YECfPiLzKYS1x5EA+5Lpg2+p+owwce7ifrUjiJwpg3nakHBJLWUrZ9OXkLIQEQSjjzE7+gqVT7ITCWD7vW3EBQVqIE6TiWEK8d41z1L+QqUoQJ9DmlZHHLtaXt/IlR731oRE0JFf3nFETs4hpnsjekGRcc3gwhUnN7DlHDakX8UEYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPICBHa0fdFFZqj0wlR7KWfnGweRvwiMVBiwqHwK5uU=;
 b=nfAcCYdoQOz27XTGmf7j5JultSS30GBYKchtcTiSxGTKLQVQ37vCFCNliAlPcADfInB0KpeEtyaY7aD19RBH4gX6WLAIqXfcRgtfQVwNQwfe/nX53XrdbdDJ5cyl6/VenAdGSIqabTmNtp723+y3E6XNvMfJuevpMfYgEGZsPGIGy49TyViW/NCoZLaiZFl9blxQCKrG7vekZ081kXKCgii6Eqjtt7MF9DP0rs5tHPsJ+eS5cRxKGvsA7VDXd/k7UE2L+4a5Ob7PJX/5HTvc06oMIX3KF357Z/qIMgRvaec2pSZnEniSTmwlKA0+0A1FcqrnumpZbbscYnHhQ5xp6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPICBHa0fdFFZqj0wlR7KWfnGweRvwiMVBiwqHwK5uU=;
 b=Ig6AIvhIW1hB60/BlAWdcOkB7EU6yDAxuTs+MSOIG7iH3NA6iIvvtmFsuGwX6LHoDEeUyNfjigYsXl9SC/bFVFyRWL/9BkpgnWtOhKQY1OAiILNlDX9l7asSkCGdYMFYl+X0S7JAoxHvJl7aDwJPgo5Mo3Tq4kRbWhOa8u6Xpak=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by FR0P281MB3083.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:52::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Mon, 19 Sep
 2022 18:06:37 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::74b2:f96e:154d:8aa2]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::74b2:f96e:154d:8aa2%8]) with mapi id 15.20.5654.014; Mon, 19 Sep 2022
 18:06:37 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "nuno.sa@analog.com" <nuno.sa@analog.com>,
        "dragos.bogdan@analog.com" <dragos.bogdan@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: Re: [RFT] potential bug with IIO_CONST_ATTR usage with triggered
 buffers
Thread-Topic: [RFT] potential bug with IIO_CONST_ATTR usage with triggered
 buffers
Thread-Index: AQHYzAUrLaBLRu9mX0OEcWs5gsAP063m4fEAgAAdzgCAAA1TAA==
Date:   Mon, 19 Sep 2022 18:06:37 +0000
Message-ID: <ae28aca3-6834-653c-9d66-1c98b67c7d4d@fi.rohmeurope.com>
References: <20210215104043.91251-1-alexandru.ardelean@analog.com>
 <20210215104043.91251-15-alexandru.ardelean@analog.com>
 <aecd6a19-79a8-d9a6-2dc4-73dcd756c92d@fi.rohmeurope.com>
 <87fbfc8e-fb17-444d-22a2-3738ade77cb5@fi.rohmeurope.com>
 <20220919163214.5b757903@jic23-huawei> <20220919181854.01214355@jic23-huawei>
In-Reply-To: <20220919181854.01214355@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2454:EE_|FR0P281MB3083:EE_
x-ms-office365-filtering-correlation-id: 85ed73cf-35c9-4e71-bb1e-08da9a69b216
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w1dp+8A4lGOOVrGdJfch6n+fbMaZf6dS1QObLQg/gz6W2V5+qaCSq1HCYb6MasIktOA8VXdPCccJv6Uw/na1eAgxp52Uz8l4xfpUvbJ69FmP1Ru2wdErSzmvu2Loq9klnsBRT7KM7luNF2CDhV9g57tfvrYre06XpBy8f+CaKYISYvQSAjN8V66VVKCh4qfSvJsyLYoGZ/7bsFw7K8sLt41xRbznP/c0KyXr9G5YS0lw/VsbAXdTdRwzooDQ6tafj8mDv+asksragYAdfJr3Dqri4LAE0uhZHawJ6d/ZxKkSlRRqqZKBuZqcy79d/I3i1kduJ7QVgHlcIYfFEptra72NhOpvQqfX3yKHmjn+P2ToyxGca84h1hv5Jj4zxFxf/wCIIsECvgU6SM+ZUnv1ivYAPQwREumZB+a+/5MSbsNbFSObd6wOaxXeFhWQbqrGgz2f1aICwaCcrvYQ3UVKzWN24cZYVq+ndbw9U3yG+zEW25IFHqEp0UnmtSocwxq/cyXPMraH4S/0kXFuMSrnIuteAQHYsSpIqxnXsevAYFFv/NQ984GiMuObSeEIkYYxNLWdmtJCc943Y98U9JTLWMdmw1ekIjRr/uV4GGcHvBj7cIVWAPuDeHkysBuwnhOmE4h5FxZSJF2w0tkTRP0k1qAO0Fbc8P/U05TbJw0ClWfiH0XKVst4H++ddOb0EVZoyOpL6IVPPiO99iFZU1w/x3pSkA1kRiyRVQvLvs+P9yolCQ3nv29bjgmkzNJHtA1GzUBVh9fUCdvgoeM3DoF14Gg0yzFdmtXj2vC+0NCha/nrt0zQRbkOVDvJXXEvbHyK2b3LaDqY5JK+MoPIDWqxyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(396003)(39840400004)(136003)(451199015)(478600001)(41300700001)(2616005)(6486002)(71200400001)(53546011)(7416002)(2906002)(6512007)(6506007)(186003)(8936002)(316002)(91956017)(6916009)(54906003)(5660300002)(66556008)(66476007)(66446008)(76116006)(66946007)(64756008)(4326008)(8676002)(38100700002)(122000001)(83380400001)(38070700005)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVhndW4wcVFaelI5SjJyYi92YngvdmVtMWFCUTg5VHltOEV4N1JTbnUrYUpQ?=
 =?utf-8?B?S0g4S2h0d0p2L3FpLzdmOEt0Vzh0bXNUUVA4c25HM0lFUkJkTmc1dmMvZWxt?=
 =?utf-8?B?bC8wdlk4WlUvYldjNUg3MzZ0WFlzN3NUZWJVZCsxRFErdHp1c2RCeCtSWE1z?=
 =?utf-8?B?L1NqTHliZTdVWHRDYStLejQwcEhNK1hFR1d2WVB6elowZkVnS2NRRWRoaDJX?=
 =?utf-8?B?QXQzQmVIazJ1dTVZeG16aEtOMFlhZ3Z5ZlJIeUQxcVJPVWdMSmtBODVpWFBy?=
 =?utf-8?B?MGp3YzNJR1JZeEFKaGJvdVNsMHhodTNTMW1SS25aYXQ4OVpHcUk0ZU5KWHJK?=
 =?utf-8?B?KzR6ZklwaW54eEtaK2d5M1prODRHM2lMaXBDTytWa2J4TXNKSnh5T1FDL3Nl?=
 =?utf-8?B?NEV0c0tqd0NnTElKTFAxbzdvTTBMa1NxcDZadmRJdEwrNjVxMWd6SWtvdVY1?=
 =?utf-8?B?aCswU0ttMUlaTHFDYWtUZm9hWWVKMmYyRVlnR1NEQlpsaTArSkV5YVJORkJQ?=
 =?utf-8?B?Zm8vRi9Fc1d3LzFSeXphckNsZjNES3BnRElLMER5c2o4WWdKVnBJejlBVlNI?=
 =?utf-8?B?dFhFTE5Wd2NXUlV3bktUOTBWTTYxeVQ1RjlyN1V0TVcray9yWGZ0M21HckJZ?=
 =?utf-8?B?cUpLV05qR3VaSEU0eE11endqQWs4UTdzMS9UY0Y1SXJEUWVRcFJOQzJNUkh1?=
 =?utf-8?B?VERQL1JVRjFWdlcrU0dOa0VDa2NvSFE2NHlPNTEvSzVDeElTT1lqU1Rmb1Bw?=
 =?utf-8?B?WGNxZDAwaUxjNXNYWDNYOHdoTjhucHR6VFRlL3gwampvRTR1MVB4c3ZMYjdu?=
 =?utf-8?B?bDcyaWRyc0l1SWFCN3h0bzY3anVHT2g3VmdLYUtFNEhiVlF6U0MrVVVLTXNw?=
 =?utf-8?B?SVJpQkZQNnZCOUQ3am94ZGlENUxuOTRaMHMya09udlV3N2lmZHRsYUFrUksx?=
 =?utf-8?B?VFFjbHAzQ3hMcW44enV5SDVWbnVXQVE2dUIrRDIra2Qycng2K29hRHNMaHhW?=
 =?utf-8?B?cnRESjV2WEVRdkNOakVDQ3RlVUhsaE1VSTRxVkd0MkVab3BZb3lrTzhsNE5O?=
 =?utf-8?B?MVdPM3c3WDBVRUxYVlVtRWVlYjQrSVdpcnVUb0h3cmZuVTRuNm9vS21lZGpL?=
 =?utf-8?B?RXlGdXFxZDFjS0V0UlV5KysvSEpZa0I3elRtOXN6L3h2bHFhWWpjcWEyR2c2?=
 =?utf-8?B?UStnVVJ1UjlvRG1sdmt1aTBmUzlBemlITUk5R2Z3UEdIdm5qNXZoeUE5bWE3?=
 =?utf-8?B?T3hsSFhQaEpLOFJzZ1B0MXd5QWJoVm05UnhFdGl2TnJwZGsvOERHK1VSeHpP?=
 =?utf-8?B?WWxyaFJiMmdkaTM2UWlXdmNSUXNHVzRFR0JDZ0hBcnJNTnQxK3YrdVZZUTRL?=
 =?utf-8?B?VTY4dUxsWVFoYWl1SkdyWkVYOGxVcHllcEI0MU55WU0vNjl6dVFhd0hOSzJr?=
 =?utf-8?B?Tm1vZ1JtTW9pbmJmZ2xaQ0tXS0UvK2F6dVJxaDZiSUhmcDNHZEFWRXE4ZEJK?=
 =?utf-8?B?WjlYaFlsMXN2Nm5xYk0xSmZhazBVQUYybUd1bmk0S3VreGZJV3ZMaFFTR2cy?=
 =?utf-8?B?Sks4NmZvWDB4czdDSk1SM2RuaUZDQTJyMlMzcjMveHlnMkFmZEdpRDlkWmYx?=
 =?utf-8?B?eXNwWlVHOHdzY2RDbUhHNWFHNXIxalBGSFFPRkZQYW5RTk45U0dTb1lWdUVH?=
 =?utf-8?B?UGcrWDg2RkhpVGZHK1IrY2x0akVUQWVYd3pRNmd5czFKc2NKUzloQ0UzZVBo?=
 =?utf-8?B?YnljUXF4RUpWREo3L3NKTTFFbVp4Q3Qvckl6THhRZmlWc3M5aGVZMG50eEIv?=
 =?utf-8?B?Y0RXUFhHYm9GSFRqckgwcXR4UXRRVjFoOWxQU1E3ekRhOFFiSE9mNGN0bWh6?=
 =?utf-8?B?cGhKTms3amtST1Q1WnplRXBUcjBHRUdCSnJlNDVBR3hoMkpOK3gxSFVYb2ov?=
 =?utf-8?B?bTRYcU1mbmNmTFpoanE5YkJ5UFNIUU5SU1ZJVXpORll3QVh4U2VLU2FwajZH?=
 =?utf-8?B?eG1zZ0ZlUXdlSHdGU0hnQUxCK0huN094ek9PeUYxMTlmUnFaeDlRcUN2dUtD?=
 =?utf-8?B?TXB1VzB6TnRHZnBGSkZGQ1NUbDZWOVVIc2x2eHlOOFNGdFNEMm9oeEMvdTc0?=
 =?utf-8?B?TEl2dzFqenA5akdaWUFzZU5NTmtyNXc5Q21SRTBXdGswVkNtVlhKbEF1OXRw?=
 =?utf-8?Q?esSgbVt3n2ZlLl5P3/LPsLY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F8DB1F07513D94B9E7DC9AF19CC4765@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB3083
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8xOS8yMiAyMDoxOCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gT24gTW9uLCAxOSBT
ZXAgMjAyMiAxNjozMjoxNCArMDEwMA0KPiBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwu
b3JnPiB3cm90ZToNCj4gDQo+PiBPbiBNb24sIDE5IFNlcCAyMDIyIDA4OjUyOjM4ICswMDAwDQo+
PiAiVmFpdHRpbmVuLCBNYXR0aSIgPE1hdHRpLlZhaXR0aW5lbkBmaS5yb2htZXVyb3BlLmNvbT4g
d3JvdGU6DQo+Pg0KPj4+IE9uIDkvOS8yMiAxMToxMiwgVmFpdHRpbmVuLCBNYXR0aSB3cm90ZToN
Cj4+Pj4gSGkgZGVlIEhvIHBlZXBzIQ0KPj4+Pg0KPj4+PiBEaXNjbGFpbWVyIC0gSSBoYXZlIG5v
IEhXIHRvIHRlc3QgdGhpcyB1c2luZyByZWFsIGluLXRyZWUgZHJpdmVycy4gSWYNCj4+Pj4gc29t
ZW9uZSBoYXMgYSBkZXZpY2Ugd2l0aCBhIHZhcmlhbnQgb2YgYm1jMTUwIG9yIGFkeGwzNzIgb3Ig
IC0gaXQnZCBiZQ0KPj4+PiBuaWNlIHRvIHNlZSBpZiByZWFkaW5nIGh3Zmlmb193YXRlcm1hcmtf
bWF4IG9yIGh3Zmlmb193YXRlcm1hcmtfbWluDQo+Pj4+IHdvcmtzIHdpdGggdGhlIHY2LjAtcmM0
LiBNYXliZSBJIGFtIG1pc3JlYWRpbmcgY29kZSBhbmQgaGF2ZSBteSBvd24NCj4+Pj4gaXNzdWVz
IC0gaW4gd2hpY2ggY2FzZSBJIGFwb2xvZ2l6ZSBhbHJlYWR5IG5vdyBhbmQgZ28gdG8gdGhlIGNv
cm5lcg0KPj4+PiB3aGlsZSBiZWluZyBkZWVwbHkgYXNoYW1lZCA6KQ0KPj4+DQo+Pj4gSSB3b3Vs
ZCBsaWtlIHRvIGFkZCBhdCBsZWFzdCB0aGUgYXQ5MS1zYW1hNWQyX2FkYyAoY29uZGl0b25hbGx5
DQo+Pj4gcmVnaXN0ZXJzIHRoZSBJSU9fQ09OU1RfQVRUUiBmb3IgdHJpZ2dlcmVkLWJ1ZmZlcikg
dG8gdGhlIGxpc3Qgb2YNCj4+PiBkZXZpY2VzIHRoYXQgY291bGQgYmUgcG90ZW50aWFsbHkgdGVz
dGVkLiBJIGhvcGUgc29tZSBvZiB0aGVzZSBkZXZpY2VzDQo+Pj4gaGFkIGEgdXNlciB3aG8gY291
bGQgZWl0aGVyIG1ha2UgdXMgd29ycmllZCBhbmQgdmVyaWZ5IG15IGFzc3VtcHRpb24gLQ0KPj4+
IG9yIG1ha2UgbWUgYXNoYW1lZCBidXQgcmVzdCBvZiB1cyByZWxpZXZlZCA6KSBFZyAtIEkgc2Vj
b25kIG15IHJlcXVlc3QNCj4+PiBmb3IgdGVzdGluZyB0aGlzIC0gYW5kIGFkZCBwb3RlbnRpYWwg
b3duZXJzIG9mIGF0OTEtc2FtYTVkMl9hZGMgdG8gdGhlIGxpc3QuDQo+Pj4gICAgDQo+Pj4+IE9u
IDIvMTUvMjEgMTI6NDAsIEFsZXhhbmRydSBBcmRlbGVhbiB3cm90ZToNCj4+Pj4+IFRoaXMgY2hh
bmdlIHdyYXBzIGFsbCBidWZmZXIgYXR0cmlidXRlcyBpbnRvIGlpb19kZXZfYXR0ciBvYmplY3Rz
LCBhbmQNCj4+Pj4+IGFzc2lnbnMgYSByZWZlcmVuY2UgdG8gdGhlIElJTyBidWZmZXIgdGhleSBi
ZWxvbmcgdG8uDQo+Pj4+Pg0KPj4+Pj4gV2l0aCB0aGUgYWRkaXRpb24gb2YgbXVsdGlwbGUgSUlP
IGJ1ZmZlcnMgcGVyIG9uZSBJSU8gZGV2aWNlLCB3ZSBuZWVkIGEgd2F5DQo+Pj4+PiB0byBrbm93
IHdoaWNoIElJTyBidWZmZXIgaXMgYmVpbmcgZW5hYmxlZC9kaXNhYmxlZC9jb250cm9sbGVkLg0K
Pj4+Pj4NCj4+Pj4+IFdlIGtub3cgdGhhdCBhbGwgYnVmZmVyIGF0dHJpYnV0ZXMgYXJlIGRldmlj
ZV9hdHRyaWJ1dGVzLg0KPj4+Pg0KPj4+PiBJIHRoaW5rIHRoaXMgYXNzdW1wdGlvbiBpcyBzbGln
aHRseSB1bnNhZmUuIEkgc2VlIGZldyBkcml2ZXJzIGFkZGluZw0KPj4+PiBJSU9fQ09OU1RfQVRU
UnMgaW4gYXR0cmlidXRlIGdyb3Vwcy4gRm9yIGV4YW1wbGUgdGhlIGJtYzE1MCBhbmQgYWR4bDM3
Mg0KPj4+PiBhZGQgdGhlIGh3Zmlmb193YXRlcm1hcmtfbWluIGFuZCBod2ZpZm9fd2F0ZXJtYXJr
X21heC4NCj4+Pj4gICAgIA0KPj4+DQo+Pj4gYW5kIGF0OTEtc2FtYTVkMl9hZGMNCj4+Pg0KPj4+
IC8vc25pcA0KPj4+ICAgIA0KPj4+PiBJIG5vdGljZWQgdGhhdCB1c2luZw0KPj4+PiBJSU9fQ09O
U1RfQVRUUnMgZm9yIHRyaWdnZXJlZCBidWZmZXJzIHNlZW0gdG8gY2F1c2UgYWNjZXNzIHRvIHNv
bWV3aGVyZQ0KPj4+PiBpdCBzaG91bGRuJ3QuLi4gT29wcy4NCj4+Pj4NCj4+Pj4gUmVhZGluZyB0
aGUgY29kZSBhbGxvd3MgbWUgdG8gYXNzdW1lIHRoZSBwcm9ibGVtIGlzIHdyYXBwaW5nIHRoZQ0K
Pj4+PiBhdHRyaWJ1dGVzIHRvIElJT19ERVZfQVRUUnMuDQo+Pj4+DQo+Pj4+IHN0YXRpYyBzdHJ1
Y3QgYXR0cmlidXRlICppaW9fYnVmZmVyX3dyYXBfYXR0cihzdHJ1Y3QgaWlvX2J1ZmZlciAqYnVm
ZmVyLA0KPj4+PiArCQkJCQkgICAgICBzdHJ1Y3QgYXR0cmlidXRlICphdHRyKQ0KPj4+PiArew0K
Pj4+PiArCXN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICpkYXR0ciA9IHRvX2Rldl9hdHRyKGF0dHIp
Ow0KPj4+PiArCXN0cnVjdCBpaW9fZGV2X2F0dHIgKmlpb19hdHRyOw0KPj4+PiArDQo+Pj4+ICsJ
aWlvX2F0dHIgPSBremFsbG9jKHNpemVvZigqaWlvX2F0dHIpLCBHRlBfS0VSTkVMKTsNCj4+Pj4g
KwlpZiAoIWlpb19hdHRyKQ0KPj4+PiArCQlyZXR1cm4gTlVMTDsNCj4+Pj4gKw0KPj4+PiArCWlp
b19hdHRyLT5idWZmZXIgPSBidWZmZXI7DQo+Pj4+ICsJbWVtY3B5KCZpaW9fYXR0ci0+ZGV2X2F0
dHIsIGRhdHRyLCBzaXplb2YoaWlvX2F0dHItPmRldl9hdHRyKSk7DQo+Pj4+DQo+Pj4+IFRoaXMg
Y29weSBkb2VzIGFzc3VtZSBhbGwgYXR0cmlidXRlcyBhcmUgZGV2aWNlX2F0dHJzLCBhbmQgZG9l
cyBub3QgdGFrZQ0KPj4+PiBpbnRvIGFjY291bnQgdGhhdCBJSU9fQ09OU1RfQVRUUlMgaGF2ZSB0
aGUgc3RyaW5nIHN0b3JlZCBpbiBhIHN0cnVjdA0KPj4+PiBpaW9fY29uc3RfYXR0ciB3aGljaCBp
cyBjb250YWluaW5nIHRoZSBkZXZfYXR0ci4gRWcsIGNvcHlpbmcgaW4gdGhlDQo+Pj4+IGlpb19i
dWZmZXJfd3JhcF9hdHRyKCkgZG9lcyBub3QgY29weSB0aGUgc3RyaW5nIC0gYW5kIGxhdGVyIGlu
dm9raW5nIHRoZQ0KPj4+PiAnc2hvdycgY2FsbGJhY2sgZ29lcyByZWFkaW5nIHNvbWV0aGluZyBl
bHNlIHRoYW4gdGhlIG1lbnRpb25lZCBzdHJpbmcNCj4+Pj4gYmVjYXVzZSB0aGUgcG9pbnRlciBp
cyBub3QgY29waWVkLg0KPj4+DQo+Pj4gWW91cnMsDQo+Pj4gCS0tIE1hdHRpDQo+PiBIaSBNYXR0
aSwNCj4+DQo+PiArQ0MgQWxleGFuZHJ1IG9uIGEgY3VycmVudCBlbWFpbCBhZGRyZXNzLg0KPj4N
Cj4+IEkgc2F3IHRoaXMgd2hpbHN0IHRyYXZlbGxpbmcgYW5kIGNvbXBsZXRlbHkgZm9yZ290IGFi
b3V0IHdoZW4NCj4+IEkgd2FzIGJhY2sgdG8gbm9ybWFsIC0gc28gZ3JlYXQgeW91IHNlbnQgYSBm
b2xsb3cgdXAhDQoNCkkgd2FzIGFsc28gcGFydGljaXBhdGluZyBhdCBFTENFIGxhc3Qgd2VlayBz
byBkaWRuJ3QgZG8gbXVjaCBvZiBlbWFpbHMvY29kZS4NCg0KPj4NCj4+IEFueWhvdywgeW91ciBy
ZWFzb25pbmcgc2VlbXMgY29ycmVjdCBhbmQgaXQgd291bGQgYmUgZWFzeSBlbm91Z2gNCj4+IHRv
IGFkZCBzdWNoIGEgY2FzZSB0byBpaW8vZHVtbXkvaWlvX3NpbXBsZV9kdW1teV9idWZmZXIuYyBh
bmQNCj4+IHByb3ZpZGUgYSBjbGVhciB0ZXN0IGZvciB0aGUgcHJvYmxlbS4NCj4+DQo+PiBBcyB0
byBzb2x1dGlvbnMuIFRoZSBxdWlja2VzdCBpcyBwcm9iYWJseSB0byBzd2l0Y2ggdGhlc2UgY29u
c3QgYXR0cnMNCj4+IG92ZXIgdG8gYSBub24gY29uc3QgZm9ybSBhbmQgYWRkIGEgY29tbWVudCB0
byB0aGUgaGVhZGVyIHRvIHNheSB0aGV5IGFyZQ0KPj4gdW5zdWl0YWJsZSBmb3IgdXNlIHdpdGgg
YnVmZmVycy4NCj4gDQo+IFRoaW5raW5nIGEgbGl0dGxlIG1vcmUgb24gdGhpcyAtIGFsbCAvICht
b3N0Pykgb2YgdGhlIHVzZXJzIHBhc3MgYSBudWxsIHRlcm1pbmF0ZWQNCj4gYXJyYXkgb2Ygc3Ry
dWN0IGRldmljZV9hdHRyaWJ1dGUgKiB0byAqaWlvX3RyaWdnZXJlZF9idWZmZXJfc2V0dXBfZXh0
KCkNCj4gDQo+IFRoYXQncyB0aGVuIGFzc2lnbmVkIHRvIGJ1ZmZlci0+YXR0cnMuDQo+IFdlIGNv
dWxkIGFkZCBhbiBhZGRpdGlvbmFsIHBvaW50ZXIgdG8gdGhlIHN0cnVjdCBpaW9fYnVmZmVyIHRv
IHRha2UNCj4gYSBudWxsIHRlcm1pbmF0ZWQgYXJyYXkgb2Ygc3RydWN0IGlpb19kZXZfYXR0ciAq
DQo+IGFuZCBjaGFuZ2UgdGhlIHNpZ25hdHVyZSBvZiB0aGF0IGZ1bmN0aW9uIHRvIHRha2Ugb25l
IG9mIHRob3NlLCB0aHVzDQo+IHByZXZlbnRpbmcgdXMgdXNpbmcgaWlvX2NvbnN0X2F0dHIgc3Ry
dWN0dXJlcyBmb3IgdGhpcy4NCg0KWWVzLiBJIHdvdWxkIGFsc28gcmF0aGVyIHNlZSBwb2ludGVy
IHRvIGFycmF5IG9mIHN0cnVjdCBpaW9fZGV2X2F0dHIgKiANCmlmIHdlIGNvbnRpbnVlIGtlZXBp
bmcgdGhlIGFzc3VtcHRpb24gdGhhdCBhdHRycyBhcmUgb2YgdHlwZSBpaW9fZGV2X2F0dHIuDQoN
Cj4gDQo+IFRoZW4gd2UgY2FuIHdyYXAgdGhvc2UganVzdCBmaW5lIGluIHRoZSBjb2RlIHlvdSBo
aWdobGlnaHRlZCBhbmQgYXNzaWduIHRoZQ0KPiByZXN1bHQgaW50byBidWZmZXItPmF0dHJzLg0K
PiANCj4gV2UnZCBuZWVkIHRvIHByZWNlZGUgdGhhdCBjaGFuZ2Ugd2l0aCBmaXhlcyB0aGF0IGp1
c3Qgc3dpdGNoIHRoZQ0KPiBpaW9fY29uc3RfYXR0ciB1c2VzIG92ZXIgdG8gaWlvX2Rldl9hdHRy
IGJ1dCBjaGFuZ2luZyB0aGlzIHdvdWxkIGVuc3VyZSBubw0KPiBhY2NpZGVudGFsIHJlaW50cm9k
dWN0aW9ucyBvZiB0aGUgcHJvYmxlbSBpbiBmdXR1cmUgZHJpdmVycyAodHlwaWNhbGx5DQo+IGFz
IGEgcmVzdWx0IG9mIHNvbWVvbmUgZm9yd2FyZCBwb3J0aW5nIGEgZHJpdmVyIHRoYXQgaXMgb3V0
IG9mIHRyZWUpLg0KDQpBZ2FpbiBJIGRvIGFncmVlLiBCZXNpZGVzIGNoYW5nZSBvZiBjb25zdF9h
dHRycyBpcyBuZWNlc3NhcnkgaW4gYW55IGNhc2UgDQppZiB3ZSBkb24ndCBjaGFuZ2UgdGhlIHdy
YXBwaW5nLg0KDQo+Pg0KPj4gV291bGQgeW91IGxpa2UgdG8gc2VuZCBwYXRjaGVzIGdpdmVuIHlv
dSBpZGVudGlmaWVkIHRoZSBwcm9ibGVtPw0KDQpJIGFtIGluIGFueSBjYXNlIGFib3V0IHRvIHNl
bmQgY291cGxlIG9mIHBhdGNoZXMgdG8gSUlPLiBUaGUgZGV2bS1oZWxwZXIgDQp1c2FnZSAodjIg
LSBJIHNlbnQgdjEgZnJvbSBteSBvdGhlciBlbWFpbCBhZGRyZXNzIChtYXp6aWVzYWNjb3VudCkg
LSBidXQgDQpJIGFtIHRoZSBzYW1lIHBlcnNvbiA6XSApIGFuZCBhIG5ldyBhY2NlbGVyb21ldGVy
IGRyaXZlci4gU28sIEkgY2FuIGxvb2sgDQphbHNvIGF0IHRoaXMgY2hhbmdlIHdoaWxlIEkgYW0g
YXQgaXQgaWYgeW91J3JlIGJ1c3kpLg0KDQo+PiBJZiBub3QgSSdtIGhhcHB5IHRvIGZpeCB0aGVz
ZSB1cC4gTXkgZ3JlcHBpbmcgaWRlbnRpZmllZCB0aGUgc2FtZSAzIGNhc2VzDQo+PiB5b3UgZm91
bmQuDQoNCkZlZWwgZnJlZSB0byBwYXRjaCB0aGlzIGlmIHlvdSB3aXNoLiBKdXN0IHBsZWFzZSBs
ZXQgbWUga25vdyBpZiB5b3UgdGFrZSANCmNhcmUgb2YgdGhpcyBzbyB3ZSBkb24ndCBkbyBkb3Vi
bGUgdGhlIHdvcmsgOikNCg0KWW91cnMNCgktLSBNYXR0aQ0KDQoNCi0tIA0KTWF0dGkgVmFpdHRp
bmVuDQpMaW51eCBrZXJuZWwgZGV2ZWxvcGVyIGF0IFJPSE0gU2VtaWNvbmR1Y3RvcnMNCk91bHUg
RmlubGFuZA0KDQp+fiBXaGVuIHRoaW5ncyBnbyB1dHRlcmx5IHdyb25nIHZpbSB1c2VycyBjYW4g
YWx3YXlzIHR5cGUgOmhlbHAhIH5+DQo=
