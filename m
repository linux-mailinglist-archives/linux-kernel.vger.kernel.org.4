Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9333770F1E8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240580AbjEXJMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240595AbjEXJMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:12:47 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2050.outbound.protection.outlook.com [40.92.98.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F053184
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:12:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBqPpEqh1R0jxfyJ8aRZg2+amnM6ckY2XS36snyUQ/WZx1+13kYeGw9CNZAqjWX8KxapyFJp9fhsxhrWGY+gt3te+P5V9BlKrZ7NgISL+OW3ljo6cMZRSmPyZqMsBtJ6Fjdes4Xcj4Y+yyevHu9xkWnC0s7X9t3aNWq6JLkxNkLDN9OjFdn4NsPDnpIhjMuHSZmOmJ2Xh9A4lE9WwHAOLeR9YSduhLcMkFmFs5GHO+iUpEMXBWyDki+i0hp68yS/JWj4TpD/r1gsMPS++wqjgjR3DZneqjkajhdBST1oZnB6wnbeqKk//nf9bIXPtOGmGiuJuRXuMopXvtVyFr08jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHMPZGS1TDAqIFQY3kwzgFN/cKtjgzGQuQ5/nfJsw6c=;
 b=SXxDG1hv9nRp6K19zcSu3Ap0Vcdp6PuK0ViuLkbwp2oPp6JCOf7h2ScCw+/DUL/w06R2py7/NJz2nrfZdu4DnoOSOpdt+dFjXFinyuWP7TCA7rgJOGqSdQ2eXddfRUNW1hdWLWOsdDNy/N3coJ3vFWCgSFyf7vFyxAuKs0B7Vx/birTeATbp/jSLVzftpCZ+k0ojK0SzpaLrk6FxX6XY0jxyvTIbuTgHkiXxRaM6kiOvCOElsAiiqb8QV2E61oDhMfwx8Ppvj/dgkJezkLN8yo0wno9DXhp82rLAMLkfLPMs7J/0khiWeVW0UEKVIo/D2rgOwNCEm5kYsNQhecMKsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHMPZGS1TDAqIFQY3kwzgFN/cKtjgzGQuQ5/nfJsw6c=;
 b=D2sWOst8OkCkJva1eIeeQChAD5IDmIW4Yw0vvTWyja5HxuyL034kFl426eJ7sMBeYK+9+JfCKQ2a5ge6micUOU4AJd1HNe2UKmfVRXiepaSYgZHNAHGdALUXBbc8Gr/3YPD+eUsOSe/pqRJF84IPT0FI/IDu9zalt4rZZvaSALr8ucpOQ+q7N0QQJcF2e9/wtZxDmOHoMIZ8bw6N7V4Gjok393JJcd8ieA1KuEXSUOJrNxqDWK04WlEAiDfxSTB2/ABbHMm9K6GTJ3JAYvOA8JOZW/WUoYoFXIrsjUUyhSa/HOeiFbxy1iThp531L3CVQnQDjJhq2rJGFnIJTIGvZQ==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TYVP286MB3716.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:36d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 09:12:39 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5805:16d6:6ab7:6639]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5805:16d6:6ab7:6639%5]) with mapi id 15.20.6411.029; Wed, 24 May 2023
 09:12:39 +0000
Message-ID: <TY3P286MB2611130B8500A098E33598E498419@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date:   Wed, 24 May 2023 17:12:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Shengyu Qu <wiagn233@outlook.com>
Subject: Re: [PATCH v11 0/3] regulator: Add X-Powers AXP15060/AXP313a PMIC
 support
To:     Andre Przywara <andre.przywara@arm.com>,
        Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>
Cc:     wiagn233@outlook.com, Martin Botka <martin.botka@somainline.org>,
        martin.botka1@gmail.com, Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230524000012.15028-1-andre.przywara@arm.com>
