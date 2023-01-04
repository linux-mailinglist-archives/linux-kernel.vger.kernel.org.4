Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A2765DCCF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 20:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240136AbjADTe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 14:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240137AbjADTeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:34:19 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C453D1C0
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 11:34:17 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id z17-20020a25e311000000b00719e04e59e1so34887874ybd.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 11:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1tPYYgfmJsbQWqu0ltxW4RY1Nkj1mo/Al1PbZ2zMD4Q=;
        b=smJNk0zhuo1/1zHEXj0d6yRUmkqnDpfIx58BEn/cGg72LNn90pxpjarz3SeORF9+yR
         yl478rY3Qppd5f2Y2rZddHE4v8a3gs+QAutJk1j+5azEWDoaxwtIegEqQuDJ3prj1Dnd
         1SykFQVuvIO49v0UGRh5vXfggrpNq1r2pN7O6akJ9lVtiSpQ6r25tG99U4dkahMHP0fZ
         ugdj2OGR8BNOj38eCHSjfyUB+X0SwCYD98iAle3qi1XqCvIJGo/NsOnerjHn262s7apJ
         4n5Uq6j6d+L7QR9x+bLGU1VyjWUbIhmGiO8nuCF7RLGyL5gvU0COr4DthqITRqypavI+
         /d9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1tPYYgfmJsbQWqu0ltxW4RY1Nkj1mo/Al1PbZ2zMD4Q=;
        b=0ejT82eL57yts8jnfRFxlAQPkROcQuQryIsJVC8VFmSwy+fNJYx8hlLEZ2JKI27m27
         EnZP/++eKHDXDRw9wtV6TY/8pcLLcj+jbpw3iDM+cB0B20J78yjgFIvyJiSWLknbSmmk
         hen0PmSQ9R2x/L/I59PARLNZOqnDAt2mOl/H6abnx6KLBy1Jkr94IeIGikrcukR7WXA9
         lAhGmlwRq5pln4a3otxG5ZEMVqfUj+0U8aEC4EKF13AcnlBGU0Vtp71gvy5WFZtp3uKn
         2t/ZGI4D4ZoSDQP8fixm93X+LIhV7zx2tsjRRSFIsSEn1e2O8jFHhp4FgNpVRQGEyPzq
         9dJg==
X-Gm-Message-State: AFqh2krbFDyocA2pnHLE92BeHMNEi1YFwgj/lIZBbpzTtOOGNBfezJ5P
        i3lVAmYAfV+2EIsSAHTpS5FfLrj8vyOjCXw=
X-Google-Smtp-Source: AMrXdXudx83GP3Mrrft7oAK5KgZusnNPxKJ/c9Yu72lCZ4dQmJoXMT56KJYtoNZOE58Swk/uWBTV1OiO8Y3xHSU=
X-Received: from jesussanp.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5f10])
 (user=jesussanp job=sendgmr) by 2002:a25:790d:0:b0:7b0:62c8:d02b with SMTP id
 u13-20020a25790d000000b007b062c8d02bmr433902ybc.272.1672860857141; Wed, 04
 Jan 2023 11:34:17 -0800 (PST)
Date:   Wed,  4 Jan 2023 11:34:14 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230104193414.606905-1-jesussanp@google.com>
Subject: [PATCH v2] perf: Add missing sys/types.h include
From:   Jesus Sanchez-Palencia <jesussanp@google.com>
To:     linux-perf-users@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        Jesus Sanchez-Palencia <jesussanp@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all libc implementations define ssize_t as part of stdio.h like
glibc does since the standard only requires this type to be defined by
unistd.h and sys/types.h. For this reason the perf build is currently
broken for toolchains based on uClibc, for instance.

Include sys/types.h explicitly to fix that.

Fixes: 378ef0f5d9d7 ("perf build: Use libtraceevent from the system")
Signed-off-by: Jesus Sanchez-Palencia <jesussanp@google.com>
---
 tools/perf/util/trace-event.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index add6c5d9531c..9b3cd79cca12 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -4,6 +4,7 @@
 
 #include <stdbool.h>
 #include <stdio.h>
+#include <sys/types.h>
 #include <linux/types.h>
 
 struct evlist;
-- 
2.39.0.314.g84b9a713c41-goog

