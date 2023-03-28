Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018196CBE15
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjC1LuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbjC1LuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:50:01 -0400
X-Greylist: delayed 601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Mar 2023 04:50:00 PDT
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4966A75;
        Tue, 28 Mar 2023 04:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1680003594;
        bh=SzulNji4opou7lgojxtUyQ4UHhhPqbMH3w+G5a9zDiw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LCrSQT3N3+FNICWBBgk+C37FnzNTqIDN30fvbnD1v1F/wEXmFONCcGPeaOHokHNiS
         SU7Kiubj/PG+DiIPUFyeKzp+DL14tKhWjyArBVVqsShWBLwTbCCCBVzsbTrMTMXEfW
         /MDuzO/aIrSZjmB2lKjG2E4qVi6bMPUPQ0J6OBq4=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 6E7A365BFC;
        Tue, 28 Mar 2023 07:39:45 -0400 (EDT)
Message-ID: <9817aaa043e9f0ed964bd523773447bd64f6e2c0.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Add kernel address sanitizer support
From:   Xi Ruoyao <xry111@xry111.site>
To:     Qing Zhang <zhangqing@loongson.cn>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Huacai Chen <chenhuacai@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Tue, 28 Mar 2023 19:39:42 +0800
In-Reply-To: <20230328111714.2056-1-zhangqing@loongson.cn>
References: <20230328111714.2056-1-zhangqing@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTAzLTI4IGF0IDE5OjE3ICswODAwLCBRaW5nIFpoYW5nIHdyb3RlOgoKLyog
c25pcCAqLwoKCj4gLXZvaWQgKiBfX2luaXQgcmVsb2NhdGVfa2VybmVsKHZvaWQpCj4gK3Vuc2ln
bmVkIGxvbmcgX19pbml0IHJlbG9jYXRlX2tlcm5lbCh2b2lkKQoKV2h5IHdlIG11c3QgbW9kaWZ5
IHJlbG9jYXRlX2tlcm5lbCBmb3IgS0FTQU4/Cgo+IMKgewo+IMKgwqDCoMKgwqDCoMKgwqB1bnNp
Z25lZCBsb25nIGtlcm5lbF9sZW5ndGg7Cj4gwqDCoMKgwqDCoMKgwqDCoHVuc2lnbmVkIGxvbmcg
cmFuZG9tX29mZnNldCA9IDA7Cj4gwqDCoMKgwqDCoMKgwqDCoHZvaWQgKmxvY2F0aW9uX25ldyA9
IF90ZXh0OyAvKiBEZWZhdWx0IHRvIG9yaWdpbmFsIGtlcm5lbCBzdGFydCAqLwo+IC3CoMKgwqDC
oMKgwqDCoHZvaWQgKmtlcm5lbF9lbnRyeSA9IHN0YXJ0X2tlcm5lbDsgLyogRGVmYXVsdCB0byBv
cmlnaW5hbCBrZXJuZWwgZW50cnkgcG9pbnQgKi8KPiDCoMKgwqDCoMKgwqDCoMKgY2hhciAqY21k
bGluZSA9IGVhcmx5X2lvcmVtYXAoZndfYXJnMSwgQ09NTUFORF9MSU5FX1NJWkUpOyAvKiBCb290
IGNvbW1hbmQgbGluZSBpcyBwYXNzZWQgaW4gZndfYXJnMSAqLwo+IMKgCj4gwqDCoMKgwqDCoMKg
wqDCoHN0cnNjcHkoYm9vdF9jb21tYW5kX2xpbmUsIGNtZGxpbmUsIENPTU1BTkRfTElORV9TSVpF
KTsKPiBAQCAtMTkwLDkgKzE4OSw2IEBAIHZvaWQgKiBfX2luaXQgcmVsb2NhdGVfa2VybmVsKHZv
aWQpCj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlbG9jX29mZnNldCAr
PSByYW5kb21fb2Zmc2V0Owo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8q
IFJldHVybiB0aGUgbmV3IGtlcm5lbCdzIGVudHJ5IHBvaW50ICovCj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGtlcm5lbF9lbnRyeSA9IFJFTE9DQVRFRF9LQVNMUihzdGFydF9rZXJu
ZWwpOwo+IC0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qIFRoZSBjdXJyZW50
IHRocmVhZCBpcyBub3cgd2l0aGluIHRoZSByZWxvY2F0ZWQga2VybmVsICovCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBfX2N1cnJlbnRfdGhyZWFkX2luZm8gPSBSRUxPQ0FURURf
S0FTTFIoX19jdXJyZW50X3RocmVhZF9pbmZvKTsKPiDCoAo+IEBAIC0yMDQsNyArMjAwLDcgQEAg
dm9pZCAqIF9faW5pdCByZWxvY2F0ZV9rZXJuZWwodm9pZCkKPiDCoAo+IMKgwqDCoMKgwqDCoMKg
wqByZWxvY2F0ZV9hYnNvbHV0ZShyYW5kb21fb2Zmc2V0KTsKPiDCoAo+IC3CoMKgwqDCoMKgwqDC
oHJldHVybiBrZXJuZWxfZW50cnk7Cj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIHJhbmRvbV9vZmZz
ZXQ7CgotLSAKWGkgUnVveWFvIDx4cnkxMTFAeHJ5MTExLnNpdGU+ClNjaG9vbCBvZiBBZXJvc3Bh
Y2UgU2NpZW5jZSBhbmQgVGVjaG5vbG9neSwgWGlkaWFuIFVuaXZlcnNpdHkK

