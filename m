Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3127570A63C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 09:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjETH51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 03:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjETH5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 03:57:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E921A4;
        Sat, 20 May 2023 00:57:22 -0700 (PDT)
Received: from [IPv6:2a00:23c7:6883:e501:5580:8bf2:4bf2:e6a4] (unknown [IPv6:2a00:23c7:6883:e501:5580:8bf2:4bf2:e6a4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4BCD66605974;
        Sat, 20 May 2023 08:57:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684569440;
        bh=rBbHRoQ+a5jN+SVcKOaJRLVgHRVde7WgPRp1FgivvwU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bndFM+6L/tC3MNbqKAZnTQELQSH7lBnsnuMioIyrkAFYIbvhIC8aJd7F5m/WuiGJk
         i4Ws0xRDGaQAYW4azbSzyYd/2CaXPTzql2WnEOyqpah+baK1QaMkaeK+l6nHrnNR8n
         WjQ+5JUDZmm0OBY8ZD0qVQwp+hNpXs/FdwyHOT0j7V/1TNygLzDsd8XVQa+vIJAL1z
         POzO2mv3zVENfJPNtguigCFORGu5pptuZJQ6bAtrIH4LNFO0H/uN2X9AGQ5EOim0b/
         2+g6eQH8UnWUvgIkof71byAHJg0JWcgdbhADPodVy5IrbiBHF0B9DBX35ZLiZYatal
         DGj5AhOL1OUCQ==
Message-ID: <c8befb46085c43e1d09f27709b90e92dbce52c82.camel@collabora.com>
Subject: Re: [PATCH v1 1/2] clk: composite: Fix handling of high clock rates
From:   Christopher Obbard <chris.obbard@collabora.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, stable@vger.kernel.org
Date:   Sat, 20 May 2023 08:57:16 +0100
In-Reply-To: <20230519190522.194729-2-sebastian.reichel@collabora.com>
References: <20230519190522.194729-1-sebastian.reichel@collabora.com>
         <20230519190522.194729-2-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2ViYXN0aWFuLAoKT24gRnJpLCAyMDIzLTA1LTE5IGF0IDIxOjA1ICswMjAwLCBTZWJhc3Rp
YW4gUmVpY2hlbCB3cm90ZToKPiBVTE9OR19NQVggaXMgdXNlZCBieSBhIGZldyBkcml2ZXJzIHRv
IGZpZ3VyZSBvdXQgdGhlIGhpZ2hlc3QgYXZhaWxhYmxlCj4gY2xvY2sgcmF0ZSB2aWEgY2xrX3Jv
dW5kX3JhdGUoY2xrLCBVTE9OR19NQVgpLiBTaW5jZSBhYnMoKSB0YWtlcyBhCj4gc2lnbmVkIHZh
bHVlIGFzIGlucHV0LCB0aGUgY3VycmVudCBsb2dpYyBlZmZlY3RpdmVseSBjYWxjdWxhdGVzIHdp
dGgKPiBVTE9OR19NQVggPSAtMSwgd2hpY2ggcmVzdWx0cyBpbiB0aGUgd29yc3QgcGFyZW50IGNs
b2NrIGJlaW5nIGNob3Nlbgo+IGluc3RlYWQgb2YgdGhlIGJlc3Qgb25lLgo+IAo+IEZvciBleGFt
cGxlIG9uIFJvY2tjaGlwIFJLMzU4OCB0aGUgZU1NQyBkcml2ZXIgdHJpZXMgdG8gZmlndXJlIG91
dAo+IHRoZSBoaWdoZXN0IGF2YWlsYWJsZSBjbG9jayByYXRlLiBUaGVyZSBhcmUgdGhyZWUgcGFy
ZW50IGNsb2Nrcwo+IGF2YWlsYWJsZSByZXN1bHRpbmcgaW4gdGhlIGZvbGxvd2luZyByYXRlIGRp
ZmZzIHdpdGggdGhlIGV4aXN0aW5nCj4gbG9naWM6Cj4gCj4gR1BMTDrCoMKgIGFicygxODQ0Njc0
NDA3MzcwOTU1MTYxNSAtIDExODgwMDAwMDApID0gMTE4ODAwMDAwMQo+IENQTEw6wqDCoCBhYnMo
MTg0NDY3NDQwNzM3MDk1NTE2MTUgLSAxNTAwMDAwMDAwKSA9IDE1MDAwMDAwMDEKPiBYSU4yNE06
IGFicygxODQ0Njc0NDA3MzcwOTU1MTYxNSAtwqDCoCAyNDAwMDAwMCkgPcKgwqAgMjQwMDAwMDEK
PiAKPiBBcyBhIHJlc3VsdCB0aGUgY2xvY2sgZnJhbWV3b3JrIHdpbGwgcHJvbW90ZSBhIG1heGlt
dW0gc3VwcG9ydGVkCj4gY2xvY2sgcmF0ZSBvZiAyNCBNSHosIGV2ZW4gdGhvdWdoIDEuNUdIeiBh
cmUgcG9zc2libGUuIFdpdGggdGhlCj4gdXBkYXRlZCBsb2dpYyBhbnkgY2FzdGluZyBiZXR3ZWVu
IHNpZ25lZCBhbmQgdW5zaWduZWQgaXMgYXZvaWRlZAo+IGFuZCB0aGUgbnVtYmVycyBsb29rIGxp
a2UgdGhpcyBpbnN0ZWFkOgo+IAo+IEdQTEw6wqDCoCAxODQ0Njc0NDA3MzcwOTU1MTYxNSAtIDEx
ODgwMDAwMDAgPSAxODQ0Njc0NDA3MjUyMTU1MTYxNQo+IENQTEw6wqDCoCAxODQ0Njc0NDA3Mzcw
OTU1MTYxNSAtIDE1MDAwMDAwMDAgPSAxODQ0Njc0NDA3MjIwOTU1MTYxNQo+IFhJTjI0TTogMTg0
NDY3NDQwNzM3MDk1NTE2MTUgLcKgwqAgMjQwMDAwMDAgPSAxODQ0Njc0NDA3MzY4NTU1MTYxNQo+
IAo+IEFzIGEgcmVzdWx0IHRoZSBwYXJlbnQgd2l0aCB0aGUgaGlnaGVzdCBhY2NlcHRhYmxlIHJh
dGUgaXMgY2hvc2VuCj4gaW5zdGVhZCBvZiB0aGUgcGFyZW50IGNsb2NrIHdpdGggdGhlIGxvd2Vz
dCBvbmUuCj4gCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKPiBGaXhlczogNDk1MDI0MDgw
MDdiICgibW1jOiBzZGhjaS1vZi1kd2Ntc2hjOiBwcm9wZXJseSBkZXRlcm1pbmUgbWF4IGNsb2Nr
IG9uIFJvY2tjaGlwIikKPiBTaWduZWQtb2ZmLWJ5OiBTZWJhc3RpYW4gUmVpY2hlbCA8c2ViYXN0
aWFuLnJlaWNoZWxAY29sbGFib3JhLmNvbT4KClRoaXMgcGF0Y2ggc2VyaWVzIGZpeGVzIHRoZSBl
cnJvciBvbiBSb2NrY2hpcCBSSzM1ODggb24gUk9DSyA1IE1vZGVsIEIuCgpUZXN0ZWQtYnk6IENo
cmlzdG9waGVyIE9iYmFyZCA8Y2hyaXMub2JiYXJkQGNvbGxhYm9yYS5jb20+Cgo+IC0tLQo+IMKg
ZHJpdmVycy9jbGsvY2xrLWNvbXBvc2l0ZS5jIHwgNSArKysrLQo+IMKgMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2Nsay9jbGstY29tcG9zaXRlLmMgYi9kcml2ZXJzL2Nsay9jbGstY29tcG9zaXRlLmMKPiBpbmRl
eCBlZGZhOTQ2NDFiYmYuLjY2NzU5ZmUyOGZhZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2Nsay9j
bGstY29tcG9zaXRlLmMKPiArKysgYi9kcml2ZXJzL2Nsay9jbGstY29tcG9zaXRlLmMKPiBAQCAt
MTE5LDcgKzExOSwxMCBAQCBzdGF0aWMgaW50IGNsa19jb21wb3NpdGVfZGV0ZXJtaW5lX3JhdGUo
c3RydWN0IGNsa19odyAqaHcsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgaWYgKHJldCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29udGludWU7Cj4gwqAKPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJhdGVfZGlmZiA9IGFicyhyZXEt
PnJhdGUgLSB0bXBfcmVxLnJhdGUpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgaWYgKHJlcS0+cmF0ZSA+PSB0bXBfcmVxLnJhdGUpCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmF0
ZV9kaWZmID0gcmVxLT5yYXRlIC0gdG1wX3JlcS5yYXRlOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZWxzZQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJhdGVfZGlmZiA9IHRtcF9y
ZXEucmF0ZSAtIHJlcS0+cmF0ZTsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGlmICghcmF0ZV9kaWZmIHx8ICFyZXEtPmJlc3RfcGFyZW50X2h3
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8fCBiZXN0X3JhdGVfZGlmZiA+IHJhdGVfZGlmZikgewo+
IC0tIAo+IDIuMzkuMgo+IAo+IAo=

