Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDED7025E5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 09:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239636AbjEOHSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 03:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239560AbjEOHRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 03:17:53 -0400
X-Greylist: delayed 1072 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 May 2023 00:17:26 PDT
Received: from mta16.hihonor.com (mta16.hihonor.com [8.141.234.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CB010C1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 00:17:26 -0700 (PDT)
Received: from a007.hihonor.com (unknown [10.68.22.31])
        by mta16.hihonor.com (SkyGuard) with ESMTPS id 4QKVZy4VcZz28fXQ;
        Mon, 15 May 2023 14:58:50 +0800 (CST)
Received: from a007.hihonor.com (10.68.22.31) by a007.hihonor.com
 (10.68.22.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Mon, 15 May
 2023 14:59:31 +0800
Received: from a007.hihonor.com ([fe80::fc39:c25:3c0f:a4e7]) by
 a007.hihonor.com ([fe80::fc39:c25:3c0f:a4e7%10]) with mapi id 15.02.1118.021;
 Mon, 15 May 2023 14:59:31 +0800
From:   gaoxu <gaoxu2@hihonor.com>
To:     "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
CC:     "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "surenb@google.com" <surenb@google.com>,
        yipengxiang <yipengxiang@hihonor.com>,
        wangbintian 00013160 <bintian.wang@hihonor.com>
Subject: RE: [PATCH] dma-remap: Use kvmalloc_array/kvfree for larger dma
 memory remap
Thread-Topic: [PATCH] dma-remap: Use kvmalloc_array/kvfree for larger dma
 memory remap
Thread-Index: Adl/7N1/zhRx438JTrqVRawCg6p65QHDZoCA
Date:   Mon, 15 May 2023 06:59:31 +0000
Message-ID: <a37f80a55eeb4b2eb125e3340320032e@hihonor.com>
References: <18448ae569e24dfd84e811081ede376f@hihonor.com>
In-Reply-To: <18448ae569e24dfd84e811081ede376f@hihonor.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.164.11.140]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGxlYXNlIGhlbHAgdG8gcmV2aWV3LCB0aGFua3MuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBnYW94dSAwMDAxNjk3NyANClNlbnQ6IDIwMjPE6jXUwjbI1SAxNTozNA0KVG86
ICdoY2hAbHN0LmRlJyA8aGNoQGxzdC5kZT47ICdtLnN6eXByb3dza2lAc2Ftc3VuZy5jb20nIDxt
LnN6eXByb3dza2lAc2Ftc3VuZy5jb20+DQpDYzogJ3JvYmluLm11cnBoeUBhcm0uY29tJyA8cm9i
aW4ubXVycGh5QGFybS5jb20+OyAnaW9tbXVAbGlzdHMubGludXguZGV2JyA8aW9tbXVAbGlzdHMu
bGludXguZGV2PjsgJ2xpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcnIDxsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnPjsgJ3N1cmVuYkBnb29nbGUuY29tJyA8c3VyZW5iQGdvb2dsZS5jb20+
OyB5aXBlbmd4aWFuZyAwMDAxMzI2OCA8eWlwZW5neGlhbmdAaGlob25vci5jb20+OyB3YW5nYmlu
dGlhbiAwMDAxMzE2MCA8YmludGlhbi53YW5nQGhpaG9ub3IuY29tPjsgaGFuZmVuZyAwMDAxMjk4
NSA8ZmVuZy5oYW5AaGlob25vci5jb20+DQpTdWJqZWN0OiBbUEFUQ0hdIGRtYS1yZW1hcDogVXNl
IGt2bWFsbG9jX2FycmF5L2t2ZnJlZSBmb3IgbGFyZ2VyIGRtYSBtZW1vcnkgcmVtYXANCg0KSWYg
ZG1hX2RpcmVjdF9hbGxvYygpIGFsbG9jIG1lbW9yeSBpbiBzaXplIG9mIDY0TUIsIHRoZSBpbm5l
ciBmdW5jdGlvbg0KZG1hX2NvbW1vbl9jb250aWd1b3VzX3JlbWFwKCkgd2lsbCBhbGxvY2F0ZSAx
MjhLQiBtZW1vcnkgYnkgaW52b2tpbmcgdGhlIGZ1bmN0aW9uIGttYWxsb2NfYXJyYXkoKS4gYW5k
IHRoZSBrbWFsbG9jX2FycmF5IHNlZW1zIHRvIGZhaWwgdG8gdHJ5IHRvIGFsbG9jYXRlIDEyOEtC
IG1lbS4gd29yayBhcm91bmQgYnkgZG9pbmcga3ZtYWxsb2NfYXJyYXkgaW5zdGVhZC4NCg0KU2ln
bmVkLW9mZi1ieTogR2FvIFh1IDxnYW94dTJAaGlob25vci5jb20+DQotLS0NCiBrZXJuZWwvZG1h
L3JlbWFwLmMgfCA0ICsrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEva2VybmVsL2RtYS9yZW1hcC5jIGIva2VybmVsL2Rt
YS9yZW1hcC5jIGluZGV4IGI0NTI2NjY4MC4uMjc1OTZmM2I0IDEwMDY0NA0KLS0tIGEva2VybmVs
L2RtYS9yZW1hcC5jDQorKysgYi9rZXJuZWwvZG1hL3JlbWFwLmMNCkBAIC00MywxMyArNDMsMTMg
QEAgdm9pZCAqZG1hX2NvbW1vbl9jb250aWd1b3VzX3JlbWFwKHN0cnVjdCBwYWdlICpwYWdlLCBz
aXplX3Qgc2l6ZSwNCiAJdm9pZCAqdmFkZHI7DQogCWludCBpOw0KIA0KLQlwYWdlcyA9IGttYWxs
b2NfYXJyYXkoY291bnQsIHNpemVvZihzdHJ1Y3QgcGFnZSAqKSwgR0ZQX0tFUk5FTCk7DQorCXBh
Z2VzID0ga3ZtYWxsb2NfYXJyYXkoY291bnQsIHNpemVvZihzdHJ1Y3QgcGFnZSAqKSwgR0ZQX0tF
Uk5FTCk7DQogCWlmICghcGFnZXMpDQogCQlyZXR1cm4gTlVMTDsNCiAJZm9yIChpID0gMDsgaSA8
IGNvdW50OyBpKyspDQogCQlwYWdlc1tpXSA9IG50aF9wYWdlKHBhZ2UsIGkpOw0KIAl2YWRkciA9
IHZtYXAocGFnZXMsIGNvdW50LCBWTV9ETUFfQ09IRVJFTlQsIHByb3QpOw0KLQlrZnJlZShwYWdl
cyk7DQorCWt2ZnJlZShwYWdlcyk7DQogDQogCXJldHVybiB2YWRkcjsNCiB9DQotLQ0KMi4xNy4x
DQoNCg==
