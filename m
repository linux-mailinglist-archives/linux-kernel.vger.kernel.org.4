Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF595F2794
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 04:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiJCB60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 21:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiJCB6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 21:58:24 -0400
X-Greylist: delayed 410 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 02 Oct 2022 18:58:20 PDT
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 075142F3B3
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 18:58:19 -0700 (PDT)
Received: by ajax-webmail-mail-app4 (Coremail) ; Mon, 3 Oct 2022 09:50:43
 +0800 (GMT+08:00)
X-Originating-IP: [106.117.99.137]
Date:   Mon, 3 Oct 2022 09:50:43 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   duoming@zju.edu.cn
To:     "James Smart" <jsmart2021@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        james.smart@broadcom.com, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH] nvme-fc: fix sleep-in-atomic-context bug caused by
 nvme_fc_rcv_ls_req
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <305fbf18-6759-9b00-6fc0-93a4a2e40be2@gmail.com>
References: <20221002001909.20070-1-duoming@zju.edu.cn>
 <305fbf18-6759-9b00-6fc0-93a4a2e40be2@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7bd9e071.1063f1.1839b89cefa.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgCXnP3zPzpjF6_UBg--.23647W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAg4MAVZdtbwGGwAAse
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sCgpPbiBTdW4sIDIgT2N0IDIwMjIgMTA6MTI6MTUgLTA3MDAgSmFtZXMgU21hcnQgd3Jv
dGU6Cgo+IE9uIDEwLzEvMjAyMiA1OjE5IFBNLCBEdW9taW5nIFpob3Ugd3JvdGU6Cj4gPiBUaGUg
ZnVuY3Rpb24gbHBmY19wb2xsX3RpbWVvdXQoKSBpcyBhIHRpbWVyIGhhbmRsZXIgdGhhdCBydW5z
IGluIGFuCj4gPiBhdG9taWMgY29udGV4dCwgYnV0IGl0IGNhbGxzICJremFsbG9jKC4uLCBHRlBf
S0VSTkVMKSIgdGhhdCBtYXkgc2xlZXAuCj4gPiBBcyBhIHJlc3VsdCwgdGhlIHNsZWVwLWluLWF0
b21pYy1jb250ZXh0IGJ1ZyB3aWxsIGhhcHBlbi4gVGhlIHByb2Nlc3Nlcwo+ID4gaXMgc2hvd24g
YmVsb3c6Cj4gPiAKPiA+IGxwZmNfcG9sbF90aW1lb3V0KCkKPiA+ICAgbHBmY19zbGlfaGFuZGxl
X2Zhc3RfcmluZ19ldmVudCgpCj4gPiAgICBscGZjX3NsaV9wcm9jZXNzX3Vuc29sX2lvY2IoKQo+
ID4gICAgIGxwZmNfY29tcGxldGVfdW5zb2xfaW9jYigpCj4gPiAgICAgIGxwZmNfbnZtZV91bnNv
bF9sc19oYW5kbGVyKCkKPiA+ICAgICAgIGxwZmNfbnZtZV9oYW5kbGVfbHNyZXEoKQo+ID4gICAg
ICAgIG52bWVfZmNfcmN2X2xzX3JlcSgpCj4gPiAgICAgICAgIGt6YWxsb2Moc2l6ZW9mKC4uLCBH
RlBfS0VSTkVMKSAvL21heSBzbGVlcAo+ID4gCj4gPiBUaGlzIHBhdGNoIGNoYW5nZXMgdGhlIGdm
cF90IHBhcmFtZXRlciBvZiBremFsbG9jKCkgZnJvbSBHRlBfS0VSTkVMIHRvCj4gPiBHRlBfQVRP
TUlDIGluIG9yZGVyIHRvIG1pdGlnYXRlIHRoZSBidWcuCj4gPiAKPiA+IEZpeGVzOiAxNGZkMWU5
OGFmYWYgKCJudm1lLWZjOiBBZGQgRGlzY29ubmVjdCBBc3NvY2lhdGlvbiBSY3Ygc3VwcG9ydCIp
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBEdW9taW5nIFpob3UgPGR1b21pbmdAemp1LmVkdS5jbj4KPiA+
IC0tLQo+ID4gICBkcml2ZXJzL252bWUvaG9zdC9mYy5jIHwgMiArLQo+ID4gICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbnZtZS9ob3N0L2ZjLmMgYi9kcml2ZXJzL252bWUvaG9zdC9mYy5jCj4gPiBpbmRl
eCAxMjdhYmFmOWJhNS4uMzY2OThkZmM4YjMgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL252bWUv
aG9zdC9mYy5jCj4gPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9mYy5jCj4gPiBAQCAtMTc1NCw3
ICsxNzU0LDcgQEAgbnZtZV9mY19yY3ZfbHNfcmVxKHN0cnVjdCBudm1lX2ZjX3JlbW90ZV9wb3J0
ICpwb3J0cHRyLAo+ID4gICAJbHNvcCA9IGt6YWxsb2Moc2l6ZW9mKCpsc29wKSArCj4gPiAgIAkJ
CXNpemVvZih1bmlvbiBudm1lZmNfbHNfcmVxdWVzdHMpICsKPiA+ICAgCQkJc2l6ZW9mKHVuaW9u
IG52bWVmY19sc19yZXNwb25zZXMpLAo+ID4gLQkJCUdGUF9LRVJORUwpOwo+ID4gKwkJCUdGUF9B
VE9NSUMpOwo+ID4gICAJaWYgKCFsc29wKSB7Cj4gPiAgIAkJZGV2X2luZm8obHBvcnQtPmRldiwK
PiA+ICAgCQkJIlJDViAlcyBMUyBmYWlsZWQ6IE5vIG1lbW9yeVxuIiwKPiAKPiBJIHdvdWxkIHBy
ZWZlciB0aGlzIHdhcyBmaXhlZCB3aXRoaW4gbHBmYyByYXRoZXIgdGhhbiBpbnRyb2R1Y2luZyBh
dG9taWMgCj4gYWxsb2NhdGlvbnMgKDFzdCBpbiBlaXRoZXIgaG9zdCBvciB0YXJnZXQgdHJhbnNw
b3J0KS4gIEl0IHdhcyBpbnRyb2R1Y2VkIAo+IGJ5IGxwZmMgY2hhbmdlIGluIGlycSBoYW5kbGlu
ZyBzdHlsZS4KClRoYW5rIHlvdXIgZm9yIHlvdXIgcmVwbHkgYW5kIHN1Z2dlc3Rpb25zIQoKRG8g
eW91IHRoaW5rIGNoYW5nZSB0aGUgbHBmY19wb2xsX3RpbWVvdXQoKSB0byBhIGRlbGF5ZWRfd29y
ayBpcyBiZXR0ZXI/CgpCZXN0IHJlZ2FyZHMsCkR1b21pbmcgWmhvdQ==
