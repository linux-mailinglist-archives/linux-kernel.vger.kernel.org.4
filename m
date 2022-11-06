Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8128961E19A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 11:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiKFKbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 05:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiKFKbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 05:31:46 -0500
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 624275F98
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 02:31:36 -0800 (PST)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sun, 6 Nov 2022
 18:26:38 +0800 (GMT+08:00)
X-Originating-IP: [182.148.13.29]
Date:   Sun, 6 Nov 2022 18:26:38 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wangkailong@jari.cn
To:     chenhuacai@kernel.org, kernel@xen0n.name, zhangqing@loongson.cn
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: Fix unsigned comparison with less than zero
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <63425a0e.b8.1844c7a5d80.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwD3C+Lei2djsoYBAA--.50W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQATB2FEYx0CNQAEs9
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

RWxpbWluYXRlIHRoZSBmb2xsb3dpbmcgY29jY2ljaGVjayB3YXJuaW5nOgoKLi9hcmNoL2xvb25n
YXJjaC9rZXJuZWwvdW53aW5kX3Byb2xvZ3VlLmM6ODQ6NS0xMzogV0FSTklORzogVW5zaWduZWQK
ZXhwcmVzc2lvbiBjb21wYXJlZCB3aXRoIHplcm86IGZyYW1lX3JhIDwgMAoKU2lnbmVkLW9mZi1i
eTogS2FpTG9uZyBXYW5nIDx3YW5na2FpbG9uZ0BqYXJpLmNuPgotLS0KIGFyY2gvbG9vbmdhcmNo
L2tlcm5lbC91bndpbmRfcHJvbG9ndWUuYyB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9sb29uZ2FyY2gva2Vy
bmVsL3Vud2luZF9wcm9sb2d1ZS5jIGIvYXJjaC9sb29uZ2FyY2gva2VybmVsL3Vud2luZF9wcm9s
b2d1ZS5jCmluZGV4IGIyMDZkOTE1OTIwNS4uNThjY2RiZTdmYTIyIDEwMDY0NAotLS0gYS9hcmNo
L2xvb25nYXJjaC9rZXJuZWwvdW53aW5kX3Byb2xvZ3VlLmMKKysrIGIvYXJjaC9sb29uZ2FyY2gv
a2VybmVsL3Vud2luZF9wcm9sb2d1ZS5jCkBAIC00Myw3ICs0Myw4IEBAIHN0YXRpYyBib29sIHVu
d2luZF9ieV9wcm9sb2d1ZShzdHJ1Y3QgdW53aW5kX3N0YXRlICpzdGF0ZSkKIHsKIAlzdHJ1Y3Qg
c3RhY2tfaW5mbyAqaW5mbyA9ICZzdGF0ZS0+c3RhY2tfaW5mbzsKIAl1bmlvbiBsb29uZ2FyY2hf
aW5zdHJ1Y3Rpb24gKmlwLCAqaXBfZW5kOwotCXVuc2lnbmVkIGxvbmcgZnJhbWVfc2l6ZSA9IDAs
IGZyYW1lX3JhID0gLTE7CisJdW5zaWduZWQgbG9uZyBmcmFtZV9zaXplID0gMDsKKwlsb25nIGZy
YW1lX3JhID0gLTE7CiAJdW5zaWduZWQgbG9uZyBzaXplLCBvZmZzZXQsIHBjID0gc3RhdGUtPnBj
OwogCiAJaWYgKHN0YXRlLT5zcCA+PSBpbmZvLT5lbmQgfHwgc3RhdGUtPnNwIDwgaW5mby0+YmVn
aW4pCi0tIAoyLjI1LjEK
