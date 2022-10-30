Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A86612AD8
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 15:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJ3OCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 10:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJ3OCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 10:02:07 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9626DB49D;
        Sun, 30 Oct 2022 07:02:04 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 34B0E5FD02;
        Sun, 30 Oct 2022 17:02:00 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1667138520;
        bh=c/VAlILCV2DaqKfQvynv+mBTbvN0iJjo5y/Ygka3gBk=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=sfcMMDISlKbfkEdl6G6OLNATtbrzDnudkTBxX+e+SAoSebf7glcDWz1qm5JXuXQys
         rzBxBUwpzhiv/ex/8BVlXpBuwnEIBM0WYSiINzG9ugLHCT+X42gIc5PieePIlQTOCF
         dpUKL6xGUebWlTzuoRGLKRaHif1vKX5H512LIxPRz3hdqLJkvKFpxKH13r0j8yyHGP
         k6w9xoaejHfHoZyvQJd6WcGCgf1zU5F/EFZ0HH7J7fegqzdou9tZaVMSfZxO80Nc5I
         EN+ZIjXXLKAA3Flm/8Kgx3JUcyrT4MbHJOkWD31N7dzoN1xiXpIOgqTEfUWerrKx2A
         Coy4Lp7jBhT1w==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Sun, 30 Oct 2022 17:02:00 +0300 (MSK)
From:   Arseniy Krasnov <AVKrasnov@sberdevices.ru>
To:     Pavel Machek <pavel@ucw.cz>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [RFC PATCH v1 1/1] leds: support to use own workqueue for each
 LED
Thread-Topic: [RFC PATCH v1 1/1] leds: support to use own workqueue for each
 LED
Thread-Index: AQHY7CXVXNE+VpHZTEOLMCYP8pPo3a4mqWiAgAAcMYA=
Date:   Sun, 30 Oct 2022 14:01:23 +0000
Message-ID: <b7304844-a654-2120-2159-29f6134dbadb@sberdevices.ru>
References: <9a0a70a8-0886-1115-6151-72d2cba842cf@sberdevices.ru>
 <33d05330-7c52-e873-bf32-209d40c77632@sberdevices.ru>
 <20221030122029.GA8017@duo.ucw.cz>
In-Reply-To: <20221030122029.GA8017@duo.ucw.cz>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="utf-8"
Content-ID: <01ED6DA5BE8A624492A4C0A8ECBE6C23@sberdevices.ru>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/10/30 06:59:00 #20535378
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAuMTAuMjAyMiAxNToyMCwgUGF2ZWwgTWFjaGVrIHdyb3RlOg0KPiBPbiBTdW4gMjAyMi0x
MC0zMCAwNjowNzowNSwgQXJzZW5peSBLcmFzbm92IHdyb3RlOg0KPj4gVGhpcyBhbGxvd3MgdG8g
c2V0IG93biB3b3JrcXVldWUgZm9yIGVhY2ggTEVELiBUaGlzIG1heSBiZSB1c2VmdWwsIGJlY2F1
c2UNCj4+IGRlZmF1bHQgJ3N5c3RlbV93cScgZG9lcyBub3QgZ3VhcmFudGVlIGV4ZWN1dGlvbiBv
cmRlciBvZiBlYWNoIHdvcmtfc3RydWN0LA0KPj4gdGh1cyBmb3Igc2V2ZXJhbCBicmlnaHRuZXNz
IHVwZGF0ZSByZXF1ZXN0cyAoZm9yIG11bHRpcGxlIGxlZHMpLCByZWFsDQo+PiBicmlnaHRuZXNz
IHN3aXRjaCBjb3VsZCBiZSBpbiByYW5kb20gb3JkZXIuDQo+IA0KPiBTby4uIHdoYXQ/DQo+IA0K
PiBFdmVuIGlmIGV4ZWN1dGlvbiBvcmRlciBpcyBzd2l0Y2hlZCwgaHVtYW4gZXllIHdpbGwgbm90
IGJlIGFibGUgdG8NCj4gdGVsbCB0aGUgZGlmZmVyZW5jZS4NCkhlbGxvLA0KDQpQcm9ibGVtIGFy
aXNlcyBvbiBvbmUgb2Ygb3VyIGJvYXJkcyB3aGVyZSB3ZSBoYXZlIDE0IHRyaXBsZXMgb2YgbGVk
cyhlYWNoDQp0cmlwbGUgY29udGFpbnMgUiBHIEIpLiBUZXN0IGNhc2UgaXMgdG8gcGxheSBjb21w
bGV4IGFuaW1hdGlvbiBvbiBhbGwgbGVkczoNCnNtb290aCBzd2l0Y2ggZnJvbSBvbiBSR0Igc3Rh
dGUgdG8gYW5vdGhlci4gU29tZXRpbWVzIHRoZXJlIGFyZSBnbGl0Y2hlcyBpbg0KdGhpcyBwcm9j
ZXNzIC0gZGl2ZXJnZW5jZSBmcm9tIGV4cGVjdGFibGUgUkdCIHN0YXRlLiBXZSBmaXhlZCB0aGlz
IGJ5IHVzaW5nDQpvcmRlcmVkIHdvcmtxdWV1ZS4NCg0KVGhhbmtzLCBBcnNlbml5DQoNCj4gCQkJ
CQkJCQlQYXZlbA0KDQo=
