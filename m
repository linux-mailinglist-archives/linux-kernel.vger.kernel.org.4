Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DDF6BDD9B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 01:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjCQA3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 20:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjCQA3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 20:29:30 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2059.outbound.protection.outlook.com [40.107.114.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CD859E8;
        Thu, 16 Mar 2023 17:29:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhqNt/gok4nAI3zE0a2yIwIn9Mda1Fsta5j7wDs2u72gXls/6WEm9J0Ihx3PNg+Iw55Q/E0FIDm+ld6W+DYQDRY/D5mLOi3T8r8nWzdppXSth0AI2l2g+rYGlDv/DO3Q70IFKhf129PVONc0/fdonTqesMo9cFc020aPWHD26OGiyk+JJPAGS2XhFKUeyobuXpjv2AmG0W2JW9S+oNgEMAXW2fH4A5PSdwFSrKSvIyukGCtGwT5zhVIthUuH4C3eIagk/ofY0QzIXZqOyUN6pHMoCOUqydZoKV7AHe7PrlnLhogISaAvqsM0p9UVSU4bnjqQaEPwstiZ+EBEMVCHaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfSyi+6+7huyL+b+KHlF+nXVejS9gICCbhK2xmram/M=;
 b=leuKzoSoBL9TB4Gi3KGiCtmvRUTxXeXe9/7Jfp6Fkf5l2jO5p0vTuUxX9xKG4JDj4InROe+nqxwsLqPF5U7W6zmhy63wiM6sIBNkbebUoKXJlsLLsc8jwSNSlWYE4eWkxk7x8WjjZFG2MdGrurknt50xQQySc9HSpdKrKzbBJpnw+l2YTZX283EPlFgfGHC0I5sWMpuf3K69zGqIenz8DQDOho765Wt3066xoAcxAZnDgI1b2sAT2YNSQWvQfWD4AvNW0lF+CEubYF1DP/mRU8sxwZANLs6faJTWns78ZM6zJko2Anr4Hf2dHHcoX69hYxh5SxR5+m6hsaEF8MaZkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfSyi+6+7huyL+b+KHlF+nXVejS9gICCbhK2xmram/M=;
 b=fzdcFFMvVsJ3dsuvY1VMeTvSxuI0w8Hah7HkvSYgYkvJ2+3bgTQ1RQ+0BkJFtvroalaBmmNyPVamD6dAYrHMA1pvIlnUpzWy16hReKB8cHXjqdATR05gHB2ol3iPRE0gxWyvhwmYDG6Qe8GngEJ0kBB39tDdG8gH1Yy8FcIw+IE=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OS3PR01MB10407.jpnprd01.prod.outlook.com (2603:1096:604:1ff::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.33; Fri, 17 Mar
 2023 00:29:25 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::3924:5b48:7ad7:ab0]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::3924:5b48:7ad7:ab0%9]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 00:29:24 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "xiexiuqi@huawei.com" <xiexiuqi@huawei.com>,
        "lvying6@huawei.com" <lvying6@huawei.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cuibixuan@linux.alibaba.com" <cuibixuan@linux.alibaba.com>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "zhuo.song@linux.alibaba.com" <zhuo.song@linux.alibaba.com>
Subject: Re: [PATCH v2 2/2] ACPI: APEI: handle synchronous exceptions in task
 work
Thread-Topic: [PATCH v2 2/2] ACPI: APEI: handle synchronous exceptions in task
 work
Thread-Index: AQHZSmjf8tRHDMQWe0qCot6AHA4QcK79Gx4AgABABQCAAN8VAA==
Date:   Fri, 17 Mar 2023 00:29:24 +0000
Message-ID: <20230317002922.GA407956@hori.linux.bs1.fc.nec.co.jp>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20230227050315.5670-3-xueshuai@linux.alibaba.com>
 <20230316072148.GA364378@hori.linux.bs1.fc.nec.co.jp>
 <8cd8688e-99f9-0696-c6bc-1c3ce44eec55@linux.alibaba.com>
