Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CA06127A5
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 07:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiJ3GHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 02:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJ3GHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 02:07:43 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241B410F;
        Sat, 29 Oct 2022 23:07:41 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 8613A5FD0D;
        Sun, 30 Oct 2022 09:07:39 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1667110059;
        bh=70gQPUCJRtL+Gl1erP4Tp6BQPO1jX8JvWrWFY8MQuHI=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=kOnQRetVPv+2UCipFwjhn9VvzjZbNb1MtZPEkL4XSVlkO2q0AgbiBUUxbZzxB6wXH
         yq/VsHBq0lC8A0RvQ3eLGOuhYQ9Z6013ctIfPPy260AwnRtZJCMuHS4FvxxFiHTD0H
         16ZKDb5LwUolBDySp5pnIaGKusXFqbIN3fOaSwY0FwdBlGRoBI3d1InUZt00XuVa8u
         nchrawSXaximexdtUtxiV97DRznAweF0b0Zly7PJIYrDWOV7F72/wXvQR8BYQh9k+i
         skjfhiiYz4VV/aqlMXCs6Npx2Fp6uHAkrgzyRUCpA4i+DixbBbUK3ewUxQb5HiIhB5
         51F9m8vuwQWXg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Sun, 30 Oct 2022 09:07:39 +0300 (MSK)
From:   Arseniy Krasnov <AVKrasnov@sberdevices.ru>
To:     Pavel Machek <pavel@ucw.cz>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: [RFC PATCH v1 1/1] leds: support to use own workqueue for each LED
Thread-Topic: [RFC PATCH v1 1/1] leds: support to use own workqueue for each
 LED
Thread-Index: AQHY7CXVXNE+VpHZTEOLMCYP8pPo3Q==
Date:   Sun, 30 Oct 2022 06:07:05 +0000
Message-ID: <33d05330-7c52-e873-bf32-209d40c77632@sberdevices.ru>
In-Reply-To: <9a0a70a8-0886-1115-6151-72d2cba842cf@sberdevices.ru>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1499C136C8B1C458504460BCBBB17FE@sberdevices.ru>
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

