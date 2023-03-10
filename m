Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA766B3B39
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjCJJrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjCJJqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:46:49 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071E621942;
        Fri, 10 Mar 2023 01:46:31 -0800 (PST)
Received: from [IPv6:2a00:23c6:c311:3401:45a5:b946:dcd1:2820] (unknown [IPv6:2a00:23c6:c311:3401:45a5:b946:dcd1:2820])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 948EF6603050;
        Fri, 10 Mar 2023 09:46:29 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678441589;
        bh=QXugumcwP1Ga/D3ij5tCkSC4/UWHFeOdECPIBpcL+Ic=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=StoAv9fMm06Vmy5IqLIXMVKlR8emax5CNHxTD2elzdbXhpe3mvbFO5ScwkklUM/3m
         rAo7qfiWirD47Dw1ktcOHOyn5rgDISsRFrH4rBgO2Ip88+jp0wjoq2olCDsrgrWqMt
         gBxVietQJ+eYyToS6fEQdVMVTX1jrQv5SCc/wqDcMa8UDw5ILyNhvW7heKHZEfEIrB
         y5VBHHV8L+tgA6SCVAG4gk/Sx7ru2+VMe2LKrpIokNVfLSv5GlBehUB9fIIz3YCcH1
         H/XMGOyJWGIffCAh6HPdVNJWpGP4rpuLjPsi6DVwNYrw816Ac3Z/hO0Np6FuYo68ZY
         pny9AXm8Amrgg==
Message-ID: <a2a51a0a63b7856794ac8fd6889ebf9fcb23f84e.camel@collabora.com>
Subject: Re: [PATCH v3 2/3] remoteproc: k4: Split out functions common with
 M4 driver
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Hari Nagalla <hnagalla@ti.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Date:   Fri, 10 Mar 2023 09:46:26 +0000
In-Reply-To: <400ab507-ff2f-cad8-19c6-66818407bf6d@ti.com>
References: <20230302171450.1598576-1-martyn.welch@collabora.com>
         <20230302171450.1598576-3-martyn.welch@collabora.com>
         <400ab507-ff2f-cad8-19c6-66818407bf6d@ti.com>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTAzLTA5IGF0IDEyOjA0IC0wNjAwLCBIYXJpIE5hZ2FsbGEgd3JvdGU6Cj4g
T24gMy8yLzIzIDExOjE0LCBNYXJ0eW4gV2VsY2ggd3JvdGU6Cj4gPiArICogQHRpX3NjaV9pZDog
VEktU0NJIGRldmljZSBpZGVudGlmaWVyCj4gPiArICogQG1ib3g6IG1haWxib3ggY2hhbm5lbCBo
YW5kbGUKPiA+ICsgKiBAY2xpZW50OiBtYWlsYm94IGNsaWVudCB0byByZXF1ZXN0IHRoZSBtYWls
Ym94IGNoYW5uZWwKPiA+ICsgKiBAaXBjX29ubHk6IGZsYWcgdG8gaW5kaWNhdGUgSVBDLW9ubHkg
bW9kZQo+ID4gKyAqLwo+ID4gK3N0cnVjdCBrM19ycHJvYyB7Cj4gPiArwqDCoMKgwqDCoMKgwqBz
dHJ1Y3QgZGV2aWNlICpkZXY7Cj4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcnByb2MgKnJwcm9j
Owo+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGszX3Jwcm9jX21lbSAqbWVtOwo+ID4gK8KgwqDC
oMKgwqDCoMKgaW50IG51bV9tZW1zOwo+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGszX3Jwcm9j
X21lbSAqcm1lbTsKPiA+ICvCoMKgwqDCoMKgwqDCoGludCBudW1fcm1lbXM7Cj4gPiArwqDCoMKg
wqDCoMKgwqBzdHJ1Y3QgcmVzZXRfY29udHJvbCAqcmVzZXQ7Cj4gPiArwqDCoMKgwqDCoMKgwqBj
b25zdCBzdHJ1Y3QgazNfcnByb2NfZGV2X2RhdGEgKmRhdGE7Cj4gPiArwqDCoMKgwqDCoMKgwqBz
dHJ1Y3QgdGlfc2NpX3Byb2MgKnRzcDsKPiA+ICvCoMKgwqDCoMKgwqDCoGNvbnN0IHN0cnVjdCB0
aV9zY2lfaGFuZGxlICp0aV9zY2k7Cj4gPiArwqDCoMKgwqDCoMKgwqB1MzIgdGlfc2NpX2lkOwo+
ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IG1ib3hfY2hhbiAqbWJveDsKPiA+ICvCoMKgwqDCoMKg
wqDCoHN0cnVjdCBtYm94X2NsaWVudCBjbGllbnQ7Cj4gPiArfTsKPiA+ICsKPiAiaXBjX29ubHki
IG1vZGUgZWxlbWVudCBpcyBtaXNzaW5nIGluIHRoZSBzdHJ1Y3R1cmUuCgpUaGF0J3MgYWRkZWQg
d2l0aCB0aGUgTTRGIGRyaXZlciBpbiB0aGUgbmV4dCBwYXRjaCAtIGl0J3Mgbm90IHBhcnQgb2YK
dGhlIHN0cnVjdHVyZSBpbiB0aGUgRFNQIGRyaXZlci4K

