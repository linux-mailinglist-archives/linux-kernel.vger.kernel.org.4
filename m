Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C24D67AB06
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 08:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbjAYHhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 02:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235129AbjAYHhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 02:37:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A87737F1F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 23:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674632171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NWp8AY96vdXmiMbopROrFgs2cU/VADiUd7iIJJXBCxY=;
        b=el/47FiS49Sk8mreZ2OWz2iX8VjGh8taqZbHwZv74qFL3bVKOKHuGUe1yFvUTuI0sjc6m5
        llrVLhXki9/43TklZkbLmHtvBtMoQwdOMp6NRXwtztEQzAPcDlrBLP9En/LYAUcaV9QHtN
        FG92PPC+IlBX9V4mlINT0wPRgM/jh1U=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-67-s94wKnlcOyi377eKMrntwg-1; Wed, 25 Jan 2023 02:36:10 -0500
X-MC-Unique: s94wKnlcOyi377eKMrntwg-1
Received: by mail-oi1-f198.google.com with SMTP id u9-20020a544389000000b00363be5d9f42so5551447oiv.15
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 23:36:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWp8AY96vdXmiMbopROrFgs2cU/VADiUd7iIJJXBCxY=;
        b=KHuHECozvbsms4X3V9pEXeDQ/1z0byeTw18eZsFxL08f5rbD6E/81vVHCBJ10/xfJ6
         eZ0cyWffoOx1q2nfms8vxwngp3e/dc7kOzRY8XDZKgWFfZFEaSye0OFyIfM+NVFWZEdm
         erd4IKTopqKVmS9v/aRMqhBBF1wFV4VRoocMu63xGxi1zqj+hilmrCtNTDwNgeHWU23M
         qqNm8S0LvcCvuGwfiryq5jUQLgzMQkY+W/8MkATI4tPH2BJUoYR5zkE3SH+ALtC8Uea/
         +dvb8rcfnEacfaxyh9EX+75PzuP16hCNxW0yxlB3Z4FKPjj/y8SZXfPNOB/wNxobk1wm
         j1ZQ==
X-Gm-Message-State: AFqh2kpki+vNd7tIhh4oHEdLkHXZYWoEWKDJmTeYxtbPtHWWMK6B2n4w
        KK6ma08AlWyfcoYD9QfyNUPlkGa3jCWiLxviUKAu7y1tQ2pmH5WNKM5h2qumKHLm2eS8eczJHR3
        iwPdkYxaP2u2pcQUEtV/7vWNk
X-Received: by 2002:a05:6870:e0ce:b0:15f:3bb9:7b3d with SMTP id a14-20020a056870e0ce00b0015f3bb97b3dmr17462992oab.28.1674632169346;
        Tue, 24 Jan 2023 23:36:09 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv6r5ehrqKjuOqxpudgJdHfNcykat5kT9ZAeiiKrUzWSSAJYK3YalJM5sJ2WYW3DmqLUhiPTw==
X-Received: by 2002:a05:6870:e0ce:b0:15f:3bb9:7b3d with SMTP id a14-20020a056870e0ce00b0015f3bb97b3dmr17462978oab.28.1674632169128;
        Tue, 24 Jan 2023 23:36:09 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a800:14fa:9361:c141:6c70:c877])
        by smtp.gmail.com with ESMTPSA id x189-20020a4a41c6000000b0050dc79bb80esm1538802ooa.27.2023.01.24.23.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 23:36:08 -0800 (PST)
From:   Leonardo Bras <leobras@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Leonardo Bras <leobras@redhat.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] mm/memcontrol: Remove flags from memcg_stock_pcp
Date:   Wed, 25 Jan 2023 04:35:02 -0300
Message-Id: <20230125073502.743446-6-leobras@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125073502.743446-1-leobras@redhat.com>
References: <20230125073502.743446-1-leobras@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flags member of struct memcg_stock_pcp has only one used bit:
FLUSHING_CACHED_CHARGE

Both struct member and flag were created to avoid scheduling multiple
instances of kworkers running drain_local_stock() for a single cpu.

How could this scenario happen before:
- drain_all_stock() gets called, get ownership of percpu_charge_mutex,
  schedules a drain_local_stock() on cpu X, and drops ownership of
  percpu_charge_mutex.
- Another thread calls drain_all_stock(), get ownership of
  percpu_charge_mutex, schedules a drain_local_stock() on cpu X, ...

Since the stock draining is now performed by the thread running
drain_all_stock(), and happens before letting go of the
percpu_charge_mutex, there is no chance of another drain happening
between test_and_set_bit() and clear_bit(), so flags is now useless.

Remove the flags member of memcg_stock_pcp, its usages and the
FLUSHING_CACHED_CHARGE define.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 mm/memcontrol.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5b7f7c2e0232f..60712f69595e4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2183,9 +2183,6 @@ struct memcg_stock_pcp {
 	int nr_slab_reclaimable_b;
 	int nr_slab_unreclaimable_b;
 #endif
-
-	unsigned long flags;
-#define FLUSHING_CACHED_CHARGE	0
 };
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct memcg_stock_pcp, memcg_stock) = {
@@ -2281,7 +2278,6 @@ static void drain_stock_from(struct memcg_stock_pcp *stock)
 
 	old = drain_obj_stock(stock);
 	drain_stock(stock);
-	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
 
 	spin_unlock_irqrestore(&stock->stock_lock, flags);
 	if (old)
@@ -2351,8 +2347,7 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 			flush = true;
 		rcu_read_unlock();
 
-		if (flush &&
-		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags))
+		if (flush)
 			drain_stock_from(stock);
 	}
 	migrate_enable();
-- 
2.39.1

