Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76E4612429
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 17:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJ2PYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 11:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJ2PYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 11:24:07 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACC7D52087
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 08:24:04 -0700 (PDT)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sat, 29 Oct
 2022 23:19:27 +0800 (GMT+08:00)
X-Originating-IP: [182.148.13.81]
Date:   Sat, 29 Oct 2022 23:19:27 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wangkailong@jari.cn
To:     harry.wentland@amd.com, sunpeng.li@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, HaoPing.Liu@amd.com, nicholas.kazlauskas@amd.com
Cc:     mario.limonciello@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: replace ternary operator with max()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <9d641b0.3d.184245391ec.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwCXq+F_RF1jA+AAAA--.19W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAKB2FEYx0AVwALsL
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

Rml4IHRoZSBmb2xsb3dpbmcgY29jY2ljaGVjayB3YXJuaW5nOgoKZGNuMjBfY2xrX21nci5jOjMx
NDpXQVJOSU5HIG9wcG9ydHVuaXR5IGZvciBtYXgoKQpkY24yMF9jbGtfbWdyLmM6MzUxOldBUk5J
Tkcgb3Bwb3J0dW5pdHkgZm9yIG1heCgpCgpTaWduZWQtb2ZmLWJ5OiBLYWlMb25nIFdhbmcgPHdh
bmdrYWlsb25nQGphcmkuY24+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Ns
a19tZ3IvZGNuMjAvZGNuMjBfY2xrX21nci5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9jbGtfbWdyL2RjbjIwL2RjbjIwX2Nsa19tZ3IuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9jbGtfbWdyL2RjbjIwL2RjbjIwX2Nsa19tZ3IuYwppbmRl
eCA2NTBmM2I0YjU2MmUuLjFhZWNkYzVmNzNiNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2Nsa19tZ3IvZGNuMjAvZGNuMjBfY2xrX21nci5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jbGtfbWdyL2RjbjIwL2RjbjIwX2Nsa19tZ3IuYwpA
QCAtMzExLDcgKzMxMSw3IEBAIHZvaWQgZGNuMl91cGRhdGVfY2xvY2tzKHN0cnVjdCBjbGtfbWdy
ICpjbGtfbWdyX2Jhc2UsCiAJCW5ld19jbG9ja3MtPmRpc3BfZHBwX3ZvbHRhZ2VfbGV2ZWxfa2h6
ID0gbmV3X2Nsb2Nrcy0+ZHBwY2xrX2toejsKIAogCQlpZiAodXBkYXRlX2Rpc3BjbGspCi0JCQlu
ZXdfY2xvY2tzLT5kaXNwX2RwcF92b2x0YWdlX2xldmVsX2toeiA9IG5ld19jbG9ja3MtPmRpc3Bj
bGtfa2h6ID4gbmV3X2Nsb2Nrcy0+ZHBwY2xrX2toeiA/IG5ld19jbG9ja3MtPmRpc3BjbGtfa2h6
IDogbmV3X2Nsb2Nrcy0+ZHBwY2xrX2toejsKKwkJCW5ld19jbG9ja3MtPmRpc3BfZHBwX3ZvbHRh
Z2VfbGV2ZWxfa2h6ID0gbWF4KG5ld19jbG9ja3MtPmRpc3BjbGtfa2h6LCBuZXdfY2xvY2tzLT5k
cHBjbGtfa2h6KTsKIAogCQljbGtfbWdyX2Jhc2UtPmNsa3MuZGlzcF9kcHBfdm9sdGFnZV9sZXZl
bF9raHogPSBuZXdfY2xvY2tzLT5kaXNwX2RwcF92b2x0YWdlX2xldmVsX2toejsKIAkJaWYgKHBw
X3NtdSAmJiBwcF9zbXUtPnNldF92b2x0YWdlX2J5X2ZyZXEpCkBAIC0zNDgsNyArMzQ4LDcgQEAg
dm9pZCBkY24yX3VwZGF0ZV9jbG9ja3NfZnBnYShzdHJ1Y3QgY2xrX21nciAqY2xrX21nciwKIAog
CXN0cnVjdCBkY19jbG9ja3MgKm5ld19jbG9ja3MgPSAmY29udGV4dC0+YndfY3R4LmJ3LmRjbi5j
bGs7CiAJLyogTWluIGZjbGsgPSAxLjJHSHogc2luY2UgYWxsIHRoZSBleHRyYSBzY2VtaSBsb2dp
YyBzZWVtcyB0byBydW4gb2ZmIG9mIGl0ICovCi0JaW50IGZjbGtfYWRqID0gbmV3X2Nsb2Nrcy0+
ZmNsa19raHogPiAxMjAwMDAwID8gbmV3X2Nsb2Nrcy0+ZmNsa19raHogOiAxMjAwMDAwOworCWlu
dCBmY2xrX2FkaiA9IG1heChuZXdfY2xvY2tzLT5mY2xrX2toeiwgMTIwMDAwMCk7CiAKIAlpZiAo
c2hvdWxkX3NldF9jbG9jayhzYWZlX3RvX2xvd2VyLCBuZXdfY2xvY2tzLT5waHljbGtfa2h6LCBj
bGtfbWdyLT5jbGtzLnBoeWNsa19raHopKSB7CiAJCWNsa19tZ3ItPmNsa3MucGh5Y2xrX2toeiA9
IG5ld19jbG9ja3MtPnBoeWNsa19raHo7Ci0tIAoyLjI1LjEK
