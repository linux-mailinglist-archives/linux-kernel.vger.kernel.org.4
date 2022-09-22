Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB68C5E6A5A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 20:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiIVSGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 14:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiIVSGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 14:06:05 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09472A72F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1663869964; x=1695405964;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=eou0ikRWzj/VkLZJkdubOcpKqZ/XCCFJnONZ7TErgO4=;
  b=JQdTEfAVwr71Mrcx8LCh4ZKOhPCxRACiATv18VQKfJUjyC2XQuV5bblC
   X56+PBJOUvt7Wbib7OiDchdo+ezLUNx3+1wSgJn6NrVwlcAcNo78/xxkv
   SBQTc0AmdY9hEFGl45fBc+Zzto4XaPAA4dfwWocvM4WW565Uqwz+PXlIu
   A=;
Subject: Re: [PATCH] nvme-pci: Set min align mask before calculating max_hw_sectors
Thread-Topic: [PATCH] nvme-pci: Set min align mask before calculating max_hw_sectors
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1box-d-0e176545.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 18:06:03 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1box-d-0e176545.us-east-1.amazon.com (Postfix) with ESMTPS id DA6B08927D;
        Thu, 22 Sep 2022 18:06:01 +0000 (UTC)
Received: from EX19D012UWC002.ant.amazon.com (10.13.138.165) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Thu, 22 Sep 2022 18:06:01 +0000
Received: from EX19D002UWC004.ant.amazon.com (10.13.138.186) by
 EX19D012UWC002.ant.amazon.com (10.13.138.165) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Thu, 22 Sep 2022 18:06:01 +0000
Received: from EX19D002UWC004.ant.amazon.com ([fe80::f92f:5ec1:6ed3:7754]) by
 EX19D002UWC004.ant.amazon.com ([fe80::f92f:5ec1:6ed3:7754%4]) with mapi id
 15.02.1118.012; Thu, 22 Sep 2022 18:06:01 +0000
From:   "Bhatnagar, Rishabh" <risbhat@amazon.com>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "Bacco, Mike" <mbacco@amazon.com>
Thread-Index: AQHYzSXrGcZlfkaEIUSpSTnvXbRMzq3piRAAgAFtQICAAFX8AA==
Date:   Thu, 22 Sep 2022 18:06:00 +0000
Message-ID: <529ACE8D-95AF-46D6-B449-30C7AD815AEC@amazon.com>
References: <20220920191932.22797-1-risbhat@amazon.com>
 <871c0e19-9272-e92b-28dc-a50ae705bba8@grimberg.me>
 <20220922055815.GA27619@lst.de>
In-Reply-To: <20220922055815.GA27619@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.43.161.179]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5AC30DBE291D64C9C786C65323948CE@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDkvMjEvMjIsIDEwOjU4IFBNLCAiQ2hyaXN0b3BoIEhlbGx3aWciIDxoY2hAbHN0
LmRlPiB3cm90ZToNCg0KICAgIENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91
dHNpZGUgb2YgdGhlIG9yZ2FuaXphdGlvbi4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdSBjYW4gY29uZmlybSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBj
b250ZW50IGlzIHNhZmUuDQoNCg0KDQogICAgT24gV2VkLCBTZXAgMjEsIDIwMjIgYXQgMTE6MTA6
NThBTSArMDMwMCwgU2FnaSBHcmltYmVyZyB3cm90ZToNCiAgICA+DQogICAgPj4gSWYgc3dpb3Rs
YiBpcyBmb3JjZSBlbmFibGVkIGRtYV9tYXhfbWFwcGluZ19zaXplIGVuZHMgdXAgY2FsbGluZw0K
ICAgID4+IHN3aW90bGJfbWF4X21hcHBpbmdfc2l6ZSB3aGljaCB0YWtlcyBpbnRvIGFjY291bnQg
dGhlIG1pbiBhbGlnbg0KICAgID4+IG1hc2sgZm9yIHRoZSBkZXZpY2UuDQogICAgPj4gU2V0IHRo
ZSBtaW4gYWxpZ24gbWFzayBmb3IgbnZtZSBkcml2ZXIgYmVmb3JlIGNhbGxpbmcNCiAgICA+PiBk
bWFfbWF4X21hcHBpbmdfc2l6ZSB3aGlsZSBjYWxjdWxhdGluZyBtYXggaHcgc2VjdG9ycy4NCiAg
ICA+DQogICAgPiBEb2VzIHRoaXMgZml4IGEgc3BlY2lmaWMgYnVnPyBpZiBzbyBpdCBuZWVkcyBh
IGZpeGVzIHRhZyBzbyBpdCBjYW4NCiAgICA+IGdvIHRvIHN0YWJsZSBiYWNrcG9ydHMgYXMgd2Vs
bC4NCg0KICAgIEhtbS4gIEJhc2ljYWxseSB0aGlzIGlzIGFub3RoZXIgZml4bGV0IGZvciBudm1l
IG9uIHN3aW90bGIsIHdoaWNoDQogICAgYWxyZWFkeSBkcm92ZSBhZGRpbmcgdGhlIG1heF9tYXBw
aW5nIHNpemUgYW5kIHRoZSBhbGlnbl9tYXNrLCBhbmQNCiAgICBpdCBzZWVtcyB3ZSBzdGlsbCBo
YWRuJ3QgY292ZXJlZCBhbGwgY29ybmVyIGNhc2VzIHByb3Blcmx5LiAgU28NCiAgICBJIHRoaW5r
IGl0IGJhc2ljYWxseSBoYXMgYmVlbiBicm9rZW4gc2luY2UgZGF5IDEsIGJ1dCBudm1lIG9uDQog
ICAgc3dpb3RsYiBvbmx5IHN0YXJ0ZWQgYmVjb21pbmcgImludGVyZXN0aW5nIiB3aXRoIHRoZSB0
cnVzdGVkDQogICAgaHlwZXJ2aXNvciBzY2hlbWVzLg0KDQpZZXMgdGhpcyBmaXhlcyBhIGJ1ZyB0
aGF0IHdlIHNhdyBpbiBudm1lIGRyaXZlcihhZnRlciBlbmFibGluZyBzd2lvdGxiKSB0aGF0IHJl
c2VtYmxlcyB3aGF0IHdhcw0KZml4ZWQgaW4gODI4MDY3NDRmZDdkZGU2MDNiNjRjMTUxZWVkZGFh
NGVlNjIxOTNmZC4gQnV0IG5vdCBzZXR0aW5nIHRoZQ0KbWluX2FsaWduX21hc2sgYmVmb3JlIGRl
cml2aW5nIG1heCBodyBzZWN0b3JzIHdhcyBjYXVzaW5nIHRoZSBidWcgdG8gc3RpbGwgZXhpc3Qu
DQpBbHNvIHdlIHdvdWxkIHByb2JhYmx5IG5lZWQgdG8gYmFja3BvcnQgdGhlIGFib3ZlIGZpeCBh
bG9uZyB3aXRoICg4MjgwNjc0NGZkN2RkZTYwM2I2NGMxNTFlZWRkYWE0ZWU2MjE5M2ZkKQ0KdG8g
NS4xMCBhbmQgNS4xNSBrZXJuZWxzLiBMZXQgbWUga25vdyB3aGF0IHlvdSB0aGluayBpcyB0aGUg
YmVzdCB3YXkgdG8gYWNoaWV2ZSB0aGF0Lg0KDQo=
