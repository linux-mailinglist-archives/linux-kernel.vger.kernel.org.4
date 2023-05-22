Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9573E70B9F5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 12:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjEVKVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 06:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjEVKVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 06:21:02 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B837410D;
        Mon, 22 May 2023 03:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1684750844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q7WZxOID/4rgrLmEoCSfcST4j5NQ+P/suC/H/PrATvI=;
        b=MyzB1QqX19N01tqJsBgtC5qQhF8dVFpTW8X9KfJZ0JknwRZTcFuOSTzGULwTtYZYz+XzlP
        KiMjGecK01xvPhKYC8ec30s5daE1xgycgf8AQ1tZzS+UCWt8ZgEbfKtQ9zlv+TBu0sclMf
        no0L8WLLfOrloiYG/PcE/UgB9ZnOP24=
Message-ID: <9812499a8e017b8e01327069c8063e5f213bb1c8.camel@crapouillou.net>
Subject: Re: [PATCH v2 1/2] iio/adc: ingenic: Fix channel offsets in buffer
From:   Paul Cercueil <paul@crapouillou.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Artur Rojek <contact@artur-rojek.eu>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        linux-mips@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Date:   Mon, 22 May 2023 12:20:42 +0200
In-Reply-To: <CAHp75VeLRHwcKQALwnBb-gqVeyxxH=_F40TserRXqo_kbaZzoQ@mail.gmail.com>
References: <20230521225901.388455-1-contact@artur-rojek.eu>
         <20230521225901.388455-2-contact@artur-rojek.eu>
         <CAHp75VeLRHwcKQALwnBb-gqVeyxxH=_F40TserRXqo_kbaZzoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksCgpMZSBsdW5kaSAyMiBtYWkgMjAyMyDDoCAxMzoxNSArMDMwMCwgQW5keSBTaGV2Y2hlbmtv
