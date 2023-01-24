Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7EE67916C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 07:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjAXG5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 01:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbjAXG5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 01:57:49 -0500
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 8B50B1BD2;
        Mon, 23 Jan 2023 22:57:43 -0800 (PST)
Received: by ajax-webmail-mail-app3 (Coremail) ; Tue, 24 Jan 2023 14:57:38
 +0800 (GMT+08:00)
X-Originating-IP: [112.254.167.99]
Date:   Tue, 24 Jan 2023 14:57:38 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   duoming@zju.edu.cn
To:     "Sean Young" <sean@mess.org>
Cc:     linux-media@vger.kernel.org, maximlevitsky@gmail.com,
        mchehab@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: rc: Fix use-after-free bugs caused by
 ene_tx_irqsim()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2023 www.mailtech.cn zju.edu.cn
In-Reply-To: <Y86kJKofh+tLYl6A@gofer.mess.org>
References: <20230123142123.58870-1-duoming@zju.edu.cn>
 <Y86kJKofh+tLYl6A@gofer.mess.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <5547403e.22140.185e29169ca.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cC_KCgC3vQxjgc9jOsw7DA--.55452W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgIFAVZdtdVLGAACs+
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sCgpPbiBNb24sIDIzIEphbiAyMDIzIDE1OjEzOjQwICswMDAwIFNlYW4gWW91bmcgd3Jv
dGU6Cgo+IE9uIE1vbiwgSmFuIDIzLCAyMDIzIGF0IDEwOjIxOjIzUE0gKzA4MDAsIER1b21pbmcg
WmhvdSB3cm90ZToKPiA+IFdoZW4gdGhlIGVuZSBkZXZpY2UgaXMgZGV0YWNoaW5nLCBmdW5jdGlv
biBlbmVfcmVtb3ZlKCkgd2lsbAo+ID4gYmUgY2FsbGVkLiBCdXQgdGhlcmUgaXMgbm8gZnVuY3Rp
b24gdG8gY2FuY2VsIHR4X3NpbV90aW1lcgo+ID4gaW4gZW5lX3JlbW92ZSgpLCB0aGUgdGltZXIg
aGFuZGxlciBlbmVfdHhfaXJxc2ltKCkgY291bGQgcmFjZQo+ID4gd2l0aCBlbmVfcmVtb3ZlKCku
IEFzIGEgcmVzdWx0LCB0aGUgVUFGIGJ1Z3MgY291bGQgaGFwcGVuLAo+ID4gdGhlIHByb2Nlc3Mg
aXMgc2hvd24gYmVsb3cuCj4gPiAKPiA+ICAgICAoY2xlYW51cCByb3V0aW5lKSAgICAgICAgICB8
ICAgICAgICAodGltZXIgcm91dGluZSkKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8IG1vZF90aW1lcigmZGV2LT50eF9zaW1fdGltZXIsIC4uKQo+ID4gZW5lX3JlbW92ZSgpICAg
ICAgICAgICAgICAgICAgIHwgKHdhaXQgYSB0aW1lKQo+ID4gICBrZnJlZShkZXYpIC8vRlJFRSAg
ICAgICAgICAgIHwKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IGVuZV90eF9p
cnFzaW0oKQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICBkZXYtPmh3X2xv
Y2sgLy9VU0UKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgZW5lX3R4X3Nh
bXBsZShkZXYpIC8vVVNFCj4gPiAKPiA+IEZpeCBieSBhZGRpbmcgZGVsX3RpbWVyX3N5bmMoJmRl
di0+dHhfc2ltX3RpbWVyKSBpbiBlbmVfcmVtb3ZlKCksCj4gPiBUaGUgdHhfc2ltX3RpbWVyIGNv
dWxkIHN0b3AgYmVmb3JlIGVuZSBkZXZpY2UgaXMgZGVhbGxvY2F0ZWQuCj4gPiAKPiA+IFdoYXQn
cyBtb3JlLCB0aGUgdGltZXIgY2FuIGNhbGwgZW5lX3R4X3NhbXBsZSgpIHdoaWNoIGNhbiB3cml0
ZQo+ID4gdG8gdGhlIGlvIHBvcnRzLiBTbyB3ZSBzaG91bGQgcHV0IHJjX3VucmVnaXN0ZXJfZGV2
aWNlKCkgYW5kCj4gPiBkZWxfdGltZXJfc3luYygmZGV2LT50eF9zaW1fdGltZXIpIGJlZm9yZSBy
ZWxlYXNlX3JlZ2lvbigpIGluCj4gPiBlbmVfcmVtb3ZlKCkuCj4gPiAKPiA+IEZpeGVzOiA5ZWE1
M2I3NGRmOWMgKCJWNEwvRFZCOiBTVEFHSU5HOiByZW1vdmUgbGlyY19lbmUwMTAwIGRyaXZlciIp
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBEdW9taW5nIFpob3UgPGR1b21pbmdAemp1LmVkdS5jbj4KPiA+
IC0tLQo+ID4gQ2hhbmdlcyBpbiB2MjoKPiA+ICAgLSBNb3ZlIHJjX3VucmVnaXN0ZXJfZGV2aWNl
KCkgYW5kIGRlbF90aW1lcl9zeW5jKCkgYmVmb3JlIHJlbGVhc2VfcmVnaW9uKCkuCj4gPiAKPiA+
ICBkcml2ZXJzL21lZGlhL3JjL2VuZV9pci5jIHwgMyArKy0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL21lZGlhL3JjL2VuZV9pci5jIGIvZHJpdmVycy9tZWRpYS9yYy9lbmVfaXIuYwo+ID4gaW5k
ZXggZTA5MjcwOTE2ZmIuLjI4NjQzNjBhZjllIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9tZWRp
YS9yYy9lbmVfaXIuYwo+ID4gKysrIGIvZHJpdmVycy9tZWRpYS9yYy9lbmVfaXIuYwo+ID4gQEAg
LTExMTIsOCArMTExMiw5IEBAIHN0YXRpYyB2b2lkIGVuZV9yZW1vdmUoc3RydWN0IHBucF9kZXYg
KnBucF9kZXYpCj4gPiAgCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmRldi0+aHdfbG9jaywgZmxh
Z3MpOwo+ID4gIAo+ID4gIAlmcmVlX2lycShkZXYtPmlycSwgZGV2KTsKPiA+IC0JcmVsZWFzZV9y
ZWdpb24oZGV2LT5od19pbywgRU5FX0lPX1NJWkUpOwo+ID4gIAlyY191bnJlZ2lzdGVyX2Rldmlj
ZShkZXYtPnJkZXYpOwo+ID4gKwlkZWxfdGltZXJfc3luYygmZGV2LT50eF9zaW1fdGltZXIpOwo+
ID4gKwlyZWxlYXNlX3JlZ2lvbihkZXYtPmh3X2lvLCBFTkVfSU9fU0laRSk7Cj4gPiAgCWtmcmVl
KGRldik7Cj4gPiAgfQo+IAo+IEknbSBzb3JyeSwgSSB0aGluayB0aGVyZSBtaWdodCBiZSBhIHBy
b2JsZW0gdGhlcmU6IHRoZSBpcnEgaXMgZnJlZWQgYmVmb3JlCj4gdGhlIHJjIGRldmljZSBpcyB1
bnJlZ2lzdGVyZWQuCj4gCj4gVGhlIHJ4IHJlY2VpdmVyIGlzIGRpc2FibGVkIHdpdGggZW5lX3J4
X2Rpc2FibGUoKSBiZWZvcmUgcmNfdW5yZWdpc3Rlcl9kZXZpY2UoKQo+IGlzIGNhbGxlZCwgd2hp
Y2ggbWVhbnMgaXQgY2FuIGJlIGVuYWJsZWQgYWdhaW4gaWYgYSBwcm9jZXNzIG9wZW5zIC9kZXYv
bGlyYzAKPiBiZXR3ZWVuIGVuZV9yeF9kaXNhYmxlKCkgYW5kIHJjX3VucmVnaXN0ZXJfZGV2aWNl
KCkuCj4gCj4gZW5lX3JlbW92ZSgpIHNob3VsZCBjYWxsIHJjX3VucmVnaXN0ZXJfZGV2aWNlKCkg
YW5kIGRlbF90aW1lcl9zeW5jKCkgYmVmb3JlCj4gYW55dGhpbmcgZWxzZS4KClRoYW5rIHlvdXIg
Zm9yIHlvdXIgdGltZSBhbmQgc3VnZ2VzdGlvbnMsIEkgdW5kZXJzdGFuZCBpdC4KCkJlc3QgcmVn
YXJkcywKRHVvbWluZyBaaG91Cg==
