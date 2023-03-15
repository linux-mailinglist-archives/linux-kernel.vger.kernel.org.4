Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100446BA8EC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjCOHVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjCOHU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:20:59 -0400
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2135.outbound.protection.outlook.com [40.107.127.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CAB5A1B5;
        Wed, 15 Mar 2023 00:20:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=biy+t/kYCLhms9uZXN5Qz9C8Y1MUGH4QE+XzvhBcW5ciJd78lJl1kNT4PRIaSHTx2OMCczjBlCJ6fx1e8zOv8hHgJZv6Av7qk6ljBlwH13aC0MSpGxtljuVoAfWXNuObAFNLDBPDnckGPez3bHR8SK2NUsOvzRpE9vrIKCtbPJSSyTVpNGDG9x/rq2eks8/5vIFcwtxTFE1XcBV/afVHM/JT1ouer5IMqsiVPkhKjNtlKBwDKJK+uuPOWcF32uCIrclc+hXh6BDn316/9XlmvIcUkHqaHRVkyaxlRmZjgxk/ScxLBUBaZMV8kBonN82qkaoubmHV/p2PLa8EcaDKMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDtUloA7MXLNfkMw4BhUarbdzeX8MW4V6NpYak9/oho=;
 b=BqFWhGYM4xA03g7Uyaq/qQV15puNFbcQOtfvmeeHN6DAZ9LElmJZz+Et+ZwI+NOVDB468JoVSiuWpak0cAWZbDowd6HEqDmu30uk9x/2wHXzK3bYR83+Hl0jN1+25blbwFzJbIWMrGrHeufe6A6P8PeFUUffa1amdRv6dd7sb3XBU5U7vQhvX6sZ11++4R5qXLjqcuiVRTVNJvXByV4q6SDb/HoawwXSBGeLiJ3d0nfHuy/6U2fNYjygNrXAt0rzoB9dMM8D284UNKgN31Ww8OwCCt2v/Am8WpS+LtPN2G37j1Bfbcrzges1PvVPuNXwgzHbeBfbP2FQmZFPLQEvyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDtUloA7MXLNfkMw4BhUarbdzeX8MW4V6NpYak9/oho=;
 b=CMIhEnly8IgCybekV1aaHoAtZiX6CiSf8I7jZBuskq9A81Hv0hiLXV1p+ldF0tglox74YX3SdW3QGFFZDIkwQzVDqZ3QlGKFuHmO3jGUq1hb0RNaIsPutAOBqZmK00q0TW1AewTWUcEc6Df3pqrN1upFS3lXeiMJLI5L1ZN6zc8=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by FR3P281MB3056.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:5b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Wed, 15 Mar
 2023 07:20:50 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3657:656:f6f6:dc8f]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3657:656:f6f6:dc8f%5]) with mapi id 15.20.6178.029; Wed, 15 Mar 2023
 07:20:50 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] iio: light: Add gain-time-scale helpers
Thread-Topic: [PATCH v2 2/6] iio: light: Add gain-time-scale helpers
Thread-Index: AQHZTPXh4wyEP/STAU6pVe8dzbgoCa7nluKAgAEZ7ICABO7CAIALBUgAgAA0hwCAAUw1gIAAEW2AgAFMaQA=
Date:   Wed, 15 Mar 2023 07:20:50 +0000
Message-ID: <a5b2c698-0ada-fb3e-01f4-f50c42811163@fi.rohmeurope.com>
References: <cover.1677750859.git.mazziesaccount@gmail.com>
 <9895826669118a1aa1db3f85c2610fa759426c33.1677750859.git.mazziesaccount@gmail.com>
 <ZAC7L8NQYgBcBTCF@smile.fi.intel.com>
 <7e537200-37ab-f6e6-c4e0-c3997128c01b@fi.rohmeurope.com>
 <ZAXK9Hn2NuQPJ7eo@smile.fi.intel.com>
 <1dbfc336-7d09-cd44-dfa2-9c4bedf257e1@gmail.com>
 <ZA81rpWgwvP2bigt@smile.fi.intel.com>
 <9d63c161-0449-7e56-5873-2909587f17af@gmail.com>
 <ZBBa+e9VXj/eyT4J@smile.fi.intel.com>
