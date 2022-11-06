Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D9E61E2E0
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 16:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiKFPM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 10:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiKFPMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 10:12:54 -0500
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 937F56418
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 07:12:53 -0800 (PST)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sun, 6 Nov 2022
 23:07:54 +0800 (GMT+08:00)
X-Originating-IP: [182.148.13.29]
Date:   Sun, 6 Nov 2022 23:07:54 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wangkailong@jari.cn
To:     w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
        samuel.thibault@ens-lyon.org, gregkh@linuxfoundation.org
Cc:     speakup@linux-speakup.org, linux-kernel@vger.kernel.org
Subject:  [PATCH] speakup: Fix warning comparing pointer to 0
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <1de9cab8.c1.1844d7bdf4b.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwCXq+HKzWdj6IsBAA--.49W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQACB2FEYx0CyAAQsF
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_PBL,RDNS_NONE,
        T_SPF_HELO_PERMERROR,T_SPF_PERMERROR,XPRIO autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IHRoZSBmb2xsb3dpbmcgY29jY2ljaGVjayB3YXJuaW5nOgoKZHJpdmVycy9hY2Nlc3NpYmls
aXR5L3NwZWFrdXAvdXRpbHMuaDozOToxNS0xNjogV0FSTklORyBjb21wYXJpbmcKcG9pbnRlciB0
byAwCgpTaWduZWQtb2ZmLWJ5OiBLYWlMb25nIFdhbmcgPHdhbmdrYWlsb25nQGphcmkuY24+Ci0t
LQogZHJpdmVycy9hY2Nlc3NpYmlsaXR5L3NwZWFrdXAvdXRpbHMuaCB8IDIgKy0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvYWNjZXNzaWJpbGl0eS9zcGVha3VwL3V0aWxzLmggYi9kcml2ZXJzL2FjY2Vzc2liaWxpdHkv
c3BlYWt1cC91dGlscy5oCmluZGV4IDRiZjJlZThhYzI0Ni4uNTgwM2I1MjFkZjJiIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2FjY2Vzc2liaWxpdHkvc3BlYWt1cC91dGlscy5oCisrKyBiL2RyaXZlcnMv
YWNjZXNzaWJpbGl0eS9zcGVha3VwL3V0aWxzLmgKQEAgLTM2LDcgKzM2LDcgQEAgc3RhdGljIGlu
bGluZSB2b2lkIG9wZW5faW5wdXQoY29uc3QgY2hhciAqZGlyX25hbWUsIGNvbnN0IGNoYXIgKm5h
bWUpCiAJZWxzZQogCQlzbnByaW50ZihmaWxlbmFtZSwgc2l6ZW9mKGZpbGVuYW1lKSwgIiVzIiwg
bmFtZSk7CiAJaW5maWxlID0gZm9wZW4oZmlsZW5hbWUsICJyIik7Ci0JaWYgKGluZmlsZSA9PSAw
KSB7CisJaWYgKGluZmlsZSkgewogCQlmcHJpbnRmKHN0ZGVyciwgImNhbid0IG9wZW4gJXNcbiIs
IGZpbGVuYW1lKTsKIAkJZXhpdCgxKTsKIAl9Ci0tIAoyLjI1LjEK
