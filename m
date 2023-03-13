Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852D86B746D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjCMKnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCMKm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:42:59 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7149226A5;
        Mon, 13 Mar 2023 03:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1678704177; x=1710240177;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject;
  bh=j01tB2R5nN7QLXsxRjmxkVqXlMC3tx8wTni3C5bEYL0=;
  b=qwlsB3P1inDMDRnaZhkxJ2Gj44YmneaLPzV1j0b5mY3swuqXpU0fCdf8
   Kj8TtRgEnENrVSzbq72VBWSOzvZY/FIzs3etQvBIsYmX1QLUOBqqhpTxj
   JdMOrV6EmNr0B1g0P4LW4YuSpR2tP8N/xQVrhRZ/6d7bwjmKVMGAYiy4z
   g=;
X-IronPort-AV: E=Sophos;i="5.98,256,1673913600"; 
   d="scan'208";a="192622017"
Subject: Re: [PATCH v2 0/2] [RFC] virtio-rng entropy leak reporting feature
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-fad5e78e.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 10:42:54 +0000
Received: from EX19D018EUA004.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-m6i4x-fad5e78e.us-west-2.amazon.com (Postfix) with ESMTPS id 59BD5A01BB;
        Mon, 13 Mar 2023 10:42:52 +0000 (UTC)
Received: from EX19D037EUB003.ant.amazon.com (10.252.61.119) by
 EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.24; Mon, 13 Mar 2023 10:42:51 +0000
Received: from [192.168.8.58] (10.1.212.12) by EX19D037EUB003.ant.amazon.com
 (10.252.61.119) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.24; Mon, 13 Mar
 2023 10:42:45 +0000
Message-ID: <e1c03136-b873-1f1d-8b06-d9186566fc0c@amazon.es>
Date:   Mon, 13 Mar 2023 11:42:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
From:   <bchalios@amazon.es>
To:     Amit Shah <amit@infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Jason Wang" <jasowang@redhat.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>, <sgarzare@redhat.com>,
        <amit@kernel.org>, <graf@amazon.de>, <xmarcalx@amazon.co.uk>
References: <20230131145543.86369-1-bchalios@amazon.es>
 <Y9lBeymca9eFaJ33@zx2c4.com>
 <65d872db2e1be29bb03b43ed606e7cc9e74ec08d.camel@infradead.org>
In-Reply-To: <65d872db2e1be29bb03b43ed606e7cc9e74ec08d.camel@infradead.org>
X-Originating-IP: [10.1.212.12]
X-ClientProxiedBy: EX19D039UWA004.ant.amazon.com (10.13.139.68) To
 EX19D037EUB003.ant.amazon.com (10.252.61.119)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW1pdCwKClRoYW5rcyBmb3IgdGFraW5nIHRoZSB0aW1lIHRvIGxvb2sgaW50byB0aGlzLgoK
