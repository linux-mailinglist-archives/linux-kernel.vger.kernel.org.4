Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC67658986
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 06:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiL2FXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 00:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiL2FXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 00:23:36 -0500
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3750511A3E;
        Wed, 28 Dec 2022 21:23:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1672291383; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=S/D1jwJHCYVnMs6AAL7M6rO9rybFqGzL7npfFCil7nMljPmHsrJ4oMNKUCgDlsdTo8Sn6cjpQRrrYDHWn0W/+IJELu8LN3S3ylg8UrwVEJHiqN2X2DMyIx/9257mwexfRW43FWen6oHY3E5R0qlMcG1pn61ba8aoBQ/qD4XVfNI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1672291383; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=nnBr/n6lJ5YamGCsuAeKBbZ9w6fJvkjwmLE++C03dWo=; 
        b=S1gvl0IwGAFQ96e69fbpYwWowIIN3rAMBRFwoiOt7TjSqy/6StSMUjBnMZ4fOwDNOzyQ01rrwJOT6387qyuniUxjToyxnV8eWOci8FYpvfqjHVUMQoSFox9Y8XFVPjfTjpW/as+kbTK/HTc2IOxSppp35qOZ5G/yJk2Dbfg6dNk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1672291383;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=nnBr/n6lJ5YamGCsuAeKBbZ9w6fJvkjwmLE++C03dWo=;
        b=Y9bc5X2xlec+BYjpZCL0CVbTKsEoT4ZsVLFCwk+iyadvbciKXMHybs0QJdK8TfV8
        8o9M5WZJQLVJ7M6iq6in2UnuL7nFlo1YW6f6JsGB9lvW8SRqFVgbQEEns/UUE3G62uL
        tmAZ/99vompUzKdwxNzIK26H5I19oCHp7ueUe/U4=
Received: from edelgard.fodlan.icenowy.me (120.85.98.122 [120.85.98.122]) by mx.zohomail.com
        with SMTPS id 1672291381190125.36467730764525; Wed, 28 Dec 2022 21:23:01 -0800 (PST)
