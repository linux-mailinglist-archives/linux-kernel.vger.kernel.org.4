Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4146C0986
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 04:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjCTD65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 23:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjCTD6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 23:58:54 -0400
Received: from 163.com (m12.mail.163.com [220.181.12.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46DCA1F4A8;
        Sun, 19 Mar 2023 20:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=ghRA+C90vX1ZYTuZtFlOH1voPfmpFTzjKY619ZT9nyM=; b=f
        Bs7EogveCzgDJJbsiYMiQQkcJNMCxVkhGEA6jBb3wk66yVdLEUqCzAVjl3k2gnvO
        VwegpPadYo6rFLSnOUaks9Bciw9EkETgJJaQt6YPrGvfh1151iCu3pCZbQPN56ZT
        Gc8YC3eftUa+7DNGjQtTBpib+94MG3PB9LR019Lz/c=
Received: from zyytlz.wz$163.com ( [111.206.145.21] ) by
 ajax-webmail-wmsvr12 (Coremail) ; Mon, 20 Mar 2023 11:41:27 +0800 (CST)
X-Originating-IP: [111.206.145.21]
Date:   Mon, 20 Mar 2023 11:41:27 +0800 (CST)
From:   =?GBK?B?zfXV9w==?= <zyytlz.wz@163.com>
To:     "Lars-Peter Clausen" <lars@metafoo.de>
Cc:     "Jonathan Cameron" <jic23@kernel.org>, eugen.hristev@collabora.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] iio: at91-sama5d2_adc: Fix use after free bug in
 at91_adc_remove due to race condition
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <d62ece80-4d88-36a6-9561-fa0f5afc40c1@metafoo.de>
References: <20230310091239.1440279-1-zyytlz.wz@163.com>
 <20230318173913.19e8a1b1@jic23-huawei>
 <d62ece80-4d88-36a6-9561-fa0f5afc40c1@metafoo.de>
X-NTES-SC: AL_QuycC/6TvE4j4SKdY+kXn0oRjuY8XsK3v/kl3YNXP5k0vynH/gsFYl9FHVb32ci2LieikDinXz9i2/5fbZt4RoRXKQgTdqlQirHsSO4ZsvUW
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <2fdfc137.4e1c.186fd1b8f5a.Coremail.zyytlz.wz@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wD3qRTn1Rdk1GYSAA--.867W
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiXQs3U1WBo93sHAACsq
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKCgoKCgoKCgoKCgoKCkF0IDIwMjMtMDMtMTkgMDA6MzY6MDQsICJMYXJzLVBldGVyIENsYXVz
ZW4iIDxsYXJzQG1ldGFmb28uZGU+IHdyb3RlOgo+T24gMy8xOC8yMyAxMDozOSwgSm9uYXRoYW4g
Q2FtZXJvbiB3cm90ZToKPj4gT24gRnJpLCAxMCBNYXIgMjAyMyAxNzoxMjozOSArMDgwMAo+PiBa
aGVuZyBXYW5nIDx6eXl0bHoud3pAMTYzLmNvbT4gd3JvdGU6Cj4+Cj4+PiBJbiBhdDkxX2FkY19w
cm9iZSwgJnN0LT50b3VjaF9zdC53b3JrcSBpcyBib3VuZCB3aXRoCj4+PiBhdDkxX2FkY193b3Jr
cV9oYW5kbGVyLiBUaGVuIGl0IHdpbGwgYmUgc3RhcnRlZCBieSBpcnEKPj4+IGhhbmRsZXIgYXQ5
MV9hZGNfdG91Y2hfZGF0YV9oYW5kbGVyCj4+Pgo+Pj4gSWYgd2UgcmVtb3ZlIHRoZSBkcml2ZXIg
d2hpY2ggd2lsbCBjYWxsIGF0OTFfYWRjX3JlbW92ZQo+Pj4gICAgdG8gbWFrZSBjbGVhbnVwLCB0
aGVyZSBtYXkgYmUgYSB1bmZpbmlzaGVkIHdvcmsuCj4+Pgo+Pj4gVGhlIHBvc3NpYmxlIHNlcXVl
bmNlIGlzIGFzIGZvbGxvd3M6Cj4+Pgo+Pj4gRml4IGl0IGJ5IGZpbmlzaGluZyB0aGUgd29yayBi
ZWZvcmUgY2xlYW51cCBpbiB0aGUgYXQ5MV9hZGNfcmVtb3ZlCj4+Pgo+Pj4gQ1BVMCAgICAgICAg
ICAgICAgICAgIENQVTEKPj4+Cj4+PiAgICAgICAgICAgICAgICAgICAgICB8YXQ5MV9hZGNfd29y
a3FfaGFuZGxlcgo+Pj4gYXQ5MV9hZGNfcmVtb3ZlICAgICB8Cj4+PiBpaW9fZGV2aWNlX3VucmVn
aXN0ZXJ8Cj4+PiBpaW9fZGV2X3JlbGVhc2UgICAgIHwKPj4+IGtmcmVlKGlpb19kZXZfb3BhcXVl
KTt8Cj4+PiAgICAgICAgICAgICAgICAgICAgICB8Cj4+PiAgICAgICAgICAgICAgICAgICAgICB8
aWlvX3B1c2hfdG9fYnVmZmVycwo+Pj4gICAgICAgICAgICAgICAgICAgICAgfCZpaW9fZGV2X29w
YXF1ZS0+YnVmZmVyX2xpc3QKPj4+ICAgICAgICAgICAgICAgICAgICAgIHwvL3VzZQo+Pj4gRml4
ZXM6IDIzZWMyNzc0ZjFjYyAoImlpbzogYWRjOiBhdDkxLXNhbWE1ZDJfYWRjOiBhZGQgc3VwcG9y
dCBmb3IgcG9zaXRpb24gYW5kIHByZXNzdXJlIGNoYW5uZWxzIikKPj4+IFNpZ25lZC1vZmYtYnk6
IFpoZW5nIFdhbmcgPHp5eXRsei53ekAxNjMuY29tPgo+Pj4gLS0tCj4+PiAgIGRyaXZlcnMvaWlv
L2FkYy9hdDkxLXNhbWE1ZDJfYWRjLmMgfCAyICsrCj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKykKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL2F0OTEtc2Ft
YTVkMl9hZGMuYyBiL2RyaXZlcnMvaWlvL2FkYy9hdDkxLXNhbWE1ZDJfYWRjLmMKPj4+IGluZGV4
IDUwZDAyZTVmYzZmYy4uMWI5NWQxOGQ5ZTBiIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9paW8v
YWRjL2F0OTEtc2FtYTVkMl9hZGMuYwo+Pj4gKysrIGIvZHJpdmVycy9paW8vYWRjL2F0OTEtc2Ft
YTVkMl9hZGMuYwo+Pj4gQEAgLTI0OTUsNiArMjQ5NSw4IEBAIHN0YXRpYyBpbnQgYXQ5MV9hZGNf
cmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4+PiAgIAlzdHJ1Y3QgaWlvX2Rl
diAqaW5kaW9fZGV2ID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7Cj4+PiAgIAlzdHJ1Y3Qg
YXQ5MV9hZGNfc3RhdGUgKnN0ID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsKPj4+ICAgCj4+PiArCWRp
c2FibGVfaXJxX25vc3luYyhzdC0+aXJxKTsKPj4+ICsJY2FuY2VsX3dvcmtfc3luYygmc3QtPnRv
dWNoX3N0LndvcmtxKTsKPj4gSSdkIGxpa2Ugc29tZSBpbnB1dCBmb3JtIHNvbWVvbmUgbW9yZSBm
YW1pbGlhciB3aXRoIHRoaXMgZHJpdmVyIHRoYW4gSSBhbS4KPj4KPj4gSW4gcGFydGljdWxhciwg
d2hpbHN0IGl0IGZpeGVzIHRoZSBidWcgc2VlbiBJJ20gbm90IHN1cmUgd2hhdCB0aGUgbW9zdAo+
PiBsb2dpY2FsIG9yZGVyaW5nIGZvciB0aGUgZGlzYWJsZSBpcyBvciB0aGUgYmVzdCB3YXkgdG8g
ZG8gaXQuCj4+Cj4+IEknZCBwcmVmZXIgdG8gc2VlIHRoZSBpcnEgY3V0IG9mZiBhdCBzb3VyY2Ug
YnkgZGlzYWJsaW5nIGl0IGF0IHRoZSBkZXZpY2UKPj4gZmVhdHVyZSB0aGF0IGlzIGdlbmVyYXRp
bmcgdGhlIGlycSBmb2xsb3dlZCBieSBjYW5jZWxsaW5nIG9yIHdhaXRpbmcgZm9yCj4+IGNvbXBs
ZXRpb24gb2YgYW55IGluIGZsaWdodCB3b3JrLgo+VGhlIHVzdWFsbHkgd2F5IHlvdSdkIGRvIHRo
aXMgYnkgY2FsbGluZyBmcmVlX2lycSgpIGJlZm9yZSB0aGUgCj5jYW5jZWxfd29ya19zeW5jKCku
CgpIaSwKClRoYW5rIHlvdSBmb3IgeW91ciByZXNwb25zZSBhbmQgZmVlZGJhY2sgb24gbXkgcGF0
Y2guIEkgYXBwcmVjaWF0ZSB5b3VyIGlucHV0IGFuZCB3b3VsZCBsaWtlIHRvIGFkZHJlc3MgeW91
ciBjb25jZXJucy4KClJlZ2FyZGluZyB0aGUgYmVzdCB3YXkgdG8gZGlzYWJsZSB0aGUgSVJRLCBJ
IGFncmVlIHRoYXQgY2FsbGluZyBmcmVlX2lycSgpIGJlZm9yZSBjYW5jZWxfd29ya19zeW5jKCkg
d291bGQgYmUgYSBiZXR0ZXIgYXBwcm9hY2guIFRoaXMgZW5zdXJlcyB0aGF0IHRoZSBJUlEgaXMg
Y29tcGxldGVseSBkaXNhYmxlZCBhdCB0aGUgc291cmNlLCBhbmQgYW55IGluLWZsaWdodCB3b3Jr
IGlzIGZpbmlzaGVkIGJlZm9yZSByZW1vdmluZyB0aGUgZHJpdmVyLiBJIHdpbGwgbWFrZSB0aGlz
IGNoYW5nZSBpbiB0aGUgcGF0Y2guCgpCZXN0IHJlZ2FyZHMsClpoZW5nIFdhbmcKCj4K
