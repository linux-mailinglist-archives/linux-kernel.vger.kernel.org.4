Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405866EDA21
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 04:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbjDYCHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 22:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbjDYCHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 22:07:34 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B7CE55AF;
        Mon, 24 Apr 2023 19:07:32 -0700 (PDT)
Received: from u201911681$hust.edu.cn ( [172.16.0.254] ) by
 ajax-webmail-app2 (Coremail) ; Tue, 25 Apr 2023 10:06:26 +0800 (GMT+08:00)
X-Originating-IP: [172.16.0.254]
Date:   Tue, 25 Apr 2023 10:06:26 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5ZGo5biI5b63?= <u201911681@hust.edu.cn>
To:     "abel vesa" <abelvesa@kernel.org>, "peng fan" <peng.fan@nxp.com>,
        "michael turquette" <mturquette@baylibre.com>,
        "stephen boyd" <sboyd@kernel.org>,
        "shawn guo" <shawnguo@kernel.org>,
        "sascha hauer" <s.hauer@pengutronix.de>,
        "pengutronix kernel team" <kernel@pengutronix.de>,
        "fabio estevam" <festevam@gmail.com>,
        "nxp linux team" <linux-imx@nxp.com>, "bai ping" <ping.bai@nxp.com>
Cc:     hust-os-kernel-patches@googlegroups.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx: clk-imx8mm: fix memory leak issue in
 'imx8mm_clocks_probe'
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220802(cbd923c5)
 Copyright (c) 2002-2023 www.mailtech.cn hust
