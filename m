Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40B574A81A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 02:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjGGA0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 20:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjGGA0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 20:26:36 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2071.outbound.protection.outlook.com [40.107.215.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE1A19AE;
        Thu,  6 Jul 2023 17:26:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwHC7IjQO7TkVR4RRN4UslCRSb2j4ku0wneOUZ89h7Dt4AyTvGAa7YF9ZgmAeQT0cH7NxC1tlbc1oUWktZ1Q1S/JE47OOLSbFazhFiSBdYoyC2AdJq8GKMmHEbeapmgk0eFa1JAxzB1k189leMAuJ9s2J6G20lobmgl2MoSMOjqSL6Ac8UdiK6SzLrqo/Q0t+wHMUUvBGDPwCPt0JGMdtVbg3YFYenCJnNuYtdSqSueCq+S8um7SkGTrMH3xUNXFj8PFYaTVhRBHKQcrauhau26VsedJd3YPaCx1ygoodnuoWJS7CHnYf/TH4feCUPFD90tLXFgH7TLEMX9NDxfbHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2vXB2OBiI7reToT0wA+9dIfJJrXJAdmaUTyY0o58OI=;
 b=OgszyZx2PvFyQwgH6BXIDCAviiWpteg6NkQi6DM14NazUoBe7YhVPZC08U1GNlWaIo45EUH3ZgICPLa7I/MD3s9ZfLdIvwEH/r7ZezT3QumIS6Om+0w39QIhRyIlEjJe0e5ZjBgle6FG79beWy1b8aSfj7K9cxjzzTASjly+wmmLfWNCMj6/UFa7M0MXBtVv+8J5uhK2eEaxHV5PgDGteXDljvP33n8HAp/zxf0+CMBYkZLsJd5NOmqxk53mm41J/2Ce0M0f9HoVAvVol6Kc6SfC69TZwB1HBDImCEkT/3It2IC2EjLD/ST+hYa42VMydWbExSCN6aZyWmtHljOzrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2vXB2OBiI7reToT0wA+9dIfJJrXJAdmaUTyY0o58OI=;
 b=GCPlnk0B77tVZG7UC+ByfRNQJuzFlpHB3aQdltSQ0E0hYNBr85ZgWwVOvJAArFD85WWAlzHrihOXmAUePuJRGvHAYDEd9+FGZ7lZhVRwlHBO6lqxjXto7aYqwlZIyBlVaSxytStxEfe8HWMfGh9jcPEA7zDSlgtbm/+LEZXjNKk=
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com (2603:1096:400:1c5::12)
 by PSAPR02MB5112.apcprd02.prod.outlook.com (2603:1096:301:79::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 00:26:29 +0000
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::2e7:47a3:69c4:9e8e]) by TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::2e7:47a3:69c4:9e8e%3]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 00:26:28 +0000
From:   =?utf-8?B?5p2O5Z+56ZSLKHdpbmsp?= <lipeifeng@oppo.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?5byg6K+X5piOKFNpbW9uIFpoYW5nKQ==?= 
        <zhangshiming@oppo.com>, =?utf-8?B?6YOt5YGl?= <guojian@oppo.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSF0gYmxvY2s6IG1xLWRlYWRsaW5lOiBy?=
 =?utf-8?B?ZW5hbWUgc29ydF9saXN0IHRvIHNvcnRfcmI=?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIGJsb2NrOiBtcS1kZWFkbGluZTogcmVuYW1lIHNv?=
 =?utf-8?B?cnRfbGlzdCB0byBzb3J0X3Ji?=
Thread-Index: AQHZri0DsaJtii+IQUasqZzqxbUUA6+ppwGAgACquBCAAilvEIAATjqAgACtKeA=
Date:   Fri, 7 Jul 2023 00:26:28 +0000
Message-ID: <TYZPR02MB559543EE78F4052B6995EBAEC62DA@TYZPR02MB5595.apcprd02.prod.outlook.com>
References: <20230704040626.24899-1-lipeifeng@oppo.com>
 <32dad510-1508-f0dc-ab49-60d56ed2c2d6@acm.org>
 <TYZPR02MB55955F57A8CCC819054338BFC62FA@TYZPR02MB5595.apcprd02.prod.outlook.com>
 <TYZPR02MB55950B363465E43DB0044ACEC62CA@TYZPR02MB5595.apcprd02.prod.outlook.com>
 <c77cf93f-c27e-63aa-c2d4-c494bd9e3bee@kernel.dk>
