Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409785F1529
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 23:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbiI3Vrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 17:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiI3Vrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 17:47:40 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37619166F03
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 14:47:39 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id y2so3634798qkl.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 14:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=aRUqCLLcHsh6POG9Rz1BBcJxeSLfOpSm82me8CPX0EE=;
        b=V5yeN+2EUTx0ijWJHDat3dpN2jVX7DOl7IDNuurm/iWg+TpeqENWHay15+kLGDcPU4
         zsgzTMkjcgBL+J5yFGWyFzvCkpEG/7nkfg7UMdu8J/ch51KUoLVnIeR1+4VKgLZSN1wg
         rwdhxVRNQTGdyhYK7fey/xUnUpUT1aXx20FQVX9fytSPB62iCS3+7gAUKCX/wPg1q5Ox
         C0WOLCWWlDhXU94JUVZxzPToZirWZEACBkVtYk4XqRSAwV/BymvDQM5IOXkDd0/6iARx
         73ZjxJhyDlKnLG41P2LKn+z37DnYdoPVC24t2ewhGSmELIjvHoThMasZzSHP/B9rvhUg
         OBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=aRUqCLLcHsh6POG9Rz1BBcJxeSLfOpSm82me8CPX0EE=;
        b=PWt2gbwhPsPWhZqDDoW+S1jY9UjO/PrG7lqRq1iaYaft3fHw7Xm1Oxw92Ur0yROu0W
         tAvhluOL+1MAmGd0XC7m1KuLDARyf+d+oTiYI4VdbVZzUhrp+xST/wG0DFwmqJXghsgW
         GAUKufs+2o8D1qPYLYCWVAH7C0C4bABuF+CCNJpq2LL7khJ9TMsvbnE1bGyhE4yWWyPP
         mIxdMUquXvv89MCqqcTM/EkETqNqVCHxJXak7jd4RPcfJ+MvcHLYKWpjFG4r+3onHerQ
         Sbft/8ofqt+GCKuV5PuB+DDsy0dufM/SjpNRIOGWJqZ3JcEPSzKMGrlgcDFp+C43gTsL
         1LkA==
X-Gm-Message-State: ACrzQf1eqFiKE7dkk3pJnd2iMqcXsO5ZEMKQz6nJb6An7zvyyKXox3G2
        vYOiPH2TvqNwXi0KEzP6ienXLn1zpe0=
X-Google-Smtp-Source: AMsMyM6/XfxUdjgGd9O1cCQKRZ2np6KUYs377e81QtosrGKyKSfv7aUauYp9JMTd/MJHU3YW/ShcLA==
X-Received: by 2002:a05:620a:13af:b0:6ce:809e:243a with SMTP id m15-20020a05620a13af00b006ce809e243amr7669222qki.461.1664574457892;
        Fri, 30 Sep 2022 14:47:37 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id m13-20020a05620a24cd00b006cec8001bf4sm4120920qkn.26.2022.09.30.14.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 14:47:37 -0700 (PDT)
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
Subject: [PATCH stable 5.4] perf tools: Fixup get_current_dir_name() compilation
Date:   Fri, 30 Sep 2022 14:44:42 -0700
Message-Id: <20220930214442.2218882-1-f.fainelli@gmail.com>
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

