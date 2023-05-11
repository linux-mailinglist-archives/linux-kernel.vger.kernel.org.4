Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5288A6FF4ED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238542AbjEKOti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238521AbjEKOtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:49:12 -0400
X-Greylist: delayed 465 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 11 May 2023 07:47:17 PDT
Received: from mx2.securetransport.de (mx2.securetransport.de [IPv6:2a03:4000:13:6c7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6462F12486;
        Thu, 11 May 2023 07:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1683815927;
        bh=1yj/IKE5GtQ/NghhKpBm3Au13woVZKptiZvn9g7W1fo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=w4brse4wW0VyosRPYpG2i80bkVRTDUDBOalUGVh4L0iKQejrc6JHt3EMJXKvsOOsI
         0O1YGwuiCSMQiOiyTETMUZn6xdTjCg0qhBEdayakFfvQGpo4b1QcqKLDvm3lRiPCbe
         jRsXeR73NVwJhIBPCRSfYmVa8ijmavex3MUGgCupwM/qjg9W4nQBA7ttdrvR5/KgHg
         PEZBokwn4im7n+as/F3rEvbT9aFCKl+w7AW4ZXUjFEheIWoOJcKKFqsNVQvoMuuXqc
         s5nMzpDVcGkhGa81Ravr0tzs+T5vPhg2YuP/sa3AamV/tP4JFJ4QGtJrxisHbhvynZ
         BJOKwOS4ULL0Q==
X-secureTransport-forwarded: yes
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>,
        Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cpufreq: imx6q: Disable only available frequencies
Thread-Topic: [PATCH] cpufreq: imx6q: Disable only available frequencies
Thread-Index: AQHZg+p2AXZhE0CYb0WkO6LusMFecq9Us6OAgABksVA=
Date:   Thu, 11 May 2023 14:38:42 +0000
Message-ID: <a7bfc85a9b664daf84e90adf520c0a56@dh-electronics.com>
References: <20230511092334.3017-1-cniedermaier@dh-electronics.com>
 <20230511095355.5t7ldsyg5eglrrtv@vireshk-i7>
In-Reply-To: <20230511095355.5t7ldsyg5eglrrtv@vireshk-i7>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogVmlyZXNoIEt1bWFyIFttYWlsdG86dmlyZXNoLmt1bWFyQGxpbmFyby5vcmddDQpTZW50
OiBUaHVyc2RheSwgTWF5IDExLCAyMDIzIDExOjU0IEFNDQo+IE9uIDExLTA1LTIzLCAxMToyMywg
Q2hyaXN0b3BoIE5pZWRlcm1haWVyIHdyb3RlOg0KPj4gQEAgLTI1NCwxNiArMjY5LDE2IEBAIHN0
YXRpYyBpbnQgaW14NnFfb3BwX2NoZWNrX3NwZWVkX2dyYWRpbmcoc3RydWN0IGRldmljZSAqZGV2
KQ0KPj4gICAgICAgdmFsICY9IDB4MzsNCj4+DQo+PiAgICAgICBpZiAodmFsIDwgT0NPVFBfQ0ZH
M19TUEVFRF85OTZNSFopDQo+PiAtICAgICAgICAgICAgIGlmIChkZXZfcG1fb3BwX2Rpc2FibGUo
ZGV2LCA5OTYwMDAwMDApKQ0KPj4gKyAgICAgICAgICAgICBpZiAoZGlzYWJsZV9mcmVxX2lmX2F2
YWlsYWJsZShkZXYsIDk5NjAwMDAwMCkpDQo+PiAgICAgICAgICAgICAgICAgICAgICAgZGV2X3dh
cm4oZGV2LCAiZmFpbGVkIHRvIGRpc2FibGUgOTk2TUh6IE9QUFxuIik7DQo+IA0KPiBBaGgsIHRo
ZXNlIHdhcm5pbmdzLg0KPiANCj4gV2hhdCBhYm91dCBwcmludGluZyB0aGUgd2FybmluZyBvbmx5
IHdoZW4gcmV0dXJuZWQgZXJyb3IgIT0gLUVOT0RFViA/DQo+IE9yIGp1c3QgbWFya2luZyB0aGVt
IGRldl9kYmcoKSA/DQoNCkkgaGF2ZSBrZXB0IHRvIHRoZSBkb2N1bWVudGF0aW9uIG9mIG9wcCwg
YnV0IGlmIC1FTk9ERVYgaXMgcG9zc2libGUNCkkgcHJlZmVyIGl0LiBNeSBzdWdnZXN0aW9uIGlz
IHRvIGNoYW5nZSBlYWNoICJkZXZfcG1fb3BwX2Rpc2FibGUiIGluDQp0aGlzIHdheToNCg0KLQlp
ZiAodmFsIDwgT0NPVFBfQ0ZHM19TUEVFRF85OTZNSFopDQotCQlpZiAoZGV2X3BtX29wcF9kaXNh
YmxlKGRldiwgOTk2MDAwMDAwKSkNCisJaWYgKHZhbCA8IE9DT1RQX0NGRzNfU1BFRURfOTk2TUha
KSB7DQorCQlyZXRfb3BwID0gZGV2X3BtX29wcF9kaXNhYmxlKGRldiwgOTk2MDAwMDAwKTsNCisJ
CWlmIChyZXRfb3BwIDwgMCAmJiByZXRfb3BwICE9IC1FTk9ERVYpDQogCQkJZGV2X3dhcm4oZGV2
LCAiZmFpbGVkIHRvIGRpc2FibGUgOTk2TUh6IE9QUFxuIik7DQorCX0NCg0KSWYgdGhhdCdzIE9L
LCBJIGNhbiBkbyBhIHZlcnNpb24gMiB3aXRoIGl0Lg0KDQoNClJlZ2FyZHMNCkNocmlzdG9waA0K
