Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2CD6127A1
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 07:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJ3GFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 02:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJ3GFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 02:05:42 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A79FBB;
        Sat, 29 Oct 2022 23:05:38 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 981FA5FD0D;
        Sun, 30 Oct 2022 09:05:34 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1667109934;
        bh=Mj6XeGhibfGmSiEoTN5jf4ujH17LQ75QJnsy4cgB8Go=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=c+ccjpSE8FDHp9W8PipF45eu6bKB8Wp2qvhDjbOlJoJ7WHzFwAS7h8coDc63s7/wo
         c64/QtpDpI2hWLMzp3+uVg5HGLuqjaCkSfAb7uigfg3eUvJXNDr4dS3bWHTlIB+F93
         e2s1YCwcYWayCSfDtBd+46thh0AnvQER97mE9RxVu0JUwgN4MmBGzFxikrAyCh9RAG
         P8wN+6MarQkUJvuj14asjJT+4j57SV2sCyV29cRCabwoU16CZv7CQuhMNU5fa3xZHP
         OcpEoIuuufL60rPa1aJ6EjSeK2jxgfoi5ziO+epUwPqhOW8P/vo+5nA6PEbqm42kQk
         bH5Oc+iRDBuag==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Sun, 30 Oct 2022 09:05:33 +0300 (MSK)
From:   Arseniy Krasnov <AVKrasnov@sberdevices.ru>
To:     Pavel Machek <pavel@ucw.cz>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: [RFC PATCH v1 0/1] Support to use own workqueue for each LED
Thread-Topic: [RFC PATCH v1 0/1] Support to use own workqueue for each LED
Thread-Index: AQHY7CWKPTqYZU7OvEqkn9ySnKgCJg==
Date:   Sun, 30 Oct 2022 06:04:59 +0000
Message-ID: <9a0a70a8-0886-1115-6151-72d2cba842cf@sberdevices.ru>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C39020E49B98E4B9770742F765209BE@sberdevices.ru>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/10/30 00:33:00 #20534548
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBhbGxvd3MgdG8gdXNlIG93biB3b3JrcXVldWUgZm9yIGVhY2ggTEVELiBUaGlzIGNvdWxk
IGJlIHVzZWZ1bCB3aGVuIHdlDQpoYXZlIG11bHRpcGxlIExFRHMgd2hpY2ggbXVzdCB3b3JrIG11
dHVhbGx5IChmcm9tIHVzZXIncyBwb2ludCBvZiB2aWV3KSwgZm9yDQpleGFtcGxlIHdoZW4gY29t
cGxleCBhbmltYXRpb24gbXVzdCBiZSBwbGF5ZWQuIFByb2JsZW0gaXMgdGhhdCBkZWZhdWx0IHdx
IC0NCidzeXN0ZW1fd3EnIGRvZXMgbm90IGd1YXJhbnRlZSBvcmRlciBvZiBjYWxsYmFja3MgZXhl
Y3V0aW9uLCB3aGljaCBjb250cm9sDQpicmlnaHRuZXNzIG9mIGV2ZXJ5IExFRC4gU28gd2hlbiB1
c2Vyc3BhY2Ugb3IgcGF0dGVybiBsb2dpYyB3YW50cyB0byBjaGFuZ2UNCmJyaWdodG5lc3MgaW4g
b25lIG9yZGVyLCBrd29ya2VycyBtYXkgZG8gaXQgaW4gcmFuZG9tIHdheSwgdGh1cyBicmVha2lu
Zw0Kc21vb3RobmVzcyBvZiBhbmltYXRpb24uDQoNCkhlcmUgaXMgZXhhbXBsZSBob3cgdG8gdXNl
IHRoaXMgcGF0Y2g6DQoNCi0tLSBhL2RyaXZlcnMvbGVkcy9sZWRzLWF3MjAxMy5jDQorKysgYi9k
cml2ZXJzL2xlZHMvbGVkcy1hdzIwMTMuYw0KQEAgLTI2NCwxMSArMjY0LDE3IEBAIHN0YXRpYyBp
bnQgYXcyMDEzX3Byb2JlX2R0KHN0cnVjdCBhdzIwMTMgKmNoaXApDQogCXN0cnVjdCBkZXZpY2Vf
bm9kZSAqbnAgPSBkZXZfb2Zfbm9kZSgmY2hpcC0+Y2xpZW50LT5kZXYpLCAqY2hpbGQ7DQogCWlu
dCBjb3VudCwgcmV0ID0gMCwgaSA9IDA7DQogCXN0cnVjdCBhdzIwMTNfbGVkICpsZWQ7DQorCXN0
cnVjdCB3b3JrcXVldWVfc3RydWN0ICp3cTsNCg0KIAljb3VudCA9IG9mX2dldF9hdmFpbGFibGVf
Y2hpbGRfY291bnQobnApOw0KIAlpZiAoIWNvdW50IHx8IGNvdW50ID4gQVcyMDEzX01BWF9MRURT
KQ0KIAkJcmV0dXJuIC1FSU5WQUw7DQoNCisJd3EgPSBhbGxvY19vcmRlcmVkX3dvcmtxdWV1ZSgi
YXcyMDEzX3dxIiwgMCk7DQorDQorCWlmICghd3EpDQorCQlyZXR1cm4gLUVOT01FTTsNCisNCiAJ
cmVnbWFwX3dyaXRlKGNoaXAtPnJlZ21hcCwgQVcyMDEzX1JTVFIsIEFXMjAxM19SU1RSX1JFU0VU
KTsNCg0KIAlmb3JfZWFjaF9hdmFpbGFibGVfY2hpbGRfb2Zfbm9kZShucCwgY2hpbGQpIHsNCkBA
IC0yOTksNiArMzA1LDcgQEAgc3RhdGljIGludCBhdzIwMTNfcHJvYmVfZHQoc3RydWN0IGF3MjAx
MyAqY2hpcCkNCg0KIAkJbGVkLT5jZGV2LmJyaWdodG5lc3Nfc2V0X2Jsb2NraW5nID0gYXcyMDEz
X2JyaWdodG5lc3Nfc2V0Ow0KIAkJbGVkLT5jZGV2LmJsaW5rX3NldCA9IGF3MjAxM19ibGlua19z
ZXQ7DQorCQlsZWQtPmNkZXYuc2V0X2JyaWdodG5lc3Nfd3EgPSB3cTsNCg0KIAkJcmV0ID0gZGV2
bV9sZWRfY2xhc3NkZXZfcmVnaXN0ZXJfZXh0KCZjaGlwLT5jbGllbnQtPmRldiwNCiAJCQkJCQkg
ICAgICZsZWQtPmNkZXYsICZpbml0X2RhdGEpOw0KDQpFLmcuIHNwZWNpYWwgd29ya3F1ZXVlIG11
c3QgYmUgYWxsb2NhdGVkIGFuZCBzZXQgZm9yIGVhY2ggTEVEIGR1cmluZyBpbml0IG9mDQonbGVk
X2NsYXNzZGV2Jy4gVGhlbiBsYXRlciBpbiAnbGVkX2luaXRfY29yZSgpJywgJ3N5c3RlbV93cScg
d29uJ3QgYmUgdXNlZCBmb3INCnN1Y2ggTEVEcy4NCg0KQXJzZW5peSBLcmFzbm92KDEpOg0KIGRy
aXZlcnMvbGVkcy9sZWQtY29yZS5jIHwgOCArKysrKystLQ0KIGluY2x1ZGUvbGludXgvbGVkcy5o
ICAgIHwgMSArDQogMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQoNCi0tIA0KMi4zNS4wDQo=
