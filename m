Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E857731A98
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjFON5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344208AbjFON5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:57:08 -0400
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89472D63;
        Thu, 15 Jun 2023 06:56:30 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-90.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-90.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:5310:0:640:bece:0])
        by forward500b.mail.yandex.net (Yandex) with ESMTP id 46B385F203;
        Thu, 15 Jun 2023 16:56:13 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-90.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 9uc1t51Wxa60-ZnkmKTAD;
        Thu, 15 Jun 2023 16:56:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1686837372;
        bh=6I7oNB104lTEttVt2iOQolZMZPAWsy5D0ajvBCSZxXE=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=lRH5r5ulr7gfVWjieHmuPXZ7WdQmf5Ht2VvwqHw1gKXwIVbXfP5SlXaNBECAJs6a/
         NgdO5xWp49jxBZId5SsiLaLX+FGnKRiceqAkaZINCodiM6ki9CeiPhUa9sC+B9QvP9
         UswOktkK5mFu17xMo94YBL9g0ZFfHG9tUzUiSbag=
Authentication-Results: mail-nwsmtp-smtp-production-main-90.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <a8b44c9c5dbd938eb2d826aa0d25af38ad613a17.camel@maquefel.me>
Subject: Re: [PATCH v1 01/43] gpio: ep93xx: split device in multiple
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     andy.shevchenko@gmail.com
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Russell King <linux@armlinux.org.uk>,
        Lukasz Majewski <lukma@denx.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Date:   Thu, 15 Jun 2023 19:56:10 +0300
In-Reply-To: <ZHlK9EkHlLD7DDG7@surfacebook>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
         <20230601053546.9574-2-nikita.shubin@maquefel.me>
         <ZHlK9EkHlLD7DDG7@surfacebook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gQW5keSAhCgpPbiBGcmksIDIwMjMtMDYtMDIgYXQgMDQ6NTAgKzAzMDAsIGFuZHkuc2hl
