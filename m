Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56ABD638597
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 09:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiKYIyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 03:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKYIyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 03:54:50 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2041.outbound.protection.outlook.com [40.107.113.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E1A30555
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 00:54:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QreodXhWPMznkbNjE5tunTjNZSwJuJlAG7lUaaqLtOIV32qt/dohSqysPR6SloQkMU+hbi/SxYhKHiDNbn8oVkkqhiYM5T0hwQWyFLNuCQVsmNH6LcAzDyhg+7GLjPt/9pdZynLSkiMFs7g/tQ38lh+Z2LAh2u60eAsLdvIhmeN6qGoAJ0SU3MCEEk5mqm81TGd/ipMXY9SJlCs6nmgi9ZkJIO4GLZG5unkME7xN4tywVMT+5nVBDFNHHvZydgwj2YrdSUqe/3vR+b+LrzDj7u5+B1yuNPqcQWxnDgV+o9D45jM3dwEetefRIBaiS6JIo6Js8Ku4Rcbi/x79jmp3Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmtFgwyLWd7ja1B198p+KEWcDTCz7k4hIeJU/pgdubc=;
 b=ZFVqwpw7KXCg9UTOkRegupfg0xy0iUNQEzQsi9rhEHi6UNi3tUI9hqV4LWTn4FVHX0nWv7b3j3JcQUdhR0pD8fZ0dapa2wDoWV+bdG9Ecp9eRzYBnI7aL/eSoBL1SH6wSRGbPlNacupPS9gIQrARxz5dMXr8keWyAlGHtil2Kl2O9pL91GhZyCz/3wYq2T+hL/lJev6hJE/QH6R30TtydiTPPdbELxdxEbKf9NEnSj2AOXGxt/KZgPMhRtgSVEbISIPJPCdkO1CI16dRgD2jGr2++dF52U5lsAxy7PIHXfA45mauCbb5f5Y2wsUtbtEqWJ6JfF2wOIQz7ib/7rS8TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmtFgwyLWd7ja1B198p+KEWcDTCz7k4hIeJU/pgdubc=;
 b=iNniRGzrP78JzLKMy5GCdemev3eN3tt6FWN2LWPUZHeWK0zoWKMW5NrbVRdXVRDU3HY8lcgI5tPRbXv3W9ebVgSY6rWLi4k8TA4aYYUNeVsDsbqcTtgh0BIjsgYzOjZH8NrbjqJ2dj8CM8yfaUub6149sWSjLfVFLysG9Dqv3X8=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYCPR01MB6240.jpnprd01.prod.outlook.com (2603:1096:400:78::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Fri, 25 Nov
 2022 08:54:47 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::d8db:df00:40e5:2c5b]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::d8db:df00:40e5:2c5b%9]) with mapi id 15.20.5857.018; Fri, 25 Nov 2022
 08:54:47 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Wupeng Ma <mawupeng1@huawei.com>
CC:     "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "pizhenwei@bytedance.com" <pizhenwei@bytedance.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next 1/1] mm/memory-failure.c: Cleanup in unpoison_memory
Thread-Topic: [PATCH -next 1/1] mm/memory-failure.c: Cleanup in
 unpoison_memory
