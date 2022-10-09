Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220B35F88BA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 03:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJIBkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 21:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJIBkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 21:40:09 -0400
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E1A18B24
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 18:40:05 -0700 (PDT)
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: 4PzXER4Bulfq0lrlokHYkaAlRismpaZmHnrwZevtPiH5Y/EuzG1Vt8Qj4JFdL
        rEThIe+lIKwCNHugkmY5/5rgjA6aXUD8dS0rYDWbbLU+/J2Qgay0Gb3xtomLEtxnbPKTkrm
        T5P2WP73rQgiM6pvmqiGwzyCm6mXQNNvB4Wr30FYtkhKPzDJkqhSAx60wlMWKtr4UMqqJ/v
        2PTiggSdngesYVWPYFmRy4nf5FqTpW+XXZUgvfLcY8TW4lQYVAuIpw52kO8Fu4VT7UrpAqR
        V2KBzzjwm7PQyC28EO56tTX4fYhr8hU7gMEFp03Dt7AIXD9TxrGZygOyvfKBrGySvadfVbd
        BdQlC3MFFIhT7++N3GR3Qs3aYp8+Kiw3VUW4AEgijBF2kTLNLg=
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 113.57.13.187
X-QQ-STYLE: 
X-QQ-mid: logic637t1665279096t2157815
From:   "=?utf-8?B?WmhhbmcgWGluY2hlbmc=?=" <zhangxincheng@uniontech.com>
To:     "=?utf-8?B?bWF6?=" <maz@kernel.org>
Cc:     "=?utf-8?B?dGdseA==?=" <tglx@linutronix.de>,
        "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>,
        "=?utf-8?B?b2xla3NhbmRy?=" <oleksandr@natalenko.name>,
        "=?utf-8?B?SGFucyBkZSBHb2VkZQ==?=" <hdegoede@redhat.com>,
        "=?utf-8?B?YmlnZWFzeQ==?=" <bigeasy@linutronix.de>,
        "=?utf-8?B?bWFyay5ydXRsYW5k?=" <mark.rutland@arm.com>,
        "=?utf-8?B?bWljaGFlbA==?=" <michael@walle.cc>
Subject: Re: [PATCH] interrupt: discover and disable very frequent interrupts
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Sun, 9 Oct 2022 09:31:36 +0800
X-Priority: 3
Message-ID: <tencent_48EE20EE67D50AC81A28CAAF@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20220930064042.14564-1-zhangxincheng@uniontech.com>
        <86bkqx6wrd.wl-maz@kernel.org>
        <tencent_7C4E401B708789BC3A26F57C@qq.com>
        <868rm16tbu.wl-maz@kernel.org>
In-Reply-To: <868rm16tbu.wl-maz@kernel.org>
X-QQ-ReplyHash: 682764619
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Sun, 09 Oct 2022 09:31:37 +0800 (CST)
Feedback-ID: logic:uniontech.com:qybglogicsvr:qybglogicsvr5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
        MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBBZ2Fpbjogd2hhdCBtYWtlcyB5b3UgdGhpbmsgdGhhdCBpdCBpcyBiZXR0ZXIgdG8ga2ls
bCB0aGUgaW50ZXJydXB0DQo+IHRoYW4gc3VmZmVyaW5nIGEgUkNVIHN0YWxsPyBZZXMsIHRo
YXQncyBhIGxvdCBvZiBpbnRlcnJ1cHRzLiBCdXQNCj4ga2lsbGluZyBpdCBhbmQgcmlza2lu
ZyB0aGUgd2hvbGUgc3lzdGVtIGlzbid0IGFuIGFjY2VwdGFibGUgb3V0Y29tZS4NCg0KSXQn
cyByZWFsbHkgbm90IGdvb2QgdG8ga2lsbCBpbnRlcnJ1cHRzIGRpcmVjdGx5LiBQZXJoYXBz
IGEgYmV0dGVyIHdheSBpcw0KdG8gcmVwb3J0IGl0IGFuZCBsZXQgdGhlIHN5c3RlbSBhZG1p
bmlzdHJhdG9yIGRlY2lkZSB3aGF0IHRvIGRvIHdpdGggaXQuDQoNCisgaWYoKGRlc2MtPmdh
cF9jb3VudCAmIDB4ZmZmZjAwMDApID09IDApDQorIGRlc2MtPmdhcF90aW1lID0gZ2V0X2pp
ZmZpZXNfNjQoKTsNCisNCisgZGVzYy0+Z2FwX2NvdW50ICsrOw0KKw0KKyBpZigoZGVzYy0+
Z2FwX2NvdW50ICYgMHgwMDAwZmZmZikgPj0gMjAwMCkgew0KKyBpZigoZ2V0X2ppZmZpZXNf
NjQoKSAtIGRlc2MtPmdhcF90aW1lKSA8IEhaKSB7DQorIGRlc2MtPmdhcF9jb3VudCArPSAw
eDAwMDEwMDAwOw0KKyBkZXNjLT5nYXBfY291bnQgJj0gMHhmZmZmMDAwMDsNCisgfSBlbHNl
IHsNCisgZGVzYy0+Z2FwX2NvdW50ID0gMDsNCisgfQ0KKw0KKyBpZigoZGVzYy0+Z2FwX2Nv
dW50ID4+IDE2KSA+IDMwKSB7DQorIF9fcmVwb3J0X2JhZF9pcnEoZGVzYywgYWN0aW9uX3Jl
dCwgS0VSTl9FUlIgImlycSAlZDogdHJpZ2dlcmVkIHRvbyBmcmVxdWVudGx5XG4iKTsNCisg
fQ0KKyB9DQorDQoNCg0KVGhhbmtzLA0KDQogICAgICAgICAgICAgWmhhbmcgWGluY2hlbmc=

