Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97904720A04
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 21:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbjFBTpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 15:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235937AbjFBTpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 15:45:18 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237CD19B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 12:45:17 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-651f2f38634so1966036b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 12:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685735116; x=1688327116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Yo0iLHtIXzns4YdryR3pdo44wLy6L2MpMgI0lT2F9VA=;
        b=DOTRovC7U744AstVeBREzqt5mec2w6cmU+Ju/GIz2VOX64xZo4EOUY3C533UaWZhh3
         IzJUQq4wGZV3/NZrwM9H3JqIdFGgzJrugVjbwsNBNVg+2AG4+nz7Ez2eM80jXeDBPqyw
         YXyBlzDNBckIzTb0U0mFW28atGrt1z4ix0QUZSwdu4kycEttdPIQgvJENq1/4Lf6jprv
         +ebACT7Vl/RFBKMF2lBbqmazYrTdozXLwNJ1Y280dWzOvRkAgBd6c1vEEtwUb4dhiHVW
         DZ+8IYntD3VBNUDX1xNgQ6kZPxeRPaO3Wns0b1PBGKFlqrRAu3AJrzsdm9+GcGgHajj1
         t8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685735116; x=1688327116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yo0iLHtIXzns4YdryR3pdo44wLy6L2MpMgI0lT2F9VA=;
        b=I92vzsGyayF8hPw6vUDFT8YyNUn2/KqHl55YUW6maBre34kFds9lrdOsTdLthhG0VF
         euYI/VACMrvyzUOFyQ5CDM2xWq7gYd52w6VQQwlvEaHgV8Uc/FNcESxNEW6PzcE9ak96
         1hUquDncs2CE1gdR6iaEsWN4dv/nyByWSu9GLTT6MhF/81o4AdiZk8S6HB6FnPIoxCbO
         1ymgghZ4MFnpWgQ2IejzhG/yt2VaupE/ToJ1nFUk4MfNu3ZA2wEaUOYt7HYoyG4NKhsJ
         lg70LB2rhHz3Ey5YHr9qFWOwFM8b6lxAnOZnMz3bbRgJLEBsMTMVJXo7nrAAzw2Gq5E8
         NOBQ==
X-Gm-Message-State: AC+VfDwpTRIby2yA4D5c2ssyssoHQW3SDjuUiDci99Buqjq0Sm/UBAjA
        SvGCX/sUzfnhXrbVHDe1dkM=
X-Google-Smtp-Source: ACHHUZ53OxGmNI4bh4qaoJDfzzgmubzPQTVpf2SCqXTNQ6fE+3I6JIgZFfm+jHuCq+7n7c4fPbbhhw==
X-Received: by 2002:a05:6a00:23c8:b0:64c:c5f9:152a with SMTP id g8-20020a056a0023c800b0064cc5f9152amr16789338pfc.23.1685735116310;
        Fri, 02 Jun 2023 12:45:16 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:bc81:87cb:7da8:98c2])
        by smtp.gmail.com with ESMTPSA id j1-20020aa78d01000000b0065329194416sm1291341pfe.193.2023.06.02.12.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 12:45:15 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [PATCH] perf/x86/amd: Reject branch stack for IBS events
Date:   Fri,  2 Jun 2023 12:45:13 -0700
Message-ID: <20230602194513.1589179-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
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

The AMD IBS PMU doesn't handle branch stacks, so it should not accept
events with brstack.

Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 arch/x86/events/amd/ibs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 371014802191..607a692ba8ce 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -265,6 +265,9 @@ static int perf_ibs_init(struct perf_event *event)
 	if (config & ~perf_ibs->config_mask)
 		return -EINVAL;
 
+	if (has_branch_stack(event))
+		return -EOPNOTSUPP;
+
 	if (hwc->sample_period) {
 		if (config & perf_ibs->cnt_mask)
 			/* raw max_cnt may not be set */
-- 
2.41.0.rc2.161.g9c6817b8e7-goog

