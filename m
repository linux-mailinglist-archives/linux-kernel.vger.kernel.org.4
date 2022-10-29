Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D02461244D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 17:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJ2Ppr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 11:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiJ2Ppf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 11:45:35 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3524D631ED
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 08:45:33 -0700 (PDT)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sat, 29 Oct
 2022 23:40:58 +0800 (GMT+08:00)
X-Originating-IP: [182.148.13.81]
Date:   Sat, 29 Oct 2022 23:40:58 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wangkailong@jari.cn
To:     Kai.Makisara@kolumbus.fi, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: st: replace ternary operator with max()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <317f9e05.40.18424674406.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwCXq+GKSV1jUOEAAA--.20W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAOB2FEYx0BKAADs5
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

Rml4IHRoZSBmb2xsb3dpbmcgY29jY2ljaGVjayB3YXJuaW5nOgoKZHJpdmVycy9zY3NpL3N0LmM6
MTU3NzogV0FSTklORyBvcHBvcnR1bml0eSBmb3IgbWF4KCkKClNpZ25lZC1vZmYtYnk6IEthaUxv
bmcgV2FuZyA8d2FuZ2thaWxvbmdAamFyaS5jbj4KLS0tCiBkcml2ZXJzL3Njc2kvc3QuYyB8IDMg
Ky0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9zY3NpL3N0LmMgYi9kcml2ZXJzL3Njc2kvc3QuYwppbmRleCBiOTBh
NDQwZTEzNWQuLjU0Nzc4OTdhYTkyMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9zY3NpL3N0LmMKKysr
IGIvZHJpdmVycy9zY3NpL3N0LmMKQEAgLTE1NzQsOCArMTU3NCw3IEBAIHN0YXRpYyBpbnQgc2V0
dXBfYnVmZmVyaW5nKHN0cnVjdCBzY3NpX3RhcGUgKlNUcCwgY29uc3QgY2hhciBfX3VzZXIgKmJ1
ZiwKIAogCWlmICghU1RicC0+ZG9fZGlvKSB7CiAJCWlmIChTVHAtPmJsb2NrX3NpemUpCi0JCQli
dWZzaXplID0gU1RwLT5ibG9ja19zaXplID4gc3RfZml4ZWRfYnVmZmVyX3NpemUgPwotCQkJCVNU
cC0+YmxvY2tfc2l6ZSA6IHN0X2ZpeGVkX2J1ZmZlcl9zaXplOworCQkJYnVmc2l6ZSA9IG1heChT
VHAtPmJsb2NrX3NpemUsIHN0X2ZpeGVkX2J1ZmZlcl9zaXplKTsKIAkJZWxzZSB7CiAJCQlidWZz
aXplID0gY291bnQ7CiAJCQkvKiBNYWtlIHN1cmUgdGhhdCBkYXRhIGZyb20gcHJldmlvdXMgdXNl
ciBpcyBub3QgbGVha2VkIGV2ZW4gaWYKLS0gCjIuMjUuMQo=
