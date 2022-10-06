Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4EB5F68C4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiJFOFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiJFOFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:05:13 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120051.outbound.protection.outlook.com [40.107.12.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1F160525;
        Thu,  6 Oct 2022 07:05:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ob5BX/vO+7/iTORFZreiHwvth2X05VESqO73nmh3pjjNBiU4FhZRkfheMAwrm5Uz38RniFEx34Hpn4vX5A50zRDOS34RSa9cR35WK6wX1TgqGvJD9rbboyVhp83ZsfvPBdMvDjvLtztEL8EvqyMoluvZcGTe5Jwd3XPLr1T7igOQ6mkrtjZEKG9fi6ZEYXzcl1i6XijqBCCrgmFAhxo6Z5+pCBqUres0XuCf9MFEMpNzCxNMRCymmC6HQ71y/M7+jcd62swiFk8o5kv0Toc7HMZiDE/iDDy/xO/iJJwVA1THO44sJDezehRPetWMVoXNPyeyyz57eckLLSWWXptGLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrRk4Mvwqdv3uQUewgTzfS5sBMFf62fBANYJU0Zg5pc=;
 b=HsVM0uQS+e6R5tsDUV1NWPTnlO2DqEt3vnJut2lXP6F1d0WY1hrCyLvtw4iMGVVZA/mF6cqi2qK5Dsb6gq9RDrCrDH8zHND+ft4WbBx4jyh7QlVl+A4KpDY3scZSkltNMBsZn0qsgVatkhmKbdKBz2YMQOhkBVJKzA5OoEwyVDmkcg7qjKKrXBkKn+PuKmccxnjSa6hbOa3WERBn05GwwM/np2jeu9KL54ZJpAhL4Fpyh8fzjYsXxCsB0WrP+O8wllTkYOl4CrGlrC7Ntduvmy8tJCjYwOL3k7Z/Qy9/7P8daBK9utXL6CllPmUxMpI6G/Me8OPZHCF4vM1lJqsS/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrRk4Mvwqdv3uQUewgTzfS5sBMFf62fBANYJU0Zg5pc=;
 b=V9OWrxDRX6m6XGlSjLH+LC4eKFKu67zJlq/2ZgESInmQhuWa2CtLs2Aqc2HuHc/89H5gpALzAgJsRB6L36p2GcFwfq/lp7457w50Y2oXlk2As5QApX0QT1HMFTSUw+ToBdAfFU8d2QHxyqvbbyvB8/idbDyvVCitq7qkdHnGbjhF+y4tv/hsu/Ab8wie3pGUy0qgrNpOmxeEDbv6M5+XQ9AR1oGp9Cd7AyYdKBqSfemWw5BzpNjheJwiWkssfmX2ZmEKW6AkdDcLBmL9eA5rXQlDjuirgmHO4AdZlK3lz7vAO7+MmvQZ04gxfMREGs8If16fazmd+dw3DEZtcZKCKQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB1434.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:164::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Thu, 6 Oct
 2022 14:05:08 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c854:380d:c901:45af]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c854:380d:c901:45af%5]) with mapi id 15.20.5676.036; Thu, 6 Oct 2022
 14:05:08 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: Replace NO_IRQ by 0
Thread-Topic: [PATCH] usb: Replace NO_IRQ by 0
Thread-Index: AQHY2UK+PJcRly8Gk0ii4TX51MgeQa4BYqiAgAAEGYA=
Date:   Thu, 6 Oct 2022 14:05:08 +0000
Message-ID: <46d1ca5e-8a68-40fb-db3f-acf69e688c4f@csgroup.eu>
References: <63f6d2e7ea17f6522f36abd6cf5e6a7f25f215c6.1665033267.git.christophe.leroy@csgroup.eu>
 <Yz7dI5iTaguhn73K@rowland.harvard.edu>
