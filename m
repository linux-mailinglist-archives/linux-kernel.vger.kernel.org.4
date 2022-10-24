Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0402609B43
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiJXHYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiJXHYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:24:38 -0400
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2130.outbound.protection.outlook.com [40.107.127.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9375F61;
        Mon, 24 Oct 2022 00:24:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrEqI9qnEczhjbOcDFuG1QwGBGwdNw6ndkJU2FfoM8Yf7o2O11y78VIRrlSvxlflnfqDqKsrHoY4d+bNZhyqjonS7rXO6hvw+rGeplAZqqTeUd335zZkMxbsFHErk0iXaU8/nbS73o9FJfpNbea4HoLjb8xwNVlq+qfbOcNnpOG517YADH+OBqX/Xqb8tfuyhFjbixQYCzDJBIAxLU/iuAQ12t+10px1PEM9ODmgMlwFHMPXdGukJvB6xduCG03B630QfjwezTqi1f/Eqv8NMWk5lewDiX8+qlX9SZYv+5jq/OYd7wCwh/dgoecepulqhESGhNZX2uWGwWPpBXPEDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpqbU3Vdovc7iycJv82qjhn7selhDFn4qJEJwt4YgVE=;
 b=m18gvuyqzWBehzKhhCGsq2UScoH9JtBWvtApRsjzysmcYp1+GJgCRzrNBA9fU7dQ71D4Gm8cdwdxID60uW33ccL0azQvTH6XzThQtcSIqkVj73J64uxjwfckKCvQSNyYhYGqHXVaiyiMGfUmGsGuT0sT8Tt9NBYGpP6d+I2uEoSNNpyfiBEPPJjog1BNy3uUB7e7XUxG9mdzvpvMC0HhbFZOWVWmvmEKPfI0v2GUDLqY2xV+Lkcb+SrwBCYP5YZtTXM0YUqlfEb0J8RtzKRAO5HLVM3FzG/oWVMk9LjCNog52t2NMFfH0tBP+m9kfG1PioeZi2ERqse0zXXmrtuJKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpqbU3Vdovc7iycJv82qjhn7selhDFn4qJEJwt4YgVE=;
 b=tuO0TQ/8Xe5T8x+/tPWHQQnPbgp3BwZFj6j7lGgmtOeENz/ZOAPgNdVeEonH6n9C4rjhuM2X8LhFHR7L0aJooORJ3KyYEWDsjN0G49OkKZ9S+PcujR73IBN1CBFVvZ+oFWZgVwE0FqR+Hg72uRkf3lMpYQK7+QkKQoEJseLAkKw=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by FR2P281MB1638.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:8d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Mon, 24 Oct
 2022 07:24:21 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::adc3:ee78:7f30:722]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::adc3:ee78:7f30:722%4]) with mapi id 15.20.5746.023; Mon, 24 Oct 2022
 07:24:21 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Joe Perches <joe@perches.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] MAINTAINERS: Add KX022A maintainer entry
Thread-Topic: [PATCH v4 3/3] MAINTAINERS: Add KX022A maintainer entry
Thread-Index: AQHY5T+Ki+hRTsI0rUKVheWiu5nxcK4dH/IAgAAI0gA=
Date:   Mon, 24 Oct 2022 07:24:21 +0000
Message-ID: <0c1471c0-b6b0-7b2b-62af-d3221edeeac4@fi.rohmeurope.com>
References: <cover.1666350457.git.mazziesaccount@gmail.com>
 <db45c0ee76c3205b9253cb2200a79119c2f2b946.1666350457.git.mazziesaccount@gmail.com>
 <92c3f72e60bc99bf4a21da259b4d78c1bdca447d.camel@perches.com>
