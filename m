Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AEC661F13
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 08:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbjAIHS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 02:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjAIHSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 02:18:33 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2057.outbound.protection.outlook.com [40.107.9.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1E6FE9;
        Sun,  8 Jan 2023 23:18:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTGmWp9LjeiUgvzBdq3KeF6/ZzPLx53WON5KOiFnLrECjjOZ6IlPftdj4bxzJhzn+ua/SaLDMrpCaUCXaigSphvNQbf8HubNnHh2+W5BFhHbBIPqYvqi++y5JtSGgCynkFbg/Xz8kppmtTRqPxHba4zcnfIPoQR6b8fiWcZZ0SDS1R96AyukuX6LcASItINtNvVCUEsLz29LgSHj+4enHokw0XPnXDqMgn5PKiZyqTLpUOYx5HeFw3sEv/Hp+MkWqwNuV7P68FfBG8HEQ+Lf8bsyqE3jYkEntUkw+IfI1pR3wRfUXxLtSpQk1SZdJ59LAGNMiRJqdFX10NqYhjK8FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4eQyuJD1XRZEX34CKvrqwDT+q0h2/Hv42LHuy6SgLs=;
 b=ML+BbJka1ggtylZfJG4MC5j+1O50l0EVrF6Y5Q1hpgXKhuGmw0OSNgL9cz+n9iFNZxWYCFd8ref9uJkusnQPhEnDvIsfd4gWLf1UX377paUuDdpArv/POOhFvPCgy5mwmALo8a5Abw/WQgxpHfIxmjCPGVr9eQgF14puFzF0fEUSBopSbIZnepUaOtSf1viqax7T6u4PZqTPH8oMGKWMkkyttrcWn5/J9jU71pl0+waFyL3dCDeBIaZLiXYmRcQRMxS+2LFS0i3EMMvutJTX4U1+7G1qxhgb595WZpx1f17GoTCiCdaboiiZIwVerHBObcAEH15S1+1BZdHajHwpuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4eQyuJD1XRZEX34CKvrqwDT+q0h2/Hv42LHuy6SgLs=;
 b=bCHImqQ2uujClwwX2lR9uyqZxoi7B95hIMgig70awTRJygvOPT67dz0jkM7nxKZPPljLH5Nnp/hbqhDIFQInJPIKFhA4GTgrhR1xToa4JFJlUTSF7Gfv0aZ6SQ3wAkQr2R2MgQNxCvUlbdmwhnnZXLvwAYypjYTh+RyLbbR2EdJrFh3P+p4meU29a1d9KPAryBJ8eWDN6WnG70jB/4wfpNj9GANBT2F1urKlQrsKMLBKrV50Outc1n3MOvsfAoC2LR7BdR/7RaPVBuZp5VxYHO0ZTVu9jvHmb5pErgmv/lXB0hOgcLhoN2Y5/29EUPV16csjKT4f5Q3LndJx0B/Qsw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB2905.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 07:18:27 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097%7]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 07:18:27 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Christoph Hellwig <hch@infradead.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH] crypto: talitos - Remove GFP_DMA and add DMA alignment
 padding
Thread-Topic: [PATCH] crypto: talitos - Remove GFP_DMA and add DMA alignment
 padding
Thread-Index: AQHZHCDQXSm6u3UJi0SyhqtRNChANa6VvOCA
Date:   Mon, 9 Jan 2023 07:18:27 +0000
Message-ID: <07259416-84bb-c264-dd8a-5bb3706b8c49@csgroup.eu>
References: <Y4nDL50nToBbi4DS@gondor.apana.org.au>
 <Y4xpGNNsfbucyUlt@infradead.org> <Y47BgCuZsYLX61A9@gondor.apana.org.au>
 <Y47g7qO8dsRdxCgf@infradead.org> <Y47+gxbdKR03EYCj@gondor.apana.org.au>
 <Y61WrVAjjtAMAvSh@gondor.apana.org.au> <Y651YoR58cCg3adj@gondor.apana.org.au>
 <Y66T1UCBTqBE6GQ4@gondor.apana.org.au>
