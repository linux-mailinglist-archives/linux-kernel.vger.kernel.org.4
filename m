Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D617707C2C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 10:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjERIiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 04:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjERIiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 04:38:05 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3369173C;
        Thu, 18 May 2023 01:38:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEZqvGOQDu0W68X+dz78kL36MIeobVNPpr7hrzXrSYF9GPj8Wsg6q5pHEaVbrxL/6IGMJQkZ4UWw4Q7sXKkpZTeYsmTJEX9Tm4/T2R6FsLiFatwfqpUe1Kw53p99ZxAZ4Vp/FKPG/vNyx8CedZkIl3Sj/UA6D6Ou7QtqLG6VMdi3Fd1T9eAv9MzWL1SDaWnEO77iv3oOoz4SZmcF5LTwCDL0gUZp4dX6sS6+jTlWjGF8uIBr7Q9ASSqc77x93pG3/kqqwkzZFA72PO3EBtKI2rNA/tbCWU5Ak+LWWoMtxNyeyatONDdTFN4ZFZQ6VEa246Z7D/hnqQHT3/cdbQ6+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPJRRkNR6GRHiixj3z1zgkKoAvMAyc7rHb5NY6yNvYQ=;
 b=PokGf1ZqpVT88ZI0VdZqFm4fj3shds0YZcG4lx0I/P0bM1nZ/pQLkeJJAPzHq5HbeulodArDTUBstwv7VJYhjleDi3glnLrqA6dX8kjFiV8oUFHYGlGXJq/6lEqr7x7qvEAyMXxENvyoCDII5xKyJNs5yMTc4TtEcR7aI7ghn2SvImsIV5NeH9h8X3rjrqAciL4ohEfdRXNeVxWr8LimpHun/Mh90M6hxjpso5z9ej5LbSZVnIh+rxvYXmwwyYcpkIealeyUHWdrhOiKGmLb/vBLrSRb17xkv4Gqyv/fVz463r0nfx7a25IvxJdFv/lDt9zrFQkQ28vx1buY2sITxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPJRRkNR6GRHiixj3z1zgkKoAvMAyc7rHb5NY6yNvYQ=;
 b=f7GPjI7jfDmKwI8jm3UyIEZwchNeITz8JFEppp4M9aF9tap/7yrGeEBVp9JAzOhuVrkuASTXH91cMaBw28gGmN4du28T5SYKHvhYKjOcnahAcVemny1kVJ0YgD/w6ctpIIs2ociFCXj+WtZknRnLEQqmmM24W+BIj8BD1bGAvuu7locZZOxIVrjFi15q8sJvBKZs32MVdKXA9AYrjCEy6j+vHx6Awnp4QjzXW2t3e0Aw0oc2BExQGqzkYJGQIccaXqiBRbqMe9YXi0fOAZ67MFkTrLCb4ZDdBNQuo9+2U1zMC4tRdLKOw80HS+Rt/z8U7QHzm+78GHMsxcYfMvYj1A==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CYYPR12MB8751.namprd12.prod.outlook.com (2603:10b6:930:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 08:38:01 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 08:38:01 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v4 05/11] nvme{032,040}: Use runtime fio
 background jobs
Thread-Topic: [PATCH blktests v4 05/11] nvme{032,040}: Use runtime fio
 background jobs
Thread-Index: AQHZhBJOfsVlFwYj/UCDMPw6Hsnvj69d62AAgAHHyYCAAAzNAA==
Date:   Thu, 18 May 2023 08:38:01 +0000
Message-ID: <417e9772-d622-7d98-397a-7fec162f63a0@nvidia.com>
References: <20230511140953.17609-1-dwagner@suse.de>
 <20230511140953.17609-6-dwagner@suse.de>
 <50c50cda-23f5-b55d-a902-ce34de8498e1@nvidia.com>
 <eykbvi7lzhnbd6ft6cva6qu4lp5ryn3ha2fgigmao2553qm4bu@227ey5mv5ls5>
