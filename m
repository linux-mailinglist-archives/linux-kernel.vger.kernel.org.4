Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D3B652A07
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 00:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbiLTXxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 18:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiLTXxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 18:53:15 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2066.outbound.protection.outlook.com [40.107.114.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B93815A2C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 15:53:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+Bd2VU8FyNFYiAyH98t2SeK+GM7B6W4SctsIH24aRlAirtjCTeoUO2JZeVq9Hg7+oWoZx04Sl+S6GlBrAQqM6SeMrua+IoRX1TPDmjPZvV6kzo6/cPYEr80Gh3C6y5kivaQjVOIwPrKO70gy40vHNmmVM7bHANFhh4JWL5k5Gle6oULkXKrueLeksJjFfBTHYAr6ZPmDc/XSfI3126XvazwtW3E4LB7towydDx/HhOD2xrBHC9lgMttZMGN5gwUYZr0Td1w3pSJidlC1+e4u6QXesHPDLGZFlBruXxhJJgSSyMiK9T0E/cGxBmheYKC/muMfYvwM5JYA0WFD1Yz+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXBCKpU0wNjTIfKdJU9NQPrjAgODEB0Gaw5tQi9QbEE=;
 b=JTciBhtKPvv14mtG3vCrgh4QXYlj0oPn7OmADe8rdaJZkNWZAHGpk4r4hB/Lo0NjNfjD8KTKpqHw9padAe+BNCVlTbIyB/JKtWwRq59on2mpUs9wjOzy5E/h5Xm1wii3hK6cPx3jCvT5aeMtloZriJn000b1bsrYjkRA6etqyRxuiZ+9gpPrKA0oG4U5ONpC4Iq3KyRwP9Rz2ffwKQPX96dw/LjX38+FwAxXD6lUb67Ey/ltaDCrlU5oLglfnWt+nlMLi4yel1Ribkeb1MaXQs3k5CgBuoX6hSadT1pX+pOw50Kal1tQ6VNZ6vGGkc7aKrdtYInsuM8Qz1XyFOcLkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXBCKpU0wNjTIfKdJU9NQPrjAgODEB0Gaw5tQi9QbEE=;
 b=UWtSBJCOUtEa66iapJ4hZztNs4QZEWdVX0GeuP8lYKn3SsPEgxtDXMeI15LQeNHonCdoa9ZyQA3vHhRgaH0ds/KAnnHyMpDWqXjB5MnTt6wgKcRD3vdIzhIcN9Z6iZrJFVLes0+cBezXHOicju+dqcWF0CIkN83L4sVvyqoPCBo=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYCPR01MB8534.jpnprd01.prod.outlook.com (2603:1096:400:153::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 23:53:11 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::8c61:6836:588:47aa]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::8c61:6836:588:47aa%4]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 23:53:11 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joe Perches <joe@perches.com>, Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew WilCox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v3 1/4] mm/hwpoison: remove MF_MSG_SLAB from
 action_page_types
Thread-Topic: [RFC v3 1/4] mm/hwpoison: remove MF_MSG_SLAB from
 action_page_types
Thread-Index: AQHZFM43bQ2DWz1Qc0mA6D7JK/lfUw==
Date:   Tue, 20 Dec 2022 23:53:11 +0000
Message-ID: <20221220235246.GA2334024@hori.linux.bs1.fc.nec.co.jp>
References: <20221218101901.373450-1-42.hyeyoo@gmail.com>
 <20221218101901.373450-2-42.hyeyoo@gmail.com>