In-Reply-To: <20230524000012.15028-1-andre.przywara@arm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------JHJfrvz3qXsOmrazwX1M8xtb"
X-TMN:  [iW2ZjwezmODVXvKgbtE1s4kpK3NRgq87]
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <bb6ab5e3-f0cd-4ab7-2c21-0df9815025fd@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYVP286MB3716:EE_
X-MS-Office365-Filtering-Correlation-Id: cf5494b1-5648-420f-58dc-08db5c3705c4
X-MS-Exchange-SLBlob-MailProps: YfhX3sd/0TXNxj/Xt5tX4sxVLZRBiLOUrhc3tHonJKEY5or3xu+T9vxwFR9sbFHWAiurHloX2zO/vJ8MkoMMWEZfybnOcEw73CUPdoAbSOJPSNwnMZiqUUcB3YCXtHK6xIjc3Vn8BcEVfi4HL2T95UMA1AtV4+bOZDI4Tpe67enkRAT+VRplF7PNrqgCQb97vd2hjIHRfa8qSHqIG5K2NquftLJjlEUXbxWLNh3BBh9iYW3YrvqcjwsHEBJE+UMOPtOcTeNsIO86UY9qCNKgjkEhagb0iSRAgu+eB4M5OaEPJRQmO1j3cc5uSsziynCat2F01w5SQkSm0PA1BB3haGtfsb7HK5HpX7nLUfkqFp1SCNPh4jRm3N0AHMcl33jZmMv2iFirnXvuWuCgWdshIQfnBd51wb/NFWKK2CoMioEQdpogS0r4buonR68daqrFqXCcXU56rgqOZUvHxQWr4MC9yRrhyE1AJKuGvuDS/13J1VxGjvWM+w6dWlplijGoCGk9k67i+5TR1mGC4XrQUEGhYrEUROsnUQFXacC3RAm/4jz33Z3tJfVnbPvePtTgD128dH+XHewqDpLUBVeiTElwaulyWAThZ2W+B9JWCdlKm2MpkCvqxfx+U2nm8x5cXrdcfncuzAQKluRNOYsCz8OGN4Fkcr8fJcfgOhRV4liknQBq1qF+WWd4DCxkIkzIR9a7RUP4fN5Z7hWo2pzfzKcu4QOMY/fWJZ33MbRlX5PXMYzPkeEKwouSDi94iyRoFx1G9ZnwplzuJi6XcsLu2d/HdT/DbTb83xkXEfQuWG8=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /BFC/cC9oC5T70mZ1VMp6rBV/CC04A/tEmIMbjmZa2+nZSmZRGAjUJt5cLZ5D/XEkUk3MsssuopHfOY19WL3MlGsTp81eGXG9frIV/ng/eXO/voD82yxBv2qlKpoIoq6o825kEhnD1n0FTic4uAiNe63bKAxFd1MlfJsjsuJWL8nB3x2pD0gmJQkz1A8+3ZOTQziirqS5eSYFDMH500+D7gfEopu2mCTarUCtLoTqgXuHxLe0fnMCu9CFwfLN3VzmSNpgW48WnfozyXdOVxqP+OXiZ00C08xn1dYgYLgNxvE/zGr5xJCzvtf3x1NbRA6Swvd6SEueGimVsM+NHn4pYTLcRmFP7oCG/NS7IXBdfKBkqSaEqVPDNQo8zN/icdUJzCiT+xx/Madw04vax2z95Eewri8Ne/d20YWzyXfMNNfeWrvwtjGm7dkSIg2kt3isHHWlB/+9DTSGSxTSxdi3bURP2nZ8kxj2wrEXrnJPOPa+GQdst4EV5meC8hcR8TbujTVJxOlV4hJ0GacmHXcMQFqrKH3F8wfHhUwsbdjWJK7+jjYOO6U5hPZCdsaQlYmsZw0z7RXTsvldZBWJo5hIt1ZvBeAIoQBO0KBJqFL3SPun3F3hOJ7u9oTcyunISvGGAHyo8qkvOFHmoDB2t7L5A==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXBmaS9KSUFsdWwwZ05rVU9mN0dZL0x2Zi9rU0g3S3ZYNjlSNi9tQUp3SnFB?=
 =?utf-8?B?L1Z3YXcvZ3ZWZWRqT0RVUHkyVzNSaXZiY2F5TERIMGQva2U5YkxyOExkK2Y2?=
 =?utf-8?B?bHorUWNqS2xIdDJlTERXUDNDQVNmSXhNbzhIU09LaU9mTVhDaGthck5vSHlz?=
 =?utf-8?B?TkErYmdqbmswV1VsWUtWbUtjeFFkM2gwQ0xHZmpPdVBjNHVCaTZqRVdJSTRY?=
 =?utf-8?B?Nnl3Nyt4MnJDeDhkWTdzYVg1Ni9JYzFRSCtSQkkrOVl0TmVVeVlZR2hWZ2tm?=
 =?utf-8?B?ekIwMGZHRjJOVHVPeHdxTFBRUkZzZkpwcnZkR3ZHQmord2JDNjZZK2xXUEp6?=
 =?utf-8?B?VWlvU3NiUmtFdEZnVG9LSzRVTzJaQkVBYXE1cmNWTit2eUJSSy96ZGQ0R1g4?=
 =?utf-8?B?SnFtT0lBNDYxVmRTdzU2Zy95eVFla0NDVlB0d1MwbkY1TUxaZ3l5Uk9qbzBq?=
 =?utf-8?B?a2pYVWRIajBQbUNIZkV5bngyRWZ6KzdUZjVWU3dhUDI1TXo5RjlJRmNHcVYy?=
 =?utf-8?B?Tmp0MnVCV3htVDRaME9Wa2pSOW1GbFdQTVY4RTJKY3NUa1E4RWJxd0JCYlF6?=
 =?utf-8?B?bFl2MlV1L2pmVDBqNytNVnN1c3dHUFM5dlQrTjN0bEU5QmFuRXpYRmFQdnA0?=
 =?utf-8?B?U0lYNTRKQTYvYTVIblpIWldlYWFTTUZNL1plMytrU0l5TFp2OCsyR25Na0xY?=
 =?utf-8?B?MFVXR3YrWUpLeXg5QTdhbzZieUFwSm12NDhaTU56VjlmRDVwUHNHeDJaMktH?=
 =?utf-8?B?ZHhqTGRQMDhHRmZwbk1hbysybjRDRmxZd0wvdlk4eXpIUEJiK2FHM0JxTjZE?=
 =?utf-8?B?MDJDRW5sdW1ETWlHMzlyajlCWU5tYnpocXhUbUxTbTI1bmd5TG80R3pac2Jm?=
 =?utf-8?B?Z2FVSXNTeVFDaWd6c1o1a3ZyMHRhSWt1UjFnUjdKeWcxWHJSU3hsMDZNTVhJ?=
 =?utf-8?B?RnVrNkdMSGU3STgrZ2drVmJod0RDYUp3RFlZNGRxRjZUbHhueHpLQkQyaFNi?=
 =?utf-8?B?b3RZNFMxc0poNnFTaU8yS3RSWFpMd2hGei9iOWJGVFhYbjNwU1pPbGxlR08r?=
 =?utf-8?B?MHc2ZjkzUm11NGh3bzM5aThIM3l1UTNFalhuMVpRZ2JrUlNmQjVHbzcwVFpH?=
 =?utf-8?B?dXhPTXJvUmd0RkUwamcyWEJVbGxkZWEzdHBHL3Jyc2FxbHRzWHlyRFlUWUx4?=
 =?utf-8?B?cm9ab1pmRTNiNGpxaGNpWmNSdUFVT0tqUjl0RzQvT2N3Wko0T05kZ1FoQktL?=
 =?utf-8?B?NlRlRitiODg4Q3ZUSkRGd04zbHY2eTZWdWw1QXRLaWdpUmVzVDlnRCtBbGgw?=
 =?utf-8?B?a0xxOUwrM2g5cDhWRFNOWWpDVWN3M3lLYllwSGhkN2QwUnJtenkrNzQ0U2dJ?=
 =?utf-8?B?T3RMcnZiYjRqK0V4NUc5OEFkajRzSEpTQjQzaHUxd2hURGpmeFV3dngza0Fp?=
 =?utf-8?B?UmpnUG9QUjRWNGpNRGdiaVVOWHozeFBzU1dTcVZsa2R3UHdOaEVHTURUNnhY?=
 =?utf-8?B?OEd1VnIweVBxdlIyTERoYlFmNEVLTUQ0TWZIZmtrR0l1RHlraUFNWHJyQ0Zm?=
 =?utf-8?B?bUdSU0VnMm1pTUhsajZDV1Vhb0dCdmdCd1l3SEpBMzVvZC9sRWc1SGM5QVVv?=
 =?utf-8?B?RzlsaXZLd1NlR0RWTnFoYW1lMGozTVE9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf5494b1-5648-420f-58dc-08db5c3705c4
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 09:12:39.5958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVP286MB3716
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------JHJfrvz3qXsOmrazwX1M8xtb
Content-Type: multipart/mixed; boundary="------------YWDpRHQ5iGoPy5Rwuh6Hh1Yw";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Andre Przywara <andre.przywara@arm.com>, Lee Jones <lee@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Mark Brown <broonie@kernel.org>
Cc: wiagn233@outlook.com, Martin Botka <martin.botka@somainline.org>,
 martin.botka1@gmail.com, Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Message-ID: <bb6ab5e3-f0cd-4ab7-2c21-0df9815025fd@outlook.com>
