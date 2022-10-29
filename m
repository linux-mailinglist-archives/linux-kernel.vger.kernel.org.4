Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5B6612456
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 18:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJ2QBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 12:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJ2QA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 12:00:59 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D88F12CCB5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 09:00:44 -0700 (PDT)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sat, 29 Oct
 2022 23:56:03 +0800 (GMT+08:00)
X-Originating-IP: [182.148.13.81]
Date:   Sat, 29 Oct 2022 23:56:03 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wangkailong@jari.cn
To:     harry.wentland@amd.com, daniel@ffwll.ch, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, airlied@gmail.com, jun.lei@amd.com,
        Alvin.Lee2@amd.com, Nevenko.Stupar@amd.com, samson.tam@amd.com
Cc:     rdunlap@infradead.org, David.Galiffi@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject:  [PATCH] drm/amd/display: replace ternary operator with max()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <20f55cfc.42.1842475135f.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwB3jOITTV1jjuIAAA--.21W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAOB2FEYx0BKAAHs9
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

Rml4IHRoZSBmb2xsb3dpbmcgY29jY2ljaGVjayB3YXJuaW5nOgoKZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2RtbC9kY24zMi9kY24zMl9mcHUuYzo4ODc6NDktNTA6CldBUk5JTkcgb3Bw
b3J0dW5pdHkgZm9yIG1heCgpCmRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwvZGNu
MzIvZGNuMzJfZnB1LmM6OTc4OjQyLTQzOgpXQVJOSU5HIG9wcG9ydHVuaXR5IGZvciBtYXgoKQoK
U2lnbmVkLW9mZi1ieTogS2FpTG9uZyBXYW5nIDx3YW5na2FpbG9uZ0BqYXJpLmNuPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwvZGNuMzIvZGNuMzJfZnB1LmMgfCA0ICsr
LS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtbC9kY24zMi9kY24zMl9m
cHUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwvZGNuMzIvZGNuMzJfZnB1
LmMKaW5kZXggYjZjZDEwZjMxODFjLi41ZmRiYmRjYTk3ZTAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwvZGNuMzIvZGNuMzJfZnB1LmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtbC9kY24zMi9kY24zMl9mcHUuYwpAQCAtODg0LDcg
Kzg4NCw3IEBAIHN0YXRpYyBib29sIHN1YnZwX2Rycl9zY2hlZHVsYWJsZShzdHJ1Y3QgZGMgKmRj
LCBzdHJ1Y3QgZGNfc3RhdGUgKmNvbnRleHQsIHN0cnVjCiAJc3RyZXRjaGVkX2Rycl91cyA9IGRy
cl9mcmFtZV91cyArIG1hbGxfcmVnaW9uX3VzICsgU1VCVlBfRFJSX01BUkdJTl9VUzsKIAlkcnJf
c3RyZXRjaGVkX3ZibGFua191cyA9IChkcnJfdGltaW5nLT52X3RvdGFsIC0gZHJyX3RpbWluZy0+
dl9hZGRyZXNzYWJsZSkgKiBkcnJfdGltaW5nLT5oX3RvdGFsIC8KIAkJCShkb3VibGUpKGRycl90
aW1pbmctPnBpeF9jbGtfMTAwaHogKiAxMDApICogMTAwMDAwMCArIChzdHJldGNoZWRfZHJyX3Vz
IC0gZHJyX2ZyYW1lX3VzKTsKLQltYXhfdmJsYW5rX21hbGxyZWdpb24gPSBkcnJfc3RyZXRjaGVk
X3ZibGFua191cyA+IG1hbGxfcmVnaW9uX3VzID8gZHJyX3N0cmV0Y2hlZF92YmxhbmtfdXMgOiBt
YWxsX3JlZ2lvbl91czsKKwltYXhfdmJsYW5rX21hbGxyZWdpb24gPSBtYXgoZHJyX3N0cmV0Y2hl
ZF92YmxhbmtfdXMsIG1hbGxfcmVnaW9uX3VzKTsKIAogCS8qIFdlIGNvbnNpZGVyIFN1YlZQICsg
RFJSIHNjaGVkdWxhYmxlIGlmIHRoZSBzdHJldGNoZWQgZnJhbWUgZHVyYXRpb24gb2YgdGhlIERS
UiBkaXNwbGF5IChpLmUuIHRoZQogCSAqIGhpZ2hlc3QgcmVmcmVzaCByYXRlICsgbWFyZ2luIHRo
YXQgY2FuIHN1cHBvcnQgVUNMSyBQLVN0YXRlIHN3aXRjaCkgcGFzc2VzIHRoZSBzdGF0aWMgYW5h
bHlzaXMKQEAgLTk3NSw3ICs5NzUsNyBAQCBzdGF0aWMgYm9vbCBzdWJ2cF92Ymxhbmtfc2NoZWR1
bGFibGUoc3RydWN0IGRjICpkYywgc3RydWN0IGRjX3N0YXRlICpjb250ZXh0KQogCQkJCShkb3Vi
bGUpKHZibGFua190aW1pbmctPnBpeF9jbGtfMTAwaHogKiAxMDApICogMTAwMDAwMDsKIAkJc3Vi
dnBfYWN0aXZlX3VzID0gbWFpbl90aW1pbmctPnZfYWRkcmVzc2FibGUgKiBtYWluX3RpbWluZy0+
aF90b3RhbCAvCiAJCQkJKGRvdWJsZSkobWFpbl90aW1pbmctPnBpeF9jbGtfMTAwaHogKiAxMDAp
ICogMTAwMDAwMDsKLQkJbWF4X3ZibGFua19tYWxscmVnaW9uID0gdmJsYW5rX2JsYW5rX3VzID4g
bWFsbF9yZWdpb25fdXMgPyB2YmxhbmtfYmxhbmtfdXMgOiBtYWxsX3JlZ2lvbl91czsKKwkJbWF4
X3ZibGFua19tYWxscmVnaW9uID0gbWF4KHZibGFua19ibGFua191cywgbWFsbF9yZWdpb25fdXMp
OwogCiAJCS8vIFNjaGVkdWxhYmxlIGlmIFZBQ1RJVkUgcmVnaW9uIG9mIHRoZSBTdWJWUCBwaXBl
IGNhbiBmaXQgdGhlIE1BTEwgcHJlZmV0Y2gsIFZCTEFOSyBmcmFtZSB0aW1lLAogCQkvLyBhbmQg
dGhlIG1heCBvZiAoVkJMQU5LIGJsYW5raW5nIHRpbWUsIE1BTEwgcmVnaW9uKQotLSAKMi4yNS4x
Cg==
