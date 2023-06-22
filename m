Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FFC739717
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 07:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjFVF6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 01:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjFVF6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 01:58:37 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD92EA;
        Wed, 21 Jun 2023 22:58:36 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-341c81d71f6so29579425ab.0;
        Wed, 21 Jun 2023 22:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687413515; x=1690005515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=6LgDdsVWxwuIcdGWkXM+//E7h6q+sL/ftkkHRO/sno0=;
        b=d5XoRu21YNy2Tz7y9D8qfodXjHbHjPINszK1ZfNE0peIL9eYeTiIbubpZ56jtzGw3T
         +Hty8mSDnuslgGvyVH32WLlQ/F7daHeVADWwvEB+LO5DLWeJERZVY0h/Jku8eARL2hdz
         nb1UXVqbl7qoRhJW076ed2FQ1pld8LaLjGu+Ke4rZHCC9DzNcb60kGwrg4RM1zHAEMbk
         LRvfZbN7QwbM9z8mw23ahBy1+X1h7yOkrm+2T1vDm3rNRR6AePPB+gs/rjykywx6YosF
         GaguGalfzFzKTWqqhYYQhn7l0n2a38Dx0VVNQzTUYOdjOmKvdic/uwuPQ9Z28JIqeqgo
         NfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687413515; x=1690005515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LgDdsVWxwuIcdGWkXM+//E7h6q+sL/ftkkHRO/sno0=;
        b=MB//zwVjWdZRndIOLodaJkinaXXYUomNvgTZ6APtVp61l4HXNdk3XU55lxVyXxfpN6
         gMe1p7Bcq46YeBLoAzjluo4KAmZ1Zgv5grQ2OB7/Dj4FmgAk+RusnM40dg5M8xah0H0e
         hTjm8eXe8Ct1x52RsyBcvBkPpR7eiYdoxjPLBcLQiISxjG57gw9x0aUgJjaQNf+SBjdL
         YR6YeB8rchDEhul8ZgktH2eSFVBUlaRZlkyJkMLQ9dG4E8icvRYL2gGcPCAvZfOY3PJ7
         58kQXlEvUh1vvsM9Vjwv0jAuOQfezyqIQpHZmW3B5yGJN42sbhf7U09e3FuByj0Ud+ZU
         paiA==
X-Gm-Message-State: AC+VfDxEJqOdIWQ1YeGu2mCmmbWBMop6m3CMjm/dV0NngZzm/K5jUd3S
        9htKaajizd7q96W5qdda0DM=
X-Google-Smtp-Source: ACHHUZ789G4G84oxl5HwGSknm9yhTAsw0RzfQx88pkLl+3Itw3SttMaLnRYxkk+2J363iWmHZ+f4VQ==
X-Received: by 2002:a92:c081:0:b0:340:9132:f99 with SMTP id h1-20020a92c081000000b0034091320f99mr16765919ile.22.1687413515652;
        Wed, 21 Jun 2023 22:58:35 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:ad24:b28c:6f03:5b78])
        by smtp.gmail.com with ESMTPSA id b25-20020aa78719000000b0063b8d21be5asm3903607pfo.147.2023.06.21.22.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 22:58:35 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] perf test: Remove x permission from lib/stat_output.sh
Date:   Wed, 21 Jun 2023 22:58:32 -0700
Message-ID: <20230622055832.83476-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
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

The commit fc51fc87b1b8 factored out the helper functions to a library
but the new file had execute permission.  Due to the way it detects
the shell test scripts, it showed up in the perf test list unexpectedly.

  $ ./perf test list 2>&1 | grep 86
   76: x86 bp modify
   77: x86 Sample parsing
   78: x86 hybrid
   86:                        <---- (here)

  $ ./perf test -v 86
   86:                                                                 :
  --- start ---
  test child forked, pid 1932207
  test child finished with 0
  ---- end ----
  : Ok

As it's a collection of library functions, it should not run as is.
Let's remove the execute permission.

Fixes: fc51fc87b1b8 ("perf test: Move all the check functions of stat CSV output to lib")
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/lib/stat_output.sh | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 tools/perf/tests/shell/lib/stat_output.sh

diff --git a/tools/perf/tests/shell/lib/stat_output.sh b/tools/perf/tests/shell/lib/stat_output.sh
old mode 100755
new mode 100644
-- 
2.41.0.162.gfafddb0af9-goog

