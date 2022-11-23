Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942486369B8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239609AbiKWTQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239728AbiKWTQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:16:32 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C94C5611
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:16:31 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-37360a6236fso175901717b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X97CaIo508IuewzPhurtDZScOLGwj1jfW1Uvg0x2Gcc=;
        b=FHWwtiQNvy7LXVX5r2hmXUm2NChPmeQc8EC2GwExWP95KYacmbh1RS0fFSCWKRhcwl
         fjfuiKHMrGkmvZsz4LHOVQLer203z1ekyo5pyPQZRLkR7rVsE9HAEy3+bqcIcIYsaGVr
         4uxnio8pONXGIZXDIgCA0VBhA27uA60ZDm0ru6p3nstKwlgvX7uIeE0rJtEFJMgJ+kiM
         DLc306NYw8LHhIRXqiaH22anU5AqYomy8orX8NzPQRcYcDpQR5+0rmErEkaa15co2oJU
         2amK0DiknwOE2PEwNRnzfEuEEFDtNXTt4LGCRTYfFJD8ntK6NmMDfBbnP6PaEKzbVMRg
         IFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X97CaIo508IuewzPhurtDZScOLGwj1jfW1Uvg0x2Gcc=;
        b=hxZ9ZyAOWl/LHtujfoeA5pd2SkktTazC+3RMglsjCDq/dQg9o94G87pEyoDicEsjl9
         LyNznMjqPdf60CFTVhEo8nBGv3jfrA8PNfMKMjr6MdeVobUYMcSpFta2wqF9q7XlKqFz
         +9vhJFLr+DMLdY1loR9k5hq50igQXLEKjBuMuN9hYvdMrJgsONsjU2TmCfQ+x0TX87AM
         JebtYpXFlpSTfT6R8vdcg/MN0woaGseF7sveFlMxpn3xU66QXubl0rBbQtKqUIr1g+bc
         6pQm22lZxSc/PjqQIK9W04DlB5hFc25/lqdvt3W5l+nNkSDJYQ6CjXPT/oH2IZmaPrmm
         0SWw==
X-Gm-Message-State: ANoB5pllOuvIuAwk0NM5w8SfdjH/W0WyXJuVtdiUCUHMq0L7eRgLipVy
        mld6HBy2YxOx/ineJm9bejtP7Hsr/u4RdJA=
X-Google-Smtp-Source: AA0mqf7e9GG6/HE6k7eL4JRy6eIJnJmXenNtjzwdXuglYlZ3DFr2L+LapfmBRDIyIkG7kiqIOpxCoUy18/VSf5E=
X-Received: from lixiaoyan-desktop.svl.corp.google.com ([2620:15c:2c4:201:d403:2d3e:7222:9b9c])
 (user=lixiaoyan job=sendgmr) by 2002:a81:4ec8:0:b0:3b1:ef5d:ab0d with SMTP id
 c191-20020a814ec8000000b003b1ef5dab0dmr2629055ywb.43.1669230990603; Wed, 23
 Nov 2022 11:16:30 -0800 (PST)
Date:   Wed, 23 Nov 2022 11:16:26 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221123191627.3442831-1-lixiaoyan@google.com>
Subject: [PATCH net-next v2 1/2] IPv6/GRO: generic helper to remove temporary
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

Signed-off-by: Coco Li <lixiaoyan@google.com>
---
 include/net/ipv6.h     | 36 ++++++++++++++++++++++++++++++++++++
 net/ipv6/ip6_offload.c | 26 ++++----------------------
 2 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index d383c895592a..c5a1daaf5056 100644
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
+	int err = 0;
+
+	if (!nexthdr)
+		return err;
+
+	err = skb_cow_head(skb, 0);
+	if (err)
+		return err;
+
+	/* Remove the HBH header.
+	 * Layout: [Ethernet header][IPv6 header][HBH][L4 Header]
+	 */
+	memmove(skb_mac_header(skb) + hophdr_len, skb_mac_header(skb),
+		skb_network_header(skb) - skb_mac_header(skb) +
+		sizeof(struct ipv6hdr));
+
+	skb->data += hophdr_len;
+	skb->len -= hophdr_len;
+	skb->network_header += hophdr_len;
+	skb->mac_header += hophdr_len;
+
+	h6 = ipv6_hdr(skb);
+	h6->nexthdr = nexthdr;
+
+	return err;
+}
+
 static inline bool ipv6_accept_ra(struct inet6_dev *idev)
 {
 	/* If forwarding is enabled, RA are not accepted unless the special
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 3ee345672849..60a82342fe57 100644
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
@@ -87,28 +87,10 @@ static struct sk_buff *ipv6_gso_segment(struct sk_buff *skb,
 	bool gso_partial;
 
 	skb_reset_network_header(skb);
-	nexthdr = ipv6_has_hopopt_jumbo(skb);
-	if (nexthdr) {
-		const int hophdr_len = sizeof(struct hop_jumbo_hdr);
-		int err;
+	err = ipv6_hopopt_jumbo_remove(skb);
+	if (err)
+		return ERR_PTR(err);
 
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
 	nhoff = skb_network_header(skb) - skb_mac_header(skb);
 	if (unlikely(!pskb_may_pull(skb, sizeof(*ipv6h))))
 		goto out;
-- 
2.38.1.584.g0f3c55d4c2-goog

