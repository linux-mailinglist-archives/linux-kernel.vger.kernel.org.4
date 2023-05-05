Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D729F6F7F60
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 10:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjEEIu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 04:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjEEIu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 04:50:57 -0400
X-Greylist: delayed 394 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 05 May 2023 01:50:55 PDT
Received: from cstnet.cn (smtp37.cstnet.cn [159.226.251.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFB9418929
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 01:50:55 -0700 (PDT)
Received: from zhangfei$nj.iscas.ac.cn ( [104.249.174.122] ) by
 ajax-webmail-APP-12 (Coremail) ; Fri, 5 May 2023 16:43:44 +0800 (GMT+08:00)
X-Originating-IP: [104.249.174.122]
Date:   Fri, 5 May 2023 16:43:44 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5byg6aOe?= <zhangfei@nj.iscas.ac.cn>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: Optimize memset
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.15 build 20230321(1bf45b10)
 Copyright (c) 2002-2023 www.mailtech.cn cnic.cn
Content-Type: multipart/mixed; 
        boundary="----=_Part_843841_1477095471.1683276224911"
MIME-Version: 1.0
Message-ID: <6d1cbe2e.3c31d.187eb14d990.Coremail.zhangfei@nj.iscas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: tgCowADXAEXBwVRkyZkZAA--.17989W
X-CM-SenderInfo: x2kd0whihlq03mol2u1dvotugofq/1tbiBwICEWRUtj8l+QAAsz
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW5Jw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_843841_1477095471.1683276224911
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

Cg==
------=_Part_843841_1477095471.1683276224911
Content-Type: application/octet-stream; 
	name=0001-riscv-Optimize-memset.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-riscv-Optimize-memset.patch"

RnJvbSBiY2ExODlmYmZhY2YxYjAxOTc1YWY0NWU0OTA5NmE1NzE4ODg3YTQyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiB6aGFuZ2ZlaSA8emhhbmdmZWlAbmouaXNjYXMuYWMuY24+CkRh
dGU6IEZyaSwgNSBNYXkgMjAyMyAxNDo1ODozNSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIHJpc2N2
OiBPcHRpbWl6ZSBtZW1zZXQKClRoaXMgcGF0Y2ggaGFzIGJlZW4gb3B0aW1pemVkIGZvciBtZW1z
ZXQgZGF0YSBzaXplcyBsZXNzIHRoYW4gMTYgYnl0ZXMuCkNvbXBhcmVkIHRvIGJ5dGUgYnkgYnl0
ZSBzdG9yYWdlLCBzaWduaWZpY2FudCBwZXJmb3JtYW5jZSBpbXByb3ZlbWVudCBoYXMgYmVlbiBh
Y2hpZXZlZC4KClNpZ25lZC1vZmYtYnk6IEZlaSBaaGFuZyA8emhhbmdmZWlAbmouaXNjYXMuYWMu
Y24+Ci0tLQogYXJjaC9yaXNjdi9saWIvbWVtc2V0LlMgfCAzMyArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvbGliL21lbXNldC5TIGIvYXJjaC9yaXNj
di9saWIvbWVtc2V0LlMKaW5kZXggMzRjNTM2MGM2NzA1Li4wOTY3YmRmODZiZDYgMTAwNjQ0Ci0t
LSBhL2FyY2gvcmlzY3YvbGliL21lbXNldC5TCisrKyBiL2FyY2gvcmlzY3YvbGliL21lbXNldC5T
CkBAIC0xMDUsOSArMTA1LDM2IEBAIFdFQUsobWVtc2V0KQogCWJlcXogYTIsIDZmCiAJYWRkIGEz
LCB0MCwgYTIKIDU6Ci0Jc2IgYTEsIDAodDApCi0JYWRkaSB0MCwgdDAsIDEKLQlibHR1IHQwLCBh
MywgNWIKKyAgICAgICAgc2IgYTEsIDAodDApCisgICAgICAgIHNiIGExLCAtMShhMykKKyAgICAg
ICAgbGkgYTQsIDIKKyAgICAgICAgYmdldSBhNCwgYTIsIDZmCisKKyAgICAgICAgc2IgYTEsIDEo
dDApCisgICAgICAgIHNiIGExLCAyKHQwKQorICAgICAgICBzYiBhMSwgLTIoYTMpCisgICAgICAg
IHNiIGExLCAtMyhhMykKKyAgICAgICAgbGkgYTQsIDYKKyAgICAgICAgYmdldSBhNCwgYTIsIDZm
CisKKyAgICAgICAgc2IgYTEsIDModDApCisgICAgICAgIHNiIGExLCAtNChhMykKKyAgICAgICAg
bGkgYTQsIDgKKyAgICAgICAgYmdldSBhNCwgYTIsIDZmCisKKyAgICAgICAgc2IgYTEsIDQodDAp
CisgICAgICAgIHNiIGExLCAtNShhMykKKyAgICAgICAgbGkgYTQsIDEwCisgICAgICAgIGJnZXUg
YTQsIGEyLCA2ZgorCisgICAgICAgIHNiIGExLCA1KHQwKQorICAgICAgICBzYiBhMSwgNih0MCkK
KyAgICAgICAgc2IgYTEsIC02KGEzKQorICAgICAgICBzYiBhMSwgLTcoYTMpCisgICAgICAgIGxp
IGE0LCAxNAorICAgICAgICBiZ2V1IGE0LCBhMiwgNmYKKworICAgICAgICBzYiBhMSwgNyh0MCkK
IDY6CiAJcmV0CiBFTkQoX19tZW1zZXQpCi0tIAoyLjMzLjAKCg==
------=_Part_843841_1477095471.1683276224911--