In-Reply-To: <ZBBa+e9VXj/eyT4J@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2454:EE_|FR3P281MB3056:EE_
x-ms-office365-filtering-correlation-id: b5622335-deb4-46cb-136a-08db2525ce35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BtOwcVvsXc9YGkmE2Ea71FREOjYQ59SY9lFTd1VzVumRHw5D0Z5rAaQXbIn+n5UW88sh9ZuXqSUABb0E8qnD0y3KSwcINAhwxebBmWDzIGkPx+9bLVQs7WRnmzFyP22dTyNDgohW/75I+bOo4e3HdBK5y361kvEwiLm37zkAUK/nN0cbve8e8WZhWBGobqplV0iKChU8Xmg8jMgbQwRA22xELJvCHRCl55I3xO2Chogcwej9O8IJ4HFdrZkg5Hradfe+XT4Y2hGGcNWYCMiNjbFbnNDvEQ28P0+EJcfwmLlHq77pe2XRMcsmNi1+uCqssl4t/uvfAWUCxkfuKPx0bau4trzQzXRGWxChwySy3ffrt2pZyUW8PRXCHEKzwAVOdi1ln+XGZThePfGRw5vvrUG9j5lr8roJJuWOrT21dNmN8pCIjnI6vBMM++4Gp6/Kzn5Zw79tOsyQDn3BNH9FbGvjrZg2utQJB7iATUsGhJmSKv/80JWVaGRbOdy640ie6+umrn+V73Cj+scGUo8Y3rXBI+qxVLpdwhzPsaSJDrA1Mf4FKk1KW7ZXjbMlyVIPs+PxkQRMNyCGyn6OxPQrXIG53mPvIMcnCeGvzz54TpY9mUXjev49Y6f5Ea4j0RRpcCKoN3iug7N+RjWlH55voTgbixFuIhnUFSJvGLoSt88If4kKflFAsXXyzyVBaTLCTcuQ9GSSO9QI6CS+KPWCxFVpfS31OfPFDH/VeayLxZICWfS4DcC5gcVOaN+KajVQuWMwokTzXpNOV1JYubzG3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39850400004)(396003)(346002)(136003)(366004)(451199018)(38100700002)(38070700005)(31696002)(86362001)(122000001)(2906002)(7416002)(5660300002)(8936002)(41300700001)(4326008)(6506007)(2616005)(53546011)(186003)(6512007)(83380400001)(26005)(316002)(54906003)(110136005)(66946007)(66556008)(66476007)(64756008)(91956017)(66446008)(76116006)(8676002)(6486002)(71200400001)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFJBMWF3VVFVaXVRSDNrdVZzcFE3RXg4UEhLbUFqd0FmcUxFKzMzN3N6Ky80?=
 =?utf-8?B?WVNncjIvb1J3dndpUDJvMm02Zm1YWUtrWitMZytSUWt4dkFPN0sxenR4WnN6?=
 =?utf-8?B?MXZjMkNPU0EvRzlGVk9lc0tVdXpmV0p0dGMrTHRQMGZJOGxaTjdsR2JjNzUy?=
 =?utf-8?B?MitxSDBaWXRrWVBITWp4Vnh1cW9nYklIM3c2cXRjajFIVEZKTU1NaWJHbjJZ?=
 =?utf-8?B?SDVvSU5oK2pjeEFCelhudG12MnNjTlE2Z3ZVd2pydUZUODF5d2d2aXRmTDNQ?=
 =?utf-8?B?M2l5TGs4SnpyRmpITEw3OWo2RzdhUDd1WDBOdmlGT0VRSUxKZ1ZXcGN6ZGZE?=
 =?utf-8?B?Nm9ueDRaM01EbXA5WnlKamhQM2VFUExRRkhXbFpjeE5YZEorWUQzckU2R29m?=
 =?utf-8?B?djBNRmcwSTVHdzRFMm9RVjFtVjNSd3RxbE8rTFpNUExkb1h1RGd4SkR4RlFY?=
 =?utf-8?B?V2ovcmVWRkFJNE5mNnJHVTRocDB4V2szVDdERTJBNC9ZWnRjZGdmSTdCT0Z4?=
 =?utf-8?B?ckdTaWh4L3hIOCtvaUpuQzhOZEdjRU9HaFVldTczZEFLZkRWQSsrMmlVWkpQ?=
 =?utf-8?B?WkIzTlk4M2hqRTI0YU1TMnZxM2g0Q0llTGJoUHFSWGIvMGlrWHBxM0ZyZWVz?=
 =?utf-8?B?cmlaOFB2d20zNnlwNExiZWhKSms2YWJEWVRmaFZ0TC90eFRBOTg0dDZhUW9T?=
 =?utf-8?B?emZMQ0JGdklCQ1pSK0dkamZyZm15Um5SM3hoRktmbWRLbWdDaTg3UERxWHV4?=
 =?utf-8?B?dG50YVRKMExoc2RET1FlQTI1RlVkWHRZNDZ5ZlFzSW5GUmJCbUNabUM4V3B6?=
 =?utf-8?B?VStPUmJ1VGo4aWVhekpUSzd2SEQxNUdPU01HVnQ2RmRacm1yNkVGcndIZU5h?=
 =?utf-8?B?TmsybmJsNjhQMy9vbzhHNWJ4WHdCZjlKOXNVQk1WVVkwUHFKeExFeFJZV1d0?=
 =?utf-8?B?cmtaSTBRL01SQlNhajU1UXpRTjl2ZDF5Q29kbk16czQwWHZHeE8yUmVFQ2Vv?=
 =?utf-8?B?aW9aWUJpVmc3UmJ2eE5nc1kreHNnZ0JwT1dkNmxEN1V4NVlIckF0V0ltUHhF?=
 =?utf-8?B?N2FaOGs3cFZFQWdlR0xTRkpabmdLWlF4cjhSVHhKaVl6R3EvT2ZZS0FBeVdH?=
 =?utf-8?B?YmhTWGx6VVA0WWZRSTE3Zys2S3M0ZDR5QUplWGFqUXVqT1V2SjIrZ3Nzb2xw?=
 =?utf-8?B?akM5d1lwdHU5Ri90VFhlNkVQMzJBK1l0d2VwVW9VS21zcFpQdCt2SDZEUGtn?=
 =?utf-8?B?M2J2cXhiN3pTTkk5ZHRNeXRuYWNkN3RoOTZ4K0FMdDF0U284ZVZNSkRVdFdj?=
 =?utf-8?B?NUFOOUhXeXNYUkE3RzFsTm44QlNPVUdnYVNqNWJ2NjNEak1IS2JRQVhhUTRF?=
 =?utf-8?B?TnNJQnVFSVBwVzZicEZiSDhKUk9SYjV2dmlVMWRpa0hXZVl3MWxaZ0FrSER1?=
 =?utf-8?B?dFR3Vm4ySGR2NWlTMSswU1lrWlMzaFoxTSt1eGltRlhuaVR0eDkrUXdVUFZO?=
 =?utf-8?B?WWpMQVJSV08wTkVHUjZSclJUVDFJSmhwMTV0Q3hoalRDT2hnd091VWQvQW5F?=
 =?utf-8?B?c3oweEZzQWpNY1RjU3FrSG0zZDVHS2RvZTUwdy9NOFo3T29uUEw4WnFMeVR6?=
 =?utf-8?B?VXNIY0RNK1JoRFBjVlUvekdlQ1lNQW55VmUrQjFvUGw5VHRmcFd6WUpxWHhp?=
 =?utf-8?B?UlVmQVZFV2N0MFR5ajJKUmtiY3Q5eTR1TFpJQXlkb1lRUkM0TFFpSnYyUHNo?=
 =?utf-8?B?SjBCV0s4S3RObUU4bWtIOXoyQlE1SDduSTl5b3duZUdGclE0T1djTndtNWdK?=
 =?utf-8?B?QkQwTlBza2Z1NS9iQ0pFVUxqUlAvQmp5QUEvSmFIaU5xbEtWeVlJcS8xYXgv?=
 =?utf-8?B?Y1BYL2RuUzB1WWFUNkcrNzB0V2FXQlIyVWxDZGUya0pFUFhSZkkxN3dEMk9D?=
 =?utf-8?B?LzZYVi80aFVMeTRxQ2doZUdpd2hSQzZNZ0gxMTVObFU3Zmx6M1p4bXNGbW43?=
 =?utf-8?B?TkRSTFRaMjR3SnAzRWR4U2pTYml3MmVLQlN2TGhGUk9WVGFBNHZad25SOVlh?=
 =?utf-8?B?cE54S3REYmpqbjdMU0l3ZitYdGtVb3JJQWJsUFNmMmp0d1VaK1Y0Ni9aYk5V?=
 =?utf-8?B?aUFuYk1GSWo5ZE5DZzJQcVZlakZQVEh1cnk5UXFsa05Sejg0cldOU1lSRXp4?=
 =?utf-8?B?VGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5121619BA46E3343BF91B32F0BE3A19E@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b5622335-deb4-46cb-136a-08db2525ce35
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 07:20:50.6503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QtWoxrAGsnfPWg3cXlhL6fOSUYoQQT1kxOXghfd5DFFfbNtnx8xNlySJlWKU5tzrCyDOc0sWWienvYFkkKiz6vC127JaBrKaB4lRAYGv5lQExzZKjCls/Kq3GpFVZj7P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB3056
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8xNC8yMyAxMzozMSwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBPbiBUdWUsIE1hciAx
NCwgMjAyMyBhdCAxMjoyODo0M1BNICswMjAwLCBNYXR0aSBWYWl0dGluZW4gd3JvdGU6DQo+PiBP
biAzLzEzLzIzIDE2OjM5LCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+Pj4gT24gTW9uLCBNYXIg
MTMsIDIwMjMgYXQgMDE6MzE6NDJQTSArMDIwMCwgTWF0dGkgVmFpdHRpbmVuIHdyb3RlOg0KPj4+
PiBPbiAzLzYvMjMgMTM6MTMsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4+Pj4+IE9uIEZyaSwg
TWFyIDAzLCAyMDIzIGF0IDA3OjU0OjIyQU0gKzAwMDAsIFZhaXR0aW5lbiwgTWF0dGkgd3JvdGU6
DQo+Pj4+Pj4gT24gMy8yLzIzIDE3OjA1LCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+Pj4+Pj4+
IE9uIFRodSwgTWFyIDAyLCAyMDIzIGF0IDEyOjU3OjU0UE0gKzAyMDAsIE1hdHRpIFZhaXR0aW5l
biB3cm90ZToNCj4gDQo+IC4uLg0KPiANCj4+Pj4+Pj4+ICsJCWZvciAoaSA9IDA7ICFyZXQgJiYg
aSA8IGd0cy0+bnVtX2F2YWlsX2FsbF9zY2FsZXM7IGkrKykNCj4+Pj4+Pj4NCj4+Pj4+Pj4gTXVj
aCBlYXNpZXIgdG8gcmVhZCBpZiB5b3UgbW92ZSB0aGlzLi4uDQo+Pj4+Pj4+DQo+Pj4+Pj4+PiAr
CQkJcmV0ID0gaWlvX2d0c190b3RhbF9nYWluX3RvX3NjYWxlKGd0cywgYWxsX2dhaW5zW2ldLA0K
Pj4+Pj4+Pj4gKwkJCQkJJmd0cy0+YXZhaWxfYWxsX3NjYWxlc190YWJsZVtpICogMl0sDQo+Pj4+
Pj4+PiArCQkJCQkmZ3RzLT5hdmFpbF9hbGxfc2NhbGVzX3RhYmxlW2kgKiAyICsgMV0pOw0KPj4+
Pj4+Pg0KPj4+Pj4+PiAuLi5oZXJlIGFzDQo+Pj4+Pj4+DQo+Pj4+Pj4+IAkJaWYgKHJldCkNCj4+
Pj4+Pj4gCQkJYnJlYWs7DQo+Pj4+Pj4NCj4+Pj4+PiBJIHRoaW5rIHRoZSAhcmV0IGluIGxvb3Ag
Y29uZGl0aW9uIGlzIG9idmlvdXMuIEFkZGluZyBicmVhayBhbmQgYnJhY2tldHMNCj4+Pj4+PiB3
b3VsZCBub3QgaW1wcm92ZSB0aGlzLg0KPj4+Pj4NCj4+Pj4+IEl0IG1vdmVzIGl0IHRvIHRoZSBy
ZWd1bGFyIHBhdHRlcm4uIFlvdXJzIGlzIG5vdCBzbyBkaXN0cmlidXRlZCBpbiB0aGUga2VybmVs
Lg0KPj4+Pg0KPj4+PiBJIGJlbGlldmUgd2UgY2FuIGZpbmQgZXhhbXBsZXMgb2YgYm90aCBwYXR0
ZXJucyBpbiBrZXJuZWwuIEkgZG9uJ3QgdGhpbmsgdGhlDQo+Pj4+ICJtYW55IHBlb3BsZSB1c2Ug
ZGlmZmVyZW50IHBhdHRlcm4iIGlzIGEgZ3JlYXQgcmVhc29uIHRvIGFkZCBicmVhayArDQo+Pj4+
IGJyYWNrZXRzIHdoaWNoIChpbiBteSBleWVzKSBnaXZlIG5vIGFkZGl0aW9uYWwgdmFsdWUgdG8g
Y29kZSBJIGFtIHBsYW5uaW5nDQo+Pj4+IHRvIGtlZXAgcmVhZGluZyBhbHNvIGluIHRoZSBmdXR1
cmUuLi4NCj4+Pg0KPj4+IFRoZSBwcm9ibGVtIGlzIHRoYXQgeW91ciBwYXR0ZXJuIGlzIG5vdCBz
byBzdGFuZGFyZCAoZGlzdHJpYnV0ZWQpIGFuZCBoZW5jZQ0KPj4+IGxlc3MgbWFpbnRhaW5hYmxl
Lg0KPj4NCj4+IEkgYW0gc29ycnkgYnV0IEkgY2FuJ3QgcmVhbGx5IGFncmVlIHdpdGggeW91IG9u
IHRoaXMgb25lLiBGb3IgbWUgYWRkaW5nIHRoZQ0KPj4gYnJlYWsgYW5kIGJyYWNrZXRzIHdvdWxk
IGp1c3QgY29tcGxpY2F0ZSB0aGUgZmxvdyBhbmQgdGh1cyBkZWNyZWFzZSB0aGUNCj4+IG1haW50
YWluYWJpbGl0eS4NCj4gDQo+IFNvLCB3ZSBtYXkgc3RhcnQgdG8gaGF2ZSBhICJmdW5kYW1lbnRh
bCBkaXNhZ3JlZW1lbnRzIGJldHdlZW4gTWF0dGkgYW5kIEFuZHkgb24NCj4gdGhlIGNvZGUgc3R5
bGUgaW4gdGhlIExpbnV4IGtlcm5lbCIgZG9jdW1lbnQgdGhhdCB3ZSB3b24ndCBjbGFzaCBvbiB0
aGlzIGFnYWluLg0KPiBBdCBsZWFzdCB0aGUgYW1vdW50IG9mIHRoZXNlIGRpc2FncmVlbWVudHMg
c2VlbXMgbm90IGRlY3JlYXNpbmcgaW4gdGltZS4NCj4gDQoNCjopDQoNCj4gLi4uDQo+IA0KPj4+
Pj4+Pj4gKwkJCWlmICghZGlmZikgew0KPj4+Pj4+Pg0KPj4+Pj4+PiBXaHkgbm90IHBvc2l0aXZl
IGNvbmRpdGlvbmFsPw0KPj4+Pj4+DQo+Pj4+Pj4gQmVjYXVzZSAhZGlmZiBpcyBhIHNwZWNpYWwg
Y29uZGl0aW9uIGFuZCB3ZSBjaGVjayBleHBsaWNpdGx5IGZvciBpdC4NCj4+Pj4+DQo+Pj4+PiBB
bmQgaG93IG15IHN1Z2dlc3Rpb24gbWFrZXMgaXQgZGlmZmVyZW50Pw0KPj4+Pg0KPj4+PiBJbiBl
eGFtcGxlIHlvdSBnYXZlIHdlIHdvdWxkIGJlIGNoZWNraW5nIGlmIHRoZSB2YWx1ZSBpcyBhbnl0
aGluZyBlbHNlIGJ1dA0KPj4+PiB0aGUgc3BlY2lmaWMgdmFsdWUgd2UgYXJlIGNoZWNraW5nIGZv
ci4gSXQgaXMgY291bnRlciBpbnR1aXRpdmUuDQo+Pj4+DQo+Pj4+PiAoTm90ZSwgaXQncyBlYXN5
IHRvIG1pc3MgdGhlICEgaW4gdGhlIGNvbmRpdGlvbmFscywgdGhhdCdzIHdoeSBwb3NpdGl2ZSBv
bmVzDQo+Pj4+PiAgICAgYXJlIHByZWZlcmFibGUuKQ0KPj4+Pg0KPj4+PiBUaGFuayB5b3UgZm9y
IGV4cGxhaW5pbmcgbWUgdGhlIHJhdGlvbmFsZSBiZWhpbmQgdGhlICJwb3NpdGl2ZSBjaGVja3Mi
LiBJDQo+Pj4+IGRpZG4ndCBrbm93IG1pc3NpbmcgJyEnIHdhcyBzZWVuIGFzIGEgdGhpbmcuDQo+
Pj4+IEkgc3RpbGwgZG9uJ3QgdGhpbmsgYmVpbmcgYWZyYWlkIG9mIG1pc3NpbmcgJyEnIGlzIGEg
Z29vZCByZWFzb24gdG8gc3dpdGNoDQo+Pj4+IHRvIGNvdW50ZXIgaW50dWl0aXZlIGNoZWNrcy4g
QSBjaGVjayAiaWYgKCFmb28pIiBpcyBhIHBhdHRlcm4gaW4ta2VybmVsIGlmDQo+Pj4+IGFueXRo
aW5nIGFuZCBpbiBteSBvcGluaW9uIHBlb3BsZSByZWFsbHkgc2hvdWxkIGJlIGF3YXJlIG9mIGl0
Lg0KPj4+Pg0KPj4+PiAoSSB3b3VsZCBtdWNoIG1vcmUgc2F5IHRoYXQgaGF2aW5nIGEgY29uc3Rh
bnQgdmFsdWUgb24gbGVmdCBzaWRlIG9mIGENCj4+Pj4gImVxdWFsaXR5IiBjaGVjayBpcyBiZW5l
ZmljaWFsIGFzIHBlb3BsZSBkbyByZWFsbHkgb2NjYXNpb25hbGx5IG1pc3Mgb25lICc9Jw0KPj4+
PiB3aGVuIG1lYW5pbmcgJz09Jy4gU3RpbGwsIHRoaXMgaXMgbm90IHN0cm9uZyBlbm91Z2ggcmVh
c29uIHRvIG1ha2UNCj4+Pj4gY291bnRlci1pbnR1aXRpdmUgY2hlY2tzLiBJbiBteSBib29rcyAn
YXZvaWRpbmcgbmVnYXRpdmUgY2hlY2tzJyBpcyBtdWNoDQo+Pj4+IGxlc3Mgb2YgYSByZWFzb24g
YXMgcGVvcGxlIChpbiBteSBleHBlcmllbmNlKSBkbyBub3QgcmVhbGx5IG1pc3MgdGhlICchJy4p
DQo+Pj4NCj4+PiBJdCdzIG5vdCBhIHByb2JsZW0gd2hlbiBpdCdzIGEgY29tbW9uIHBhdHRlcm4g
KGxpa2UgeW91IG1lbnRpb25lZA0KPj4+IGlmICghZm9vKSByZXR1cm4gLUVOT01FTTsgb3IgYWxp
a2UpLCBidXQgaW4geW91ciBjYXNlIGl0J3Mgbm90Lg0KPj4NCj4+IEkgdGhpbmsgd2UgY2FuIGZp
bmQgcGxlbnR5IG9mIGNhc2VzIHdoZXJlIHRoZSBpZiAoIWZvbykgaXMgdXNlZCBhbHNvIGZvcg0K
PiANCj4gUGxlYWRpbmcgdG8gdGhlIHF1YW50aXR5IGFuZCBub3QgcXVhbGl0eSBpcyBub3QgYW4g
YXJndW1lbnQsIHJpZ2h0Pw0KDQpFaC4gSSB0aGluayBpdCBoYXMgYmVlbiB5b3Ugd2hvIGhhcyBx
dWl0ZSBvZnRlbiB1c2VkIHRoYXQgYXMgYW4gDQphcmd1bWVudCwgcmlnaHQ/DQoNCj4+IG90aGVy
IHR5cGUgb2YgY2hlY2tzLiBUbyBtZSB0aGUgYXJndW1lbnQgYWJvdXQgcGVvcGxlIGVhc2lseSBt
aXNzaW5nIHRoZSAhDQo+PiBpbiBpZiAoKSBqdXN0IGRvIG5vdCBzb3VuZCByZWFzb25hYmxlLg0K
PiANCj4gWW91IG1heSB0aGVvcmV0aWNhbGx5IGRpc2N1c3MgdGhpcywgSSdtIHRlbGxpbmcgZnJv
bSBteSByZXZpZXcgYmFja2dyb3VuZA0KPiBhbmQgcmVhbCBjYXNlcy4NCg0KSSB0aGluayB3ZSBh
bGwgaGF2ZSBiZWVuIHJlYWRpbmcgdGhlIGNvZGUgZm9yIHF1aXRlIGEgZmV3IHllYXJzLiBUaHVz
LCANCmFsc28gbXkgc3RhdGVtZW50cyBhcmUgZG9uZSBiYXNlZCBvbiByZWFsIGNhc2VzLCBvciBs
YWNrIG9mIHRoZW0gDQp0aGVyZW9mLiBIZW5jZSBhICJTaHV0IHVwLCBJIGhhdmUgdGhlIHJldmll
d2luZyBleHBlcmllbmNlIiBpcyBub3Qgc3VjaCANCmEgc3Ryb25nIGFyZ3VtZW50IGluIG15IGJv
b2tzIDspDQoNCj4+PiBJIHdvdWxkIHJhdGhlciBzZWUgaWYgKGRpZmYgPT0gMCkgd2hpY2ggZGVm
aW5pdGVseSBzaG93cyB0aGUgaW50ZW50aW9uDQo+Pj4gYW5kIEkgd291bGRuJ3QgdGVsbCBhIHdv
cmQgYWdhaW5zdCBpdC4NCj4+DQo+PiBJIHRoaW5rIHRoaXMgZGVwZW5kcyBtdWNoIG9mIHRoZSBj
b3JuZXIgb2YgdGhlIGtlcm5lbCB5b3UgaGF2ZSBiZWVuIHdvcmtpbmcNCj4+IHdpdGguIEFzIGZh
ciBhcyBJIHJlbWVtYmVyLCBpbiBzb21lIHBhcnRzIHRoZSBrZXJuZWwgdGhlIGNoZWNrDQo+PiAo
Zm9vID09IDApIHdhcyBhY3R1YWxseSBkaXNjb3VyYWdlZCwgYW5kIGNoZWNrICghZm9vKSB3YXMg
cHJlZmVycmVkLg0KPiANCj4gRG9uJ3QgeW91IHVzZSB5b3VyIGNvbW1vbiBzZW5zZT8NCg0KSSB0
cnkuIEkgYmVsaWV2ZSB0aGlzIGlzIHdoeSBJIHNvIG9mdGVuIGNsYXNoIHdpdGggcGVvcGxlIHdo
byBhcmUganVzdCANCm1vcmUgb3IgbGVzcyBibGluZGx5IGZvbGxvd2luZyB0aGVpciBwcmVmZXJy
ZWQgaWRpb21zLg0KDQo+PiBQZXJzb25hbGx5IEkgbGlrZSAhZm9vIG11Y2ggbW9yZSAtIGJ1dCBJ
IGNhbiB0b2xlcmF0ZSB0aGUgKGZvbyA9PSAwKSBpbg0KPj4gY2FzZXMgd2hlcmUgdGhlIHB1cnBv
c2UgaXMgdG8gcmVhbGx5IHNlZSBpZiBzb21lIG1lYXN1cmUgZXF1YWxzIHRvIHplcm8uDQo+Pg0K
Pj4gT3RoZXIgdXNlcyB3aGVyZSBJIGRlZmluaXRlbHkgZG9uJ3Qgd2FudCB0byB1c2UgIj09IDAi
IGFyZSBmb3IgZXhhbXBsZQ0KPj4gY2hlY2tpbmcgaWYgYSBmbGFnIGlzIGNsZWFyLCBwb2ludGVy
IGlzIE5VTEwgb3IgIm1hZ2ljIHZhbHVlIiBpcyB6ZXJvLg0KPj4NCj4+IEluIHRoaXMgY2FzZSB3
ZSBhcmUgY2hlY2tpbmcgZm9yIGEgbWFnaWMgdmFsdWUuIEhhdmluZyB0aGlzIGNoZWNrIHdyaXR0
ZW4NCj4+IGFzOiAoZGlmZiA9PSAwKSwgd291bGQgYWN0dWFsbHkgZmFsc2VseSBzdWdnZXN0IG1l
IHdlIGFyZSBjaGVja2luZyBmb3IgdGhlDQo+PiBkaWZmZXJlbmNlIG9mIGdhaW5zIGJlaW5nIHpl
cm8uIFRoYXQgd291bGQgcmVhbGx5IGJlIGEgY2xldmVyIG9iZnVzY2F0aW9uDQo+PiBhbmQgSSBh
bSBjZXJ0YWluIHRoZSBjb2RlIHJlYWRlcnMgd291bGQgZmFsbCBvbiB0aGF0IHRyYXAgcXVpdGUg
ZWFzaWx5Lg0KPiANCj4gVGVzdGluZyB3aXRoICFkaWZmIHNvdW5kcyBsaWtlIGl0J3MgYSBib29s
ZWFuIGtpbmQgYW5kIG1ha2VzIGEgZmFsc2UNCj4gaW1wcmVzc2lvbiB0aGF0IGFsbCBvdGhlciB2
YWx1ZXMgYXJlIGFsbW9zdCB0aGUgc2FtZSBtZWFuaW5nIHdoaWNoIGlzDQo+IG5vdCB0aGUgY2Fz
ZS4gQW0gSSByaWdodD8gVGhhdCdzIHdoeSBkaWZmID09IDAgc2hvd3MgdGhlIGV4YWN0IGludGVu
dGlvbg0KPiBoZXJlICJJIHdvdWxkIGxpa2UgdG8gY2hlY2sgaWYgZGlmZiBpcyAwIGJlY2F1c2Ug
dGhpcyBpcyAqc3BlY2lhbCBjYXNlKiIuDQoNClRvIG1lIHRoZSBkaWZmID09IDAgd291bGQgZGVm
aW5pdGVseSByZWFkICJkaWZmZXJlbmNlIG9mIGdhaW5zIGlzIHplcm8iLiANCkFuZCB0aGlzIGlz
IE5PVCB3aGF0IHRoaXMgY2hlY2sgaXMgaGVyZSBmb3IuIEFuZCBubywgdXNpbmcgIXZhciBpcyBf
bm90XyANCmEgc2lnbiBvZiBhIGJvb2xlYW4gZm9yIG1lLiBJdCBtaWdodCBiZSBpZiB0aGlzIHBh
dHRlcm4gd2FzIG5vdCB1c2VkIA0KdGhyb3VnaG91dCB0aGUga2VybmVsIGZvciBjaGVja2luZyBp
ZiBzb21ldGhpbmcgaXMgX25vdCBzZXRfLCANCnN1Y2Nlc3NmdWwsIE5VTEwgYW5kIHllcywgb2Z0
ZW4gYWxzbyB0byBzZWUgaXQgc29tZXRoaW5nIGlzIG5vbiB6ZXJvLg0KDQo+IE1ha2luZyAhZGlm
ZiBjcmVhdGVzIGxlc3MgdmlzaWJpbGl0eSBvbiB0aGlzLg0KPiANCj4gUmVzdWx0OiBGdW5kYW1l
bnRhbCBkaXNhZ3JlZW1lbnQgYmV0d2VlbiB1cy4NCg0KV2UgYWdyZWUgb24gdGhhdCA6KQ0KDQot
LSANCk1hdHRpIFZhaXR0aW5lbg0KTGludXgga2VybmVsIGRldmVsb3BlciBhdCBST0hNIFNlbWlj
b25kdWN0b3JzDQpPdWx1IEZpbmxhbmQNCg0Kfn4gV2hlbiB0aGluZ3MgZ28gdXR0ZXJseSB3cm9u
ZyB2aW0gdXNlcnMgY2FuIGFsd2F5cyB0eXBlIDpoZWxwISB+fg0KDQo=
