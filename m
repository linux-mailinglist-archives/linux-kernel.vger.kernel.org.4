Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BB16B0A72
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjCHOFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjCHOFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:05:17 -0500
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865665C9C1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 06:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1678284158; x=1709820158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YsCrycNZVu9ajvbzg05TfrxqY/+XEILB7/x3zK+Cnls=;
  b=ZVIsPtDLPktKix9Fe1ywEHU2/mzeue4hF8wJOzIn/VNnmrm6Bup61Aht
   dhza0dsIrDPRC6WysLI4O3eo0E/3Qmj6rjVijYEw09dyLwOI1p9mzRk+7
   3JGyci7GtxbE9UH6v2OzxQBzDXrellnVPanQF75iF8w3Nibg7rD3rhEDk
   o=;
X-IronPort-AV: E=Sophos;i="5.98,244,1673913600"; 
   d="scan'208";a="316167520"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-e7094f15.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 14:02:09 +0000
Received: from EX19D012EUA003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-m6i4x-e7094f15.us-west-2.amazon.com (Postfix) with ESMTPS id 1399940D49;
        Wed,  8 Mar 2023 14:02:08 +0000 (UTC)
Received: from EX19D030EUB004.ant.amazon.com (10.252.61.33) by
 EX19D012EUA003.ant.amazon.com (10.252.50.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.24; Wed, 8 Mar 2023 14:02:06 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX19D030EUB004.ant.amazon.com (10.252.61.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.24;
 Wed, 8 Mar 2023 14:02:06 +0000
Received: from dev-dsk-krckatom-1b-7b393aa4.eu-west-1.amazon.com
 (10.13.225.85) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server (TLS) id 15.0.1497.45 via Frontend Transport; Wed, 8 Mar 2023 14:02:04
 +0000
From:   Tomas Krcka <krckatom@amazon.de>
To:     <robin.murphy@arm.com>
CC:     <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
        <joro@8bytes.org>, <krckatom@amazon.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <shameerali.kolothum.thodi@huawei.com>, <will@kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix event queue overflow acknowledgment
Date:   Wed, 8 Mar 2023 14:02:04 +0000
Message-ID: <20230308140204.83249-1-krckatom@amazon.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <8291b66d-b9b8-47c9-f5ed-a4e951c92154@arm.com>
References: <8291b66d-b9b8-47c9-f5ed-a4e951c92154@arm.com>
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

Pj4gV2hlbiBhbiBvdmVyZmxvdyBvY2N1cnMgaW4gdGhlIGV2ZW50IHF1ZXVlLCB0aGUgU01NVSB0
b2dnbGVzIG92ZXJmbG93Cj4+IGZsYWcgT1ZGTEcgaW4gdGhlIFBST0QgcmVnaXN0ZXIuCj4+IFRo
ZSBldnRxIHRocmVhZCBpcyBzdXBwb3NlZCB0byBhY2tub3dsZWRnZSB0aGUgb3ZlcmZsb3cgZmxh
ZyBieSB0b2dnbGluZwo+PiBmbGFnIE9WQUNLRkxHIGluIHRoZSBDT05TIHJlZ2lzdGVyLCBvdGhl
cndpc2UgdGhlIG92ZXJmbG93IGNvbmRpdGlvbiBpcwo+PiBzdGlsbCBhY3RpdmUgKE9WRkxHICE9
IE9WQUNLRkxHKS4KPj4KPj4gQ3VycmVudGx5IHRoZSBhY2tub3dsZWRnZSByZWdpc3RlciBpcyB0
b2dnbGVkIGFmdGVyIGNsZWFyaW5nIHRoZSBldmVudAo+PiBxdWV1ZSBidXQgaXMgbmV2ZXIgcHJv
cGFnYXRlZCB0byB0aGUgaGFyZHdhcmUuIEl0IHdvdWxkIGJlIGRvbmUgbmV4dAo+PiB0aW1lIHdo
ZW4gZXhlY3V0aW5nIGV2dHEgdGhyZWFkLgo+Pgo+PiBUaGUgU01NVSBzdGlsbCBhZGRzIGVsZW1l
bnRzIHRvIHRoZSBxdWV1ZSB3aGVuIHRoZSBvdmVyZmxvdyBjb25kaXRpb24gaXMKPj4gYWN0aXZl
IGJ1dCBhbnkgc3Vic2VxdWVudCBvdmVyZmxvdyBpbmZvcm1hdGlvbiBhZnRlciBjbGVhcmluZyB0
aGUgZXZlbnQKPj4gcXVldWUgd2lsbCBiZSBsb3N0Lgo+Pgo+PiBUaGlzIGNoYW5nZSBrZWVwcyB0
aGUgU01NVSBpbiBzeW5jIGFzIGl0J3MgZXhwZWN0ZWQgYnkgZGVzaWduLgo+Cj4gSWYgSSd2ZSB1
bmRlcnN0b29kIGNvcnJlY3RseSwgdGhlIHVwc2hvdCBvZiB0aGlzIGlzIHRoYXQgaWYgdGhlIHF1
ZXVlCj4gaGFzIG92ZXJmbG93ZWQgb25jZSwgYmVjb21lIGVtcHR5LCB0aGVuIHNvbWVob3cgZ29l
cyBmcm9tIGVtcHR5IHRvIGZ1bGwKPiBiZWZvcmUgd2UgbWFuYWdlIHRvIGNvbnN1bWUgYSBzaW5n
bGUgZXZlbnQsIHdlIHdvbid0IHByaW50IHRoZSAiZXZlbnRzCj4gbG9zdCIgbWVzc2FnZSBhIHNl
Y29uZCB0aW1lLgo+Cj4gSGF2ZSB5b3Ugc2VlbiB0aGlzIGhhcHBlbiBpbiBwcmFjdGljZT8gVEJI
IGlmIHRoZSBldmVudCBxdWV1ZSBldmVyCj4gb3ZlcmZsb3dzIGV2ZW4gb25jZSBpdCdzIGluZGlj
YXRpdmUgdGhhdCB0aGUgc3lzdGVtIGlzIGhvc2VkIGFueXdheSwgc28KPiBpdCdzIG5vdCBjbGVh
ciB0byBtZSB0aGF0IHRoZXJlJ3MgYW55IGdyZWF0IGxvc3Mgb2YgdmFsdWUgaW4gc29tZXRpbWVz
Cj4gZmFpbGluZyB0byByZXBlYXQgYSB3YXJuaW5nIGZvciBhIGNocm9uaWMgb25nb2luZyBvcGVy
YXRpb25hbCBmYWlsdXJlLgo+CgpZZXMsIEkgZGlkIHNlZSBpbiBwcmFjdGljZS4gQW5kIGl04oCZ
cyBub3QganVzdCBhYm91dCBsb29zaW5nIHN1YnNlcXVlbmNlIHdhcm5pbmcuClRoZSB3YXkgaG93
IGl04oCZcyBkb25lIG5vdyBrZWVwcyBpbmNvbnNpc3RlbnQgQ09OUyByZWdpc3RlciB2YWx1ZSBi
ZXR3ZWVuIFNNTVUgYW5kIHRoZSBrZXJuZWwKdW50aWwgYW55IG5ldyBldmVudCBoYXBwZW5zLiBU
aGUga2VybmVsIGRvZXNu4oCZdCBpbmZvcm0gU01NVSB0aGF0IHdlIGtub3cgYWJvdXQgdGhlIG92
ZXJmbG93CmFuZCBjb25zdW1pbmcgZXZlbnRzIGFzIGZhc3QgYXMgd2UgY2FuLgoKPiBJdCBjb3Vs
ZCBiZSBhcmd1ZWQgdGhhdCB3ZSBoYXZlIGEgc3VidGxlIGluY29uc2lzdGVuY3kgYmV0d2Vlbgo+
IGFybV9zbW11X2V2dHFfdGhyZWFkKCkgYW5kIGFybV9zbW11X3ByaXFfdGhyZWFkKCkgaGVyZSwg
YnV0IHRoZSBmYWN0IGlzCj4gdGhhdCB0aGUgRXZlbnQgcXVldWUgYW5kIFBSSSBxdWV1ZSAqZG8q
IGhhdmUgZGlmZmVyZW50IG92ZXJmbG93Cj4gYmVoYXZpb3Vycywgc28gaXQgY291bGQgZXF1YWxs
eSBiZSBhcmd1ZWQgdGhhdCBpbmNvbnNpc3RlbmN5IGluIHRoZSBjb2RlCj4gaGVscHMgcmVmbGVj
dCB0aGF0LiBGV0lXIEkgY2FuJ3Qgc2F5IEkgaGF2ZSBhIHN0cm9uZyBwcmVmZXJlbmNlIGVpdGhl
ciB3YXkuCgpGb3IgdGhlIGFyZ3VtZW50IHRoYXQgdGhlIGNvZGUgY2FuIHJlZmxlY3QgdGhlIGRp
ZmZlcmVuY2UuClRoZW4gdGhlIGNvbW1lbnQgJ1N5bmMgb3VyIG92ZXJmbG93IGZsYWcsIGFzIHdl
IGJlbGlldmUgd2UncmUgdXAgdG8gc3BlZWTigJkgaXMKYWxyZWFkeSBtaXNsZWFkaW5nLgoKVGhh
bmtzLgpCUiwKVG9tYXMKCgoKQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgK
S3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFu
IFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hh
cmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4
OSAyMzcgODc5CgoK

