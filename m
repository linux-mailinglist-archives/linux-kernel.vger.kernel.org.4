Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB4C7102F0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 04:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237231AbjEYCer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 22:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237076AbjEYCeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 22:34:44 -0400
Received: from zg8tmtyylji0my4xnjqunzqa.icoremail.net (zg8tmtyylji0my4xnjqunzqa.icoremail.net [162.243.164.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAB2312B
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 19:34:39 -0700 (PDT)
Received: from duoming$zju.edu.cn ( [218.12.18.236] ) by
 ajax-webmail-mail-app4 (Coremail) ; Thu, 25 May 2023 10:34:13 +0800
 (GMT+08:00)
X-Originating-IP: [218.12.18.236]
Date:   Thu, 25 May 2023 10:34:13 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   duoming@zju.edu.cn
To:     "Mike Snitzer" <snitzer@kernel.org>
Cc:     linux-kernel@vger.kernel.org, agk@redhat.com, dm-devel@redhat.com,
        "Ignat Korchagin" <ignat@cloudflare.com>
Subject: Re: dm crypt: fix sleep-in-atomic-context bug in
 kcryptd_crypt_tasklet
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220622(41e5976f)
 Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <ZGz9k3jnVqiO20a2@redhat.com>
References: <20230523075857.76520-1-duoming@zju.edu.cn>
 <ZGz9k3jnVqiO20a2@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <89fc5b.4de4d.18850c1b97f.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgBHjAkmyW5kO_KyAw--.52218W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwIGAWRuJ94HcwAAsB
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sCgpPbiBUdWUsIDIzIE1heSAyMDIzIDEzOjUzOjIzIC0wNDAwIE1pa2UgU25pdHplciB3
cm90ZToKCj4gPiBJbiBvcmRlciB0byBpbXByb3ZlIHRoZSBJTyBwZXJmb3JtYW5jZSBvZiB0aGUg
ZG0tY3J5cHQKPiA+IGltcGxlbWVudGF0aW9uLCB0aGUgY29tbWl0IDM5ZDQyZmE5NmJhMSAoImRt
IGNyeXB0Ogo+ID4gYWRkIGZsYWdzIHRvIG9wdGlvbmFsbHkgYnlwYXNzIGtjcnlwdGQgd29ya3F1
ZXVlcyIpCj4gPiBhZGRzIHRhc2tsZXQgdG8gZG8gdGhlIGNyeXB0byBvcGVyYXRpb25zLgo+ID4g
Cj4gPiBUaGUgdGFza2xldCBjYWxsYmFjayBmdW5jdGlvbiBrY3J5cHRkX2NyeXB0X3Rhc2tsZXQo
KQo+ID4gY2FsbHMga2NyeXB0ZF9jcnlwdCgpIHdoaWNoIGlzIGFuIG9yaWdpbmFsIHdvcmtxdWV1
ZQo+ID4gY2FsbGJhY2sgZnVuY3Rpb24gdGhhdCBtYXkgc2xlZXAuIEFzIGEgcmVzdWx0LCB0aGUK
PiA+IHNsZWVwLWluLWF0b21pYy1jb250ZXh0IGJ1ZyBtYXkgaGFwcGVuLiBUaGUgcHJvY2Vzcwo+
ID4gaXMgc2hvd24gYmVsb3cuCj4gPiAKPiA+ICAgIChhdG9taWMgY29udGV4dCkKPiA+IGtjcnlw
dGRfY3J5cHRfdGFza2xldCgpCj4gPiAgIGtjcnlwdGRfY3J5cHQoKQo+ID4gICAgIGtjcnlwdGRf
Y3J5cHRfd3JpdGVfY29udmVydCgpCj4gPiAgICAgICB3YWl0X2Zvcl9jb21wbGV0aW9uKCkgLy9t
YXkgc2xlZXAKPiA+IAo+ID4gVGhlIHdhaXRfZm9yX2NvbXBsZXRpb24oKSBpcyBhIGZ1bmN0aW9u
IHRoYXQgbWF5IHNsZWVwLgo+ID4gSW4gb3JkZXIgdG8gbWl0aWdhdGUgdGhlIGJ1ZywgdGhpcyBw
YXRjaCBjaGFuZ2VzCj4gPiB3YWl0X2Zvcl9jb21wbGV0aW9uKCkgdG8gdHJ5X3dhaXRfZm9yX2Nv
bXBsZXRpb24oKS4KPiA+IAo+ID4gRml4ZXM6IDM5ZDQyZmE5NmJhMSAoImRtIGNyeXB0OiBhZGQg
ZmxhZ3MgdG8gb3B0aW9uYWxseSBieXBhc3Mga2NyeXB0ZCB3b3JrcXVldWVzIikKPiA+IFNpZ25l
ZC1vZmYtYnk6IER1b21pbmcgWmhvdSA8ZHVvbWluZ0B6anUuZWR1LmNuPgo+ID4gLS0tCj4gPiAg
ZHJpdmVycy9tZC9kbS1jcnlwdC5jIHwgMyArKy0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21k
L2RtLWNyeXB0LmMgYi9kcml2ZXJzL21kL2RtLWNyeXB0LmMKPiA+IGluZGV4IDhiNDdiOTEzZWU4
Li41ZTJiMjQ2M2Q4NyAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvbWQvZG0tY3J5cHQuYwo+ID4g
KysrIGIvZHJpdmVycy9tZC9kbS1jcnlwdC5jCj4gPiBAQCAtMjA4NSw3ICsyMDg1LDggQEAgc3Rh
dGljIHZvaWQga2NyeXB0ZF9jcnlwdF93cml0ZV9jb252ZXJ0KHN0cnVjdCBkbV9jcnlwdF9pbyAq
aW8pCj4gPiAgCWNyeXB0X2ZpbmlzaGVkID0gYXRvbWljX2RlY19hbmRfdGVzdCgmY3R4LT5jY19w
ZW5kaW5nKTsKPiA+ICAJaWYgKCFjcnlwdF9maW5pc2hlZCAmJiBrY3J5cHRkX2NyeXB0X3dyaXRl
X2lubGluZShjYywgY3R4KSkgewo+ID4gIAkJLyogV2FpdCBmb3IgY29tcGxldGlvbiBzaWduYWxl
ZCBieSBrY3J5cHRkX2FzeW5jX2RvbmUoKSAqLwo+ID4gLQkJd2FpdF9mb3JfY29tcGxldGlvbigm
Y3R4LT5yZXN0YXJ0KTsKPiA+ICsJCXdoaWxlICghdHJ5X3dhaXRfZm9yX2NvbXBsZXRpb24oJmN0
eC0+cmVzdGFydCkpCj4gPiArCQkJOwo+ID4gIAkJY3J5cHRfZmluaXNoZWQgPSAxOwo+ID4gIAl9
Cj4gPiAgCj4gPiAtLSAKPiA+IDIuMTcuMQo+ID4gCj4gCj4gQ2MnaW5nIElnbmF0IGZvciBjbG9z
ZXIgcmV2aWV3Lgo+IAo+IEJ1dCB3YXNuJ3QgdGhpcyBhbHJlYWR5IGFkZHJlc3NlZCB3aXRoIHRo
aXMgY29tbWl0PzoKPiA4YWJlYzM2ZDEyNzQgZG0gY3J5cHQ6IGRvIG5vdCB3YWl0IGZvciBiYWNr
bG9nZ2VkIGNyeXB0byByZXF1ZXN0IGNvbXBsZXRpb24gaW4gc29mdGlycQo+IAo+IE1pa2UKClRo
YW5rIHlvdSBmb3IgeW91ciByZXZpZXcsIEkgdGhpbmsgdGhlIGNvbW1pdCA4YWJlYzM2ZDEyNzQg
KCJkbSBjcnlwdDogCmRvIG5vdCB3YWl0IGZvciBiYWNrbG9nZ2VkIGNyeXB0byByZXF1ZXN0IGNv
bXBsZXRpb24gaW4gc29mdGlycSIpIGNvdWxkCm5vdCBzb2x2ZSB0aGlzIHByb2JsZW0uCgpXaGVu
IGNyeXB0X2NvbnZlcnQoKSByZXR1cm5zIEJMS19TVFNfUFJPVEVDVElPTiBvciBCTEtfU1RTX0lP
RVJSLCBtZWFud2hpbGUsCnRoZXJlIGlzIHJlcXVlc3QgdGhhdCBpcyBxdWV1ZWQgYW5kIHdhaXQg
a2NyeXB0ZF9hc3luY19kb25lKCkgdG8gcHJvY2Vzcy4KVGhlIHdvcmtxdWV1ZSBjYWxsYmFjayBm
dW5jdGlvbiBrY3J5cHRkX2NyeXB0X3JlYWRfY29udGludWUoKSB3aWxsIG5vdCBiZSBjYWxsZWQu
ClRoZSB2YXJpYWJsZSBjcnlwdF9maW5pc2hlZCBlcXVhbHMgdG8gemVybywgaXQgd2lsbCBjYWxs
IHdhaXRfZm9yX2NvbXBsZXRpb24oKQp0aGF0IG1heSBzbGVlcC4gVGhlIHJlbGV2YW50IGNvZGVz
IGFyZSBzaG93biBiZWxvdzoKCnN0YXRpYyBibGtfc3RhdHVzX3QgY3J5cHRfY29udmVydCguLi4p
CnsKLi4uCgkJLyoKCQkgKiBUaGUgcmVxdWVzdCBpcyBxdWV1ZWQgYW5kIHByb2Nlc3NlZCBhc3lu
Y2hyb25vdXNseSwKCQkgKiBjb21wbGV0aW9uIGZ1bmN0aW9uIGtjcnlwdGRfYXN5bmNfZG9uZSgp
IHdpbGwgYmUgY2FsbGVkLgoJCSAqLwoJCWNhc2UgLUVJTlBST0dSRVNTOgoJCQljdHgtPnIucmVx
ID0gTlVMTDsKCQkJY3R4LT5jY19zZWN0b3IgKz0gc2VjdG9yX3N0ZXA7CgkJCXRhZ19vZmZzZXQr
KzsKCQkJY29udGludWU7Ci4uLgoJCS8qCgkJICogVGhlcmUgd2FzIGEgZGF0YSBpbnRlZ3JpdHkg
ZXJyb3IuCgkJICovCgkJY2FzZSAtRUJBRE1TRzoKCQkJYXRvbWljX2RlYygmY3R4LT5jY19wZW5k
aW5nKTsKCQkJcmV0dXJuIEJMS19TVFNfUFJPVEVDVElPTjsKCQkvKgoJCSAqIFRoZXJlIHdhcyBh
biBlcnJvciB3aGlsZSBwcm9jZXNzaW5nIHRoZSByZXF1ZXN0LgoJCSAqLwoJCWRlZmF1bHQ6CgkJ
CWF0b21pY19kZWMoJmN0eC0+Y2NfcGVuZGluZyk7CgkJCXJldHVybiBCTEtfU1RTX0lPRVJSOwoJ
CX0KLi4uCn0KCnN0YXRpYyB2b2lkIGtjcnlwdGRfY3J5cHRfd3JpdGVfY29udmVydCguLi4pCnsK
Li4uCglyID0gY3J5cHRfY29udmVydCgpOyAvL3JldHVybiBCTEtfU1RTX1BST1RFQ1RJT04gb3Ig
QkxLX1NUU19JT0VSUgouLi4KCWlmIChyID09IEJMS19TVFNfREVWX1JFU09VUkNFKSB7IC8vdGhp
cyBjb25kaXRpb24gaXMgbm90IHNhdGlzZmllZCwgdGhlIHdvcmtxdWV1ZSB3aWxsIG5vdCBiZSBj
YWxsZWQuCgkJSU5JVF9XT1JLKCZpby0+d29yaywga2NyeXB0ZF9jcnlwdF93cml0ZV9jb250aW51
ZSk7CgkJcXVldWVfd29yayhjYy0+Y3J5cHRfcXVldWUsICZpby0+d29yayk7CgkJcmV0dXJuOwoJ
fQouLi4KICAgICAgICAvLyBjcnlwdF9maW5pc2hlZCBpcyB6ZXJvLCBiZWNhdXNlIHRoZXJlIGlz
IHJlcXVlc3QgdGhhdCBpcyBxdWV1ZWQgYW5kIHdhaXQga2NyeXB0ZF9hc3luY19kb25lKCkgdG8g
cHJvY2Vzcy4KCWNyeXB0X2ZpbmlzaGVkID0gYXRvbWljX2RlY19hbmRfdGVzdCgmY3R4LT5jY19w
ZW5kaW5nKTsgCglpZiAoIWNyeXB0X2ZpbmlzaGVkICYmIGtjcnlwdGRfY3J5cHRfd3JpdGVfaW5s
aW5lKGNjLCBjdHgpKSB7CgkJLyogV2FpdCBmb3IgY29tcGxldGlvbiBzaWduYWxlZCBieSBrY3J5
cHRkX2FzeW5jX2RvbmUoKSAqLwoJCXdhaXRfZm9yX2NvbXBsZXRpb24oJmN0eC0+cmVzdGFydCk7
ICAvL21heSBzbGVlcCEKICAgICAgICAgICAgICAgIC4uLgoJfQouLi4KfQoKQmVzdCByZWdhcmRz
LApEdW9taW5nIFpob3UKCgoKCg==
