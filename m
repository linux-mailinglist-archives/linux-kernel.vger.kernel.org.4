Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C9B612441
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 17:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJ2PgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 11:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJ2PgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 11:36:21 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E32ECB3D
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 08:36:20 -0700 (PDT)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sat, 29 Oct
 2022 23:31:43 +0800 (GMT+08:00)
X-Originating-IP: [182.148.13.81]
Date:   Sat, 29 Oct 2022 23:31:43 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wangkailong@jari.cn
To:     airlied@gmail.com, daniel@ffwll.ch, evan.quan@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com
Cc:     darren.powell@amd.com, aleksei.kodanev@bell-sw.com,
        tangmeng@uniontech.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/pm: replace ternary operator with max()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3b1eb0d7.3f.184245eccc6.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwCHj+BfR11j5+AAAA--.10W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAOB2FEYx0BJQAFsy
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

Rml4IHRoZSBmb2xsb3dpbmcgY29jY2ljaGVjayB3YXJuaW5nOgpkcml2ZXJzL2dwdS9kcm0vYW1k
L3BtL3Bvd2VycGxheS9od21nci92ZWdhMTBfaHdtZ3IuYzozNDg6ODUtODY6CldBUk5JTkcgb3Bw
b3J0dW5pdHkgZm9yIG1heCgpCmRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdy
L3ZlZ2ExMF9od21nci5jOjM1MTo1Mi01MzoKV0FSTklORyBvcHBvcnR1bml0eSBmb3IgbWF4KCkK
ClNpZ25lZC1vZmYtYnk6IEthaUxvbmcgV2FuZyA8d2FuZ2thaWxvbmdAamFyaS5jbj4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci92ZWdhMTBfaHdtZ3IuYyB8IDgg
KystLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvdmVn
YTEwX2h3bWdyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci92ZWdh
MTBfaHdtZ3IuYwppbmRleCBjOGM5ZmI4MjdiZGEuLjM1Njc3YzEzZGRmOSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEwX2h3bWdyLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEwX2h3bWdyLmMK
QEAgLTM0NSwxMiArMzQ1LDggQEAgc3RhdGljIGludCB2ZWdhMTBfb2RuX2luaXRpYWxfZGVmYXVs
dF9zZXR0aW5nKHN0cnVjdCBwcF9od21nciAqaHdtZ3IpCiAJCW9kbl90YWJsZS0+bWluX3ZkZGMg
PSBkZXBfdGFibGVbMF0tPmVudHJpZXNbMF0udmRkYzsKIAogCWkgPSBvZF90YWJsZVsyXS0+Y291
bnQgLSAxOwotCW9kX3RhYmxlWzJdLT5lbnRyaWVzW2ldLmNsayA9IGh3bWdyLT5wbGF0Zm9ybV9k
ZXNjcmlwdG9yLm92ZXJkcml2ZUxpbWl0Lm1lbW9yeUNsb2NrID4gb2RfdGFibGVbMl0tPmVudHJp
ZXNbaV0uY2xrID8KLQkJCQkJaHdtZ3ItPnBsYXRmb3JtX2Rlc2NyaXB0b3Iub3ZlcmRyaXZlTGlt
aXQubWVtb3J5Q2xvY2sgOgotCQkJCQlvZF90YWJsZVsyXS0+ZW50cmllc1tpXS5jbGs7Ci0Jb2Rf
dGFibGVbMl0tPmVudHJpZXNbaV0udmRkYyA9IG9kbl90YWJsZS0+bWF4X3ZkZGMgPiBvZF90YWJs
ZVsyXS0+ZW50cmllc1tpXS52ZGRjID8KLQkJCQkJb2RuX3RhYmxlLT5tYXhfdmRkYyA6Ci0JCQkJ
CW9kX3RhYmxlWzJdLT5lbnRyaWVzW2ldLnZkZGM7CisJb2RfdGFibGVbMl0tPmVudHJpZXNbaV0u
Y2xrID0gbWF4KGh3bWdyLT5wbGF0Zm9ybV9kZXNjcmlwdG9yLm92ZXJkcml2ZUxpbWl0Lm1lbW9y
eUNsb2NrLCBvZF90YWJsZVsyXS0+ZW50cmllc1tpXS5jbGspOworCW9kX3RhYmxlWzJdLT5lbnRy
aWVzW2ldLnZkZGMgPSBtYXgob2RuX3RhYmxlLT5tYXhfdmRkYywgb2RfdGFibGVbMl0tPmVudHJp
ZXNbaV0udmRkYyk7CiAKIAlyZXR1cm4gMDsKIH0KLS0gCjIuMjUuMQo=
