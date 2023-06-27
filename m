Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FB973F941
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjF0Jz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjF0JzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:55:12 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2054.outbound.protection.outlook.com [40.107.9.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332AD2969;
        Tue, 27 Jun 2023 02:54:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ag6KvrtcWb9KE77Dq6xvLEXP0A75Vu4RxsJ4w86Xp7JDggTzdV/9f5V1Thvnqfbf54DWRihcJPft2XzB4d7oz9o0pqg0NvJDMFbZ5UF5QxkHS8WKOuZiwQj1egJDZiD1h5DcumNoSBEPnUAFg2FTpXkuwLovYEnpSEy70CIlxW94I8gwno8Ac4n3zhUKh72d/mLTE/N+Yd2KFJFS0ALEce4ymIsuAWz88BAyIbgBf6yox4UwE3B06K+IQdrXai0BGVWVKBanQT53PuAWCmslJTgb4V8rhz8gQvIpCFkyB7X3xOBhCMkNwETuzDvHLb6+rNgpO3Ndp2SkeErx1bLbtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+VCqCLtsx5cbPmNOa+LFlD4chZlfHujzq5+Za8kMrU=;
 b=UBKC255CbtgK7A/xVaXP8L6CGwe98FBfTEJm7Xr3Ga5q9Lrcs+xDXAYXeZEfubBVxcEEUe2/T8wNegJCXRoZeCtCjZu3JpjJvFZnarw0iRH/7zkqkKzYlB2Nlm76kpqkqneqfHE76Dz4382vqUBeUVy/t5+RI4Rad+e7dvxASrIYfgvkxTmwneGb8pHfmO6RqfrC671S/zE5QylIdBcDPWSr61j822ZLy9BBCv3TGwRwylohhoq/qFN7d5X+6ErWSm5shkpzCrtdEVDUjmlZju4kOZ/VxviF6KTyqaDdYZ/5NqDTuhVIeS8/lU4PdSsy3trFQIJUS/VUq37dYGQeFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+VCqCLtsx5cbPmNOa+LFlD4chZlfHujzq5+Za8kMrU=;
 b=QO8QqFvXqXFboe9NyzD5jOyxuqsgP/HT6o5ulKchbLylBMNeXQ1KjLuPRlMGhxumfMEBUIEhDvmPA8hH0NxXcDy6UifI8VW5APf4Xz4I4DwgF/bSvOklSZR5HdYnK/lCH8heQAT3ULYYJQeHBN5DLW5j8HjoRfCLPzvqfKN2/GqZozx5Wd2IMLZELqH/5k0w9MLqUF8ME8h2kp4Y4hvF0d+mAMuurbARHLwmFySIr/UkCsvSmay3SwLZ+rNCgZhCH3Go2+MFhQc75tg5abcf2QOo5Q42L6SBcxiipIflRElSH/3Ap1nj96WNJwlDGVefndT2qguTQpOaS2zemdNYZw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAYP264MB3319.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:18c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 09:54:39 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::802b:33:561c:4217]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::802b:33:561c:4217%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 09:54:39 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v6 02/13] ASoC: dt-bindings: simple-card: Add
 additional-devs subnode
Thread-Topic: [PATCH v6 02/13] ASoC: dt-bindings: simple-card: Add
 additional-devs subnode
Thread-Index: AQHZpbDqY3UCTr2AzEuZx47fLIXGb6+eb2MA
Date:   Tue, 27 Jun 2023 09:54:39 +0000
Message-ID: <ca6f3ac3-d3d9-7e45-aa6b-8358f5765057@csgroup.eu>
References: <20230623085830.749991-1-herve.codina@bootlin.com>
 <20230623085830.749991-3-herve.codina@bootlin.com>
