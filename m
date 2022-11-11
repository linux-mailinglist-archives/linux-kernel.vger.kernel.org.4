Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A710A625B12
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 14:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbiKKNQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 08:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbiKKNQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 08:16:45 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5504D7298A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 05:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1668172603;
  x=1699708603;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UGId/xbBvvbV09vLsI6ZjJlsM6NHPh4oFHruzL5CqcQ=;
  b=YLd5gjWMitBvHSvOnulYw4T6gKNEhKM68iMGgkOYmZZ+hVoZMsXt+qoQ
   VAluEkSxehHZXeWINXNGWQNxFGGck800CWULLJmUrN0aIqZ9No0Cw5bsx
   AUxQjgYjSphmWLm6cb+a6ZWSENbQhnSOGTk+oSdG5CQzOfqjB9jUc0Hju
   Q1Bf1PJrOvcGWC8DwuibfDYSpINR03+vXu9nPwCbQ55DIGGLD2DT3FjFJ
   DCEoz6/Y9koGUi+a9i+usBn97UMpnbqYx5v5StKHUqYvVpO3xMFC/dDjo
   lMu+6I5oQ2TlNKqUS5NuwB3l/Xg/aFYB08KWcmtID1qA2LDyW+tyPmPft
   w==;
From:   =?utf-8?B?THVkdmlnIFDDpHJzc29u?= <Ludvig.Parsson@axis.com>
To:     "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        =?utf-8?B?THVkdmlnIFDDpHJzc29u?= <Ludvig.Parsson@axis.com>
CC:     "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
Subject: Re: [PATCH] tee: optee: Populate child nodes in probe function
Thread-Topic: [PATCH] tee: optee: Populate child nodes in probe function
Thread-Index: AQHY9FVbeqfP3YVtpkqNWltUYufXla437AcAgAAVOICAAW1fAIAAN58A
Date:   Fri, 11 Nov 2022 13:16:41 +0000
Message-ID: <02a899a1807274e2d0fa20e0d6059db00839d9ec.camel@axis.com>
References: <20221109160708.507481-1-ludvig.parsson@axis.com>
         <CAFA6WYPxTET4mUQ4YHosbPN1o0UthP6PU=t8bAp91GZL+5rjRA@mail.gmail.com>
         <df564dc6ffbddcae12bd345b7a0525e586aba5ed.camel@axis.com>
         <CAFA6WYPgW0ya3+yiD49QH3q4nLj1rUyEPye_x2engtihYVaNuA@mail.gmail.com>
