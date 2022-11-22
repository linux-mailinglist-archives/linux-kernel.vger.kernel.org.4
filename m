Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F094763449F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 20:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbiKVTd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 14:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234830AbiKVTdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 14:33:04 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE8B1F2D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:32:51 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id u6-20020a170903124600b00188cd4769bcso12174612plh.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N4Pb5W255LH0BWY4yuGbMLQMKFxJAPzH0I4oKHVGlwI=;
        b=rG8Z0VfwaA61bPZeGe5CnP8ilpFBvhTqlF9lTA6QpM53rohJc2wzAw7rs1GQZW+NEv
         RLWLFEJhfvjgk5RbgXqLj58WpJioOScTUo8jdDGop2H5QOtDBWju/w7GfldL1KQnuH+l
         PuB6BmbX81PIYU7z0tKY2wbl/4rPYVu3PedIbk4oZgIXnLCNEfxYxBRLjdjn2pI1pQJG
         az8cFasXy0LoGu8oiPGcvsZyccvAbo3ftp8Rxl8viuaU6Ti8i91/Oy//HMFGJjLWNDrD
         QtdgFE0FLx2dPwPNoRl5SdCCwfUfsRmyqW56AIBGr6vVUb8+gBKn1amV8CZPUjCXvtLD
         v41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N4Pb5W255LH0BWY4yuGbMLQMKFxJAPzH0I4oKHVGlwI=;
        b=20o+olvYcCx8HHVRnBWj2oEpsIyaDYw1gbRftEChfhW4cer6bBMYHFOtcZyFNy6+m7
         3QcSGbu4csh71PYd1zxEThhI6rKAQRF13gs3fLO05hVBV1zTCtimnExOEdIqvDAxnXR3
         2nJ4xSaOANvdpvQWrQoK5DxmSTrSlbTMTWmuq976glq+KYogAk9pXLo4SMWR1lGyO9GA
         4nEE5Hw0c3TOCMLz9MT6BZ86IZ4hMqNj6nNpOfvNWdK9GBC7zsPUCRCgD5vRAwSIcQbR
         j9ujBzQvqMNr4umCz9eLQAe3NGH9U1PlKpM2gwlCL4owzd4dhpSrdoAx7tTOsGsyjR5h
         W1GQ==
X-Gm-Message-State: ANoB5pk6+RGMX6WPSbEcsn2f0KqcIU8T4kTHb6pXRUkMAce6Q5SAkzzS
        vvv5V/ZCWro51ETRuzL6kilT43/RtN02kSE=
X-Google-Smtp-Source: AA0mqf5IhvX2InjcErypWIqoQF+tN+KeLvgxsDwFZbbrEjcAAiym78wd3DpAzvGg3xkHQrwfH4mVR+sTsw8Rhqw=
X-Received: from lixiaoyan-desktop.svl.corp.google.com ([2620:15c:2c4:201:d85f:1168:cf63:556b])
 (user=lixiaoyan job=sendgmr) by 2002:a17:902:a989:b0:188:d6c7:e7b7 with SMTP
 id bh9-20020a170902a98900b00188d6c7e7b7mr5323760plb.16.1669145571058; Tue, 22
 Nov 2022 11:32:51 -0800 (PST)
Date:   Tue, 22 Nov 2022 11:32:38 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221122193239.3159985-1-lixiaoyan@google.com>
Subject: [PATCH net-next 1/2] IPv6/GRO: generic helper to remove temporary
 HBH/jumbo header in driver
From:   Coco Li <lixiaoyan@google.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Michael Chan <michael.chan@broadcom.com>
Cc:     linux-kernel@vger.kernel.org, Coco Li <lixiaoyan@google.com>
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
 include/net/ipv6.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index d383c895592a..a11d58c85c05 100644
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
+	memmove(skb->data + hophdr_len,
+		skb->data,
+		ETH_HLEN + sizeof(struct ipv6hdr));
+
+	skb->data += hophdr_len;
+	skb->len -= hophdr_len;
+	skb->network_header += hophdr_len;
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
-- 
2.38.1.584.g0f3c55d4c2-goog

