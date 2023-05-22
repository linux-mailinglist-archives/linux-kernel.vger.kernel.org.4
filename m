Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D646F70B9FF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 12:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjEVKXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 06:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjEVKXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 06:23:47 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7235FA0;
        Mon, 22 May 2023 03:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1684751024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xr0HEh2zxv4q5k9U0u4+sS1RQc9NVlTeV6OX1Pz/Tv4=;
        b=w1VeYLVxWfqJLTh75GEhKX+wYS/Pf1FQxIzC0UBL08HuNmDFAlv3lPicZ0OGlMQP8gpKo0
        g3pPhHd5Z+I1yTR7BLnqyUpWbR7PS/zrAB0qcB5ZwuQBzbxietMomd+uQuyIR/bahnRiOA
        M5cvoStiOSBOjMGSGzedApU7NZiNeis=
Message-ID: <2fc0874ce8a802aeb98e553b15e27fb4d4b75a1c.camel@crapouillou.net>
Subject: Re: [PATCH v2 1/2] iio/adc: ingenic: Fix channel offsets in buffer
From:   Paul Cercueil <paul@crapouillou.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Artur Rojek <contact@artur-rojek.eu>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        linux-mips@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Date:   Mon, 22 May 2023 12:23:43 +0200
In-Reply-To: <CAHp75VedgVOA4qTJFeVuabKXBaB=y4Ss0fLu7a7J9GGgWFPqQg@mail.gmail.com>
References: <20230521225901.388455-1-contact@artur-rojek.eu>
         <20230521225901.388455-2-contact@artur-rojek.eu>
         <CAHp75VeLRHwcKQALwnBb-gqVeyxxH=_F40TserRXqo_kbaZzoQ@mail.gmail.com>
         <CAHp75VedgVOA4qTJFeVuabKXBaB=y4Ss0fLu7a7J9GGgWFPqQg@mail.gmail.com>
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

