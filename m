Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC4460CFCC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbiJYPBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiJYPBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:01:16 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A050E101C5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:01:13 -0700 (PDT)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Tue, 25 Oct
 2022 22:56:11 +0800 (GMT+08:00)
X-Originating-IP: [182.148.15.254]
Date:   Tue, 25 Oct 2022 22:56:11 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wangkailong@jari.cn
To:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        broonie@kernel.org, motolav@gmail.com, cezary.rojewski@intel.com,
        mkumard@nvidia.com, pierre-louis.bossart@linux.intel.com,
        kai.vehmanen@linux.intel.com, peter.ujfalusi@linux.intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA/ASoC: replace ternary operator with min()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3d74bcaf.5.1840fa4d439.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwCXq+EL+VdjmgQAAA--.1W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAKB2FEYx0AUgADsG
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

Rml4IHRoZSBmb2xsb3dpbmcgY29jY2ljaGVjayB3YXJuaW5nOgoKc291bmQvc29jL3NvYy1vcHMu
Yzo4MTc6IFdBUk5JTkcgb3Bwb3J0dW5pdHkgZm9yIG1pbigpCnNvdW5kL2NvcmUvdm1hc3Rlci5j
OjczOiBXQVJOSU5HIG9wcG9ydHVuaXR5IGZvciBtaW4oKQpzb3VuZC9wY2kvaGRhL2hkYV9jb2Rl
Yy5jOjMzNzogV0FSTklORyBvcHBvcnR1bml0eSBmb3IgbWluKCkKc291bmQvcGNpL2N0eGZpL2N0
YXRjLmM6NDQ4OiBXQVJOSU5HIG9wcG9ydHVuaXR5IGZvciBtaW4oKQpzb3VuZC9wY2kvY3R4Zmkv
Y3RhdGMuYzozODc6IFdBUk5JTkcgb3Bwb3J0dW5pdHkgZm9yIG1pbigpCgpTaWduZWQtb2ZmLWJ5
OiBLYWlMb25nIFdhbmcgPHdhbmdrYWlsb25nQGphcmkuY24+Ci0tLQogc291bmQvY29yZS92bWFz
dGVyLmMgICAgICB8IDIgKy0KIHNvdW5kL3BjaS9jdHhmaS9jdGF0Yy5jICAgfCA0ICsrLS0KIHNv
dW5kL3BjaS9oZGEvaGRhX2NvZGVjLmMgfCAyICstCiBzb3VuZC9zb2Mvc29jLW9wcy5jICAgICAg
IHwgMiArLQogNCBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvc291bmQvY29yZS92bWFzdGVyLmMgYi9zb3VuZC9jb3JlL3ZtYXN0ZXIu
YwppbmRleCBkMGYxMWYzNzg4OWIuLjcwNGEwOWY0YmZkNiAxMDA2NDQKLS0tIGEvc291bmQvY29y
ZS92bWFzdGVyLmMKKysrIGIvc291bmQvY29yZS92bWFzdGVyLmMKQEAgLTcwLDcgKzcwLDcgQEAg
c3RhdGljIGludCBmb2xsb3dlcl91cGRhdGUoc3RydWN0IGxpbmtfZm9sbG93ZXIgKmZvbGxvd2Vy
KQogCQlmb2xsb3dlci0+dmFsc1tjaF0gPSB1Y3RsLT52YWx1ZS5pbnRlZ2VyLnZhbHVlW2NoXTsK
ICBlcnJvcjoKIAlrZnJlZSh1Y3RsKTsKLQlyZXR1cm4gZXJyIDwgMCA/IGVyciA6IDA7CisJcmV0
dXJuIG1pbihlcnIsIDApOwogfQogCiAvKiBnZXQgdGhlIGZvbGxvd2VyIGN0bCBpbmZvIGFuZCBz
YXZlIHRoZSBpbml0aWFsIHZhbHVlcyAqLwpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2N0eGZpL2N0
YXRjLmMgYi9zb3VuZC9wY2kvY3R4ZmkvY3RhdGMuYwppbmRleCBmYmRiOGEzZDViOGUuLjlmZWE1
MGI3MmNmYiAxMDA2NDQKLS0tIGEvc291bmQvcGNpL2N0eGZpL2N0YXRjLmMKKysrIGIvc291bmQv
cGNpL2N0eGZpL2N0YXRjLmMKQEAgLTM4NCw3ICszODQsNyBAQCBzdGF0aWMgaW50IGF0Y19wY21f
cGxheWJhY2tfc3RhcnQoc3RydWN0IGN0X2F0YyAqYXRjLCBzdHJ1Y3QgY3RfYXRjX3BjbSAqYXBj
bSkKIAlhcGNtLT5zdGFydGVkID0gMTsKIAogCW1heF9jaXN6ID0gc3JjLT5tdWx0aSAqIHNyYy0+
cnNjLm1zcjsKLQltYXhfY2lzeiA9IDB4ODAgKiAobWF4X2Npc3ogPCA4ID8gbWF4X2Npc3ogOiA4
KTsKKwltYXhfY2lzeiA9IDB4ODAgKiBtaW4obWF4X2Npc3osIDgpOwogCiAJc3JjLT5vcHMtPnNl
dF9zYShzcmMsIGFwY20tPnZtX2Jsb2NrLT5hZGRyKTsKIAlzcmMtPm9wcy0+c2V0X2xhKHNyYywg
YXBjbS0+dm1fYmxvY2stPmFkZHIgKyBhcGNtLT52bV9ibG9jay0+c2l6ZSk7CkBAIC00NDUsNyAr
NDQ1LDcgQEAgYXRjX3BjbV9wbGF5YmFja19wb3NpdGlvbihzdHJ1Y3QgY3RfYXRjICphdGMsIHN0
cnVjdCBjdF9hdGNfcGNtICphcGNtKQogCiAJc2l6ZSA9IGFwY20tPnZtX2Jsb2NrLT5zaXplOwog
CW1heF9jaXN6ID0gc3JjLT5tdWx0aSAqIHNyYy0+cnNjLm1zcjsKLQltYXhfY2lzeiA9IDEyOCAq
IChtYXhfY2lzeiA8IDggPyBtYXhfY2lzeiA6IDgpOworCW1heF9jaXN6ID0gMTI4ICogbWluKG1h
eF9jaXN6LCA4KTsKIAogCXJldHVybiAocG9zaXRpb24gKyBzaXplIC0gbWF4X2Npc3ogLSBhcGNt
LT52bV9ibG9jay0+YWRkcikgJSBzaXplOwogfQpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2hkYS9o
ZGFfY29kZWMuYyBiL3NvdW5kL3BjaS9oZGEvaGRhX2NvZGVjLmMKaW5kZXggYjRkMWU2NThjNTU2
Li5jMTk1Zjk5YmQ4ZDUgMTAwNjQ0Ci0tLSBhL3NvdW5kL3BjaS9oZGEvaGRhX2NvZGVjLmMKKysr
IGIvc291bmQvcGNpL2hkYS9oZGFfY29kZWMuYwpAQCAtMzM0LDcgKzMzNCw3IEBAIGludCBzbmRf
aGRhX2dldF9kZXZpY2VzKHN0cnVjdCBoZGFfY29kZWMgKmNvZGVjLCBoZGFfbmlkX3QgbmlkLAog
CQlyZXR1cm4gMDsKIAogCWRldl9sZW4gPSBwYXJtICsgMTsKLQlkZXZfbGVuID0gZGV2X2xlbiA8
IG1heF9kZXZpY2VzID8gZGV2X2xlbiA6IG1heF9kZXZpY2VzOworCWRldl9sZW4gPSBtaW4oZGV2
X2xlbiwgbWF4X2RldmljZXMpOwogCiAJZGV2aWNlcyA9IDA7CiAJd2hpbGUgKGRldmljZXMgPCBk
ZXZfbGVuKSB7CmRpZmYgLS1naXQgYS9zb3VuZC9zb2Mvc29jLW9wcy5jIGIvc291bmQvc29jL3Nv
Yy1vcHMuYwppbmRleCBiZDg4ZGUwNTYzNTguLmQ3MWQxMDA1NWVkNyAxMDA2NDQKLS0tIGEvc291
bmQvc29jL3NvYy1vcHMuYworKysgYi9zb3VuZC9zb2Mvc29jLW9wcy5jCkBAIC04MTQsNyArODE0
LDcgQEAgaW50IHNuZF9zb2NfYnl0ZXNfdGx2X2NhbGxiYWNrKHN0cnVjdCBzbmRfa2NvbnRyb2wg
Kmtjb250cm9sLCBpbnQgb3BfZmxhZywKIAkJCQl1bnNpZ25lZCBpbnQgc2l6ZSwgdW5zaWduZWQg
aW50IF9fdXNlciAqdGx2KQogewogCXN0cnVjdCBzb2NfYnl0ZXNfZXh0ICpwYXJhbXMgPSAodm9p
ZCAqKWtjb250cm9sLT5wcml2YXRlX3ZhbHVlOwotCXVuc2lnbmVkIGludCBjb3VudCA9IHNpemUg
PCBwYXJhbXMtPm1heCA/IHNpemUgOiBwYXJhbXMtPm1heDsKKwl1bnNpZ25lZCBpbnQgY291bnQg
PSBtaW5fdCh1bnNpZ25lZCBpbnQsIHNpemUsIHBhcmFtcy0+bWF4KTsKIAlpbnQgcmV0ID0gLUVO
WElPOwogCiAJc3dpdGNoIChvcF9mbGFnKSB7Ci0tIAoyLjI1LjEK
