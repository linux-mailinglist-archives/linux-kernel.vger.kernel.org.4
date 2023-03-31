Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE6C6D2974
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 22:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjCaUaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 16:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjCaU34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 16:29:56 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D282B76E;
        Fri, 31 Mar 2023 13:29:55 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j13so21688465pjd.1;
        Fri, 31 Mar 2023 13:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680294595; x=1682886595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ON3ePqj/wXwvqLAB1yIimizzqbLUeCNd0TWXqbkcGVM=;
        b=Y0/w0BpUD/RjYQDJHQTZYdcHHj90Xry7pIWujDCnBcNgrI6ewhUvX+Za73JbTxs7vO
         XmqeUrQNZ6PSpjLbaQYTpQz3gC07EVRf+w2leb80++HMdS+OClW9auiVQ8alG7xRTTi8
         tZ2gHwZ/XYcPdkKi2RPCa6RndYCZM6pknN+nu+q7TqtL17FJK/H5X4UIqzH6aj7ZZ53n
         yFHKsLXvWTYot/+pEncxNU8BkyX+wP802Vbk6wx6R+zco+dCywhomwW3xAURnHqzV2Ic
         rrIt7hs5P/5ce4SMST4pn7d6DbYGB2vj/9lS7cCTmYWluWtPFBw38qoEM8qRyngsvJoT
         pZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680294595; x=1682886595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ON3ePqj/wXwvqLAB1yIimizzqbLUeCNd0TWXqbkcGVM=;
        b=yCYGkSdUH3z5SDjfKhNYMPUtY2RDNf3SaVC/t+c3AIQwNpkR6s34ei/30TG9p2XOdA
         K1cewOsXyrSxlMePsVP5Z6RZs1HOXGM6SI98DUGNBg6lpoXxqdyIw/1D6k9ErqqQCtIj
         0e5xdzHcmDTbRk3qVQ+l5wVX0vkIvODCQPttTPh/S259KUr/MY0VBuEih+Htm3ATWciX
         2W2QvleRpXEVT9mszXy1pzpLt/WzTD9c2Y/wvlpepYHGfOu1TeI4Jb/hzdvo7WDfxKDL
         8KAkGzuglhlNdnTUFFK7yKd3gE3419w1TL8w+GnQIqlNR1AJbBxn0Mzl2JcMGQsgCscX
         Sjag==
X-Gm-Message-State: AAQBX9fatTVXMES5DCrDPodmhExKEcuaHr7vzDqj8QVeZg8OPX9xkBZH
        IwmSDCXUpwXBETtK6A4bIoy8Ct8tn3Y=
X-Google-Smtp-Source: AKy350a0MmdY/uaNdjYU5X3rSslGoDtaaLFqO9OBh6CD0QbVnn1ginhw6HqbHiswugjl1Scgr/nfUg==
X-Received: by 2002:a17:903:27ce:b0:19c:da7f:a234 with SMTP id km14-20020a17090327ce00b0019cda7fa234mr22844841plb.67.1680294594606;
        Fri, 31 Mar 2023 13:29:54 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:44b0:5cfb:ad2c:e6f5:d42f])
        by smtp.gmail.com with ESMTPSA id t14-20020a1709028c8e00b001a1dc2be791sm1916803plo.259.2023.03.31.13.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 13:29:54 -0700 (PDT)
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
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 2/9] perf tools: Fix a asan issue in parse_events_multi_pmu_add()
Date:   Fri, 31 Mar 2023 13:29:42 -0700
Message-Id: <20230331202949.810326-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230331202949.810326-1-namhyung@kernel.org>
References: <20230331202949.810326-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the parse_events_multi_pmu_add() it passes the 'config' variable
twice to parse_events_term__num() - one for config and another for
loc_term.  I'm not sure about the second one as it's converted to
YYLTYPE variable.  Asan reports it like below:

  In function ‘parse_events_term__num’,
      inlined from ‘parse_events_multi_pmu_add’ at util/parse-events.c:1602:6:
  util/parse-events.c:2653:64: error: array subscript ‘YYLTYPE[0]’ is partly outside
                                      array bounds of ‘char[8]’ [-Werror=array-bounds]
   2653 |                 .err_term  = loc_term ? loc_term->first_column : 0,
        |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
  util/parse-events.c: In function ‘parse_events_multi_pmu_add’:
  util/parse-events.c:1587:15: note: object ‘config’ of size 8
   1587 |         char *config;
        |               ^~~~~~
  cc1: all warnings being treated as errors

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/parse-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index cc8e8766ca30..0010e5e0ee68 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1601,7 +1601,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 
 	if (parse_events_term__num(&term,
 				   PARSE_EVENTS__TERM_TYPE_USER,
-				   config, 1, false, &config,
+				   config, 1, false, NULL,
 					NULL) < 0) {
 		free(config);
 		goto out_err;
-- 
2.40.0.348.gf938b09366-goog

