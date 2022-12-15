Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25AA64E1C5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 20:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiLOT2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 14:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiLOT20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:28:26 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E015A47310;
        Thu, 15 Dec 2022 11:28:25 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d7so1408pll.9;
        Thu, 15 Dec 2022 11:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmvCh9yWugB6d0aTmM0VqqANfCxzP4Vie55qPJtB7BM=;
        b=CeLAmgOiXHIHJn83Qhm5ixy1ObxMdDGRJ4N7S+Zg1RY0kHpTS85+DNblRtc3BhUPZl
         m1V9YMC5Z+MCEYu1fiNjjpzZUdzLSb6EFz+USZtexhudhKn5jgM8y4qiBM2ZPv4SfMOU
         gxfgxDlGPbnRBprjU8nBze+xAloxq5caTp+RufjQfwQ0ZJmyQpW4l8HgUczdUwq8nECy
         K4ZsjIDeNuYH0u11lFU+yyEg5nz3x/r0oUC/Ul0wvhEdyquwGNbHBrawfWC1y/d2uA2x
         WpH7uEQI1eqQMsrq+ENkq0YwaCxHl37umCz/GaYlXhBRvH7g5A8mfYUlRXMbOYJwQ50m
         1Dsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PmvCh9yWugB6d0aTmM0VqqANfCxzP4Vie55qPJtB7BM=;
        b=uF0KJBtRoNfsnyvNVQXlP9fN58AZvZ7u7ggvPPS8fdSG87UtXKyZinx0VLp5w5rZZj
         WTrlro+04h49tbm5aBPtVLYXYYFvlyL3i2qJXL+3O8ynpDV3xjUgzPdU7T/UeVoczN2y
         mWr64fCID/1q2Xt7gt/s1mDuDLqt5WB++JImVzw/IcfapjXddj3m2PZzTcRgEIp1bizV
         z47QmPKmb/Df0ddtdTt83ZIpx0ceYXzO5W8/Zm2FfhizjIUxfvoIax3879giERUd/RTq
         YHfV/AFwukExBlnXQquee3Bl/646Riq3hycN+/kRIiY+c/UCiHrCpRIVYw/EQvKcN6P/
         cLrw==
X-Gm-Message-State: ANoB5plIfaUtXMXQqXaN9mYDdXs/Zc1KQyoJKriNGxmTjz4G33QX7RcT
        0sxFcDc4d6Oy5OCrgzH9pV0=
X-Google-Smtp-Source: AA0mqf4wtz2yafBiL61XmWmsglECRXYgg003yapMm9cTEisqZTK2L7YZY2iN9FEs9nV39FaG20d0MQ==
X-Received: by 2002:a17:90a:740e:b0:219:78e:9c3c with SMTP id a14-20020a17090a740e00b00219078e9c3cmr30076808pjg.39.1671132505350;
        Thu, 15 Dec 2022 11:28:25 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:ecc1:3e44:be34:129c])
        by smtp.gmail.com with ESMTPSA id ep14-20020a17090ae64e00b00219cf5c3829sm3475129pjb.57.2022.12.15.11.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 11:28:25 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 4/9] perf srcline: Skip srcline if .debug_line is missing
Date:   Thu, 15 Dec 2022 11:28:12 -0800
Message-Id: <20221215192817.2734573-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221215192817.2734573-1-namhyung@kernel.org>
References: <20221215192817.2734573-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The srcline info is from the .debug_line section.  No need to setup
addr2line subprocess if the section is missing.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/srcline.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 5319efb16a5a..2c212e2e1b65 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -550,6 +550,9 @@ static int addr2line(const char *dso_name, u64 addr,
 	size_t inline_count = 0;
 
 	if (!a2l) {
+		if (!filename__has_section(dso_name, ".debug_line"))
+			goto out;
+
 		dso->a2l = addr2line_subprocess_init(dso_name);
 		a2l = dso->a2l;
 	}
-- 
2.39.0.314.g84b9a713c41-goog

