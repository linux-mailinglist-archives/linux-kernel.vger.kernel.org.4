Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84656648D21
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 05:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiLJERw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 23:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiLJERO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 23:17:14 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA917D048
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 20:16:54 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-368994f4bc0so72605337b3.14
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 20:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3UTBim1uEt5vwLtdAODs9aBiC6oBtXfrCv1Q8xSciis=;
        b=DuDJzLEwS3xTDGNyqym6VVKk54sQ3nETwyWPzdzBcNrIf00cWsfHMR+/zaPff76MQz
         79J4NxEyqJdt00Wg0n1HnbqNCm3oJXDd0v2/gyWdD7yrKQFs4jh+1wAnM8t6yjtn9+lL
         OkJWaZRoWZbvg6rW68weTAFLo6sZ9x9upeidKLIa6tGBUdrJ1GfqsxAFCVTJq049r9Z6
         kud6/07RaSLYhwU9Fiaya9eVzSfKOpxmVLXu7ESnZuWsktIVQP6xQvZEGXxE4W+x0L7s
         K5hKgilMDhsZZGkg9JXF6NI/g23CkOck0yjE9uSulTQSMdl++bPg2qJqyKY3Tlzln0Mo
         ++Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3UTBim1uEt5vwLtdAODs9aBiC6oBtXfrCv1Q8xSciis=;
        b=xvBl2/48BKaX1H9J01IPqsU8vSSfyMttkY2Mtp0Wxzs1VCyMGDOh3ykRVy6pF8JHCC
         nYhXunQkHnEKfPux4iUBWqFzTnHyPRjadTT76N7TkjFxQNwXe1oaBLK4JJJtP7d4ctQd
         9AmwhFeg98RXw0V9luuf5zqujSxQoZ1An44Gb3O75ZTyxCiEBKQkBU/p9Srxc96afg34
         3NnSMafFiuY/m8L0LjV+BWTm+rRhwl5gJc5ktZSEidwH5hwlCHiO1jCUIRbV0GQes6vm
         aOWRf6FYJRiDigz25GCNfHdx0w9rNsuXdalUyGM86cXsEbgmX06vIUpYefM0MI9FLpiX
         oWWw==
X-Gm-Message-State: ANoB5pnbbtR1b6nOjgxiBhZyvGA6zDA04NDPtKNi68UJsrgWfKpGp/bo
        rWupQmEc8T9Wl7WBEV7vlMvZnuuCp42Tcys=
X-Google-Smtp-Source: AA0mqf4TRvmaNXc7+g7T3l3NU+X5ZvzAPWEXKCZuO46m91qMGdtG9qmW0Sk7e8UhKpmIkC1v9+65TL7JbmxiKU4=
X-Received: from coco0920.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:5738])
 (user=lixiaoyan job=sendgmr) by 2002:a25:ad97:0:b0:6fa:bac8:c9c1 with SMTP id
 z23-20020a25ad97000000b006fabac8c9c1mr36779951ybi.477.1670645813372; Fri, 09
 Dec 2022 20:16:53 -0800 (PST)
Date:   Sat, 10 Dec 2022 04:16:46 +0000
In-Reply-To: <20221210041646.3587757-1-lixiaoyan@google.com>
Mime-Version: 1.0
References: <20221210041646.3587757-1-lixiaoyan@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221210041646.3587757-2-lixiaoyan@google.com>
Subject: [RFC net-next v6 2/2] bnxt: Use generic HBH removal helper in tx path
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

Eric Dumazet implemented Big TCP that allowed bigger TSO/GRO packet sizes
for IPv6 traffic. See patch series:
'commit 89527be8d8d6 ("net: add IFLA_TSO_{MAX_SIZE|SEGS} attributes")'

This reduces the number of packets traversing the networking stack and
should usually improves performance. However, it also inserts a
temporary Hop-by-hop IPv6 extension header.

Using the HBH header removal method in the previous patch, the extra header
be removed in bnxt drivers to allow it to send big TCP packets (bigger
TSO packets) as well.

Tested:
Compiled locally

To further test functional correctness, update the GSO/GRO limit on the
physical NIC:

ip link set eth0 gso_max_size 181000
ip link set eth0 gro_max_size 181000

Note that if there are bonding or ipvan devices on top of the physical
NIC, their GSO sizes need to be updated as well.

Then, IPv6/TCP packets with sizes larger than 64k can be observed.

Signed-off-by: Coco Li <lixiaoyan@google.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 26 ++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 9f8a6ce4b356..b281091a1b1d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -389,6 +389,9 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 			return NETDEV_TX_BUSY;
 	}
 
+	if (unlikely(ipv6_hopopt_jumbo_remove(skb)))
+		goto tx_free;
+
 	length = skb->len;
 	len = skb_headlen(skb);
 	last_frag = skb_shinfo(skb)->nr_frags;
@@ -11283,6 +11286,7 @@ static bool bnxt_exthdr_check(struct bnxt *bp, struct sk_buff *skb, int nw_off,
 			      u8 **nextp)
 {
 	struct ipv6hdr *ip6h = (struct ipv6hdr *)(skb->data + nw_off);
+	struct hop_jumbo_hdr *jhdr;
 	int hdr_count = 0;
 	u8 *nexthdr;
 	int start;
@@ -11310,9 +11314,27 @@ static bool bnxt_exthdr_check(struct bnxt *bp, struct sk_buff *skb, int nw_off,
 
 		if (hdrlen > 64)
 			return false;
+
+		/* The ext header may be a hop-by-hop header inserted for
+		 * big TCP purposes. This will be removed before sending
+		 * from NIC, so do not count it.
+		 */
+		if (*nexthdr == NEXTHDR_HOP) {
+			if (likely(skb->len <= GRO_LEGACY_MAX_SIZE))
+				goto increment_hdr;
+
+			jhdr = (struct hop_jumbo_hdr *)hp;
+			if (jhdr->tlv_type != IPV6_TLV_JUMBO || jhdr->hdrlen != 0 ||
+			    jhdr->nexthdr != IPPROTO_TCP)
+				goto increment_hdr;
+
+			goto next_hdr;
+		}
+increment_hdr:
+		hdr_count++;
+next_hdr:
 		nexthdr = &hp->nexthdr;
 		start += hdrlen;
-		hdr_count++;
 	}
 	if (nextp) {
 		/* Caller will check inner protocol */
@@ -13633,6 +13655,8 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		dev->features &= ~NETIF_F_LRO;
 	dev->priv_flags |= IFF_UNICAST_FLT;
 
+	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
+
 #ifdef CONFIG_BNXT_SRIOV
 	init_waitqueue_head(&bp->sriov_cfg_wait);
 #endif
-- 
2.39.0.rc1.256.g54fd8350bd-goog

