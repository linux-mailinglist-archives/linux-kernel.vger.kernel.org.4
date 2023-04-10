Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385DB6DC684
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 14:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDJMFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 08:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjDJMFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 08:05:04 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A0C961B4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 05:05:01 -0700 (PDT)
Received: from u201911649$hust.edu.cn ( [10.17.52.61] ) by ajax-webmail-app1
 (Coremail) ; Mon, 10 Apr 2023 20:04:21 +0800 (GMT+08:00)
X-Originating-IP: [10.17.52.61]
Date:   Mon, 10 Apr 2023 20:04:21 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5oi06ZKm5ram?= <u201911649@hust.edu.cn>
To:     "daniel lezcano" <daniel.lezcano@linaro.org>,
        "thomas gleixner" <tglx@linutronix.de>,
        "bartosz golaszewski" <bgolaszewski@baylibre.com>
Cc:     hust-os-kernel-patches@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: clocksource: fix memory leak in
 davinci_timer_register
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220802(cbd923c5)
 Copyright (c) 2002-2023 www.mailtech.cn hust
In-Reply-To: <20230322151945.102353-1-flno@hust.edu.cn>
References: <20230322151945.102353-1-flno@hust.edu.cn>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <192d4b12.39f86.1876b0d8808.Coremail.u201911649@hust.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: FgEQrACnuAlF+zNkQ_RUAg--.32893W
X-CM-SenderInfo: zxsqimqrrwkmo6kx23oohg3hdfq/1tbiAQkRC17Em468VQAAs0
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CnBpbmc/Cgo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZXMtLS0tLQo+IEZyb206ICJRaW5ydW4gRGFp
IiA8Zmxub0BodXN0LmVkdS5jbj4KPiBTZW50IFRpbWU6IDIwMjMtMDMtMjIgMjM6MTk6NDUgKFdl
ZG5lc2RheSkKPiBUbzogIkRhbmllbCBMZXpjYW5vIiA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9y
Zz4sICJUaG9tYXMgR2xlaXhuZXIiIDx0Z2x4QGxpbnV0cm9uaXguZGU+LCAiQmFydG9zeiBHb2xh
c3pld3NraSIgPGJnb2xhc3pld3NraUBiYXlsaWJyZS5jb20+Cj4gQ2M6IGh1c3Qtb3Mta2VybmVs
LXBhdGNoZXNAZ29vZ2xlZ3JvdXBzLmNvbSwgIlFpbnJ1biBEYWkiIDxmbG5vQGh1c3QuZWR1LmNu
PiwgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwo+IFN1YmplY3Q6IFtQQVRDSF0gZHJpdmVy
czogY2xvY2tzb3VyY2U6IGZpeCBtZW1vcnkgbGVhayBpbiBkYXZpbmNpX3RpbWVyX3JlZ2lzdGVy
Cj4gCj4gU21hdGNoIHJlcG9ydHM6Cj4gZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1kYXZpbmNp
LmM6MzMyIGRhdmluY2lfdGltZXJfcmVnaXN0ZXIoKQo+IHdhcm46ICdiYXNlJyBmcm9tIGlvcmVt
YXAoKSBub3QgcmVsZWFzZWQgb24gbGluZXM6IDI3NC4KPiAKPiBGaXggdGhpcyBieSBkZWZpbmlu
ZyBhIHVuaWZpZWQgZnVuY3Rpb24gZXhpdAo+IHRvIGlvdW5tYXAgJ2Jhc2UnIGFuZCByZXR1cm4g
Y29ycmVzcG9uZGluZyB2YWx1ZS4KPiAKPiBGaXhlczogNzIxMTU0Zjk3MmFhICgiY2xvY2tzb3Vy
Y2UvZHJpdmVycy9kYXZpbmNpOiBBZGQgc3VwcG9ydCBmb3IgY2xvY2tldmVudHMiKQo+IFNpZ25l
ZC1vZmYtYnk6IFFpbnJ1biBEYWkgPGZsbm9AaHVzdC5lZHUuY24+Cj4gLS0tCj4gIGRyaXZlcnMv
Y2xvY2tzb3VyY2UvdGltZXItZGF2aW5jaS5jIHwgMTQgKysrKysrKysrKy0tLS0KPiAgMSBmaWxl
IGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXItZGF2aW5jaS5jIGIvZHJpdmVycy9jbG9ja3Nv
dXJjZS90aW1lci1kYXZpbmNpLmMKPiBpbmRleCA5OTk2YzA1NDI1MjAuLmE2ZGQxZGE5ZTZkMSAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLWRhdmluY2kuYwo+ICsrKyBi
L2RyaXZlcnMvY2xvY2tzb3VyY2UvdGltZXItZGF2aW5jaS5jCj4gQEAgLTI3MCw4ICsyNzAsMTAg
QEAgaW50IF9faW5pdCBkYXZpbmNpX3RpbWVyX3JlZ2lzdGVyKHN0cnVjdCBjbGsgKmNsaywKPiAg
CXRpY2tfcmF0ZSA9IGNsa19nZXRfcmF0ZShjbGspOwo+ICAKPiAgCWNsb2NrZXZlbnQgPSBremFs
bG9jKHNpemVvZigqY2xvY2tldmVudCksIEdGUF9LRVJORUwpOwo+IC0JaWYgKCFjbG9ja2V2ZW50
KQo+IC0JCXJldHVybiAtRU5PTUVNOwo+ICsJaWYgKCFjbG9ja2V2ZW50KSB7Cj4gKwkJcnYgPSAt
RU5PTUVNOwo+ICsJCWdvdG8gaW91bm1hcF9iYXNlOwo+ICsJfQo+ICAKPiAgCWNsb2NrZXZlbnQt
PmRldi5uYW1lID0gInRpbTEyIjsKPiAgCWNsb2NrZXZlbnQtPmRldi5mZWF0dXJlcyA9IENMT0NL
X0VWVF9GRUFUX09ORVNIT1Q7Cj4gQEAgLTI5Niw3ICsyOTgsNyBAQCBpbnQgX19pbml0IGRhdmlu
Y2lfdGltZXJfcmVnaXN0ZXIoc3RydWN0IGNsayAqY2xrLAo+ICAJCQkgImNsb2NrZXZlbnQvdGlt
MTIiLCBjbG9ja2V2ZW50KTsKPiAgCWlmIChydikgewo+ICAJCXByX2VycigiVW5hYmxlIHRvIHJl
cXVlc3QgdGhlIGNsb2NrZXZlbnQgaW50ZXJydXB0XG4iKTsKPiAtCQlyZXR1cm4gcnY7Cj4gKwkJ
Z290byBpb3VubWFwX2Jhc2U7Cj4gIAl9Cj4gIAo+ICAJZGF2aW5jaV9jbG9ja3NvdXJjZS5kZXYu
cmF0aW5nID0gMzAwOwo+IEBAIC0zMjMsMTMgKzMyNSwxNyBAQCBpbnQgX19pbml0IGRhdmluY2lf
dGltZXJfcmVnaXN0ZXIoc3RydWN0IGNsayAqY2xrLAo+ICAJcnYgPSBjbG9ja3NvdXJjZV9yZWdp
c3Rlcl9oeigmZGF2aW5jaV9jbG9ja3NvdXJjZS5kZXYsIHRpY2tfcmF0ZSk7Cj4gIAlpZiAocnYp
IHsKPiAgCQlwcl9lcnIoIlVuYWJsZSB0byByZWdpc3RlciBjbG9ja3NvdXJjZVxuIik7Cj4gLQkJ
cmV0dXJuIHJ2Owo+ICsJCWdvdG8gaW91bm1hcF9iYXNlOwo+ICAJfQo+ICAKPiAgCXNjaGVkX2Ns
b2NrX3JlZ2lzdGVyKGRhdmluY2lfdGltZXJfcmVhZF9zY2hlZF9jbG9jaywKPiAgCQkJICAgICBE
QVZJTkNJX1RJTUVSX0NMS1NSQ19CSVRTLCB0aWNrX3JhdGUpOwo+ICAKPiAgCXJldHVybiAwOwo+
ICsKPiAraW91bm1hcF9iYXNlOgo+ICsJaW91bm1hcChiYXNlKTsKPiArCXJldHVybiBydjsKPiAg
fQo+ICAKPiAgc3RhdGljIGludCBfX2luaXQgb2ZfZGF2aW5jaV90aW1lcl9yZWdpc3RlcihzdHJ1
Y3QgZGV2aWNlX25vZGUgKm5wKQo+IC0tIAo+IDIuMzcuMgo=
