Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661AF73F93C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjF0Jzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjF0JzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:55:04 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2054.outbound.protection.outlook.com [40.107.9.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F6D3A8C;
        Tue, 27 Jun 2023 02:54:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AW3cXHpcMOe6KLfKtpPeztj29PuXKojw7hfgbsrIw7mMZ977M5MNlGvH2fnb+a1vcZe6ABOFC1H1qhLcciiQyp3YF7x9pevX162cLbwsMGKhUj4yGtdtFc7COQ5xbI1EWovHOcvctO4GeEUZvPexvQx8LE1dj/EghMMzMHY9w/ksfwv475HTcpavNbmOHtUQ8uT9G1+8mLZ6j+KPVBCRsHUNMX+27vNUkXWuaPrUc03x01M2fskTOZpuUnvD1xAyqSCPsZjoc/9D+iRaC5LW30Y89PtKC2VbwUaNNK/0nYO1wG6KVvX2JJzO/r/IIUl9pP35/gF8aOKJpXQtiklcyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUUBe0fC5r/MLtSnU/JpwfH75K/t2sea1vtCVWkA6Mg=;
 b=VgM/qfv639bAANnn/jYwE+YowqV/gqmSZ6oQzJL1YUOjn/pf7JTofKFEZxLGYCrwVyB0UMDCzp/tLxG7L/AW/aIRSgyt2TF7dRGUjoD0uPtPRrP6wXwabS6AOkdYQCf7xSL5RxI5XEOHH192fqNXK4zsLgkSStMCiN1xE411XfB4zNP7HiGW4WIgZQ0vRa/P0sgsfCRPIUbyHp+WwXsgUQ4WWdQNS+JBAMJLAtLFCmcz8wrI9k4Rw5TdVvlYAm1rGsPj9DhMhZTW7WucGE/LRjLQigI0IaZYNWUqb5uoiMbE8T85MpkqikfstWc8znvL/p8R4yao8hmAuHVfCwP8ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUUBe0fC5r/MLtSnU/JpwfH75K/t2sea1vtCVWkA6Mg=;
 b=GFf9ybDEg7teHMeEV5ycr+oGXcV+T/v9VOxEUr6O0K1CfhwNHNf5teD3PIPD3KpsNGHnIxWU9tAOg9wlR7KFHNDLObblJE+dT6qpfJaMOv8hiCcFFtjPKOV2uwsxbT0NuUvcAVqveZKIozoSvHm8z3+z6eOau9BHbXowvA8iso0BD934AsMLbbPAJtbfu6fRTc+3n0zduDLLa5iHxugh6ov/gBoJfd45O8Ydqr1zKE8zWGaavWk8Tul8Sij9ZCw5TBGEw2fy3Divs72pq6a0qZJdXEsvWHXC3gcij8HxjGzEsRD4ZRT0BYl2vBoHE+/lQSsoA92kjBWyHez9ifxh2Q==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAYP264MB3319.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:18c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 09:54:16 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::802b:33:561c:4217]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::802b:33:561c:4217%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 09:54:16 +0000
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
Subject: Re: [PATCH v6 03/13] iio: inkern: Check error explicitly in
 iio_channel_read_max()
Thread-Topic: [PATCH v6 03/13] iio: inkern: Check error explicitly in
 iio_channel_read_max()
Thread-Index: AQHZpbDrwkgbwph1TUmGLHseN7c/sq+eb0eA
Date:   Tue, 27 Jun 2023 09:54:16 +0000
Message-ID: <769a9a93-849f-2e45-7220-6e612500a579@csgroup.eu>
References: <20230623085830.749991-1-herve.codina@bootlin.com>
 <20230623085830.749991-4-herve.codina@bootlin.com>
