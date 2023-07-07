Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A41E74B0BD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 14:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjGGM0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 08:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjGGM0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 08:26:41 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25FC1FEA;
        Fri,  7 Jul 2023 05:26:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbc656873eso23014105e9.1;
        Fri, 07 Jul 2023 05:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688732798; x=1691324798;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bklyYiP/IhxeYjsLbgb+f+L9NtgpRzAgyHR6T9K9BbM=;
        b=sUEPF7CpHwBz6vjelHaHjXAqGKvaLXbaMuzOdBmX+LCOt2ExjEtZMW5dZSSRVnR8j9
         xBTD7abRZljt5XD0reFOvz/nSQOiA0Yx3Fhz1h7qEDCC3AN5E9NlswMjkHbH1KpEc6tw
         cQHMnbQNMJmZM0lufQnkKQyGERwt1ALNnlKCZW8/1V5hsdz5+vYfYfs3hhOiSKqBqVp/
         9cMiF/LlXXVLEEUI8v8F684bPYkWV93YF1faBlwil1RJLFtd9KV25g8317jy7Cj0CI1k
         6sAwvYEjWOh1syIKkmmwcz2k37kg24NrHznZVhYJeH6gEGyFNpwOd3e17D5kf9JSd7Uv
         PIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688732798; x=1691324798;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bklyYiP/IhxeYjsLbgb+f+L9NtgpRzAgyHR6T9K9BbM=;
        b=AxBloCPUvi5lhkVy19Y+Bg52fQFW1p/0nAr82crsr6XZzO3XcndVCVVScgfJRjQ5EW
         KB+5wVNSbT3lJC6dcTaNYdVLgkWg6nVVAyPHl1lnB5ZhCvs90EodjzlezpDoeUZCOf9O
         Xfgtyldh88nXLzWvC7p3AXqUWWZS182bI8W8zuguUsKYOAlcZge9p+XbY9r5kn2CR4vx
         dReXUUfdTP8mmYIaWD6GI/F6UdbtFm0arQZ6NyqGlr+SeKJW05OgGAKDX7LOGIHZNm57
         1X93t/1dXhlFzLSCi6fP9RBD+ecIiM7O5MXNYI8bcJBhOet6GChvbiIo0R2M4H2W9YSk
         JrZQ==
X-Gm-Message-State: ABy/qLYWweabasKNVFb+J1AcPXl0RNdQKr6rTGi+sA0tEW4rw10tkMF6
        L7Z9MulyTUF1EScw7xqq7l0U2dIQRbc=
X-Google-Smtp-Source: APBJJlES8G4cbYSQkVhST6V2w2AQCskZzOoGPHOC21woukenHiDmLxsfKOsLGEDpiH8nNSHbs9T3HQ==
X-Received: by 2002:a05:600c:247:b0:3fc:65:8dff with SMTP id 7-20020a05600c024700b003fc00658dffmr1502438wmj.4.1688732798311;
        Fri, 07 Jul 2023 05:26:38 -0700 (PDT)
Received: from debian ([89.238.191.199])
        by smtp.gmail.com with ESMTPSA id e4-20020a5d5004000000b0030fb4b55c13sm4307150wrt.96.2023.07.07.05.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 05:26:38 -0700 (PDT)
Date:   Fri, 7 Jul 2023 14:26:28 +0200
From:   Richard Gobert <richardbgobert@gmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
        dsahern@kernel.org, tom@herbertland.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, gal@nvidia.com
Subject: [PATCH 1/1] net: gro: fix misuse of CB in udp socket lookup
Message-ID: <20230707122627.GA17845@debian>
References: <20230707121650.GA17677@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707121650.GA17677@debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a misuse of IP{6}CB(skb) in GRO, while calling to
`udp6_lib_lookup2` when handling udp tunnels. `udp6_lib_lookup2` fetch the
device from CB. The fix changes it to fetch the device from `skb->dev`.
l3mdev case requires special attention since it has a master and a slave
device.

Fixes: a6024562ffd7 ("udp: Add GRO functions to UDP socket")
Reported-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 include/net/udp.h      |  2 ++
 net/ipv4/udp.c         | 21 +++++++++++++++++++--
 net/ipv4/udp_offload.c |  7 +++++--
 net/ipv6/udp.c         | 21 +++++++++++++++++++--
 net/ipv6/udp_offload.c |  7 +++++--
 5 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/include/net/udp.h b/include/net/udp.h
index 4d13424f8f72..48af1479882f 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -299,6 +299,7 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
 int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 		       sockptr_t optval, unsigned int optlen,
 		       int (*push_pending_frames)(struct sock *));
