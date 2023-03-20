Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F8A6C0982
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 04:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjCTDzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 23:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjCTDzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 23:55:14 -0400
Received: from 163.com (m12.mail.163.com [220.181.12.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CC231DBA3;
        Sun, 19 Mar 2023 20:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=NoZ6Yv3m5eH5XJcKyA2YOme8UsgLpMm+h1N1F+fx0Jg=; b=m
        1JmAR+SS1nkRLRKRuCvaVNFYLVtAZsmKb+DU64vk7PslFaOAF6FRKFNUJZcObIQ/
        Abd6seucL0xJrkPA98GbOCUpbW/KigSll9Dt5/FJqKXXtfaHSz2jB9NKFjv15JyK
        KRDTaUyxLvE+9c0AT7N7lA3El6l4MaGurJuBtY4Lik=
Received: from zyytlz.wz$163.com ( [111.206.145.21] ) by
 ajax-webmail-wmsvr12 (Coremail) ; Mon, 20 Mar 2023 11:54:27 +0800 (CST)
X-Originating-IP: [111.206.145.21]
Date:   Mon, 20 Mar 2023 11:54:27 +0800 (CST)
From:   =?GBK?B?zfXV9w==?= <zyytlz.wz@163.com>
To:     "Jonathan Cameron" <jic23@kernel.org>
Cc:     eugen.hristev@collabora.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Lars-Peter Clausen" <lars@metafoo.de>, hackerzheng666@gmail.com,
        alex000young@gmail.com, 1395428693sheep@gmail.com
Subject: Re:Re: [PATCH] iio: at91-sama5d2_adc: Fix use after free bug in
 at91_adc_remove due to race condition
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <20230319152222.0b02fb51@jic23-huawei>
References: <20230310091239.1440279-1-zyytlz.wz@163.com>
 <20230318173913.19e8a1b1@jic23-huawei>
 <d62ece80-4d88-36a6-9561-fa0f5afc40c1@metafoo.de>
 <20230319152222.0b02fb51@jic23-huawei>
X-NTES-SC: AL_QuycC/6Tu0wt4SefZ+kXn0oRjuY8XsK3v/kl3YNXP5k0vynH/gsFYl9FHVb32ci2LieikDinXz9i2/5fbZt4RoQ1HuBST22Vvm8uYK7tJP/b
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <275f7404.51b6.186fd27783f.Coremail.zyytlz.wz@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wC3RSXz2BdkPhETAA--.4938W
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiXRM4U1WBo+DaWQAAsx
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKCgoKCgoKCgoKCgoKCkF0IDIwMjMtMDMtMTkgMjI6MjI6MjIsICJKb25hdGhhbiBDYW1lcm9u
IiA8amljMjNAa2VybmVsLm9yZz4gd3JvdGU6Cj5PbiBTYXQsIDE4IE1hciAyMDIzIDEwOjM2OjA0
IC0wNzAwCj5MYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT4gd3JvdGU6Cj4KPj4g
T24gMy8xOC8yMyAxMDozOSwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToKPj4gPiBPbiBGcmksIDEw
IE1hciAyMDIzIDE3OjEyOjM5ICswODAwCj4+ID4gWmhlbmcgV2FuZyA8enl5dGx6Lnd6QDE2My5j
b20+IHdyb3RlOgo+PiA+ICAKPj4gPj4gSW4gYXQ5MV9hZGNfcHJvYmUsICZzdC0+dG91Y2hfc3Qu
d29ya3EgaXMgYm91bmQgd2l0aAo+PiA+PiBhdDkxX2FkY193b3JrcV9oYW5kbGVyLiBUaGVuIGl0
IHdpbGwgYmUgc3RhcnRlZCBieSBpcnEKPj4gPj4gaGFuZGxlciBhdDkxX2FkY190b3VjaF9kYXRh
X2hhbmRsZXIKPj4gPj4KPj4gPj4gSWYgd2UgcmVtb3ZlIHRoZSBkcml2ZXIgd2hpY2ggd2lsbCBj
YWxsIGF0OTFfYWRjX3JlbW92ZQo+PiA+PiAgICB0byBtYWtlIGNsZWFudXAsIHRoZXJlIG1heSBi
ZSBhIHVuZmluaXNoZWQgd29yay4KPj4gPj4KPj4gPj4gVGhlIHBvc3NpYmxlIHNlcXVlbmNlIGlz
IGFzIGZvbGxvd3M6Cj4+ID4+Cj4+ID4+IEZpeCBpdCBieSBmaW5pc2hpbmcgdGhlIHdvcmsgYmVm
b3JlIGNsZWFudXAgaW4gdGhlIGF0OTFfYWRjX3JlbW92ZQo+PiA+Pgo+PiA+PiBDUFUwICAgICAg
ICAgICAgICAgICAgQ1BVMQo+PiA+Pgo+PiA+PiAgICAgICAgICAgICAgICAgICAgICB8YXQ5MV9h
ZGNfd29ya3FfaGFuZGxlcgo+PiA+PiBhdDkxX2FkY19yZW1vdmUgICAgIHwKPj4gPj4gaWlvX2Rl
dmljZV91bnJlZ2lzdGVyfAo+PiA+PiBpaW9fZGV2X3JlbGVhc2UgICAgIHwKPj4gPj4ga2ZyZWUo
aWlvX2Rldl9vcGFxdWUpO3wKPj4gPj4gICAgICAgICAgICAgICAgICAgICAgfAo+PiA+PiAgICAg
ICAgICAgICAgICAgICAgICB8aWlvX3B1c2hfdG9fYnVmZmVycwo+PiA+PiAgICAgICAgICAgICAg
ICAgICAgICB8Jmlpb19kZXZfb3BhcXVlLT5idWZmZXJfbGlzdAo+PiA+PiAgICAgICAgICAgICAg
ICAgICAgICB8Ly91c2UKPj4gPj4gRml4ZXM6IDIzZWMyNzc0ZjFjYyAoImlpbzogYWRjOiBhdDkx
LXNhbWE1ZDJfYWRjOiBhZGQgc3VwcG9ydCBmb3IgcG9zaXRpb24gYW5kIHByZXNzdXJlIGNoYW5u
ZWxzIikKPj4gPj4gU2lnbmVkLW9mZi1ieTogWmhlbmcgV2FuZyA8enl5dGx6Lnd6QDE2My5jb20+
Cj4+ID4+IC0tLQo+PiA+PiAgIGRyaXZlcnMvaWlvL2FkYy9hdDkxLXNhbWE1ZDJfYWRjLmMgfCAy
ICsrCj4+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+PiA+Pgo+PiA+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL2F0OTEtc2FtYTVkMl9hZGMuYyBiL2RyaXZlcnMv
aWlvL2FkYy9hdDkxLXNhbWE1ZDJfYWRjLmMKPj4gPj4gaW5kZXggNTBkMDJlNWZjNmZjLi4xYjk1
ZDE4ZDllMGIgMTAwNjQ0Cj4+ID4+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9hdDkxLXNhbWE1ZDJf
YWRjLmMKPj4gPj4gKysrIGIvZHJpdmVycy9paW8vYWRjL2F0OTEtc2FtYTVkMl9hZGMuYwo+PiA+
PiBAQCAtMjQ5NSw2ICsyNDk1LDggQEAgc3RhdGljIGludCBhdDkxX2FkY19yZW1vdmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikKPj4gPj4gICAJc3RydWN0IGlpb19kZXYgKmluZGlvX2Rl
diA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOwo+PiA+PiAgIAlzdHJ1Y3QgYXQ5MV9hZGNf
c3RhdGUgKnN0ID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsKPj4gPj4gICAKPj4gPj4gKwlkaXNhYmxl
X2lycV9ub3N5bmMoc3QtPmlycSk7Cj4+ID4+ICsJY2FuY2VsX3dvcmtfc3luYygmc3QtPnRvdWNo
X3N0LndvcmtxKTsgIAo+PiA+IEknZCBsaWtlIHNvbWUgaW5wdXQgZm9ybSBzb21lb25lIG1vcmUg
ZmFtaWxpYXIgd2l0aCB0aGlzIGRyaXZlciB0aGFuIEkgYW0uCj4+ID4KPj4gPiBJbiBwYXJ0aWN1
bGFyLCB3aGlsc3QgaXQgZml4ZXMgdGhlIGJ1ZyBzZWVuIEknbSBub3Qgc3VyZSB3aGF0IHRoZSBt
b3N0Cj4+ID4gbG9naWNhbCBvcmRlcmluZyBmb3IgdGhlIGRpc2FibGUgaXMgb3IgdGhlIGJlc3Qg
d2F5IHRvIGRvIGl0Lgo+PiA+Cj4+ID4gSSdkIHByZWZlciB0byBzZWUgdGhlIGlycSBjdXQgb2Zm
IGF0IHNvdXJjZSBieSBkaXNhYmxpbmcgaXQgYXQgdGhlIGRldmljZQo+PiA+IGZlYXR1cmUgdGhh
dCBpcyBnZW5lcmF0aW5nIHRoZSBpcnEgZm9sbG93ZWQgYnkgY2FuY2VsbGluZyBvciB3YWl0aW5n
IGZvcgo+PiA+IGNvbXBsZXRpb24gb2YgYW55IGluIGZsaWdodCB3b3JrLiAgCj4+IFRoZSB1c3Vh
bGx5IHdheSB5b3UnZCBkbyB0aGlzIGJ5IGNhbGxpbmcgZnJlZV9pcnEoKSBiZWZvcmUgdGhlIAo+
PiBjYW5jZWxfd29ya19zeW5jKCkuCj4KPkknZCBnbyBhIGxpdHRsZSBmdXJ0aGVyIHRoYW4gdGhh
dCBhbmQgZGlzYWJsZSB0aGUgaW50ZXJydXB0IHNvdXJjZSBhdCB0aGUKPmRldmljZSAoaWYgcG9z
c2libGUpIHRoZW4gY2FsbCBmcmVlX2lycSgpIHRoZW4gY2FuY2VsX3dvcmtfc3luYygpCj4KPk90
aGVyd2lzZSB0aGUgZGV2aWNlIGlzIG1lcnJpbHkgbW9uaXRvcmluZyBzb21ldGhpbmcgYW5kIGdl
bmVyYXRpbmcgaW50ZXJydXB0cwo+dGhhdCB3ZSBkb24ndCBjYXJlIGFib3V0LiAgTWlnaHQgd2Vs
bCBiZSB3YXN0aW5nIHBvd2VyIGRvaW5nIHRoYXQsIHRob3VnaCBJIGhhdmVuJ3QKPmNoZWNrZWQg
dGhlIGZsb3cgaW4gdGhpcyBwYXJ0aWN1bGFyIGNhc2UuCgo+CgoKCkRlYXIgTGFycy1QZXRlciBD
bGF1c2VuLApUaGFuayB5b3UgZm9yIHlvdXIgcmVzcG9uc2UgdG8gbXkgcXVlc3Rpb24uIEkgYXBw
cmVjaWF0ZSB5b3VyIHN1Z2dlc3Rpb24gdG8gZGlzYWJsZSB0aGUgaW50ZXJydXB0IHNvdXJjZSBh
dCB0aGUgZGV2aWNlIGJlZm9yZSBjYWxsaW5nIGZyZWVfaXJxKCkgYW5kIGNhbmNlbF93b3JrX3N5
bmMoKS4gCkhvd2V2ZXIsIEkgYW0gbm90IHN1cmUgd2hpY2ggc3BlY2lmaWMgZnVuY3Rpb24gdG8g
dXNlIGluIG9yZGVyIHRvIGFjaGlldmUgdGhpcy4gCkNhbiB5b3UgcGxlYXNlIHByb3ZpZGUgbW9y
ZSBpbmZvcm1hdGlvbiBvbiB3aGljaCBmdW5jdGlvbiB0byB1c2UgYW5kIGhvdyB0byB1c2UgaXQ/
CgpUaGFuayB5b3UgdmVyeSBtdWNoIGZvciB5b3VyIGhlbHAuCgpCZXN0IHJlZ2FyZHMsClpoZW5n
IFdhbmcKCj5Kb25hdGhhbgo=
