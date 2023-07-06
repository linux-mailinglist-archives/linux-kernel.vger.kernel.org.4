Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7944A74A309
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 19:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjGFRXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 13:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGFRXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 13:23:22 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD991BE9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 10:23:21 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-55b83ae9be2so728814a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 10:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1688664200; x=1691256200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3w6eM1h+0P8X1QDbGu2Q17kb8M2qnV/qp1NskbLt6Z0=;
        b=BUPdN44Pqpap981nerjdz0tmWFl99Jhx/pTjf/uNWurNdXG0E8Aya+43lFIjrQakt3
         aTVTSRMtB6Qre/swdUDlKkB51mf/8gU0WbwhkChkq3WHXezkMH74Qiea6VOZMcvmFixL
         m/qNgag4jj6XXQKOE7w2+lkZSjvJlz02Fh6yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688664200; x=1691256200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3w6eM1h+0P8X1QDbGu2Q17kb8M2qnV/qp1NskbLt6Z0=;
        b=NHBx225afbA5q2EIFqf4utYhqflbOIvx+z10k+GWNVkvlsNuNNHRtGGLShYq3gsRtX
         HfRXpBrbR0zV0oWn1QqMlGZolWbUXgdKP4Nc5Zqe76AFU7YkhZAAUnvGcvqnjurR2LyN
         g3n1318Jcs+epmyLG3mXErcrVsayRTsn2cjPEVotAZsBVU4IXZdOD4fhxYv9GK2pLK/C
         6WIr1bUkBKdlL+ea5WlcknmgKjhSjV8YCpzSZzizXn2fk0zC+h8COIL67Di6ahahVswW
         O4T+Nw4UjHoyQK5kJfGnmLgWKQHy1ZHPYgAsxYvhz4pqu3IfTWk4OrUh4pRRuyNlrc4b
         xoTA==
X-Gm-Message-State: ABy/qLaHgCjLt8ZllexeEemeREJrCpn7wfwmsH2udg/oFoDq0GI/2bDg
        B1JeqFXLjFWnC602SgA8HWW5mZiK2a4NzoUNpr6m3g==
X-Google-Smtp-Source: APBJJlEnFoNgR0Za1gb6swgE7IdNVSOCrgicMUPGnWTnn3YySvdOVMl+LhVdLLfoOXeS1V3o/KJ5/A==
X-Received: by 2002:a05:6a20:9384:b0:130:3c8b:4204 with SMTP id x4-20020a056a20938400b001303c8b4204mr2118043pzh.8.1688664200464;
        Thu, 06 Jul 2023 10:23:20 -0700 (PDT)
Received: from localhost ([2601:644:200:aea:502d:5846:fd1f:55e7])
        by smtp.gmail.com with ESMTPSA id p22-20020aa78616000000b0067903510abbsm1528509pfn.163.2023.07.06.10.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 10:23:20 -0700 (PDT)
From:   Ivan Babrou <ivan@cloudflare.com>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Ivan Babrou <ivan@cloudflare.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Satoru Moriya <satoru.moriya@hds.com>
Subject: [PATCH] udp6: add a missing call into udp_fail_queue_rcv_skb tracepoint
Date:   Thu,  6 Jul 2023 10:22:36 -0700
Message-ID: <20230706172237.28341-1-ivan@cloudflare.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 net/ipv6/udp.c | 2 ++
 1 file changed, 2 insertions(+)

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

