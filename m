Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC6B5BBB40
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 05:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiIRDPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 23:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiIRDPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 23:15:34 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E06248F2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 20:15:33 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id iw17so25024217plb.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 20:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=OS4UYZ8DIUkJDvQP5tRmIq0ewNPcm5dr1beINkDXglI=;
        b=TeaGBrs24ZanM/HhDvim4InqF+clK+TEuKanEY4Qnu85x12T07n0VtWqplkYIXJTBC
         KttvxGMKbG6aQBKsS054AZX2oJhYt04ZGPmzG0f5KhpStYZFmo9JyJtbqnCDNyAp0aw3
         jn9VEoaZ0ohW5CEc6Wcr20EsxRBYSyj3/XE1H1CQOc5fLzSQiBPxypWF0W3vjV+UNQsO
         pGhGPA0FBc/sicFLqBS+GtoGo1ulND4DtvVJ3zlWkK2HssBqR5yentQEqwtbzmVVkw2U
         lp5k3pI3Mac9pQ+MaDouf9II8T6wMl7Utk19PBxxiMXdcgw4OszWSI0LAAYXTulaujkL
         X3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OS4UYZ8DIUkJDvQP5tRmIq0ewNPcm5dr1beINkDXglI=;
        b=nZLETlNjZlcFqchw2/31A2DneX+Zy4X5aCzFSxvxUIdud+/gkSHn3ua47166VJXF0T
         9cDzcU7YG5Gyvu/3ZYYfpXtob7yugXvE3UAhyfhz+NooCwMhGf4Jqvsr9/Q1gTCOMpi4
         jDrEfTOOe851mIVE0YwrTvL65ISi3SH24LEcHJIEA4P5I+/27BRQ+/ulSctlpcVTyqeM
         psQ+x1At+W1vtXQ0qs3kwMKfr9zS3fYRaJ04b5FZnKCYE3GCvPEc2uMJiTfTqeI6QkV4
         BmEtjjH7cCJ4eb7KrgBgNRLvngDdk3+dfgy1ekKin91hplL76tmIYGgF08daB5rquN9H
         ZTOQ==
X-Gm-Message-State: ACrzQf3l0KKCdprqzwzpae74ld7vRrcyL/TQ6ydbJuAqo8CHXoT7BwjY
        J7TrDNd4KYa+JYQm+7QIZBpmOmNXasa1wAkzhA8=
X-Google-Smtp-Source: AMsMyM7qxFQRgCk07DjoucrzWeRWhfxIw3/DC+osQydxwrq/UjTjNm9dpGDI8OYLwiSRCKpbM1Y4/Q==
X-Received: by 2002:a17:90a:c782:b0:202:c73e:5488 with SMTP id gn2-20020a17090ac78200b00202c73e5488mr23516835pjb.202.1663470932638;
        Sat, 17 Sep 2022 20:15:32 -0700 (PDT)
Received: from leoy-yangtze.lan (45.78.11.189.16clouds.com. [45.78.11.189])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090301cd00b00177f4ef7970sm17822647plh.11.2022.09.17.20.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 20:15:32 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 1/2] perf subcmd: Set environment variable "PREFIX"
Date:   Sun, 18 Sep 2022 11:15:23 +0800
Message-Id: <20220918031524.26719-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220918031524.26719-1-leo.yan@linaro.org>
References: <20220918031524.26719-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

