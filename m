Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78CE60005D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 17:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiJPPFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 11:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiJPPFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 11:05:04 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493E92B1BC
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 08:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1665932697;
        bh=KK3E7+y95n/wamk0irXlrFth95WLKZ8CxF125WruhUA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NZVert3nzC7vV75zXzsFR6pMzODvqxgY6ihc/OPUL40crEb2NkOY6fGya6Eb/Q2cY
         lW+sHcAatrG0PPduA9Nl93eCWxtdh7N7VFPs6I2TxXjzjP9A7kdg7n8Dx7B6KPBucs
         tNP+dzo/cPO7gg22HxwUBD8QQFw10BM77IauBGFo=
Received: from [IPv6:240e:358:1113:db00:dc73:854d:832e:4] (unknown [IPv6:240e:358:1113:db00:dc73:854d:832e:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id A5FFA65AA8;
        Sun, 16 Oct 2022 11:04:50 -0400 (EDT)
Message-ID: <c1b674a37a1a04f9c84df1e9a227db68bf78e922.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Add unaligned access support
From:   Xi Ruoyao <xry111@xry111.site>
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
Date:   Sun, 16 Oct 2022 23:04:42 +0800
In-Reply-To: <20221016133418.2122777-1-chenhuacai@loongson.cn>
References: <20221016133418.2122777-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIyLTEwLTE2IGF0IDIxOjM0ICswODAwLCBIdWFjYWkgQ2hlbiB3cm90ZToKCj4g
TG9vbmdzb24tMiBzZXJpZXMgKExvb25nc29uLTJLNTAwLCBMb29uZ3Nvbi0ySzEwMDApCgoiMksx
MDAwTEEiPyAiMksxMDAwIiBpcyBwdXp6bGluZyBiZWNhdXNlIG9mIGEgbmFtZSBjb25mbGljdCB3
aXRoIHRoZQpNSVBTLWJhc2VkIG1vZGVsLgoKLyogc25pcCAqLwoKPiArc3RhdGljIGlubGluZSB1
bnNpZ25lZCBsb25nIHJlYWRfZnByKHVuc2lnbmVkIGludCBmZCkKPiArewo+ICsjZGVmaW5lIFJF
QURfRlBSKGZkLCBfX3ZhbHVlKcKgwqDCoMKgwqDCoMKgwqDCoMKgXAo+ICt7wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoFwKClVubmVjZXNzYXJ5IGN1cmx5IGJyYWNlIHBhaXIuCgo+ICvCoMKgwqDCoMKgwqDC
oF9fYXNtX18gX192b2xhdGlsZV9fKMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBcCj4gK8KgwqDCoMKg
wqDCoMKgIm1vdmZyMmdyLmRcdCUwLCAkZiUxXG5cdCLCoMKgwqDCoMKgwqBcCj4gK8KgwqDCoMKg
wqDCoMKgOiAiPXIiKF9fdmFsdWUpIDogImkiKGZkKSk7wqDCoMKgwqDCoFwKPiArfQoKSSdtIG5v
dCBzdXJlIGlmIHRoaXMgaXMgYSBjb3JyZWN0IHVzZSBvZiAiaSIgY29uc3RyYWludC4gIE1heWJl
IHdlCnNob3VsZCBqdXN0IGNvbmNhdGVuYXRlIHRoZSBzdHJpbmc/CgoibW92ZnIyZ3IuZFx0JTAs
ICRmIiAjZmQgIlxuXHQiCgo+ICsKPiArwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBsb25nIF9fdmFs
dWU7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoHN3aXRjaCAoZmQpIHsKCkkgZG9uJ3QgbGlrZSB0aGlz
ICJ2ZXJ5IGxvbmciIHN3aXRjaCBzdGF0ZW1lbnQsIGJ1dCBpdCBzZWVtcyB3ZSBoYXZlIG5vCndh
eSB0byBtYWtlIGl0IGJldHRlci4uLgoKPiArwqDCoMKgwqDCoMKgwqBjYXNlIDA6Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFJFQURfRlBSKDAsIF9fdmFsdWUpOwo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBicmVhazsKPiArwqDCoMKgwqDCoMKgwqBjYXNlIDE6Cj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFJFQURfRlBSKDEsIF9fdmFsdWUpOwo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBicmVhazsKPiArwqDCoMKgwqDCoMKgwqBjYXNl
IDI6Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFJFQURfRlBSKDIsIF9fdmFsdWUp
Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBicmVhazsKCi0tIApYaSBSdW95YW8g
PHhyeTExMUB4cnkxMTEuc2l0ZT4KU2Nob29sIG9mIEFlcm9zcGFjZSBTY2llbmNlIGFuZCBUZWNo
bm9sb2d5LCBYaWRpYW4gVW5pdmVyc2l0eQo=

