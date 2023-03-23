Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F226C6E89
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjCWRTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCWRTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:19:14 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DC82686C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1679591953; x=1711127953;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N2xs9Le0FZa4sfemWsZ8c99myqbmUyGpmin5ty43DWU=;
  b=M+dejhQy3cD/sNH7bZpPWm5twRQ0eMXUQ6nGicLQUwr4HS3i0DZ0Dmpn
   I9/Kac8Q+lUwg5y1kJBBkixHxav8nDeHYe0WC5rdvEQBTnVvoXHIIqWcn
   BdoIoa/30rb1bwhWR4jGhFrrgshwJmxbPcY08sYBEkE6pnpxLOBsu5wx1
   s=;
X-IronPort-AV: E=Sophos;i="5.98,285,1673913600"; 
   d="scan'208";a="310619558"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-bbc6e425.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 17:19:09 +0000
Received: from EX19D014EUA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-m6i4x-bbc6e425.us-east-1.amazon.com (Postfix) with ESMTPS id D2C0488023;
        Thu, 23 Mar 2023 17:19:07 +0000 (UTC)
Received: from EX19D030EUB004.ant.amazon.com (10.252.61.33) by
 EX19D014EUA002.ant.amazon.com (10.252.50.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 23 Mar 2023 17:19:06 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D030EUB004.ant.amazon.com (10.252.61.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.24; Thu, 23 Mar 2023 17:19:05 +0000
Received: from dev-dsk-krckatom-1b-7b393aa4.eu-west-1.amazon.com
 (10.13.225.85) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25 via Frontend Transport; Thu, 23 Mar 2023 17:19:05 +0000
From:   Tomas Krcka <krckatom@amazon.de>
To:     <linux-mm@kvack.org>
CC:     Tomas Krcka <krckatom@amazon.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm: Be less noisy during memory hotplug
Date:   Thu, 23 Mar 2023 17:19:04 +0000
Message-ID: <20230323171904.14444-1-krckatom@amazon.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VHVybiBhIHByX2luZm8oKSBpbnRvIGEgcHJfZGVidWcoKSB0byBwcmV2ZW50IGRtZXNnIHNwYW1t
aW5nIG9uIHN5c3RlbXMKd2hlcmUgbWVtb3J5IGhvdHBsdWcgaXMgYSBmcmVxdWVudCBvcGVyYXRp
b24uCgpGaXhlczogOTY2Y2Y0NGY2MzdlICgibW06IGRlZmVyIFpPTkVfREVWSUNFIHBhZ2UgaW5p
dGlhbGl6YXRpb24gdG8gdGhlIHBvaW50IHdoZXJlIHdlIGluaXQgcGdtYXAiKQoKU3VnZ2VzdGVk
LWJ5OiBKYW4gSC4gU2Now7ZuaGVyciA8anNjaG9lbmhAYW1hem9uLmRlPgpTaWduZWQtb2ZmLWJ5
OiBUb21hcyBLcmNrYSA8a3Jja2F0b21AYW1hem9uLmRlPgotLS0KIG1tL3BhZ2VfYWxsb2MuYyB8
IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlm
ZiAtLWdpdCBhL21tL3BhZ2VfYWxsb2MuYyBiL21tL3BhZ2VfYWxsb2MuYwppbmRleCBhYzFmYzk4
NmFmNDQuLjE0ZDcwZjRlNmMwYSAxMDA2NDQKLS0tIGEvbW0vcGFnZV9hbGxvYy5jCisrKyBiL21t
L3BhZ2VfYWxsb2MuYwpAQCAtNjk1OSw3ICs2OTU5LDcgQEAgdm9pZCBfX3JlZiBtZW1tYXBfaW5p
dF96b25lX2RldmljZShzdHJ1Y3Qgem9uZSAqem9uZSwKIAkJCQkgICAgIGNvbXBvdW5kX25yX3Bh
Z2VzKGFsdG1hcCwgcGZuc19wZXJfY29tcG91bmQpKTsKIAl9CiAKLQlwcl9pbmZvKCIlcyBpbml0
aWFsaXNlZCAlbHUgcGFnZXMgaW4gJXVtc1xuIiwgX19mdW5jX18sCisJcHJfZGVidWcoIiVzIGlu
aXRpYWxpc2VkICVsdSBwYWdlcyBpbiAldW1zXG4iLCBfX2Z1bmNfXywKIAkJbnJfcGFnZXMsIGpp
ZmZpZXNfdG9fbXNlY3MoamlmZmllcyAtIHN0YXJ0KSk7CiB9CiAKLS0gCjIuMzkuMgoKCgoKQW1h
em9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcg
QmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4g
V2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJC
IDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4OSAyMzcgODc5CgoK

