Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CC768FAD9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 00:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjBHXEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 18:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBHXEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 18:04:30 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2516538EA8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 15:04:28 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-309-aUTVRWF3Mm-EQUq0RboarQ-1; Wed, 08 Feb 2023 23:04:25 +0000
X-MC-Unique: aUTVRWF3Mm-EQUq0RboarQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.45; Wed, 8 Feb
 2023 23:04:24 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.045; Wed, 8 Feb 2023 23:04:24 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Andrew.Cooper3@citrix.com'" <Andrew.Cooper3@citrix.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>
Subject: RE: [PATCH v3 3/4] x86/alternative: Rewrite optimize_nops() some
Thread-Topic: [PATCH v3 3/4] x86/alternative: Rewrite optimize_nops() some
Thread-Index: AQHZO/bkCLmxNXlmiUO26BXbwYgbs67FquVg
Date:   Wed, 8 Feb 2023 23:04:24 +0000
Message-ID: <c76df3cb3c8944e98baad3406a522bad@AcuMS.aculab.com>
References: <20230208171050.490809180@infradead.org>
 <20230208171431.373412974@infradead.org>
 <f0b54521-26cf-ed38-d805-3a8eef3b3103@citrix.com>
In-Reply-To: <f0b54521-26cf-ed38-d805-3a8eef3b3103@citrix.com>
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

RnJvbTogQW5kcmV3LkNvb3BlcjNAY2l0cml4LmNvbQ0KPiBTZW50OiAwOCBGZWJydWFyeSAyMDIz
IDE5OjUyDQouLi4NCj4gVW5jb25kaXRpb25hbCBqbXBzIGNvc3QgYnJhbmNoIHByZWRpY3Rpb24g
dGhlc2UgZGF5cywgYW5kIHdvbid0IGJlDQo+IHN1Y2Nlc3NmdWxseSBwcmVkaWN0ZWQgdW50aWwg
dGFrZW4uDQoNClRoYXQgaXMgc2FkIDotKA0KDQpEb24ndCB0aGV5IGFsc28gdXNlIHRoZSBCVEIg
Zm9yIHRoZSB0YXJnZXQgYWRkcmVzcz8NClNvIGV2ZW4gaWYgcHJlZGljdGVkIHRha2VuIHRoZSBj
cHUgY2FuIHNwZWN1bGF0ZSBmcm9tDQp0aGUgd3JvbmcgYWRkcmVzcz8/DQoNCglEYXZpZA0KDQot
DQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwg
TWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2Fs
ZXMpDQo=

