Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBD5645952
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiLGLvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiLGLve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:51:34 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B1F51315
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 03:51:33 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id d14so19582441edj.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 03:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b50DMxxzpcvqZuaYvZ+NeDB+ivxCzALRsRPpNk8vSuo=;
        b=ah+7qtSPQPfP7JCSCAvryAWT9SaG5pcJwqrq8YnhlRflNzMbRupaadUDIHbI+2nJzU
         TMrmD0Xuy2WF5G5MQUev9P92s685Ze1SJ4Z+/MRt4ew43KoMCku4hGDnPxnQhBdxhYUW
         bcYduHfJena87oqsnUpOuNyRtQOTaKd4dZeBByE9r2fpmjcmpuvnPBf0njAzI6TCdRn3
         7JXRYMSiWd5cYeD19na2UwaItZHATd6+rHx3/s39/WmVj7P2YS3KBEkfEYFfI1fo+WLd
         oDInrXxfA8aZO8kSxq4xZU+pKMSp6KBqdn6d/frwiivwnRoi5Z3QXbPpxup4u3cPVYEs
         Sg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b50DMxxzpcvqZuaYvZ+NeDB+ivxCzALRsRPpNk8vSuo=;
        b=ibaIqn3tuNrRM8gEbPVfAFl49eep1ym3dWArAURDJVSHJdveyMh8kPHLz9s3MjBdvP
         1PripHfCpJo7B7Z161Rj+UsJfu+2irp0RP0HgzYmACOrl8QoJSlbQbi9s0fytG70PhsZ
         Q/RSbZwzE30HQuJ8juG6Ee3avNgUDpXyBMDNEl8D23/SwcQ0TV38r2F+aMd2Yd2QtOKc
         yd7SpPyXSWY4E9/zXNSuE3VvwLUHumBqjjA9hqGkrb/5ZbwDxYwgtJgoF4HP3lHs0fhj
         +UkrjhAdlQMt9Qoncto/6WOwz2cnJMbUXiWI7khPQsC/iOC+1BM7eAh5UYxSCXnxiY/V
         dGuQ==
X-Gm-Message-State: ANoB5pl3yzWHt2GVc271USgwQ8qrS0iATmuNclEQ5O2PkMFzKhFo/KBW
        W5iPp0hew2xldhQ7wlVCXaTaPg==
X-Google-Smtp-Source: AA0mqf5Jgn1LUauRgbHQj9w8QV4AUcZH5sRBPp3Nm6PB9JKg3E7uiSJV4t3LjuIeCcrLPSexUTR2iQ==
X-Received: by 2002:a05:6402:5289:b0:462:70ee:fdb8 with SMTP id en9-20020a056402528900b0046270eefdb8mr47279793edb.66.1670413886071;
        Wed, 07 Dec 2022 03:51:26 -0800 (PST)
Received: from localhost.localdomain ([193.33.38.48])
        by smtp.gmail.com with ESMTPSA id g26-20020a056402181a00b004618a89d273sm2132816edy.36.2022.12.07.03.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 03:51:25 -0800 (PST)
From:   Andrew Melnychenko <andrew@daynix.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     yan@daynix.com, yuri.benditovich@daynix.com
Subject: [PATCH v5 1/6] udp: allow header check for dodgy GSO_UDP_L4 packets.
Date:   Wed,  7 Dec 2022 13:35:53 +0200
Message-Id: <20221207113558.19003-2-andrew@daynix.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221207113558.19003-1-andrew@daynix.com>
References: <20221207113558.19003-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow UDP_L4 for robust packets.

Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 net/ipv4/udp_offload.c | 3 ++-
 net/ipv6/udp_offload.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 6d1a4bec2614..f65b1a7a0c26 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -387,7 +387,8 @@ static struct sk_buff *udp4_ufo_fragment(struct sk_buff *skb,
 	if (!pskb_may_pull(skb, sizeof(struct udphdr)))
 		goto out;
 
-	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
+	    !skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST))
 		return __udp_gso_segment(skb, features, false);
 
 	mss = skb_shinfo(skb)->gso_size;
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index 7720d04ed396..057293293e30 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -42,7 +42,8 @@ static struct sk_buff *udp6_ufo_fragment(struct sk_buff *skb,
 		if (!pskb_may_pull(skb, sizeof(struct udphdr)))
 			goto out;
 
-		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
+		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
+		    !skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST))
 			return __udp_gso_segment(skb, features, true);
 
 		mss = skb_shinfo(skb)->gso_size;
-- 
2.38.1

