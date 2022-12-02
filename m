Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A91A6403F2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 11:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbiLBKCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 05:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbiLBKB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:01:57 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7110CB224
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 02:01:55 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-259-gU3wSqt4NfGibvtvFXD_wg-1; Fri, 02 Dec 2022 10:01:52 +0000
X-MC-Unique: gU3wSqt4NfGibvtvFXD_wg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 2 Dec
 2022 10:01:50 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Fri, 2 Dec 2022 10:01:50 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Anders Roxell' <anders.roxell@linaro.org>,
        Kees Cook <keescook@chromium.org>
CC:     =?utf-8?B?SG9yaWEgR2VhbnTEgw==?= <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "kernel test robot" <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] crypto/caam: Avoid GCC constprop bug warning
Thread-Topic: [PATCH] crypto/caam: Avoid GCC constprop bug warning
Thread-Index: AQHZBekth9IOKPP1MEG2CcwZTmA4Xa5aWPsA
Date:   Fri, 2 Dec 2022 10:01:50 +0000
Message-ID: <4f7ffdd948a84013a0e84876b3e3944b@AcuMS.aculab.com>
References: <20221028210527.never.934-kees@kernel.org>
 <20221202005814.GD69385@mutt>
In-Reply-To: <20221202005814.GD69385@mutt>
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

RnJvbTogQW5kZXJzIFJveGVsbA0KPiBTZW50OiAwMiBEZWNlbWJlciAyMDIyIDAwOjU4DQo+IA0K
PiBPbiAyMDIyLTEwLTI4IDE0OjA1LCBLZWVzIENvb2sgd3JvdGU6DQo+ID4gR0NDIDEyIGFwcGVh
cnMgdG8gcGVyZm9ybSBjb25zdGFudCBwcm9wYWdhdGlvbiBpbmNvbXBsZXRlbHkoPykgYW5kIGNh
bg0KPiA+IG5vIGxvbmdlciBub3RpY2UgdGhhdCAibGVuIiBpcyBhbHdheXMgMCB3aGVuICJkYXRh
IiBpcyBOVUxMLiBFeHBhbmQgdGhlDQo+ID4gY2hlY2sgdG8gYXZvaWQgd2FybmluZ3MgYWJvdXQg
bWVtY3B5KCkgaGF2aW5nIGEgTlVMTCBhcmd1bWVudDoNCj4gPg0KPiA+ICAgIC4uLg0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgZnJvbSBkcml2ZXJzL2NyeXB0by9jYWFtL2tleV9nZW4uYzo4Og0K
PiA+ICAgIGRyaXZlcnMvY3J5cHRvL2NhYW0vZGVzY19jb25zdHIuaDogSW4gZnVuY3Rpb24gJ2Fw
cGVuZF9kYXRhLmNvbnN0cHJvcCc6DQo+ID4gICAgaW5jbHVkZS9saW51eC9mb3J0aWZ5LXN0cmlu
Zy5oOjQ4OjMzOiB3YXJuaW5nOiBhcmd1bWVudCAyIG51bGwgd2hlcmUgbm9uLW51bGwgZXhwZWN0
ZWQgWy0NCj4gV25vbm51bGxdDQo+ID4gICAgICAgNDggfCAjZGVmaW5lIF9fdW5kZXJseWluZ19t
ZW1jcHkgICAgIF9fYnVpbHRpbl9tZW1jcHkNCj4gPiAgICAgICAgICB8ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXg0KPiA+ICAgIGluY2x1ZGUvbGludXgvZm9ydGlmeS1zdHJpbmcu
aDo0Mzg6OTogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvICdfX3VuZGVybHlpbmdfbWVtY3B5
Jw0KPiA+ICAgICAgNDM4IHwgICAgICAgICBfX3VuZGVybHlpbmdfIyNvcChwLCBxLCBfX2ZvcnRp
Znlfc2l6ZSk7ICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiA+ICAgICAgICAgIHwgICAgICAg
ICBefn5+fn5+fn5+fn5+DQouLi4NCg0KSXMgdGhpcyByZWFsbHkgYSBidWcgaW4gdGhlIGZvcnRp
Znktc3RyaW5nIHdyYXBwZXJzPw0KSUlSQyB0aGUgY2FsbCBpcyBtZW1jcHkoTlVMTCwgcHRyLCAw
KSAob3IgbWF5YmUgbWVtY3B5KHB0ciwgTlVMTCwgMCkuDQpJbiBlaXRoZXIgY2FzZSBjYWxsIGNh
biBiZSByZW1vdmVkIGF0IGNvbXBpbGUgdGltZS4NCg0KSSdkIGJldCB0aGF0IHRoZSBjb25zdGFu
dCBwcm9wYWdhdGlvbiBvZiAnbGVuJyBmYWlscyBiZWNhdXNlDQpvZiBhbGwgdGhlIGludGVybWVk
aWF0ZSB2YXJpYWJsZXMgdGhhdCBnZXQgdXNlZCBpbiBvcmRlciB0bw0KYXZvaWQgbXVsdGlwbGUg
ZXZhbHVhdGlvbi4NCg0KVGhlIHNvbWUgJ3RyaWNrcycgdGhhdCBhcmUgdXNlZCBpbiBtaW4oKSAo
c2VlIG1pbm1heC5oKSB0bw0KZ2VuZXJhdGUgYSBjb25zdGFudCBvdXRwdXQgZm9yIGNvbnN0YW50
IGlucHV0IGNvdWxkIGJlDQp1c2UgdG8gZGV0ZWN0IGEgY29tcGlsZS10aW1lIHplcm8gbGVuZ3Ro
Lg0KDQpTb21ldGhpbmcgbGlrZToNCiNkZWZpbmUgbWVtY3B5KGRzdCwgc3JjLCBsZW4pIFwNCgko
X19pc19jb25zdHplcm8obGVuKSA/IChkc3QpIDogbWVtY3B5X2NoZWNrKGRzdCwgc3JjLCBsZW4p
KQ0KDQpXaXRoOg0KI2RlZmluZSBfX2lzX2NvbnN0emVybyh4KSBzaXplb2YoKigxID8gKHZvaWQg
KikoeCkgOiAoaW50ICopMCkgIT0gMSkNCldoaWNoIGNvdWxkIGdvIGludG8gY29uc3QuaCBhbmQg
dXNlZCBpbiB0aGUgZGVmaW5pdGlvbiBvZiBfX2lzX2NvbnN0ZXhwcigpLg0KDQoJRGF2aWQNCg0K
LQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0s
IE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdh
bGVzKQ0K

