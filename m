Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED9563D500
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbiK3LwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbiK3LwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:52:04 -0500
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E78613E0B9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:52:00 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,206,1665417600"; 
   d="scan'208";a="39636949"
Received: from hk-mbx12.mioffice.cn (HELO xiaomi.com) ([10.56.21.122])
  by outboundhk.mxmail.xiaomi.com with ESMTP; 30 Nov 2022 19:51:59 +0800
Received: from yz-mbx01.mioffice.cn (10.237.88.121) by HK-MBX12.mioffice.cn
 (10.56.21.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 30 Nov
 2022 19:51:59 +0800
Received: from BJ-MBX04.mioffice.cn (10.237.8.124) by yz-mbx01.mioffice.cn
 (10.237.88.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 30 Nov
 2022 19:51:58 +0800
Received: from BJ-MBX04.mioffice.cn ([fe80::44a0:4515:f68b:f8b1]) by
 BJ-MBX04.mioffice.cn ([fe80::44a0:4515:f68b:f8b1%18]) with mapi id
 15.02.0986.036; Wed, 30 Nov 2022 19:51:58 +0800
From:   =?utf-8?B?RGF2aWQgV2FuZyDnjovmoIc=?= <wangbiao3@xiaomi.com>
To:     Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_wenjieli@quicinc.com" <quic_wenjieli@quicinc.com>,
        =?utf-8?B?6ZmI5rW35Y2O?= <chenhaihua@xiaomi.com>,
        =?utf-8?B?5p2o5YGl6b6Z?= <yangjianlong@xiaomi.com>,
        =?utf-8?B?5YiY5re75aiB?= <liutianwei@xiaomi.com>,
        =?utf-8?B?6ams5oyv5Y2O?= <mazhenhua@xiaomi.com>,
        =?utf-8?B?VGluZzExIFdhbmcg546L5am3?= <wangting11@xiaomi.com>
Subject: =?utf-8?B?562U5aSNOiBbRXh0ZXJuYWwgTWFpbF1SZTogW1BBVENILXRpcCB2NF0gc2No?=
 =?utf-8?B?ZWQ6IEZpeCBOVUxMIHVzZXJfY3B1c19wdHIgY2hlY2sgaW4gZHVwX3VzZXJf?=
 =?utf-8?Q?cpus=5Fptr()?=
Thread-Topic: [External Mail]Re: [PATCH-tip v4] sched: Fix NULL user_cpus_ptr
 check in dup_user_cpus_ptr()
Thread-Index: AQHZAsrXDaXvDeP620qPLKMZKe2la65TtjsAgAA1kACAAYB7gIAAF7SAgAAHBwCAAAGSgIABzj4Q
Date:   Wed, 30 Nov 2022 11:51:58 +0000
Message-ID: <8ce41c4d972b44e4b7faddccadaa59e7@xiaomi.com>
References: <20221125023943.1118603-1-longman@redhat.com>
 <92b99a5e-1588-4e08-a652-72e9c51421cf@redhat.com>
 <20221128120008.GA25090@willie-the-truck>
 <d49a78bb-dce1-92b1-0f67-d71259609263@redhat.com>
 <20221129140759.GA26437@willie-the-truck>
 <f669ce38-1e23-04b4-fe6f-591579e817de@redhat.com>
 <20221129155757.GC26561@willie-the-truck>
 <4e93019d-4b19-14f9-14d7-da43456d3546@redhat.com>
In-Reply-To: <4e93019d-4b19-14f9-14d7-da43456d3546@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.237.8.11]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,SPF_HELO_SOFTFAIL,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBXaWxsLCAgTG9uZ21hbiwNCg0KQ291bGQgd2UgZml4IHRoZSBpc3N1ZSBmaXJzdCB3ZSBt
ZXQ/ICBXZSBjYW4gYW5hbHl6ZSBvdGhlciBpc3N1ZSBsYXRlci4NCg0KVGhhbmtzDQoNCg0KLS0t
LS3pgq7ku7bljp/ku7YtLS0tLQ0K5Y+R5Lu25Lq6OiBXYWltYW4gTG9uZyA8bG9uZ21hbkByZWRo
YXQuY29tPg0K5Y+R6YCB5pe26Ze0OiAyMDIy5bm0MTHmnIgzMOaXpSAwOjA0DQrmlLbku7bkuro6
IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+DQrmioTpgIE6IEluZ28gTW9sbmFyIDxtaW5n
b0ByZWRoYXQuY29tPjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPjsgSnVy
aSBMZWxsaSA8anVyaS5sZWxsaUByZWRoYXQuY29tPjsgVmluY2VudCBHdWl0dG90IDx2aW5jZW50
Lmd1aXR0b3RAbGluYXJvLm9yZz47IERpZXRtYXIgRWdnZW1hbm4gPGRpZXRtYXIuZWdnZW1hbm5A
YXJtLmNvbT47IFN0ZXZlbiBSb3N0ZWR0IDxyb3N0ZWR0QGdvb2RtaXMub3JnPjsgQmVuIFNlZ2Fs
bCA8YnNlZ2FsbEBnb29nbGUuY29tPjsgTWVsIEdvcm1hbiA8bWdvcm1hbkBzdXNlLmRlPjsgRGFu
aWVsIEJyaXN0b3QgZGUgT2xpdmVpcmEgPGJyaXN0b3RAcmVkaGF0LmNvbT47IFBoaWwgQXVsZCA8
cGF1bGRAcmVkaGF0LmNvbT47IFdlbmppZSBMaSA8d2VuamllbGlAcXRpLnF1YWxjb21tLmNvbT47
IERhdmlkIFdhbmcg546L5qCHIDx3YW5nYmlhbzNAeGlhb21pLmNvbT47IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNCuS4u+mimDogW0V4dGVybmFsIE1haWxdUmU6IFtQQVRDSC10aXAgdjRd
IHNjaGVkOiBGaXggTlVMTCB1c2VyX2NwdXNfcHRyIGNoZWNrIGluIGR1cF91c2VyX2NwdXNfcHRy
KCkNCg0KW+WklumDqOmCruS7tl0g5q2k6YKu5Lu25p2l5rqQ5LqO5bCP57Gz5YWs5Y+45aSW6YOo
77yM6K+36LCo5oWO5aSE55CG44CC6Iul5a+56YKu5Lu25a6J5YWo5oCn5a2Y55aR77yM6K+35bCG
6YKu5Lu26L2s5Y+R57uZbWlzZWNAeGlhb21pLmNvbei/m+ihjOWPjemmiA0KDQpPbiAxMS8yOS8y
MiAxMDo1NywgV2lsbCBEZWFjb24gd3JvdGU6DQo+IE9uIFR1ZSwgTm92IDI5LCAyMDIyIGF0IDEw
OjMyOjQ5QU0gLTA1MDAsIFdhaW1hbiBMb25nIHdyb3RlOg0KPj4gT24gMTEvMjkvMjIgMDk6MDcs
IFdpbGwgRGVhY29uIHdyb3RlOg0KPj4+IE9uIE1vbiwgTm92IDI4LCAyMDIyIGF0IDEwOjExOjUy
QU0gLTA1MDAsIFdhaW1hbiBMb25nIHdyb3RlOg0KPj4+PiBPbiAxMS8yOC8yMiAwNzowMCwgV2ls
bCBEZWFjb24gd3JvdGU6DQo+Pj4+PiBPbiBTdW4sIE5vdiAyNywgMjAyMiBhdCAwODo0MzoyN1BN
IC0wNTAwLCBXYWltYW4gTG9uZyB3cm90ZToNCj4+Pj4+PiBPbiAxMS8yNC8yMiAyMTozOSwgV2Fp
bWFuIExvbmcgd3JvdGU6DQo+Pj4+Pj4+IEluIGdlbmVyYWwsIGEgbm9uLW51bGwgdXNlcl9jcHVz
X3B0ciB3aWxsIHJlbWFpbiBzZXQgdW50aWwgdGhlIHRhc2sgZGllcy4NCj4+Pj4+Pj4gQSBwb3Nz
aWJsZSBleGNlcHRpb24gdG8gdGhpcyBpcyB0aGUgZmFjdCB0aGF0DQo+Pj4+Pj4+IGRvX3NldF9j
cHVzX2FsbG93ZWQoKSB3aWxsIGNsZWFyIGEgbm9uLW51bGwgdXNlcl9jcHVzX3B0ci4gVG8NCj4+
Pj4+Pj4gYWxsb3cgdGhpcyBwb3NzaWJsZSByYWNpbmcgY29uZGl0aW9uLCB3ZSBuZWVkIHRvIGNo
ZWNrIGZvciBOVUxMDQo+Pj4+Pj4+IHVzZXJfY3B1c19wdHIgdW5kZXIgdGhlIHBpX2xvY2sgYmVm
b3JlIGR1cGluZyB0aGUgdXNlciBtYXNrLg0KPj4+Pj4+Pg0KPj4+Pj4+PiBGaXhlczogODUxYTcy
M2U0NWQxICgic2NoZWQ6IEFsd2F5cyBjbGVhciB1c2VyX2NwdXNfcHRyIGluDQo+Pj4+Pj4+IGRv
X3NldF9jcHVzX2FsbG93ZWQoKSIpDQo+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFdhaW1hbiBMb25n
IDxsb25nbWFuQHJlZGhhdC5jb20+DQo+Pj4+Pj4gVGhpcyBpcyBhY3R1YWxseSBhIHByZS1leGlz
dGluZyB1c2UtYWZ0ZXItZnJlZSBidWcgc2luY2UgY29tbWl0DQo+Pj4+Pj4gMDdlYzc3YTFkNGU4
DQo+Pj4+Pj4gKCJzY2hlZDogQWxsb3cgdGFzayBDUFUgYWZmaW5pdHkgdG8gYmUgcmVzdHJpY3Rl
ZCBvbiBhc3ltbWV0cmljIHN5c3RlbXMiKS4NCj4+Pj4+PiBTbyBpdCBuZWVkcyB0byBiZSBmaXhl
ZCBpbiB0aGUgc3RhYmxlIHJlbGVhc2UgYXMgd2VsbC4gV2lsbA0KPj4+Pj4+IHJlc2VuZCB0aGUg
cGF0Y2ggd2l0aCBhbiBhZGRpdGlvbmFsIGZpeGVzIHRhZyBhbmQgdXBkYXRlZCBjb21taXQgbG9n
Lg0KPj4+Pj4gUGxlYXNlIGNhbiB5b3UgZWxhYm9yYXRlIG9uIHRoZSB1c2UtYWZ0ZXItZnJlZSBo
ZXJlPyBMb29raW5nIGF0DQo+Pj4+PiAwN2VjNzdhMWQ0ZTgsIHRoZSBtYXNrIGlzIG9ubHkgZnJl
ZWQgaW4gZnJlZV90YXNrKCkgd2hlbiB0aGUgdXNhZ2UNCj4+Pj4+IHJlZmNvdW50IGhhcyBkcm9w
cGVkIHRvIHplcm8gYW5kIEkgY2FuJ3Qgc2VlIGhvdyB0aGF0IGNhbiByYWNlIHdpdGggZm9yaygp
Lg0KPj4+Pj4NCj4+Pj4+IFdoYXQgYW0gSSBtaXNzaW5nPw0KPj4+PiBJIG1pc3NlZCB0aGF0IGF0
IGZpcnN0LiBUaGUgY3VycmVudCB0YXNrIGNsb25pbmcgcHJvY2VzcyBjb3BpZXMgdGhlDQo+Pj4+
IGNvbnRlbnQgb2YgdGhlIHRhc2sgc3RydWN0dXJlIG92ZXIgdG8gdGhlIG5ld2x5IGNsb25lZC9m
b3JrZWQgdGFzay4NCj4+Pj4gSU9XLCBpZiB1c2VyX2NwdXNfcHRyIGhhZCBiZWVuIHNldCB1cCBw
cmV2aW91c2x5LCBpdCB3aWxsIGJlIGNvcGllZA0KPj4+PiBvdmVyIHRvIHRoZSBjbG9uZWQgdGFz
ay4gTm93IGlmIHVzZXJfY3B1c19wdHIgb2YgdGhlIHNvdXJjZSB0YXNrIGlzDQo+Pj4+IGNsZWFy
ZWQgcmlnaHQgYWZ0ZXIgdGhhdCBhbmQgYmVmb3JlIGR1cF91c2VyX2NwdXNfcHRyKCkgaXMgY2Fs
bGVkLg0KPj4+PiBUaGUgb2Jzb2xldGUgdXNlcl9jcHVzX3B0ciB2YWx1ZSBpbiB0aGUgY2xvbmVk
IHRhc2sgd2lsbCByZW1haW4gYW5kIGdldCB1c2VkIGV2ZW4gaWYgaXQgaGFzIGJlZW4gZnJlZWQu
DQo+Pj4+IFRoYXQgaXMgd2hhdCBJIGNhbGwgYXMgdXNlLWFmdGVyLWZyZWUgYW5kIGRvdWJsZS1m
cmVlLg0KPj4+IElmIHRoZSBwYXJlbnQgdGFzayBjYW4gYmUgbW9kaWZpZWQgY29uY3VycmVudGx5
IHdpdGgNCj4+PiBkdXBfdGFza19zdHJ1Y3QoKSB0aGVuIHN1cmVseSB3ZSdkIGhhdmUgYmlnZ2Vy
IGlzc3VlcyBiZWNhdXNlIHRoYXQncw0KPj4+IG5vdCBnb2luZyB0byBiZSBhdG9taWM/IEF0IHRo
ZSB2ZXJ5IGxlYXN0IHdlJ2QgaGF2ZSBhIGRhdGEgcmFjZSwgYnV0DQo+Pj4gaXQgYWxzbyBmZWVs
cyBsaWtlIHdlIGNvdWxkIGVuZCB1cCB3aXRoIGluY29uc2lzdGVudCB0YXNrIHN0YXRlIGluDQo+
Pj4gdGhlIGNoaWxkLiBJbiBmYWN0LCBjb3VsZG4ndCB0aGUgbm9ybWFsICdjcHVzX21hc2snIGJl
IGNvcnJ1cHRlZCBieSBhIGNvbmN1cnJlbnQgc2V0X2NwdXNfYWxsb3dlZF9jb21tb24oKT8NCj4+
Pg0KPj4+IE9yIGFtIEkgc3RpbGwgZmFpbGluZyB0byB1bmRlcnN0YW5kIHRoZSByYWNlPw0KPj4+
DQo+PiBBIG1ham9yIGRpZmZlcmVuY2UgYmV0d2VlbiBjcHVzX21hc2sgYW5kIHVzZXJfY3B1c19w
dHIgaXMgdGhhdCBmb3INCj4+IGNwdXNfbWFzaywgdGhlIGJpdG1hcCBpcyBlbWJlZGRlZCBpbnRv
IHRhc2tfc3RydWN0IHdoZXJlYXMNCj4+IHVzZXJfY3B1c19wdHIgaXMgYSBwb2ludGVyIHRvIGFu
IGV4dGVybmFsIGJpdG1hcC4gU28gdGhlcmUgaXMgbm8NCj4+IGlzc3VlIG9mIHVzZS1hZnRlci1m
cmVlIHdydCBjcHVzX21hc2suIFRoYXQgaXMgbm90IHRoZSBjYXNlIHdoZXJlIHRoZQ0KPj4gbWVt
b3J5IG9mIHRoZSB1c2VyX2NwdXNfcHRyIG9mIHRoZSBwYXJlbnQgdGFzayBpcyBmcmVlZCwgYnV0
IHRoZW4gYQ0KPj4gcmVmZXJlbmNlIHRvIHRoYXQgbWVtb3J5IGlzIHN0aWxsIGF2YWlsYWJsZSBp
biB0aGUgY2hpbGQncyB0YXNrIHN0cnVjdCBhbmQgbWF5IGJlIHVzZWQuDQo+IFN1cmUsIEknbSBu
b3Qgc2F5aW5nIHRoZXJlJ3MgYSBVQUYgb24gY3B1c19tYXNrLCBidXQgSSdtIGNvbmNlcm5lZA0K
PiB0aGF0IHdlIGNvdWxkIGNvcnJ1cHQgdGhlIGRhdGEgYW5kIGVuZCB1cCB3aXRoIGFuIGFmZmlu
aXR5IG1hc2sgdGhhdA0KPiBkb2Vzbid0IGNvcnJlc3BvbmQgdG8gYW55dGhpbmcgbWVhbmluZ2Z1
bC4gRG8geW91IGFncmVlIHRoYXQncyBwb3NzaWJsZT8NClRoYXQgaXMgY2VydGFpbmx5IHBvc3Np
YmxlLiBTbyB3ZSBoYXZlIHRvIGJlIGNhcmVmdWwgYWJvdXQgaXQuDQo+DQo+PiBOb3RlIHRoYXQg
dGhlIHByb2JsZW1hdGljIGNvbmN1cnJlbmNlIGlzIG5vdCBiZXR3ZWVuIHRoZSBjb3B5aW5nIG9m
DQo+PiB0YXNrIHN0cnVjdCBhbmQgY2hhbmdpbmcgb2YgdGhlIHRhc2sgc3RydWN0LiBJdCBpcyB3
aGF0IHdpbGwgaGFwcGVuDQo+PiBhZnRlciB0aGUgdGFzayBzdHJ1Y3QgY29weWluZyBoYXMgYWxy
ZWFkeSBiZWVuIGRvbmUgd2l0aCBhbiBleHRyYQ0KPj4gcmVmZXJlbmNlIHByZXNlbnQgaW4gdGhl
IGNoaWxkJ3MgdGFzayBzdHJ1Y3QuDQo+IFdlbGwsIHNvcnQgb2YsIGJ1dCB0aGUgY2hpbGQgb25s
eSBoYXMgdGhlIGV4dHJhIHJlZmVyZW5jZSBfYmVjYXVzZV8NCj4gdGhlIHBhcmVudCBwb2ludGVy
IHdhcyBjb25jdXJyZW50bHkgY2xlYXJlZCB0byBOVUxMLCBvdGhlcndpc2UNCj4gZHVwX3VzZXJf
Y3B1c19wdHIoKSB3b3VsZCBoYXZlIGFsbG9jYXRlZCBhIG5ldyBjb3B5IGFuZCB3ZSdkIGJlIG9r
LCBubz8NClllcywgdGhhdCBpcyBleGFjdGx5IHdoZXJlIHRoZSBwcm9ibGVtIGlzIGFuZCB0aGlz
IGlzIHdoYXQgbXkgcGF0Y2ggaXMgdHJ5aW5nIHRvIGZpeC4NCj4NCj4gT3ZlcmFsbCwgSSdtIGp1
c3QgdmVyeSB3YXJ5IHRoYXQgd2Ugc2VlbSB0byBiZSBzYXlpbmcgdGhhdA0KPiBjb3B5X3Byb2Nl
c3MoKSBjYW4gcnVuIGNvbmN1cnJlbnRseSB3aXRoIGNoYW5nZXMgdG8gdGhlIHBhcmVudC4gTWF5
YmUNCj4gaXQncyBhbGwgYmVlbiB3cml0dGVuIHdpdGggdGhhdCBpbiBtaW5kaSAoaW5jbHVkaW5n
IGFsbCB0aGUgYXJjaA0KPiBjYWxsYmFja3MpLCBidXQgSSdkIGJlIGFzdG9uaXNoZWQgaWYgdGhp
cyBpcyB0aGUgb25seSBwcm9ibGVtIGluIHRoZXJlLg0KDQpJdCBzZWVtcyBsaWtlIHRoYXQsIGF0
IGxlYXN0IGluIHNvbWUgY2FzZXMsIHRoZSBjbGVhcmluZyBvZiBhIHRhc2sncyB1c2VyX2NwdXNf
cHRyIGNhbiBiZSBkb25lIGJ5IGFub3RoZXIgdGFzay4gU28gdGhlIHBhcmVudCBtYXkgYmUgdW5h
d2FyZSBvZiBpdCBhbmQgc28gaXMgbm90IGl0cyBmYXVsdC4NCg0KQ2hlZXJzLA0KTG9uZ21hbg0K
DQojLyoqKioqKuacrOmCruS7tuWPiuWFtumZhOS7tuWQq+acieWwj+exs+WFrOWPuOeahOS/neWv
huS/oeaBr++8jOS7hemZkOS6juWPkemAgee7meS4iumdouWcsOWdgOS4reWIl+WHuueahOS4quS6
uuaIlue+pOe7hOOAguemgeatouS7u+S9leWFtuS7luS6uuS7peS7u+S9leW9ouW8j+S9v+eUqO+8
iOWMheaLrOS9huS4jemZkOS6juWFqOmDqOaIlumDqOWIhuWcsOazhOmcsuOAgeWkjeWItuOAgeaI
luaVo+WPke+8ieacrOmCruS7tuS4reeahOS/oeaBr+OAguWmguaenOaCqOmUmeaUtuS6huacrOmC
ruS7tu+8jOivt+aCqOeri+WNs+eUteivneaIlumCruS7tumAmuefpeWPkeS7tuS6uuW5tuWIoOmZ
pOacrOmCruS7tu+8gSBUaGlzIGUtbWFpbCBhbmQgaXRzIGF0dGFjaG1lbnRzIGNvbnRhaW4gY29u
ZmlkZW50aWFsIGluZm9ybWF0aW9uIGZyb20gWElBT01JLCB3aGljaCBpcyBpbnRlbmRlZCBvbmx5
IGZvciB0aGUgcGVyc29uIG9yIGVudGl0eSB3aG9zZSBhZGRyZXNzIGlzIGxpc3RlZCBhYm92ZS4g
QW55IHVzZSBvZiB0aGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGhlcmVpbiBpbiBhbnkgd2F5IChp
bmNsdWRpbmcsIGJ1dCBub3QgbGltaXRlZCB0bywgdG90YWwgb3IgcGFydGlhbCBkaXNjbG9zdXJl
LCByZXByb2R1Y3Rpb24sIG9yIGRpc3NlbWluYXRpb24pIGJ5IHBlcnNvbnMgb3RoZXIgdGhhbiB0
aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpIGlzIHByb2hpYml0ZWQuIElmIHlvdSByZWNlaXZlIHRo
aXMgZS1tYWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkgcGhvbmUgb3Ig
ZW1haWwgaW1tZWRpYXRlbHkgYW5kIGRlbGV0ZSBpdCEqKioqKiovIw0K
