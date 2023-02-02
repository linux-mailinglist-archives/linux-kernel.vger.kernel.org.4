Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D096873C1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 04:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjBBDXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 22:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjBBDXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 22:23:38 -0500
Received: from BL0PR02CU005-vft-obe.outbound.protection.outlook.com (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EF34FAE7;
        Wed,  1 Feb 2023 19:23:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjDo2csz4fueyowiFG4uiu6ep0h/3mstOGa/PKSNeR1Mdaz/IEf958YwaZEe3LnK3pDkhqeNDzKDLRtZpAL9ySFWqZ2z1uL0FlWcgmW/ySiSYkvL6VnBiBcuH5yc7tDxdiw2esgf4wGFieUZ50+//6e3k4Plyow3Opf5rjaVhgM1zFA5SJFDXQDWFRo1guUtggjMNhweMnU7DI95VyEJ70gG9LBvuhLUm99Vpmjrddmg10onLxQ9/UBZLkUkD1B9Qp5nafZtrMwHJZ3CtSss5yMBqiJ2P1hNh9zVpfVv0qL9H377ouRDHxJlos6WInL2dBRDa0rnm1Uxj/qIDY5vrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CgDl+VNo5RytyrL/k+moMAO4jQ2N3VGv9HRhEqUSn8=;
 b=Y6kIPArAt5Xo/JCE1aZp/yAkyIayrihO5adLSeykStOfIC6rGbgyM1S2f/7QeoGsYBPY+RTrvKhSPi+zlnATy1dl6Pi6xoaSZb9t89MKftFd//MREwLqk+yHLrnLegNzvkLJ8KCHrN9dZeez1tnHdKpBxIrrHxY+rkwLDZKtUdN3fZ2sqfsz4EXDyRrARpnLQ5I7gkjigQuLTxq44aVmQ+YwtNtmXJIoEJOx6m1rr1WzjouRo65R/HlhwNbtDAuRZbC85thLeKKGRqBYEenbd4dvDOe1T+yacFG3H2EZ8oK0b+aGgsnTnaIA8q2XhAGCULnoMoIG4RSnElebjg0c/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CgDl+VNo5RytyrL/k+moMAO4jQ2N3VGv9HRhEqUSn8=;
 b=ALv3It6iyq+qd8FfnGsvYMcomSeg31Xelv+xSquzwDKcN7UriojC4SyINSSNGbOR/WD0bz5IKSv3gEO3BDnN7nXFb3ce/VHEh0ZXq0fSS0mQnaZLNs7xFAGKnuGmZYgCSGWceNijWiLQKk/jSTSIG10doq4Q6hb9v3P35fgdpxM=
Received: from CH3PR05MB10206.namprd05.prod.outlook.com
 (2603:10b6:610:155::10) by SA1PR05MB8408.namprd05.prod.outlook.com
 (2603:10b6:806:1d7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Thu, 2 Feb
 2023 03:23:35 +0000
Received: from CH3PR05MB10206.namprd05.prod.outlook.com
 ([fe80::ad2d:cb08:253b:26e7]) by CH3PR05MB10206.namprd05.prod.outlook.com
 ([fe80::ad2d:cb08:253b:26e7%7]) with mapi id 15.20.6064.027; Thu, 2 Feb 2023
 03:23:34 +0000
From:   Zack Rusin <zackr@vmware.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
CC:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Banack <banackm@vmware.com>
Subject: Suspend with ps2 keyboard/mice
Thread-Topic: Suspend with ps2 keyboard/mice
Thread-Index: AQHZNrW7KJ5vtr9de0a88QyEj+Za8g==
Date:   Thu, 2 Feb 2023 03:23:34 +0000
Message-ID: <6d7b3cda248c7ca14d6fb3c8fbd49345306ae46e.camel@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.2-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR05MB10206:EE_|SA1PR05MB8408:EE_
x-ms-office365-filtering-correlation-id: 74895c8e-8566-4060-8f8e-08db04ccdddf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J5lzXDFZ9/eZzmCagwZj9ibN5oXR/Pq8Dn5TLv4D8ZYVaI3yrngXU3u3uHDs3JkWQQXKQ1aytgsh0HdbNMA4xGm0y0fj5cxljoUpS0IROVJDhm2OzeKg4C47oRcY4NlneUFxRqOqW28CStGLd+xJRCb0j9yzD3Jm3D7J7yicyeeEyMIQbQQI7w/+E82OGGW/Zjvrj8EOzYwYBPxmGVrFhkgJF6KwqbKmgBpd6tBNrO1mIq3Hx566+kKYG/LBUWbLjgjn6UsHiQwwZLTWGpUmejLPQuLqjmmxBI3uTtqxBiQJBpAt9aXAXcM3VtVwR4EggV0WTuD35gobDr6K/skfA66f9XvZCNBQ4idS7qYOWPYuHyCKS54zTR7cncEoJuY7eaHhKOXnbGMh5M4+HZzCXX6IPJWhfZEU1gaEOlTCbcPin+TM4Fl3rIS6iApzz9LrPyKAKpY3g5k/JQ8idgO2d779zMH+UMxCoerR69qI52qOQV449FUXcEiYk6TRDYGp7ZAXh5qqombclTPuQfqsQJTYiduj2DHz1ph+fnLK9NxOJmWSKdiw5cFQNU0QllVfAQHvU9eJjUqo+S8sou4nC57YAruCr4+Lv3UYgCa3K9Q+ZLoeKcWK7FOHSrL+BoxeHMIETOth2X+w32nbzZMr3TQSidfHGhrbvcBXasyMP32RYj5pjE6x2HcqsXRZwvKefJ3J33ILsRglOO8G+duszQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR05MB10206.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199018)(5660300002)(41300700001)(2906002)(15650500001)(91956017)(76116006)(71200400001)(66476007)(66946007)(66446008)(316002)(64756008)(66556008)(4326008)(6916009)(54906003)(8676002)(6486002)(6512007)(36756003)(107886003)(478600001)(2616005)(26005)(8936002)(186003)(122000001)(86362001)(83380400001)(38070700005)(6506007)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clJQc29sOVpzZ3piZjkvZHg2MXVMaGFDZ0xaODZUWGd4TFhweUd0Q09DQkVG?=
 =?utf-8?B?ZGFtRzJBOTAwdEhxa1A5elU1bVRGeXRjc2Q0bEk4SjU4N3hqS3hocmQzc0xy?=
 =?utf-8?B?UFdkV3p6QUhyLzRFcHMrREVHRlZJZ0tUR2JILzByekJYUm9DT012L2FWa1FC?=
 =?utf-8?B?VWNWNkF3Y1owazd2engvMm9UMUJwWjZOUHAzdU4wWklQY2VXc0lpczNjek9y?=
 =?utf-8?B?N3dHbWdqRXpkMC96VzR3azlqLzJuS0tRcVB1aFpjb05GZysrRzNuTXBjcnVV?=
 =?utf-8?B?SmZhMUczMFF5TUFvUlZwdGhXeThWZUlXTDNqbllPazRYZUxyRjRxYWlqYkRW?=
 =?utf-8?B?WVJWTFdtaGgwNWNHVnFrSk9PWFJXZHVPRUVpTEZIWE02VVI3R3F2Vk9YWjlm?=
 =?utf-8?B?UmxSTncxSzBBZXhnMUFuVW5rMm10K2VKTnJBYjFYbmpET2pTcFpoRnlwbXJN?=
 =?utf-8?B?NU5STFlwdi9JTk5MejZkeEJCZ2pDWVBDV1I1cnlYRFQ4YldqOU5BTUpBZnlY?=
 =?utf-8?B?Y1QrRHU2Um9obFRETGYxUGg4WFBlZVVTRUVTWnl3QWVoNEhGci9RRkwvekNI?=
 =?utf-8?B?dHkvTWVjRUc4QXhSbngwdldWZXRBeEpPVytmc09jS3lrb0FLS3BIY1gzUHNY?=
 =?utf-8?B?TkdUcENCVkhMc0NSRDZGSjJEYVpUL2FqWmZzbHJicFp1MnZndGtKWm1EeEFu?=
 =?utf-8?B?OTQ4UW1Mc2h2L2ZoTStyM29PSi9PbnowOWc1bHMvdVdpcllFek1nUmZtQ3Yr?=
 =?utf-8?B?TU1jU0txNkxPOXZVanpJTmdrc2NjdDg2VThXZnVjTlozbXZIY3o3VWVSQnJP?=
 =?utf-8?B?aUtkcCtQVEh2WEM3cFpLU2U2ZTkwYTZHWFZCNmdqZUkwZS9FK3JKRzJKSDdC?=
 =?utf-8?B?Nit3QXFEYTJzcGFnZ3JwZ2dCVE0rQUt1TjdBZ3d0WktHekI1UEE5VjA4bnA0?=
 =?utf-8?B?RjljTDZWMi9OWEZEdnViZ2hwdUo5Z0FZbHZhVkpBVXI3ZThEZkF6NTVtdU00?=
 =?utf-8?B?MjJ2MUdVRXBnZmVycFNOaHRDR3dvZHJHOFRlQy93RUtoZ1BYOEpWMzRCc1R6?=
 =?utf-8?B?RFFwdERSQTJYaGV5OUJPNWtHZWphaUdQWGVsS1JnQ3JlQ3VDOVl4akJtbVRX?=
 =?utf-8?B?ajNMU0R6MWZPdG9FdUd6SCt4Q3BGSk9Ob2pHTFJIQXI3SXY2RXJXSVpUaUpO?=
 =?utf-8?B?WHdRcElGNDV4UkFFS2g1TGVpUlRYckt4cTRhTWdjeWh1a204OFljTFJybCtv?=
 =?utf-8?B?WkZ4K1EyaUhIK04wRllaaWdSalF4aGtXaURIcGNMbGU0TnNYdXJKUW1JVjBq?=
 =?utf-8?B?SGEvVHdXZ3I1TGwwTGt2MUxCQzRGSjBvSG16WGVaOUQ3UFNPM2ZSSEVUblky?=
 =?utf-8?B?aldza05DdG1NVUFpbHVMdTVSU3U0QkYrR2pvZGFyU3NZMm1xSllJRkQySW1Y?=
 =?utf-8?B?cDRtWklyNHMrSHdaL09RUVNMQml5am05RjBqYmE2dis3L2lQTzdRVmxrM05U?=
 =?utf-8?B?OGROV29pUklQMHdTanJvU1BWSzFBSjlDUkFlek5BTE5KY1AyaEhFQnJ4SGQy?=
 =?utf-8?B?TGo3TVdFVFdJNkZGUjVQaU1ZMlNjbW5VMk5tTUE1VU5UODlRSVM3VFkzdjRq?=
 =?utf-8?B?NTd6bVJLYXdwRE1lZTBZLzc5V2ZFNXI1NUowS2hUb2FsQ011MkhHM0JDMDNw?=
 =?utf-8?B?emI1eDdKVnhvUDZIV2F4WGIxRGRHcGE2OC9pN2tnY1ZaQkh0VTE1NVhuTUlr?=
 =?utf-8?B?UW1XdkhOQ3pkVU5adGx4NGNUalUxM2t3dWE5bzQ1em13K3Q1NmtvMWdBN2Ji?=
 =?utf-8?B?STdueUdiWTFWTE5SNjFDWTh3Ui9pakI0d3MweHFwR3JQWUlZNlRXNXlNRTVJ?=
 =?utf-8?B?UDc1TkkwdmZLbnYzQ1VhWVF1dk1QVTRpZHgvODNEdThaYnNuaDNmdTNSWnli?=
 =?utf-8?B?aTF0dHh2MnhucDIxTmZBSGxIcm0ybUJWeFRWbDFTck9nNnhDU1NzT3FLRHJy?=
 =?utf-8?B?aHVGZEVkNytENCtkTEVFMGhyZ3UvVHZoZ1ZEVXJLVUkxOFY1K1laVldHRFdV?=
 =?utf-8?B?aWR0WUlnNi8vRVd0eXBMRkt5N1FwTXZsWWJaZEZXUWo5d2ZpSnFhZ1JsVEd5?=
 =?utf-8?Q?iBSfo7EYdHbljcc8ymppS8yBX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DAA4C0DAFD2582428FB754C34CE6EED5@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR05MB10206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74895c8e-8566-4060-8f8e-08db04ccdddf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 03:23:34.5000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SBcHrqQ+oXysbrJrXM1k+OTfgWRytQYQR6cryC0qOzmC+zsAwu2eY77IsaKtLp8qXWokIiLF2HauU9SUrRC9Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR05MB8408
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERtaXRyeS4NCg0KV2UndmUgYmVlbiBzY3JhdGNoaW5nIG91ciBoZWFkcyBhYm91dDoNCmEx
Y2VjMDYxNzczOCAoIklucHV0OiBwc21vdXNlIC0gcHJvcGVybHkgcmVzZXQgbW91c2Ugb24gc2h1
dGRvd24vc3VzcGVuZCIpDQpiZWNhdXNlIHdlJ3JlIGhhdmluZyB0cm91YmxlIHNlZWluZyBob3cg
aXQgY2FuIHdvcmsgd2l0aCBzdXNwZW5kIG9uIHBzMi4gV2Ugd2VyZQ0KcGxhbm5pbmcgdG8gd2Fp
dCBhbm90aGVyIDQgeWVhcnMgdG8gZ2V0IHRvIGEgMjAgeWVhciBhbm5pdmVyc2FyeSBvZiB0aGF0
IHBhdGNoIGJ1dA0Kd2UgZmlndXJlZCAxNiBpcyBwcm9iYWJseSBnb29kIGVub3VnaC4gDQoNClNv
IHRoZSBrZXJuZWxzIGk4MDQyIG1vZHVsZSBzcGVjaWZpY2FsbHkgY2FsbHMgZGV2aWNlX3NldF93
YWtldXBfZW5hYmxlIG9ubHkgb24gdGhlDQprZXlib2FyZCBwb3J0LiBUaGVuIGJlY2F1c2Ugb2Yg
dGhlIGExY2VjMDYxNzczOCBwc2Jhc2UgbGVhdmVzIHRoZSBtb3VzZSBlbmFibGVkIG9uDQpzdXNw
ZW5kIHdoaWNoLCBpbiBjYXNlIG9mIGEgbW91c2UgbW92ZS9jbGljayByaWdodCBiZWZvcmUgdGhl
IHN1c3BlbmQgbWFrZXMgc3VyZQ0KTGludXggd2lsbCBuZXZlciB3YWtlIHVwLsKgDQoNClRoYXQn
cyBiZWNhdXNlIHRoZSBkYXRhcG9ydCB3aWxsIGJlIGVmZmVjdGl2ZWx5IGxhdGNoZWQgdG8gdGhl
IG1vdXNlIChtb3VzZSBpcnENCndhc24ndCBzZXJ2aWNlZCBpbiB0aGUgZ3Vlc3QpIGFuZCBpdCB3
b24ndCBiZSBwb3NzaWJsZSB0byBkZWxpdmVyIGEga2V5Ym9hcmQNCmludGVycnVwdCBhbnltb3Jl
LCBhbmQgbW91c2UgaW50ZXJydXB0cyB3b24ndCB3YWtlIExpbnV4Lg0KDQpPdXIgc3VnZ2VzdGlv
biB3b3VsZCBiZSB0byBzaW1wbHkgcmVtb3ZlIHRoZToNCnBzMl9jb21tYW5kKCZwc21vdXNlLT5w
czJkZXYsIE5VTEwsIFBTTU9VU0VfQ01EX0VOQUJMRSk7DQphZGRlZCBpbiBhMWNlYzA2MTc3Mzgg
LiBJIGRvbid0IGhhdmUgYWNjZXNzIHRvIEhQIG54NzQwMCBmcm9tIDIwMDcgYnV0IGl0IHNlZW1z
IGxpa2UNCnRoYXQgY29kZSBicmVha3MgZXZlcnkgb3RoZXIgd2VsbCBmb3JtZWQgcHMvMiBjb250
cm9sbGVyIHdpdGggc3VzcGVuZC93YWtldXAuDQoNCkkgdGhpbmsgdGhlIHBzMiBtb3VzZSBoYXMg
dG8gYmUgZGlzYWJsZWQgb24gc3VzcGVuZCBpbiBvcmRlciB0byBiZSBhYmxlIHRvIGdldCB0aGUN
CmtleWJvYXJkIGludGVycnVwdHMgcmVxdWlyZWQgdG8gd2FrZSB1cC4gT3RoZXJ3aXNlIGlmIHRo
ZSBtb3VzZSBpcyBzdXBwb3NlZCB0byBiZQ0KcmVhbGx5IGVuYWJsZWQgKGJ1dCBtb3VzZSBpcnEn
cyB3aWxsIGJlIGlnbm9yZWQpLCB0aGVuIGhvdyBkb2VzIHRoZSBQUy8yIGNvbnRyb2xsZXINCmRl
Y2lkZSB3aGV0aGVyIHRvIHJldHVybiBtb3VzZSBvciBrZXlib2FyZCBkYXRhIHdoZW4gdGhleSBk
byB0aGUgZGF0YSBwb3J0IHJlYWQ/DQoNCnoNCg==
