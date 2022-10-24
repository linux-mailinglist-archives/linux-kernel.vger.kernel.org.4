Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2846D609B6F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJXHgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiJXHgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:36:00 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2087.outbound.protection.outlook.com [40.107.114.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054AD474CA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 00:35:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6GnJmmcequzogUHzN9Ou09rRLNaHSw2fQRkdxI7ElzPRdpdZtk4dRQM5DGGpGRGXrB4N0BgVKdRtG6ZqGG6Y0AkNKaYVkXRkpvyCAnTZcPbhZI+0Lmu2w7DwVHmE1ouit7l1baOuQZnilppP7O22N7XZzKCx4hTCX2OWuKCS25CCjq3dOpGg0Yf5tivtPln+AVMEL7HIotXBSX4ZeLtgDyTOBi8+uhztNIMrsc/qM8h9HelfHRl7s3wfziyNsveKiIld3wgt2WCCkSHxvzVWxIA3xkrJ7LpU8u2rETZzoaJw8bTDyAv1cCC+HPS0n/KDgp12YAP8t02oHA8jl8ewQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCiek6lvDhDf5UfL6uK95WAMzbkpeJt9GIX2vNGP4jg=;
 b=Hg4O1h7k73FnjsoGuCE3/c0ttJwlw3PJbc9DZ/VEmjM2msrpEeqkCajdt8SYW8A78RyIqVauz7ZrjfjSLsOB8gADvYF9WRuoeCmklrcxLwdrWgPxfnkFBHqk3BU9FcTAuRjHkcLSgc00tFWc8LiL3OUpek1ij0hN1INUHwfa9Nc8dhJOF7OzWkv08MiB418usArpQp8TiYq4G4gIQXNid3WwrzqlUptmuxgdr8LreMhEdY19VHJrteO90ZR6qfrx+ky31HgP1JxQz1bp+CS6l4780J+PXor635GTPJ+p0LrFHIAqTKE1iVVU0FR1vSoXNplkk0Ki8z5ILRVkMkIoWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCiek6lvDhDf5UfL6uK95WAMzbkpeJt9GIX2vNGP4jg=;
 b=GJfhOE8yEi+U0BXwThe3509z2eAfRUgVN+50Uj+rCYaftgLYmc5v8ub+3rLrnIk+53ydPIO9Qt22l9L0aQzKL1JD2g/F0ikqeIA1VmdMkuGBCV2ruiewUZgPL8EdFTL7JYRw98gGnIlC+B/WR/My9iDzoe4T1+5HoDwRX7Y2hHo=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OS0PR01MB5441.jpnprd01.prod.outlook.com (2603:1096:604:a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Mon, 24 Oct
 2022 07:35:53 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9f34:8082:cd2f:589c]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9f34:8082:cd2f:589c%9]) with mapi id 15.20.5746.025; Mon, 24 Oct 2022
 07:35:53 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm: memory-failure: make action_result() return int
Thread-Topic: [PATCH v2] mm: memory-failure: make action_result() return int
Thread-Index: AQHY51lNDdVOX+mTnEaVkQ0FfFOZPa4dJ8oA
Date:   Mon, 24 Oct 2022 07:35:52 +0000
Message-ID: <20221024073552.GA4043713@hori.linux.bs1.fc.nec.co.jp>
References: <20221021084611.53765-3-wangkefeng.wang@huawei.com>
 <20221024035138.99119-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20221024035138.99119-1-wangkefeng.wang@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|OS0PR01MB5441:EE_
