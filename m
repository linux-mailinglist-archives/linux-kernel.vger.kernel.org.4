Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12176C1182
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjCTMIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjCTMIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:08:39 -0400
Received: from 163.com (m12.mail.163.com [220.181.12.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E0592659A;
        Mon, 20 Mar 2023 05:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=any2LG+UghBJpBtb2ma/J/4il5qY3mBNhe3dnfW5z/Q=; b=d
        AcBBvPyUjhVgvrxySDNo1G2N7EEYCzSznCUb45LjeljfW7k0ruM4Yt+QaAHhTJDR
        ShWDEliV92Wk5kQ9Z5PKSWpL1V23wvX0WHBAIZ+Fe85O9ukGN5I9vDxGFrBFvQb8
        WxaEQ4FP5iBKHy5ZPtvPwMByfO0pRn66FmXZWMJjNA=
Received: from zyytlz.wz$163.com ( [111.206.145.21] ) by
 ajax-webmail-wmsvr91 (Coremail) ; Mon, 20 Mar 2023 20:07:52 +0800 (CST)
X-Originating-IP: [111.206.145.21]
Date:   Mon, 20 Mar 2023 20:07:52 +0800 (CST)
From:   =?GBK?B?zfXV9w==?= <zyytlz.wz@163.com>
To:     "Nicolas Ferre" <nicolas.ferre@microchip.com>
Cc:     eugen.hristev@collabora.com, jic23@kernel.org, lars@metafoo.de,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com
Subject: Re:Re: [PATCH] iio: at91-sama5d2_adc: Fix use after free bug in
 at91_adc_remove due to race condition
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <954acc8c-0df3-23a4-7237-ecbc31811a56@microchip.com>
References: <20230310091239.1440279-1-zyytlz.wz@163.com>
 <954acc8c-0df3-23a4-7237-ecbc31811a56@microchip.com>
X-NTES-SC: AL_QuycC/+au0gs5CGYbekXn0oRjuY8XsK3v/kl3YNXP5k0pir36yEsXkV8OHnYzuOSJyqciiKKcSJIxftbZ6pBVLiEa/JRVsfb8BpEatx+iClf
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <2220fb68.10ff7.186feeb3231.Coremail.zyytlz.wz@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wDHza2YTBhkAocUAA--.24180W
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiGhg4U1aEEohinAAAsf
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKCgoKCgoKCgoKCgoKCkF0IDIwMjMtMDMtMjAgMTY6MzU6MjQsICJOaWNvbGFzIEZlcnJlIiA8
bmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tPiB3cm90ZToKPk9uIDEwLzAzLzIwMjMgYXQgMTA6
MTIsIFpoZW5nIFdhbmcgd3JvdGU6Cj4+IEluIGF0OTFfYWRjX3Byb2JlLCAmc3QtPnRvdWNoX3N0
LndvcmtxIGlzIGJvdW5kIHdpdGgKPj4gYXQ5MV9hZGNfd29ya3FfaGFuZGxlci4gVGhlbiBpdCB3
aWxsIGJlIHN0YXJ0ZWQgYnkgaXJxCj4+IGhhbmRsZXIgYXQ5MV9hZGNfdG91Y2hfZGF0YV9oYW5k
bGVyCj4+IAo+PiBJZiB3ZSByZW1vdmUgdGhlIGRyaXZlciB3aGljaCB3aWxsIGNhbGwgYXQ5MV9h
ZGNfcmVtb3ZlCj4+ICAgIHRvIG1ha2UgY2xlYW51cCwgdGhlcmUgbWF5IGJlIGEgdW5maW5pc2hl
ZCB3b3JrLgo+PiAKPj4gVGhlIHBvc3NpYmxlIHNlcXVlbmNlIGlzIGFzIGZvbGxvd3M6Cj4+IAo+
PiBGaXggaXQgYnkgZmluaXNoaW5nIHRoZSB3b3JrIGJlZm9yZSBjbGVhbnVwIGluIHRoZSBhdDkx
X2FkY19yZW1vdmUKPj4gCj4+IENQVTAgICAgICAgICAgICAgICAgICBDUFUxCj4+IAo+PiAgICAg
ICAgICAgICAgICAgICAgICB8YXQ5MV9hZGNfd29ya3FfaGFuZGxlcgo+PiBhdDkxX2FkY19yZW1v
dmUgICAgIHwKPj4gaWlvX2RldmljZV91bnJlZ2lzdGVyfAo+PiBpaW9fZGV2X3JlbGVhc2UgICAg
IHwKPj4ga2ZyZWUoaWlvX2Rldl9vcGFxdWUpO3wKPj4gICAgICAgICAgICAgICAgICAgICAgfAo+
PiAgICAgICAgICAgICAgICAgICAgICB8aWlvX3B1c2hfdG9fYnVmZmVycwo+PiAgICAgICAgICAg
ICAgICAgICAgICB8Jmlpb19kZXZfb3BhcXVlLT5idWZmZXJfbGlzdAo+PiAgICAgICAgICAgICAg
ICAgICAgICB8Ly91c2UKPgo+VGhlcmUgaXMgbm8gc3VjaCB0aGluZyBhcyBhIFNNUCBwbGF0Zm9y
bSB1c2luZyB0aGlzIGRyaXZlciAoeWV0PyksIHNvIHdlIAo+YWdyZWUgdGhhdCB0aGlzIGZpeCBp
cyBwdXJlbHkgdGhlb3JldGljYWwsIGNhbm5vdCBiZSByZXByb2R1Y2VkIG5vciBpdHMgCj5maXgg
dmFsaWRhdGVkLgo+Cj5UaGF0IGJlaW5nIHNhaWQsIEknbSBoYXBweSB0aGF0IGVuaGFuY2VtZW50
cyBhcmUgcHJvdmlkZWQgdG8gdGhpcyAKPmRyaXZlciwgbm8gZG91YnQgYWJvdXQgdGhhdC4KPgoK
SGkgTmljb2xhcywKClRoYW5rcyBmb3IgeW91ciByZXBseS4gSSdtIG5vdCBmYW1pbGlhciB3aXRo
IHRoZSBtb2R1bGUgYW5kIEkgdGhpbmsgeW91J3JlIHJpZ2h0LgoKPgo+PiBGaXhlczogMjNlYzI3
NzRmMWNjICgiaWlvOiBhZGM6IGF0OTEtc2FtYTVkMl9hZGM6IGFkZCBzdXBwb3J0IGZvciBwb3Np
dGlvbiBhbmQgcHJlc3N1cmUgY2hhbm5lbHMiKQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuZyBXYW5n
IDx6eXl0bHoud3pAMTYzLmNvbT4KPj4gLS0tCj4+ICAgZHJpdmVycy9paW8vYWRjL2F0OTEtc2Ft
YTVkMl9hZGMuYyB8IDIgKysKPj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4+
IAo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRjL2F0OTEtc2FtYTVkMl9hZGMuYyBiL2Ry
aXZlcnMvaWlvL2FkYy9hdDkxLXNhbWE1ZDJfYWRjLmMKPj4gaW5kZXggNTBkMDJlNWZjNmZjLi4x
Yjk1ZDE4ZDllMGIgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9hdDkxLXNhbWE1ZDJf
YWRjLmMKPj4gKysrIGIvZHJpdmVycy9paW8vYWRjL2F0OTEtc2FtYTVkMl9hZGMuYwo+PiBAQCAt
MjQ5NSw2ICsyNDk1LDggQEAgc3RhdGljIGludCBhdDkxX2FkY19yZW1vdmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikKPj4gICAgICAgICAgc3RydWN0IGlpb19kZXYgKmluZGlvX2RldiA9
IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOwo+PiAgICAgICAgICBzdHJ1Y3QgYXQ5MV9hZGNf
c3RhdGUgKnN0ID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsKPj4gCj4+ICsgICAgICAgZGlzYWJsZV9p
cnFfbm9zeW5jKHN0LT5pcnEpOwo+PiArICAgICAgIGNhbmNlbF93b3JrX3N5bmMoJnN0LT50b3Vj
aF9zdC53b3JrcSk7Cj4KPkFib3V0IHN0b3BwaW5nIHRoZSBzb3VyY2Ugb2YgaW50ZXJydXB0LCBJ
IHdvdWxkIHJlY29tbWVuZCB1c2luZyBhIAo+c2VxdWVuY2UgYWxyZWFkeSBleHBvc2VkIGluIGF0
OTFfYWRjX2h3X2luaXQgKGFuZCBwb3NzaWJseSBtYWtlIGl0IAo+Y29tbW9uKSwgbGlrZToKPgo+
ICAgIGlmIChzdC0+c29jX2luZm8ucGxhdGZvcm0tPmxheW91dC0+RU9DX0lEUikKPiAgICAgICAg
ICAgIGF0OTFfYWRjX3dyaXRlbChzdCwgRU9DX0lEUiwgMHhmZmZmZmZmZik7Cj4gICAgYXQ5MV9h
ZGNfd3JpdGVsKHN0LCBJRFIsIDB4ZmZmZmZmZmYpOwo+CgpUaGFua3MgZm91IHlvdXIgYWR2aWNl
LiBJJ2xsIGFwcGx5IGl0IGluIHRoZSBuZXh0IHZlcnNpb24uCgpCZXN0IHJlZ2FyZHMsClpoZW5n
Cgo+UmVnYXJkcywKPiAgIE5pY29sYXMKPgo+PiAgICAgICAgICBpaW9fZGV2aWNlX3VucmVnaXN0
ZXIoaW5kaW9fZGV2KTsKPj4gCj4+ICAgICAgICAgIGF0OTFfYWRjX2RtYV9kaXNhYmxlKHN0KTsK
Pj4gLS0KPj4gMi4yNS4xCj4+IAo+Cj4tLSAKPk5pY29sYXMgRmVycmUK
