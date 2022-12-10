Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF8D648D1F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 05:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiLJERf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 23:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiLJERK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 23:17:10 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E1076153
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 20:16:50 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id j18-20020a170902da9200b00189b3b16addso5740800plx.23
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 20:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C6RTbmmSkPOFm902+mLMHGPXN9xcjb04HtLDqi+Zh0c=;
        b=BvO0Vvnynj96CFRnXCmTlxB2yUgmetu/LkyKo83qxWb7GC5KxrSYBwHscaynK6luPu
         sfvKOizMxzBtaEwMS0MrAG7ys4gWlbeE5d4PvbpEsoQCEGAnVrvs9UqIq1L3dvTrVmB4
         sxsoQzAV/K+9upPPpNXGaO513a6HTYhNAxZE8pd+mI/YOhOvgCm+Vxajs5j72RwQw1dS
         n77gzfpXonUFXlPYp7Yw3hO3zxu6aAu/cA7uyc05gF7uVoanoRiL2iIvWzicf+NFB4cl
         rypFBaVwhkN3QK5DFXDvbUHguHVLeAwQNDU8aBKYG77ZN0udlOg8YJD3P/0p6ZWf6nS+
         vNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C6RTbmmSkPOFm902+mLMHGPXN9xcjb04HtLDqi+Zh0c=;
        b=CSAalrlxyLsOsrOYux5NjIZ7HNe7WmBXBy1atjokNpF0AvOw386+ifX/Jl9V34fea9
         /XoMfTlDaXrj9j8tcKeMenCMaIonAGN2vRSSXPDZExI6BBVvL5wYW0AREKHcC2cBu1MK
         /106MpkgjPGTOoujwV+izkZZDfYMSFurmQS7NF6etbPXQ7MGi1W+on6MuLRnuzmg1GA8
         uWtP/aNzls0Uje5vbNvcnEIoAiEs/bcooJJsTjrQuGeUJFGkLa9Ibe7MIZZlhL5UBTMi
         wlCQqDt6J/gzh07YvP04cnwdCm7YrfD9B7+JDTg7sIwZj+u/fTtlvCx4Aqvtg3DRG/K6
         ej1Q==
X-Gm-Message-State: ANoB5pnfjAYMCuSN9QrUjI0gy2lzhn4atsvRsOByhK4ko2QX4i6i2sMf
        iWh1aDWkfii4DV8gJ1We9wpNvJktaI+hEtU=
X-Google-Smtp-Source: AA0mqf5ReNfWId0H/gPB/QbbYUelHRoprIljtlKARcNQUX7xC3FBUYq9e6dGGf3dNWwFpgfcxul4j4LTOBFxFLw=
X-Received: from coco0920.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:5738])
 (user=lixiaoyan job=sendgmr) by 2002:a17:90a:2a88:b0:220:1f03:129b with SMTP
 id j8-20020a17090a2a8800b002201f03129bmr28851pjd.0.1670645809623; Fri, 09 Dec
 2022 20:16:49 -0800 (PST)
Date:   Sat, 10 Dec 2022 04:16:45 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221210041646.3587757-1-lixiaoyan@google.com>
Subject: [PATCH net-next v6 1/2] IPv6/GRO: generic helper to remove temporary
 HBH/jumbo header in driver
From:   Coco Li <lixiaoyan@google.com>
To:     "David S . Miller" <davem@davemloft.net>,
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
 include/net/ipv6.h     | 33 +++++++++++++++++++++++++++++++++
 net/ipv6/ip6_offload.c | 27 ++++-----------------------
 2 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index d383c895592a..03f3af02a9a6 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -500,6 +500,39 @@ static inline int ipv6_has_hopopt_jumbo(const struct sk_buff *skb)
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
2.39.0.rc1.256.g54fd8350bd-goog

