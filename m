Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E976BB4D9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjCONhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbjCONhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:37:50 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20615.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::615])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4051EBF1;
        Wed, 15 Mar 2023 06:37:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXOi14M19H+JK7Va9SMQEw2/H9gwAnWBk9wDpKNfwClTv+cGog1ixgVfAnV1wSuwKeEv/Mja4biZgM+/GikKS9kovYx/BQtc3kts37Qmlf45JrwlIOnXG5BpCmyXyiLAT6JCn3DrdNXZvOwgW06tD0pw8oyZyzLOoRt/EmEMuBcNWDQobjq0J9/rngK0dgPEDm37sphdYpd5HtT140H/lOPSfX1G3BPg8Byb/8Le434yJh5YxKAovKZ7NKIuLcBsjkGjLAbD3eEdrEa97DftuVpoz7b/91BOjGxBAb3k7IaiEbN3aN0ndcEYc6sY/Q3pfG7wfmydfmRaEe5byOaY6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DedZRVJ7oajOkKn+sg2W6ez4QIO48/KbCtCea5HbhFU=;
 b=k1973vXNuBUG54hkKnmgad3Yj7rvsczS8fSu4j8F68iPQ12Jv6u3wtW6U1LElAyhniwwqzVnRfdG/ee1qz5GJsFI7By3vnsT3JwP0/2SJHzldoDZ0JyFlsp+NpxhKbore3FBrbBjDI5/h37PKINkwMj9apgw+pIwLy1vBkHMnmpVT3ZW7qtXfnxOsyVDdvQbsZUX0Uh+0rGEmGrtC9wDARVfXyQpAH1rnqVsSkMMoa7GygjiuI/vD8PUWGwIWfpnBBWU0aMEXbUKj7m82d24aNWf99Re3J8BoVLnqf+U/k0D7hcQZPaICaci3s7mloLGoc10VXY0hpt05GuJ/9zrwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DedZRVJ7oajOkKn+sg2W6ez4QIO48/KbCtCea5HbhFU=;
 b=UyzwYUtxNQf1EyBKtMs3PTY35miQjq5rk2Q3r8McZLrw3JtaHciGO1aYoDabVWnQbuKs0hcupi/zsynySGIgoFmy9AimXQCd4/g2oEX5TgZ1zgvKUGJnL8ow3OSBWxILK3lNvqUoNR57CPud56hBj7QJYkBDRjOqulWAw/b3Yro=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PAXPR04MB8752.eurprd04.prod.outlook.com (2603:10a6:102:20e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Wed, 15 Mar
 2023 13:37:44 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3079:f55a:740e:c103]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3079:f55a:740e:c103%9]) with mapi id 15.20.6178.029; Wed, 15 Mar 2023
 13:37:44 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] tty: serdev: serdev-ttyport: add devt for ctrl->dev
Thread-Topic: [PATCH] tty: serdev: serdev-ttyport: add devt for ctrl->dev
Thread-Index: AQHZVyzjNbgw/TJEikSSFujd8MFQaK77rx4AgAAkpxA=
Date:   Wed, 15 Mar 2023 13:37:44 +0000
Message-ID: <AS8PR04MB84040E622C467609935FF2E192BF9@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20230315105400.23426-1-sherry.sun@nxp.com>
 <ZBGnniL7x5ENju6H@kroah.com>