IGEgw6ljcml0wqA6Cj4gT24gTW9uLCBNYXkgMjIsIDIwMjMgYXQgMTo1OeKAr0FNIEFydHVyIFJv
amVrIDxjb250YWN0QGFydHVyLXJvamVrLmV1Pgo+IHdyb3RlOgo+ID4gCj4gPiBDb25zdW1lcnMg
ZXhwZWN0IHRoZSBidWZmZXIgdG8gb25seSBjb250YWluIGVuYWJsZWQgY2hhbm5lbHMuIFdoaWxl
Cj4gPiBwcmVwYXJpbmcgdGhlIGJ1ZmZlciwgdGhlIGRyaXZlciBtYWtlcyB0d28gbWlzdGFrZXM6
Cj4gPiAxKSBJdCBpbnNlcnRzIGVtcHR5IGRhdGEgZm9yIGRpc2FibGVkIGNoYW5uZWxzLgo+ID4g
MikgRWFjaCBBREMgcmVhZG91dCBjb250YWlucyBzYW1wbGVzIGZvciB0d28gMTYtYml0IGNoYW5u
ZWxzLiBJZgo+ID4gZWl0aGVyCj4gPiDCoMKgIG9mIHRoZW0gaXMgYWN0aXZlLCB0aGUgd2hvbGUg
MzItYml0IHNhbXBsZSBpcyBwdXNoZWQgaW50byB0aGUKPiA+IGJ1ZmZlcgo+ID4gwqDCoCBhcy1p
cy4KPiA+IAo+ID4gQm90aCBvZiB0aG9zZSBpc3N1ZXMgY2F1c2UgdGhlIGFjdGl2ZSBjaGFubmVs
cyB0byBhcHBlYXIgYXQgdGhlCj4gPiB3cm9uZwo+ID4gb2Zmc2V0cyBpbiB0aGUgYnVmZmVyLiBG
aXggdGhlIGFib3ZlIGJ5IGRlbXV4aW5nIHNhbXBsZXMgZm9yIGFjdGl2ZQo+ID4gY2hhbm5lbHMg
b25seS4KPiA+IAo+ID4gVGhpcyBoYXMgcmVtYWluZWQgdW5ub3RpY2VkLCBhcyBhbGwgdGhlIGNv
bnN1bWVycyBzbyBmYXIgd2VyZSBvbmx5Cj4gPiB1c2luZwo+ID4gY2hhbm5lbHMgMCBhbmQgMSwg
bGVhdmluZyB0aGVtIHVuYWZmZWN0ZWQgYnkgY2hhbmdlcyBpbnRyb2R1Y2VkIGluCj4gPiB0aGlz
Cj4gPiBjb21taXQuCj4gCj4gLi4uCj4gCj4gPiArwqDCoMKgwqDCoMKgIHUxNiB0ZGF0WzZdOwo+
ID4gK8KgwqDCoMKgwqDCoCB1MzIgdmFsOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoCBtZW1zZXQo
dGRhdCwgMCwgQVJSQVlfU0laRSh0ZGF0KSk7Cj4gCj4gWWVhaCwgYXMgTEtQIHRlbGxzIHVzIHRo
aXMgc2hvdWxkIGJlIHNpemVvZigpIGluc3RlYWQgb2YKPiBBUlJBWV9TSVpFKCkuCgpQcm9iYWJs
eSAidTE2IHRkYXRbNl0gPSB7IDAgfTsiIHdvdWxkIHdvcmsgdG9vPwoKQ2hlZXJzLAotUGF1bAoK
PiAKPiA+ICvCoMKgwqDCoMKgwqAgZm9yIChpID0gMDsgbWFzayAmJiBpIDwgQVJSQVlfU0laRSh0
ZGF0KTsgbWFzayA+Pj0gMikgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYg
KG1hc2sgJiAweDMpIHsKPiAKPiAoZm9yIHRoZSBjb25zaXN0ZW5jeSBpdCBoYXMgdG8gYmUgR0VO
TUFTSygpLCBidXQgc2VlIGJlbG93KQo+IAo+IEZpcnN0IG9mIGFsbCwgc3RyaWN0bHkgc3BlYWtp
bmcgd2Ugc2hvdWxkIHVzZSB0aGUgZnVsbCBtYXNrIHdpdGhvdXQKPiBsaW1pdGluZyBpdCB0byB0
aGUgMCBlbGVtZW50IGluIHRoZSBhcnJheSAoSSdtIHRhbGtpbmcgYWJvdXQKPiBhY3RpdmVfc2Nh
bl9tYXNrKS4KPiAKPiBUaGF0IHNhaWQsIHdlIG1heSBhY3R1YWxseSB1c2UgYml0IG9wZXJhdGlv
bnMgaGVyZSBpbiBhIGJldHRlciB3YXksCj4gaS5lLgo+IAo+IMKgIHVuc2lnbmVkIGxvbmcgbWFz
ayA9IGFjdGl2ZV9zY2FuX21hc2tbMF0gJiAoYWN0aXZlX3NjYW5fbWFza1swXSAtCj4gMSk7Cj4g
Cj4gwqAgaiA9IDA7Cj4gwqAgZm9yX2VhY2hfc2V0X2JpdChpLCBhY3RpdmVfc2Nhbl9tYXNrLCAu
Li4pIHsKPiDCoMKgwqAgdmFsID0gcmVhZGwoLi4uKTsKPiDCoMKgwqAgLyogVHdvIGNoYW5uZWxz
IHBlciBzYW1wbGUuIERlbXV4IGFjdGl2ZS4gKi8KPiDCoMKgwqAgdGRhdFtqKytdID0gdmFsID4+
ICgxNiAqIChpICUgMikpOwo+IMKgIH0KPiAKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB2YWwgPSByZWFkbChhZGMtPmJhc2UgKyBKWl9BRENfUkVHX0FE
VENIKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAv
KiBUd28gY2hhbm5lbHMgcGVyIHNhbXBsZS4gRGVtdXggYWN0aXZlLgo+ID4gKi8KPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAobWFzayAmIEJJVCgw
KSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgdGRhdFtpKytdID0gdmFsICYgMHhmZmZmOwo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChtYXNrICYgQklUKDEpKQo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB0ZGF0W2krK10gPSB2YWwgPj4gMTY7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB9Cj4gPiDCoMKgwqDCoMKgwqDCoCB9Cj4gCgo=

