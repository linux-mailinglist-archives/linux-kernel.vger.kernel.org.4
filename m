Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF02F6E9A80
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjDTRSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjDTRS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:18:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0757A469A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:18:25 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 132-20020a250c8a000000b00b8f4e12dd57so2681195ybm.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682011104; x=1684603104;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YdIqMyPsEr0gHs4l/llP+kkiN7mlxuAb3vlVBqEI0dg=;
        b=VZBVK9Wk4NuIbFIFJxytyMlkljzYTpCwXmlMNhlTQJBgio03D0Ga6j7Vaa0Qh64f8q
         9ioPsZhH1NMX7ra+cqxLo5JZ/T4/t6XHcdMhnH/c/f8c11+7yt4NKZViQiO1trsLhwGi
         f/lJsZEiiUtlkkiXQQFn35RH9zMlWIMr9T80uN3MMIx2zMx+MbblSYD0Bv/AgeEnKJN4
         HV3iICnx3TISDRfQQRINqpOjKDpGK7Oq7TVnZP/WEAIvyz0B+gs1VeJmjcpahmsCpb0S
         FPHr00arqpKItk3RKnD+AhfK3QDtXeMt7jHDof5rgrbJyznuNxkcYafMsFMmQNcAEvFm
         ZsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682011104; x=1684603104;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YdIqMyPsEr0gHs4l/llP+kkiN7mlxuAb3vlVBqEI0dg=;
        b=aq7Z9g8AqwWWbHICdXue6vRfAdUxpzq8zJoh9hG+qdfRC2D7jBNvnoq9NaTd0mmF1X
         qYHtxLQBzplrwWupcPTLpvSipu8/yqeFd43aWveJtkJ8laajpyWTf/F00HBm301DCWTL
         Yi7VfLnrMoQZa+IZwBz7pQl7aKPjwDP36INoVgnPErWnSvwWvoxE+3kFBDvDSWxD8lxO
         xyf7ez4OmKWjb/oTdqGswwl+xagLGeFd56fVEHQRypLsi1QG829deR2UckQV/cpZigj8
         mvLJsX53PRLFFKtAU14bh4aSmSzQTSFBEmw8JwTFhPSx3vdHvA9FdEnvj5T2guNcG7wa
         +uUg==
X-Gm-Message-State: AAQBX9evuqmZAAkrrYfnBZV0x9CZgMkI8OxVp3IGXYNn1WYLJklgWZg5
        l3pEaOzqXJoKE29HA6XdRJLudD+4V+D4
X-Google-Smtp-Source: AKy350YCsMObkz9XUCyBTT8b9NxzuVD1AGbQwwdZ2MIHTkJGkMlbZEVeV1X6z7bNzUnxUrlqxy4evNWM4NvG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:2265:b6ce:fba4:80e6])
 (user=irogers job=sendgmr) by 2002:a25:76d1:0:b0:b76:ceb2:661b with SMTP id
 r200-20020a2576d1000000b00b76ceb2661bmr1502922ybc.3.1682011104229; Thu, 20
 Apr 2023 10:18:24 -0700 (PDT)
Date:   Thu, 20 Apr 2023 10:18:12 -0700
Message-Id: <20230420171812.561603-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Subject: [PATCH v1] libperf rc_check: Enable implicitly with sanitizers
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If using leak sanitizer then implicitly enable reference count
checking.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/internal/rc_check.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/lib/perf/include/internal/rc_check.h b/tools/lib/perf/include/internal/rc_check.h
index c0626d8beb59..d5d771ccdc7b 100644
--- a/tools/lib/perf/include/internal/rc_check.h
+++ b/tools/lib/perf/include/internal/rc_check.h
@@ -5,6 +5,14 @@
 #include <stdlib.h>
 #include <linux/zalloc.h>
 
+/*
+ * Enable reference count checking implicitly with leak checking, which is
+ * integrated into address sanitizer.
+ */
+#if defined(LEAK_SANITIZER) || defined(ADDRESS_SANITIZER)
+#define REFCNT_CHECKING 1
+#endif
+
 /*
  * Shared reference count checking macros.
  *
-- 
2.40.0.634.g4ca3ef3211-goog

