Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D65A6A23D1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 22:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjBXVba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 16:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBXVb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 16:31:28 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16426F821;
        Fri, 24 Feb 2023 13:31:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNAUD7wYnAO+0omtMdW/hbgqcrOtaNAy0DaN3BwQnvaTKnQdZo4wZ/Dr9EpSu4l7hyvzqkxrl3E/mmlu9gfvEC7GI+G9V2jIZd4PmUtm8BNbJgJNHy16vVjOHpGImS5v7NDc1N6kGijkpzxvkrjUqJVCiJQ0wNEio9YNWfUCVN8khoV5tRERhv2JS75F5E+9d7tBhXADYQzpMZoZzvWdvUS8uQs3dpUNaZypTFhDGGpoBO1VC9K0v831RRRlUyg/FK7KNrvm4xT7SMfZbkBTk/gvReXlmxoVtI4+8xUs19J+sBe19aD2tfcz7w9gCILzpTmXCUVGuruopIgdsbFOyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqS8oeGV71caRaj0LyE0CPQL9ptay82IxsaQTQB0IqA=;
 b=jm6f1Se8cCkYJF/pHKVKN/KF9gzwdEs3MYTiOvJd0uxLCw2hx449yUAc9vRTNeFeyrjmwiwREKCQ4KpIwfRcH1utYa1QDJIyeLhZAbavPuZ2IG7BfNlS04ig07q03kb/FJgXKVBNTDv9WP/UiyIZIrrXXNq511XG+62RCHpYPNV1EYbIxpK+E3/MHjfNJZARZg3yaXsnRQkWX/ef2n631s89emnnUrCWs3fnwvPmC91y2aMZloEsGyBJcy76n6CSVueqDsK6qkDdbRbbAWqIZDOWcoS694vOqEJ+6LIgXilz9YbRcCe98fxv9RXFlUxphMu6xl5oxGHeNMbMESuelw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqS8oeGV71caRaj0LyE0CPQL9ptay82IxsaQTQB0IqA=;
 b=e82HqEEZJHrQnsUe6kg4p+bvR/xx+NANZcsnEfKxSA9x2GTG+BpMeTgvi5L9p3ZMubzZY3aJ/o15F8we3qok0KaJsFP3m62tvGUgoAQA0Q0JjB3n4GCI5IF0U/64WVEvfq6rAXQRbq17YM8JNqPFpTIq/O5jA9xsBsi0P5DdHxNiM4io2mCEHvz16JCejibGqVmrVzmY9KWeHAWFU7eowqgJDc20r5u+11nV2ytxN1gDtTptu4va++CZACq+D/E8eCo9rdxPZWJ4zSwEmWjI7Rr4YE9EXotw8+jgT6jcCjzB4R5Pc+LaImhGkbQOpEDFxwdUHLGfv22p4jXbbK7ZoQ==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by CY8PR12MB7490.namprd12.prod.outlook.com (2603:10b6:930:91::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 21:31:23 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::5f35:2f2d:94a4:f7c3]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::5f35:2f2d:94a4:f7c3%4]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 21:31:23 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] gpio: mmio: handle "ngpios" properly in bgpio_init()
Thread-Topic: [PATCH v2] gpio: mmio: handle "ngpios" properly in bgpio_init()
Thread-Index: AQHZSIURrjamuHnB/0+0xZv5lbPT667ekbKAgAAJ2PA=
Date:   Fri, 24 Feb 2023 21:31:23 +0000
Message-ID: <CH2PR12MB3895688618F6465904E7ADD9D7A89@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20230224192021.22591-1-asmaa@nvidia.com>
 <CAHp75Vdz=P=HrjyhT=dQFJt0LmqzBG2Cmw=sCBmU-RCwkQ3uUw@mail.gmail.com>
