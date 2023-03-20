Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4706C0984
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 04:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjCTD6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 23:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjCTD6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 23:58:00 -0400
Received: from 163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AD8AD51F;
        Sun, 19 Mar 2023 20:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=/gLyn9NgV9a5Loqbhm+Q8jjDGShVTpb10p5zf1UgHHo=; b=L
        gEg7qg3I4NUN8/U4j4mPZ0Fnm6geYv4aYGqM5iOmClZFr0r51oPwopcSl1JT75Qn
        pTj8HBrp+SoIG7n9rrGHHJSwkWel4th4VmOyGjxJ9Yha7EEYlzVwux05vVvRErnv
        LonaVfYC6yUZuegOgu/bnzk7+lM5CrnJTonRUH3AV0=
Received: from zyytlz.wz$163.com ( [111.206.145.21] ) by
 ajax-webmail-wmsvr12 (Coremail) ; Mon, 20 Mar 2023 11:40:28 +0800 (CST)
X-Originating-IP: [111.206.145.21]
Date:   Mon, 20 Mar 2023 11:40:28 +0800 (CST)
From:   =?GBK?B?zfXV9w==?= <zyytlz.wz@163.com>
To:     "Jonathan Cameron" <jic23@kernel.org>
Cc:     eugen.hristev@collabora.com, lars@metafoo.de,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] iio: at91-sama5d2_adc: Fix use after free bug in
 at91_adc_remove due to race condition
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <20230318173913.19e8a1b1@jic23-huawei>
References: <20230310091239.1440279-1-zyytlz.wz@163.com>
 <20230318173913.19e8a1b1@jic23-huawei>
