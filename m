Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679605F626E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiJFISw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiJFISr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:18:47 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90073.outbound.protection.outlook.com [40.107.9.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D549082B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:18:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XM4ZuC/bUez6szw0HjFbZ86EVqiwlMzsaF+rzj4GegQYc0amcLmQ/NjgOijOA9kYqXNWUIUBE2PvoqW7diO952tCEGnEn2b2/G/bPP878KimvJ0heSrA1vjuacwRY3Qo70BtIzplwikP/EwKz/9deL8EIEIPZOg0Z04X0FzMQAA3zd/JWCzdB0ebIRsMbhIvQuxVtu71psFswUUf/2kKUf2UTtuEY1ukhvhT8e55V2qYFlVTF+0VCo2HChi55QWmJSJDjipw6Nq4ui+NAXKKHUL3tKHnCTqWnoIh1H9VSmaLL32qTcSPHg3iB/+HXz2wmuRGe3M/w4kAgc1qZ89LSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjJgZ5bGs5mTJ9jrYt4mLk4r7ZHGBHFvMp8GoYukdOI=;
 b=lrOyrsTMUAYGSAfsId/X3IXtkpbKB2dcrJ1BzWGHa0E7eX2i3glJle031E3qj6p27uzMsHXZHGFZc+thkLtIyP1VkTK+lBLjagijotZCYof1fKrB/wBVi3avkfp5DG05B2iAWLZ4/Qgv2MzPzc1merwYZMinynpAAqKuhi5BLMo103LllAgzbfFyqGtI7COIlhspM5zLVm2+xPtfSW894k8CR2fzGRXg7yMJdkhXbtL6UruPs+4Ji3e/TdaDHzJ2uyDf53NNeJmrNZbTwvRigbQtR7Cc6/4NEaIlQSP6Dxk1AC+VSlaoiWba5wR+Z1r+7cXyoi2F4MMYQrWhAdfk8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjJgZ5bGs5mTJ9jrYt4mLk4r7ZHGBHFvMp8GoYukdOI=;
 b=yNGUZ1dskbJfvuL6b0BWm7KAkilQ9KaV/ZI7H8YLayzI5WRpLxVONjUpnNUK57zIb4DA0QsfLlJ7tkbe3WqtXjSZctNpwabwwJ3r3ZEaAan0PZQyx5W2z4DwTJhbPgy98hD++EyMdi8qmoaYRKH9BMbaTXIQnF4axN1+7iCVwxb5Y2mKhLkXEbq249nl6uGaCfD3QsDQrmC1sljgRuRdiR7J4dAZNyKdE08AY+rj2q0/uLhJu82gtvethcWTigTJgzPrJD75s0cHEF9OU6ayrxeeHnXzL7+RrWViDnocdVYp7vCtjzQgY30ox8jwYv3ubbDpPRiC0VgNmt5B/HvqQg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB1962.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:168::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Thu, 6 Oct
 2022 08:18:42 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c854:380d:c901:45af]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c854:380d:c901:45af%5]) with mapi id 15.20.5676.036; Thu, 6 Oct 2022
 08:18:42 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH] mtd: rawnand: mpc5121: Replace NO_IRQ by 0
Thread-Topic: [PATCH] mtd: rawnand: mpc5121: Replace NO_IRQ by 0
Thread-Index: AQHY2USqNNFgEuSoTkSY6babunhwha4A/TuAgAAIt4A=
Date:   Thu, 6 Oct 2022 08:18:42 +0000
Message-ID: <1c62aa44-c282-0d8c-7f4d-530b5e6db3e8@csgroup.eu>
References: <4e3ca3e0077ea124ea210c312e6e620f0f9e8bca.1665034065.git.christophe.leroy@csgroup.eu>
 <20221006094729.61ff9b24@xps-13>
