Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339516E19F2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 04:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjDNCCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 22:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDNCCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 22:02:45 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45A933C15;
        Thu, 13 Apr 2023 19:02:44 -0700 (PDT)
Received: from u201911681$hust.edu.cn ( [10.12.190.96] ) by
 ajax-webmail-app1 (Coremail) ; Fri, 14 Apr 2023 10:02:19 +0800 (GMT+08:00)
X-Originating-IP: [10.12.190.96]
Date:   Fri, 14 Apr 2023 10:02:19 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5ZGo5biI5b63?= <u201911681@hust.edu.cn>
To:     "stephen boyd" <sboyd@kernel.org>
Cc:     "abel vesa" <abelvesa@kernel.org>, "bai ping" <ping.bai@nxp.com>,
        "fabio estevam" <festevam@gmail.com>,
        "michael turquette" <mturquette@baylibre.com>,
        "nxp linux team" <linux-imx@nxp.com>,
        "peng fan" <peng.fan@nxp.com>,
        "pengutronix kernel team" <kernel@pengutronix.de>,
        "sascha hauer" <s.hauer@pengutronix.de>,
        "shawn guo" <shawnguo@kernel.org>,
        hust-os-kernel-patches@googlegroups.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "hao luo" <m202171776@hust.edu.cn>
Subject: Re: Re: [PATCH] clk: imx: clk-imx8mm: fix memory leak issue in
 'imx8mm_clocks_probe'
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220802(cbd923c5)
 Copyright (c) 2002-2023 www.mailtech.cn hust
In-Reply-To: <25b06794ffb595229019640e10f256fd.sboyd@kernel.org>
References: <20230413032439.1706448-1-u201911681@hust.edu.cn>
 <25b06794ffb595229019640e10f256fd.sboyd@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <5e18370b.3c8a8.1877d7fc98a.Coremail.u201911681@hust.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: FgEQrAAHVwgrtDhk3X2oAg--.38998W