Thread-Index: AQHZAJrXquiJJuGBoUuykQaBhQfOkK5PVeoA
Date:   Fri, 25 Nov 2022 08:54:47 +0000
Message-ID: <20221125085444.GA1230393@hori.linux.bs1.fc.nec.co.jp>
References: <20221125065444.3462681-1-mawupeng1@huawei.com>
In-Reply-To: <20221125065444.3462681-1-mawupeng1@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|TYCPR01MB6240:EE_
x-ms-office365-filtering-correlation-id: 2de8a399-077d-4c01-7bd3-08dacec2b463
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EgDd8ka3BtUdSrvl9b3EVmz5kOpR83caHmCMlcrg/GAo4dTrSS8YLMwnqftrJeht2g9sW8EvsG4woaF2v2VEjQaVIjH36V+OB5H/IP0/+cgigTwu+PyknVGebMzaC5vrwLa+nMHZxSynqqT9cFEBOdTDacPZoF3LhP7InIjVGN/ilJe29m0jWd4GuvGYgMGeVSPAYQ8xM3Y/Tnz4RPyCVUhi63QX4of6F0u7PcgFVLWLmynQe4WGYrOfLVE/gDDOn8Eayvd4X8wVTIRaAdoYulMgmnpt2riImiXSz8wDHbwbqn6nVHuWG1PblHdUYsC0ZpSM5QkAazJOf7x7laFCU2mL1d+vg+WkX4kqqsWMEVsieGLF7atht28NbHBMT0IxGeFNn3QtE48+D6bN1onIxaWroJYIqQqzQ/+Cp3XvkJFNSrPmN6Reu8MV8W4wLLs3Tp5ImxQKAYDSv5/Q4PNZeZ6VAm7yaMXd62XCVGmD6dnCTlOTGEsfk5Ob6jk//VLmmJt7lMfk+wdMDe8/bcgyYzhTRegyr/WbzA4jAEOBOjHy3LlG/MkKPVLDrG7W99vvUYgZZw6XawLdUUnnFWHMdzUwRSBpw/jtmsxRxiConef3hbdVMB5HVPWSzQ/X0IUtf6cLHtpPEwylh9mHnv3rn6+aO0+RZJNfnYYYgnvtoOBLd0z3qYpiQ4dKW0M9g/APZoMVcUhtrkG5O8yJbbPuJxW2DLJwVLprzFpvlhNM3cg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199015)(86362001)(33656002)(85182001)(38070700005)(8676002)(66946007)(66446008)(66556008)(66476007)(64756008)(6916009)(71200400001)(4326008)(76116006)(122000001)(82960400001)(38100700002)(478600001)(1076003)(6506007)(83380400001)(26005)(9686003)(6512007)(41300700001)(2906002)(8936002)(316002)(54906003)(5660300002)(6486002)(186003)(309714004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVZ1UW1uV21ESnpNK0lNK2tHYkxweTMwN2ZPRVpJOTRJQjJuNWYwTmFteHJy?=
 =?utf-8?B?VzJUM3B6cFBEWjhZbDRWTDV3RFRzMFJheGlFNzN5SEwwdHFScHdIYTdCcHVF?=
 =?utf-8?B?WWNrR2wzOHI2cjRKbmJNZWtIUko4dE8vN0VyYkpGdFk5L0t5Z0tWMmJWdGU1?=
 =?utf-8?B?YjNTazE5OCtpUGZBT1ArcUtWTGpUeXd2NnJDMlNlSXhTTUgwTUQ1TXY5YkRU?=
 =?utf-8?B?ZWNhdlBUeDFyZGRLaXBLY3NyV0FKbnFEM0huTGFRb3RSMnZmT3BPMFVES1hj?=
 =?utf-8?B?VWJSNFFVOXYrby82SHh5V0J2RGdKRHROVFFHUDE4UkQ0N3I4cFdOMUY5SmZK?=
 =?utf-8?B?ZzE1ajJNTlg3Vm85Qzc1TER0WXYrYXo1YXdVMTFjcVphcGJBdCs4L0pPdC8y?=
 =?utf-8?B?M1NGSmFadjB4RTBtVzE0QWgwL1BpVUYyRFl5T05PR3R5NDQyZ1Q3NDNIZ2pp?=
 =?utf-8?B?am1rVHRGVHNoT0VUT0RjK0ZhdDdEaWx4NGRJazU3ZW56WGxORHVYNXdZRjQ4?=
 =?utf-8?B?djNSOFAvVGsveFJ2Z3pTcWhBS2g2aEEzRUhpNG1oc0xFbDVRRW5yVEwyWTFt?=
 =?utf-8?B?L1E5TE01eFVBdjRpT0N1azQ1WXBjMGdscVpYWDNDaGtsN0NHU1czNVdneWRE?=
 =?utf-8?B?N1pOVnh0dkM2bXZhQURuS2ZGZnNvem5XRmhnWWc5NlZSc0dCQ0FOR1RqeURa?=
 =?utf-8?B?RCt3UTQ1NHVxbXlQTFVuaHRDMThjd2tsOHRGU0dVcTZ2cXQ5Zng4NFN2T3lD?=
 =?utf-8?B?QkpvRmtqR0JCRWdUUE9OZXA2a3l1MjhpSUlvTDhSYUNzOTRIWngwL01Wblhh?=
 =?utf-8?B?OHdxdDRBQWZRTHhkcnVnTThTM1BkSGRWVlQ0Slp4U3FKUWRyejZFVFZ2c3pi?=
 =?utf-8?B?YVVubGl6M2RPTlhkVjRmUDBvM3ltTzJPTHRLQ0lQTGNuVlh4VURscDYxQUNT?=
 =?utf-8?B?WUtpdnF4djRRRWFCM3FTQW5IS1Z3TmNCdnZwcUxBRm1VTFV1Y0VqSzlGL09Y?=
 =?utf-8?B?dndsQ2YrVjlRZC9aK2xxVHlOeDI3MEVHalBMR0E5aDI5QTI5TDZaNmhqUWZE?=
 =?utf-8?B?Y0thQm5lVmsrK1V6UHVTSkVQKzVKSDhSRDlobDZjUG8wMWtOYVJnSkdha3Ev?=
 =?utf-8?B?RkF0bVZJVlNhM2tjSDA3a2R2L01CZEVlTTZnMWlGZlhQK3FBcm0rM3lUQ0FB?=
 =?utf-8?B?azB5VDc1OHZxYnlyUUtmMkFmSWUxak4zR2NzYW1ZVkRnQ09waE5GcVRxK0Zm?=
 =?utf-8?B?Njd2UUN4QlQwVlgxRGhkUXd1bkhYWHkvU0NEZ05lYStXVDNCbU1nYlNaL3hP?=
 =?utf-8?B?SlNEalpBSmZtV2VyN2thc1pIVWdKZDkwWmtoend4eWQwYmt0Q24vTVg0MnRa?=
 =?utf-8?B?dytSck5NYmJpOVNRN3Bjd1Z0bWFzQlpTZ1p0bHN5cTZwaVZxZDMrVklXL3Er?=
 =?utf-8?B?ZVJtMTlCZlVKRFhrYzBiUTRBdzRrUmpUeGhmdGJkR0VWWUNyaXVEWG9kV3lx?=
 =?utf-8?B?R1FEa1F4T212VERKcFZxYTNZcm9Td2tjREJNM1Q1ei9XQStqL2RKcUZVR1Rt?=
 =?utf-8?B?ZXNUVEtZSUU3enduU2dqeG9SajhCdzRyRSs4cStsblBDTmZtSnkwdE03Nyty?=
 =?utf-8?B?OE1DYldpUm8rZjN0WjNybHRCNXloQnNRZlNEcFRiZVlvbndVaWt5NVdHcWR5?=
 =?utf-8?B?aFYwTE1LRHBaamtBY3dleTV2MG5ScFZ1TXBmRk5ZN0tUS3RicFpDVENCNlM5?=
 =?utf-8?B?WjJEaEhNQXNXL0ZNZStHNi8xaitnTEVoK1lrUG9ZanZMakdlTzc4NyszRHJo?=
 =?utf-8?B?OHpxWUFranpNWWlxU3NwekErYXhsL202Wko1VWNuMXE3WUp1THZuNjh5RlR0?=
 =?utf-8?B?dVZDRDFVSmZmZitwZkZ3V2xhaGNhNWVyLy9Xa0gzbnlnbE9ra2VZaURMTXJk?=
 =?utf-8?B?RHhndnA4RGw3S25kNlhiT0FwNWxPdlpRemdvR3puYWRzMkdxUFpuRTFYRjRk?=
 =?utf-8?B?THZISkp4YWZKUCtpekNodW4rbjZsR3VkRmRtdVkwczZhcEVVV3AxNktQN2ZG?=
 =?utf-8?B?VWVFdlBUeUVTUGVob2g4NUhrS000UVJJdUZ0TEwwZG5IMjRHditRaGNSeWg5?=
 =?utf-8?B?SlpNb2ZJSnoyajBrZkpWK0JxTzlKSE1FT00xbUMvNTRLZE9pVk1QTlM2NTNo?=
 =?utf-8?B?VEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ECEA3E5D928BE34A86F1CD316AA60EA0@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de8a399-077d-4c01-7bd3-08dacec2b463
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2022 08:54:47.1105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1fWGnf9i0IzXIZAIjoaOZveKOpqyR40DZ6iv3zpcH4jZ3ZC9Mte+P8n5656qtztqRrnnZybZnsmXGHAp2Pt+cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6240
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBOb3YgMjUsIDIwMjIgYXQgMDI6NTQ6NDRQTSArMDgwMCwgV3VwZW5nIE1hIHdyb3Rl
Og0KPiBGcm9tOiBNYSBXdXBlbmcgPG1hd3VwZW5nMUBodWF3ZWkuY29tPg0KPiANCj4gSWYgZnJl
ZWl0IGl0IHRydWUsIHRoZSB2YWx1ZSBvZiByZXQgbXVzdCBiZSB6ZXJvLCB0aGVyZSBpcyBubyBu
ZWVkIHRvDQo+IGNoZWNrIHRoZSB2YWx1ZSBvZiBmcmVlaXQgYWZ0ZXIgbGFiZWwgdW5sb2NrX211
dGV4Lg0KPiANCj4gV2UgY2FuIGRyb3AgdmFyaWFibGUgZnJlZWl0IHRvIGRvIHRoaXMgY2xlYW51
cC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hIFd1cGVuZyA8bWF3dXBlbmcxQGh1YXdlaS5jb20+
DQoNCkhpIFd1cGVuZywNCg0KPiAtLS0NCj4gIG1tL21lbW9yeS1mYWlsdXJlLmMgfCA2ICsrLS0t
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9tbS9tZW1vcnktZmFpbHVyZS5jIGIvbW0vbWVtb3J5LWZhaWx1cmUu
Yw0KPiBpbmRleCAyZTYyOTQwYzdiYWUuLmM3N2E5ZTM3ZTI3ZSAxMDA2NDQNCj4gLS0tIGEvbW0v
bWVtb3J5LWZhaWx1cmUuYw0KPiArKysgYi9tbS9tZW1vcnktZmFpbHVyZS5jDQo+IEBAIC0yMzM4
LDcgKzIzMzgsNiBAQCBpbnQgdW5wb2lzb25fbWVtb3J5KHVuc2lnbmVkIGxvbmcgcGZuKQ0KPiAg
CXN0cnVjdCBwYWdlICpwYWdlOw0KPiAgCXN0cnVjdCBwYWdlICpwOw0KPiAgCWludCByZXQgPSAt
RUJVU1k7DQo+IC0JaW50IGZyZWVpdCA9IDA7DQo+ICAJdW5zaWduZWQgbG9uZyBjb3VudCA9IDE7
DQo+ICAJYm9vbCBodWdlID0gZmFsc2U7DQo+ICAJc3RhdGljIERFRklORV9SQVRFTElNSVRfU1RB
VEUodW5wb2lzb25fcnMsIERFRkFVTFRfUkFURUxJTUlUX0lOVEVSVkFMLA0KPiBAQCAtMjQxMywx
MCArMjQxMiw5IEBAIGludCB1bnBvaXNvbl9tZW1vcnkodW5zaWduZWQgbG9uZyBwZm4pDQo+ICAJ
CQkJZ290byB1bmxvY2tfbXV0ZXg7DQo+ICAJCQl9DQo+ICAJCX0NCj4gLQkJZnJlZWl0ID0gISFU
ZXN0Q2xlYXJQYWdlSFdQb2lzb24ocCk7DQo+ICANCj4gIAkJcHV0X3BhZ2UocGFnZSk7DQo+IC0J
CWlmIChmcmVlaXQpIHsNCj4gKwkJaWYgKFRlc3RDbGVhclBhZ2VIV1BvaXNvbihwKSkgew0KDQpU
aGlzIHJlb3JkZXJzIHB1dF9wYWdlKCkgYW5kIFRlc3RDbGVhclBhZ2VIV1BvaXNvbigpLCBidXQg
d2hlbiB3ZSBydW4NCmludG8gdGhpcyBlbHNlIGJsb2NrLCB0aGUgdGFyZ2V0IHBhZ2Ugb3IgaHVn
ZXBhZ2Ugc2hvdWxkIGhhdmUgcmVmY291bnQgPiAxLA0Kc28gaXQgZG9lcyBub3QgY2F1c2UgYW55
IGJlaGF2aW9yYWwgY2hhbmdlLiAgU28gSSdtIGZpbmUgd2l0aCBpdC4NCg0KTG9va3MgZ29vZCB0
byBtZS4gVGhhbmsgeW91IGZvciB0aGUgcGF0Y2guDQoNCkFja2VkLWJ5OiBOYW95YSBIb3JpZ3Vj
aGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0KDQo+ICAJCQlwdXRfcGFnZShwYWdlKTsNCj4g
IAkJCXJldCA9IDA7DQo+ICAJCX0NCj4gQEAgLTI0MjQsNyArMjQyMiw3IEBAIGludCB1bnBvaXNv
bl9tZW1vcnkodW5zaWduZWQgbG9uZyBwZm4pDQo+ICANCj4gIHVubG9ja19tdXRleDoNCj4gIAlt
dXRleF91bmxvY2soJm1mX211dGV4KTsNCj4gLQlpZiAoIXJldCB8fCBmcmVlaXQpIHsNCj4gKwlp
ZiAoIXJldCkgew0KPiAgCQlpZiAoIWh1Z2UpDQo+ICAJCQludW1fcG9pc29uZWRfcGFnZXNfc3Vi
KHBmbiwgMSk7DQo+ICAJCXVucG9pc29uX3ByX2luZm8oIlVucG9pc29uOiBTb2Z0d2FyZS11bnBv
aXNvbmVkIHBhZ2UgJSNseFxuIiwNCj4gLS0gDQo+IDIuMjUuMQ==
