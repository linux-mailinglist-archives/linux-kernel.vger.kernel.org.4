Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD1A639AC1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 14:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiK0NB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 08:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiK0NBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 08:01:54 -0500
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D839EBE27
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 05:01:53 -0800 (PST)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sun, 27 Nov
 2022 21:01:45 +0800 (GMT+08:00)
X-Originating-IP: [182.148.15.36]
Date:   Sun, 27 Nov 2022 21:01:45 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "KaiLong Wang" <wangkailong@jari.cn>
To:     linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject:  [PATCH] arch/arm: convert sysfs snprintf to sysfs_emit
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <75c9d8ca.1d6.184b92ded9c.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwCXn+C5X4Njp3IFAA--.102W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQADB2FEYx0G1gAJsH
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_PBL,RDNS_NONE,
        T_SPF_HELO_PERMERROR,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IHRoZSBmb2xsb3dpbmcgY29jY2ljaGVjayB3YXJuaW5nOgoKYXJjaC9hcm0vbW0vY2FjaGUt
bDJ4MC1wbXUuYzozNDY6OC0xNjogV0FSTklORzogdXNlIHNjbnByaW50ZiBvciBzcHJpbnRmCgpT
aWduZWQtb2ZmLWJ5OiBLYWlMb25nIFdhbmcgPHdhbmdrYWlsb25nQGphcmkuY24+Ci0tLQogYXJj
aC9hcm0vbW0vY2FjaGUtbDJ4MC1wbXUuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21tL2NhY2hlLWwy
eDAtcG11LmMgYi9hcmNoL2FybS9tbS9jYWNoZS1sMngwLXBtdS5jCmluZGV4IDk5M2ZlZmRjMTY3
YS4uYTliZDA1YjgyMDAzIDEwMDY0NAotLS0gYS9hcmNoL2FybS9tbS9jYWNoZS1sMngwLXBtdS5j
CisrKyBiL2FyY2gvYXJtL21tL2NhY2hlLWwyeDAtcG11LmMKQEAgLTM0Myw3ICszNDMsNyBAQCBz
dGF0aWMgc3NpemVfdCBsMngwX3BtdV9ldmVudF9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwKIAlz
dHJ1Y3QgbDJ4MF9ldmVudF9hdHRyaWJ1dGUgKmxhdHRyOwogCiAJbGF0dHIgPSBjb250YWluZXJf
b2YoYXR0ciwgdHlwZW9mKCpsYXR0ciksIGF0dHIpOwotCXJldHVybiBzbnByaW50ZihidWYsIFBB
R0VfU0laRSwgImNvbmZpZz0weCV4XG4iLCBsYXR0ci0+Y29uZmlnKTsKKwlyZXR1cm4gc3lzZnNf
ZW1pdChidWYsICJjb25maWc9MHgleFxuIiwgbGF0dHItPmNvbmZpZyk7CiB9CiAKIHN0YXRpYyB1
bW9kZV90IGwyeDBfcG11X2V2ZW50X2F0dHJfaXNfdmlzaWJsZShzdHJ1Y3Qga29iamVjdCAqa29i
aiwKLS0gCjIuMjUuMQo=
