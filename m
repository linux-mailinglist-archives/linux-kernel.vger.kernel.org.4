Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D736F6B8B23
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 07:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjCNGTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 02:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjCNGTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 02:19:42 -0400
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2117.outbound.protection.outlook.com [40.107.135.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A99A2CFDA;
        Mon, 13 Mar 2023 23:19:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUksk58NWE64ZelTKpLFJWztmkmVn8pS3qIss8eg1BCseMLVs1pqd8ixkTN2lKTRrZRNKX0KMS/dOboastN+cxzjeYGFW51y0K5bWqTbDPPoEDlsyT8L9UOAUIM64zB08NEA+67aurA0yaSepzmjffEaA6+5xX4R4GFKYk7xFLtCuMmkCtHEq4LyBlkwjmDO/eJHlAz+/Fd30ciGdUr1oDbibVdIVfJ6LOV71f+DWFqJ4wIADSazWaq/FI6MpKWWUVki+lwi+/aRAvn8u+8zfzwx/TOxNfUa9bm5tm58MjeeHfNncA3L310QPmK1PoMd9mpsHetT99KRO220F5wH6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0raJlS1HswAvpdIIjowYAm1NFRDKqg3WjdO9h7MzemY=;
 b=FKVUEmt3sN9YRB8UsVI0+GcBpmk7SQLfZKDZ63osQE0ySp9kCelmlNsp/YNCmmfLY/drtm/DhTZ+HCf2vH6ZW63+Iwc7c5cZXL5rawuYFu5oiD3oVYMroVdOoCIV7qXqnUFgLGEDsuqpnH8LNActcx7PVHoHrcQC+l+ackNfCck55lHm6OX92McWYxS2ufbK0EirF3MI2OqxD05vUJ61r+34wjw475LeynMxcct1xAXkKh8l4ibPMMt+ufYJ2JgpHVLc906VVYZg4uj1JlHHBj4NWQGCrA0M83g+XkqqTNSYyt5D+BL0BMNiIMobupgkI4xkZnqEYei/9UBZlrapEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0raJlS1HswAvpdIIjowYAm1NFRDKqg3WjdO9h7MzemY=;
 b=xyR1HwJCbXknuzcNwc670h28tYDYzZIBe4+hX6l5+tDfE0Tw7DsKsQVWJXEofCkyDkCdYONgNp+qmMddRzHunzLHULqMH9sLZTn0lnFjNDYOuKyiS/LT/DdM6Ztpdy5NsYF8nOzqKqAug0U4EqaSKKDvc36Tyd+9KDwtc1zyJmw=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by BE1P281MB2547.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:6e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20; Tue, 14 Mar
 2023 06:19:36 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3657:656:f6f6:dc8f]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3657:656:f6f6:dc8f%6]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 06:19:35 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] iio: light: Add gain-time-scale helpers
Thread-Topic: [PATCH v3 2/6] iio: light: Add gain-time-scale helpers
Thread-Index: AQHZUAx6fUf10mXfYki+7tKCTx+0v67ttQ2AgAmwfwCAAVDzgIAABM6AgAEefoA=
Date:   Tue, 14 Mar 2023 06:19:35 +0000
Message-ID: <d2986a9e-c516-ea6d-8f94-5cd4723312bd@fi.rohmeurope.com>
References: <cover.1678093787.git.mazziesaccount@gmail.com>
 <a4cb9a34ca027867ac014ffe93ca7e8245ce263f.1678093787.git.mazziesaccount@gmail.com>
 <ZAXiKfRbsXpHhwAJ@smile.fi.intel.com> <20230312165100.45de0c9b@jic23-huawei>
 <bad05e06-3b37-b435-bfac-962aef36cc97@gmail.com>
 <ZA8ho4YfhBkSMFxS@smile.fi.intel.com>
