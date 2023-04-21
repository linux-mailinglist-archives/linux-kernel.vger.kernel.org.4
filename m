Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6843F6EA792
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjDUJtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbjDUJsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:48:50 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F28A268;
        Fri, 21 Apr 2023 02:48:48 -0700 (PDT)
Received: from pps.filterd (m0174678.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33L5eYFv029819;
        Fri, 21 Apr 2023 09:48:37 GMT
Received: from eur03-am7-obe.outbound.protection.outlook.com (mail-am7eur03lp2241.outbound.protection.outlook.com [104.47.51.241])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3q372hk25f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 09:48:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntn8QKuAPQ5Oui/7JpQneoWGcdMMeLKKpdI28ydQTzfrrxl33wkZssA77mgkJrjKVJCsP97aDNZpp+MRNtYkhCaNrvnrQGyuQvDmfpUxvnJWd6y3Wr1fFJDMEvjGtcjs1aOK0Ewjzqb5OtUy1RL6M+jPPd/NGvueRD7zM/4LODanJVaSKs5NwcdQNefyEbZhUbpkL4yluHVDF/SQt7Elkvy6mLs97g+sQAtUetO9NyfZFkedDnZLcIiulZImtE1MHua3F0j7rHxY/5O866aUFkCXCJ4jBoK4uurLzCg/ATHaJSRqAXKQBYIc/5Hexn7vm4Oxk/gtNo8NQAKcDMo+LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRUdWle3uZJKACLO507pfGesvAHYup8lLZXZ6FTCKMU=;
 b=kYgg7ClO3pVGGv8IVXedSXQVPbZI0eLR39WGQK/gVsm8MvoidvyVutwmpcpa4wwksA2hunrrXHRetwWRqBtlLKDYEKSfgnG6rMsAUO/9iNggsSDW5WHqkJftSU7RVTgVxs9NbxeaA6PjzYKh05mwvfYvgAqCUgE7wl8T0WYrV6gL0NDbeZ9VVD3l7OXEsFnH6Sd7Wo3ziNBjLA1YcB3rkQisEdk8m/OQfKXtCo91w7OFvZEgCAyxgvQ07ZvgZJZpjHIVPtlthhVvKhHJamjTmLIttb/XKUNz0KXnjGZDUdSiQzS2W5Vu//dfieW8uxzeYvpEl5z+b5XsPafzcx3Qcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRUdWle3uZJKACLO507pfGesvAHYup8lLZXZ6FTCKMU=;
 b=G8ANqfL5PSfCPOCxX7DRZWUQN4ynU1oKUyoC5trupGAd9+pGS8eNBbvjFr+rmWn6LOkKogH5Lm53ZI62wvcoY07ijx1duitnJtqsOY7+9KkuH3KCzlQZyfSzuMlcif5373PD/9fii6lBPNBWASu/mveYQL2Z62xoVXWiRp48rE5xjti5rjVmbyFJGom97yKKGsAiGSy5BMbbvdS7egbIqZz+looceB/zdfEPdNiXHIL+XP7z555gW8FBdMjaQgbDKSwkmWkGqlTI/gOJSzVBmOcrRHy8+44qkD1Tt+4pGXwTKk55DMfB0p0zdmrOiZcsffqXeAHuLSVwKSmvZO/CMA==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by PAXPR03MB7634.eurprd03.prod.outlook.com (2603:10a6:102:1dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.50; Fri, 21 Apr
 2023 09:48:33 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::bcf5:cd14:fd35:1300]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::bcf5:cd14:fd35:1300%9]) with mapi id 15.20.6298.045; Fri, 21 Apr 2023
 09:48:33 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