dmNoZW5rb0BnbWFpbC5jb20gd3JvdGU6Cj4gVGh1LCBKdW4gMDEsIDIwMjMgYXQgMDg6MzM6NTJB
TSArMDMwMCwgTmlraXRhIFNodWJpbiBraXJqb2l0dGk6Cj4gPiBUaGlzIHByZXBhcmVzIGVwOTN4
eCBTT0MgZ3BpbyB0byBjb252ZXJ0IGludG8gZGV2aWNlIHRyZWUgZHJpdmVyOgo+ID4gLSBkcm9w
cGVkIGJhbmtzIGFuZCBsZWdhY3kgZGVmaW5lcwo+ID4gLSBzcGxpdCBBQiBJUlEgYW5kIG1ha2Ug
aXQgc2hhcmVkCj4gPiAKPiA+IFdlIGFyZSByZWx5aW5nIG9uIElSUSBudW1iZXIgaW5mb3JtYXRp
b24gQSwgQiBwb3J0cyBoYXZlIHNpbmdsZQo+ID4gc2hhcmVkCj4gPiBJUlEsIHdoaWxlIEYgcG9y
dCBoYXZlIGRlZGljYXRlZCBJUlEgZm9yIGVhY2ggbGluZS4KPiA+IAo+ID4gQWxzbyB3ZSBoYWQg
dG8gc3BsaXQgc2luZ2xlIGVwOTN4eCBwbGF0Zm9ybV9kZXZpY2UgaW50byBtdWx0aXBsZSwKPiA+
IG9uZQo+ID4gZm9yIGVhY2ggcG9ydCwgd2l0aG91dCB0aGlzIHdlIGNhbid0IGRvIGEgZnVsbCB3
b3JraW5nIHRyYW5zaXRpb24KPiA+IGZyb20KPiA+IGxlZ2FjeSBwbGF0Zm9ybSBjb2RlIGludG8g
ZGV2aWNlIHRyZWUgY2FwYWJsZS4gQWxsIEdQSU9fTE9PS1VQIHdlcmUKPiA+IGNoYW5nZSB0byBt
YXRjaCBuZXcgY2hpcCBuYW1pbmdzLgo+IAo+IEZpcnN0IG9mIGFsbCwgY2hlY2sgaWYgeW91IGFk
ZGVkIEluLVJlcGx5LXRvIGVtYWlsIGhlYWRlciB0byB0aGUKPiBwcmV2aW91cwo+IHRocmVhZCwg
YXQgbGVhc3QgYGI0YCBkb3dubG9hZGVkIDE4OCBtZXNzYWdlcyBpbiB0aGlzIG9uZSBzbyBmYXIu
Cj4gU2Vjb25kLAo+IHRoZSBwcmV2aW91cyB3YXMga2luZGEgdjAsIHdoaWxlIHdlIHVzdWFsbHkg
YXNzdW1lIHRoYXQgbm9uLXZlcnNpb25lZAo+IHNlcmllcwo+IGlzIHYxLiBUaGlzIGlzIGEgYml0
IGFtYmlndW91cy4KPiAKPiAuLi4KPiAKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBHUElPX0xPT0tVUF9JRFgoImdwaW8tZXA5M3h4LjQiLCAxLMKgwqDCoMKgwqBOVUxMLCAxLAo+
ID4gR1BJT19BQ1RJVkVfSElHSCksCj4gCj4gVEFCIHVzZWQgaW5zdGVhZCBvZiBzcGFjZS4KPiAK
PiAuLi4KPiAKPiA+IMKgc3RydWN0IGRldmljZSBfX2luaXQgKmVwOTN4eF9pbml0X2RldmljZXMo
dm9pZCkKPiA+IMKgewo+ID4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBkZXZpY2UgKnBhcmVudDsK
PiA+ICvCoMKgwqDCoMKgwqDCoGludCBpOwo+IAo+IEl0J3MgdW5zaWduZWQsIHJpZ2h0Pwo+IAo+
ID4gK8KgwqDCoMKgwqDCoMKgZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUoZXA5M3h4X2dwaW9f
ZGV2aWNlKTsgaSsrKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBsYXRmb3Jt
X2RldmljZV9yZWdpc3RlcihlcDkzeHhfZ3Bpb19kZXZpY2VbaV0pOwo+IAo+IC4uLgo+IAo+ID4g
wqDCoMKgwqDCoMKgwqDCoHdyaXRlYihlaWMtPmludF9kZWJvdW5jZSwKPiA+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBlcGctPmJhc2UgKyBlaWMtPmlycV9vZmZzZXQgKwo+ID4gRVA5M1hY
X0lOVF9ERUJPVU5DRV9PRkZTRVQpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVp
Yy0+YmFzZSArIEVQOTNYWF9JTlRfREVCT1VOQ0VfT0ZGU0VUKTsKPiAKPiBOb3cgdGhpcyBjYW4g
YmUgYSBzaW5nbGUgbGluZS4gQWxzbyBzb21lIG90aGVyIGNhc2VzIG1heSBiZQo+IG9wdGltaXpl
ZC4KPiAKPiAuLi4KPiAKPiA+ICvCoMKgwqDCoMKgwqDCoHZvaWQgX19pb21lbSAqaW50ciA9Cj4g
PiBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2VfYnluYW1lKHBkZXYsICJpbnRyIik7Cj4g
Cj4gSXQncyBsZXNzIGVycm9yIHByb25lIGlmIHRoZSBhc3NpZ25tZW50IGlzIHNwbGl0IGZyb20g
ZGVmaW5pdGlvbiBhbmQKPiBtb3ZlZAo+IGNsb3NlciB0byBpdHMgKGZpcnN0KSB1c2VyLi4uCj4g
Cj4gPiArCj4gCj4gLi4uaGVyZS4KPiAKPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChJU19FUlIoaW50
cikpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIFBUUl9FUlIoaW50
cik7Cj4gCj4gLi4uCj4gCj4gPiArwqDCoMKgwqDCoMKgwqBlZ2MtPmVpYyA9IGRldm1fa2NhbGxv
YyhkZXYsIDEsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBzaXplb2YoKmVnYy0+ZWljKSwKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEdGUF9LRVJO
RUwpOwo+IAo+IFdoeSBrY2FsbG9jKDEpLCBpcyB0aGlzIGEgcGFydCB0aGF0IHdpbGwgYmUgKHNs
aWdodGx5KSBtb2RpZmllZCBpbgo+IHRoZSBuZXh0Cj4gcGF0Y2hlcyBpbiB0aGUgc2VyaWVzPwo+
IAo+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKCFlZ2MtPmVpYykKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqByZXR1cm4gLUVOT01FTTsKPiA+IMKgCj4gLi4uCj4gCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaXJxID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCAwKTsK
PiAKPiBObyByZXR1cm4gdmFsdWUgY2hlY2s/Cj4gCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmV0ID0gZGV2bV9yZXF1ZXN0X2lycShkZXYsIGlycSwKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVwOTN4
eF9hYl9pcnFfaGFuZGxlciwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoElSUUZfU0hBUkVELCBnYy0+bGFiZWwsIGdjKTsK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAocmV0KSB7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl9lcnIoZGV2LCAiZXJy
b3IgcmVxdWVzdGluZyBJUlEgOiAlZFxuIiwKPiA+IGlycSk7Cj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiByZXQ7Cj4gCj4gSWYgaXQncyBz
b3NsZWx5IHBhcnQgb2YgdGhlIC0+cHJvYmUoKSBmbG93LCB5b3UgbWF5IHVzZQo+IGRldl9lcnJf
cHJvYmUoKS4KPiAKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiDCoAo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdpcnEtPnBhcmVudHNbMF0gPSBpcnE7
Cj4gCj4gLi4uCj4gCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZvciAoaSA9
IDA7IGkgPCBnaXJxLT5udW1fcGFyZW50czsgaSsrKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlycSA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwg
aSk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlm
IChpcnEgPD0gMCkKPiAKPiA9PSAwIGlzIG5ldmVyIGhhcHBlbiBjYXNlLiBXaHk/Cj4gCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBjb250aW51ZTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgZ2lycS0+cGFyZW50c1tpXSA9IGlycTsKPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgfQo+IAo+ID4gK8KgwqDCoMKgwqDCoMKgcmV0ID0gYmdwaW9faW5p
dChnYywgJnBkZXYtPmRldiwgMSwgZGF0YSwgTlVMTCwgTlVMTCwgZGlyLAo+ID4gTlVMTCwgMCk7
Cj4gPiArwqDCoMKgwqDCoMKgwqBpZiAocmV0KSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgZGV2X2VycigmcGRldi0+ZGV2LCAidW5hYmxlIHRvIGluaXQgZ2VuZXJpYwo+ID4g
R1BJT1xuIik7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsK
PiAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBkZXZfZXJyX3Byb2Jl
KC4uLik7Cj4gCj4gPiDCoMKgwqDCoMKgwqDCoMKgfQo+IAo+IC4uLgo+IAo+ID4gK8KgwqDCoMKg
wqDCoMKgaWYgKHBsYXRmb3JtX2lycV9jb3VudChwZGV2KSA+IDApIHsKPiAKPiBEbyB5b3UgbmVl
ZCB0aGlzIGNoZWNrPwoKT25seSBBL0IvRiBwb3J0cyBoYXZlIGlycSdzIHNvIHdlIGRvbid0IGJv
dGhlciBzZXR0aW5nIHVwIGZvciBvdGhlcgpwb3J0cy4gCgo+IAo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGRldl9kYmcoJnBkZXYtPmRldiwgInNldHRpbmcgdXAgaXJxcyBmb3Ig
JXNcbiIsCj4gPiBkZXZfbmFtZSgmcGRldi0+ZGV2KSk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcmV0ID0gZXA5M3h4X3NldHVwX2lycXMocGRldiwgZWdjKTsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAocmV0KQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfZXJyKCZwZGV2LT5kZXYsICJzZXR1cCBp
cnFzIGZhaWxlZCBmb3IKPiA+ICVzXG4iLCBkZXZfbmFtZSgmcGRldi0+ZGV2KSk7Cj4gCj4gSWYg
aXQncyBhbiBlcnJvciwgd2h5IGNvbnRpbnVpbmc/CgpXZWxsIC0gaXQncyBub3QgZmF0YWwsIHdl
IGNhbiBzdGlsbCB1c2UgZ3Bpb3MgZXZlbiB3aXRob3V0IGlycSdzIGJ1dCB3ZQpzaG91bGQgd2Fy
bi4KCkFsbCBvdGhlciBjb21tZW50cyBhY2tub3dsZWRnZWQgYW5kIGZpeGVkLCB0aGFuayB5b3Uu
Cgo+IAo+ID4gK8KgwqDCoMKgwqDCoMKgfQo+IAoK

