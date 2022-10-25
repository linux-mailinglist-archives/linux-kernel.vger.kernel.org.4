Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D969560D052
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbiJYPVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbiJYPUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:20:43 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECFCA2BE6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:19:34 -0700 (PDT)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Tue, 25 Oct
 2022 23:15:01 +0800 (GMT+08:00)
X-Originating-IP: [182.148.15.254]
Date:   Tue, 25 Oct 2022 23:15:01 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wangkailong@jari.cn
To:     Jason@zx2c4.com, djwong@kernel.org, hca@linux.ibm.com,
        gregkh@linuxfoundation.org, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] rslib: replace ternary operator with min()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4b3795b5.6.1840fb613ac.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwB3jOJ1_VdjvwQAAA--.4W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAKB2FEYx0AVwAEsE
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
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

Rml4IHRoZSBmb2xsb3dpbmcgY29jY2ljaGVjayB3YXJuaW5nOgoKbGliL3JlZWRfc29sb21vbi90
ZXN0X3JzbGliLmM6NDIyOiBXQVJOSU5HIG9wcG9ydHVuaXR5IGZvciBtaW4oKQoKU2lnbmVkLW9m
Zi1ieTogS2FpTG9uZyBXYW5nIDx3YW5na2FpbG9uZ0BqYXJpLmNuPgotLS0KIGxpYi9yZWVkX3Nv
bG9tb24vdGVzdF9yc2xpYi5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvbGliL3JlZWRfc29sb21vbi90ZXN0X3JzbGli
LmMgYi9saWIvcmVlZF9zb2xvbW9uL3Rlc3RfcnNsaWIuYwppbmRleCA4NDhlN2ViNWRhOTIuLmY0
YTAzYWU0M2I4NiAxMDA2NDQKLS0tIGEvbGliL3JlZWRfc29sb21vbi90ZXN0X3JzbGliLmMKKysr
IGIvbGliL3JlZWRfc29sb21vbi90ZXN0X3JzbGliLmMKQEAgLTQxOSw3ICs0MTksNyBAQCBzdGF0
aWMgaW50IGV4ZXJjaXNlX3JzX2JjKHN0cnVjdCByc19jb250cm9sICpycywgc3RydWN0IHdzcGFj
ZSAqd3MsCiAJCWlmIChlcmFzIDwgMCkKIAkJCWVyYXMgPSAwOwogCi0JCWN1dG9mZiA9IG5yb290
cyA8PSBsZW4gLSBlcnJzID8gbnJvb3RzIDogbGVuIC0gZXJyczsKKwkJY3V0b2ZmID0gbWluKG5y
b290cywgbGVuIC0gZXJycyk7CiAJCWZvciAoOyBlcmFzIDw9IGN1dG9mZjsgZXJhcysrKQogCQkJ
dGVzdF9iYyhycywgbGVuLCBlcnJzLCBlcmFzLCB0cmlhbHMsICZzdGF0LCB3cyk7CiAJfQotLSAK
Mi4yNS4xCg==
