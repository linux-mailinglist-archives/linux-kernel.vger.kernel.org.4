Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6899F6E09D7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjDMJOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjDMJOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:14:00 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2081.outbound.protection.outlook.com [40.107.114.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278F95BB1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 02:13:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zs/P6QWKStnwQzzf7vpZpRVivueAU2J+38rimowm7UAAB/TEIggWScbF/PFhcNIwBro9RmfzY0rqdAxYoADJK7aQulDcZq+5qZyQVyZ2zo14tf7pC0wg9i0K816CY6K6nZDUCPYVVsFkkEsJcvRe23XwsxMtLjEN4zudWv3ejv19sM2NOZn86TXu/5anHXzPr72d3CagZ4nyLggN+087wEGzUkuaovQSHaGAyVlSOLuapPXK7a6SGtHF7C4GAWPQWfAEuxisTGOB00NZsdky8fT5taH/G4abOtKZc9TBx80rrrCCVGssylpmtWxWLUET9mmrQc5b/GW3UWpw6IqP6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jM1QS02wkLmF1RiEW+jwtCdDLOKoVG3AzIwHZ1sVi5Y=;
 b=LWD8F2p65My1/VAx8ShyULoHWwWVTAr/4bPTmaWO1UFkfb1EhBaNv2zibRAC7jh83M+/rnfXrJEdP1/L6y9cHI3FAWFEthy3k/NBks3qH/28W8Ut7K7uwlxr8jIYzUEAfD4c8G2XunIOus6oCgjx60jwHCcwO+qt8UX7lb+wxMFP/WO9utSOkLeGAVBbcmCmATgmZWyM60V5b16KQ2uFlctDKYiE5VBqa7ArcEXIFpHNQhpXM8rfuvqtwddNCzKG4sSsSiH805R1iQy3hSPchgBeerCoJ9RaPgYmdQj2eP/Y89YOadEQK6RyBPC7BVL588n7ppe/sN5vFD9zWq9vgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jM1QS02wkLmF1RiEW+jwtCdDLOKoVG3AzIwHZ1sVi5Y=;
 b=TLE1dSe1jvcZp4TtAXPxQSQyh1BSa8D/bAPsFEDi9G/jKXdC9meuKyDdHXQy60IjSVznjR8eH/O2FVXw+JecaDD4B/H48LSxeVj1GDN1O8yhZ4VQwmJA3PFK7FKsDdZ1bzl9hqCUx9YaU67o//v47dJf7vwcRvY05AE0QGzFH6A=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OS3PR01MB5687.jpnprd01.prod.outlook.com (2603:1096:604:c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.31; Thu, 13 Apr
 2023 09:13:56 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::22a3:7e89:cc26:15c8]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::22a3:7e89:cc26:15c8%7]) with mapi id 15.20.6298.028; Thu, 13 Apr 2023
 09:13:56 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     xialonglong <xialonglong1@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "sunnanyong@huawei.com" <sunnanyong@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 2/2] mm: ksm: Support hwpoison for ksm page
Thread-Topic: [PATCH 2/2] mm: ksm: Support hwpoison for ksm page
Thread-Index: AQHZYtukRA1rprlVwk26L/8bdjt87q8UYYKAgBSUt4CAABSagA==
Date:   Thu, 13 Apr 2023 09:13:56 +0000
Message-ID: <20230413091355.GA2458769@hori.linux.bs1.fc.nec.co.jp>
References: <20230330074501.205092-1-xialonglong1@huawei.com>
 <20230330074501.205092-3-xialonglong1@huawei.com>
 <20230331054243.GB1435482@hori.linux.bs1.fc.nec.co.jp>
 <fea18890-7e6c-733e-9710-00a15df60a4c@huawei.com>
