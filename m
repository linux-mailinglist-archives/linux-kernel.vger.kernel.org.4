Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3E46130DF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 08:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiJaHCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 03:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJaHCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 03:02:19 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B03BE25;
        Mon, 31 Oct 2022 00:02:14 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id F29AD5FD04;
        Mon, 31 Oct 2022 10:02:10 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1667199731;
        bh=BKY2cTjdeYEw23ZGX7u2bK3iTwGW6d+R14VKNmLfPW4=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=UcItTpekz0+Ew5myOYjqCL6Jdtz9ioKWmIEWDuTIJr/xgxLQhurNifPD9ehkHe93O
         QFcGPfYAL4uJT2pPnkPWelvDI3pgiQjNjiymT3mtXRVnoTIe1sEAmYahbcil86TTd9
         QVPcVH7BforhVNncsL9SEwg+n672poKi8O1F6mGQOpMe9l0JLKsEOmmtwiO1tOZWFT
         7r8dC61ldp5wuzqbMXwGay2USWG+iT066rM3bheQ57c2iYbEBETWilD1YtYlGPz0QS
         Id6fcIZnIMgquHW1s96NSupgwdia/UcxPk76Sq2AvLd8ehgt6s+Xa91BTwUasvLJ9s
         Lvo0psVqR9cww==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 31 Oct 2022 10:02:10 +0300 (MSK)
From:   Arseniy Krasnov <AVKrasnov@sberdevices.ru>
To:     Pavel Machek <pavel@ucw.cz>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [RFC PATCH v1 1/1] leds: support to use own workqueue for each
 LED
Thread-Topic: [RFC PATCH v1 1/1] leds: support to use own workqueue for each
 LED
Thread-Index: AQHY7CXVXNE+VpHZTEOLMCYP8pPo3a4mqWiAgAAcMYCAAGiDgIAAtIQA
Date:   Mon, 31 Oct 2022 07:01:28 +0000
Message-ID: <03bc76b5-4e2e-5d4d-96b5-53a1f95ffd0c@sberdevices.ru>
References: <9a0a70a8-0886-1115-6151-72d2cba842cf@sberdevices.ru>
 <33d05330-7c52-e873-bf32-209d40c77632@sberdevices.ru>
 <20221030122029.GA8017@duo.ucw.cz>
 <b7304844-a654-2120-2159-29f6134dbadb@sberdevices.ru>
 <20221030201527.GA23195@duo.ucw.cz>
In-Reply-To: <20221030201527.GA23195@duo.ucw.cz>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BF8C2F341EB144FA2DDE82A6596886A@sberdevices.ru>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/10/31 05:11:00 #20539587
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAuMTAuMjAyMiAyMzoxNSwgUGF2ZWwgTWFjaGVrIHdyb3RlOg0KPiBIaSENCj4gDQo+Pj4+
IFRoaXMgYWxsb3dzIHRvIHNldCBvd24gd29ya3F1ZXVlIGZvciBlYWNoIExFRC4gVGhpcyBtYXkg
YmUgdXNlZnVsLCBiZWNhdXNlDQo+Pj4+IGRlZmF1bHQgJ3N5c3RlbV93cScgZG9lcyBub3QgZ3Vh
cmFudGVlIGV4ZWN1dGlvbiBvcmRlciBvZiBlYWNoIHdvcmtfc3RydWN0LA0KPj4+PiB0aHVzIGZv
ciBzZXZlcmFsIGJyaWdodG5lc3MgdXBkYXRlIHJlcXVlc3RzIChmb3IgbXVsdGlwbGUgbGVkcyks
IHJlYWwNCj4+Pj4gYnJpZ2h0bmVzcyBzd2l0Y2ggY291bGQgYmUgaW4gcmFuZG9tIG9yZGVyLg0K
Pj4+DQo+Pj4gU28uLiB3aGF0Pw0KPj4+DQo+Pj4gRXZlbiBpZiBleGVjdXRpb24gb3JkZXIgaXMg
c3dpdGNoZWQsIGh1bWFuIGV5ZSB3aWxsIG5vdCBiZSBhYmxlIHRvDQo+Pj4gdGVsbCB0aGUgZGlm
ZmVyZW5jZS4NCj4+IEhlbGxvLA0KPj4NCj4+IFByb2JsZW0gYXJpc2VzIG9uIG9uZSBvZiBvdXIg
Ym9hcmRzIHdoZXJlIHdlIGhhdmUgMTQgdHJpcGxlcyBvZiBsZWRzKGVhY2gNCj4+IHRyaXBsZSBj
b250YWlucyBSIEcgQikuIFRlc3QgY2FzZSBpcyB0byBwbGF5IGNvbXBsZXggYW5pbWF0aW9uIG9u
IGFsbCBsZWRzOg0KPj4gc21vb3RoIHN3aXRjaCBmcm9tIG9uIFJHQiBzdGF0ZSB0byBhbm90aGVy
LiBTb21ldGltZXMgdGhlcmUgYXJlIGdsaXRjaGVzIGluDQo+PiB0aGlzIHByb2Nlc3MgLSBkaXZl
cmdlbmNlIGZyb20gZXhwZWN0YWJsZSBSR0Igc3RhdGUuIFdlIGZpeGVkIHRoaXMgYnkgdXNpbmcN
Cj4+IG9yZGVyZWQgd29ya3F1ZXVlLg0KPiANCj4gQXJlIHRoZXJlIG90aGVyIHNvbHV0aW9ucyBw
b3NzaWJsZT8gTGlrZSBiYXRjaCBhbmQgYWx3YXlzIGFwcGx5IF9hbGxfDQo+IHRoZSB1cGRhdGVz
IHlvdSBoYXZlIHF1ZXVlZCBmcm9tIHlvdXIgdGhlIHdvcmtlciBjb2RlPw0KDQpJSVVDIFlvdSwg
aXQgaXMgcG9zc2libGUgdG8gZG8gdGhpcyBpZiBicmlnaHRuZXNzIHVwZGF0ZSByZXF1ZXN0cyBh
cmUgcGVyZm9ybWVkIHVzaW5nDQp3cml0ZSB0byAiYnJpZ2h0bmVzcyIgZmlsZSBpbiAvc3lzL2Ns
YXNzL2xlZC8uIEJ1dCBpZiBwYXR0ZXJuIHRyaWdnZXIgbW9kZSBpcyB1c2VkKGluIG15DQpjYXNl
KSAtIEkgY2FuJ3Qgc3luY2hyb25pemUgdGhlc2UgcmVxdWVzdHMgYXMgdGhleSBhcmUgY3JlYXRl
ZCBpbnRlcm5hbGx5IGluIGtlcm5lbCBvbg0KdGltZXIgdGljay4NCg0KVGhhbmtzLCBBcnNlbml5
DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IAkJCQkJCQkJUGF2ZWwNCj4gDQoNCg==
