Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A127118F0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240627AbjEYVUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjEYVUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:20:43 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38056195;
        Thu, 25 May 2023 14:20:42 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d18d772bdso276607b3a.3;
        Thu, 25 May 2023 14:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685049641; x=1687641641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=45SuE5tqoQ9NMHm14LfNKKCQI6JSEw3tNHdyDgpIw7s=;
        b=Ndi8URAN5vHTz0bC2Q7OVlxN3AK2sCndjWHABSvRm9nbF5fn4ZXFeimGpbGBda43Ho
         RoPfDpYH3U+Pzob+GqEvecnebL1ca5e9tSk54SEY8gnqiu1a45A9VkR5Ee7eLWbPVe1F
         UQdOuztfkHpn1+dCPgTmv8Cgo311zeaUy+hEnFTAkiRTWa2u+E526k7UAipC7O/OQeDv
         mH3nqfv348ul7HoBIaGK4mPAy8tSqObwa6z2x2FFDyuJx8fOSTMWRtEa25LaLd2+7YEs
         cgpEteXtiN3DojMy4WMPp7JY1HZM8497v+vqK6sXYTGYHd3CkziKEU7pImqcH7h170q0
         0v+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685049641; x=1687641641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45SuE5tqoQ9NMHm14LfNKKCQI6JSEw3tNHdyDgpIw7s=;
        b=inAf6i+D61DQIaQkmYZpFLddnAWnFA2BbFZG3S7Vuu1px6yG0jGovCqV0OiQeD16uX
         mZBf3/8excShOcostjQ61dPzIGAHQ9NDG7yqvMn2WG2WI41mh67bAqUQn4LmUyhvMQ9d
         3vKOuchYJUZSBlYuUEJ0k0WEw5RdjibeatEM+JmrsdgO21bPxsx6LkvuPd/UtRQVOiwz
         skzuNdprFiKmJA+223co+SWfDVf8UPsIJqozLvrxyl8gtTgJCGFYWqCtAyg9ZIXsT/JB
         41tJleR8D6TwhoZjetMxwliUADc560ZstCutGe3+zRReoNyMrizrG6iDBYT6HHPJdjkb
         jTlw==
X-Gm-Message-State: AC+VfDx5SxzSijSJY/hmE2KqnR7J0E7dBvKfW50zgje988rAiOootTPH
        NcFNkiowI5GW/qhQLX4DsDA=
X-Google-Smtp-Source: ACHHUZ7FPZD5wWjzyBxVjlaa3d/WQeREicaIKDqhWFMoUB2Zy3LJMo3nKvJBEnQB8qBJRiiWebsoaQ==
X-Received: by 2002:a05:6a00:1ac7:b0:64b:7c1d:518e with SMTP id f7-20020a056a001ac700b0064b7c1d518emr13583pfv.31.1685049641387;
        Thu, 25 May 2023 14:20:41 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:7217:977f:12fc:72e0])
        by smtp.gmail.com with ESMTPSA id l11-20020a62be0b000000b0064f46570bb7sm1522820pff.167.2023.05.25.14.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 14:20:40 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Changbin Du <changbin.du@huawei.com>
Subject: [PATCH] perf ftrace latency: Remove unnecessary "--" from --use-nsec option
Date:   Thu, 25 May 2023 14:20:38 -0700
Message-ID: <20230525212038.3535851-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
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

The option name should not have the dashes.  Current version shows four
dashes for the option.

  $ perf ftrace latency -h

   Usage: perf ftrace [<options>] [<command>]
      or: perf ftrace [<options>] -- [<command>] [<options>]
      or: perf ftrace {trace|latency} [<options>] [<command>]
      or: perf ftrace {trace|latency} [<options>] -- [<command>] [<options>]

      -b, --use-bpf         Use BPF to measure function latency
      -n, ----use-nsec      Use nano-second histogram
      -T, --trace-funcs <func>
                            Show latency of given function

Fixes: 84005bb61486 ("perf ftrace latency: Add -n/--use-nsec option")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index ad2a9ae041f6..ac2e6c75f912 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -1177,7 +1177,7 @@ int cmd_ftrace(int argc, const char **argv)
 	OPT_BOOLEAN('b', "use-bpf", &ftrace.target.use_bpf,
 		    "Use BPF to measure function latency"),
 #endif
-	OPT_BOOLEAN('n', "--use-nsec", &ftrace.use_nsec,
+	OPT_BOOLEAN('n', "use-nsec", &ftrace.use_nsec,
 		    "Use nano-second histogram"),
 	OPT_PARENT(common_options),
 	};
-- 
2.41.0.rc0.172.g3f132b7071-goog

