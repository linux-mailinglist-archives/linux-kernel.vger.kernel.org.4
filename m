Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D432F65730F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 07:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbiL1GH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 01:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbiL1GHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 01:07:10 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D626390
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 22:05:50 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d3so15167841plr.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 22:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rnzuDwY9FmAO14Kx2NCVg1gQTcRNz9Evdut4pXlMBxI=;
        b=AuP2RTco0awU63q4n0GIvtcwnCHVbdJez5/WLQXESQzc/nIG8P+V8I1/YQ0XABgROh
         AJUunBwsQS5gpyEd73FnNTNJPfI3itXYrO4XsBpksWezZoyUAsq+BCFb+2S8d7Gba3xT
         K8vgYhXdLCRBrTgApccHpwg9VbaJi28eFoH6LUMhu7Gfyhii8pMPShKDc3M1fxceuqdu
         nXu527EnqbfxW10ZbxiDCwMFHbbyS8AppjLYkvLczwvMh9UQaPjw+H2dfRx8Sjer6lm1
         Qz3blw42igyyTPs2tMSuhiK+kADhcFq+9b/8x2OKfsIxS5mZVZ1XPcYdZVnpqw04CQV7
         I0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rnzuDwY9FmAO14Kx2NCVg1gQTcRNz9Evdut4pXlMBxI=;
        b=xJltLeKsjEO/o3co/DUX91A5TL0kfkZdQtu+nCWvioYvCC3AkHXfgDkr281z5lggrj
         CBo6/RLf+pD8lVCKiXYerFgdK/vbY5Q/nzbY/aDd0Ld86h/upW8Ye5WO7j97sORbKrQT
         hkje9zIWg4mNV8vf+qiekfF2XlC/NJLBEGcq46q9nohvxUnGpQoVZaQQCh7jD7WllAKh
         KCjqAHzl4uMzlrowuid7btNg2TA7zydQkMXVhGMRsueUjUA18bpqmy+JRjp19IYNtf2M
         SrUvVyQ+IlLeIv+mdCaLjPDjwo1xarlO6aVVYdGRLB5umCpdgbj1urO0dsfCZrmdzlvq
         cH4g==
X-Gm-Message-State: AFqh2krqUvH8oJXTOZZwcpIsLx4+b1rffcRaXqDFu1YXwxn6NCjb7K5e
        qv0GtjEjqHH88tlBE7DdgiyJ0w==
X-Google-Smtp-Source: AMrXdXtlwww+E/odVueMr/N2wKd4XOMnCpTXEuIng2vOgpPBqnamR+zOalyxDDPEbMTdu1fZUbZ7MQ==
X-Received: by 2002:a05:6a21:788c:b0:a3:49d2:9504 with SMTP id bf12-20020a056a21788c00b000a349d29504mr2890705pzc.3.1672207550025;
        Tue, 27 Dec 2022 22:05:50 -0800 (PST)
Received: from [2620:15c:29:203:93f7:84:3b7b:8294] ([2620:15c:29:203:93f7:84:3b7b:8294])
        by smtp.gmail.com with ESMTPSA id h7-20020a17090a470700b002192a60e900sm11029318pjg.47.2022.12.27.22.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 22:05:49 -0800 (PST)
Date:   Tue, 27 Dec 2022 22:05:48 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>
cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [patch] mm, slab: periodically resched in drain_freelist()
Message-ID: <b1808b92-86df-9f53-bfb2-8862a9c554e9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drain_freelist() can be called with a very large number of slabs to free,
such as for kmem_cache_shrink(), or depending on various settings of the
slab cache when doing periodic reaping.

If there is a potentially long list of slabs to drain, periodically
schedule to ensure we aren't saturating the cpu for too long.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 mm/slab.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/slab.c b/mm/slab.c
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2211,6 +2211,8 @@ static int drain_freelist(struct kmem_cache *cache,
 		raw_spin_unlock_irq(&n->list_lock);
 		slab_destroy(cache, slab);
 		nr_freed++;
+
+		cond_resched();
 	}
 out:
 	return nr_freed;
