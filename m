Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DF16F00BB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 08:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243003AbjD0GUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 02:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242836AbjD0GUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 02:20:39 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2088.outbound.protection.outlook.com [40.107.9.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE4F420A;
        Wed, 26 Apr 2023 23:20:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3bHdM39BR88j0khXTXVlGqmtfU3NDNnrwQsJqcCNU43aLiu4ibPLySS/fju58s9f2GUJNZCDSICwOnFBapI6hbr1idUY1n21klpJ1lxDz3edjrZa4Ig+m944uSuvB7wmLSWJq3X9bN33USmDaIr/CLyRsXhlRMX9n4/Nhyi/5iluy/nlc2zo5o/ZIOSdn0WcY5b+5xi+6v2e9bi9ek3FDXWTesNlfr5MjenJ+fb2nY1RyVNN1u1qliCCsxnmIKeixhqPTWQCZeX94sk7eNS2wkC0jWmwfRi6EJfsIQvrncI9HVBFzb6HxssK4pAZNRo41bYhomnO6rmz54tR4ZRbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MS83fR9URRKwFcmF8wpDTWOmhFwUhLEfIBeX9nVQjug=;
 b=aXFokzzoVQp0iDHlHkVzD6i+zwU+xx1nh4C1TIuSL4Im2s4We7RgH24e+gYXRFJbMyTfkWJ3sZqFAyfDm6aKv7z3+wMCOEeHMkhXjnj8973ABFlH1Kwr4LGsaGmwvD6Dmgrb1MemxVx110nR0PAMU62Uu9K9RQrbzoKG2TBMxIijdt4wzzGImcYbn+A3NkIbhDRZFuXT50FKtlnogEWNHZe9LR9EDbFSkfPv0U+eYoRIO+XK0n8Te6zJdceT4Zt1cqNGrmm0wLzodIpvBhZH8YfEp8xIJN0AKBeGLkC5cA1gy8MDpVnWNcv1CIc5A83gqPpd2+3yeZDNFMYSK5On6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MS83fR9URRKwFcmF8wpDTWOmhFwUhLEfIBeX9nVQjug=;
 b=xZELSNPh2pQNxwxuKgi2WaTQjx5MJEcwxvHGndV6KKMgeyvgkuhuGWncUU+wNvkfheHzolug195cHiIOh/8AcKih7szMSKu7vXKw6hJAX8darFvPXHDmrWBb8YU2V3iU9Ws/ejglQK4/1lWF2t4B4wuB2t1k+UbiCc4Lqm0MGsLxw0/jwKa7b4UKO8/MicAuPkolrfyvPBLZ0cCankB1Av4DcZHiEu2Vs4jWswh6XOhZxmy63o+fXl3Skzvhy3A2/qZSyJUJy741PPu3JH3Fyd5w4drT14yig2r49YLRIdLrBwStGChYY8jsKpE0MH2Ked51UTP+9mrYyHTiYINmCQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB2141.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 06:20:34 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8d19:d0c0:1908:3f25]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8d19:d0c0:1908:3f25%5]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 06:20:34 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Andreas Kemnade <andreas@kemnade.info>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ": Tony Lindgren" <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Subject: Re: [PATCH] gpiolib: fix allocation of mixed dynamic/static GPIOs
Thread-Topic: [PATCH] gpiolib: fix allocation of mixed dynamic/static GPIOs
Thread-Index: AQHZeIsM14bqQdx5QUm8jstSB2yPI68+pFKAgAAF0ICAAAWGgA==
Date:   Thu, 27 Apr 2023 06:20:34 +0000
Message-ID: <52453352-74bd-979f-03b6-322489800538@csgroup.eu>
References: <20230426220338.430638-1-andreas@kemnade.info>
 <f6b261ad-3267-db70-c173-154a12c42bea@csgroup.eu>
 <CAHp75Vep8VSirY7mvGGCubNi-O4jS_inTALS3Ei9mQu98RV+7Q@mail.gmail.com>