x-ms-office365-filtering-correlation-id: 50f40b4d-edbf-44ed-f5d4-08dab5926169
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hFz089+HT905CJtBFpeLl9rFDfmp4HJ5cMy/e2EvwTntIIqABcZkAiR8IXwDq/D1DZZfJ74EOxrQiEGNwtKHvfhANCl5M0NfmbTFzKA6WdNiBIODce7+wVJ5c4laRfJtLzKUNTjVGnC3TtlsHlB8Mkeh7vRhHvWOMQHDIlJFl23Wt6MgI6gIokQ4yWF+nJWESl5MFNtq0Q2ODBGWHTUyRhKKovaJ7t65XJ5wkyXVtmql4mz08G9U5kdqQbdhAZwwHClRSz6AR6DZ+vN2QwU5E1HoOxHlxMJd5dMMvKTY91uKoRgsVWA0ry+9jAi/s9smRvM8zwdlUOBfCp7n741halzG/YERTCo4eC0MdgCvMUpD2f7nhHag0X1P7Z1Z3RhWf4fXSFjSN9+PFxChtMJsu8EDhcohzXvVGX6aerDLIKv87V4/r5pYco78Q7GEV2FB/Oz09K9n8kds1twkz8pGhmGFOY4PeiTJ5rrhpynXPiwiN8AIyixS6xvcY8CBfguwxC+ykvlfSes9YFvIm39NZGPU+IQBvpH/iqrBuWEHXIkF5xZexd1Q9WyKsoBdsMkloZcwgp5S7SV9ztogU1a/oRS/0lLAYJoA8tPq3uAM0ULC+m8kz8uFExQbnBgBhjC65WlGPtQ0NbkjrJyKK3iZpyXmnLjkB+IXm0vuKSkB2NIk1gpkd5ivUh5QfL1TXDH9rDMV0Hw+vn4028I9MFF4r9KA56onMIk964Z2vvjo232YWSysawptbGOpWBhJz41eo7CJM8O35NvkXFtqwdMDdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199015)(82960400001)(38070700005)(54906003)(6916009)(71200400001)(83380400001)(38100700002)(122000001)(186003)(1076003)(6506007)(6512007)(26005)(9686003)(55236004)(478600001)(6486002)(76116006)(8676002)(66446008)(64756008)(66476007)(66556008)(66946007)(8936002)(86362001)(4326008)(316002)(4744005)(85182001)(5660300002)(2906002)(41300700001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ek44UjBQQzVQWVB1ZDBGMjBIckw4bjNYTy9YTFJGcmNqclZWeXdNRi94OUI3?=
 =?utf-8?B?bWFDNzhkQ3pjRW55SkR0ZWFLaUxIZ05ySStwV0gveGJLMUI4cmJTc0N1NFAr?=
 =?utf-8?B?U2lVcXBRUzJ1aUJVazhpb3pwTnFrb25aUWhObDdZb3UrMFRVMlh5M1ZKcmhE?=
 =?utf-8?B?R3FuL29CYU1uWjBydTBPTzJJUUdrZE9BSTFVcEIyYk96dUxnU2c5eWwzVW5N?=
 =?utf-8?B?OWYvb0U4SlNCWEtRZ010YnNHKzAwMkE0ME1GdG1RRDBCVEpYUWxaWGJaeFRa?=
 =?utf-8?B?d3psbU54cXRLV2YzczVOczd4TVF1bzV3MTl6eUZ5dUU2dVZnZW4zenc5dTBI?=
 =?utf-8?B?ZHk0T1NEODI5VzRJeXRIMEkyN2FZeE9XRW5ZZHV6ckRxd1o4cFhuampPcFJn?=
 =?utf-8?B?cG81UzNrYjZFQURCd3hMVjBrR3JoaldrM25Lc3I0aDY0a0NZQWNyWDhDVW1k?=
 =?utf-8?B?blEvaTl3YTIzbE9Pbms3ek92ODN5VWtMMllvMWNNc2o2QlV4U045Yk4waUo5?=
 =?utf-8?B?cGJOK1M5dUpTUzNZOTh0YmFxd1U4em9VcFJJV0NHZ1J6b3FqcnEza09XQVlV?=
 =?utf-8?B?czYrOHFyUi9BeVZWUUNsNjBGa1RjT09HWENQaDV4R3IwSmdacWswMjZhU2Zn?=
 =?utf-8?B?dGszQ2ZFM3lQYWFJN2I3UlFTL2M2Z21zMWdBZm9ybXh4a3Z0ZmpTcUxkUjJ2?=
 =?utf-8?B?dzZmNlZJK2dSVGtNbUowWVNlK1g0d1VtVEFDMG9paEVVSVltVmtrVHMyVnRT?=
 =?utf-8?B?OE1rNGVnNHNJUFZiajVycVhwQVQ1Wno3c2JhUHNOYTBjRlVlbERINWVpa0tP?=
 =?utf-8?B?cTVzYytHS21RUEZ1ZFhZYnliYTZUWk4vQmtjUzJ3cWNweWQ2TzY0VERXaGpS?=
 =?utf-8?B?MlJxYjF0aEs0b3hRSjR4bU5IUFN6MG5VTEdPd25UUEU4MnhOazNHTWw0VlBv?=
 =?utf-8?B?bktwNzZoellBSlpVMTRSVjV5dHp6WXBNQnpzUzVOYWRad0d0QXhrQVA4UnNx?=
 =?utf-8?B?WHhTRWNTZ0tpVm56WDFQMWZPR2RKaldlVFd2ellTeVd4ckJwQlYyQzB2cXdS?=
 =?utf-8?B?QTJ6bTkrQXg3QjFXMC9OR2xXeTBUaUk2SklyTW9RbWVGdWxlQ0xRNW9XYktn?=
 =?utf-8?B?eDNISXNaeXMvcEhjK2FNamg5V1REUFk0eDVla1RKaEJPMGtKRzRaRnJEV2JQ?=
 =?utf-8?B?YzdZbVMwUzFBOHFoVDltR215UVRBZGFueHM4clpqYXBObGVRVzErWEg1M1FR?=
 =?utf-8?B?OXdLaUttWlBSenJ0QnFCZDNMMTM5dlFxKzRhR0JGT1ZBK0JMOU14VU5MeUJD?=
 =?utf-8?B?emFGZWZzWm9WemdYdENHaTJ4akZQZVNXZUFjdlZyV2R1K3p3VU43K1FNWnhM?=
 =?utf-8?B?Si9VZTRqekN5MUdOdm02bmdIR1lCSzFFMFdWcWk1YjdqZGZYSW1hVWZFYkI4?=
 =?utf-8?B?SVd4NGVob1NnZzNNS3ZFYXdTdnI2NlBMZnIveDhtOFFIWEZwNkUvSHdDNlQz?=
 =?utf-8?B?aXBCMTJzbDl3YUxJSUJLQTNXZTBMb25WOHFUZHZIWDAvcE5aMkx3U3RLckRW?=
 =?utf-8?B?THBlUFdVUDdDWk96VXRzTmpqb0V3eXl6SnpORitVWTB6OVRlWG1PLzg3WUtH?=
 =?utf-8?B?WEVnMVpRTU0zd0hBRXpDb3R0aWZsRUpMSmpKVXI1ZFFkVkhEa3ZabWw0ekhi?=
 =?utf-8?B?cWIvR0hkT1ZncG5OeElnOXlxVHVWc1pqU0gxQmt1amJHcnBqMGVnM3RzRGk1?=
 =?utf-8?B?TjZFdUE3SStldUt6cDV3R09yam4wcmdkYXZNMlpoSnJmQjRtU0RlUlNmcG5K?=
 =?utf-8?B?WlRqZVNkWEt1UEtONHI1d1hrRzdNYlJybHVXWTc5bDV0MWhIR3lvdlAzS0hu?=
 =?utf-8?B?UzRWM0RMejAzWk1JaUNhWUZrcEg0S25ZY29kaGxnaFUxSTZmU0w1Z0t5eVoz?=
 =?utf-8?B?OE9pWTE0UDVsTWczRi9RMFVjQ1l0VmtNMCsweVZYY2FEWWQ0SjJrZTJTSmZx?=
 =?utf-8?B?Z0t2Ykg5WE92bXdYTE1QSnY1QVd2dTR2Q1pYNTJPTUVDUFBweHBLTTFEaFdX?=
 =?utf-8?B?c0pIanNHWFRzWXdVNndyZ3VOa2dhOHd6MjBiT29DcXl1U3BHTWZwalJ0eVR0?=
 =?utf-8?B?RmhJRll0QzU2NGtaUDZ6MDRITXpsalJjSVlabWxyMkc1Yk5nNWxZTDFBdzlh?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97F7890C9725B9459F9ECB97689164B2@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f40b4d-edbf-44ed-f5d4-08dab5926169
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2022 07:35:53.0064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s5KO5qsnVx86Ca/0jjy9BZH2ZhAwNP/LRS+OmZiNweQ8GhAUoiiwwj2gikkLmaBohAPrFUNyRI5t2RnE/810Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5441
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBPY3QgMjQsIDIwMjIgYXQgMTE6NTE6MzhBTSArMDgwMCwgS2VmZW5nIFdhbmcgd3Jv
dGU6DQo+IENoZWNrIG1mX3Jlc3VsdCBpbiBhY3Rpb25fcmVzdWx0KCksIG9ubHkgcmV0dXJuIDAg
d2hlbg0KPiBNRl9SRUNPVkVSRUQvTUZfREVMQVlFRCwgb3IgcmV0dXJuIC1FQlVTWSwgd2hpY2gg
d2lsbA0KPiBzaW1wbGlmeSBjb2RlIGEgYml0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2VmZW5n
IFdhbmcgPHdhbmdrZWZlbmcud2FuZ0BodWF3ZWkuY29tPg0KPiAtLS0NCj4gdjI6IA0KPiAtIE1G
X0RFTEFZRUQgaXMgY29uc2lkZXJlZCBhcyBzdWNjZXNzLCBzdWdnZXN0ZWQgYnkgSE9SSUdVQ0hJ
DQo+IC0gYWRqdXN0IG9yZGVyIGJldHdlZW4gdW5sb2NrX3BhZ2UoaGVhZCkgYW5kIGFjdGlvbl9y
ZXN1bHQoKQ0KPiAgIGFmdGVyICFod3BvaXNvbl91c2VyX21hcHBpbmdzKCkgdG8gY2xlYW4gY29k
ZSBtb3JlIGluDQo+ICAgdHJ5X21lbW9yeV9mYWlsdXJlX2h1Z2V0bGIoKQ0KPiANCg0KVGhhbmsg
eW91IGZvciB0aGUgdXBkYXRlLiBUaGUgcGF0Y2ggbG9va3MgZ29vZCB0byBtZS4NCg0KQWNrZWQt
Ynk6IE5hb3lhIEhvcmlndWNoaSA8bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+
