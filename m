Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818335F3235
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 16:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiJCO5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 10:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJCO5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 10:57:33 -0400
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A52C51836C;
        Mon,  3 Oct 2022 07:57:06 -0700 (PDT)
Received: by ajax-webmail-mail-app4 (Coremail) ; Mon, 3 Oct 2022 22:56:23
 +0800 (GMT+08:00)
X-Originating-IP: [218.12.19.40]
Date:   Mon, 3 Oct 2022 22:56:23 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   duoming@zju.edu.cn
To:     "Dmitry Bogdanov" <d.bogdanov@yadro.com>
Cc:     linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        kuba@kernel.org, davem@davemloft.net, andrii@kernel.org,
        gregkh@linuxfoundation.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: Re: [PATCH] scsi: target: iscsi: cxgbit: fix
 sleep-in-atomic-context bug in cxgbit_abort_conn
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <20221003144602.GA10901@yadro.com>
References: <20221002014047.23066-1-duoming@zju.edu.cn>
 <20221003144602.GA10901@yadro.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2c8985b8.107370.1839e591d73.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgA3OMwY+Dpjor_ZBg--.64103W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgMMAVZdtbwWwAAfsH
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

SGVsbG8sCgpPbiBNb24sIDMgT2N0IDIwMjIgMTc6NDY6MDIgKzAzMDAgRG1pdHJ5IEJvZ2Rhbm92
IHdyb3RlOgoKPiBPbiBTdW4sIE9jdCAwMiwgMjAyMiBhdCAwOTo0MDo0N0FNICswODAwLCBEdW9t
aW5nIFpob3Ugd3JvdGU6Cj4gPiAKPiA+IFRoZSBmdW5jdGlvbiBpc2NzaXRfaGFuZGxlX3RpbWUy
cmV0YWluX3RpbWVvdXQoKSBpcyBhIHRpbWVyIGhhbmRsZXIgdGhhdAo+ID4gcnVucyBpbiBhbiBh
dG9taWMgY29udGV4dCwgYnV0IGl0IGNhbGxzICJhbGxvY19za2IoMCwgR0ZQX0tFUk5FTCB8IC4u
LikiCj4gPiB0aGF0IG1heSBzbGVlcC4gQXMgYSByZXN1bHQsIHRoZSBzbGVlcC1pbi1hdG9taWMt
Y29udGV4dCBidWcgd2lsbCBoYXBwZW4uCj4gPiBUaGUgcHJvY2VzcyBpcyBzaG93biBiZWxvdzoK
PiA+IAo+ID4gaXNjc2l0X2hhbmRsZV90aW1lMnJldGFpbl90aW1lb3V0KCkKPiA+ICBpc2NzaXRf
Y2xvc2Vfc2Vzc2lvbigpCj4gPiAgIGlzY3NpdF9mcmVlX2Nvbm5lY3Rpb25fcmVjb3ZlcnlfZW50
cmllcygpCj4gPiAgICBpc2NzaXRfZnJlZV9jbWQoKQo+ID4gICAgIF9faXNjc2l0X2ZyZWVfY21k
KCkKPiA+ICAgICAgY3hnYml0X3VubWFwX2NtZCgpCj4gPiAgICAgICBjeGdiaXRfYWJvcnRfY29u
bigpCj4gPiAgICAgICAgYWxsb2Nfc2tiKDAsIEdGUF9LRVJORUwgfCAuLi4pIC8vbWF5IHNsZWVw
Cj4gPiAKPiA+IFRoaXMgcGF0Y2ggY2hhbmdlcyB0aGUgZ2ZwX3QgcGFyYW1ldGVyIG9mIGFsbG9j
X3NrYigpIGZyb20gR0ZQX0tFUk5FTCB0bwo+ID4gR0ZQX0FUT01JQyBpbiBvcmRlciB0byBtaXRp
Z2F0ZSB0aGUgYnVnLgo+ID4gCj4gPiBGaXhlczogMWFlMDE3MjRhZTkyICgiY3hnYml0OiBBYm9y
dCB0aGUgVENQIGNvbm5lY3Rpb24gaW4gY2FzZSBvZiBkYXRhIG91dCB0aW1lb3V0IikKPiA+IFNp
Z25lZC1vZmYtYnk6IER1b21pbmcgWmhvdSA8ZHVvbWluZ0B6anUuZWR1LmNuPgo+ID4gLS0tCj4g
PiAgZHJpdmVycy90YXJnZXQvaXNjc2kvY3hnYml0L2N4Z2JpdF9jbS5jIHwgMiArLQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+ID4gCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy90YXJnZXQvaXNjc2kvY3hnYml0L2N4Z2JpdF9jbS5jIGIvZHJpdmVy
cy90YXJnZXQvaXNjc2kvY3hnYml0L2N4Z2JpdF9jbS5jCj4gPiBpbmRleCAzMzM2ZDJiNzhiZi4u
ZWIzZGE2ZDJjNjIgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3RhcmdldC9pc2NzaS9jeGdiaXQv
Y3hnYml0X2NtLmMKPiA+ICsrKyBiL2RyaXZlcnMvdGFyZ2V0L2lzY3NpL2N4Z2JpdC9jeGdiaXRf
Y20uYwo+ID4gQEAgLTY5Nyw3ICs2OTcsNyBAQCBfX2N4Z2JpdF9hYm9ydF9jb25uKHN0cnVjdCBj
eGdiaXRfc29jayAqY3NrLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQo+ID4gCj4gPiAgdm9pZCBjeGdi
aXRfYWJvcnRfY29ubihzdHJ1Y3QgY3hnYml0X3NvY2sgKmNzaykKPiA+ICB7Cj4gPiAtICAgICAg
IHN0cnVjdCBza19idWZmICpza2IgPSBhbGxvY19za2IoMCwgR0ZQX0tFUk5FTCB8IF9fR0ZQX05P
RkFJTCk7Cj4gPiArICAgICAgIHN0cnVjdCBza19idWZmICpza2IgPSBhbGxvY19za2IoMCwgR0ZQ
X0FUT01JQyB8IF9fR0ZQX05PRkFJTCk7Cj4gPiAKPiA+ICAgICAgICAgY3hnYml0X2dldF9jc2so
Y3NrKTsKPiA+ICAgICAgICAgY3hnYml0X2luaXRfd3Jfd2FpdCgmY3NrLT5jb20ud3Jfd2FpdCk7
Cj4gPiAtLQo+ID4gMi4xNy4xCj4gPgo+IAo+IFRoZSBsYXN0IGxpbmUgaW4gY3hnYml0X2Fib3J0
X2Nvbm4gaXMgY3hnYml0X3dhaXRfZm9yX3JlcGx5KCkgd2hpY2gKPiBhbHNvIHNob3VsZCBub3Qg
YmUgY2FsbGVkIGluIGludGVycnVwdCBjb250ZXh0LgoKSSBhZ3JlZSB3aXRoIHlvdS4KCj4gQW55
d2F5IHRoaXMgaXNzdWUgaXMgbm90IGR1ZSB0byBjeGdiaXQsIGl0IGlzIGNvbW1vbiBmb3IgaVND
U0kgaXRzZWxmOgo+IGlzY3NpdF9jbG9zZV9zZXNzaW9uKCkKPiAgIGlzY3NpdF9mcmVlX2Nvbm5l
Y3Rpb25fcmVjb3ZlcnlfZW50cmllcygpCj4gICAgIGlzY3NpdF9mcmVlX2NtZCgpCj4gICAgICAg
dHJhbnNwb3J0X2dlbmVyaWNfZnJlZV9jbWQoKQo+ICAgICAgICAgdGFyZ2V0X3dhaXRfZnJlZV9j
bWQoKQo+ICAgICAgICAgICB3YWl0X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQoKQoKSSB1bmRlcnN0
YW5kLgoKPiBJTUhPLCB0aGVyZSBpcyBubyByZWFzb24gdG8gY2FsbCBpc2NzaXRfY2xvc2Vfc2Vz
c2lvbiBpbiBhbiBhdG9taWMgY29udGV4dC4KPiBJIGhhdmUgdHdvIHBhdGNoZXMgcmVsYWl0ZWQg
VGltZTJSZXRhaW4gdGltZXIuIEkgd2lsbCBzaGFyZSB0aGVtIHRvZGF5LgoKVGhhdCdzIGdyZWF0
LCB0aGFuayB5b3UhCgpCZXN0IHJlZ2FyZHMsCkR1b21pbmcgWmhvdQo=
