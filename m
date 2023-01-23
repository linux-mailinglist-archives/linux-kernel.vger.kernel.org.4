Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBB3677AF0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjAWMak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjAWMah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:30:37 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2050.outbound.protection.outlook.com [40.107.12.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7904ABB9A;
        Mon, 23 Jan 2023 04:30:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkW0ghAT6mDfmxvzfrpkhIw7ipUAJYRPd04vvIx/tk100H3Q31BVrPF7KUDj3+6l1h7s4o4BXYCFR4aXIvHpJiV1nlHrfs7OdDNnOM5+ACYZVJh8GPKWrjtNQNTdFIN7Nriqxma5x1aoew7GTdF7nGLW/q86kxEVIoC1OawttI77tUz6BT267u0PDkaiD5RJ3RRTOyrLfX0tW5UyIOkjQK6jNZl6CtDLwza9jb02RJg6vcKp8Y5q+WNLuTkZHe0vB1lsWN2g+RRZAeqp6ulbz4HxNgDEUrYcwaPeUp/EbjGbFVnjQhrbVU+OWrKNFCr7R8xYsFq/4JBv8CCYv8pg9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p86fTMgBo9Uu734RIo3lpca1qWg7ZKeHRlP4lILGrCI=;
 b=nAH/2ajtYVF9fxLeD8v85XdWBlbd87cjVRnI0pJF1PqVivpLy4EbSjwl0cqnc+LDI7l4pDhAWZCTadp5Jbtql8cKSyV5RtjSgkItdhnsiSDIRHr7qAPkgBpRh6lophwr4NQRrvXt/xQdRzDeHA9aDj0/LDJznvcqjeCGDdizhsRy7EbWoaQI7gMfqFLJE0jYiRAC/0LtlNnvgak5ikrl4oqXsbAQnYAEGxGm2zgQiBY6xAphhdCKiDVkfYoPaLi1HMFSLqQMpd6Z/Pg8bbWyt3UtWaPHAOIb7QvbbFEKC93qbc3PViD2ZsRvxa5C5/U/qZYxWzZrcqH2UFbuZkhMwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p86fTMgBo9Uu734RIo3lpca1qWg7ZKeHRlP4lILGrCI=;
 b=Pl3dWJqdBqjVE/6auo1znNJ0Imm2xWW+Zpe1R89hTaQvSptOYaBJ0rPUV3DzwfGE8FmfmcPFwjBsKmRnwKDRImx12SXdhT7bqnkHuU8fhBCudxfco8KRVHafdO17/iPoMZ34CADHodgL7cUzk0rqqgUJHwhh2R5XOHOAMTMQIMLgkWq6JPihofNMahhAytlTJnACRo+uFxeum2kNx4fv2JPIm1i3hvJT8xkwqPtruPumaqxlRQMhx9WxtyNpC0Psbb+OEFmbQyfHWB+0ex5SXbGsHbDdQF3uqUMHq5YGsLmIBYV7BcxC5wSgxBkNAe8fnBWsKrBPijppVreAg4hRlA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB3035.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:30::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 12:30:32 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097%4]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 12:30:32 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Herve Codina <herve.codina@bootlin.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 2/3] ASoC: codecs: Add support for the Renesas
 IDT821034 codec
Thread-Topic: [PATCH v2 2/3] ASoC: codecs: Add support for the Renesas
 IDT821034 codec
Thread-Index: AQHZLLSvyotuf1YmL0q52bZzrUxZsa6rpj6AgAARhICAACY+gIAAEgiAgAADhYA=
Date:   Mon, 23 Jan 2023 12:30:32 +0000
Message-ID: <79b35117-98aa-dc7c-2a27-805cd4ac2c71@csgroup.eu>
References: <20230120095036.514639-1-herve.codina@bootlin.com>
 <20230120095036.514639-3-herve.codina@bootlin.com>
 <d51b826b-e71f-393c-586b-6a1ca953f26f@csgroup.eu>
 <20230123095631.4aba35d6@bootlin.com>
 <eb20dc66-f564-ed7e-8873-65621e5970de@csgroup.eu>
 <20230123131755.1f5702be@bootlin.com>
