Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C65373F971
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjF0J7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjF0J6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:58:55 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2059.outbound.protection.outlook.com [40.107.12.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55F12952;
        Tue, 27 Jun 2023 02:57:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHXHOnL6Jd6GMeIzJwFLimQNhTqnQrKreDN58FLDdomm8eXPXbphXYLeDWwujeEVvh2h5Pa1JK5EiFH/xSfvJ22Oe3fUaDY1taWtQjgwSW1/ZNAnfkvjMw8zdj+j4PGnBFm3gXwKqaWjfjqiHb6f9QddHSUk7GwBGxBoY20UJrEcUF/mG1j2WBraV2givixMqR5R8MgMAYlPsbh5BnEf60m7BFgOxlJe6b4aZt8P1GbtpC104j4Ik4hCIYhQigMIus9OaO48ZaQzb6F4BYD7ox+i+wX6ymZVhfW3CbvX7GJNWSWHS5L1qCD4HEAeYlG4ofFXS95ulEa7dPnl/J3ieA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRN3ZQFVemQlQqTtpCQc9UU+y/EEcAGqg0JxZVWJ9M4=;
 b=Vse+41ZO3u26joPYOcblNCX+9rOqnsHz5FXdA7M5Ywtr9py9LM+TxLxH56yKSCC17P4vb/xd7Iy7O+bNsYjXx+7+oynNDBgXUGwimw7s8Fu1qGrLEmaD3PoWMDFcFi5zr5Slf14oXYxDLkUDCrzYg0H5AH3xld7JgoDFp5cxr1HveyTluE1iU0//DwPtauTQaox8fGeGOHzwLTyfQ2/OR95EWcosa1XxApxEm32dDcp0tXu+LL2j29o5ERb0a/Tru5asSE8W/5V6m5xZDXU91trjAfEZQSwLEuFw0MU57tGE8dTP/qxXX3RUtXRiZOqK1oKrehu3koaBpXoKuXlyaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRN3ZQFVemQlQqTtpCQc9UU+y/EEcAGqg0JxZVWJ9M4=;
 b=H7KIJEMgyMT3cKH1JADN9IKrjxHTO4aCuxvj3JAWwff8gxh5EPGMPyXUHv70IG05wgrbGVAYo2KqLQRjYfnRBLHKUXGAR5w8KyPCTxGntyTm1Ya8gBhDOmXm556idaqpgnSv6XSIEfkpgbQp+0kEBjC0BXVMYEAPzXoSMYXMR2PEJA/QISAzpmlLVQ+oaTv4YdE40KiDvykk+hG/K46a30/+bsxK0QpiXUXGZEHNFaGt7U19KBttO0OIgT/KPy8iBXR0cdgcd71CWalbYgrbvWtBas7tJLkLasWBJdNVaip6qgXD+rt2K/Inm2z6IQ2aIMVcsfUTka4vKNBMZsAICw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB1628.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:166::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 09:57:07 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::802b:33:561c:4217]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::802b:33:561c:4217%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 09:57:07 +0000
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 07/13] minmax: Introduce {min,max}_array()
Thread-Topic: [PATCH v6 07/13] minmax: Introduce {min,max}_array()
Thread-Index: AQHZpbDwXNyJA0Kgn0GOtNMldSLv1q+ecBMA
Date:   Tue, 27 Jun 2023 09:57:07 +0000
Message-ID: <a37b8f2d-1ade-86ec-282d-25d7eab148aa@csgroup.eu>
References: <20230623085830.749991-1-herve.codina@bootlin.com>
 <20230623085830.749991-8-herve.codina@bootlin.com>
