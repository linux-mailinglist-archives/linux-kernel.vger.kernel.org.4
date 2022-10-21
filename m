Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAA9606EA9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 06:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJUELb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 00:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiJUEL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 00:11:29 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAC81669A6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 21:11:27 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-248-s68IOj53PiiIuHOXq5VdrA-1; Fri, 21 Oct 2022 05:11:24 +0100
X-MC-Unique: s68IOj53PiiIuHOXq5VdrA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 21 Oct
 2022 05:11:23 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Fri, 21 Oct 2022 05:11:23 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Tony Luck' <tony.luck@intel.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
CC:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Matthew Wilcox" <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH v2] mm, hwpoison: Try to recover from copy-on write faults
Thread-Topic: [PATCH v2] mm, hwpoison: Try to recover from copy-on write
 faults
Thread-Index: AQHY5QLKTeMIBBrbhUi0l3qIy2avP64YPAZA
Date:   Fri, 21 Oct 2022 04:11:23 +0000
Message-ID: <1643d19d795b4a8084228eab66a7db9f@AcuMS.aculab.com>
References: <SJ1PR11MB60838C1F65CA293188BB442DFC289@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20221019170835.155381-1-tony.luck@intel.com>
 <893b681b-726e-94e3-441e-4d68c767778a@linux.alibaba.com>
 <Y1GqGbBNk6fX/OnD@agluck-desk3.sc.intel.com>
 <359bae4e-6ce3-cc7e-33d0-252064157bc6@linux.alibaba.com>
 <Y1IbOAvpGzA8bst1@agluck-desk3.sc.intel.com>
In-Reply-To: <Y1IbOAvpGzA8bst1@agluck-desk3.sc.intel.com>
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

RnJvbTogVG9ueSBMdWNrDQo+IFNlbnQ6IDIxIE9jdG9iZXIgMjAyMiAwNTowOA0KLi4uLg0KPiBX
aGVuIHdlIGRvIHJldHVybiB0byB1c2VyIG1vZGUgdGhlIHRhc2sgaXMgZ29pbmcgdG8gYmUgYnVz
eSBzZXJ2aWNpbmcNCj4gYSBTSUdCVVMgLi4uIHNvIHNob3VsZG4ndCB0cnkgdG8gdG91Y2ggdGhl
IHBvaXNvbiBwYWdlIGJlZm9yZSB0aGUNCj4gbWVtb3J5X2ZhaWx1cmUoKSBjYWxsZWQgYnkgdGhl
IHdvcmtlciB0aHJlYWQgY2xlYW5zIHRoaW5ncyB1cC4NCg0KV2hhdCBhYm91dCBhbiBSVCBwcm9j
ZXNzIG9uIGEgYnVzeSBzeXN0ZW0/DQpUaGUgd29ya2VyIHRocmVhZHMgYXJlIHByZXR0eSBsb3cg
cHJpb3JpdHkuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJy
YW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lz
dHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

