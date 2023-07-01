Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8916744592
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 02:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjGAA0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 20:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjGAA0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 20:26:11 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37283C2A;
        Fri, 30 Jun 2023 17:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1688171171; x=1719707171;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EVAjfQbNhRjax6f7+Kvlem3Yk941WtRSvZSQTykb7DM=;
  b=E4J9O9Wkspa4bMMNJ9dbNJinf+gAvZlNtD9WR8KgY/jsVhiXxWP8ztyW
   eScLICdBKJW5wF8KJyX53bOhD33/1vCrzXtYSU3EOCAa12+E6JOzTSUey
   eB+lKgkifvgJkc0ZbDQILl155WrWm0uzPfb20aaYxQqNc9AiB+CWkaEkF
   g=;
X-IronPort-AV: E=Sophos;i="6.01,172,1684800000"; 
   d="scan'208";a="348885066"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2023 00:26:06 +0000
Received: from EX19MTAUWA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com (Postfix) with ESMTPS id D9ACB60C5B;
        Sat,  1 Jul 2023 00:26:05 +0000 (UTC)
Received: from EX19D001UWB003.ant.amazon.com (10.13.138.112) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sat, 1 Jul 2023 00:26:05 +0000
Received: from EX19D035UWB002.ant.amazon.com (10.13.138.97) by
 EX19D001UWB003.ant.amazon.com (10.13.138.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.30;
 Sat, 1 Jul 2023 00:26:05 +0000
Received: from EX19D035UWB002.ant.amazon.com ([fe80::90db:7d3a:2c4f:9bb4]) by
 EX19D035UWB002.ant.amazon.com ([fe80::90db:7d3a:2c4f:9bb4%6]) with mapi id
 15.02.1118.030; Sat, 1 Jul 2023 00:26:05 +0000
From:   "Smith, Stewart" <trawets@amazon.com>
To:     Eric Dumazet <edumazet@google.com>
CC:     "Mendoza-Jonas, Samuel" <samjonas@amazon.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        "David Ahern" <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Herrenschmidt, Benjamin" <benh@amazon.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH net] net/ipv6: Reduce chance of collisions in
 inet6_hashfn()
Thread-Topic: [PATCH net] net/ipv6: Reduce chance of collisions in
 inet6_hashfn()
Thread-Index: AQHZq7KfYc+rw25OyUiEk9xvIqrYAw==
Date:   Sat, 1 Jul 2023 00:26:05 +0000
Message-ID: <182D446E-8871-4811-9275-98FF067B1BA9@amazon.com>
References: <20230629015844.800280-1-samjonas@amazon.com>
 <CANn89i+6d9K1VwNK1Joc-Yb_4jAfV_YFzk=z_K2_Oy+xJHSn_g@mail.gmail.com>
In-Reply-To: <CANn89i+6d9K1VwNK1Joc-Yb_4jAfV_YFzk=z_K2_Oy+xJHSn_g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-originating-ip: [10.111.154.15]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB90FE560575E44EB6F2A544336E3923@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gSnVuIDI5LCAyMDIzLCBhdCAzOjA1IEFNLCBFcmljIER1bWF6ZXQgPGVkdW1hemV0
QGdvb2dsZS5jb20+IHdyb3RlOg0KPiANCj4gDQo+IE9uIFRodSwgSnVuIDI5LCAyMDIzIGF0IDM6
NTnigK9BTSBTYW11ZWwgTWVuZG96YS1Kb25hcw0KPiA8c2Ftam9uYXNAYW1hem9uLmNvbT4gd3Jv
dGU6DQo+PiANCj4+IEZyb206IFN0ZXdhcnQgU21pdGggPHRyYXdldHNAYW1hem9uLmNvbT4NCj4+
IA0KPj4gRm9yIGJvdGggSVB2NCBhbmQgSVB2NiBpbmNvbWluZyBUQ1AgY29ubmVjdGlvbnMgYXJl
IHRyYWNrZWQgaW4gYSBoYXNoDQo+PiB0YWJsZSB3aXRoIGEgaGFzaCBvdmVyIHRoZSBzb3VyY2Ug
JiBkZXN0aW5hdGlvbiBhZGRyZXNzZXMgYW5kIHBvcnRzLg0KPj4gSG93ZXZlciwgdGhlIElQdjYg
aGFzaCBpcyBpbnN1ZmZpY2llbnQgYW5kIGNhbiBsZWFkIHRvIGEgaGlnaCByYXRlIG9mDQo+PiBj
b2xsaXNpb25zLg0KPj4gDQo+PiBUaGUgSVB2NiBoYXNoIHVzZWQgYW4gWE9SIHRvIGZpdCBldmVy
eXRoaW5nIGludG8gdGhlIDk2IGJpdHMgZm9yIHRoZQ0KPj4gZmFzdCBqZW5raW5zIGhhc2gsIG1l
YW5pbmcgaXQgaXMgcG9zc2libGUgZm9yIGFuIGV4dGVybmFsIGVudGl0eSB0bw0KPj4gZW5zdXJl
IHRoZSBoYXNoIGNvbGxpZGVzLCB0aHVzIGZhbGxpbmcgYmFjayB0byBhIGxpbmVhciBzZWFyY2gg
aW4gdGhlDQo+PiBidWNrZXQsIHdoaWNoIGlzIHNsb3cuDQo+PiANCj4+IFdlIHRha2UgdGhlIGFw
cHJvYWNoIG9mIGhhc2ggaGFsZiB0aGUgZGF0YTsgaGFzaCB0aGUgb3RoZXIgaGFsZjsgYW5kDQo+
PiB0aGVuIGhhc2ggdGhlbSB0b2dldGhlci4gV2UgZG8gdGhpcyB3aXRoIDN4IGplbmtpbnMgaGFz
aGVzIHJhdGhlciB0aGFuDQo+PiAyeCB0byBjYWxjdWxhdGUgdGhlIGhhc2hpbmcgdmFsdWUgZm9y
IHRoZSBjb25uZWN0aW9uIGNvdmVyaW5nIHRoZSBmdWxsDQo+PiBsZW5ndGggb2YgdGhlIGFkZHJl
c3NlcyBhbmQgcG9ydHMuDQo+PiANCj4gDQo+IC4uLg0KPiANCj4+IFdoaWxlIHRoaXMgbWF5IGxv
b2sgbGlrZSBpdCBhZGRzIG92ZXJoZWFkLCB0aGUgcmVhbGl0eSBvZiBtb2Rlcm4gQ1BVcw0KPj4g
bWVhbnMgdGhhdCB0aGlzIGlzIHVubWVhc3VyYWJsZSBpbiByZWFsIHdvcmxkIHNjZW5hcmlvcy4N
Cj4+IA0KPj4gSW4gc2ltdWxhdGluZyB3aXRoIGxsdm0tbWNhLCB0aGUgaW5jcmVhc2UgaW4gY3lj
bGVzIGZvciB0aGUgaGFzaGluZyBjb2RlDQo+PiB3YXMgfjUgY3ljbGVzIG9uIFNreWxha2UgKGZy
b20gYSBiYXNlIG9mIH41MCksIGFuZCBhbiBleHRyYSB+OSBvbg0KPj4gTmVoYWxlbSAoYmFzZSBv
ZiB+NjIpLg0KPj4gDQo+PiBJbiBjb21taXQgZGQ2ZDI5MTBjNWUwICgibmV0ZmlsdGVyOiBjb25u
dHJhY2s6IHN3aXRjaCB0byBzaXBoYXNoIikNCj4+IG5ldGZpbHRlciBzd2l0Y2hlZCBmcm9tIGEg
amVua2lucyBoYXNoIHRvIGEgc2lwaGFzaCwgYnV0IGV2ZW4gdGhlIGZhc3Rlcg0KPj4gaHNpcGhh
c2ggaXMgYSBtb3JlIHNpZ25pZmljYW50IG92ZXJoZWFkICh+MjAtMzAlKSBpbiBzb21lIHByZWxp
bWluYXJ5DQo+PiB0ZXN0aW5nLiBTbywgaW4gdGhpcyBwYXRjaCwgd2Uga2VlcCB0byB0aGUgbW9y
ZSBjb25zZXJ2YXRpdmUgYXBwcm9hY2ggdG8NCj4+IGVuc3VyZSB3ZSBkb24ndCBhZGQgbXVjaCBv
dmVyaGVhZCBwZXIgU1lOLg0KPj4gDQo+PiBJbiB0ZXN0aW5nLCB0aGlzIHJlc3VsdHMgaW4gYSBj
b25zaXN0ZW50bHkgZXZlbiBzcHJlYWQgYWNyb3NzIHRoZQ0KPj4gY29ubmVjdGlvbiBidWNrZXRz
LiBJbiBib3RoIHRlc3RpbmcgYW5kIHJlYWwtd29ybGQgc2NlbmFyaW9zLCB3ZSBoYXZlDQo+PiBu
b3QgZm91bmQgYW55IG1lYXN1cmFibGUgcGVyZm9ybWFuY2UgaW1wYWN0Lg0KPj4gDQo+PiBDYzog
c3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPj4gRml4ZXM6IDA4ZGNkYmY2YTdiOSAoImlwdjY6IHVz
ZSBhIHN0cm9uZ2VyIGhhc2ggZm9yIHRjcCIpDQo+PiBGaXhlczogYjNkYTJjZjM3YzVjICgiW0lO
RVRdOiBVc2Ugamhhc2ggKyByYW5kb20gc2VjcmV0IGZvciBlaGFzaC4iKQ0KPj4gU2lnbmVkLW9m
Zi1ieTogU3Rld2FydCBTbWl0aCA8dHJhd2V0c0BhbWF6b24uY29tPg0KPj4gU2lnbmVkLW9mZi1i
eTogU2FtdWVsIE1lbmRvemEtSm9uYXMgPHNhbWpvbmFzQGFtYXpvbi5jb20+DQo+PiAtLS0NCj4+
IGluY2x1ZGUvbmV0L2lwdjYuaCAgICAgICAgICB8IDQgKy0tLQ0KPj4gbmV0L2lwdjYvaW5ldDZf
aGFzaHRhYmxlcy5jIHwgNSArKysrLQ0KPj4gMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pDQo+PiANCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL25ldC9pcHY2
LmggYi9pbmNsdWRlL25ldC9pcHY2LmgNCj4+IGluZGV4IDczMzIyOTZlY2E0NC4uZjliYjU0ODY5
ZDgyIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9uZXQvaXB2Ni5oDQo+PiArKysgYi9pbmNsdWRl
L25ldC9pcHY2LmgNCj4+IEBAIC03NTIsOSArNzUyLDcgQEAgc3RhdGljIGlubGluZSB1MzIgaXB2
Nl9hZGRyX2hhc2goY29uc3Qgc3RydWN0IGluNl9hZGRyICphKQ0KPj4gLyogbW9yZSBzZWN1cmVk
IHZlcnNpb24gb2YgaXB2Nl9hZGRyX2hhc2goKSAqLw0KPj4gc3RhdGljIGlubGluZSB1MzIgX19p
cHY2X2FkZHJfamhhc2goY29uc3Qgc3RydWN0IGluNl9hZGRyICphLCBjb25zdCB1MzIgaW5pdHZh
bCkNCj4+IHsNCj4+IC0gICAgICAgdTMyIHYgPSAoX19mb3JjZSB1MzIpYS0+czZfYWRkcjMyWzBd
IF4gKF9fZm9yY2UgdTMyKWEtPnM2X2FkZHIzMlsxXTsNCj4+IC0NCj4+IC0gICAgICAgcmV0dXJu
IGpoYXNoXzN3b3Jkcyh2LA0KPj4gKyAgICAgICByZXR1cm4gamhhc2hfM3dvcmRzKChfX2ZvcmNl
IHUzMilhLT5zNl9hZGRyMzJbMV0sDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAoX19m
b3JjZSB1MzIpYS0+czZfYWRkcjMyWzJdLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
KF9fZm9yY2UgdTMyKWEtPnM2X2FkZHIzMlszXSwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGluaXR2YWwpOw0KPiANCj4gSG1tbS4uLiBzZWUgbXkgZm9sbG93aW5nIGNvbW1lbnQuDQo+
IA0KPj4gZGlmZiAtLWdpdCBhL25ldC9pcHY2L2luZXQ2X2hhc2h0YWJsZXMuYyBiL25ldC9pcHY2
L2luZXQ2X2hhc2h0YWJsZXMuYw0KPj4gaW5kZXggYjY0YjQ5MDEyNjU1Li5iYjcxOTgwODE5NzQg
MTAwNjQ0DQo+PiAtLS0gYS9uZXQvaXB2Ni9pbmV0Nl9oYXNodGFibGVzLmMNCj4+ICsrKyBiL25l
dC9pcHY2L2luZXQ2X2hhc2h0YWJsZXMuYw0KPj4gQEAgLTMzLDcgKzMzLDEwIEBAIHUzMiBpbmV0
Nl9laGFzaGZuKGNvbnN0IHN0cnVjdCBuZXQgKm5ldCwNCj4+ICAgICAgICBuZXRfZ2V0X3JhbmRv
bV9vbmNlKCZpbmV0Nl9laGFzaF9zZWNyZXQsIHNpemVvZihpbmV0Nl9laGFzaF9zZWNyZXQpKTsN
Cj4+ICAgICAgICBuZXRfZ2V0X3JhbmRvbV9vbmNlKCZpcHY2X2hhc2hfc2VjcmV0LCBzaXplb2Yo
aXB2Nl9oYXNoX3NlY3JldCkpOw0KPj4gDQo+PiAtICAgICAgIGxoYXNoID0gKF9fZm9yY2UgdTMy
KWxhZGRyLT5zNl9hZGRyMzJbM107DQo+PiArICAgICAgIGxoYXNoID0gamhhc2hfM3dvcmRzKChf
X2ZvcmNlIHUzMilsYWRkci0+czZfYWRkcjMyWzNdLA0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICgoKHUzMilscG9ydCkgPDwgMTYpIHwgKF9fZm9yY2UgdTMyKWZwb3J0LA0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgIChfX2ZvcmNlIHUzMilmYWRkci0+czZfYWRkcjMyWzBd
LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIGlwdjZfaGFzaF9zZWNyZXQpOw0KPiAN
Cj4gVGhpcyBzZWVtcyB3cm9uZyB0byBtZS4NCj4gDQo+IFJldXNpbmcgaXB2Nl9oYXNoX3NlY3Jl
dCBhbmQgb3RoZXIga2V5cyB0d2ljZSBpcyBub3QgZ29vZCwgSSBhbSBzdXJlDQo+IHNvbWUgc2Vj
dXJpdHkgcmVzZWFyY2hlcnMNCj4gd291bGQgbG92ZSB0aGlzLi4uDQoNCk15IHBlcnNvbmFsIG1h
dGggaGVyZSBpcyBub3doZXJlIG5lYXIgd2hhdOKAmXMgbmVlZGVkIHRvIHdvcmsgb3V0IGlmIGl0
4oCZcyBhIHByb2JsZW0gb3Igbm90LCBpdCBwYXNzZWQgdGhlIOKAnEFtIEkgYSBjb21wbGV0ZSBp
ZGlvdCBoZXJlP+KAnSBxdWVzdGlvbiBvZiBzb21lb25lIG11Y2ggc21hcnRlciB0aGFuIG1lIGlu
IHRoZSBhcmVhLCBidXQgdGhhdOKAmXMgbm90IHN1c3RhaW5lZCBzY3J1dGlueSBvZiBjb3Vyc2Uu
IEl04oCZcyBxdWl0ZSBwb3NzaWJsZSB0aGVyZeKAmXMgc29tZXRoaW5nIHRoZXJlIGdpdmVuIGVu
b3VnaCB0aW1lIHRvIG5vb2RsZSBvbiBpdC4NCg0KPiBQbGVhc2UganVzdCBjaGFuZ2UgX19pcHY2
X2FkZHJfamhhc2goKSwgc28gdGhhdCBhbGwgdXNlcnMgY2FuIGJlbmVmaXQNCj4gZnJvbSBhIG1v
cmUgc2VjdXJlIHZlcnNpb24gPw0KPiBJdCBhbHNvIGxlYXZlcyBsaGFzaCAvIGZoYXNoIG5hbWVz
IHJlbGV2YW50IGhlcmUuDQo+IA0KPiBXZSB3aWxsIHByb2JhYmx5IGhhdmUgdG8gc3dpdGNoIHRv
IHNpcCAob3Igb3RoZXIgc3Ryb25nZXIgaGFzaCB0aGFuDQo+IGpoYXNoKSAgYXQgc29tZSBwb2lu
dCwgaXQgaXMgYSB0cmFkZW9mZi4NCg0KUHJvYmFibHkgdG8gYSBoc2lwaGFzaD8NCg0KV2hlbiB1
c2luZyB0aGUgc2FtZSBraW5kIG9mIHNpbSB3aXRoIGxsdm0tbWNhLCBoc2lwaGFzaCBhcHBlYXJz
IHRvIGJlIGFib3V0IHRoZSBzYW1lIG51bWJlciBvZiBjeWNsZXMgYXMgamhhc2gyIHlvdSBzdWdn
ZXN0LCBzbyBtYXliZSB3ZSBzaG91bGQganVzdCBnbyB0aGVyZSBhbmQgYmUgZG9uZSB3aXRoIGl0
Pw0KDQpJIHB1dCBteSB0ZXN0cyBhbmQgb3V0cHV0IHVwIGF0IGh0dHBzOi8vZ2l0aHViLmNvbS9z
dGV3YXJ0c21pdGgvaW5ldDZfaGFzaGZuLXNpbSANCg0KSeKAmWxsIHRocm93IHNvbWUgdHJhZmZp
YyBhdCB0aGUgaHNpcGhhc2ggYW5kIHNlZSBpZiB3ZSBjYW4gb2JzZXJ2ZSBhIGRpZmZlcmVuY2Uu
DQoNCklmIG5vYm9keSBpcyBtYWRseSBjb21wbGFpbmluZyBhYm91dCBuZXRmaWx0ZXIgc3dpdGNo
aW5nIHRvIGl0IGFzIG9mIGRkNmQyOTEwYzVlMDcxYTg2ODM4MjdkZjFhODllNTI3YWE1MTQ1YWIs
IHRoZW4gaXQgbWF5IGJlIGZpbmUsIGJ1dCB3aWxsIHRocm93IHNvbWUgbW9yZSBiZW5jaG1hcmtz
IGF0IGl0Lg0KDQo=