In-Reply-To: <fea18890-7e6c-733e-9710-00a15df60a4c@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|OS3PR01MB5687:EE_
x-ms-office365-filtering-correlation-id: 00a2748f-bb0e-4201-9bcc-08db3bff68f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9tkJIQuc8GeOZjpmoWCbclGm4hLIZV8q61ppz/jznS2efKJf1FD1Vva5LgnEvRSZDvAO8KWDE5KxMTPaWrpCw628gaTWKWF2EnZyuLv0H0s0L80F8A2rx81vxle9vbJfpBZC35y68Q80ib8aEoZmZuSc960604Lh3+hp6NRFndCvRBMvBoKPMopl+174IcLw59UdBNVMSGXS/5AfI9+T14fAniLDqClSOn6QUhWc23CAW9jFzTDtJLDLUpiOtuJjDOWNb7QSqizFBbNfyFBw7OBWzTfj9+xUan31DGshpAlbB0U5DhOfWR9k1uoT5oKwUt9fW3rOc43L1ieQSkgJXifGVquJXStjW0qwuFYKK0EN1aiLgMp8qrYwsgtq90rz13oFkaCAs3rUjyaQMzrC1Un3FpMSN0viD7kZmxvw6/UhWYSOHv1fh8gXHRCLWHd3lqLy95v8PvB8X4qh7zuKPbaJHkcayTEhCs14bGH5Wl3ZMPNfUy5567/R2K5IoyOg+l9JXgFwiomsoWokTVHUQ/7N1P+E68uGqxbbMJW9Sql3lbKFuYyZ8JDScGQVTsifFKTNA4au5LfXwOULr+j5o4ta2awD7kUHWDP3d/uE1BOo1euQ5axhgRA64WegNFUf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199021)(38100700002)(85182001)(33656002)(2906002)(38070700005)(66556008)(316002)(8676002)(86362001)(8936002)(5660300002)(66446008)(4326008)(64756008)(6916009)(66946007)(122000001)(41300700001)(66476007)(82960400001)(83380400001)(76116006)(6506007)(1076003)(54906003)(9686003)(26005)(186003)(6512007)(6486002)(71200400001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWNtelJZRjhud2NIZmluMDgvWDhOaGV0UDV0a1FuaHV1WHozUDZESU9zMEs2?=
 =?utf-8?B?VTZ0Mm9rRzJwZERMMkIzaFBzN1hyUjk1Q3BEZ2QwWnAyTnd4RGw1UTJKUW14?=
 =?utf-8?B?aVlPeG4zTlFDcTZacUFqci9mNFVMY0pUZEhRbks0Y1pTRXFyamlLbTdZd1Zl?=
 =?utf-8?B?eEVPTjA1bDVwM2pCaTRlVGF5dmFhZXhjQ05RWFlIRnV0Rk9yaGRwK3N1aDVJ?=
 =?utf-8?B?RXNvdmRNcm91UkJZemlQNG9OT25BNHRoOUVyS0FUOUFGN0EwcE5JV2FXRnQ0?=
 =?utf-8?B?SDdNWHFrOE54d3pTNEdGNUdCeEV5b0IwdVJIWEMvNktlTnZTM09raW54Q2FR?=
 =?utf-8?B?T0xZQTFrWXVnSU1nTmdmUVo1ZmRtd1dNdlpSRk1tdTErUE00d3BpNzE2aS9z?=
 =?utf-8?B?bFVaZFAvRFp0bFlMV3JCL0hHWnZRTWFuN3ZmWW5HVE1tMUR0Vmp5NnpibDZt?=
 =?utf-8?B?Uk9iTVhHL1ltWTRrd3dRdXQvU21Za2JnSFdJWDJuMW9rSGRsaGw0TWVZbU9j?=
 =?utf-8?B?SSszblhnc0xJYXJxNnYxaTFZR0dDcG5PNC9HQUFaa0toWXV0Q0NTQW5tUTZi?=
 =?utf-8?B?a2E4K2xOVDRQNU1PZDNpRFR3MWtrYWs3WjlhMXloODRmWm12bHZrSGtIdjRp?=
 =?utf-8?B?N1RmNnJFSEV2TTFtUmxzdjRpWldqbk1GZ3JpTkY0YktLVEFqSmVJQ1BxSk5x?=
 =?utf-8?B?YlRCQmdEWVZ6aFNwMURIN051RkJGNlViSm41NG11VzBkbjU5dXFrU1JNR0s0?=
 =?utf-8?B?NFJzUGoyeG55ODNZWFRhbER1VlVpcXFZTTNjQngxVTkwY2hDRktUZTZxSEFF?=
 =?utf-8?B?bFE1N1IvUXZHOXlYMXlyYlc3Zkd2V1gycldwb3RieTFsR0RFM0N1K3Q3UE1P?=
 =?utf-8?B?VWgyZ3NsK2lXYW8wYmx4ajlIOC9yN0MwTHRLQnp1T0g1UzVuSGJWemFNWkFM?=
 =?utf-8?B?OW5WNFVXRzFWd05hYzhTTGJVbCtaazVHdllXeVNsTmlOVG1pQ09YU3U2YjVE?=
 =?utf-8?B?NEYzTkdDdHgyUk1oYkZIMFF2U3h2Z0wxQkdWWUVWWDZHb1FzS3lkbEpmQkts?=
 =?utf-8?B?MEdneXdmM3pwbnFFTTBXamgvb290eTR0UWNweXZTQmlSWDdxTkpvQnFxWFRP?=
 =?utf-8?B?UzBUenlCTGhBMGZBN3dtdkFkeURzM3dpRWtnbE1yUm0yR1JVYTYrTzRvOVdQ?=
 =?utf-8?B?YXN0dnIzblpUNk9zdDZqcG0yYnE4YTVFMjcveGFxYnQ5S0MweFdYNFRRUnU5?=
 =?utf-8?B?SzVSclBpNWtsaThwWnBrYjVWMzdBVEZuaERubVRKVWtnR0ZuYXZWUUVZdjdp?=
 =?utf-8?B?VGUxT3BpS2Q5cHd4bFNFQzZsN056eklkNTMybmNLVzU2aU8wN1ZUUVZpVHIz?=
 =?utf-8?B?RW1oRVZQN1ArdFpJVkFtQnNGdXNBZ0h2bUZ6WTl4c0R5NTNsdUlNdytlUWEx?=
 =?utf-8?B?Tk5MczlOZ0FIWWJuZmRNcUVyU2VkYTRQYVFNdW8vcTg3SllnWFFxODZRa3Rk?=
 =?utf-8?B?aEdqMmJpUzQ2aXFVQVBYcmxJVUtLRi9ZVHNRU2J0ZlovQjdDYjhiUVo4OTd3?=
 =?utf-8?B?cnovUUZVcjEzdTlHNHVZQ08vYWdkQ1daeXRQakU2Yk05Sjl6dzVOTjlZcVM3?=
 =?utf-8?B?cm05UC8yQUlJcVA3T3o1YU95ZWtXK0pvQlljZDFCc2hkWWhRbGVzZHZDaGF6?=
 =?utf-8?B?QjBtNWMrMjJsVVFEbWF3SGJEOCtLZWFJNUw5RjdJREU0M0lLYXJ5ckorMmhL?=
 =?utf-8?B?b3B6RTlaVkVGM3ZpK0piSEtOL3cvbk5ncTRubW5uSDZ5SFJ3b1c0VXdrNjdq?=
 =?utf-8?B?TzVQWVVVSVpQSGhlSTA1ektIV005KytLM2QwOTRZclJsUzE4UnU4OG4rZjhq?=
 =?utf-8?B?YzhIMjFTalE0R2RubjRZU2N1U3c4SFZ3UE93MnhoejljdjJyUGU3NmtJRGNJ?=
 =?utf-8?B?WFVMU2MzYlpBc1Q4QTF6dkFxck5YOFR2K1dmL2c1NVdFcnpUcjZwR0xXaC9L?=
 =?utf-8?B?TzRNenZDeDlCdno2RFVvamI5V0twcHgvZnJHcEc4bWx4eUNBYmdjVkoyOG4z?=
 =?utf-8?B?cHhSV2tjWDhlVzFPcnVzQ0xnNnhHUlVlTHp4MWRmakxudEFQTnRyYWdtZEhE?=
 =?utf-8?B?RE9HNTFZRVozSzVsaXFhUTZRM2g0dXB5U1VQTHh6bmZiZDAzN3RwTWlSeDVQ?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A1C923CE2E6704BA255DA8660C324DA@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a2748f-bb0e-4201-9bcc-08db3bff68f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2023 09:13:56.5877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B72CWh+5TVLDlIB0f0vQm17g2ZjC2gFvB/XK6187HSd5XOSwwivvormpiv54SGjxgTmWxNKpA2yFg0aCZ9znNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5687
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBBcHIgMTMsIDIwMjMgYXQgMDQ6MDA6MTFQTSArMDgwMCwgeGlhbG9uZ2xvbmcgd3Jv
dGU6DQo+IA0KPiANCj4g5ZyoIDIwMjMvMy8zMSAxMzo0MiwgSE9SSUdVQ0hJIE5BT1lBKOWggOWP
oyDnm7TkuZ8pIOWGmemBkzoNCj4gPiBPbiBUaHUsIE1hciAzMCwgMjAyMyBhdCAwMzo0NTowMVBN
ICswODAwLCBMb25nbG9uZyBYaWEgd3JvdGU6DQo+ID4gPiBod3BvaXNvbl91c2VyX21hcHBpbmdz
KCkgaXMgdXBkYXRlZCB0byBzdXBwb3J0IGtzbSBwYWdlcywgYW5kIGFkZA0KPiA+ID4gY29sbGVj
dF9wcm9jc19rc20oKSB0byBjb2xsZWN0IHByb2Nlc3NlcyB3aGVuIHRoZSBlcnJvciBoaXQgYW4g
a3NtDQo+ID4gPiBwYWdlLiBUaGUgZGlmZmVyZW5jZSBmcm9tIGNvbGxlY3RfcHJvY3NfYW5vbigp
IGlzIHRoYXQgaXQgYWxzbyBuZWVkcw0KPiA+ID4gdG8gdHJhdmVyc2UgdGhlIHJtYXAtaXRlbSBs
aXN0IG9uIHRoZSBzdGFibGUgbm9kZSBvZiB0aGUga3NtIHBhZ2UuDQo+ID4gPiBBdCB0aGUgc2Ft
ZSB0aW1lLCBhZGRfdG9fa2lsbF9rc20oKSBpcyBhZGRlZCB0byBoYW5kbGUga3NtIHBhZ2VzLiBB
bmQNCj4gPiA+IHRhc2tfaW5fdG9fa2lsbF9saXN0KCkgaXMgYWRkZWQgdG8gYXZvaWQgZHVwbGlj
YXRlIGFkZGl0aW9uIG9mIHRzayB0bw0KPiA+ID4gdGhlIHRvX2tpbGwgbGlzdC4gVGhpcyBpcyBi
ZWNhdXNlIHdoZW4gc2Nhbm5pbmcgdGhlIGxpc3QsIGlmIHRoZSBwYWdlcw0KPiA+ID4gdGhhdCBt
YWtlIHVwIHRoZSBrc20gcGFnZSBhbGwgY29tZSBmcm9tIHRoZSBzYW1lIHByb2Nlc3MsIHRoZXkg
bWF5IGJlDQo+ID4gPiBhZGRlZCByZXBlYXRlZGx5Lg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBMb25nbG9uZyBYaWEgPHhpYWxvbmdsb25nMUBodWF3ZWkuY29tPg0KPiA+IA0KPiA+IEkg
ZG9uJ3QgZmluZCBhbnkgc3BlY2lmaWMgaXNzdWUgYnkgY29kZSByZXZpZXcgZm9yIG5vdywgc28g
SSdsbCB0cnkgdG8NCj4gPiB0ZXN0IHlvdXIgcGF0Y2hlcy4NCj4gDQo+IERlYXIgbWFpbnRhaW5l
ciwNCj4gDQo+IENhbiB5b3UgcGxlYXNlIHByb3ZpZGUgYSBicmllZiB1cGRhdGUgb24gdGhlIHRl
c3Rpbmcgc3RhdHVzIG9mIHRoZSBwYXRjaCBhbmQNCj4gYW55IHN1Z2dlc3Rpb25zIHlvdSBtYXkg
aGF2ZSBmb3IgaW1wcm92aW5nIGl0Pw0KDQpTb3JyeSBmb3IgbXkgbGF0ZSByZXNwb25zZSwgbXkg
a3NtLXJlbGF0ZWQgdGVzdGNhc2VzIGdldCB0byBwYXNzIHdpdGggeW91cg0KcGF0Y2hlcy4gU28g
ZmVlbCBmcmVlIHRvIGFkZCBteSB0ZXN0ZWQtYnkuDQpUZXN0ZWQtYnk6IE5hb3lhIEhvcmlndWNo
aSA8bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+