In-Reply-To: <CAHp75Vdz=P=HrjyhT=dQFJt0LmqzBG2Cmw=sCBmU-RCwkQ3uUw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|CY8PR12MB7490:EE_
x-ms-office365-filtering-correlation-id: 3f7197d6-de95-4a48-6fc8-08db16ae7a38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NAQTXCN2BH6QcofldYH1NnKiK7TseGjqAWMj3FR6jkzSuSZZf7XDUqdAPP58KU4g9h9iC/xZx9jBlDTFUENx2rXe3g0ggS12O+NhSKcyNgxADgNtN52+ousdsAzv1Z7fqOM5lpnmQv4bPfY4tKg3Xri6YSgkLT6UftOf5VL5/YE/W4kKC3j1DwdS2bFjX6qyMwIhGylHKjiJFd7DT7ULxY0RgzpBfDiyusKiD2M5BWwajvhcaoirorxu4ZmcdoJFeuPYDGjbQk4XRT2rmFQheYe1UzQnZHmLl4v4tbcp+i8cI3dP0PJMx4ALyM25Gt3l/xyvSagNIoMvfv64LEd3ad6FFhFv/4CWF5MpRjGOvNkbXILYVf3RNgNnjxO2DZPwtB6BT5JH/xqvg1EhOMnAoekk/6ImbLB57g4PwREXEpcHUrDS9LPDIrrG419ODX6Xegn97d0aUabFpCZUrpNwfqHhuMx+XSBGQhoEWLeNB1ooD1/9O3E4wrZZZrsAMm9Vo6n1B7zQO1rvG1IC8z12SH0EO5A2TERQ1drDZOY94qupN5ueBfgscHh7oy35C+OR/D5P8MjKatvBWc0ax1jr5Vg3tvSpEW30jDExwI4BsX1flZrdJw/kgUKTOtE+B2oAJ2DHHQ2vA68mjhXUzznKlr3Cpc2zwVk1v/cGYyLq5JP108SYwmr1pA2ByqAOqMKN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199018)(316002)(6506007)(9686003)(26005)(186003)(4326008)(6916009)(2906002)(66556008)(66946007)(66446008)(76116006)(64756008)(66476007)(8676002)(38100700002)(54906003)(478600001)(8936002)(5660300002)(52536014)(55016003)(38070700005)(41300700001)(86362001)(71200400001)(122000001)(7696005)(33656002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXNDbHVHMUM3b0xKUlpvTTd5aUVmaUV5S0RmTkxscGl3N1FOa0lMVFo4REpY?=
 =?utf-8?B?ZHZJOWhFSkZVRlZVMVN2N1VxYnc0RFNGc21RSmh2RnpISUlFUFUralMrS3BM?=
 =?utf-8?B?SE9OQldOM3BOYnNySTFyeUVOOUhhV3hEWUdtMUk3K3BGcDNRN1UydnJmMzZk?=
 =?utf-8?B?R29TWXJNdWRvM0RrMUtjWnExRjZ5MlcyZDB3cnpaWG1DVFFHblFheDBsaVRH?=
 =?utf-8?B?NWJxVGxKaG83VnM2dEtUZXF0b0tscTZHMktKSGdqNTMyOWFobmVzVzBxWjNx?=
 =?utf-8?B?T0lRUjdUWXprUndhQU5tL25BTjdEMjlmU3YybWljaHFRcGtBMHNXd3lVQ0pK?=
 =?utf-8?B?TVkrOWhNa25rcGlQOWFGblNCNURmenNwcWE2UkwzUFgxdmN4QVpOeERRNGVs?=
 =?utf-8?B?TUhHSDVjMlRxZSt3MW9adnpHSzVWZis0WHBQTUM2b09MeHYxSXdpZ3ArMVV2?=
 =?utf-8?B?dVB0b3hvZmhmc1dlb0F1YzZjZU9zQ2cxTXFsY3dXalZvcUQ3TWpwQ0tNLzha?=
 =?utf-8?B?U3RZM1FFVVFvTGtsTkNkSlAxUmlLQlpNSG16TVd3RDZndmxWR2lLejhQY0lp?=
 =?utf-8?B?TU9kVWp0aWpkWHJUVlJHRFVhNkNHc2Fwd3BVUVI1V1AyaEYzT2lvalRsc3dr?=
 =?utf-8?B?cDQ1OThzcEw0RlpxRjBiOE5GYUJtMzVHK3JubWkxek81Rlh0MWlqV1NwZXR5?=
 =?utf-8?B?UW9OSHJtSkUySHJQWXpTLzJYWlJtTU4rNis0bUx1ZUUxb2NxbzNOMHF6UUUv?=
 =?utf-8?B?OUxLQWxVc0d1RDAxaldaZWVidkFrTklTbG1ocUJSckZjWitmelZZN240TmJu?=
 =?utf-8?B?eXdHZGhLYkVtWUVmQ0U3Q0lDdVJvYlNrTmdQOGR5RUJkOU9tZGNiNVdCQVBS?=
 =?utf-8?B?d1NWSE9KOFlGdVl6RmR0cURpQkRBajE5NjFibitnL2laamFrV05YbUg2RE9O?=
 =?utf-8?B?eGpCRjFuL0FSWXlDVjdiU2ZkdnZJQVZSRXMzcm0yUkpOUGZWZ2d6S3J6YXE1?=
 =?utf-8?B?MnZ3eG9PelBESHViUkhrdTB5cnJxam10VWVSbWZxOWI4bXVuV3JVVGdGbmRi?=
 =?utf-8?B?a3NsMDFxTHcxRlQ0RUpqWjdjSkJWNEVNZHBXYVcyRmZkRnpqWi84Vm5EalhM?=
 =?utf-8?B?Njd5WUxFTXNMRHRRVWFUYmxlVHJ6ZzZyNnJRczNlSXdHVVJEbjFZYnV4MjJV?=
 =?utf-8?B?U0liaEJURmczbHp0Y1JYaHc2eS9DUVE3bEdoVi9NUGswTUgzS3B4aVRuMVhP?=
 =?utf-8?B?N0F5VmNsSmJuaEJpZkd3Wm8rTXg3dm5mRzNQdDhKSWRLWDNNb0VlWFVYNVF0?=
 =?utf-8?B?UExkV0pNSkN2NlY3MWNuaWgybEF6MkJUOUNsbG1mRTJraFdVaGREWFVHdXZz?=
 =?utf-8?B?SHl2aDNLcnAwYWoxcXNWL20rcEdNaWZNTXluREIvelZhN09TemZOQ3c3MXpF?=
 =?utf-8?B?MjRNekl6eGxYK0hoNHdYUE5nZVhQYzhxbWZQdGQ4SzJNSVE3bFNyNXYvSzFh?=
 =?utf-8?B?VDNjRkRCcGJzVTl3MnFiVkNJQkFlUEtnUlV1SjZsaWkraDliRnhIbTdPMTNJ?=
 =?utf-8?B?dWpPdTRuczAxL3BTRUZtd0ZKckU3bmtzeDMxRkkrNWVjQjVvd1pUOEltdVBh?=
 =?utf-8?B?a1Y3bTZ6Vk5YNExhVkhuYlg1NDFvajBCalM1QjYzb0xiQlRLaUJ6K080OXNR?=
 =?utf-8?B?QmhXUFJIYUpqZ0ZreWtESkoyQ0kzUm9iMTM0L1h1R0IxOUhiVk9yODAxRHJl?=
 =?utf-8?B?ZWdCd1owdTFHWjg2MWpEN20yMGlUK2IwK2tuemhOSSswb0JWYXMxdVJnK0pu?=
 =?utf-8?B?T2h5U25zVzJpeXlJRThxQ1pRVEYwZjMwU2tkcjVIVzNiN0R5Y1haQndSWFZT?=
 =?utf-8?B?RzBWc0orL0FhZTNsdUZ3SXZGOEdKNCtFVXBrZ2lrbFVJN3BEV2FGaGxyOUtX?=
 =?utf-8?B?UEdnMEhMSERmYUYwbDBNME9OUmxna25UNzZpVTlZbk13RWR2c3ZmOVNDVEs2?=
 =?utf-8?B?VTJVNVdBcG9TM3pmdHNuSDdWVkUwaXJ2Zm5iM0ZPYVhyY0prdlVOVkRDRmtV?=
 =?utf-8?B?cWlNczdiTjZRckFzaVRmbldzbWRCYUUyTWpycFBob281Z2ZYWU95SG1hOXFC?=
 =?utf-8?Q?u6ak=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7197d6-de95-4a48-6fc8-08db16ae7a38
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 21:31:23.3071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ptug8KifHPzuK6fueg1cLSRTA5L7XvdiohO88BL5wt7Sl1U3Ax0FjjhY1qPKhDiIGL3meYxJql4hgs1aDkM8YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7490
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IGJncGlvX2luaXQoKSB1c2VzICJzeiIgYXJndW1lbnQgdG8gcG9wdWxhdGUgbmdwaW8sIHdo
aWNoIGlzIG5vdA0KPiA+IGFjY3VyYXRlLiBJbnN0ZWFkLCByZWFkIHRoZSAibmdwaW9zIiBwcm9w
ZXJ0eSBmcm9tIHRoZSBEVCBhbmQgaWYgaXQNCj4gPiBkb2Vzbid0IGV4aXN0LCB1c2UgdGhlICJz
eiIgYXJndW1lbnQuIFdpdGggdGhpcyBjaGFuZ2UsIGRyaXZlcnMgbm8NCj4gPiBsb25nZXIgbmVl
ZCB0byBvdmVyd3JpdGUgdGhlIG5ncGlvIHZhcmlhYmxlIGFmdGVyIGNhbGxpbmcgYmdwaW9faW5p
dC4NCj4gDQo+IC4uLg0KPiANCj4gPiArICAgICAgIHJldCA9IGRldmljZV9wcm9wZXJ0eV9wcmVz
ZW50KGRldiwgIm5ncGlvcyIpOw0KPiA+ICsgICAgICAgaWYgKCFyZXQpDQo+IA0KPiByZXQgaXMg
bm90IG9mIHRoZSBjb3JyZWN0IHR5cGUgZm9yIHRoaXMgY2FsbC4NCj4gDQo+IFdoeSBub3Qgc2lt
cGx5DQo+IA0KPiAgICAgaWYgKCFkZXZpY2VfcHJvcGVydHlfcHJlc2VudChkZXYsICJuZ3Bpb3Mi
KSkNCj4gDQo+ID4gKyAgICAgICAgICAgICAgIGdjLT5uZ3BpbyA9IGdjLT5iZ3Bpb19iaXRzOw0K
PiANCj4gLi4uDQo+IA0KPiBUaGUgcHJvYmxlbSB3aXRoIHRoaXMgY2hhbmdlIGlzIHRoYXQgeW91
IG5lZWQgdG8gcHJvdmlkZSBiZ3Bpb19iaXRzLg0KPiANCj4gU28sIGlmIHRoZXJlIGlzIGEgcHJv
cGVydHkgd2hlbiBiZ3Bpb19iaXRzIHdpbGwgYmUgdXBkYXRlZD8NCj4gDQo+IFRoYXQncyBzYWlk
IHdoYXQgeW91IG5lZWQgaXMgc29tZXRoaW5nIGxpa2UgdGhpczoNCj4gMSkgc3BsaXQgIm5ncGlv
cyIgaGFuZGxpbmcgY29kZSAobGluZXMgfjcxOC03NDQgaW4gZ3Bpb2xpYi5jKSAgaW50byBhIGhl
bHBlcg0KPiBmdW5jdGlvbiB0aGF0IGlzIGF2YWlsYWJsZSBpbnNpZGUgZHJpdmVycy9ncGlvOw0K
PiAyKSB1c2UgaXQgaW4gYmdwaW9faW5pdCgpIGJ5IG92ZXJyaWRpbmcgYmdwaW9fYml0cy4NCj4g
DQo+IHJldCA9IG5ld19oZWxwZXIoKTsNCj4gaWYgKHJldCkNCj4gICAgIGdjLT5iZ3Bpb19iaXRz
ID0gc3ogKiA4Ow0KPiBlbHNlDQo+ICAgICAuLi4gPSBnYy0+bmdwaW87DQoNClNvIHRoaXMgbmV3
X2hlbHBlcigpIHdoaWNoIHJlYWRzIHRoZSBuZ3Bpb3MgcHJvcGVydHksIHdvdWxkIGJlIGNhbGxl
ZCBmcm9tIGJncGlvX2luaXQoKSBhbmQgDQpGcm9tIGdwaW9jaGlwX2FkZF9kYXRhX3dpdGhfa2V5
KCkgY29ycmVjdD8gU2luY2UgdGhlcmUgYXJlIHNvbWUgZHJpdmVycyB0aGF0IGRvbuKAmXQgdXNl
DQpiZ3Bpb19pbml0KCkuDQpBbHNvLCBzaG91bGRuJ3QgImdjLT5iZ3Bpb19iaXRzID0gPSBzeiAq
IDg7IiBiZSBpbmRlcGVuZGVudCBvZiBuZXdfaGVscGVyKCkgZnVuY3Rpb24/DQoiYmdwaW9fYml0
cyIgaXMgZGVzY3JpYmVkIGFzICJudW1iZXIgb2YgcmVnaXN0ZXIgYml0cyB1c2VkIGZvciBhIGdl
bmVyaWMgR1BJTyBpLmUuIDxyZWdpc3RlciB3aWR0aD4gKiA4IiANCndoaWNoIHNlZW1zIGRpZmZl
cmVudCBmcm9tICJuZ3BpbyIgZGVzY3JpYmVkIGFzICJ0aGUgbnVtYmVyIG9mIEdQSU9zIGhhbmRs
ZWQgYnkgdGhpcyBjb250cm9sbGVyIg0KDQoNCg0K