X-CM-SenderInfo: zxsqimqrrwmio6kx23oohg3hdfq/1tbiAQkBAV7Em5BU+wABs3
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiU3RlcGhlbiBCb3lkIiA8
c2JveWRAa2VybmVsLm9yZz4KPiDlj5HpgIHml7bpl7Q6IDIwMjMtMDQtMTQgMDM6MDY6NTkgKOaY
n+acn+S6lCkKPiDmlLbku7bkuro6ICJBYmVsIFZlc2EiIDxhYmVsdmVzYUBrZXJuZWwub3JnPiwg
IkJhaSBQaW5nIiA8cGluZy5iYWlAbnhwLmNvbT4sICJGYWJpbyBFc3RldmFtIiA8ZmVzdGV2YW1A
Z21haWwuY29tPiwgIk1pY2hhZWwgVHVycXVldHRlIiA8bXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb20+
LCAiTlhQIExpbnV4IFRlYW0iIDxsaW51eC1pbXhAbnhwLmNvbT4sICJQZW5nIEZhbiIgPHBlbmcu
ZmFuQG54cC5jb20+LCAiUGVuZ3V0cm9uaXggS2VybmVsIFRlYW0iIDxrZXJuZWxAcGVuZ3V0cm9u
aXguZGU+LCAiU2FzY2hhIEhhdWVyIiA8cy5oYXVlckBwZW5ndXRyb25peC5kZT4sICJTaGF3biBH
dW8iIDxzaGF3bmd1b0BrZXJuZWwub3JnPiwgIlpob3UgU2hpZGUiIDx1MjAxOTExNjgxQGh1c3Qu
ZWR1LmNuPgo+IOaKhOmAgTogaHVzdC1vcy1rZXJuZWwtcGF0Y2hlc0Bnb29nbGVncm91cHMuY29t
LCAiWmhvdSBTaGlkZSIgPHUyMDE5MTE2ODFAaHVzdC5lZHUuY24+LCBsaW51eC1jbGtAdmdlci5r
ZXJuZWwub3JnLCBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcsIGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcsICJIYW8gTHVvIiA8bTIwMjE3MTc3NkBodXN0LmVkdS5jbj4K
PiDkuLvpopg6IFJlOiBbUEFUQ0hdIGNsazogaW14OiBjbGstaW14OG1tOiBmaXggbWVtb3J5IGxl
YWsgaXNzdWUgaW4gJ2lteDhtbV9jbG9ja3NfcHJvYmUnCj4gCj4gUXVvdGluZyBaaG91IFNoaWRl
ICgyMDIzLTA0LTEyIDIwOjI0OjM5KQo+ID4gVGhlIGZ1bmN0aW9uIGlteDhtbV9jbG9ja3NfcHJv
YmUoKSBoYXMgdHdvIG1haW4gaXNzdWVzOgo+ID4gLSBUaGUgb2ZfaW9tYXAoKSBmdW5jdGlvbiBt
YXkgY2F1c2UgYSBtZW1vcnkgbGVhay4KPiA+IC0gTWVtb3J5IGFsbG9jYXRlZCBmb3IgJ2Nsa19o
d19kYXRhJyBtYXkgbm90IGJlIGZyZWVkIHByb3Blcmx5Cj4gPiBpbiBzb21lIHBhdGhzLgo+ID4g
Cj4gPiBUbyBmaXggdGhlc2UgaXNzdWVzLCB0aGlzIGNvbW1pdCByZXBsYWNlcyB0aGUgdXNlIG9m
IG9mX2lvbWFwKCkKPiA+IHdpdGggZGV2bV9vZl9pb21hcCgpIGFuZCByZXBsYWNlcyBremFsbG9j
KCkgd2l0aCBkZXZtX2t6YWxsb2MoKS4KPiA+IFRoaXMgZW5zdXJlcyB0aGF0IGFsbCBtZW1vcnkg
aXMgcHJvcGVybHkgbWFuYWdlZCBhbmQgYXV0b21hdGljYWxseQo+ID4gZnJlZWQgd2hlbiB0aGUg
ZGV2aWNlIGlzIHJlbW92ZWQuCj4gPiAKPiA+IEluIGFkZGl0aW9uLCB3aGVuIGRldm1fb2ZfaW9t
YXAoKSBhbGxvY2F0ZXMgbWVtb3J5IHdpdGggYW4gZXJyb3IsCj4gPiBpdCB3aWxsIGZpcnN0IGp1
bXAgdG8gbGFiZWwgInVucmVnaXN0ZXJfaHdzIiBhbmQKPiA+IHRoZW4gcmV0dXJuIFBUUl8gRVJS
KGJhc2UpLgo+ID4gCj4gPiBGaXhlczogOWM3MWY5ZWEzNWQ3ICgiY2xrOiBpbXg6IGlteDhtbTog
U3dpdGNoIHRvIGNsa19odyBiYXNlZCBBUEkiKQo+ID4gRml4ZXM6IGJhNTYyNWMzZTI3MiAoImNs
azogaW14OiBBZGQgY2xvY2sgZHJpdmVyIHN1cHBvcnQgZm9yIGlteDhtbSIpCj4gPiBTaWduZWQt
b2ZmLWJ5OiBaaG91IFNoaWRlIDx1MjAxOTExNjgxQGh1c3QuZWR1LmNuPgo+ID4gLS0tCj4gPiBU
aGUgaXNzdWUgaXMgZGlzY292ZXJlZCBieSBzdGF0aWMgYW5hbHlzaXMsIGFuZCB0aGUgcGF0Y2gg
aXMgbm90IHRlc3RlZCB5ZXQuCj4gCj4gQW5kIHlvdSdyZSBub3QgY29vcmRpbmF0aW5nIHdpdGgg
ZWFjaCBvdGhlcj8KV2hhdCBkbyB5b3UgbWVhbiBieSAiY29vcmRpbmF0aW5nIHdpdGggZWFjaCBv
dGhlciI/CgpyZWdhcmRzLApaaG91IFNoaWRl
