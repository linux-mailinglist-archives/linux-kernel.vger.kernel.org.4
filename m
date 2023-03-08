Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7B96AFF2E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 07:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjCHG7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 01:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCHG7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 01:59:14 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C307DA0F29;
        Tue,  7 Mar 2023 22:59:13 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id v11so16785583plz.8;
        Tue, 07 Mar 2023 22:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678258753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hIkmwT/HZfPdKI7XyMs9iCXmGKHTJCfQa15FJksHUag=;
        b=oyfGVI75sqU6FBVb43RtFbhFg9F03goImGxnOf2UrScVsVNaffit6jFuWZs5JYEf5/
         Wmr2Pq9YdCC13iQL2AkMsLtWLacPAt6rmA31mkNLBpB3emrzzrObMQIJ2rdkzPVYGCw6
         K7f9OebTm2RA1klvlZu/lE/g1auniPVGGCEIWiqWTfgoW2sFwlrEm0YRWjJ64hPgrWUt
         vcrg7qgBdNWY74txDlcfaYLn6mWi3WmrIv1Vd1RidOJof0yUcRdyvJeDckSCecOgYI+N
         eEFtZb8jZobadbLXuUUIfblYz4wXRhUNS+46XKYL6+dODJSWPPspfZlGwM1/bC4GGKbn
         tKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678258753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIkmwT/HZfPdKI7XyMs9iCXmGKHTJCfQa15FJksHUag=;
        b=hHXcb7OOUMHi8kD60Ti1G1XfovzcfGkQqRh+4BUhFBTZec/jiPf8FC7zodH6dt0wXq
         1phjyrForOWqpwl7vEMdb/e8qeaaE1bgaLhR6zifiwIPq+8o0fggC+K7N1KyvCV1EiEb
         q6t2o2fbDSyF12I7d7hho+XeTHBk727kYNPG6tajX/iIekolsMMqaSXfQ4aqXaPBKzzw
         J80XBfoHWLZJuNTK8VMvzNspsTmqg1UP4YG1vvsOT4Gn6ulkEIViAoCbRBpwgIGGThfi
         lCdLMtiPCCybiFibogf8vWtDVMOPhz5IiNFGtnb1Jph3vl0pk/PypejRJNPX6hRMpdt5
         PFmQ==
X-Gm-Message-State: AO0yUKXtazSBt0Gzna9agOIq64G0d/dQjHCRn3IIMDPJg2SzYzEVxozA
        t6XbVUH4Y4sBP9e0UQxYp/I=
X-Google-Smtp-Source: AK7set8zu6AK4NHwvciMC1jk3hw45M/7yB1LnA6To89LcogEfv/AeR8PdS29+jK1aSDR/FOvtVpRfg==
X-Received: by 2002:a17:90b:1804:b0:233:af77:c075 with SMTP id lw4-20020a17090b180400b00233af77c075mr17871939pjb.36.1678258753094;
        Tue, 07 Mar 2023 22:59:13 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:44b0:80c8:4a92:e7f2:ff68])
        by smtp.gmail.com with ESMTPSA id gz7-20020a17090b0ec700b002349608e80csm8365410pjb.47.2023.03.07.22.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 22:59:12 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf tools: Ignore vmlinux.h
Date:   Tue,  7 Mar 2023 22:59:11 -0800
Message-Id: <20230308065911.1127255-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vmlinux.h file is generated during the build.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_skel/.gitignore | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_skel/.gitignore b/tools/perf/util/bpf_skel/.gitignore
index 5263e9e6c5d8..cd01455e1b53 100644
--- a/tools/perf/util/bpf_skel/.gitignore
+++ b/tools/perf/util/bpf_skel/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 .tmp
-*.skel.h
\ No newline at end of file
+*.skel.h
+vmlinux.h
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