In-Reply-To: <Yz7dI5iTaguhn73K@rowland.harvard.edu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB1434:EE_
x-ms-office365-filtering-correlation-id: bbbb8702-4718-425c-621e-08daa7a3c6d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AeW4c5n57wMyEImxRz8PpUJBwQYjO8sBxd6ezMl7e3klGPehcLBxGf+1zzntd90+on0V8qZHmH05Ka3GiwX5utJgzYGTFqFnaVS0Upfh4LsHDwjxvI4ejLQ7y5GWe18hLrJrgVZEZ6kr1qyeu6rP1BUiP5ZJ2Hqb29sK9/1pR0uUcvkb3z01Ckgc6Vnu0fG7rBmbGuNmdfw/cpvnNqzApGu3JSx/xg7cm7z9qWvVhxLd0QSbFkmlIOwV2RGnsInnNdya5dlDbBQ39T/USB03mHRorc0R959dJBGwZ5HejkuE1hAt5S8aHNMq1feAzd8Jc+4BruVJnSFAIwg9+U8lqkovEbTwfC2YAKxusct6p3Bmu794sy9mmQT2tSebYcW9yiNMEim7aBhNrp7Q4so8o7Wk1aPhWJJtJV1NKqJZE6kImRsi/ZxgdkamfLOQ3RD0hS8WFjA1bSqDG1RzWPWuGtmA4G8/6BT787dVYHQpRZYBHMQMft0yCGPpRMKr9J4u9i/ZMLEseoUtu4gWk8gPR1O+MSTtAyZi0xSwtXS4OIy4S7RsUb3kfSV0UvTokNF0fZ/MEuFspaI304OCtj1iEsC8+daOZfe8JME1e+azQxQ007UBnoHkPNlmjDkhg+tsIcGtraEpg8noGXMzOdW/cC4S+Nk7MjdBPoSKWV255rOaogi7dePuDbnt5AixcFlFkqcotTXLO0My1EdDf1K+TJxG4oJ1n3mw7mM2PNyuzJQv/9gN6L1YKn3vZML+qs1NOTVUsAIdYzXEqb28JfLHdYOOMqf3xHL0lRTegr1+m9Z0HH4V1YDjA6yN4F8oJJIH9EjcUhizLhWTs828f+QHpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199015)(44832011)(2906002)(2616005)(186003)(6506007)(41300700001)(8936002)(26005)(5660300002)(6512007)(122000001)(38100700002)(38070700005)(31696002)(36756003)(4744005)(86362001)(6916009)(54906003)(316002)(6486002)(31686004)(76116006)(66446008)(8676002)(66946007)(4326008)(66556008)(66476007)(64756008)(91956017)(71200400001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHlCVkZGbzA0OWF2Tk4zWTliaFZnN1c0QlBQYjFIWjIzZ0xNcStHMVljM0lP?=
 =?utf-8?B?TXorNGdxMVhnQXl2WkJHSkdmNTgycytEVmZWeWpTQ2JsZmlkZ2cyaWFxYkpm?=
 =?utf-8?B?ejU3WHFnWm9TelhwdWZwMk1TQU83ZU5Md0FIUFNBTTVOVG9TWFMxM016TkE2?=
 =?utf-8?B?M1Uzb1Qya0FOVnBUSEpHWXlKNzU5WU5vMlY4NmdZUUlRWkpKWkVrTEZ5dy93?=
 =?utf-8?B?OHBwdHg0RWZtMFZMMlRkaWY2RU1XcHRrM2Fua0svN3o2MVljUUp2NWJkQ2tR?=
 =?utf-8?B?U1dkRG91QnQ1SFV0ditGSWZ1N3c5R25WUG9tT0ppWjZGUW9TWjFzU0hTdzJL?=
 =?utf-8?B?Mi9WTGdGMURINEpsNmJOdmRSbnpEa0FNdm4va1dwMUgvcUZ0MEVPMk1GR29O?=
 =?utf-8?B?MC9aK1dzMWpGM25zcEQrNFVMK2syY2luYUtZTG9welpUTTdiOHIrYTBJb2VR?=
 =?utf-8?B?Nkk4STNsK3pveDZRRDR6eU5vK2g3ZWErQ1UvUzliSitkZFFSVGY0bnNqY1J6?=
 =?utf-8?B?UFRPekxkT09mQUQxN3hZMmI0U3lnMnZzVVBTWjJQZnRwZXFHa2loQnVRUE1j?=
 =?utf-8?B?UVQ0byt4SkUvdUZTZmFSNDFiUjREbXFmOFhTSmg5dStOZWlwcG9DWGJCaHBM?=
 =?utf-8?B?MWNtZnpsdUQzc2Y2VG83YWdKRC9JNVl3cEdOTFFuT0hwRXQ0Q2xNWXdBQXJl?=
 =?utf-8?B?aU9ZKytMcDUyV2IrTm9RU1lwZWhRSFk2TktieWdFTy8ySko3ZWt3WTAzMW9T?=
 =?utf-8?B?ek5xZ290dC8vNWJiY0JSSE5FS1YvWVhUQmJCNEpPa0wxaHE0YXlFazM1SE82?=
 =?utf-8?B?WW9RRStkNVRMK003ZGZTTHJkL3JtSUxiRE1BVXpyUmdvNEorSjZwa213bXcy?=
 =?utf-8?B?Z2VaTlhoZitVRTQ0cXdWY1R5RXVEbm9iUTlZRVJCeHpIMUh0bVRKSTdoR2N3?=
 =?utf-8?B?R2lmc2dQbU4zbmxOaFhhc0tFd0pGUUkrV3FvN3Y4QTlvK2QzWjRPbDVGTURn?=
 =?utf-8?B?TWlNMDZkSFZQN0JWZ2wwWElseFlLTGhybGRKU0trbnVGMFNEUFM3RlZyQ3NZ?=
 =?utf-8?B?SnBObXhjUUswaUVydDZVTEs4UFd1N1dESmMrK3JrMkVXM1BTWjRyUi9HRFJY?=
 =?utf-8?B?eUNhQlNNUmNteEVVS041VkdiVWs0WXFLOFZDODdpYUJaMlRPTkZUR2l5U1Bx?=
 =?utf-8?B?SWJEWGw0M0VxS1B6TWgxWUJKaWd5MzF6L2pVT00zbDNIZFFDYUJDQVhqYUdN?=
 =?utf-8?B?M1Y1VitRSm9YUVhBY1dpSmRkSCtjNzJrQkoveHlYLzRmVkVrMDdBL2lsNVJn?=
 =?utf-8?B?c1BFbXdvRDhFOThNOERuY052TTJBQ0J4U2VQdUJCK082NlBtZTJ1cTIzTUpS?=
 =?utf-8?B?Y0U1R21rWWJUNEtCM1NVM1RVZFpnaHpOdmtLODNCRU5yOW1VUjlHV0ZmSHQ1?=
 =?utf-8?B?eE5zQkovYU50UDVVVkRsV3ZLUENSWUxLS3pVU1RmQ1p5WDcxcTlMc1pibWhw?=
 =?utf-8?B?ZE5rVFFEUFpQajJwOGp3a250RDdQWlJFejNxdC9CN3hDR1FQdmVEcnJtMWh5?=
 =?utf-8?B?NkhEOHhFcGVVbTlkSUFlVE0wNExaZzdKYzU3T0ZkeTh3b3kzbXMyUEtQSStV?=
 =?utf-8?B?VklRejVNcG1GQ0x6NkdHMVY2RjlTRFZmM1ZRTUhyOXFsV1JzL0NRemtmUWdV?=
 =?utf-8?B?RUtRQmdUQXNrMHBZU0k1NFR1L2JCQVV5eUFhbnpJSVZNeVlycG9oQnU4cnFU?=
 =?utf-8?B?ZHVjb0xJVit0T1BWeUdSRzFRQWhsVloxaFd0RWg3eEd3em9pOU41WWdmQkJP?=
 =?utf-8?B?TngreXE2RUViY3dxMTQ3anlOWGhNRm43OHJqZDczVnA2dDB5MHBmNjZWLzZL?=
 =?utf-8?B?aFJzREN3N0h1WWZTL1lDQUFoZ3Vla3VLL1FaTXFmTXFEeXRjNlAwZng1QndU?=
 =?utf-8?B?NkwvUjdKVXBEejdheGJwL2pQakdEVVkzZ05hUXI0VUVQZWFia2o2RW5OWUdV?=
 =?utf-8?B?OWQ5NE9maE9Eci96UWttLzIySmVWOGFRNnhCSVdmWU4xNFcxZksxK0V3QmRx?=
 =?utf-8?B?d0ZvT1ZKTkp3Vi81Ukdid3h6WHFsRmpIbDR1dTJ5UTcyb1NXN2tJS3Y5YmYw?=
 =?utf-8?B?OU1Zd0trUFFlTUI2S05SR0xnOTQ2V1MwUjFoWngxeGdkUHRBWXN1SkFFL1Jr?=
 =?utf-8?Q?tzKuXuGFraM9opN16wkZ44w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C07552F55583C047A78535D23F33EA92@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbb8702-4718-425c-621e-08daa7a3c6d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 14:05:08.3833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RW9Hro0VASNK/8BYGTxV2a/5h87lLWMvnMk/axuBN6BcOTYyqHVBQf8qFiWByQjysZO5j8HnVW7TmjuGHQb4fAtOOEIX7v1qe4Lgt5b6Xpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB1434
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDA2LzEwLzIwMjIgw6AgMTU6NTAsIEFsYW4gU3Rlcm4gYSDDqWNyaXTCoDoNCj4gT24g
VGh1LCBPY3QgMDYsIDIwMjIgYXQgMDc6MTU6NDRBTSArMDIwMCwgQ2hyaXN0b3BoZSBMZXJveSB3
cm90ZToNCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L2VoY2ktZ3JsaWIuYyBiL2Ry
aXZlcnMvdXNiL2hvc3QvZWhjaS1ncmxpYi5jDQo+PiBpbmRleCBhMmMzYjRlYzhhOGIuLjA3MTdm
MmNjZjQ5ZCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvdXNiL2hvc3QvZWhjaS1ncmxpYi5jDQo+
PiArKysgYi9kcml2ZXJzL3VzYi9ob3N0L2VoY2ktZ3JsaWIuYw0KPj4gQEAgLTk5LDcgKzk5LDcg
QEAgc3RhdGljIGludCBlaGNpX2hjZF9ncmxpYl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpvcCkNCj4+ICAgCWhjZC0+cnNyY19sZW4gPSByZXNvdXJjZV9zaXplKCZyZXMpOw0KPj4gICAN
Cj4+ICAgCWlycSA9IGlycV9vZl9wYXJzZV9hbmRfbWFwKGRuLCAwKTsNCj4+IC0JaWYgKGlycSA9
PSBOT19JUlEpIHsNCj4+ICsJaWYgKCFpcnEpIHsNCj4+ICAgCQlkZXZfZXJyKCZvcC0+ZGV2LCAi
JXM6IGlycV9vZl9wYXJzZV9hbmRfbWFwIGZhaWxlZFxuIiwNCj4+ICAgCQkJX19GSUxFX18pOw0K
Pj4gICAJCXJ2ID0gLUVCVVNZOw0KPiANCj4gU2luY2UgTk9fSVJRIGlzIHNvbWV0aW1lcyBzZXQg
dG8gLTEsIHNob3VsZG4ndCB0aGlzIHRlc3QgKGFuZCBhbGwgdGhlDQo+IG90aGVyIG9uZXMgeW91
IGNoYW5nZWQpIHJlYWxseSBiZSBkb2luZzoNCj4gDQo+IAlpZiAoIWlycSB8fCBpcnEgPT0gTk9f
SVJRKSB7IC4uLg0KPiANCg0KTm8sIGJlY2F1c2UgaXJxX29mX3BhcnNlX2FuZF9tYXAoKSB3aWxs
IG5ldmVyIHJldHVybiAtMSBhcyBhbiBlcnJvci4gSXQgDQp3aWxsIGFsd2F5cyBiZSAwLg0KDQpU
aGUgYmVsb3cgY2FsbCBnaXZlcyBubyByZXN1bHQuDQoNCglnaXQgZ3JlcCAtdyBOT19JUlEgZHJp
dmVycy9vZi8gaW5jbHVkZS8=