In-Reply-To: <c77cf93f-c27e-63aa-c2d4-c494bd9e3bee@kernel.dk>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR02MB5595:EE_|PSAPR02MB5112:EE_
x-ms-office365-filtering-correlation-id: 282595ae-a5cf-4ca7-8d09-08db7e80ce61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yRWt1iCalHoUnHfOoSASuPTROOlVQFKnKszr+f5H88MlH68pXhSq0UkEUhoT0YKKvy6SVzu5MZcxuKWZjH9xhahpjTKAGMSufVs2JwsDupHlA211APCi6WuOb6wyanEjusM7keF+fc0a/teb84z9U7ZMWXy1h69inURGMqjNxxAjWEMmwebHt2y+3uykM1k5N5eCatdfEDQJJsZ9cvksXFk++vR/xZvnfAvy1nfi1A6CWthS/7RaKQeoZMpA48mKab/1UXJt76MQ/MQe6MtXj9lc23T9jK58BlS860Tfx4b3D1KS7R4+CtSNxp0XuNsA3Zb62T8Ko2tBFya7T9SCYij2kiGwZPZuDKr7LKfPGsmlBCMr/z4hKkOvRzHVRnIlXI86dMSEyx/zAX8IGqDrlmDCcAyXW7KHDWXoU8ftmCbTr5KQRQ5U/4cSUG29v8AtN4ePer7TJ8HBcN19PHsXRATS+OIVSnoh4dvL5Pgwbvlf/TSkHV7/ArnzOvzKMbUAa9s6tMAhMgSK7EGygqicR9A9c7CL31bF+kwGeU8J4ahPXIBZztQrGMZVxjEqMm+7v6EFQJUn0OJwtB/2hUrEewK/GG/1Z+PlJKVZaWE9PcZVT94nWfNos0qLHY+B4rka
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR02MB5595.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199021)(6916009)(66446008)(64756008)(66556008)(33656002)(66946007)(66476007)(76116006)(478600001)(224303003)(4326008)(316002)(2906002)(85182001)(52536014)(5660300002)(8936002)(41300700001)(55016003)(26005)(54906003)(38070700005)(86362001)(7696005)(9686003)(186003)(6506007)(38100700002)(71200400001)(122000001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTY0eFZCVU9qT3hNTmZxMXZsZFNZWWZxenoyNUlNVVltMUh2OEJlbW55Qmt1?=
 =?utf-8?B?NkwxSExLdDRKancwYlJ5bEhmbjNvM0hpSmF6UmxDRmwveXFObnNZVGtkb0lK?=
 =?utf-8?B?U1VHNG8vR2ZydmhiWFEyQy9tYkxiUytiUDNDQlp4d1BOdFdXZUpqaVV5R1NL?=
 =?utf-8?B?Nno0YUFNLzJrZjRNK1dwaXpXRVhXTHN1cHhRR0I2Sm9xNm9CcE92Q2R3UVVS?=
 =?utf-8?B?UkhtOUtndEtuR0t2Y3VkRmlETmQ4UTR0S2YxVU5tMVowcjlQbklMK1duWGlz?=
 =?utf-8?B?aVV1RU80a1YwZlNTWElJYmdNV2RDVVlaME0weUhYbXdPSU96WnJZOVMyNWJ3?=
 =?utf-8?B?YThvL01ObG9jNEN6dGNOaFRjcFA1MExncUo4TWhhcmkvMUZvdXlTSk1RVHNC?=
 =?utf-8?B?VkFUNjY0MTdsNG9xUVREZnl5TVNvcGUwUXhqaHo0OUJ6L1NrOEVzSzBDakNP?=
 =?utf-8?B?cnJwNitINnhkU1hRZS9PM0lxdjJLaGRyY29wTk55L1dFdmw5VUc3ai9JTmJJ?=
 =?utf-8?B?aVVxUkQvZG1Pakl2aVVsMFBsVXBESWNFbnZkeXNPKzBiS002SlFwb21wM0lH?=
 =?utf-8?B?Wk1zdElzUDFqMVBOTEY5ekhnUWpsL1hqcXlYWWxHL1Z3N0UxMXRROUNJZEZ5?=
 =?utf-8?B?dURNNUo3ekt0Wk1SNCtGN2RVSWE1V0VkT2lMdG01UWV6UlFZNmhjcW8ydHlm?=
 =?utf-8?B?NjVTZXJwNWpBNnRQWVBZRXRPa1RDTFA4Y3ZmSjRXeHFDTEZGdCtmQ0FRK3cr?=
 =?utf-8?B?Y1hpKzk1ZEFOM1RhRWE4QTd0cWxORFhqNUROTUlGNlk1R0NPOURKaW1PS0c2?=
 =?utf-8?B?UUFjaFliYTFpaFVEbWU2MnRPdzRnOEE2dU5nbFJzb1JNK1Z0VnFCNEdwUGxC?=
 =?utf-8?B?Qlp2TFkxcHNCaWxwdXBaY1hUWmhpdXpZdzdmN01ZMzViT1UzYVdOS255RkdF?=
 =?utf-8?B?M2ZNbXdMckxZcW55UkNnNjh0RGxnZDhtSjNlaW5yemE2OWxYRC9Yc21XK2Iz?=
 =?utf-8?B?T0ZpbVYvN3o5UXdjQ080TjJNZStqR1VrL3MyQ1I0aENnK0NpSElxYzJYbVJ1?=
 =?utf-8?B?bSs1MkpMOEQ2SytYbEZhS0xPbW1NVG9lMUhyangvQUptVjk2Vy81akYzanow?=
 =?utf-8?B?NW11N3Z0aHBNVFFwLzRBWEVhcWl6ZVhWS1BmWWIxM3ZyMzliVjltZzg5b3pP?=
 =?utf-8?B?dS9PV1Q4Y29BaUptTnFINTdjbkRFb2ZSZDJYdkJMbTk1S0VKY0crd3YyOTN4?=
 =?utf-8?B?VW92dUxUQlRJTjBZWW9tN3o2RmVaS2NrNWJxZHFKMnBZUjFmUERnV2tHQzlV?=
 =?utf-8?B?YWM0S3VtdTRlQnFhWUtMelRzVDhCTksxaTZYWWl6eFQzTlNIelVCNkh4T3pD?=
 =?utf-8?B?T2NnUFhVQk1FRXR4ZGlGZlMwRENaOFRYazZWbVFHdWNQUnc2S09WbjVjb09D?=
 =?utf-8?B?OWhNRGlnZEgzKzhzY3pVV0YvNEMvZm0wMDBaeTl0dXVadGtiS3dCM0ZRaDFm?=
 =?utf-8?B?eS8zZWhKVE95cVd0eDd1WVV6TUxRS3czRmo4NUxMVTlwVE1CZ056dG9xMjho?=
 =?utf-8?B?dXJPZ2czblFpK2tSQ3JTTnNlOWpqRkxPN3VOYlJuUjFJOHZpY1VlMHg0TVBP?=
 =?utf-8?B?SjlkU0lnTDBqakNwVDJWeDFoWHdwc1E3elp0c1hVdXBvR1VBNWcwdmYydU1P?=
 =?utf-8?B?QWV5dnBxZ1UyMElDeC9YTUhTTGduYUpMNm9XSWVTUG9RTmsvZzByRENlbWtu?=
 =?utf-8?B?c0hUSGVldHkrT0paTEZEZGFFbEtoYWh0RXF5QnFuRUF4OUNhWEdtS0hJdUJH?=
 =?utf-8?B?VDlsMEhVYlM0MFNGcU1LdW1XNmtTS2Iwc3VaNk5uVm90b2NlSjZrSHRsYjZZ?=
 =?utf-8?B?VEZabUZnL3gvcGRjL21kcU83c3A2bEMzOXlHc2IvVTY1TEVYWDk5UW12Y2JI?=
 =?utf-8?B?MHZoaDUxTGZMeVNyUGFyT2IyTDNaMnRhaXUrZDhMNjNiOTBmakRlMGFjSXpT?=
 =?utf-8?B?ZWxEcnpFdTRWd1owUXRZdkNXY1hjaXZMTFFUeGFGaEFrVUVlaVRrV2RpZjZY?=
 =?utf-8?B?TjY1dTgxU0psT0hWdkFEQ3h4SWI3aEZlN3FyVUlXWEhGSjIwYVNDaVRWUWt2?=
 =?utf-8?Q?Z3I0OkazL4eggWqLjjrlNV+5c?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB5595.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 282595ae-a5cf-4ca7-8d09-08db7e80ce61
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 00:26:28.5908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OVj526i+C1g9bcZUr4Z+4524n9z7Di841KBMjbIiMgCIoo8J4863KygOLKWKB3dRePD/oORuvcBBRqp4KhNhQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR02MB5112
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4+Pj4gTXEtZGVhZGxpbmUgd291bGQgc3RvcmUgcmVxdWVzdCBpbiBsaXN0OmZpZm9fbGlzdCBh
bmQgDQo+Pj4+PiByYl90cmVlOnNvcnRfbGlzdCwgYW5kIHNvcnRfbGlzdCBzaG91bGQgYmUgcmVu
YW1lZCB0byBzb3J0X3JiIHdoaWNoIA0KPj4+Pj4gaXMgYmVuZWZpY2lhbCBmb3IgdW5kZXJzdGFu
ZGluZy4NCj4+IA0KPj4+PiBIdWg/IEkgdGhpbmsgdGhpcyBwYXRjaCBtYWtlcyB0aGUgY29kZSBs
ZXNzIHJlYWRhYmxlIGluc3RlYWQgb2YgbW9yZSByZWFkYWJsZSAuLi4NCj4+IA0KPj4+IEh1aD8g
TWF5YmUgd2UgaGFkIGRpZmZlcmVudCBvcGluaW9ucyBhYm91dCBpdCwgSSB0aGlua3MgdGhlIGVz
c2VuY2Ugb2YgdGhpcyB3b3JkIGlzICdzb3J0Jw0KPj4+IFNvIHRoYXQgcmVhZGVyIGNhbiBnZXQg
dGhlIG1lYW5pbmcgb2YgaXQgZWFzaWx5LiBBbmQgaW4gbXkgbWluZCwgKl9yYiBpcyBtb3JlIHJl
YXNvbmFibGUgZm9yIHJiX3Jvb3QgcmF0aGVydGhhbiAqX2xpc3QgZm9yIHJlYWRlci4NCj4+IA0K
Pj4gSGkgU2lyPw0KPj4gU2hvdWxkIGl0IGJlIG1lcmdlZCBmb3IgdGhlIGFib3ZlIHJlYXNvbj8g
SG9wZSBmb3IgeW91ciByZXBseSwgdGhhbmtzLg0KDQo+Tm8sIHRoZSBwYXRjaCBtYWtlcyBubyBz
ZW5zZS4gSSBhZ3JlZSB3aXRoIEJhcnQgdGhhdCBpdCBkb2Vzbid0IG1ha2UgaXQgYW55IG1vcmUg
cmVhZGFibGUsIGluIGZhY3QgaXQncyB3b3JzZS4gV2UgaGF2ZSBhIHNvcnQgYW5kIGZpZm8gbGlz
dCwgdGhlIGJhY2tpbmcgZGF0YSBzdHJ1Y3R1cmUgaXNuJ3QgdGhhdCBleGNpdGluZyBieSBpdHNl
bGYuDQoNClRoYXQgaXMgb2theSwgdGhhbmsgeW91IGZvciB5b3VyIHJlcGx5IGFuZCByZXNwZWN0
IGJvdGggb2YgeW91Lg0KDQotLS0tLemCruS7tuWOn+S7ti0tLS0tDQrlj5Hku7bkuro6IEplbnMg
QXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4gDQrlj5HpgIHml7bpl7Q6IDIwMjPlubQ35pyINuaXpSAy
MjowNQ0K5pS25Lu25Lq6OiDmnY7ln7nplIsod2luaykgPGxpcGVpZmVuZ0BvcHBvLmNvbT4NCuaK
hOmAgTogbGludXgtYmxvY2tAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyDlvKDor5fmmI4oU2ltb24gWmhhbmcpIDx6aGFuZ3NoaW1pbmdAb3Bwby5jb20+OyDp
g63lgaUgPGd1b2ppYW5Ab3Bwby5jb20+OyBCYXJ0IFZhbiBBc3NjaGUgPGJ2YW5hc3NjaGVAYWNt
Lm9yZz4NCuS4u+mimDogUmU6IOWbnuWkjTogW1BBVENIXSBibG9jazogbXEtZGVhZGxpbmU6IHJl
bmFtZSBzb3J0X2xpc3QgdG8gc29ydF9yYg0KDQpPbiA3LzYvMjMgMzoyNz9BTSwgPz8/KHdpbmsp
IHdyb3RlOg0KPj4+PiBNcS1kZWFkbGluZSB3b3VsZCBzdG9yZSByZXF1ZXN0IGluIGxpc3Q6Zmlm
b19saXN0IGFuZCANCj4+Pj4gcmJfdHJlZTpzb3J0X2xpc3QsIGFuZCBzb3J0X2xpc3Qgc2hvdWxk
IGJlIHJlbmFtZWQgdG8gc29ydF9yYiB3aGljaCANCj4+Pj4gaXMgYmVuZWZpY2lhbCBmb3IgdW5k
ZXJzdGFuZGluZy4NCj4gDQo+Pj4gSHVoPyBJIHRoaW5rIHRoaXMgcGF0Y2ggbWFrZXMgdGhlIGNv
ZGUgbGVzcyByZWFkYWJsZSBpbnN0ZWFkIG9mIG1vcmUgcmVhZGFibGUgLi4uDQo+IA0KPj4gSHVo
PyBNYXliZSB3ZSBoYWQgZGlmZmVyZW50IG9waW5pb25zIGFib3V0IGl0LCBJIHRoaW5rcyB0aGUg
ZXNzZW5jZSBvZiB0aGlzIHdvcmQgaXMgJ3NvcnQnDQo+PiBTbyB0aGF0IHJlYWRlciBjYW4gZ2V0
IHRoZSBtZWFuaW5nIG9mIGl0IGVhc2lseS4gQW5kIGluIG15IG1pbmQsICpfcmIgaXMgbW9yZSBy
ZWFzb25hYmxlIGZvciByYl9yb290IHJhdGhlcnRoYW4gKl9saXN0IGZvciByZWFkZXIuDQo+IA0K
PiBIaSBTaXI/DQo+IFNob3VsZCBpdCBiZSBtZXJnZWQgZm9yIHRoZSBhYm92ZSByZWFzb24/IEhv
cGUgZm9yIHlvdXIgcmVwbHksIHRoYW5rcy4NCg0KTm8sIHRoZSBwYXRjaCBtYWtlcyBubyBzZW5z
ZS4gSSBhZ3JlZSB3aXRoIEJhcnQgdGhhdCBpdCBkb2Vzbid0IG1ha2UgaXQgYW55IG1vcmUgcmVh
ZGFibGUsIGluIGZhY3QgaXQncyB3b3JzZS4gV2UgaGF2ZSBhIHNvcnQgYW5kIGZpZm8gbGlzdCwg
dGhlIGJhY2tpbmcgZGF0YSBzdHJ1Y3R1cmUgaXNuJ3QgdGhhdCBleGNpdGluZyBieSBpdHNlbGYu
DQoNCi0tDQpKZW5zIEF4Ym9lDQoNCg==