Subject: Re: [PATCH v11 0/3] regulator: Add X-Powers AXP15060/AXP313a PMIC
 support
References: <20230524000012.15028-1-andre.przywara@arm.com>
In-Reply-To: <20230524000012.15028-1-andre.przywara@arm.com>

--------------YWDpRHQ5iGoPy5Rwuh6Hh1Yw
Content-Type: multipart/mixed; boundary="------------CceeTACUHKmCf29ZruQrwmB9"

--------------CceeTACUHKmCf29ZruQrwmB9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgQW5kcmUsDQoNClRoYW5rIHlvdSBmb3IgeW91ciB3b3JrLCB0ZXN0IHN1Y2NlZWRlZCBv
biBBWFAxNTA2MCB3aXRoIG5vIHByb2JsZW0uDQoNClRlc3RlZC1ieTogU2hlbmd5dSBRdSA8
d2lhZ24yMzNAb3V0bG9vay5jb20+DQoNCkJlc3QgcmVnYXJkcywNCg0KU2hlbmd5dQ0KDQo+
IEhpLA0KPg0KPiB0aGlzIHBhdGNoIHNlcmllcyBhZGRzIHN1cHBvcnQgZm9yIHRoZSBYLVBv
d2VycyBBWFAxNTA2MCBhbmQgQVhQMzEzYQ0KPiBQTUlDLCB3aGljaCBhcmUgZ2VuZXJhbCBw
dXJwb3NlIFBNSUNzIGFzIHNlZW4gb24gZGlmZmVyZW50IGJvYXJkcyB3aXRoDQo+IGRpZmZl
cmVudCBTT0NzLCBtb3N0bHkgZnJvbSBBbGx3aW5uZXIuDQo+DQo+IFRoaXMgaXMgbW9zdGx5
IGEgcmVwb3N0IG9mIHRoZSBwcmV2aW91cyBwYXRjaGVzLCBjb21iaW5pbmcgYm90aCB0aGUN
Cj4gQVhQMzEzYSBhbmQgQVhQMTUwNjAgc2VyaWVzLCByZWJhc2VkIG9uIHRvcCBvZiB2Ni40
LXJjMywgYW5kIG9taXR0aW5nDQo+IHRoZSBwYXRjaGVzIHRoYXQgYWxyZWFkeSBnb3QgbWVy
Z2VkLg0KPiBUaGUgZmlyc3QgdHdvIHBhdGNoZXMgYXJlIHRoZSBzdWNjZXNzb3JzIG9mIHRo
ZSBBWFAzMTNhIHYxMCBwb3N0LA0KPiB0aGUgdGhpcmQgcGF0Y2ggaXMgYmFzZWQgb24gU2hl
bmd5dSdzIEFYUDE1MDYwIHYzIHBvc3QuDQo+DQo+IFRoZXJlIHdlcmUgbm8gY29kZSBjaGFu
Z2VzLCBqdXN0IHNvbWUgdGlueSBjb250ZXh0IGRpZmZlcmVuY2VzIGR1ZSB0bw0KPiB0aGUg
cmViYXNlLCBwbHVzIEkgYWRkZWQgdGhlIG5ld2x5IGdhaW5lZCB0YWdzLg0KPg0KPiBBcyB0
aGUgRFQgYmluZGluZ3MgYW5kIHRoZSBBWFAxNTA2MCBNRkQgcGFydCBhcmUgYWxyZWFkeSBp
biB0aGUgdHJlZSwNCj4gdGhpcyBpcyBqdXN0IGNvbXBsZXRpbmcgc3VwcG9ydCB3aXRoIHRo
ZSBNRkQgcGFydCBmb3IgdGhlIEFYUDMxM2EsIGFuZA0KPiB0aGUgcmVndWxhdG9yIHN1cHBv
cnQgZm9yIGJvdGggUE1JQ3MuDQo+DQo+IFNoZW5neXUsIE1hcnRpbjogY2FuIHlvdSBwbGVh
c2UgZ2l2ZSB0aGlzIGEgZmluYWwgdGVzdD8NCj4NCj4gQ2hlZXJzLA0KPiBBbmRyZQ0KPg0K
PiBDaGFuZ2Vsb2c6DQo+DQo+IHYzL3YxMCAuLiB2MTE6DQo+IC0gYWRkIGJyb29uaWUncyBh
bmQgQ2hlbi1ZdSdzIHJldmlldyB0YWdzDQo+IC0gcmViYXNlIG9uIHRvcCBvZiB2Ni40LXJj
Mw0KPg0KPiBBWFAzMTNhOg0KPiB2OSAuLiB2MTA6DQo+IC0gdXNlIE1GRF9DRUxMX1JFUyBt
YWNybw0KPiAtIG1hcmsgZGNkYy1mcmVxIHByb3BlcnR5IGFzICJmYWxzZSIgZm9yIEFYUDMx
M2ENCj4gLSBhZGQgTGVlJ3MgQUNLDQo+DQo+IHY4IC4uIHY5Og0KPiAtIHVzZSBNRkRfQ0VM
TF9OQU1FIG1hY3JvDQo+IC0gZml4IExETyByZWd1bGF0b3IgbmFtZXMgdG8gbWF0Y2ggdGhl
IGRhdGFzaGVldA0KPiAtIG9ubHkgbWFyayBjaGFuZ2luZyByZWdpc3RlcnMgYXMgdm9sYXRp
bGUNCj4gLSB1c2UgY29ycmVjdCByZWdpc3RlciBmb3Igc2h1dGRvd24gb3BlcmF0aW9uDQo+
IC0gYWRkIHBvd2VyIGtleSByZXNvdXJjZXMNCj4gLSBkaXNhbGxvdyB4LXBvd2VycyxkY2Rj
LWZyZXEgaW4gdGhlIERUIGJpbmRpbmcNCj4gLSBkcm9wIHVudXNlZCBPVVRQVVRfTU9OSVRP
UiByZWdpc3RlciBuYW1lLCBhZGQgU0hVVERPV05fQ1RSTA0KPiAtIHJlcXVpcmUgZGNkY2Zy
ZXEgYmVpbmcgMCAobm9uLXByZXNlbnQgRFQgcHJvcGVydHkgZGVmYXVsdCkNCj4NCj4gdjcg
Li4gdjg6DQo+IC0gQWRkIGNoZWNrIGZvciBkY2RjZnJlcSBiZWluZyB6ZXJvDQo+DQo+IHY2
IC4uIHY3Og0KPiAtIFVzZSBhbHBoYWJldGljYWwgb3JkZXJpbmcNCj4NCj4gdjUgLi4gdjY6
DQo+IC0gY2hhbmdlIG5hbWUgZnJvbSBBWFAxNTMwIHRvIEFYUDMxM2ENCj4gLSBleHRlbmQg
Y29tbWl0IG1lc3NhZ2VzDQo+IC0gZHJvcCBBWFAqX0ZSRVFVRU5DWSByZWdpc3RlciAobm90
IHVzZWQgYW55d2F5KQ0KPiAtIGJldHRlciB2ZXJ0aWNhbGx5IGFsaWduIHN0cnVjdCBkZWZp
bml0aW9ucw0KPiAtIHJlbmFtZSBJUlFzIHRvIG1hdGNoIG5hbWVzIHVzZWQgZm9yIG90aGVy
IFBNSUNzDQo+IC0gYWRkIFJUQ19MRE8gcmVndWxhdG9yDQo+IC0gdXNlIGRlY2ltYWwgbnVt
YmVycyBmb3Igc2VsZWN0b3IgcmFuZ2VzDQo+IC0gdXNlIG1hY3JvIGRlZmluaXRpb25zIHRv
IG5hbWUgc29tZSB2YWx1ZXMNCj4gLSBmb3JjZSBEQy9EQyBzd2l0Y2hpbmcgZnJlcXVlbmN5
IHRvIGJlIGZpeGVkIGF0IDMgTUh6DQo+IC0gY2hhbmdlIExETyBzb3VyY2Ugc3VwcGx5IHRv
IFZJTjEgKGFzIHBlciBkYXRhc2hlZXQpDQo+DQo+IHY0IC4uIHY1Og0KPiAtIFVzZSBhbHBo
YWJldGljYWwgb3JkZXJpbmcgaW4gbWZkDQo+IC0gQ29ycmVjdCB7IHBsYWNlbWVudCBsaW5l
DQo+IC0gUmVwbGFjZSBzcGFjZXMgd2l0aCB0YWJzIGluIDEgc3RydWN0DQo+DQo+IHYzIC4u
IHY0Og0KPiAtIEZpeCBpbmRlbnRhdGlvbg0KPg0KPiB2MiAuLiB2MzoNCj4gLSBNb3ZlIEFY
UDE1MzAgZHQtYmluZGluZyB0byBhbHBoYWJldGljYWwgb3JkZXINCj4NCj4gdjEgLi4gdjI6
DQo+IC0gUmVtb3ZlIFJTQiBzdXBwb3J0Lg0KPiAtIERyb3AgLmlkID0gMA0KPiAtIEFkZCBk
dC1iaW5kaW5nIGZvciB0aGUgQVhQMTUzMA0KPg0KPiBBWFAxNTA2MDoNCj4gdjIgLi4gdjM6
DQo+IC0gUmViYXNlIHRvIEFYUDMxM2Egc2VyaWVzIHYxMCBbMV0gKyBuZXdlc3QgKDIwMjMw
NDIwKSAtbmV4dCBicmFuY2gNCj4gLSBEaXNhYmxlcyBEQy1EQyBmcmVxdWVuY3kgc2V0dGlu
Zw0KPiAtIEFkZCBheHBfcmVndWxhdG9yX29ubHlfY2VsbHMgcmF0aGVyIHRoYW4gZGlyZWN0
bHkgdXNpbmcgYXhwODA2X2NlbGxzDQo+ICAgIGZvciBjYXNlcyB0aGF0IElSUSBsaW5lIGlz
bid0IGNvbm5lY3RlZC4NCj4gLSBGaXggc29tZSB3aGl0ZXNwYWNlDQo+IC0gUmVuYW1lIHN3
b3V0IHRvIHN3IHRvIGtlZXAgdXAgd2l0aCBiaW5kaW5ncw0KPiAtIEFkZCBjaGVjayBmb3Ig
c2V0dGluZyBEQy1EQyBmcmVxdWVuY3kNCj4NCj4gdjEgLi4gdjI6DQo+IC0gTW92ZSBjcHVz
bGRvIGJlZm9yZSBkcml2ZXZidXMgKEtyenlzenRvZiBLb3psb3dza2kpDQo+DQo+DQo+IE1h
cnRpbiBCb3RrYSAoMik6DQo+ICAgIG1mZDogYXhwMjB4OiBBZGQgc3VwcG9ydCBmb3IgQVhQ
MzEzYSBQTUlDDQo+ICAgIHJlZ3VsYXRvcjogYXhwMjB4OiBBZGQgc3VwcG9ydCBmb3IgQVhQ
MzEzYSB2YXJpYW50DQo+DQo+IFNoZW5neXUgUXUgKDEpOg0KPiAgICByZWd1bGF0b3I6IGF4
cDIweDogQWRkIEFYUDE1MDYwIHN1cHBvcnQNCj4NCj4gICBkcml2ZXJzL21mZC9heHAyMHgt
aTJjLmMgICAgICAgICAgICAgfCAgIDIgKw0KPiAgIGRyaXZlcnMvbWZkL2F4cDIweC5jICAg
ICAgICAgICAgICAgICB8ICA3OCArKysrKystDQo+ICAgZHJpdmVycy9yZWd1bGF0b3IvYXhw
MjB4LXJlZ3VsYXRvci5jIHwgMjkwICsrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAg
IGluY2x1ZGUvbGludXgvbWZkL2F4cDIweC5oICAgICAgICAgICB8ICAzMiArKysNCj4gICA0
IGZpbGVzIGNoYW5nZWQsIDM5MyBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPg0K

