Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F1B6D6856
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbjDDQGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 12:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDDQG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:06:28 -0400
X-Greylist: delayed 1664 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Apr 2023 09:06:27 PDT
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A5F3AB9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 09:06:27 -0700 (PDT)
Received: from [2601:447:c680:c050::6c59]
        by baldur.buserror.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <oss@buserror.net>)
        id 1pjif1-009Iut-PN; Tue, 04 Apr 2023 10:33:28 -0500
Message-ID: <48dacc58c7c04ba8a005d8edd56744c8455f007e.camel@buserror.net>
From:   Crystal Wood <oss@buserror.net>
To:     Sean Anderson <sean.anderson@seco.com>,
        Li Yang <leoyang.li@nxp.com>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Camelia Groza <camelia.groza@nxp.com>,
        linux-kernel@vger.kernel.org, Roy Pledge <roy.pledge@nxp.com>,
        "David S . Miller" <davem@davemloft.net>
Date:   Tue, 04 Apr 2023 10:33:26 -0500
In-Reply-To: <20230404145557.2356894-2-sean.anderson@seco.com>
References: <20230404145557.2356894-1-sean.anderson@seco.com>
         <20230404145557.2356894-2-sean.anderson@seco.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2601:447:c680:c050::6c59
X-SA-Exim-Rcpt-To: sean.anderson@seco.com, leoyang.li@nxp.com, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, vladimir.oltean@nxp.com, claudiu.manoil@nxp.com, camelia.groza@nxp.com, linux-kernel@vger.kernel.org, roy.pledge@nxp.com, davem@davemloft.net
X-SA-Exim-Mail-From: oss@buserror.net
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
Subject: Re: [PATCH v3 2/2] soc: fsl: qbman: Use raw spinlock for cgr_lock
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA0LTA0IGF0IDEwOjU1IC0wNDAwLCBTZWFuIEFuZGVyc29uIHdyb3RlOgoK
PiBAQCAtMTQ1NiwxMSArMTQ1NiwxMSBAQCBzdGF0aWMgdm9pZCBxbV9jb25nZXN0aW9uX3Rhc2so
c3RydWN0IHdvcmtfc3RydWN0Cj4gKndvcmspCj4gwqDCoMKgwqDCoMKgwqDCoHVuaW9uIHFtX21j
X3Jlc3VsdCAqbWNyOwo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcW1hbl9jZ3IgKmNncjsKPiDC
oAo+IC3CoMKgwqDCoMKgwqDCoHNwaW5fbG9ja19pcnEoJnAtPmNncl9sb2NrKTsKPiArwqDCoMKg
wqDCoMKgwqByYXdfc3Bpbl9sb2NrX2lycSgmcC0+Y2dyX2xvY2spOwo+IMKgwqDCoMKgwqDCoMKg
wqBxbV9tY19zdGFydCgmcC0+cCk7Cj4gwqDCoMKgwqDCoMKgwqDCoHFtX21jX2NvbW1pdCgmcC0+
cCwgUU1fTUNDX1ZFUkJfUVVFUllDT05HRVNUSU9OKTsKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKCFx
bV9tY19yZXN1bHRfdGltZW91dCgmcC0+cCwgJm1jcikpIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgc3Bpbl91bmxvY2tfaXJxKCZwLT5jZ3JfbG9jayk7Cj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHJhd19zcGluX3VubG9ja19pcnEoJnAtPmNncl9sb2NrKTsKCnFt
X21jX3Jlc3VsdF90aW1lb3V0KCkgc3BpbnMgd2l0aCBhIHRpbWVvdXQgb2YgMTAgbXMgd2hpY2gg
aXMgdmVyeQppbmFwcHJvcHJpYXRlIGZvciBhIHJhdyBsb2NrLiAgV2hhdCBpcyB0aGUgYWN0dWFs
IGV4cGVjdGVkIHVwcGVyIGJvdW5kPwoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGRldl9jcml0KHAtPmNvbmZpZy0+ZGV2LCAiUVVFUllDT05HRVNUSU9OIHRpbWVvdXRcbiIpOwo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcW1hbl9wX2lycXNvdXJjZV9hZGQocCwg
UU1fUElSUV9DU0NJKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybjsK
PiBAQCAtMTQ3Niw3ICsxNDc2LDcgQEAgc3RhdGljIHZvaWQgcW1fY29uZ2VzdGlvbl90YXNrKHN0
cnVjdCB3b3JrX3N0cnVjdAo+ICp3b3JrKQo+IMKgwqDCoMKgwqDCoMKgwqBsaXN0X2Zvcl9lYWNo
X2VudHJ5KGNnciwgJnAtPmNncl9jYnMsIG5vZGUpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBpZiAoY2dyLT5jYiAmJiBxbWFuX2NncnNfZ2V0KCZjLCBjZ3ItPmNncmlkKSkKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjZ3ItPmNiKHAs
IGNnciwgcW1hbl9jZ3JzX2dldCgmcnIsIGNnci0+Y2dyaWQpKTsKPiAtwqDCoMKgwqDCoMKgwqBz
cGluX3VubG9ja19pcnEoJnAtPmNncl9sb2NrKTsKPiArwqDCoMKgwqDCoMKgwqByYXdfc3Bpbl91
bmxvY2tfaXJxKCZwLT5jZ3JfbG9jayk7Cj4gwqDCoMKgwqDCoMKgwqDCoHFtYW5fcF9pcnFzb3Vy
Y2VfYWRkKHAsIFFNX1BJUlFfQ1NDSSk7Cj4gwqB9CgpUaGUgY2FsbGJhY2sgbG9vcCBpcyBhbHNv
IGEgYml0IGNvbmNlcm5pbmcuLi4KCi1DcnlzdGFsCgo=

