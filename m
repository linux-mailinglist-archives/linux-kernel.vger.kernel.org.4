Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6157E653E6E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 11:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbiLVKj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 05:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235206AbiLVKjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 05:39:20 -0500
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D0028706;
        Thu, 22 Dec 2022 02:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1671705559; x=1703241559;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=Zj60oV1boQ7NGalLVs3NkupJlLWftO5a5+YQLV6/KX8=;
  b=MOGtg8HjoqkKpH0zHAZOKFImCtdK2CCwTN1M1xjVK2+KlH/50ciryK1k
   Ifcz1C73wOrvwU2eanIfBe8m3aOuAdVJbkduUfw4X9ZvrGqqCRq4kqNZs
   abxIAQqPcFDzmV8h3v2uBGQL+LaVkxRpmJYvwEKWcoVLQFi29M/LY9Irt
   Y=;
X-IronPort-AV: E=Sophos;i="5.96,265,1665446400"; 
   d="scan'208";a="279975315"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-47cc8a4c.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 10:39:16 +0000
Received: from EX13MTAUWB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-m6i4x-47cc8a4c.us-east-1.amazon.com (Postfix) with ESMTPS id 5ABBB1610DC;
        Thu, 22 Dec 2022 10:39:13 +0000 (UTC)
Received: from EX13P01UWB004.ant.amazon.com (10.43.161.213) by
 EX13MTAUWB002.ant.amazon.com (10.43.161.202) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Thu, 22 Dec 2022 10:39:12 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13P01UWB004.ant.amazon.com (10.43.161.213) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Thu, 22 Dec 2022 10:39:12 +0000
Received: from dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (10.15.11.255)
 by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1497.42 via Frontend Transport; Thu, 22 Dec 2022 10:39:12 +0000
Received: by dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (Postfix, from userid 23027615)
        id D6E8520A24; Thu, 22 Dec 2022 11:39:10 +0100 (CET)
From:   Pratyush Yadav <ptyadav@amazon.de>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
CC:     <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Len Brown" <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Robert Moore" <robert.moore@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devel@acpica.org>
Subject: Re: [PATCH 0/2] intel_pstate: fix turbo not being used after a
 processor is rebooted
References: <20221221155203.11347-1-ptyadav@amazon.de>
        <72bcd14eef038ec9181d30b3d196b0a872f47ccb.camel@linux.intel.com>
