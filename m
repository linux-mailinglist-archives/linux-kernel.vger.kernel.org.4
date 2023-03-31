Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B6B6D2979
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 22:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjCaUa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 16:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbjCaUaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 16:30:04 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC85922222;
        Fri, 31 Mar 2023 13:30:02 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j13so21688815pjd.1;
        Fri, 31 Mar 2023 13:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680294602; x=1682886602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJy9ywO65dgXdPExYWd/WvWg/5bb5i5vxOfS+9ONLpE=;
        b=Dq/ZgPQkU5fblBTtWmiLNvUS3Ic9vsP2pqx4BomQixfxHnz8czK3NIW/AbhsvVtDxG
         PTzdoZB7mn5rHN567sdRjrqPRtDd73uvKeHNdnXjQMNpQ1uo8fT96PCbmExoZGHwdFI3
         Pc8NeVJ+Sh9YuLTgS+KE31VtrcLJ+vrM/U4Xgkh3DS0v6LZptXkFn02JgUyKnQ/WO/Ey
         DG8u4Bj1hoZIlcd1HTr/grLCBUGE4NSVXcdqpN4gvfLmOj3gQtq+w1xPePRqnmuljpWU
         bWdYUY9PXrw6q4UXwpzCMWLDQH5Naj2rvlNqZ0D5pBzljp45K4Taxjl4vDB+bbAwXOla
         hyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680294602; x=1682886602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XJy9ywO65dgXdPExYWd/WvWg/5bb5i5vxOfS+9ONLpE=;
        b=oathkcXPzMzrvWwIb7bEbfIG0QfMla9v6CTSJTeW/ML2r5k4f9JNwURwlpy5tU2K48
         HQv5G/482yN8+r4o44cX+qfUwBU6/lt72esAvH8x+yTpn3LP2S3CxOKGYgvcoe9W8B45
         CVnIkFT0CtE7LjY51ibjGdW0HUob7qrEHlVY+2JxvYHwZOh8r8QxwPJut7pxhXXtZAZr
         /U9gciVSIK1PqjCfN8C9ecPqaKMK/wMAhQ0xzd6m9bZz6EeZUmW2HlUNxWRUv5okN1Xu
         RDwtBPbPrde7JH5HXhbPikBVHGjpkOhyq3kJ0K8a6VUxY6X1B57HXTLLksq85NP2G+nU
         k09w==
X-Gm-Message-State: AAQBX9dzWsmjBIweaxErhysL/TnC156Xdg7D0jBsJcA6M8D+7iu5LzBz
        2u4fYmimFXFu3tL5+LdmjuM=
X-Google-Smtp-Source: AKy350amgDAmFcEKgHVPM7C5h3M8fg1ZTRuceQkPIEUVEVDhXdyw7pWvPMoBDQ9A912D02kjHAAq1w==
X-Received: by 2002:a17:902:c951:b0:1a2:3108:5cc9 with SMTP id i17-20020a170902c95100b001a231085cc9mr28632579pla.40.1680294602145;
        Fri, 31 Mar 2023 13:30:02 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:44b0:5cfb:ad2c:e6f5:d42f])
        by smtp.gmail.com with ESMTPSA id t14-20020a1709028c8e00b001a1dc2be791sm1916803plo.259.2023.03.31.13.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 13:30:01 -0700 (PDT)
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
Subject: [PATCH 7/9] perf pmu: Use relative path in setup_pmu_alias_list()
Date:   Fri, 31 Mar 2023 13:29:47 -0700
Message-Id: <20230331202949.810326-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230331202949.810326-1-namhyung@kernel.org>
References: <20230331202949.810326-1-namhyung@kernel.org>
MIME-Version: 1.0
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

Likewise, x86 needs to traverse the PMU list to build alias.
Let's use the new helpers to use relative paths.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/arch/x86/util/pmu.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index f73b80dcd8bd..3c0de3370d7e 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -71,7 +71,7 @@ static struct pmu_alias *pmu_alias__new(char *name, char *alias)
 
 static int setup_pmu_alias_list(void)
 {
-	char path[PATH_MAX];
+	int fd, dirfd;
 	DIR *dir;
 	struct dirent *dent;
 	struct pmu_alias *pmu_alias;
@@ -79,10 +79,11 @@ static int setup_pmu_alias_list(void)
 	FILE *file;
 	int ret = -ENOMEM;
 
-	if (!perf_pmu__event_source_devices_scnprintf(path, sizeof(path)))
+	dirfd = perf_pmu__event_source_devices_fd();
+	if (dirfd < 0)
 		return -1;
 
-	dir = opendir(path);
+	dir = fdopendir(dirfd);
 	if (!dir)
 		return -errno;
 
@@ -91,11 +92,11 @@ static int setup_pmu_alias_list(void)
 		    !strcmp(dent->d_name, ".."))
 			continue;
 
-		perf_pmu__pathname_scnprintf(path, sizeof(path), dent->d_name, "alias");
-		if (!file_available(path))
+		fd = perf_pmu__pathname_fd(dirfd, dent->d_name, "alias", O_RDONLY);
+		if (fd < 0)
 			continue;
 
-		file = fopen(path, "r");
+		file = fdopen(fd, "r");
 		if (!file)
 			continue;
 
-- 
2.40.0.348.gf938b09366-goog

