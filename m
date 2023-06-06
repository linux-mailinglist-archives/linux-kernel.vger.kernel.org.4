Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5338A7246CA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237856AbjFFOvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237305AbjFFOuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:50:52 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2135.outbound.protection.outlook.com [40.107.7.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1268199B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:50:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjUBGcmxyM8x+wzSUVy4YHPOdigi8x9El9xcVHS3d12HCKHmBmLNaNohRyAL9nZnFsLuKmWOJ+Phsutjv+V8FxwjOOUV/h8XgTh//rBX2NSmfQYY5Bx+60iflQ6HUzKDSSlGLtC6av1hN7vnK7gzVrKBpVJUWjGHPoh98KCglLyQ8BeSfDG/5u60RLUrTPJWW9Er2PybjbsXvuBsSY9ujewH+k/GEKU/kyHVOdvGrXFvVw8TWASdQJL6a/F3RrVvQyNuVc/NHHaOMcUj0hyEWYTPW+j6JifNMn9bPRuIunmD0JnrlZbY7+9hbusfSr9TQcAHRn07V2EdYNTOBoUqaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZlVWnisYOFTVdYWWm+WV7htGQUaCU1GcXk0MpQWdHk=;
 b=HUIX5hNflhf+jWJAxchpa7UDg30edMEbFwaAI0q8PnUZW1I0+xSE7ugEZxd7EOzXgOyLe3HRPNtpagUIEK7IIGwAHgNc9g3PoLDsRuk1jJD6XpjahvhgxXxcx2OiQd/EN5ovYuBMAaTT/CZ4SLePvnZpE2+CwonsEtScnA2GooPZkMsfnEpZSbczCFIekP31MVg6e22/iVNacXs8El7jMp36+Iz0JSn6CTCazdMB71rbEW0etkPUnpm34AEZs1varEWpRbmyLJMpP0x4tyUTnam5R9xL88UiNJroombkIKwqOqzcV7zw9r+pphnuJIDsSIYsGOhxUG8mWibdp206OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=habana.ai;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZlVWnisYOFTVdYWWm+WV7htGQUaCU1GcXk0MpQWdHk=;
 b=Vrvitf38+TdENHKgr4hbOxrvYwKdxszJdbrwWQcvpKW22pELBcTo/Wzt+lARv+6MSiyflleJ0Ufb3Y6uuOajayPH/NrdvEFJDjQgJy2droXUACC1PmGH5VDPye40KNwFYwlcM1RKIgiiN9nHBo0QOxB31MDCB4MUYSmOEvyTdf/6BNW2JxAmzSxqNXjwCb/2w/M1l6IiPdNvnylhZdgDgkAUJnfg+YtBdi7bJAiBVjjx3p35hat7EOnjQljxoDYq2RXwO4z4/EU/Wuf0ZIQ1IeBI9LaKNMstJpw65vSOCTpCqJTIwnM1x37iopN3bs1jlYxcN09UUegjh7eCIOeh/g==
Received: from AM9PR02MB7706.eurprd02.prod.outlook.com (2603:10a6:20b:43d::23)
 by PAWPR02MB9149.eurprd02.prod.outlook.com (2603:10a6:102:33d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 14:50:21 +0000
Received: from AM9PR02MB7706.eurprd02.prod.outlook.com
 ([fe80::73e3:88a8:1bd4:7bde]) by AM9PR02MB7706.eurprd02.prod.outlook.com
 ([fe80::73e3:88a8:1bd4:7bde%7]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 14:50:21 +0000
From:   Moti Haimovski <mhaimovski@habana.ai>
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "david.m.ertman@intel.com" <david.m.ertman@intel.com>,
        "ogabbay@kernel.org" <ogabbay@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] make AUXILIARY_BUS config selection clearer
Thread-Topic: [PATCH v1] make AUXILIARY_BUS config selection clearer
Thread-Index: AQHZmHvOlQ30/AODak+XP1A3z091Ua99ygkAgAAJxlA=
Date:   Tue, 6 Jun 2023 14:50:21 +0000
Message-ID: <AM9PR02MB7706888212798FE0CC8213D6D152A@AM9PR02MB7706.eurprd02.prod.outlook.com>
References: <20230606133528.197335-1-mhaimovski@habana.ai>
 <20230606-aspirate-evident-00b27a98a718@wendy>
In-Reply-To: <20230606-aspirate-evident-00b27a98a718@wendy>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=habana.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR02MB7706:EE_|PAWPR02MB9149:EE_
x-ms-office365-filtering-correlation-id: 39100906-5690-4522-9d9a-08db669d5a44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cURQPXFxpg1hCC0SwC8JQZaf+VH6CeCDqJH07/bdcKdBceSXbphY7AIpbbCq1A6Ws6DVOQuuR083o8YZu//l3PmSLyM7QOUWbrYPzmLLeeSsnb4dn2fmNy2qNTTHjiITdnniLl6yXBIHUHxRIhrLGtDlE2mGiQbj5lf51C41LcDEo85Divsm1kzpt6C9NUYroT2olimsAyKgwpS6J/JiGddQWKFmWEAUng2dVhlEthrKS+bw8hbHpgmOXGVHAjYjt+sFyIaqEaNJAqjTvo6uu5cv4DR30qJ6hv8Foznnvtxw7fBs7Q+cPO+qmOuNNw/TUVxeFjKixVyp8x45csLvtlM6Fxg+Yeu5PPM9QnPsx1pu6HR4kkr6vvrDo2B1aYKn/sJNoQWtHoNwCbjCeafi+gI2O1ko4SrosG+Pfu5yOf1WBnHZXc/S1x02Kd3bICK8ykUeVuNXABkfWFhLe7Gk1m613OEAVFraIRSLQaC7B6vDXlw7uZ6Aq8E2nsAZlq83zy7xQo2AlP/Ge5p2jSJ6FyFZEsiZAg7tnVSSZqdNcDLxzM1lpI+sMMR4u+SDFjOHyA429WDutdcJYGwo4SGHbvMXwS7lG/OMaaDix/MmhFCXJhLxRnlKtRxOoGYGCMXg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR02MB7706.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(376002)(366004)(136003)(346002)(396003)(451199021)(71200400001)(7696005)(64756008)(66476007)(66446008)(2906002)(122000001)(82960400001)(76116006)(66556008)(66946007)(8676002)(54906003)(8936002)(38100700002)(5660300002)(38070700005)(52536014)(86362001)(478600001)(4326008)(316002)(6916009)(33656002)(55016003)(41300700001)(9686003)(6506007)(26005)(53546011)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXNmWFJ4dEVmMVpjajRFYUFOK3Qwa0tNZnBJb1psZ0FwVG0yTTdWK3BsM3Bs?=
 =?utf-8?B?WHkrQk54Z2szSHZ0S2VPVWdzQTA4SHZTSE1lRDROTU1XVlAxc3oxNXBpL0xI?=
 =?utf-8?B?QWVBSDRQM2NRN3JyY3E1MFJWNTJ3UXFOa2FMUUVvaXZ2cTJBNW92aXcyQXZX?=
 =?utf-8?B?aUd4K2xIZTFBMnFIa0RsYnlYRmZpaUl3ckdqNGk5RlpiMDhIanR4ZmwzT3Y0?=
 =?utf-8?B?eFJMdGwrd0t6aDBJUktHSnZtZUlRODVxVGhtSGp1K3FtWjc2OFR5N08zQ3Ju?=
 =?utf-8?B?aXQ0bmIrQ1RMOEo3dXNuUjVOSVFCVnRNZ0FkT3cvc1JqMTU3ejNkZlZISkwx?=
 =?utf-8?B?bTRWNUFqMWpqbzBuZklkRHpUR3E5WDM5d1ZYaC9EQTU3Zkl5TEZURFcvRE5x?=
 =?utf-8?B?a0Q4QVlKVmkyVVBmV0tSVmZoMjQ4R3piZ0g4emJqM29QUlo4UHJwblR6bFRD?=
 =?utf-8?B?NFpWYVhnbTVERm41TjRaWkNJcXZZa21uTlBuOTE1N3VSQytSTmlhQnhOeC84?=
 =?utf-8?B?OUpVUHZUTjNJczZkRFhGUDBmbUZteXpYOHhrNnRKWkVVRUtZVmpZUWovVWo4?=
 =?utf-8?B?R1E5WjlFUGIwSFNEeWFpdng1Y055Q2h3SU9paVl0aXFFMkFrSnZGS0VrV2tD?=
 =?utf-8?B?WHFNOVdIejlQQS9zZGcxTFFIbW94Rm9Pc1JmVUc3YlpMbjB0L0tuRmVtbjgx?=
 =?utf-8?B?S2M1NlJ3MXkxaFhjS0NUYVA2ZW41MlorL1dncWFnOXpRZzFMVE1jclRYcVlU?=
 =?utf-8?B?QTNCVW1hZitlOUZYUEJmVDBXVXNFWVNCT0lEa0ZjV21rK2xMY3hFTzJVeTVE?=
 =?utf-8?B?QVh5RGZ4RGVhU2J1bjZFSTFCY011Yzlmc1hBeFJReFlIRnhjaEN3YWlOZytJ?=
 =?utf-8?B?aXovbnhiT05kQUJuNnV1RGRYZS9FdHRzbkVjZ29DenlWNUR3enNIb0ZPWnp2?=
 =?utf-8?B?UWJkdUc5Smc5WmEzV0NSV0FuK1lSRHE1MXJ5Uk14RzJwQmJBTzdQSVNYa3JS?=
 =?utf-8?B?UGdxR3lsTXFJcWFOYkRpODVMNWc3K0M0ZnhGaUxuU3BHWnJmb2F5OXdOdkNx?=
 =?utf-8?B?ek9vQ0taNzZnK0p0S1d3NHZyTXN1NzV3WXpDSFFHdlFSUTh0MndMOHJVNUQr?=
 =?utf-8?B?eXAxZjh1ZVF4VEJSZ0xDOUY0VTBZRW9DaUkzMHIrOTRuV0ZQRzhvUEpqaFVw?=
 =?utf-8?B?U052VVJSUlozSGtCeC9ud2k3dlQyMmQ5RlRFNFNUNGlPK2RraENQMlV2V0N2?=
 =?utf-8?B?T1BCY3ZQRXNPWG5hNWFZdUFSVWRMZDB4ajNmMlNQY2cxRWx3N2M5WHVIeWJT?=
 =?utf-8?B?UkZZc2tWZ1A1SmJZcVFlMC8vdjhNazdaNFYyRTA1OWF2eTU3bGZSc3NwRTdw?=
 =?utf-8?B?djRmRWZvWnhocFlHbjNxdXV5SkQ1SVFsQ1F1cGhmanJpaXJSV3ZpajM1LzBT?=
 =?utf-8?B?WWtvczJqRXV3M3dQQ2RpcUFkTlNvMXVqMHd2NDNmRWc3eTNKOWJnSHBWOWZI?=
 =?utf-8?B?a0NZQmh0NGFvd0dGZ0hQMVhNU3VwVEdRUjVjcG5UZTE5OWk5SmZLYWhSOW5E?=
 =?utf-8?B?RDlkbXhUSDJ1N3pyV3FrVmduWWR4dUprRWREU0VxcDZaVDNia1A3UGVIcnN3?=
 =?utf-8?B?bkFmUmw1V0V1SUcrWDdyVlNFVWNpOHlwRk9wNU1qblZTQWlKcFk4bFFuV1Nm?=
 =?utf-8?B?Z0s1aFZsNWIrOVJKd0dWaTJGOTc0c2VKU0kvckwxa1Nwd01FUmZxY3VYQUl4?=
 =?utf-8?B?TEE3bWszU0hweHU5NS8xOTV1Z2E3YXJxV2EwOXZ6R0c4RUFBT1ptTGFvSFRM?=
 =?utf-8?B?bmFVN0wxeWxraStuRUxPSkgwM25tUTRKN0gvZ1RjNlR5Uy9wU3JqTkhweG1a?=
 =?utf-8?B?QVlTV1dqU1FjYXpWeGw2WWtYcXp6K0RXMzBKYStkaGthTGpraHhwVythaEZa?=
 =?utf-8?B?RUVRT2NIYi9WSlF0cDJpc3crY2FUMzhBSEtWTzR5RldHOHJndFNNQW84TjM3?=
 =?utf-8?B?enhmQTFhZHFVaG5rYTBvQS9JL0JoR1BIcmliYXl1VXhjOHhpcCtMS2p4MXhi?=
 =?utf-8?B?aHlMMDlYclB2aWp2enR2SFpwajJ3OHNOc2lZcmIvNTFlRjExa3hrV3ZhMnJt?=
 =?utf-8?Q?Wa5sbhqFqOQ5eVEnhX7LEiP3X?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR02MB7706.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39100906-5690-4522-9d9a-08db669d5a44
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 14:50:21.2786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iH7ubzx/6WCxY2/j2M2i+0xe/Mn8V/LRi84rhftWfeZTOQoKLR705sqS9zjOVeXPliwY4ORpGebnekrSbWNs+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR02MB9149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ29ub3IsDQogTm90aW5nIGlzIHdyb25nIHdpdGggdGhlIGRyaXZlcnMg8J+Yig0KDQpJJ3Zl
IHN0dW1ibGVkIHRoYXQgaXNzdWUgd2hlbiB0cnlpbmcgdG8gZmlndXJlLW91dCBob3cgdG8gbWFu
aXB1bGF0ZSB0aGUgYXV4aWxpYXJ5LWJ1cyBzZWxlY3Rpb24NClZpYSAibWFrZSBtZW51Y29uZmln
Ig0KVGhlIGlzc3VlIGlzIHRoYXQgd2l0aCB0aGUgY3VycmVudCBLY29uZmlnIHdoZW4geW91IHJ1
biAiIG1ha2UgbWVudWNvbmZpZyIgYW5kIGVudGVyIHRoZQ0KRGV2aWNlIERyaXZlcnMgLS0tPiAg
ICAgR2VuZXJpYyBEcml2ZXIgT3B0aW9ucyAtLS0+ICAgU3ViLW1lbnUgdGhlbiB0aGVyZSBpcyBu
byBtZW50aW9uaW5nIG9mDQogdGhlIEF1eGlsaWFyeSBidXMgYWx0aG91Z2ggaXQgaXMgdGhlIGZp
cnN0IGVudHJ5IGluIGRyaXZlcnMvYmFzZS9LY29uZmlnIHRoYXQgdGhpcyBtZW51IGlzIHByZXNl
bnRpbmcuDQpTbywgdGhlIHVzZXIgaGFzIG5vIGlkZWEgdGhhdCB0aGlzIG9wdGlvbiBleGlzdHMg
YW5kIG5vIHdheSB0byBtYW5pcHVsYXRlIGl0IHZpYSBtZW5jb25maWcuDQpNeSBjb21taXQgbWFr
ZXMgdGhpcyBvcHRpb24gInZpc2libGUiIGJ5IGFkZGluZyB0aGUgc2hvcnQgZGVzY3JpcHRpb24g
aW4gdGhlICJib29sIiBsaW5lDQphbmQgLCB3aGlsZSBhdCBpdCwgYWRkaW5nIGEgc2hvcnQgZGVz
Y3JpcHRpb24gZm9yIHRoZSBzYWtlIG9mIGZ1dHVyZSBnZW5lcmF0aW9ucy4NCk5vIGZ1bmN0aW9u
YWxpdHkgbm9yIGRlZmF1bHQgdmFsdWVzIHdlcmUgYWx0ZXJlZC4NCg0KSG9wZSB0aGlzIGFuc3dl
cnMgeW91ciBxdWVzdGlvbg0KIE1vdGkgSA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+IFNl
bnQ6IFR1ZXNkYXksIDYgSnVuZSAyMDIzIDE2OjQ4DQo+IFRvOiBNb3RpIEhhaW1vdnNraSA8bWhh
aW1vdnNraUBoYWJhbmEuYWk+DQo+IENjOiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgZGF2
aWQubS5lcnRtYW5AaW50ZWwuY29tOw0KPiBvZ2FiYmF5QGtlcm5lbC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gbWFrZSBBVVhJTElB
UllfQlVTIGNvbmZpZyBzZWxlY3Rpb24gY2xlYXJlcg0KPiANCj4gSGV5IE1vdGksDQo+IA0KPiBP
biBUdWUsIEp1biAwNiwgMjAyMyBhdCAwNDozNToyOFBNICswMzAwLCBNb3RpIEhhaW1vdnNraSB3
cm90ZToNCj4gPiBBZGQgYSBkaXNwbGF5IHN0cmluZyBhbmQgYSBoZWxwIHNlY3Rpb24gdG8gdGhl
IGNvbmZpZyBBVVhJTElBUllfQlVTDQo+ID4gc2VjdGlvbiB1bmRlciB0aGUgIkdlbmVyaWMgRHJp
dmVyIE9wdGlvbnMiIG1lbnUgaW4gb3JkZXIgdG8gbWFrZSBpdHMNCj4gPiBzZWxlY3Rpb24gY2xl
YXJlci4NCj4gDQo+IEkgYW0gYSB3ZWUgYml0IGNvbmZ1c2VkLCBzaW5jZSBpdCBpcyBub3QgZXhw
bGljaXRseSBtZW50aW9uZWQgaGVyZSwgd2h5IGlzIHRoaXMNCj4gbm93IGdvaW5nIHRvIGJlIHVz
ZXIgdmlzaWJsZS9zZWxlY3RhYmxlPyBXaGF0IHdhcyB3cm9uZyB3aXRoIHRoZSBkcml2ZXJzDQo+
IHRoYXQgbmVlZGVkIGl0IHNlbGVjdGluZyBpdD8NCj4gDQo+IFRoYW5rcywNCj4gQ29ub3IuDQo+
IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTW90aSBIYWltb3Zza2kgPG1oYWltb3Zza2lAaGFi
YW5hLmFpPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2Jhc2UvS2NvbmZpZyB8IDExICsrKysrKysr
KystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9iYXNlL0tjb25maWcgYi9kcml2ZXJzL2Jh
c2UvS2NvbmZpZyBpbmRleA0KPiA+IDZmMDRiODMxYTVjMC4uZTFjYWFjMWQ5YTU4IDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvYmFzZS9LY29uZmlnDQo+ID4gKysrIGIvZHJpdmVycy9iYXNlL0tj
b25maWcNCj4gPiBAQCAtMiw3ICsyLDE2IEBADQo+ID4gIG1lbnUgIkdlbmVyaWMgRHJpdmVyIE9w
dGlvbnMiDQo+ID4NCj4gPiAgY29uZmlnIEFVWElMSUFSWV9CVVMNCj4gPiAtCWJvb2wNCj4gPiAr
CWJvb2wgIlN1cHBvcnQgZm9yIGF1eGlsaWFyeSBidXMiDQo+ID4gKwloZWxwDQo+ID4gKwkgIFRo
ZSBhdXhpbGlhcnkgYnVzIGRyaXZlciBwcm92aWRlcyBhIHdheSB0byBleHBvcnQgYW4gaW50ZXJm
YWNlDQo+ID4gKwkgIGZvciBhbm90aGVyIHN1YnN5c3RlbSB0byBkcml2ZSwgaW1wbGVtZW50IGEg
Y29tbW9uIGludGVyc2VjdGlvbg0KPiA+ICsJICBvZiBmdW5jdGlvbmFsaXR5IG9yIHNwbGl0IGEg
ZnVuY3Rpb24gaW50byBjaGlsZC1kZXZpY2VzDQo+ID4gKwkgIHJlcHJlc2VudGluZyBzdWItZG9t
YWlucyBvZiBmdW5jdGlvbmFsaXR5IHdoZXJlIGVhY2ggYXV4aWxpYXJ5DQo+ID4gKwkgIGRldmlj
ZSByZXByZXNlbnRzIGEgcGFydCBvZiBpdHMgcGFyZW50IGZ1bmN0aW9uYWxpdHkgKHVzdWFsbHkp
DQo+ID4gKwkgIGRyaXZlbiBieSBhbm90aGVyIGRyaXZlci4NCj4gPiArDQo+ID4gKwkgIElmIHVu
c3VyZSwgc2F5IFkuDQo+ID4NCj4gPiAgY29uZmlnIFVFVkVOVF9IRUxQRVINCj4gPiAgCWJvb2wg
IlN1cHBvcnQgZm9yIHVldmVudCBoZWxwZXIiDQo+ID4gLS0NCj4gPiAyLjI1LjENCj4gPg0K
