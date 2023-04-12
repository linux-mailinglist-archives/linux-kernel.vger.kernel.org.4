Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE9D6DF16C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 12:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjDLKBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 06:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjDLKBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:01:25 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F193A6E90
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 03:01:23 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-185-n4ojGTg5OZe_xGJ9iNrvmQ-1; Wed, 12 Apr 2023 11:01:20 +0100
X-MC-Unique: n4ojGTg5OZe_xGJ9iNrvmQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 12 Apr
 2023 11:01:18 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 12 Apr 2023 11:01:18 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Chen Zhongjin' <chenzhongjin@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "akpm@linux-foudation.org" <akpm@linux-foudation.org>,
        "ben-linux@fluff.org" <ben-linux@fluff.org>,
        "wuchi.zero@gmail.com" <wuchi.zero@gmail.com>
Subject: RE: [PATCH 1/2] x86: profiling: remove lock functions hack for
 !FRAME_POINTER
Thread-Topic: [PATCH 1/2] x86: profiling: remove lock functions hack for
 !FRAME_POINTER
Thread-Index: AQHZbQyvTGGrlueVOUe2AvMO59CTTK8ncLfw
Date:   Wed, 12 Apr 2023 10:01:18 +0000
Message-ID: <4c601a93e55341fc8cff766af43cb5e6@AcuMS.aculab.com>
References: <20230410022226.181812-1-chenzhongjin@huawei.com>
 <20230410022226.181812-2-chenzhongjin@huawei.com>
 <d416428f-c846-b6b9-74da-f3571d92d38a@intel.com>
 <1ceb1769-f01b-c417-e912-4ee1149dd0cb@huawei.com>
In-Reply-To: <1ceb1769-f01b-c417-e912-4ee1149dd0cb@huawei.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2hlbiBaaG9uZ2ppbg0KPiBTZW50OiAxMiBBcHJpbCAyMDIzIDA4OjAyDQouLi4NCj4g
PiA0LiAhQ09ORklHX0ZSQU1FX1BPSU5URVIgaXMgcHJvYmFibHkgZXZlbiBtb3JlIHJhcmUgdG9k
YXkgdGhhbiBpdCB3YXMgaW4NCj4gPiAgICAgMjAwNg0KPg0KPiBOby4gIUNPTkZJR19GUkFNRV9Q
T0lOVEVSIGlzIG1vcmUgY29tbW9uIHRvZGF5IGJlY2F1c2Ugb2YgVU5XSU5ERVJfT1JDLg0KPiBB
bmQgdGhhdCBpcyB3aHkgdGhlIGJ1ZyBpcyB0cmlnZ2VyZWQgbW9yZSBmcmVxdWVudGx5Lg0KDQpD
T05GSUdfRlJBTUVfUE9JTlRFUiBpcyBwcmV0dHkgbXVjaCByZXF1aXJlZCAob24geDg2LTY0KQ0K
Zm9yIHRoZSB1c2VyIGNvcHkgY2hlY2tzIHRoYXQgYXJlIGVuYWJsZWQgaW4gZGlzdHJvIGtlcm5l
bHMuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkg
Um9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlv
biBObzogMTM5NzM4NiAoV2FsZXMpDQo=