VGhpcyBhbGxvd3MgdG8gc2V0IG93biB3b3JrcXVldWUgZm9yIGVhY2ggTEVELiBUaGlzIG1heSBi
ZSB1c2VmdWwsIGJlY2F1c2UNCmRlZmF1bHQgJ3N5c3RlbV93cScgZG9lcyBub3QgZ3VhcmFudGVl
IGV4ZWN1dGlvbiBvcmRlciBvZiBlYWNoIHdvcmtfc3RydWN0LA0KdGh1cyBmb3Igc2V2ZXJhbCBi
cmlnaHRuZXNzIHVwZGF0ZSByZXF1ZXN0cyAoZm9yIG11bHRpcGxlIGxlZHMpLCByZWFsDQpicmln
aHRuZXNzIHN3aXRjaCBjb3VsZCBiZSBpbiByYW5kb20gb3JkZXIuDQoNClNpZ25lZC1vZmYtYnk6
IEFyc2VuaXkgS3Jhc25vdiA8QVZLcmFzbm92QHNiZXJkZXZpY2VzLnJ1Pg0KLS0tDQogZHJpdmVy
cy9sZWRzL2xlZC1jb3JlLmMgfCA4ICsrKysrKy0tDQogaW5jbHVkZS9saW51eC9sZWRzLmggICAg
fCAxICsNCiAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbGVkcy9sZWQtY29yZS5jIGIvZHJpdmVycy9sZWRzL2xl
ZC1jb3JlLmMNCmluZGV4IDRhOTdjYjc0NTc4OC4uZThlY2YzMzI3OTNhIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9sZWRzL2xlZC1jb3JlLmMNCisrKyBiL2RyaXZlcnMvbGVkcy9sZWQtY29yZS5jDQpA
QCAtMTg4LDYgKzE4OCw5IEBAIHN0YXRpYyB2b2lkIGxlZF9ibGlua19zZXR1cChzdHJ1Y3QgbGVk
X2NsYXNzZGV2ICpsZWRfY2RldiwNCiANCiB2b2lkIGxlZF9pbml0X2NvcmUoc3RydWN0IGxlZF9j
bGFzc2RldiAqbGVkX2NkZXYpDQogew0KKwlpZiAoIWxlZF9jZGV2LT5zZXRfYnJpZ2h0bmVzc193
cSkNCisJCWxlZF9jZGV2LT5zZXRfYnJpZ2h0bmVzc193cSA9IHN5c3RlbV93cTsNCisNCiAJSU5J
VF9XT1JLKCZsZWRfY2Rldi0+c2V0X2JyaWdodG5lc3Nfd29yaywgc2V0X2JyaWdodG5lc3NfZGVs
YXllZCk7DQogDQogCXRpbWVyX3NldHVwKCZsZWRfY2Rldi0+YmxpbmtfdGltZXIsIGxlZF90aW1l
cl9mdW5jdGlvbiwgMCk7DQpAQCAtMjUyLDcgKzI1NSw4IEBAIHZvaWQgbGVkX3NldF9icmlnaHRu
ZXNzKHN0cnVjdCBsZWRfY2xhc3NkZXYgKmxlZF9jZGV2LCB1bnNpZ25lZCBpbnQgYnJpZ2h0bmVz
cykNCiAJCSAqLw0KIAkJaWYgKCFicmlnaHRuZXNzKSB7DQogCQkJc2V0X2JpdChMRURfQkxJTktf
RElTQUJMRSwgJmxlZF9jZGV2LT53b3JrX2ZsYWdzKTsNCi0JCQlzY2hlZHVsZV93b3JrKCZsZWRf
Y2Rldi0+c2V0X2JyaWdodG5lc3Nfd29yayk7DQorCQkJcXVldWVfd29yayhsZWRfY2Rldi0+c2V0
X2JyaWdodG5lc3Nfd3EsDQorCQkJCSAgICZsZWRfY2Rldi0+c2V0X2JyaWdodG5lc3Nfd29yayk7
DQogCQl9IGVsc2Ugew0KIAkJCXNldF9iaXQoTEVEX0JMSU5LX0JSSUdIVE5FU1NfQ0hBTkdFLA0K
IAkJCQkmbGVkX2NkZXYtPndvcmtfZmxhZ3MpOw0KQEAgLTI3Myw3ICsyNzcsNyBAQCB2b2lkIGxl
ZF9zZXRfYnJpZ2h0bmVzc19ub3BtKHN0cnVjdCBsZWRfY2xhc3NkZXYgKmxlZF9jZGV2LCB1bnNp
Z25lZCBpbnQgdmFsdWUpDQogDQogCS8qIElmIGJyaWdodG5lc3Mgc2V0dGluZyBjYW4gc2xlZXAs
IGRlbGVnYXRlIGl0IHRvIGEgd29yayBxdWV1ZSB0YXNrICovDQogCWxlZF9jZGV2LT5kZWxheWVk
X3NldF92YWx1ZSA9IHZhbHVlOw0KLQlzY2hlZHVsZV93b3JrKCZsZWRfY2Rldi0+c2V0X2JyaWdo
dG5lc3Nfd29yayk7DQorCXF1ZXVlX3dvcmsobGVkX2NkZXYtPnNldF9icmlnaHRuZXNzX3dxLCAm
bGVkX2NkZXYtPnNldF9icmlnaHRuZXNzX3dvcmspOw0KIH0NCiBFWFBPUlRfU1lNQk9MX0dQTChs
ZWRfc2V0X2JyaWdodG5lc3Nfbm9wbSk7DQogDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9s
ZWRzLmggYi9pbmNsdWRlL2xpbnV4L2xlZHMuaA0KaW5kZXggYmE0ODYxZWM3M2QzLi4xMTIxYmFl
MjFmZWQgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L2xlZHMuaA0KKysrIGIvaW5jbHVkZS9s
aW51eC9sZWRzLmgNCkBAIC0xNDAsNiArMTQwLDcgQEAgc3RydWN0IGxlZF9jbGFzc2RldiB7DQog
CXZvaWQJCQkoKmZsYXNoX3Jlc3VtZSkoc3RydWN0IGxlZF9jbGFzc2RldiAqbGVkX2NkZXYpOw0K
IA0KIAlzdHJ1Y3Qgd29ya19zdHJ1Y3QJc2V0X2JyaWdodG5lc3Nfd29yazsNCisJc3RydWN0IHdv
cmtxdWV1ZV9zdHJ1Y3QgKnNldF9icmlnaHRuZXNzX3dxOw0KIAlpbnQJCQlkZWxheWVkX3NldF92
YWx1ZTsNCiANCiAjaWZkZWYgQ09ORklHX0xFRFNfVFJJR0dFUlMNCi0tIA0KMi4zNS4wDQo=
