Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8075E99AE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 08:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbiIZGio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 02:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbiIZGik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 02:38:40 -0400
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4F20F5AB
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 23:38:38 -0700 (PDT)
Received: by ajax-webmail-mail-app2 (Coremail) ; Mon, 26 Sep 2022 14:38:28
 +0800 (GMT+08:00)
X-Originating-IP: [10.162.98.155]
Date:   Mon, 26 Sep 2022 14:38:28 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   duoming@zju.edu.cn
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     johannes@sipsolutions.net, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Subject: Re: [PATCH V9] devcoredump: add context check in dev_coredumpm
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <YzFGblnZdDPWAW7E@kroah.com>
References: <20220926061609.44153-1-duoming@zju.edu.cn>
 <YzFGblnZdDPWAW7E@kroah.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <66a140d1.f7b7e.1837884be23.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgAn31rkSDFj1rJUBg--.16554W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAg0FAVZdtbpalgABsC
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sCgpPbiBNb24sIDI2IFNlcCAyMDIyIDA4OjI3OjU4ICswMjAwIEdyZWcgS0ggd3JvdGU6
Cgo+IE9uIE1vbiwgU2VwIDI2LCAyMDIyIGF0IDAyOjE2OjA5UE0gKzA4MDAsIER1b21pbmcgWmhv
dSB3cm90ZToKPiA+IFRoZSBkZXZfY29yZWR1bXBtKCksIGRldl9jb3JlZHVtcHYoKSBhbmQgZGV2
X2NvcmVkdW1wc2coKSBjb3VsZCBub3QKPiA+IGJlIHVzZWQgaW4gYXRvbWljIGNvbnRleHQsIGJl
Y2F1c2UgdGhleSBjYWxsIGt2YXNwcmludGZfY29uc3QoKSBhbmQKPiA+IGtzdHJkdXAoKSB3aXRo
IEdGUF9LRVJORUwgcGFyYW1ldGVyLiBUaGUgcHJvY2VzcyBpcyBzaG93biBiZWxvdzoKPiA+IAo+
ID4gZGV2X2NvcmVkdW1wdiguLiwgZ2ZwX3QgZ2ZwKQo+ID4gICBkZXZfY29yZWR1bXBtKC4uLCBn
ZnBfdCBnZnApCj4gPiAgICAgZGV2X3NldF9uYW1lCj4gPiAgICAgICBrb2JqZWN0X3NldF9uYW1l
X3ZhcmdzCj4gPiAgICAgICAgIGt2YXNwcmludGZfY29uc3QoR0ZQX0tFUk5FTCwgLi4uKTsgLy9t
YXkgc2xlZXAKPiA+ICAgICAgICAgICBrc3RyZHVwKHMsIEdGUF9LRVJORUwpOyAvL21heSBzbGVl
cAo+ID4gCj4gPiBUaGlzIHBhdGNoIGFkZHMgY29udGV4dCBjaGVjayBpbiBkZXZfY29yZWR1bXBt
KCkgaW4gb3JkZXIgdG8gc2hvdwo+ID4gZGV2X2NvcmVkdW1wbSgpIGFuZCBpdHMgY2FsbGVycyBj
b3VsZCBub3QgYmUgdXNlZCBpbiBhdG9taWMgY29udGV4dC4KPiA+IAo+ID4gV2hhdCdzIG1vcmUs
IHRoaXMgY2hhbmdlIGNhbiBhbGxvdyB0aGUgYXBpIHRvIGV2b2x2ZSBhbmQgd2lsbCBub3QKPiA+
IGluZmx1ZW5jZSB0aGUgdXNlcnMgdGhhdCBjYWxsIHRoaXMgYXBpLgo+ID4gCj4gPiBGaXhlczog
ODMzYzk1NDU2YTcwICgiZGV2aWNlIGNvcmVkdW1wOiBhZGQgbmV3IGRldmljZSBjb3JlZHVtcCBj
bGFzcyIpCj4gPiBTaWduZWQtb2ZmLWJ5OiBEdW9taW5nIFpob3UgPGR1b21pbmdAemp1LmVkdS5j
bj4KPiA+IC0tLQo+ID4gQ2hhbmdlcyBpbiB2OToKPiA+ICAgLSBBZGQgY29udGV4dCBjaGVjayBp
biBkZXZfY29yZWR1bXBtKCkuCj4gPiAKPiA+ICBkcml2ZXJzL2Jhc2UvZGV2Y29yZWR1bXAuYyB8
IDMgKysrCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+ID4gCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9iYXNlL2RldmNvcmVkdW1wLmMgYi9kcml2ZXJzL2Jhc2UvZGV2Y29y
ZWR1bXAuYwo+ID4gaW5kZXggZjRkNzk0ZDZiYjguLjgwNmVlODcyZjVmIDEwMDY0NAo+ID4gLS0t
IGEvZHJpdmVycy9iYXNlL2RldmNvcmVkdW1wLmMKPiA+ICsrKyBiL2RyaXZlcnMvYmFzZS9kZXZj
b3JlZHVtcC5jCj4gPiBAQCAtMjU1LDYgKzI1NSw5IEBAIHZvaWQgZGV2X2NvcmVkdW1wbShzdHJ1
Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBtb2R1bGUgKm93bmVyLAo+ID4gIAlzdHJ1Y3QgZGV2Y2Rf
ZW50cnkgKmRldmNkOwo+ID4gIAlzdHJ1Y3QgZGV2aWNlICpleGlzdGluZzsKPiA+ICAKPiA+ICsJ
aWYgKCFnZnBmbGFnc19ub3JtYWxfY29udGV4dChnZnApKQo+ID4gKwkJZ290byBmcmVlOwo+IAo+
IFdhaXQsIHRoaXMganVzdCBicm9rZSB0aGluZ3MgZm9yIG5vIGdvb2QgcmVhc29uIGlmIGEgY2Fs
bGVyIGhhcHBlbmVkIHRvCj4gaGF2ZSBzZXQgYSBHRlAgZmxhZyB0aGF0IHdlIGRvIG5vdCBsaWtl
IGF0IHRoZSBtb21lbnQuCj4gCj4gV2hhdCBjb2RlIG5vdyBkb2VzIG5vdCB3b3JrIHRoYXQgcHJl
dmlvdXNseSBkaWQgd29yayB3aXRoIHRoaXMgY2hhbmdlPwoKSSBmb3VuZCB0aGF0IGFsbCB1c2Vy
cyBpbiB0aGUga2VybmVsIGNhbGwgdGhlIGRldl9jb3JlZHVtcHYoKSwgZGV2X2NvcmVkdW1wbSgp
IGFuZApkZXZfY29yZWR1bXBzZygpIHdpdGggIkdGUF9LRVJORUwiLiBTbyB0aGlzIGNoYW5nZSB3
aWxsIG5vdCBpbmZsdWVuY2UgdGhlIGV4aXN0aW5nIHVzZXJzLgoKQmVzdCByZWdhcmRzLApEdW9t
aW5nIFpob3U=