In-Reply-To: <CAHp75Vep8VSirY7mvGGCubNi-O4jS_inTALS3Ei9mQu98RV+7Q@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB2141:EE_
x-ms-office365-filtering-correlation-id: ebece40a-e464-41ef-9083-08db46e7828b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /io0IMCvVTsJQ6YR73gatUDUQqmJqf9a6ibmMd9KfT3ruLhqMpXh2DxpuXsX34HCNss08D/duy8gD9woiZKhW2BmfNx9VHEHQfYjhkl4coDMb1S03cb2lnUuQSjswLaKuUmSV5Aks1UIxtFzbVq3oUtv3f7G5RB0b2GXlkWracrWAbWCtCwFVNX/fJq1LJoY831TDNiy8HWI1Z3KETDxOv3ykSn7lyVg9vk5K7U+nsMKDW0knsQn9QNrtvhm/ga1Cpd9/sL02VFXhZF3l41cQQU7hAVPDb/zG4uTQ8daxgML2Xtdqs682DTftfRMmV87khdvyIKEcg/UAQ7Ejdg1uA6CxZkWaDOMVONIx3yBGVJ+TrQdW6LST5g5HWGlVhx+o7O3+ZHD/mVLAzP9O9I7uG6X5XmG5rvbAOjpDiWvVzxGbulL1obkiLLPzL4W2hgIzrBYksIinDhpvso9vv2VlKexL5zeZeKf1o9MB+ZVdN5JiFDJ2yJnvTorh50WlxDqCeO+w1V+Xb0/rlbRpZmYRv83f9FcBLm93PbMiCApY3fl0ItpemTeo9CaigmqIlnKopNfVjeLF+2WQbAIq2nJeDQM2K+YzLSwH77wVP7fQpDIwPZbBX17L8tGX2QbjhzEc82nDhXfpvXn7Kvlw8DsExfvUGfb1EyEO6OfxTqAlR7e18lXq2+TYP3IhvWCOOQcfpmFAXzEH0tkfFHKG6kTUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39850400004)(366004)(396003)(376002)(346002)(451199021)(966005)(86362001)(76116006)(91956017)(186003)(71200400001)(478600001)(6512007)(26005)(6506007)(53546011)(54906003)(6486002)(36756003)(122000001)(8676002)(8936002)(38100700002)(2616005)(41300700001)(38070700005)(31686004)(66574015)(2906002)(5660300002)(44832011)(6916009)(31696002)(316002)(4326008)(66476007)(66556008)(66946007)(66446008)(64756008)(116466002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dThLdlBndE4wN0xYSUFabEt3ditNYVpXcXM5cUZMUnVKbEdkd0Z4UGhTRDc3?=
 =?utf-8?B?TDlqQ1R6VDhQNkdvK1M2YnJpNndhZFhJblcyZmQ2YWVGTXVENm56MkRXZ0tW?=
 =?utf-8?B?bkpKam9NWXBkUzJ5cHFHV0RGd1M0YjVBTXg4TWlXOW5uMUdUcEdiaGhhQzJ1?=
 =?utf-8?B?bjgranJ0N0I2dWM1U3NGcUQvT1U2WW8xbmxKRUF3NU9qeGd3MVhPTWM1K0FI?=
 =?utf-8?B?QXdydFVzTjF0U2ZDZWlYNUNramJjejRVY2pSR3ozVmtualVRdStNaXRnd05p?=
 =?utf-8?B?YUVSa1A1M09LMkRHQTcvdU1oVEU5MEFJTDF0cGM5ajlnK1NlemYwbzA0SHdU?=
 =?utf-8?B?d2pHc1NldlFpbjVGNWd1V1RRMGoyTXZGVjVNVkFUZmVoQy85Zy9mUnJDQTMy?=
 =?utf-8?B?RWlWSHk2WDBSUVIwRUxHRlR3OEpEK1NEV2NvUEdEbXJtRkdmK2hxL2c2WkxZ?=
 =?utf-8?B?YnFLOERoTDlZelk1Um03ZERQNmtUOEthenJkdUw5cTFDNDI4d0pFSUwzL1Ez?=
 =?utf-8?B?WU1XclFHaWhPMGVacVM0OTI1cVN4Qk4zaFM5TCsvQ09Ock04T2U1aG5pY1gx?=
 =?utf-8?B?NzJoSjI4S0J2dE9aS2Z4RVpxWFpmcWg4TTlrOS82VEFoT1RGZWdHbGtQV2Zp?=
 =?utf-8?B?RDBVeEFYM1BEU0Q4T0NmcmZFNnZ0OWxhY0tESzJ1cjlDYW52dmRlbHVzUjcv?=
 =?utf-8?B?VlRwUlpFbGJHSURPb1R2Ung3VmR5VmxNRGF6dGRtWFJoUHpFRFNpc1B3SnZV?=
 =?utf-8?B?ZktTWEN4MlNjNjdQUFNDclVHZjZqeVRHa0FMTEZoOFFpVDRKWTBLV2tpSW94?=
 =?utf-8?B?YmJzMnVqV0p3TVN4Q3l6NnFRamFidXZyRGt6VldUTWdiYktXbk01cURjNG5V?=
 =?utf-8?B?N3ArTlhNRUZ3NWREa3pCUi9HRWRhSE1RZGVKNEZwaW84Tlp4RXFLZFd6WVpj?=
 =?utf-8?B?VlJ5NWJBUnlyV1p0bUxZRHYxQmg2S2pjZ01sM0c0RVlvM3I0M1prTzhZKzQ0?=
 =?utf-8?B?M0xnalpTMzZXaGZMV0ZHQUt3OWVHemttc1VQUDUwOU5Gd21MSmZFT2RSVjhz?=
 =?utf-8?B?dHZqMnhZRWc1TEVMcExzVzBUMGhsbHQ4TFk3ME00VUNnNlUvbGhLMkhrT29o?=
 =?utf-8?B?OFl2UW9MN2toaVpCUUc2ak5UaG9ZQU9lUjIzeE5nY0poSGxIV08rOUNFSlBq?=
 =?utf-8?B?Mk1Ib1p3Lys2WFBBVStrVEhsOEM5UUZ2OUpnbisxcXpmNEFFZUJIV3paYmdF?=
 =?utf-8?B?aDVTU3N2UE1QMGdWYjJRWTBxMDkxTWh5MVhqRzlPek9rdWZ3NmVGMnlGdU83?=
 =?utf-8?B?bUhJaDA1Wk9lZzlqTE1rYmxWcHlGQ0o5TDFKNXUrWHBFUHJTc0hlcXlxWXo3?=
 =?utf-8?B?VGpYMHRFY0d6T0E2MGRoeXdHM0VwZmY4OVExWVZkN1JSbElmelM2Nm4wNk53?=
 =?utf-8?B?THdiVlFuNkdqeko1T041RmpscVFLRkhQWlRtTE5sR2dzNzAwZVZjQmh4ZFNv?=
 =?utf-8?B?c2RtTE82OXNlbHBPeGp1ZERWOXEvTVViZGR6bUNyUUdKTmpWeXNQT3RCVjRC?=
 =?utf-8?B?eEJJdkxYSzhVREY0UVMyUnJSaXVLVnFJSFVsSGxkcjYzRVJwayt1VXY0Ulcx?=
 =?utf-8?B?Si96cXR2L1VJYmhBRU5GRkxOTTY2TkJPY280L1hIak5nd24zUmVRbGVzM1Vl?=
 =?utf-8?B?ZjZyZ09HRlBvVm8xekRBRlMxQ2xkZ0hlL3FmaUtLOXFHa2YrRnJWb2pVQWlk?=
 =?utf-8?B?WGx2ak5CWmoyZGdrdGd1dGNJNlhMeTNiOUhjd0VOaDdDRUtjSHcyd1MrWmJX?=
 =?utf-8?B?Sms1azZjcTBxUldRYVF4UmMyMTFBaUVFQ3hrZ05wZzVYOGp0djZWUld5THJL?=
 =?utf-8?B?Tk95dHpiVCtuRUhCSGxEdGNoWG5YM1BOanZ2MjVlWjFJejd2S1VWZ292VkFw?=
 =?utf-8?B?dWxURjR1Mm9DcGkzL0prOFdPbkVVMnBXZlJPVmJVSVJDZ3NtWDRyeDEvOG5t?=
 =?utf-8?B?NEFzRUxpRDBEOVZDeFBMOHlIdngrcWVqU3MraHArNW1uNUVUek5FK2k3Nnlv?=
 =?utf-8?B?Si95Y3pGS05jMXJKZEFwaGg1c1hTWGFnUldMdkRsSjExQ0dId1VBREgyNk1S?=
 =?utf-8?Q?fjKYKhjJCM324K9rueTBZun6x?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C10BBE54EFD4C4ABC6CB208068DF6E7@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ebece40a-e464-41ef-9083-08db46e7828b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 06:20:34.4283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ckyR7BHSc5z7mSMeyOSeyMGlS+aQuxIV8+9QHCNMA1ySsstZ11ScwXqeqU713rkyEW0bWJrLEM3kcPj6NK9iyJIxMu3q0ybaA7s6vfBhNvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB2141
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDI3LzA0LzIwMjMgw6AgMDg6MDAsIEFuZHkgU2hldmNoZW5rbyBhIMOpY3JpdMKgOg0K
PiBPbiBUaHUsIEFwciAyNywgMjAyMyBhdCA4OjQw4oCvQU0gQ2hyaXN0b3BoZSBMZXJveQ0KPiA8
Y2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1PiB3cm90ZToNCj4+DQo+Pg0KPj4NCj4+IExlIDI3
LzA0LzIwMjMgw6AgMDA6MDMsIEFuZHJlYXMgS2VtbmFkZSBhIMOpY3JpdCA6DQo+Pj4gW1ZvdXMg
bmUgcmVjZXZleiBwYXMgc291dmVudCBkZSBjb3VycmllcnMgZGUgYW5kcmVhc0BrZW1uYWRlLmlu
Zm8uIETDqWNvdXZyZXogcG91cnF1b2kgY2VjaSBlc3QgaW1wb3J0YW50IMOgIGh0dHBzOi8vYWth
Lm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+Pj4NCj4+PiBJZiBzdGF0aWMg
YWxsb2NhdGlvbiBhbmQgZHluYW1pYyBhbGxvY2F0aW9uIEdQSU9zIGFyZSBwcmVzZW50LA0KPj4+
IGR5bmFtaWMgYWxsb2NhdGlvbiBwb2xsdXRlcyB0aGUgbnVtYmVyc3BhY2UgZm9yIHN0YXRpYyBh
bGxvY2F0aW9uLA0KPj4+IGNhdXNpbmcgc3RhdGljIGFsbG9jYXRpb24gdG8gZmFpbC4NCj4+PiBF
bmZvcmUgZHluYW1pYyBhbGxvY2F0aW9uIGFib3ZlIEdQSU9fRFlOQU1JQ19CQVNFLg0KPj4NCj4+
IEh1bSAuLi4uDQo+Pg0KPj4gQ29tbWl0IDdiNjEyMTJmMmEwNyAoImdwaW9saWI6IEdldCByaWQg
b2YgQVJDSF9OUl9HUElPUyIpIHdhcyBzdXBwb3NlZA0KPj4gdG8gZW5mb3JjZSBkeW5hbWljIGFs
bG9jYXRpb24gYWJvdmUgR1BJT19EWU5BTUlDX0JBU0UgYWxyZWFkeS4NCj4+DQo+PiBDYW4geW91
IGRlc2NyaWJlIHdoYXQgaXMgZ29pbmcgd3JvbmcgZXhhY3RseSB3aXRoIHRoZSBhYm92ZSBjb21t
aXQgPw0KPiANCj4gQWJvdmUgY29tbWl0IG9ubHkgd29ya3MgdG8gdGhlIGZpcnN0IGR5bmFtaWMg
YWxsb2NhdGlvbiwgaWYgeW91IG5lZWQNCj4gbW9yZSB0aGFuIG9uZSB3aXRoIHN0YXRpYyBvbmVz
IHByZXNlbnQgaXQgbWlzdGFrZW5seSB3aWxsIGdpdmUgeW91IGENCj4gYmFzZSBfYmVsb3dfIERZ
TkFNSUNfQkFTRS4NCg0KQWggcmlnaHQsIHRoYXQgbmVlZHMgdG8gYmUgZml4ZWQuDQoNCj4gDQo+
IEhvd2V2ZXIsIHRoaXMgY2hhbmdlIGlzIGp1c3QgUG9DIEkgcHJvcG9zZWQsIHRoZSBjb25kaXRp
b25hbCBhbmQNCj4gYWN0aW9uIHNob3VsZCBiZSBzbGlnaHRseSBkaWZmZXJlbnQgdG8gY292ZXIg
YSBjb3JuZXIgY2FzZSwgd2hlbg0KPiBzdGF0aWNhbGx5IGFsbG9jYXRlZCBjaGlwIG92ZXJsYXBz
IHRoZSBEWU5BTUlDX0JBU0UsIGkuZS4gZ2Rldi0+YmFzZSA8DQo+IERZTkFNSUNfQkFTRSwgd2hp
bGUgZ2Rldi0+YmFzZSArIGdkZXYtPm5ncGlvID49IERZTkFNSUNfQkFTRS4NCj4gDQoNClllcyB5
b3UgYXJlIHJpZ2h0LCB0aGF0J3MgZ2Rldi0+YmFzZSArIGdkZXYtPm5ncGlvIHRoYXQgc2hvdWxk
IGJlIGNoZWNrZWQuDQoNCkNocmlzdG9waGUNCg==
