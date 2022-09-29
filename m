Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0345EF0B3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbiI2Ii7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbiI2Ii5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:38:57 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E5A9132FC2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:38:55 -0700 (PDT)
Received: from chenhuacai$loongson.cn ( [112.20.108.220] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Thu, 29 Sep 2022 16:38:48
 +0800 (GMT+08:00)
X-Originating-IP: [112.20.108.220]
Date:   Thu, 29 Sep 2022 16:38:48 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>
To:     maobibo <maobibo@loongson.cn>
Cc:     "Qi Zheng" <zhengqi.arch@bytedance.com>,
        "David Hildenbrand" <david@redhat.com>, akpm@linux-foundation.org,
        muchun.song@linux.dev, chris@zankel.net, jcmvbkbc@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Muchun Song" <songmuchun@bytedance.com>
Subject: Re: Re: [PATCH v2] mm: use update_mmu_tlb() on the second thread
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220411(feba7c69)
 Copyright (c) 2002-2022 www.mailtech.cn .loongson.cn
In-Reply-To: <24f6df23-82cc-1290-e015-cba2a284e060@loongson.cn>
References: <20220926115621.13849-1-zhengqi.arch@bytedance.com>
 <b5823e18-6139-c16e-a2df-1aa3e88927fa@redhat.com>
 <c41a3cb6-aef9-d8a9-ab0b-b9c8013ee1d8@bytedance.com>
 <e5cd4c46-71fd-8edb-098c-2ac839d5c5d2@loongson.cn>
 <d4e4a362-fbf2-7eea-e021-16ae7782e06e@bytedance.com>
 <24f6df23-82cc-1290-e015-cba2a284e060@loongson.cn>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: Khox42Zvb3Rlcl90eHQ9Mjk0MTo2MTI=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <b702cc9.d17c.1838865fb5c.Coremail.chenhuacai@loongson.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAf8Axk+GYWTVjLrEjAA--.7729W
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/1tbiAQAEBmM0OV4TRAABsl
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

SGksIGFsbCwKCgo+IC0tLS0t5Y6f5aeL6YKu5Lu2LS0tLS0KPiDlj5Hku7bkuro6IG1hb2JpYm8g
PG1hb2JpYm9AbG9vbmdzb24uY24+Cj4g5Y+R6YCB5pe26Ze0OjIwMjItMDktMjkgMTI6MDU6MzMg
KOaYn+acn+WbmykKPiDmlLbku7bkuro6ICJRaSBaaGVuZyIgPHpoZW5ncWkuYXJjaEBieXRlZGFu
Y2UuY29tPiwgIkRhdmlkIEhpbGRlbmJyYW5kIiA8ZGF2aWRAcmVkaGF0LmNvbT4sIGFrcG1AbGlu
dXgtZm91bmRhdGlvbi5vcmcsIG11Y2h1bi5zb25nQGxpbnV4LmRldiwgIumZiOWNjuaJjSIgPGNo
ZW5odWFjYWlAbG9vbmdzb24uY24+Cj4g5oqE6YCBOiBjaHJpc0B6YW5rZWwubmV0LCBqY212Ymti
Y0BnbWFpbC5jb20sIGxpbnV4LW1tQGt2YWNrLm9yZywgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZywgIk11Y2h1biBTb25nIiA8c29uZ211Y2h1bkBieXRlZGFuY2UuY29tPgo+IOS4u+mimDog
UmU6IFtQQVRDSCB2Ml0gbW06IHVzZSB1cGRhdGVfbW11X3RsYigpIG9uIHRoZSBzZWNvbmQgdGhy
ZWFkCj4gCj4gCj4gCj4g5ZyoIDIwMjIvOS8yOSAxMTo0NywgUWkgWmhlbmcg5YaZ6YGTOgo+ID4g
Cj4gPiAKPiA+IE9uIDIwMjIvOS8yOSAxMToyNywgbWFvYmlibyB3cm90ZToKPiA+PiDlnKggMjAy
Mi85LzI5IDExOjA3LCBRaSBaaGVuZyDlhpnpgZM6Cj4gPj4+Cj4gPj4+Cj4gPj4+IE9uIDIwMjIv
OS8yNiAyMjozNCwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6Cj4gPj4+PiBPbiAyNi4wOS4yMiAx
Mzo1NiwgUWkgWmhlbmcgd3JvdGU6Cj4gPj4+Pj4gQXMgbWVzc2FnZSBpbiBjb21taXQgN2RmNjc2
OTc0MzU5ICgibW0vbWVtb3J5LmM6IFVwZGF0ZSBsb2NhbCBUTEIKPiA+Pj4+PiBpZiBQVEUgZW50
cnkgZXhpc3RzIikgc2FpZCwgd2Ugc2hvdWxkIHVwZGF0ZSBsb2NhbCBUTEIgb25seSBvbiB0aGUK
PiA+Pj4+PiBzZWNvbmQgdGhyZWFkLiBTbyBpbiB0aGUgZG9fYW5vbnltb3VzX3BhZ2UoKSBoZXJl
LCB3ZSBzaG91bGQgdXNlCj4gPj4+Pj4gdXBkYXRlX21tdV90bGIoKSBpbnN0ZWFkIG9mIHVwZGF0
ZV9tbXVfY2FjaGUoKSBvbiB0aGUgc2Vjb25kIHRocmVhZC4KPiA+Pj4+Pgo+ID4+Pj4+IFNpZ25l
ZC1vZmYtYnk6IFFpIFpoZW5nIDx6aGVuZ3FpLmFyY2hAYnl0ZWRhbmNlLmNvbT4KPiA+Pj4+PiBS
ZXZpZXdlZC1ieTogTXVjaHVuIFNvbmcgPHNvbmdtdWNodW5AYnl0ZWRhbmNlLmNvbT4KPiA+Pj4+
PiAtLS0KPiA+Pj4+PiB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIyMDkyNDA1
MzIzOS45MTY2MS0xLXpoZW5ncWkuYXJjaEBieXRlZGFuY2UuY29tLwo+ID4+Pj4+Cj4gPj4+Pj4g
Q2hhbmdlbG9nIGluIHYxIC0+IHYyOgo+ID4+Pj4+IMKgwqAgLSBjaGFuZ2UgdGhlIHN1YmplY3Qg
YW5kIGNvbW1pdCBtZXNzYWdlIChEYXZpZCkKPiA+Pj4+Pgo+ID4+Pj4+IMKgwqAgbW0vbWVtb3J5
LmMgfCAyICstCj4gPj4+Pj4gwqDCoCAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkKPiA+Pj4+Pgo+ID4+Pj4+IGRpZmYgLS1naXQgYS9tbS9tZW1vcnkuYyBiL21t
L21lbW9yeS5jCj4gPj4+Pj4gaW5kZXggMTE4ZTVmMDIzNTk3Li45ZTExYzc4M2JhMGUgMTAwNjQ0
Cj4gPj4+Pj4gLS0tIGEvbW0vbWVtb3J5LmMKPiA+Pj4+PiArKysgYi9tbS9tZW1vcnkuYwo+ID4+
Pj4+IEBAIC00MTIyLDcgKzQxMjIsNyBAQCBzdGF0aWMgdm1fZmF1bHRfdCBkb19hbm9ueW1vdXNf
cGFnZShzdHJ1Y3Qgdm1fZmF1bHQgKnZtZikKPiA+Pj4+PiDCoMKgwqDCoMKgwqAgdm1mLT5wdGUg
PSBwdGVfb2Zmc2V0X21hcF9sb2NrKHZtYS0+dm1fbW0sIHZtZi0+cG1kLCB2bWYtPmFkZHJlc3Ms
Cj4gPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmdm1mLT5wdGwpOwo+ID4+Pj4+
IMKgwqDCoMKgwqDCoCBpZiAoIXB0ZV9ub25lKCp2bWYtPnB0ZSkpIHsKPiA+Pj4+PiAtwqDCoMKg
wqDCoMKgwqAgdXBkYXRlX21tdV9jYWNoZSh2bWEsIHZtZi0+YWRkcmVzcywgdm1mLT5wdGUpOwo+
ID4+Pj4+ICvCoMKgwqDCoMKgwqDCoCB1cGRhdGVfbW11X3RsYih2bWEsIHZtZi0+YWRkcmVzcywg
dm1mLT5wdGUpOwo+ID4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gcmVsZWFzZTsKPiA+
Pj4+PiDCoMKgwqDCoMKgwqAgfQo+ID4+Pj4KPiA+Pj4+Cj4gPj4+PiBTdGFyaW5nIGF0IDdkZjY3
Njk3NDM1OSwgaXQgaW5kZWVkIGxvb2tzIGxpa2UgYW4gYWNjaWRlbnRhbCB1c2UgW25vdGhpbmcg
ZWxzZSBpbiB0aGF0IHBhdGNoIHVzZXMgdXBkYXRlX21tdV9jYWNoZV0uCj4gPj4+Pgo+ID4+Pj4g
U28gaXQgbG9va3MgZ29vZCB0byBtZSwgYnV0IGEgY29uZmlybWF0aW9uIGZyb20gQmlibyBNYW8g
bWlnaHQgYmUgZ29vZC4KPiA+Pj4KPiA+Pj4gVGhhbmtzLCBhbmQgSGkgQmlibywgYW55IGNvbW1l
bnRzIGhlcmU/IDopCj4gPj4KPiA+PiB1cGRhdGVfbW11X3RsYiBpcyBkZWZpbmVkIGFzIGVtcHR5
IG9uIGxvb25nYXJjaCwgbWF5YmUgc29tZSBsaW5lcyBzaG91bGQKPiA+PiBiZSBhZGRlZCBpbiBm
aWxlIGFyY2gvbG9vbmdhcmNoL2luY2x1ZGUvYXNtL3BndGFibGUuaCBsaWtlIHRoaXM6Cj4gPiAK
PiA+IFNlZW1zIGxpa2UgYSBidWc/IEJlY2F1c2UgdGhlcmUgYXJlIG1hbnkgb3RoZXIgcGxhY2Vz
IHdoZXJlCj4gPiB1cGRhdGVfbW11X3RsYigpIGlzIGNhbGxlZC4KPiA+IAo+ID4+Cj4gPj4gKyNk
ZWZpbmUgX19IQVZFX0FSQ0hfVVBEQVRFX01NVV9UTEIKPiA+PiArI2RlZmluZSB1cGRhdGVfbW11
X3RsYsKgIHVwZGF0ZV9tbXVfY2FjaGUKPiA+IAo+ID4gSWYgc28sIEkgY2FuIG1ha2UgdGhlIGFi
b3ZlIGFzIGEgc2VwYXJhdGUgZml4IHBhdGNoLgo+IEl0IHNvdW5kcyBnb29kIHRvIG1lLiAgCj4g
Cj4gSHVhY2FpLCBkbyB5b3UgaGF2ZSBhbnkgY29tbWVudHM/CkZyb20gbXkgcG9pbnQgb2Ygdmll
dywgTG9vbmdBcmNoIG5lZWQgYSBmaXggZm9yIHRoaXMuCgpIdWFjYWkKPiAKPiByZWdhcmRzCj4g
YmlibywgbWFvCj4gPiAKPiA+IFRoYW5rcywKPiA+IFFpCj4gPiAKPiA+Pgo+ID4+IHJlZ2FyZHMK
PiA+PiBiaWJvIG1hbwo+ID4+Pgo+ID4+Pj4KPiA+Pj4KPiA+Pgo+ID4gCg0KDQrmnKzpgq7ku7bl
j4rlhbbpmYTku7blkKvmnInpvpnoiq/kuK3np5HnmoTllYbkuJrnp5jlr4bkv6Hmga/vvIzku4Xp
mZDkuo7lj5HpgIHnu5nkuIrpnaLlnLDlnYDkuK3liJflh7rnmoTkuKrkurrmiJbnvqTnu4TjgILn
poHmraLku7vkvZXlhbbku5bkurrku6Xku7vkvZXlvaLlvI/kvb/nlKjvvIjljIXmi6zkvYbkuI3p
mZDkuo7lhajpg6jmiJbpg6jliIblnLDms4TpnLLjgIHlpI3liLbmiJbmlaPlj5HvvInmnKzpgq7k
u7blj4rlhbbpmYTku7bkuK3nmoTkv6Hmga/jgILlpoLmnpzmgqjplJnmlLbmnKzpgq7ku7bvvIzo
r7fmgqjnq4vljbPnlLXor53miJbpgq7ku7bpgJrnn6Xlj5Hku7bkurrlubbliKDpmaTmnKzpgq7k
u7bjgIIgDQpUaGlzIGVtYWlsIGFuZCBpdHMgYXR0YWNobWVudHMgY29udGFpbiBjb25maWRlbnRp
YWwgaW5mb3JtYXRpb24gZnJvbSBMb29uZ3NvbiBUZWNobm9sb2d5ICwgd2hpY2ggaXMgaW50ZW5k
ZWQgb25seSBmb3IgdGhlIHBlcnNvbiBvciBlbnRpdHkgd2hvc2UgYWRkcmVzcyBpcyBsaXN0ZWQg
YWJvdmUuIEFueSB1c2Ugb2YgdGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBoZXJlaW4gaW4gYW55
IHdheSAoaW5jbHVkaW5nLCBidXQgbm90IGxpbWl0ZWQgdG8sIHRvdGFsIG9yIHBhcnRpYWwgZGlz
Y2xvc3VyZSwgcmVwcm9kdWN0aW9uIG9yIGRpc3NlbWluYXRpb24pIGJ5IHBlcnNvbnMgb3RoZXIg
dGhhbiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpIGlzIHByb2hpYml0ZWQuIElmIHlvdSByZWNl
aXZlIHRoaXMgZW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBieSBwaG9u
ZSBvciBlbWFpbCBpbW1lZGlhdGVseSBhbmQgZGVsZXRlIGl0LiA=
