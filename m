Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA846D333D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 20:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjDASp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 14:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDASp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 14:45:27 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2054.outbound.protection.outlook.com [40.107.9.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6980676AD
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 11:45:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXZqUjz97ZoTPwbarS0pnDDYRffA0doVJXuKS5Uoiegv4H4n67GZ0WLQ8USUs0L6zeeYrpj5bhqsNkJECybOnF4UNbnNjr/NPfYO0kp192yI5VXBDEGt3LseXJaAhMI2HC4knzbL68768taa1ZfN+MbpW+Nz06GDhNiOy1jCwHUv0MTOUb3xMvn0NCHA0JZA65I3jvlKpMtYCZrgScJTLezHKCnzI4XOwW9oENA9q9QIz3mWCkl0ZEug5ZT8TKf5msGJvgQlnQ6r57pjLNHVTIArrVUazwQi+wggVlEXmRq9M5ONI3wu2V+jG18WCgrc8/0wwLUhTDm8q2dTmE4U0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMm125j/QdBCLhuesWyKI//tXODKFuwF61U6YY3jrWA=;
 b=WNGlwuLoi5yfaJy3MD0+CuxgCUcGaszkMEx+plODF0FnWVAu94gGeCFrAtOTjkVi8pwHxCCpE+D2tJFD6ETvCiX/+vt07ipuRXK9TriS5nUfErlBnMG1O1JM7Ul/vKf9qOMMYntOZaYrkyelNGOD1jPsC08OkzFBJrFQfraWq4Qh6br6l2bGp4b3v7pnBQ0OwAo1QO1z4rUYzXqU8BKiHrm9OusS3NIQhgNftoSJRgUkMUCunUkz22ImvGwFM+aL6r2WN5FFFkLPFRM/1oh/EZt7dIFh9xRNySFkUpjpu4bOsCKniEUk+GRz7g7yoh80Y3f0BptgNHLXqXMQR4MfaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMm125j/QdBCLhuesWyKI//tXODKFuwF61U6YY3jrWA=;
 b=jsmm9ZsxA3BHH7aBldqncN1VZTDnfvr3pFnkkJ8kmb7G3H8srKqwHWd2h+ez6BMB4b23p4Wbcj5e17gxkm4YtnzlRZXtI+F8DUMOiUgt1fPd+cYEIZ0T3PxfI3Uj5FUomDnkgdck4MENTsCdfaKNFlA1NI4mCAm/UcCUiK6TUa4xifz8XfP7EnELnce2pOB/J4ompRMxQHA5a2y6Vrra62KIfuANz/zvAv6J4DqWpj17P1xpgRCSUHvTVKA7gochWyizUERkVxaRDxeFf29Haf0pJRjIRIFd6VK9SlMgfLoJisyavzn1Au9A29fx9i3QQUeoWvsp9kVubdoR6nnr4Q==
Received: from MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3d::7) by
 MRZP264MB3194.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.28; Sat, 1 Apr 2023 18:45:20 +0000
Received: from MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c102:f008:98e:6be9]) by MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c102:f008:98e:6be9%7]) with mapi id 15.20.6254.028; Sat, 1 Apr 2023
 18:45:20 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Vlastimil Babka' <vbabka@suse.cz>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH] mm: remove all the slab allocators
Thread-Topic: [PATCH] mm: remove all the slab allocators
Thread-Index: AQHZZH7yOrUwuuDv9Uu+InBUAFt6z68Wx+kAgAADT4A=
Date:   Sat, 1 Apr 2023 18:45:20 +0000
Message-ID: <a84e8534-ef49-c33f-711c-fa5b9ee88269@csgroup.eu>
References: <20230401094658.11146-1-vbabka@suse.cz>
 <eea7e17ab4264b7ca7ccea0ab725120f@AcuMS.aculab.com>