In-Reply-To: <20230623085830.749991-3-herve.codina@bootlin.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PAYP264MB3319:EE_
x-ms-office365-filtering-correlation-id: 45f8651a-0304-4109-c7e8-08db76f4860c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3uvIdPeHU+8aOE63pQyqPslnk0M7jOaRkYswWm39/ks8ve1Vs65RYE6h50+eprEr0gA6kO6z2DvTxgtRin+CaanglgtGyDSOv8kmN3qQHf2JhUGOD6emqDmS3VB6XTuHs1CR5EYx6kjaBUV66xDe0HqpEBANfDhaDAoOWuXVruf1GauIN9v3/u8AU0gZJ8pQJRwOvJIYCPeUpqIFHhyTeHOZuS8j4kFdDaA7mIxPivv4bEagO1lSNUAL/huDZ+SJHbsjBt3yQNTUnBb4zVexpDbOR2/XbuTw0f5/ebbH7PzVrifrgO9Q/FsR5piojxNAesxLA6Z6gjbUcp+JfZZlFRnrrrP9gNwJFM59tCmj+i0C873+zm67eOBzVXKKOmvkOwwjhXqIL2aZY8GbJq+OtpeoORrVGF897bPlz5/0LLH2BIYancAp4XASI365AlJcuUruSPkJhopYVO4FGpb0AI29mH2Cj10xGGfo569AduuiYT2LYV9QYYA3RgrEcQGcSfK0flPy9m1BzjF+TXbbwVonGe4iMvWUInmSdRPjOxmHo+a/vennqYBBBPHcuOEywOzK0Fc8sz+QSwxtU82qapR2ZQGw2iGcq9J2qHttu/7CsWYJlJdlwz998z87p3y3wsNG27tPolo3MU20g56u2FgzW3mmfPngYMazIpGNHiX6R3dHRleBjcrImeEMEKNguApaD9eu/kiGT+Bom9SXxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199021)(66446008)(66574015)(54906003)(110136005)(83380400001)(6486002)(71200400001)(26005)(2906002)(6512007)(2616005)(6506007)(478600001)(186003)(5660300002)(44832011)(36756003)(921005)(7416002)(4326008)(122000001)(38100700002)(76116006)(316002)(66946007)(38070700005)(31696002)(66476007)(41300700001)(8936002)(8676002)(66556008)(91956017)(64756008)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGh1WEJCVitBa21IOFJMbm1iKzFqSFg1NVc5cmJSa2ZtYytaM0FiSGJJUGZn?=
 =?utf-8?B?OVJ3cHBteW9GY0FaTTNTQWNBN0ZVb21EUW4wUDNjbDNpMmQySkY5cHZ6Skl0?=
 =?utf-8?B?VFhJTDZ4ZlNDYWc3SzRSbXRlUG9YTGJBdU5BSWdkUnkvQUl1aHR3SUFhanJp?=
 =?utf-8?B?ZGl3ZHRXaXJQZVN5Q1hFM21RTFRhd2NWdjgxN1lENlkyNUFHVDBLNGFnbmYv?=
 =?utf-8?B?TDhZKzJ5WWdQUFh4MTJHR2tVaVZxWmkrNVA4S2hMUnphcVRRN1NRbjlmelp3?=
 =?utf-8?B?S05kSGdHQmFaN3Vnbkl6TFRhdk1ySVBGL2k3MkdVd1gwUmZ3YlplbDcwT0h3?=
 =?utf-8?B?dXhXNjltcDBlVFEzY2RYYXRJMjNJR2tEQVo4MHhOY28xTFFUbXZ0SzJUVXh6?=
 =?utf-8?B?anAzdlU1REJYS21ESkdpQW42ejArd2tMdGhkQmw0Vk55Yk1lUjU0Y0VFVXVU?=
 =?utf-8?B?UzJ1d3gzOXFNdjU1QnNBdC81TzhHbElNOGlOUlpDWFVpNi9rUXhwNHBpU0lh?=
 =?utf-8?B?VStOaDdmcy9nN29LbEF2ODcvczVHclVDRTJtajBNd1NPNnA0OXdCUXExdG96?=
 =?utf-8?B?NHc3YkUrK0hqK25jdFNhZXcycjUveFFDd1B0L1hjcmwyOHhQVndWV1dkTjJG?=
 =?utf-8?B?cEZwSDVoTVlzSlluUVNXdW92YVc0ck9ZZlpNV3NnUVRNQldDSjNnVVNJMjlM?=
 =?utf-8?B?RUZsbUhsemkyZ3ZiL21XUWVkK014Q1BuWndHRHh1VU5zVGJuc1RyTFk4S3Mv?=
 =?utf-8?B?OFo5akw3eXVYMTNDZnM3L28zM2ZRZ016aHR2U1VyRTVXaForZzhLN1VkOS9U?=
 =?utf-8?B?anhiRFZSdFJ1RlZqMGtPNHNuU2tDNE5vREVzRTNJejhOendPcnV2REowTTZH?=
 =?utf-8?B?MEZEUjcvaGFPSWU3RFpLek50VjlGOCsvNlIzelpuZjYzNVA0YjhRK2kvRnY0?=
 =?utf-8?B?b1Z2U1hNUzMzLzhkaGp1M01ZbWZBam4rR3VETytpZnlDZ1ErVlJEdytIQmt0?=
 =?utf-8?B?MVJCUlRYb2ViN05Ma3kxOVdVQk1kNFhBeTJoZjBEejJqN1J4YnlxRHpvOUV4?=
 =?utf-8?B?a3pqZm5lK09tNzFLNCtsRVdidTVRVlZEZm9qS2RMY2ZuM1VxdjRJeTFXbDZZ?=
 =?utf-8?B?ejQ3eklnWVFRcEsxWDZ6cDFSYmdBaHdqVGtnOUxQVjVqQ1BYVDV3MFhFS0xw?=
 =?utf-8?B?OEFLWTZyVXNaakhCaFBHaWJTNXduNHhyai9BRzRGbzRzVzBGWUFlQ2wwQSt1?=
 =?utf-8?B?dTZUQ3hoN3dwMUdWNlVKWXRvdmFGay80TldoVENTNDBZeC8vb1B0NndTZVJs?=
 =?utf-8?B?K05Hdyt2ZzlySGVuYWlKKzhOWGFxT2RaMzcwRGFqcS80VUhPampRejJXWm9m?=
 =?utf-8?B?QW15OWJ2ejFvNU1BSjNEUE4xMXVYVlRRcFJSUGF1RHNsMWUwTmZRdzMyREt6?=
 =?utf-8?B?V2tWQjAxK3hKWFJiVVJ4bGhSNVFqSkFxUXB0L2FDdE1oamVRd0ZpSWFET2FF?=
 =?utf-8?B?b1NCMDRvMFBTWVMzSThvdU1yLys2SXc3SjB4ZVg4ZHQ2OXlyWXFUSGxmNlJQ?=
 =?utf-8?B?bHJtSVdpRCsvQlJOOTc5dUJBSHJQT1hNTXQ5RzBMMHQrcWNnM00zN1FZTDBP?=
 =?utf-8?B?NHpFampXUnQvWUg2UjJnUTgyUFhLL3pBYTJuNzlnc0ZhSkx2aStPa2QvaElV?=
 =?utf-8?B?SGw1cTQwMytLbldMWDRGdnJWSGEyK1ZaOHIrS216MnE0SXdTQ1NZU1VVcnpn?=
 =?utf-8?B?OG1PV1dxZnQ1K0U0bnpWb2hMQjBVUU15R2ZNRjFrbjFYNEFNSnl3cUp6T3NG?=
 =?utf-8?B?bUw0K1RkN1hETUFmMTQ4ZkdUYnlTQ0cxQ203VVBuVkNRRG9vWk9tWGY1WDJQ?=
 =?utf-8?B?TlZ4UFBmbXdBbFVnZ0JQNk9aVjJjb0hrTGpMM0tjeFZPV283Lzl3eHZjOXFE?=
 =?utf-8?B?QzB3NWFDeGNTMkphUExPQng5UjFNTE53bzgxdERaY09OQVVRL2wrZVdWYjlW?=
 =?utf-8?B?aTAvbzF1YXRIY2lxYk9xelRBQnVQOTdGNTJhbC9mMzQ0QytZVzJqRGVhTS8w?=
 =?utf-8?B?K0g5TVFjTnVWODV0dVJxWXZKaSs4Y2IwUXR0MXhKZVhod2NsWndDcFFqNWRz?=
 =?utf-8?Q?bKrmW9GonL5weq1NgoRPDU0rY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5531EDA3555FA740A29DDDA2C410B0C9@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f8651a-0304-4109-c7e8-08db76f4860c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 09:54:39.5997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fD9O0qzue2vAluPMciM7/J7kUZv3NFIEtS5TnYTTMQ1wnW1TU9dNLxAtoHiKJw2rr6VkWsjmPVZlsPKgo3ggvKho0UCzQGo1StDVEFafVGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAYP264MB3319
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDIzLzA2LzIwMjMgw6AgMTA6NTgsIEhlcnZlIENvZGluYSBhIMOpY3JpdMKgOg0KPiBU
aGUgYWRkaXRpb25hbC1kZXZzIHN1Ym5vZGUgYWxsb3dzIHRvIGRlY2xhcmVkIHNvbWUgdmlydHVh
bCBkZXZpY2VzDQo+IGFzIHNvdW5kIGNhcmQgY2hpbGRyZW4uDQo+IFRoZXNlIHZpcnR1YWwgZGV2
aWNlcyBjYW4gdGhlbiBiZSB1c2VkIGJ5IHRoZSBzb3VuZCBjYXJkIGFuZCBzbyBiZQ0KPiBwcmVz
ZW50IGluIHRoZSBhdWRpbyBwYXRoLg0KPiANCj4gVGhlIGZpcnN0IHZpcnR1YWwgZGV2aWNlIHN1
cHBvcnRlZCBpcyB0aGUgYXVkaW8gSUlPIGF1eGlsaWFyeSBkZXZpY2UNCj4gaW4gb3JkZXIgdG8g
c3VwcG9ydCBhbiBJSU8gZGV2aWNlIGFzIGFuIGF1ZGlvIGF1eGlsaWFyeSBkZXZpY2UuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBIZXJ2ZSBDb2RpbmEgPGhlcnZlLmNvZGluYUBib290bGluLmNvbT4N
Cj4gUmV2aWV3ZWQtYnk6IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2Vp
LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IENocmlzdG9waGUgTGVyb3kgPGNocmlzdG9waGUubGVyb3lA
Y3Nncm91cC5ldT4NCg0KPiAtLS0NCj4gICAuLi4vYmluZGluZ3Mvc291bmQvc2ltcGxlLWNhcmQu
eWFtbCAgICAgICAgICAgfCA1MyArKysrKysrKysrKysrKysrKysrDQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDUzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvc291bmQvc2ltcGxlLWNhcmQueWFtbCBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9zaW1wbGUtY2FyZC55YW1sDQo+IGluZGV4IGIwNWUw
NWM4MWNjNC4uNTlhYzJkMWQxY2NmIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3Mvc291bmQvc2ltcGxlLWNhcmQueWFtbA0KPiArKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvc2ltcGxlLWNhcmQueWFtbA0KPiBAQCAtMTQ4
LDYgKzE0OCwxNSBAQCBkZWZpbml0aW9uczoNCj4gICAgICAgcmVxdWlyZWQ6DQo+ICAgICAgICAg
LSBzb3VuZC1kYWkNCj4gICANCj4gKyAgYWRkaXRpb25hbC1kZXZzOg0KPiArICAgIHR5cGU6IG9i
amVjdA0KPiArICAgIGRlc2NyaXB0aW9uOg0KPiArICAgICAgQWRkaXRpb25hbCBkZXZpY2VzIHVz
ZWQgYnkgdGhlIHNpbXBsZSBhdWRpbyBjYXJkLg0KPiArICAgIHBhdHRlcm5Qcm9wZXJ0aWVzOg0K
PiArICAgICAgJ15paW8tYXV4KC0uKyk/JCc6DQo+ICsgICAgICAgIHR5cGU6IG9iamVjdA0KPiAr
ICAgICAgICAkcmVmOiBhdWRpby1paW8tYXV4LnlhbWwjDQo+ICsNCj4gICBwcm9wZXJ0aWVzOg0K
PiAgICAgY29tcGF0aWJsZToNCj4gICAgICAgY29udGFpbnM6DQo+IEBAIC0xODcsNiArMTk2LDgg
QEAgcHJvcGVydGllczoNCj4gICAgICAgJHJlZjogIiMvZGVmaW5pdGlvbnMvbWNsay1mcyINCj4g
ICAgIHNpbXBsZS1hdWRpby1jYXJkLGF1eC1kZXZzOg0KPiAgICAgICAkcmVmOiAiIy9kZWZpbml0
aW9ucy9hdXgtZGV2cyINCj4gKyAgc2ltcGxlLWF1ZGlvLWNhcmQsYWRkaXRpb25hbC1kZXZzOg0K
PiArICAgICRyZWY6ICIjL2RlZmluaXRpb25zL2FkZGl0aW9uYWwtZGV2cyINCj4gICAgIHNpbXBs
ZS1hdWRpby1jYXJkLGNvbnZlcnQtcmF0ZToNCj4gICAgICAgJHJlZjogIiMvZGVmaW5pdGlvbnMv
Y29udmVydC1yYXRlIg0KPiAgICAgc2ltcGxlLWF1ZGlvLWNhcmQsY29udmVydC1jaGFubmVsczoN
Cj4gQEAgLTM1OSw2ICszNzAsNDggQEAgZXhhbXBsZXM6DQo+ICAgICAgICAgICB9Ow0KPiAgICAg
ICB9Ow0KPiAgIA0KPiArIyAtLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiArIyByb3V0ZSBhdWRpbyB0
by9mcm9tIGEgY29kZWMgdGhyb3VnaCBhbiBhbXBsaWZpZXINCj4gKyMgZGVzaWduZWQgd2l0aCBh
IHBvdGVudGlvbWV0ZXIgZHJpdmVuIGJ5IElJTzoNCj4gKyMgLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj4gKyAgLSB8DQo+ICsgICAgc291bmQgew0KPiArICAgICAgICBjb21wYXRpYmxlID0gInNpbXBs
ZS1hdWRpby1jYXJkIjsNCj4gKw0KPiArICAgICAgICBzaW1wbGUtYXVkaW8tY2FyZCxhdXgtZGV2
cyA9IDwmYW1wX2luPiwgPCZhbXBfb3V0PjsNCj4gKyAgICAgICAgc2ltcGxlLWF1ZGlvLWNhcmQs
cm91dGluZyA9DQo+ICsgICAgICAgICAgICAiQ09ERUMgTEVGVElOIiwgIkFNUF9JTiBMRUZUIE9V
VCIsDQo+ICsgICAgICAgICAgICAiQ09ERUMgUklHSFRJTiIsICJBTVBfSU4gUklHSFQgT1VUIiwN
Cj4gKyAgICAgICAgICAgICJBTVBfT1VUIExFRlQgSU4iLCAiQ09ERUMgTEVGVE9VVCIsDQo+ICsg
ICAgICAgICAgICAiQU1QX09VVCBSSUdIVCBJTiIsICJDT0RFQyBSSUdIVE9VVCI7DQo+ICsNCj4g
KyAgICAgICAgc2ltcGxlLWF1ZGlvLWNhcmQsYWRkaXRpb25hbC1kZXZzIHsNCj4gKyAgICAgICAg
ICAgIGFtcF9vdXQ6IGlpby1hdXgtb3V0IHsNCj4gKyAgICAgICAgICAgICAgICBjb21wYXRpYmxl
ID0gImF1ZGlvLWlpby1hdXgiOw0KPiArICAgICAgICAgICAgICAgIGlvLWNoYW5uZWxzID0gPCZw
b3Rfb3V0IDA+LCA8JnBvdF9vdXQgMT47DQo+ICsgICAgICAgICAgICAgICAgaW8tY2hhbm5lbC1u
YW1lcyA9ICJMRUZUIiwgIlJJR0hUIjsNCj4gKyAgICAgICAgICAgICAgICBzbmQtY29udHJvbC1p
bnZlcnQtcmFuZ2UgPSA8MSAxPjsNCj4gKyAgICAgICAgICAgICAgICBzb3VuZC1uYW1lLXByZWZp
eCA9ICJBTVBfT1VUIjsNCj4gKyAgICAgICAgICAgIH07DQo+ICsNCj4gKyAgICAgICAgICAgIGFt
cF9pbjogaWlvX2F1eC1pbiB7DQo+ICsgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJhdWRp
by1paW8tYXV4IjsNCj4gKyAgICAgICAgICAgICAgICBpby1jaGFubmVscyA9IDwmcG90X2luIDA+
LCA8JnBvdF9pbiAxPjsNCj4gKyAgICAgICAgICAgICAgICBpby1jaGFubmVsLW5hbWVzID0gIkxF
RlQiLCAiUklHSFQiOw0KPiArICAgICAgICAgICAgICAgIHNvdW5kLW5hbWUtcHJlZml4ID0gIkFN
UF9JTiI7DQo+ICsgICAgICAgICAgICB9Ow0KPiArICAgICAgICB9Ow0KPiArDQo+ICsgICAgICAg
IHNpbXBsZS1hdWRpby1jYXJkLGNwdSB7DQo+ICsgICAgICAgICAgICBzb3VuZC1kYWkgPSA8JmNw
dT47DQo+ICsgICAgICAgIH07DQo+ICsNCj4gKyAgICAgICAgc2ltcGxlLWF1ZGlvLWNhcmQsY29k
ZWMgew0KPiArICAgICAgICAgICAgc291bmQtZGFpID0gPCZjb2RlYz47DQo+ICsgICAgICAgICAg
ICBjbG9ja3MgPSA8JmNsb2Nrcz47DQo+ICsgICAgICAgIH07DQo+ICsgICAgfTsNCj4gKw0KPiAg
ICMgLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICAjIFNhbXBsaW5nIFJhdGUgQ29udmVyc2lvbg0K
PiAgICMgLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg==
