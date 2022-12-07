Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD48646457
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 23:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiLGWyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 17:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiLGWyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 17:54:41 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DDB63DD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 14:54:40 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id md9-20020a17090b23c900b00218fa3308a9so14500560pjb.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 14:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2cCrJ2T3lsz5o645qE6JJwrkYwd4cRkkzCyLadpkJHU=;
        b=dJfLG8m04CTQ6CvoSKcsgLa31EDZGf97ccACDsHTBAWfJl6AuvowVlpYzBl74Vvb3o
         Jf/AqYw/vpJKlODPivcr2wm82oAWUYLxtnjGM4smoxLGSgJzCcvSWVCHMlgDAMl4Oq9H
         c6QF4Emmya8idJ+iZu99+vLXKrsjJKofoUBlzHIeatfZhxA4nPB4YAx/NWTyHZS2LebR
         hPQFW9TThLdmBN9t2HM66z8pRKTN6I+wso4Ok+otmt0Nj0rMUpHXWk1WYEHU4ZodlyBH
         jfEOBL9/A9v1eDScs1FkxIaIxhH4KQdNaZygarJWfKkYInDeeMotvGKCIeCpIo16S1Bt
         DHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2cCrJ2T3lsz5o645qE6JJwrkYwd4cRkkzCyLadpkJHU=;
        b=aYOJ5onWPmcwasCfAg+J5qXbaTRDQV4RDIPP+bTO4nqHzsSiTfbrgFA2OKzeZlapEf
         lR8nmDNfpAtPOXzf6RhcnVJkeGh9dKgOLIpAYjXP+kEIjSPhK0waZyQqJOwzlFtvqmp5
         1s6OrumXwnQVQwIuz29vACZWnTWwcZj25395OupEjNR24ZC3/Kci9eYbGTn9ILnPS++1
         fvuN7VCzAGL6YQBOEeA+1aY90T24DQuTRPRM64Vu66z6urNXva6tE+eGGYp/hMVgt4Nf
         OHlvX/eP8R94bZY1Mmxk0iFRdWAeepXe2Wbiy8LCky+StaW35nfqN4FU3N5FrpZ8Q08A
         kIsQ==
X-Gm-Message-State: ANoB5plNPTrybnXDw1bKLaV+UuE5aPV9sJY1oEFEVG/8SJaRHooneeZ5
        +lT1SV+Zs8xL9newvLiWnZlQPqRB2ku+VM0=
X-Google-Smtp-Source: AA0mqf6DBm6e3QSCALqkUAlh3auJURtxVQs/yPcQcT3b8nOXfANrJS/mqxAzld6bRi/s9zuK+ySM5W2FIellBbo=
X-Received: from lixiaoyan-desktop.svl.corp.google.com ([2620:15c:2c4:201:4f64:90f:3bcd:e820])
 (user=lixiaoyan job=sendgmr) by 2002:aa7:954d:0:b0:576:f9e2:a968 with SMTP id
 w13-20020aa7954d000000b00576f9e2a968mr15819671pfq.84.1670453679904; Wed, 07
 Dec 2022 14:54:39 -0800 (PST)
Date:   Wed,  7 Dec 2022 14:54:34 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221207225435.1273226-1-lixiaoyan@google.com>
Subject: [PATCH net-next v5 1/2] IPv6/GRO: generic helper to remove temporary
 HBH/jumbo header in driver
From:   Coco Li <lixiaoyan@google.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Michael Chan <michael.chan@broadcom.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Coco Li <lixiaoyan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPv6/TCP and GRO stacks can build big TCP packets with an added
temporary Hop By Hop header.

Is GSO is not involved, then the temporary header needs to be removed in
the driver. This patch provides a generic helper for drivers that need
to modify their headers in place.

Tested:
Compiled and ran with ethtool -K eth1 tso off
Could send Big TCP packets

Signed-off-by: Coco Li <lixiaoyan@google.com>
---
 include/net/ipv6.h     | 36 ++++++++++++++++++++++++++++++++++++
 net/ipv6/ip6_offload.c | 27 ++++-----------------------
 2 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index d383c895592a..6dcf93a1ec14 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -500,6 +500,42 @@ static inline int ipv6_has_hopopt_jumbo(const struct sk_buff *skb)
 	return jhdr->nexthdr;
 }
 
+/* Return 0 if HBH header is successfully removed
+ * Or if HBH removal is unnecessary (packet is not big TCP)
+ * Return error to indicate dropping the packet
+ */
+static inline int ipv6_hopopt_jumbo_remove(struct sk_buff *skb)
+{
+	const int hophdr_len = sizeof(struct hop_jumbo_hdr);
+	int nexthdr = ipv6_has_hopopt_jumbo(skb);
+	struct ipv6hdr *h6;
+
+	if (!nexthdr)
+		return 0;
+
+	if (skb_cow_head(skb, 0))
+		return -1;
+
+	/* Remove the HBH header.
+	 * Layout: [Ethernet header][IPv6 header][HBH][L4 Header]
+	 */
+	memmove(skb_mac_header(skb) + hophdr_len, skb_mac_header(skb),
+		skb_network_header(skb) - skb_mac_header(skb) +
+		sizeof(struct ipv6hdr));
+
+	if (unlikely(!pskb_may_pull(skb, hophdr_len)))
+		return -1;
+
+	__skb_pull(skb, hophdr_len);
+	skb->network_header += hophdr_len;
+	skb->mac_header += hophdr_len;
+
+	h6 = ipv6_hdr(skb);
+	h6->nexthdr = nexthdr;
+
+	return 0;
+}
+
 static inline bool ipv6_accept_ra(struct inet6_dev *idev)
 {
 	/* If forwarding is enabled, RA are not accepted unless the special
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 3ee345672849..00dc2e3b0184 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -77,7 +77,7 @@ static struct sk_buff *ipv6_gso_segment(struct sk_buff *skb,
 	struct sk_buff *segs = ERR_PTR(-EINVAL);
 	struct ipv6hdr *ipv6h;
 	const struct net_offload *ops;
-	int proto, nexthdr;
+	int proto, err;
 	struct frag_hdr *fptr;
 	unsigned int payload_len;
 	u8 *prevhdr;
@@ -87,28 +87,9 @@ static struct sk_buff *ipv6_gso_segment(struct sk_buff *skb,
 	bool gso_partial;
 
 	skb_reset_network_header(skb);
-	nexthdr = ipv6_has_hopopt_jumbo(skb);
-	if (nexthdr) {
-		const int hophdr_len = sizeof(struct hop_jumbo_hdr);
-		int err;
-
-		err = skb_cow_head(skb, 0);
-		if (err < 0)
-			return ERR_PTR(err);
-
-		/* remove the HBH header.
-		 * Layout: [Ethernet header][IPv6 header][HBH][TCP header]
-		 */
-		memmove(skb_mac_header(skb) + hophdr_len,
-			skb_mac_header(skb),
-			ETH_HLEN + sizeof(struct ipv6hdr));
-		skb->data += hophdr_len;
-		skb->len -= hophdr_len;
-		skb->network_header += hophdr_len;
-		skb->mac_header += hophdr_len;
-		ipv6h = (struct ipv6hdr *)skb->data;
-		ipv6h->nexthdr = nexthdr;
-	}
+	err = ipv6_hopopt_jumbo_remove(skb);
+	if (err)
+		return ERR_PTR(err);
 	nhoff = skb_network_header(skb) - skb_mac_header(skb);
 	if (unlikely(!pskb_may_pull(skb, sizeof(*ipv6h))))
 		goto out;
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

