Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF30E706E84
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjEQQsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjEQQsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:48:09 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3249C59F6;
        Wed, 17 May 2023 09:48:05 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 33EFA5FD47;
        Wed, 17 May 2023 19:48:02 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1684342082;
        bh=lL5Ig/feq+5ZBoLLfuFLUuIyi3rpN3rrbk58Ou2ypQs=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=iB6dWI9mC38wGNkQQa0OMrr5hZpGh1A+syBAKrO1wrf+Vn54KpXRu0AavGGmGSz0P
         WueifkgZqcuB3Zl77MlMjnNNL8I7IBomzX/vN4WDlsbiKtkC/JqR2HZMwA+pjpasn1
         aYv6G0rs3r5tSX/XeGhSuQcDymgoGK3lzaWOzLzkuPm5aMc272stWuUwYK+nJ9wVvC
         OXLN2Tcuxppu0kZvOKF7PjA4eoiFeGPO2lNOes7FzEF52f+yvSPOtrhytApeqm6BJt
         aJslkSaVdJsaNtFg+ym0Xh52/ryczT0m7snAmEfzjRAS+VB/W9PSl6e9rSXqrhFA/U
         H2pK2RAkZu/ng==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 17 May 2023 19:48:00 +0300 (MSK)
From:   =?utf-8?B?0KHRgtCw0YDQuiDQk9C10L7RgNCz0LjQuSDQndC40LrQvtC70LDQtdCy0Lg=?=
         =?utf-8?B?0Yc=?= <GNStark@sberdevices.ru>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "nuno.sa@analog.com" <nuno.sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [PATCH v1] meson saradc: fix clock divider mask length
Thread-Topic: [PATCH v1] meson saradc: fix clock divider mask length
Thread-Index: AQHZh3EQTxw9IHKo50q7J9Xz6LtR8q9dEmgAgAFp8QA=
Date:   Wed, 17 May 2023 16:47:59 +0000
Message-ID: <f0966e95-43c7-e6f6-8aeb-05f27691cec3@sberdevices.ru>
References: <20230515210545.2100161-1-gnstark@sberdevices.ru>
 <CAFBinCCc+t7Ks6fqz38cVrufPRFdxFgC9Qp+JhcM1KfD6pupTg@mail.gmail.com>
In-Reply-To: <CAFBinCCc+t7Ks6fqz38cVrufPRFdxFgC9Qp+JhcM1KfD6pupTg@mail.gmail.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.13]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D8EA23852B1CE4E84E905633DABAB39@sberdevices.ru>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/17 11:04:00 #21328336
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8xNi8yMyAyMjowOCwgTWFydGluIEJsdW1lbnN0aW5nbCB3cm90ZToNCj4gSGkgR2Vvcmdl
LA0KPg0KPiB0aGFuayB5b3UgZm9yIHRoaXMgcGF0Y2ghDQo+DQo+IE9uIE1vbiwgTWF5IDE1LCAy
MDIzIGF0IDExOjA24oCvUE0gR2VvcmdlIFN0YXJrIDxnbnN0YXJrQHNiZXJkZXZpY2VzLnJ1PiB3
cm90ZToNCj4+IEZyb206IEdlb3JnZSBTdGFyayA8R05TdGFya0BzYmVyZGV2aWNlcy5ydT4NCj4+
DQo+PiBBY2NvcmRpbmcgdG8gZGF0YXNoZWV0cyBvZiBzdXBwb3J0ZWQgbWVzb24gU09Dcw0KPj4g
bGVuZ3RoIG9mIEFEQ19DTEtfRElWIGZpZWxkIGlzIDYgYml0cyBsb25nDQo+IEkgaGF2ZSBhIHF1
ZXN0aW9uIGFib3V0IHRoaXMgc2VudGVuY2Ugd2hpY2ggZG9lc24ndCBhZmZlY3QgdGhpcyBwYXRj
aA0KPiAtIGl0J3Mgb25seSBhYm91dCBtYW5hZ2luZyBleHBlY3RhdGlvbnM6DQo+IFdoaWNoIFNv
QyBhcmUgeW91IHJlZmVycmluZyB0bz8NCj4gVGhpcyBkaXZpZGVyIGlzIG9ubHkgcmVsZXZhbnQg
b24gb2xkZXIgU29DcyB0aGF0IHByZWRhdGUgR1hCQiAoUzkwNSkuDQo+IFRvIG15IGtub3dsZWRn
ZSBhbGwgU29DcyBmcm9tIEdYQkIgb253YXJkcyBwbGFjZSB0aGUgZGl2aWRlciBpbiB0aGUNCj4g
bWFpbiBvciBBTyBjbG9jayBjb250cm9sbGVyLCBzbyB0aGlzIGJpdG1hc2sgaXMgaXJyZWxldmFu
dCB0aGVyZS4NCg0KSGVsbG8gTWFydGluDQoNCkkndmUgY2hlY2tlZCBkYXRhc2hlZXRzIG9mIGFs
bCBjaGlwcyBsaXN0ZWQgaW4gbWVzb25fc2FyX2FkY19vZl9tYXRjaCBhcnJheSBpbiBtZXNvbl9z
YXJhZGMuYyBhbmQgZXZlcnl3aGVyZSB0aGlzIGZpZWxkIGlzIDYgYml0cyBsb25nLiBBY2NvcmRp
bmcgdG8gZHJpdmVyIGNvZGUgYW5kIGV4aXN0aW5nIGR0cyBmaWxlcyB0aGlzIHBhdGNoIGFmZmVj
dHMgYWxsIHN1cHBvcnRlZCBjaGlwcyBleGNlcHQgbWVzb244Lg0KDQpCZXN0IHJlZ2FyZHMNCkdl
b3JnZQ0KDQoNCj4+IEZpeGVzOiAzYWRiZjM0MjczMzAgKCJpaW86IGFkYzogYWRkIGEgZHJpdmVy
IGZvciB0aGUgU0FSIEFEQyBmb3VuZCBpbiBBbWxvZ2ljIE1lc29uIFNvQ3MiKQ0KPj4gU2lnbmVk
LW9mZi1ieTogR2VvcmdlIFN0YXJrIDxHTlN0YXJrQHNiZXJkZXZpY2VzLnJ1Pg0KPiBTaW5jZSBt
eSBxdWVzdGlvbiBhYm92ZSBkb2Vzbid0IGFmZmVjdCB0aGlzIHBhdGNoOg0KPiBSZXZpZXdlZC1i
eTogTWFydGluIEJsdW1lbnN0aW5nbCA8bWFydGluLmJsdW1lbnN0aW5nbEBnb29nbGVtYWlsLmNv
bT4NCj4NCg0K
