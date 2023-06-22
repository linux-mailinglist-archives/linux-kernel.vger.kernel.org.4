Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C735873A243
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjFVNzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjFVNzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:55:32 -0400
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D771BF6;
        Thu, 22 Jun 2023 06:55:26 -0700 (PDT)
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
        by mx0.infotecs.ru (Postfix) with ESMTP id 041CE10F4874;
        Thu, 22 Jun 2023 16:55:23 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 041CE10F4874
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
        t=1687442123; bh=4n0/HOa8GcSzSv0ccDtNa+JBp10/ttCJkrIJGTCvlBU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=kHhFfhWWEBFs4xMaoIib8LP+3Swn1yh0P52ShIUncCSo5kch5jNeyUKoOKaxqCO8p
         Mb1Pj/ATMB7MqsgNBTVb1QoEv2S2SyY0G3y+/jgIzkTd5cvhiRYr7GX6U7sRFrR4S1
         X7lkaTFRwjTAWBJwWUSwznw1gPXnYy+OPi5wB58Q=
Received: from msk-exch-01.infotecs-nt (msk-exch-01.infotecs-nt [10.0.7.191])
        by mx0.infotecs-nt (Postfix) with ESMTP id 0102230D12EB;
        Thu, 22 Jun 2023 16:55:23 +0300 (MSK)
From:   Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To:     Simon Horman <simon.horman@corigine.com>
CC:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Patrick McHardy <kaber@trash.net>,
        "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
        "coreteam@netfilter.org" <coreteam@netfilter.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH] netfilter: nf_conntrack_sip: fix the
 ct_sip_parse_numerical_param() return value.
Thread-Topic: [PATCH] netfilter: nf_conntrack_sip: fix the
 ct_sip_parse_numerical_param() return value.
Thread-Index: AQHZpREwousYyJT2d0KPXYKYnJV5Dg==
Date:   Thu, 22 Jun 2023 13:55:22 +0000
Message-ID: <6f2b5c12-82b5-2496-23a3-05ab22d7b14b@infotecs.ru>
References: <20230426150414.2768070-1-Ilia.Gavrilov@infotecs.ru>
 <ZEwdd7Xj4fQtCXoe@corigine.com>
 <d0a92686-acc4-4fd8-0505-60a8394d05d8@infotecs.ru>
 <ZFEYpNsp/hBEJAGU@corigine.com>
 <f9d9ac80-704a-91d7-b120-449b921e8bb0@infotecs.ru>
 <ZFEuazEvNWHfEH93@corigine.com>
