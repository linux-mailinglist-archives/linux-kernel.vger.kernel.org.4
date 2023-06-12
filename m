Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FFE72D510
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 01:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237196AbjFLXlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 19:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238088AbjFLXlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 19:41:10 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A52131;
        Mon, 12 Jun 2023 16:41:06 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6563ccf5151so5393667b3a.0;
        Mon, 12 Jun 2023 16:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686613266; x=1689205266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=tO4BEzDA5SKQ1mdhJE03WlcR/YP5mBsUNepj0gTUsj4=;
        b=IbNtXXLwsAM5WoJd86ZKQwz4shGA/1q1CC81HOR5uAxaxd+s4ckX6wYWKpXxlMhUj1
         E05p9tGl38qtBj+hWQLavaSsU1fwmORdBg+5a9QDJrhIqyNLqnUr1shpP4CTeptmswu2
         2b95/4ONvKCZ1Y2qjKsvkFEDuzxZ7r9oBSTHYONlo4+P+k40WE91mdpItsbp5zhQkyMc
         1h6aKT/YNR+xu4iN5qgSzw2ZKSSOYlwgTUfomXOfXp2J27MTOH3S8tFfNISHndC4dnRX
         9K7xrveuPfthECwaA8Ywod4miAoK7h6xp8LxBSJQdU84wz+U8+xOvn69JVcQlerXiiVC
         D2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686613266; x=1689205266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tO4BEzDA5SKQ1mdhJE03WlcR/YP5mBsUNepj0gTUsj4=;
        b=O9559XQMD9q7NPUCRza34Q05vzEZH4BR1yuhr1kN0EXUEtEAzibwY+hndixNc4vnAL
         Y0apmUzN+Yar8KhiFIZbAqscPPrt0bIW/j7eRUhmDTcI6iGqZAX0GprqdGGXz9NU+tOQ
         J0BIj+kMghuBM7fvV+BYZzsAEjPLmn2L+WQ/ZXSZWMHWbqQLDQjFHpwCuI3sgWVYO4PJ
         pUIXCrvXNNVK9PJiT0PTHkxedewHrDVcLKpGB9YICv/oUnfU65RU44NHzL0Scx2OtOrp
         YcypUaaIw+t6oZUJee2CLJEhBWbimwGCwmCfnleqeI1JrFqjJJPXf3NaOTJpux0WnlQy
         zrxg==
X-Gm-Message-State: AC+VfDwfTyUe7XHCL4as5VhF4/+2i6NDbl4KsXS1aQAhU6HWWg3ExVPs
        0FI++KenFDVMqRS2Eib1130=
X-Google-Smtp-Source: ACHHUZ45g0s26QqVsvUuILK5LluS0vA0/vkdbZcWdnjUmGd2ynULJhO1U4OALjfodlnj3JQXjOFveg==
X-Received: by 2002:a05:6a20:549f:b0:10c:1047:68ba with SMTP id i31-20020a056a20549f00b0010c104768bamr14647373pzk.35.1686613265809;
        Mon, 12 Jun 2023 16:41:05 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:1e19:385a:b5d0:f4a2])
        by smtp.gmail.com with ESMTPSA id t12-20020a62ea0c000000b00643355ff6a6sm7565619pfh.99.2023.06.12.16.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 16:41:05 -0700 (PDT)
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
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 1/2] perf dwarf-aux: Fix off-by-one in die_get_varname()
Date:   Mon, 12 Jun 2023 16:41:01 -0700
Message-ID: <20230612234102.3909116-1-namhyung@kernel.org>
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

The die_get_varname() returns "(unknown_type)" string if it failed to
find a type for the variable.  But it had a space before the opening
parenthesis and it made the closing parenthesis cut off due to the
off-by-one in the string length (14).

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index e4593a71556b..1ac88b79687d 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1103,7 +1103,7 @@ int die_get_varname(Dwarf_Die *vr_die, struct strbuf *buf)
 	ret = die_get_typename(vr_die, buf);
 	if (ret < 0) {
 		pr_debug("Failed to get type, make it unknown.\n");
-		ret = strbuf_add(buf, " (unknown_type)", 14);
+		ret = strbuf_add(buf, "(unknown_type)", 14);
 	}
 
 	return ret < 0 ? ret : strbuf_addf(buf, "\t%s", dwarf_diename(vr_die));
-- 
2.41.0.162.gfafddb0af9-goog

