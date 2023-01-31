Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E3B683355
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjAaRG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjAaRGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:06:25 -0500
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2026734316;
        Tue, 31 Jan 2023 09:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1675184784; x=1706720784;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject;
  bh=J2AkhPTMGISpTBHHUJbbjfnBrK8QBklJ2lmqINVAGNI=;
  b=aFB1+1c1q9U2gmiIzAnFnWFH2HeSxM2hLlQWGH6yNPgsnArbY5uYKSgu
   TMpqMmhvhsIooFNEbg6LD1zx4PZLf7m5JGDgRUyG/RwGtjRXMIdcUXHhU
   ySQf4SirYdnnfbPrXf7Lw0+70SzV5KgECWQNUZnQ9YpZoR5qi0Er6xcAH
   k=;
X-IronPort-AV: E=Sophos;i="5.97,261,1669075200"; 
   d="scan'208";a="176920456"
Subject: Re: [PATCH v2 0/2] [RFC] virtio-rng entropy leak reporting feature
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-245b69b1.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 17:06:20 +0000
Received: from EX13D50EUB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-m6i4x-245b69b1.us-east-1.amazon.com (Postfix) with ESMTPS id CFD983423B1;
        Tue, 31 Jan 2023 17:06:18 +0000 (UTC)
Received: from EX19D037EUB003.ant.amazon.com (10.252.61.119) by
 EX13D50EUB001.ant.amazon.com (10.43.166.192) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Tue, 31 Jan 2023 17:06:17 +0000
Received: from [192.168.9.28] (10.43.160.120) by EX19D037EUB003.ant.amazon.com
 (10.252.61.119) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.24; Tue, 31 Jan
 2023 17:06:13 +0000
Message-ID: <1f8279ce-ea85-901e-a64b-ad3f21886a52@amazon.es>
Date:   Tue, 31 Jan 2023 18:06:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
From:   <bchalios@amazon.es>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>, <sgarzare@redhat.com>,
        <amit@kernel.org>, <graf@amazon.de>, <xmarcalx@amazon.co.uk>
References: <20230131145543.86369-1-bchalios@amazon.es>
 <Y9lBeymca9eFaJ33@zx2c4.com>
In-Reply-To: <Y9lBeymca9eFaJ33@zx2c4.com>
X-Originating-IP: [10.43.160.120]
X-ClientProxiedBy: EX13D35UWC001.ant.amazon.com (10.43.162.197) To
 EX19D037EUB003.ant.amazon.com (10.252.61.119)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFzb24sCgpJIHJlYWxseSBkaWRuJ3QgbWVhbiB0byBpbnRlcnJ1cHQgeW91ciBob2xpZGF5
