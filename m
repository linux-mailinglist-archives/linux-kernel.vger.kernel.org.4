Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DB474192F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjF1UB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjF1UBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:01:46 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CA31FF6;
        Wed, 28 Jun 2023 13:01:46 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666eef03ebdso120873b3a.1;
        Wed, 28 Jun 2023 13:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687982505; x=1690574505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8rBC54h3TqzO9Dqa/LMLhbq/U3gSsKwzSwcc3zbIic=;
        b=TdpOW9/uiMYrng7phmY9h/ygcWEDPzlQXSGsOBafxfzi+fRuSbxfH94J6rkyP+LLVk
         wJngk0RxllDwKPxB88BPEAguKA4Gi9zccEOyEPyVyY0UDMQsZOQoV81w8+pJGDRGw2iB
         N2RGFxF7oiMnPKJkkxEGbMH+RBmdUMVkgSeY8WNG0m9kX4INHvE6EBy0mIj3X5GwO/Ro
         krrg9YY59wF1PAQg3GFop6kks8jV43g5o959MqhdiO+C0O7jhxkWQudVSJQDa1+8c0F+
         jLZuU+KoOSf9WgOPudPy3tvibdexV6msFES0u8kcgoDPAyjeBgTIgqnAhbTPRn/buv/r
         EeyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687982505; x=1690574505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c8rBC54h3TqzO9Dqa/LMLhbq/U3gSsKwzSwcc3zbIic=;
        b=hbvwXi9grLq2bqGuZuS6efkrZFpXyOefk9OIcF5YYZ+Boz1ZBsRpATwHR5ZPaXJ84J
         KJUFo6CMpeFmf4QucuBTEylaxwgs1g6ygTZYoicj5DudJ6xjdeduBOLScokltsPaxY9F
         3b1Dht9OxhxN6xdLVXHQQachRlw/0pv9GS0XI0PpkGNHo8jF8kAKnQpt/2NWb4GG8qWs
         W//qeTCV+Nd9fZ+1y56Rlc8OqwBwOYzWcWE5H4LvlhHsaJ9GgzxNDezrCI6eo32wI2eE
         k3hhNxazQCy75vibpRnHDDMQpZzUmmO7RsFuVjSj9sao0aQCblB/NE5zDbjduo1iWN5t
         iv6g==
X-Gm-Message-State: AC+VfDxPIcUv9MW0+XpWL1l4jZdotjaJCuEqyvTrYG28qO1yOeOleRU2
        kZH8CHGsSqNEAkCBa4hHgtw=
X-Google-Smtp-Source: ACHHUZ67J7MUDfaWo7Gc4irDeQBnU/Elc4xrYwJ/qt0GtxJSSvLT8QrdtNv+WQCpgYhP/AXN0xXOjQ==
X-Received: by 2002:a05:6a20:4305:b0:123:c3dc:2052 with SMTP id h5-20020a056a20430500b00123c3dc2052mr17839261pzk.35.1687982505378;
        Wed, 28 Jun 2023 13:01:45 -0700 (PDT)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:fc6b:e50c:c8f0:b09b])
        by smtp.gmail.com with ESMTPSA id f3-20020aa78b03000000b0065e154bac6dsm7340376pfd.133.2023.06.28.13.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:01:45 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH 1/4] perf lock: Remove stale comments
Date:   Wed, 28 Jun 2023 13:01:38 -0700
Message-ID: <20230628200141.2739587-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230628200141.2739587-1-namhyung@kernel.org>
References: <20230628200141.2739587-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment was for symbol_conf.sort_by_name which was deleted already.
Let's get rid of the stale comments as well.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index da36ace66d68..187efb651436 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1773,7 +1773,6 @@ static int __cmd_report(bool display_info)
 		return PTR_ERR(session);
 	}
 
-	/* for lock function check */
 	symbol_conf.allow_aliases = true;
 	symbol__init(&session->header.env);
 
@@ -1902,7 +1901,6 @@ static int __cmd_contention(int argc, const char **argv)
 	if (con.aggr_mode == LOCK_AGGR_CALLER)
 		con.save_callstack = true;
 
-	/* for lock function check */
 	symbol_conf.allow_aliases = true;
 	symbol__init(&session->header.env);
 
-- 
2.41.0.255.g8b1d071c50-goog

