Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CEE6B66B9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjCLNcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjCLNcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:32:04 -0400
Received: from smtp49.naquadria.it (smtp49.naquadria.it [185.54.213.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D2434024
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:31:57 -0700 (PDT)
Received: from smtp.naquadria.it (smtp [10.0.0.237])
        by smtp40.naquadria.it (Postfix) with ESMTP id 897204826D9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 14:31:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intre.it; s=default;
        t=1678627908; bh=TDAhlJYS/S3QF2NjrPj7530Cq6PEonKEfEgL5D1ZIX8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=itGNp5IN5so3RECRXeKlGer7N96a3EgTQ/ffHPw0/fY4aoC/2e0fS9DzQ6k4fve1w
         WmMm3cZJ2B6XscHoBvVIP9FXcbIHx21L3yhZQxQiaFVu4JvZQAZQLYxCUFyGYv/w5a
         l/fnx9LWKcyYCK2Fhfr7WmpjgJG70hCw+I4CVkjQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=intre.it; s=mail;
        t=1678627904; bh=TDAhlJYS/S3QF2NjrPj7530Cq6PEonKEfEgL5D1ZIX8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=UC3ZtlvkSX8pL0Y+idp/SCS70hH6wtTWN6cVeN7JFeGsRMcLwuw1DpPtW34z4V83m
         jY0em0IEdCoXnGrasUL0iepx/X5z7dRoYpTixHdlxnTXkVWs7iax7VEntg7OFVt3Tq
         hoCdQMIHivUTZmHcOURuJQIWM/hBIV71RncXM6Bg=
From:   Ornaghi Davide <davide.ornaghi@intre.it>
To:     Jere Viikari <jere.viikari@gmail.com>
CC:     Kees Cook <kees@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: R: [RFC PATCH] Introduce per-interrupt kernel-stack randomization
Thread-Topic: [RFC PATCH] Introduce per-interrupt kernel-stack randomization
Thread-Index: AQHZUsnUS1bJ0/NeckG7hJSc9SaMEa70GNEAgAG5L5CAAFD5AIABA1AQ
Date:   Sun, 12 Mar 2023 13:32:04 +0000
Message-ID: <414aee3992a54b6c933597bdbf9e0f71@intre.it>
References: <ef2c926cf7b148028f1902279cb35a41@intre.it>
 <906901ED-DAE3-4A36-A3E4-16DF6F251C48@kernel.org>
 <c2d598d5a11d4a29815a4eca63606159@intre.it>
 <CALDd4YW6_Vw=VHaxzZiLjhr9w+tqbVmCaXKGiUFMeKbWxkiRxg@mail.gmail.com>
In-Reply-To: <CALDd4YW6_Vw=VHaxzZiLjhr9w+tqbVmCaXKGiUFMeKbWxkiRxg@mail.gmail.com>
Accept-Language: it-IT, en-US
Content-Language: it-IT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.140.1]
x-c2processedorg: 3c642b5e-0ab0-4568-9f09-fc6a11a1a8a0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1NZXNzYWdnaW8gb3JpZ2luYWxlLS0tLS0NCj4gRGE6IEplcmUgVmlpa2FyaSA8
amVyZS52aWlrYXJpQGdtYWlsLmNvbT4NCj4gSW52aWF0bzogc2FiYXRvIDExIG1hcnpvIDIwMjMg
MjM6NTYNCj4gQTogT3JuYWdoaSBEYXZpZGUgPGRhdmlkZS5vcm5hZ2hpQGludHJlLml0Pg0KPiBD
YzogS2VlcyBDb29rIDxrZWVzQGtlcm5lbC5vcmc+OyBrZWVzY29va0BjaHJvbWl1bS5vcmc7DQo+
IHBhdWxtY2tAa2VybmVsLm9yZzsgbnNhZW56anVAcmVkaGF0LmNvbTsgcGV0ZXJ6QGluZnJhZGVh
ZC5vcmc7DQo+IGJpZ2Vhc3lAbGludXRyb25peC5kZTsgZnJlZGVyaWNAa2VybmVsLm9yZzsgbGlu
dXgtaGFyZGVuaW5nQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZw0KPiBPZ2dldHRvOiBSZTogW1JGQyBQQVRDSF0gSW50cm9kdWNlIHBlci1pbnRlcnJ1cHQg
a2VybmVsLXN0YWNrIHJhbmRvbWl6YXRpb24NCj4gDQo+IEkgYW0gY29uY2VybmVkIGFib3V0IHRo
ZSBkaXNjbGFpbWVyLiBXaGVuIEkgcmVwbGllZCwgSSBoYWQgYWxzbyB0byByZW1vdmUgYWxsDQo+
IG90aGVyIGluZm9ybWF0aW9uIHRvIGVuc3VyZSB0aGF0IEkgZGlkIG5vdCB2aW9sYXRlIHRoZSB0
ZXJtcy4NCj4gDQoNClNvcnJ5LCBJdGFsaWFuIHJlZ3VsYXRpb25zIHRoYXQgb2J2aW91c2x5IGRv
bid0IGFwcGx5IHRvIHB1YmxpYyBtYWlsaW5nIGxpc3RzLi4uDQpUaGUgZGlzY2xhaW1lciBzaG91
bGQgYmUgZ29uZSBub3csIHNvIHlvdSBjYW4gcmVwbHkgdG8gdGhpcyB0aHJlYWQgaWYgeW91IHBy
ZWZlci4NCg0KLSBEYXZpZGUNCg0KPiA+IE5vdGEgaW5mb3JtYXRpdmE6IEluIG90dGVtcGVyYW56
YSBkZWxsYSBMZWdnZSAxOTYvMjAwMyBlIGFsIFJlZ29sYW1lbnRvDQo+IFVFIDY3OS8yMDE2IChH
RFBSKSBzdWxsYSB0dXRlbGEgZGVpIGRhdGkgcGVyc29uYWxpLCBsZSBpbmZvcm1hemlvbmkgY29u
dGVudXRlDQo+IGluIHF1ZXN0byBtZXNzYWdnaW8gc29ubyBzdHJldHRhbWVudGUgcmlzZXJ2YXRl
IGUgc29ubyBlc2NsdXNpdmFtZW50ZQ0KPiBpbmRpcml6emF0ZSBhbCBkZXN0aW5hdGFyaW8gaW5k
aWNhdG8gKG9wcHVyZSBhbGxhIHBlcnNvbmEgcmVzcG9uc2FiaWxlIGRpDQo+IHJpbWV0dGVybG8g
YWwgZGVzdGluYXRhcmlvKS4gTGUgaWRlZSBlIG9waW5pb25pIGVzcHJlc3NlIHNvbm8gcXVlbGxl
IGRlbGzigJlhdXRvcmUgZSwNCj4gYSBtZW5vIGNoZSBub24gc2lhIGNoaWFyYW1lbnRlIHNjcml0
dG8sIG5vbiByYXBwcmVzZW50YW5vIG5lY2Vzc2FyaWFtZW50ZQ0KPiBxdWVsbGUgZGkgSW50csOp
IFMuci5sLiBRdWFsc2lhc2kgdXNvLCByaXByb2R1emlvbmUgbyBkaXZ1bGdhemlvbmUgZGkgcXVl
c3RvDQo+IG1lc3NhZ2dpbyBlJyB2aWV0YXRhLCBhbmNoZSBhaSBzZW5zaSBkZWxs4oCZYXJ0LiA2
MTYgYy5wLiBpdGFsaWFuby4gTmVsIGNhc28gaW4gY3VpDQo+IGF2ZXN0ZSByaWNldnV0byBxdWVz
dGEgZS1tYWlsIHBlciBlcnJvcmUsIHZvZ2xpYXRlIGF2dmVydGlyY2kgYWwgcGl1JyBwcmVzdG8g
YQ0KPiBtZXp6byBwb3N0YSBlbGV0dHJvbmljYSBhbGzigJlpbmRpcml6em8gcHJpdmFjeUBpbnRy
ZS5pdCBlIGRpc3RydWdnZXJlIGlsIHByZXNlbnRlDQo+IG1lc3NhZ2dpby4NCj4gPiBQbGVhc2Ug
bm90ZTogSW4gcmVmZXJlbmNlIHRvIEl0YWxpYW4gbGF3IDE5Ni8yMDAzIGFuZCB0byB0aGUgUmVn
dWxhdGlvbiBFVQ0KPiA2NzkvMjAxNiAoR0RQUiksIHRoaXMgZW1haWwgdHJhbnNtaXNzaW9uIGlu
Y2x1ZGluZyBpdHMgYXR0YWNobWVudHMsIGlzDQo+IGludGVuZGVkIG9ubHkgZm9yIHRoZSBwZXJz
b24gb3IgZW50aXR5IHRvIHdoaWNoIGl0IGlzIGFkZHJlc3NlZCBhbmQgbWF5DQo+IGNvbnRhaW4g
Y29uZmlkZW50aWFsIGFuZC9vciBwcml2aWxlZ2VkIG1hdGVyaWFsLiBBbnkgdmlld3Mgb3Igb3Bp
bmlvbnMgYXJlDQo+IHNvbGVseSB0aG9zZSBvZiB0aGUgYXV0aG9yIGFuZCBkbyBub3QgbmVjZXNz
YXJpbHkgcmVwcmVzZW50IHRob3NlIG9mIEludHLDqSBTLnIubC4sDQo+IHVubGVzcyBzcGVjaWZp
Y2FsbHkgc3RhdGVkLiBBbnkgcmV2aWV3LCByZXRyYW5zbWlzc2lvbiwgZGlzc2VtaW5hdGlvbiBv
ciBvdGhlcg0KPiB1c2Ugb2YsIG9yIHRha2luZyBvZiBhbnkgYWN0aW9uIGluIHJlbGlhbmNlIHVw
b24sIHRoaXMgaW5mb3JtYXRpb24gYnkgcGVyc29ucyBvcg0KPiBlbnRpdGllcyBvdGhlciB0aGFu
IHRoZSBpbnRlbmRlZCByZWNpcGllbnQgaXMgcHJvaGliaXRlZC4gSWYgeW91IHJlY2VpdmVkIHRo
aXMNCj4gZW1haWwgZHVlIHRvIGFuIGVycm9yLCBwbGVhc2UgY29udGFjdCB0aGUgc2VuZGVyIHZp
YSBlLW1haWwgdG8gdGhlIGFkZHJlc3MNCj4gcHJpdmFjeUBpbnRyZS5pdCBhbmQgZGVsZXRlIHRo
ZSBlbWFpbCB0cmFuc21pc3Npb24gaW1tZWRpYXRlbHkuDQo+IA0KPiBHb29nbGUgdHJhbnNsYXRp
b24gaW4gRW5nbGlzaDoNCj4gDQo+IEluZm9ybWF0aW9uIG5vdGU6IEluIGNvbXBsaWFuY2Ugd2l0
aCBMYXcgMTk2LzIwMDMgYW5kIEVVIFJlZ3VsYXRpb24NCj4gNjc5LzIwMTYgKEdEUFIpIG9uIHRo
ZSBwcm90ZWN0aW9uIG9mIHBlcnNvbmFsIGRhdGEsIHRoZSBpbmZvcm1hdGlvbg0KPiBjb250YWlu
ZWQgaW4gdGhpcyBtZXNzYWdlIGlzIHN0cmljdGx5IGNvbmZpZGVudGlhbCBhbmQgaXMgZXhjbHVz
aXZlbHkgYWRkcmVzc2VkIHRvDQo+IHRoZSBpbmRpY2F0ZWQgcmVjaXBpZW50IChvciB0byB0aGUg
cGVyc29uIHJlc3BvbnNpYmxlIGZvciBmb3J3YXJkaW5nIGl0IHRvIHRoZQ0KPiByZWNpcGllbnQp
LiBUaGUgaWRlYXMgYW5kIG9waW5pb25zIGV4cHJlc3NlZCBhcmUgdGhvc2Ugb2YgdGhlIGF1dGhv
ciBhbmQsDQo+IHVubGVzcyBjbGVhcmx5IHN0YXRlZCwgZG8gbm90IG5lY2Vzc2FyaWx5IHJlcHJl
c2VudCB0aG9zZSBvZiBJbnRyw6kgUy5yLmwuIEFueSB1c2UsDQo+IHJlcHJvZHVjdGlvbiBvciBk
aXNjbG9zdXJlIG9mIHRoaXMgbWVzc2FnZSBpcyBwcm9oaWJpdGVkLCBhbHNvIHB1cnN1YW50IHRv
IGFydC4NCj4gNjE2IGNyaW1pbmFsIGNvZGUgSXRhbGlhbi4gSWYgeW91IGhhdmUgcmVjZWl2ZWQg
dGhpcyBlLW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkNCj4gdXMgYXMgc29vbiBhcyBwb3Nz
aWJsZSBieSBlLW1haWwgYXQgcHJpdmFjeUBpbnRyZS5pdCBhbmQgZGVzdHJveSB0aGlzIG1lc3Nh
Z2UuDQo+IFBsZWFzZSBub3RlOiBJbiByZWZlcmVuY2UgdG8gSXRhbGlhbiBsYXcgMTk2LzIwMDMg
YW5kIHRvIHRoZSBSZWd1bGF0aW9uIEVVDQo+IDY3OS8yMDE2IChHRFBSKSwgdGhpcyBlbWFpbCB0
cmFuc21pc3Npb24gaW5jbHVkaW5nIGl0cyBhdHRhY2htZW50cywgaXMNCj4gaW50ZW5kZWQgb25s
eSBmb3IgdGhlIHBlcnNvbiBvciBlbnRpdHkgdG8gd2hpY2ggaXQgaXMgYWRkcmVzc2VkIGFuZCBt
YXkNCj4gY29udGFpbiBjb25maWRlbnRpYWwgYW5kL29yIHByaXZpbGVnZWQgbWF0ZXJpYWwuIEFu
eSB2aWV3cyBvciBvcGluaW9ucyBhcmUNCj4gc29sZWx5IHRob3NlIG9mIHRoZSBhdXRob3IgYW5k
IGRvIG5vdCBuZWNlc3NhcmlseSByZXByZXNlbnQgdGhvc2Ugb2YgSW50csOpIFMuci5sLiwNCj4g
dW5sZXNzIHNwZWNpZmljYWxseSBzdGF0ZWQuIEFueSByZXZpZXcsIHJldHJhbnNtaXNzaW9uLCBk
aXNzZW1pbmF0aW9uIG9yIG90aGVyDQo+IHVzZSBvZiwgb3IgdGFraW5nIG9mIGFueSBhY3Rpb24g
aW4gcmVsaWFuY2UgdXBvbiwgdGhpcyBpbmZvcm1hdGlvbiBieSBwZXJzb25zIG9yDQo+IGVudGl0
aWVzIG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lwaWVudCBpcyBwcm9oaWJpdGVkLiBJZiB5
b3UgcmVjZWl2ZWQgdGhpcw0KPiBlbWFpbCBkdWUgdG8gYW4gZXJyb3IsIHBsZWFzZSBjb250YWN0
IHRoZSBzZW5kZXIgdmlhIGVtYWlsIHRvIHRoZSBhZGRyZXNzDQo+IHByaXZhY3lAaW50cmUuaXQg
YW5kIGRlbGV0ZSB0aGUgZW1haWwgdHJhbnNtaXNzaW9uIGltbWVkaWF0ZWx5Lg0KPiANCj4gLUpl
cmUNCg==