In-Reply-To: <Y66T1UCBTqBE6GQ4@gondor.apana.org.au>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB2905:EE_
x-ms-office365-filtering-correlation-id: 98201821-51c4-46f3-ec42-08daf211b41e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nDz6aKIDzle0+G1S9Pc2ptR+Nsu44+6CMNe5GQ/VH1Q36pRoDK+yI9Aqsdc/iuqn9X85+EB+C/m3/OwSaOoExttnDSri3C6hgYRdPDO4TSHFq3oHxndW9Z7h1A9cWsVbp93XL2Dj6bJMEVjMSxOxWm7nq6/9jkQ3F5N/GiQGD3Q2GQmKKcUGoT+Xlaib/VkuYM3pj/UmWHe8Sy+ff83Mhs1ANijslAXk2arfkcs/IRdSzXgRDjBIvVNv7qEAleskpWW2O6Z5V21N3QDCzsvpFro/zZ3dUcjXdrYms7Xz9ng7/SjdW87aUAfw5MvuDScx6wBtR1hHJC91qc5sDdyT1hxvTiLlBV755Jd32aMJbpWu0upNaqbDCnyv2l64EiMRDRSvJ+CzCJpackqBA9n2uROQ0CeLpI3oZtLRq7KgBaXW1AFMlLWAsABcK9DBoAarnEpHJJq1GeNq7grPYjLJ6s9i0GIClyi4ORzsRt5shwbUt9oAZv8QkB5NDysK17iyRkKoe0aYmmIIe25oRk6zu30itI02dIGZ0T+NMc7zBnUpHoSxwdXNHc/JgwEUgILGBbbKwS+K3CfNJaKnc3F4zZT0WWiILALO49GTWo58ebouCccJAxc7r3I4ZcQZAURMVccLPjLTpRjI8xn/f4m1NF6os2PVkEszA/UBW0WzdTnuNoYu7H0McNe1TIaG01E1RUDW0TCS/oSH3V0Z4onh5GpmAh8Q9M0AtbOkXhxOJr9BgdoNjYpwo4eg4MaIYmZ0aqk3RCoKWkI8TbIRUp9XAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(346002)(39850400004)(376002)(451199015)(31686004)(2906002)(8936002)(7416002)(44832011)(5660300002)(36756003)(41300700001)(91956017)(8676002)(66446008)(66946007)(66476007)(76116006)(64756008)(66556008)(316002)(71200400001)(110136005)(54906003)(4326008)(6486002)(478600001)(26005)(6506007)(6512007)(186003)(2616005)(31696002)(86362001)(38070700005)(122000001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFFJY0JnRmdsa2xaL1A0RUxWQmFtUnRUelFVa2xRRXVMRzM0cjI0QnhhMTFv?=
 =?utf-8?B?Q1RITW5KdEZTWmpyVTBudUNCVFV0THpJZWtCRk5zcVZucWNDbjVIN1J6bFRQ?=
 =?utf-8?B?UkFpWDZkcS9zUkJtRXNJVGNsT25WUTF5TkUwZHlTdERyc2dZKzlNeGJFYXln?=
 =?utf-8?B?MGFVbFpZSDhvMUVBbGw3alFSZWhoTEs5d2JnRzR0VnlwK1BiNzd4WkRyaWpv?=
 =?utf-8?B?blkxQkhXNHNMWXgxbWhnYXVPS2JNRE9ZMkVPOVVqY1lrc2pWS08vY0VoMnp1?=
 =?utf-8?B?bTJ0NDVLc1NMRXVPWjNobTl4RnVheHRPRU16NTlmM3E0cWwzem4rWWNTYk4v?=
 =?utf-8?B?Q3lqcStrSUdCRkVKdDg3a00xS0R2UG9OZVFrbGpUV3Vvdi9xeHIyemxRdzF0?=
 =?utf-8?B?azJHdHY5VGN1U1c4K1FSOWc5QzJWUWJ0bHVGcXNSODhIcGMvT2xESlBxaVFL?=
 =?utf-8?B?WDlQRkZ5R3hxMXpqNVdmUDVza09oWDdpbE92Ly9rQmxBUE9ZL1lNT1JWdlFo?=
 =?utf-8?B?eG42eHhmL2dJOEZoNkFHVHNpcmh2aTB4aXdyd2hwTlJNcjhvTzFqUVFHZWNM?=
 =?utf-8?B?VkMvL1I4MUF2OWh2UFZVNmxLWHA2QmwxckkzZ2IzNi9HclUxMEIzRTZ5cXl5?=
 =?utf-8?B?Y2txZFhKRXNWdU5tOUlNNUMvOWpkWlFJcVJQQjFOOFZiRDVsTzUzNFlOWCty?=
 =?utf-8?B?eVVrSFVQa3ZrNi9Hajc3Kyt2dkpKN3A2aUlmMW55bnE2a2JReUUrVkpOZTJQ?=
 =?utf-8?B?SmdwK0lnQzYzQlNOcHhBRStLeUw5SnBSdlhCWHZHSnRiMEt1RG1kQ1BCMU5S?=
 =?utf-8?B?YklUWW5qZ3FFSnRRWTc1UVROeTN6STl5T081Smw2ZkdyOEZIMFRFY3Q0Q0Jl?=
 =?utf-8?B?c1pWUTR1N21OUFBPeTVicjFiT2UyZVZTdVEyZ04wN1lueVMrU05ZT0VJRXI5?=
 =?utf-8?B?a1FQeEFGYVUzdjk0cjZrdWpsbnBQM2NqLzNJSnNnQm9NNDdkWk1TVnRTenJw?=
 =?utf-8?B?NWR3NEx3Qzc4M0srbGVGVENyYUtMVU1tNDlLZzBudDhEb1NNcmw3OUFpSGFM?=
 =?utf-8?B?SHZ3QUhmT2huKzVob0tIQURtcDNPYUZaRXNoN1pJV25IaGo3aVFGb3RMcldX?=
 =?utf-8?B?aGd4MmNJVDV0VVUwWnFJVDhSQTkra0RrNFlUYTlNVllBcis3VkF0dVhlb0R3?=
 =?utf-8?B?OXU5VVVSR0pVd0Vya3pYWGgzNk82L2dSL1dFZDAwZXVxdzQrUUd1QitrRHJL?=
 =?utf-8?B?YVZvVHM4TnJPbFpuQ0hCN1FONjBwS2s4RjIwYnY0WWxjWmNWTTlQZnAyTXhW?=
 =?utf-8?B?ZThLWDdCU2orcjZPSGxWQkRPQ21CZ2dPOXZjQk9uQ2krNGsvUC91c3c3YUdj?=
 =?utf-8?B?U2FGU1NtNFBML0k5ZTgwdy9ab2VNTEpNaWx5dHNBamgwYVd2bHRjaWhIeGdj?=
 =?utf-8?B?WTFvVlJiei9RdnUzaEJYTm5xWXl2MFF2VHIwaGFidnBWV2J3VWZLSzQ3ZU1I?=
 =?utf-8?B?QVk4K1FENFNlTENsQmhsK0Nta1BZRkNtVlFmcWxTeDB6NFpJTm43NHIySVlO?=
 =?utf-8?B?aTcrN1ZYWUhSQy9IWjlUbWcvNTdyQzVmcUhHS2w2RFhIM3o5Rnp2a283Qzla?=
 =?utf-8?B?SVVIem1PQ1RGbnc4bmtOSTh3dmdQRi9nY1RLTjlwYWo1bXRFZ1BjQ0lQcjRx?=
 =?utf-8?B?NVRnMEdhVWZmaXpwOFdIbC9BM2VuSVJ0b2ttRlo1cVRKNkFXUnBidEZkd3RP?=
 =?utf-8?B?bFpGRjdIVkxCcDZYMzZsa05qWFl2NHpkU1cva1Z0aTFnQS9uaERVOUhpTWt1?=
 =?utf-8?B?Q0cyRGtPT1VIa3JBeWZFZWh5NHBBOW13UktrRld1R0tPOTNxSzI4M21aNFBY?=
 =?utf-8?B?OUVsMUpHeUgzSE1SSDNPa1JkOC9odkVBNTd3UTZXVDhXR05JRnhJOFA0a3hs?=
 =?utf-8?B?SXlkbysxbG5uYXE3STkyR2RqdVEvSmpWd0F2ZlBDbG5jaXNaTGhnOVE4dkRj?=
 =?utf-8?B?VTBna2FsaG02L1lRN2loZk52UnBRaklERGFWRGtSUUFReWhnSUhvUmUrREF5?=
 =?utf-8?B?c2w4L1hNM2FhMXJmYWRFcmdocUc2T2xCYSs3SC9od0ZoanR0UXZDTXU4Qlkz?=
 =?utf-8?B?bi93ZkJaNjBldU5KaldGby9iblJtYURmdnEySVRDRkcrcFdRV1RTOXVmZFNH?=
 =?utf-8?B?K1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1B6DB6796FE8E409FBF74830D5E158A@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 98201821-51c4-46f3-ec42-08daf211b41e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 07:18:27.6012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k0zBM/R5CuSTABT4D39wWeeOZt3YtGC4OphygCbSQ03e7NBGasx8Otj3h3kmN016RJeaL/9v2XdCgpY+KH9do+ECjc+DmTWG/86kjCc8cgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2905
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDMwLzEyLzIwMjIgw6AgMDg6MzEsIEhlcmJlcnQgWHUgYSDDqWNyaXTCoDoNCj4gR0ZQ
X0RNQSBkb2VzIG5vdCBndWFyYW50ZWUgdGhhdCB0aGUgcmV0dXJuZWQgbWVtb3J5IGlzIGFsaWdu
ZWQNCj4gZm9yIERNQS4gIEl0IHNob3VsZCBiZSByZW1vdmVkIHdoZXJlIGl0IGlzIHN1cGVyZmx1
b3VzLg0KDQpEb2Vzbid0IEdGUF9ETUEgZ3VhcmFudGVlcyB0aGF0IHRoZSBwcm92aWRlZCBtZW1v
cnkgaXMgYWRkcmVzc2FibGUgZm9yIA0KRE1BID8gT3IgZG8gd2UgYXNzdW1lIHRoYXQgYWxsIG1l
bW9yeSByZXR1cm5lZCBieSBrbWFsbG9jIGNhbiBiZSB1c2VkIA0KZm9yIERNQSA/DQoNCj4gDQo+
IEhvd2V2ZXIsIGttYWxsb2MgbWF5IHN0YXJ0IHJldHVybmluZyBETUEtdW5hbGlnbmVkIG1lbW9y
eSBpbiBmdXR1cmUNCj4gc28gZml4IHRoaXMgYnkgYWRkaW5nIHRoZSBhbGlnbm1lbnQgYnkgaGFu
ZC4NCg0Ka21hbGxvYygpIGFscmVhZHkgcmV0dXJucyBub3QgRE1BIGFsaWduZWQgbWVtb3J5LCB3
aHkgZG9lcyBpdCBiZWNvbWVzIGEgDQpwcm9ibGVtIG5vdyA/DQpPaywgdGhhdCBtYXkgYmUgc3Vi
b3B0aW1hbCwgYnV0IGlzIHRoYXQgYSBwcm9ibGVtIGF0IGFsbCA/DQoNCkJ5IHRoZSB3YXksIEkn
bSBub3Qgc3VyZSBJIHVuZGVyc3RhbmQgdGhlIHNvbHV0aW9uLCB3aGF0J3MgdGhlIGFkZGVkIA0K
dmFsdWUgb2YgYWxpZ25pbmcgYWxsb2NhdGlvbiBsZW5ndGggdG8gdGhlIGNhY2hlIGFsaWdubWVu
dCA/DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhlcmJlcnQgWHUgPGhlcmJlcnRAZ29uZG9yLmFw
YW5hLm9yZy5hdT4NCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NyeXB0by90YWxpdG9zLmMg
Yi9kcml2ZXJzL2NyeXB0by90YWxpdG9zLmMNCj4gaW5kZXggNzFkYjY0NTBiNmFhLi5kNjJlYzY4
ZTMxODMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY3J5cHRvL3RhbGl0b3MuYw0KPiArKysgYi9k
cml2ZXJzL2NyeXB0by90YWxpdG9zLmMNCj4gQEAgLTEzOTMsNyArMTM5Myw3IEBAIHN0YXRpYyBz
dHJ1Y3QgdGFsaXRvc19lZGVzYyAqdGFsaXRvc19lZGVzY19hbGxvYyhzdHJ1Y3QgZGV2aWNlICpk
ZXYsDQo+ICAgCQlhbGxvY19sZW4gKz0gc2l6ZW9mKHN0cnVjdCB0YWxpdG9zX2Rlc2MpOw0KPiAg
IAlhbGxvY19sZW4gKz0gaXZzaXplOw0KPiAgIA0KPiAtCWVkZXNjID0ga21hbGxvYyhhbGxvY19s
ZW4sIEdGUF9ETUEgfCBmbGFncyk7DQo+ICsJZWRlc2MgPSBrbWFsbG9jKEFMSUdOKGFsbG9jX2xl
biwgZG1hX2dldF9jYWNoZV9hbGlnbm1lbnQoKSksIGZsYWdzKTsNCj4gICAJaWYgKCFlZGVzYykN
Cj4gICAJCXJldHVybiBFUlJfUFRSKC1FTk9NRU0pOw0KPiAgIAlpZiAoaXZzaXplKSB7DQo=