X-NTES-SC: AL_QuycC/6TvE4p7iWYZOkXn0oRjuY8XsK3v/kl3YNXP5k0vynH/gsFYl9FHVb32ci2LieikDinXz9i2/5fbZt4RoS8WqxpNClyu2Lf2aqKoHtC
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <6c72d3e3.4dde.186fd1aa9d7.Coremail.zyytlz.wz@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wAntSSs1RdkZvwSAA--.12543W
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiXQs3U1WBo93sHAABsp
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKCgoKCgoKCgoKCgoKCkF0IDIwMjMtMDMtMTkgMDA6Mzk6MTMsICJKb25hdGhhbiBDYW1lcm9u
IiA8amljMjNAa2VybmVsLm9yZz4gd3JvdGU6Cj5PbiBGcmksIDEwIE1hciAyMDIzIDE3OjEyOjM5
ICswODAwCj5aaGVuZyBXYW5nIDx6eXl0bHoud3pAMTYzLmNvbT4gd3JvdGU6Cj4KPj4gSW4gYXQ5
MV9hZGNfcHJvYmUsICZzdC0+dG91Y2hfc3Qud29ya3EgaXMgYm91bmQgd2l0aAo+PiBhdDkxX2Fk
Y193b3JrcV9oYW5kbGVyLiBUaGVuIGl0IHdpbGwgYmUgc3RhcnRlZCBieSBpcnEKPj4gaGFuZGxl
ciBhdDkxX2FkY190b3VjaF9kYXRhX2hhbmRsZXIKPj4gCj4+IElmIHdlIHJlbW92ZSB0aGUgZHJp
dmVyIHdoaWNoIHdpbGwgY2FsbCBhdDkxX2FkY19yZW1vdmUKPj4gICB0byBtYWtlIGNsZWFudXAs
IHRoZXJlIG1heSBiZSBhIHVuZmluaXNoZWQgd29yay4KPj4gCj4+IFRoZSBwb3NzaWJsZSBzZXF1
ZW5jZSBpcyBhcyBmb2xsb3dzOgo+PiAKPj4gRml4IGl0IGJ5IGZpbmlzaGluZyB0aGUgd29yayBi
ZWZvcmUgY2xlYW51cCBpbiB0aGUgYXQ5MV9hZGNfcmVtb3ZlCj4+IAo+PiBDUFUwICAgICAgICAg
ICAgICAgICAgQ1BVMQo+PiAKPj4gICAgICAgICAgICAgICAgICAgICB8YXQ5MV9hZGNfd29ya3Ff
aGFuZGxlcgo+PiBhdDkxX2FkY19yZW1vdmUgICAgIHwKPj4gaWlvX2RldmljZV91bnJlZ2lzdGVy
fAo+PiBpaW9fZGV2X3JlbGVhc2UgICAgIHwKPj4ga2ZyZWUoaWlvX2Rldl9vcGFxdWUpO3wKPj4g
ICAgICAgICAgICAgICAgICAgICB8Cj4+ICAgICAgICAgICAgICAgICAgICAgfGlpb19wdXNoX3Rv
X2J1ZmZlcnMKPj4gICAgICAgICAgICAgICAgICAgICB8Jmlpb19kZXZfb3BhcXVlLT5idWZmZXJf
bGlzdAo+PiAgICAgICAgICAgICAgICAgICAgIHwvL3VzZQo+PiBGaXhlczogMjNlYzI3NzRmMWNj
ICgiaWlvOiBhZGM6IGF0OTEtc2FtYTVkMl9hZGM6IGFkZCBzdXBwb3J0IGZvciBwb3NpdGlvbiBh
bmQgcHJlc3N1cmUgY2hhbm5lbHMiKQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuZyBXYW5nIDx6eXl0
bHoud3pAMTYzLmNvbT4KPj4gLS0tCj4+ICBkcml2ZXJzL2lpby9hZGMvYXQ5MS1zYW1hNWQyX2Fk
Yy5jIHwgMiArKwo+PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+PiAKPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy9hdDkxLXNhbWE1ZDJfYWRjLmMgYi9kcml2ZXJzL2lp
by9hZGMvYXQ5MS1zYW1hNWQyX2FkYy5jCj4+IGluZGV4IDUwZDAyZTVmYzZmYy4uMWI5NWQxOGQ5
ZTBiIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvYXQ5MS1zYW1hNWQyX2FkYy5jCj4+
ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9hdDkxLXNhbWE1ZDJfYWRjLmMKPj4gQEAgLTI0OTUsNiAr
MjQ5NSw4IEBAIHN0YXRpYyBpbnQgYXQ5MV9hZGNfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYpCj4+ICAJc3RydWN0IGlpb19kZXYgKmluZGlvX2RldiA9IHBsYXRmb3JtX2dldF9k
cnZkYXRhKHBkZXYpOwo+PiAgCXN0cnVjdCBhdDkxX2FkY19zdGF0ZSAqc3QgPSBpaW9fcHJpdihp
bmRpb19kZXYpOwo+PiAgCj4+ICsJZGlzYWJsZV9pcnFfbm9zeW5jKHN0LT5pcnEpOwo+PiArCWNh
bmNlbF93b3JrX3N5bmMoJnN0LT50b3VjaF9zdC53b3JrcSk7Cj4KPkknZCBsaWtlIHNvbWUgaW5w
dXQgZm9ybSBzb21lb25lIG1vcmUgZmFtaWxpYXIgd2l0aCB0aGlzIGRyaXZlciB0aGFuIEkgYW0u
Cj4KPkluIHBhcnRpY3VsYXIsIHdoaWxzdCBpdCBmaXhlcyB0aGUgYnVnIHNlZW4gSSdtIG5vdCBz
dXJlIHdoYXQgdGhlIG1vc3QKPmxvZ2ljYWwgb3JkZXJpbmcgZm9yIHRoZSBkaXNhYmxlIGlzIG9y
IHRoZSBiZXN0IHdheSB0byBkbyBpdC4KPgo+SSdkIHByZWZlciB0byBzZWUgdGhlIGlycSBjdXQg
b2ZmIGF0IHNvdXJjZSBieSBkaXNhYmxpbmcgaXQgYXQgdGhlIGRldmljZQo+ZmVhdHVyZSB0aGF0
IGlzIGdlbmVyYXRpbmcgdGhlIGlycSBmb2xsb3dlZCBieSBjYW5jZWxsaW5nIG9yIHdhaXRpbmcg
Zm9yCj5jb21wbGV0aW9uIG9mIGFueSBpbiBmbGlnaHQgd29yay4KCkhpLAoKU29ycnkgZm9yIG15
IGxhdGUgcmVwbHkuIEkgdGhpbmsgd2UgbmVlZCB0byByZXBsYWNlIGRpc2FibGVfaXJxX25vc3lu
YyB3aXRoIGZyZWVfaXJxLgoKVGhhbmtzLApaaGVuZwoKPgo+PiAgCWlpb19kZXZpY2VfdW5yZWdp
c3RlcihpbmRpb19kZXYpOwo+PiAgCj4+ICAJYXQ5MV9hZGNfZG1hX2Rpc2FibGUoc3QpOwo=