+void udp4_get_iif_sdif(const struct sk_buff *skb, int *iif, int *sdif);
 struct sock *udp4_lib_lookup(struct net *net, __be32 saddr, __be16 sport,
 			     __be32 daddr, __be16 dport, int dif);
 struct sock *__udp4_lib_lookup(struct net *net, __be32 saddr, __be16 sport,
@@ -310,6 +311,7 @@ struct sock *udp6_lib_lookup(struct net *net,
 			     const struct in6_addr *saddr, __be16 sport,
 			     const struct in6_addr *daddr, __be16 dport,
 			     int dif);
+void udp6_get_iif_sdif(const struct sk_buff *skb, int *iif, int *sdif);
 struct sock *__udp6_lib_lookup(struct net *net,
 			       const struct in6_addr *saddr, __be16 sport,
 			       const struct in6_addr *daddr, __be16 dport,
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 42a96b3547c9..0581ab184afd 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -550,15 +550,32 @@ static inline struct sock *__udp4_lib_lookup_skb(struct sk_buff *skb,
 				 inet_sdif(skb), udptable, skb);
 }

+void udp4_get_iif_sdif(const struct sk_buff *skb, int *iif, int *sdif)
+{
+	*iif = inet_iif(skb) || skb->dev->ifindex;
+	*sdif = 0;
+
+#if IS_ENABLED(CONFIG_NET_L3_MASTER_DEV)
+	if (netif_is_l3_slave(skb->dev)) {
+		struct net_device *master = netdev_master_upper_dev_get_rcu(skb->dev);
+		*sdif = *iif;
+		*iif = master ? master->ifindex : 0;
+	}
+#endif
+}
+
 struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb,
 				 __be16 sport, __be16 dport)
 {
 	const struct iphdr *iph = ip_hdr(skb);
 	struct net *net = dev_net(skb->dev);
+	int iif, sdif;
+
+	udp4_get_iif_sdif(skb, &iif, &sdif);

 	return __udp4_lib_lookup(net, iph->saddr, sport,
-				 iph->daddr, dport, inet_iif(skb),
-				 inet_sdif(skb), net->ipv4.udp_table, NULL);
+				 iph->daddr, dport, iif,
+				 sdif, net->ipv4.udp_table, NULL);
 }

 /* Must be called under rcu_read_lock().
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 75aa4de5b731..70d760b271db 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -603,10 +603,13 @@ static struct sock *udp4_gro_lookup_skb(struct sk_buff *skb, __be16 sport,
 {
 	const struct iphdr *iph = skb_gro_network_header(skb);
 	struct net *net = dev_net(skb->dev);
+	int iif, sdif;
+
+	udp4_get_iif_sdif(skb, &iif, &sdif);

 	return __udp4_lib_lookup(net, iph->saddr, sport,
-				 iph->daddr, dport, inet_iif(skb),
-				 inet_sdif(skb), net->ipv4.udp_table, NULL);
+				 iph->daddr, dport, iif,
+				 sdif, net->ipv4.udp_table, NULL);
 }

 INDIRECT_CALLABLE_SCOPE
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 317b01c9bc39..aac9b20d67e4 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -294,15 +294,32 @@ static struct sock *__udp6_lib_lookup_skb(struct sk_buff *skb,
 				 inet6_sdif(skb), udptable, skb);
 }

+void udp6_get_iif_sdif(const struct sk_buff *skb, int *iif, int *sdif)
+{
+	*iif = skb->dev->ifindex;
+	*sdif = 0;
+
+#if IS_ENABLED(CONFIG_NET_L3_MASTER_DEV)
+	if (netif_is_l3_slave(skb->dev)) {
+		struct net_device *master = netdev_master_upper_dev_get_rcu(skb->dev);
+		*sdif = *iif;
+		*iif = master ? master->ifindex : 0;
+	}
+#endif
+}
+
 struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
 				 __be16 sport, __be16 dport)
 {
 	const struct ipv6hdr *iph = ipv6_hdr(skb);
 	struct net *net = dev_net(skb->dev);
+	int iif, sdif;
+
+	udp6_get_iif_sdif(skb, &iif, &sdif);

 	return __udp6_lib_lookup(net, &iph->saddr, sport,
-				 &iph->daddr, dport, inet6_iif(skb),
-				 inet6_sdif(skb), net->ipv4.udp_table, NULL);
+				 &iph->daddr, dport, iif,
+				 sdif, net->ipv4.udp_table, NULL);
 }

 /* Must be called under rcu_read_lock().
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index ad3b8726873e..88191d79002e 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -119,10 +119,13 @@ static struct sock *udp6_gro_lookup_skb(struct sk_buff *skb, __be16 sport,
 {
 	const struct ipv6hdr *iph = skb_gro_network_header(skb);
 	struct net *net = dev_net(skb->dev);
+	int iif, sdif;
+
+	udp6_get_iif_sdif(skb, &iif, &sdif);

 	return __udp6_lib_lookup(net, &iph->saddr, sport,
-				 &iph->daddr, dport, inet6_iif(skb),
-				 inet6_sdif(skb), net->ipv4.udp_table, NULL);
+				 &iph->daddr, dport, iif,
+				 sdif, net->ipv4.udp_table, NULL);
 }

 INDIRECT_CALLABLE_SCOPE
--
2.36.1

