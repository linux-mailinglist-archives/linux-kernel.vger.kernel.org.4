Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5AF72F698
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238564AbjFNHm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234847AbjFNHmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:42:54 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936611BC9;
        Wed, 14 Jun 2023 00:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1686728571;
  x=1718264571;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QzV7gT+IteIA3kl7Sr2qJ540vXrQVMMiMl/VHRBpSk8=;
  b=oUiaNus4ZLVIprHyIdHSVQAOtleU4njsl5g/vV/oTo1BSvd035Frf/j+
   xRt4mMMsV0eI7EWzD7lQ80ptuBVujOzU02cupglQVIbB8wdn5L50jMcL2
   BZmtATjMCVmjWZxe/+6n6cqir8wNPD+KMkazWqdBDI0DRXJ/cxOvfHANH
   YrWxi6mg3N7+IeIMMM3oVIGWjfBL6s5oF3Dm50uDvomb3abEjf4N6tqhQ
   eXpj2jbf4XhVFBZ3h/RZ7gQWLig6WT+vGFwllJnprWWW/Ra7zcgs6DKd4
   EmtqaGWemb5qXyIDUK0vROvqz9i9D2OU53IIU2hUZyTN3sg28kMLHfFv5
   Q==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfFKwId7q2oVRHCV61qaxj9McZ53yc83utJNQn1AR/Eaq8PuIMmDvx1DX6RP7UQnKhAtYqTndgb5HcU/LnrMxvRtT1+2kqML6GRwJC+RQ5LWcwzYI6r62GG3tFz+3yWkbVu94O4O817ZpDD5O5aafW3wnwgd9Iwpqf3zApJqPZOzeAWcb6DGmWirhD58Wpx5B+l2Yq2b3J3KzCOP3BNtYsxc408EjQxJJnCNnGNCMv3G9SH+sfLCdzkmWrPopqhiL8zb6Ad7+wH1LjFj+XikK57VQ4fp/hjcVHGAWqX2Zz5qcdLzlbdAbsvEGG1ax6ksiRorJ0uGZSl2mQ3+24Iq/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzV7gT+IteIA3kl7Sr2qJ540vXrQVMMiMl/VHRBpSk8=;
 b=eIZz6XSzJ7x79sy5Y7cT+uTtanyYi9ydoSH2f0MPA3fKVoR3Vh7TXY3+MVyp4aRjf+cqhcz+dwxG2V625WNrrM5XxjadpmnOFARvvTDlM5V6I6O7Ss6arCBsGV8E/pInsQXWqSJedOrREJ717zdMhokEzx197XPn9L2W/Tm1rzijB+MnlM5CwxnpecyolN/2XKKxSy1jqwRECxZfu1oHKOyDGSfAgEqea5gEJjekPKxxlUQIy/d0meX2DMpMN1kOuLalr2tmHg4qAGtatmOW0hFdwUKHL/yOkWiJlv7aQ2xV9A+nekwZEL7cC7XaGbBC/myxeH6/WAFhd2wS20xOfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzV7gT+IteIA3kl7Sr2qJ540vXrQVMMiMl/VHRBpSk8=;
 b=SyTnG//I6C83QwTRkPz7djd2AjjanBcqn8f7crlpCesFtVNWtbZGGqXJUU7HGCOBdYYaEwhBIYvtuSDaZnukaREd4R+pzG0RKTaZq0631b1JRCaqU95YNsg/QBsSdLdQIG9Bu/TWAS1/N4lK80scm4Yg2xZ3EB7+/oDaAuRnM7I=
From:   Vincent Whitchurch <Vincent.Whitchurch@axis.com>
To:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        Vincent Whitchurch <Vincent.Whitchurch@axis.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH v2] watchdog/mm: Allow dumping memory info in pretimeout
Thread-Topic: [PATCH v2] watchdog/mm: Allow dumping memory info in pretimeout
Thread-Index: AQHZnP9HJvDgzR7/GkiqGkzDh9u8CK+HQU4AgAKsUIA=
Date:   Wed, 14 Jun 2023 07:42:46 +0000
Message-ID: <041dcfd3d4e45c387fa1f6f49f53ccb59967b104.camel@axis.com>
References: <20230608-pretimeout-oom-v2-1-581f0ad0e4f3@axis.com>
         <41ecdf8d-59be-ded0-1ace-0a7cadabbcc3@roeck-us.net>