In-Reply-To: <ZBGnniL7x5ENju6H@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|PAXPR04MB8752:EE_
x-ms-office365-filtering-correlation-id: 08e13327-aad1-4b44-a5d7-08db255a74ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6AJHOJ5S67ndJ1rPI0wyDswv8mFXfSYoC/K0vaae19WucnMWRNRPgDKNdiCPx0ZIoq+R3SNaNi4p0T/vA2SskX+gWUdiZwpdGd6nQeVLIacqyFXuuzsbn5v9qYamoZjgXNslsJ9EvOqXJNxdZo0fSppzmlYyavMAApCT3Wy618SJ91KG9TELRRtXXY6rTJSSp60vZDPgZXzx7GghuWVbo4CJa9XNqHSFD4XCkPy8JMjxzmHxYrOp/GRGLlwLUBdDJndUgGyaXb6TPNfpz3sVJNZ/SFNf5TQoBZqxiMguNEGizp7MzBlZv22XEwbgIymN2K9HEAop5NC25YaCOlwFdQIwYUeEiSLpD+qpZUTW/faAXP7H7YIeRq20bR3ZQv5ydpkzjjoxZKZy3NRJGCDEoNHsLX68IrU5V7zfD9I4VPEBrzN3jj0LYBJm/bkyh/IhsGSks35u17D7V5gQJIxZz+vLivzbWU5xx7Roki6GeKVkoOrw9hiIv9WGyZjsBds44D9czO8ZCWoUE4uGja+u92Xb85n5i2gzXyjZEVyCbm7N+0CXs0H0xQykhW3TrA16ytru1iQ0ylw1oJ26h8LbFQNw7g0by0lfZbCp8HEdU9/Um40UFptWWZtTYJIlTM/p/ixmUJFRgqd8dF91vlzsXJagfgBpXeufocr/yrIgmgQuIFtqNSsyV7bumjjOPOfW9UJ/7Zaa/p0nihnwnK5eSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199018)(38070700005)(86362001)(33656002)(38100700002)(122000001)(2906002)(52536014)(41300700001)(5660300002)(8936002)(55016003)(4326008)(26005)(186003)(53546011)(6506007)(9686003)(83380400001)(316002)(54906003)(66446008)(76116006)(8676002)(66476007)(66946007)(6916009)(44832011)(478600001)(7696005)(71200400001)(66556008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Vk9uNjJFSjFxcWs3ejNlNm11WkpxOWRHUjRYUFRmSUNUdi9TeFdWVXhwc29N?=
 =?gb2312?B?cTJjSU5YZTBPNkRyc0NxQ25RQjJNY1ZUQTd3eHBhTVhMTVdkUlNpSVREaWR1?=
 =?gb2312?B?OWYrbEtCL2tOQ0RPWG9SODJwTFJqZFRCcDc3aENOMlFKUzhuMmlZbmQ2RXQx?=
 =?gb2312?B?ZnZLZEJjSm5FbElhald0U2ZYKysrQzZWZVdCOUJOMWJsYjFJZiszcGZlR1B2?=
 =?gb2312?B?UXZobHFDUW9xS0ZocG9NYTkvcnhIYWIxYzhDSUg1ZkVtaUd6MVVSZTREMUw4?=
 =?gb2312?B?V3hMNUcwVUxlQ1ViOWtFOGdLVVcwdWcyNU41b3F5dDdTakFYbWE3dFZqTEE2?=
 =?gb2312?B?Qlpidk03Si9zTjAyRUNSZEdlejNBQTUvNWExZHlkUUUvMG55am1hZEhrU0NZ?=
 =?gb2312?B?b0NXQmtMZER5Y0xmRjkyUWk5Wk1GZi8vZmhyazY2NzI0RFJwaHlxRE1JN1Uy?=
 =?gb2312?B?bXBubTE5T3E1TWI1UXJic3k0dSt0NTliZzZKUVlId0RkYWRRUm0yalJUcGIx?=
 =?gb2312?B?MzB1UG15NVFlbnNENGZURG8wWU9maDk3NysyUUlaYUI1ZGpoZkUvcDVvTHZP?=
 =?gb2312?B?LzFHNzBIN0grMnlTOGhSbktNVW5QbU5SZWVXN1JqZG5KbXh3U1pvTGMwNUI4?=
 =?gb2312?B?Y1gvUTJLWUlBeUJUNVB2NG4yQ0xBcWNha2dLek1nNnlZUmNmOGVPYVVSSEo3?=
 =?gb2312?B?VGd4WnRCTmZ1V3I4R2dlblRBVnlBYXg0eE1NMm96MTlWVG5OTVk3aHdkYmdt?=
 =?gb2312?B?dHVjbEJ3TEF1WXpnRytLbHFlZ3phTUFucUhhSklPR0hyNUwvejFtYmd6aURU?=
 =?gb2312?B?d3JzQi9GM0FqVzhvSHFGejVJQU9hK1RIQVp3UGZzUFdKbWxFMmYyV3hyank3?=
 =?gb2312?B?UjkwRFF3TGU2MFpuanJrMVA3OHRwRXY1cG1GVjc5alRmWUV4TVl2b2dzQnZu?=
 =?gb2312?B?bnVWcjc4OUgxTlRQb2l2M2JZTXRzOGhITjcrci9jWWZWRDZqb3RtaDEwanlp?=
 =?gb2312?B?eDFISnQwaFVQWjRYZ3lBaHh2UnNpdmh0U25pdVhEdVlUa3NnclZ3NlR4N2VH?=
 =?gb2312?B?eUUxWDBLVUFXT2xhUXptNCtzVzBzY1BiTHA5cTR4eE9ueEptZkpYY3FtT0Vj?=
 =?gb2312?B?ZUJ4QWR3Y2wxOGpHRFRFbzB4RG1URmpPY2UwNzJpL01sRUFPdjhCbWpkSi9B?=
 =?gb2312?B?VzZjMEd5NW0xdGV5cE5DQVJhYWxzeG9jZTd4VzlHcjl1OGprdURjWFFYRjF1?=
 =?gb2312?B?Wjd3Q2FMVHZpWEsrQ1hXU3JLMGVuaTlSWlVkd3E2bEVVUkNON2NWcG13UGVl?=
 =?gb2312?B?V2d1WjluT0xRV21BWVplQ0ZJaU5jTk9aOE52bnVGell3NU9wWmZHbkhxVmp4?=
 =?gb2312?B?SUsyc3BSOVhKeHBjUllqYVQ4REdQTVZqWklhUGxtajliQlFpQUs2VG9ScVhB?=
 =?gb2312?B?dzc2Nldvdkh6eGQzK0QrclJLTjVUeDJuVy9IQk04VlY4MmdzNmk2OFpMZlZp?=
 =?gb2312?B?Vjg1bWNtaXA1c3J5blVUdUFqcWYxUytEWVU0ekFSbFArYjJEZWdQbVQ0QXpP?=
 =?gb2312?B?Z1pWVmo4cjRHRWpmcWdJMjU3U2ROZEN6UHBMV3BseFRwVzBSRkkwUlV2bFhk?=
 =?gb2312?B?Mjg4eDVxRVFkV0h6QmpZalN6Wm10K2MxU2pDZU9PRVNoV2oyaFltRFdzc2Jo?=
 =?gb2312?B?dFBuOGtpempvUGtIOGIwaTg0eDBlcEpqZ2Y1MHQ5dFZuY2VUTWJTK21DeDRY?=
 =?gb2312?B?WVMzN1Z0eWhqQmlWTFdXQ2hGU0hhT3M0QzBxZGpCaklTUThoNUxuNGwvdjNF?=
 =?gb2312?B?S2NBMmlPYmFIUlh1QW1nd1VFdnhmYlV2UDJuTU9PckZmb3dnbTJlU0w2TFZR?=
 =?gb2312?B?M3pyVDBUd3lUeXpHTk9vL1lrUlk4cGNiTmZMWUp1UVFPL0lkTHF3d04yR1F3?=
 =?gb2312?B?aUsrbFBmTUlnWWtLWmxXWW5yNWJSRFVleTZJK29hUklZV2QwNFJsU0JwanNr?=
 =?gb2312?B?Q1YrM2tkL21sbDdrM2kyQWtJQkE5VXNjRWFLSGQ0QThJN2JJSmwwV24xUjNv?=
 =?gb2312?B?WVZtelRoUVFNRVJzdkd6ditXazFGcWZIb3BJUWtqbWJselN4emxoZ3F6aTk5?=
 =?gb2312?Q?XMh4=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e13327-aad1-4b44-a5d7-08db255a74ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 13:37:44.1604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +IgYLy7c2FfrRzWVit7BK4Ow/lEB4eXfSAPR06Sqk02R6qvdlXcVyMYEYpWQU0FuIzPyvjGWarcq22Y+tCwSFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8752
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,T_SPF_PERMERROR,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3JlZyBLSCA8Z3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+IFNlbnQ6IDIwMjPE6jPUwjE1yNUgMTk6MTANCj4gVG86
IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT4NCj4gQ2M6IGppcmlzbGFieUBrZXJuZWwu
b3JnOyByb2JoQGtlcm5lbC5vcmc7IGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHR0eTogc2VyZGV2OiBzZXJkZXYtdHR5cG9ydDog
YWRkIGRldnQgZm9yIGN0cmwtPmRldg0KPiANCj4gT24gV2VkLCBNYXIgMTUsIDIwMjMgYXQgMDY6
NTQ6MDBQTSArMDgwMCwgU2hlcnJ5IFN1biB3cm90ZToNCj4gPiBGb3Igc2VyZGV2IGZyYW1ld29y
aywgdGhlIHNlcmRldl9jb250cm9sbGVyIGRldmljZSBpcyB0aGUgdHR5IGRldmljZSwNCj4gPiB3
aGljaCBpcyBhbHNvIHRoZSBjaGlsZCBkZXZpY2Ugb2YgdGhlIHVhcnRfcG9ydCBkZXZpY2UuIElm
IHdlIGRvbid0DQo+ID4gc2V0IGRldnQgcHJvcGVydHkgZm9yIGN0cmwtPmRldiwgZGV2aWNlX2Zp
bmRfY2hpbGQodXBvcnQtPmRldiwgLi4uKQ0KPiA+IG1heSBhbHdheXMgcmV0dXJuIE5VTEwgaW4g
dWFydF9zdXNwZW5kX3BvcnQoKSBmdW5jdGlvbiwgd2hpY2ggcHJldmVudHMNCj4gPiB1cyBmcm9t
IHByb3Blcmx5IGhhbmRsaW5nIHVhcnQgcG9ydCBzdXNwZW5kLCBzbyBmaXggaXQgaGVyZS4NCj4g
Pg0KPiA+IEZpeGVzOiBiZWQzNWM2ZGZhNmEgKCJzZXJkZXY6IGFkZCBhIHR0eSBwb3J0IGNvbnRy
b2xsZXIgZHJpdmVyIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGVycnkgU3VuIDxzaGVycnkuc3Vu
QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvdHR5L3NlcmRldi9zZXJkZXYtdHR5cG9y
dC5jIHwgMiArKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyZGV2L3NlcmRldi10dHlwb3J0LmMNCj4gPiBi
L2RyaXZlcnMvdHR5L3NlcmRldi9zZXJkZXYtdHR5cG9ydC5jDQo+ID4gaW5kZXggYmJhMzdhYjkw
MjE1Li5jNThhZjgxNDEzODAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy90dHkvc2VyZGV2L3Nl
cmRldi10dHlwb3J0LmMNCj4gPiArKysgYi9kcml2ZXJzL3R0eS9zZXJkZXYvc2VyZGV2LXR0eXBv
cnQuYw0KPiA+IEBAIC0yNjgsNiArMjY4LDcgQEAgc3RydWN0IGRldmljZSAqc2VyZGV2X3R0eV9w
b3J0X3JlZ2lzdGVyKHN0cnVjdA0KPiA+IHR0eV9wb3J0ICpwb3J0LCAgew0KPiA+ICAJc3RydWN0
IHNlcmRldl9jb250cm9sbGVyICpjdHJsOw0KPiA+ICAJc3RydWN0IHNlcnBvcnQgKnNlcnBvcnQ7
DQo+ID4gKwlkZXZfdCBkZXZ0ID0gTUtERVYoZHJ2LT5tYWpvciwgZHJ2LT5taW5vcl9zdGFydCkg
KyBpZHg7DQo+ID4gIAlpbnQgcmV0Ow0KPiA+DQo+ID4gIAlpZiAoIXBvcnQgfHwgIWRydiB8fCAh
cGFyZW50KQ0KPiA+IEBAIC0yODIsNiArMjgzLDcgQEAgc3RydWN0IGRldmljZSAqc2VyZGV2X3R0
eV9wb3J0X3JlZ2lzdGVyKHN0cnVjdA0KPiB0dHlfcG9ydCAqcG9ydCwNCj4gPiAgCXNlcnBvcnQt
PnR0eV9pZHggPSBpZHg7DQo+ID4gIAlzZXJwb3J0LT50dHlfZHJ2ID0gZHJ2Ow0KPiA+DQo+ID4g
KwljdHJsLT5kZXYuZGV2dCA9IGRldnQ7DQo+IA0KPiBUaGlzIGZlZWxzIHdyb25nIGFzIHlvdSBj
YW4ndCBqdXN0IGNyZWF0ZSBhIG1hZ2ljIGRldl90IG91dCBvZiBubyB3aGVyZSBhbmQNCj4gZXhw
ZWN0IGl0IHRvIGJlIGhhbmRsZWQgcHJvcGVybHkuICBXaGVyZSBub3cgaXMgdGhpcyBkZXZfdCBl
eHBvc2VkPw0KPiANCkhpIEdyZWcsDQpOb3cgZGV2X3QgaXMgdGhlIGtleSBwb2ludCB0byBnZXQg
dGhlIHR0eS0+ZGV2IGluIHVhcnRfc3VzcGVuZF9wb3J0KCkvdWFydF9yZXN1bWVfcG9ydCgpIGFu
ZCBhbGxvY190dHlfc3RydWN0KCksIGl0IGlzIHNldCBpbiB0dHlfcmVnaXN0ZXJfZGV2aWNlX2F0
dHIoKSBidXQgbm90IGluIHNlcmRldl90dHlfcG9ydF9yZWdpc3RlcigpLg0KDQpUbyBiZSBmcmFu
aywgSSBhbSBhbHNvIG5vdCBzdXJlIGlmIHRoaXMgaXMgdGhlIHJpZ2h0IHdheSB0byBmaXggdGhl
IGlzc3VlLCBtYXliZSB3ZSBjYW4gaGF2ZSBtb3JlIGRpc2N1c3Npb24gaGVyZSByZWdhcmRpbmcg
aG93IHRvIGdldCB0aGUgY29ycmVjdCB0dHlfZGV2IGluIHVhcnRfc3VzcGVuZF9wb3J0KCkuDQpB
dCBsZWFzdCB3aXRoIHRoZSBjb2RlIGxvZ2ljIGluIHNlcmRldiBmcmFtZXdvcmsgd2UgYXJlIHVz
aW5nIG5vdywgd2Ugd2lsbCBhbHdheXMgZ2V0IE5VTEwgdHR5X2RldiBmcm9tIGRldmljZV9maW5k
X2NoaWxkKCkuIEkgYmVsaWV2ZSB0aGlzIGlzIG5vdCB3aGF0IHdlIHdhbnQgaGVyZS4NCg0Kc3Rh
dGljIGludCBzZXJpYWxfbWF0Y2hfcG9ydChzdHJ1Y3QgZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEp
DQp7DQogICAgc3RydWN0IHVhcnRfbWF0Y2ggKm1hdGNoID0gZGF0YTsNCiAgICBzdHJ1Y3QgdHR5
X2RyaXZlciAqdHR5X2RydiA9IG1hdGNoLT5kcml2ZXItPnR0eV9kcml2ZXI7DQogICAgZGV2X3Qg
ZGV2dCA9IE1LREVWKHR0eV9kcnYtPm1ham9yLCB0dHlfZHJ2LT5taW5vcl9zdGFydCkgKw0KICAg
ICAgICBtYXRjaC0+cG9ydC0+bGluZTsNCg0KICAgIHJldHVybiBkZXYtPmRldnQgPT0gZGV2dDsg
LyogQWN0dWFsbHksIG9ubHkgb25lIHR0eSBwZXIgcG9ydCAqLw0KfQ0KaW50IHVhcnRfc3VzcGVu
ZF9wb3J0KHN0cnVjdCB1YXJ0X2RyaXZlciAqZHJ2LCBzdHJ1Y3QgdWFydF9wb3J0ICp1cG9ydCkN
CnsNCiAgICBzdHJ1Y3QgdWFydF9zdGF0ZSAqc3RhdGUgPSBkcnYtPnN0YXRlICsgdXBvcnQtPmxp
bmU7DQogICAgc3RydWN0IHR0eV9wb3J0ICpwb3J0ID0gJnN0YXRlLT5wb3J0Ow0KICAgIHN0cnVj
dCBkZXZpY2UgKnR0eV9kZXY7DQogICAgc3RydWN0IHVhcnRfbWF0Y2ggbWF0Y2ggPSB7dXBvcnQs
IGRydn07DQoNCiAgICBtdXRleF9sb2NrKCZwb3J0LT5tdXRleCk7DQoNCiAgICB0dHlfZGV2ID0g
ZGV2aWNlX2ZpbmRfY2hpbGQodXBvcnQtPmRldiwgJm1hdGNoLCBzZXJpYWxfbWF0Y2hfcG9ydCk7
DQogICAgaWYgKHVwb3J0LT5saW5lID09IDIpDQogICAgaWYgKHR0eV9kZXYgJiYgZGV2aWNlX21h
eV93YWtldXAodHR5X2RldikpIHsNCiAgICAgICAgZW5hYmxlX2lycV93YWtlKHVwb3J0LT5pcnEp
Ow0KICAgICAgICBwdXRfZGV2aWNlKHR0eV9kZXYpOw0KICAgICAgICBtdXRleF91bmxvY2soJnBv
cnQtPm11dGV4KTsNCiAgICAgICAgcmV0dXJuIDA7DQogICAgfQ0KICAgIHB1dF9kZXZpY2UodHR5
X2Rldik7DQouLi4NCg0KQmVzdCBSZWdhcmRzDQpTaGVycnkNCg0KDQo+IFNvbWV0aGluZyBlbHNl
IGZlZWxzIHdyb25nIGhlcmUsIHNvcnJ5LCBJIGRvIG5vdCB0aGluayB0aGlzIGlzIGNvcnJlY3Qu
DQo+IA0KPiB0aGFua3MsDQo+IA0KPiBncmVnIGstaA0K