T24gMy8yLzIzIDU6NTUgUE0sIEFtaXQgU2hhaCA8YW1pdEBpbmZyYWRlYWQub3JnPiB3cm90ZToK
PiBDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdh
bml6YXRpb24uIERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3UgY2FuIGNvbmZpcm0gdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLgo+
IAo+IAo+IAo+IEhleSBhbGwsCj4gCj4gT24gVHVlLCAyMDIzLTAxLTMxIGF0IDE3OjI3ICswMTAw
LCBKYXNvbiBBLiBEb25lbmZlbGQgd3JvdGU6Cj4gPiBZb3Ugc2VudCBhIHYyLCBidXQgSSdtIG5v
dCBiYWNrIHVudGlsIHRoZSAxMXRoIHRvIHByb3ZpZGUgY29tbWVudHMgb24KPiA+IHYxLiBJIHN0
aWxsIHRoaW5rIHRoaXMgaXNuJ3QgdGhlIHJpZ2h0IGRpcmVjdGlvbiwgYXMgdGhpcyBuZWVkcyB0
aWUtaW5zCj4gPiB0byB0aGUgcm5nIHRvIGFjdHVhbGx5IGJlIHVzZWZ1bC4gUGxlYXNlIHN0b3Ag
cG9zdGluZyBuZXcgdmVyc2lvbnMgb2YKPiA+IHRoaXMgZm9yIG5vdywgc28gdGhhdCBzb21lYm9k
eSBkb2Vzbid0IGFjY2lkZW50YWxseSBtZXJnZSBpdDsgdGhhdCdkIGJlCj4gPiBhIGJpZyBtaXN0
YWtlLiBJJ2xsIHBhc3RlIHdoYXQgSSB3cm90ZSB5b3UgcHJpb3I6Cj4gCj4gSSBzYXQgZG93biB0
byByZXZpZXcgdGhlIHBhdGNoc2V0IGJ1dCBsb29rcyBsaWtlIHRoZXJlJ3Mgc29tZQo+IGJhY2tn
cm91bmQgSSdtIG5vdCBhd2FyZSBvZi4KPiAKPiBJdCBsb29rcyBsaWtlIEJhYmlzIGhhcyBpbXBs
ZW1lbnRlZCB0aGUgZ3Vlc3Qgc2lkZSBoZXJlIGFjY29yZGluZyB0bwo+IHRoZSBzcGVjIGNoYW5n
ZSB0aGF0IE1pY2hhZWwgaGFzIHBvc3RlZC4KPiAKPiBKYXNvbiwgZG8geW91IGhhdmUgYW4gYWx0
ZXJuYXRpdmUgaW4gbWluZD8gIEluIHRoYXQgY2FzZSwgd2Ugc2hvdWxkCj4gcGljayB0aGlzIHVw
IGluIHRoZSBzcGVjIHVwZGF0ZSB0aHJlYWQgaW5zdGVhZC4KCkkgYW0gbm90IHN1cmUgd2hhdCBK
YXNvbiBtZWFudCBoZXJlIGJ5ICJUaGlzIG5lZWRzIHRvIGJlIGludGVncmF0ZWQgbW9yZSBjbG9z
ZWx5IHdpdGggcmFuZG9tLmMgaXRzZWxmLCBzaW1pbGFyIHRvIGhvdyB2bWdlbmlkIHdvcmtzIiwK
YnV0IGhlcmUncyBteSB0YWtlIG9uIHRoaXMuCgpUaGUgcG9pbnQgb2YgdGhlIHBhdGNoc2V0IGlz
IHRvIHByb3ZpZGUgYW4gaW1wbGVtZW50YXRpb24gb2YgTWljaGFlbCdzIHNwZWMgb24gd2hpY2gg
d2UgY2FuIGRpc2N1c3MuIEl0IGltcGxlbWVudHMgdGhlIEhXIEFQSSBhbmQgaXQgaGFzCnNvbWUg
aG9va3Mgc2hvd2luZyBob3cgdGhpcyBBUEkgY291bGQgYmUgdXNlZC4gSXQgaXMgbWFpbmx5IGRp
cmVjdGVkIHRvd2FyZHMgdGhlIHVzZXItc3BhY2Ugd2hlcmUgd2UgZGlkIG5vdCBoYXZlIGEgcHJv
cGVyIEFQSSB0byBjb25zdW1lClZNR0VOSUQtbGlrZSBmdW5jdGlvbmFsaXR5LiBXaXRoIHJlZ2Fy
ZHMgdG8gdGhlIHJhbmRvbS5jIGNvbXBvbmVudHMgaXQgZG9lcyBleGFjdGx5IHdoYXQgVk1HRU5J
RCBkb2VzIGN1cnJlbnRseSwgaS5lLiB3aGVuZXZlciBhbiBlbnRyb3B5LWxlYWsKaXMgZGV0ZWN0
ZWQgaXQgdXNlcyB0aGUgbmV3IHJhbmRvbSBieXRlcyBwcm92aWRlZCBieSB0aGUgdmlydGlvLXJu
ZyBkZXZpY2UgYXMgZW50cm9weS4gVGhpcyBpcyBhcyByYWN5IGFzIFZNR0VOSUQsIGFzIEkgbWVu
dGlvbiBpbiB0aGUgY292ZXIKbGV0dGVyIG9mIHRoZSBwYXRjaHNldC4KCkhvd2V2ZXIsIHRoZSBu
ZXcgc3BlYyBkb2VzIGFsbG93IHVzIHRvIGRvIHRoaW5ncyBfY29ycmVjdGx5XywgaS5lLiBub3Qg
cmVseSBvbiBhc3luY2hyb25vdXMgaGFuZGxpbmcgb2YgZXZlbnRzIHRvIHJlLXNlZWQgdGhlIGtl
cm5lbC4gRm9yIGV4YW1wbGUsIHdlCmNvdWxkIGFjaGlldmUgc29tZXRoaW5nIGxpa2UgdGhhdCBi
eSBtYWtpbmcgdXNlIG9mIHRoZSAiY29weS1vbi1sZWFrIiBvcGVyYXRpb24sIHNvIHRoYXQgYSBm
bGFnIGNoYW5nZXMgdmFsdWUgYmVmb3JlIHZDUFVzIGdldCByZXN1bWVkLCBzbyB3ZSBrbm93Cndo
ZW4gYSBsZWFrIGhhcyBoYXBwZW5lZCB3aGVuIG5lZWRlZCwgZS5nLiBiZWZvcmUgcmV0dXJuaW5n
IHJhbmRvbSBieXRlcyB0byB1c2VyLXNwYWNlLiBBdCBsZWFzdCwgdGhhdCdzIHdoYXQgSSByZW1l
bWJlciB1cyBkaXNjdXNzaW5nIGR1cmluZyBMUEMuCkphc29uLCBNaWNoYWVsLCBBbGV4LCBwbGVh
c2Uga2VlcCBtZSBob25lc3QgaGVyZSA6KQoKVW5mb3J0dW5hdGVseSwgSSBhbSBub3QgdmVyeSBm
YW1pbGlhciB3aXRoIHRoZSByYW5kb20uYyBjb2RlIGFuZCBkaWQgbm90IHdhbnQgdG8gZG8gc29t
ZXRoaW5nIHRoZXJlIHRoYXQgd291bGQgbW9zdCBjZXJ0YWlubHkgYmUgd3JvbmcsIGhlbmNlIEkg
cG9zdGVkCnRoaXMgYXMgYW4gUkZDLCBhc2tpbmcgZm9yIGlucHV0IG9uIGhvdyB3ZSBjb3VsZCBh
Y2hpZXZlIHRoaXMgYmV0dGVyIGludGVncmF0aW9uLiBIb3BlZnVsbHksIHdoZW4gSmFzb24gaXMg
YmFjayBmcm9tIGhpcyB2YWNhdGlvbiBoZSBjYW4gc2hhcmUgaGlzIHRob3VnaHRzCm9uIHRoaXMs
IGJ1dCBpZiB5b3Vyc2VsZiAob3IgYW55b25lIGVsc2UgaW50ZXJlc3RlZCkgaGF2ZSBhbnkgaWRl
YXMgb24gaG93IHdlIGNvdWxkIGRlc2lnbiB0aGlzIHByb3Blcmx5LCBJICdtIGhhcHB5IHRvIGRp
c2N1c3MhCgoKPiAKPiBTb21laG93IGl0IGZlZWxzIGxpa2UgSSBkb24ndCBoYXZlIHRoZSBjb21w
bGV0ZSBzdG9yeSBmb3IgdGhpcyBmZWF0dXJlCj4gc2V0LCBoYXZpbmcgbWlzc2VkIHRoZSBkaXNj
dXNzaW9uIGR1cmluZyBMUEMuCj4gCj4gICAgICAgICAgQW1pdAo+IAoKCkNoZWVycywKQmFiaXMK
QW1hem9uIFNwYWluIFNlcnZpY2VzIHNvY2llZGFkIGxpbWl0YWRhIHVuaXBlcnNvbmFsLCBDYWxs
ZSBSYW1pcmV6IGRlIFByYWRvIDUsIDI4MDQ1IE1hZHJpZC4gUmVnaXN0cm8gTWVyY2FudGlsIGRl
IE1hZHJpZCAuIFRvbW8gMjI0NTggLiBGb2xpbyAxMDIgLiBIb2phIE0tNDAxMjM0IC4gQ0lGIEI4
NDU3MDkzNgo=

