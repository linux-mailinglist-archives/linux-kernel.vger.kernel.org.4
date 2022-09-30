Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835335F15AB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 00:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbiI3WDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 18:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiI3WDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 18:03:31 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844581A0D32
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 15:03:30 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id m18so3622174qvo.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 15:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=aRUqCLLcHsh6POG9Rz1BBcJxeSLfOpSm82me8CPX0EE=;
        b=okvuzhBnK0d0ANULgMPU3k3viUHLg+igv4ggkiK8A2+UE0/eJZAPtUhp1MYjrzmtvV
         TNNtMaIz7UnNMuUhBm+WAXUK2x5genpuOeOJgu+e4xgS7SQKU7bLgoLBGijBzF/PbSQ6
         WwZkzGmCh+x14bZe7dOvH9csgI9C9VWf3zjx8UWlb4J/j+CNNp8/97smzPFttcqVoz37
         cPeCVzcTtCp7yo4ewa4mJNYEQJ0VAU/v8GisL2hs6Wb7EHDZROyBS+Fjlpgz+cdChKbU
         q5h+lU0v8JhxRKuY99n8FzEOHaHGSmTvNtZHyDuraEy9YL83Sndn2OUlggyqWnspj2N/
         gGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=aRUqCLLcHsh6POG9Rz1BBcJxeSLfOpSm82me8CPX0EE=;
        b=5hWyX217+dMsNM38V9obonmrijxGT1PM/HzTvXYKUAfCoK3RJ7e+owIfNvEK4fz+bm
         oOmZkD/Enb9eKYo0ZCQQr70F14a1Daw0XlctqOFwqL1HMl14MOmOO7Ffag1TY+IScnaf
         YVl7w7yslAEY5Woje8XtxiTkUf6uMp5jDdDU1D5oTQjBciMkxFt1kdygiESIUwCdlrbR
         HOseGVarnaEG9Cqh9Z6ImtsBOaFYvBNh6Kz8ml8rDcW89ifYS1MvTep1QUi7VNls7P/k
         PiJrmzULdAN3P5P2Kk8WqvlTk1H66NVA6onMDLtIgkX0yIv0yHPgrheX7N2H7CLd4u3V
         wM2g==
X-Gm-Message-State: ACrzQf1waUgB/oG5R/AlwlHhv4VXBehiYln6uFP485MpL5Zc2EvXxqru
        Zntkzub4WamwQnmI5HqOvO9jIXZQDAU=
X-Google-Smtp-Source: AMsMyM4LVEC5fIG16WfDsSxkuVZnaWCWVYFMy+Oba+4/rIt9DxKAl45VTbTqb28U01WMfpHKPgAN5A==
X-Received: by 2002:a05:6214:dc2:b0:4af:b73f:190a with SMTP id 2-20020a0562140dc200b004afb73f190amr5154489qvt.4.1664575409245;
        Fri, 30 Sep 2022 15:03:29 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id dm19-20020a05620a1d5300b006cbbc3daaacsm3908863qkb.113.2022.09.30.15.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 15:03:28 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH stable 5.10] perf tools: Fixup get_current_dir_name() compilation
Date:   Fri, 30 Sep 2022 15:03:24 -0700
Message-Id: <20220930220324.2427999-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: Alexey Dobriyan <adobriyan@gmail.com>

commit 128dbd78bd673f9edbc4413072b23efb6657feb0 upstream

strdup() prototype doesn't live in stdlib.h .

Add limits.h for PATH_MAX definition as well.

This fixes the build on Android.

Signed-off-by: Alexey Dobriyan (SK hynix) <adobriyan@gmail.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/YRukaQbrgDWhiwGr@localhost.localdomain
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---

This patch is necessary to build perf with a musl-libc toolchain, not
just Android's bionic.

 tools/perf/util/get_current_dir_name.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/get_current_dir_name.c b/tools/perf/util/get_current_dir_name.c
index b205d929245f..e68935e9ac8c 100644
--- a/tools/perf/util/get_current_dir_name.c
+++ b/tools/perf/util/get_current_dir_name.c
@@ -3,8 +3,9 @@
 //
 #ifndef HAVE_GET_CURRENT_DIR_NAME
 #include "get_current_dir_name.h"
+#include <limits.h>
+#include <string.h>
 #include <unistd.h>
-#include <stdlib.h>
 
 /* Android's 'bionic' library, for one, doesn't have this */
 
-- 
2.25.1