--------------CceeTACUHKmCf29ZruQrwmB9
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------CceeTACUHKmCf29ZruQrwmB9--

--------------YWDpRHQ5iGoPy5Rwuh6Hh1Yw--

--------------JHJfrvz3qXsOmrazwX1M8xtb
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmRt1QAACgkQX75KBAfJ
sRm0RA/8Dg+4ghGAVdMwO7G4TGz1bGKkADkeUrOPzdbVYXgUBSU6UG90Cpu6cPM5
bAaNh1zyXp1IExi+2oihT79fPNe/V3KCUVcB5eLuzArOpSxFhTfR+oEgU/HttH/i
nAl6CYPBeAMFKuF2PMCFhC746yOF7LoU7WYNGlwmxjpdJwzkQY3rPPwso3qyIYMv
OSnLh9k90KG/EJ8Ac56GRKoFjJR1sZ9mh66XJBXY/ppWnHq1xnmh1shV+6zTz9y2
CNlw/tEVKL7+0czIQNkCJnklJrx59yNNxebX6eROARtBgF7+IqKvIi+i976S1TMC
glNtlb5sYLI/IAKv6bMrTtRNt8UbSP316DPID7YuM6XDoOZ4ZWXUMYJdPDxfowbj
ANOT6478RuLXYjEPlkJGcVoBEBvqRRvMUMia+CcKG7xeTTnXfHth8I3fpdztbbRD
O2Hw8vj/5u/5pFJzDvgITfKz1Imxavtoqymy5gyNsTuS9avCrw9W3ir9/nV3aqHC
9At2hmyZDWRuL4bozUB6l25iv/Nj8A0ljXppe7lE8USOquT/fIzdpf7BJG3eIifb
DCeaMZWAilQaFnrM5mln/bawWa9RMMciwbgRiIMpsFMZ1JqO84zMKqs+j7g73vN9
FtXEIdMroVS6GLWZaYvVXpuT6yCdjTh741QxZPqklNG4eOx1wsI=
=yImd
-----END PGP SIGNATURE-----

--------------JHJfrvz3qXsOmrazwX1M8xtb--