Message-ID: <58b64e74466a572d472a13515dd481600dd2c63d.camel@icenowy.me>
Subject: Re: [PATCH] clk: sunxi-ng: h3/h5: Model H3 CLK_DRAM as a fixed clock
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Date:   Thu, 29 Dec 2022 13:22:56 +0800
In-Reply-To: <20221229042230.24532-1-samuel@sholland.org>
References: <20221229042230.24532-1-samuel@sholland.org>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5ZyoIDIwMjItMTItMjjmmJ/mnJ/kuInnmoQgMjI6MjIgLTA2MDDvvIxTYW11ZWwgSG9sbGFuZOWG
memBk++8mgo+IFRoZSBEUkFNIGNvbnRyb2xsZXIgY2xvY2sgaXMgb25seSBhbGxvd2VkIHRvIGNo
YW5nZSBmcmVxdWVuY3kgd2hpbGUKPiB0aGUKPiBEUkFNIGNoaXBzIGFyZSBpbiBzZWxmLXJlZnJl
c2guIFRvIHN1cHBvcnQgdGhpcywgY2hhbmdlcyB0byB0aGUKPiBDTEtfRFJBTQo+IG11eCBhbmQg
ZGl2aWRlciBoYXZlIG5vIGVmZmVjdCB1bnRpbCBhY2tub3dsZWRnZWQgYnkgdGhlIG1lbW9yeQo+
IGR5bmFtaWMKPiBmcmVxdWVuY3kgc2NhbGluZyAoTURGUykgaGFyZHdhcmUgaW5zaWRlIHRoZSBE
UkFNIGNvbnRyb2xsZXIuIChUaGVyZQo+IGlzCj4gYSBTRFJDTEtfVVBEIGJpdCBpbiBEUkFNX0NG
R19SRUcgd2hpY2ggc2hvdWxkIHNlcnZlIGEgc2ltaWxhcgo+IHB1cnBvc2UsCj4gYnV0IHRoaXMg
Yml0IGFjdHVhbGx5IGRvZXMgbm90aGluZy4pCj4gCj4gSG93ZXZlciwgdGhlIE1ERlMgaGFyZHdh
cmUgaW4gSDMgYXBwZWFycyB0byBiZSBicm9rZW4uIFRyaWdnZXJpbmcgYQo+IGZyZXF1ZW5jeSBj
aGFuZ2UgdXNpbmcgdGhlIHByb2NlZHVyZSBmcm9tIHNpbWlsYXIgU29DcyAoQTY0L0g1KSBoYW5n
cwo+IHRoZSBoYXJkd2FyZS4gQWRkaXRpb25hbGx5LCB0aGUgdmVuZG9yIEJTUCBzcGVjaWZpY2Fs
bHkgYXZvaWRzIHVzaW5nCj4gdGhlCj4gTURGUyBoYXJkd2FyZSBvbiBIMywgaW5zdGVhZCBwZXJm
b3JtaW5nIGFsbCBEUkFNIFBIWSBwYXJhbWV0ZXIKPiB1cGRhdGVzCj4gYW5kIHJlc2V0cyBpbiBz
b2Z0d2FyZS4KPiAKPiBUaHVzLCBpdCBpcyBlZmZlY3RpdmVseSBpbXBvc3NpYmxlIHRvIGNoYW5n
ZSB0aGUgQ0xLX0RSQU0KPiBtdXgvZGl2aWRlciwKPiBzbyB0aG9zZSBmZWF0dXJlcyBzaG91bGQg
bm90IGJlIG1vZGVsZWQuIEFkZCBDTEtfU0VUX1JBVEVfUEFSRU5UIHNvCj4gZnJlcXVlbmN5IGNo
YW5nZXMgYXBwbHkgdG8gUExMX0REUiBpbnN0ZWFkLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFNhbXVl
bCBIb2xsYW5kIDxzYW11ZWxAc2hvbGxhbmQub3JnPgo+IC0tLQo+IAo+IMKgZHJpdmVycy9jbGsv
c3VueGktbmcvY2N1LXN1bjhpLWgzLmMgfCAxNSArKysrKysrKysrLS0tLS0KPiDCoDEgZmlsZSBj
aGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2Nsay9zdW54aS1uZy9jY3Utc3VuOGktaDMuYyBiL2RyaXZlcnMvY2xrL3N1bnhp
LQo+IG5nL2NjdS1zdW44aS1oMy5jCj4gaW5kZXggZDNmY2I5ODNjMTdjLi5iZmViZThkYmJlNjUg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9jbGsvc3VueGktbmcvY2N1LXN1bjhpLWgzLmMKPiArKysg
Yi9kcml2ZXJzL2Nsay9zdW54aS1uZy9jY3Utc3VuOGktaDMuYwo+IEBAIC00MzQsOCArNDM0LDEz
IEBAIHN0YXRpYyBTVU5YSV9DQ1VfR0FURSh1c2Jfb2hjaTJfY2xrLMKgwqDCoMKgwqDCoMKgInVz
Yi0KPiBvaGNpMiIswqDCoMKgwqAib3NjMjRNIiwKPiDCoHN0YXRpYyBTVU5YSV9DQ1VfR0FURSh1
c2Jfb2hjaTNfY2xrLMKgwqDCoCJ1c2Itb2hjaTMiLMKgwqDCoMKgIm9zYzI0TSIsCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4MGNjLCBCSVQoMTkpLCAwKTsK
PiDCoAo+IC1zdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IGRyYW1fcGFyZW50c1tdID0geyAicGxs
LWRkciIsICJwbGwtCj4gcGVyaXBoMC0yeCIgfTsKPiAtc3RhdGljIFNVTlhJX0NDVV9NX1dJVEhf
TVVYKGRyYW1fY2xrLCAiZHJhbSIsIGRyYW1fcGFyZW50cywKPiArLyogSDMgaGFzIGJyb2tlbiBN
REZTIGhhcmR3YXJlLCBzbyB0aGUgbXV4L2RpdmlkZXIgY2Fubm90IGJlCj4gY2hhbmdlZC4gKi8K
PiArc3RhdGljIENMS19GSVhFRF9GQUNUT1JfSFcoaDNfZHJhbV9jbGssICJkcmFtIiwKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJnBsbF9kZHJf
Y2xrLmNvbW1vbi5odywKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgMSwgMSwgQ0xLX1NFVF9SQVRFX1BBUkVOVCB8Cj4gQ0xLX0lTX0NSSVRJQ0FM
KTsKClNob3VsZCB3ZSBkbyBzb21lIHNhbml0eSBjaGVjayBvbiB0aGUgdmFsdWVzIHdoZW4gcHJv
YmluZyBDQ1U/Cgo+ICsKPiArc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBoNV9kcmFtX3BhcmVu
dHNbXSA9IHsgInBsbC1kZHIiLCAicGxsLQo+IHBlcmlwaDAtMngiIH07Cj4gK3N0YXRpYyBTVU5Y
SV9DQ1VfTV9XSVRIX01VWChoNV9kcmFtX2NsaywgImRyYW0iLCBoNV9kcmFtX3BhcmVudHMsCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4
MGY0LCAwLCA0LCAyMCwgMiwgQ0xLX0lTX0NSSVRJQ0FMKTsKPiDCoAo+IMKgc3RhdGljIFNVTlhJ
X0NDVV9HQVRFKGRyYW1fdmVfY2xrLMKgwqDCoMKgwqAiZHJhbS12ZSIswqDCoMKgwqDCoMKgImRy
YW0iLAo+IEBAIC01OTIsNyArNTk3LDcgQEAgc3RhdGljIHN0cnVjdCBjY3VfY29tbW9uICpzdW44
aV9oM19jY3VfY2xrc1tdID0gewo+IMKgwqDCoMKgwqDCoMKgwqAmdXNiX29oY2kxX2Nsay5jb21t
b24sCj4gwqDCoMKgwqDCoMKgwqDCoCZ1c2Jfb2hjaTJfY2xrLmNvbW1vbiwKPiDCoMKgwqDCoMKg
wqDCoMKgJnVzYl9vaGNpM19jbGsuY29tbW9uLAo+IC3CoMKgwqDCoMKgwqDCoCZkcmFtX2Nsay5j
b21tb24sCj4gK8KgwqDCoMKgwqDCoMKgJmg1X2RyYW1fY2xrLmNvbW1vbiwKPiDCoMKgwqDCoMKg
wqDCoMKgJmRyYW1fdmVfY2xrLmNvbW1vbiwKPiDCoMKgwqDCoMKgwqDCoMKgJmRyYW1fY3NpX2Ns
ay5jb21tb24sCj4gwqDCoMKgwqDCoMKgwqDCoCZkcmFtX2RlaW50ZXJsYWNlX2Nsay5jb21tb24s
Cj4gQEAgLTczMiw3ICs3MzcsNyBAQCBzdGF0aWMgc3RydWN0IGNsa19od19vbmVjZWxsX2RhdGEK
PiBzdW44aV9oM19od19jbGtzID0gewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
W0NMS19VU0JfT0hDSTFdwqDCoMKgwqDCoMKgwqDCoMKgPSAmdXNiX29oY2kxX2Nsay5jb21tb24u
aHcsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBbQ0xLX1VTQl9PSENJMl3CoMKg
wqDCoMKgwqDCoMKgwqA9ICZ1c2Jfb2hjaTJfY2xrLmNvbW1vbi5odywKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoFtDTEtfVVNCX09IQ0kzXcKgwqDCoMKgwqDCoMKgwqDCoD0gJnVz
Yl9vaGNpM19jbGsuY29tbW9uLmh3LAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBb
Q0xLX0RSQU1dwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoD0gJmRyYW1fY2xrLmNvbW1vbi5o
dywKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgW0NMS19EUkFNXcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqA9ICZoM19kcmFtX2Nsay5odywKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoFtDTEtfRFJBTV9WRV3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgPSAmZHJhbV92
ZV9jbGsuY29tbW9uLmh3LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgW0NMS19E
UkFNX0NTSV3CoMKgwqDCoMKgwqDCoMKgwqDCoD0gJmRyYW1fY3NpX2Nsay5jb21tb24uaHcsCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBbQ0xLX0RSQU1fREVJTlRFUkxBQ0VdwqDC
oD0KPiAmZHJhbV9kZWludGVybGFjZV9jbGsuY29tbW9uLmh3LAo+IEBAIC04NDgsNyArODUzLDcg
QEAgc3RhdGljIHN0cnVjdCBjbGtfaHdfb25lY2VsbF9kYXRhCj4gc3VuNTBpX2g1X2h3X2Nsa3Mg
PSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBbQ0xLX1VTQl9PSENJMV3CoMKg
wqDCoMKgwqDCoMKgwqA9ICZ1c2Jfb2hjaTFfY2xrLmNvbW1vbi5odywKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoFtDTEtfVVNCX09IQ0kyXcKgwqDCoMKgwqDCoMKgwqDCoD0gJnVz
Yl9vaGNpMl9jbGsuY29tbW9uLmh3LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
W0NMS19VU0JfT0hDSTNdwqDCoMKgwqDCoMKgwqDCoMKgPSAmdXNiX29oY2kzX2Nsay5jb21tb24u
aHcsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFtDTEtfRFJBTV3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgPSAmZHJhbV9jbGsuY29tbW9uLmh3LAo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBbQ0xLX0RSQU1dwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoD0g
Jmg1X2RyYW1fY2xrLmNvbW1vbi5odywKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oFtDTEtfRFJBTV9WRV3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgPSAmZHJhbV92ZV9jbGsuY29tbW9u
Lmh3LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgW0NMS19EUkFNX0NTSV3CoMKg
wqDCoMKgwqDCoMKgwqDCoD0gJmRyYW1fY3NpX2Nsay5jb21tb24uaHcsCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBbQ0xLX0RSQU1fREVJTlRFUkxBQ0VdwqDCoD0KPiAmZHJhbV9k
ZWludGVybGFjZV9jbGsuY29tbW9uLmh3LAoK

