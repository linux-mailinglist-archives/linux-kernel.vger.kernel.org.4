Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBBA7292ED
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240298AbjFIIXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240651AbjFIIXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:23:19 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71344204;
        Fri,  9 Jun 2023 01:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1686298917; x=1717834917;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QTspSyUb45qICqfAqkowcBOD4g3NAvapwgBH7a+Acd8=;
  b=F3RYN8ndUS3Elfagg11c3v2vjAbS2a/yclzNj5V+Gzyf0b8fIw1dMLx5
   Bs9ho7f4W0GquO7ibQD/SgONKnwHAhwvJzRSAGAFIu9RkN0zL7fNNxgEW
   fHofafmk3GyqgOGCD+eF7fg78AZ2IdItvQEx6WUvrg4pB+02F2pMSlDQQ
   ZyDHQYJ4Y3sviE4XoYQfLM4SlDFJsBQntEOOVor2z/fqLO9MqgwNRua72
   OoFJ3ZwUwjPaFqwVLSOHSZYY+2eeNB0iPGq9jGK3zw9bixvbX/G30PsXo
   VLnzF8syFhW/SgQq2yy+t1CZdvwj+f6dB9L9fFkPhL/RXnv1hUbKccP79
   g==;
X-IronPort-AV: E=Sophos;i="6.00,228,1681164000"; 
   d="scan'208";a="31359638"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 09 Jun 2023 10:20:16 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 09 Jun 2023 10:20:16 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 09 Jun 2023 10:20:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1686298816; x=1717834816;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QTspSyUb45qICqfAqkowcBOD4g3NAvapwgBH7a+Acd8=;
  b=TwDjBBWGqdapd1P1hz97LVnLEXsFm1k4Oaz17D5JtWzeN6vejy1PA9QG
   2XN68jJyiGP6i5oh5bM88vTJ7w2h24KiJa+a5qw5WXy9vIXtknVzHInai
   T3Et3dSof7BpG2tAVmhhL/c7nhrSIRj3CA3dRYDdjSIWzN42Nj88caNif
   DP+LYn6dkFrznRLJBfvNiqMw+7qT4mKtL4+H6MG4D0EbMzNdY+aGB6VJa
   WvVfCiLBlX6LTVyvmjXOsKzyDOeYP8L8LfD1C+mDP1QWTUTaDBV6cGETu
   TACMSLEzRfyexxVFDaujb1VaBbHbQLMLWZl9fEEQEmtTBcBCq3uAZfFPX
   A==;
X-IronPort-AV: E=Sophos;i="6.00,228,1681164000"; 
   d="scan'208";a="31359637"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 09 Jun 2023 10:20:16 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 63947280087;
        Fri,  9 Jun 2023 10:20:16 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     imx@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     coresight@lists.linaro.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] arm64: dts: imx8mp: Add coresight trace components
