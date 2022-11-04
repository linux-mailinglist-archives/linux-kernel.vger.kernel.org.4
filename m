Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C9A619711
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiKDNHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiKDNHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:07:39 -0400
Received: from m13134.mail.163.com (m13134.mail.163.com [220.181.13.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89F142E6B9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 06:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=M9PbT
        Gakjv/3zqqgp2j3iH+TiftOFmtoxz74GES9Wdo=; b=Yp/+ETeK6T2LXqYxNALmY
        CjF/byF4HURdXx4RLah+6zhP35r5VkVwOboxj1jrufD3Huwl3mLjk2nmx5qKIukL
        jH4Wm9IVgMZ82BCTNoxEw7M2dmVa305eNgdRcpXK/+l17Guqna9gmuaoq4IT3hmJ
        RsPUcQbRcv+LsrJ3c2keeM=
Received: from 00107082$163.com ( [222.64.157.165] ) by
 ajax-webmail-wmsvr134 (Coremail) ; Fri, 4 Nov 2022 21:07:35 +0800 (CST)
X-Originating-IP: [222.64.157.165]
Date:   Fri, 4 Nov 2022 21:07:35 +0800 (CST)
From:   "David Wang" <00107082@163.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] trace/trace_uprobe: Only invoke uprobe ebpf handler when
 event matches.
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
X-NTES-SC: AL_QuydBfmduEou4yWfZekZnEoUjug3W8K5v/kk3Y9VOp80iivC1Q4adlVPLEL4686kOQeHmjKpQSRf6PtgR4pKcqx5q1y7eiLUqlPJsufzuHT5
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <41828b90.5798.18442c10017.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: hsGowACH_t2XDmVjmj5cAA--.49235W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiEAivql8YLKr7GgABs8
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T25seSBpbnZva2UgdXByb2JlIGVicGYgaGFuZGxlciB3aGVuIGV2ZW50IG1hdGNoZXMuCiAgICAK
dXByb2JlIGVicGYgaGFuZGxlciB3b3VsZCBiZSBjYWxsZWQgZXZlbiB0aGUgZXZlbnQgZG9zZSBu
b3QKbWF0Y2ggYW55IHJlZ2lzdGVyZWQgcGVyZiBldmVudCwgZm9sbG93aW5nIHN0ZXBzIHdvdWxk
IGJlCnVzZWQgdG8gZ2VuZXJhdGUgYSB1bnJlZ2lzdGVyZWQgcGVyZiBldmVudC4KMS4gcmVnaXN0
ZXIgYSB1cHJvYmUgZXZlbnQgb24gYSBzcGVjaWZpZWQgcGlkIDxwaWQtYT4KMi4gPHBpZC1hPiBp
bnZva2VzIHN5c2NhbGwgYGNsb25lYCAodmlhIHB0aHJlYWRfY3JlYXRlKSwKICAgIG5ldyBwcm9j
ZXNzIDxwaWQtYj4gZ2VuZXJhdGVkLiAoTWF5YmUgaXQgaXMgYSBidWcgaGVyZSwgdGhlCnVwcm9i
ZSBicmVha3BvaW50IGlzIGluaGVyaXRlZCBmcm9tIDxwaWQtYT4KMy4gPHBpZC1iPiBpbnZva2Vz
IHRoZSBmdW5jdGlvbiB3aGljaCBpcyB1cHJvYmVkIGluIHN0ZXAgMS4KNC4gcGVyZiBldmVudCBn
ZW5lcmF0ZWQuLi4KICAgIApFYnBmIGhhbmRsZXIgd291bGQgYmUgaW52b2tlZCBldmVuIHRoZSBl
dmVudCBoYXBwZW5lZCBvbiA8cGlkLWI+LApidXQgdGhlIGRlZmF1bHQgcGVyZiBldmVudCBoYW5k
bGVyIG1ha2UgZnVydGhlciBjaGVjayBhbmQgaWdub3JlCnRoZSBldmVudCBiZWNhdXNlIG5vIHJl
Z2lzdGVyZWQgcGVyZiBldmVudCBtYXRjaCBvbiA8cGlkLWI+LgoKVGhlIHBhdGNoIG1lYW5zIHRv
IGZpeCB0aGUgaW5jb25zaXN0ZW50IGJlaGF2aW9yIGJldHdlZW4gZWJwZiBhbmQgdGhlIGRlZmF1
bHQuCkJlZm9yZSBpbnZva2UgdXByb2JlIGVicGYgaGFuZGxlciwgbWFrZSBzdXJlIGN1cnJlbnQg
ZXZlbnQgbWF0Y2guCiAgICAKU2lnbmVkLW9mZi1ieTogRGF2aWQgV2FuZyA8MDAxMDcwODJAMTYz
LmNvbT4KLS0KZGlmZiAtLWdpdCBhL2tlcm5lbC90cmFjZS90cmFjZV91cHJvYmUuYyBiL2tlcm5l
bC90cmFjZS90cmFjZV91cHJvYmUuYwppbmRleCBmYjU4ZTg2ZGQxMTcuLjZmMTMxNjNjMGMwZiAx
MDA2NDQKLS0tIGEva2VybmVsL3RyYWNlL3RyYWNlX3Vwcm9iZS5jCisrKyBiL2tlcm5lbC90cmFj
ZS90cmFjZV91cHJvYmUuYwpAQCAtMTM0NiwyNyArMTM0NiwyMCBAQCBzdGF0aWMgdm9pZCBfX3Vw
cm9iZV9wZXJmX2Z1bmMoc3RydWN0IHRyYWNlX3Vwcm9iZSAqdHUsCiAJdm9pZCAqZGF0YTsKIAlp
bnQgc2l6ZSwgZXNpemU7CiAJaW50IHJjdHg7CisJYm9vbCB0cmFjZV9ldmVudF9tYXRjaCA9IHRy
dWU7CiAKLSNpZmRlZiBDT05GSUdfQlBGX0VWRU5UUwotCWlmIChicGZfcHJvZ19hcnJheV92YWxp
ZChjYWxsKSkgewotCQl1MzIgcmV0OwogCi0JCXJldCA9IGJwZl9wcm9nX3J1bl9hcnJheV9zbGVl
cGFibGUoY2FsbC0+cHJvZ19hcnJheSwgcmVncywgYnBmX3Byb2dfcnVuKTsKLQkJaWYgKCFyZXQp
Ci0JCQlyZXR1cm47CisJcHJlZW1wdF9kaXNhYmxlKCk7CisJaGVhZCA9IHRoaXNfY3B1X3B0cihj
YWxsLT5wZXJmX2V2ZW50cyk7CisJaWYgKGhsaXN0X2VtcHR5KGhlYWQpKSB7CisJCXRyYWNlX2V2
ZW50X21hdGNoID0gZmFsc2U7CisJCWdvdG8gb3V0OwogCX0KLSNlbmRpZiAvKiBDT05GSUdfQlBG
X0VWRU5UUyAqLwogCiAJZXNpemUgPSBTSVpFT0ZfVFJBQ0VfRU5UUlkoaXNfcmV0X3Byb2JlKHR1
KSk7Ci0KIAlzaXplID0gZXNpemUgKyB0dS0+dHAuc2l6ZSArIGRzaXplOwogCXNpemUgPSBBTElH
TihzaXplICsgc2l6ZW9mKHUzMiksIHNpemVvZih1NjQpKSAtIHNpemVvZih1MzIpOwogCWlmIChX
QVJOX09OQ0Uoc2l6ZSA+IFBFUkZfTUFYX1RSQUNFX1NJWkUsICJwcm9maWxlIGJ1ZmZlciBub3Qg
bGFyZ2UgZW5vdWdoIikpCi0JCXJldHVybjsKLQotCXByZWVtcHRfZGlzYWJsZSgpOwotCWhlYWQg
PSB0aGlzX2NwdV9wdHIoY2FsbC0+cGVyZl9ldmVudHMpOwotCWlmIChobGlzdF9lbXB0eShoZWFk
KSkKIAkJZ290byBvdXQ7CiAKIAllbnRyeSA9IHBlcmZfdHJhY2VfYnVmX2FsbG9jKHNpemUsIE5V
TEwsICZyY3R4KTsKQEAgLTEzODksMTEgKzEzODIsMjEgQEAgc3RhdGljIHZvaWQgX191cHJvYmVf
cGVyZl9mdW5jKHN0cnVjdCB0cmFjZV91cHJvYmUgKnR1LAogCiAJCW1lbXNldChkYXRhICsgbGVu
LCAwLCBzaXplIC0gZXNpemUgLSBsZW4pOwogCX0KLQogCXBlcmZfdHJhY2VfYnVmX3N1Ym1pdChl
bnRyeSwgc2l6ZSwgcmN0eCwgY2FsbC0+ZXZlbnQudHlwZSwgMSwgcmVncywKIAkJCSAgICAgIGhl
YWQsIE5VTEwpOwogIG91dDoKIAlwcmVlbXB0X2VuYWJsZSgpOworCisjaWZkZWYgQ09ORklHX0JQ
Rl9FVkVOVFMKKwlpZiAodHJhY2VfZXZlbnRfbWF0Y2ggJiYgYnBmX3Byb2dfYXJyYXlfdmFsaWQo
Y2FsbCkpIHsKKwkJdTMyIHJldDsKKworCQlyZXQgPSBicGZfcHJvZ19ydW5fYXJyYXlfc2xlZXBh
YmxlKGNhbGwtPnByb2dfYXJyYXksIHJlZ3MsIGJwZl9wcm9nX3J1bik7CisJCWlmICghcmV0KQor
CQkJcmV0dXJuOworCX0KKyNlbmRpZiAvKiBDT05GSUdfQlBGX0VWRU5UUyAqLworCiB9CiAKIC8q
IHVwcm9iZSBwcm9maWxlIGhhbmRsZXIgKi8KLS0K
