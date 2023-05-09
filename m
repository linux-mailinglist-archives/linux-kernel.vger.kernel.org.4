Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B796FD278
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 00:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbjEIWQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 18:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235281AbjEIWQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 18:16:23 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3B046A2
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 15:16:22 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f42b984405so9829655e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 15:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1683670581; x=1686262581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lc+xA7tlcC6A/HLIGYglx4S12hhfgqdXTKqlDOHD+8g=;
        b=MzlgfUUAYES98I8Blt0uDfqbqzdhCiYd3z2QxUhekOknoxQbNIgpLRyzMq1Xmch7h8
         HItqYCSavUCqWy6kHsNZ0BcKI0OVSRDn6fwwYEQTXfplkFaQkswuICiX2I3//M9E6kAB
         P2nMX2EJLEkjUiRmfAAJoiyX555vwsTfgrWbc6FYyR/Pab9SfAR5yRxBmcBmTuaTDhmf
         jz/2BVV0PIEB5rr4S6tBalg4PrONuoUJJVDKZoAR+ajpq3NwV9XoZ8Lq2Nc2Avbp4q9O
         tXCn4Yl6HwngLAP+Lu+i6S3wv4Uhh/lPDtEwx1EtJpazHkWWT3scsIQqIIemzg+mHVwv
         Jrdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683670581; x=1686262581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lc+xA7tlcC6A/HLIGYglx4S12hhfgqdXTKqlDOHD+8g=;
        b=e7nboUehhW3eh8B3RnjK1JuJ852PomWzmK3d/M29BQKxUQ/jaRqDneduDL4kLZynnY
         1ZOzv3uoWhEkb1A9/3x0EW2cTCrg/bgtn+M0jFiuHIxFL3TyDN4H0tFYan8iVpex02O8
         9uAE3pUo0PTaylvuwU/+xWUhbjt0TpYwb+v9rq0Z22s6BuJia7IRRxEFI8S33wb/H2lI
         MdZ9aoK36Xt/ot1iRdtZz77LQak0xXouxIH3yg5u/NBlXQjlg5OQI4ny1ptBNPTgh8D6
         cs3mGHICS0gHc9TOjb9Cm0syXxI1vauqcFfXdVW64gsLcC6VOLsLVGKHxphTzEfHNlB/
         Utqg==
X-Gm-Message-State: AC+VfDzckS2F/HYHEUlTIbP97WYaHiOE5C6/uTzPrKCvo/rPJeiBLJQ7
        w1Sk0RlPpWcofQQBry9D5KKRS561cf5xecwAW7c=
X-Google-Smtp-Source: ACHHUZ53khA8ZUPP0QlnwjV+NGrdwIuAZcQJbHfVX3TMwqEq0wSrQhmpuHxdHD0QKJFqU+ila5I/Bg==
X-Received: by 2002:a1c:f20a:0:b0:3f1:819d:d050 with SMTP id s10-20020a1cf20a000000b003f1819dd050mr10537973wmc.37.1683670580862;
        Tue, 09 May 2023 15:16:20 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t25-20020a7bc3d9000000b003f42d3111b8sm2052888wmj.30.2023.05.09.15.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 15:16:20 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Dmitry Safonov <dima@arista.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Leonard Crestez <cdleonard@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        netdev@vger.kernel.org
Subject: [RFC 5/5] net/tcp-md5: Don't send ACK if key (dis)appears
Date:   Tue,  9 May 2023 23:16:08 +0100
Message-Id: <20230509221608.2569333-6-dima@arista.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230509221608.2569333-1-dima@arista.com>
References: <20230509221608.2569333-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To mirror RST paranoid checks and tcp_inbound_md5_hash().

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/ipv4/tcp_ipv4.c | 2 ++
 net/ipv6/tcp_ipv6.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index d94cd5e70d58..0c8893240f70 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -918,6 +918,8 @@ static void tcp_v4_send_ack(const struct sock *sk,
 	rep.th.window  = htons(win);
 
 #ifdef CONFIG_TCP_MD5SIG
+	if (unlikely(!!key != !!tcp_parse_md5sig_option(th)))
+		return;
 	if (key) {
 		int offset = (tsecr) ? 3 : 0;
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 498dfa194b8b..4131ada9fabf 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -863,6 +863,8 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 	if (tsecr)
 		tot_len += TCPOLEN_TSTAMP_ALIGNED;
 #ifdef CONFIG_TCP_MD5SIG
+	if (!rst && unlikely(!!key != !!tcp_parse_md5sig_option(th)))
+		return;
 	if (key)
 		tot_len += TCPOLEN_MD5SIG_ALIGNED;
 #endif
-- 
2.40.0

