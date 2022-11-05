Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EC361DAAA
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 14:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiKEN7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 09:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKEN7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 09:59:40 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE15620BE3;
        Sat,  5 Nov 2022 06:59:38 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y203so6849507pfb.4;
        Sat, 05 Nov 2022 06:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2VGen5F4wRHnElI7bxeSRaRwtCRZafiIgyKdmdxpY5M=;
        b=ZBSwev+3fS8foai/lxRVCQ5HORJW/mX6OK+S/745P8Dxqp4yXbJTGjskKbayxJCh2F
         Xx2ib0n+1wGNw7tXkt0UkgJvwgTGvjnMUrHcngpR8PLendVZMMXScDukSJwPSOGOECEx
         3nf1XyAsBfbBfzcW/g5Zt+5cXWPq2+uroIq4/m8NBkBoGFzOINBUhPQBWVi0CsQCeYHc
         ajx9c7JHHw/kkMUG1KlEQmAa5DES2fxC6PASbC+fIjtLy6X8VSpbCE6PMxJBrTtvoxTE
         4HvuhUDke2vfHDyRJr5xKi9Y3/zVWkqCJzfgmP2T3muYERaGgJ+Uff2PUgwYsQgDvi3Y
         ux5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2VGen5F4wRHnElI7bxeSRaRwtCRZafiIgyKdmdxpY5M=;
        b=L1JHIdaQcpJtLnoxs5fPaD0ODHF3mIrsVU1Ek6nB154wJyHV40t0n/6LP4Nyn4HDM4
         ZrjswH5/Elupnz8hNlfKx+JPFjWBnx5OYIMwGHuW/we57oINkVeOrY+87WPB0fFVBrwz
         LcSNJyAVEKlpcxvSDF6Zy4i9LFhZzQr5Og+tKIjj1aJo2NY2ORN//+EtlhK2omfn4n/W
         YfXBRqbVK1kT0svk1Vfsu8yBxXzb4u9WhoFvKenBWfbo1YcBCDW6TeJT1Qyvbj7lQQaS
         EfjzoZR42GPsLBvfLKS9mZgXY4ZbdsBUV/JNOZfzcJ7kAvO6G8mBsb0Gs/1sKx+cQwgg
         yyew==
X-Gm-Message-State: ACrzQf2Zm9sNXy293sxF/X1KPUjbEkHbeNGC+f29lJDYKwf3KgtdAa7q
        yNlHk2GfYWYrRa9PKhOMuLY=
X-Google-Smtp-Source: AMsMyM4Yv6iBcUYVoQ3nH2DFk/VbgI33wuXw9f4LHs8PMStaADQ08aQEMg2ivczJTlKGDEs/Bm/m8g==
X-Received: by 2002:a65:6e0f:0:b0:43a:1cd4:4ae6 with SMTP id bd15-20020a656e0f000000b0043a1cd44ae6mr34023270pgb.289.1667656778238;
        Sat, 05 Nov 2022 06:59:38 -0700 (PDT)
Received: from uftrace.. ([14.5.161.231])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709027e4100b0017f5ba1fffasm1672000pln.297.2022.11.05.06.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 06:59:37 -0700 (PDT)
From:   Kang Minchul <tegongkang@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kang Minchul <tegongkang@gmail.com>
Subject: [PATCH] perf print-events: Remove redundant comparison with zero
Date:   Sat,  5 Nov 2022 22:59:32 +0900
Message-Id: <20221105135932.81612-1-tegongkang@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since variable npmus is unsigned int, comparing with 0 is unnecessary.

Signed-off-by: Kang Minchul <tegongkang@gmail.com>
---
 tools/perf/util/print-events.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index c4d5d87fae2f..6df947df1c0f 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -311,10 +311,8 @@ int print_hwcache_events(const char *event_glob, bool name_only)
 				if ((hybrid_supported == 0) ||
 				    (hybrid_supported == npmus)) {
 					evt_list[evt_i] = strdup(name);
-					if (npmus > 0) {
-						for (j = 0; j < npmus; j++)
-							zfree(&evt_pmus[j]);
-					}
+					for (j = 0; j < npmus; j++)
+						zfree(&evt_pmus[j]);
 				} else {
 					for (j = 0; j < hybrid_supported; j++) {
 						evt_list[evt_i++] = evt_pmus[j];
-- 
2.34.1