In-Reply-To: <eea7e17ab4264b7ca7ccea0ab725120f@AcuMS.aculab.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MR1P264MB2980:EE_|MRZP264MB3194:EE_
x-ms-office365-filtering-correlation-id: 32492603-7216-41c6-b60a-08db32e13eb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BfTp5BUAxc76gtmZaYvVB1fpQDryJg7pDBovyi6ouTB82WQnyqE/5m+cMFq0rOVbgq7EeFU1HpzOV89fDU1cGmUrlTi+vC6rkrl6S0CGGjzi1zay0P579wwopPBWTvea+JZiSKY36gqrXXT5S4AX9nKDUYEeX0EKDHWhYRZ5v6AC8qSBX5fjRKxq4oCU08ZGUGt0sfUwYa53S++E0Hh6FUWZK+lY/schhWTtsfLLiforVInRO6oLY4X5PQVR0QXw+bkBXElALdln2O9UsBBQ4Oc+ePgONRH8z1Fem44/vXQPSTn3wJBe5vMmdZjC/sIRxiQ+dp8W9/L1F1oFR+Y7vwG4nTnr8H6BLD/ICJYBhnrYOuB+Cuat3oiizXVpjWZW0VCd7DKt6LH/BsV41vj1pTZGEdC81D7Fzk77Op4flMrNOvlCyMoLhMLSsfAjEXmCV6wnSa0V95H91rf//LoSfDn+fBIIJyL/eOR3waCij1H4uAvbAGuosm+WWImdrWiXRReQ8wYS0TUnO2HkG8KJvEaizo9ZBUx31UnjCw3y4L7QRl/X15yogFhFbeLc9Bax0laDNjEIgFSSTsoqJZRwo9ZoqFrHFWEIpCtLslDC2n6p0LaKEngNYIrf3jEHHvaBm2eg3QVG7L/kJnzOtOinaJunO0fwp8PXCunyRFZBxgM8ZC59PAXHdotYdUHyIAc2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39840400004)(346002)(376002)(366004)(136003)(451199021)(91956017)(4326008)(8676002)(76116006)(66556008)(66476007)(66446008)(64756008)(66946007)(478600001)(110136005)(316002)(54906003)(8936002)(4744005)(5660300002)(41300700001)(122000001)(38100700002)(186003)(2616005)(71200400001)(6486002)(44832011)(6512007)(6506007)(26005)(31696002)(86362001)(36756003)(2906002)(38070700005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?am5BSlpvMTIwbWtDaG1QYlFtNHFMejY4NWFTcG9sMXpTc0FkUUtDaityYm1m?=
 =?utf-8?B?ZlphRkRZT3VTRm5lNGpCZndPTklBWTFoR3g4bHpQZDRDL0szcFdmdy83dHpE?=
 =?utf-8?B?OEVoZUhmTk9ESnVVTzZqeFEvLzZ3SDVFMEQzWk9YVzJCZzM5dXpsQ3QvNFJX?=
 =?utf-8?B?aFlWM3A4L0VxZkw2VFAvd2lySVBvbHp4VXdaa1dxNDROWVpPSEU0SGN5ZnZL?=
 =?utf-8?B?WHJ1OUl6c3VuNnV3MFhzT1BnVnM5WlhmbUh2dHB0RDUvU0FwakdMZlRLbE0y?=
 =?utf-8?B?RzEwOHRKdk4zYmJqYVBRU2hFbFF3bTQwTk1YR09hOTdKdi9leXFNb1JzQnUv?=
 =?utf-8?B?MGI0c1J0QmhpRWdLdDErSUZhRUY5d2V2czhvNWNVNzhxZmtuS2dLMFFSdGRE?=
 =?utf-8?B?ZGhWZDNIZmlmUWI2bDJ5YzhrQmVwMHhYeTd0YVRWdTBGRjR0S25FbGhQaFV0?=
 =?utf-8?B?OTQvSDRLZXM5dVpRdlpHbzcvMzg4MDhHUk1IOHFJRUxBR0gzd1AxUzVobUhy?=
 =?utf-8?B?U3FLSGVGTG56bmJlYWJsc3NrcU5yMGp4ZXRsRksydFRmK2gra051M2JGT0c3?=
 =?utf-8?B?TzM3cWFqZEJ5ZGVBR1JGRGZRK2N4REFBMDg4ZjRMWnRQVk53OFQzRWdvV3JQ?=
 =?utf-8?B?RXNSM0FPNXk4Wmh4UDViNEc1OUx2N0dYVVo4UjNVVWdReTBuVGhVUjhWS3ow?=
 =?utf-8?B?TG1wYUZPenU4SjJtOEFoSERrU0RlUUNUb20vOWNaU3krQVpLMDlMRW9ITkVl?=
 =?utf-8?B?QU1Xamx0aVBIemtBcWgwVnBpaXNEKzlyc3JFd2ljVXlrV3FmVVlTUXk1Y01a?=
 =?utf-8?B?d2JWYVYzMExDeWgvM2FBZGJBR0xhNitDblNtcE4wa2NzVndCVEsxTys4clhT?=
 =?utf-8?B?aXBMNHZpU291SGlMbExzMDNpTkFKSVE3NVdpb0h0MWdFbFNOVERZakRKa1Z6?=
 =?utf-8?B?QjRibVZ5T05GT3grN0J4aE5zWWMvNXkxVnlrbEVxRGl1b1JaTldZKzV1a3Rq?=
 =?utf-8?B?b0RzVXY5ZXFaMkRncnBEY2picVVraGg2YUs0VEMrVlhvVTZENVh1cE80ai83?=
 =?utf-8?B?ZEpSSHNPUGtvN1VkQ0Fka1Q1blJTWGpnZXJVTS84dWdVY0Jzb1dsaDRCSmRK?=
 =?utf-8?B?T3h5SVozcVFzdktudFBueDVhZmRweFhaNGt3QWtSWG9zVjNnRU44ZjNEeDEy?=
 =?utf-8?B?aHZOVVlyQUtyK2hBcDF4aExYcWwrQ2VpNWhmOEdmS0hNY1pLZVRtY0JKd2lM?=
 =?utf-8?B?WVRaWTNwdWd2S1VKeUVLOGFLTUZ6OXpmaE5DMGRSK09Td2MyYUVnaW9Ea0ta?=
 =?utf-8?B?cyszQldiY0I3QmZBTDBxUkNSK3I0U3ltaEFGc0s1emRQVEF4NTdRU2VhZitk?=
 =?utf-8?B?MS9GYXY0NVdsQjNlSysyRmZaZlNxdVF4UHhkdmU0YlNJM2JQaWV0UDJiM3hs?=
 =?utf-8?B?ZVRhZWk0UlpGNVRBUi9EOVVqaHJyYVVjYTJSZ0hXam9FWmJzamZScDUzb084?=
 =?utf-8?B?TDdTc2FNeHFFcVdzWTdDM3ZIQmJHUUtuSEIzQmhySEd2SkFKZGpzeHpESEJC?=
 =?utf-8?B?MFFwYWMzU2d5MFV1WGh3QSsyKzhCRGh0MUFxVWFha2x0SW00SW42SjIweHIz?=
 =?utf-8?B?ZStvenozUWtSS0lPTUxBaHpidnFmOGR4WDVwdlVYclRCNmRvZmNEUmJ6akJw?=
 =?utf-8?B?dXFXZWpCT09LWkVndm12OE4wVzJLT1Q2cThoK016L29TSy84Q0tBR0dRNEFy?=
 =?utf-8?B?Wkh1U2ROck1DS1NOOUtta3hmTVdhd3pzamRtUkF6M0tGaEwxS3YwdTN6QW1p?=
 =?utf-8?B?N0hkVnZMQWZmMlNsRkI1NWczTHJvZzN6NGNOUVNKeDlVQjViK3hobVVWZFl4?=
 =?utf-8?B?SGRUUzFFWjEwa1ZDa1dPTmV6QlNKNUFBZ2pyczNJNStEMTlpeVdrQ3ZBcTBI?=
 =?utf-8?B?Y0JJbFpNTGFKUnd2QW9rZE1kcHFsSjlKN2taMnE4QTUwRE51amFJRVczR29q?=
 =?utf-8?B?SDhlZThmZ3NsQ1hpSlR2R01WNzcxOHNsVzNkUjgzcjlqM1JLdGgwYmNjZDhi?=
 =?utf-8?B?UmM3SFFMbXZncytVZHNDSDl0WUxwai9uaVU4bVhFQmRpMmtPTzhGbWJlUGNL?=
 =?utf-8?Q?Q524lgHCq8BfvZqdAg3hJOkGe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <095EF28137E6A94FB3AF65B9CB2CD71B@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 32492603-7216-41c6-b60a-08db32e13eb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2023 18:45:20.3293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +9n/0O+pUcy3/3AL9c5MacIDrtrCUIURHoIoeUMxFo9ITENb+mNkHkyFPWFgOYTXNSQMRIMXWJkKBJ69JVdtuatlhAMSQMw+QDbpI7KbImc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB3194
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDAxLzA0LzIwMjMgw6AgMjA6MzMsIERhdmlkIExhaWdodCBhIMOpY3JpdMKgOg0KPiBG
cm9tOiBWbGFzdGltaWwgQmFia2ENCj4+IFNlbnQ6IDMyIE1hcmNoIDIwMjMgMTA6NDcNCj4+DQo+
PiBBcyB0aGUgU0xPQiByZW1vdmFsIGlzIG9uIHRyYWNrIGFuZCB0aGUgU0xBQiByZW1vdmFsIGlz
IHBsYW5uZWQsIEkgaGF2ZQ0KPj4gcmVhbGl6ZWQgLSB3aHkgc2hvdWxkIHdlIHN0b3AgdGhlcmUg
YW5kIG5vdCByZW1vdmUgYWxzbyBTTFVCPyBXaGF0J3MgYQ0KPj4gc2xhYiBhbGxvY2F0b3IgZ29v
ZCBmb3IgaW4gMjAyMz8gVGhlIFJBTSBzaXplcyBhcmUgZ2V0dGluZyBsYXJnZXIgYW5kDQo+PiB0
aGUgbW9kdWxlcyBjaGVhcGVyIFsxXS4gVGhlIG9iamVjdCBjb25zdHJ1Y3RvciB0cmljayB3YXMg
cGVyaGFwcw0KPj4gaW50ZXJlc3RpbmcgaW4gMTk5NCwgYnV0IG5vdCB3aXRoIGNvbnRlbXBvcmFy
eSBDUFVzLiBTbyBhbGwgdGhlIHNsYWINCj4+IGFsbG9jYXRvciBkb2VzIHRvZGF5IGlzIGp1c3Qg
YWRkaW5nIGFuIHVubmVjZXNzYXJ5IGxheWVyIG9mIGNvbXBsZXhpdHkNCj4+IG92ZXIgdGhlIHBh
Z2UgYWxsb2NhdG9yLg0KPiANCj4gV2h5IHN0b3AgdGhlcmU/DQo+IFJlbW92ZSBrbWFsbG9jKCkg
Y29tcGxldGVseS4NCj4gV2l0aCBjaGVhcCBtZW1vcnkgaXNuJ3QgdW5yZWFzb25hYmxlIHRvIGdv
IGJhY2sgdG8gY29tcGlsZS10aW1lDQo+IHNldHRhYmxlIGZpeGVkIHNpemUgYXJyYXlzIGZvciBh
bGwgaXRlbXMuDQo+IFNob3VsZCBtYWtlICd1c2UgYWZ0ZXIgZnJlZScgbXVjaCBlYXNpZXIgdG8g
dHJhY2sgZG93bi4NCj4gDQoNCldoaWxlIGF0IGl0LCB3aHkgbm90IGFsc28gaW5jcmVhc2UgdGhl
IHBhZ2Ugc2l6ZSB0byBodWdlcGFnZSBzaXplLCB0aGF0IA0Kd291bGQgYWxsb3cgdXMgdG8gcmVt
b3ZlIGFsbCB0aGUgY29tcGxleCBUSFAgbG9naWMsIGFuZCB3b3VsZCByZW1vdmUgb25lIA0KbGV2
ZWwgb2YgcGFnZSB0YWJsZXMuIEkgd291bGQgYWxzbyByZWR1Y2UgVExCIHByZXNzdXJlLg0KDQpD
aHJpc3RvcGhlDQo=
