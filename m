Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD7163D1D1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbiK3J1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbiK3J1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:27:47 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD8E28710;
        Wed, 30 Nov 2022 01:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1669800465;
  x=1701336465;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1y8QECB4tD4m9RoWUHsKvvvPOkhmnzx/LTx/KkEgaFs=;
  b=BLCySY3yWEBCcBIl7fDOkKvuWj6RPrebPThxT4gz/LRnBBMu2K0OABBn
   geS6m9mRCUH/qx6BNxhpjscj/zOb8lnTYHSUtVKZahRyQFm4rFlXUaKDt
   e/ZTEKXxzidmb35PWUoI7ITGToWiwtsfkFTeJYaqbCMWao4QF9pSWDCzq
   RPFh6BEvmsJ7zcTwzL6GnYEnGNotJc//L+ngG/jMUOBDQdsPFGaJMTlgk
   aGZO5vN/buW5vYvtvwp48RB77vy+uFAsGVMsjz/Xi/sry6BPueFG8uwwz
   XLR0r2/2VYFrpUgp/hqo6EhA/3YoJrZsU2gpD8zPHzMshr8XHd7kgehsT
   g==;
From:   Hermes Zhang <Hermes.Zhang@axis.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
CC:     kernel <kernel@axis.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hermes Zhang <Hermes.Zhang@axis.com>
Subject: Re: [PATCH] power: supply: bq256xx: Remove init ichg/vbat with max
 value
Thread-Topic: [PATCH] power: supply: bq256xx: Remove init ichg/vbat with max
 value
Thread-Index: AQHZA9EmYBH5aDLerkKG2mvQfE9eNq5V9biAgAEt4AA=
Date:   Wed, 30 Nov 2022 09:27:42 +0000
Message-ID: <60ca0aa6-508a-4350-f892-98d1368e3783@axis.com>
References: <20221129090112.3451501-1-chenhuiz@axis.com>
 <20221129152715.4hwtobuv57hrndzu@mercury.elektranox.org>
