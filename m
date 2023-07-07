Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B8774A9FF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 06:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjGGEjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 00:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjGGEjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 00:39:42 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDC51BF8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 21:39:41 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1b3f722fdafso1448873fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 21:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1688704779; x=1691296779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9UWYQqOrYqkxR5XpwKp6R22GVBVnnsxJZJsmiNrkFSw=;
        b=W0t5g/B1oy0yWoS9I4G0cGXHdlj4SznvVg7lqL2NZauZ7JCHiUBrbWDFm5zuVLIBct
         NYyiqasx+mGmFapxdlx7IvBBfH+l0yeOsdcDVTQc6r8ykfBeseb8UeARhrrX4JEAGV6Y
         GMr4VR8b6MIs9LYlKiMoNmSb6/eCC4N5QZG3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688704779; x=1691296779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9UWYQqOrYqkxR5XpwKp6R22GVBVnnsxJZJsmiNrkFSw=;
        b=NWg9nr9JPGePpYc81lSDjox8QOGV2PTvZOmTXsoLpy9UPMggNrtK9ZOkF7DSCHee8a
         7jOMY6q8GPzww3BZTLC1X2UHhTqOMLLTdfxkoVm7+jH3ccu0hTMlM46O0Z9161Jz1Kxp
         9v2srcm4XXCJkqvhU7F40l1kAXEn9UUUzPFCiDrfrQB1y6MZZUdHpxLUXPuxlKwjbo4X
         7qgiek3+jLL9l2sxgsN1qT/F7kC4KvluHKPNXHvK2DRm5F4v3xWz8nAYjTEpXPY/lgHZ
         5vbulY6sYivxnuwZGRjrbu6R5sgh7ZWzUh7/eMgKTpVXiUTRZWQm6jW+bQ0SqkoyYiEi
         wLEw==
X-Gm-Message-State: ABy/qLb5fpFkVmE5R60jE1ZTHOxQOiUUcWhXsDpPRpruCd+Ij7hvsDJT
        BOJQF8Nrwimq7zXrgTWZ4GBOaw==
X-Google-Smtp-Source: APBJJlFmgPUvYnZf5B/mqoJrxp5s/bQoPHgPHPa3ft527lToxgI0pMs4rl3RBhthX5RmGK/P+cVJuw==
X-Received: by 2002:a05:6870:2215:b0:1b0:3637:2bbe with SMTP id i21-20020a056870221500b001b036372bbemr4848122oaf.54.1688704779673;
        Thu, 06 Jul 2023 21:39:39 -0700 (PDT)
Received: from localhost ([2601:644:200:aea:502d:5846:fd1f:55e7])
        by smtp.gmail.com with ESMTPSA id n2-20020a17090a670200b0025c1cfdb93esm576569pjj.13.2023.07.06.21.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 21:39:39 -0700 (PDT)
From:   Ivan Babrou <ivan@cloudflare.com>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Ivan Babrou <ivan@cloudflare.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Peilin Ye <peilin.ye@bytedance.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Petr Machata <petrm@nvidia.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Satoru Moriya <satoru.moriya@hds.com>
Subject: [PATCH v2] udp6: add a missing call into udp_fail_queue_rcv_skb tracepoint
Date:   Thu,  6 Jul 2023 21:39:20 -0700
Message-ID: <20230707043923.35578-1-ivan@cloudflare.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tracepoint has existed for 12 years, but it only covered udp
over the legacy IPv4 protocol. Having it enabled for udp6 removes
the unnecessary difference in error visibility.

Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
Fixes: 296f7ea75b45 ("udp: add tracepoints for queueing skb to rcvbuf")

---
v2: added tracepoint export to make it build with IPV6=m (thanks Jakub!)
---
 net/core/net-traces.c | 2 ++
 net/ipv6/udp.c        | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/net/core/net-traces.c b/net/core/net-traces.c
index 805b7385dd8d..6aef976bc1da 100644
--- a/net/core/net-traces.c
+++ b/net/core/net-traces.c
@@ -63,4 +63,6 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(napi_poll);
 EXPORT_TRACEPOINT_SYMBOL_GPL(tcp_send_reset);
 EXPORT_TRACEPOINT_SYMBOL_GPL(tcp_bad_csum);
 
+EXPORT_TRACEPOINT_SYMBOL_GPL(udp_fail_queue_rcv_skb);
+
 EXPORT_TRACEPOINT_SYMBOL_GPL(sk_data_ready);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index e5a337e6b970..debb98fb23c0 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -45,6 +45,7 @@
 #include <net/tcp_states.h>
 #include <net/ip6_checksum.h>
 #include <net/ip6_tunnel.h>
+#include <trace/events/udp.h>
 #include <net/xfrm.h>
 #include <net/inet_hashtables.h>
 #include <net/inet6_hashtables.h>
@@ -680,6 +681,7 @@ static int __udpv6_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		}
 		UDP6_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
 		kfree_skb_reason(skb, drop_reason);
+		trace_udp_fail_queue_rcv_skb(rc, sk);
 		return -1;
 	}
 
-- 
2.41.0

