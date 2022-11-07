Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1616D61EDDA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 09:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiKGIza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 03:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbiKGIzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 03:55:22 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2109.outbound.protection.outlook.com [40.107.114.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EFA15FEA;
        Mon,  7 Nov 2022 00:55:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcFFOqjMkJ+uwuGRz/fQL2L+qTbe4LpV7Q9UDS5Av9NcMObKzeSbGdtRqkqqVzK6t7eIcEYGtbsl1F5Ve4/9GrIVKzcmhnLHvcCDmRqFmBN2ryUloQ2J8yDDnR1f7FivVleHbp3/HLm+x+AD+m/Enq2GszoLPGmp6uGwq0vWV5wb5RM3tYILaZ6hzZ+EDqPESEEJyCtynlhX2A73OIfn8v8bIIPKDWI4F/LtMqTvVT512xVE5KxVfrPyMb6Wu61GqE/i7zQc/ZoCL2J2cZi2jADV7NAOE6ztC+E+3f0gTnOOIGen4A5QMEbmroYpVMa39EaggG3hN+nUastL4BgS8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onPSQxlfnyrEV6C+2KhXSY1u6JSR47c/euWC4W8Ybyc=;
 b=oXc050Wl2qHkpD1CLk+3AEnIjTXd5acn6fsW/MWoOUwJdLudtJmRhw0iERWrNXCgJi8BTT04pkndGkWMUrOmBWGvCvzi96aswrCi2xy78j9TvwuQ4SNtb6R5ZiXgLQbAqOE1zum6mwmcArH7w1kspenbrqc6tU0+KY2g08YIp/2QIJ4CDmcpuIGP6LR5bNDDk5HOoZBFCbfH3YGNXUipD3PKv5JzpSvDyX4qAdlGbjaIrl1CV5wgUNPqgpCpsZuDOY37r6Vh4WfvJ0k5kkhF9GtewQyhHBAihAk74ie3/TEVNrAlIaoTw/b79U/bxHhS8H5JHEFcwU/6fa8IE/FQ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onPSQxlfnyrEV6C+2KhXSY1u6JSR47c/euWC4W8Ybyc=;
 b=sxCnLBkx8fwPmthed+R/6nWrKfYkIyuDYkv8CcG2F/IofZa0kVQF0B1tjXc77eZWtv4j2k2Cnv+fP45xVBzDYEMY2jY9X/6hT9prcqEa1jfEHJh9cnSJy7aSEUTAurtW7+YHtA96VRQKXwEblya+/hl8GB3PCj+MR61WgSFejp8=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB6038.jpnprd01.prod.outlook.com (2603:1096:604:d9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 08:55:11 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 08:55:11 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Billy Tsai <billy_tsai@aspeedtech.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        "garnermic@meta.com" <garnermic@meta.com>
CC:     kernel test robot <lkp@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: RE: [v3 2/3] pwm: Add Aspeed ast2600 PWM support
Thread-Topic: [v3 2/3] pwm: Add Aspeed ast2600 PWM support
Thread-Index: AQHY7p7kl1T9YGA12UCEvmgRzmEVOa4ryCswgAdlwYCAAAAiYA==
Date:   Mon, 7 Nov 2022 08:55:11 +0000
Message-ID: <OS0PR01MB5922EC7AB73207DF30F42A0A863C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221102083601.10456-1-billy_tsai@aspeedtech.com>
 <20221102083601.10456-3-billy_tsai@aspeedtech.com>
 <OS0PR01MB5922014A7D74A884D2E7BDC286399@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <C7224BE1-D81E-4FE0-8B7C-5A3CA69898D2@aspeedtech.com>
In-Reply-To: <C7224BE1-D81E-4FE0-8B7C-5A3CA69898D2@aspeedtech.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB6038:EE_
x-ms-office365-filtering-correlation-id: bac88005-2379-4580-e8f1-08dac09dc76a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xGYA/S+qqPIBxWfVUqDoXAhzSFrfy/zIpTzmXh21OiQlSIPgOx2+WjcF+R5q7DHMCOTzLdGgdI8Mnu234B/9lKQ7meMnUgjwfoG+SnR4uBgNrpxHrPNTBaDLdpQSIn3QVtK9b3sD4hFYwXAyAP74d7rdRIjQn41QBDbcKVIdxUT1JiVur0br+0U7/LUkErRsbYdN3Wy9GD/zKqaJOaoiDCiADi6rFG7BNJ0Sph/9/2p2b4HWAeuZ3cYX+rX7+HB66ZB8aIb4c8/2cLglOiTOh7UBQS4T8pKO5IfNyLKZ5c00mzCv2O6qofsqsi8zSf39qBRdnQooPaw01+KidXmKgHuQLxB+okNA5z0z9VGYbdd4ftkMHJa1mWMkMW31O6ZHJ9tJhWlDFryP1pCKNwzPl+CjTQA3pK6cHi4riON6lbFZEXD/pW9Nrn6YnnT4+FvOXyTtNCaw13sK0fMcktxsdXRAx7HbA2xTxwn5oqI670+eZLVyrekrwAzJavRTPVZ9i02odT0Sf9NLLSIC5P4GSg8HJG+XqzWWVskc4ycxaMYlvxoa3FocJG2RUL47Urprv6RcBfMzqYj+WfVCdyw56PKg8T3Ij833nqT2N1Pgpr3/ir3vqVHHPpYCZeA7opaJtRZOP6h2KJFbK/F3B3r4M//WbC1sOxMSMEkYw16/4p1fl6I3RvjnESCA+ULwWKVcnjdK06m2jXJYj4rUFpe1wSPovK9SDqQ4HflBRm7ISaPk8Cvj8So09pYGjJfJXsdpchi6F97qr7Z0XRlFM5mWRnudVoyifuaVsQIFjFD5hAU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199015)(316002)(33656002)(5660300002)(54906003)(921005)(55016003)(110136005)(71200400001)(7416002)(83380400001)(38070700005)(478600001)(2906002)(4326008)(41300700001)(52536014)(8936002)(76116006)(66556008)(66476007)(66446008)(64756008)(66946007)(8676002)(53546011)(9686003)(186003)(38100700002)(26005)(122000001)(86362001)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWc0ZExLV1VhR3ZxTVlBeVphRzZBNFVuOHh4QnpqS2pDWExreXJGU2VKSzIv?=
 =?utf-8?B?cnluTTFGOVNPVnlYT1RYa3lsd3BIaklDSlNTSzlaMldsQVMydXhpeGlROGxh?=
 =?utf-8?B?bmtqTDJnU3RMaEdoditKb2JjR3hURWlnbHBkcFRpb2ZkQzlsNzVuRWZ3dnBQ?=
 =?utf-8?B?SXlDMXUxdTJQM0FCV0JSUTl3WnlHT3VlK3o0dVNzVXA1d0d1OG95bHVhd0tq?=
 =?utf-8?B?MEFtZnk3djcyQmJJVzdtbGJOS3NRSlRTajZHTUJMQ1ZqV2xtSUx2RmdrOXNU?=
 =?utf-8?B?Q3FSa1ZhVm1mMHMyQ1NjQ2ZpNmVRa1Y2VWpkNWR0c1BxL3RTN0E1dGRwcTlj?=
 =?utf-8?B?WlpEU09EUy9pdThpVnZPOVhxdkptcFN6NkwxTlAwY0sza095QVhFUjhaZjcy?=
 =?utf-8?B?L29RMk5TbW55YWdVQWdqdFg1VDlXQzJsMksrNmJseGlGNXpIM2JMZlptYkRm?=
 =?utf-8?B?V2pUZFRGUm5YSWhqSHJqNUFPSkZHWHpsMGtzeTMyWGVDYjFhSEU5SnhIeG9Q?=
 =?utf-8?B?M0ltVWRMMmtYQ3BPTWJCV3B2KzUyNVdyMnNnWURPdUV0cTV6Yk5LV0R1bWlL?=
 =?utf-8?B?Rm1VcEl5eThYT080anJWOVFOakQ1Mkw1VWZMT1pwcVkrcnYxNHdnK3NRR05I?=
 =?utf-8?B?OW14eThYM2ZCU2NnLytSd2E1czJzTS8zUGZwUTZwVWVObGhQc2dRVUxCTDhC?=
 =?utf-8?B?RFhiNHNlVytHbkZKQ21sSjdBQ1NXNDlRalQ0UStTVmtYSFBwV09RZCt4TXFs?=
 =?utf-8?B?UEtSaHNvTmlMRUdtbUtObmtmZk9STDNDR0hIVDBrODdVTEgwSEJ1SnRDclpj?=
 =?utf-8?B?aWE0NWl6emJ0aEtnSVFHdFFuREdwc2g4UkZwUjZZWXY0bXhHTVJQQ0xHbUFu?=
 =?utf-8?B?TGFqZzFPMG1UQkNVNG41bkxQaFI1cDE2bGFKOXh2Rno5NHo1WWhJVk5Kb3RE?=
 =?utf-8?B?bzdMSGFiUFlsNzBmRWY5T1UwT0dJNEN0QWhOTG13bXFsQnBmK2FHR0Z3ZDBZ?=
 =?utf-8?B?OUpIU3BKYjVhMCtjZXRiN1BCeW1ZVkd5Mzk1YjRYeFdYQi9jdTZ5d1lsN1lF?=
 =?utf-8?B?d3F6aEJaZTRmU3YySmNrUEc3cVYvdVFURjJ3NlYwUSthUjJtdHhIcmY2eGZN?=
 =?utf-8?B?aG5rVWcwVWVEai9tb0F6Z0hMTDVJUzFJbGd2dWFZbXYrSmt0bU5ITEZtZFVE?=
 =?utf-8?B?SW1sWldiUjNBemFyT1UwVWp6amFyanZ3RG9qbGlOQlBaMldLQ2ZsSWUvUWVz?=
 =?utf-8?B?QzlVNUdxbCtRb05LZkFHdmhRYlBSRHVKWVlidC9zRStObGRpVGpKbFh3NkNY?=
 =?utf-8?B?YWt4aWdLd1I0dkhsNnVGZWNTUWx4Y29aRHpRejdHeE5qU056dUlDeVBOR1RV?=
 =?utf-8?B?RW8zSjRhT2FCOGpoR05RcC9wakJyZnpEZDB6TU9tMnBXMFl1Q1lvSHQ5c1dO?=
 =?utf-8?B?MXdMcWcyMTNocDRid0R5Z0xXNVp2a3VPb2twbWN6WnBZNHZjSFhNOGtzckV3?=
 =?utf-8?B?eFRiYi9IM2Zrd0tIR21QZjZHek83cnhaTURMODVJby93SENjazJCejBKeHNC?=
 =?utf-8?B?Y29qemZTT0tyWDhWTDFieEhrZHlsVm5lNEVYWWhVWWIwV1ZXRzJwTDg0KzBy?=
 =?utf-8?B?NXFiRVdjSWcrbUt6dFJjRW9INU5sZEp6OXFjdnI1SHBmUTNsanF3VzhtaStD?=
 =?utf-8?B?ZXlYTWZValpxZHI3aGxDUE43WDU4bjdvV0hmWE5GQ3RYdE14aGNsVnp2MmZx?=
 =?utf-8?B?VGRaaFlFd3FWNWR4L2lmWE1vZ0tKOFdIWnhOVWNlNFc2L1BIT0lxNlpvV2k3?=
 =?utf-8?B?eFcrV1BuRWRObE11MVZVeGdaOHJ3TWQzYWRxTkdFc2pyZ3l4UGZ1M1JFd000?=
 =?utf-8?B?QWZIVWVVeXhTS0xMRVZ1bEI4cUgwcnZKQlhPUXFkU1FOODBvaG1KNnJGTk40?=
 =?utf-8?B?Ym5zY01SQnluejlYV1JMbVNLRHBoM0h5VitHSkVqWTFwYzBiU1BqaENhS25x?=
 =?utf-8?B?dmFWTi9Lb3VETGVJVHR2LzVtV3VUV0RyM05VUHhWOGlOK1FUcngxd05hbzNp?=
 =?utf-8?B?MnJTSFo5bUNER3Y2S0pDOWhXTjNPc2M2bUNpSlNTTEc0OFlrN2U3Y2dDL3ZL?=
 =?utf-8?B?elc5eW52cmhuazJ2bUJkVmJlcDArTWVzdFlPNmFwQzFEeFlSTXY3WnlFQjJ5?=
 =?utf-8?B?S1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac88005-2379-4580-e8f1-08dac09dc76a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 08:55:11.4104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V25z6brqmhGpknkmgJiAZ1/f6zAwk8+SCeY5iHXafTrri/vG7SjHuIfaf0x8eWVM5Ln8qVKoS9txI04rMKp/NliiZ/tTXmPOxhbiWdaJzFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6038
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmlsbHkgVHNhaSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBC
aWxseSBUc2FpIDxiaWxseV90c2FpQGFzcGVlZHRlY2guY29tPg0KPiBTZW50OiAwNyBOb3ZlbWJl
ciAyMDIyIDA4OjQ4DQo+IFRvOiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+
OyBqZGVsdmFyZUBzdXNlLmNvbTsgbGludXhAcm9lY2stDQo+IHVzLm5ldDsgcm9iaCtkdEBrZXJu
ZWwub3JnOyBqb2VsQGptcy5pZC5hdTsgYW5kcmV3QGFqLmlkLmF1Ow0KPiBsZWUuam9uZXNAbGlu
YXJvLm9yZzsgdGhpZXJyeS5yZWRpbmdAZ21haWwuY29tOyB1LmtsZWluZS0NCj4ga29lbmlnQHBl
bmd1dHJvbml4LmRlOyBwLnphYmVsQHBlbmd1dHJvbml4LmRlOyBsaW51eC1od21vbkB2Z2VyLmtl
cm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBhc3BlZWRAbGlzdHMub3psYWJzLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IHB3bUB2Z2VyLmtlcm5lbC5v
cmc7IEJNQy1TVyA8Qk1DLVNXQGFzcGVlZHRlY2guY29tPjsgZ2FybmVybWljQG1ldGEuY29tDQo+
IENjOiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFt2
MyAyLzNdIHB3bTogQWRkIEFzcGVlZCBhc3QyNjAwIFBXTSBzdXBwb3J0DQo+IA0KPiBPbiAyMDIy
LzExLzIsIDExOjU2IFBNLCAiQmlqdSBEYXMiIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4g
d3JvdGU6DQo+IA0KPiAgICAgPiA+ICsJcGFyZW50X2RldiA9IG9mX2ZpbmRfZGV2aWNlX2J5X25v
ZGUobnApOw0KPiAgICAgPiA+ICsJcHJpdi0+Y2xrID0gZGV2bV9jbGtfZ2V0X2VuYWJsZWQoJnBh
cmVudF9kZXYtPmRldiwgTlVMTCk7DQo+ICAgICA+ID4gKwlpZiAoSVNfRVJSKHByaXYtPmNsaykp
DQo+ICAgICA+ID4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJSKHByaXYtPmNs
ayksDQo+ICAgICA+ID4gKwkJCQkgICAgICJDb3VsZG4ndCBnZXQgY2xvY2tcbiIpOw0KPiANCj4g
ICAgID4gV2hhdCBpcyB0aGUgdXNlIGNhc2U/DQo+IA0KPiAgICAgPiBJcyBwd20gY29uZmlndXJl
ZCBieSBib290IGxvYWRlciBpbml0aWFsbHkgPw0KPiANCj4gICAgID4gT3INCj4gDQo+ICAgICA+
IHB3bSBjb25maWd1cmVkIGJ5IExpbnV4LCBub3QgYnkgdGhlIGJvb3Rsb2FkZXIgaW5pdGlhbGx5
Pw0KPiANCj4gICAgID4gT3INCj4gDQo+ICAgICA+IERyaXZlciBuZWVkcyB0byBoYW5kbGUgYm90
aCBjYXNlcz8NCj4gDQo+ICAgICA+IEp1c3QgYXNraW5nLCBiZWNhdXNlIHlvdSBhcmUgdHVybmlu
ZyBvbiB0aGUgY2xvY2sgdW5uZWNlc3NhcmlseSBoZXJlLA0KPiAgICAgPiBJZiB5b3UgbmVlZCB0
byBhZGRyZXNzIGFsbCB0aGUgdXNlIGNhc2VzLiBJZiBpdCBpcyBqdXN0IGZpcnN0IG9uZSwgdGhl
bg0KPiAgICAgPiBJdCBpcyBvay4NCj4gDQo+IEhpIEJpanUsDQo+IA0KPiBUaGUgZHJpdmVyIHdh
bnQgdG8gaGFuZGxlIGFsbCBvZiB0aGUgdXNlIGNhc2VzLiBDYW4geW91IHRlbGwgbWUgd2h5IHR1
cm5pbmcNCj4gb24gdGhlIGNsb2NrIGlzIHVubmVjZXNzYXJpbHkgaGVyZT8NCg0KRm9yIHRoZSB1
c2UgY2FzZSwgInB3bSBjb25maWd1cmVkIGJ5IExpbnV4LCBub3QgYnkgdGhlIGJvb3Rsb2FkZXIg
aW5pdGlhbGx5IiwNCg0KWW91IGFyZSB1bm5lY2Vzc2FyaWx5IHR1cm5pbmcgb24gdGhlIGNsb2Nr
cy4gWW91IGNvdWxkIA0KDQplbmFibGUgaXQgZHVyaW5nIHB3bV9lbmFibGUNCmFuZCBkaXNhYmxl
IGl0IGR1cmluZyBwd21fZGlzYWJsZS4NCg0KRm9yIGNvbmZpZ3VyaW5nIHJlZ2lzdGVycywgd2hp
bGUgcHdtIGlzIGluIGRpc2FibGUgc3RhdGUsIA0KeW91IGNvdWxkIGp1c3QgdHVybiBvbiB0aGUg
Y2xvY2sgYW5kIGRvIHRoZSByZWdpc3RlciBjb25maWd1cmF0aW9ucyBhbmQgdHVybiBpdCBvZmYu
DQoNCkJ5IHRoaXMgd2F5IHlvdSBhcmUgc2F2aW5nIHBvd2VyLg0KDQpDaGVlcnMsDQpCaWp1DQoN
Cg0KDQoNCiANCg0K
