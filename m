Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A96747839
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 20:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjGDSPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 14:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjGDSPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 14:15:20 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B83E10CA;
        Tue,  4 Jul 2023 11:15:19 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666e64e97e2so3003610b3a.1;
        Tue, 04 Jul 2023 11:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688494519; x=1691086519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=DSqYHV9aOqFyal3Tm/y/6ISIc1yWfppvT5nKEoCz+0I=;
        b=RIzLb7TawJkCpEJQbDIU8BXy4bWw/yGDH/7J/GYhKwiu9J7lCjupK3kiSYf4wa8mmr
         k1S4t1dw0herZTL6y2GQ0gHWwTa8UC0WK5FToGuAK2YcMP/3ohfSTzVenkWFlbGJ86hN
         MKsfx2j1EKkHnx8lt3ol6fJ4GG3adw7TNXGUbfYku6mADtMx1CjWo2Jf6HMkw7780dk6
         tqd8+kUlaYOO7cioX/WxIOMd3wozhQMwShwujlMVOHJBOEkjc2u9ZAcV2sKFEsokDqjt
         Hd4ZSzaRKwOs2QZssxM25FsgBPLKcd0MbNnPY/eZDdut9cOkY7z2DTm6X4CSFdJJkqbX
         PztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688494519; x=1691086519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSqYHV9aOqFyal3Tm/y/6ISIc1yWfppvT5nKEoCz+0I=;
        b=Fufrmo3wrhQ7QCfw46PI8G0g24Fmj65lEK5yXkhklXgS+ykJzx4glNWBTDU7o6+6cI
         z6+2gkV3ZfzwMjTFtH5BmbNMiedB9Ity8UIHzon9/z9ECZ5w8dZSUg7rYLzvvYCa9h2Q
         hbOqqKSgxmQuEB3yiWUpWHxevDbZirnyvHHDlbIG6qc64JJROMUgHNFPe7xGKWLFyb6o
         HkEWENYZnpy/iCUQOXaGQ21JAki4O7DVXNOBZKSN8K0e6cOjtF/bEyJ0mIVvm9HroYBV
         CpLS+ukY52M6bqayzWw+AO00uuidwAXtc3uVGZoDKoIbquwiiEogE02lklTB0UrF/sPY
         GBMQ==
X-Gm-Message-State: ABy/qLYRNrP4xUmZzWZI3OhBAeS5dlUJ08EdSzuMl2piOW18fJQUtW9k
        2krupy/sGOsQvPN6kwp6OXQ=
X-Google-Smtp-Source: APBJJlHRgeukUmL5ptqGK63dR+9Sh5I4TafvsUUhKrlZ5EWZgFXxkxEtpKdqugjc8mEXOwJkawzeuQ==
X-Received: by 2002:a05:6a00:2da3:b0:66a:2771:6c4d with SMTP id fb35-20020a056a002da300b0066a27716c4dmr15771360pfb.4.1688494518570;
        Tue, 04 Jul 2023 11:15:18 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6700:7f00:6b7:7112:19a1:fc15])
        by smtp.gmail.com with ESMTPSA id u25-20020a62ed19000000b00682a839d0aesm1476717pfh.112.2023.07.04.11.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 11:15:18 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Greg Thelen <gthelen@google.com>, stable@vger.kernel.org
Subject: [PATCH] perf/x86: Fix lockdep warning in for_each_sibling_event() on SPR
Date:   Tue,  4 Jul 2023 11:15:15 -0700
Message-ID: <20230704181516.3293665-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
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

On SPR, the load latency event needs an auxiliary event in the same
group to work properly.  There's a check in intel_pmu_hw_config()
for this to iterate sibling events and find a mem-loads-aux event.

The for_each_sibling_event() has a lockdep assert to make sure if it
disabled hardirq or hold leader->ctx->mutex.  This works well if the
given event has a separate leader event since perf_try_init_event()
grabs the leader->ctx->mutex to protect the sibling list.  But it can
cause a problem when the event itself is a leader since the event is
not initialized yet and there's no ctx for the event.

Actually I got a lockdep warning when I run the below command on SPR,
but I guess it could be a NULL pointer dereference.

  $ perf record -d -e cpu/mem-loads/uP true

The code path to the warning is:

  sys_perf_event_open()
    perf_event_alloc()
      perf_init_event()
        perf_try_init_event()
          x86_pmu_event_init()
            hsw_hw_config()
              intel_pmu_hw_config()
                for_each_sibling_event()
                  lockdep_assert_event_ctx()

We don't need for_each_sibling_event() when it's a standalone event.
Let's return the error code directly.

Fixes: f3c0eba28704 ("perf: Add a few assertions")
Reported-by: Greg Thelen <gthelen@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 arch/x86/events/intel/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0d09245aa8df..933fe4894c32 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3983,6 +3983,14 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		struct perf_event *leader = event->group_leader;
 		struct perf_event *sibling = NULL;
 
+		/*
+		 * The event is not fully initialized yet and no ctx is set
+		 * for the event.  Avoid for_each_sibling_event() since it
+		 * has a lockdep assert with leader->ctx->mutex.
+		 */
+		if (leader == event)
+			return -ENODATA;
+
 		if (!is_mem_loads_aux_event(leader)) {
 			for_each_sibling_event(sibling, leader) {
 				if (is_mem_loads_aux_event(sibling))
-- 
2.41.0.255.g8b1d071c50-goog

