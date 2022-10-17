Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DB3600DF8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 13:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiJQLnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 07:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiJQLnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 07:43:15 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2070.outbound.protection.outlook.com [40.107.113.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D43BB7D3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 04:43:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJT5vKyJHouQSheVLhQyE3Zk4A3wSxxIflX8GG7kcKhesd1oh33niFs3xQbnPw0ggZUa+zFUutjvGzyA6f2b69jubWXt8EXOsKu8AmSuh4zYvmnoYyUBbrtXv3xThp/Cher3ZDP1UWtJ/7WyNCCGZkd4FgOiQkMHjRJ3GIyo3dY0Ei7b2gVKYBsIt/XWEtm4gt81zGeEgZZkw0bLsgQ5uN+gnE6kOMJlUeYgUnOlOeNA+tKmi3GFuYS5TvOIySCbp7tFo/mC2knKg4OptP5N7YbwV/GlN03Wa97uQlKw8aH5MGIzIkmDr+yYBWfbLUve/3nAe++frEsqTlpLwdgSIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpM02pQR/3rEjnKVPn8N0cuR7N9UV3yl2AGBd93zYy4=;
 b=nyMDwhEdOIYlU5UcWEmnTHL8cbVRdM5c5UpLmRUEXQ406fv4q09G8UlSjrbb6N/BH4WjubXrIs3DMkE++MI1waa4FmNMmLZlO6Pw0IjHrcVj4Di3Iadrrc0w3yOC1chn+gglKQiEkFLiRvzWd4lDQeFXIOHEIv0B5bsJ9pjI0bPhJ0gUONN3dweV0jVqr9uaeTVfBviyfUryX+ddouPPXj5AF/35XWk5LrihGe5EGqKrU/W9SuHFNpXt+japzx9bl51zNkGnKLe83jrwBQbh7CY1G6M1XSlAeuTVWqPQQr88UAIWtPBJkhPnwGSz45DgQs7qiSgZ0r0aORQ6gUbaJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpM02pQR/3rEjnKVPn8N0cuR7N9UV3yl2AGBd93zYy4=;
 b=SZqbuUXe/o92y/x89t63bTGfL/Gr3S5pgTgAjpelFOXqXeqcjBnQ+eUFbp4PKy4vfDVZUjJ0Hir08DMsYx6Hmb9y/a/tU51CL3kaACBlDg7sJZHXgmLgA8wkH/D5ewnwWRPu3ARiyduOVafHq0v1GXOYw6U0lqdqLaMVbbNFk7M=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYCPR01MB5744.jpnprd01.prod.outlook.com (2603:1096:400:45::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31; Mon, 17 Oct
 2022 11:43:11 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9f34:8082:cd2f:589c]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9f34:8082:cd2f:589c%8]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 11:43:11 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Jane Chu <jane.chu@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 4/4] mm/hwpoison: introduce per-memory_block hwpoison
 counter
Thread-Topic: [PATCH v6 4/4] mm/hwpoison: introduce per-memory_block hwpoison
 counter
Thread-Index: AQHY4D2+Yt0j6jGli0auvFA3GIs+t64SesiA
Date:   Mon, 17 Oct 2022 11:43:11 +0000
Message-ID: <20221017114311.GA3679212@hori.linux.bs1.fc.nec.co.jp>
References: <20221007010706.2916472-1-naoya.horiguchi@linux.dev>
 <20221007010706.2916472-5-naoya.horiguchi@linux.dev>
 <3a6e403d-15d1-f419-698a-b1c825f59472@huawei.com>
