Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115346D59DF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbjDDHmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbjDDHmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:42:19 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BD010FF;
        Tue,  4 Apr 2023 00:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1680594132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qOZ8v52pVL5DD+Gn0MGYLxezIgSQkcNGsAlQQVJ5uHQ=;
        b=rczpZOCJplcg3kGUzumWu10j9pyrmtEYX0tOTEJGulUwch5PZbja4Y7k1nGSFPmkOAuUec
        LmPGA1KUU98IXrRquU315uAcPDBJOcbEcGh3JgYfgm30xhfTgME9c6io7kooRf0O44FfJ7
        axFFQyms00TieZjobmvfgM8I9oqO6yw=
Message-ID: <c9c9fa881aeda36862d0ad8c5a46472e0e363531.camel@crapouillou.net>
Subject: Re: [PATCH v3 01/11] dmaengine: Add API function
 dmaengine_prep_slave_dma_array()
From:   Paul Cercueil <paul@crapouillou.net>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vinod Koul <vkoul@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Date:   Tue, 04 Apr 2023 09:42:11 +0200
In-Reply-To: <20230404015944.502-1-hdanton@sina.com>
References: <20230403154800.215924-1-paul@crapouillou.net>
         <20230404015944.502-1-hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSGlsbGYsCgpMZSBtYXJkaSAwNCBhdnJpbCAyMDIzIMOgIDA5OjU5ICswODAwLCBIaWxsZiBE
YW50b24gYSDDqWNyaXTCoDoKPiBPbiAzIEFwciAyMDIzIDE3OjQ3OjUwICswMjAwIFBhdWwgQ2Vy
Y3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0Pgo+ID4gVGhpcyBmdW5jdGlvbiBjYW4gYmUgdXNl
ZCB0byBpbml0aWF0ZSBhIHNjYXR0ZXItZ2F0aGVyIERNQSB0cmFuc2Zlcgo+ID4gd2hlcmUgdGhl
IERNQSBhZGRyZXNzZXMgYW5kIGxlbmd0aHMgYXJlIGxvY2F0ZWQgaW5zaWRlIGFycmF5cy4KPiA+
IAo+ID4gVGhlIG1ham9yIGRpZmZlcmVuY2Ugd2l0aCBkbWFlbmdpbmVfcHJlcF9zbGF2ZV9zZygp
IGlzIHRoYXQgaXQKPiA+IHN1cHBvcnRzCj4gPiBzcGVjaWZ5aW5nIHRoZSBsZW5ndGhzIG9mIGVh
Y2ggRE1BIHRyYW5zZmVyOyBhcyB0cnlpbmcgdG8gb3ZlcnJpZGUKPiA+IHRoZQo+ID4gbGVuZ3Ro
IG9mIHRoZSB0cmFuc2ZlciB3aXRoIGRtYWVuZ2luZV9wcmVwX3NsYXZlX3NnKCkgaXMgYSB2ZXJ5
Cj4gPiB0ZWRpb3VzCj4gPiBwcm9jZXNzLiBUaGUgaW50cm9kdWN0aW9uIG9mIGEgbmV3IEFQSSBm
dW5jdGlvbiBpcyBhbHNvIGp1c3RpZmllZAo+ID4gYnkgdGhlCj4gPiBmYWN0IHRoYXQgc2NhdHRl
cmxpc3RzIGFyZSBvbiB0aGVpciB3YXkgb3V0Lgo+IAo+IEdpdmVuIHNnJ3Mgd2F5b3V0IGFuZCBj
b25jZXB0dWFsbHkgaW92ZWMgYW5kIGt2ZWMgKGluCj4gaW5jbHVkZS9saW51eC91aW8uaCksCj4g
d2hhdCB5b3UgYWRkIHNob3VsZCBoYXZlIGJlZW4gZG1hX3ZlYyB0byBlYXNlIHBlb3BsZSBtYWtp
bmcgdXNlIG9mCj4gaXQuCj4gCj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBkbWFfdmVjIHsKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRtYV9hZGRyX3TCoMKgwqDCoMKgwqBhZGRy
Owo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc2l6ZV90wqDCoMKgwqDCoMKgwqDC
oMKgwqBsZW47Cj4gwqDCoMKgwqDCoMKgwqDCoH07CgpXZWxsIGl0J3Mgbm90IHRvbyBsYXRlIDsp
CgpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4KCkNoZWVycywKLVBhdWwKCj4gPiAKPiA+IFNpZ25l
ZC1vZmYtYnk6IFBhdWwgQ2VyY3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0Pgo+ID4gCj4gPiAt
LS0KPiA+IHYzOiBOZXcgcGF0Y2gKPiA+IC0tLQo+ID4gwqBpbmNsdWRlL2xpbnV4L2RtYWVuZ2lu
ZS5oIHwgMTYgKysrKysrKysrKysrKysrKwo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0
aW9ucygrKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9kbWFlbmdpbmUuaCBi
L2luY2x1ZGUvbGludXgvZG1hZW5naW5lLmgKPiA+IGluZGV4IGMzNjU2ZTU5MDIxMy4uNjJlZmEy
OGMwMDlhIDEwMDY0NAo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9kbWFlbmdpbmUuaAo+ID4gKysr
IGIvaW5jbHVkZS9saW51eC9kbWFlbmdpbmUuaAo+ID4gQEAgLTkxMiw2ICs5MTIsMTEgQEAgc3Ry
dWN0IGRtYV9kZXZpY2Ugewo+ID4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBkbWFfYXN5bmNfdHhf
ZGVzY3JpcHRvcgo+ID4gKigqZGV2aWNlX3ByZXBfZG1hX2ludGVycnVwdCkoCj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBkbWFfY2hhbiAqY2hhbiwgdW5zaWduZWQg
bG9uZyBmbGFncyk7Cj4gPiDCoAo+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGRtYV9hc3luY190
eF9kZXNjcmlwdG9yCj4gPiAqKCpkZXZpY2VfcHJlcF9zbGF2ZV9kbWFfYXJyYXkpKAo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBkbWFfY2hhbiAqY2hhbiwgZG1hX2Fk
ZHJfdCAqYWRkcnMsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc2l6ZV90ICps
ZW5ndGhzLCBzaXplX3QgbmIsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZW51
bSBkbWFfdHJhbnNmZXJfZGlyZWN0aW9uIGRpcmVjdGlvbiwKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBsb25nIGZsYWdzKTsKPiAKPiBUaGVuIHRoZSBjYWxsYmFj
ayBsb29rcyBsaWtlCj4gCj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBkbWFfYXN5bmNfdHhfZGVz
Y3JpcHRvciAqKCpkZXZpY2VfcHJlcF9zbGF2ZV92ZWMpKAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgc3RydWN0IGRtYV9jaGFuICpjaGFuLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgc3RydWN0IGRtYV92ZWMgKnZlYywKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGludCBudmVjLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZW51
bSBkbWFfdHJhbnNmZXJfZGlyZWN0aW9uIGRpcmVjdGlvbiwKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHVuc2lnbmVkIGxvbmcgZmxhZ3MpOwoK

