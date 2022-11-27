Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790BF639A8A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 13:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiK0Mfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 07:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiK0Mfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 07:35:38 -0500
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 015B5C76E;
        Sun, 27 Nov 2022 04:35:27 -0800 (PST)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sun, 27 Nov
 2022 20:35:10 +0800 (GMT+08:00)
X-Originating-IP: [182.148.15.36]
Date:   Sun, 27 Nov 2022 20:35:10 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "KaiLong Wang" <wangkailong@jari.cn>
To:     kartilak@cisco.com, sebaddel@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: snic: convert sysfs snprintf to sysfs_emit
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <716c3cdc.1d2.184b9159597.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwD3C+J+WYNjWXIFAA--.129W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAJB2FEYx0EXwAGsJ
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

Rml4IHRoZSBmb2xsb3dpbmcgY29jY2ljaGVjayB3YXJuaW5nOgoKZHJpdmVycy9zY3NpL3NuaWMv
c25pY19hdHRycy5jOjI2OjgtMTY6IFdBUk5JTkc6IHVzZSBzY25wcmludGYgb3IKc3ByaW50Zgpk
cml2ZXJzL3Njc2kvc25pYy9zbmljX2F0dHJzLmM6MTY6OC0xNjogV0FSTklORzogdXNlIHNjbnBy
aW50ZiBvcgpzcHJpbnRmCmRyaXZlcnMvc2NzaS9zbmljL3NuaWNfYXR0cnMuYzozNTo4LTE2OiBX
QVJOSU5HOiB1c2Ugc2NucHJpbnRmIG9yCnNwcmludGYKZHJpdmVycy9zY3NpL3NuaWMvc25pY19h
dHRycy5jOjQ4OjgtMTY6IFdBUk5JTkc6IHVzZSBzY25wcmludGYgb3IKc3ByaW50ZgoKU2lnbmVk
LW9mZi1ieTogS2FpTG9uZyBXYW5nIDx3YW5na2FpbG9uZ0BqYXJpLmNuPgotLS0KIGRyaXZlcnMv
c2NzaS9zbmljL3NuaWNfYXR0cnMuYyB8IDggKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL3Nu
aWMvc25pY19hdHRycy5jIGIvZHJpdmVycy9zY3NpL3NuaWMvc25pY19hdHRycy5jCmluZGV4IDNk
ZGJkYmMzZGVkMS4uNmU4ZjRkMGI5YzNjIDEwMDY0NAotLS0gYS9kcml2ZXJzL3Njc2kvc25pYy9z
bmljX2F0dHJzLmMKKysrIGIvZHJpdmVycy9zY3NpL3NuaWMvc25pY19hdHRycy5jCkBAIC0xMyw3
ICsxMyw3IEBAIHNuaWNfc2hvd19zeW1fbmFtZShzdHJ1Y3QgZGV2aWNlICpkZXYsCiB7CiAJc3Ry
dWN0IHNuaWMgKnNuaWMgPSBzaG9zdF9wcml2KGNsYXNzX3RvX3Nob3N0KGRldikpOwogCi0JcmV0
dXJuIHNucHJpbnRmKGJ1ZiwgUEFHRV9TSVpFLCAiJXNcbiIsIHNuaWMtPm5hbWUpOworCXJldHVy
biBzeXNmc19lbWl0KGJ1ZiwgIiVzXG4iLCBzbmljLT5uYW1lKTsKIH0KIAogc3RhdGljIHNzaXpl
X3QKQEAgLTIzLDcgKzIzLDcgQEAgc25pY19zaG93X3N0YXRlKHN0cnVjdCBkZXZpY2UgKmRldiwK
IHsKIAlzdHJ1Y3Qgc25pYyAqc25pYyA9IHNob3N0X3ByaXYoY2xhc3NfdG9fc2hvc3QoZGV2KSk7
CiAKLQlyZXR1cm4gc25wcmludGYoYnVmLCBQQUdFX1NJWkUsICIlc1xuIiwKKwlyZXR1cm4gc3lz
ZnNfZW1pdChidWYsICIlc1xuIiwKIAkJCXNuaWNfc3RhdGVfc3RyW3NuaWNfZ2V0X3N0YXRlKHNu
aWMpXSk7CiB9CiAKQEAgLTMyLDcgKzMyLDcgQEAgc25pY19zaG93X2Rydl92ZXJzaW9uKHN0cnVj
dCBkZXZpY2UgKmRldiwKIAkJICAgICAgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsCiAJ
CSAgICAgIGNoYXIgKmJ1ZikKIHsKLQlyZXR1cm4gc25wcmludGYoYnVmLCBQQUdFX1NJWkUsICIl
c1xuIiwgU05JQ19EUlZfVkVSU0lPTik7CisJcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAiJXNcbiIs
IFNOSUNfRFJWX1ZFUlNJT04pOwogfQogCiBzdGF0aWMgc3NpemVfdApAQCAtNDUsNyArNDUsNyBA
QCBzbmljX3Nob3dfbGlua19zdGF0ZShzdHJ1Y3QgZGV2aWNlICpkZXYsCiAJaWYgKHNuaWMtPmNv
bmZpZy54cHRfdHlwZSA9PSBTTklDX0RBUykKIAkJc25pYy0+bGlua19zdGF0dXMgPSBzdm5pY19k
ZXZfbGlua19zdGF0dXMoc25pYy0+dmRldik7CiAKLQlyZXR1cm4gc25wcmludGYoYnVmLCBQQUdF
X1NJWkUsICIlc1xuIiwKKwlyZXR1cm4gc3lzZnNfZW1pdChidWYsICIlc1xuIiwKIAkJCShzbmlj
LT5saW5rX3N0YXR1cykgPyAiTGluayBVcCIgOiAiTGluayBEb3duIik7CiB9CiAKLS0gCjIuMjUu
MQo=
