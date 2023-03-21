Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A817C6C31C3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 13:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjCUMfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 08:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCUMfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 08:35:39 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D0F3A4D3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 05:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1679402137;
        bh=WqHd6UmiflAZuHzVPLhpeirTpk1BHvePg3JeMyhBQbE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bjCHwENxoDjb6bK4lLpiebeF4axazjLESvQBHn8qmKv1JeVbC91tDW/15BCkrCjI8
         StazifwyGhK3Un1Bpi3TlA2A+8DsIgbuXUx1zbE00u30XESxFaOsqicrNufmwkGRmt
         bmULJfddPXeEiq/qN2+xZoHBWbynPVnfGHchj5kM=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id B90D765938;
        Tue, 21 Mar 2023 08:35:35 -0400 (EDT)
Message-ID: <253a5dfcb7e41e44d15232e1891e7ea9d39dc953.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Check unwind_error() in arch_stack_walk()
From:   Xi Ruoyao <xry111@xry111.site>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Guenter Roeck <linux@roeck-us.net>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Date:   Tue, 21 Mar 2023 20:35:34 +0800
In-Reply-To: <1679380154-20308-1-git-send-email-yangtiezhu@loongson.cn>
References: <1679380154-20308-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTAzLTIxIGF0IDE0OjI5ICswODAwLCBUaWV6aHUgWWFuZyB3cm90ZToKPiBX
ZSBjYW4gc2VlIHRoZSBmb2xsb3dpbmcgbWVzc2FnZXMgd2l0aCBDT05GSUdfUFJPVkVfTE9DS0lO
Rz15IG9uCj4gTG9vbmdBcmNoOgo+IAo+IMKgIEJVRzogTUFYX1NUQUNLX1RSQUNFX0VOVFJJRVMg
dG9vIGxvdyEKPiDCoCB0dXJuaW5nIG9mZiB0aGUgbG9ja2luZyBjb3JyZWN0bmVzcyB2YWxpZGF0
b3IuCj4gCj4gVGhpcyBpcyBiZWNhdXNlIHN0YWNrX3RyYWNlX3NhdmUoKSByZXR1cm5zIGEgYmln
IHZhbHVlIGFmdGVyIGNhbGwKPiBhcmNoX3N0YWNrX3dhbGsoKSwgaGVyZSBpcyB0aGUgY2FsbCB0
cmFjZToKPiAKPiDCoCBzYXZlX3RyYWNlKCkKPiDCoMKgwqAgc3RhY2tfdHJhY2Vfc2F2ZSgpCj4g
wqDCoMKgwqDCoCBhcmNoX3N0YWNrX3dhbGsoKQo+IMKgwqDCoMKgwqDCoMKgIHN0YWNrX3RyYWNl
X2NvbnN1bWVfZW50cnkoKQo+IAo+IGFyY2hfc3RhY2tfd2FsaygpIHNob3VsZCByZXR1cm4gaW1t
ZWRpYXRlbHkgaWYgdW53aW5kX25leHRfZnJhbWUoKQo+IGZhaWxlZCwgbm8gbmVlZCB0byBkbyB0
aGUgdXNlbGVzcyBsb29wcyB0byBpbmNyZWFzZSB0aGUgdmFsdWUgb2YKPiBjLT5sZW4gaW4gc3Rh
Y2tfdHJhY2VfY29uc3VtZV9lbnRyeSgpLCB0aGVuIHdlIGNhbiBmaXggdGhlIGFib3ZlCj4gcHJv
YmxlbS4KPiAKPiBSZXBvcnRlZC1ieTogR3VlbnRlciBSb2VjayA8bGludXhAcm9lY2stdXMubmV0
Pgo+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC84YTQ0YWQ3MS02OGQyLTQ5MjYt
ODkyZi03MmJmYzdhNjdlMmFAcm9lY2stdXMubmV0Lwo+IFNpZ25lZC1vZmYtYnk6IFRpZXpodSBZ
YW5nIDx5YW5ndGllemh1QGxvb25nc29uLmNuPgoKVGhlIGZpeCBtYWtlcyBzZW5zZSwgYnV0IEkn
bSBhc2tpbmcgdGhlIHNhbWUgcXVlc3Rpb24gYWdhaW4gKHNvcnJ5IGlmCml0J3Mgbm9pc3kpOiBz
aG91bGQgd2UgQ2Mgc3RhYmxlQHZnZXIua2VybmVsLm9yZyBhbmQvb3IgbWFrZSBhIFBSIGZvcgo2
LjM/CgpUbyBtZSBhIGJ1ZyBmaXhlcyBzaG91bGQgYmUgYmFja3BvcnRlZCBpbnRvIGFsbCBzdGFi
bGUgYnJhbmNoZXMgYWZmZWN0ZWQKYnkgdGhlIGJ1ZywgdW5sZXNzIHRoZXJlIGlzIHNvbWUgc2Vy
aW91cyBkaWZmaWN1bHR5LiAgQXMgNi4zIHJlbGVhc2UKd2lsbCB3b3JrIG9uIGxhdW5jaGVkIDNB
NTAwMCBib2FyZHMgb3V0LW9mLWJveCwgcGVvcGxlIG1heSB3YW50IHRvIHN0b3AKc3RheWluZyBv
biB0aGUgbGVhZGluZyBlZGdlIGFuZCB1c2UgYSBMVFMvc3RhYmxlIHJlbGVhc2Ugc2VyaWVzLiBX
ZQpjYW4ndCBqdXN0IHNheSAob3IgYmVoYXZlIGxpa2UpICJ3ZSBkb24ndCBiYWNrcG9ydCwgcGxl
YXNlIHVzZSBsYXRlc3QKbWFpbmxpbmUiIElNTyA6KS4KCj4gLS0tCj4gwqBhcmNoL2xvb25nYXJj
aC9rZXJuZWwvc3RhY2t0cmFjZS5jwqDCoMKgwqDCoCB8IDMgKystCj4gwqBhcmNoL2xvb25nYXJj
aC9rZXJuZWwvdW53aW5kLmPCoMKgwqDCoMKgwqDCoMKgwqAgfCAxICsKPiDCoGFyY2gvbG9vbmdh
cmNoL2tlcm5lbC91bndpbmRfcHJvbG9ndWUuYyB8IDQgKysrLQo+IMKgMyBmaWxlcyBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2FyY2gv
bG9vbmdhcmNoL2tlcm5lbC9zdGFja3RyYWNlLmMgYi9hcmNoL2xvb25nYXJjaC9rZXJuZWwvc3Rh
Y2t0cmFjZS5jCj4gaW5kZXggM2E2OTBmOS4uN2MxNWJhNSAxMDA2NDQKPiAtLS0gYS9hcmNoL2xv
b25nYXJjaC9rZXJuZWwvc3RhY2t0cmFjZS5jCj4gKysrIGIvYXJjaC9sb29uZ2FyY2gva2VybmVs
L3N0YWNrdHJhY2UuYwo+IEBAIC0zMCw3ICszMCw4IEBAIHZvaWQgYXJjaF9zdGFja193YWxrKHN0
YWNrX3RyYWNlX2NvbnN1bWVfZm4gY29uc3VtZV9lbnRyeSwgdm9pZCAqY29va2llLAo+IMKgCj4g
wqDCoMKgwqDCoMKgwqDCoHJlZ3MtPnJlZ3NbMV0gPSAwOwo+IMKgwqDCoMKgwqDCoMKgwqBmb3Ig
KHVud2luZF9zdGFydCgmc3RhdGUsIHRhc2ssIHJlZ3MpOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgIXVud2luZF9kb25lKCZzdGF0ZSk7IHVud2luZF9uZXh0X2ZyYW1lKCZzdGF0ZSkpIHsK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAhdW53aW5kX2RvbmUoJnN0YXRlKSAmJiAhdW53aW5k
X2Vycm9yKCZzdGF0ZSk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW53aW5kX25leHRfZnJh
bWUoJnN0YXRlKSkgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYWRkciA9IHVu
d2luZF9nZXRfcmV0dXJuX2FkZHJlc3MoJnN0YXRlKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGlmICghYWRkciB8fCAhY29uc3VtZV9lbnRyeShjb29raWUsIGFkZHIpKQo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJyZWFrOwo+IGRp
ZmYgLS1naXQgYS9hcmNoL2xvb25nYXJjaC9rZXJuZWwvdW53aW5kLmMgYi9hcmNoL2xvb25nYXJj
aC9rZXJuZWwvdW53aW5kLmMKPiBpbmRleCBhNDYzZDY5Li5iYTMyNGJhIDEwMDY0NAo+IC0tLSBh
L2FyY2gvbG9vbmdhcmNoL2tlcm5lbC91bndpbmQuYwo+ICsrKyBiL2FyY2gvbG9vbmdhcmNoL2tl
cm5lbC91bndpbmQuYwo+IEBAIC0yOCw1ICsyOCw2IEBAIGJvb2wgZGVmYXVsdF9uZXh0X2ZyYW1l
KHN0cnVjdCB1bndpbmRfc3RhdGUgKnN0YXRlKQo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoH0gd2hp
bGUgKCFnZXRfc3RhY2tfaW5mbyhzdGF0ZS0+c3AsIHN0YXRlLT50YXNrLCBpbmZvKSk7Cj4gwqAK
PiArwqDCoMKgwqDCoMKgwqBzdGF0ZS0+ZXJyb3IgPSB0cnVlOwo+IMKgwqDCoMKgwqDCoMKgwqBy
ZXR1cm4gZmFsc2U7Cj4gwqB9Cj4gZGlmZiAtLWdpdCBhL2FyY2gvbG9vbmdhcmNoL2tlcm5lbC91
bndpbmRfcHJvbG9ndWUuYyBiL2FyY2gvbG9vbmdhcmNoL2tlcm5lbC91bndpbmRfcHJvbG9ndWUu
Ywo+IGluZGV4IDkwOTVmZGUuLjU1YWZjMjcgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9sb29uZ2FyY2gv
a2VybmVsL3Vud2luZF9wcm9sb2d1ZS5jCj4gKysrIGIvYXJjaC9sb29uZ2FyY2gva2VybmVsL3Vu
d2luZF9wcm9sb2d1ZS5jCj4gQEAgLTIxMSw3ICsyMTEsNyBAQCBzdGF0aWMgYm9vbCBuZXh0X2Zy
YW1lKHN0cnVjdCB1bndpbmRfc3RhdGUgKnN0YXRlKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBjID0gcmVncy0+Y3NyX2VyYTsKPiDCoAo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICh1c2VyX21vZGUo
cmVncykgfHwgIV9fa2VybmVsX3RleHRfYWRkcmVzcyhwYykpCj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGZhbHNl
Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGdvdG8gb3V0Owo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgc3RhdGUtPmZpcnN0ID0gdHJ1ZTsKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdGF0ZS0+cGMgPSBwYzsKPiBAQCAtMjI2
LDYgKzIyNiw4IEBAIHN0YXRpYyBib29sIG5leHRfZnJhbWUoc3RydWN0IHVud2luZF9zdGF0ZSAq
c3RhdGUpCj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgfSB3aGlsZSAoIWdldF9zdGFja19pbmZvKHN0
YXRlLT5zcCwgc3RhdGUtPnRhc2ssIGluZm8pKTsKPiDCoAo+ICtvdXQ6Cj4gK8KgwqDCoMKgwqDC
oMKgc3RhdGUtPmVycm9yID0gdHJ1ZTsKPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGZhbHNlOwo+
IMKgfQo+IMKgCgotLSAKWGkgUnVveWFvIDx4cnkxMTFAeHJ5MTExLnNpdGU+ClNjaG9vbCBvZiBB
ZXJvc3BhY2UgU2NpZW5jZSBhbmQgVGVjaG5vbG9neSwgWGlkaWFuIFVuaXZlcnNpdHkK

