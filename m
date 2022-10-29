Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078C561240C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 16:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiJ2Oya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 10:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJ2Oy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 10:54:28 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 143CF317D8
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 07:54:17 -0700 (PDT)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sat, 29 Oct
 2022 22:49:30 +0800 (GMT+08:00)
X-Originating-IP: [182.148.13.81]
Date:   Sat, 29 Oct 2022 22:49:30 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wangkailong@jari.cn
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject:  [PATCH] f2fs: replace ternary operator with max()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <44b06118.3c.18424382765.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwCnu+F6PV1j+d0AAA--.25W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAKB2FEYx0AVwAJsJ
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_PBL,RDNS_NONE,
        T_SPF_HELO_PERMERROR,T_SPF_TEMPERROR,XPRIO autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IHRoZSBmb2xsb3dpbmcgY29jY2ljaGVjayB3YXJuaW5nOgoKLi9mcy9mMmZzL3NlZ21lbnQu
Yzo4Nzc6MjQtMjU6IFdBUk5JTkcgb3Bwb3J0dW5pdHkgZm9yIG1heCgpCgpTaWduZWQtb2ZmLWJ5
OiBLYWlMb25nIFdhbmcgPHdhbmdrYWlsb25nQGphcmkuY24+Ci0tLQogZnMvZjJmcy9zZWdtZW50
LmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkK
CmRpZmYgLS1naXQgYS9mcy9mMmZzL3NlZ21lbnQuYyBiL2ZzL2YyZnMvc2VnbWVudC5jCmluZGV4
IGFkYTIxZTgzZDI3OS4uNmRhOTI1MTgzMjhjIDEwMDY0NAotLS0gYS9mcy9mMmZzL3NlZ21lbnQu
YworKysgYi9mcy9mMmZzL3NlZ21lbnQuYwpAQCAtODc0LDcgKzg3NCw3IEBAIGJsb2NrX3QgZjJm
c19nZXRfdW51c2FibGVfYmxvY2tzKHN0cnVjdCBmMmZzX3NiX2luZm8gKnNiaSkKIAl9CiAJbXV0
ZXhfdW5sb2NrKCZkaXJ0eV9pLT5zZWdsaXN0X2xvY2spOwogCi0JdW51c2FibGUgPSBob2xlc1tE
QVRBXSA+IGhvbGVzW05PREVdID8gaG9sZXNbREFUQV0gOiBob2xlc1tOT0RFXTsKKwl1bnVzYWJs
ZSA9IG1heChob2xlc1tEQVRBXSwgaG9sZXNbTk9ERV0pOwogCWlmICh1bnVzYWJsZSA+IG92cF9o
b2xlcykKIAkJcmV0dXJuIHVudXNhYmxlIC0gb3ZwX2hvbGVzOwogCXJldHVybiAwOwotLSAKMi4y
NS4xCg==
