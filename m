Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6401767797B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjAWKr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjAWKr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:47:27 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2085.outbound.protection.outlook.com [40.107.12.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6A412F04;
        Mon, 23 Jan 2023 02:47:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M515EDmh6N4NiGZKGs3qOT/PpeHvJB6aRiiIlgCxC7Q+mo6Qyy40oB7reZ1PHOgXkg60Fmg5mcngylM29CJf86nw6laFQD48OQTOnVx6liS27JZG8xF3X2JoO8LdXhVbn/EFMc6ZRIo9Xl8HYkCYv7+y/FTexE1dsKl/brqzNPCrSRgJR20dsAq0dF9BjRHQkzDLkk1XJS5lnY8GRb2Gd1AxuZ5itcISY8MnK47AwtAmpv3vVA6VapkeuS3otTqiaAxiP8xADJMkC3lZnknhXvCg8NLIgoNw2GotZy8NQkXBe/ykRkFupO7hdxjPR0j9ZRttHoFjpatcFG+BPMhgNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vr9c0cbQElegFdX8hHCEEPxb30ck5/+mxFYHHtQQX9o=;
 b=IyKD5O6kk2ftsSPOY35oH8umdkmCAHIux5L2zqoAIKg01g0uy8B9fAa1w95JFHxoKbplZT26V9l9Ug5bRTXSLJ5l5VCi0n/TpcwrdGwGd1IqO+cu6Xm1dHas9zr5ZN0fauaaZOCeur5Lef6xBD9kYa82GDNbUfIUR+yQop2yatJQtfyNItMpWJWRrJs9/DfgHHhZCKkRnFa6k+0VgfvzcZO9BKJp0i/flwOyCDNygsQtkGLAMgUuHkr83p17ntm/Phjae429EakAo5eCs5hFmjMdEgz9iLIg3D9ef2qyR+2L5Lutt+kuAfOrD++8HpHo1ZJxS+f0VJ9OI6YI4kPLqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vr9c0cbQElegFdX8hHCEEPxb30ck5/+mxFYHHtQQX9o=;
 b=6AvSJHwzxP9e8eZshX/treww8ffx7uCaoFjBycBv4SCXBMQeeLmBTub8fhNu15K9gy9pm9n6j1y1V+Uk13TH099OFYudcSmRfUQtG0soYHFKId0g7ajd8oEhPHrCoGryfKlLPrvb3zX6g8Ey9Q0ER34ehziVQLDI/suI/zy4p9Q+L7qN/nuniJIGfe5ZgdjdANKvmLFBM8IKbbHwY/Wql6hOYzdvTcCwc77RryZYgs12VWKdex1JiHEJ8g/CzJJCokfwQ9t9VwCNHjTbLYsJQK9+2FzEwfe9nCVSNsgJGO7ywbVZS2VVsLHvHVFAwkLBDUL0Maz47fL7bX2akUsb3A==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB3369.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:110::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 10:47:24 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097%4]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 10:47:23 +0000
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
Thread-Index: AQHZLLSvyotuf1YmL0q52bZzrUxZsa6rpj6AgAARhICAAB76gA==
Date:   Mon, 23 Jan 2023 10:47:23 +0000
Message-ID: <20b4b695-1ea5-7b70-5791-1b611d685c44@csgroup.eu>
References: <20230120095036.514639-1-herve.codina@bootlin.com>
 <20230120095036.514639-3-herve.codina@bootlin.com>
 <d51b826b-e71f-393c-586b-6a1ca953f26f@csgroup.eu>
 <20230123095631.4aba35d6@bootlin.com>
