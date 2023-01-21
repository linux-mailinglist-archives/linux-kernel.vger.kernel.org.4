Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B41676378
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 04:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjAUDkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 22:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjAUDkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 22:40:06 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F8A2D5F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 19:40:06 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id k18so6940529pll.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 19:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E0GuYQ0G2pHZ2CbzhRDvaQYe3yXi7QgsYoJRG+c3IfY=;
        b=g9O69hSPUUH1UI04WY8Oj4LiUrVyYZZaB3AkX1QEvzudVMNV8FREOyJGsxcCuLPen/
         W/VHgHR2CBfmWJQntj4arjevp2CYtiWY39sK7cVpyfztIxwxT81UC6ptUqM61bJmOkGc
         RrvcLK+J43ektIPvssT5ULhHensowUmVBpUJoQLAteUtqe6OPGYEiWQbpFPUdFPTP1Hb
         t4/hNh+hy6AdYMPlZrglexXDxnahHY3ax5P/EllOLmR/7hlcQKIoPa30NZFRNoLFz9KQ
         rTtvoCWgnwCm2L93z3ckefpycnNyqn2kXHho795lyWFuFUEur+PH7vCbKx+Xe/B7Y8ok
         H2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0GuYQ0G2pHZ2CbzhRDvaQYe3yXi7QgsYoJRG+c3IfY=;
        b=TndtMPyJZrNF7CrME6taj9w//Llzoe4fm3zoDKUF0XSUyq1zwTQtbwDaZ/Qd8xuxxb
         evMU7NsB4WmPVP0ed3swscsIY6wMPB1cswzQbrDPlpCppKUeA1NBNKn3NAuSNBgPCP+y
         XiMaWFE4ixB/Hj3n05+1Nd9xnl81vX3VFnjbl91OCFudbNwUT+lf+1rak0C6BiQy1lg4
         XCOZpedVyt1jMNK4B/6n4OnIimcKercgj8bIIbjb/3IQpSDsb1hwRm9RjFxo/TZ7HuQv
         S7w5LssrMN5FeoLCiFnNefOEIz9idOZVs+t/u/8D0EmTll2YMG87oQuShl+v1e+JCfG1
         T6Vw==
X-Gm-Message-State: AFqh2krBmok6Bc+qBSIShAnQNWS8PWExnePijpYLzdp7ftOaQXcUK7Qc
        h6om1yb+qXGrmnG2nmhx7ms=
X-Google-Smtp-Source: AMrXdXvpGvfhQcKB1wwwgU3bg1uNVCaA2QiVeitPKOeP9jLqAhmC7DZISdyx3ps5i+MZ2i/ETs59vA==
X-Received: by 2002:a17:902:f2ca:b0:193:2303:c9e5 with SMTP id h10-20020a170902f2ca00b001932303c9e5mr15667506plc.20.1674272405501;
        Fri, 20 Jan 2023 19:40:05 -0800 (PST)
Received: from hyeyoo.. ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902b18700b0019335832ee9sm23331274plr.179.2023.01.20.19.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 19:40:04 -0800 (PST)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Matthew Wilcox <willy@infradead.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH mm-unstable] lib/Kconfig.debug: do not enable DEBUG_PREEMPT by default
Date:   Sat, 21 Jan 2023 12:39:42 +0900
Message-Id: <20230121033942.350387-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In workloads where this_cpu operations are frequently performed,
enabling DEBUG_PREEMPT may result in significant increase in
runtime overhead due to frequent invocation of
__this_cpu_preempt_check() function.

This can be demonstrated through benchmarks such as hackbench where this
configuration results in a 10% reduction in performance, primarily due to
the added overhead within memcg charging path.

Therefore, do not to enable DEBUG_PREEMPT by default and make users aware
of its potential impact on performance in some workloads.

hackbench-process-sockets
		      debug_preempt	 no_debug_preempt
Amean     1       0.4743 (   0.00%)      0.4295 *   9.45%*
Amean     4       1.4191 (   0.00%)      1.2650 *  10.86%*
Amean     7       2.2677 (   0.00%)      2.0094 *  11.39%*
Amean     12      3.6821 (   0.00%)      3.2115 *  12.78%*
Amean     21      6.6752 (   0.00%)      5.7956 *  13.18%*
Amean     30      9.6646 (   0.00%)      8.5197 *  11.85%*
Amean     48     15.3363 (   0.00%)     13.5559 *  11.61%*
Amean     79     24.8603 (   0.00%)     22.0597 *  11.27%*
Amean     96     30.1240 (   0.00%)     26.8073 *  11.01%*

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 lib/Kconfig.debug | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ddbfac2adf9c..f6f845a4b9ec 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1176,13 +1176,16 @@ config DEBUG_TIMEKEEPING
 config DEBUG_PREEMPT
 	bool "Debug preemptible kernel"
 	depends on DEBUG_KERNEL && PREEMPTION && TRACE_IRQFLAGS_SUPPORT
-	default y
 	help
 	  If you say Y here then the kernel will use a debug variant of the
 	  commonly used smp_processor_id() function and will print warnings
 	  if kernel code uses it in a preemption-unsafe way. Also, the kernel
 	  will detect preemption count underflows.
 
+	  This option has potential to introduce high runtime overhead,
+	  depending on workload as it triggers debugging routines for each
+	  this_cpu operation. It should only be used for debugging purposes.
+
 menu "Lock Debugging (spinlocks, mutexes, etc...)"
 
 config LOCK_DEBUGGING_SUPPORT
-- 
2.34.1

