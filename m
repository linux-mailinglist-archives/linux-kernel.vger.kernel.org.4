Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A178703F2E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 23:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244876AbjEOVBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 17:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245205AbjEOVBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 17:01:36 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE67DC52
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 14:01:26 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 0C8E82C03F9;
        Tue, 16 May 2023 09:01:24 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1684184484;
        bh=Tz5+g/BvNw8GbUeCGGoq026ZsxVO8Vm9awwmEtoqSOw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ZYlYo/13O5wZO6P8sJQ7Licx4xymSAc5tPLLespeJmHXSBjCkG3eI57Gkp9AyS1/0
         L1GZCzDPF5IqlBGsp2/OpDcLL/yOd4fHDoYgT2S4cQCsbsvLXvRxgaKteoGZDjG6GN
         P9mCGas3J2n00nlETvTrddezhExPNDNc3OlhpCJ8tKptrFRIIWgGUT+47tok2X+Q28
         jfxd1nMmjihzY40yLOnwetmkjoeQuQ+Xbxvp+prxy30O3CKFBggZNHlZr+uiI82SP8
         KVSN+F5f9+ScXPFoYvQ+zLeJRxAjG2Vru14KpIG2r3hqp/QWzlptD9Hz6XgFZAaNG/
         /6YnU27aYKJsA==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B64629da30001>; Tue, 16 May 2023 09:01:23 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.26; Tue, 16 May 2023 09:01:23 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Tue, 16 May 2023 09:01:23 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.026; Tue, 16 May 2023 09:01:23 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC:     Johan Hovold <johan@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>, "maz@kernel.org" <maz@kernel.org>,
        Ben Brown <Ben.Brown@alliedtelesis.co.nz>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpiolib: Avoid side effects in gpio_is_visible()
Thread-Topic: [PATCH] gpiolib: Avoid side effects in gpio_is_visible()
Thread-Index: AQHZhIoofApft8Zm8kuYZtpxH+f53K9Vc1EAgAQYugCAAJLPgIAA77UA
Date:   Mon, 15 May 2023 21:01:23 +0000
Message-ID: <00b3447d-ead2-c5c6-c38f-94d38fc8040b@alliedtelesis.co.nz>
References: <20230512042806.3438373-1-chris.packham@alliedtelesis.co.nz>
 <ZF3pqvOVv6eZl62y@hovoldconsulting.com>
 <2265adee-e003-08ae-e66d-fb41bdd79122@alliedtelesis.co.nz>
 <ZGHUjUpI-5JWNCAf@surfacebook>
In-Reply-To: <ZGHUjUpI-5JWNCAf@surfacebook>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEFB3F9149AEBF41ADA1C4B8D577A384@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=cLieTWWN c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=P0xRbXHiH_UA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=1HLHooU2AtUqCnB0nEYA:9 a=QEXdDO2ut3YA:10 a=uYmH_lBRNJ4A:10 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxNS8wNS8yMyAxODo0MywgYW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbSB3cm90ZToNCj4g
U3VuLCBNYXkgMTQsIDIwMjMgYXQgMDk6NTc6NThQTSArMDAwMCwgQ2hyaXMgUGFja2hhbSBraXJq
b2l0dGk6DQo+PiBPbiAxMi8wNS8yMyAxOToyNCwgSm9oYW4gSG92b2xkIHdyb3RlOg0KPj4+IE9u
IEZyaSwgTWF5IDEyLCAyMDIzIGF0IDA0OjI4OjA2UE0gKzEyMDAsIENocmlzIFBhY2toYW0gd3Jv
dGU6DQo+IC4uLg0KPg0KPj4+IFlvdSBuZWVkIGEgYmV0dGVyIGV4cGxhbmF0aW9uIGFzIHRvIHdo
eSB0aGlzIGlzIGFuIGlzc3VlLiBXaGF0IGRvZXMgdGhlDQo+Pj4gd2FybmluZyBsb29rIGxpa2Ug
Zm9yIGV4YW1wbGU/DQo+PiBJcm9uaWNhbGx5IEkgaGFkIHRoYXQgaW4gbXkgZmlyc3QgYXR0ZW1w
dCB0byBhZGRyZXNzIHRoZSBpc3N1ZSBidXQgd2FzDQo+PiB0b2xkIGl0IHdhcyB0b28gbXVjaCBk
ZXRhaWwuIFNvIG5vdyBJJ3ZlIGdvbmUgdG9vIGZhciB0aGUgb3RoZXIgd2F5Lg0KPj4gSSdsbCBp
bmNsdWRlIGl0IGluIHRoZSByZXNwb25zZSBJJ20gYWJvdXQgdG8gc2VuZCB0byBMaW51c1cuDQo+
IFlvdSBoYXZlIGJlZW4gKGltcGxpY2l0bHkpIHRvbGQgdG8gcmVkdWNlIHRoZSBzY29wZSBvZiB0
aGUgZGV0YWlscyB0byBoYXZlDQo+IHRoZSBvbmx5IGltcG9ydGFudCBvbmVzLCByZW1vdmluZyB0
aGUgdHJhY2ViYWNrIGNvbXBsZXRlbHkgd2Fzbid0IG9uIHRoZQ0KPiB0YWJsZS4NCj4NCj4gQ2l0
YXRpb246ICJCZXNpZGVzIHRoZSB2ZXJ5IG5vaXN5IHRyYWNlYmFjayBpbiB0aGUgY29tbWl0IG1l
c3NhZ2UgKHJlYWQNCj4gaHR0cHM6Ly9rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9wcm9jZXNz
L3N1Ym1pdHRpbmctcGF0Y2hlcy5odG1sI2JhY2t0cmFjZXMtaW4tY29tbWl0LW1lc3NhZ2VzIg0K
DQpZZXMgZmFpciBwb2ludC4gSSBqdXN0IG92ZXIgY29tcGVuc2F0ZWQgYW4gdGhvdWdodCB0aGUg
ZXhwbGFuYXRpb24gb2YgDQp3YXJuaW5nIGluIGdwaW9jaGlwX2Rpc2FibGVfaXJxKCkgd2FzIHN1
ZmZpY2llbnQuDQo=