In-Reply-To: <20221218101901.373450-2-42.hyeyoo@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|TYCPR01MB8534:EE_
x-ms-office365-filtering-correlation-id: 022d8a65-712e-4a90-beb8-08dae2e55a0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Uo3CkXpeWp5UN89pppBUMDJTqHqjLHql4zRPjq6QnxLpM7ggn0rsGpmCGakwMwD9NU26pJpmE3f/0lvGnmUIbn5bQaCUrCl8zRorTbC1Ev6R+BPETp8jiLzwqEW8cc29PZ4jaULvDf444RmLtAuTVJFLreO6o/wZ5C5zor8XJzlIQpbneDpCl8tQU8MwKttBTYmjnLaNWB9xs8ctdSmJRRoO4rKtM9BHRjOR157LdYbAIKqufs6yvoXIGSiqQLzA4IMxUJZqFR4nljkzqch3bgfm0zrsnTgvhxUw386Mztdb/F92LOTIykTrnx4gROwX9Uco/x9zEhnU9z2GXKZMjyUGYVl34bwJTAn1hfqy8LGgRjMbqH13uSVIEYSfrl8+lIZ0WqmAPD00NEmSRkMaFmY7xo6XOzdOhPFkDM0iYGdUbhqQ300vTLRFaYnRHVpkFgW8zxFg607b+pZ+5onh9vUkzUEclSrZTscOdwyVKuK92WIMj/W2Dni/XYE1VaKcogkdCbkv327onipZJfjS6UhyZm90oGkdi3XfPRNDBliKDoL5L2O6Mfgvgv43loUEQ8toJeizEUHpbjfx3bdVN25jlCZonXiJciPpYyKdtqSd3ar8dBynUsorCIjZUoAyWNs8OhLJ5pSsddwYjcR4wgF9AvcCpQsRBKA+w5WNuPA+eAYvNNea6BUHpjdlixfZvrgpH/RYEh7XK3PbaLYl/hhdSps29i77XyyV5aqPAM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(451199015)(86362001)(82960400001)(38100700002)(26005)(71200400001)(6512007)(9686003)(2906002)(186003)(55236004)(33656002)(478600001)(54906003)(966005)(6486002)(85182001)(6506007)(6916009)(316002)(8936002)(122000001)(66946007)(4326008)(64756008)(66446008)(66556008)(41300700001)(4744005)(76116006)(66476007)(83380400001)(5660300002)(8676002)(7416002)(38070700005)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjErT1g1QUppenF0Z0FiOXZhQ3JQeGJ1MFl6WENBT2FMK0JKMkJ5TlVpYTVm?=
 =?utf-8?B?VUFtK1RtSElTeTJ5czhvV3dLL2NheTN5ZHFsaUNSKzc1TVNMZmxPaHkwZHN4?=
 =?utf-8?B?SVVmcEdhSFpIeEVPdEJaSFJBalQxb3lpUnQrVWp3SUhMckZwWkFBYnc0dk1M?=
 =?utf-8?B?Z1l4U1N6QUhBUmxSYjVPenRacGdqekIwd2JTZzM4elltUG1JSWtkV1dnNGlu?=
 =?utf-8?B?amhOcnMxTEZZK0wvZmQrc044bGIrY0t4d1Z3Z3B0OFlvWE9TeDNqOHRJclZq?=
 =?utf-8?B?M2E2cC9Qa2NsV2JyZy9NNGtEK0prbXQxMWJUZWM2R2pNWVlMaEtXUU5McmFY?=
 =?utf-8?B?VDdFMW1jOTIwZmtwMlk1ejJjN05KbWh5RmVDWjJWdkxYMHV6MklKS0NGdCs0?=
 =?utf-8?B?TUFmNVhtWXJ2aVh5T3NydnJzTWZGYVJaTDVKNXN0R2FxaERuRlJyd0tweC8w?=
 =?utf-8?B?N2ZzQ3JDWlZZV005WU03QnQ0ci84T3JIaWU1TlpoT3c1ZDVIRFBMMEU5YU9E?=
 =?utf-8?B?OHM0bytoMnhXVWlJUStZVlV6YW1CellkQWE5R3k1SHlSMzE4YmN1eUtpc2xM?=
 =?utf-8?B?dGNMU255SHhkS1RoLzlKdkZQQUJXNkpCS2l3anU3NFdsRnB2WHJkWlRRaW9E?=
 =?utf-8?B?azI1MEpwSVVJUVZIdnlxeEhQV2JqM0JZN01rRU1oNXZ0RVhYMGlwdTNOY0Er?=
 =?utf-8?B?U3BDaGJBWmFBQXRWenYwemUyQU05SStaOWszeTZEMGJBbVdndjNVbC90eFp1?=
 =?utf-8?B?cGY1WDIxamZRQ1JVWDZ5cG1PdG9uWjlSNm82MlB4SXVNMmw3b3VBNXYzSXRx?=
 =?utf-8?B?eDkrd2NuK08vdThqSSs1aUlPeXRraFVzY1dzQTEzTVFFVHVCaGJUZ1ZzTkQx?=
 =?utf-8?B?eTlGZXdROVZiMWRRVTFYNlJSbjExZ041dytjeWV4RjNjcTVDQzRkeVpsRFFQ?=
 =?utf-8?B?MjJrZ1J5NjhjZHVrRHFESGdMNGpVRjE1U1AxekR0UWNsUlBpVktwQW9vMCs0?=
 =?utf-8?B?UnVFQWRaQmNOSVh6UWhNMUZkNUh1N3U2WFBRR0wvTHo3ZWxyNnE5SE14eXpo?=
 =?utf-8?B?WSszZTc1Mk5JbThJNlNoWmpwSHhMWkoxNitOVHM2OEpud3FaSi93VmpZZnlM?=
 =?utf-8?B?bFozWC9LRkp6cTNyZ0g3aFhadFZ5c1dmdkNRTlhsU1JhLy8vclF2K1MvdHU0?=
 =?utf-8?B?LzFpU1I3RVg3L2MzZHJuKzVPd0YyWnp1eGk5bXZVeGVMOHdWY0ZueWF2eURa?=
 =?utf-8?B?YlVJNjk4SGZXSHR3Wms5blN6NUhTaWxwWENUbmtlVHlzdExadkppeGVyYVZu?=
 =?utf-8?B?azRTK1R0Z3RpK0ZkVktaaS9aa1BaR05hRVdnSVRYNlBsUnNMUXJnaTNaQTUw?=
 =?utf-8?B?RG1FdHVBTlpDajZVSm5nL1VSalBSakJrNUlmWjVnOUZxNjNWVm1HMlhNZGYy?=
 =?utf-8?B?OHlRTTZSQ29NOGpreWRTc1BWdUNXK09VWjNhaC93d0FMcWpiMjNyY2JMd0F6?=
 =?utf-8?B?Uk41cWJzZ21GdzJMTlVybThJOEovMkFRaUNkWm9la0pua2w2M2NDdzhrSEhR?=
 =?utf-8?B?eGNrZG5qQlpSdWpQT29ZOEZ1NW51ZjIzcWlXb3lXR2lGbk9IbFV2WEZiQS9z?=
 =?utf-8?B?OWRxSWVTOHRLOGxOdEdDejl4SGNMS0h2b3QzcFQveVJ2UWFVMmdmaEkyZ3Ey?=
 =?utf-8?B?ZlVGUThtOHNETUowcTRrWU16QVJ4QzB1bmVnQ00yOXBtdUJGMlhOZkJjZ0hn?=
 =?utf-8?B?YVpYSzdacVBOT0lvR1IwN2p6ZGNPdXVncHJZMXkvTFkxU3BySSsrdjkxSXo0?=
 =?utf-8?B?ekgxSXI1Q2FoLzZLK1hyOUk4dFo2RWlSOG5ZM1FSL0JzSiszdjZvKzVTZDhy?=
 =?utf-8?B?cFBNNExrc2RrWmh0ekViM2xmY2ZLa1hYTmVrWU5MR2VYcEZFa05nMDRtZjZI?=
 =?utf-8?B?c04vZC9YelR3c0ZXSXNaRGJMMitGcldKNTlYMXVjUldoaU42OWhRRnR0TWhF?=
 =?utf-8?B?Qmt5K3F5K3h4YUVWWFJpVzlHQ3NNVmxMRERKUmQzbUJtWnpEbllVcjB6ZUtK?=
 =?utf-8?B?REhidW9CaE9lU2NRV0NBeGVHSVZCZzdnd1dEVHdpYlZqV0w3UUVLaFFuT2c0?=
 =?utf-8?B?T2xqbzNUU2M5eWxNa0NZR0hPeWIxbGdBeFFFcFk4eU9yaEIvYTBwU3BHNklI?=
 =?utf-8?B?cGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <466E8D64D138224586099FE6492796D1@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 022d8a65-712e-4a90-beb8-08dae2e55a0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 23:53:11.2337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 15CP4ud+tomfdzsx4tBAbCk73GfJnTWzvpffYqxpTkrRqEsVhzOQ7BAxfROLTKe73AeH+nkv5rEki+uuUpUy3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8534
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCBEZWMgMTgsIDIwMjIgYXQgMDc6MTg6NThQTSArMDkwMCwgSHllb25nZ29uIFlvbyB3
cm90ZToNCj4gQXMgc3VnZ2VzdGVkIGJ5IE5hb3lhIFsxXSwgaWRlbnRpZnlfcGFnZV9zdGF0ZSgp
IGlzIG5ldmVyDQo+IGNhbGxlZCB3aGVuIGhhbmRsaW5nIG1lbW9yeSBlcnJvciBvbiBhIHNsYWIg
cGFnZS4NCj4gDQo+IENsZWFuIHRoaXMgdXAgYmVmb3JlIG1vdmluZyBQR19zbGFiIGZsYWcgdG8g
cGFnZV90eXBlIGluIGxhdGVyIHBhdGNoLg0KPiANCj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LW1tL1kycytkbkJzSEFKdTE5b2JAaHlleW9vLyNyDQo+IA0KPiBTdWdnZXN0ZWQt
Ynk6IE5hb3lhIEhvcmlndWNoaSA8bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IEh5ZW9uZ2dvbiBZb28gPDQyLmh5ZXlvb0BnbWFpbC5jb20+DQoNClRoYW5rIHlvdSBm
b3IgdGhlIHBhdGNoLA0KSSB0aGluayB0aGVyZSdyZSBhIGZldyBvdGhlciBwbGFjZXMgdG8gcmVt
b3ZlIHVuZGVyIGluY2x1ZGUvLg0KDQogICQgZ3JlcCAtaW5yIE1GX01TR19TTEEgaW5jbHVkZQ0K
ICBpbmNsdWRlL3Jhcy9yYXNfZXZlbnQuaDozNTk6ICAgIEVNICggTUZfTVNHX1NMQUIsICJrZXJu
ZWwgc2xhYiBwYWdlIiApICAgICAgICAgICAgICAgICAgICAgICAgICBcDQogIGluY2x1ZGUvbGlu
dXgvbW0uaDozNTAyOiAgICAgICAgTUZfTVNHX1NMQUIsDQoNCiwgc28gY291bGQgeW91IHVwZGF0
ZSB0aGVtIHRvZ2V0aGVyPw0KDQpUaGFua3MsDQpOYW95YSBIb3JpZ3VjaGk=
