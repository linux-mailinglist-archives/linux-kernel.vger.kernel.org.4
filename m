Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2449618BBB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 23:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiKCWnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 18:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKCWnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:43:20 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC171EEC7;
        Thu,  3 Nov 2022 15:43:19 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id v8so2115682qkg.12;
        Thu, 03 Nov 2022 15:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WdZLCgKHIdzaKrVzd3AIPVk+0hPKJe4RjNLWBaYHtGU=;
        b=lJiY1JXueEt7xixTEIC7QH71PPBv6Fju4ceiWO6XhXrVQTuySFc/K7Mur9umV02Dri
         YHhU35irCmdIu28xCg7RgAKWZJiGbbwtfuq0YSf22VzLJUEMUFbc2Agq2iF/XWL6vsAN
         7nrvptWEl0/f2XaeGfm7UMkFVprO1zYMv5dUtc8evQ/fG1Bst+UKvgi5Z0kWkYiaPC0w
         hfoqouRPLNff3J26vu+Ogsmb68zs9yWw72b46YkrxhH7KoVD+9kXE0t3I//hLTmWZ3tH
         KC9jyBMyRCerYRuRdICiDaFprmd5EN2Q5pIJYrn/HkBpcqoK0po32/1eQLdvlEB7nhJc
         hRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WdZLCgKHIdzaKrVzd3AIPVk+0hPKJe4RjNLWBaYHtGU=;
        b=7GzHu9rSOS0UAAZEsl7bwjLk3hAEx3xMDU4KDb+Bbk9mEgjaBwYGtEufjhPFGExkKv
         gT1Pd7ssNdMfbao1fGMasHocr8RjuTX6I4OiqI8z4JDSdIiFktC6ufXohEOY4TRtp4vx
         6Wjvm76hNWkNQmkhVD43npSBUUkoZtSMxaTx1ZpoK08ZFFnpJC7+VhcKDOdb8vZeomUe
         nrAhRBsajUh3Wr2OCur5vZSNdnGrWEwn1/E4DtJ5X8W1DxUvQMuITi4SonKli/6CqH3q
         3OnH9STLBFW14UUDt1nt9EI2w8QfdVkfK8zpIUCgjmW+DYJP8mHRQyQ7g9lMnHgjFAYl
         S18g==
X-Gm-Message-State: ACrzQf2bVhcsJjvEff24BZjONhVSiFOsSoEFaWcIgQdh9Lbn7XDyr/fI
        FVVnnOO9jKHu8642ADfgCHir8y3brW02VA==
X-Google-Smtp-Source: AMsMyM79RAmUOhW3mdsjAwRY/OHSUJ8w6IBTzPC7YVDCA79bR1oszfYaKFwWIz6q7DG7ywU6yqbvTg==
X-Received: by 2002:a05:620a:12d2:b0:6fa:2ffa:81c9 with SMTP id e18-20020a05620a12d200b006fa2ffa81c9mr17465927qkl.642.1667515398148;
        Thu, 03 Nov 2022 15:43:18 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id fe4-20020a05622a4d4400b00397b1c60780sm1312828qtb.61.2022.11.03.15.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 15:43:17 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     anand.gore@broadcom.com, william.zhang@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS
        SUBSYSTEM)
Subject: [PATCH] perf: Fix perf_event_{init,exit}_cpu stubs
Date:   Thu,  3 Nov 2022 15:43:03 -0700
Message-Id: <20221103224303.3910486-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
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

The original commit that introduced those stubs was already at fault,
but in the absence of a caller of perf_event_{init,exit}_cpu outside of
code that is compiled regardless of CONFIG_PERF_EVENTS, the build
failure cannot be observed. This was observed with the Android kernel to
produce a build failure similar to this:

    In file included from ./include/uapi/linux/posix_types.h:5,
                     from ./include/uapi/linux/types.h:14,
                     from ./include/linux/types.h:6,
                     from ./include/linux/limits.h:6,
                     from ./include/linux/kernel.h:7,
                     from ./include/linux/sched/mm.h:5,
                     from kernel/cpu.c:6:
    kernel/cpu.c: In function 'random_and_perf_prepare_fusion':
    ./include/linux/stddef.h:8:14: error: called object is not a function or function pointer
     #define NULL ((void *)0)
                  ^
    ./include/linux/perf_event.h:1607:29: note: in expansion of macro 'NULL'
     #define perf_event_init_cpu NULL
                                 ^~~~
    kernel/cpu.c:1686:2: note: in expansion of macro 'perf_event_init_cpu'
      perf_event_init_cpu(cpu);
      ^~~~~~~~~~~~~~~~~~~

Fixes: 00e16c3d68fc ("perf/core: Convert to hotplug state machine")
Reported-by: Anand Gore <anand.gore@broadcom.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 include/linux/perf_event.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0031f7b4d9ab..592040e2398c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1678,8 +1678,15 @@ static struct device_attribute format_attr_##_name = __ATTR_RO(_name)
 int perf_event_init_cpu(unsigned int cpu);
 int perf_event_exit_cpu(unsigned int cpu);
 #else
-#define perf_event_init_cpu	NULL
-#define perf_event_exit_cpu	NULL
+static inline int perf_event_init_cpu(unsigned int cpu)
+{
+	return 0;
+}
+
+static inline int perf_event_exit_cpu(unsigned int cpu)
+{
+	return 0;
+}
 #endif
 
 extern void __weak arch_perf_update_userpage(struct perf_event *event,
-- 
2.25.1

