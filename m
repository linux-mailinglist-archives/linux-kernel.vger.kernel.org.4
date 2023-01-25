Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53AB67BB82
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 20:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236014AbjAYT6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 14:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235646AbjAYT6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 14:58:05 -0500
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBC13C36
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 11:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1674676666; x=1706212666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=dTGhMjxl/MBiucl9G+MvBBfDV9C4XxGVHQBHc71kpcA=;
  b=PPlrHBaA6a0InPzRBJIdp3dW1In23YwqkQi7WNktaEFZYWFq1HteURxY
   0m75AQS1lnQBedwcytdi98xXalxwguq5xyC70bBaluWyDEdfTn70MGPpX
   /a8F95OPVs42rFeDDPLfEYYKmSwM7uCf51FAoG64anpWk201nqxXLVbj6
   8=;
X-IronPort-AV: E=Sophos;i="5.97,246,1669075200"; 
   d="scan'208";a="304272292"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 19:57:20 +0000
Received: from EX13D41EUC003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com (Postfix) with ESMTPS id C115082031;
        Wed, 25 Jan 2023 19:57:18 +0000 (UTC)
Received: from EX19D033EUC004.ant.amazon.com (10.252.61.133) by
 EX13D41EUC003.ant.amazon.com (10.43.164.188) with Microsoft SMTP Server (TLS)
 id 15.0.1497.45; Wed, 25 Jan 2023 19:57:17 +0000