In-Reply-To: <CAFA6WYPgW0ya3+yiD49QH3q4nLj1rUyEPye_x2engtihYVaNuA@mail.gmail.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.5.60]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8830FE8A3134B44C933524261BB7C127@exhub.se.axis.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTExLTExIGF0IDE1OjI3ICswNTMwLCBTdW1pdCBHYXJnIHdyb3RlOg0KPiBP
biBUaHUsIDEwIE5vdiAyMDIyIGF0IDE3OjM5LCBMdWR2aWcgUMOkcnNzb24NCj4gPEx1ZHZpZy5Q
YXJzc29uQGF4aXMuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBUaHUsIDIwMjItMTEtMTAgYXQg
MTY6MjMgKzA1MzAsIFN1bWl0IEdhcmcgd3JvdGU6DQo+ID4gPiBPbiBXZWQsIDkgTm92IDIwMjIg
YXQgMjE6MzcsIEx1ZHZpZyBQw6Ryc3NvbiA8IA0KPiA+ID4gbHVkdmlnLnBhcnNzb25AYXhpcy5j
b20+DQo+ID4gPiB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+IEN1cnJlbnRseSB0aGVyZSBpcyBu
byBkZXBlbmRlbmN5IGJldHdlZW4gdGhlICJsaW5hcm8sc2NtaS0NCj4gPiA+ID4gb3B0ZWUiDQo+
ID4gPiA+IGRyaXZlcg0KPiA+ID4gPiBhbmQgdGhlIHRlZV9jb3JlLiBJZiB0aGUgc2NtaS1vcHRl
ZSBkcml2ZXIgZ2V0cyBwcm9iZWQgYmVmb3JlDQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiB0ZWVfYnVz
X3R5cGUgaXMgaW5pdGlhbGl6ZWQsIHRoZW4gd2Ugd2lsbCBnZXQgYW4gdW53YW50ZWQgZXJyb3IN
Cj4gPiA+ID4gcHJpbnQuDQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBXaGF0IGVycm9yIHByaW50
IGRvIHlvdSBvYnNlcnZlPyBJIHN1cHBvc2UgdGhpcyBjYXNlIGlzIGFscmVhZHkNCj4gPiA+IGhh
bmRsZWQgYnkgc2NtaSBvcHRlZSBkcml2ZXIgdmlhIC1FUFJPQkVfREVGRVIuDQo+ID4gPiANCj4g
PiA+IC1TdW1pdA0KPiA+ID4gDQo+ID4gSGkgU3VtaXQsDQo+ID4gDQo+ID4gVGhlIGVycm9yIHBy
aW50IGlzIGluIGRyaXZlcl9yZWdpc3RlcigpLg0KPiA+IA0KPiA+IFRoaXMgaXMga2luZCBvZiB3
aGF0IGhhcHBlbnM6DQo+ID4gc2NtaV9kcml2ZXJfaW5pdCgpDQo+ID4gc2NtaV9wcm9iZSgpDQo+
ID4gwqDCoMKgIHNjbWlfb3B0ZWVfbGlua19zdXBwbGllcigpDQo+ID4gwqDCoMKgwqDCoMKgwqAg
c2NtaV9vcHRlZV9pbml0KCkNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRyaXZlcl9yZWdp
c3RlcigpIDwtLS0gcHJfZXJyKCkgaWYgdGVlX2J1c190eXBlIGlzIG5vdA0KPiA+IGluaXRpYWxp
emVkDQo+ID4gdGVlX2luaXQoKSA8LS0tIHRlZV9idXNfdHlwZSBnZXRzIGluaXRpYWxpemVkIGhl
cmUNCj4gPiANCj4gPiBUaGUgc2NtaV9vcHRlZV9saW5rX3N1cHBsaWVyKCkgd2lsbCBhbHdheXMg
cmV0dXJuIC1FUFJPQkVfREVGRVIgdGhlDQo+ID4gZmlyc3QgdGltZSBiZWNhdXNlIHNjbWlfb3B0
ZWVfcHJpdmF0ZSBpcyBpbml0aWFsaXplZCBpbg0KPiA+IHNjbWlfb3B0ZWVfc2VydmljZV9wcm9i
ZSwgd2hpY2ggaXMgb25seSBjYWxsZWQgYWZ0ZXIgdGhlIGRyaXZlciBpcw0KPiA+IHJlZ2lzdGVy
ZWQgaW4gc2NtaV9vcHRlZV9pbml0LiBSaWdodCBub3cgdGhlIGRyaXZlcl9yZWdpc3RlciBmYWls
cw0KPiA+IGJlY2F1c2UgdGVlX2J1c190eXBlIGlzIG5vdCBpbml0aWFsaXplZCB3aGljaCBpcyBw
cmludGluZyB0aGUNCj4gPiB1bndhbnRlZA0KPiA+IGVycm9yIHByaW50LiBBbm90aGVyIHNpZGUg
ZWZmZWN0IG9mIHRoaXMgaXMgdGhhdA0KPiA+IHNjbWlfb3B0ZWVfbGlua19zdXBwbGllcigpIHdp
bGwgcmV0dXJuIC1FUFJPQkVfREVGRVIgYSBzZWNvbmQgdGltZSwNCj4gPiBhbmQNCj4gPiBzY21p
X3Byb2JlIHdpbGwgYmUgc3VjY2Vzc2Z1bCB0aGUgdGhpcmQgdGltZSBpbnN0ZWFkIG9mIHRoZSBz
ZWNvbmQNCj4gPiB0aW1lLg0KPiANCj4gVGhhbmtzIGZvciB0aGUgcmVwb3J0LiBJdCByYXRoZXIg
bG9va3MgbGlrZSBhbiBpbnRlciBzdWJzeXN0ZW0NCj4gZGVwZW5kZW5jeSBwcm9ibGVtLiBDaGVj
ayBpZiB0aGlzIFsxXSBwYXRjaCByZXNvbHZlcyB5b3VyIHByb2JsZW0/DQo+IA0KPiBbMV0gaHR0
cHM6Ly9sa21sLm9yZy9sa21sLzIwMjIvMTEvMTEvMzI5DQo+IA0KPiAtU3VtaXQNCj4gDQpZZXMs
IHRoaXMgc29sdmVzIHRoZSBwcm9ibGVtLCBidXQgSSBkb24ndCB0aGluayB0aGUgbWFpbnRhaW5l
ciBmb3IgdGhlDQpTQ01JIHN1YnN5c3RlbSBsaWtlcyB0aGUgc29sdXRpb24uIEVhcmxpZXIgdGhp
cyB3ZWVrIEkgZGlzY3Vzc2VkIHRoaXMNCnByb2JsZW0gd2l0aCBTdWRlZXAsIENyaXN0aWFuIGFu
ZCBFdGllbm5lIHRoYXQgYXJlIENDZWQgaW4gdGhlDQpzdWJtaXNzaW9uIHlvdSBsaW5rZWQuIENo
YW5naW5nIHRoZSBpbml0Y2FsbCBsZXZlbCB3YXMgb25lIG9mIG15DQpzdWdnZXN0aW9ucyB3aGlj
aCBnb3QgaW5zdGFudGx5IHJlamVjdGVkLiBXZSBhZ3JlZWQgdGhhdCB0aGUgc29sdXRpb24NCmlu
IHRoZSBwYXRjaCBpIHN1Ym1pdHRlZCB3YXMgcHJvYmFibHkgdGhlIGJlc3Qgb25lLCBidXQgbWF5
YmUgdGhleSB3aWxsDQpjaGFuZ2UgdGhlaXIgbWluZHMuDQoNCkJSLA0KTHVkdmlnDQoNCj4gPiAN
Cj4gPiBCUiwNCj4gPiBMdWR2aWcNCj4gPiANCj4gPiA+ID4gVGhpcyBwYXRjaCBlbmFibGVzIHB1
dHRpbmcgc2NtaS1vcHRlZSBub2RlcyBhcyBjaGlsZHJlbiB0byB0aGUNCj4gPiA+ID4gb3B0ZWUN
Cj4gPiA+ID4gbm9kZSBpbiBkZXZpY2V0cmVlLCB3aGljaCBpbmRpcmVjdGx5IGNyZWF0ZXMgdGhl
IG1pc3NpbmcNCj4gPiA+ID4gZGVwZW5kZW5jeS4NCj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IEx1ZHZpZyBQw6Ryc3NvbiA8bHVkdmlnLnBhcnNzb25AYXhpcy5jb20+DQo+ID4gPiA+
IC0tLQ0KPiA+ID4gPiDCoGRyaXZlcnMvdGVlL29wdGVlL3NtY19hYmkuYyB8IDUgKysrKysNCj4g
PiA+ID4gwqAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+ID4gPiA+IA0KPiA+ID4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90ZWUvb3B0ZWUvc21jX2FiaS5jDQo+ID4gPiA+IGIvZHJp
dmVycy90ZWUvb3B0ZWUvc21jX2FiaS5jDQo+ID4gPiA+IGluZGV4IGExYzFmYTFhOWMyOC4uYmU2
ZjAyZmQ1YTdmIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3RlZS9vcHRlZS9zbWNfYWJp
LmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy90ZWUvb3B0ZWUvc21jX2FiaS5jDQo+ID4gPiA+IEBA
IC0xNTMzLDYgKzE1MzMsMTEgQEAgc3RhdGljIGludCBvcHRlZV9wcm9iZShzdHJ1Y3QNCj4gPiA+
ID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCBpZiAocmMp
DQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycl9kaXNhYmxl
X3NobV9jYWNoZTsNCj4gPiA+ID4gDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqAgLyogUG9wdWxhdGUg
YW55IGRlcGVuZGVudCBjaGlsZCBub2RlIChpZiBhbnkpICovDQo+ID4gPiA+ICvCoMKgwqDCoMKg
wqAgcmMgPSBkZXZtX29mX3BsYXRmb3JtX3BvcHVsYXRlKCZwZGV2LT5kZXYpOw0KPiA+ID4gPiAr
wqDCoMKgwqDCoMKgIGlmIChyYykNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZ290byBlcnJfZGlzYWJsZV9zaG1fY2FjaGU7DQo+ID4gPiA+ICsNCj4gPiA+ID4gwqDCoMKg
wqDCoMKgwqAgcHJfaW5mbygiaW5pdGlhbGl6ZWQgZHJpdmVyXG4iKTsNCj4gPiA+ID4gwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIDA7DQo+ID4gPiA+IA0KPiA+ID4gPiAtLQ0KPiA+ID4gPiAyLjMwLjIN
Cj4gPiA+ID4gDQo+ID4gDQoNCg==
