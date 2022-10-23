Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E44A6092FA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 14:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiJWMsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 08:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiJWMsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 08:48:10 -0400
X-Greylist: delayed 118 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 23 Oct 2022 05:48:01 PDT
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FC6674E03
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 05:48:01 -0700 (PDT)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sun, 23 Oct
 2022 20:44:20 +0800 (GMT+08:00)
X-Originating-IP: [182.148.15.254]
Date:   Sun, 23 Oct 2022 20:44:20 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "KaiLong Wang" <wangkailong@jari.cn>
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        farosas@linux.ibm.com, mirq-linux@rere.qmqm.pl,
        dmitry.osipenko@collabora.com, kda@linux-powerpc.org,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject:  [PATCH] powerpc: replace ternary operator with min()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4ebda26c.346.18404df6852.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwD3AG8lN1Vjk+RoAA--.1470W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAIB2FEYxtOmwAAsG
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

Rml4IHRoZSBmb2xsb3dpbmcgY29jY2ljaGVjayB3YXJuaW5nOgoKYXJjaC9wb3dlcnBjL3htb24v
eG1vbi5jOjI5ODc6IFdBUk5JTkcgb3Bwb3J0dW5pdHkgZm9yIG1pbigpCmFyY2gvcG93ZXJwYy94
bW9uL3htb24uYzoyNTgzOiBXQVJOSU5HIG9wcG9ydHVuaXR5IGZvciBtaW4oKQoKU2lnbmVkLW9m
Zi1ieTogS2FpTG9uZyBXYW5nIDx3YW5na2FpbG9uZ0BqYXJpLmNuPgotLS0KIGFyY2gvcG93ZXJw
Yy94bW9uL3htb24uYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMveG1vbi94bW9uLmMgYi9h
cmNoL3Bvd2VycGMveG1vbi94bW9uLmMKaW5kZXggZjUxYzg4MmJmOTAyLi5hNzc1MWNkMmNjOWQg
MTAwNjQ0Ci0tLSBhL2FyY2gvcG93ZXJwYy94bW9uL3htb24uYworKysgYi9hcmNoL3Bvd2VycGMv
eG1vbi94bW9uLmMKQEAgLTI1ODAsNyArMjU4MCw3IEBAIHN0YXRpYyB2b2lkIHhtb25fcmF3ZHVt
cCAodW5zaWduZWQgbG9uZyBhZHJzLCBsb25nIG5kdW1wKQogCXVuc2lnbmVkIGNoYXIgdGVtcFsx
Nl07CiAKIAlmb3IgKG4gPSBuZHVtcDsgbiA+IDA7KSB7Ci0JCXIgPSBuIDwgMTY/IG46IDE2Owor
CQlyID0gbWluKG4sIDE2KTsKIAkJbnIgPSBtcmVhZChhZHJzLCB0ZW1wLCByKTsKIAkJYWRycyAr
PSBucjsKIAkJZm9yIChtID0gMDsgbSA8IHI7ICsrbSkgewpAQCAtMjk4NCw3ICsyOTg0LDcgQEAg
cHJkdW1wKHVuc2lnbmVkIGxvbmcgYWRycywgbG9uZyBuZHVtcCkKIAlmb3IgKG4gPSBuZHVtcDsg
biA+IDA7KSB7CiAJCXByaW50ZihSRUcsIGFkcnMpOwogCQlwdXRjaGFyKCcgJyk7Ci0JCXIgPSBu
IDwgMTY/IG46IDE2OworCQlyID0gbWluKG4sIDE2KTsKIAkJbnIgPSBtcmVhZChhZHJzLCB0ZW1w
LCByKTsKIAkJYWRycyArPSBucjsKIAkJZm9yIChtID0gMDsgbSA8IHI7ICsrbSkgewotLSAKMi4y
NS4xCg==
