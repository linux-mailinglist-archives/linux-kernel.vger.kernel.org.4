Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1CB6E4F99
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjDQRsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjDQRsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:48:30 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B879C3;
        Mon, 17 Apr 2023 10:48:29 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f167d2941fso16521045e9.1;
        Mon, 17 Apr 2023 10:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681753707; x=1684345707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jB1xSXNmpwcA25uvh5ZQdPIIhw+Ev7b4/mxTIIm4AO0=;
        b=lSI324OV20WxE+4pdlggDyXcDT/VEUFW8FVXZsfbs+n4pBxxucr180XtKo4hREUnq+
         KU4V2muCy1QinMcBtb97XXmB3bLeF8C8bld/ouxAMaCgzTU9trFkqvs5W4qWOvKHnyLi
         j0KoTzKnKOksW9o9rhyh4tpKdqyXPTTyzVYPePDFrO57awuQFgBCPBsNlWgKOI6Lq35Z
         I4xLZQkZGim8RQcvnhPjQnm544A59NIJ1M4OK1onvfPd9WBtLtXM47Bm3zDGsIwgPNig
         EAHVOa+BY4zer6PHF1oUAzxci6wWtlhmW/7DHTGUOA2bqAfrJgg6CDJnUKY4Z2nn2kxs
         xWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681753707; x=1684345707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jB1xSXNmpwcA25uvh5ZQdPIIhw+Ev7b4/mxTIIm4AO0=;
        b=Dn9KitkXEgCPo9TyIV0JRj3efLkw/FSNbQ5eILdJeKzW+7RumgYTmmS5Q44Dgx68kB
         yNMUN1JyCP9ViscLgJxfSEVykL4HLXEr+3VS3eF8o7WY6h6QQlRR9bDp3ET+wsFsrCXM
         BO2WR3MKhU+uP24+uo04wMpFtGVVHTtDZxGuqhW14r3OYdUkZwYLvM/sTc0JwC7cPSkO
         gQgM2MPPAxWRn8Ie2y+NJnWhEK9a2SIgYUYO92RTJaIs1JDDqL3x1TXoxswbqpTIjoEw
         1ufCIFIkgyPMK5WFBlgVn2Cpc6f1gIkqEJhJ2NzPdx7njuL83vm9WzvdCAyFdCJ+0iUX
         iJGQ==
X-Gm-Message-State: AAQBX9eTpfot5g4FANcR3xQvBQgZH1qMvZr3nkNm/4GvbE1NNFBYIh/R
        e5fbQ64IfXb2nPjxU8lNbdg=
X-Google-Smtp-Source: AKy350ahiiHUo1uqxBOzXUyQQEt0O2gqBfeI9Mvh4CfLe0d0j4P+xmpQQgYWZwk76slIUaWEKk8iRA==
X-Received: by 2002:adf:df85:0:b0:2f7:825c:9db0 with SMTP id z5-20020adfdf85000000b002f7825c9db0mr5712911wrl.52.1681753707456;
        Mon, 17 Apr 2023 10:48:27 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id f16-20020a05600c155000b003f177cda5ebsm398199wmg.33.2023.04.17.10.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 10:48:27 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Petar Gligoric <petar.gligoric@rohde-schwarz.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        linux-perf-users@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] perf script: task-analyzer: Fix spelling mistake "miliseconds" -> "millseconds"
Date:   Mon, 17 Apr 2023 18:48:26 +0100
Message-Id: <20230417174826.52963-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in the help for the --ms option. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/perf/scripts/python/task-analyzer.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/task-analyzer.py b/tools/perf/scripts/python/task-analyzer.py
index 52e8dae9b1f0..3f1df9894246 100755
--- a/tools/perf/scripts/python/task-analyzer.py
+++ b/tools/perf/scripts/python/task-analyzer.py
@@ -114,7 +114,7 @@ def _parse_args():
         "--ns", action="store_true", help="show timestamps in nanoseconds"
     )
     parser.add_argument(
-        "--ms", action="store_true", help="show timestamps in miliseconds"
+        "--ms", action="store_true", help="show timestamps in milliseconds"
     )
     parser.add_argument(
         "--extended-times",
-- 
2.30.2

