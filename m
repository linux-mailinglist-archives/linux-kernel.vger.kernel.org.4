Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087135F40FD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 12:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJDKpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 06:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJDKpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 06:45:51 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059B050504
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 03:45:49 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-264-FH1a9qrmNke5557Bg5trUA-1; Tue, 04 Oct 2022 11:45:47 +0100
X-MC-Unique: FH1a9qrmNke5557Bg5trUA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Tue, 4 Oct
 2022 11:45:43 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Tue, 4 Oct 2022 11:45:43 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'John Stultz' <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Pavankumar Kondeti <pkondeti@codeaurora.org>,
        John Dias <joaodias@google.com>,
        Connor O'Brien <connoro@google.com>,
        Rick Yiu <rickyiu@google.com>, John Kacur <jkacur@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        "Abhijeet Dharmapurikar" <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "kernel-team@android.com" <kernel-team@android.com>,
        Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>,
        "J . Avila" <elavila@google.com>
Subject: RE: [RFC PATCH v4 3/3] softirq: defer softirq processing to ksoftirqd
 if CPU is busy with RT
Thread-Topic: [RFC PATCH v4 3/3] softirq: defer softirq processing to
 ksoftirqd if CPU is busy with RT
Thread-Index: AQHY137PeCXUyXlKSE6PmZSqbVV5Vq3+C5IA
Date:   Tue, 4 Oct 2022 10:45:43 +0000
Message-ID: <ac37c63a5039435ab775a0e983213902@AcuMS.aculab.com>
References: <20221003232033.3404802-1-jstultz@google.com>
 <20221003232033.3404802-4-jstultz@google.com>
In-Reply-To: <20221003232033.3404802-4-jstultz@google.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSm9obiBTdHVsdHoNCj4gU2VudDogMDQgT2N0b2JlciAyMDIyIDAwOjIxDQo+IA0KPiBG
cm9tOiBQYXZhbmt1bWFyIEtvbmRldGkgPHBrb25kZXRpQGNvZGVhdXJvcmEub3JnPg0KPiANCj4g
RGVmZXIgdGhlIHNvZnRpcnEgcHJvY2Vzc2luZyB0byBrc29mdGlycWQgaWYgYSBSVCB0YXNrIGlz
DQo+IHJ1bm5pbmcgb3IgcXVldWVkIG9uIHRoZSBjdXJyZW50IENQVS4gVGhpcyBjb21wbGVtZW50
cyB0aGUgUlQNCj4gdGFzayBwbGFjZW1lbnQgYWxnb3JpdGhtIHdoaWNoIHRyaWVzIHRvIGZpbmQg
YSBDUFUgdGhhdCBpcyBub3QNCj4gY3VycmVudGx5IGJ1c3kgd2l0aCBzb2Z0aXJxcy4NCj4gDQo+
IEN1cnJlbnRseSBORVRfVFgsIE5FVF9SWCwgQkxPQ0sgYW5kIElSUV9QT0xMIHNvZnRpcnFzIGFy
ZSBvbmx5DQo+IGRlZmVycmVkIGFzIHRoZXkgY2FuIHBvdGVudGlhbGx5IHJ1biBmb3IgbG9uZyB0
aW1lLg0KDQpEZWZlcnJpbmcgTkVUX1JYIHRvIGtzb2Z0aXJxZCBzdG9wcyB0aGUgTkVUX1JYIGNv
ZGUgZnJvbQ0KcnVubmluZyB1bnRpbCB0aGUgUlQgcHJvY2VzcyBjb21wbGV0ZXMuDQoNClRoaXMg
aGFzIGV4YWN0bHkgdGhlIHNhbWUgcHJvYmxlbXMgYXMgdGhlIHNvZnRpbnQgdGFraW5nDQpwcmlv
cml0eSBvZiB0aGUgUlQgdGFzayAtIGp1c3QgdGhlIG90aGVyIHdheSBhcm91bmQuDQoNClVuZGVy
IHZlcnkgaGlnaCB0cmFmZmljIGxvYWRzIHJlY2VpdmUgcGFja2V0cyBnZXQgbG9zdC4NCkluIG1h
bnkgY2FzZXMgdGhhdCBpcyBhY3R1YWxseSBmYXIgd29yc2UgdGhhdCB0aGUgd2FrZXVwDQpvZiBh
biBSVCBwcm9jZXNzIGJlaW5nIGRlbGF5ZWQgc2xpZ2h0bHkuDQoNClRoZSBpcyBubyAnb25lIHNp
emUgZml0cyBhbGwnIGFuc3dlciB0byB0aGUgcHJvYmxlbS4NCg0KUGxhdXNpYmx5IGRlcGVuZGlu
ZyBvbiB0aGUgcHJpb3JpdHkgb2YgdGhlIFJUIHRhc2sNCm1pZ2h0IGJlIHVzZWZ1bC4NCkJ1dCBz
b21ldGltZXMgaXQgZGVwZW5kcyBvbiB0aGUgYWN0dWFsIHJlYXNvbiBmb3IgdGhlDQp3YWtldXAu
DQpGb3IgaW5zdGFuY2UgYSB3YWtldXAgZnJvbSBhbiBJU1Igb3IgYSBoaXNoLXJlcyB0aW1lcg0K
bWlnaHQgbmVlZCBsb3dlciBsYXRlbmN5IHRoYW4gb25lIGZyb20gYSBmdXRleC4NCg0KCURhdmlk
DQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBG
YXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2
IChXYWxlcykNCg==