CC:     Peng Fan <peng.fan@oss.nxp.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "souvik.chakravarty@arm.com" <souvik.chakravarty@arm.com>
Subject: Re: [RFC v1 1/2] scmi: Introduce pinctrl SCMI protocol driver
Thread-Topic: [RFC v1 1/2] scmi: Introduce pinctrl SCMI protocol driver
Thread-Index: AQHZaTpLwL07BD9460y7/F64OnMs/q8oQvCAgAaar4CABqnaAIAADdAAgAAFIAA=
Date:   Fri, 21 Apr 2023 09:48:33 +0000
Message-ID: <3041c92c-385a-00cd-87cd-d8b906dcd84c@epam.com>
References: <cover.1680793130.git.oleksii_moisieiev@epam.com>
 <54119b2cb43e29f69c5858a5320d3a58f23fed21.1680793130.git.oleksii_moisieiev@epam.com>
 <ZDcqx9JVMvqr2WYu@e120937-lin>
 <6dc456ff-7fc6-3b73-3727-dd048e9a9629@oss.nxp.com>
 <f73f39e2-81dd-4204-a3be-c5e7f5e54c1b@epam.com>
 <ZEJXpCdf9pWgoXL6@e120937-lin>
In-Reply-To: <ZEJXpCdf9pWgoXL6@e120937-lin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|PAXPR03MB7634:EE_
x-ms-office365-filtering-correlation-id: 78c85d16-f359-437a-4def-08db424d9242
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3NeBpX3ogho/gdCM1wq/UyMqbDfi9TNSiogSBi5a1CvHkFv6Uo4PpfnE5vK5O8IBH4GwYpDGhlish4ChKFgncG2ZSHvaycXaHTNdCEfbXJJ6ErhWflzvQlUE6AGcQLMDs4XqyALsQz23Id/4nnBs7NdiP5NjiLECEVQQc9HfezNIhFWWmPAe+w32UO5Uau5A1NlOzye+wVFcb6Egc+lBhh0wpJvfp3xvqJCoIBE1nJl8iTVMvYPrVGy9xCU5vIutHFypKTCtYCBgV3rjr29tkPv687l2/G0jQsZpililMiWIKmes+PhGHByzh6rhD8ysoeKhoicnnB8xs0CQ1268DRN9t4aUjTXZ9y3IlZuM5TBqvc+83oNmU9xL/Sg2lTyxDV9IuCsrPuI1RxZFVtocP+YPMLYfUaaBp83jGe8WKiLvNKDPT6vF6BClG1xGsTGOqz7omY0zr3apMmxr2W7XT7R5dB0gJwIyF9p/0noWSNptnkXLI/ld9kfBF3gqMT5Fw9eepNj2DD/9Kns+LASHD1AYsA41RUZlcdpAYxXECHgCynRFTvSakd/9Uui2jIKdWZa3K37b/2rM6p8imwUKQAjwixf2H32FEnRX/N0Nl052CrosQo/u6DJZpDgiq+PR7Iok7DQLRl8qdlIpiL92mA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199021)(2616005)(83380400001)(36756003)(31686004)(186003)(966005)(6486002)(54906003)(478600001)(71200400001)(91956017)(66556008)(76116006)(66946007)(38100700002)(66476007)(66446008)(64756008)(8676002)(5660300002)(8936002)(122000001)(41300700001)(6916009)(4326008)(316002)(38070700005)(7416002)(6506007)(6512007)(53546011)(2906002)(26005)(31696002)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enNEa0MrbVBTUW02eDlwZE9BaU1QVTJ3ejNrRTFJbXZKMHZMaXZvRHVyWlh6?=
 =?utf-8?B?eXBvVkJTWTcrZHcxL3huUkdFcFkzeUFGYkpRWTd4VnZ1WEJjSHV5cmUwdVh0?=
 =?utf-8?B?U3c5a1c5aEZrWWhzOHZSK2FWU3htN3VOWWlINVNzaEV3VzROa21WbGUzTDdS?=
 =?utf-8?B?ZkhtNkMxQWo0YW9JTGJWdk9QMllzd2JNbFVTeVk5RGxmaEN5RXA3VnBvRGsx?=
 =?utf-8?B?bGtmZGJGb3RkbWQvajVmWm4xcnYvWXQ4TlNaSnppMEE5QVRWQ2xnTnppNXNK?=
 =?utf-8?B?SXBiOXdic2FUdmIyOU94WHM1RmNmMmNjcU16RkVyclNWV1NENnMyRHhCdGo5?=
 =?utf-8?B?Yk5KS2Z4V2xhU203NHZvemk0bEdYbGNEY3htejVINE52M0Fub1lnQlpMaVhz?=
 =?utf-8?B?RGhRcmdiVXpxRGdLa3VwWGYxTE1WQUVWZDZUc2Z6eEtIbUhsNXdKeXR5ZHZ2?=
 =?utf-8?B?MWJqczhLSmE1VzBlQmI2VUdTTnFDcXhQYmNmTjhiaWV2cGRpY3NtTW1peVlq?=
 =?utf-8?B?Q0hDdjk3dnVuWDhwRlBNaFA5bkkxRWRBRnhJQkVDVVJlMHIzRWZNSHVNeFEx?=
 =?utf-8?B?Z0NwNW5KSGlDWk05OWZ6RHhJRFBHdFpOcU9sSHFMR3E3RW5DTGJvbG1iMEZL?=
 =?utf-8?B?T2hjWE1qeTJvRGo1MmZ6TWNiRXJ3THIramRNVytZeUFrTlZQcnlTQkh1MU9K?=
 =?utf-8?B?d0s4c2FwVVBnSmMwVGo3MFFYbkZmTXFVaG9ORHFhMDc5SnhHbEJRN0owVlRQ?=
 =?utf-8?B?elI4NzNFN3Q5bVBmN3dlOEVBTHZIdFFsMEtJM2k1ck13YTBpQjhEaGRzVDZl?=
 =?utf-8?B?aGYvQnFaanlXK3NMditxQ0pDb0I0SFZ6Yzh5Y2Y4RGtIVUtGeXJJWlhRbnJy?=
 =?utf-8?B?RnJQTnV5N2ZqRFlDbWFEaEE4bjdBVVYrM1BDTzE3TnhaY2ZOcEtwQ2pEdHZD?=
 =?utf-8?B?Z1hKTEd0dGY4c1R4M2kyZW9tejBQeDBwbDkvYnZjYUFjMm9IQnpXUGljQ2pv?=
 =?utf-8?B?RndlYjZJUkFRUXRsbkJCZDRycGVzcTlKT3ZzU3NuTkRPM0ZMWm0rcUpzeG1l?=
 =?utf-8?B?aHNqdFVQaXRBZlltaFRqOWU0a2VBUjJOM3RsdVpuRmdpaDhBdWk4RG52VFNJ?=
 =?utf-8?B?VnFTYVpqYXB6S0NvakZNSDdqR2ptZWlyT1JiQzIzNFdQK2ZVS3lXNXFCT3Rr?=
 =?utf-8?B?azBhaG92bVc1a1k0REc0ZXQ5RWdpRjRqb3ZkZnZHZFpxdW90TWU4c1UxVEoy?=
 =?utf-8?B?dzNyM01WUjNxVWdYamZEanhIMGdtVDE1OWF0QWo5RG95Ri9yaDFUSEJQcEdv?=
 =?utf-8?B?Qm9MSFgvN002SlB2SlUzV3I3b2FTeFBsOVFuZ25FSTBxT1FyR0FWTUtDZzRI?=
 =?utf-8?B?dzh3RW5RVEZ2NE4xQ0ZySDlabzAxNngrRHdHZXoxbTJaUlh4VGZEd3k1VCtK?=
 =?utf-8?B?a2I2RzhaRnlKS0pHMFZDTjBUYXduNnlVZzhxVy9sSFdyMVU0SGRrZWJtOW02?=
 =?utf-8?B?T0RGYm9RbHNIdWFSRTM4clc0MC92K0pzQ2VsL1k5a0Vkd2xjMjNCVFRrTVJK?=
 =?utf-8?B?eW04Q2oxK2xrSGRkaUFRdUFKeEV3bGlhMVBWTWJMMGxyT0U5NEE3UUMwREI5?=
 =?utf-8?B?S2ZpOVJZa2hCT0U5MlROYlhQa0d3MURreTVUV3VFSTBta05oK0JiQXMwbzBx?=
 =?utf-8?B?SVM0VmNpdFY3dm1RdUZmOXIwamVwcXNxM090YTFmVkhHMy9NQjZybGFjMWgz?=
 =?utf-8?B?dmJFUVAzUlJucUpvaXhZaU5MUUo3Z0s0bWduQysyTnRHZUFibFl2SUNpRktZ?=
 =?utf-8?B?Y0x0L2pMcnJZeXc4OXRhYVNTeUV5VG8vcTNpOWxBYjZrNXJSdjFVbHJzRnlm?=
 =?utf-8?B?bEwzOFlhWFlNRXFmYUpkcFd2Z1Vwc1J6SnNaSU9OVlZ6Q3F1cUhELy9oY0Vi?=
 =?utf-8?B?MTVDVTVWZ0Ezb2F4VFlXUnU4eFRYS3JkcDZWUmhDSm5QeHNSbVgyTWtzTXN6?=
 =?utf-8?B?SzRnaGthRzl2NWRSNEVraFkxbEpiMDZuQ3gzKzE5Y3pTVnd6VUw5KzFxM2pZ?=
 =?utf-8?B?MDFDR1hqNkR2dVova0Z4TDRJNFhneTlvT2llMVJVSVlFT0RmV2hnMk9HQ28w?=
 =?utf-8?B?d3AyRXJCMEFLZUJUNU1hNnlTd0N1Y0JFd1c0UTNqRlpuUFU3Q0JyVGxmRnlQ?=
 =?utf-8?B?RWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2DF9B5D2BB26848937C607A7F42717D@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c85d16-f359-437a-4def-08db424d9242
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 09:48:33.6510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UbXGJf550/LeA9HxQylanTglRbdti4zcoBvRMsjhYopBANUKadT690STH89twwb7lLwvwdAe44vBwNWc5e4yQsyZmeIky4Gbj3z93xHqF9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7634
X-Proofpoint-GUID: Q_iSlBG6ZMWfZVJwvXppncn1pqCIstsK
X-Proofpoint-ORIG-GUID: Q_iSlBG6ZMWfZVJwvXppncn1pqCIstsK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_03,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 mlxlogscore=648 malwarescore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304210084
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ3Jpc3RpYW4sDQoNCk9uIDIxLjA0LjIzIDEyOjMwLCBDcmlzdGlhbiBNYXJ1c3NpIHdyb3Rl
Og0KPiBPbiBGcmksIEFwciAyMSwgMjAyMyBhdCAwODo0MDo0N0FNICswMDAwLCBPbGVrc2lpIE1v
aXNpZWlldiB3cm90ZToNCj4+IEhpIFBlbmcgRmFuLA0KPj4NCj4+IE9uIDE3LjA0LjIzIDA1OjU1
LCBQZW5nIEZhbiB3cm90ZToNCj4+Pg0KPj4+IE9uIDQvMTMvMjAyMyA2OjA0IEFNLCBDcmlzdGlh
biBNYXJ1c3NpIHdyb3RlOg0KPj4+PiBPbiBGcmksIEFwciAwNywgMjAyMyBhdCAxMDoxODoyN0FN
ICswMDAwLCBPbGVrc2lpIE1vaXNpZWlldiB3cm90ZToNCj4+Pj4+IEltcGxlbWVudGF0aW9uIG9m
IHRoZSBTQ01JIGNsaWVudCBkcml2ZXIsIHdoaWNoIGltcGxlbWVudHMNCj4+Pj4+IFBJTkNUUkxf
UFJPVE9DT0wuIFRoaXMgcHJvdG9jb2wgaGFzIElEIDE5IGFuZCBpcyBkZXNjcmliZWQNCj4+Pj4+
IGluIHRoZSBsYXRlc3QgREVOMDA1NiBkb2N1bWVudC4NCj4+Pj4gSGksDQo+Pj4+DQo+Pj4+PiBU
aGlzIHByb3RvY29sIGlzIHBhcnQgb2YgdGhlIGZlYXR1cmUgdGhhdCB3YXMgZGVzaWduZWQgdG8N
Cj4+Pj4+IHNlcGFyYXRlIHRoZSBwaW5jdHJsIHN1YnN5c3RlbSBmcm9tIHRoZSBTQ1AgZmlybXdh
cmUuDQo+Pj4+PiBUaGUgaWRlYSBpcyB0byBzZXBhcmF0ZSBjb21tdW5pY2F0aW9uIG9mIHRoZSBw
aW4gY29udHJvbA0KPj4+Pj4gc3Vic3lzdGVtIHdpdGggdGhlIGhhcmR3YXJlIHRvIFNDUCBmaXJt
d2FyZQ0KPj4+Pj4gKG9yIGEgc2ltaWxhciBzeXN0ZW0sIHN1Y2ggYXMgQVRGKSwgd2hpY2ggcHJv
dmlkZXMgYW4gaW50ZXJmYWNlDQo+Pj4+PiB0byBnaXZlIHRoZSBPUyBhYmlsaXR5IHRvIGNvbnRy
b2wgdGhlIGhhcmR3YXJlIHRocm91Z2ggU0NNSSBwcm90b2NvbC4NCj4+Pj4+IFRoaXMgaXMgYSBn
ZW5lcmljIGRyaXZlciB0aGF0IGltcGxlbWVudHMgU0NNSSBwcm90b2NvbCwNCj4+Pj4+IGluZGVw
ZW5kZW50IG9mIHRoZSBwbGF0Zm9ybSB0eXBlLg0KPj4+Pj4NCj4+Pj4+IERFTjAwNTYgZG9jdW1l
bnQ6DQo+Pj4+PiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9kZXZlbG9wZXIu
YXJtLmNvbS9kb2N1bWVudGF0aW9uL2RlbjAwNTYvbGF0ZXN0X187ISFHRl8yOWRiY1FJVUJQQSF5
MmhSM1BFR0d4aVBqVmVYQmNnR3lWMDNEUERoemdVS1IwdUh2c1RwaWFmS2dCYXI4RWdjNm9PT3Mt
SWtGSXF1aFNmLXFCemx0cUVNeXpSWkhxOGVDNGckDQo+Pj4+PiBbZGV2ZWxvcGVyWy5dYXJtWy5d
Y29tXQ0KPj4+Pj4NCj4+Pj4gTm8gbmVlZCB0byBzcGVjaWZ5IGFsbCBvZiB0aGlzIGluIHRoZSBj
b21taXQgbWVzc2FnZSwganVzdCBhIG5vdGUgdGhhdA0KPj4+PiB5b3UgYXJlIGFkZGluZyBhIG5l
dyBTQ01JdjMuMiBQaW5jb250cm9sIHByb3RvY29sLCBoaWdobGlnaHRpbmcgYW55dGhpbmcNCj4+
Pj4gdGhhdCBoYXMgYmVlbiBsZWZ0IG91dCBpbiB0aGlzIHBhdGNoIChpZiBhbnkpIHdpbGwgYmUg
ZW5vdWdoLg0KPj4+IElzIGl0IHBvc3NpYmxlIHRvIGV4dGVuZCB0aGUgc3BlYyB0byBzdXBwb3J0
IG11bHRpbHBsZSB1aW50MzJfdCBmb3IgUElODQo+Pj4gQ09ORklHIFNFVD8NCj4+Pg0KPj4+IFdp
dGggb25seSBvbmUgdWludDMyX3QgY291bGQgbm90IHNhdGlzZnkgaS5NWCByZXF1aXJlbWVudC4N
Cj4+Pg0KPj4+IFRoYW5rcywNCj4+PiBQZW5nLg0KPj4+DQo+PiBJSVVDIHlvdSBhcmUgZXhwZWN0
aW5nIHRvIGhhdmUgYW4gYWJpbGl0eSB0byBzZXQgc29tZSBraW5kIG9mIGFycmF5IG9mDQo+PiB1
aW50MzJfdCBjb25maWcgdmFsdWVzIHRvIHNvbWUgc3BlY2lmaWMgQ29uZmlnVHlwZT8NCj4+DQo+
PiBJJ20gbm90IHN1cmUgaWYgaXQncyBzdXBwb3J0ZWQgYnkgcGludGN0cmwgc3Vic3lzdGVtIHJp
Z2h0IG5vdy4gSSB3YXMNCj4+IHVuYWJsZSB0byBmaW5kIGFuIGV4YW1wbGUgaW4gdGhlIGV4aXN0
aW5nIGRldmljZS10cmVlIHBpbmN0cmwgYmluZGluZ3MuDQo+PiBUaGlzIG1ha2VzIG1lIHRoaW5r
IHRoYXQgdGhpcyBraW5kIG9mIGJpbmRpbmcgaXMgT0VNIHNwZWNpZmljLg0KPj4NCj4+IE1heWJl
IGl0IGNhbiBiZSBpbXBsZW1lbnRlZCBieSBhZGRpbmcgbmV3IElEcyB0byBPRU0gc3BlY2lmaWMg
cmFuZ2UNCj4+ICgxOTItMjU1KSB3aGljaCBpcyByZXNlcnZlZCBmb3IgT0VNIHNwZWNpZmljIHVu
aXRzIChTZWUgVGFibGUgMjMgb2YNCj4+IERFTjAwNTZFKS4NCj4+DQo+IElmIEkgdW5kZXJzdG9v
ZCBjb3JyZWN0bHkgdGhlIGFpbSBvZiBQZW5nIG11bHRpLXZhbHVlZCByZXF1ZXN0LCBJIHRoaW5r
DQo+IHRoYXQgZXZlbiBpZiBMaW51eCBkb2VzIG5vdCBzdXBwb3J0IHVzaW5nIHRoaXMga2luZCBv
ZiBtdWx0aXBsZSB2YWx1ZWQNCj4gcmVxdWVzdHMgKGFzIG9mIG5vdyksIGlmIGl0IGlzIHVzZWZ1
bCBvciByZXF1aXJlZCBieSBzb21lIG9mIHRoZSBwb3NzaWJseQ0KPiBzdXBwb3J0ZWQgaGFyZHdh
cmUsIGl0IHNob3VsZCBiZSBkZXNjcmliZWQgYW5kIGFsbG93ZWQgYnkgdGhlIHNwZWNpZmljYXRp
b24NCj4gYW5kIHN1cHBvcnRlZCBieSB0aGUgY29yZSBTQ01JIHByb3RvY29sIHN1cHBvcnQgYXQg
bGVhc3QsIHdoaWxlIHRoZSBwaW5jdHJsDQo+IFNDTUkgZHJpdmVyIGNhbiBpZ25vcmUgdGhpcyBh
bmQga2VlcCB1c2luZyBhIG9uZS1zaXplZCBhcnJheSBwcm90b2NvbF9vcHMNCj4gY2FsbCBpbnRl
cm5hbGx5IChzaW5jZSBpdCBjYW5ub3QgZG8gYW55IGRpZmZlcmVudCBhbnl3YXkgYXMgb2Ygbm93
KQ0KPg0KPiBJT1cgSSBkb250IHRoaW5rIHdlIHNob3VsZCBtb2RlbCB0b28gc3RyaWN0bHkgdGhl
IFNDTUkgc3BlYyBhZ2FpbnN0IG9ubHkNCj4gd2hhdCB0aGUgTGludXggcGluY3RybCBzdWJzeXN0
ZW0gc3VwcG9ydCB0b2RheSwgc2luY2UgTGludXggaXQgaXMganVzdA0KPiByZWFsbHkgb25seSBv
bmUgb2YgdGhlIHBvc3NpYmxlIFNDTUkgYWdlbnRzIGFuZCBMaW51eCBpbXBsZW1lbnRhdGlvbiBp
dHNlbGYNCj4gY2FuIHBvc3NpYmx5IGNoYW5nZTogaXQgaXMgYmV0dGVyIHRvIG1vZGVsIHRoZSBz
cGVjIG9uIHRoZSBIVyByZXF1aXJlbWVudHMNCj4gb3IgdGhlIHBvc3NpYmxlIHVzYWdlIHBhdHRl
cm5zIGFjcm9zcyBhbGwgdGhlIHBvc3NpYmx5IHBhcnRpY2lwYXRpbmcgYWdlbnRzLg0KPg0KPiBB
cyBhbiBleGFtcGxlLCBmb3Igc2ltaWxhciByZWFzb25zLCB3aGVuIHRoZSBTQ01JIFZvbHRhZ2Ug
cHJvdG9jb2wgd2FzIGFkZGVkDQo+IHRvIHRoZSBzcGVjLCBhdCB0aGUgdmVyeSBsYXN0IG1pbnV0
ZSwgYSBjaGFuZ2Ugd2FzIG1hZGUgdG8gdGhlIHNwZWMgdG8gYWxsb3cNCj4gZm9yIG5lZ2F0aXZl
IHZvbHRhZ2VzLCBldmVuIHRob3VnaCB0aGUgTGludXggcmVndWxhdG9yIHN1YnN5c3RlbSB3YXMg
bm90DQo+IGFuZCBzdGlsbCBpcyBub3Qgc3VwcG9ydGluZyBhdCBhbGwgbmVnYXRpdmUgdm9sdGFn
ZXMgYXMgb2Ygbm93OyBzbyBiYXNpY2FsbHkNCj4gdGhlIFNDTUkgdm9sdGFnZSBwcm90b2NvbCBB
UEkgbm93IGV4cG9zZXMgYSBwZXItZG9tYWluIGZsYWcgKG5lZ2F0aXZlX3ZvbHRzX2FsbG93ZWQp
LA0KPiB0aGF0IGFsbG93cyBhbnkga2luZCBvZiB2b2x0YWdlIGRvbWFpbiB0byBiZSBlbnVtZXJh
dGVkIGFuZCBoYW5kbGVkIGF0IHRoZSBTQ01JDQo+IHNwZWMgYW5kIGNvcmUgbGF5ZXIgYnV0IHRo
YXQgYWxzbyBhbGxvd3MgYW55IFNDTUkgZHJpdmVyIHVzZXIsIGxpa2UgdGhlIFNDTUkNCj4gUmVn
dWxhdG9yIGRyaXZlciwgdG8gZGVjaWRlIG9uIGhpcyBvd24gaWYgbmVnYXRpdmUgdm9sdGFnZXMg
ZG9tYWlucyBjYW4gYmUNCj4gc3VwcG9ydGVkOiBpbmRlZWQgdGhlIHNjbWktcmVndWxhdG9yIGRy
aXZlciBqdXN0IHNraXBzIHRoZSBpbml0aWFsaXphdGlvbiBvZg0KPiBhbnkgdm9sdGFnZSBkb21h
aW4gdGhhdCBpcyBmb3VuZCB0byBiZSBkZXNjcmliaW5nIG5lZ2F0aXZlIHZvbHRhZ2VzLg0KPg0K
PiBIZXJlIGlzIGEgYml0IGRpZmZlcmVudCwgaXQgaXMgbW9yZSBvZiBhbiBvcHRpbWl6YXRpb24g
aW4gdGhlIGNhbGwgcGF0aA0KPiB0aGFuIGFuIEhXIGRpZmZlcmVuY2UsIGJ1dCBJIHdvdWxkIGZv
bGxvdyB0aGUgc2FtZSBhcHByb2FjaDogd2l0aCB0aGUNCj4gU0NNSSBzcGVjIGFuZCB0aGUgY29y
ZSBTQ01JIHN0YWNrICh0aGUgcHJvdG9jb2wpIHRoYXQgc3VwcG9ydHMgYSBtdWx0aS11aW50MzIN
Cj4gY2FsbCBhcyBhIGdlbmVyYWwgY2FzZSwgaWYgdXNlZnVsIGZvciBzb21lIHNjZW5hcmlvcywg
YW5kIGluc3RlYWQgdGhlIFNDTUkNCj4gcGluY3RybCBkcml2ZXIgdGhhdCBqdXN0IGlnbm9yZXMg
dGhpcyBwb3NzaWJpbGl0eSBhbmQga2VlcCB1c2luZyBhIHNpbmdsZS12YWx1ZQ0KPiBhcnJheSBh
bnl3YXkuLi4udGhlbiwgaXQgd2lsbCBiZSB1cCB0byB0aGUgZ3V5cyBsZXZlcmFnaW5nIHRoaXMg
bXVsdGktdmFsdWVkDQo+IGNhbGwgdG8gY29tZSB1cCB3aXRoIGEgd2F5IHRvIHVzZSBpdCBvbiB0
aGVpciBzeXN0ZW1zLCBwb3NzaWJseSBtYXliZSBjb250cmlidXRpbmcNCj4gYmFjayB0byB1cHN0
cmVhbSBhbnkgbmVlZGVkIG1vZGlmaWNhdGlvbiBpZiBnZW5lcmFsIGVub3VnaA0KPiAobm90IHN1
cmUgYWJvdXQgdGhlIGRldGFpbHMgb2YgaG93IHRoaXMgbXVsdGktdmFscyBvcGVyYXRpb24gc2hv
dWxkIGJlLi4ud2UnbGwgaGF2ZQ0KPiB0byBkaXNjdXNzIHRoYXQgYWJvdXQgdGhlIHNwZWMgYWxs
IHRvZ2V0aGVyIEkgdGhpbmsuKQ0KPg0KPiBJbiBhbnkgY2FzZSwgSSB3b3VsZCBkZWZpbml0ZWx5
IE5PVCByZWxlZ2F0ZSBzdWNoIHBvc3NpYmlsaXR5IHRvIHZlbmRvciBzcGFjZSwNCj4gc2luY2Ug
aXQgaXMgc29tZXRoaW5nIGdlbmVyaWMgYW5kLCBlc3BlY2lhbGx5IGJlaW5nIGp1c3QgKGFzIGl0
IHNlZW1zIHRvIG1lKSBhbg0KPiBvcHRpbWl6YXRpb24gb24gdGhlIGNhbGwgcGF0aCBhdCB0aGUg
ZW5kLCBpdCB3aWxsIGp1c3QgbGVhZCB0byB1bmVlZGVkIGR1cGxpY2F0aW9uDQo+IG9mIGZ1bmN0
aW9uYWxpdGllcyBpbiB0aGUgdmVuZG9yIGltcGxlbWVudGF0aW9uIG9mIHN0dWZmIHRoYXQgaXQg
aXMgYWxyZWFkeQ0KPiB2ZXJ5IHNsaWdodGx5IGRpZmZlcmVudGx5IHN1cHBvcnRlZCBieSB0aGUg
c3RhbmRhcmQuDQo+DQo+IC4uLmp1c3QgbXkgb3BpbmlvbiBhbnl3YXksIEknbGwgaGFwcGlseSBs
ZXQgb3RoZXIgZ3V5cyBpbiB0aGlzIHRocmVhZCBkaXNjdXNzIGFuZA0KPiBkZWNpZGUgYWJvdXQg
dGhpcyA6UA0KPg0KPiBUaGFua3MsDQo+IENyaXN0aWFuDQoNClRoYXQgc291bmRzIHJlYXNvbmFi
bGUgZm9yIG1lLCBhbHRob3VnaCBJIGNhbid0IGltYWdpbmUgdGhlIHVzZSBjYXNlIG9mIA0KbXVs
dGktdmFsdWVkIGNvbmZpZyB2YWx1ZXMgKG1vc3QgbGlrZWx5IHRoaXMgaXMgdGhlIHByb2JsZW0g
b2YgbXkgDQppbWFnaW5hdGlvbikuIFNvIEknZCBhcHByZWNpYXRlIGlmIFBlbmcgRmFuIGNvdWxk
IHByb3ZpZGUgdXMgd2l0aCBzb21lIA0KZXhhbXBsZXMuDQoNCiBGcm9tIG15IHN0YW5kcG9pbnQg
LSBDb25maWdUeXBlcyBhcmUgbWVhbnQgdG8gYmUgc2ltcGxlIHZhbHVlIGJlY2F1c2UgDQp0aGV5
IGFyZSBtb3N0bHkgcmVsYXRlZCB0byB0aGUgZWxlY3Ryb25pYyBwcm9wZXJ0aWVzLiBCdXQgSSBh
Z3JlZSB0aGF0IA0KcHJvdG9jb2wgc2hvdWxkIGJlIHBsYXRmb3JtLWFnbm9zdGljLg0KDQpJdCB3
aWxsIGJlIGdyZWF0IGlmIFBlbmcgRmFuIGNvdWxkIHByb3ZpZGUgc29tZSBleGFtcGxlcywgc28g
d2UgY2FuIA0KdGhpbmsgYWJvdXQgdGhlIGJlc3Qgc29sdXRpb24uDQoNCkJlc3QgcmVnYXJkcywN
Cg0KT2xla3NpaQ0K