In-Reply-To: <3a6e403d-15d1-f419-698a-b1c825f59472@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|TYCPR01MB5744:EE_
x-ms-office365-filtering-correlation-id: 81498ed7-a326-46be-8392-08dab034c51c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vK0CR8BffZDcSyOfMoCCaneiT+/2bI34J274zdFbVTGz6XcWsvQaGSEjUiTRwnJ6v1xOmA1IUO0+lkEVKPXhMNq9jyWYnSBiawJ+AvgUMvXV0NzAh2zp8h+m6zt8HrDDh2arZlf6g1bFBpAku9MPY7QQfN1TD6v7BRxFKf1IqD3nADCXmHk9yE4dyENMPJxXiCqNifrcCzknILRY35uUIiTctp0kFfv8yh51K6CJWmAjcZH9xIIS+AUnnqwT4t97CsfueVDgjzNbfKjesq39qCj4653GnC3mF18uBSleaEruNRDLpSltr0J3T588kFiXCQroyc9uwTAjJoeUh7ktF6IgqI1goecIw5CmAD0keplKytQO0QvxSFS7QSYC7pVvSOefzmWpg4AXRkZgr0wjo3Li3mbmfU6PEhRWf/YFq3Ta5sU+hOIjSP5OF+KX0s03x8n/Kd3OXlrMqRaQDE/XWBalUGlhzrQdo0ZnZjZpz2QcDZ29jNOXA7Jpds+f8HtxkAgUm2/N3Jha6GqX0l6Z0x0qB9HHhlvNCkdouzJy9SMrBS40LSuG1/zhBnLL6tXgNwMdzCTAU0G5hfbtmoVF8RFddBhTh60sDswo2WcGwCOh+yrYcB8FmlTlrk9b9N4IJ4VqRACvKnTrsHS/yOC2IqxEVFRb1LRKGotGwfmTgWv2sY1OJFsDkLwsbN+TYfabQakma9tNprigYHYFUx4L/9XKYTdKPHALe5qrtTZIVVB67OtBXEwijJN0ndWCIxqZKAmaQ13nUuE/C+z1hFNzEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199015)(85182001)(33656002)(122000001)(86362001)(5660300002)(7416002)(2906002)(82960400001)(38100700002)(1076003)(186003)(83380400001)(38070700005)(26005)(55236004)(6506007)(53546011)(316002)(478600001)(6512007)(9686003)(54906003)(6916009)(6486002)(71200400001)(66946007)(76116006)(66556008)(66476007)(66446008)(41300700001)(4326008)(8936002)(64756008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mm5OVUtOdU5PZzN2cS80NWpJWG0vbHdmbWY1RjFBVVZqMDIvNE9lekNUNkhU?=
 =?utf-8?B?dnNlTitCV2Z3WDR1ZGI0emVMNC9xait6WkhWUlZTY2xtNUtXaGNhUjl6NDRQ?=
 =?utf-8?B?V1oxTTczMWUxbWtvcWFEN3E0NEVIQm1MNVp0eGFwMElLSHF2a0JOTjJOYkRl?=
 =?utf-8?B?NFJXWFBuaXl0ZWRyYk9ZTUtMMUJVV04xdlNiZGd0cWhSL3l0RUl2ZU9JekJM?=
 =?utf-8?B?WmJhbWloYnJieFRQc3BwT1dXYmhZOFZmcENjUlp5aDd2RUJGdGRjSG5uZUtT?=
 =?utf-8?B?UmpBTmxPT1pVOFVUdk9wTGhkRDRhVWF3UFBqRllzb3VjZWExSXQrRnFqaXc0?=
 =?utf-8?B?RVFJd2R1N201Mld2aExGQy9idU1aWXJRSWNoeUZQSnlkeC90WmJUNkI5ajM4?=
 =?utf-8?B?MEtkcW0rNXBBbFpwL25nMnl3WmxOWnB5M0d0aVF2Qi9EYzlha3puWGxqOSt1?=
 =?utf-8?B?dDVqMU5KdFpqNnRwcVRsYmh1dk1VdFNzR09qQ0EzVHZ5VTY5ZTZ4MHFzWDJK?=
 =?utf-8?B?SU1sMzRhL256WEhDU3Z0UjRwS3NHR3gvYVFSUm40bDhoODhRVGVQU2NMYytE?=
 =?utf-8?B?Rk9aLzBhOWFNSFBHVmxFaGI1akNUOTFkQW8zQm0rMVVjMUF3T3MvNXlEOEwy?=
 =?utf-8?B?YXFDeHFvazJONmNMZ0g4UVdadXlNa0FUOXdEY3BvQk8vcVpOamtIVndBVjNL?=
 =?utf-8?B?QUVBYkZqSTJuaEZOWk9ka2QxMXNsOFpJYlRsRlpKQ0tmQk41YUw5UVNUbWh2?=
 =?utf-8?B?dmV5RXdaZi9seWsxOUJ3eG1HVGVsMDdSWG1nak4zRndSeTNLZ3o5allIakFD?=
 =?utf-8?B?OVZUamhkcysrZW5TT0NmZjR6SWpSYWlJREF4a0k2TXFpMUY5eE8wQU5yMC9Y?=
 =?utf-8?B?TFhMZWpDOFoxQmRFZmtRZGJoVTVCWlFwUmdtQldKMmFJemVicnIra3d2bEVR?=
 =?utf-8?B?SWc4ay8ya1JVaDNwSG90d09HNUp6eG1aY1FpVkp6VmxzRFhDK3hYcHNaTnBG?=
 =?utf-8?B?U1VENXZIV3FBOTllMzZNQit6VnBEUUJ6bXYwQTlqS0M2bXBLbkRuWHFITmUv?=
 =?utf-8?B?Y1Jvb0FrY0tKRExENVk3VEFaREUzK04rM3loM29KWVg3L0ZNTGFwN2xBMlBY?=
 =?utf-8?B?R0JwYkZDSHlQV0hCR2dSbzBUVlhrb20vRWhkZ1MvL1pwNnlSeWVtcE9RQmE0?=
 =?utf-8?B?elpHV05Cc2Z0bE1UUm9XYVc0LzNuL016b2FjMTlFb09aeWxLS2pyc0NFNG1R?=
 =?utf-8?B?ZzBpUS9Cak9aMmJPTlJ6bzloaXVvSVBUcE4rUUk4U3dqOEpiMkNnZDZOeXFr?=
 =?utf-8?B?bmIzRVNMem1HWURrRmYzZkhzQ0ZrNEUvVnFKNnZ1NEQ0U3JTNGVoZkNMek1n?=
 =?utf-8?B?SFdFbHo4akU0WlhVTVB2VlRzblJhd3ZvelovTklqY2MvRk4xa0VOVm5SMjNa?=
 =?utf-8?B?c0MvQTFpaW83WTVYdE5yRXhQUnhqRlRYa0Z4RUUvNDNTVjBOV1VpTW1ESi9t?=
 =?utf-8?B?d2tsazJHbyt0RkJ5U1B1OUNmY0plb2hISWhKVzNGTnFQbFN6d2FySnM4QlpC?=
 =?utf-8?B?a3JmUUJpTHFkTzkxTXcvbE5LUWlwQ3dZU0svQmxCakhvRTBhSUM0Rk5OakNo?=
 =?utf-8?B?SGQzTG9QT1F6Yk16aDE1MmFSa1JqTUtianJmUGVFZzRvU2RMTWswck94Q3lC?=
 =?utf-8?B?d0ZJZXd1NStPVUxkZnlrNVVETUFyeXVzL1p3a2wrVExrVnFyRDNmU28yY2Rq?=
 =?utf-8?B?UUdvRGdjdlV6czhKTXpnSTdHZlpmM3VaYnR0NUFPWmJvcHk4N1FqbDhtYnJV?=
 =?utf-8?B?RkdBbE9YNkZDZnhLU2lvYWNJbU1sMTFHTjlBM05VcEpWNUFBanBiZkhDNXFs?=
 =?utf-8?B?VkdaVWw1cHNvdmFkYmkyWjQ4Vm5kcGhNWjVVVXRycUUwaWIwdlJna01STHRF?=
 =?utf-8?B?ZTB3VmRLL1AxU2xrbG1vQjNTNFNvZk1SR0VnT1QyNmlnR2pNSnZ0LytYc1hm?=
 =?utf-8?B?citmZzFKc1JzOG5Cb2o1a205aEZvdjBHa0EyZWgwTm9Nd3JJaFV0WjZPT2M0?=
 =?utf-8?B?UDdDeFBJMkYzNmRGMkw1N3IzbDA1Qzgzb0Vkai9lMzVGQVFEWThKQzlPWWFM?=
 =?utf-8?B?WEx5dnNrUnFEdS80amVjWkxDdHArUEMxZVBMNkNadzhJSVZtR2VwOGltenIz?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E9CB45762D2814D84DC2192D8208DA5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81498ed7-a326-46be-8392-08dab034c51c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 11:43:11.7646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Aso948bJl2yWdz2JkPvaI8zU35jwdOuSwyc8xC1AuyM/vED+3gB1GBXxUgWGqyLOS9nUYGbReycd+ERRekIhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5744
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBPY3QgMTUsIDIwMjIgYXQgMTA6Mjg6MDBBTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi8xMC83IDk6MDcsIE5hb3lhIEhvcmlndWNoaSB3cm90ZToNCi4uLg0KPiA+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21lbW9yeS5oIGIvaW5jbHVkZS9saW51eC9tZW1v
cnkuaA0KPiA+IGluZGV4IGFhNjE5NDY0YTFkZi4uYWQ4Y2Q5YmIzMjM5IDEwMDY0NA0KPiA+IC0t
LSBhL2luY2x1ZGUvbGludXgvbWVtb3J5LmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L21lbW9y
eS5oDQo+ID4gQEAgLTg1LDYgKzg1LDkgQEAgc3RydWN0IG1lbW9yeV9ibG9jayB7DQo+ID4gIAl1
bnNpZ25lZCBsb25nIG5yX3ZtZW1tYXBfcGFnZXM7DQo+ID4gIAlzdHJ1Y3QgbWVtb3J5X2dyb3Vw
ICpncm91cDsJLyogZ3JvdXAgKGlmIGFueSkgZm9yIHRoaXMgYmxvY2sgKi8NCj4gPiAgCXN0cnVj
dCBsaXN0X2hlYWQgZ3JvdXBfbmV4dDsJLyogbmV4dCBibG9jayBpbnNpZGUgbWVtb3J5IGdyb3Vw
ICovDQo+ID4gKyNpZiBkZWZpbmVkKENPTkZJR19NRU1PUllfRkFJTFVSRSkgJiYgZGVmaW5lZChD
T05GSUdfTUVNT1JZX0hPVFBMVUcpDQo+ID4gKwlhdG9taWNfbG9uZ190IG5yX2h3cG9pc29uOw0K
PiA+ICsjZW5kaWYNCj4gPiAgfTsNCj4gPiAgDQo+ID4gIGludCBhcmNoX2dldF9tZW1vcnlfcGh5
c19kZXZpY2UodW5zaWduZWQgbG9uZyBzdGFydF9wZm4pOw0KPiA+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L21tLmggYi9pbmNsdWRlL2xpbnV4L21tLmgNCj4gPiBpbmRleCAxNzExOWRiZjhm
YWQuLmY4MDI2OWU5MDc3MiAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L21tLmgNCj4g
PiArKysgYi9pbmNsdWRlL2xpbnV4L21tLmgNCj4gPiBAQCAtMzI4MCw2ICszMjgwLDcgQEAgZXh0
ZXJuIGludCBzb2Z0X29mZmxpbmVfcGFnZSh1bnNpZ25lZCBsb25nIHBmbiwgaW50IGZsYWdzKTsN
Cj4gPiAgZXh0ZXJuIGludCBfX2dldF9odWdlX3BhZ2VfZm9yX2h3cG9pc29uKHVuc2lnbmVkIGxv
bmcgcGZuLCBpbnQgZmxhZ3MsDQo+ID4gIAkJCQkJYm9vbCAqbWlncmF0YWJsZV9jbGVhcmVkKTsN
Cj4gPiAgZXh0ZXJuIHZvaWQgbnVtX3BvaXNvbmVkX3BhZ2VzX2luYyh1bnNpZ25lZCBsb25nIHBm
bik7DQo+ID4gK2V4dGVybiB2b2lkIG51bV9wb2lzb25lZF9wYWdlc19zdWIodW5zaWduZWQgbG9u
ZyBwZm4sIGxvbmcgaSk7DQo+IA0KPiBUaGUgcHJvdG90eXBlIG9mIHRoaXMgZnVuY3Rpb24gaXM6
ICppbmxpbmUqIHZvaWQgbnVtX3BvaXNvbmVkX3BhZ2VzX3N1Yih1bnNpZ25lZCBsb25nIHBmbiwg
bG9uZyBpKS4NCj4gVGhlIGNvbWJpbmF0aW9uIG9mIGlubGluZSBhbmQgZXh0ZXJuIGxvb2tzIHdl
aXJkIHRvIG1lLiBJcyB0aGlzIGEgY29tbW9uIHVzZSBjYXNlPw0KDQpObywgaXQgc2VlbXMgbm90
LiAgSSBjYW4gZmluZCBhIGZldyBwbGFjZSBvZiBzdWNoIGEgY29taW5hdGlvbiBsaWtlIHRhc2tf
Y3VycigpDQphbmQgcmFpc2Vfc29mdGlycV9pcnFvZmYoKSwgYnV0IGFzIGxvbmcgYXMgSSB1bmRl
cnN0YW5kLCB0aGVyZSdzIGxpdHRsZSBtZWFuaW5nDQooc2hvd2luZyBleHBsaWNpdGx5IGJ1dCBy
ZWR1bmRhbnQpIHRvIGFkZCBleHRlcm4ga2V5d29yZCB0byBmdW5jdGlvbnMgaW4gc2hhcmVkDQpo
ZWFkZXIgZmlsZXMuIFNvIEkgdGhpbmsgb2YgZHJvcHBpbmcgdGhlIGV4dGVybiBrZXl3b3JkLg0K
DQo+IA0KPiBBbnl3YXksIHRoaXMgcGF0Y2ggbG9va3MgZ29vZCB0byBtZS4gVGhhbmtzLg0KPiBS
ZXZpZXdlZC1ieTogTWlhb2hlIExpbiA8bGlubWlhb2hlQGh1YXdlaS5jb20+DQoNClRoYW5rIHlv
dS4NCg0KLSBOYW95YSBIb3JpZ3VjaGk=
