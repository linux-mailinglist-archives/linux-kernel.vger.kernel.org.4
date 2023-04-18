Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964456E5D2E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjDRJR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjDRJRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:17:24 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BAD5D3C2A;
        Tue, 18 Apr 2023 02:17:22 -0700 (PDT)
Received: from u202112136$hust.edu.cn ( [10.21.196.175] ) by
 ajax-webmail-app1 (Coremail) ; Tue, 18 Apr 2023 17:17:00 +0800 (GMT+08:00)
X-Originating-IP: [10.21.196.175]
Date:   Tue, 18 Apr 2023 17:17:00 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5p2O6Ziz?= <u202112136@hust.edu.cn>
To:     "greg kroah-hartman" <gregkh@linuxfoundation.org>,
        "felipe balbi" <balbi@kernel.org>,
        "sergey shtylyov" <s.shtylyov@omp.ru>
Cc:     "dongliang mu" <dzm91@hust.edu.cn>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        hust-os-kernel-patches@googlegroups.com
Subject: Re: [PATCH] usb: phy: phy-tahvo: fix memory leak in
 tahvo_usb_probe()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220802(cbd923c5)
 Copyright (c) 2002-2023 www.mailtech.cn hust
In-Reply-To: <20230418090758.18756-1-lidaxian@hust.edu.cn>
References: <20230418090758.18756-1-lidaxian@hust.edu.cn>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <63953090.3ef41.18793a73009.Coremail.u202112136@hust.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: FgEQrAB3xwgMYD5kSw33Ag--.40058W
X-CM-SenderInfo: rxsqjiirsrjlo6kx23oohg3hdfq/1tbiAQoFE17Em5GXpQACs9
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiTGkgWWFuZyIgPGxpZGF4
aWFuQGh1c3QuZWR1LmNuPgo+IFNlbnQgVGltZTogMjAyMy0wNC0xOCAxNzowNzo1NyAoVHVlc2Rh
eSkKPiBUbzogIkdyZWcgS3JvYWgtSGFydG1hbiIgPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3Jn
PiwgIkZlbGlwZSBCYWxiaSIgPGJhbGJpQGtlcm5lbC5vcmc+LCAiU2VyZ2V5IFNodHlseW92IiA8
cy5zaHR5bHlvdkBvbXAucnU+Cj4gQ2M6ICJMaSBZYW5nIiA8bGlkYXhpYW5AaHVzdC5lZHUuY24+
LCAiRG9uZ2xpYW5nIE11IiA8ZHptOTFAaHVzdC5lZHUuY24+LCBsaW51eC11c2JAdmdlci5rZXJu
ZWwub3JnLCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4gU3ViamVjdDogW1BBVENIXSB1
c2I6IHBoeTogcGh5LXRhaHZvOiBmaXggbWVtb3J5IGxlYWsgaW4gdGFodm9fdXNiX3Byb2JlKCkK
PiAKPiBTbWF0Y2ggcmVwb3J0czoKPiBkcml2ZXJzL3VzYi9waHkvcGh5LXRhaHZvLmM6IHRhaHZv
X3VzYl9wcm9iZSgpCj4gd2FybjogbWlzc2luZyB1bndpbmQgZ290bz8KPiAKPiBBZnRlciBnZXRp
bmcgaXJxLCBpZiByZXQgPCAwLCBpdCB3aWxsIHJldHVybiB3aXRob3V0IGVycm9yIGhhbmRsaW5n
IHRvCj4gZnJlZSBtZW1vcnkuCj4gSnVzdCBhZGQgZXJyb3IgaGFuZGxpbmcgdG8gZml4IHRoaXMg
cHJvYmxlbS4KPiAKPiBGaXhlczogMGQ0NWExMzczZTY2ICgidXNiOiBwaHk6IHRhaHZvOiBhZGQg
SVJRIGNoZWNrIikKPiBTaWduZWQtb2ZmLWJ5OiBMaSBZYW5nIDxsaWRheGlhbkBodXN0LmVkdS5j
bj4KPiBSZXZpZXdlZC1ieTogRG9uZ2xpYW5nIE11IDxkem05MUBodXN0LmVkdS5jbj4KPiAtLS0K
PiBUaGUgaXNzdWUgaXMgZm91bmQgYnkgc3RhdGljIGFuYWx5c2lzLCBhbmQgdGhlIHBhdGNoIHJl
bWFpbnMgdW50ZXN0Lgo+IC0tLQo+ICBkcml2ZXJzL3VzYi9waHkvcGh5LXRhaHZvLmMgfCA3ICsr
KysrLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
PiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvcGh5L3BoeS10YWh2by5jIGIvZHJpdmVycy91
c2IvcGh5L3BoeS10YWh2by5jCj4gaW5kZXggZjJkMmNjNTg2YzViLi4xODRhNWYzZDc0NzMgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy91c2IvcGh5L3BoeS10YWh2by5jCj4gKysrIGIvZHJpdmVycy91
c2IvcGh5L3BoeS10YWh2by5jCj4gQEAgLTM5MCw4ICszOTAsMTEgQEAgc3RhdGljIGludCB0YWh2
b191c2JfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiAgCWRldl9zZXRfZHJ2
ZGF0YSgmcGRldi0+ZGV2LCB0dSk7Cj4gIAo+ICAJdHUtPmlycSA9IHJldCA9IHBsYXRmb3JtX2dl
dF9pcnEocGRldiwgMCk7Cj4gLQlpZiAocmV0IDwgMCkKPiAtCQlyZXR1cm4gcmV0Owo+ICsJaWYg
KHJldCA8IDApIHsKPiArCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJjb3VsZCBub3QgZ2V0IGlycTog
JWRcbiIsCj4gKwkJCQlyZXQpOwo+ICsJCWdvdG8gZXJyX3JlbW92ZV9waHk7Cj4gKwl9Cj4gIAly
ZXQgPSByZXF1ZXN0X3RocmVhZGVkX2lycSh0dS0+aXJxLCBOVUxMLCB0YWh2b191c2JfdmJ1c19p
bnRlcnJ1cHQsCj4gIAkJCQkgICBJUlFGX09ORVNIT1QsCj4gIAkJCQkgICAidGFodm8tdmJ1cyIs
IHR1KTsKPiAtLSAKPiAyLjM0LjEKY2MgaHVzdC1vcy1rZXJuZWwtcGF0Y2hlc0Bnb29nbGVncm91
cHMuY29t
