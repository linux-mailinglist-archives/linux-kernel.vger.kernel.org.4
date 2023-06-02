Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8033371FB97
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbjFBIMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234294AbjFBIME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:12:04 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FE91A1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 01:12:02 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-5555765c6d3so1349415eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 01:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1685693522; x=1688285522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMgEeyTxt1Bo6VDZUGwQjdkhsPRlWxhl30gajyLXBa4=;
        b=VjphZxOIejuEYZEGuPwwC4pDQ7lIV7K/XG9vcSDLCRxCWGgGi5PSze6VUYd11+IAs0
         Kuul4CNsZBFvMYso/aMxRk0DUCPanLD16zAl1A0vODdrCeOViOsELz9IBaR8oTw6UPca
         Sh5kimkJvKN5Y60CS7Fgx05CnVMkFs3LUuQK4GRlUFaU64P6G3aEXHniXJomFeuNh7RV
         2g9IxHPICSZ3vQb4CogF4QAJdPmhaXCbiWb/5M6aqzDmAghY5ZlzepkhiMb7IttTe7uY
         mULWUSkeYlsAYa+W5goQyWu6i+nF1szs/G1oDUjv5o+ae9/cGIFhbicxvEJ9GU8G5HDk
         p57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685693522; x=1688285522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMgEeyTxt1Bo6VDZUGwQjdkhsPRlWxhl30gajyLXBa4=;
        b=Ovw2o2KxjlzpFiADp0oG4iuQn+6Z0WkslAyieOXF+tXs5C1y4M0FutGuCfkRrlZeuD
         /0Z8SisKcaTXpwnzTMOFcEm4Xft8a76mHb45Zo8qCGyhCNsXJUiRJ27M9TNn543Cq5Kc
         pD7qWJxmnQB0upBeYXgr3V3kzaY+qcAe7TgaDgxgQg57k+x+B3Qn0UYZLLxhQKO11o3l
         8C65y0wpgW4a7CuAMwYo4giLFJJAph8K/zvZkECKAX9Uw7VJPrqMiuRAqn13+qPQu1QN
         MRgqpkdp5E2ZcS8tLE+YdHt2ffudrYOj+3mt48H9fXeBRBRbxAfhs0kT9KJdTZHJ22nR
         +4dA==
X-Gm-Message-State: AC+VfDz4OSQ0SYvo4xvDJaMgS3qzP2oMcOFiLEtA2Kar64QG3bte0usP
        E+CiFIEBu4B9XvHPGirH4gPcRA==
X-Google-Smtp-Source: ACHHUZ4A27qjlFy5d7fB7UgzYv64hzjwk6Uq2zWiwMXFJiJaGOxm7+lY8w3gnnmpSkd1sTF3hYYqJw==
X-Received: by 2002:a05:6808:198:b0:398:9ee4:1dac with SMTP id w24-20020a056808019800b003989ee41dacmr1647685oic.32.1685693522017;
        Fri, 02 Jun 2023 01:12:02 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id ij9-20020a170902ab4900b001b025aba9edsm703570plb.220.2023.06.02.01.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 01:12:01 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>
Cc:     Simon Horman <simon.horman@corigine.com>, netdev@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH net-next v5 2/3] sock: Always take memcg pressure into consideration
Date:   Fri,  2 Jun 2023 16:11:34 +0800
Message-Id: <20230602081135.75424-3-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230602081135.75424-1-wuyun.abel@bytedance.com>
References: <20230602081135.75424-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sk_under_memory_pressure() is called to check whether there is
memory pressure related to this socket. But now it ignores the net-
memcg's pressure if the proto of the socket doesn't care about the
global pressure, which may put burden on its memcg compaction or
reclaim path (also remember that socket memory is un-reclaimable).

So always check the memcg's vm status to alleviate memstalls when
it's in pressure.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 include/net/sock.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 3f63253ee092..ad1895ffbc4a 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1411,13 +1411,11 @@ static inline bool sk_has_memory_pressure(const struct sock *sk)
 
 static inline bool sk_under_memory_pressure(const struct sock *sk)
 {
-	if (!sk->sk_prot->memory_pressure)
-		return false;
-
 	if (mem_cgroup_under_socket_pressure(sk->sk_memcg))
 		return true;
 
-	return !!*sk->sk_prot->memory_pressure;
+	return sk->sk_prot->memory_pressure &&
+		*sk->sk_prot->memory_pressure;
 }
 
 static inline long
-- 
2.37.3

