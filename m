Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F47620DF7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbiKHLAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbiKHLAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:00:03 -0500
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CA14450B3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 02:59:54 -0800 (PST)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Tue, 8 Nov 2022
 18:55:03 +0800 (GMT+08:00)
X-Originating-IP: [182.148.13.29]
Date:   Tue, 8 Nov 2022 18:55:03 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wangkailong@jari.cn
To:     Wentland <harry.wentland@amd.com>, Li <sunpeng.li@amd.com>,
        Siqueira <Rodrigo.Siqueira@amd.com>,
        Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, Airlie <airlied@gmail.com>,
        Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject:  [PATCH] drm/amd/display: fix array-bounds error in
 dc_stream_remove_writeback()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7bafafdf.f5.18456e11abd.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwCXn+CHNWpjAcsBAA--.39W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAEB2FEYx0DdQABsu
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

cmVwbGFjZSB0aGUgc3Vic2VxdWVudCBjaGVjayBmb3IgJ2kgIT0gaicgd2l0aCAKRGVsZXRlIGhl
YWRlciBmaWxlICJ0aW1pbmdfZ2VuZXJhdG9yLmgiCgpTaWduZWQtb2ZmLWJ5OiBLYWlMb25nIFdh
bmcgPHdhbmdrYWlsb25nQGphcmkuY24+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2NvcmUvZGNfc3RyZWFtLmMgfCAxNyArKysrKysrLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5n
ZWQsIDcgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfc3RyZWFtLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19zdHJlYW0uYwppbmRleCAzOGQ3MWI1YzFmMmQuLjY2
NjYxYTIwMTE3YiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Nv
cmUvZGNfc3RyZWFtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUv
ZGNfc3RyZWFtLmMKQEAgLTI5LDcgKzI5LDYgQEAKICNpbmNsdWRlICJjb3JlX3R5cGVzLmgiCiAj
aW5jbHVkZSAicmVzb3VyY2UuaCIKICNpbmNsdWRlICJpcHAuaCIKLSNpbmNsdWRlICJ0aW1pbmdf
Z2VuZXJhdG9yLmgiCiAjaW5jbHVkZSAiZGNfZG11Yl9zcnYuaCIKIAogI2RlZmluZSBEQ19MT0dH
RVIgZGMtPmN0eC0+bG9nZ2VyCkBAIC0xNTIsOSArMTUxLDggQEAgc3RhdGljIHZvaWQgZGNfc3Ry
ZWFtX2ZyZWUoc3RydWN0IGtyZWYgKmtyZWYpCiAKIHZvaWQgZGNfc3RyZWFtX3JlbGVhc2Uoc3Ry
dWN0IGRjX3N0cmVhbV9zdGF0ZSAqc3RyZWFtKQogewotCWlmIChzdHJlYW0gIT0gTlVMTCkgewor
CWlmIChzdHJlYW0gIT0gTlVMTCkKIAkJa3JlZl9wdXQoJnN0cmVhbS0+cmVmY291bnQsIGRjX3N0
cmVhbV9mcmVlKTsKLQl9CiB9CiAKIHN0cnVjdCBkY19zdHJlYW1fc3RhdGUgKmRjX2NyZWF0ZV9z
dHJlYW1fZm9yX3NpbmsoCkBAIC0zMTYsMTEgKzMxNCwxMSBAQCBib29sIGRjX3N0cmVhbV9zZXRf
Y3Vyc29yX2F0dHJpYnV0ZXMoCiAJc3RydWN0IGRjICAqZGM7CiAJYm9vbCByZXNldF9pZGxlX29w
dGltaXphdGlvbnMgPSBmYWxzZTsKIAotCWlmIChOVUxMID09IHN0cmVhbSkgeworCWlmIChzdHJl
YW0gPT0gTlVMTCkgewogCQlkbV9lcnJvcigiREM6IGRjX3N0cmVhbSBpcyBOVUxMIVxuIik7CiAJ
CXJldHVybiBmYWxzZTsKIAl9Ci0JaWYgKE5VTEwgPT0gYXR0cmlidXRlcykgeworCWlmIChhdHRy
aWJ1dGVzID09IE5VTEwpIHsKIAkJZG1fZXJyb3IoIkRDOiBhdHRyaWJ1dGVzIGlzIE5VTEwhXG4i
KTsKIAkJcmV0dXJuIGZhbHNlOwogCX0KQEAgLTM5OSwxMiArMzk3LDEyIEBAIGJvb2wgZGNfc3Ry
ZWFtX3NldF9jdXJzb3JfcG9zaXRpb24oCiAJc3RydWN0IGRjICAqZGMgPSBzdHJlYW0tPmN0eC0+
ZGM7CiAJYm9vbCByZXNldF9pZGxlX29wdGltaXphdGlvbnMgPSBmYWxzZTsKIAotCWlmIChOVUxM
ID09IHN0cmVhbSkgeworCWlmIChzdHJlYW0gPT0gTlVMTCkgewogCQlkbV9lcnJvcigiREM6IGRj
X3N0cmVhbSBpcyBOVUxMIVxuIik7CiAJCXJldHVybiBmYWxzZTsKIAl9CiAKLQlpZiAoTlVMTCA9
PSBwb3NpdGlvbikgeworCWlmIChwb3NpdGlvbiA9PSBOVUxMKSB7CiAJCWRtX2Vycm9yKCJEQzog
Y3Vyc29yIHBvc2l0aW9uIGlzIE5VTEwhXG4iKTsKIAkJcmV0dXJuIGZhbHNlOwogCX0KQEAgLTQ2
OCw5ICs0NjYsOCBAQCBib29sIGRjX3N0cmVhbV9hZGRfd3JpdGViYWNrKHN0cnVjdCBkYyAqZGMs
CiAJCX0KIAl9CiAKLQlpZiAoIWlzRHJjKSB7CisJaWYgKCFpc0RyYykKIAkJc3RyZWFtLT53cml0
ZWJhY2tfaW5mb1tzdHJlYW0tPm51bV93Yl9pbmZvKytdID0gKndiX2luZm87Ci0JfQogCiAJaWYg
KGRjLT5od3NzLmVuYWJsZV93cml0ZWJhY2spIHsKIAkJc3RydWN0IGRjX3N0cmVhbV9zdGF0dXMg
KnN0cmVhbV9zdGF0dXMgPSBkY19zdHJlYW1fZ2V0X3N0YXR1cyhzdHJlYW0pOwpAQCAtNTI2LDcg
KzUyMyw3IEBAIGJvb2wgZGNfc3RyZWFtX3JlbW92ZV93cml0ZWJhY2soc3RydWN0IGRjICpkYywK
IAkvKiByZW1vdmUgd3JpdGViYWNrIGluZm8gZm9yIGRpc2FibGVkIHdyaXRlYmFjayBwaXBlcyBm
cm9tIHN0cmVhbSAqLwogCWZvciAoaSA9IDAsIGogPSAwOyBpIDwgc3RyZWFtLT5udW1fd2JfaW5m
bzsgaSsrKSB7CiAJCWlmIChzdHJlYW0tPndyaXRlYmFja19pbmZvW2ldLndiX2VuYWJsZWQpIHsK
LQkJCWlmIChqIDwgaSkKKwkJCWlmIChpICE9IGopCiAJCQkJLyogdHJpbSB0aGUgYXJyYXkgKi8K
IAkJCQlzdHJlYW0tPndyaXRlYmFja19pbmZvW2pdID0gc3RyZWFtLT53cml0ZWJhY2tfaW5mb1tp
XTsKIAkJCWorKzsKLS0gCjIuMzYuMQoK
