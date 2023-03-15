Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2954B6BA63D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 05:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjCOEd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 00:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjCOEd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 00:33:27 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B402364C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 21:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1678854802;
        bh=dnx8mYuIXKhY0u6LRcFBOzoqXdx1e7QKqhBvWdPzpZ8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VgEC4Y46BOhmxYa8KoD9dQnAmGzAcqArZr0zdsHqekEdduwtfswHmehsoGT391Rm8
         bqoYsvYYjFe8Je30ruve6ZLKXqw/o95+2EShlqvf8wMo5Dd5rrd0rfkuUb0ajpLz0I
         q9IbRDObDqGGVGwHgZUMOT6HlNVEj2yllOMwS83I=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 41E4165907;
        Wed, 15 Mar 2023 00:33:21 -0400 (EDT)
Message-ID: <0f07fc368ef9a365f4928f97819f203e45deb345.camel@xry111.site>
Subject: Re: [PATCH V2] LoongArch: Make WriteCombine configurable for
 ioremap()
From:   Xi Ruoyao <xry111@xry111.site>
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Date:   Wed, 15 Mar 2023 12:33:19 +0800
In-Reply-To: <20230315004450.508486-1-chenhuacai@loongson.cn>
References: <20230315004450.508486-1-chenhuacai@loongson.cn>
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

T24gV2VkLCAyMDIzLTAzLTE1IGF0IDA4OjQ0ICswODAwLCBIdWFjYWkgQ2hlbiB3cm90ZToKCi8q
IHNuaXAgKi8KCj4gK2NvbmZpZyBBUkNIX1dSSVRFQ09NQklORQo+ICvCoMKgwqDCoMKgwqDCoGJv
b2wgIkVuYWJsZSBXcml0ZUNvbWJpbmUgKFdVQykgZm9yIGlvcmVtYXAoKSIKPiArwqDCoMKgwqDC
oMKgwqBoZWxwCj4gK8KgwqDCoMKgwqDCoMKgwqAgTG9vbmdBcmNoIG1haW50YWlucyBjYWNoZSBj
b2hlcmVuY3kgaW4gaGFyZHdhcmUsIGJ1dCB3aGVuIHBhaXJlZAo+ICvCoMKgwqDCoMKgwqDCoMKg
IHdpdGggTFM3QSBjaGlwc2V0cyB0aGUgV1VDIGF0dHJpYnV0ZSAoV2Vhay1vcmRlcmVkIFVuQ2Fj
aGVkLCB3aGljaAo+ICvCoMKgwqDCoMKgwqDCoMKgIGlzIHNpbWlsYXIgdG8gV3JpdGVDb21iaW5l
KSBpcyBvdXQgb2YgdGhlIHNjb3BlIG9mIGNhY2hlIGNvaGVyZW5jeQo+ICvCoMKgwqDCoMKgwqDC
oMKgIG1hY2hhbmlzbSBmb3IgUENJZSBkZXZpY2VzICh0aGlzIGlzIGEgUENJZSBwcm90b2NvbCB2
aW9sYXRpb24sIHdoaWNoCj4gK8KgwqDCoMKgwqDCoMKgwqAgbWF5IGJlIGZpeGVkIGluIG5ld2Vy
IGNoaXBzZXRzKS4KPiArCj4gK8KgwqDCoMKgwqDCoMKgwqAgVGhpcyBtZWFucyBXVUMgY2FuIG9u
bHkgdXNlZCBmb3Igd3JpdGUtb25seSBtZW1vcnkgcmVnaW9ucyBub3csIHNvCj4gK8KgwqDCoMKg
wqDCoMKgwqAgdGhpcyBvcHRpb24gaXMgZGlzYWJsZWQgYnkgZGVmYXVsdCwgbWFraW5nIFdVQyBz
aWxlbnRseSBmYWxsYmFjayB0bwo+ICvCoMKgwqDCoMKgwqDCoMKgIFNVQyBmb3IgaW9yZW1hcCgp
LiBZb3UgY2FuIGVuYWJsZSB0aGlzIG9wdGlvbiBpZiB0aGUga2VybmVsIGlzIGVuc3VyZWQKPiAr
wqDCoMKgwqDCoMKgwqDCoCB0byBydW4gb24gaGFyZHdhcmUgd2l0aG91dCB0aGlzIGJ1Zy4KCidZ
b3UgY2FuIG92ZXJyaWRlIHRoaXMgc2V0dGluZyB2aWEgd3JpdGVjb21iaW5lPXllcy9ubyBib290
IHBhcmFtZXRlci4nCgovKiBzbmlwICovCgo+ICtzdGF0aWMgaW50IF9faW5pdCBzZXR1cF93cml0
ZWNvbWJpbmUoY2hhciAqcCkKPiArewo+ICvCoMKgwqDCoMKgwqDCoGlmICghc3RyY21wKHAsICJv
biIpKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwZ3Byb3Rfd2MgPSBQQUdFX0tF
Uk5FTF9XVUM7Cj4gK8KgwqDCoMKgwqDCoMKgZWxzZSBpZiAoIXN0cmNtcChwLCAib2ZmIikpCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBncHJvdF93YyA9IFBBR0VfS0VSTkVMX1NV
QzsKCmVsc2UKCXByX3dhcm4oIlVua25vd24gd3JpdGVjb21iaW5lIHNldHRpbmcgXCIlc1wiLlxu
IiwgcCk7CgpPdGhlcndpc2UgTEdUTS4KCi0tIApYaSBSdW95YW8gPHhyeTExMUB4cnkxMTEuc2l0
ZT4KU2Nob29sIG9mIEFlcm9zcGFjZSBTY2llbmNlIGFuZCBUZWNobm9sb2d5LCBYaWRpYW4gVW5p
dmVyc2l0eQo=