In-Reply-To: <20230123131755.1f5702be@bootlin.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB3035:EE_
x-ms-office365-filtering-correlation-id: 0ed7244a-8816-40cb-6ce4-08dafd3d9eaa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5ClVQrEAlSUwsCTKl0AGsBRNtr9nOi+3OcPk8O0lMxkCU/7GBeQdb/Rx0EXITlfm7inQa1C514eUAsqcJAl27KhRBsHXMkep/1Bu/a2vtRQo1aDQbnDxBl66FPWrAzN4P/u2fEBLGfyC8iqDpqSQwdFHT/irWN+kE98I22WDCgJdY//CUc+fe8piP7luUrlNcH1yrNuGq7tICSS7tejs4GC0kvos4P5aBUL2OmZlbLzXTgNZY9wJ3AqDrkJTywRL+0m8+ht6kuiGjBi+mmHCARiuJCn/l2HMP7I+mK6buSXSvT9lR+NX3YdLYhc079HD1hk4S8aEVUumfrdR5GPbmE4uXnjhk2YYadHT5EkYsIT57ZTY96rhLPiR8n4D6ZdEk0+VqMR9DLi6TX8GmwKSCBnK45v3z8kIOwcIcCI04SjfgGhIVb156whXKQVThSo90oLy7T7MXGffRDYl2AdwWfZQsT56Cb04F6eaCMCMD9ZN1Pz89SMbT0YaL2LzIpnlrat+p3TkKzuo2WFdOWFp9h+B5Kz9/pbkFqeQl40c0uNATTxfNG4D0hRJFLlJ9+cQouB+9jC08Fs708xWRH5KT5KKhqZ60cKJUPb9CKTuLttXmbCmocQs7ap5G7X8So/nkmV4rI4acm/s8Y4ckNeJ3T2446YDZ+re9xJXU+sgg1IspybPd5WXVPrSxswmqfIIhcBnD9oE8hslGZuje+evfa6roJXaV9Az04kA5bUZlPGRGuA75nz7JZ2/4kEMySTpsaakhVx6LpJx2tI0nUs1aw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39850400004)(396003)(376002)(366004)(346002)(451199015)(122000001)(83380400001)(41300700001)(86362001)(31696002)(38100700002)(38070700005)(5660300002)(2906002)(44832011)(7416002)(8936002)(4326008)(6512007)(6916009)(26005)(8676002)(6506007)(186003)(66574015)(66556008)(316002)(54906003)(66946007)(2616005)(76116006)(66446008)(64756008)(91956017)(478600001)(71200400001)(6486002)(66476007)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VG9ZOVFQWGhkb3JRRUlGR2FRTjFiMHUvbFlncHlpVDVHV0hqZis2dm5lR21i?=
 =?utf-8?B?Ty9HdTUyZTMyckxRVWtHbzhWZEhxcjRHMGZPbzNTcWJIZFNXMDNvWkFQSmE2?=
 =?utf-8?B?M2pVcVZ4N2ZScjBrY2R4WmNCTkhzOUk1ajVScExoSndpZGxNTEppVW1CajhE?=
 =?utf-8?B?b0tyejlRNS9uWU9kN3EySTd2K2g5Y3lheVkvZFZ1TFBhb1BmbXBUamRrQ01y?=
 =?utf-8?B?WnVma3NBLzJtMmhUejNaQ2lOVFRKcXRQNHZtTFBYMlo2ZmpwV04wMVpxQ2dV?=
 =?utf-8?B?ekJ1SjNHUGJ0eXQvQW1rY09IM2pYalJ3aU84OHQwbzhEUVhTSmF4Z21VRFV5?=
 =?utf-8?B?OTJJYmUyRW40bkJLS2NwZ1VaU3Q4K3R5ZTcxdHAva2t6b1YvdnVaTkdSOWxp?=
 =?utf-8?B?aTlvbnNqTm1xUVNwTWRuMHVxL25LK284MTBFZFlKbmxmMGFEc2RSaVBXdHR1?=
 =?utf-8?B?cDVVNTZyL3FSdnpxWFpFSVUvd2ZQekd0Ny9XY0U5ZWhjeCtNbDV5SSt6OTAv?=
 =?utf-8?B?bGF2V2dxOXhEMENOdFRQQVBUeXlma1BHc3hVK0t3am5WUXltWE5PdkQ4Y3Fy?=
 =?utf-8?B?bzBwNTRqWmovaHdwU21rbWhDZ0srVStnN0w5UFZSTjQ0Ri9taHNZb0NXOXN2?=
 =?utf-8?B?ZVk3L3VKcTlMeUVoS3RVN1JRMnFjYWpMRVRiQ3cxcUx0emZGWFlXN25tVGsv?=
 =?utf-8?B?Z3ZOK0tMaDRHZDFPOVFNYWk1a3lkOFJYS1hKMS9kdDNkaHQ1bndNRVZtSnNj?=
 =?utf-8?B?UWxpS0RHUVZNZnFzNUZvdHRkOGVxK1Fod2t5L0xueC8wOWNjdC95WWNKVVBv?=
 =?utf-8?B?UEhEWDF2NDFka0NReFpHaEVaOVpyazBmTnUxZHpGU2tRUmJ4cVdqZThRdGUw?=
 =?utf-8?B?NzJRekNzWTN0KytJT21xdHRNQzdrQ2dXVmNaNlRFK3E1TGVSQ1ViWm51OWIv?=
 =?utf-8?B?QTg5VlNOQ0FPZjJEUEZpbmlDOHNsdWFaVzNMajRQMWRONmJCV1pSVWIyd0lE?=
 =?utf-8?B?YmQ3Z0JJbzlJaTFrdEhmR2xoODBmdzBXTjFSaWIwSkhYL0gxSSt6YVVLYkZJ?=
 =?utf-8?B?cTVaQ1h1NEVlRXgwU0N3dTFDWmkrditIMmNVSHQxZzJ5MlRWSTZKc0w0dURu?=
 =?utf-8?B?VStKNC9mT2JoeDFxS0lMcnVmMHFyNTNhZzJpN0kyME5UelBuZCtmNDhTcHZx?=
 =?utf-8?B?RzlFOEU1RjE2NHpxc0x6Q093UWpwZ21PZnB1Y0tqRENncnRibDVKMjVNMjBP?=
 =?utf-8?B?bHBoR2J2c2cvemd0UldlMkVmUGd0NXNRZjBhQVM1WXhQUndzcHFPS1EzZDIy?=
 =?utf-8?B?TDJXcUFEeHJDMENSZU0xWStGQUlmbmR2WDc2TEhpaC80SGZXVjB0V0ZLVVpC?=
 =?utf-8?B?OWExQVhMUjMvY3FjK0tFeEdHeTF6N3p1Nk5qUlI2ZnBoczVQcHVhMDZZcjBh?=
 =?utf-8?B?UUx6WXNBYWcrNkx3M2dKSGN2cjlIVDdBbjNIOU9oZ3hNLzVJZUdKZElBUFBK?=
 =?utf-8?B?SzRXR3FLMndGeVRFU05PMDdIc2VTOWU1YndKc2ZTOWZZVEpKTEpDbTBHM1dR?=
 =?utf-8?B?bnhNMmo3OXZzemRLc1BjUVdXM1hoMkQ2SDlTbmdTT3JJeEJPaitKdmVmT3p1?=
 =?utf-8?B?V0F1dVVJVGpKWHVOb2tkVlRqNVhxVGQvMjR1YlRaeDZLc1R1eGdkVnJpOEU4?=
 =?utf-8?B?NW1uYTdkZHlGdE9hQXoySnJTUzgwK1dpTWgwMlhYLzNxb3k2OVg5TEpUMjBK?=
 =?utf-8?B?ZlJ5NmhNeUF0V01sSEkxSkZ5bkJmNGdBMXEzVFByNHc4RXQ2K3crS2QyNjA4?=
 =?utf-8?B?VTlqdWJZdUZiekFPYUhTVkJWNU81Rnd2cG9aSXROdFlDNTRXaWVwVjA1R2NS?=
 =?utf-8?B?S1NsZE9IZ0c5TE94WE04a1N1QWd1ZHFDKzZjY0xOWitxMjlPS3ptUjgyOW9V?=
 =?utf-8?B?b3M1NFVMY2VFOU4wdWV2cVQrVTZvdi8zR0d2SzQ1MGg2QXhISDRxMC8venJK?=
 =?utf-8?B?TG82MytFbEswbTVhcDgxSHpvY1g1UzlXNFhSdDRXZFFsL3ZPeDNlQjE4NENW?=
 =?utf-8?B?TC9LU3VIc2dJZ25WTHNKandMUnA5RUJGcGVkeTB2WHZHMm5tSkJrcm83c1Yv?=
 =?utf-8?B?ZHVTb1dkZ2xyaWVmaU5zeE1UR2tvVCs3RTFiNWVpYjNtaHVQeG9SamY4L2ls?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E664E542C65B3B47885A49B7111D46B2@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed7244a-8816-40cb-6ce4-08dafd3d9eaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 12:30:32.2523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: su9BNBULkkqLOxR5bTfHJM5lWGuRcSNuSLxpleHLTua/PhPeAELHjcWY8pKRjkpK3nfmzGYGPXkALZ5K3ugbzuBP44zd5K4vOxKasnGXqCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB3035
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDIzLzAxLzIwMjMgw6AgMTM6MTcsIEhlcnZlIENvZGluYSBhIMOpY3JpdMKgOg0KPiBI
aSBDaHJpc3RvcGhlLA0KPiANCj4gT24gTW9uLCAyMyBKYW4gMjAyMyAxMToxMzoyMyArMDAwMA0K
PiBDaHJpc3RvcGhlIExlcm95IDxjaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+IHdyb3RlOg0K
PiANCj4+IEhpIEhlcnbDqSwNCj4+DQo+PiBMZSAyMy8wMS8yMDIzIMOgIDA5OjU2LCBIZXJ2ZSBD
b2RpbmEgYSDDqWNyaXTCoDoNCj4+Pg0KPj4+IGdwaW9jaGlwX2dldF9kYXRhKCkgaXMgZGVmaW5l
ZCBvbmx5IHdoZW4gQ09ORklHX0dQSU9MSUIgaXMgc2V0Lg0KPj4+IFRoYXQncyB3aHkgdGhlICNp
ZiBzZWN0aW9uIGlzIHVzZWQuDQo+Pg0KPj4gZ3Bpb2NoaXBfZ2V0X2RhdGEoKSBpcyBzdGlsbCBk
ZWNsYXJlZCB3aGVuIENPTkZJR19HUElPTElCIGlzIG5vdCBzZXQsIHNvDQo+PiBpdCBpcyBub3Qg
YSBwcm9ibGVtLCB0aGUgY2FsbCB0byBpdCB3aWxsIGJlIGVsaW1pbmF0ZWQgYXQgYnVpbGR0aW1l
Lg0KPj4NCj4+IEJ5IHRoZSB3YXksIGF0IHRoZSB0aW1lIGJlaW5nIEkgZ2V0IHRoZSBmb2xsb3dp
bmcgd2FybmluZ3M6DQo+Pg0KPj4gICAgIENDICAgICAgc291bmQvc29jL2NvZGVjcy9pZHQ4MjEw
MzQubw0KPj4gc291bmQvc29jL2NvZGVjcy9pZHQ4MjEwMzQuYzozMTA6MTI6IHdhcm5pbmc6ICdp
ZHQ4MjEwMzRfcmVhZF9zbGljX3JhdycNCj4+IGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNl
ZC1mdW5jdGlvbl0NCj4+ICAgICAzMTAgfCBzdGF0aWMgaW50IGlkdDgyMTAzNF9yZWFkX3NsaWNf
cmF3KHN0cnVjdCBpZHQ4MjEwMzQgKmlkdDgyMTAzNCwNCj4+IHU4IGNoLCB1OCAqc2xpY19yYXcp
DQo+PiAgICAgICAgIHwgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPj4gc291
bmQvc29jL2NvZGVjcy9pZHQ4MjEwMzQuYzozMDU6MTE6IHdhcm5pbmc6DQo+PiAnaWR0ODIxMDM0
X2dldF93cml0dGVuX3NsaWNfcmF3JyBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtZnVu
Y3Rpb25dDQo+PiAgICAgMzA1IHwgc3RhdGljIHU4IGlkdDgyMTAzNF9nZXRfd3JpdHRlbl9zbGlj
X3JhdyhzdHJ1Y3QgaWR0ODIxMDM0DQo+PiAqaWR0ODIxMDM0LCB1OCBjaCkNCj4+ICAgICAgICAg
fCAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+PiBzb3VuZC9zb2Mv
Y29kZWNzL2lkdDgyMTAzNC5jOjI3NjoxMjogd2FybmluZzogJ2lkdDgyMTAzNF93cml0ZV9zbGlj
X3JhdycNCj4+IGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1mdW5jdGlvbl0NCj4+ICAg
ICAyNzYgfCBzdGF0aWMgaW50IGlkdDgyMTAzNF93cml0ZV9zbGljX3JhdyhzdHJ1Y3QgaWR0ODIx
MDM0DQo+PiAqaWR0ODIxMDM0LCB1OCBjaCwgdTggc2xpY19yYXcpDQo+PiAgICAgICAgIHwgICAg
ICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4+IHNvdW5kL3NvYy9jb2RlY3MvaWR0
ODIxMDM0LmM6MjcxOjExOiB3YXJuaW5nOiAnaWR0ODIxMDM0X2dldF9zbGljX2NvbmYnDQo+PiBk
ZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtZnVuY3Rpb25dDQo+PiAgICAgMjcxIHwgc3Rh
dGljIHU4IGlkdDgyMTAzNF9nZXRfc2xpY19jb25mKHN0cnVjdCBpZHQ4MjEwMzQgKmlkdDgyMTAz
NCwNCj4+IHU4IGNoKQ0KPj4gICAgICAgICB8ICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+
fn5+fg0KPj4gc291bmQvc29jL2NvZGVjcy9pZHQ4MjEwMzQuYzoyNTA6MTI6IHdhcm5pbmc6ICdp
ZHQ4MjEwMzRfc2V0X3NsaWNfY29uZicNCj4+IGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNl
ZC1mdW5jdGlvbl0NCj4+ICAgICAyNTAgfCBzdGF0aWMgaW50IGlkdDgyMTAzNF9zZXRfc2xpY19j
b25mKHN0cnVjdCBpZHQ4MjEwMzQgKmlkdDgyMTAzNCwNCj4+IHU4IGNoLCB1OCBzbGljX2RpcikN
Cj4+ICAgICAgICAgfCAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+Pg0KPj4N
Cj4+IFdpdGggdGhlIGZvbGxvd2luZyBjaGFuZ2VzIEkgaGF2ZSBubyB3YXJuaW5nIGFuZCBhbiBv
YmpkdW1wIC14IG9uDQo+PiBpZHQ4MjEwMzQubyBzaG93cyBubyByZWZlcmVuY2UgdG8gZ3Bpb2No
aXBfZ2V0X2RhdGEoKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvY29kZWNzL2lkdDgy
MTAzNC5jIGIvc291bmQvc29jL2NvZGVjcy9pZHQ4MjEwMzQuYw0KPj4gaW5kZXggNWViOTNmZWM2
MDQyLi44Yjc1Mzg4ZTIyY2UgMTAwNjQ0DQo+PiAtLS0gYS9zb3VuZC9zb2MvY29kZWNzL2lkdDgy
MTAzNC5jDQo+PiArKysgYi9zb3VuZC9zb2MvY29kZWNzL2lkdDgyMTAzNC5jDQo+PiBAQCAtOTY4
LDcgKzk2OCw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX3NvY19jb21wb25lbnRfZHJpdmVy
DQo+PiBpZHQ4MjEwMzRfY29tcG9uZW50X2RyaXZlciA9IHsNCj4+ICAgIAkuZW5kaWFubmVzcwkJ
PSAxLA0KPj4gICAgfTsNCj4+DQo+PiAtI2lmIElTX0VOQUJMRUQoQ09ORklHX0dQSU9MSUIpDQo+
PiAgICAjZGVmaW5lIElEVDgyMTAzNF9HUElPX09GRlNFVF9UT19TTElDX0NIQU5ORUwoX29mZnNl
dCkgKCgoX29mZnNldCkgLw0KPj4gNSkgJSA0KQ0KPj4gICAgI2RlZmluZSBJRFQ4MjEwMzRfR1BJ
T19PRkZTRVRfVE9fU0xJQ19NQVNLKF9vZmZzZXQpICAgIEJJVCgoX29mZnNldCkgJSA1KQ0KPj4N
Cj4+IEBAIC0xMTMzLDEyICsxMTMyLDYgQEAgc3RhdGljIGludCBpZHQ4MjEwMzRfZ3Bpb19pbml0
KHN0cnVjdCBpZHQ4MjEwMzQNCj4+ICppZHQ4MjEwMzQpDQo+PiAgICAJcmV0dXJuIGRldm1fZ3Bp
b2NoaXBfYWRkX2RhdGEoJmlkdDgyMTAzNC0+c3BpLT5kZXYsDQo+PiAmaWR0ODIxMDM0LT5ncGlv
X2NoaXAsDQo+PiAgICAJCQkJICAgICAgaWR0ODIxMDM0KTsNCj4+ICAgIH0NCj4+IC0jZWxzZSAv
KiBJU19FTkFCTEVEKENPTkZJR19HUElPTElCKSAqLw0KPj4gLXN0YXRpYyBpbnQgaWR0ODIxMDM0
X2dwaW9faW5pdChzdHJ1Y3QgaWR0ODIxMDM0ICppZHQ4MjEwMzQpDQo+PiAtew0KPj4gLQlyZXR1
cm4gMDsNCj4+IC19DQo+PiAtI2VuZGlmDQo+Pg0KPj4gICAgc3RhdGljIGludCBpZHQ4MjEwMzRf
c3BpX3Byb2JlKHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpDQo+PiAgICB7DQo+PiBAQCAtMTE2NSw2
ICsxMTU4LDkgQEAgc3RhdGljIGludCBpZHQ4MjEwMzRfc3BpX3Byb2JlKHN0cnVjdCBzcGlfZGV2
aWNlICpzcGkpDQo+PiAgICAJaWYgKHJldCkNCj4+ICAgIAkJcmV0dXJuIHJldDsNCj4+DQo+PiAr
CWlmICghSVNfRU5BQkxFRChDT05GSUdfR1BJT0xJQikpDQo+PiArCQlyZXR1cm4gMDsNCj4+ICsN
Cj4+ICAgIAlyZXQgPSBpZHQ4MjEwMzRfZ3Bpb19pbml0KGlkdDgyMTAzNCk7DQo+PiAgICAJaWYg
KHJldCkNCj4+ICAgIAkJcmV0dXJuIHJldDsNCj4+DQo+Pg0KPj4gQ2hyaXN0b3BoZQ0KPiANCj4g
UmlnaHQsIEkgZGlkIHRoZSB0ZXN0IHRvbyBhbmQgaW5kZWVkLCBJIGNhbiByZW1vdmUgdGhlICNp
ZiBzZWN0aW9uLg0KPiANCj4gSSB3aWxsIHVzZSAoSSB0aGluayBpcyBjbGVhcmVyKSBhdCBpZHQ4
MjEwMzRfc3BpX3Byb2JlKCk6DQo+IAlpZiAoIUlTX0VOQUJMRUQoQ09ORklHX0dQSU9MSUIpKSB7
DQo+ICAgICAJCXJldCA9IGlkdDgyMTAzNF9ncGlvX2luaXQoaWR0ODIxMDM0KTsNCj4gCQlpZiAo
cmV0KQ0KPiAgICAgCQkJcmV0dXJuIHJldDsNCj4gCX0NCj4gDQoNCg0KSSBndWVzcyB5b3UgbWVh
biA6DQoNCglpZiAoSVNfRU5BQkxFRChDT05GSUdfR1BJT0xJQikpDQoNCg0KPiBJcyB0aGF0IG9r
IGZvciB5b3UgPw0KDQoNCg0KV2hhdCBhYm91dDoNCg0KCWlmIChJU19FTkFCTEVEKENPTkZJR19H
UElPTElCKSkNCgkJcmV0dXJuIGlkdDgyMTAzNF9ncGlvX2luaXQoaWR0ODIxMDM0KTsNCgllbHNl
DQoJCXJldHVybiAwOw0KDQpDaHJpc3RvcGhlDQo=
