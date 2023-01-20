Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2F2675725
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjATO3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjATO3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:29:18 -0500
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBB480899;
        Fri, 20 Jan 2023 06:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1674224932; x=1705760932;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject;
  bh=FkMRWQ83h9RadsNbLD+ZuI0L7IMzva4jSqpOEcCAdeU=;
  b=T9tAcjJE0lczYrZ1sdgTeIf9NxUNe7cTEBm3AgCumozr7oy9eKa0r5iS
   EaVnxQzARwbq1jeU56FTw9yEf9tCiguthtLiOlmGzDmGDBqvvnccXRmnG
   0c0HGGt6s9iiiGiuz4U9fyqBqGreIH93PQOIbKefX0NLInjw/S4jCMOnl
   E=;
X-IronPort-AV: E=Sophos;i="5.97,232,1669075200"; 
   d="scan'208";a="173241907"
Subject: Re: [PATCH 0/2] [RFC] virtio-rng entropy leak reporting feature
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-e651a362.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 14:28:12 +0000
Received: from EX13D48EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-m6i4x-e651a362.us-east-1.amazon.com (Postfix) with ESMTPS id 6AFCF81FDA;
        Fri, 20 Jan 2023 14:28:08 +0000 (UTC)
Received: from EX19D037EUB003.ant.amazon.com (10.252.61.119) by
 EX13D48EUB003.ant.amazon.com (10.43.166.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.45; Fri, 20 Jan 2023 14:28:07 +0000
Received: from [192.168.17.83] (10.43.162.56) by EX19D037EUB003.ant.amazon.com
 (10.252.61.119) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.7; Fri, 20 Jan
 2023 14:28:03 +0000
Message-ID: <2e0e51a5-d852-241d-3c3a-5440296bc896@amazon.es>
Date:   Fri, 20 Jan 2023 15:27:58 +0100
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
        <virtualization@lists.linux-foundation.org>, <amit@kernel.org>,
        <graf@amazon.de>, <xmarcalx@amazon.co.uk>
References: <20230119184349.74072-1-bchalios@amazon.es>
 <Y8qjLolaLbMnDnkw@zx2c4.com>
In-Reply-To: <Y8qjLolaLbMnDnkw@zx2c4.com>
X-Originating-IP: [10.43.162.56]
X-ClientProxiedBy: EX13D39UWB003.ant.amazon.com (10.43.161.215) To
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

CgpPbiAxLzIwLzIzIDM6MjAgUE0sICJKYXNvbiBBLiBEb25lbmZlbGQiIDxKYXNvbkB6eDJjNC5j
b20+IHdyb3RlOgo+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUg
b2YgdGhlIG9yZ2FuaXphdGlvbi4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVu
dHMgdW5sZXNzIHlvdSBjYW4gY29uZmlybSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50
IGlzIHNhZmUuCj4gCj4gCj4gCj4gSGkgQmFiaXMsCj4gCj4gQXMgSSBtZW50aW9uZWQgdG8geW91
IHByaXZhdGVseSB0aGlzIHdlZWssIEknbSBhYm91dCB0byBiZSBvdXQgb2YgdG93biwKPiBzbyBJ
IHdvbid0IGJlIGFibGUgdG8gbG9vayBhdCB0aGlzIHVudGlsIEknbSBiYWNrIGluIGEgZmV3IHdl
ZWtzLiBJCj4gYXBwcmVjaWF0ZSB5b3VyIHBhdGllbmNlLgo+IAo+IEJ1dCBhcyBhIGN1cnNvcnkg
bG9vaywgSSdtIGhhcHB5IHRoYXQgeW91J3ZlIHdyaXR0ZW4gdGhlIGhhcmR3YXJlLXNpZGUKPiBj
b2RlIGZvciB0aGlzLiBUaGF0J3MgYSBncmVhdCBzdGFydGluZyBwb2ludC4gVGhlIHBsdW1iaW5n
IGlzIG5vdCBzbwo+IG5pY2UsIHRob3VnaC4gVGhpcyBuZWVkcyB0byBiZSBpbnRlZ3JhdGVkIG1v
cmUgY2xvc2VseSB3aXRoIHJhbmRvbS5jCj4gaXRzZWxmLCBzaW1pbGFyIHRvIGhvdyB2bWdlbmlk
IHdvcmtzLgo+IAo+IFdoZW4gSSdtIGJhY2sgaW4gYSBmZXcgd2Vla3MsIEknbGwgc2VlIGlmIEkg
Y2FuIGVpdGhlciB3cml0ZSBhCj4gZGVzY3JpcHRpb24gb2Ygd2hhdCBJIGhhdmUgaW4gbWluZCwg
b3Igc2ltcGx5IGludGVncmF0ZSB0aGUgdXNlZnVsCj4gaGFyZHdhcmUgd29yayBoZXJlIGludG8g
YW4gZXhwYW5kZWQgcGF0Y2ggc2VyaWVzLgo+IAo+IFtQbGVhc2UgZG9uJ3QgbWVyZ2UgYW55dGhp
bmcgZm9yIG5vdy5dCj4gCj4gSmFzb24KPiAKCkhleSBKYXNvbiwKCkkgYWdyZWUgdGhhdCB0aGUg
cGx1bWJpbmcgd2l0aCByYW5kb20uYyBuZWVkcyB3b3JrLiBUaGF0J3Mgd2h5IHRoaXMgaXMgYW4g
UkZDISBUaGF0J3MgdGhlIGtpbmQgb2YgaW5wdXQgSSdtIGxvb2tpbmcgZm9yLgpBcyBJIG1lbnRp
b24gaW4gdGhlIGNvdmVyIGxldHRlciwgSU1ITywgd2UgbmVlZCB0byBnaXZlIHRvIHJhbmRvbS5j
IChhbmQgb3RoZXIgcGFydHMgb2YgdGhlIGtlcm5lbCB0aGF0IHRoZXkgbWlnaHQgbmVlZCBpdCkK
YW4gQVBJIHRvIGRpcmVjdGx5IGFkZCBidWZmZXJzIGluIHRoZSBxdWV1ZSwgc28gdGhhdCB3ZSBh
dm9pZCB0aGUgcmFjZS1jb25kaXRpb24gaGVyZS4KCkFueSBpZGVhcyBvbiB0aGF0IGZyb250IGFy
ZSBtb3JlIHRoYW4gd2VsY29tZSBhbmQgbG9va2luZyBmb3J3YXJkIHRvIHRoZW0uCgpDaGVlcnMs
CkJhYmlzCkFtYXpvbiBTcGFpbiBTZXJ2aWNlcyBzb2NpZWRhZCBsaW1pdGFkYSB1bmlwZXJzb25h
bCwgQ2FsbGUgUmFtaXJleiBkZSBQcmFkbyA1LCAyODA0NSBNYWRyaWQuIFJlZ2lzdHJvIE1lcmNh
bnRpbCBkZSBNYWRyaWQgLiBUb21vIDIyNDU4IC4gRm9saW8gMTAyIC4gSG9qYSBNLTQwMTIzNCAu
IENJRiBCODQ1NzA5MzYK