In-Reply-To: <20230623085830.749991-4-herve.codina@bootlin.com>
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
x-ms-office365-filtering-correlation-id: 9a9d3fb2-60c7-43a5-5fd0-08db76f4782f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pzafqrlQquoIhE5ku8ynKUfNoejdyUAdEa9do8ncI0pFOz7NY1Amkw86sNsP1h6h/0jFlBGeJaFspmdXPNpjf0OYLKvPhGS62y9k5J3TQVGcwIDifQFr34+/mlhR2uFiIxe8I6UQE/NBVCJl7DeUBUzcp85Knlppcwgrt0BrAgb++/46GhqxDZrByj8H/wlkToaoiZef9U9jazhxjPqaSYaIH0fAjenjMJjQHnHrJIInX0eN3hefad1evj4PbfZqZZKTwdv5ivRS3+OdyHqjtjG0W0nIHwI29XtDIfsevQzc0W3bwe3gEo4g76pgjSCyZDh/Hzyt9ZiStxioIep/riuGuAt7U9tl3/UG/M6ZRtKkK9hN2rt3/U79sFKuyAG37K5SCiyKK5zuhdLN8HRl2ohqxD8mu6SqeiPo5QBF9ubzxUkq4e/GLGojHmzVj/ngGN1MbB5grBEPHwOFPfUNNSbOA1i2aCmNiYQ0NsbMwjd5Ue1MMqD7DnxCOKQACgpK2Y3UdrrDSRIidAGdlUUv0gWthuejaZSC+dX0D5xg0ZQhoUPr+z3HGnyFV4UgQBt1DEuu2ha2PAERngrQ92HZPXsBgWdXzNG6IkR4TW9HUJG6vmOPKHCCiDUFTCvFgC1P2sdcMLK4BhZGib3xKH0Xvq2Eu4MaXzuv8XAzTehm+n2AJDA6d+f4uwZBDljHii4KR/oYUQj5IWHkc1JQlO76ew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199021)(66446008)(66574015)(54906003)(110136005)(83380400001)(6486002)(71200400001)(26005)(2906002)(6512007)(2616005)(6506007)(478600001)(186003)(5660300002)(44832011)(36756003)(921005)(7416002)(4326008)(122000001)(38100700002)(76116006)(316002)(66946007)(38070700005)(31696002)(66476007)(41300700001)(8936002)(8676002)(66556008)(91956017)(64756008)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mkx6eStoOXhjK2huOWFLUTVOUVd4YjJBMGhJWWhyMytHaVBwZEdvQ1NITCtC?=
 =?utf-8?B?UHptdndRS3JoZmhlcEdSRGVITENXbXJMUTJ5U0YycmtidkxZS3pEd1dscDVV?=
 =?utf-8?B?Nm9EOWY5aWdHWUhzM1ZTdlJIQUQ1MzREaExYeTY0d0NyRTlLS09YaGNrdDZ2?=
 =?utf-8?B?b3ZtbnZLWjdEN2VBaXViQ2JuT2pxcHVYU3hhZEErSm90MWJ1RDAvbWxxdmVQ?=
 =?utf-8?B?RDlGZnpibmtrZ1ZsbzQrUUdiT3h2ekR3OHVOeXlmWHdLWVV1RkFKT1EyNTdV?=
 =?utf-8?B?WkpkUFZQMVNuSEdWdU5IekMvMGwyTVJ3RkYwcHNWQlFheEl2bzRmOGlxbkM5?=
 =?utf-8?B?Yld5YnFTTjFBZm9udzNLbjk2Qm1xVFpNejU1cVh3NDM3TWtaMndsR0Jlek0w?=
 =?utf-8?B?MnhXWHlSalZ4RG1Ha0NZMzBTS1B5QklIUkxQdHhZcHg4elpGQTBteVBIMU44?=
 =?utf-8?B?SUw3OThXaTdKcTk0VEZ6QTRjSXp0Z3FrK1l1V0FuMDhzdktqYlVqM293TzBr?=
 =?utf-8?B?empnVUN0ZzhBZEh5SmhKOTR5QTFkdEd4L283Yk5XaFVVSGxZUU5Yc01welp4?=
 =?utf-8?B?Rmx1a1FEaWp0TWE4SUhMSi9nSS9JODhLbFdGNnUzVXJoZmk0K1plTEU1d0py?=
 =?utf-8?B?d3E4c1BoaXdzYVZVbjBtbUVlS2QyN2t5aUZVSzdwdzRQeFRFQkt5VU40Ymh4?=
 =?utf-8?B?NHNuR2JOdHlmWjR1S3NHYU1kREVPNHlNTjIzS0dvMXhOV2pTOGxSazUwTjRK?=
 =?utf-8?B?OUdnUE8vM3pteVdVeG9adWdpdWl4VUVlMlhtTnFvRVlBRDMyeUhsenRMY3dv?=
 =?utf-8?B?K0o2NXJ6czNzR0xTL3FWV3lsOXYxbEt4WjlTcUlhYTZiYVVRbWxudzB5U1gz?=
 =?utf-8?B?cldTOGFudmR0MFFRSTdkcDVFbGkvcTVSLzRJQ1ZDdFhaeVJybnBMUXMyOHVP?=
 =?utf-8?B?SkdpajVaWWFMdTNsRDVzYTV0cjIvU2FySE9rNlRjNzVBa3pqeitYR3JBM3dL?=
 =?utf-8?B?RU1OaEQzWEpHbnFWejhnTmdoVThoSjM4TUxyR2dIUm1qcUFOZnRWdnJNTGRQ?=
 =?utf-8?B?QU1UKzNZbXlUb0tpMC90RjNaMjQ3Rnk5QVF2VmxGdU1vemdScFFQUlg4NXdo?=
 =?utf-8?B?akthZkk1TlNaQWZsNGZzQkprTVZmUlZIMHFXUXhPajlQL2xzQ2pNQ0xGRDlI?=
 =?utf-8?B?dmVaZHJiN05XU2dXWjB0SXdrQStqa2gvenB5SjE2YnZGcGhLaWMreXpRaElT?=
 =?utf-8?B?VnhnNEpESWpkTlNqbEYzTC9GTFZrbmpJVUw0Mmk0U0pLbWlrUlhPcE5Xd0Uz?=
 =?utf-8?B?aGo4aFhZQ0lSc2poQ1I4RHNabHQwOFBTWnBwaGhIZEQ0M0dVWk9jQmNKbDRZ?=
 =?utf-8?B?RW1mVFVyK3QxQUNDYVB4ZndPSlI3WUV4U0tCT3VNVURIeEF4VGpKUlcwSndm?=
 =?utf-8?B?ZDdyNFlMSUpRMmZ3WHd1SkhVS3czZEdNWWZqMU9zVWg5OXFROXVzT293Tzcv?=
 =?utf-8?B?ei9RVy9rdVZ1bUVXK2FJd2VOYjlIVC9iVFIrc2VCa2Y1cVJPbHRsbzlmSzVZ?=
 =?utf-8?B?N1RXV2lCa3gxbG5xdzR6NTE1cHQ1V1pQV3hoMXZFdFJuODlWZGpWV05CUDJO?=
 =?utf-8?B?d04zMElNTzlQSk5Bdk0rZjl2WnVoWFFiS1hKNzBxMHJNWDd3cnBVdi8waGxS?=
 =?utf-8?B?YXdGRFBETXlnNG5FVzJFK0FEbFFocmlpdWtiSFNad0N0WTg2Sm5xVVJSTk5z?=
 =?utf-8?B?S2pLVkF6YlQyaEpNOUVpcFh3bXZTcFd1N3N2K0M2ZkJaWU9wSkh4VUdUVFZa?=
 =?utf-8?B?aStvTEFCRzNPSzNlNzRUQmxHTS83Qy9yd25kQm84bDVHMVBHOU45QW51UFBO?=
 =?utf-8?B?N1VhZXVubE1BSmpBOU42UG1ZL2tkTlhqRUZzbm9ZWUxTeTZpUUsrb1dUTURa?=
 =?utf-8?B?OWg0Q1lLY0kzM3FBNlI1NjVLb3gwYTBXNXpQZWk1czdLU3VZYnNQMExGZjI5?=
 =?utf-8?B?V1Rzd3B2eTRweUM2azN4RThFSlEzSW90dldpR3lpQUxJb29yaElwL2MvcEFa?=
 =?utf-8?B?UzZPOEJSTlBob0FMYTY2eEt3VDR4bmI1TXgvcHFwR2xJaEhYRnZwVS9XSjNn?=
 =?utf-8?Q?kYM9237CK1dkYSGpBYyUrlRr7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53CE729500D3304DA6740986175C0C1C@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9d3fb2-60c7-43a5-5fd0-08db76f4782f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 09:54:16.3006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G3QYIhOhjNrrAN2WENcyOcnJ3oltMq5xpByZFnJk9FeVKojYiEIqeLGYlQyqgqWK/bWXV+HU2HuOoOItAZucEfho5UBc0Irs3dzsR5Axftg=
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
aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiByZXR1cm5zIHRoZSBlcnJvciBjb2RlIGFzIHBhcnQg
b2YgdGhlDQo+IGRlZmF1bHQgc3dpdGNoIGNhc2UuDQo+IFRoaXMgY2FuIGxlYWQgdG8gcmV0dXJu
aW5nIGFuIGluY29ycmVjdCBwb3NpdGl2ZSB2YWx1ZSBpbiBjYXNlIG9mDQo+IGlpb19hdmFpbF90
eXBlIGVudW0gZW50cmllcyBldm9sdXRpb24uDQo+IA0KPiBJbiBvcmRlciB0byBhdm9pZCB0aGlz
IGNhc2UsIGJlIG1vcmUgc3RyaWN0IGluIGVycm9yIGNoZWNraW5nLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogSGVydmUgQ29kaW5hIDxoZXJ2ZS5jb2RpbmFAYm9vdGxpbi5jb20+DQo+IEFja2VkLWJ5
OiBKb25hdGhhbiBDYW1lcm9uIDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+DQo+IFJldmll
d2VkLWJ5OiBBbmR5IFNoZXZjaGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQoNClJl
dmlld2VkLWJ5OiBDaHJpc3RvcGhlIExlcm95IDxjaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+
DQoNCj4gLS0tDQo+ICAgZHJpdmVycy9paW8vaW5rZXJuLmMgfCA1ICsrKystDQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaWlvL2lua2Vybi5jIGIvZHJpdmVycy9paW8vaW5rZXJuLmMNCj4gaW5kZXgg
ODcyZmQ1YzI0MTQ3Li5mNzM4ZGI5YTBjMDQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaWlvL2lu
a2Vybi5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2lua2Vybi5jDQo+IEBAIC04NTgsNiArODU4LDkg
QEAgc3RhdGljIGludCBpaW9fY2hhbm5lbF9yZWFkX21heChzdHJ1Y3QgaWlvX2NoYW5uZWwgKmNo
YW4sDQo+ICAgCQl2YWwyID0gJnVudXNlZDsNCj4gICANCj4gICAJcmV0ID0gaWlvX2NoYW5uZWxf
cmVhZF9hdmFpbChjaGFuLCAmdmFscywgdHlwZSwgJmxlbmd0aCwgaW5mbyk7DQo+ICsJaWYgKHJl
dCA8IDApDQo+ICsJCXJldHVybiByZXQ7DQo+ICsNCj4gICAJc3dpdGNoIChyZXQpIHsNCj4gICAJ
Y2FzZSBJSU9fQVZBSUxfUkFOR0U6DQo+ICAgCQlzd2l0Y2ggKCp0eXBlKSB7DQo+IEBAIC04ODgs
NyArODkxLDcgQEAgc3RhdGljIGludCBpaW9fY2hhbm5lbF9yZWFkX21heChzdHJ1Y3QgaWlvX2No
YW5uZWwgKmNoYW4sDQo+ICAgCQlyZXR1cm4gMDsNCj4gICANCj4gICAJZGVmYXVsdDoNCj4gLQkJ
cmV0dXJuIHJldDsNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICAgCX0NCj4gICB9DQo+ICAgDQo=
