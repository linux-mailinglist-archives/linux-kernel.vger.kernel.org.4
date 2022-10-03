Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCD15F354B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 20:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiJCSK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 14:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJCSKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 14:10:50 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B84E25E84;
        Mon,  3 Oct 2022 11:10:49 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id i17so7021698qkk.12;
        Mon, 03 Oct 2022 11:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=6GSBpywsjKwPYr9hvx5GHTfSyCn4GlAqxJaWR8Wo4kE=;
        b=a9WJRwXeC7awSc02b11mfesATFj5xtBd6llcvg3qJLnJrC33eS148byjd/TsHGqMbH
         zS53uh3nvUyH50Rq6CWhV8MzjwXJc5zktsmcGKxI7ITIZfxMfj0360rwtLoTdFTJjiY6
         B6WmIUqtrs4fCCxGAb4ESyFDDvCGM6Csozf5eNXTZOFPRqTb7KTGNxZSvc2+/iEDeYEO
         BQKXinOk4GcyDq5bbYDEsYX1x695p3xCAgjVR+9JpFbcplJXqEH/bEnsBT1RlEVHqT4X
         z2KuJlCkzsOOl5XZqwrmcqhnBSXO2R5PbKa3ooNO86a8CCd8L+/t4z+cFP+qlA33UAGG
         8Fqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=6GSBpywsjKwPYr9hvx5GHTfSyCn4GlAqxJaWR8Wo4kE=;
        b=0KuY2jkn0y1mhTWUZzf3COZi+XWjuqxeahQGBYfi/EQy0ZgSdk5LV/d78KQOMjhuXu
         cnL13YjzaRxRHj4juCfAYQM5AUPA/pdnj4BTuIVYFV2PIpFlrL0im7Y5BbbLTuaABGW/
         FJbSbR8klETfgxdBD90tGvCoSKCNdk8qWAaz/xFWFG20PfGtaS3NFuGm5IIPTq/TUyHf
         IaTlZQWTriapSxfnjD3j2Fa8IHX3vfjMhkgYtLgfGlfwSzRTcROPO6Q9IfbzU9KkU1b4
         WLQCQtTLXKkNgkqjQTHEZYHRDG4ngtZL8l0Ek7rlrl4cHwCSgbSFl6LbnMWnRCrZD/YL
         rDbw==
X-Gm-Message-State: ACrzQf0FfYa1Tyh3O4xkh2KZ0mSWWblwpjM5XxRXiRO+PV89H4NEbMo/
        pNBzywacrJjD/u1robl7K2Q=
X-Google-Smtp-Source: AMsMyM4FnfmYgVQg5JBBX7kgw8rHsxg7t3Isw4ZnZJ7BBhcMSkSJsIcdL5SBLEcNi5RZsi4y78IDOA==
X-Received: by 2002:a05:620a:4304:b0:6d4:56aa:430e with SMTP id u4-20020a05620a430400b006d456aa430emr7118326qko.483.1664820648173;
        Mon, 03 Oct 2022 11:10:48 -0700 (PDT)
Received: from localhost.localdomain ([177.222.37.214])
        by smtp.googlemail.com with ESMTPSA id bs43-20020a05620a472b00b006b5df4d2c81sm12176226qkb.94.2022.10.03.11.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 11:10:47 -0700 (PDT)
From:   Henry Castro <hcvcastro@gmail.com>
To:     hcvcastro@gmail.com
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf: fix the probe finder location (.dwo files)
Date:   Mon,  3 Oct 2022 14:10:39 -0400
Message-Id: <20221003181040.4822-1-hcvcastro@gmail.com>
X-Mailer: git-send-email 2.20.1
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

If the file object is compiled using -gsplit-dwarf,
the probe finder location will fail.

Signed-off-by: Henry Castro <hcvcastro@gmail.com>
---

> Anyway I think it'd be safer to do
>
>    if (dwarf_cu_info() == 0 && unit_type == skeleton)
>        pf->cu_die = subdie;

Thank you, I have modifed the patch :)


 tools/perf/util/probe-finder.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 50d861a80f57..b27039f5f04b 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1161,7 +1161,8 @@ static int debuginfo__find_probe_location(struct debuginfo *dbg,
 	struct perf_probe_point *pp = &pf->pev->point;
 	Dwarf_Off off, noff;
 	size_t cuhl;
-	Dwarf_Die *diep;
+	Dwarf_Die *diep, cudie, subdie;
+	uint8_t unit_type;
 	int ret = 0;

 	off = 0;
@@ -1200,6 +1201,14 @@ static int debuginfo__find_probe_location(struct debuginfo *dbg,
 			continue;
 		}

+#if _ELFUTILS_VERSION >= 171
+		/* Check separate debug information file. */
+		if (dwarf_cu_info(pf->cu_die.cu, NULL, &unit_type,
+				  &cudie, &subdie, NULL, NULL, NULL) == 0
+		    && unit_type == DW_UT_skeleton)
+			pf->cu_die = subdie;
+#endif
+
 		/* Check if target file is included. */
 		if (pp->file)
 			pf->fname = cu_find_realpath(&pf->cu_die, pp->file);
--
2.20.1

