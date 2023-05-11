Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BB57014EF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 09:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjEMH1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 03:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjEMH1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 03:27:41 -0400
Received: from mx2.securetransport.de (mx2.securetransport.de [IPv6:2a03:4000:13:6c7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BC45583;
        Sat, 13 May 2023 00:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1683962820;
        bh=Zfh4d8B4LCdZL2rza0iU1oDtbQFTnh16x2qtx/eZP60=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=HDRzcSm7DoqCgKQLBwZ0ky+iszHNpckb9iAkuUPOcTix8KM+qg50OPiO2RGEOJD4p
         636UEjrINApY5B9KxPtXxHCEypQHYBwaha5DBDaw9d4HKi8qXo0VBvVTXnH01hCJlT
         Y0OOvd2W3Y9jzc7Q92L0HLo2nDIFlqGpoq1Wccc14TJ5woxY0NPDPPNn0io1RKx5rg
         llEoMJmHbe9oNkkOlKzVG/R7tTa+t5b5zGTtWt0/g76JpvvVOEcxF5l9bAkYXFB//q
         +jfR7A1BGSGPc89FQxAIxOGa/Av/aPWctlcvTcsPD163gg/nZ2vP0oU72Kl5wOENQz
         Y3ehRES9UCdhw==
X-secureTransport-forwarded: yes
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     Marek Vasut <marex@denx.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cpufreq: imx6q: Disable only available frequencies
Thread-Topic: [PATCH] cpufreq: imx6q: Disable only available frequencies
Thread-Index: AQHZg+p2AXZhE0CYb0WkO6LusMFecq9VU2kAgAA31EA=
Date:   Thu, 11 May 2023 20:51:33 +0000
Message-ID: <a377e725107341a8bf57b5aaf63f058b@dh-electronics.com>
References: <20230511092334.3017-1-cniedermaier@dh-electronics.com>
 <898fe00e-43f4-a8aa-b2b4-5b293fc77640@denx.de>
In-Reply-To: <898fe00e-43f4-a8aa-b2b4-5b293fc77640@denx.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWFyZWsgVmFzdXQgW21haWx0bzptYXJleEBkZW54LmRlXQ0KU2VudDogVGh1cnNkYXks
IE1heSAxMSwgMjAyMyA5OjI2IFBNDQo+IE9uIDUvMTEvMjMgMTE6MjMsIENocmlzdG9waCBOaWVk
ZXJtYWllciB3cm90ZToNCj4+IEluIHRoZSBleGFtcGxlIGluIERvY3VtZW50YXRpb24vcG93ZXIv
b3BwLnJzdCwgYW4gYXZhaWxhYmlsaXR5IGNoZWNrDQo+PiBpcyBwcmVzZW50IGJlZm9yZSBkaXNh
YmxpbmcgYSBzcGVjaWZpYyBmcmVxdWVuY3kuIElmIGEgZnJlcXVlbmN5IGlzbid0DQo+PiBhdmFp
bGFibGUsIHRoZSB3YXJuaW5nIG9mIGEgZmFpbGVkIGRpc2FibGluZyBvZiBhIG5vbi1leGlzdGVu
dA0KPj4gZnJlcXVlbmN5IGlzIG1pc2xlYWRpbmcuIFRoZXJlZm9yZSwgY2hlY2sgdGhlIGF2YWls
YWJpbGl0eSBvZiB0aGUNCj4+IGZyZXF1ZW5jeSBpbiBhIHNlcGFyYXRlIGlubGluZSBmdW5jdGlv
biBiZWZvcmUgZGlzYWJsaW5nIGl0Lg0KPiANCj4gWy4uLl0NCj4gDQo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9jcHVmcmVxL2lteDZxLWNwdWZyZXEuYyBiL2RyaXZlcnMvY3B1ZnJlcS9pbXg2cS1j
cHVmcmVxLmMNCj4+IGluZGV4IDQ4ZTE3NzJlOThmZC4uNGUyZDJiYzQ3YWJhIDEwMDY0NA0KPj4g
LS0tIGEvZHJpdmVycy9jcHVmcmVxL2lteDZxLWNwdWZyZXEuYw0KPj4gKysrIGIvZHJpdmVycy9j
cHVmcmVxL2lteDZxLWNwdWZyZXEuYw0KPj4gQEAgLTIwOSw2ICsyMDksMjEgQEAgc3RhdGljIHN0
cnVjdCBjcHVmcmVxX2RyaXZlciBpbXg2cV9jcHVmcmVxX2RyaXZlciA9IHsNCj4+ICAgICAgIC5z
dXNwZW5kID0gY3B1ZnJlcV9nZW5lcmljX3N1c3BlbmQsDQo+PiAgIH07DQo+Pg0KPj4gK3N0YXRp
YyBpbmxpbmUgaW50IGRpc2FibGVfZnJlcV9pZl9hdmFpbGFibGUoc3RydWN0IGRldmljZSAqZGV2
LA0KPiANCj4gVGhlIGlubGluZSBpc24ndCBuZWVkZWQsIGVzcC4gb24gc3RhdGljIGZ1bmN0aW9u
LCBsZXQgdGhlIGNvbXBpbGVyDQo+IGZpZ3VyZSBpdCBvdXQuDQo+IA0KPiBBbHNvLCAiZGlzYWJs
ZSBpZiBhdmFpbGFibGUiIHNob3VsZCByYXRoZXIgYmUgImRpc2FibGUgaWYgdW5hdmFpbGFibGUi
IEkNCj4gdGhpbmsgPw0KDQpIZXJlIEkgbWVhbiB0aGUgT1BQIGFuZCBJIGNhbiBvbmx5IGRpc2Fi
bGUgYW4gYXZhaWxhYmxlIGZyZXF1ZW5jeS4NCg0KPiANCj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgZnJlcSkNCj4+ICt7DQo+PiArICAg
ICBzdHJ1Y3QgZGV2X3BtX29wcCAqb3BwOw0KPj4gKyAgICAgaW50IHJldCA9IDA7DQo+PiArDQo+
PiArICAgICBvcHAgPSBkZXZfcG1fb3BwX2ZpbmRfZnJlcV9leGFjdChkZXYsIGZyZXEsIHRydWUp
Ow0KPj4gKyAgICAgaWYgKCFJU19FUlIob3BwKSkgew0KPj4gKyAgICAgICAgICAgICBkZXZfcG1f
b3BwX3B1dChvcHApOw0KPj4gKyAgICAgICAgICAgICByZXQgPSBkZXZfcG1fb3BwX2Rpc2FibGUo
ZGV2LCBmcmVxKTsNCj4+ICsgICAgIH0NCj4+ICsNCj4+ICsgICAgIHJldHVybiByZXQ7DQo+PiAr
fQ0KPj4gKw0KPj4gICAjZGVmaW5lIE9DT1RQX0NGRzMgICAgICAgICAgICAgICAgICAweDQ0MA0K
Pj4gICAjZGVmaW5lIE9DT1RQX0NGRzNfU1BFRURfU0hJRlQgICAgICAgICAgICAgIDE2DQo+PiAg
ICNkZWZpbmUgT0NPVFBfQ0ZHM19TUEVFRF8xUDJHSFogICAgICAgICAgICAgMHgzDQo+PiBAQCAt
MjU0LDE2ICsyNjksMTYgQEAgc3RhdGljIGludCBpbXg2cV9vcHBfY2hlY2tfc3BlZWRfZ3JhZGlu
ZyhzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+PiAgICAgICB2YWwgJj0gMHgzOw0KPj4NCj4+ICAgICAg
IGlmICh2YWwgPCBPQ09UUF9DRkczX1NQRUVEXzk5Nk1IWikNCj4+IC0gICAgICAgICAgICAgaWYg
KGRldl9wbV9vcHBfZGlzYWJsZShkZXYsIDk5NjAwMDAwMCkpDQo+PiArICAgICAgICAgICAgIGlm
IChkaXNhYmxlX2ZyZXFfaWZfYXZhaWxhYmxlKGRldiwgOTk2MDAwMDAwKSkNCj4+ICAgICAgICAg
ICAgICAgICAgICAgICBkZXZfd2FybihkZXYsICJmYWlsZWQgdG8gZGlzYWJsZSA5OTZNSHogT1BQ
XG4iKTsNCj4+DQo+PiAgICAgICBpZiAob2ZfbWFjaGluZV9pc19jb21wYXRpYmxlKCJmc2wsaW14
NnEiKSB8fA0KPj4gICAgICAgICAgIG9mX21hY2hpbmVfaXNfY29tcGF0aWJsZSgiZnNsLGlteDZx
cCIpKSB7DQo+IA0KPiBDYW4gd2UgaW50cm9kdWNlIGEgZnVuY3Rpb24gbGlrZToNCj4gDQo+IHZv
aWQgaW14X2Rpc2FibGVfZnJlcV9pZl91bmF2YWlsYWJsZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHUz
MiBmcmVxX21oeiwNCj4gdTMyIHZhbCwgdTMyIG1hc2spDQo+IHsNCj4gICAgIGlmICh2YWwgPT0g
bWFzaykNCj4gICAgICAgcmV0dXJuOw0KPiAgICAgaWYgKCFkaXNhYmxlX2ZyZXFfaWZfYXZhaWxh
YmxlKGRldiwgZnJlcV9taHogKiAxMDAwMDAwKSkNCj4gICAgICAgcmV0dXJuOw0KPiAgICAgZGV2
X3dhcm4oZGV2LCAiZmFpbGVkIHRvIGRpc2FibGUgJWRNSHogT1BQXG4iLCBtaHopOw0KPiB9DQo+
IA0KPiBBbmQgdGhlbiBqdXN0IGNhbGwgaXQgbXVsdGlwbGUgdGltZXMgaW4gaGVyZSwgdG8gcmVk
dWNlIGR1cGxpY2F0aW9uID8NCj4gDQo+PiAgICAgICAgICAgICAgIGlmICh2YWwgIT0gT0NPVFBf
Q0ZHM19TUEVFRF84NTJNSFopDQo+PiAtICAgICAgICAgICAgICAgICAgICAgaWYgKGRldl9wbV9v
cHBfZGlzYWJsZShkZXYsIDg1MjAwMDAwMCkpDQo+PiArICAgICAgICAgICAgICAgICAgICAgaWYg
KGRpc2FibGVfZnJlcV9pZl9hdmFpbGFibGUoZGV2LCA4NTIwMDAwMDApKQ0KPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZGV2X3dhcm4oZGV2LCAiZmFpbGVkIHRvIGRpc2FibGUgODUy
TUh6IE9QUFxuIik7DQo+IA0KDQpZZXMsIHVzaW5nIGEgZnVuY3Rpb24gdG8gcmVkdWNlIGR1cGxp
Y2F0aW9ucyB3b3VsZCBiZSBnb29kLg0KDQoNClJlZ2FyZHMNCkNocmlzdG9waA0K
