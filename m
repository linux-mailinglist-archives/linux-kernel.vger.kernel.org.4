Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D81F6779E3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 12:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjAWLNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 06:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjAWLN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 06:13:29 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2047.outbound.protection.outlook.com [40.107.12.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0994BA256;
        Mon, 23 Jan 2023 03:13:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+1vHm9dvuoxA1+NbYGcIHlA0PlhIvb9WYhrUIAneBoKc5hUZk1u8R1205DV5R4bTpBZR2U2BvHMRnJqvf1sJX0ENUo1HT8UUTT0l0LA/iBJu1Oih8WBHPK0L8IvF2t7NPhnXRuo6Jadia4LQcOr3aVv3H9yzr5Zy99K6WKyH5Gm8Qq2yUbYRC1bxLXi9s/wB7SD2FIDbfjMMCC00zovhm5Z/t1M5oDWDoAsRHJ9ebjB990AOixVXkIdE65WSl8mM4tP49apEb1mFUzy7SJE22EAdWu/UMcjEDp4r7WXRlQQNQrIXbmBVZI4BbK63VECwRdXUz1Lj+xlGdMzpTwY/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTvQHkPlscFYUAVVNU9f/wPuWV1ls5gNy8hz6vUUXqE=;
 b=MAGFoW+ZI1mZL45vTwBIZFN7l6yhwgoDzUdi9gj2OZObHg98N2x1Nkl4pCl6W5JGp1lO8Lob/8E598KFTVOyopO4VsmH5rehkJHW/fWC2Q2s6DyZqZzlBaKjZ3m3TPZjF0ZDACo4URfGyR6h/MKYv0wlELn+vVzSlWPJ+TpXzi6QG/TzmAng+WmzYOAKeFTYeyr7UCyBxcNjjTPXWbL96VkJ4Bq0LIWmrv2flFxroVmj95ZmnGFIXFsNNsCZaPrxYyOUwylYVZCWLcIgvStv/Gb1W/CfGqapDaikJVAysSr7ge9m2oDLM6laDG4rpeaOW3P1nr/rsu2NiruwqRx6iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTvQHkPlscFYUAVVNU9f/wPuWV1ls5gNy8hz6vUUXqE=;
 b=qkSUloJMAvsCtcxOBNkV9tYID1AYFbWl0n4RV90vsQayHEzRwaRNed/mo71gViG8QD7GCkTtMHpnTej9jpUmqwzDq+Cr7ZwhlNpWLegz56hX4Y7usEQyRNmKmCFg0Op//eJxVi1Hb2+W+iHh18sjiMEtUDpAamMkxSlKFXyAakO/Itgee2ZosIvPHKLSix6xwlSijKl9Iyi69dh0yLSLESsw9KxNlDxcRb0NTWbTlp+5gppm8bJEi3P4IapClIsBulTXzt7J11fL14/I46ikdZ8g3Rw+Lg4PTA2it6BCPKUG8qF81uXzf1dvJc1sAb+TpC22ZoVGhgKDUwn1e+L9XQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB1912.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.33; Mon, 23 Jan 2023 11:13:24 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097%4]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 11:13:23 +0000
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
Thread-Index: AQHZLLSvyotuf1YmL0q52bZzrUxZsa6rpj6AgAARhICAACY+gA==
Date:   Mon, 23 Jan 2023 11:13:23 +0000
Message-ID: <eb20dc66-f564-ed7e-8873-65621e5970de@csgroup.eu>
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
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB1912:EE_
x-ms-office365-filtering-correlation-id: 0741e9cc-69d0-4908-a41d-08dafd32d7e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sxRFfWRTG6w2sZAOiUd7xyS/ElCg3lD4Q5q6mmcIXvUaDyxq4f0Qq+Cwx4b8mTLpZezOrrDoJLUDWfezpLj6a+UcnNoCENd+34+B9CYKE2ROIZK1j9MW3S4rY9aSCtxUQJTj6K3czmvxnNgprXHajkvaUsR0Ic83pZomw0bdHdje1wueP3WmMkevgUWdP5Dc7hxb0XRYyMv6oMWa/vwFU/Eiz6/4hKm5OhCumcyuuLfNb5EKXBq5fLYQWzfMGIn2lGy3aDT0DQrFGO5lhS6rKW5plq/N0djsZCwwR36CSwxKsm34KOV8IE192qSHKNOHOn1fKm8XcW31bkVg0X5kDnvHLXv7TAATUpJnHUStKLrwfcpodLIKnG1cW7yvUCXAFb8vfzi2FoPJqKzOZzPkMak/q96M/Dg0r3T6O6vvBiU8bI/8yBLDl0VXIT4qmrnjbNNm8Z1mYcMNtvlpCJxrntSeTQyAjZeYhzLmA51XxMXcu3qGdKYynhqEHQAin6jAr0yw0+4P9AWCnuiQKgS056mMevAAbC6mr9CPrwMNxFREb4+FndTn831UaV9ZAlrT58bmjxHunI6mGIGPuwCYfhsxrT2nXtKaR/nsLdyvwsQrzqtvejHGccMCcYj1Vku6reht93QatAiPHu1U3N5/K9iMXh3j3GFnL3gwWHqOlzt+fBm3A8Rr6cM6YOm09BkGVNRGukXr5XdFXddMOjJZx4wbHn02M47fMdYkEdkHBstnV6pPnPRKCE5Jf6FLKHpUZb+RHXKmQwMDAjXn8iMcSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39850400004)(366004)(376002)(346002)(396003)(451199015)(2906002)(86362001)(36756003)(38070700005)(31696002)(54906003)(316002)(66574015)(8676002)(83380400001)(6506007)(6486002)(478600001)(71200400001)(2616005)(26005)(186003)(6512007)(38100700002)(7416002)(8936002)(5660300002)(44832011)(6916009)(122000001)(64756008)(66446008)(4326008)(66476007)(66556008)(91956017)(76116006)(66946007)(41300700001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3FiRktzQ1JLVnFzak1qT0d0WG9PSUF5bmNjaGIvb2lxdXdUaTFGamI0TStT?=
 =?utf-8?B?OEd4M1l5R2RVMmsyQ0tueFJrZVVJUDRGdDZ1YkFNUWpXUTBsZTJJSS9ab1lT?=
 =?utf-8?B?Z2hHK3NuQ28xaFVOMmkrUEtMTzhkY3hybGVqakYrcGgyZW4wSEdjT2JHVHV1?=
 =?utf-8?B?dFNWakVPeDYxNlF1SmgzK3pSa2xPVGdmL0doQnJEcHZ5bGpEamVyL09oLzRH?=
 =?utf-8?B?cGpDa2g3VitHZjRVRW9rUS9GMEZZUkljR3pDc25rWHdKSTJmVExUOXBVdDRn?=
 =?utf-8?B?TDNtUDZyL1ZZd29QdWFVVTFEalRxR0piREJzZEs0QWxtbU1NaVFRbVlkeE9J?=
 =?utf-8?B?bHZCZ1JlTklJb2JTd1IwV0dIeWdTVTQwd01tSFRQWDdBbm1qVUR1dkFiNFV5?=
 =?utf-8?B?Uitna0VCYXAvOThVNUNEUGF0SEpPVTZ4bmtiUFBvUG9oMkFzWkVkSmg2R0VK?=
 =?utf-8?B?djkrcGQyYWplNU01d1VHWWVuL3o4cS96V241YW5HcUxJSnROcUtjSktBbnlh?=
 =?utf-8?B?bE1LVmhvL1BnSVc2UzJzck03ekdZSHp1c2l0Y2hISzBobnlpUTNuOW9wbVg5?=
 =?utf-8?B?V3BSUSt1L0RoZFpzRUJEQnJIZlprdWczK2NlcmErdDBpOE1vQ0RRSllSZnM2?=
 =?utf-8?B?cHRJSmlXaTUyWHVDLzNCK2JUV09oREczMVhIUTk0VXpRTTZqTVVVdEdzTnZX?=
 =?utf-8?B?aWxWVFUzV1hZN1Z4RmtDNU5RQzFPOTZiOHcyTTZuVG1KL2RBSmVjaStrM2pK?=
 =?utf-8?B?Tmxvc0ZHbkhyS2w2K2F0NDRIWmJrWTBNQkptTWgzaTF5RGhXZUorVUI2K3h1?=
 =?utf-8?B?Ni82ajNrOWYzeldEZ0ZyM0RlUC9lQkFvZ21iMUNCelZVOEc4MVlUZmphaDl6?=
 =?utf-8?B?OUkvdmNySFFyd216UU9aTjVxL2h2RHdiWVE5dDRPbWZsQ2w4TndIOHJ2NUtE?=
 =?utf-8?B?eWtWR3ZPMk8yeW5VUjNYbFREMnB4ckhZaUtKSFQrUEtyUmQrVlRtVTN4SUxX?=
 =?utf-8?B?V0xzZzY3WjdVWVVlb3p6YkRnb1MwaEZIejZwTUF3TWFGcllrUFpRbmxSQXJM?=
 =?utf-8?B?Um5nVm9LdnlPa2FIMmJKeHlSOElrRjAyVy9FSUVSVks0MloyV1huTzh1NHV0?=
 =?utf-8?B?Vm82TzJvSmFOak5qdlFSN1FUbzVPTlJITk50S2RTMmtJTTNQTTQzc0syNkpT?=
 =?utf-8?B?N00wTFFVV3d5SHBZMm9obGwrdXJRZThBZ2pkZWpLazR5amtvKy9lNUxaQkNC?=
 =?utf-8?B?a1g1c0laSk5neWdWaDBQSzBYQnVlS2llODdKZ1pLWHJaV2FnVDl1TlVOU3Ny?=
 =?utf-8?B?R0ZidmhvQnJiNWVSb3dlQ1ZhTzY1MGt1UVBlWklFbEdoZTJ5dmFYYkRMcXFH?=
 =?utf-8?B?VEkzcjJscHpqcnVCWXBBUEdveU53b1hQUVM5MTFHUVVkcVkxMnY2RllZaFZo?=
 =?utf-8?B?ZXQ3N2puTGNwMUNyZDUvTktkMWUzVVJlbG9XUFgwTEdWZGMvSFZ6L0Z1RUhX?=
 =?utf-8?B?SnFoY05PRENzekNJR1VjU0YxZTlvY0VPZFdFV0pIRUFUWExCQ2ZqNkVpK2tC?=
 =?utf-8?B?UGp5Yks5N1Bjc3piTlpaeXNCWTZrak5sQTY4ZGdPREowVDA1Y043cFpUbjd6?=
 =?utf-8?B?bm83RGFpVEdLSEVkNnFIaVZDTVMwQ0xWY3VHT0srdEpuVzNXMVZ2RGNueUpo?=
 =?utf-8?B?c3RTd1liWjYxM3BnTk05MW1NQzZxNE1uYXo2RDNaaTR3NVFhb3dhYW5kejdB?=
 =?utf-8?B?Q2I3N3IwanFBdXJxY0ovMTZubXhVc2VLcVdmNG5XQjhFY0FZUEdmTWFGdmQ4?=
 =?utf-8?B?bHpHTkxLazNKeG9xVkNzNVE3ZCtLNG9UQWM0Tko2cUMvVHZETGx2SUEyUFd4?=
 =?utf-8?B?ZXQrOS83dldiRzZxK0ZweEFZVXRFQ3NRSy9HQU5MWXp6NVdyZFB1ZThkbjZ4?=
 =?utf-8?B?RkR3a3BwOWI0aWZBNVd6RGU2VmJBZm5acEtiKzdIVWdkby9SdXRBL21DcUhn?=
 =?utf-8?B?UnV3R1M3cFZFVHNYV1dpTFZ5Wkhrb0VSejlwR0M0dDZZZU9aamtQTFB6dWta?=
 =?utf-8?B?VE0waTB1RUorQVk2dlNwVUI5eDZhUU1NckFNRnlRUEY4SHJJdU5NUmt4Z1dj?=
 =?utf-8?B?VTZpUDQ0N2JiRlNRRHUwMmxXVTZBODRta0xBYUZ5ME90YWQrRHZNRmozemFw?=
 =?utf-8?B?aWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <458652CF244D974AA673FBF80233863F@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0741e9cc-69d0-4908-a41d-08dafd32d7e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 11:13:23.8483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gyFkywzHUeq0pn5ylpfZQKnHYuqnI2oEZSdnMQ6HJVA62ygj2kZRPu8aE8KsNixVA7ZSZaBh8g4Cb/7SI6mrzOqfRq5JtpF78Y4cjgqLfNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB1912
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSGVydsOpLA0KDQpMZSAyMy8wMS8yMDIzIMOgIDA5OjU2LCBIZXJ2ZSBDb2RpbmEgYSDDqWNy
aXTCoDoNCj4gDQo+IGdwaW9jaGlwX2dldF9kYXRhKCkgaXMgZGVmaW5lZCBvbmx5IHdoZW4gQ09O
RklHX0dQSU9MSUIgaXMgc2V0Lg0KPiBUaGF0J3Mgd2h5IHRoZSAjaWYgc2VjdGlvbiBpcyB1c2Vk
Lg0KDQpncGlvY2hpcF9nZXRfZGF0YSgpIGlzIHN0aWxsIGRlY2xhcmVkIHdoZW4gQ09ORklHX0dQ
SU9MSUIgaXMgbm90IHNldCwgc28gDQppdCBpcyBub3QgYSBwcm9ibGVtLCB0aGUgY2FsbCB0byBp
dCB3aWxsIGJlIGVsaW1pbmF0ZWQgYXQgYnVpbGR0aW1lLg0KDQpCeSB0aGUgd2F5LCBhdCB0aGUg
dGltZSBiZWluZyBJIGdldCB0aGUgZm9sbG93aW5nIHdhcm5pbmdzOg0KDQogICBDQyAgICAgIHNv
dW5kL3NvYy9jb2RlY3MvaWR0ODIxMDM0Lm8NCnNvdW5kL3NvYy9jb2RlY3MvaWR0ODIxMDM0LmM6
MzEwOjEyOiB3YXJuaW5nOiAnaWR0ODIxMDM0X3JlYWRfc2xpY19yYXcnIA0KZGVmaW5lZCBidXQg
bm90IHVzZWQgWy1XdW51c2VkLWZ1bmN0aW9uXQ0KICAgMzEwIHwgc3RhdGljIGludCBpZHQ4MjEw
MzRfcmVhZF9zbGljX3JhdyhzdHJ1Y3QgaWR0ODIxMDM0ICppZHQ4MjEwMzQsIA0KdTggY2gsIHU4
ICpzbGljX3JhdykNCiAgICAgICB8ICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4N
CnNvdW5kL3NvYy9jb2RlY3MvaWR0ODIxMDM0LmM6MzA1OjExOiB3YXJuaW5nOiANCidpZHQ4MjEw
MzRfZ2V0X3dyaXR0ZW5fc2xpY19yYXcnIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1m
dW5jdGlvbl0NCiAgIDMwNSB8IHN0YXRpYyB1OCBpZHQ4MjEwMzRfZ2V0X3dyaXR0ZW5fc2xpY19y
YXcoc3RydWN0IGlkdDgyMTAzNCANCippZHQ4MjEwMzQsIHU4IGNoKQ0KICAgICAgIHwgICAgICAg
ICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0Kc291bmQvc29jL2NvZGVjcy9pZHQ4
MjEwMzQuYzoyNzY6MTI6IHdhcm5pbmc6ICdpZHQ4MjEwMzRfd3JpdGVfc2xpY19yYXcnIA0KZGVm
aW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWZ1bmN0aW9uXQ0KICAgMjc2IHwgc3RhdGljIGlu
dCBpZHQ4MjEwMzRfd3JpdGVfc2xpY19yYXcoc3RydWN0IGlkdDgyMTAzNCANCippZHQ4MjEwMzQs
IHU4IGNoLCB1OCBzbGljX3JhdykNCiAgICAgICB8ICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+DQpzb3VuZC9zb2MvY29kZWNzL2lkdDgyMTAzNC5jOjI3MToxMTogd2FybmluZzog
J2lkdDgyMTAzNF9nZXRfc2xpY19jb25mJyANCmRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNl
ZC1mdW5jdGlvbl0NCiAgIDI3MSB8IHN0YXRpYyB1OCBpZHQ4MjEwMzRfZ2V0X3NsaWNfY29uZihz
dHJ1Y3QgaWR0ODIxMDM0ICppZHQ4MjEwMzQsIA0KdTggY2gpDQogICAgICAgfCAgICAgICAgICAg
Xn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCnNvdW5kL3NvYy9jb2RlY3MvaWR0ODIxMDM0LmM6MjUw
OjEyOiB3YXJuaW5nOiAnaWR0ODIxMDM0X3NldF9zbGljX2NvbmYnIA0KZGVmaW5lZCBidXQgbm90
IHVzZWQgWy1XdW51c2VkLWZ1bmN0aW9uXQ0KICAgMjUwIHwgc3RhdGljIGludCBpZHQ4MjEwMzRf
c2V0X3NsaWNfY29uZihzdHJ1Y3QgaWR0ODIxMDM0ICppZHQ4MjEwMzQsIA0KdTggY2gsIHU4IHNs
aWNfZGlyKQ0KICAgICAgIHwgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KDQoN
CldpdGggdGhlIGZvbGxvd2luZyBjaGFuZ2VzIEkgaGF2ZSBubyB3YXJuaW5nIGFuZCBhbiBvYmpk
dW1wIC14IG9uIA0KaWR0ODIxMDM0Lm8gc2hvd3Mgbm8gcmVmZXJlbmNlIHRvIGdwaW9jaGlwX2dl
dF9kYXRhKCkNCg0KZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9jb2RlY3MvaWR0ODIxMDM0LmMgYi9z
b3VuZC9zb2MvY29kZWNzL2lkdDgyMTAzNC5jDQppbmRleCA1ZWI5M2ZlYzYwNDIuLjhiNzUzODhl
MjJjZSAxMDA2NDQNCi0tLSBhL3NvdW5kL3NvYy9jb2RlY3MvaWR0ODIxMDM0LmMNCisrKyBiL3Nv
dW5kL3NvYy9jb2RlY3MvaWR0ODIxMDM0LmMNCkBAIC05NjgsNyArOTY4LDYgQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBzbmRfc29jX2NvbXBvbmVudF9kcml2ZXIgDQppZHQ4MjEwMzRfY29tcG9uZW50
X2RyaXZlciA9IHsNCiAgCS5lbmRpYW5uZXNzCQk9IDEsDQogIH07DQoNCi0jaWYgSVNfRU5BQkxF
RChDT05GSUdfR1BJT0xJQikNCiAgI2RlZmluZSBJRFQ4MjEwMzRfR1BJT19PRkZTRVRfVE9fU0xJ
Q19DSEFOTkVMKF9vZmZzZXQpICgoKF9vZmZzZXQpIC8gDQo1KSAlIDQpDQogICNkZWZpbmUgSURU
ODIxMDM0X0dQSU9fT0ZGU0VUX1RPX1NMSUNfTUFTSyhfb2Zmc2V0KSAgICBCSVQoKF9vZmZzZXQp
ICUgNSkNCg0KQEAgLTExMzMsMTIgKzExMzIsNiBAQCBzdGF0aWMgaW50IGlkdDgyMTAzNF9ncGlv
X2luaXQoc3RydWN0IGlkdDgyMTAzNCANCippZHQ4MjEwMzQpDQogIAlyZXR1cm4gZGV2bV9ncGlv
Y2hpcF9hZGRfZGF0YSgmaWR0ODIxMDM0LT5zcGktPmRldiwgDQomaWR0ODIxMDM0LT5ncGlvX2No
aXAsDQogIAkJCQkgICAgICBpZHQ4MjEwMzQpOw0KICB9DQotI2Vsc2UgLyogSVNfRU5BQkxFRChD
T05GSUdfR1BJT0xJQikgKi8NCi1zdGF0aWMgaW50IGlkdDgyMTAzNF9ncGlvX2luaXQoc3RydWN0
IGlkdDgyMTAzNCAqaWR0ODIxMDM0KQ0KLXsNCi0JcmV0dXJuIDA7DQotfQ0KLSNlbmRpZg0KDQog
IHN0YXRpYyBpbnQgaWR0ODIxMDM0X3NwaV9wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0K
ICB7DQpAQCAtMTE2NSw2ICsxMTU4LDkgQEAgc3RhdGljIGludCBpZHQ4MjEwMzRfc3BpX3Byb2Jl
KHN0cnVjdCBzcGlfZGV2aWNlICpzcGkpDQogIAlpZiAocmV0KQ0KICAJCXJldHVybiByZXQ7DQoN
CisJaWYgKCFJU19FTkFCTEVEKENPTkZJR19HUElPTElCKSkNCisJCXJldHVybiAwOw0KKw0KICAJ
cmV0ID0gaWR0ODIxMDM0X2dwaW9faW5pdChpZHQ4MjEwMzQpOw0KICAJaWYgKHJldCkNCiAgCQly
ZXR1cm4gcmV0Ow0KDQoNCkNocmlzdG9waGUNCg==