In-Reply-To: <eykbvi7lzhnbd6ft6cva6qu4lp5ryn3ha2fgigmao2553qm4bu@227ey5mv5ls5>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CYYPR12MB8751:EE_
x-ms-office365-filtering-correlation-id: f650a12a-8f76-48d9-78db-08db577b30ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5JeIqvOGCgDGpDmvd6MlIsTCTHY2MDrHeVRTJEPFNIIICkFc/pBxQJdNEpvvG1R7NlneVdSnw4YbiZUK47BS268Gf73/7ZZbkoUuPeJD8a5/7VVPKO7qcEsUIeWd0e2MtbpKQ6EhG1QIjYhL67NrT7rhcZB/7upq0F/yXYWKAGzr9AR56zKWchPYfJWPAzD3+s7YUYk936MxKOG7Fa13CyHTuQAjLcapvfQ4EldcYQBsHmjCTvlZ7VOsmkuqyuP4eDxvZMiZBY0HlfMoHA2djsPCuzkQ439XjbCb4OtclemBNyLXa/H1L2LzC69gkhKQqxWTZBzV9ooYZhUdPq5jvGPoDJUz23FaHOFm4x3GK0xp91Rlz6f35/g/3xvZiI14F4gVRk20Dk1356aXLhwRa7a89KKTKTkcvgV4NIuqpszQn50dbnLkAnMnHt7VpvqDYEeFSVc0fmoHYO3Fu4KHwhxW9XYtVuPWULzL8VzNhrCxgQXlL4oBc5Yj/hXORyC5yVRxv50Y7DjVB5mJsrf3H3XsfKs8xlmtYPKwgWCFAtcsKiGhDbVcOPKGRkrSlAlYdD8FktRW/roA1nKkptmTvYDOQxuoQ5n7Dym+DSjY9/Gcdo6l3Xf2QQQ0LoDDA2M1ei+y7XznR5QYGYclQvKddSV0B6tnTU0nOublYKw9wBGkGqPdVV8oQ0ALckkw8Wk6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(451199021)(26005)(6512007)(6506007)(53546011)(36756003)(2616005)(31696002)(86362001)(38070700005)(122000001)(38100700002)(186003)(6486002)(54906003)(478600001)(2906002)(4744005)(316002)(31686004)(6916009)(8936002)(4326008)(8676002)(41300700001)(5660300002)(91956017)(64756008)(66446008)(66476007)(76116006)(66946007)(66556008)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekRXTFQ1L3ZSVGtwcFNrc2U1YmhGU1R5KzhjQjRRbzRTQnEvTUZzalZnQ1Nm?=
 =?utf-8?B?eUxEMHRqbmJ3T3hGL3pVK1VwVTVlYUV3SThwaUxIc29PK2RTWHpVZkJvd2Zi?=
 =?utf-8?B?bGsxUkpxdVVUVjUwczNqRXEwbzhnQ1dGd2lYaFpYV0dXdkRSU3RvZTVPWkF4?=
 =?utf-8?B?NDFhU2h1VlUzcEM3T0ZNUmZ0OTd4T2ZMWDNlK2pXUVhRdEFlb0VmRWhjbmpH?=
 =?utf-8?B?S2txSzZVbExjaG9WZVJkZVNwNkUySjJ3aWpQTE1NMXBVRlY1ejhKbzQ4ZWZk?=
 =?utf-8?B?TXlIckpkUXl3aEpOT0JJSTJBQWtOc21PLytPNC8wNDNhbWk3YkNQTkhNVnlL?=
 =?utf-8?B?eFJFSE9iRkkyTThMVExkclJySnNGVExWbnZncVRKNTllUEVJU3ZrT2E4a3Bv?=
 =?utf-8?B?NmNWK2kyMzJMSnZjZFlpaGVEQTBxeXhZeTFGK1JVZDNnR0xnTGlMR1BlUWdq?=
 =?utf-8?B?VmhsQzUrUThJekpUTHhzWGlPME9XQXlDa0tNMDlqVkpidnZQaUs1ZHVkY1VK?=
 =?utf-8?B?VXpmcXNKbnc0aXJPUWxRV05kSnJ5QUNyNnhNVHJ4WG5wYUhER2JjOC9xWmVi?=
 =?utf-8?B?K2VpMVUwWElnMTFnMEZzWks4Qk1WSnQwZVpoTjdyR1o3aG9BU0JCSlhPNE8y?=
 =?utf-8?B?NlEwSVhaRmgzTGJzbC9Sa1NOL01xeXZOZnNkVEYzVWx1b0RoWXJpSVBwUE1Y?=
 =?utf-8?B?c0p0amZLckl4c1U5MjZwS2pnMGczWW1LenNzVVd3Y3I3Ukh4eDRBZ0MxNzg3?=
 =?utf-8?B?bHRoSWUxc1U2Z0ViWjFkL0lLMnpBMzdsWGgxd0Z4WEoyemlUNFo2S3BMTnd4?=
 =?utf-8?B?TUVVU3ZrbVJYanZTNERLMmZ5ZDFKRWhmSjYvN2tjcjdVcUR1NXNRUStrNml0?=
 =?utf-8?B?VDdjbjZGK1ArRnlIZXMvVitmK1VTSVZabENzQ1lPL280dVNDWW9KN1k4Zktr?=
 =?utf-8?B?YmJvOSt0Vnl1cVFuOCtRYXVTOXNIb0RKeU56QlFxSHVCRUpNdzFuc0dETTh5?=
 =?utf-8?B?anRRVmhLVWRVRnNQQnJkRTUxN1FTSng0UUYyenZqT2pxazVtUGN3Rm1WWkRO?=
 =?utf-8?B?MjFwR0EvK2hzZjVEQi9CNngydERNUGhlUnluTW9oYlFxdm0wSTg5SjhSOWJU?=
 =?utf-8?B?c2Z0ZHJtOEoyeHpBMldZcERWZDd4UytsdzA1SWFaeDVyQWhuRHBsSTV2Yk1P?=
 =?utf-8?B?NGtsa2JFdXVLUjBRWHZadVRKUERuVzdlRlFsQVd6SWFxcEdUbEhwQTlacnZH?=
 =?utf-8?B?eXdWdERQUHR5RmREQk82WjZoVTVGOEFwQnljTlhncmJHeThTRmNUUE5yRFBU?=
 =?utf-8?B?bzMyaUxsYlFRZ0xOdENRSXpKQWtLTU5iajNJMUFPMXg3TU1XeFZGc1hNcm43?=
 =?utf-8?B?V0hLSFk4dWxxZnpPMExHRWRCSEhDQ3VRVnczU1NVTVR3aFFSVDYwS1NqK1gw?=
 =?utf-8?B?SkNTbFhCdFVkMUdpanZyWUJpOFA0TFpxZ0syR3ZybXRLVXhyMXdxSGhacUZh?=
 =?utf-8?B?OFU4RXc3aXFHakJwVDNpYXlvYWlNenl4K0FNK2pibHAwR2RJd2JYR0VESlpY?=
 =?utf-8?B?MTBjY0l5ZGttakZFNytnUVh2Yklzd2hIZnJLY1NSQlJFdEN2T3o4eklGb2di?=
 =?utf-8?B?bkREYkhDeC9Pb3ZYc3l6cUs3eUM2M210L3JnSWxrdEhZQXJ0YmtHVlBhTkc3?=
 =?utf-8?B?UldIVjhiK0UzL1B2TWNKSXEvTXRISlBmV0ZIemtDWCtjMUtQM0Q1MFRWRmNt?=
 =?utf-8?B?bW41dGVuZTVtZXRaVFFyTk8wQVIvbnNHdklUWFZ0dlJaakpQRnVITFBXVEVv?=
 =?utf-8?B?SjVZYVM5Z0doZGd6Y1Q2SmJMS0JsZW9mY2UrNUFmRSsrSjJYREJKNldHUm9a?=
 =?utf-8?B?ci9TRFYyQm1EOC9TRnRTOU8wb0Q5VHJZK3Znby9vTHJmcHY4R0lySkU2NUpz?=
 =?utf-8?B?RlFhMkx5UXJJNlJRbmxWUkR5aGtLdjdqenJUS2YyOWIwQXRvVTMydmFmRWFU?=
 =?utf-8?B?Nm5jQTdEVUwwb3gxOTBDTFJGRFpGYXdXTVBxV1VDWUkySmQ3eEtFbU9FT2Fh?=
 =?utf-8?B?NUNiMmY0d2hxWXhiOUlwZHVrYUIyRWdBS2VIbmwwK1EwR0FPUjZxWDcxR3lN?=
 =?utf-8?Q?Esi9t+yjpv/W7OA0iAN1ZSsJF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9868B44CACBFF642B00599EAE65EE8BC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f650a12a-8f76-48d9-78db-08db577b30ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 08:38:01.2097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GdGr9lgjAZGlL5XaJ77misYq9lRYFWF5rl5Qc32IIkBoH4zJXwgsmoBpcY52bHYV/sPVE3vY5599lAf5ARnivQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8751
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8xOC8yMyAwMDo1MiwgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4gT24gV2VkLCBNYXkgMTcs
IDIwMjMgYXQgMDQ6NDA6NTJBTSArMDAwMCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4g
T24gNS8xMS8yMyAwNzowOSwgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4+PiBUaGUgZmlvIGpvYnMg
YXJlIHN1cHBvc2VkIHRvIHJ1biBsb25nIGluIGJhY2tncm91bmQgZHVyaW5nIHRoZSB0ZXN0Lg0K
Pj4+IEluc3RlYWQgcmVseWluZyBvbiBhIGpvYiBzaXplIHVzZSBleHBsaWNpdCBydW50aW1lIGZv
ciB0aGlzLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIFdhZ25lciA8ZHdhZ25lckBz
dXNlLmRlPg0KPj4gSXMgdGhlcmUgYW55IGlzc3VlIHdpdGggdGhlIGV4aXRpbmcgYXBwcm9hY2gg
Zm9yIHRoaXMgY2hhbmdlID8NCj4gVGhlIGV4cGVjdGF0aW9uIG9mIHRoZSB0ZXN0IGhlcmUgaXMg
dGhhdCB0aGVyZSBpcyBhIGJhY2tncm91bmQgam9iIHJ1bm5pbmcuDQo+IERlcGVuZGluZyBvbiB0
aGUgam9iIHNpemUgaXMgYW4gaW5kaXJlY3Qgd2F5IHRvIGV4cHJlc3MgcnVuIGF0IGxlYXN0IGZv
ciB4DQo+IHNlY29uZHMuIFRoaXMgZ2l2ZXMgYSB2YXJpYWJsZSBydW50aW1lIGFzIGl0IGRlcGVu
ZHMgdGhlIGhvdyBmYXN0IGZpbyBqb2JzIGdldHMNCj4gZXhlY3V0ZWQuIEV4cGxpY2l0bHkgdGVs
bGluZyB0aGUgcnVudGltZSBpcyBteSBvcGluaW9uIG1vcmUgcm9idXN0IGFuZCBkb2N1bWVudHMN
Cj4gdGhlIGluZGVudGlvbiBiZXR0ZXIuDQoNCmFncmVlLCBpdCBpcyBiZXR0ZXIgdG8ga2lsbCBv
biByZWx5IG9uIHRoZSB2YXJpYWJsZSB3aGlsZSB0ZXN0IGlzIA0KcnVubmluZyAuLi4NCg0KUmV2
aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoN
Cg==