In-Reply-To: <20230123095631.4aba35d6@bootlin.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB3369:EE_
x-ms-office365-filtering-correlation-id: 06fa5c1a-74fe-4af0-4984-08dafd2f3613
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bgICKgKwvQlC4TIORkgnzmNwx/i2benvMPhrt9jZm4+HzyNrnMdB+1mi7RsFtCHfc8KBu8iosTCKjZ7p3/DbyO/S+d44135UbzRBHYpx3fSCHymfJ1ZVI0brGwBngnavzMRMJG9TljFtDERxveGb82Xpbh6NzAJZsNSj0POOyNjgf+nVeYDlundCRQjMdu0GsmBgJ/560bL5KpqplrD5ofr1mF3Qhoouvf/5bLo3TWA+khRut77v4hGpOKljmujv7BaXkl9F6busjxjmxpjvEyGwGOuC6NifHuhvzNGZ/hrwQu0W3Fx8aJfBHMiHgKDaSOqahxDAdPdJ5+QnEkMIQ3rRieChm4YSYB6UV/BCeLCaFv3/U2FoWX8C9GbI4kC7GxWhB/en7Z13J/MhwGz/ZXfRJP3i3I3ZacYitpW3MYaClxUghl3ZU0lR+I8ZkmwuaK6nx8PswMkJhStWDrdUe/qxunTmwghb35xXtCu4KrZ10vUluvIlj2O+546zpXiqI2pTEJtY4y+qY7XAlkWfT7z+U9RAqNWE1CL7ltQcpjLcPJ7Aj+WzuVt50k2rfsia4wqi2nrk7RA/KQlqIR1ewiyAOoBP/LvgY+8o12drObKNVWOoOQgOUzBvuL0x3H5I1+OijPPB1YfZFStAFNstdIbgYWdYMO1Eft78ZAR+KP9WBTaBWAw9wtaIo1gdtI/ehDcfStNE3clKZn2YO7kvR1zfN7cH76NNuCjmK/OsevaQJktHDPTJyvc6Lf2hhonhPMRD3oXdsJoCOX3wwQq9Lg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39830400003)(136003)(366004)(376002)(346002)(451199015)(122000001)(38100700002)(36756003)(31696002)(86362001)(478600001)(38070700005)(316002)(54906003)(6486002)(66446008)(64756008)(8676002)(76116006)(66946007)(66556008)(6916009)(66476007)(4326008)(91956017)(2616005)(71200400001)(31686004)(2906002)(6506007)(8936002)(41300700001)(186003)(26005)(44832011)(6512007)(5660300002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWthVTQ1aVYxbGRoaFNhakdiRDYzam5KR0RtODN1N0pmbjJtcWgxMkZLVmR1?=
 =?utf-8?B?bkNmczNscnVQbnBxYXRFRVkxbStpMVN4U2w2RUFxZFRGUkxrVVErNkRmVjlZ?=
 =?utf-8?B?a2dWVWJsSkprYjM2UmhudWtMM0lnMjZrT1lCTHZqbkpmdk9VbWcxcHZlektZ?=
 =?utf-8?B?ZjdpTWxpNWxsZlgyWElqMWowUTF6dVFkWE9XeTdUK3AyeWQ5dk1wNFRWR0l5?=
 =?utf-8?B?S0E1dkUra3ZaSGlGYitVazlIcWF5cE04Q0IwWlA5b256UjRNMXI4d2tvcm00?=
 =?utf-8?B?YlVSMVh6dldrdFNCa0RoRkFPdnNsbHhyWWFZYVNMRGZBSWREVHRLQ3NBRW9p?=
 =?utf-8?B?a3ZjcDRYMmZIa0treEo2eWdwNGdheEQ1dEh0ZGJFbzJteG5kQ2VpQngyTEoz?=
 =?utf-8?B?N1lBaThqdk1ONkVhVDN5eWQ0NGdTYmZZYURhcmwzQVdheVR1OStWbjEvQjVE?=
 =?utf-8?B?ampTWHoyLzY1YkZ5WDFJS1R1ZiszYm9ZczVmSjN2MWxFYnl3Nnkyc1Y3bkd1?=
 =?utf-8?B?Yk4vaUZaRUR1MzUrZ0hBZWRzTys1QTJPNXNFNStOOEJWQ3ZwVEZlNk5ib2t4?=
 =?utf-8?B?LzZRU1BITy9EUm9TNDVkVHBwWmVoQnhJalZSSEYwekpycjhtMUVpL0VrWU9p?=
 =?utf-8?B?SGZROGpRdEc3WFlxUGJvYU5DdVd1THkrVlBaaVQ5NmNIQVFOVk1PamVtQVp4?=
 =?utf-8?B?TmhFdFBzWEo0ZGtWVGEvU2VwMEtMd2d5QWxpOWtVUU5lMlg3c0YvbUpQM1JK?=
 =?utf-8?B?dDgrQmNOVlBLZUZBNWVncTdLTkdEZDF5bmZtNGRMVzZsN0x2cngraVgxdWcy?=
 =?utf-8?B?RGVVOFJGRCtRQWVHYXR4aVBaMzlaRGRFSWpYTURISzRlSDVLTWtyZFVuYVk1?=
 =?utf-8?B?WkExc0FGRVBEdExSNm5JbWJJcHRXUWZKc2kvckVscWNBNGc5VW1wd3JEUVdk?=
 =?utf-8?B?SjBLcG5KaHQ1MDM4eWRJR0Q3YW9xOFRWaWJZT1JWMm5xWkE1aUcvQmJJVS9t?=
 =?utf-8?B?S2N1UTQ1MzdxNjZaemVLalBZdkt3NTVzLzRjTFpzS3FzM1BqVkxhdmcrZjVZ?=
 =?utf-8?B?ZFVjb2JxdS9nalpKWDVHd2hPY0IyUThISmVrSndQUS9WdTNpVFBjMHZvOG4y?=
 =?utf-8?B?THc2Z3RZTlJLTExSTFpHZS9sdHVmQlRramtLbGJqd3JNekx5aTZ5bGFHL3Iv?=
 =?utf-8?B?TFA0NHBYL2FjaE1GYnNVbWJMam10S3grWG5wdS96OXBubnJxRlNJUnF3Ynly?=
 =?utf-8?B?M012NVorKzIyRXhxWUE1MVlJeDc3eVgzRnF6aDRCbFhjZXhJTFRFemU3UjE4?=
 =?utf-8?B?OHVVVVQyaFpYWmNzaWF5TEdWUG4zTjZZcG9QYmJ1VG5UWEM1cXZqTDlnRHNG?=
 =?utf-8?B?alhVVFI1TVg1UDFIUk4zMm1pZjBQNGFsYlpUOHNrTTRBeStYVnhHbTBjSU1R?=
 =?utf-8?B?N3FIU0ZxN2dCVWdDY1RDNGhRWnZTU1BkclVNRllNWURFdTIxTjl3WTJZZm9o?=
 =?utf-8?B?K0JJY1ZvM09xMjRhTjd4NlJBNUsydWZlb080SHpnOEd2RGR2cjlHVU9CZGo1?=
 =?utf-8?B?aVBmcG10UlNBL3hDcEtwcDdGdzM4TW5sc2ZPM3JEUjd1Vks2b1RHbFJ2dW1r?=
 =?utf-8?B?NGd6b21PRnJYWVVnajBhLzR1TUdPb1FjdG5RUXBlb1Z0TTdYR3F0VUlWT054?=
 =?utf-8?B?ZVRSRnRGZHN3YkJPS24zWjdweGcxR2dhU0p6UFJHUTZRZzRRdUtTa3ZVTkxk?=
 =?utf-8?B?WURTZFV5U05WNlVKT0Irb3YwRHJ3a21SejVrZmRocnVGUVllMjZ6Vy9maGs2?=
 =?utf-8?B?TDJ0YlZlbFhqb2l4YlZPRVJuTmR6a1FES1B2VG1CNkYydDNtQkJpRW5SUyti?=
 =?utf-8?B?eTExaHg5QjZtU0VBd3JIM3RkSzBySzRiQVovZ3VLUS9meWNKOTBROFpmZk12?=
 =?utf-8?B?TXhyWVJ6ZW53SlV0b09FQ2FmS0J0V3hqaGV6RHJuakF6VzVkQnQxZVYrNTY4?=
 =?utf-8?B?Z1lkT1ZPRURYYTRPQkpiZzV2cTlGaWhDb2hMMmpZNXRJcEViYnZwcFZvRmFC?=
 =?utf-8?B?WW9TVkRJSytaVXZmbDIvQzArU25HVGpvNVdSTG13bmpYR1kwcU1zK21pYVY4?=
 =?utf-8?B?NnZYcitub3pXaWcyWjFvTUdxN1JaWUF1a1M3djVUQTgvWWh5ZktTTTlNWTRE?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92E389F7633AE945ABFB68A9452C0C5D@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fa5c1a-74fe-4af0-4984-08dafd2f3613
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 10:47:23.8401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hwk6O5Ed60/8TI5Ttzz4yNwgulFH2Ux+P7pXs9UudaFpwii5PyswudHAR6/ww7eBtFQO0YAQ2uv1hpwNc2b21H3PUrxIFBphx5n3iAH18sM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3369
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDIzLzAxLzIwMjMgw6AgMDk6NTYsIEhlcnZlIENvZGluYSBhIMOpY3JpdMKgOg0KPj4+
ICsNCj4+PiArc3RhdGljIGludCBpZHQ4MjEwMzRfc2V0X2NoYW5uZWxfcG93ZXIoc3RydWN0IGlk
dDgyMTAzNCAqaWR0ODIxMDM0LCB1OCBjaCwgdTggcG93ZXIpDQo+Pj4gK3sNCj4+PiArCXU4IGNv
bmY7DQo+Pj4gKwlpbnQgcmV0Ow0KPj4+ICsNCj4+PiArCWRldl9kYmcoJmlkdDgyMTAzNC0+c3Bp
LT5kZXYsICJzZXRfY2hhbm5lbF9wb3dlcigldSwgMHgleClcbiIsIGNoLCBwb3dlcik7DQo+Pj4g
Kw0KPj4+ICsJY29uZiA9IElEVDgyMTAzNF9NT0RFX0NPREVDKGNoKSB8IGlkdDgyMTAzNC0+Y2Fj
aGUuY29kZWNfY29uZjsNCj4+PiArDQo+Pj4gKwlpZiAocG93ZXIgJiBJRFQ4MjEwMzRfQ09ORl9Q
V1JVUF9SWCkgew0KPj4+ICsJCXJldCA9IGlkdDgyMTAzNF84Yml0X3dyaXRlKGlkdDgyMTAzNCwg
Y29uZiB8IElEVDgyMTAzNF9DT05GX1BXUlVQX1JYKTsNCj4+PiArCQlpZiAocmV0KQ0KPj4+ICsJ
CQlyZXR1cm4gcmV0Ow0KPj4+ICsJCXJldCA9IGlkdDgyMTAzNF84Yml0X3dyaXRlKGlkdDgyMTAz
NCwgaWR0ODIxMDM0LT5jYWNoZS5jaFtjaF0ucnhfc2xvdCk7DQo+Pj4gKwkJaWYgKHJldCkNCj4+
PiArCQkJcmV0dXJuIHJldDsNCj4+PiArCX0NCj4+PiArCWlmIChwb3dlciAmIElEVDgyMTAzNF9D
T05GX1BXUlVQX1RYKSB7DQo+Pj4gKwkJcmV0ID0gaWR0ODIxMDM0XzhiaXRfd3JpdGUoaWR0ODIx
MDM0LCBjb25mIHwgSURUODIxMDM0X0NPTkZfUFdSVVBfVFgpOw0KPj4+ICsJCWlmIChyZXQpDQo+
Pj4gKwkJCXJldHVybiByZXQ7DQo+Pj4gKwkJcmV0ID0gaWR0ODIxMDM0XzhiaXRfd3JpdGUoaWR0
ODIxMDM0LCBpZHQ4MjEwMzQtPmNhY2hlLmNoW2NoXS50eF9zbG90KTsNCj4+PiArCQlpZiAocmV0
KQ0KPj4+ICsJCQlyZXR1cm4gcmV0Ow0KPj4+ICsJfQ0KPj4+ICsJaWYgKCEocG93ZXIgJiAoSURU
ODIxMDM0X0NPTkZfUFdSVVBfVFggfCBJRFQ4MjEwMzRfQ09ORl9QV1JVUF9SWCkpKSB7DQo+Pj4g
KwkJcmV0ID0gaWR0ODIxMDM0XzhiaXRfd3JpdGUoaWR0ODIxMDM0LCBjb25mKTsNCj4+PiArCQlp
ZiAocmV0KQ0KPj4+ICsJCQlyZXR1cm4gcmV0Ow0KPj4+ICsJCXJldCA9IGlkdDgyMTAzNF84Yml0
X3dyaXRlKGlkdDgyMTAzNCwgMHgwMCk7DQo+Pj4gKwkJaWYgKHJldCkNCj4+PiArCQkJcmV0dXJu
IHJldDsNCj4+PiArCX0NCj4+DQo+PiBDYW4gd2UgcmVmYWN0b3IgdGhlIHRocmVlIGFjdGlvbnMg
d2l0aCBhbiBoZWxwZXIsIHRoYXQgY291bGQgYWxzbyBiZQ0KPj4gcmV1c2VkIGZvciBpZHQ4MjEw
MzRfc2V0X2NvZGVjX2NvbmYoKSBhbmQgaWR0ODIxMDM0X3NldF9jaGFubmVsX3RzKCkgYW5kDQo+
PiBpZHQ4MjEwMzRfc2V0X3NsaWNfY29uZigpIGFuZCBpZHQ4MjEwMzRfd3JpdGVfc2xpY19yYXco
KSBhbmQNCj4+IGlkdDgyMTAzNF9zZXRfZ2Fpbl9jaGFubmVsLCBzb21ldGhpbmcgbGlrZSBmb3Ig
aW5zdGFuY2U6DQo+Pg0KPj4gc3RhdGljIGludCBpZHQ4MjEwMzRfc2V0X2NvbmYoc3RydWN0IGlk
dDgyMTAzNCAqaWR0ODIxMDM0LCB1OCBjb25mLCB1OCB2YWwpDQo+PiB7DQo+PiAJcmV0ID0gaWR0
ODIxMDM0XzhiaXRfd3JpdGUoaWR0ODIxMDM0LCBjb25mKTsNCj4+IAlpZiAocmV0KQ0KPj4gCQly
ZXR1cm4gcmV0Ow0KPj4gCXJldHVybiBpZHQ4MjEwMzRfOGJpdF93cml0ZShpZHQ4MjEwMzQsIHZh
bCk7DQo+PiB9DQo+IA0KPiBJdCBjYW4gYmUgY2hhbmdlZC4NCj4gVGhlIGZ1bmN0aW9uIG5hbWUg
d2lsbCBub3QgYmUgaWR0ODIxMDM0X3NldF9jb25mKCkgYXMgaXQgaXMgbm90IHRoZSBzYW1lDQo+
IGtpbmQgb2YgZnVudGlvbiBhcyB0aGUgaWR0ODIxMDMxX3NldF8qKCkgYWxyZWFkeSBhdmFpbGFi
bGUgaW4gdGhlIGNvZGUuDQo+IFdoYXQgZG8geW91IHRoaW5rIGFib3V0Og0KPiAgICBzdGF0aWMg
aW50IGlkdDgyMTAzNF8yeDhiaXRfd3JpdGUoc3RydWN0IGlkdDgyMTAzNCAqaWR0ODIxMDM0LCB1
OCB2YWwxLCB1OCB2YWwyKQ0KPiBvcg0KPiAgICBzdGF0aWMgaW50IGlkdDgyMTAzNF9jb25mX3dy
aXRlKHN0cnVjdCBpZHQ4MjEwMzQgKmlkdDgyMTAzNCwgdTggY29uZiwgdTggdmFsKQ0KPiANCj4g
SSBwcmVmZXIgdGhlIGZpcnN0IG9uZSBidXQgaXQgaXMgb25seSBhIHBlcnNvbmFsIHByZWZlcmVu
Y2UuDQo+IE9uIHlvdXIgc2lkZSwgd2hhdCBkbyB5b3UgcHJlZmVyID8NCg0KaWR0ODIxMDM0XzJ4
OGJpdF93cml0ZSgpIGxvb2tzIGdvb2QgdG8gbWUuDQoNCkNocmlzdG9waGUNCg==