In-Reply-To: <41ecdf8d-59be-ded0-1ace-0a7cadabbcc3@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1+deb11u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10288:EE_|AS8PR02MB7253:EE_
x-ms-office365-filtering-correlation-id: 247aae54-5d20-4a6c-e08d-08db6caaf1d8
x-ld-processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8ciacMS98YTDwQ6unmiY5z3it51yvLLI+0kx4yfRCRbt9LAtpmfmy8AOwzn26OZU440sb6VrPV/Dgn5qdbt5X4OYVf3H71VNL4+Ve0RtTmZ8hgbPOCnnwQENuBkOFixULxYwpvtGl410+N69iHINk7nq9B44/8BW39eUeeXV55V9XlGJGrHZHk5nfhfa3zdkf1o0P4xxZh7hzxaENM+74/CGT7mFYl4H6sMB0ozik693w6gW2qqrvfvMb+hesqZ0gT7QUeGpse90w1ko1WccYMAtPPSRgLipswcGv0f4HllfsKrWzZCoDfJQIqVEcYFKVq11yOSOwqWjGjQbJAHHVzKoLMfEb8Jea1h6TI1315ovb0P4Rw6P8lV0s0toMJ78g8QyDDeD1zQZcmfbtktYhNwZirbJOWQAU5negTQnyUw/GBME1xo5xr94V+5nXCOYjwtezxsDlgGQ007Q35nqu0y7zHFKu5wdjHoM0EZfCSI+HK+jfEF4Hx4ogIQPieytvav1rNClZv5qULU+c7IoUKeIvUMACJ0f8AV6yv/loHjKeKBvt05+U1hXrWUlqsqbastDNbL/BSDeP8WAibfAif5YvnE60lLCvt0jg+JS8cjv96rjCeZFlzaOXQBeVDL2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10288.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(8936002)(6486002)(26005)(8676002)(6512007)(41300700001)(38100700002)(478600001)(36756003)(86362001)(71200400001)(66946007)(66476007)(4326008)(91956017)(76116006)(64756008)(66446008)(66556008)(316002)(122000001)(38070700005)(110136005)(54906003)(53546011)(6506007)(5660300002)(83380400001)(186003)(2616005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0UvUDJYcHBYem5xdTNXWU04bjdYV00xdHQ1Q1FsQVdxdGQ0b0dzcWVsb2hE?=
 =?utf-8?B?azVQNzFqeGVTcSt3dE5oeThrL0ZXRStIay9WbHRYbVI4dW9NR3YwbW1YU0wr?=
 =?utf-8?B?S2dYZUlFZ09sS2RvOUhIbEN4alZ5cEQwSVpVUE1ZYjJ0ZG9keG9zeHN4MzNy?=
 =?utf-8?B?Rk5hczdwOEVuNUplT0dSekhrVjdGVjJSbEhFN1hOYS9TSTNDV1hUUm95M2hT?=
 =?utf-8?B?ZC9BQjhQSFVTNUlzcFNKYS9NbUlnMXlNRTY2a1puZ1pHa1BPY25MZlFZT1BI?=
 =?utf-8?B?UnpzdVY0R2d4ZzRwUFpKcCtMZ3ZnSEZsQytUeGFRZFR3REFPR3lPdkhoa2E2?=
 =?utf-8?B?Rm9BQ3dOUHd0WUwxSVJEUXk5M3VwY2VaQWxTMFBLNEJqTUY4eDExRFB0bnZo?=
 =?utf-8?B?bXJ2SzBqVG1DaGZ3ZE45em84ekl5N04vWFhVQUNiMzhCUVdSOTJvRVZOK3Va?=
 =?utf-8?B?ZW8xaExXaC9BOHRJMWk4ZGNBV2pHblFHRDVpRlR5MmFHMjFzRHpUTHVVZDRZ?=
 =?utf-8?B?T29EVWtQUlJEdThqeElsN3R4ZXNmbWhpaDYwWE41QzFCWWNFOXZBdE9jdit0?=
 =?utf-8?B?UE5qdCtWcEY4djZhRkZxSEJ4NXY3bmhBSTI2YWV5UElveUFyZ0F1SkxPMUln?=
 =?utf-8?B?b3N6REkrdXQvUjQwQStFUDU4MWx6OG9GNmxIVWJxbHhFRkxWRzJoaFBvQWIv?=
 =?utf-8?B?Uk12a0E4T09ScE9BR2k4OWdPV3RHZFR1UFhnd2hYaHlwbkI0NFBvWGFrMC85?=
 =?utf-8?B?SWNscWs0T3cyNmJYK1Fma1ovdmhRdUw2cExFTjgxclJRVEJnMjhBaUMyWGs0?=
 =?utf-8?B?eVlkbDdTSWVZa1Nhb1paWFUveFVUMzlROHJ5QUdTcVFEeGtLd0ZkYmplZUhj?=
 =?utf-8?B?ZHVrcDhMd1VsekVYMlUxYTNiTlhndjV5N0phQld5UTNEN3Y5YlpCd2F2M2Rh?=
 =?utf-8?B?TjdXaUFzejRpaVZHYTNXTC9CMFVsNVlqcnIxWlpyV3VPZS9KME5NeXhYQjht?=
 =?utf-8?B?RHh5VkNSVG1ZL1VmTXRzUnJnYkxsS1I3NWd2dU5MN001ZDNoRmJDZjhOZ1pH?=
 =?utf-8?B?VWJmcUszTXRnTlFSQVdhTHRhZFF4cm1MdGRYaGRlZ0dqWURqeVhwb1Z2bXNB?=
 =?utf-8?B?WnB1MDd1RC9pL285ZlU1SERkVytzSUd6Rm44YXdYK0hOMHptY1lXa2V5eVBB?=
 =?utf-8?B?M1hzVlBxUEVOZll5WWRMcHp3SmR1YTlZV1R0VU42Y0lNUStlKy9LZklCSmxY?=
 =?utf-8?B?RXNOSGVlM1VXOStBUGd3elI5WWhQcTlyV05jb1VJbjVaZ1lGdHlQelo3Ymg4?=
 =?utf-8?B?SUNIbUNKcGgyQ2JUMlBTc1E5My85QmE2MGJvYlUvU1o4a2JUcUVSSjVoQld5?=
 =?utf-8?B?d2J0ZlNJWGQwVmkzSFpIWjVkWHlSdjduWGcrSHdpWVdLZUlwcm9IVms3OC9M?=
 =?utf-8?B?UERFdWQ5UytRclQ5MVNYQ08zdHJZdU1RbWxUSkQ2Z0hwU1hTcmFKbTd4cTMr?=
 =?utf-8?B?VjVMSjZHbXd0Rk5KMUMrTUpuQnNvT1Y3TGdaR3drTDlMbEdnRlRPazZaNVIy?=
 =?utf-8?B?amZLTmMvSVBUTTVBTEhJRk5Rdk9vRWhWaGN6RXpjbllOb2hEcG00TVFpTHdi?=
 =?utf-8?B?VmpCZjkwS05BNDU3SllYQzBQanV4WUxLOUl0ZE1kWkE0RkZmYUxBaDYxQTNt?=
 =?utf-8?B?eTg0NnVSaTg2M25BMElVQ1ZpTHBJQ0pad1JuMUN2elFESm02S0NhcW41NjlE?=
 =?utf-8?B?LzZJVVQzMHBjeGV5NUtPYUp1d0lCTFVsZjRZdlY3VFJNTW9tRmx4dy9RUVpr?=
 =?utf-8?B?Yk5ucVBrUDJlSDM2L29PaVhIWWdEM3UxK3VSTkJhaE1PZmdUMWkyRTNXeDlW?=
 =?utf-8?B?d1VOdEpoYkJiWkpDQWFsUTU3b2p6RHVnYzFsakd6QUhZS3ZWeDJyaGtuTW9u?=
 =?utf-8?B?U3ptRm5YR0t6cFpweWo5d0lza1dFdGh1ZWNhU3I3QWlIandKM3pCd1QzNXRW?=
 =?utf-8?B?UVozOTRuYkx5UU1Ed25nU0xMckhVSEcvUTVNQmRILzZ1STVUSEFIa3RtZVNp?=
 =?utf-8?B?RWNtblRxeVVVbEdPb1JNTjVsNUUwelZQa0NRaS9SVXp3T1VhZ3JZd1VqTFgr?=
 =?utf-8?Q?8XYk66xiTZka6dpkcDAhdtZhe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <42BBBCB4B5303E47A3CC744BF18BA5A9@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10288.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 247aae54-5d20-4a6c-e08d-08db6caaf1d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 07:42:46.0254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6EW4qKsmm/trjwVirO1zLg66nO01xT9eoYTMUVml9gbOAgGJsMOo4NpGAfu8sj4U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB7253
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA2LTEyIGF0IDA3OjUzIC0wNzAwLCBHdWVudGVyIFJvZWNrIHdyb3RlOg0K
PiBPbiA2LzEyLzIzIDAwOjI2LCBWaW5jZW50IFdoaXRjaHVyY2ggd3JvdGU6DQo+ID4gT24gbXkg
KGVtYmVkZGVkKSBzeXN0ZW1zLCB0aGUgbW9zdCBjb21tb24gY2F1c2Ugb2YgaGl0dGluZyB0aGUg
d2F0Y2hkb2cNCj4gPiAocHJlKXRpbWVvdXQgaXMgZHVlIHRvIHRocmFzaGluZy4gIERpYWdub3Np
bmcgdGhlc2UgcHJvYmxlbXMgaXMgaGFyZA0KPiA+IHdpdGhvdXQga25vd2luZyB0aGUgbWVtb3J5
IHN0YXRlIGF0IHRoZSBwb2ludCBvZiB0aGUgd2F0Y2hkb2cgaGl0LiAgSW4NCj4gPiBvcmRlciB0
byBtYWtlIHRoaXMgaW5mb3JtYXRpb24gYXZhaWxhYmxlLCBhZGQgYSBtb2R1bGUgcGFyYW1ldGVy
IHRvIHRoZQ0KPiA+IHdhdGNoZG9nIHByZXRpbWVvdXQgcGFuaWMgZ292ZXJub3IgdG8gYXNrIGl0
IHRvIGR1bXAgbWVtb3J5IGluZm8gYW5kIHRoZQ0KPiA+IE9PTSB0YXNrIGxpc3QgKHVzaW5nIGEg
bmV3IGhlbHBlciBpbiB0aGUgT09NIGNvZGUpIGJlZm9yZSB0cmlnZ2VyaW5nIHRoZQ0KPiA+IHBh
bmljLg0KPiANCj4gUGVyc29uYWxseSBJIGRvbid0IHRoaW5rIHRoaXMgaXMgdGhlIHJpZ2h0IHdh
eSBvZiBhcHByb2FjaGluZyB0aGlzIHByb2JsZW0uDQo+IEZpcnN0LCB0aGUgdXNlcnNwYWNlIHRh
c2sgY29udHJvbGxpbmcgdGhlIHdhdGNoZG9nIHNob3VsZCBydW4gYXMgcmVhbHRpbWUNCj4gdGFz
aywgZm9yY2VkIHRvIGJlIGluIG1lbW9yeSwgYW5kIG5vdCBiZSBhZmZlY3RlZCBieSB0aHJhc2hp
bmcuDQoNClRoYXQgbWF5IG5vdCBiZSBhcHByb3ByaWF0ZSBpbiBhbGwgY2FzZXMgc2luY2UgeW91
IG1heSB3YW50IHRoZSB3YXRjaGRvZw0KdG8gaGl0IHdoZW4gdGhlIHN5c3RlbSBhcyBhIHdob2xl
IHJlYWxseSBpcyB1bnVzYWJsZS4NCg0KPiBTZWNvbmQsIHRoZSBwcm9ibGVtIHNob3VsZCBiZSBv
YnNlcnZhYmxlIHdlbGwgYmVmb3JlIHRoZSB3YXRjaGRvZyBmaXJlcy4NCg0KWWVzLCB0aGVyZSBh
cmUgd2F5cyB0byB0cnkgdG8gZGV0ZWN0IGl0IGVhcmxpZXIgKGUuZy4gUFNJKSBhbmQgYXR0ZW1w
dA0KcmVjb3ZlcnksIGV2ZW4gaWYgdGhlIGtlcm5lbCdzIE9PTSBraWxsZXIgaXRzZWxmIGlzIHZl
cnkgc2xvdyB0byByZWFjdC4NCg0KQnV0IGlmIHRob3NlIGF0dGVtcHRzIGZhaWwgZm9yIHdoYXRl
dmVyIHJlYXNvbiBhbmQgd2UgYWN0dWFsbHkgZG8gZW5kIHVwDQpoaXR0aW5nIHRoZSB3YXRjaGRv
Zywgc29tZXRoaW5nIGxpa2UgdGhpcyBwYXRjaCBwcm92aWRlcyBpbmZvcm1hdGlvbg0Kd2hpY2gg
aXMgaW52YWx1YWJsZSBmb3IgZGlhZ25vc2luZyB0aGUgcHJvYmxlbS4NCg0KPiBMYXN0IGJ1dCBu
b3QgbGVhc3QsIEkgZG9uJ3QgdGhpbmsgaXQgaXMgYXBwcm9wcmlhdGUgdG8gaW50ZXJ0d2luZQ0K
PiB3YXRjaGRvZyBjb2RlIHdpdGggb29tIGhhbmRsaW5nIGNvZGUgYXMgc3VnZ2VzdGVkIGhlcmUu
DQoNClRoZSBzaG93X21lbSgpIGZ1bmN0aW9uIGlzIGluIGxpYi8gc28gdGhhdCdzIG91dHNpZGUg
b2YgdGhlIE9PTQ0KaGFuZGxpbmcuICBUaGUgb29tX2R1bXBfdGFza3MoKSBmdW5jdGlvbiBjb3Vs
ZCBwZXJoYXBzIGJlIHJlZmFjdG9yZWQgYW5kDQptb3ZlZCB0byBhIG5ldXRyYWwgbG9jYXRpb24g
c28gdGhlbiB3ZSB3b3VsZCBhdm9pZCB0aGUgaW50ZXJ0d2luaW5nLg0KDQo=
