Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604F8741DD9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 03:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjF2B7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 21:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjF2B7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 21:59:10 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08982681;
        Wed, 28 Jun 2023 18:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1688003949; x=1719539949;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z5ADgpgRcm7ildcG3JRpr/Zcwf95I9lu4+eIDLt2QIQ=;
  b=hikrSbtCH2THGVDVNMfIqYzS9KMdkZyiZeAZi4CmawK2tsOoglkgKkmu
   +rG3RFSzU2z0j0nTjY8aIyZ1bMcjClPUwfnxXOnw84XJxPV8XH/XC2NFs
   uGHf0PSHvShuz/cQ/N6T8eNnEVdOTT3REL6JCNYxUrd1QK841dvZIlQtd
   E=;
X-IronPort-AV: E=Sophos;i="6.01,167,1684800000"; 
   d="scan'208";a="348439320"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-1cca8d67.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 01:59:09 +0000
Received: from EX19MTAUWA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-m6i4x-1cca8d67.us-west-2.amazon.com (Postfix) with ESMTPS id 24CC08064F;
        Thu, 29 Jun 2023 01:59:08 +0000 (UTC)
Received: from EX19D001UWA002.ant.amazon.com (10.13.138.236) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 29 Jun 2023 01:59:07 +0000
Received: from u46989501580c5c.ant.amazon.com (10.88.130.162) by
 EX19D001UWA002.ant.amazon.com (10.13.138.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 29 Jun 2023 01:59:06 +0000
From:   Samuel Mendoza-Jonas <samjonas@amazon.com>
To:     <netdev@vger.kernel.org>
CC:     Stewart Smith <trawets@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <benh@amazon.com>,
        <stable@vger.kernel.org>,
        Samuel Mendoza-Jonas <samjonas@amazon.com>
Subject: [PATCH net] net/ipv6: Reduce chance of collisions in inet6_hashfn()
Date:   Wed, 28 Jun 2023 18:58:44 -0700
Message-ID: <20230629015844.800280-1-samjonas@amazon.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.88.130.162]
X-ClientProxiedBy: EX19D041UWA002.ant.amazon.com (10.13.139.121) To
 EX19D001UWA002.ant.amazon.com (10.13.138.236)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stewart Smith <trawets@amazon.com>

For both IPv4 and IPv6 incoming TCP connections are tracked in a hash
table with a hash over the source & destination addresses and ports.
However, the IPv6 hash is insufficient and can lead to a high rate of
collisions.

The IPv6 hash used an XOR to fit everything into the 96 bits for the
fast jenkins hash, meaning it is possible for an external entity to
ensure the hash collides, thus falling back to a linear search in the
bucket, which is slow.

We take the approach of hash half the data; hash the other half; and
then hash them together. We do this with 3x jenkins hashes rather than
2x to calculate the hashing value for the connection covering the full
length of the addresses and ports.

While this may look like it adds overhead, the reality of modern CPUs
means that this is unmeasurable in real world scenarios.

In simulating with llvm-mca, the increase in cycles for the hashing code
was ~5 cycles on Skylake (from a base of ~50), and an extra ~9 on
Nehalem (base of ~62).

In commit dd6d2910c5e0 ("netfilter: conntrack: switch to siphash")
netfilter switched from a jenkins hash to a siphash, but even the faster
hsiphash is a more significant overhead (~20-30%) in some preliminary
testing. So, in this patch, we keep to the more conservative approach to
ensure we don't add much overhead per SYN.

In testing, this results in a consistently even spread across the
connection buckets. In both testing and real-world scenarios, we have
not found any measurable performance impact.

Cc: stable@vger.kernel.org
Fixes: 08dcdbf6a7b9 ("ipv6: use a stronger hash for tcp")
Fixes: b3da2cf37c5c ("[INET]: Use jhash + random secret for ehash.")
Signed-off-by: Stewart Smith <trawets@amazon.com>
Signed-off-by: Samuel Mendoza-Jonas <samjonas@amazon.com>
---
 include/net/ipv6.h          | 4 +---
 net/ipv6/inet6_hashtables.c | 5 ++++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 7332296eca44..f9bb54869d82 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -752,9 +752,7 @@ static inline u32 ipv6_addr_hash(const struct in6_addr *a)
 /* more secured version of ipv6_addr_hash() */
 static inline u32 __ipv6_addr_jhash(const struct in6_addr *a, const u32 initval)
 {
-	u32 v = (__force u32)a->s6_addr32[0] ^ (__force u32)a->s6_addr32[1];
-
-	return jhash_3words(v,
+	return jhash_3words((__force u32)a->s6_addr32[1],
 			    (__force u32)a->s6_addr32[2],
 			    (__force u32)a->s6_addr32[3],
 			    initval);
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index b64b49012655..bb7198081974 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -33,7 +33,10 @@ u32 inet6_ehashfn(const struct net *net,
 	net_get_random_once(&inet6_ehash_secret, sizeof(inet6_ehash_secret));
 	net_get_random_once(&ipv6_hash_secret, sizeof(ipv6_hash_secret));
 
-	lhash = (__force u32)laddr->s6_addr32[3];
+	lhash = jhash_3words((__force u32)laddr->s6_addr32[3],
+			    (((u32)lport) << 16) | (__force u32)fport,
+			    (__force u32)faddr->s6_addr32[0],
+			    ipv6_hash_secret);
 	fhash = __ipv6_addr_jhash(faddr, ipv6_hash_secret);
 
 	return __inet6_ehashfn(lhash, lport, fhash, fport,
-- 
2.25.1

