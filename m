Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CD66F4FAB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 07:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjECFMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 01:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjECFMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 01:12:00 -0400
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2128.outbound.protection.outlook.com [40.107.135.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EE81FCF;
        Tue,  2 May 2023 22:11:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COvPnYI9oVPBpBqimNz1Sg0KQ4fWHsYrD9IAtIcLAlKqzR357q+cD8K1eQ5oTQ0TVNyc3MUmsgh33KDgnalzC1rwJSawqcvGNCqDvrDlbgexGEjoIqV949J0SaHXVW+Fv92+/cEpQYbaibf137MuB2pgqa6QhRjIap+ysDZkUj41QlCTptfdNMoVADvPGNC8Fwq69G5w+bydhN4oTyno9bZB8yzikIPxlyk7nk+Tuhxw/xEOlTty92GGg/yU6G4h/Vh9MMlC8mDB9Pf1LZ1IouwINMrl/YSJUaB4iQnFXHpU+0fZaBIBYhhdlK90DyQR/9fzmG+Gf0eW0AEHvkY41w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvDKAWlmaHol23mWkw9LzZ6Hc5iME2qigUE0oK/91IM=;
 b=PXRzxLdGbp77jIU34dQDEU2i9XXZ3wZfX7/yaDvJ6cQtKpUNtloBjlZjreZfFOwhLEEBeEyKEvwizQAlr8isOqISCYrprp4pkp/u5vTQ2LJbggQyDqsS2UjuTUarpvJQ6HsDQXqHJlCpob8WoxSNS/edSjYTFkuf6148cdCrUJ3Y923HZfZjP6YrH6VNB5rLVT6Vr1KwP5fdpi5bTWrMj/Wr8PxOuNAWDxaPldOXHBzYPO9GdauYnrHbxqbA5keiCeo/JM4rz4to27F462uMPEK2FUtjvMRFDVzrRX8tqEfM2BTH7NDaKt96U8dmJqaAsVa5VnrNYU4wjoxLCCnM0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvDKAWlmaHol23mWkw9LzZ6Hc5iME2qigUE0oK/91IM=;
 b=qzYgFznQ70J6sgAVCz4JDLZGrWuNjtN9hZux/DXTjnjG2pix7EYCOYlKiXDON2I6jtzkarhZZI1NExXGSsOafVAtqhtrA2h94dIARndxWzR3kaTzms77IwxidvSYLJj+orctZWIEp5vqppDxac11CvImryUHotjnzu5H/OoAcmk=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by BE1P281MB1458.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:16::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.28; Wed, 3 May
 2023 05:11:54 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::4218:fb63:61ae:c42a]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::4218:fb63:61ae:c42a%5]) with mapi id 15.20.6363.021; Wed, 3 May 2023
 05:11:53 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH v3 4/5] iio: light: ROHM BU27008 color sensor
Thread-Topic: [PATCH v3 4/5] iio: light: ROHM BU27008 color sensor
Thread-Index: AQHZeBZK8Xh3LhqzG0GtS1tlBKbJKq9HfHIAgACO7YA=
Date:   Wed, 3 May 2023 05:11:53 +0000
Message-ID: <307cc8ce-6178-7a86-2c90-eaf0ac8c122d@fi.rohmeurope.com>
References: <cover.1682495921.git.mazziesaccount@gmail.com>
 <fb35de40a3908988f5f83e25d17119e6944d289b.1682495921.git.mazziesaccount@gmail.com>
 <ZFF1NMaR1RYThcSB@smile.fi.intel.com>