In-Reply-To: <20221129152715.4hwtobuv57hrndzu@mercury.elektranox.org>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
x-originating-ip: [10.0.5.60]
Content-Type: text/plain; charset="utf-8"
Content-ID: <20646CE5E4D40646B190A8A596CAB197@exhub.se.axis.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCuWcqCAyMDIyLzExLzI5IDIzOjI3LCBTZWJhc3RpYW4gUmVpY2hlbCDlhpnpgZM6DQo+
IEhpLA0KPg0KPiBPbiBUdWUsIE5vdiAyOSwgMjAyMiBhdCAwNTowMToxMlBNICswODAwLCBIZXJt
ZXMgWmhhbmcgd3JvdGU6DQo+PiBJbml0IHRoZSBpY2hnIGFuZCB2YmF0IHJlZyB3aXRoIG1heCB2
YWx1ZSBpcyBub3QgZ29vZC4gRmlyc3QgdGhlIGNoaXANCj4+IGFscmVhZHkgaGFzIGEgZGVmYXVs
dCB2YWx1ZSBmb3IgaWNoZyBhbmQgdmJhdCAoc21hbGwgdmFsdWUpLiBJbml0IHRoZXNlDQo+PiB0
d28gcmVnIHdpdGggbWF4IHZhbHVlIHdpbGwgcmVzdWx0IGFuIHVuc2FmZSBjYXNlIChlLmcuIGJh
dHRlcnkgaXMgb3Zlcg0KPj4gY2hhcmdpbmcgaW4gYSBob3QgZW52aXJvbm1lbnQpIGlmIG5vIHVz
ZXIgc3BhY2UgY2hhbmdlIHRoZW0gbGF0ZXIuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSGVybWVz
IFpoYW5nIDxjaGVuaHVpekBheGlzLmNvbT4NCj4+IC0tLQ0KPiBJdCdzIHRoZSBkcml2ZXIncyB0
YXNrIHRvIHNldHVwIHNhZmUgaW5pdGlhbCBtYXhpbXVtIHZhbHVlcy4NCj4gUHJlLWtlcm5lbCB2
YWx1ZXMgbWF5IG9yIG1heSBub3QgYmUgc2FmZSBpZiB5b3UgY29uc2lkZXIgdGhpbmdzDQo+IGxp
a2Uga2V4ZWMuIElmIHlvdSBnZXQgdW5zYWZlIHZhbHVlcyBwcm9ncmFtbWVkLCB0aGVuIGZpeCB0
aGUNCj4gdmFsdWVzIGluc3RlYWQuDQo+DQo+IC0tIFNlYmFzdGlhbg0KDQpUaGUgY29uc3RhbnRf
Y2hhcmdlX2N1cnJlbnRfbWF4X3VhIGlzIGVpdGhlciBmcm9tIGR0cyBvciBkZWZhdWx0IHZhbHVl
IA0KZm9yIGVhY2ggY2hpcCBpbiB0aGUgY29kZSwgYnV0IEkgZ3Vlc3MgSSBjb3VsZCBvdCBjaGFu
Z2UgdGhlbSBiZWNhdXNlIGl0IA0KaGFzIHRoZWlyIG93biBtZWFuaW5nIChpdCB3aWxsIGJlIHVz
ZWQgdG8gY2hlY2sgaWYgdGhlIHNldHRpbmcgaXMgdmFsaWQgDQpvciBub3QpLiBEbyB5b3UgbWVh
biBJIGNhbiBzZXQgc29tZSBvdGhlciB2YWx1ZSBoZXJlIGluc3RlYWQgb2YgDQpjb25zdGFudF94
eHhfbWF4Pw0KDQpCZXN0IFJlZ2FyZHMsDQpIZXJtZXMNCg0KDQo+PiAgIGRyaXZlcnMvcG93ZXIv
c3VwcGx5L2JxMjU2eHhfY2hhcmdlci5jIHwgMTAgLS0tLS0tLS0tLQ0KPj4gICAxIGZpbGUgY2hh
bmdlZCwgMTAgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcG93ZXIv
c3VwcGx5L2JxMjU2eHhfY2hhcmdlci5jIGIvZHJpdmVycy9wb3dlci9zdXBwbHkvYnEyNTZ4eF9j
aGFyZ2VyLmMNCj4+IGluZGV4IDAxYWQ4NGZkMTQ3Yy4uZDFhYTkyYzEwYzIyIDEwMDY0NA0KPj4g
LS0tIGEvZHJpdmVycy9wb3dlci9zdXBwbHkvYnEyNTZ4eF9jaGFyZ2VyLmMNCj4+ICsrKyBiL2Ry
aXZlcnMvcG93ZXIvc3VwcGx5L2JxMjU2eHhfY2hhcmdlci5jDQo+PiBAQCAtMTU2MiwyMSArMTU2
MiwxMSBAQCBzdGF0aWMgaW50IGJxMjU2eHhfaHdfaW5pdChzdHJ1Y3QgYnEyNTZ4eF9kZXZpY2Ug
KmJxKQ0KPj4gICAJaWYgKHJldCkNCj4+ICAgCQlyZXR1cm4gcmV0Ow0KPj4gICANCj4+IC0JcmV0
ID0gYnEtPmNoaXBfaW5mby0+YnEyNTZ4eF9zZXRfaWNoZyhicSwNCj4+IC0JCQkJYmF0X2luZm8t
PmNvbnN0YW50X2NoYXJnZV9jdXJyZW50X21heF91YSk7DQo+PiAtCWlmIChyZXQpDQo+PiAtCQly
ZXR1cm4gcmV0Ow0KPj4gLQ0KPj4gICAJcmV0ID0gYnEtPmNoaXBfaW5mby0+YnEyNTZ4eF9zZXRf
aXByZWNoZyhicSwNCj4+ICAgCQkJCWJhdF9pbmZvLT5wcmVjaGFyZ2VfY3VycmVudF91YSk7DQo+
PiAgIAlpZiAocmV0KQ0KPj4gICAJCXJldHVybiByZXQ7DQo+PiAgIA0KPj4gLQlyZXQgPSBicS0+
Y2hpcF9pbmZvLT5icTI1Nnh4X3NldF92YmF0cmVnKGJxLA0KPj4gLQkJCQliYXRfaW5mby0+Y29u
c3RhbnRfY2hhcmdlX3ZvbHRhZ2VfbWF4X3V2KTsNCj4+IC0JaWYgKHJldCkNCj4+IC0JCXJldHVy
biByZXQ7DQo+PiAtDQo+PiAgIAlyZXQgPSBicS0+Y2hpcF9pbmZvLT5icTI1Nnh4X3NldF9pdGVy
bShicSwNCj4+ICAgCQkJCWJhdF9pbmZvLT5jaGFyZ2VfdGVybV9jdXJyZW50X3VhKTsNCj4+ICAg
CWlmIChyZXQpDQo+PiAtLSANCj4+IDIuMzAuMg0KPj4NCg0K
