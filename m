Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E9F5E90CD
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 04:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiIYC7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 22:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiIYC7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 22:59:12 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D097243639
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 19:59:11 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id p14so826864pjd.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 19:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=OS4UYZ8DIUkJDvQP5tRmIq0ewNPcm5dr1beINkDXglI=;
        b=pMsNwRcTsrUwx4709l7bBQopVh9p8cTyUX4+N6zn0nGWfJ8aUJeAL6mO0gTX6Fasms
         v6I78Uu9UXJKgF9koM9Gqx2WiZ9DClMxdqnvUt/Qo2o2CF6QPdvNcnnS1J68fBRHlbAw
         1ELy3Qr8uuE/wKvYsVvHYLnEmfvYXtu//PF3eBf37gXTqz9SdeNH0Qt8Rf5LoVmeECOG
         E1eJmnL8Ko/RY4KPHkoIGJVVSUbb0CHJ0Zk0ZMs01k4+9bKxesewUk4QsDCjk40Ih3q9
         W5daZ9pOk/mE+CjCMPmT+2PpcxG/n3BcT6VvlGFxksLSc3bYw/U2+ptcBKiw1MCgLIbM
         PP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OS4UYZ8DIUkJDvQP5tRmIq0ewNPcm5dr1beINkDXglI=;
        b=QqmVeAZVD+sd40fSYpyN9GvH5Wf3g4QAgrcLh78D7RUZUyFqY6+DgEWhxMbMuNBFJ8
         lnSGXjtqPZ8l4pFN3Cf9B1dbB4BN+pm4lM17eNj8Eg8qVe51H8y8JC4bmveyyacq39Aa
         Zi9/KCXrTmCXNxfl/7nyrbDYLbq/LsPJdqwRJAvybkchjyMQn7EcQiO9H7dKnT9irmEZ
         p2iTLIiWnCzlkSfVC296NAFljHtZxzcaxmuOWyG/VXTQxPQ/aMiMgIchHD5HjVbPCsO5
         5vT2XbaPgharl8MIKFPVDajITULjazptEfSQGj9CWwTsYGixCh70j/1sFImMwv9F08Vo
         L97g==
X-Gm-Message-State: ACrzQf1XjMHFGwgyue574FGl4Qs7BSb+tDaa/jpgHnj3hhToxokv+0RC
        R0xc0Ndv6mzBRcXSzYdtjMfHZg==
X-Google-Smtp-Source: AMsMyM5joIJtYlA+twvlOzLjCdbWpan9i8/RzhsZZqMGnmVHxEZzaYDb9ZC1IigVr9ymwVaW1/gj5w==
X-Received: by 2002:a17:90a:1b6e:b0:1f5:1902:af92 with SMTP id q101-20020a17090a1b6e00b001f51902af92mr29852232pjq.238.1664074751300;
        Sat, 24 Sep 2022 19:59:11 -0700 (PDT)
Received: from leoy-huanghe.lan ([137.184.34.254])
        by smtp.gmail.com with ESMTPSA id z11-20020a170903018b00b0016bf5557690sm8409198plg.4.2022.09.24.19.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 19:59:10 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 1/2] perf subcmd: Set environment variable "PREFIX"
Date:   Sun, 25 Sep 2022 10:58:34 +0800
Message-Id: <20220925025835.70364-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220925025835.70364-1-leo.yan@linaro.org>
References: <20220925025835.70364-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set environment variable "PREFIX", it will be used by invoked shell
script, e.g. the shell script uses it to find lib paths.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/lib/subcmd/exec-cmd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/subcmd/exec-cmd.c b/tools/lib/subcmd/exec-cmd.c
index 33e94fb83986..5dbea456973e 100644
--- a/tools/lib/subcmd/exec-cmd.c
+++ b/tools/lib/subcmd/exec-cmd.c
@@ -24,6 +24,9 @@ void exec_cmd_init(const char *exec_name, const char *prefix,
 	subcmd_config.prefix		= prefix;
 	subcmd_config.exec_path		= exec_path;
 	subcmd_config.exec_path_env	= exec_path_env;
+
+	/* Setup environment variable for invoked shell script. */
+	setenv("PREFIX", prefix, 1);
 }
 
 #define is_dir_sep(c) ((c) == '/')
-- 
2.34.1