SGkgQW5keSwKCkxlIGx1bmRpIDIyIG1haSAyMDIzIMOgIDEzOjE4ICswMzAwLCBBbmR5IFNoZXZj
aGVua28gYSDDqWNyaXTCoDoKPiBPbiBNb24sIE1heSAyMiwgMjAyMyBhdCAxOjE14oCvUE0gQW5k
eSBTaGV2Y2hlbmtvCj4gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+IHdyb3RlOgo+ID4gT24g
TW9uLCBNYXkgMjIsIDIwMjMgYXQgMTo1OeKAr0FNIEFydHVyIFJvamVrCj4gPiA8Y29udGFjdEBh
cnR1ci1yb2play5ldT4gd3JvdGU6Cj4gCj4gLi4uCj4gCj4gPiA+ICvCoMKgwqDCoMKgwqAgdTE2
IHRkYXRbNl07Cj4gPiA+ICvCoMKgwqDCoMKgwqAgdTMyIHZhbDsKPiA+ID4gKwo+ID4gPiArwqDC
oMKgwqDCoMKgIG1lbXNldCh0ZGF0LCAwLCBBUlJBWV9TSVpFKHRkYXQpKTsKPiA+IAo+ID4gWWVh
aCwgYXMgTEtQIHRlbGxzIHVzIHRoaXMgc2hvdWxkIGJlIHNpemVvZigpIGluc3RlYWQgb2YKPiA+
IEFSUkFZX1NJWkUoKS4KPiA+IAo+ID4gPiArwqDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IG1hc2sg
JiYgaSA8IEFSUkFZX1NJWkUodGRhdCk7IG1hc2sgPj49IDIpIHsKPiA+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaWYgKG1hc2sgJiAweDMpIHsKPiA+IAo+ID4gKGZvciB0aGUgY29u
c2lzdGVuY3kgaXQgaGFzIHRvIGJlIEdFTk1BU0soKSwgYnV0IHNlZSBiZWxvdykKPiA+IAo+ID4g
Rmlyc3Qgb2YgYWxsLCBzdHJpY3RseSBzcGVha2luZyB3ZSBzaG91bGQgdXNlIHRoZSBmdWxsIG1h
c2sgd2l0aG91dAo+ID4gbGltaXRpbmcgaXQgdG8gdGhlIDAgZWxlbWVudCBpbiB0aGUgYXJyYXkg
KEknbSB0YWxraW5nIGFib3V0Cj4gPiBhY3RpdmVfc2Nhbl9tYXNrKS4KPiA+IAo+ID4gVGhhdCBz
YWlkLCB3ZSBtYXkgYWN0dWFsbHkgdXNlIGJpdCBvcGVyYXRpb25zIGhlcmUgaW4gYSBiZXR0ZXIg
d2F5LAo+ID4gaS5lLgo+ID4gCj4gPiDCoCB1bnNpZ25lZCBsb25nIG1hc2sgPSBhY3RpdmVfc2Nh
bl9tYXNrWzBdICYgKGFjdGl2ZV9zY2FuX21hc2tbMF0gLQo+ID4gMSk7Cj4gPiAKPiA+IMKgIGog
PSAwOwo+ID4gwqAgZm9yX2VhY2hfc2V0X2JpdChpLCBhY3RpdmVfc2Nhbl9tYXNrLCAuLi4pIHsK
PiA+IMKgwqDCoCB2YWwgPSByZWFkbCguLi4pOwo+ID4gwqDCoMKgIC8qIFR3byBjaGFubmVscyBw
ZXIgc2FtcGxlLiBEZW11eCBhY3RpdmUuICovCj4gPiDCoMKgwqAgdGRhdFtqKytdID0gdmFsID4+
ICgxNiAqIChpICUgMikpOwo+IAo+IEFsdGVybmF0aXZlbHkKPiAKPiDCoMKgwqDCoCAvKiBUd28g
Y2hhbm5lbHMgcGVyIHNhbXBsZS4gRGVtdXggYWN0aXZlLiAqLwo+IMKgwqDCoMKgIGlmIChpICUg
MikKPiDCoMKgwqDCoMKgwqAgdGRhdFtqKytdID0gdXBwZXJfMTZfYml0cyh2YWwpOwo+IMKgwqDC
oMKgIGVsc2UKPiDCoMKgwqDCoMKgwqAgdGRhdFtqKytdID0gbG93ZXJfMTZfYml0cyh2YWwpOwo+
IAo+IHdoaWNoIG1heSBiZSBiZXR0ZXIgdG8gcmVhZC4KCkl0J3Mgbm90IGlmL2Vsc2UgdGhvdWdo
LiBZb3Ugd291bGQgY2hlY2sgKGkgJSAyKSBmb3IgdGhlIHVwcGVyIDE2IGJpdHMsCmFuZCAoaSAl
IDEpIGZvciB0aGUgbG93ZXIgMTYgYml0cy4gQm90aCBjYW4gYmUgdmFsaWQgYXQgdGhlIHNhbWUg
dGltZS4KCkNoZWVycywKLVBhdWwKCj4gCj4gPiDCoCB9Cj4gPiAKPiA+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZhbCA9IHJlYWRsKGFkYy0+YmFzZSAr
Cj4gPiA+IEpaX0FEQ19SRUdfQURUQ0gpOwo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogVHdvIGNoYW5uZWxzIHBlciBzYW1wbGUuIERlbXV4IGFj
dGl2ZS4KPiA+ID4gKi8KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGlmIChtYXNrICYgQklUKDApKQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRkYXRbaSsrXSA9IHZhbCAm
IDB4ZmZmZjsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGlmIChtYXNrICYgQklUKDEpKQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRkYXRbaSsrXSA9IHZhbCA+PiAxNjsK
PiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+ID4gPiDCoMKgwqDCoMKgwqDC
oCB9Cj4gCj4gCgo=