In-Reply-To: <ZFF1NMaR1RYThcSB@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2454:EE_|BE1P281MB1458:EE_
x-ms-office365-filtering-correlation-id: 2d669353-d411-4ca8-8f2b-08db4b94e8e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZKkqZ2N0OW5+0xeUlN3bQ1GiFLYLeEa1Rq2DFnSoreYsVq4GbuEhwWto8Cbc8OLDQCDGiCZqlfJCbdHOV0s0x0krDiRKfsdOIEsGukqbrqvtmqvao8r9DQE1bqzBl9jS4Im5q/7DNB5xwu3vimKK40hrGB4r9/7Ag46y5F9z38gXHtQECad+7XV48z6NJJ1GXJeq9OfFniLUnfby7HtwEMnwpvmppn4quOXHwcqyR81pqOYmeV+3eEBFahwJSQF3U8JYJgwNY8UzNwQXXtDhc1qTZhTOa7inJXSJWfqb2cThr1pTAXCeBuzc5uFr3/mxO/9kCbihYd/xFW6/55anSF5AyCT+MMIdLnAYmugawehFaqe89k4N2eTnZCaAF0fUfh4h3Xvdy0wY9G1S5ci0/Antw4R8B22sAp5aTLZ7ZJrnQ+EcPc/GeD8BJ1IsD+Y5/fhjSLBJNhttFzI5GWRmzgqH3IhSmaynzWJIpcB5hftAhmzHZbp4FFUkYHjp9CU842GCF73+Sq2P7vT9rW7fxG/8Gjs2c8fUeMmet7N4WjxyI+7u4PO+GtmrunTMsIXFOYGbcimLLDwO7LvcLhOLmjlmLfrzygOxI3gAFKqfFpT1bJvTpJfva4xKnfTF8p+F8UQ26IQQ+enVfa1BoB5peniGFksGVmcLadES4dIeWd9qbra/vPA620yTDC2VouMT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(346002)(39850400004)(136003)(451199021)(5660300002)(7416002)(91956017)(4326008)(86362001)(31696002)(2616005)(122000001)(6512007)(186003)(53546011)(6506007)(26005)(38100700002)(38070700005)(8936002)(478600001)(8676002)(54906003)(110136005)(6486002)(316002)(41300700001)(71200400001)(66476007)(76116006)(66946007)(31686004)(64756008)(66446008)(66556008)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjVjMytFelpUczkrQUhYdm5rTE0xbDBjaE1Xa3ZYVWl0RTBHVy9rc3Vyalhp?=
 =?utf-8?B?ZTFVcW9oK09SVHpmc2V3QllyZzRRRE92dE1LTlpabG5jWGdZTVBMN2YrRWwv?=
 =?utf-8?B?U3FVVCtuQTgvU29ISUlKeDFqRmhDdDN6YkROZ09xV01wOU5OQjlZZUIxVUNw?=
 =?utf-8?B?bzUxbVhtZkVhNnBHSDRHM3VMMno1VlpMVEtTRTlaOEhoZUQwc3g5N1FRQlk3?=
 =?utf-8?B?cCtKSG96dStiaW95UVI3U1lYc3ZlQ0NacjlVS05URjY1TnUxVGM5cG9kWlZP?=
 =?utf-8?B?YVpneWJnRXBXcjZEaHhNRDJCcjNOQjNMTEg5Skx3d2ZyUENiSmZXaHdmeHQ0?=
 =?utf-8?B?RXZTcXp2STQyd0pWYkxlcG8xT0lLYXBMOW1lTWRZVlAycFlZR0haM0luQ2d1?=
 =?utf-8?B?cWc4aVhLTzF2TjdJdXVaYUdYY1JGa0h1UW5EOWFNL0hMdG1zVy94N21XYjZk?=
 =?utf-8?B?TWVIaFM3WFFaT3Z6U1hEYWE1NTFWa3pLdUt0YjZiZmFjalhSZUFKaDExdFUv?=
 =?utf-8?B?RnR5L0RKMWJ0RW1MWDRFdnA0WmlsamNSYW5xUEU0aTFybmF3TTRCeXNvWHF0?=
 =?utf-8?B?NlVndndkU3dIbkJHYVNrRDhxTjFFMW9NWW1waENlTmJJWVNLNGZXTm15WklJ?=
 =?utf-8?B?cHhVUW1OMmVaMkE3TUhYOFlYOVh2TGF0dVVNQW11MDNQN0tzYzlua1VkTWpJ?=
 =?utf-8?B?MGo5dmVUWDM1SnZzdGljN2wrZTBOSEE5VHd3UlgrOHM0NmNxNk5jWG16N1Uv?=
 =?utf-8?B?ZyswWllxd2g1TjhYOGJHM0swZnUrMkJXcVp0YUJSYjBBUjdGbERvdDh6Znhi?=
 =?utf-8?B?U21vVEd3RWRKYTZiaWFOQ25VOEIrU1lrSXRzaDRBNTBBU242U0lMbUpzUE9p?=
 =?utf-8?B?RUY4ckhsbG0wcUFGTnFRV1pYeTFtWnFpQ1l1cXJSaFVFbnVmZVAzWGhuYTc3?=
 =?utf-8?B?RGJaRGdGYW1ob3dMUmkzRVFnUmQ0TVNYOU1CT0lQZVBuK2pYZUdSR0ErbElF?=
 =?utf-8?B?RFYrL0tNUjQ1QnlDcU9KNmFwOFRTeC9WM1FKRUcya0hjWnR4dnlsRHpISGtQ?=
 =?utf-8?B?UGJJS0xQZm0ySGtKNDRTK2MxRlZVNVdmdnhCTUpIcmRvdTVPdVluZFlFWVhD?=
 =?utf-8?B?V2FaVkt6cTlNVTYrYVlJdWRDZU8wNUNHM2ZMYkZ2cTczdjhXZlpZbHFMV2ZZ?=
 =?utf-8?B?a3F1by9sVWFRYWxsTU9vY2xISCtUTWZRWjkvdWxxVUoxV2JzL0VWMW14eHg3?=
 =?utf-8?B?TXpnSVBpcGt3L05CVENTQUp4a20yTEZFd0FpS0V4eEN5dlFnNVhOcUhDZ3k0?=
 =?utf-8?B?Z2ZMOTF6d3pkamNvcEx1UUhpN1pvSjRub213S1FNL2tERTJBVmNpNXN6NDNj?=
 =?utf-8?B?NDl1d0ZTek1lcnJROXNiRnVLTFlzd3BITzh6cVFPb3FYOUVNdE5vQUdNV2Uz?=
 =?utf-8?B?QUJsWlM3SVZTUkNWRWhnZlpJMzg1eEtrSkwyZWJsb05BQWExNVQ0UnNINXdm?=
 =?utf-8?B?OHZ3RTdsVW1WTTllNi9tVGh2L1dOWGpFelNjY1h2em9kZ2JzaHRqRXVxNVJr?=
 =?utf-8?B?dVZIeUtuaHFYdDBhaDZUVDdvN0h0U0RVMHk4a051ZDQ1WWRjWTB1SFhnY1Fo?=
 =?utf-8?B?NVBIZ3F4UnBsdExpb2ZyZ1pJcUV5bm96QWFQM1drMDl3OWpVN1ZnZytJZ09r?=
 =?utf-8?B?QUQ4c2orU3M4cHdrTlVIYUhVR0Z0UHRXWG9MRUVRem85cnpKQk5lT0V6N0xK?=
 =?utf-8?B?c05lN0s3K0o2SmIrVVljSFIrL1VpWlpjVWNBUW8zYnFMNGRuTFpNWitHcXdr?=
 =?utf-8?B?WEoyUEVwaWx5YkQ0STVJdytsSW16eHNRNkxFdWl4TzdoTHNEVFl4L1cySlNu?=
 =?utf-8?B?eXhwYklIMG80TXhLdW5LazZFRmZueWdFeFdzZGtjRWtNVzhSSUJQSFh1eGZG?=
 =?utf-8?B?Nkt0OHR5OUptMzllZ0pvVmxWQkl2eDFkMUNBNW5iZ1NZWHhGSFkxaTR3aG5L?=
 =?utf-8?B?TlAyMU5RZ0xzL3Z4UVBpUksyR2FTbk5VaUZrUTJZclFUbGxyQXV2WUdoYm1r?=
 =?utf-8?B?cHppcituRkQ1OG9WY0E4T1BNMmpQVG5mU1pBdGRmaENQNWJVUU1kZ1p0RXNQ?=
 =?utf-8?B?d2dQenU2NUtiTEZ1cTBGdHFCV2NZeGJwMEhRWGZCWkJ5Q0xNRCtWeTNjNnM4?=
 =?utf-8?B?QVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26C6F6CF1762394D9FB04732087AAC63@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d669353-d411-4ca8-8f2b-08db4b94e8e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 05:11:53.6975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +5Ywx52I2diIAc+hHFGaUDq5w5Jdy+sEzQxQ3NRJita45r33vbsSLxuL0drpKiUzMDxlFep+oxGZ5tsetY6CPWGEDnyR0DipVNV/0TyenVGAfZfVWz1sRhmneEYaUd8/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB1458
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5keQ0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNCk9uIDUvMi8yMyAyMzo0MCwgQW5k
eSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBPbiBXZWQsIEFwciAyNiwgMjAyMyBhdCAxMTowODoxN0FN
ICswMzAwLCBNYXR0aSBWYWl0dGluZW4gd3JvdGU6DQo+PiBUaGUgUk9ITSBCVTI3MDA4IGlzIGEg
c2Vuc29yIHdpdGggNSBwaG90b2Rpb2RlcyAocmVkLCBncmVlbiwgYmx1ZSwgY2xlYXINCj4+IGFu
ZCBJUikgd2l0aCBmb3VyIGNvbmZpZ3VyYWJsZSBjaGFubmVscy4gUmVkIGFuZCBncmVlbiBiZWlu
ZyBhbHdheXMNCj4+IGF2YWlsYWJsZSBhbmQgdHdvIG91dCBvZiB0aGUgcmVzdCB0aHJlZSAoYmx1
ZSwgY2xlYXIsIElSKSBjYW4gYmUNCj4+IHNlbGVjdGVkIHRvIGJlIHNpbXVsdGFuZW91c2x5IG1l
YXN1cmVkLiBUeXBpY2FsIGFwcGxpY2F0aW9uIGlzIGFkanVzdGluZw0KPj4gTENEIGJhY2tsaWdo
dCBvZiBUVnMsIG1vYmlsZSBwaG9uZXMgYW5kIHRhYmxldCBQQ3MuDQo+Pg0KPj4gQWRkIGluaXRp
YWwgc3VwcG9ydCBmb3IgdGhlIFJPSE0gQlUyNzAwOCBjb2xvciBzZW5zb3IuDQo+PiAgIC0gcmF3
X3JlYWQoKSBvZiBSR0IgYW5kIGNsZWFyIGNoYW5uZWxzDQo+PiAgIC0gdHJpZ2dlcmVkIGJ1ZmZl
ciB3LyBEUkRZIGludGVycnR1cHQNCj4gDQo+IC4uLg0KPiANCj4+ICtlbnVtIHsNCj4+ICsJQlUy
NzAwOF9SRUQsCS8qIEFsd2F5cyBkYXRhMCAqLw0KPj4gKwlCVTI3MDA4X0dSRUVOLAkvKiBBbHdh
eXMgZGF0YTEgKi8NCj4+ICsJQlUyNzAwOF9CTFVFLAkvKiBkYXRhMiwgY29uZmlndXJhYmxlIChi
bHVlIC8gY2xlYXIpICovDQo+PiArCUJVMjcwMDhfQ0xFQVIsCS8qIGRhdGEyIG9yIGRhdGEzICov
DQo+PiArCUJVMjcwMDhfSVIsCS8qIGRhdGEzICovDQo+PiArCUJVMjcwMDhfTlVNX0NIQU5TDQo+
IA0KPiBXaHkgbm90IGNvbnZlcnRpbmcgY29tbWVudHMgdG8gYSBrZXJuZWwtZG9jPw0KPiANCj4+
ICt9Ow0KPj4gKw0KPj4gK2VudW0gew0KPj4gKwlCVTI3MDA4X0RBVEEwLCAvKiBBbHdheXMgUkVE
ICovDQo+PiArCUJVMjcwMDhfREFUQTEsIC8qIEFsd2F5cyBHUkVFTiAqLw0KPj4gKwlCVTI3MDA4
X0RBVEEyLCAvKiBCbHVlIG9yIENsZWFyICovDQo+PiArCUJVMjcwMDhfREFUQTMsIC8qIElSIG9y
IENsZWFyICovDQo+PiArCUJVMjcwMDhfTlVNX0hXX0NIQU5TDQo+PiArfTsNCj4gDQo+IERpdHRv
Lg0KDQpJIHNlZSBubyB2YWx1ZSBoYXZpbmcgZW50aXRpZXMgd2hpY2ggYXJlIG5vdCBpbnRlbmRl
ZCB0byBiZSB1c2VkIG91dHNpZGUgDQp0aGlzIGZpbGUgZG9jdW1lbnRlZCBpbiBhbnkgImdsb2Jh
bCIgZG9jdW1lbnRhdGlvbi4gT25lIHdobyBpcyBldmVyIA0KZ29pbmcgdG8gdXNlIHRoZXNlIG9y
IHdvbmRlciB3aGF0IHRoZXNlIGFyZSAtIHdpbGwgbW9zdCBsaWtlbHkgYmUgDQp3YXRjaGluZyB0
aGlzIGZpbGUuIE15IHBlcnNvbmFsIHZpZXcgaXMgdGhhdCB0aGUgZ2VuZXJhdGVkIGRvY3Mgc2hv
dWxkIA0KYmUga2VwdCBsZWFuLiBJbiBteSBvcGluaW9uIHRoZSBwcm9ibGVtIG9mIHRoZSBkYXkg
aXMgdGhlIHRpbWUgd2Ugc3BlbmQgDQpsb29raW5nIGZvciBhIG5lZWRsZSBoaWRkZW4gaW4gYSBo
YXlzdGFjay4gSW4gbXkgb3BpbmlvbiBhZGRpbmcgdGhpcyB0byANCmtlcm5lbC1kb2MganVzdCBh
ZGRzIGhheSA6KQ0KDQpJIHN0aWxsIGNhbiBkbyB0aGlzIGlmIG5vLW9uZSBlbHNlIG9iamVjdHMu
IEkgYWxtb3N0IG5ldmVyIGxvb2sgYXQgdGhlIA0KZ2VuZXJhdGVkIGRvY3MgbXlzZWxmLiBVc3Vh
bGx5IEkganVzdCBsb29rIHRoZSBkb2NzIGZyb20gY29kZSBmaWxlcyAtIA0KYW5kIGtlcm5lbC1k
b2MgZm9ybWF0IGlzIG5vdCBhbnkgd29yc2UgZm9yIG1lIHRvIHJlYWQuIFN0aWxsLCBJIGNhbiAN
CmltYWdpbmUgaW5jbHVkaW5nIHRoaXMgdHlwZSBvZiBzdHVmZiB0byBnZW5lcmljIGRvYyBqdXN0
IGJsb2F0cyB0aGVtIGFuZCANCm15IG5vdCBzZXJ2ZSB3ZWxsIHRob3NlIHdobyB1c2UgdGhlbS4N
Cg0KPiANCj4gLi4uDQo+IA0KPj4gKwlpZiAoaW50X3RpbWUgPCAwKQ0KPj4gKwkJaW50X3RpbWUg
PSA0MDAwMDA7DQo+IA0KPiBBZGRpbmcgMyAwOnMgdG8gZHJvcCB0aGVtIGJlbG93IHdpdGggYSBo
ZWF2eSBkaXZpc2lvbiBvcGVyYXRpb24/IFdlbGwgZG9uZSENCj4gT3IgZGlkIEkgbWlzcyBhbnl0
aGluZz8NCg0KTm8uIFlvdSBkaWQgbm90IG1pc3MgYW55dGhpbmcuIFRoaXMgY2FuIGJlIGltcHJv
dmVkLg0KDQo+IA0KPj4gKwltc2xlZXAoaW50X3RpbWUgLyAxMDAwKTsNCj4gDQo+IFVTRUNfUEVS
X01TRUMgPw0KDQpPay4NCg0KPiAuLi4NCj4gDQo+PiArCXJldCA9IGRldm1faWlvX2RldmljZV9y
ZWdpc3RlcihkZXYsIGlkZXYpOw0KPj4gKwlpZiAocmV0KQ0KPj4gKwkJcmV0dXJuIGRldl9lcnJf
cHJvYmUoZGV2LCByZXQsDQo+PiArCQkJCSAgICAgIlVuYWJsZSB0byByZWdpc3RlciBpaW8gZGV2
aWNlXG4iKTsNCj4+ICsNCj4+ICsJcmV0dXJuIHJldDsNCj4gDQo+IHJldHVybiAwIHdpbGwgc3Vm
ZmljZS4NCg0KT2suDQoNClRoYW5rcywNCgktLSBNYXR0aQ0KDQotLSANCk1hdHRpIFZhaXR0aW5l
bg0KTGludXgga2VybmVsIGRldmVsb3BlciBhdCBST0hNIFNlbWljb25kdWN0b3JzDQpPdWx1IEZp
bmxhbmQNCg0Kfn4gV2hlbiB0aGluZ3MgZ28gdXR0ZXJseSB3cm9uZyB2aW0gdXNlcnMgY2FuIGFs
d2F5cyB0eXBlIDpoZWxwISB+fg0KDQo=
