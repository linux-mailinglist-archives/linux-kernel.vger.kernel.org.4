Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E855167828D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjAWRFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbjAWRF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:05:27 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7B727D6E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:05:18 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id s124so10949773oif.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2GRRNrDhCrnlwVW91CW9FSUCR/cr5m9HywrBeRIIiU=;
        b=finZTNj1eGWaV2AmpSJfvqcxLGxQU2fTE9yH9iw/wQIpHK0AtwI358OYChnUXm/8iJ
         885GsZ7L+Qd2HsByw4673Ec8W+rPwybrY8NNH9uVdmzttMMGB3crZ6X3JaWMwMfvVtZ5
         Kat9fNB7+JiCO6EMl4pHgb/8bzTiYCfgU5JtHk2K5dkGGaEJs7DbGIxeER6UUFvFSuBS
         gyV74PLOidorQhN12tk9QB59wPIuufCpu3l30daIVWeu9BC3GItN8Y5FYyuJDN1xy7xZ
         Dw46z8YRHz0afNEvAByA6Aq4wWLUJrJAEcTazwhOgd3Fof5IFs50ES3tOmcCZL68xZil
         mneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2GRRNrDhCrnlwVW91CW9FSUCR/cr5m9HywrBeRIIiU=;
        b=wtJAjAu6kTq6tzVtqGEecOsSO4HtCatwlLSjJVnfrFBpeaNpaeo7N51zWtUyJ4Tfg/
         UpdCSDnJCD4c/qR835Jdf2M+eeBjVMOgsHp3MbT/bT0+sxsmcw8dj8+oBjHkjpAZBlUS
         +wj6fZn0TxydNfsMJP5MiLuxCpqPkdiNWZd4+Dt4EIy9MUitdGFTckzVaFOksZNzezVA
         Hgfcv1tnhM/x3rCYd3XU6yEqviGZicgmDyuY/LZPwoIgWI9ft0bfmmmceEwxcARJk6pt
         gteOlDniMfnFERgiulOjfkWhNTihPd8x9W8HuyJtKlxf73GPU5TQxr7sFh7gL/BeiOtB
         caSw==
X-Gm-Message-State: AFqh2ko+MqRxjn2snaNbo5c8UCZo6WOsBNXJRw/ZjgXIANVS2vJiuskL
        aPUJFpHySW3mIwfqYSWOSJZTTy3kyfvLpyD2ieeeOzKJL5wQ/ViS9HJsUjKeAab2vgCck8KsIL8
        CpMCWNOE+403AKNcKTYwdApFYCrbN35pHNibirLvo1mkM4S+QCL9hD3f0Bj/4pm7hanuQig33ub
        xRnYB62CQPzA==
X-Google-Smtp-Source: AMrXdXtf3m6tswAwu4JAcP7eCbHkFbal+Boirz42qiwEY8KwjUMPKGRMWdR5Ardxhr7Hb+ZCseEe/g==
X-Received: by 2002:a05:6808:1414:b0:363:b9af:ec89 with SMTP id w20-20020a056808141400b00363b9afec89mr15920247oiv.1.1674493518413;
        Mon, 23 Jan 2023 09:05:18 -0800 (PST)
Received: from DESKTOP-B7RB26P.localdomain (cpe-70-114-202-97.austin.res.rr.com. [70.114.202.97])
        by smtp.gmail.com with ESMTPSA id 2-20020aca0502000000b0035ec1384c9esm23160163oif.23.2023.01.23.09.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 09:05:18 -0800 (PST)
From:   George Prekas <george@enfabrica.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        George Prekas <george@enfabrica.net>
Subject: [PATCH 6/9] mm: kmemleak: do not scan cpu_cache of struct kmem_cache
Date:   Mon, 23 Jan 2023 11:04:16 -0600
Message-Id: <20230123170419.7292-7-george@enfabrica.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230123170419.7292-1-george@enfabrica.net>
References: <20230123170419.7292-1-george@enfabrica.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code already makes sure that kmemleak will not scan similar caches:
array_cache and alien_cache. For the cpu_cache, the code takes a
different approach using kmemleak_erase. This approach handles object
allocations but does not handle transfers to other caches and leads to
undetected leaks.

According to the comment in alloc_arraycache: [...] when such objects
are allocated or transferred to another cache the pointers are not
cleared and they could be counted as valid references during a kmemleak
scan. Therefore, kmemleak must not scan such objects.

Signed-off-by: George Prekas <george@enfabrica.net>
---
 mm/slab.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 29300fc1289a..a927e1a285d1 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1744,6 +1744,7 @@ static struct array_cache __percpu *alloc_kmem_cache_cpus(
 	for_each_possible_cpu(cpu) {
 		init_arraycache(per_cpu_ptr(cpu_cache, cpu),
 				entries, batchcount);
+		kmemleak_no_scan(per_cpu_ptr(cpu_cache, cpu));
 	}
 
 	return cpu_cache;
@@ -3023,20 +3024,8 @@ static inline void *____cache_alloc(struct kmem_cache *cachep, gfp_t flags)
 
 	STATS_INC_ALLOCMISS(cachep);
 	objp = cache_alloc_refill(cachep, flags);
-	/*
-	 * the 'ac' may be updated by cache_alloc_refill(),
-	 * and kmemleak_erase() requires its correct value.
-	 */
-	ac = cpu_cache_get(cachep);
 
 out:
-	/*
-	 * To avoid a false negative, if an object that is in one of the
-	 * per-CPU caches is leaked, we need to make sure kmemleak doesn't
-	 * treat the array pointers as a reference to the object.
-	 */
-	if (objp)
-		kmemleak_erase(&ac->entry[ac->avail]);
 	return objp;
 }
 
-- 
2.37.1

