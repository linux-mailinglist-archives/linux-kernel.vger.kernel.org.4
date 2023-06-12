Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006C372D511
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 01:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238217AbjFLXlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 19:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238039AbjFLXlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 19:41:10 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BB7124;
        Mon, 12 Jun 2023 16:41:07 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1a6b7060862so191157fac.2;
        Mon, 12 Jun 2023 16:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686613267; x=1689205267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2idTz1dI6R8Bw9mKAT+NEGNVBgEcKr2rXGyUpAj9+VU=;
        b=mB7cvxaim/8ZW9lHIU6lPRBtBVdQGyUyF7w/Ves7I7UzY9aln8lv2zFB8x6FiAsoQx
         evbQJQlxpWjEMLrfL05DdfpvfCKwiCayTx8Cihk32yBvYSvP6vUkjx5kX6Ulaq5L4i2o
         iflgiWkANNwHQrkF59utzROQChv2vSRy47uBfgVsNt/aUHDprnSjyx6qOzEATxjsXSSf
         ZQSE7au3F3SwDnx9Z7EDfc4TQl0jMqmBh4HGj8cVygjsOs5zb9ShcNDij2Lt2gQHAInF
         LZZZq/4JvuOkTln9n5GXrLwd6CDpMURymHyBXCYeKBaHOPaignGE83NFu8k1M5B0G9Qc
         6VrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686613267; x=1689205267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2idTz1dI6R8Bw9mKAT+NEGNVBgEcKr2rXGyUpAj9+VU=;
        b=K0p0lA5Bk0JLLaiIegJV9rqz+q/tBPBXjgzyCJFqby03MAo9QQR2Pi3C5LbEskUgIz
         HHJEWd/wO8HabovFCqexTd+p58NqqgkAovYMB9XxgUkBvSMcLFMh/lvXQxypHJIPdrvi
         x4DIlM2T3bG+jYcnL0csXDqYNv/Wn7sUnZkdOzEUvqk/a2e+bW2Q/+XeuCinDQaojlEN
         qsNeVBkYcpjYomIagsSsg/1EoGHseHEX87/9mz0hxHbfDJbtbYj53uS6WdybUbcWNldm
         rOsSwERSQQvOuoq942TfsiEUz1Dt75J+v/6Ii9pauuqUDUk143x/d+8soUKLZyzXr05n
         4Ufw==
X-Gm-Message-State: AC+VfDzAWThQyAb7elIbvZ8G16EUXyC5/FenfzjvxqT+eTGSrvH+eVQj
        g/aZLsaxgwhzMkt+8XCc/KjQtOF/Iac=
X-Google-Smtp-Source: ACHHUZ7HqPKNH19sewXwfiGUfXwY44Aclu+I1FQs4blBB3V2M4vlAWC878Vcx4n1rF33vjkSM6fkwA==
X-Received: by 2002:a05:6871:555:b0:177:809e:ead3 with SMTP id t21-20020a056871055500b00177809eead3mr7199845oal.41.1686613266879;
        Mon, 12 Jun 2023 16:41:06 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:1e19:385a:b5d0:f4a2])
        by smtp.gmail.com with ESMTPSA id t12-20020a62ea0c000000b00643355ff6a6sm7565619pfh.99.2023.06.12.16.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 16:41:06 -0700 (PDT)
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
Subject: [PATCH 2/2] perf dwarf-aux: Allow unnamed struct/union/enum
Date:   Mon, 12 Jun 2023 16:41:02 -0700
Message-ID: <20230612234102.3909116-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230612234102.3909116-1-namhyung@kernel.org>
References: <20230612234102.3909116-1-namhyung@kernel.org>
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

It's possible some struct/union/enum type don't have type name.  Allow
the empty name after "struct"/"union"/"enum" string rather than fail.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 1ac88b79687d..759434552653 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1074,16 +1074,18 @@ int die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf)
 		/* Function pointer */
 		return strbuf_add(buf, "(function_type)", 15);
 	} else {
-		if (!dwarf_diename(&type))
-			return -ENOENT;
+		const char *name = dwarf_diename(&type);
+
 		if (tag == DW_TAG_union_type)
 			tmp = "union ";
 		else if (tag == DW_TAG_structure_type)
 			tmp = "struct ";
 		else if (tag == DW_TAG_enumeration_type)
 			tmp = "enum ";
+		else if (name == NULL)
+			return -ENOENT;
 		/* Write a base name */
-		return strbuf_addf(buf, "%s%s", tmp, dwarf_diename(&type));
+		return strbuf_addf(buf, "%s%s", tmp, name ?: "");
 	}
 	ret = die_get_typename(&type, buf);
 	return ret ? ret : strbuf_addstr(buf, tmp);
-- 
2.41.0.162.gfafddb0af9-goog

