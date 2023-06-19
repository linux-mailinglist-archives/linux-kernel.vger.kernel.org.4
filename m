Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15F1735E93
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 22:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjFSUiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 16:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFSUiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 16:38:09 -0400
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889E3DF
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 13:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1687207088; x=1718743088;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s7kMJnxQvkCPcrRqUeLV6yLIHbwqnw9UYgn55GcA5E4=;
  b=RVoT4RmW3iKMauGITaqRAvOznC9O7ZcGNpw0xOblsJIvtcGdLqG6VNfT
   1Tnx9zop/kmVQsfzCP1ZjhXO44+2dRv3NQTHd2nO1PtKb87KoiVarBsPk
   /uQhnFMtjvdo++tAZp2977HpkDrIiv1FYdYqaGI6w0s0q+Dd2j9FEB1Um
   4=;
X-IronPort-AV: E=Sophos;i="6.00,255,1681171200"; 
   d="scan'208";a="11083222"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 20:38:05 +0000
Received: from EX19MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com (Postfix) with ESMTPS id E29CB45F57;
        Mon, 19 Jun 2023 20:38:03 +0000 (UTC)
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 19 Jun 2023 20:38:03 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Mon, 19 Jun
 2023 20:38:01 +0000
Message-ID: <b3a3f65d-9bbf-c509-3312-b6f19eaab5cb@amazon.de>
Date:   Mon, 19 Jun 2023 22:37:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 1/1] vmgenid: emit uevent when VMGENID updates
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Babis Chalios <bchalios@amazon.es>
CC:     Theodore Ts'o <tytso@mit.edu>, <linux-kernel@vger.kernel.org>,
        <mzxreary@0pointer.de>, <xmarcalx@amazon.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230531095119.11202-1-bchalios@amazon.es>
 <20230531095119.11202-2-bchalios@amazon.es>
 <CAHmME9pVLD-U+iYfv7=HBufRtaSkBmCRpKLH8pbvPNkgozE3cg@mail.gmail.com>
From:   Alexander Graf <graf@amazon.de>
In-Reply-To: <CAHmME9pVLD-U+iYfv7=HBufRtaSkBmCRpKLH8pbvPNkgozE3cg@mail.gmail.com>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IEphc29uLAoKT24gMTkuMDYuMjMgMjI6MzAsIEphc29uIEEuIERvbmVuZmVsZCB3cm90ZToK
PiBMaWtlIHRoZSBvdGhlciBwYXRjaCwgYW5kIGFzIGRpc2N1c3NlZCBiZWZvcmUgdG9vLCBJIGRv
bid0IHRoaW5rIHRoaXMKPiBoYXMgYW55IGJ1c2luZXNzIGJlaW5nIHBhcnQgb2YgKHZpcnR1YWwp
IGhhcmR3YXJlIGRyaXZlcnMsIGFuZCBpbnN0ZWFkCj4gYmVsb25ncyBpbiByYW5kb20uYywgd2hp
Y2ggbWlnaHQgcmVjZWl2ZSB0aGVzZSBub3RpZmljYXRpb25zIGZyb20gYQo+IHZhcmlldHkgb2Yg
ZGV2aWNlcywgYW5kIGNhbiB0aHVzIHN5bmNocm9uaXplIHRoaW5ncyBhY2NvcmRpbmdseS4KPiBQ
bGVhc2Ugc3RvcCBwb3N0aW5nIG1vcmUgb2YgdGhlc2Ugc2FtZSBhcHByb2FjaGVzLiBTYW1lIG5h
Y2sgYXMgdGhlCj4gb3RoZXIgb25lcy4KCgpDb3VsZCB5b3UgcGxlYXNlIGVsYWJvcmF0ZSB3aGF0
IG90aGVyIGRldmljZXMgeW91IGVudmlzaW9uIGVtaXR0aW5nIAoiVGhpcyBWTSB3YXMgY2xvbmVk
LCB5b3UgTUFDIGFkZHJlc3MgbWF5IG5vdyBjb2xsaWRlIiBzdHlsZSBldmVudHM/CgpXaGF0IHdl
IHRhbGtlZCBhYm91dCBhdCBMUEMgd2FzIGFuIG9ydGhvZ29uYWwgaW50ZXJmYWNlIHRoYXQgYWxs
b3dzIHVzZXIgCnNwYWNlIHRvIHJlY2VpdmUgcmVzZWVkIGV2ZW50cyB3aGVuIGVpdGhlciB0aGUg
a2VybmVsLCBhbiBSTkcgZGV2aWNlIG9yIAphbnl0aGluZyBlbHNlIGluIHRoZSBzeXN0ZW0gd2Fu
dHMgdG8gc2F5ICJZb3VyIGNhY2hlZCByYW5kb21uZXNzIG1heSBiZSAKY29tcHJvbWlzZWQsIHBs
ZWFzZSBmZXRjaCBzb21lIG5ldyIuCgpUaGlzIHBhdGNoIGlzIG5vdCB0aGF0IGludGVyZmFjZS4g
SXQncyBhbiBldmVudCBtZWFudCBmb3Igc3lzdGVtZCAoYW5kIApvdGhlciBzeXN0ZW0gc29mdHdh
cmUpIHRvIGtub3cgZXhjbHVzaXZlbHkgYWJvdXQgVk0gY2xvbmUgZXZlbnRzLiBUaGF0IApzeXN0
ZW0gc29mdHdhcmUgY2FuIG5vdCB1c2UgdGhlIHJlc2VlZCBldmVudCBhYm92ZTogSnVzdCBpbWFn
aW5lIGdldHRpbmcgCmEgbmV3IE1BQyBhZGRyZXNzIGV2ZXJ5IDUgbWludXRlcy4gU28gaGVyZSB3
ZSByZWFsbHkganVzdCB3YW50IHRvIGtub3cgCnRoZSB2bWdlbmlkIGNoYW5nZWQsIG5vIG1vcmUs
IG5vIGxlc3MuCgoKQWxleAoKCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdt
YkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0
aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQg
Q2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERF
IDI4OSAyMzcgODc5CgoK

