Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE56473F983
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjF0KAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjF0KAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:00:03 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2047.outbound.protection.outlook.com [40.107.9.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CF230EC;
        Tue, 27 Jun 2023 02:57:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCw4y1dYEJ+H+FUiLrbHOTaM2PIxL0ZZm2R2H/mrGBZVI2Ed+hQdwrl+kI4LN4TxokBK6JarkCbNHLoFBXx8ZlOaIDr9apt51f/UCqV8YSgbGXs/RfcYB3JPk8eqWT5dXub2ddh4FFJE88TM7LoP+x2AkcVIqPqZFPL8k6jUfm8cawnYHDBIcXN6T2RM9TJOgXgOKV407tFPOilxhX2wURe400G4zYs7w0zmyK5akt9JWhLBRsz9BMEYboGTtTN+rNIptIJuSFyfBAsxIyWXoUimLpWKWMlGwS0Hr1AWelCowpNe/Ig8QXZlojegKNwRrXWUZrezY/BNWdlhPZFVPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEYX5mSI1GOKDQiZ6qqUkem2sxcfmFWrhw1OvynakOg=;
 b=eca/m0+O7l2IqiGyOJV/JK7V4MnIGzhNDHtgcSmwMT1l+CkiA8h2flWlh4tUVMCzOYMfH6IhgbsdaEyuTeP9YRve1cBetkWkNdRlU8OgeZDWxC/elfY9huXOg+0DuQ+gFkT0CLjuvPCaG5Jk5m8D0O/pYFXGohoHeQ/r0RE5pB8n+JgLHRBkRxNUyEb96ub2R6PRT77kCp+EwwIMfgvojX66ZkAx7GprTVxJ6Spt5F1XUerpXtp+o7wI4kj8O5KvujwzYYy78jrGvib+5SJ7ankOr4rwzcg0TOEudxJXdFrixwIwVHxfTWWZJQRETDlys52u8wGFKTYSfrEnqxY5LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEYX5mSI1GOKDQiZ6qqUkem2sxcfmFWrhw1OvynakOg=;
 b=l+k1miNupS4VIqRTkF1FG2c2v+efkGGVHJAHu3exkvJvdTR/5ceCAjkZk2aqmpIH9Ma8OGPPq6ktr7cxp6b38/ytKq7fkD/GEgMwSMAJE5my9ZHw2cEsBfu1v1Ld6QEbZ4FEd//jDp2Ddz4qt99EWcJkS0HXTGQ7DlLqEzsgIAjNp8PbnHH8ZWDPL1/nqFmSc9aRofvc1n+UVFIXnvRmnqb6nPaxXSMhf9Zy4Maw61Dvp5VgnnL4bZoDsYApeDj5ayr7Ony0+jM93WNLOBOLJo5ncg74ZIafG+S+nfEBvQ6LsCSib5mZs2RTn1b+dH7Cp3o6Q+6VTKFytkRiFr6Vhg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2423.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 09:57:49 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::802b:33:561c:4217]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::802b:33:561c:4217%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 09:57:49 +0000
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
Subject: Re: [PATCH v6 09/13] iio: inkern: Replace a FIXME comment by a TODO
 one
Thread-Topic: [PATCH v6 09/13] iio: inkern: Replace a FIXME comment by a TODO
 one
Thread-Index: AQHZpbDz4IJQWxE94UGtvqMcp4kRDa+ecEUA
Date:   Tue, 27 Jun 2023 09:57:49 +0000
Message-ID: <c5a588ab-6212-a274-7353-f5f99f84df82@csgroup.eu>
References: <20230623085830.749991-1-herve.codina@bootlin.com>
 <20230623085830.749991-10-herve.codina@bootlin.com>
In-Reply-To: <20230623085830.749991-10-herve.codina@bootlin.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB2423:EE_
x-ms-office365-filtering-correlation-id: 913597c2-abe3-4c11-66c3-08db76f4f710
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DqepICxNqHgHx9Z+gn88Te+gQIrlD9jYoZ3Q3jU+MFKq+lybeMPvj5zuKVh2UXSE9mwTVnPNQ9G458qj+spZObd7vICRV3DHCwn1V//wUJf6/LVDnuokXr73FiuD6SpEJYGeTt9HcqlIDthNarcLztzMtbxTkwduNihqWrCkQvnyqOpRWt9VSh1XXP488OyoID3/B1p/hEvCGO51BKtzvqK5s4XWFRnQ8F5bReSw0vtRUE0I6YDXMcPpBG8+PY4pH4vM6S0A7AIccLvMd3v83MiN5V862GajfEhAAMtsH5u/H3A0iqlwnE7tEraxOEYbqNVeHUp+YwUlXi/S1gCdNxU3M//wju/G/meKfzX+1fEVZhDHGoBq6ki4Ze791lqBfouOzxp+qP6JHaPeHv92weqL/ZG2cpBC/Vx8XiOLWvqma8t1nZqs5P++SVWPuD2cAuuPlH59elNNPpxFsDVDYBta/gFluOwC1fzCTqz35Vd2XVvr3lEfCybXvezDIN2J9n+zzixp4sHCJbQyOhaws6bdCEwRW66ldOASkrZ3P+Q4JzcZuGhBKazKiqP9LL5mXlTkkdaLVavMJ6PALPETPIlE5SX+6Er9ZNfRiypFj8LtA5v+3W+a/a53ogTaqnZtp+XF7FIyod9xoxVX0+SMfcNe5dYHWmm+Gv44xuM78mJfEW7fob8CR2ZVHHWwMCy9qqVvz+bAz4ZD5glNooS7gA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(41300700001)(66476007)(26005)(4744005)(186003)(2906002)(66574015)(38070700005)(921005)(38100700002)(71200400001)(122000001)(6512007)(6506007)(8936002)(5660300002)(64756008)(83380400001)(44832011)(91956017)(76116006)(66446008)(66946007)(66556008)(8676002)(36756003)(7416002)(2616005)(110136005)(6486002)(54906003)(31696002)(86362001)(4326008)(478600001)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?em42T2tZNldJV3BtQWRRVFdzOFkxcUttV1pjaXIza1ZJUkV0cENmM2JNZ2hz?=
 =?utf-8?B?NFZaV052aXNEeDhSVEFIbkhobTh3TEU2eTRsWGZmeE45S1hPWGtJOXdOa3hv?=
 =?utf-8?B?amszR3VtNndlZDQvdU5jRzNoVzRNSVlYMHZOblJBT2x6V1hvLzhTNTl0dDd1?=
 =?utf-8?B?RzZJNW5SVG9GdXl6L01qbHluQTlCTGtHdmVpL3Zka21tUXoxT0o2bTBmQlNI?=
 =?utf-8?B?cy9pVUtydGFUMDJ5emZaVVVmQzh3V1c1RzZmcEJTZW81US9qUEFVdFpYNVdk?=
 =?utf-8?B?SVpFMHpIS2Fyd2RsMmZyV0NwU0ZINmNZRm9WbFJXU1ZlamkzSDBZVm5pUTAv?=
 =?utf-8?B?blZ5TUQ4MXlNemZyK0xCZ2FhS1dyaG9OU3J0cjE0aTVub0tPRWQ1OWlic0pP?=
 =?utf-8?B?bWlnK3pZSDYxWnRML1o0alJ4Q2hvc0l0RTRhcVBTQVp0Uzl5V09SQlJab216?=
 =?utf-8?B?c201WFRNOVJ2TFJXYm9IYjZjQTcxa1hxYk13eG5RVDVXYXl4eTN4ZkRKbW8x?=
 =?utf-8?B?QlNHcEJrNVYrTGhEQm8xQU5vUjRvMmE3amFvV2hmRjhZekRMRFNzOUtrZFAx?=
 =?utf-8?B?L2ZHK2Y0K1dTWVRFLytCb2RvVW1rS3d4bEpvZVlRWDJKQll1b01RdndMT3Ri?=
 =?utf-8?B?aXFzM28xNXdvQU9DaTJoOWRaeVpwR1ZCamV4RnZaenhtbWpCSzJXQ0U4Q29X?=
 =?utf-8?B?N01rZFlCK050OTl0eTJNRmFvbGQrMmhQL1Q2Y1Jqa0d6dmhGeGlyUzlseXlp?=
 =?utf-8?B?UDhMZ0liWCtZYXV6TzN6dzJySGVJYUZ2Q3l0VFR6ZkVEVGRRRWsyT0VRZDlR?=
 =?utf-8?B?Sk5mVHE2TFppZ05OaURQSTZkTVNUa3lRSGpEZ09JUk5Rcm8yczl0UUxjd2NJ?=
 =?utf-8?B?S2VqckYrYU9NUmlXaUJZSW9YZ01oWCs2S1VTYUlWeWVNUzBiTXlUTWlLZlJm?=
 =?utf-8?B?QU9KdFNPMm1vejJZMnFNMjFxK2QrZHBKNnZTZlFJWDQ2Mm1JTU9rWVdqVFdl?=
 =?utf-8?B?cmtrL0lJVFJPZzE5UVBaYURGQjBkZDVwY0VsUmdYU1VHZnRzTHM5a1M0QS9R?=
 =?utf-8?B?cGQxdnk5bEl2QUg3eDhIVjVyZ0VlSEZncUVkR1o3Vi90ZjN3M1kydW1EZWpS?=
 =?utf-8?B?L1lmb3lyT24yRUYxYWdmVDI5eFE3d2RTSFdnVFF3dmU3TXZmMWQ2WWlhQ0pK?=
 =?utf-8?B?cnFObE5hRTRtZjdHdVREbDFVY1BjSzEzL0xoWU95bmxoRHhMYklid2d5bnpm?=
 =?utf-8?B?Q1dnRVBuUEppb3pzRjFGMFBlbGRJalR2NGxRZHYwcEoyL2FTTEZrT0Z2Zm5S?=
 =?utf-8?B?bnk1bmFGcFlOa0JqUGlLc3NmUzF3dU5NMDBhSmNPWEVDSWYzRzk0WmVFOXpP?=
 =?utf-8?B?a3VuQzhnWmxNeDRVNk5xQlpZOU1RZys5S0xscUQ0VFlsMktNNGtIWHJLMFpX?=
 =?utf-8?B?dTNkZFFqTTkvVzBPcjdROEZHYWNma3BSTjZGdXN2d1VtMDRwZGVwK2JueUVD?=
 =?utf-8?B?VnpDc2Q5Y0tYRzlDUUU3NStZNFFJL1BXRVlTYkJuWjNiN2xMR1FOQjdES3NX?=
 =?utf-8?B?STY4cHA3UVlHU2g5ajhXMHJ6dEgwRmFQbWErY3c2WTdDaHBtWTg2NUowRjJY?=
 =?utf-8?B?a09abU1BODdkcEd0ZnhXdEwzYVU1bTl0ZlM1N0ltR1czTENPN01qQ1AxUGlz?=
 =?utf-8?B?L1hGbzVyd3FwV0xlMkVSZUdYdmx0QjJxV1VKN1k1aGo3V0NnNUN6anpEUTZV?=
 =?utf-8?B?YVNuNHZsNEdyV1h2WUNYVDdYRTBwNXFrcnQyMk9NTnZ0ZHdWZDV5MHFiQ2hs?=
 =?utf-8?B?UjM2U1BXZUxBNURzYmJHTy9vS29xM0pDdWZlQTlSenlheXRoY3RxcXlSUGJl?=
 =?utf-8?B?V1IvZDFVVG5hOVB5Mi9Wblk2NDZ6WjMvZ0JNS2htMWwydThzU0VUVEFaUUhR?=
 =?utf-8?B?OHdrdnVkM1FIYmpKNFVreTlRcUVvdW1JSUMyTVp5dXplRkhiRDVTb2VqQUMy?=
 =?utf-8?B?bG84cjM5c0x3NTBlaHFZbzArQjIxekNVa3RiM1dBdTRrY01BWGhkb0pXc0N5?=
 =?utf-8?B?aXdpU3RBUVEwZjhxbTlteERYWlhENnRRR2c1d1M2SzRJUDZrWXRlSmM2UHg2?=
 =?utf-8?Q?xbmMx/UBC8PBiKdtAeFdeH8qE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00F99C223D533347A79D70558BD086DC@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 913597c2-abe3-4c11-66c3-08db76f4f710
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 09:57:49.1705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YW8K5i9UC9mi2VMM/TAOqIyfbw7rf6CHEIpEklaH3+Q6YieoYe81WtsbVGSizbcyxW7Gf+QYU0G9pUSHDZ23mCFjR17sMId5IuOoBqBqTG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2423
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
aGlzIEZJWE1FIGNvbW1lbnQgaXMgbW9yZSBhIFRPRE8gb25lLg0KPiBJdCBpcyBhIG5vdGUgd2hl
biBzb21lb25lIHdpbGwgbmVlZCBmb3IgdGhpcyBjdXJyZW50bHkgdW5zdXBwb3J0ZWQgY2FzZS4N
Cj4gDQo+IENoYW5nZSBmcm9tIEZJWE1FIHRvIFRPRE8uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBI
ZXJ2ZSBDb2RpbmEgPGhlcnZlLmNvZGluYUBib290bGluLmNvbT4NCj4gU3VnZ2VzdGVkLWJ5OiBK
b25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+DQo+IFJldmlld2Vk
LWJ5OiBBbmR5IFNoZXZjaGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+IEFja2Vk
LWJ5OiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+DQoNClJl
dmlld2VkLWJ5OiBDaHJpc3RvcGhlIExlcm95IDxjaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+
DQoNCj4gLS0tDQo+ICAgZHJpdmVycy9paW8vaW5rZXJuLmMgfCAyICstDQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9paW8vaW5rZXJuLmMgYi9kcml2ZXJzL2lpby9pbmtlcm4uYw0KPiBpbmRleCA4YmZk
OTFmNzQxMDEuLjE5ZGRkNzdhZGIxMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vaW5rZXJu
LmMNCj4gKysrIGIvZHJpdmVycy9paW8vaW5rZXJuLmMNCj4gQEAgLTg3OSw3ICs4NzksNyBAQCBz
dGF0aWMgaW50IGlpb19jaGFubmVsX3JlYWRfbWF4KHN0cnVjdCBpaW9fY2hhbm5lbCAqY2hhbiwN
Cj4gICAJCQkqdmFsID0gbWF4X2FycmF5KHZhbHMsIGxlbmd0aCk7DQo+ICAgCQkJYnJlYWs7DQo+
ICAgCQlkZWZhdWx0Og0KPiAtCQkJLyogRklYTUU6IGxlYXJuIGFib3V0IG1heCBmb3Igb3RoZXIg
aWlvIHZhbHVlcyAqLw0KPiArCQkJLyogVE9ETzogbGVhcm4gYWJvdXQgbWF4IGZvciBvdGhlciBp
aW8gdmFsdWVzICovDQo+ICAgCQkJcmV0dXJuIC1FSU5WQUw7DQo+ICAgCQl9DQo+ICAgCQlyZXR1
cm4gMDsNCg==