In-Reply-To: <20230413032439.1706448-1-u201911681@hust.edu.cn>
References: <20230413032439.1706448-1-u201911681@hust.edu.cn>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2038e5bd.42407.187b62983e3.Coremail.u201911681@hust.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: GQEQrAAXaJWiNUdk9uLZAw--.56301W
X-CM-SenderInfo: zxsqimqrrwmio6kx23oohg3hdfq/1tbiAQsMAV7Em5P7UAACs8
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKPiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiWmhvdSBTaGlkZSIgPHUy
MDE5MTE2ODFAaHVzdC5lZHUuY24+Cj4g5Y+R6YCB5pe26Ze0OiAyMDIzLTA0LTEzIDExOjI0OjM5
ICjmmJ/mnJ/lm5spCj4g5pS25Lu25Lq6OiAiQWJlbCBWZXNhIiA8YWJlbHZlc2FAa2VybmVsLm9y
Zz4sICJQZW5nIEZhbiIgPHBlbmcuZmFuQG54cC5jb20+LCAiTWljaGFlbCBUdXJxdWV0dGUiIDxt
dHVycXVldHRlQGJheWxpYnJlLmNvbT4sICJTdGVwaGVuIEJveWQiIDxzYm95ZEBrZXJuZWwub3Jn
PiwgIlNoYXduIEd1byIgPHNoYXduZ3VvQGtlcm5lbC5vcmc+LCAiU2FzY2hhIEhhdWVyIiA8cy5o
YXVlckBwZW5ndXRyb25peC5kZT4sICJQZW5ndXRyb25peCBLZXJuZWwgVGVhbSIgPGtlcm5lbEBw
ZW5ndXRyb25peC5kZT4sICJGYWJpbyBFc3RldmFtIiA8ZmVzdGV2YW1AZ21haWwuY29tPiwgIk5Y
UCBMaW51eCBUZWFtIiA8bGludXgtaW14QG54cC5jb20+LCAiQmFpIFBpbmciIDxwaW5nLmJhaUBu
eHAuY29tPgo+IOaKhOmAgTogaHVzdC1vcy1rZXJuZWwtcGF0Y2hlc0Bnb29nbGVncm91cHMuY29t
LCAiWmhvdSBTaGlkZSIgPHUyMDE5MTE2ODFAaHVzdC5lZHUuY24+LCBsaW51eC1jbGtAdmdlci5r
ZXJuZWwub3JnLCBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcsIGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcKPiDkuLvpopg6IFtQQVRDSF0gY2xrOiBpbXg6IGNsay1pbXg4
bW06IGZpeCBtZW1vcnkgbGVhayBpc3N1ZSBpbiAnaW14OG1tX2Nsb2Nrc19wcm9iZScKPiAKPiBU
aGUgZnVuY3Rpb24gaW14OG1tX2Nsb2Nrc19wcm9iZSgpIGhhcyB0d28gbWFpbiBpc3N1ZXM6Cj4g
LSBUaGUgb2ZfaW9tYXAoKSBmdW5jdGlvbiBtYXkgY2F1c2UgYSBtZW1vcnkgbGVhay4KPiAtIE1l
bW9yeSBhbGxvY2F0ZWQgZm9yICdjbGtfaHdfZGF0YScgbWF5IG5vdCBiZSBmcmVlZCBwcm9wZXJs
eQo+IGluIHNvbWUgcGF0aHMuCj4gCj4gVG8gZml4IHRoZXNlIGlzc3VlcywgdGhpcyBjb21taXQg
cmVwbGFjZXMgdGhlIHVzZSBvZiBvZl9pb21hcCgpCj4gd2l0aCBkZXZtX29mX2lvbWFwKCkgYW5k
IHJlcGxhY2VzIGt6YWxsb2MoKSB3aXRoIGRldm1fa3phbGxvYygpLgo+IFRoaXMgZW5zdXJlcyB0
aGF0IGFsbCBtZW1vcnkgaXMgcHJvcGVybHkgbWFuYWdlZCBhbmQgYXV0b21hdGljYWxseQo+IGZy
ZWVkIHdoZW4gdGhlIGRldmljZSBpcyByZW1vdmVkLgo+IAo+IEluIGFkZGl0aW9uLCB3aGVuIGRl
dm1fb2ZfaW9tYXAoKSBhbGxvY2F0ZXMgbWVtb3J5IHdpdGggYW4gZXJyb3IsCj4gaXQgd2lsbCBm
aXJzdCBqdW1wIHRvIGxhYmVsICJ1bnJlZ2lzdGVyX2h3cyIgYW5kCj4gdGhlbiByZXR1cm4gUFRS
XyBFUlIoYmFzZSkuCj4gCj4gRml4ZXM6IDljNzFmOWVhMzVkNyAoImNsazogaW14OiBpbXg4bW06
IFN3aXRjaCB0byBjbGtfaHcgYmFzZWQgQVBJIikKPiBGaXhlczogYmE1NjI1YzNlMjcyICgiY2xr
OiBpbXg6IEFkZCBjbG9jayBkcml2ZXIgc3VwcG9ydCBmb3IgaW14OG1tIikKPiBTaWduZWQtb2Zm
LWJ5OiBaaG91IFNoaWRlIDx1MjAxOTExNjgxQGh1c3QuZWR1LmNuPgo+IC0tLQo+IFRoZSBpc3N1
ZSBpcyBkaXNjb3ZlcmVkIGJ5IHN0YXRpYyBhbmFseXNpcywgYW5kIHRoZSBwYXRjaCBpcyBub3Qg
dGVzdGVkIHlldC4KPiAKPiAgZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bW0uYyB8IDE2ICsrKysr
KysrKystLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDYgZGVsZXRp
b25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2lteC9jbGstaW14OG1tLmMgYi9k
cml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtbS5jCj4gaW5kZXggYjYxODg5MjE3MGYyLi5lNmUwYmI0
ODA1YTYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bW0uYwo+ICsrKyBi
L2RyaXZlcnMvY2xrL2lteC9jbGstaW14OG1tLmMKPiBAQCAtMzAzLDcgKzMwMyw3IEBAIHN0YXRp
YyBpbnQgaW14OG1tX2Nsb2Nrc19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+
ICAJdm9pZCBfX2lvbWVtICpiYXNlOwo+ICAJaW50IHJldDsKPiAgCj4gLQljbGtfaHdfZGF0YSA9
IGt6YWxsb2Moc3RydWN0X3NpemUoY2xrX2h3X2RhdGEsIGh3cywKPiArCWNsa19od19kYXRhID0g
ZGV2bV9remFsbG9jKGRldiwgc3RydWN0X3NpemUoY2xrX2h3X2RhdGEsIGh3cywKPiAgCQkJCQkg
IElNWDhNTV9DTEtfRU5EKSwgR0ZQX0tFUk5FTCk7Cj4gIAlpZiAoV0FSTl9PTighY2xrX2h3X2Rh
dGEpKQo+ICAJCXJldHVybiAtRU5PTUVNOwo+IEBAIC0zMjAsMTAgKzMyMCwxMiBAQCBzdGF0aWMg
aW50IGlteDhtbV9jbG9ja3NfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiAg
CWh3c1tJTVg4TU1fQ0xLX0VYVDRdID0gaW14X2dldF9jbGtfaHdfYnlfbmFtZShucCwgImNsa19l
eHQ0Iik7Cj4gIAo+ICAJbnAgPSBvZl9maW5kX2NvbXBhdGlibGVfbm9kZShOVUxMLCBOVUxMLCAi
ZnNsLGlteDhtbS1hbmF0b3AiKTsKPiAtCWJhc2UgPSBvZl9pb21hcChucCwgMCk7Cj4gKwliYXNl
ID0gZGV2bV9vZl9pb21hcChkZXYsIG5wLCAwLCBOVUxMKTsKPiAgCW9mX25vZGVfcHV0KG5wKTsK
PiAtCWlmIChXQVJOX09OKCFiYXNlKSkKPiAtCQlyZXR1cm4gLUVOT01FTTsKPiArCWlmIChXQVJO
X09OKElTX0VSUihiYXNlKSkpIHsKPiArCQlyZXQgPSBQVFJfRVJSKGJhc2UpOwo+ICsJCWdvdG8g
dW5yZWdpc3Rlcl9od3M7Cj4gKwl9Cj4gIAo+ICAJaHdzW0lNWDhNTV9BVURJT19QTEwxX1JFRl9T
RUxdID0gaW14X2Nsa19od19tdXgoImF1ZGlvX3BsbDFfcmVmX3NlbCIsIGJhc2UgKyAweDAsIDAs
IDIsIHBsbF9yZWZfc2VscywgQVJSQVlfU0laRShwbGxfcmVmX3NlbHMpKTsKPiAgCWh3c1tJTVg4
TU1fQVVESU9fUExMMl9SRUZfU0VMXSA9IGlteF9jbGtfaHdfbXV4KCJhdWRpb19wbGwyX3JlZl9z
ZWwiLCBiYXNlICsgMHgxNCwgMCwgMiwgcGxsX3JlZl9zZWxzLCBBUlJBWV9TSVpFKHBsbF9yZWZf
c2VscykpOwo+IEBAIC0zOTksOCArNDAxLDEwIEBAIHN0YXRpYyBpbnQgaW14OG1tX2Nsb2Nrc19w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+ICAKPiAgCW5wID0gZGV2LT5vZl9u
b2RlOwo+ICAJYmFzZSA9IGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwKTsK
PiAtCWlmIChXQVJOX09OKElTX0VSUihiYXNlKSkpCj4gLQkJcmV0dXJuIFBUUl9FUlIoYmFzZSk7
Cj4gKwlpZiAoV0FSTl9PTihJU19FUlIoYmFzZSkpKSB7Cj4gKwkJcmV0ID0gUFRSX0VSUihiYXNl
KTsKPiArCQlnb3RvIHVucmVnaXN0ZXJfaHdzOwo+ICsJfQo+ICAKPiAgCS8qIENvcmUgU2xpY2Ug
Ki8KPiAgCWh3c1tJTVg4TU1fQ0xLX0E1M19ESVZdID0gaW14OG1fY2xrX2h3X2NvbXBvc2l0ZV9j
b3JlKCJhcm1fYTUzX2RpdiIsIGlteDhtbV9hNTNfc2VscywgYmFzZSArIDB4ODAwMCk7Cj4gLS0g
Cj4gMi4zNC4xCnBpbmfvvJ8=