Received: from u40bc5e070a0153.ant.amazon.com (10.43.161.198) by
 EX19D033EUC004.ant.amazon.com (10.252.61.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.7; Wed, 25 Jan 2023 19:57:12 +0000
Date:   Wed, 25 Jan 2023 20:57:07 +0100
From:   Roman Kagan <rkagan@amazon.de>
To:     Zhang Qiao <zhangqiao22@huawei.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [bug-report] possible s64 overflow in max_vruntime()
Message-ID: <Y9GJk65CxNjwQXoK@u40bc5e070a0153.ant.amazon.com>
Mail-Followup-To: Roman Kagan <rkagan@amazon.de>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
References: <73e639d5-702b-0d03-16d9-a965b1963ef6@huawei.com>
 <Y6RRfF5yRew7rdCp@hirez.programming.kicks-ass.net>
 <df6135b6-7710-2fec-baea-4eaa5c63bf28@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <df6135b6-7710-2fec-baea-4eaa5c63bf28@huawei.com>
X-Originating-IP: [10.43.161.198]
X-ClientProxiedBy: EX13D32UWB002.ant.amazon.com (10.43.161.139) To
 EX19D033EUC004.ant.amazon.com (10.252.61.133)
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBEZWMgMjMsIDIwMjIgYXQgMDk6NTc6MzNQTSArMDgwMCwgWmhhbmcgUWlhbyB3cm90
ZToKPiDlnKggMjAyMi8xMi8yMiAyMDo0NSwgUGV0ZXIgWmlqbHN0cmEg5YaZ6YGTOgo+ID4gT24g
V2VkLCBEZWMgMjEsIDIwMjIgYXQgMTE6MTk6MzFQTSArMDgwMCwgWmhhbmcgUWlhbyB3cm90ZToK
PiA+PiBoaSBmb2xrcywKPiA+Pgo+ID4+ICAgICBJIGZvdW5kIHByb2JsZW0gYWJvdXQgczY0IG92
ZXJmbG93IGluIG1heF92cnVudGltZSgpLgo+ID4+Cj4gPj4gICAgIEkgY3JlYXRlIGEgdGFzayBn
cm91cCBHUk9VUEEgKHBhdGg6IC9zeXN0ZW0uc2xpY2UveHh4L3l5eS9DR1JPVVBBKSBhbmQgcnVu
IGEgdGFzayBpbiB0aGlzCj4gPj4gZ3JvdXAgb24gZWFjaCBjcHUsIHRoZXNlIHRhc2tzIGlzIHdo
aWxlIGxvb3AgYW5kIDEwMCUgY3B1IHVzYWdlLgo+ID4+Cj4gPj4gICAgIFdoZW4gdW5yZWdpc3Rl
ciBuZXQgZGV2aWNlcywgd2lsbCBxdWV1ZSBhIGt3b3JrIG9uIHN5c3RlbV9oaWdocHJpX3dxIGF0
IGZsdXNoX2FsbF9iYWNrbG9ncygpCj4gPj4gYW5kIHdha2UgdXAgYSBoaWdoLXByaW9yaXR5IGt3
b3JrZXIgdGhyZWFkIG9uIGVhY2ggY3B1LiBIb3dldmVyLCB0aGUga3dvcmtlciB0aHJlYWQgaGFz
IGJlZW4KPiA+PiB3YWl0aW5nIG9uIHRoZSBxdWV1ZSBhbmQgaGFzIG5vdCBiZWVuIHNjaGVkdWxl
ZC4KPiA+Pgo+ID4+ICAgICBBZnRlciBwYXJzaW5nIHRoZSB2bWNvcmUsIHRoZSB2cnVudGltZSBv
ZiB0aGUga3dvcmtlciBpcyAweDkxOGZkYjA1Mjg3ZGE3YzMgYW5kIHRoZQo+ID4+IGNmc19ycS0+
bWluX3ZydW50aW1lIGlzIDB4MTI0YjE3ZmQ1OWRiOGQwMi4KPiA+Pgo+ID4+ICAgICB3aHkgdGhl
IGRpZmZlcmVuY2UgYmV0d2VlbiB0aGUgY2ZzX3JxLT5taW5fdnJ1bnRpbWUgYW5kIGt3b3JrZXIn
cyB2cnVudGltZSBpcyBzbyBsYXJnZT8KPiA+PiAgICAgMSkgdGhlIGt3b3JrZXIgb2YgdGhlIHN5
c3RlbV9oaWdocHJpX3dxIHNsZWVwIGZvciBsb25nIGxvbmcgdGltZShhYm91dCAzMDAgZGF5cyku
Cj4gPj4gICAgIDIpIGNmc19ycS0+Y3VyciBpcyB0aGUgYW5jZXN0b3Igb2YgdGhlIEdST1VQQSwg
Y2ZzLT5jdXJyLT5sb2FkLndlaWdodCBpcyAyNDk0LCBzbyB3aGVuCj4gPj4gdGhlIHRhc2sgYmVs
b25naW5nIHRvIHRoZSBHUk9VUEEgcnVuIGZvciBhIGxvbmcgdGltZSwgaXRzIHZydW50aW1lIHdp
bGwgaW5jcmVhc2UgYnkgNDIwCj4gPj4gdGltZXMsIGNmc19ycS0+bWluX3ZydW50aW1lIHdpbGwg
YWxzbyBncm93IHJhcGlkbHkuCj4gPj4gICAgIDMpIHdoZW4gd2FrZXVwIGt3b3JrZXIgdGhyZWFk
LCBrd29ya2VyIHdpbGwgYmUgc2V0IHRoZSBtYXhpbXVtIHZhbHVlIGJldHdlZW4ga3dvcmtlcidz
Cj4gPj4gdnJ1bnRpbWUgYW5kIGNmc19ycS0+bWluX3ZydW50aW1lLiBCdXQgYXQgbWF4X3ZydW50
aW1lKCksIHRoZXJlIHdpbGwgYmUgYSBzNjQgb3ZlcmZsb3cgaXNzdWUsCj4gPj4gYXMgZm9sbG93
Ogo+ID4+Cj4gPj4gLS0tLS0tLS0tCj4gPj4KPiA+PiBzdGF0aWMgaW5saW5lIHU2NCBtaW5fdnJ1
bnRpbWUodTY0IG1pbl92cnVudGltZSwgdTY0IHZydW50aW1lKQo+ID4+IHsKPiA+PiAJLyoKPiA+
PiAJICogdnJ1bnRpbWU9MHgxMjRiMTdmZDU5ZGI4ZDAyCj4gPj4gCSAqIG1pbl92cnVudGltZT0w
eDkxOGZkYjA1Mjg3ZGE3YzMKPiA+PiAJICogdnJ1bnRpbWUgLSBtaW5fdnJ1bnRpbWUgPSA5Mjc2
MDc0ODk0MTc3NDYxNTY3ID4gczY0X21heCwgd2lsbCBzNjQgb3ZlcmZsb3cKPiA+PiAJICovCj4g
Pj4gCXM2NCBkZWx0YSA9IChzNjQpKHZydW50aW1lIC0gbWluX3ZydW50aW1lKTsKPiA+PiAJaWYg
KGRlbHRhIDwgMCkKPiA+PiAJCW1pbl92cnVudGltZSA9IHZydW50aW1lOwo+ID4+Cj4gPj4gCXJl
dHVybiBtaW5fdnJ1bnRpbWU7Cj4gPj4gfQo+ID4+Cj4gPj4gLS0tLS0tLS0tLQo+ID4+Cj4gPj4g
bWF4X3ZydW50aW1lKCkgd2lsbCByZXR1cm4gdGhlIGt3b3JrZXIncyBvbGQgdnJ1bnRpbWUsIGl0
IGlzIGluY29ycmVjdCBhbmQgdGhlIGNvcnJlY3QgcmVzdWx0Cj4gPj4gc2hvdWQgYmUgY2ZzX3Jx
LT5taW52cnVudGltZS4gVGhpcyBpbmNvcnJlY3QgcmVzdWx0IGlzIGdyZWF0ZXIgdGhhbiBjZnNf
cnEtPm1pbl92cnVudGltZSBhbmQKPiA+PiB3aWxsIGNhdXNlIGt3b3JrZXIgdGhyZWFkIHN0YXJ2
ZWQuCj4gPj4KPiA+PiAgICAgRG9lcyBhbnlvbmUgaGF2ZSBhIGdvb2Qgc3VnZ2VzdGlvbiBmb3Ig
c2xvdmUgdGhpcyBwcm9ibGVtPyBvciBidWdmaXggcGF0Y2guCj4gPiAKPiA+IEkgZG9uJ3QgdW5k
ZXJzdGFuZCB3aGF0IHlvdSB0aWhuayB0aGUgcHJvYmxlbSBpcy4gU2lnbmVkIG92ZXJmbG93IGlz
Cj4gPiBwZXJmZWN0bHkgZmluZSBhbmQgd29ya3MgYXMgZGVzaWduZWQgaGVyZS4KPiAKPiBoaSwg
UGV0ZXIgYW5kIFdhaW1hbiwKPiAKPiBUaGlzIHByb2JsZW0gb2NjdXJzIGluIHRoZSBwcm9kdWN0
aW9uIGVudmlyb25tZW50IHRoYXQgZGVwbG95IHNvbWUgZHBkayBzZXJ2aWNlcy4gV2hlbiB0aGlz
IHByb2JlbG0KPiBvY2N1cnMsIHRoZSBzeXN0ZW0gd2lsbCBiZSB1bmF2YWlsYWJsZShmb3IgZXhh
bXBsZSwgbWFueSBjb21tYW5kcyBhYm91dCBuZXR3b3JrIHdpbGwgYmUgc3R1Y2sp77yMc28KPiBp
IHRoaW5rIGl0J3MgYSBwcm9ibGVtLgo+IAo+IEJlY2F1c2UgbW9zdCBuZXR3b3JrIGNvbW1hbmRz
KHN1Y2ggYXMgImlwIikgcmVxdWlyZSBydG5sX211dGV4LCBidXQgdGhlIHJ0bmxfbXV0ZXgncyBv
bndlciBpcyB3YWl0aW5nIGZvcgo+IHRoZSB0aGUga3dvcmtlciBvZiB0aGUgc3lzdGVtX2hpZ2hw
cmlfd3EgYXQgZmx1c2hfYWxsX2JhY2tsb2dzKCksIHV0aWwgdGhpcyBoaWdocHJpIGt3b3JrZXIg
ZmluaXNoZWQKPiBmbHVzaCB0aGUgbmV0d29yayBwYWNrZXRzLgo+IAo+IEhvd2V2ZXIsIHRoaXMg
aGlnaHByaSBrd29ya2VyIGhhcyBiZWVuIHNsZWVwaW5nIGZvciBsb25nLCB0aGUgZGlmZmVyZW5j
ZSBiZXR3ZWVuIHRoZSBrd29ya2VyJ3MgdnJ1bnRpbWUKPiBhbmQgY2ZzX3JxLT5taW5fdnJ1bnRp
bWUgaXMgc28gYmlnLCB3aGVuIHdha2luZyB1cCBpdCwgaXQgd2lsbCBiZSBzZXQgaXRzIG9sZCB2
cnVudGltZSBkdWUgdG8gczY0IG92ZXJmbG93Cj4gYXQgbWF4X3ZydW50aW1lKCkuIEJlY2F1c2Ug
dGhlIGluY29ycmVjdCB2cnVudGltZSwgdGhlIGt3b3JrZXIgbWlnaHQgbm90IGJlIHNjaGVkdWxl
ZC4KPiAKPiBJcyBpdCBuZWNlc3NhcnkgdG8gZGVhbCB3aXRoIHRoaXMgcHJvYmxlbSBpbiBrZXJu
ZWw/Cj4gSWYgbmVjZXNzYXJ5LCBmb3IgZml4IHRoaXMgcHJvYmxlbSwgd2hlbiBhIHRhc2tzIGlz
IHNsZWVwaW5nIGxvbmcgZW5vdWdoLCB3ZSBzZXQgaXRzIHZydW50aW1lIGFzCj4gY2ZzX3JxLT5t
aW5fdnJ1bnRpbWUgd2hlbiB3YWtldXAgaXQsIGF2b2lkIHRoZSBzNjQgb3ZlcmZsb3cgaXNzdWUg
YXQgbWF4X3ZydW50aW1lLCBhcyBmb2xsb3c6Cj4gCj4gCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9z
Y2hlZC9mYWlyLmMgYi9rZXJuZWwvc2NoZWQvZmFpci5jCj4gaW5kZXggZTE2ZTlmMDEyNGIwLi44
OWRmOGQ3YmFlNjYgMTAwNjQ0Cj4gLS0tIGEva2VybmVsL3NjaGVkL2ZhaXIuYwo+ICsrKyBiL2tl
cm5lbC9zY2hlZC9mYWlyLmMKPiBAQCAtNDMzNiwxMCArNDMzNiwxNCBAQCBzdGF0aWMgdm9pZCBj
aGVja19zcHJlYWQoc3RydWN0IGNmc19ycSAqY2ZzX3JxLCBzdHJ1Y3Qgc2NoZWRfZW50aXR5ICpz
ZSkKPiAgI2VuZGlmCj4gIH0KPiAKPiArLyogd2hlbiBhIHRhc2sgc2xlZXAgb3ZlciAyMDAgZGF5
cywgaXQncyB2cnVudGltZSB3aWxsIGJlIHNldCBhcyBjZnNfcnEtPm1pbl92cnVudGltZS4gKi8K
PiArI2RlZmluZSBXQUtFVVBfUkVJTklUX1RIUkVTSE9MRF9OUyAgICAgKDIwMExMICogMjQgKiAz
NjAwICogTlNFQ19QRVJfU0VDKQoKSSB3b25kZXIgd2hlcmUgZG8gdGhlc2UgMjAwIGRheXMgY29t
ZSBmcm9tPwoKRS5nLiBpbiBvdXIgc2V0dXAgd2UndmUgb2JzZXJ2ZWQgdGhlIHByb2JsZW0gb24g
YSA0NDggY3B1IHN5c3RlbSwgd2l0aAphbGwgdGhlIGNwdXMgYmVpbmcgb2NjdXBpZWQgYnkgdGFz
a3MgaW4gYSBzaW5nbGUgY3B1IGNncm91cCAoYW5kCnRoZXJlZm9yZSBjb250cmlidXRpbmcgdG8g
aXRzIHdlaWdodCksIHdoZW4gdGhlIG90aGVyIHRhc2sgKGt3b3JrZXIpCnNsZXB0IGZvciBhcm91
bmQgMjA5IGRheXMuICBJT1cgcHJlc3VtYWJseSBhZGRpbmcgYSBmZXcgbW9yZSBjcHVzIG9yCmp1
c3QgcnVubmluZyB0aGUgd2hvbGUgY2dyb3VwIGF0IGFuIGVsZXZhdGVkIG5pY2UgbGV2ZWwgd2ls
bCBtYWtlIHRoZQpkaWZmZXJlbmNlIGFjY3VtdWxhdGUgZmFzdGVyLgoKVGhhbmtzLApSb21hbi4K
Cj4gKwo+ICBzdGF0aWMgdm9pZAo+ICBwbGFjZV9lbnRpdHkoc3RydWN0IGNmc19ycSAqY2ZzX3Jx
LCBzdHJ1Y3Qgc2NoZWRfZW50aXR5ICpzZSwgaW50IGluaXRpYWwpCj4gIHsKPiAgICAgICAgIHU2
NCB2cnVudGltZSA9IGNmc19ycS0+bWluX3ZydW50aW1lOwo+ICsgICAgICAgc3RydWN0IHJxICpy
cSA9IHJxX29mKGNmc19ycSk7Cj4gCj4gICAgICAgICAvKgo+ICAgICAgICAgICogVGhlICdjdXJy
ZW50JyBwZXJpb2QgaXMgYWxyZWFkeSBwcm9taXNlZCB0byB0aGUgY3VycmVudCB0YXNrcywKPiBA
QCAtNDM2NCw4ICs0MzY4LDExIEBAIHBsYWNlX2VudGl0eShzdHJ1Y3QgY2ZzX3JxICpjZnNfcnEs
IHN0cnVjdCBzY2hlZF9lbnRpdHkgKnNlLCBpbnQgaW5pdGlhbCkKPiAgICAgICAgICAgICAgICAg
dnJ1bnRpbWUgLT0gdGhyZXNoOwo+ICAgICAgICAgfQo+IAo+IC0gICAgICAgLyogZW5zdXJlIHdl
IG5ldmVyIGdhaW4gdGltZSBieSBiZWluZyBwbGFjZWQgYmFja3dhcmRzLiAqLwo+IC0gICAgICAg
c2UtPnZydW50aW1lID0gbWF4X3ZydW50aW1lKHNlLT52cnVudGltZSwgdnJ1bnRpbWUpOwo+ICsg
ICAgICAgaWYgKHVubGlrZWx5KCFpbml0aWFsICYmIChzNjQpKHJxX2Nsb2NrX3Rhc2socnEpIC0g
c2UtPmV4ZWNfc3RhcnQpID4gV0FLRVVQX1JFSU5JVF9USFJFU0hPTERfTlMpKQo+ICsgICAgICAg
ICAgICAgICBzZS0+dnJ1bnRpbWUgPSB2cnVudGltZTsKPiArICAgICAgIGVsc2UKPiArICAgICAg
ICAgICAgICAgLyogZW5zdXJlIHdlIG5ldmVyIGdhaW4gdGltZSBieSBiZWluZyBwbGFjZWQgYmFj
a3dhcmRzLiAqLwo+ICsgICAgICAgICAgICAgICBzZS0+dnJ1bnRpbWUgPSBtYXhfdnJ1bnRpbWUo
c2UtPnZydW50aW1lLCB2cnVudGltZSk7Cj4gIH0KPiAKPiAgc3RhdGljIHZvaWQgY2hlY2tfZW5x
dWV1ZV90aHJvdHRsZShzdHJ1Y3QgY2ZzX3JxICpjZnNfcnEpOwo+IAo+IAo+IAo+ID4gCj4gPiAu
Cj4gPiAKCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0
ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdl
ciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1
cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4OSAyMzcgODc5
CgoK