Date:   Thu, 22 Dec 2022 11:39:10 +0100
In-Reply-To: <72bcd14eef038ec9181d30b3d196b0a872f47ccb.camel@linux.intel.com>
        (srinivas pandruvada's message of "Wed, 21 Dec 2022 13:34:18 -0800")
Message-ID: <mafs0k02jd8oh.fsf_-_@dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkhpIFNyaW5pdmFzLAoKT24gV2VkLCBEZWMgMjEgMjAyMiwgc3Jpbml2YXMgcGFuZHJ1dmFkYSB3
cm90ZToKPiBPbiBXZWQsIDIwMjItMTItMjEgYXQgMTY6NTIgKzAxMDAsIFByYXR5dXNoIFlhZGF2
IHdyb3RlOgo+PiBXaGVuIGEgcHJvY2Vzc29yIGlzIGJyb3VnaHQgb2ZmbGluZSBhbmQgb25saW5l
IGFnYWluLCBpdCBpcyB1bmFibGUgdG8KPj4gdXNlIFR1cmJvIG1vZGUgYmVjYXVzZSB0aGUgX1BT
UyB0YWJsZSBkb2VzIG5vdCBjb250YWluIHRoZSB3aG9sZQo+PiB0dXJibwo+PiBmcmVxdWVuY3kg
cmFuZ2UsIGJ1dCBvbmx5ICsxIE1IeiBhYm92ZSB0aGUgbWF4IG5vbi10dXJibyBmcmVxdWVuY3ku
Cj4+IFRoaXMKPj4gY2F1c2VzIHByb2JsZW1zIHdoZW4gQUNQSSBwcm9jZXNzb3IgZHJpdmVyIHRy
aWVzIHRvIHNldCBmcmVxdWVuY3kKPj4gY29uc3RyYWludHMuIFNlZSBwYXRjaCAyIGZvciBtb3Jl
IGRldGFpbHMuCj4+Cj4gQXJlIHlvdSB1c2luZyBzb21lIF9QUEMgY29uc3RyYWludCB0byBmb3Jj
ZSB0byBsaW1pdCBmcmVxdWVuY3k/Cj4gSSBkaWQgYSBvZmZsaW5lL29ubGluZSB3aXRoIFBQQz0w
IHdpdGggbm8gSFdQLCBJIGNhbiBnZXQgdG8gZnVsbCB0dXJibwo+IHJhbmdlLgo+Cj4gWyAgMTIx
LjIzNzc1Ml0gc21wYm9vdDogQ1BVIDEgaXMgbm93IG9mZmxpbmUKPiBbICAxMjUuNzM0ODg2XSB4
ODY6IEJvb3RpbmcgU01QIGNvbmZpZ3VyYXRpb246Cj4gWyAgMTI1LjczNDg5Ml0gc21wYm9vdDog
Qm9vdGluZyBOb2RlIDAgUHJvY2Vzc29yIDEgQVBJQyAweDIKPiBbICAxMjUuNzQxMDA3XSBpbnRl
bF9wc3RhdGU6IENQVSAxIGdvaW5nIG9ubGluZQo+IFsgIDEyNS43NDE2OTJdIGludGVsX3BzdGF0
ZTogQ1BVMSAtIEFDUEkgX1BTUyBwZXJmIGRhdGEKPiBbICAxMjUuNzQxNjk4XSBpbnRlbF9wc3Rh
dGU6ICAgICAgKlAwOiAyMzAxIE1IeiwgMjgwMDAgbVcsIDB4MmEwMAo+IFsgIDEyNS43NDE3MDNd
IGludGVsX3BzdGF0ZTogICAgICAgUDE6IDIzMDAgTUh6LCAyODAwMCBtVywgMHgxNzAwCj4gWyAg
MTI1Ljc0MTcwNV0gaW50ZWxfcHN0YXRlOiAgICAgICBQMjogMjIwMCBNSHosIDI2Mjk3IG1XLCAw
eDE2MDAKPiBbICAxMjUuNzQxNzA3XSBpbnRlbF9wc3RhdGU6ICAgICAgIFAzOiAyMDAwIE1Ieiwg
MjMyNjMgbVcsIDB4MTQwMAo+IFsgIDEyNS43NDE3MTBdIGludGVsX3BzdGF0ZTogICAgICAgUDQ6
IDE5MDAgTUh6LCAyMTkyNCBtVywgMHgxMzAwCj4gWyAgMTI1Ljc0MTcxMl0gaW50ZWxfcHN0YXRl
OiAgICAgICBQNTogMTgwMCBNSHosIDIwNjEyIG1XLCAweDEyMDAKPiBbICAxMjUuNzQxNzE0XSBp
bnRlbF9wc3RhdGU6ICAgICAgIFA2OiAxNjAwIE1IeiwgMTc4MTIgbVcsIDB4MTAwMAo+IFsgIDEy
NS43NDE3MTZdIGludGVsX3BzdGF0ZTogICAgICAgUDc6IDE1MDAgTUh6LCAxNjU4MSBtVywgMHhm
MDAKPiBbICAxMjUuNzQxNzE4XSBpbnRlbF9wc3RhdGU6ICAgICAgIFA4OiAxMzAwIE1IeiwgMTM5
NDYgbVcsIDB4ZDAwCj4gWyAgMTI1Ljc0MTcyMF0gaW50ZWxfcHN0YXRlOiAgICAgICBQOTogMTIw
MCBNSHosIDEyNzk2IG1XLCAweGMwMAo+IFsgIDEyNS43NDE3MjJdIGludGVsX3BzdGF0ZTogICAg
ICAgUDEwOiAxMTAwIE1IeiwgMTE0MjYgbVcsIDB4YjAwCj4gWyAgMTI1Ljc0MTcyNF0gaW50ZWxf
cHN0YXRlOiAgICAgICBQMTE6IDkwMCBNSHosIDkyNTAgbVcsIDB4OTAwCj4gWyAgMTI1Ljc0MTcy
Nl0gaW50ZWxfcHN0YXRlOiAgICAgICBQMTI6IDgwMCBNSHosIDc5NjUgbVcsIDB4ODAwCj4gWyAg
MTI1Ljc0MTcyOV0gaW50ZWxfcHN0YXRlOiAgICAgICBQMTM6IDcwMCBNSHosIDY5NDAgbVcsIDB4
NzAwCj4gWyAgMTI1Ljc0MTczMV0gaW50ZWxfcHN0YXRlOiAgICAgICBQMTQ6IDUwMCBNSHosIDQ3
MzggbVcsIDB4NTAwCj4gWyAgMTI1Ljc0MTczM10gaW50ZWxfcHN0YXRlOiAgICAgICBQMTU6IDQw
MCBNSHosIDM3ODcgbVcsIDB4NDAwCj4gWyAgMTI1Ljc0MTczNV0gaW50ZWxfcHN0YXRlOiBfUFBD
IGxpbWl0cyB3aWxsIGJlIGVuZm9yY2VkCj4gWyAgMTI1Ljc0MTc0MF0gaW50ZWxfcHN0YXRlOiBw
b2xpY3ktPm1heCA+IG1heCBub24gdHVyYm8gZnJlcXVlbmN5Cj4gWyAgMTI1Ljc0MTc0Ml0gaW50
ZWxfcHN0YXRlOiBjcHU6MSBtaW5fcG9saWN5X3BlcmY6NCBtYXhfcG9saWN5X3BlcmY6NDIKPiBb
ICAxMjUuNzQxNzQ1XSBpbnRlbF9wc3RhdGU6IGNwdToxIGdsb2JhbF9taW46NCBnbG9iYWxfbWF4
OjQyCj4gWyAgMTI1Ljc0MTc0N10gaW50ZWxfcHN0YXRlOiBjcHU6MSBtYXhfcGVyZl9yYXRpbzo0
MiBtaW5fcGVyZl9yYXRpbzo0Cj4gWyAgMTI1Ljc0MjI0M10gaW50ZWxfcHN0YXRlOiBwb2xpY3kt
Pm1heCA+IG1heCBub24gdHVyYm8gZnJlcXVlbmN5Cj4gWyAgMTI1Ljc0MjI0N10gaW50ZWxfcHN0
YXRlOiBjcHU6MSBtaW5fcG9saWN5X3BlcmY6NCBtYXhfcG9saWN5X3BlcmY6NDIKPiBbICAxMjUu
NzQyMjUxXSBpbnRlbF9wc3RhdGU6IGNwdToxIGdsb2JhbF9taW46NCBnbG9iYWxfbWF4OjQyCj4g
WyAgMTI1Ljc0MjI1NV0gaW50ZWxfcHN0YXRlOiBjcHU6MSBtYXhfcGVyZl9yYXRpbzo0MiBtaW5f
cGVyZl9yYXRpbzo0Cj4KPgo+IEl0IGlzIG5vdCBjbGVhciBob3cgdG8gZ2V0IHRvIHRoaXMgbm9u
IHR1cmJvIHNpdHVhdGlvbi4KCkxvb2sgYXQgdGhlIHNjYWxpbmdfbWF4X2ZyZXEgYmVmb3JlIGFu
ZCBhZnRlciByZWJvb3RpbmcgdGhlIENQVS4gQmVmb3JlCnlvdSBkbyBpdCwgaXQgc2hvdWxkIGJl
IHRoZSBtYXggdHVyYm8gZnJlcXVlbmN5IChzYXkgMjUwMCBNSHopLiBBZnRlcgpyZWJvb3Rpbmcg
dGhlIENQVSwgaXQgc2hvdWxkIG5vdyBiZSAyMzAxIE1Iei4gU28gdGhlIGtlcm5lbCB3aWxsIG5v
dyBub3QKYXNrIGZvciBhbnl0aGluZyBhYm92ZSAyMzAxIE1Ieiwgc28geW91IHdpbGwgbmV2ZXIg
Z2V0IHRvIDI1MDAgTUh6LgoKQW5vdGhlciBpbnRlcmVzdGluZyB0aGluZyBJIG9ic2VydmVkIGlz
IHRoYXQgaWYgSSByZWJvb3Qgb25seSAxIENQVSwgaXRzCnNjYWxpbmdfbWF4X2ZyZXEgZ29lcyBk
b3duIHRvIDIzMDEsIGJ1dCBpdCBzdGlsbCBrZWVwcyB3b3JraW5nIGF0IDI1MDAKTUh6LiBUaGlz
IG1pZ2h0IGJlIHNvbWV0aGluZyB0byBkbyB3aXRoIGhvdyB0dXJibyB3b3JrcywgSSBkb24ndAp1
bmRlcnN0YW5kIHRoYXQgdmVyeSB3ZWxsLiBCdXQgaWYgeW91IHJlYm9vdCBzYXkgMjAgQ1BVcywg
dGhlbiB5b3Ugc2VlCnRoZSBmcmVxdWVuY3kgZHJvcC4KCkkgdXNlIHRoZSBiZWxvdyBzdGVwcyB0
byByZXByb2R1Y2UgdGhpcyBidWcgb24gbXkgc3lzdGVtLCB3aGljaCBoYXMgNDAKQ1BVcyB3aXRo
IGEgYmFzZSBmcmVxdWVuY3kgb2YgMjUwMCBNSHogYW5kIHR1cmJvIGZyZXF1ZW5jeSBvZiAzMzAw
IE1IejoKCiQgZ3JlcCAnY3B1IE1IeicgL3Byb2MvY3B1aW5mbwpjcHUgTUh6ICAgICAgICAgOiAz
MzAwLjAwMApjcHUgTUh6ICAgICAgICAgOiAxMTk5LjY1MgpjcHUgTUh6ICAgICAgICAgOiAzMzAw
LjAwMApjcHUgTUh6ICAgICAgICAgOiAzMzAwLjAwMApjcHUgTUh6ICAgICAgICAgOiAzMzAwLjAw
MApjcHUgTUh6ICAgICAgICAgOiAzMzAwLjAwMApjcHUgTUh6ICAgICAgICAgOiAzMzAwLjAwMApj
cHUgTUh6ICAgICAgICAgOiAzMzAwLjAwMApjcHUgTUh6ICAgICAgICAgOiAzMzAwLjAwMApjcHUg
TUh6ICAgICAgICAgOiAzMzAwLjAwMApbIHJlcGVhdCAzMCB0aW1lcyBdCgokIGNhdCAvc3lzL2Rl
dmljZXMvc3lzdGVtL2NwdS9jcHUqL2NwdWZyZXEvc2NhbGluZ19tYXhfZnJlcSB8IHNvcnQgLW4g
fCB1bmlxIC1jCiAgICAgNDAgMzMwMDAwMAokIGZvciBpIGluIGBzZXEgMSAyMGA7IGRvIGVjaG8g
MCB8IHN1ZG8gdGVlIC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdSRpL29ubGluZTsgZG9uZQpb
Li4uXQokIGZvciBpIGluIGBzZXEgMSAyMGA7IGRvIGVjaG8gMSB8IHN1ZG8gdGVlIC9zeXMvZGV2
aWNlcy9zeXN0ZW0vY3B1L2NwdSRpL29ubGluZTsgZG9uZQpbLi4uXQokIGdyZXAgJ2NwdSBNSHon
IC9wcm9jL2NwdWluZm8KY3B1IE1IeiAgICAgICAgIDogMzMwMC4wMDAKY3B1IE1IeiAgICAgICAg
IDogMjUwMC4wMDAKY3B1IE1IeiAgICAgICAgIDogMjUwMC4wMDAKY3B1IE1IeiAgICAgICAgIDog
MjUwMC4wMDAKY3B1IE1IeiAgICAgICAgIDogMjUwMC4wMDAKY3B1IE1IeiAgICAgICAgIDogMjUw
MC4wMDAKWyByZXBlYXQgMTUgdGltZXMgXQpjcHUgTUh6ICAgICAgICAgOiAzMzAwLjAwMApjcHUg
TUh6ICAgICAgICAgOiAzMzAwLjAwMApbIHJlcGVhdCAxNyB0aW1lcyBdCiQgY2F0IC9zeXMvZGV2
aWNlcy9zeXN0ZW0vY3B1L2NwdSovY3B1ZnJlcS9zY2FsaW5nX21heF9mcmVxIHwgc29ydCAtbiB8
IHVuaXEgLWMKICAgICAyMCAyNTAxMDAwCiAgICAgMjAgMzMwMDAwMAoKPgo+IFRoYW5rcywKPiBT
cmluaXZhcwo+Cj4+IFByYXR5dXNoIFlhZGF2ICgyKToKPj4gICBhY3BpOiBwcm9jZXNzb3I6IGFs
bG93IGZpeGluZyB1cCB0aGUgZnJlcXVlbmN5IGZvciBhIHBlcmZvcm1hbmNlCj4+IHN0YXRlCj4+
ICAgY3B1ZnJlcTogaW50ZWxfcHN0YXRlOiB1c2UgYWNwaSBwZXJmbGliIHRvIHVwZGF0ZSB0dXJi
byBmcmVxdWVuY3kKPj4KPj4gIGRyaXZlcnMvYWNwaS9wcm9jZXNzb3JfcGVyZmxpYi5jIHwgNDAK
Pj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPj4gIGRyaXZlcnMvY3B1ZnJlcS9p
bnRlbF9wc3RhdGUuYyAgIHzCoCA1ICsrLS0KPj4gIGluY2x1ZGUvYWNwaS9wcm9jZXNzb3IuaCAg
ICAgICAgIHzCoCAyICsrCj4+ICAzIGZpbGVzIGNoYW5nZWQsIDQ1IGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pCj4+Cj4+IC0tCj4+IDIuMzguMQo+Pgo+CgotLSAKUmVnYXJkcywKUHJhdHl1
c2ggWWFkYXYKCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNl
bnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxh
ZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRl
bmJ1cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4OSAyMzcg
ODc5CgoK