Date:   Fri, 09 Jun 2023 10:20:16 +0200
Message-ID: <2229161.iZASKD2KPV@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20230505195151.1874071-1-Frank.Li@nxp.com>
References: <20230505195151.1874071-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksCgpBbSBGcmVpdGFnLCA1LiBNYWkgMjAyMywgMjE6NTE6NTEgQ0VTVCBzY2hyaWViIEZyYW5r
IExpOgo+IEFkZCBjb3Jlc2lnaHQgdHJhY2UgY29tcG9uZW50cyAoRVRNLCBFVEYsIEVUQiBhbmQg
RnVubmVsKS4KPiAKPiDilIzilIDilIDilIDilIDilIDilIDilIDilJAgIOKUjOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUkCAg4pSM4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQCj4g4pSCIENQVTAgIOKU
nOKUgOKWuuKUgiBFVE0wICDilJzilIDilrrilIIgICAgICAg4pSCCj4g4pSU4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSYICDilJTilIDilIDilIDilIDilIDilIDilIDilJggIOKUgiAgICAgICDilIIK
PiAgICAgICAgICAgICAgICAgICAgICAg4pSCICAgICAgIOKUggo+IOKUjOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUkCAg4pSM4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQICDilIIgIEFUUCAg4pSCCj4g
4pSCIENQVTEgIOKUnOKUgOKWuuKUgiBFVE0xICDilJzilIDilrrilIIgICAgICAg4pSCCj4g4pSU
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSYICDilJTilIDilIDilIDilIDilIDilIDilIDilJggIOKU
giAgICAgICDilIIKPiAgICAgICAgICAgICAgICAgICAgICAg4pSCIEZVTk5FTOKUggo+IOKUjOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUkCAg4pSM4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQICDilIIg
ICAgICAg4pSCCj4g4pSCIENQVTIgIOKUnOKUgOKWuuKUgiBFVE0yICDilJzilIDilrrilIIgICAg
ICAg4pSCCj4g4pSU4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSYICDilJTilIDilIDilIDilIDilIDi
lIDilIDilJggIOKUgiAgICAgICDilIIgICDilIzilIDilIDilIDilIDilIDilJAgIOKUjOKUgOKU
gOKUgOKUgOKUgOKUkAo+ICAgICAgICAgICAgICAgICAgICAgICDilIIgICAgICAg4pSCICAg4pSC
ICAgICDilIIgIOKUgiAgICAg4pSCCj4g4pSM4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQICDilIzi
lIDilIDilIDilIDilIDilIDilIDilJAgIOKUgiAgICAgICDilIIgICDilIIgTTcgIOKUgiAg4pSC
IERTUCDilIIKPiDilIIgQ1BVMyAg4pSc4pSA4pa64pSCIEVUTTMgIOKUnOKUgOKWuuKUgiAgICAg
ICDilIIgICDilIIgICAgIOKUgiAg4pSCICAgICDilIIKPiDilJTilIDilIDilIDilIDilIDilIDi
lIDilJggIOKUlOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUmCAg4pSU4pSA4pSA4pSA4pSs4pSA4pSA
4pSA4pSYICAg4pSU4pSA4pSA4pSs4pSA4pSA4pSYICDilJTilIDilIDilKzilIDilIDilJggICAg
ICAgICAgICAgICBBWEkKPiAgICAgICAgICAgICAgICAgICAgICAgICAgIOKUgiAgICAgICAgICDi
lIIgICAgICAgIOKUgiAgICAgICAgICAgICAgICAgICDilrIKPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgIOKWvCAgICAgICAgICDilrwgICAgICAgIOKWvCAgICAgICAgICAgICAgICAgICDilIIK
PiAgICAgICAgICAgICAgICAgICAgICAg4pSM4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQICAg
4pSM4pSA4pSA4pSA4pSA4pSA4pSQICAg4pSM4pSA4pS04pSA4pSA4pSQCj4gICAgICAgICAgICAg
ICAgICAgICAgIOKUgiAgICAgICAgICBBVFAgRlVOTkVMICAgICAgIOKUnOKUgOKUgOKWuuKUgkVU
RiAg4pSc4pSA4pa6IOKUgkVUUiDilIIKPiAgICAgICAgICAgICAgICAgICAgICAg4pSU4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSYICAg4pSU4pSA4pSA4pSA4pSA4pSA4pSYICAg4pSU4pSA4pSA
4pSA4pSA4pSYCj4gCj4gU2lnbmVkLW9mZi1ieTogRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+
Cj4gLS0tCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC5kdHNpIHwgMTc5
ICsrKysrKysrKysrKysrKysrKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDE3OSBpbnNlcnRpb25z
KCspCj4gCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDht
cC5kdHNpCj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAuZHRzaSBpbmRl
eAo+IGExOTIyNGZlMWE2YS4uMGZhNzQ0NzdiOWUxIDEwMDY0NAo+IC0tLSBhL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC5kdHNpCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvaW14OG1wLmR0c2kKPiBAQCAtMzA0LDYgKzMwNCwxODUgQEAgc29jOiBzb2NA
MCB7Cj4gIAkJbnZtZW0tY2VsbHMgPSA8JmlteDhtcF91aWQ+Owo+ICAJCW52bWVtLWNlbGwtbmFt
ZXMgPSAic29jX3VuaXF1ZV9pZCI7Cj4gCj4gKwkJZXRtMDogZXRtQDI4NDQwMDAwIHsKPiArCQkJ
Y29tcGF0aWJsZSA9ICJhcm0sY29yZXNpZ2h0LWV0bTR4IiwgCiJhcm0scHJpbWVjZWxsIjsKPiAr
CQkJcmVnID0gPDB4Mjg0NDAwMDAgMHgxMDAwMD47Cj4gKwkJCWFybSxwcmltZWNlbGwtcGVyaXBo
aWQgPSA8MHhiYjk1ZD47Cj4gKwkJCWNwdSA9IDwmQTUzXzA+Owo+ICsJCQljbG9ja3MgPSA8JmNs
ayBJTVg4TVBfQ0xLX01BSU5fQVhJPjsKPiArCQkJY2xvY2stbmFtZXMgPSAiYXBiX3BjbGsiOwo+
ICsJCQlvdXQtcG9ydHMgewo+ICsJCQkJcG9ydCB7Cj4gKwkJCQkJZXRtMF9vdXRfcG9ydDogZW5k
cG9pbnQgewo+ICsJCQkJCQlyZW1vdGUtZW5kcG9pbnQgPSAKPCZjYV9mdW5uZWxfaW5fcG9ydDA+
Owo+ICsJCQkJCX07Cj4gKwkJCQl9Owo+ICsJCQl9Owo+ICsJCX07Cj4gKwo+ICsJCWV0bTE6IGV0
bUAyODU0MDAwMCB7Cj4gKwkJCWNvbXBhdGlibGUgPSAiYXJtLGNvcmVzaWdodC1ldG00eCIsIAoi
YXJtLHByaW1lY2VsbCI7Cj4gKwkJCXJlZyA9IDwweDI4NTQwMDAwIDB4MTAwMDA+Owo+ICsJCQlh
cm0scHJpbWVjZWxsLXBlcmlwaGlkID0gPDB4YmI5NWQ+Owo+ICsJCQljcHUgPSA8JkE1M18xPjsK
PiArCQkJY2xvY2tzID0gPCZjbGsgSU1YOE1QX0NMS19NQUlOX0FYST47Cj4gKwkJCWNsb2NrLW5h
bWVzID0gImFwYl9wY2xrIjsKPiArCQkJb3V0LXBvcnRzIHsKPiArCQkJCXBvcnQgewo+ICsJCQkJ
CWV0bTFfb3V0X3BvcnQ6IGVuZHBvaW50IHsKPiArCQkJCQkJcmVtb3RlLWVuZHBvaW50ID0gCjwm
Y2FfZnVubmVsX2luX3BvcnQxPjsKPiArCQkJCQl9Owo+ICsJCQkJfTsKPiArCQkJfTsKPiArCQl9
Owo+ICsKPiArCQlldG0yOiBldG1AMjg2NDAwMDAgewo+ICsJCQljb21wYXRpYmxlID0gImFybSxj
b3Jlc2lnaHQtZXRtNHgiLCAKImFybSxwcmltZWNlbGwiOwo+ICsJCQlyZWcgPSA8MHgyODY0MDAw
MCAweDEwMDAwPjsKPiArCQkJYXJtLHByaW1lY2VsbC1wZXJpcGhpZCA9IDwweGJiOTVkPjsKPiAr
CQkJY3B1ID0gPCZBNTNfMj47Cj4gKwkJCWNsb2NrcyA9IDwmY2xrIElNWDhNUF9DTEtfTUFJTl9B
WEk+Owo+ICsJCQljbG9jay1uYW1lcyA9ICJhcGJfcGNsayI7Cj4gKwkJCW91dC1wb3J0cyB7Cj4g
KwkJCQlwb3J0IHsKPiArCQkJCQlldG0yX291dF9wb3J0OiBlbmRwb2ludCB7Cj4gKwkJCQkJCXJl
bW90ZS1lbmRwb2ludCA9IAo8JmNhX2Z1bm5lbF9pbl9wb3J0Mj47Cj4gKwkJCQkJfTsKPiArCQkJ
CX07Cj4gKwkJCX07Cj4gKwkJfTsKPiArCj4gKwkJZXRtMzogZXRtQDI4NzQwMDAwIHsKPiArCQkJ
Y29tcGF0aWJsZSA9ICJhcm0sY29yZXNpZ2h0LWV0bTR4IiwgCiJhcm0scHJpbWVjZWxsIjsKPiAr
CQkJcmVnID0gPDB4Mjg3NDAwMDAgMHgxMDAwMD47Cj4gKwkJCWFybSxwcmltZWNlbGwtcGVyaXBo
aWQgPSA8MHhiYjk1ZD47Cj4gKwkJCWNwdSA9IDwmQTUzXzM+Owo+ICsJCQljbG9ja3MgPSA8JmNs
ayBJTVg4TVBfQ0xLX01BSU5fQVhJPjsKPiArCQkJY2xvY2stbmFtZXMgPSAiYXBiX3BjbGsiOwo+
ICsJCQlvdXQtcG9ydHMgewo+ICsJCQkJcG9ydCB7Cj4gKwkJCQkJZXRtM19vdXRfcG9ydDogZW5k
cG9pbnQgewo+ICsJCQkJCQlyZW1vdGUtZW5kcG9pbnQgPSAKPCZjYV9mdW5uZWxfaW5fcG9ydDM+
Owo+ICsJCQkJCX07Cj4gKwkJCQl9Owo+ICsJCQl9Owo+ICsJCX07Cj4gKwo+ICsJCWZ1bm5lbCB7
Cj4gKwkJCS8qCj4gKwkJCSAqIG5vbi1jb25maWd1cmFibGUgZnVubmVsIGRvbid0IHNob3cgdXAg
b24gdGhlIApBTUJBCj4gKwkJCSAqIGJ1cy4gIEFzIHN1Y2ggbm8gbmVlZCB0byBhZGQgImFybSxw
cmltZWNlbGwiLgo+ICsJCQkgKi8KPiArCQkJY29tcGF0aWJsZSA9ICJhcm0sY29yZXNpZ2h0LXN0
YXRpYy1mdW5uZWwiOwo+ICsJCQlpbi1wb3J0cyB7Cj4gKwkJCQkjYWRkcmVzcy1jZWxscyA9IDwx
PjsKPiArCQkJCSNzaXplLWNlbGxzID0gPDA+Owo+ICsJCQkJcG9ydEAwIHsKPiArCQkJCQlyZWcg
PSA8MD47Cj4gKwkJCQkJY2FfZnVubmVsX2luX3BvcnQwOiBlbmRwb2ludCAKewo+ICsJCQkJCQly
ZW1vdGUtZW5kcG9pbnQgPSAKPCZldG0wX291dF9wb3J0PjsKPiArCQkJCQl9Owo+ICsJCQkJfTsK
PiArCQkJCXBvcnRAMSB7Cj4gKwkJCQkJcmVnID0gPDE+Owo+ICsJCQkJCWNhX2Z1bm5lbF9pbl9w
b3J0MTogZW5kcG9pbnQgCnsKPiArCQkJCQkJcmVtb3RlLWVuZHBvaW50ID0gCjwmZXRtMV9vdXRf
cG9ydD47Cj4gKwkJCQkJfTsKPiArCQkJCX07Cj4gKwkJCQlwb3J0QDIgewo+ICsJCQkJCXJlZyA9
IDwyPjsKPiArCQkJCQljYV9mdW5uZWxfaW5fcG9ydDI6IGVuZHBvaW50IAp7Cj4gKwkJCQkJCXJl
bW90ZS1lbmRwb2ludCA9IAo8JmV0bTJfb3V0X3BvcnQ+Owo+ICsJCQkJCX07Cj4gKwkJCQl9Owo+
ICsJCQkJcG9ydEAzIHsKPiArCQkJCQlyZWcgPSA8Mz47Cj4gKwkJCQkJY2FfZnVubmVsX2luX3Bv
cnQzOiBlbmRwb2ludCAKewo+ICsJCQkJCQlyZW1vdGUtZW5kcG9pbnQgPSAKPCZldG0zX291dF9w
b3J0PjsKPiArCQkJCQl9Owo+ICsJCQkJfTsKPiArCQkJfTsKPiArCQkJb3V0LXBvcnRzIHsKPiAr
CQkJCXBvcnQgewo+ICsJCQkJCWNhX2Z1bm5lbF9vdXRfcG9ydDA6IAplbmRwb2ludCB7Cj4gKwkJ
CQkJCXJlbW90ZS1lbmRwb2ludCA9IAo8Jmh1Z29fZnVubmVsX2luX3BvcnQwPjsKPiArCQkJCQl9
Owo+ICsJCQkJfTsKPiArCQkJfTsKPiArCQl9Owo+ICsKPiArCQlmdW5uZWxAMjhjMDMwMDAgewo+
ICsJCQljb21wYXRpYmxlID0gImFybSxjb3Jlc2lnaHQtZHluYW1pYy1mdW5uZWwiLCAKImFybSxw
cmltZWNlbGwiOwo+ICsJCQlyZWcgPSA8MHgyOGMwMzAwMCAweDEwMDA+Owo+ICsJCQljbG9ja3Mg
PSA8JmNsayBJTVg4TVBfQ0xLX01BSU5fQVhJPjsKPiArCQkJY2xvY2stbmFtZXMgPSAiYXBiX3Bj
bGsiOwo+ICsJCQlpbi1wb3J0cyB7Cj4gKwkJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKPiArCQkJ
CSNzaXplLWNlbGxzID0gPDA+Owo+ICsJCQkJcG9ydEAwIHsKPiArCQkJCQlyZWcgPSA8MD47Cj4g
KwkJCQkJaHVnb19mdW5uZWxfaW5fcG9ydDA6IAplbmRwb2ludCB7Cj4gKwkJCQkJCXJlbW90ZS1l
bmRwb2ludCA9IAo8JmNhX2Z1bm5lbF9vdXRfcG9ydDA+Owo+ICsJCQkJCX07Cj4gKwkJCQl9Owo+
ICsJCQkJcG9ydEAxIHsKPiArCQkJCQlyZWcgPSA8MT47Cj4gKwkJCQkJaHVnb19mdW5uZWxfaW5f
cG9ydDE6IAplbmRwb2ludCB7Cj4gKwkJCQkJLyogTTcgaW5wdXQgKi8KPiArCQkJCQl9Owo+ICsJ
CQkJfTsKPiArCQkJCXBvcnRAMiB7Cj4gKwkJCQkJcmVnID0gPDI+Owo+ICsJCQkJCWh1Z29fZnVu
bmVsX2luX3BvcnQyOiAKZW5kcG9pbnQgewo+ICsJCQkJCS8qIERTUCBpbnB1dCAqLwo+ICsJCQkJ
CX07Cj4gKwkJCQl9Owo+ICsJCQkJLyogdGhlIG90aGVyIGlucHV0IHBvcnRzIGFyZSBub3QgCmNv
bm5lY3QgdG8gYW55dGhpbmcgKi8KPiArCQkJfTsKPiArCQkJb3V0LXBvcnRzIHsKPiArCQkJCXBv
cnQgewo+ICsJCQkJCWh1Z29fZnVubmVsX291dF9wb3J0MDogCmVuZHBvaW50IHsKPiArCQkJCQkJ
cmVtb3RlLWVuZHBvaW50ID0gCjwmZXRmX2luX3BvcnQ+Owo+ICsJCQkJCX07Cj4gKwkJCQl9Owo+
ICsJCQl9Owo+ICsJCX07Cj4gKwo+ICsJCWV0ZkAyOGMwNDAwMCB7CgpUaGUgcmVmZXJlbmNlIG1h
bnVhbCBzdGF0ZXMgIkNYVE1DX0VUQiIgZm9yIHRoaXMgYWRkcmVzcy4gSSBkb24ndCBoYXZlIG11
Y2ggCmtub3dsZWRnZSBhYm91dCBjb3Jlc2lnaHQsIGJ1dCBFVEIgaXMgbm90IHRoZSBzYW1lIGFz
IEVURiwgcmlnaHQ/IFdoaWNoIG9uZSBpcyAKY29ycmVjdD8KCkJlc3QgcmVnYXJkcywKQWxleGFu
ZGVyCgo+ICsJCQljb21wYXRpYmxlID0gImFybSxjb3Jlc2lnaHQtdG1jIiwgCiJhcm0scHJpbWVj
ZWxsIjsKPiArCQkJcmVnID0gPDB4MjhjMDQwMDAgMHgxMDAwPjsKPiArCQkJY2xvY2tzID0gPCZj
bGsgSU1YOE1QX0NMS19NQUlOX0FYST47Cj4gKwkJCWNsb2NrLW5hbWVzID0gImFwYl9wY2xrIjsK
PiArCQkJaW4tcG9ydHMgewo+ICsJCQkJcG9ydCB7Cj4gKwkJCQkJZXRmX2luX3BvcnQ6IGVuZHBv
aW50IHsKPiArCQkJCQkJcmVtb3RlLWVuZHBvaW50ID0gCjwmaHVnb19mdW5uZWxfb3V0X3BvcnQw
PjsKPiArCQkJCQl9Owo+ICsJCQkJfTsKPiArCQkJfTsKPiArCQkJb3V0LXBvcnRzIHsKPiArCQkJ
CXBvcnQgewo+ICsJCQkJCWV0Zl9vdXRfcG9ydDogZW5kcG9pbnQgewo+ICsJCQkJCQlyZW1vdGUt
ZW5kcG9pbnQgPSAKPCZldHJfaW5fcG9ydD47Cj4gKwkJCQkJfTsKPiArCQkJCX07Cj4gKwkJCX07
Cj4gKwkJfTsKPiArCj4gKwkJZXRyQDI4YzA2MDAwIHsKPiArCQkJY29tcGF0aWJsZSA9ICJhcm0s
Y29yZXNpZ2h0LXRtYyIsIAoiYXJtLHByaW1lY2VsbCI7Cj4gKwkJCXJlZyA9IDwweDI4YzA2MDAw
IDB4MTAwMD47Cj4gKwkJCWNsb2NrcyA9IDwmY2xrIElNWDhNUF9DTEtfTUFJTl9BWEk+Owo+ICsJ
CQljbG9jay1uYW1lcyA9ICJhcGJfcGNsayI7Cj4gKwkJCWluLXBvcnRzIHsKPiArCQkJCXBvcnQg
ewo+ICsJCQkJCWV0cl9pbl9wb3J0OiBlbmRwb2ludCB7Cj4gKwkJCQkJCXJlbW90ZS1lbmRwb2lu
dCA9IAo8JmV0Zl9vdXRfcG9ydD47Cj4gKwkJCQkJfTsKPiArCQkJCX07Cj4gKwkJCX07Cj4gKwkJ
fTsKPiArCj4gIAkJYWlwczE6IGJ1c0AzMDAwMDAwMCB7Cj4gIAkJCWNvbXBhdGlibGUgPSAiZnNs
LGFpcHMtYnVzIiwgInNpbXBsZS1idXMiOwo+ICAJCQlyZWcgPSA8MHgzMDAwMDAwMCAweDQwMDAw
MD47CgoKLS0gClRRLVN5c3RlbXMgR21iSCB8IE3DvGhsc3RyYcOfZSAyLCBHdXQgRGVsbGluZyB8
IDgyMjI5IFNlZWZlbGQsIEdlcm1hbnkKQW10c2dlcmljaHQgTcO8bmNoZW4sIEhSQiAxMDUwMTgK
R2VzY2jDpGZ0c2bDvGhyZXI6IERldGxlZiBTY2huZWlkZXIsIFLDvGRpZ2VyIFN0YWhsLCBTdGVm
YW4gU2NobmVpZGVyCmh0dHA6Ly93d3cudHEtZ3JvdXAuY29tLw==