In-Reply-To: <92c3f72e60bc99bf4a21da259b4d78c1bdca447d.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2454:EE_|FR2P281MB1638:EE_
x-ms-office365-filtering-correlation-id: 23255229-4807-42f8-f07f-08dab590c50f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KWE6w4S70+Kl80gSarCLSpTpb56cELfT3sYr/WbkiCWyyYsSbdRdh0SAbK78R/cvrTrVVE9kU5kk4gT+7Wc0bHt+T20blYq0OE27JHbZbelu1v1vMqHyW1dYKutFqL9HU6uXlIBBOcrQfxyGMCYu9YAi1sT0LPbSx/omz3AQzAn8n0G8XGY94Wd3NakbVcHysh85bqUEKU9nf4gbY03wjTj/nZvCPdsQpj/R6mrtu0MeA/6OS0tESQ0EGQnxRmQHq0IcNbrgsNdfCVQZW+UJe9CMQNdGqr0XGjBTLEc5g8+kauyp4O5Xko9zHKJF9GfiVfxpehxn1RVEB0Kdhui8A8nRW+okVTLDCnpztm1BPOPFmm5S6rhWlf4dTkWGtB9OhjEX91QtisWlRVUa/bLbgExK/MPiGW9oJyVRqHdKjQvdjjAvVb3t84IS4AL96ZyPNur5yYOttt6V2KXnHX+/CVSg5PIflCTGqARluENN9LaTlRWiOvWaFLSWOyUOY1ye7EOLy7f9IaZXheyigHVQW6lvhr+xuLN7DAE5A0GwwGOrdmKiureapC5SkTH9h9YS87NtJ8DphjUpvI6Q012YTlHR5dok3Z7CowmkYksAohFFQYlQ3kjL0Ru0GlN+1buI+iBB2UzNGc2cZGNQrpfcIZ5eivdZhX4jU+IvflgplBkBxFWFLGobqhiXLtyuhbT6ZB6FyUvXylfNS0UmUg33+XAH88Iz7vwHVTx5gnV6X1WcEtVXfv8RhoZmnbg65HYn7JqeGyT1BQpiLM4E0/47vLNdtHfuBTLHomOuRXkmMQB034nD+zr9GC+mlb83ePHghj0xqAH0SFVv5xJkTgz/WECdzViIThYVw9US8EjC0eA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(39830400003)(396003)(346002)(451199015)(5660300002)(7416002)(38070700005)(41300700001)(66556008)(66476007)(8936002)(64756008)(86362001)(2906002)(31696002)(4001150100001)(2616005)(186003)(66446008)(966005)(6486002)(71200400001)(478600001)(6506007)(53546011)(6512007)(4326008)(76116006)(122000001)(38100700002)(91956017)(8676002)(45080400002)(66946007)(110136005)(54906003)(316002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkIzbUs3SlNubmQwRW5ud3JUVE9jeG5xOHhNU0VrOXB4L0Nka25sNGNMNE9l?=
 =?utf-8?B?bkRKYnpWeDhTMCtLK1ZzZm5CdnBaUmsyd2gycVdqQnZ4cG5vbkN5bU0zcVFP?=
 =?utf-8?B?SFkram9XdCt6NzU1L2xRbXRjMEwvT2ZvUXQzODNXS2svektQVGoyUmRrVzlN?=
 =?utf-8?B?THhPcnIwd1VtOUZGRUZDUU12TkFRWkdMWTc0b29rK3NMTjV2amk5V3gxVlRs?=
 =?utf-8?B?SUFBL1hOOUJIbTUwdmVmeVZxMCs0U09UWlo4dS9HbUtBQ3Nzck51QXc3d2Fz?=
 =?utf-8?B?WERvZmF5d3NCR29iN1UxSUJ5SnFXbGRsNEZXa3BpRE5VOThOd2tlYVVsSUpW?=
 =?utf-8?B?OTU2YVVNNjFZUy9mVStXVWtsajNIU2c2aVFoaWVOQnpwYUpaWGN5ejMzQ25U?=
 =?utf-8?B?TjR5MmRjbnU4Nkp4bHluRVprNTMrNjg5U3JrOWkrL0FWc1VWWDY2VlcrSEdV?=
 =?utf-8?B?SS9iN1pTZ3JCcVFRekEyRTFvRnZ4MHViNHdjZ3RqZXZXNlg4WHFMOUFKcURP?=
 =?utf-8?B?cjg3MkdwaytPL1JYNlBoc3hKa216V3VSL21JR3gvaEpBZm9laU5IS0ErS3pM?=
 =?utf-8?B?UWliUHF2aVRlRjUzTldMNGdpVGlMS2F0ekh0RUh6Q2l4akN6dmlGTVNxMUlG?=
 =?utf-8?B?WjEvWllsYXpocGdEQlEzRTN1c1NQbmRSMU40amc0RzMyVXovTFcwOVFCUVUx?=
 =?utf-8?B?bDAyUk1YUDcvc2xKYS9HNjFMcnhHZnFjbVRiYUFzclZ1V1ZJWWJtdGlFQW91?=
 =?utf-8?B?K0UxVm5hN3UwTFdIS3p2R2tJZVVzVFkwb3h4TDk0blZod1dYTDdWN3RSZ25G?=
 =?utf-8?B?dW1pamVWRDNEOXpucy9GR09ySmxqYkc2c2xydFFaTHgwbCtZTlFuaUFQamZl?=
 =?utf-8?B?VnY4REdFQmdlRnZKR3BqRStJbVl4Q1QvVitZRVc3OWlkeDVoblBhZGd3OGgw?=
 =?utf-8?B?Wm1tUjFKaHBybVpPWHd4anh6dmxBZ1VpL0dpd0R6ZHY0b3RxWXllTFZObmpa?=
 =?utf-8?B?dnhuWExGT3Q2T2hvN2IzcldYbGk0V0Zsb1h0ZCs0UjNvMU92UW1jNDREZ0Ra?=
 =?utf-8?B?S2gyajFxZFNTM3U4Ty9oWHpzcWJGNkhhd3NhWkRob1hQVWpFdTNUZEthODRN?=
 =?utf-8?B?WVRKanBYV2RFOW1SMVFlNzFXUVR4eXBIQlQ5cHJ4OFNzbkFjSUZ3R1A2MUxn?=
 =?utf-8?B?ejFGdWFEUVRlNUpRcEFTRzB1VHFQSHY4WTZVTFMyc3ZNMU9Malk0SVp0QUpH?=
 =?utf-8?B?bXFzSkZSVUQzMFlVUkdQbG9YekNDYUJYQmpobHZZeGU2VDNpSHpyV1huZnlM?=
 =?utf-8?B?WmYwZXBTRElQVHRVWDVONi90SGdCWWY0QlVLQWJRdDVOMHZpUkM5Q1Z2a0Q1?=
 =?utf-8?B?Y2svaUVtenZHNDZ5YmVPRG4weEJjamY4SGdMSTkvNklmN0s1WnpESEpPUXlZ?=
 =?utf-8?B?Zk8yTEZRN296VS9zNytmaUJhNDlDL2RqUjhHQVEyRXZ5Qm80ZzIyYVErc1Rn?=
 =?utf-8?B?MExEYlh1bVJGZ0VVRU54NkdGOFp4N1dKTFVPd1R6Ulh2anJlZ1BCbEdjaGM3?=
 =?utf-8?B?Vm10WTFTNEZaWWRPOE5OS3FvdUprT3pTMDdYd3NhWVlDaTNLamRDM2pQcnRk?=
 =?utf-8?B?WGxQNEg0c25KNW1WUVJoVlovbDBDTW5PamdlVUNDTDFuS2JYY1h0OHQwN2Ru?=
 =?utf-8?B?V0hQNWtpMjMrR0p2TFBqZ1Roek52K0lRN0tWdS9wWGVlUllnRlB1a3VBZjln?=
 =?utf-8?B?Ykc1VTFnbk1TVGk4WXNnZTZMUTBLUTJSY2VPcnREZ3BWUlR5K21zVlNxOGhY?=
 =?utf-8?B?MXFzWWZpOVorU2Q0N3JWVGxwN2hzbS94ZFhIV0lVTUd3R1Z3dGQ4MTgyck94?=
 =?utf-8?B?bnFXNkpJUmNtV29BQzFJRWtwNFNUWVlmSnA2K0dneHZkRDdLM25ydDA0KzdL?=
 =?utf-8?B?Q2dYNkYrbWVxNGpIa1UreE9xZG1HOVArNXFjUlFOcVU3NlVja3hOdGxYN0wz?=
 =?utf-8?B?bGw5MFl1TGFMaWx3blozZkdrMTJ1SmJWc214aHhXbjB6RjV3dmFnczRTRzdX?=
 =?utf-8?B?d3JXZlB2UWtDQ2s0NHJyUzNGQzdncHd5OVZtcHNnREl1b3VlT1BaM01nWlRi?=
 =?utf-8?B?UlRWVUJ2cHpzWGV6dHZmVUtPb0M5ZDVETjVyVnhkTEdodXdvR21pMFhnbWRE?=
 =?utf-8?Q?uGXA1aoCTSQlKxrz1bAFuEs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <90B838228847514DB98E1ED25459BE59@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 23255229-4807-42f8-f07f-08dab590c50f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 07:24:21.2108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S3XLe3r17WBbK8fb3912BqHsNx+rKwEm9KGnhdVqgA209HYTlC5eR6CMvbU/TN/t1/+UZr5+c7kL+Iawuxwt7CuRGZu+d+TxkzHrvL2sn5/rXbLn2z4ZcysWbL8bIhx/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB1638
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9lLA0KDQpPbiAxMC8yNC8yMiAwOTo1MiwgSm9lIFBlcmNoZXMgd3JvdGU6DQo+IE9uIEZy
aSwgMjAyMi0xMC0yMSBhdCAxNDoyMyArMDMwMCwgTWF0dGkgVmFpdHRpbmVuIHdyb3RlOg0KPj4g
QWRkIG1haW50YWluZXIgZW50cnkgZm9yIFJPSE0vS2lvbml4IEtYMDIyQSBhY2NlbGVyb21ldGVy
IHNlbnNvciBkcml2ZXIuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTWF0dGkgVmFpdHRpbmVuIDxt
YXp6aWVzYWNjb3VudEBnbWFpbC5jb20+DQo+PiAtLS0NCj4+ICAgTUFJTlRBSU5FUlMgfCA1ICsr
KysrDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0t
Z2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0KPj4gaW5kZXggY2YwZjE4NTAyMzcyLi4z
YWI5YzVmOTdkZmUgMTAwNjQ0DQo+PiAtLS0gYS9NQUlOVEFJTkVSUw0KPj4gKysrIGIvTUFJTlRB
SU5FUlMNCj4+IEBAIC0xMTQzNSw2ICsxMTQzNSwxMSBAQCBGOglkcml2ZXJzL21mZC9raGFkYXMt
bWN1LmMNCj4+ICAgRjoJaW5jbHVkZS9saW51eC9tZmQva2hhZGFzLW1jdS5oDQo+PiAgIEY6CWRy
aXZlcnMvdGhlcm1hbC9raGFkYXNfbWN1X2Zhbi5jDQo+PiAgIA0KPj4gK0tJT05JWC9ST0hNIEtY
MDIyQSBBQ0NFTEVST01FVEVSDQo+PiArUjoJTWF0dGkgVmFpdHRpbmVuIDxtYXp6aWVzYWNjb3Vu
dEBnbWFpbC5jb20+DQo+PiArUzoJU3VwcG9ydGVkDQo+PiArRjoJZHJpdmVycy9paW8vYWNjZWwv
a2lvbml4LWt4MDIyYSoNCj4gDQo+IEhvdyBpcyB0aGlzICJTOiBTdXBwb3J0ZWQiIHdpdGhvdXQg
YW4gTTogbWFpbnRhaW5lcj8NCg0KSSBhbSBjdXJyZW50bHkgcGFpZCB0byB3b3JrIHdpdGggdGhl
IEtpb25peC9ST0hNIHVwc3RyZWFtIGRyaXZlcnMuIEhlbmNlIA0KSSBhZGQgJ1M6JyB0byBvbmVz
IEkgYW0gbG9va2luZyBhZnRlci4NCg0KVGhlIGlkZW9sb2d5IHdoeSBJIGhhdmUgJ1InIGFuZCBu
b3QgJ00nIGlzIHN1bW1hcml6ZWQgYnkgbXkgZWFybGllciBwYXRjaDoNCg0KID4+IEkgY2FuIGFs
c28gYWRkIG15c2VsZiBhcyBhIG1haW50YWluZXIgaW5zdGVhZCBvZiBhIHJldmlld2VyIGlmIGl0
IGJldHRlcg0KID4+IHN1aXRzIGlpbyBtYWludGFpbmVyLiBJIGhvd2V2ZXIgZG9uJ3QgcGxhbiBz
ZXR0aW5nIHVwIG15IG93biBwdWJsaWMNCiA+PiByZXBvc2l0b3J5IGFuZCBob3BlIHRoZSBmdXJ0
aGVyIHBhdGNoZXMgd2lsbCBiZSBtZXJnZWQgdmlhIElJTyB0cmVlLg0KID4+DQogPj4gU28sIGFz
IEdlZXJ0IG9uY2UgZXhwbGFpbmVkIHRvIG1lIC0gSW4gdGhhdCBjYXNlIHRoZSBkaWZmZXJlbmNl
IGJldHdlZW4NCiA+PiBtZSBhcyBhIG1haW50YWluZXIgdnMuIGEgcmV2aWV3ZXIgd291bGQgYmUg
b25seSByZWFsbHkgcmVsZXZhbnQgdG8gdGhlDQogPj4gc3Vic3lzdGVtIChpbiB0aGlzIGNhc2Ug
SUlPKSBtYWludGFpbmVyLiBUaGUgc3Vic3lzdGVtIG1haW50YWluZXIgd2hvDQogPj4gbWVyZ2Vz
IHBhdGNoZXMgaXMgYWxsb3dlZCB0byB0YWtlIGluIGNoYW5nZXMgYWNrZWQgYnkgZG93bnN0cmVh
bQ0KID4+IG1haW50YWluZXIgdy9vIG9ibGlnYXRpb24gdG8gZG8gdGhvcm91Z2ggcmV2aWV3LiAo
RG93bnN0cmVhbSANCm1haW50YWluZXIgaXMNCiA+PiB0byBiZSBibGFtZWQgaWYgdGhpbmdzIGV4
cGxvZGUgOl0pLiBJZiBhY2sgaXMgZ2l2ZW4gYnkgYSByZXZpZXdlciwgdGhlbg0KID4+IHRoZSBz
dWJzeXN0ZW0gbWFpbnRhaW5lciBoYXMgdGhlIGZ1bGwgcmVzcG9uc2liaWxpdHkgYW5kIHNob3Vs
ZCBhbHdheXMNCiA+PiBkbyB0aGUgcmV2aWV3LiBPciAtIHRoaXMgaXMgaG93IEkgcmVtZW1iZXIg
b3VyIGRpc2N1c3Npb24gd2VudCAtIGZlZWwNCiA+PiBmcmVlIHRvIGNvcnJlY3QgbWUgaWYgSSBh
bSB3cm9uZyA6XSBJbiBhbnkgY2FzZSAtIHBsZWFzZSBsZXQgbWUga25vdyBpZg0KID4+IHlvdSdk
IHJhdGhlciBzZWUgTTogbm90IFI6IGluIGZyb250IG9mIG15IG5hbWUgZm9yIHRoZSBreDAyMmEu
DQoNClRoaXMgc2VlbWVkIHRvIGJlIGZpbmUgd2l0aCBKb25hdGhhbjoNCg0KaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzg3YWM5YTVlLWI1YmEtODJmMy1jMDBjLTc1ZDVlNmYwMTU5N0BnbWFp
bC5jb20vDQoNCkkndmUgYWxzbyB3cml0dGVuIGEgbG9uZ2VyIHZlcnNpb24gb2YgdGhpcyBpbiBh
biBMaW5rZWRJbiBhcnRpY2xlOg0KaHR0cHM6Ly93d3cubGlua2VkaW4uY29tL3B1bHNlL3Nob3Vs
ZC15b3UtbGludXgta2VybmVsLW1haW50YWluZXItbWF0dGktdmFpdHRpbmVuLw0KDQooSSBlbmpv
eSB3cml0aW5nIHNtYWxsIHN0b3JpZXMuIFNvIGRvaW5nIGFuIG9jY2FzaW9uYWwgc21hbGwgTGlu
a2VkSW4gDQphcnRpY2xlcyBvbiB3b3JraW5nIHdpdGggdGhlIHVwc3RyZWFtIGlzIGtpbmQgb2Yg
YW4gaG9iYnkgZm9yIG1lLikNCg0KQW55d2F5cywgSSBkb24ndCBzZWUgYSBjb250cmFkaWN0aW9u
IHdpdGggJ1MgKyBSJyBjb21wYXJlZCB0byAnUyArIE0nLiANCldlbGwsIHBsZWFzZSBlZHVjYXRl
IG1lIGlmIEkgYW0gd3JvbmcgOl0NCg0KWW91cnMNCgktLSBNYXR0aQ0KDQotLSANCk1hdHRpIFZh
aXR0aW5lbg0KTGludXgga2VybmVsIGRldmVsb3BlciBhdCBST0hNIFNlbWljb25kdWN0b3JzDQpP
dWx1IEZpbmxhbmQNCg0Kfn4gV2hlbiB0aGluZ3MgZ28gdXR0ZXJseSB3cm9uZyB2aW0gdXNlcnMg
Y2FuIGFsd2F5cyB0eXBlIDpoZWxwISB+fg0KDQo=
