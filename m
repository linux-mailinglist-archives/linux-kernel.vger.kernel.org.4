Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E37A6119CF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJ1SBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJ1SBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:01:36 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B918320FB19;
        Fri, 28 Oct 2022 11:01:34 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id f23so5485763plr.6;
        Fri, 28 Oct 2022 11:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmGyjkUI3Jx6s05ye5A4TzB4tPD0VcBwkqsa8EyR1XQ=;
        b=hD6Z0lr0qNzTb/h7xWEEo4kab7blvNR1dkhEaQcP+TQbguozLm/pd3/Wt/YmB4P7VN
         zVIhEM+5h48c3QkGE9zQvi9LVupqNaK2dYG+Fjcj3Pr7aL4ezJQvVeYbhMFgLxrVws4k
         +/U90S2XvRrJ/fjOz5Aj6jOZ/7czeOddZDXBXn/Si6nlOVhVnCIDgVibEdsBpWXxKKUu
         SSE/mFx6NJ3+KSrlM0jnpeBc9ltZsFAL+diDGr6YfNqElfMWiWPcZRC9WYXolLcGNZgW
         ppVj33Jp3cZ/d+WH9MrzS683eYX9A93CeqZWkFOY1saHh6BMkN5Marchffqlr3qop3zp
         IF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NmGyjkUI3Jx6s05ye5A4TzB4tPD0VcBwkqsa8EyR1XQ=;
        b=NCkPKbE+jacPLisBJQAxuiH964muzLFrpXZGN0zp8pgn1cntnFw5bJS5pYROn5H+pn
         9ssnONagho2m3f1NijusOS3W2mG924YxjW6NK0bmHC+2+VALwV8f5QWMfG5MBh6rMl1D
         5qiN4WqhMxNMqFE10wUMNXjZC2IDY2o8C6m0FPBlOupGxTe4Saq8PSquGICsdcTAWaqz
         zZHkBeShxaLdxuI1ZZY/5D4mOpvb3PCO0s/HajvAYK2FqJdSu6Twkbbh6sUwHUhwm8LQ
         nE5KHbh8by1iLRGRLrxzhXaTc6c5lq6oO31baHhW01dTZ1/iOOHjWjV6WvtJRJATRTB9
         iS2Q==
X-Gm-Message-State: ACrzQf11HOA4z6M7N9ZNJ2i08yr4rh5R7NAr12ezDYcRBy/EWdxwcvpa
        Hr2b2XZKFWo4PM2cgP65IbI=
X-Google-Smtp-Source: AMsMyM6oJIlbvojF6YXXEDr6isWduRhmVUwWJu6d5tRV2QMhZqYRLjbfnnA7R2sf/n2tVE8xjtvFVw==
X-Received: by 2002:a17:90b:4f4a:b0:20c:64e2:2bee with SMTP id pj10-20020a17090b4f4a00b0020c64e22beemr18093806pjb.32.1666980093820;
        Fri, 28 Oct 2022 11:01:33 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:976f:f075:7c14:87a2])
        by smtp.gmail.com with ESMTPSA id n3-20020a170903110300b00186b86ed450sm3400236plh.156.2022.10.28.11.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 11:01:32 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/4] perf lock contention: Fix memory sanitizer issue
Date:   Fri, 28 Oct 2022 11:01:25 -0700
Message-Id: <20221028180128.3311491-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
In-Reply-To: <20221028180128.3311491-1-namhyung@kernel.org>
References: <20221028180128.3311491-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The msan reported a use-of-uninitialized-value warning for the struct
lock_contention_data in lock_contention_read().  While it'd be filled
by bpf_map_lookup_elem(), let's just initialize it to silence the
warning.

  ==12524==WARNING: MemorySanitizer: use-of-uninitialized-value
  #0 0x562b0f16b1cd in lock_contention_read  util/bpf_lock_contention.c:139:7
  #1 0x562b0ef65ec6 in __cmd_contention  builtin-lock.c:1737:3
  #2 0x562b0ef65ec6 in cmd_lock  builtin-lock.c:1992:8
  #3 0x562b0ee7f50b in run_builtin  perf.c:322:11
  #4 0x562b0ee7efc1 in handle_internal_command  perf.c:376:8
  #5 0x562b0ee7e1e9 in run_argv  perf.c:420:2
  #6 0x562b0ee7e1e9 in main  perf.c:550:3
  #7 0x7f065f10e632 in __libc_start_main (/usr/lib64/libc.so.6+0x61632)
  #8 0x562b0edf2fa9 in _start (perf+0xfa9)
  SUMMARY: MemorySanitizer: use-of-uninitialized-value (perf+0xe15160) in lock_contention_read

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_lock_contention.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index fc4d613cb979..06466da792e4 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -110,7 +110,7 @@ int lock_contention_read(struct lock_contention *con)
 {
 	int fd, stack;
 	s32 prev_key, key;
-	struct lock_contention_data data;
+	struct lock_contention_data data = {};
 	struct lock_stat *st;
 	struct machine *machine = con->machine;
 	u64 stack_trace[con->max_stack];
-- 
2.38.1.273.g43a17bfeac-goog

