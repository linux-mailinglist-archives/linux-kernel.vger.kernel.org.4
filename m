Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF80626EB7
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 10:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbiKMJYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 04:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbiKMJYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 04:24:13 -0500
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E20F912D01;
        Sun, 13 Nov 2022 01:24:12 -0800 (PST)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sun, 13 Nov
 2022 17:19:17 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.167]
Date:   Sun, 13 Nov 2022 17:19:17 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wangkailong@jari.cn
To:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        imbrenda@linux.ibm.com, thuth@redhat.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: s390: fix array_size.cocci warning
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <56879380.12c.1847049393b.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwCXn+CVtnBjXxoDAA--.54W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAEB2FEYx0DfwAQs1
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

Rml4IGZvbGxvd2luZyBjb2NjaWNoZWNrIHdhcm5pbmc6CgphcmNoL3MzOTAvdG9vbHMvZ2VuX2Zh
Y2lsaXRpZXMuYzoxNTE6MzctMzg6IFdBUk5JTkc6IFVzZSBBUlJBWV9TSVpFCgpTaWduZWQtb2Zm
LWJ5OiBLYWlMb25nIFdhbmcgPHdhbmdrYWlsb25nQGphcmkuY24+Ci0tLQogYXJjaC9zMzkwL3Rv
b2xzL2dlbl9mYWNpbGl0aWVzLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9hcmNoL3MzOTAvdG9vbHMvZ2VuX2ZhY2ls
aXRpZXMuYyBiL2FyY2gvczM5MC90b29scy9nZW5fZmFjaWxpdGllcy5jCmluZGV4IGNiMGFmZjVj
MDE4Ny4uZjYwN2U1MDkyZjhkIDEwMDY0NAotLS0gYS9hcmNoL3MzOTAvdG9vbHMvZ2VuX2ZhY2ls
aXRpZXMuYworKysgYi9hcmNoL3MzOTAvdG9vbHMvZ2VuX2ZhY2lsaXRpZXMuYwpAQCAtMTQ4LDcg
KzE0OCw3IEBAIHN0YXRpYyB2b2lkIHByaW50X2ZhY2lsaXR5X2xpc3RzKHZvaWQpCiB7CiAJdW5z
aWduZWQgaW50IGk7CiAKLQlmb3IgKGkgPSAwOyBpIDwgc2l6ZW9mKGZhY2lsaXR5X2RlZnMpIC8g
c2l6ZW9mKGZhY2lsaXR5X2RlZnNbMF0pOyBpKyspCisJZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJ
WkUoZmFjaWxpdHlfZGVmcyk7IGkrKykKIAkJcHJpbnRfZmFjaWxpdHlfbGlzdCgmZmFjaWxpdHlf
ZGVmc1tpXSk7CiB9CiAKLS0gCjIuMjUuMQo=