cy4KCkkgcG9zdGVkIHRoaXMgYXMgYW4gUkZDIGV4YWN0bHkgYmVjYXVzZSBJIGRvbid0IHdhbnQg
dGhpcyB0byBiZSBtZXJnZWQgX2FzIGlzXywgaXQncyBqdXN0IGEgdHJpZ2dlciBmb3IgZGlzY3Vz
c2lvbi4KSXQgaXMgdjIganVzdCBhcyBhIHJlc3BvbnNlIHRvIE1pY2hhZWwncyBjb21tZW50cyBp
biB0aGUgcHJldmlvdXMgdmVyc2lvbiBhbmQgZml4ZXMgZm9yIHRoZSBDSS4KCkFsc28sIHRoZXJl
IGFyZSBvdGhlciBwZW9wbGUgdGhhdCBleHByZXNzZWQgaW50ZXJlc3QgaW4gdGhpcyBhbmQgdGhl
eSB3YW50ZWQgdG8gcGFydGljaXBhdGUgaW4gdGhlIGNvdmVyc2F0aW9uLCBzbyB0aGF0J3MganVz
dAp0aGF0LgoKSSBob3BlIHlvdSBlbmpveSB5b3VyIHZhY2F0aW9uLCBnZXQgc29tZSByZXN0IGFu
ZCBzcGVhayB0byB5b3Ugb25jZSB5b3UnIHJlIGJhY2sgOikKCkNoZWVycywKQmFiaXMKCk9uIDEv
MzEvMjMgNToyNyBQTSwgIkphc29uIEEuIERvbmVuZmVsZCIgPEphc29uQHp4MmM0LmNvbT4gd3Jv
dGU6Cj4gQ0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUg
b3JnYW5pemF0aW9uLiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxl
c3MgeW91IGNhbiBjb25maXJtIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2Fm
ZS4KPiAKPiAKPiAKPiBZb3Ugc2VudCBhIHYyLCBidXQgSSdtIG5vdCBiYWNrIHVudGlsIHRoZSAx
MXRoIHRvIHByb3ZpZGUgY29tbWVudHMgb24KPiB2MS4gSSBzdGlsbCB0aGluayB0aGlzIGlzbid0
IHRoZSByaWdodCBkaXJlY3Rpb24sIGFzIHRoaXMgbmVlZHMgdGllLWlucwo+IHRvIHRoZSBybmcg
dG8gYWN0dWFsbHkgYmUgdXNlZnVsLiBQbGVhc2Ugc3RvcCBwb3N0aW5nIG5ldyB2ZXJzaW9ucyBv
Zgo+IHRoaXMgZm9yIG5vdywgc28gdGhhdCBzb21lYm9keSBkb2Vzbid0IGFjY2lkZW50YWxseSBt
ZXJnZSBpdDsgdGhhdCdkIGJlCj4gYSBiaWcgbWlzdGFrZS4gSSdsbCBwYXN0ZSB3aGF0IEkgd3Jv
dGUgeW91IHByaW9yOgo+IAo+IHwgSGkgQmFiaXMsCj4gfAo+IHwgQXMgSSBtZW50aW9uZWQgdG8g
eW91IHByaXZhdGVseSB0aGlzIHdlZWssIEknbSBhYm91dCB0byBiZSBvdXQgb2YgdG93biwKPiB8
IHNvIEkgd29uJ3QgYmUgYWJsZSB0byBsb29rIGF0IHRoaXMgdW50aWwgSSdtIGJhY2sgaW4gYSBm
ZXcgd2Vla3MuIEkKPiB8IGFwcHJlY2lhdGUgeW91ciBwYXRpZW5jZS4KPiB8Cj4gfCBCdXQgYXMg
YSBjdXJzb3J5IGxvb2ssIEknbSBoYXBweSB0aGF0IHlvdSd2ZSB3cml0dGVuIHRoZSBoYXJkd2Fy
ZS1zaWRlCj4gfCBjb2RlIGZvciB0aGlzLiBUaGF0J3MgYSBncmVhdCBzdGFydGluZyBwb2ludC4g
VGhlIHBsdW1iaW5nIGlzIG5vdCBzbwo+IHwgbmljZSwgdGhvdWdoLiBUaGlzIG5lZWRzIHRvIGJl
IGludGVncmF0ZWQgbW9yZSBjbG9zZWx5IHdpdGggcmFuZG9tLmMKPiB8IGl0c2VsZiwgc2ltaWxh
ciB0byBob3cgdm1nZW5pZCB3b3Jrcy4KPiB8Cj4gfCBXaGVuIEknbSBiYWNrIGluIGEgZmV3IHdl
ZWtzLCBJJ2xsIHNlZSBpZiBJIGNhbiBlaXRoZXIgd3JpdGUgYQo+IHwgZGVzY3JpcHRpb24gb2Yg
d2hhdCBJIGhhdmUgaW4gbWluZCwgb3Igc2ltcGx5IGludGVncmF0ZSB0aGUgdXNlZnVsCj4gfCBo
YXJkd2FyZSB3b3JrIGhlcmUgaW50byBhbiBleHBhbmRlZCBwYXRjaCBzZXJpZXMuCj4gfAo+IHwg
W1BsZWFzZSBkb24ndCBtZXJnZSBhbnl0aGluZyBmb3Igbm93Ll0KPiAKPiBTbzogeW91IHdyb3Rl
IHNvbWUgbWF5YmUgdXNlZnVsIGhhcmR3YXJlIGNvZGUuIFRoZSByZXN0IGlzIHdyb25nLiBBbmQg
d2UKPiBoYXZlbid0IGV2ZW4gY29uY2x1ZGVkIGRpc2N1c3Npb25zIG9uIHdoZXRoZXIgdGhlIHZp
cnRpbyBpbnRlcmZhY2UgaXMKPiB0aGUgcmlnaHQgb25lLiBJbiBmYWN0LCBJIGhhZCBwcmV2aW91
c2x5IGFza2VkIGlmIHdlIGNvdWxkIHNjaGVkdWxlIHRoaXMKPiBhbGwgdW50aWwgTWFyY2guIE1h
cmNvIGZyb20geW91ciB0ZWFtIHRoZW4gc2VudCBhbiBpbXBhdGllbnQgZW1haWwsIHNvIEkKPiBz
YWlkLCBhbHJpZ2h0LCB3aGF0IGFib3V0IEZlYiAxMSB3aGVuIEknbSBiYWNrLiBUaGF0J3MgYW5u
b3lpbmcgZm9yIG1lCj4gYnV0IEkgZmlndXJlZCBJJ2QganVzdCBzaHVmZmxlIGV2ZXJ5dGhpbmcg
YXJvdW5kIGFuZCBwcmlvcml0aXplIHRoaXMuCj4gVGhlbiwgaW5zdGVhZCBvZiB3YWl0aW5nIGZv
ciB0aGF0LCB5b3UgcG9zdGVkIHYxIG9mIHRoaXMgcGF0Y2hzZXQgdGhlCj4gbmV4dCBkYXkuIEkg
YXNrZWQgeW91IGFnYWluLiBBbmQgbm93LCB3aGlsZSBJJ20gYXdheSBvbiB0aGUgZmlyc3QKPiBo
b2xpZGF5IGluIGEgd2hpbGUgd2l0aCB2ZXJ5IGxpdHRsZSBjb25uZWN0aXZpdHkgYW5kIG5vIGxh
cHRvcCwgeW91IHBvc3QKPiBhIHYyLiBTbyBJJ20gcmVhbGx5IGFubm95ZWQuIEluIG9yZGVyIHRv
IGF2b2lkIGFsbCBkb3VidCBhYm91dCB0aGlzLCBsZXQKPiBtZSB0aGVuIGp1c3QgTkFDSyB0aGlz
LCBhbmQgSSdsbCBsaWZ0IHRoZSBuYWNrIHdoZW4gSSdtIGJhY2s6Cj4gCj4gICAgICBOYWNrZWQt
Ynk6IEphc29uIEEuIERvbmVuZmVsZCA8SmFzb25AengyYzQuY29tPgo+IApBbWF6b24gU3BhaW4g
U2VydmljZXMgc29jaWVkYWQgbGltaXRhZGEgdW5pcGVyc29uYWwsIENhbGxlIFJhbWlyZXogZGUg
UHJhZG8gNSwgMjgwNDUgTWFkcmlkLiBSZWdpc3RybyBNZXJjYW50aWwgZGUgTWFkcmlkIC4gVG9t
byAyMjQ1OCAuIEZvbGlvIDEwMiAuIEhvamEgTS00MDEyMzQgLiBDSUYgQjg0NTcwOTM2Cg==