In-Reply-To: <8cd8688e-99f9-0696-c6bc-1c3ce44eec55@linux.alibaba.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|OS3PR01MB10407:EE_
x-ms-office365-filtering-correlation-id: 5f9dc439-7e8f-407e-b939-08db267ea929
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M5m0VDGvBYgc9Mc2uVosOawq4kQEH9H/eAQxQjLWQxcqce5Zh8lnIEhlPA+Vso18vUwLPbBoYLtbOO2vLClGfgQUG872c9dvISyackZSG2BpJExn/qip5kEHq2MP8Weg+ey7KkIUdeStB5NcYpBpGam1Dwcri07uupbHvNVIEJ3057J/9kbH51J+xRFIcMQC0PjCJmqiOFutWPpB8IscCjYWl8A/dwrZP2GEtDDH2HygGDzAA7TXDK1gGvcD6uoSoULzKZbs3Qo6pHNJNACg/cEXshQ2nytLdq8HLR+Ege3rVe1jWdJ4mBqJVO7yzKFxM31GtiOptqwJEoH3ByCeGSpExEhEVscZIy5XE4uozAZFwjO44yN03OEwRarCtt0KjZZmLDn2vXyXSWNVtDZaaZsUxlgey397dIBA4xozZKI++pCI5sZMEnhIv3VUCdFphdzQTLGG7XDGXPzxtdTFut37xRdIFYpY/vByEq636p4jUwFBsAL5WPSOVXmlLYPO7i2duu09yrAWLjMOCr4cqxdssM6o8wfOlSdFtFBHd3Jw83dNsSPcA09BHaYfZhtadO8E1zEn013uIi/MWbXgYhV8UDBKMQvkAhOb3pc/p+Q+R0u6wH2fmi8WEgjC1D/ZZjLiU785AChpQNeV4GXKGrMS/g+XmdDBY3fIyKkQOejPfy2A5MfYkjHwfLKF4SLv6bJqL5xXD6l2C9uGf2F66A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199018)(122000001)(38100700002)(71200400001)(83380400001)(85182001)(33656002)(64756008)(76116006)(66556008)(66476007)(316002)(66446008)(54906003)(38070700005)(8676002)(82960400001)(66946007)(6486002)(5660300002)(186003)(26005)(1076003)(9686003)(6512007)(55236004)(6506007)(86362001)(478600001)(2906002)(4326008)(8936002)(41300700001)(6916009)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUhCTkZURDUzOG1oRFdRbWxMaWlYYUhtWUpxSnllNjZIVkwwbHVwUWJKMDIy?=
 =?utf-8?B?OHpNb0JORWtWTlliTTBROWxXeUVrMU55ZDUxT0gzSFo5LzhzaG0wVHNBZm9K?=
 =?utf-8?B?WEpVYUQxT2toNW12Z0NhWWpSZlhSZ2dSOVhBWHArb0pKVHk2K08yRlhEdXRR?=
 =?utf-8?B?MXZGcy81dEovWDBucmF3eURma2RmbG5OZ0UrdXpKcXZoYUFjd0I3eVZhaktE?=
 =?utf-8?B?d0loemhQUUp4QzhmS1drZFBCUGxaTWNvWU11Nmt6YVJGVC9LVWZ2ZDlLOUNr?=
 =?utf-8?B?TVFIeUEzVDU5TUwvVWJYdHgvN1BHNVh1c3VXWWlSQk5UZ0h4NGsrdUd0UzF5?=
 =?utf-8?B?d0R4NStYbFFxOEltdGRiUGVYWUZ6bklYaHlUZ0xhUURvZVF1MWxYVkRjUHJ5?=
 =?utf-8?B?WmM2U05yY2xzVnU2OW42ZnlTcmM0bWdiZXFyZGdBRzJ2eklMWEhSdzk3T0tF?=
 =?utf-8?B?S0gvbUpkVE45QjBmblpWUDVITElHaFgydzVNU0wxWFJFU0Z2ZTdRSTFjSEh4?=
 =?utf-8?B?cEVwaXVmNERzWTY1cS9mQ25MRStwdi9HK1M0ZDQyT1pscmJOR1M2ZFpVQlRX?=
 =?utf-8?B?QVpWK2NpczIzV0VXUzZhTHpTaHk2aEpWQlVIektONEp6TE92OWJqd3Nnendk?=
 =?utf-8?B?WFhUOEgxTC9Yc0Z0VkpMMVE4K0dydWhJSEsvVFY3dlorQUpod3o2SlQyWk9o?=
 =?utf-8?B?ZVQ0ZFFZdUJUM3FUQzJST1lxV0lmeVIvL1dXMmdxREQ5Z1o4SjVsSnJ3WXU5?=
 =?utf-8?B?SnJMWUpDVVd1dUVWMEVwRmRLTXB6c1lRdGJ2ZzU4YVQvMXh1dUkrQW1zUm9B?=
 =?utf-8?B?akN0ZkdzVU1VcXdXYXFaZUhYekpBZzdrOWRwNVBlMTliRzJwUnJ3QklkWVNR?=
 =?utf-8?B?ZVJ5bStsTlJ3TWpLUkJCZFBtWS83NDVHZHF5Y2NScTArbHBTc3BpN3RNMitZ?=
 =?utf-8?B?YitBNU9lZWJnNHZnanBjSXM0Y3l5Q2ZFeUt5UE9EMy9RZWxSY2JzR0pYY3Jw?=
 =?utf-8?B?V3NyM0xnY2Y0SS8zOG9paWdZemZJa3FaNkJXdlpBRmNTb1dkRmZaU1M1c0tS?=
 =?utf-8?B?cGI1TmcxSm1Cdm43SmlwNjEwZ1hMYkdPVndLRklJY0JNM1ROL05uRU5qNDRN?=
 =?utf-8?B?eEZBYjNiVzZvSERYZXYyQURDUWZLZVNkYld4Y0h6bVJkRG1oZ0FpSTUyV2pv?=
 =?utf-8?B?TThIMllnODVIZ0haTnlqNUwvbGRqa1V0Lzg0YXowdVJYakZCS2tYQlVEeWty?=
 =?utf-8?B?cmZMbFg1L0hUU3hlVkR0RDl6VDVFYmlPb0IxNVlYSUVIdUpxTDBEa0hoejdN?=
 =?utf-8?B?UU1adVNFTWZsdzlsdkE1NkYyMGIwQUt6elA0R1pMM1V6dkVjSkplYk1Lb0Fj?=
 =?utf-8?B?cjU3UFo0NElYUWloZ1Z0djNPKzN4OThyQnZIRG1JZUZzdW1CUU91LzRGN0NX?=
 =?utf-8?B?VzBNcnMrMnNkRUVWNzNRUU1kTUFrVVFjY0FiSnZhSm51d0pEY3dhS0VTbzlM?=
 =?utf-8?B?NEowRTQ1eDljOGhUb1I4VHdoQW1ubEVaM0ZpU210U1dlaGRGL3d6ZXJERE9v?=
 =?utf-8?B?NDFBT0xCdW5JUEdIY2RTNEFMVERXSUlvUnNQZVFaaFRpNWJteGYxTDNlVit0?=
 =?utf-8?B?MTM3c2U0emZHRGFXS3M5MlY2R1ZPL3pySDR5TDNlOXdEYjY4RVlZMHJjODBn?=
 =?utf-8?B?cE9USmM1UmVqMmFqZlkvbmlaRU84U3I4anlGY2h4R1AvWWdleWVLOGpVdlZj?=
 =?utf-8?B?TDFyL2ZUVktBSFkzdHdHZk1CRzllVnJqZURTd2E0UGVSTE5tNmczSndLLzJ3?=
 =?utf-8?B?RHVnb0hnYzR1akZ4Yy9aZ3M2TmV1RXpCcnJaUzZkNFgxaFYreEJETm4vYndM?=
 =?utf-8?B?elhwc1BWejZkRDBtdXFGZURwV1ZVRmRReVBMc1RqcUFjbEtiWEpmc1lqaFFu?=
 =?utf-8?B?S1d2SHRKd05rbk0yUUlUdm85eXJrejF6NFVxcXVIS2YxUHRRWXhWZEJNaS9V?=
 =?utf-8?B?TFZHdXZwcVJnUytoTW45S0tmZERXZHl2NGdGWXRvQmFoZkpVd010U0NhTTA3?=
 =?utf-8?B?ZWRNMUFvdE5RaTBZaHBQcHZ3K3RVaXowMHdyaFdBTWh6SDR1eGNLakU1WG1u?=
 =?utf-8?B?SzZ6UFF4cjBGWDEwd0U2RTkyUU1reTJVNmNrKy9xVDU1ekp0ZVNHZFBWN1FB?=
 =?utf-8?B?N3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D5B5386686FEC479AE447BDD90A62A3@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9dc439-7e8f-407e-b939-08db267ea929
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 00:29:24.8250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AlsBzRBAicurScu1IcUwjfJmJG1P+BDzXl/8iJ3eN4W+McN9OY9xyKkBuWoj3aTN7deM6hzzrnFAoqRDRmQtgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10407
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBNYXIgMTYsIDIwMjMgYXQgMDc6MTA6NTZQTSArMDgwMCwgU2h1YWkgWHVlIHdyb3Rl
Og0KPiANCj4gDQo+IE9uIDIwMjMvMy8xNiBQTTM6MjEsIEhPUklHVUNISSBOQU9ZQSjloIDlj6Mg
55u05LmfKSB3cm90ZToNCj4gPiBPbiBNb24sIEZlYiAyNywgMjAyMyBhdCAwMTowMzoxNVBNICsw
ODAwLCBTaHVhaSBYdWUgd3JvdGU6DQo+ID4+IEhhcmR3YXJlIGVycm9ycyBjb3VsZCBiZSBzaWdu
YWxlZCBieSBzeW5jaHJvbm91cyBpbnRlcnJ1cHQsIGUuZy4gIHdoZW4gYW4NCj4gPj4gZXJyb3Ig
aXMgZGV0ZWN0ZWQgYnkgYSBiYWNrZ3JvdW5kIHNjcnViYmVyLCBvciBzaWduYWxlZCBieSBzeW5j
aHJvbm91cw0KPiA+PiBleGNlcHRpb24sIGUuZy4gd2hlbiBhbiB1bmNvcnJlY3RlZCBlcnJvciBp
cyBjb25zdW1lZC4gQm90aCBzeW5jaHJvbm91cyBhbmQNCj4gPj4gYXN5bmNocm9ub3VzIGVycm9y
IGFyZSBxdWV1ZWQgYW5kIGhhbmRsZWQgYnkgYSBkZWRpY2F0ZWQga3RocmVhZCBpbg0KPiA+PiB3
b3JrcXVldWUuDQo+ID4+DQo+ID4+IGNvbW1pdCA3ZjE3YjRhMTIxZDAgKCJBQ1BJOiBBUEVJOiBL
aWNrIHRoZSBtZW1vcnlfZmFpbHVyZSgpIHF1ZXVlIGZvcg0KPiA+PiBzeW5jaHJvbm91cyBlcnJv
cnMiKSBrZWVwIHRyYWNrIG9mIHdoZXRoZXIgbWVtb3J5X2ZhaWx1cmUoKSB3b3JrIHdhcw0KPiA+
PiBxdWV1ZWQsIGFuZCBtYWtlIHRhc2tfd29yayBwZW5kaW5nIHRvIGZsdXNoIG91dCB0aGUgd29y
a3F1ZXVlIHNvIHRoYXQgdGhlDQo+ID4+IHdvcmsgZm9yIHN5bmNocm9ub3VzIGVycm9yIGlzIHBy
b2Nlc3NlZCBiZWZvcmUgcmV0dXJuaW5nIHRvIHVzZXItc3BhY2UuDQo+ID4+IFRoZSB0cmljayBl
bnN1cmVzIHRoYXQgdGhlIGNvcnJ1cHRlZCBwYWdlIGlzIHVubWFwcGVkIGFuZCBwb2lzb25lZC4g
QW5kDQo+ID4+IGFmdGVyIHJldHVybmluZyB0byB1c2VyLXNwYWNlLCB0aGUgdGFzayBzdGFydHMg
YXQgY3VycmVudCBpbnN0cnVjdGlvbiB3aGljaA0KPiA+PiB0cmlnZ2VyaW5nIGEgcGFnZSBmYXVs
dCBpbiB3aGljaCBrZXJuZWwgd2lsbCBzZW5kIFNJR0JVUyB0byBjdXJyZW50IHByb2Nlc3MNCj4g
Pj4gZHVlIHRvIFZNX0ZBVUxUX0hXUE9JU09OLg0KPiA+Pg0KPiA+PiBIb3dldmVyLCB0aGUgbWVt
b3J5IGZhaWx1cmUgcmVjb3ZlcnkgZm9yIGh3cG9pc29uLWF3YXJlIG1lY2hhbmlzbXMgZG9lcyBu
b3QNCj4gPj4gd29yayBhcyBleHBlY3RlZC4gRm9yIGV4YW1wbGUsIGh3cG9pc29uLWF3YXJlIHVz
ZXItc3BhY2UgcHJvY2Vzc2VzIGxpa2UNCj4gPj4gUUVNVSByZWdpc3RlciB0aGVpciBjdXN0b21p
emVkIFNJR0JVUyBoYW5kbGVyIGFuZCBlbmFibGUgZWFybHkga2lsbCBtb2RlIGJ5DQo+ID4+IHNl
dGluZyBQRl9NQ0VfRUFSTFkgYXQgaW5pdGlhbGl6YXRpb24uIFRoZW4gdGhlIGtlcm5lbCB3aWxs
IGRpcmVjdHkgbm90aWZ5DQo+ID4+IHRoZSBwcm9jZXNzIGJ5IHNlbmRpbmcgYSBTSUdCVVMgc2ln
bmFsIGluIG1lbW9yeSBmYWlsdXJlIHdpdGggd3JvbmcNCj4gPj4gc2lfY29kZTogdGhlIGFjdHVh
bCB1c2VyLXNwYWNlIHByb2Nlc3MgYWNjZXNzaW5nIHRoZSBjb3JydXB0IG1lbW9yeQ0KPiA+PiBs
b2NhdGlvbiwgYnV0IGl0cyBtZW1vcnkgZmFpbHVyZSB3b3JrIGlzIGhhbmRsZWQgaW4gYSBrdGhy
ZWFkIGNvbnRleHQsIHNvDQo+ID4+IGl0IHdpbGwgc2VuZCBTSUdCVVMgd2l0aCBCVVNfTUNFRVJS
X0FPIHNpX2NvZGUgdG8gdGhlIGFjdHVhbCB1c2VyLXNwYWNlDQo+ID4+IHByb2Nlc3MgaW5zdGVh
ZCBvZiBCVVNfTUNFRVJSX0FSIGluIGtpbGxfcHJvYygpLg0KPiA+Pg0KPiA+PiBUbyB0aGlzIGVu
ZCwgc2VwYXJhdGUgc3luY2hyb25vdXMgYW5kIGFzeW5jaHJvbm91cyBlcnJvciBoYW5kbGluZyBp
bnRvDQo+ID4+IGRpZmZlcmVudCBwYXRocyBsaWtlIFg4NiBwbGF0Zm9ybSBkb2VzOg0KPiA+Pg0K
PiA+PiAtIHRhc2sgd29yayBmb3Igc3luY2hyb25vdXMgZXJyb3JzLg0KPiA+PiAtIGFuZCB3b3Jr
cXVldWUgZm9yIGFzeW5jaHJvbm91cyBlcnJvcnMuDQo+ID4+DQo+ID4+IFRoZW4gZm9yIHN5bmNo
cm9ub3VzIGVycm9ycywgdGhlIGN1cnJlbnQgY29udGV4dCBpbiBtZW1vcnkgZmFpbHVyZSBpcw0K
PiA+PiBleGFjdGx5IGJlbG9uZ3MgdG8gdGhlIHRhc2sgY29uc3VtaW5nIHBvaXNvbiBkYXRhIGFu
ZCBpdCB3aWxsIHNlbmQgU0lCQlVTDQo+ID4+IHdpdGggcHJvcGVyIHNpX2NvZGUuDQo+ID4+DQo+
ID4+IEZpeGVzOiA3ZjE3YjRhMTIxZDAgKCJBQ1BJOiBBUEVJOiBLaWNrIHRoZSBtZW1vcnlfZmFp
bHVyZSgpIHF1ZXVlIGZvciBzeW5jaHJvbm91cyBlcnJvcnMiKQ0KPiA+PiBTaWduZWQtb2ZmLWJ5
OiBTaHVhaSBYdWUgPHh1ZXNodWFpQGxpbnV4LmFsaWJhYmEuY29tPg0KPiA+IC4uLg0KPiA+PiAg
DQo+ID4+ICAvKg0KPiA+PiAtICogQ2FsbGVkIGFzIHRhc2tfd29yayBiZWZvcmUgcmV0dXJuaW5n
IHRvIHVzZXItc3BhY2UuDQo+ID4+IC0gKiBFbnN1cmUgYW55IHF1ZXVlZCB3b3JrIGhhcyBiZWVu
IGRvbmUgYmVmb3JlIHdlIHJldHVybiB0byB0aGUgY29udGV4dCB0aGF0DQo+ID4+IC0gKiB0cmln
Z2VyZWQgdGhlIG5vdGlmaWNhdGlvbi4NCj4gPj4gKyAqIHN0cnVjdCBtY2VfdGFza193b3JrIC0g
Zm9yIHN5bmNocm9ub3VzIFJBUyBldmVudA0KPiA+IA0KPiA+IFRoaXMgc2VlbXMgdG8gaGFuZGxl
IHN5bmNocm9ub3VzIG1lbW9yeSBlcnJvcnMsIG5vdCBsaW1pdGVkIHRvIE1DRT8NCj4gPiBTbyBu
YW1pbmcgdGhpcyBzdHJ1Y3QgYXMgc3VjaCAobW9yZSBnZW5lcmFsbHkpIG1pZ2h0IGJlIGJldHRl
ci4NCj4gDQo+IFllcy4gSG93IGFib3V0IGBzeW5jX3Rhc2tfd29ya2A/DQoNClNvdW5kcyBiZXR0
ZXIgdG8gbWUuDQoNCj4gDQo+ID4gDQo+ID4+ICsgKg0KPiA+PiArICogQHR3b3JrOiAgICAgICAg
ICAgICAgICBjYWxsYmFja19oZWFkIGZvciB0YXNrIHdvcmsNCj4gPj4gKyAqIEBwZm46ICAgICAg
ICAgICAgICAgICAgcGFnZSBmcmFtZSBudW1iZXIgb2YgY29ycnVwdGVkIHBhZ2UNCj4gPj4gKyAq
IEBmbGFnczogICAgICAgICAgICAgICAgZmluZSB0dW5lIGFjdGlvbiB0YWtlbg0KPiA+PiArICoN
Cj4gPj4gKyAqIFN0cnVjdHVyZSB0byBwYXNzIHRhc2sgd29yayB0byBiZSBoYW5kbGVkIGJlZm9y
ZQ0KPiA+PiArICogcmV0X3RvX3VzZXIgdmlhIHRhc2tfd29ya19hZGQoKS4NCj4gPj4gICAqLw0K
PiA+IC4uLg0KPiA+IA0KPiA+PiAgfQ0KPiA+PiAgDQo+ID4+IC1zdGF0aWMgYm9vbCBnaGVzX2Rv
X21lbW9yeV9mYWlsdXJlKHU2NCBwaHlzaWNhbF9hZGRyLCBpbnQgZmxhZ3MpDQo+ID4+ICtzdGF0
aWMgdm9pZCBnaGVzX2RvX21lbW9yeV9mYWlsdXJlKHU2NCBwaHlzaWNhbF9hZGRyLCBpbnQgZmxh
Z3MpDQo+ID4+ICB7DQo+ID4+ICAJdW5zaWduZWQgbG9uZyBwZm47DQo+ID4+ICsJc3RydWN0IG1j
ZV90YXNrX3dvcmsgKnR3Y2I7DQo+ID4+ICANCj4gPj4gIAlpZiAoIUlTX0VOQUJMRUQoQ09ORklH
X0FDUElfQVBFSV9NRU1PUllfRkFJTFVSRSkpDQo+ID4+IC0JCXJldHVybiBmYWxzZTsNCj4gPj4g
KwkJcmV0dXJuOw0KPiA+PiAgDQo+ID4+ICAJcGZuID0gUEhZU19QRk4ocGh5c2ljYWxfYWRkcik7
DQo+ID4+ICAJaWYgKCFwZm5fdmFsaWQocGZuKSAmJiAhYXJjaF9pc19wbGF0Zm9ybV9wYWdlKHBo
eXNpY2FsX2FkZHIpKSB7DQo+ID4+ICAJCXByX3dhcm5fcmF0ZWxpbWl0ZWQoRldfV0FSTiBHSEVT
X1BGWA0KPiA+PiAgCQkiSW52YWxpZCBhZGRyZXNzIGluIGdlbmVyaWMgZXJyb3IgZGF0YTogJSNs
bHhcbiIsDQo+ID4+ICAJCXBoeXNpY2FsX2FkZHIpOw0KPiA+PiAtCQlyZXR1cm4gZmFsc2U7DQo+
ID4+ICsJCXJldHVybjsNCj4gPj4gKwl9DQo+ID4+ICsNCj4gPj4gKwlpZiAoZmxhZ3MgPT0gTUZf
QUNUSU9OX1JFUVVJUkVEICYmIGN1cnJlbnQtPm1tKSB7DQo+ID4+ICsJCXR3Y2IgPSBrbWFsbG9j
KHNpemVvZigqdHdjYiksIEdGUF9BVE9NSUMpOw0KPiA+PiArCQlpZiAoIXR3Y2IpDQo+ID4+ICsJ
CQlyZXR1cm47DQo+ID4gDQo+ID4gV2hlbiB0aGlzIGttYWxsb2MoKSBmYWlscywgdGhlIGVycm9y
IGV2ZW50IG1pZ2h0IGJlIHNpbGVudGx5IGRyb3BwZWQ/DQo+ID4gSWYgc28sIHNvbWUgd2Fybmlu
ZyBtZXNzYWdlcyBjb3VsZCBiZSBoZWxwZnVsLg0KPiANCj4gWWVzLCBJIHdhcyBnb2luZyB0byBh
ZGQgYSB3YXJuaW5nIG1lc3NhZ2VzIGxpa2U6DQo+IA0KPiAgICAgcHJfZXJyKCJGYWlsZWQgdG8g
aGFuZGxlIG1lbW9yeSBmYWlsdXJlIGR1ZSB0byBvdXQgb2YgbWVtb3J5XG4iKTsNCj4gDQo+IEJ1
dCBnb3QgYSB3YXJuaW5nIGFib3V0IHBhdGNoIHdoZW4gY2hlY2tlZCBieSBjaGVja3BhdGNoLnBs
Lg0KPiANCj4gICAgV0FSTklORzogUG9zc2libGUgdW5uZWNlc3NhcnkgJ291dCBvZiBtZW1vcnkn
IG1lc3NhZ2UNCj4gDQo+IEkgd2lsbCBhZGQgaXQgYmFjayBpbiBuZXh0IHZlcnNpb24gOikNCg0K
T2gsIEkgZGlkbid0IGtub3cgYWJvdXQgdGhpcyB3YXJuaW5nLiAgSSBjaGVja2VkIHRoZSBjb21t
aXQgbG9nIGludHJvZHVjZWQNCnRoaXMgbWVlc2FnZXMsIGFuZCB0aGUganVzdGlmaWNhdGlvbiBt
YWtlcyBzZW5zZSB0byBtZS4gU28gSSdkIGxpa2UgdG8NCndpdGhkcmF3IG15IGNvbW1lbnQgYWJv
dXQgdGhpcyAoSSBtZWFuIHlvdSBkb24ndCBoYXZlIHRvIGFkZCBpdCBiYWNrKS4NCg0KICBjb21t
aXQgZWJmZGM0MDk2OWYyNGZjMGNkZDEzNDk4MzVkMzZlOGViYWUwNTM3NCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICANCiAgQXV0aG9yOiBKb2UgUGVyY2hlcyA8am9lQHBlcmNoZXMuY29tPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogIERhdGU6ICAgV2VkIEF1ZyA2
IDE2OjEwOjI3IDIwMTQgLTA3MDAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgIGNoZWNrcGF0Y2g6IGF0dGVtcHQgdG8gZmlu
ZCB1bm5lY2Vzc2FyeSAnb3V0IG9mIG1lbW9yeScgbWVzc2FnZXMgICAgICAgDQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIA0KICAgICAgTG9nZ2luZyBtZXNzYWdlcyB0aGF0IHNob3cgc29tZSB0eXBlIG9m
ICJvdXQgb2YgbWVtb3J5IiBlcnJvciBhcmUgICAgICANCiAgICAgIGdlbmVyYWxseSB1bm5lY2Vz
c2FyeSBhcyB0aGVyZSBpcyBhIGdlbmVyaWMgbWVzc2FnZSBhbmQgYSBzdGFjayBkdW1wICAgDQog
ICAgICBkb25lIGJ5IHRoZSBtZW1vcnkgc3Vic3lzdGVtLiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgIFRoZXNlIG1l
c3NhZ2VzIGdlbmVyYWxseSBpbmNyZWFzZSBrZXJuZWwgc2l6ZSB3aXRob3V0IG11Y2ggYWRkZWQg
dmFsdWUuDQoNCg0KVGhhbmtzLA0KTmFveWEgSG9yaWd1Y2hp