In-Reply-To: <20230623085830.749991-8-herve.codina@bootlin.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB1628:EE_
x-ms-office365-filtering-correlation-id: 39351815-40a4-480d-183c-08db76f4de23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YIMpgAzASW9DjTClhoPKeSX7YEuQ7xsXaYyq8iBwKfE6MML47vrZpsc4WpL7dX71UNlMYJIUYg/JKcLAQhqDM18yndjRyqLiDnB2DBMqNjw5qTbtPQIyniQiIWZbkrTquzo5334ku8thJU1rN+3J9BlgMlRvXgv16oaLm+fUGVvxplex21Q5wC3XOt7AdriHR5iUFD2yFbU1L5R3ZDje6BWZML9WeL9tqCTOevKayclYADCgCJQgCR1FHW/vexEpHoqr1neFFLoeUr4WfDiKioJZEas/lXHaI/GtPW9p76polfMBODTDagLIfkUX6C2EqL4+//C4potqeIGvdjKBJOfvuFcn2hNZV4FEMYwwoSSXB5Gc2yo7tQbt17gOYkBpU0zzPCvZu5fiBXAiXpYyB+Ny4C+msrhtdjMLD/7/uOAa8Zwrzs+T47mtDInhIcmdyBst7uocWeRRZahb7aaBdFPRJWywelPgkH0W4CSnu0m4wkG5HLQTUlK77KQZlgP1okds63RuYLfdWfmoAtOF9/lPbp///JoANZdNRv2Q0+DjXtpuJcH+47Mmfbo7PsoWYRECWwhErY22qZebrH7ImLK7DAU6JmSeEfPsEhVVWu4KU2nC/Ao9VKARjKBcogJoNwIA4qrFrRS48vYz+YcswrfHbcmWmFHYnBTPr2wiN+dwp6tPxszz3qFq2YF8aONp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199021)(66556008)(66476007)(38070700005)(36756003)(6506007)(110136005)(54906003)(478600001)(2616005)(83380400001)(26005)(186003)(2906002)(71200400001)(6486002)(5660300002)(44832011)(7416002)(921005)(122000001)(316002)(66946007)(31696002)(38100700002)(76116006)(91956017)(64756008)(8676002)(66574015)(86362001)(8936002)(41300700001)(4326008)(66446008)(31686004)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVV0cWR5S2Y0Q09Wdkh3SVdRZkpoaHRPWUNqd3FsSGp4QXA4c0taV2J6Uzhr?=
 =?utf-8?B?d0Q2L1FwQjZiQUxXeEF2MTN2cS9YUUlGM1dEaHpjcEl2VlZsb2RFVUxkYytp?=
 =?utf-8?B?WnZGNkdXR1ZkM21odnc4K01TcXM4TTNRSE9tVng4WjZPdXZBZVhXUzdtM1JW?=
 =?utf-8?B?UE13RGhXNU5MTDRnVGVMdS9PdzF2ZjczS2NaUDBvekJDSVphN3pndWtVWXJ1?=
 =?utf-8?B?V0E4RllScTVCL0QvR0VEejVqckplQW5DV29zbmJZRXd4K1Zjc1JJTDRoMHBm?=
 =?utf-8?B?OFdiSkg5bGdtaWhXbUtXaXMrdGNGVFlJVTBVT3U1ZWE2WU9sdTQ2Q1NFRmpU?=
 =?utf-8?B?a1JXck16RzhJenJ5MUhZY3lVcHFHM2h6VFdSRHpUSVQ3THRXZ3RHRTFkbVZR?=
 =?utf-8?B?VjN6cWNOVS9iYzdVQmJFc1BxVHlZS1d5clZVTjBldldodlBESWVBdWFHY3hF?=
 =?utf-8?B?YWdsU29abVJ4MlVQZjYvVEYzbjZ4elVKREVWYWxvYjJIenVJNUpyVG9KQ0d2?=
 =?utf-8?B?NWVNeGpKN0NSTTVnVHorR0lpZFVlM2VzSWFXZzJjcFdxZExWNWNLYmpTWGRG?=
 =?utf-8?B?cHNHZEtPTkdWdTA1Q21TRjFHeFdMMHZpVU9ZZzJ5NW5WRU1nWitlb2JQbmJj?=
 =?utf-8?B?OVlHMEM1S0JLUkQrMmhycmJPQ1EwbXYyMzR6ZXBscTVlWmRhbEpNMGZzV21k?=
 =?utf-8?B?YU1iMWRNK3c4UGUxcStlT1hNd3BOZ3FNL0RuZG95ZHdDeUcxSGZKbkRKekhW?=
 =?utf-8?B?YkMyK1o2bUlmSzYxbmVrdUZaWnpzV1I2YjRJTnptdlo5NGtvTHIwR3lmNURT?=
 =?utf-8?B?TnVEOGI2UzlQMkFDVE9aNTRabEpxRHUrUGpWZm15aThQZXhyTU1KaURJejBF?=
 =?utf-8?B?OEt4dnlzSC9Yd2hHU2JZRHkvcWFYMjh1anRsZjVIT3VLamcwYmQ3V29vOUVv?=
 =?utf-8?B?R3lpV1RWN01uVG5uYXk2dStpNFFWQ1doS2Z6K2Fnd3NLdW0ySVptMHVlc2JT?=
 =?utf-8?B?R2JoRmhHc1JXVXA4eDZDY3V5WlI2bDdkSGJiTjhuaGxaNU1PWmx4aDdBelR5?=
 =?utf-8?B?NGFGdnFJUjM2eDZKeFFnZnc1S0F6VzBIY0ZlV3ovOGYxbTZpU2pWVGQrRTc1?=
 =?utf-8?B?SG1DMDNoU0wrR0o4a0hwc25aR2VaMkZiSFFsb2wyWDlkTDJ0OTdLekxsT096?=
 =?utf-8?B?UVAvTWgwaEVVRFl1SDlFRW8rMGNCT1d6RVFvRlNwR1hjS1hxbXVvTWtYMGpr?=
 =?utf-8?B?MXk2MDR1SnhrbmdhTUVXNkRrYzdKdkdmRzVpdlRqV1VSY3o3aXhKQlhMTVZ0?=
 =?utf-8?B?WCttaWJzTVVZdDhFanhjY3VvV1owOFRFNWFLOVY4L0FPYWV6NGp3UmpqbFNk?=
 =?utf-8?B?NlFFK3g0K0JOcTZNRDF0eC9QR1VuQ1pqQzhPZ3B0cktzNmVDZjdkYWduZy96?=
 =?utf-8?B?dDFDYTU2aG5NRDJlbmZUNXFHLzBBUFFzaDM3VUE5RTMva3VvaEpoMGxCeVZD?=
 =?utf-8?B?K3JjQzU3THBnaFIwWUpnMDAvZ3VZdmorNTN0bFBvUDJ5UTZKcTlCc3ZmZFov?=
 =?utf-8?B?bXRIellUZjl1eXpna3E2bktUQkc0eGRRZ1gwZ2UybS9oRXZjMS9XdG04TWdS?=
 =?utf-8?B?WFY3eThGL1AwcjBtTDAxR2xrUjBiM1VaU3V0VCtrcENkY28xSkxKRnJHcDhP?=
 =?utf-8?B?Y1F4d2haMUo5b3U1bFV3SU56VUpMenNYNEtkSnQ3VHhpZjV6ZjMrRWFYMUI5?=
 =?utf-8?B?bkVJbUhZekkyOTdMaTZzSzEvRlNXYmRvaE0raGQ0ZXh5eDhrRGNlcmJORFBH?=
 =?utf-8?B?a21lVVhKaFpsM2dDK3FPaHBBUjBHM2FaWjdrVUZzOUV6UkxQa2RhVHp5MlYy?=
 =?utf-8?B?Q1hLTUNSUzJ6NmRnVXB6cGluaWpySFhJbSt3RkYyTnNJNXJIOXlOSTMxMHpZ?=
 =?utf-8?B?MjNqMWVmRS9SMmF0cVdxSnRWWG1aenVxK1dhTEp6Yys1aTNjSVhrc0g0UXp4?=
 =?utf-8?B?N0FGR2pzRWRIUHg1SWNQS2lGM1VBU2lVc3kvSTlDaWtQODc3clZWYW5wbmVP?=
 =?utf-8?B?YytPcW41ZkJaWmtSMHpnUXFMT2hpM3UrcWZzTzJDYmpCK3FtaXduZkFWUVI4?=
 =?utf-8?Q?y+ZIsyRLcykdlB7WtQ323qe4U?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F04BC93DE04CD84DB2AD03AB091A2109@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 39351815-40a4-480d-183c-08db76f4de23
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 09:57:07.3382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I8QyTjtG+dSZ0GKEwCMtzRkXlJ32dfikofCKed3gAbvq93QwoAqpA/FNKLeD5HGG+cgXJ01Besfins3rK5m85ApacjhVXHMzkvlIzbT+h+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB1628
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDIzLzA2LzIwMjMgw6AgMTA6NTgsIEhlcnZlIENvZGluYSBhIMOpY3JpdMKgOg0KPiBJ
bnRyb2R1Y2UgbWluX2FycmF5KCkgKHJlc3AgbWF4X2FycmF5KCkpIGluIG9yZGVyIHRvIGdldCB0
aGUNCj4gbWluaW1hbCAocmVzcCBtYXhpbXVtKSBvZiB2YWx1ZXMgcHJlc2VudCBpbiBhbiBhcnJh
eS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhlcnZlIENvZGluYSA8aGVydmUuY29kaW5hQGJvb3Rs
aW4uY29tPg0KPiBSZXZpZXdlZC1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmR5LnNoZXZjaGVua29A
Z21haWwuY29tPg0KDQpSZXZpZXdlZC1ieTogQ2hyaXN0b3BoZSBMZXJveSA8Y2hyaXN0b3BoZS5s
ZXJveUBjc2dyb3VwLmV1Pg0KDQo+IC0tLQ0KPiAgIGluY2x1ZGUvbGludXgvbWlubWF4LmggfCA2
NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gICAxIGZpbGUg
Y2hhbmdlZCwgNjQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvbWlubWF4LmggYi9pbmNsdWRlL2xpbnV4L21pbm1heC5oDQo+IGluZGV4IDM5NmRmMTEyMWJm
Zi4uNzk4YzY5NjM5MDlmIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L21pbm1heC5oDQo+
ICsrKyBiL2luY2x1ZGUvbGludXgvbWlubWF4LmgNCj4gQEAgLTEzMyw2ICsxMzMsNzAgQEANCj4g
ICAgKi8NCj4gICAjZGVmaW5lIG1heF90KHR5cGUsIHgsIHkpCV9fY2FyZWZ1bF9jbXAoKHR5cGUp
KHgpLCAodHlwZSkoeSksID4pDQo+ICAgDQo+ICsvKg0KPiArICogUmVtb3ZlIGEgY29uc3QgcXVh
bGlmaWVyIGZyb20gaW50ZWdlciB0eXBlcw0KPiArICogX0dlbmVyaWMoZm9vLCB0eXBlLW5hbWU6
IGFzc29jaWF0aW9uLCAuLi4sIGRlZmF1bHQ6IGFzc29jaWF0aW9uKSBwZXJmb3JtcyBhDQo+ICsg
KiBjb21wYXJpc29uIGFnYWluc3QgdGhlIGZvbyB0eXBlIChub3QgdGhlIHF1YWxpZmllZCB0eXBl
KS4NCj4gKyAqIERvIG5vdCB1c2UgdGhlIGNvbnN0IGtleXdvcmQgaW4gdGhlIHR5cGUtbmFtZSBh
cyBpdCB3aWxsIG5vdCBtYXRjaCB0aGUNCj4gKyAqIHVucXVhbGlmaWVkIHR5cGUgb2YgZm9vLg0K
PiArICovDQo+ICsjZGVmaW5lIF9fdW5jb25zdF9pbnRlZ2VyX3R5cGVfY2FzZXModHlwZSkJXA0K
PiArCXVuc2lnbmVkIHR5cGU6ICAodW5zaWduZWQgdHlwZSkwLAlcDQo+ICsJc2lnbmVkIHR5cGU6
ICAgIChzaWduZWQgdHlwZSkwDQo+ICsNCj4gKyNkZWZpbmUgX191bmNvbnN0X2ludGVnZXJfdHlw
ZW9mKHgpIHR5cGVvZigJCQlcDQo+ICsJX0dlbmVyaWMoKHgpLAkJCQkJCVwNCj4gKwkJY2hhcjog
KGNoYXIpMCwJCQkJCVwNCj4gKwkJX191bmNvbnN0X2ludGVnZXJfdHlwZV9jYXNlcyhjaGFyKSwJ
CVwNCj4gKwkJX191bmNvbnN0X2ludGVnZXJfdHlwZV9jYXNlcyhzaG9ydCksCQlcDQo+ICsJCV9f
dW5jb25zdF9pbnRlZ2VyX3R5cGVfY2FzZXMoaW50KSwJCVwNCj4gKwkJX191bmNvbnN0X2ludGVn
ZXJfdHlwZV9jYXNlcyhsb25nKSwJCVwNCj4gKwkJX191bmNvbnN0X2ludGVnZXJfdHlwZV9jYXNl
cyhsb25nIGxvbmcpLAlcDQo+ICsJCWRlZmF1bHQ6ICh4KSkpDQo+ICsNCj4gKy8qDQo+ICsgKiBE
byBub3QgY2hlY2sgdGhlIGFycmF5IHBhcmFtZXRlciB1c2luZyBfX211c3RfYmVfYXJyYXkoKS4N
Cj4gKyAqIEluIHRoZSBmb2xsb3dpbmcgbGVnaXQgdXNlLWNhc2Ugd2hlcmUgdGhlICJhcnJheSIg
cGFzc2VkIGlzIGEgc2ltcGxlIHBvaW50ZXIsDQo+ICsgKiBfX211c3RfYmVfYXJyYXkoKSB3aWxs
IHJldHVybiBhIGZhaWx1cmUuDQo+ICsgKiAtLS0gODwgLS0tDQo+ICsgKiBpbnQgKmJ1ZmYNCj4g
KyAqIC4uLg0KPiArICogbWluID0gbWluX2FycmF5KGJ1ZmYsIG5iX2l0ZW1zKTsNCj4gKyAqIC0t
LSA4PCAtLS0NCj4gKyAqDQo+ICsgKiBUaGUgZmlyc3QgdHlwZW9mKCYoYXJyYXkpWzBdKSBpcyBu
ZWVkZWQgaW4gb3JkZXIgdG8gc3VwcG9ydCBhcnJheXMgb2YgYm90aA0KPiArICogJ2ludCAqYnVm
ZicgYW5kICdpbnQgYnVmZltOXScgdHlwZXMuDQo+ICsgKg0KPiArICogVGhlIGFycmF5IGNhbiBi
ZSBhbiBhcnJheSBvZiBjb25zdCBpdGVtcy4NCj4gKyAqIHR5cGVvZigpIGtlZXBzIHRoZSBjb25z
dCBxdWFsaWZpZXIuIFVzZSBfX3VuY29uc3RfaW50ZWdlcl90eXBlb2YoKSBpbiBvcmRlcg0KPiAr
ICogdG8gZGlzY2FyZCB0aGUgY29uc3QgcXVhbGlmaWVyIGZvciB0aGUgX19lbGVtZW50IHZhcmlh
YmxlLg0KPiArICovDQo+ICsjZGVmaW5lIF9fbWlubWF4X2FycmF5KG9wLCBhcnJheSwgbGVuKSAo
ewkJCQlcDQo+ICsJdHlwZW9mKCYoYXJyYXkpWzBdKSBfX2FycmF5ID0gKGFycmF5KTsJCQkJXA0K
PiArCXR5cGVvZihsZW4pIF9fbGVuID0gKGxlbik7CQkJCQlcDQo+ICsJX191bmNvbnN0X2ludGVn
ZXJfdHlwZW9mKF9fYXJyYXlbMF0pIF9fZWxlbWVudCA9IF9fYXJyYXlbLS1fX2xlbl07IFwNCj4g
Kwl3aGlsZSAoX19sZW4tLSkJCQkJCQkJXA0KPiArCQlfX2VsZW1lbnQgPSBvcChfX2VsZW1lbnQs
IF9fYXJyYXlbX19sZW5dKTsJCVwNCj4gKwlfX2VsZW1lbnQ7IH0pDQo+ICsNCj4gKy8qKg0KPiAr
ICogbWluX2FycmF5IC0gcmV0dXJuIG1pbmltdW0gb2YgdmFsdWVzIHByZXNlbnQgaW4gYW4gYXJy
YXkNCj4gKyAqIEBhcnJheTogYXJyYXkNCj4gKyAqIEBsZW46IGFycmF5IGxlbmd0aA0KPiArICoN
Cj4gKyAqIE5vdGUgdGhhdCBAbGVuIG11c3Qgbm90IGJlIHplcm8gKGVtcHR5IGFycmF5KS4NCj4g
KyAqLw0KPiArI2RlZmluZSBtaW5fYXJyYXkoYXJyYXksIGxlbikgX19taW5tYXhfYXJyYXkobWlu
LCBhcnJheSwgbGVuKQ0KPiArDQo+ICsvKioNCj4gKyAqIG1heF9hcnJheSAtIHJldHVybiBtYXhp
bXVtIG9mIHZhbHVlcyBwcmVzZW50IGluIGFuIGFycmF5DQo+ICsgKiBAYXJyYXk6IGFycmF5DQo+
ICsgKiBAbGVuOiBhcnJheSBsZW5ndGgNCj4gKyAqDQo+ICsgKiBOb3RlIHRoYXQgQGxlbiBtdXN0
IG5vdCBiZSB6ZXJvIChlbXB0eSBhcnJheSkuDQo+ICsgKi8NCj4gKyNkZWZpbmUgbWF4X2FycmF5
KGFycmF5LCBsZW4pIF9fbWlubWF4X2FycmF5KG1heCwgYXJyYXksIGxlbikNCj4gKw0KPiAgIC8q
Kg0KPiAgICAqIGNsYW1wX3QgLSByZXR1cm4gYSB2YWx1ZSBjbGFtcGVkIHRvIGEgZ2l2ZW4gcmFu
Z2UgdXNpbmcgYSBnaXZlbiB0eXBlDQo+ICAgICogQHR5cGU6IHRoZSB0eXBlIG9mIHZhcmlhYmxl
IHRvIHVzZQ0K