In-Reply-To: <20221006094729.61ff9b24@xps-13>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB1962:EE_
x-ms-office365-filtering-correlation-id: f1446adc-8984-4c6e-2f70-08daa7736178
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c6xfgUgHEbCz908a9MnwGQPrjIwKRYc+GzRO4ABU3gncj45QBimcMA5jQhbc0QNdXLUKdSqkJdxIjdVG4zNzfyu9IaNYiVbVSZ+E0s6aOSSux6fDzZrGJq+N4jke+jA+FC71jutScw3fsETo0igElS4q3jRQOeb2REimVjGNA8HUlhW+uikqsNqLiB1huS/G9HhmjQyCS0AZauOmWGZFd7qxw6Bl1x2KaPjDDvdiBhzjLovJHyim5YhoxYR8WrWzypksmMsB15TRZ1JD1Zk7diaWbSJxfs2LE1+4YypuM+2Z6AiV8/nL8WNZnBOiTAGQhFhlQEef0Pbz1E7Qv/7z05cFOhC8O5m1oz5JNu0EYmuOSCCna9gVOM0UUHp7i50j+64/OsjUkovbP8zp9Q7GySjn/2wegIFAQ3zzV5xlsGmL7d6WdcA6c2+D4O6ekETuwLjBU+sdEYSlw//fbOcrDwudlsiWMfMik22VV1e3R3whiyPS55aNDPN3uB+v1p869f6c0mgeZHS2n9xeDG1nidUwsxjaEYATiX30dWJUg/WFxulMJRlsQ9pW5+QTNcYkGY66hR9qxdEUUIFtWVwwusEByORtfO04Bjrx92kwuXfJ6Wn0FwTquU2xPn4dHIZJlIZW3AB/qoe0ZBEH6l9MBFwk6TJfuT+hPGFjzEOBjf/cDfdwMwuRs2HP6+URMF0rdhPXtQjXxpZJZhvvOYlWg7LmUPnlDOzv5aR7GWujYeUHvDtUFDWnuYTY1fHE5kTwpyChnBQpkpz0yjULFIlPtZfNxldUy8ZRwPrXJ7579mUXNblVkLpQ9i0dhz1nKnubiUgM4JkZbibfPsXvRFFaLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(39850400004)(346002)(396003)(451199015)(2616005)(186003)(66574015)(83380400001)(8676002)(76116006)(66446008)(5660300002)(44832011)(41300700001)(91956017)(4326008)(66946007)(64756008)(8936002)(36756003)(66556008)(2906002)(66476007)(6512007)(26005)(6506007)(31696002)(122000001)(71200400001)(54906003)(478600001)(86362001)(6486002)(6916009)(316002)(38100700002)(31686004)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0JuM0RVR0wvMHJid2NBeEQ5ZUU0M2ZFM1RGNHU0MVR6ZERjZDdlNFZBQTNq?=
 =?utf-8?B?Zjd2T3NLWGsrRHg0Qjdjd3ZtV2JJMjlwb1dRdUZhNVlnWkxJY3pwSCt2djN0?=
 =?utf-8?B?L3JrczVTQnpyNENad1NsRnB2eWNnTnc2ZVBwVy9NaUdPWmJLdWJlS2JBczhL?=
 =?utf-8?B?KzgvZ1FteWZSOXhFNkU1K1gza2VUSUZrKzRYT0JRelhHdEJvcVBuZ0ZyODVn?=
 =?utf-8?B?eGlsSU9qbDA1dVRjYzdWT3F0RmdBcElWcXF5UFhuaUpoYW5xMzl6aUM0Z0pE?=
 =?utf-8?B?MzdFOU1kUXBnVyszU3JGbjlBNEkvdUZHcXphSzNFcHhxTDMvMm5YOW80RWx4?=
 =?utf-8?B?ZEZjMEtSZElZOTV1YkNHaG9FTEZpT29wTWxpR09MWDBmMnN4VTluWHQrcjJ4?=
 =?utf-8?B?RjFFN2hGMkYvZlNkZGltWkMyUnZ0Z1pZWWZWOVhnS2M4NSszeWhxTm43dUtj?=
 =?utf-8?B?bUNmNnpXMk4ycTl1VnVvWmh5bDA1L2Zib0RRampqbW1MVXJPVmFHeWcya0Zo?=
 =?utf-8?B?QUFndytqWG5laWx3MDBBMzd5K2hNb1YwOXBsU29sVmpUREM5bithR0J4QmdJ?=
 =?utf-8?B?T0lpTVNXMTVZMmY5NFJyVDN2V3lLNm1Ia1VmZDlUeGszMWV0RjdLVXh1MmtV?=
 =?utf-8?B?M2Y1Tk0xU2duNHBiemhSYzJEa2owbjUvd3VwRXcvT1kwMmlqY0hzQ0FaZTI3?=
 =?utf-8?B?bGJ5Yy85SU5FOTRVa1hIalZGazRTK3BUNlgxSDB0N1VBb0JITmpLb1N0UTZj?=
 =?utf-8?B?VWxyS1pOS3ZYKytiMVh5T2VxTkc4bzMrVStLWDFOR3lBRzBHUFo2UTF1YWVk?=
 =?utf-8?B?Y2NRb2FqQmRiaUprdmNSVE5kUHA1YTd0eGdSRTlUNVk4dkxhalRvaG13Qnpm?=
 =?utf-8?B?QnpyUDRrdWpPcTZoZkE5WThDV21XMzRsVCswSExGenZJUG8zWkdXWDRBSDk5?=
 =?utf-8?B?dGgyRnZLbWdKTGFHM2p0RmFkUDBNWDBhZHhnRGFRSDlkcEVKbHVCS0tUcGpY?=
 =?utf-8?B?OE9vRDdBdm5sdmFXL2hUY2I0aVYreWFJVmRMb0lyNWh6SFdUVmpoR0VzM0Fa?=
 =?utf-8?B?UVBtcmd4cVBJNWFrUjhjNmNGdHIwYkw1ekN1Tm5zek9yaDVGNjF3cmxyZnBh?=
 =?utf-8?B?cGhtczBKVks4VC9yaHRPMjM2eWpveDd3MEdTRHFTdW14UlpsMW4vaCtZWVVR?=
 =?utf-8?B?R1hVeUJnZ0VXVGZIdWxONE96WVhIZTRkNTVKMVVvMXBsck1MR25mb1B4a0t4?=
 =?utf-8?B?MFVVUDUyczVzWldoeWtQVFZtS0tRQjhEYlloeU8xaGtLQmFWZUtEVisrNS9X?=
 =?utf-8?B?c2d3RUVIMG5lZDNrbHAvUCtxNkVLeEExOXNWMHQ4Rk8wNGlDY3c1dkl2QnFo?=
 =?utf-8?B?eHVHSjhBQi9GcERCYTZlYkFEZWJiMWZrL09OVS9rajRtajZBVzVGaFZleGxY?=
 =?utf-8?B?QktMUWNjcWttMXVXYUFUWW0zZHZKRjVyRTR2OHZQZVBveEtFOFlOekYvd3Bj?=
 =?utf-8?B?ZS9DRXFoVkVGM3NKeFBnN3paZnd5RDRYL3Q1T2R2NC9FUVNpeFgrdlJrbzhX?=
 =?utf-8?B?anVnM09rd0VyaVJRYkdMeW1lT1JBN2tBMFl2bWY5Mmk3SXVQTysreEV2Qksv?=
 =?utf-8?B?cUVVZWs1Y01aWWdUSHh2Nk9jSHZ2UXR5Q2NhemhtZU1sV3NDQ3crQWI1dnFG?=
 =?utf-8?B?eWZiNHRUSnNEVmFZK05SaE9ZcjBNTG9rSVpaUUVpWUYycjE4Q2VMNW9xMnVz?=
 =?utf-8?B?NEVuQzlVT3NIZVNXYTIzdjNTQjJ1ZWhoNFFXRkV2MVhyM1dZYzVsSWRYaWJG?=
 =?utf-8?B?TkYwNllZamdQS1Vlc1FsRHdIdzltcXNsOFdla25ST2RXUEI0bGFDbEoyeThu?=
 =?utf-8?B?V2ZUdGtaMkR3NDkxWUVFbGhBTzVvcG5ZdGJQdGRIblVBY2NGT2JrNmNWNllD?=
 =?utf-8?B?SEFsSjEvUCtCcTh2eVRhaW1kazRUZHhqL3haaTZDNmJCRUhPSmZhZ0pwRlM2?=
 =?utf-8?B?NENaQ2owWHlFZEh4bDdwRkx1UlNNNjJISGMvYU5NZDg2WVdYTnByMGw5SVY1?=
 =?utf-8?B?b2ZUR1Q1YnlMelhtMUVQdWhrVWdEblBkV3JKWktZNUZ6OUFCSEdYZmorTmw4?=
 =?utf-8?B?TjFueWVlSncvUzZpT3NwbGpVQzl6QjEwWklnUXlPcXZoYXZ5OTIvT293TDBh?=
 =?utf-8?Q?b+yKrip5xCfm46v+nxv7rrA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <923BCF6419B16B44B121C6B60E5F7EF9@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f1446adc-8984-4c6e-2f70-08daa7736178
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 08:18:42.4534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zCiBpsGJ17E3cZ6+zhEjg9JVUTtat4GMrir0oHzWuvov83n5QrW66g4FRg3dixC6/HvXalTDPeNGWceZqnCu+TFA92pwYrDWRrysoocd06M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB1962
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWlxdWVsDQoNCkxlIDA2LzEwLzIwMjIgw6AgMDk6NDcsIE1pcXVlbCBSYXluYWwgYSDDqWNy
aXTCoDoNCj4gSGkgQ2hyaXN0b3BoZSwNCj4gDQo+IGNocmlzdG9waGUubGVyb3lAY3Nncm91cC5l
dSB3cm90ZSBvbiBUaHUsICA2IE9jdCAyMDIyIDA3OjI5OjEyICswMjAwOg0KPiANCj4+IE5PX0lS
USBpcyB1c2VkIHRvIGNoZWNrIHRoZSByZXR1cm4gb2YgaXJxX29mX3BhcnNlX2FuZF9tYXAoKS4N
Cj4+DQo+PiBPbiBzb21lIGFyY2hpdGVjdHVyZSBOT19JUlEgaXMgMCwgb24gb3RoZXIgYXJjaGl0
ZWN0dXJlcyBpdCBpcyAtMS4NCj4+DQo+PiBpcnFfb2ZfcGFyc2VfYW5kX21hcCgpIHJldHVybnMg
MCBvbiBlcnJvciwgaW5kZXBlbmRlbnQgb2YgTk9fSVJRLg0KPj4NCj4+IFNvIHVzZSAwIGluc3Rl
YWQgb2YgdXNpbmcgTk9fSVJRLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waGUgTGVy
b3kgPGNocmlzdG9waGUubGVyb3lAY3Nncm91cC5ldT4NCj4gDQo+IERlc2VydmVzIEZpeGVzIGFu
ZCBDYzpzdGFibGUgdGFncywgaXNuJ3QgaXQ/DQoNCkkgZG9uJ3QgdGhpbmsgc28sIGJlY2F1c2Ug
dGhlIG9ubHkgdXNlciB0b2RheSBpcyBwb3dlcnBjIHdoaWNoIGRlZmluZXMgDQpOT19JUlEgYXMg
MC4NCg0KSW4gdGhlIHN0YWJsZS1rZXJuZWwtcnVsZXMucnN0IGl0IGlzIHNhaWQ6DQoNCiAgLSBJ
dCBtdXN0IGZpeCBhIHJlYWwgYnVnIHRoYXQgYm90aGVycyBwZW9wbGUgKG5vdCBhLCAiVGhpcyBj
b3VsZCBiZSBhDQogICAgcHJvYmxlbS4uLiIgdHlwZSB0aGluZykuDQoNCg0KPiANCj4+IC0tLQ0K
Pj4gICBkcml2ZXJzL210ZC9uYW5kL3Jhdy9tcGM1MTIxX25mYy5jIHwgMiArLQ0KPj4gICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9tdGQvbmFuZC9yYXcvbXBjNTEyMV9uZmMuYyBiL2RyaXZlcnMvbXRkL25h
bmQvcmF3L21wYzUxMjFfbmZjLmMNCj4+IGluZGV4IDgwMGQ3NzRhZWQ4ZS4uZjY4MzQ5Y2I3ODI0
IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9tdGQvbmFuZC9yYXcvbXBjNTEyMV9uZmMuYw0KPj4g
KysrIGIvZHJpdmVycy9tdGQvbmFuZC9yYXcvbXBjNTEyMV9uZmMuYw0KPj4gQEAgLTY2Myw3ICs2
NjMsNyBAQCBzdGF0aWMgaW50IG1wYzUxMjFfbmZjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKm9wKQ0KPj4gICAJfQ0KPj4gICANCj4+ICAgCXBydi0+aXJxID0gaXJxX29mX3BhcnNlX2Fu
ZF9tYXAoZG4sIDApOw0KPj4gLQlpZiAocHJ2LT5pcnEgPT0gTk9fSVJRKSB7DQo+PiArCWlmICgh
cHJ2LT5pcnEpIHsNCj4+ICAgCQlkZXZfZXJyKGRldiwgIkVycm9yIG1hcHBpbmcgSVJRIVxuIik7
DQo+PiAgIAkJcmV0dXJuIC1FSU5WQUw7DQo+PiAgIAl9DQo+IA0KPiANCj4gVGhhbmtzLA0KPiBN
aXF1w6hs