In-Reply-To: <ZA8ho4YfhBkSMFxS@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2454:EE_|BE1P281MB2547:EE_
x-ms-office365-filtering-correlation-id: e2a54938-4e9e-460f-9b5a-08db24541560
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HGXjg/AtuLKdHxmsHgecRrCcjmNRE+i0lIO27IVmmFCGVpvIBOwGXfAjWFJGbf/IFRTCVPuJnLktu5DYZxdtcc/j268ykQRRrEns5BqJBLbw0kBNaY3IYAJiAw/qvSey5hj6A0M7oftw3s1DgV71sQcuBw01mZNNzteliWlP2t8+pYYbwFGzmb/95WOKtX0YtolEqrRrL9ZPyo24VGNAgfGPHqsl+UJp8fp6/SJkaAmbVK/9TRPoX+66jK2HV5Lx8KqhpPTSDckjcUk6nSuB/oud9/1sojbYP6zdziq4ciZacHOmZDO73kwJGOnticpk9OfBx1Jcb1HVnRN6t+2xBs7m2UElf7vf1uanyFuAunIV7EeZyRY3tmZIy1Ah5BT3dqpg1Y5YftbMkgRcJLTwhPQlguG1nuNH3Lde8s3xn1brcxAkIbN4z3Kvj4/C22bl70/hNkpuwpwQaCdj/KnZsV2qrDM5o22IxPyhr/WQQ79DDpUuiSDcYCpSa+Pl84K1uPuUKmFvce44ghcnTF5bZ1YXIqqtN3j2pLKqlWAdAMLJlPHQoQA0pkvYDyZr3Ka8KjxqGeiUncghHDMnz5W+SQIsdm6UqCNeopKvYTfd0YGAXXJ80/zCHvczAQ9NlmqOo9pF7Mu/NYGHTcE21LE++0za9OhOkgSfvDYfU9kyc86i/TK6qqd57NVG18zksJPFh8hPaBzSggaYTC+v4JUma2emPtr3gzruoM7qR5XEvdCHBzdTl/slFh3X7uMHUX8Flhi+HHVOT5mMdV0gQAVJ5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39850400004)(366004)(136003)(346002)(376002)(396003)(451199018)(38100700002)(31686004)(110136005)(6506007)(54906003)(316002)(6512007)(86362001)(122000001)(38070700005)(186003)(53546011)(26005)(83380400001)(2616005)(31696002)(7416002)(71200400001)(5660300002)(478600001)(8936002)(6486002)(41300700001)(64756008)(2906002)(66556008)(4326008)(66476007)(8676002)(66446008)(91956017)(66946007)(76116006)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFl0U0tseTcrS1FNQXB6K3lkTDdjd1VYcXFMa0J1R3ZMKytFTTRQb3dhODFY?=
 =?utf-8?B?eDNxUVNsbkJodkhyQ2RJamdoUG8vblhQdzhOTTZ2eXNhbStWUllXUE1sNEM0?=
 =?utf-8?B?REVOWVVVc1FLYlUzVTgyaTdpVER3YzVFK0lFaTJ2OXE4aGZ3S1RKdStEd1Ra?=
 =?utf-8?B?L1p4SHg1TUNJVk0wMDgySHBjY3p6WWRRM1Bscko0d3k0MjRTbHYyRU9BN1Mw?=
 =?utf-8?B?OGhrQWpMUjFVK1JZcnA2NjNQVFdYUVdORUhHMklraFAvNHZ3L3E3OUZIODBS?=
 =?utf-8?B?WnlnaTZxemQzaVVMdS9zT2IzOVlkQXVjbzY2Y2RkSlU5Z3hsQjBCUmN1QWZD?=
 =?utf-8?B?VlFsMThjTHRYTEYzME94VzFZM3hMQ0syMDJxZCs1NTcybGtXYWZRYmQxZll0?=
 =?utf-8?B?dHBtTjhUUzJqaHFhMFRzbXFRb2tnYStWZDh2MjZpTnk4NlVzRkpYTGJZdmZ2?=
 =?utf-8?B?NXZDcFNzSEFENWZubUtDZmNLWHAzdXJ0TXRFN1FySndJWHhBcUlKVFJPaHg1?=
 =?utf-8?B?cFBIZFluRjdKeCtSWC80UlZ2ZGwzYjA2R2huYUp2NjRQRmdYZDZreHRTbkw2?=
 =?utf-8?B?ekQ1ZFUzQ2g4aUptZDRVSHN5M1NXYjBrWDlLSnBGdU95bWJqL1hQSGpHcEU3?=
 =?utf-8?B?U1pzc0VzWS94YnpaYjQvZU9UWUJLc1NzdHh3Yk1kZ0dtQmlIVFZySjY2Yitq?=
 =?utf-8?B?TjU5VU9NWllpZkl1b2VJeEs1YlZlblhhdDB2ZE1zemFLUGxBWENwRzZzQjEv?=
 =?utf-8?B?Uy9mV0FNRU1idFV1dzhYdEZyVyt4NTJ3clg3QTgyb003RXVWNzdIaUJoamJH?=
 =?utf-8?B?WW1MeE1UdXpYOHFSZ3d2WGJuWlIyRk1SNk1HUTdsY0VxeUVJU3NZR0JZRkpR?=
 =?utf-8?B?d3ZXdTdCeGE0Y010aEhwWDl4bEJzbFc5Nm84Y0xkWnpjWm80MWYwWUg4dXlD?=
 =?utf-8?B?TTZndmdmK3NkdXhmWDFBSW5DSkdQMzkrMFFlbEtRNTFIdHBKL053TUVkay80?=
 =?utf-8?B?eEpkS2xwSmEzSUFKYVBzNXV0dm1rTXVSbHM3MGxiVWFvR0xNOG9UTHl4b0ZK?=
 =?utf-8?B?Z3FMQ3JjV2JicGlmYmJKc00yQnJ0N0xST2ZQWTNhMEgzZGprcmJQSHhOeFo5?=
 =?utf-8?B?a1BxUmtrWnVBdk1YUlVZYmgzRzk4b3R0enZ6OWtaZEhZdndxVjZJcmRtOHhL?=
 =?utf-8?B?RkhGRUoxSy90THBHZlhacWpkVi9kY2g0SXdCbnkzTE1xZlNnWUpSNEdnbmR2?=
 =?utf-8?B?Q2VKRytRT0RjUmdwdThzekZ6YWdSWklxSTZYVzIzOFpRdkVENGdmTGJVc1RG?=
 =?utf-8?B?QlN5dXhzZ2YyWXRrQWdZYkIyRVAwM3lpZkxNdVcxUERkN2ZKUmxGcmFCRnNB?=
 =?utf-8?B?bHIxUUFTaHdYVnFkSXNINkJPKzlKQmN3c1hlY0hscElTSktsTEUyek4yY3Nh?=
 =?utf-8?B?d1hHTnEzWFo3ckRWVTlJSGZnbjNLYW9QNzBUQUx1VzVvaENrbnpwQW80K0No?=
 =?utf-8?B?VFJCTTkyUVpzV2VOZzU2eHMrbTdzMlhkR3lBd09tY1JKLzdNL1k4bzJGZk0z?=
 =?utf-8?B?bENxdnVHKzhSRnAzREZScDZMSE9qd1Bjb0Z2N0FZbk9FOFI5aGVnOHNTUXlJ?=
 =?utf-8?B?M1ZUSmJyaVJ6NmtpR21rL1BHSU5Vems5bmJLdHJTYVdEczN5MFUxTk1yWmJ3?=
 =?utf-8?B?OC9meURkd2NqeXgwYWdNamtSczN0ZUVnTHV4SkNDS3ZSdERtTjBXKzFXNUNh?=
 =?utf-8?B?UGhEcU9kUVpsTzY4ZTBSNjJQYlN2YjlJZzI0V0tweHIxNDRodVhzRjNBbDcx?=
 =?utf-8?B?cFdTTWFMalkyV2oxMGR1T1JKY0oyd2xpSWFEN29BakZJZ3o1Y280NW1waTB0?=
 =?utf-8?B?UFZKdityc2d3bUJ1OVBlMVRIWk56aDRHMW1PdzhVNkQvTGFKdG9yOW1hUVIz?=
 =?utf-8?B?dVNHa1BUWkJjcE85VCtZS09IdUpPRUgxNkNYOWg0ZzZmUDNCaFYrTlpBYkdJ?=
 =?utf-8?B?bzlrYjNQYkhFNkhhcmxTc20xeE9Vdmw4R0lwbFRkdktqanY1Q0NIdlhjYWFy?=
 =?utf-8?B?ejV3bUFXRmJQU0V5R1ZKTks3SFcyaVRKTld5eXNQUHNNTkJURFJaTnpjZFVP?=
 =?utf-8?B?YUpZbDBLTkhuL2xPb3ZlVlBxZEJ4MGhWRmhicDR6NFRITHNyamdUUWJ4MEEw?=
 =?utf-8?B?OWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CB109368487654BA4291D58718789E1@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a54938-4e9e-460f-9b5a-08db24541560
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 06:19:35.7094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IgaW/TK5mnBb7dqKMK3IbCtismgzLjHeikZUCP4HJT51d6/LT4u7iTwjQLNYHmdXf5LfC6hCNkBtzeXN5GL00t1BAhsK+e0zx3JXdanCnOz6CKD1XBm+UsAHig9334ku
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2547
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8xMy8yMyAxNToxNCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiBPbiBNb24sIE1hciAx
MywgMjAyMyBhdCAwMjo1Njo1OVBNICswMjAwLCBNYXR0aSBWYWl0dGluZW4gd3JvdGU6DQo+PiBP
biAzLzEyLzIzIDE4OjUxLCBKb25hdGhhbiBDYW1lcm9uIHdyb3RlOg0KPj4+IE9uIE1vbiwgNiBN
YXIgMjAyMyAxNDo1Mjo1NyArMDIwMA0KPj4+IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZj
aGVua29AbGludXguaW50ZWwuY29tPiB3cm90ZToNCj4+Pj4gT24gTW9uLCBNYXIgMDYsIDIwMjMg
YXQgMTE6MTc6MTVBTSArMDIwMCwgTWF0dGkgVmFpdHRpbmVuIHdyb3RlOg0KPiANCj4gLi4uDQo+
IA0KPj4+Pj4gK0VYUE9SVF9TWU1CT0xfTlNfR1BMKGlpb19ndHNfdG90YWxfZ2Fpbl90b19zY2Fs
ZSwgSUlPX0dUU19IRUxQRVIpOw0KPj4+Pg0KPj4+PiBJIHdvdWxkIHNheSBfSEVMUEVSIHBhcnQg
aXMgdG9vIG11Y2gsIGJ1dCBmaW5lIHdpdGggbWUuDQo+Pj4NCj4+PiBIbW0uIEkgdGhpbmsgSSBs
aWtlIHRoZSBIRUxQRVIgYml0IGFzIHNlcGFyYXRlcyBpdCBmcm9tIGJlaW5nIGEgZHJpdmVyLg0K
Pj4+IE9mIGNvdXJzZSBJIG1pZ2h0IGNoYW5nZSBteSBtaW5kIGFmdGVyIGEgZmV3IHNsZWVwcy4N
Cj4+DQo+PiBFdmVyIGNvbnNpZGVyZWQgYSBjYXJlZXIgYXMgYSBwb2xpdGljaWFuPyA7KSAoTm8g
b2ZmZW5zZSBpbnRlbmRlZCAtIGFuZCBmZWVsDQo+PiBmcmVlIHRvIGNoYW5nZSB5b3VyIG1pbmQg
b24gdGhpcy4gSSBkb24ndCBleHBlY3QgdGhpcyB0byBiZSBkb25lIHRvbW9ycm93KQ0KPiANCj4g
SXQgd2lsbCBiZSBhIG9uZSBsaW5lciBpbiB0aGUgcHJvdmlkZXIgaWYgeW91IHVzZSBERUZBVUxU
X1NZTUJPTF9OQU1FU1BBQ0UNCj4gZGVmaW5pdGlvbi4NCg0KT2guIEkgZGlkbid0IGtub3cgYWJv
dXQgREVGQVVMVF9TWU1CT0xfTkFNRVNQQUNFIC0gb3IgaWYgSSBkaWQsIEkgaGFkIA0KZm9yZ290
IGl0LiBNeSBtZW1vcnkgaGFzIG5ldmVyIGJlZW4gZ3JlYXQgYW5kIHNlZW1zIHRvIGJlIGdldHRp
bmcgd29yc2UgDQphbGwgdGhlIHRpbWUuLi4NCg0KSSBkb24ndCBrbm93IHdoYXQgdG8gdGhpbmsg
b2YgdGhpcyBkZWZpbmUgdGhvdWdoLiBJIGNhbiBpbWFnaW5lIHRoYXQgDQpzb21lb25lIHdobyBp
cyBub3QgZmFtaWxpYXIgd2l0aCBpdCBjb3VsZCBiZSB2ZXJ5IGNvbmZ1c2VkIGFzIHRvIHdoeSB0
aGUgDQpzeW1ib2xzIGFyZSBub3QgZm91bmQgZXZlbiB0aG91Z2ggRVhQT1JUX1NZTUJPTCBvciBF
WFBPUlRfU1lNQk9MX0dQTCBhcmUgDQp1c2VkLiBPVE9ILCBJIHRoaW5rIEkgb25jZSBzYXcgYW4g
ZXJyb3IgYWJvdXQgc3ltYm9scyBiZWluZyBpbiBhIA0KbmFtZXNwYWNlICh3aGVuIHRyeWluZyB0
byB1c2Ugb25lIHdpdGhvdXQgdGhlIG5hbWVzcGFjZSkuIFRoaXMgc2hvdWxkIA0KcHJvYmFibHkg
anVzdCBiZSBhIGdvb2QgZW5vdWdoIGhpbnQgZm9yIGZpbmRpbmcgb3V0IHdoYXQncyBnb2luZyBv
bi4NCg0KTHVja2lseSwgSSB0aGluayBhbGwgdGhlIGV4cG9ydHMgaW4gdGhpcyBjYXNlIHdlcmUg
b25lbGluZXJzIGV2ZW4gd2l0aCANCnRoZSBuYW1lc3BhY2UgZXhwbGljaXRseSBzcGVsbGVkLiBX
ZWxsLCBJIHRoaW5rIHRoYXQgZm9yIG9uZSBvciB0d28gDQpleHBvcnRzIHRoZSBzZW1pY29sb24g
ZGlkIHNsaXAgdG8gY29sIDgxIG9yIDgyIC0gYnV0IEkgYW0gbm90IHN1cmUgaWYgDQpmaXhpbmcg
dGhpcyB3ZWlnaHMgbW9yZSB0aGFuIHRoZSBjbGFyaXR5IG9mIGV4cGxpY2l0bHkgc2hvd2luZyB0
aGUgDQpuYW1lc3BhY2UgaW4gZXhwb3J0Lg0KDQpXZWxsLCBJIGd1ZXNzIEkgY2FuIGdvIHdpdGgg
ZWl0aGVyIG9mIHRoZXNlIHdheXMgLSBkbyB5b3UgaGF2ZSBhIHN0cm9uZyANCm9waW5pb24gb24g
dXNpbmcgdGhlIERFRkFVTFRfU1lNQk9MX05BTUVTUEFDRT8NCg0KDQpZb3VycywNCgktLU1hdHRp
DQoNCi0tIA0KTWF0dGkgVmFpdHRpbmVuDQpMaW51eCBrZXJuZWwgZGV2ZWxvcGVyIGF0IFJPSE0g
U2VtaWNvbmR1Y3RvcnMNCk91bHUgRmlubGFuZA0KDQp+fiBXaGVuIHRoaW5ncyBnbyB1dHRlcmx5
IHdyb25nIHZpbSB1c2VycyBjYW4gYWx3YXlzIHR5cGUgOmhlbHAhIH5+DQoNCg==