In-Reply-To: <ZFEuazEvNWHfEH93@corigine.com>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.17.0.10]
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="utf-8"
Content-ID: <10FD4159AF211947B84172ACF6576E05@infotecs.ru>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 178188 [Jun 22 2023]
X-KLMS-AntiSpam-Version: 5.9.59.0
X-KLMS-AntiSpam-Envelope-From: Ilia.Gavrilov@infotecs.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 517 517 b0056c19d8e10afbb16cb7aad7258dedb0179a79, {Tracking_msgid_8}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;infotecs.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2023/06/22 12:25:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/06/22 09:26:00 #21554371
X-KLMS-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8yLzIzIDE4OjM4LCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+IE9uIFR1ZSwgTWF5IDAyLCAy
MDIzIGF0IDAyOjE2OjA5UE0gKzAwMDAsIEdhdnJpbG92IElsaWEgd3JvdGU6DQo+PiBPbiA1LzIv
MjMgMTc6MDUsIFNpbW9uIEhvcm1hbiB3cm90ZToNCj4+PiBPbiBUdWUsIE1heSAwMiwgMjAyMyBh
dCAxMTo0MzoxOUFNICswMDAwLCBHYXZyaWxvdiBJbGlhIHdyb3RlOg0KPj4+PiBPbiA0LzI4LzIz
IDIyOjI0LCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+Pj4+PiBPbiBXZWQsIEFwciAyNiwgMjAyMyBh
dCAwMzowNDozMVBNICswMDAwLCBHYXZyaWxvdiBJbGlhIHdyb3RlOg0KPj4+Pj4+IGN0X3NpcF9w
YXJzZV9udW1lcmljYWxfcGFyYW0oKSByZXR1cm5zIG9ubHkgMCBvciAxIG5vdy4NCj4+Pj4+PiBC
dXQgcHJvY2Vzc19yZWdpc3Rlcl9yZXF1ZXN0KCkgYW5kIHByb2Nlc3NfcmVnaXN0ZXJfcmVzcG9u
c2UoKSBpbXBseQ0KPj4+Pj4+IGNoZWNraW5nIGZvciBhIG5lZ2F0aXZlIHZhbHVlIGlmIHBhcnNp
bmcgb2YgYSBudW1lcmljYWwgaGVhZGVyIHBhcmFtZXRlcg0KPj4+Pj4+IGZhaWxlZC4gTGV0J3Mg
Zml4IGl0Lg0KPj4+Pj4+DQo+Pj4+Pj4gRm91bmQgYnkgSW5mb1RlQ1Mgb24gYmVoYWxmIG9mIExp
bnV4IFZlcmlmaWNhdGlvbiBDZW50ZXINCj4+Pj4+PiAobGludXh0ZXN0aW5nLm9yZykgd2l0aCBT
VkFDRS4NCj4+Pj4+Pg0KPj4+Pj4+IEZpeGVzOiAwZjMyYTQwZmM5MWEgKCJbTkVURklMVEVSXTog
bmZfY29ubnRyYWNrX3NpcDogY3JlYXRlIHNpZ25hbGxpbmcgZXhwZWN0YXRpb25zIikNCj4+Pj4+
PiBTaWduZWQtb2ZmLWJ5OiBJbGlhLkdhdnJpbG92IDxJbGlhLkdhdnJpbG92QGluZm90ZWNzLnJ1
Pg0KPj4+Pj4NCj4+Pj4+IEhpIEdhdnJpbG92LA0KPj4+Pj4NCj4+Pj4NCj4+Pj4gSGkgU2ltb24s
IHRoYW5rIHlvdSBmb3IgeW91ciBhbnN3ZXIuDQo+Pj4+DQo+Pj4+PiBhbHRob3VnaCBpdCBpcyBh
IHNsaWdodGx5IHVudXN1YWwgY29udmVudGlvbiBmb3Iga2VybmVsIGNvZGUsDQo+Pj4+PiBJIGJl
bGlldmUgdGhlIGludGVudGlvbiBpcyB0aGF0IHRoaXMgZnVuY3Rpb24gcmV0dXJucyAwIHdoZW4N
Cj4+Pj4+IGl0IGZhaWxzICh0byBwYXJzZSkgYW5kIDEgb24gc3VjY2Vzcy4gU28gSSB0aGluayB0
aGF0IHBhcnQgaXMgZmluZS4NCj4+Pj4+DQo+Pj4+PiBXaGF0IHNlZW1zIGEgYml0IGJyb2tlbiBp
cyB0aGUgd2F5IHRoYXQgY2FsbGVycyB1c2UgdGhlIHJldHVybiB2YWx1ZS4NCj4+Pj4+DQo+Pj4+
PiAxLiBUaGUgY2FsbCBpbiBwcm9jZXNzX3JlZ2lzdGVyX3Jlc3BvbnNlKCkgbG9va3MgbGlrZSB0
aGlzOg0KPj4+Pj4NCj4+Pj4+IAlyZXQgPSBjdF9zaXBfcGFyc2VfbnVtZXJpY2FsX3BhcmFtKC4u
LikNCj4+Pj4+IAlpZiAocmV0IDwgMCkgew0KPj4+Pj4gCQluZl9jdF9oZWxwZXJfbG9nKHNrYiwg
Y3QsICJjYW5ub3QgcGFyc2UgZXhwaXJlcyIpOw0KPj4+Pj4gCQlyZXR1cm4gTkZfRFJPUDsNCj4+
Pj4+IAl9DQo+Pj4+Pg0KPj4+Pj4gICAgICAgIEJ1dCByZXQgY2FuIG9ubHkgYmUgMCBvciAxLCBz
byB0aGUgZXJyb3IgaGFuZGxpbmcgaXMgbmV2ZXIgaW5va2VkLA0KPj4+Pj4gICAgICAgIGFuZCBh
IGZhaWx1cmUgdG8gcGFyc2UgaXMgaWdub3JlZC4gSSBndWVzcyBmYWlsdXJlIGRvZXNuJ3Qgb2Nj
dXIgaW4NCj4+Pj4+ICAgICAgICBwcmFjdGljZS4NCj4+Pj4+DQo+Pj4+PiAgICAgICAgSSBzdXNw
ZWN0IHRoaXMgc2hvdWxkIGJlOg0KPj4+Pj4NCj4+Pj4+IAlyZXQgPSBjdF9zaXBfcGFyc2VfbnVt
ZXJpY2FsX3BhcmFtKC4uLikNCj4+Pj4+IAlpZiAoIXJldCkgew0KPj4+Pj4gCQluZl9jdF9oZWxw
ZXJfbG9nKHNrYiwgY3QsICJjYW5ub3QgcGFyc2UgZXhwaXJlcyIpOw0KPj4+Pj4gCQlyZXR1cm4g
TkZfRFJPUDsNCj4+Pj4+IAl9DQo+Pj4+Pg0KPj4+Pg0KPj4+PiBjdF9zaXBfcGFyc2VfbnVtZXJp
Y2FsX3BhcmFtKCkgcmV0dXJucyAwIGluIHRvIGNhc2VzIDEpIHdoZW4gdGhlDQo+Pj4+IHBhcmFt
ZXRlciAnZXhwaXJlcz0nIGlzbid0IGZvdW5kIGluIHRoZSBoZWFkZXIgb3IgMikgaXQncyBpbmNv
cnJlY3RseSBzZXQuDQo+Pj4+IEluIHRoZSBmaXJzdCBjYXNlLCB0aGUgcmV0dXJuIHZhbHVlIHNo
b3VsZCBiZSBpZ25vcmVkLCBzaW5jZSB0aGlzIGlzIGENCj4+Pj4gbm9ybWFsIHNpdHVhdGlvbg0K
Pj4+PiBJbiB0aGUgc2Vjb25kIGNhc2UsIGl0J3MgYmV0dGVyIHRvIHdyaXRlIHRvIHRoZSBsb2cg
YW5kIHJldHVybiBORl9EUk9QLA0KPj4+PiBvciBpZ25vcmUgaXQgdG9vLCB0aGVuIGNoZWNraW5n
IHRoZSByZXR1cm4gdmFsdWUgY2FuIGJlIHJlbW92ZWQgYXMNCj4+Pj4gdW5uZWNlc3NhcnkuDQo+
Pj4NCj4+PiBTb3JyeSwgSSB0aGluayBJIG1pc3VuZGVyc3Rvb2QgdGhlIGludGVudGlvbiBvZiB5
b3VyIHBhdGNoIGVhcmxpZXIuDQo+Pj4NCj4+PiBEbyBJIChub3cpIHVuZGVyc3RhbmQgY29ycmVj
dGx5IHRoYXQgeW91IGFyZSBwcm9wb3NpbmcgYSB0cmlzdGF0ZT8NCj4+Pg0KPj4+IGEpIHJldHVy
biAxIGlmIHZhbHVlIGlzIGZvdW5kOyAqdmFsIGlzIHNldA0KPj4+IGIpIHJldHVybiAwIGlmIHZh
bHVlIGlzIG5vdCBmb3VuZDsgKnZhbCBpcyB1bmNoYW5nZWQNCj4+PiBjKSByZXR1cm4gLTEgb24g
ZXJyb3I7ICp2YWwgaXMgdW5kZWZpbmVkDQo+Pg0KPj4gWWVzLCBpdCBzZWVtcyB0byBtZSB0aGF0
IHRoaXMgd2FzIG9yaWdpbmFsbHkgaW50ZW5kZWQuDQo+IA0KPiBUaGFua3MuIFdpdGggbXkgbmV3
IGZvdW5kIHVuZGVyc3RhbmRpbmcsIHRoaXMgbG9va3MgZ29vZCB0byBtZS4NCj4gDQo+IFJldmll
d2VkLWJ5OiBTaW1vbiBIb3JtYW4gPHNpbW9uLmhvcm1hbkBjb3JpZ2luZS5jb20+DQo+IA0KDQpI
aSwgU2ltb24uDQpJJ20gc29ycnkgdG8gYm90aGVyIHlvdS4NCldpbGwgdGhpcyBwYXRjaCBiZSBh
cHBsaWVkIG9yIHJlamVjdGVkPw0KDQrQkmVzdCByZWdhcmRzLCBJbHlhLg0KDQoNCg==
