Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609966E6DF6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjDRVUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjDRVUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:20:07 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31694486
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:20:05 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id DC9982C0533;
        Wed, 19 Apr 2023 09:20:02 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1681852802;
        bh=x3alwfNlBzfwbZU57e4dV0T0LMpuH29WAw4zSK/aQEs=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=VJ6+kckm30bjQHWv+Q0VSx9mID/fpv778oeUfJlMxUG/0CIfl014QFUvBmb3flN3x
         azlZLBaaQ0ZN8XjU7IXDVLsi8qqUNtFNH8YYYodhXltYxxoQKByCKHBTnHrPQePJfp
         ejKhJGSCNQakSYG76E90tHPtnJ11Wyi6vNvDanJoKHNaoYsS/vPcRdgu6xfB6zW1Di
         M0uSq0E/iMBcZt2+T0WhXwJGUxa7FXKovpYvDx+m7llHEWMyh+Dqgpqui0mR5Ht2xk
         SKzhyozPYa/R5irCAkrbJh5gIZ0VkPyzZrBBoArJBKJ0wcnhXFwMlzx7tB6hWKsgj/
         T6tjr41Ijfsgw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B643f09820001>; Wed, 19 Apr 2023 09:20:02 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.26; Wed, 19 Apr 2023 09:20:02 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with Microsoft
 SMTP Server (TLS) id 15.0.1497.48; Wed, 19 Apr 2023 09:20:02 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Wed, 19 Apr 2023 09:20:02 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     =?utf-8?B?TWFyaXVzeiBCaWHFgm/FhGN6eWs=?= <manio@skyboo.net>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: hwmon: (adt7475) Add support for inverting pwm output
Thread-Topic: hwmon: (adt7475) Add support for inverting pwm output
Thread-Index: AQHZceXWdXchU+yVXUm4m0tN5Sjguq8wv1sAgAAKwIA=
Date:   Tue, 18 Apr 2023 21:20:02 +0000
Message-ID: <52e26a67-9131-2dc0-40cb-db5c07370027@alliedtelesis.co.nz>
References: <20230418110623.vk6kettnjondulri@skyboo.net>
 <e398560f-f8d1-afbc-4aae-ab3cf2555e8e@alliedtelesis.co.nz>
In-Reply-To: <e398560f-f8d1-afbc-4aae-ab3cf2555e8e@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1C4F17850891D4B9F2E6621A96860AB@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=VfuJw2h9 c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=dKHAf1wccvYA:10 a=rPQhiZsA37OnAWj8wpIA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxOS8wNC8yMyAwODo0MSwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4gSGkgTWFyaXVzLA0K
Pg0KPiArY2MgbGludXgtaHdtb24sIGxrbWwNCj4NCj4gT24gMTgvMDQvMjMgMjM6MDYsIE1hcml1
c3ogQmlhxYJvxYRjenlrIHdyb3RlOg0KPj4gSGkgQ2hyaXMsDQo+PiBJIGRpc2NvdmVyZWQgYnkg
YWNjaWRlbnQgdGhhdCBteSBkbWVzZyBpcyB0ZWxsaW5nIG1lOg0KPj4gW01vbiBBcHIgMTcgMTk6
MDg6NTkgMjAyM10gYWR0NzQ3NSAxOS0wMDJlOiBFcnJvciBjb25maWd1cmluZyBwd20gDQo+PiBw
b2xhcml0eQ0KPj4gW01vbiBBcHIgMTcgMTk6MDg6NTkgMjAyM10gYWR0NzQ3NSAxOS0wMDJlOiBB
RFQ3NDczIGRldmljZSwgcmV2aXNpb24gMQ0KPj4NCj4+IG1vdGhlcmJvYXJkOg0KPj4gRE1JOiBT
eXN0ZW0gbWFudWZhY3R1cmVyIFN5c3RlbSBQcm9kdWN0IE5hbWUvTTRBNzg1VEQtViBFVk8sIEJJ
T1MgDQo+PiAyMTA1wqDCoMKgIDA3LzIzLzIwMTANCj4+DQo+PiBJcyB0aGlzIHNvbWV0aGluZyBp
IG5lZWQgdG8gYmUgYWZyYWlkLCBvciBpdCdzIG5vdGhpbmcgc2VyaW91cz8NCj4NCj4gSXQncyBw
cm9iYWJseSBoYXJtbGVzcywgdW5sZXNzIHlvdXIgYm9hcmQgaXMgaW50ZW50aW9uYWxseSBzZXR0
aW5nIHRoZSANCj4gcHdtLWFjdGl2ZS1zdGF0ZSAod2hpY2ggSSBzdXNwZWN0IGl0IHdvbid0IGJl
IGFzIHlvdXIgQklPUyBpcyBwcm9iYWJseSANCj4gdGFraW5nIGNhcmUgb2YgdGhhdCBpZiByZXF1
aXJlZCkuIEkgc3VzcGVjdCBpdCdzIG1vcmUgYSBjYXNlIG9mIHRoZSANCj4gY29kZSBub3QgaGFu
ZGxpbmcgdGhlIGFic2VuY2Ugb2YgYSBkZXZpY2UgdHJlZSB3aGljaCB0aGUgY2hlY2sgZm9yIA0K
PiAtRUlOVkFMIHdhcyBzdXBwb3NlZCB0byBkZWFsIHdpdGguIFRoZXJlJ3MgYW4gb3V0c2lkZSBj
aGFuY2UgdGhhdCANCj4gdGhlcmUgaXMgYSBwcm9ibGVtIG9uIHRoZSBJMkMgYnVzIGJ1dCB0aGF0
IHdvdWxkIHJlcXVpcmUgeW91ciBwbGF0Zm9ybSANCj4gdG8gYmUgYWN0aXZlbHkgdXNpbmcgdGhl
IHB3bSBwb2xhcml0eSBmZWF0dXJlIHZpYSBhIGRldmljZSB0cmVlIA0KPiAodW5saWtlbHkgb3V0
c2lkZSBvZiBlbWJlZGRlZCBkZXZpY2VzKS4NCj4NCj4gSSB0aGluayBpdCdkIHN0aWxsIGJlIGEg
Z29vZCBpZGVhIHRvIHNxdWFzaCB0aGUgZXJyYW50IHdhcm5pbmcgc28gDQo+IGdlbnVpbmUgZXJy
b3JzIGFyZSBjYXVnaHQuIEknbGwgc2VlIGlmIEkgY2FuIHByb3Zva2UgdGhlIGlzc3VlIG9uIA0K
PiBkZXZpY2VzIEkgaGF2ZSBhY2Nlc3MgdG8uIEFyZSB5b3UgaW4gYSBwb3NpdGlvbiB0byB0cnkg
YSBwYXRjaCBpZiBJIA0KPiBjb21lIHVwIHdpdGggb25lPw0KQWggSSB0aGluayBJIHNlZSB0aGUg
cHJvYmxlbS4gT24gcGxhdGZvcm1zIHdpdGhvdXQgZGV2aWNlIHRyZWUgc3VwcG9ydCANCnRoZSBv
Zl9wcm9wZXJ0eV9yZWFkXyooKSBmdW5jdGlvbnMgcmV0dXJuIC1FTk9TWVMgc28gSSBuZWVkIHRv
IGRlYWwgd2l0aCANCnRoYXQgZXJyb3IgY29kZSBhcyB3ZWxsIGFzIC1FSU5WQUwu
