Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D40639A9B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 13:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiK0Mt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 07:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiK0MtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 07:49:25 -0500
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 410B86562;
        Sun, 27 Nov 2022 04:49:24 -0800 (PST)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sun, 27 Nov
 2022 20:49:16 +0800 (GMT+08:00)
X-Originating-IP: [182.148.15.36]
Date:   Sun, 27 Nov 2022 20:49:16 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "KaiLong Wang" <wangkailong@jari.cn>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: sony: convert sysfs snprintf to sysfs_emit
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7f3fb8ac.1d4.184b9227e20.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwCnu+HMXINjanIFAA--.132W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQADB2FEYx0G1gAEsK
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

Rml4IHRoZSBmb2xsb3dpbmcgY29jY2ljaGVjayB3YXJuaW5nOgoKZHJpdmVycy9oaWQvaGlkLXNv
bnkuYzo3MTA6OC0xNjogV0FSTklORzogdXNlIHNjbnByaW50ZiBvciBzcHJpbnRmCmRyaXZlcnMv
aGlkL2hpZC1zb255LmM6NzQ3OjgtMTY6IFdBUk5JTkc6IHVzZSBzY25wcmludGYgb3Igc3ByaW50
Zgpkcml2ZXJzL2hpZC9oaWQtc29ueS5jOjc1OTo4LTE2OiBXQVJOSU5HOiB1c2Ugc2NucHJpbnRm
IG9yIHNwcmludGYKClNpZ25lZC1vZmYtYnk6IEthaUxvbmcgV2FuZyA8d2FuZ2thaWxvbmdAamFy
aS5jbj4KLS0tCiBkcml2ZXJzL2hpZC9oaWQtc29ueS5jIHwgNiArKystLS0KIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9oaWQvaGlkLXNvbnkuYyBiL2RyaXZlcnMvaGlkL2hpZC1zb255LmMKaW5kZXggMDM2OTFjZGNm
YjhlLi41OTI1ZWQ2MTUyZjUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaGlkL2hpZC1zb255LmMKKysr
IGIvZHJpdmVycy9oaWQvaGlkLXNvbnkuYwpAQCAtNzA3LDcgKzcwNyw3IEBAIHN0YXRpYyBzc2l6
ZV90IGRzNF9zaG93X3BvbGxfaW50ZXJ2YWwoc3RydWN0IGRldmljZSAqZGV2LAogCXN0cnVjdCBo
aWRfZGV2aWNlICpoZGV2ID0gdG9faGlkX2RldmljZShkZXYpOwogCXN0cnVjdCBzb255X3NjICpz
YyA9IGhpZF9nZXRfZHJ2ZGF0YShoZGV2KTsKIAotCXJldHVybiBzbnByaW50ZihidWYsIFBBR0Vf
U0laRSwgIiVpXG4iLCBzYy0+ZHM0X2J0X3BvbGxfaW50ZXJ2YWwpOworCXJldHVybiBzeXNmc19l
bWl0KGJ1ZiwgIiVpXG4iLCBzYy0+ZHM0X2J0X3BvbGxfaW50ZXJ2YWwpOwogfQogCiBzdGF0aWMg
c3NpemVfdCBkczRfc3RvcmVfcG9sbF9pbnRlcnZhbChzdHJ1Y3QgZGV2aWNlICpkZXYsCkBAIC03
NDQsNyArNzQ0LDcgQEAgc3RhdGljIHNzaXplX3Qgc29ueV9zaG93X2Zpcm13YXJlX3ZlcnNpb24o
c3RydWN0IGRldmljZSAqZGV2LAogCXN0cnVjdCBoaWRfZGV2aWNlICpoZGV2ID0gdG9faGlkX2Rl
dmljZShkZXYpOwogCXN0cnVjdCBzb255X3NjICpzYyA9IGhpZF9nZXRfZHJ2ZGF0YShoZGV2KTsK
IAotCXJldHVybiBzbnByaW50ZihidWYsIFBBR0VfU0laRSwgIjB4JTA0eFxuIiwgc2MtPmZ3X3Zl
cnNpb24pOworCXJldHVybiBzeXNmc19lbWl0KGJ1ZiwgIjB4JTA0eFxuIiwgc2MtPmZ3X3ZlcnNp
b24pOwogfQogCiBzdGF0aWMgREVWSUNFX0FUVFIoZmlybXdhcmVfdmVyc2lvbiwgMDQ0NCwgc29u
eV9zaG93X2Zpcm13YXJlX3ZlcnNpb24sIE5VTEwpOwpAQCAtNzU2LDcgKzc1Niw3IEBAIHN0YXRp
YyBzc2l6ZV90IHNvbnlfc2hvd19oYXJkd2FyZV92ZXJzaW9uKHN0cnVjdCBkZXZpY2UgKmRldiwK
IAlzdHJ1Y3QgaGlkX2RldmljZSAqaGRldiA9IHRvX2hpZF9kZXZpY2UoZGV2KTsKIAlzdHJ1Y3Qg
c29ueV9zYyAqc2MgPSBoaWRfZ2V0X2RydmRhdGEoaGRldik7CiAKLQlyZXR1cm4gc25wcmludGYo
YnVmLCBQQUdFX1NJWkUsICIweCUwNHhcbiIsIHNjLT5od192ZXJzaW9uKTsKKwlyZXR1cm4gc3lz
ZnNfZW1pdChidWYsICIweCUwNHhcbiIsIHNjLT5od192ZXJzaW9uKTsKIH0KIAogc3RhdGljIERF
VklDRV9BVFRSKGhhcmR3YXJlX3ZlcnNpb24sIDA0NDQsIHNvbnlfc2hvd19oYXJkd2FyZV92ZXJz
aW9uLCBOVUxMKTsKLS0gCjIuMjUuMQo=
