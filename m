Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53142737B0A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 08:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjFUGIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjFUGIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:08:39 -0400
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8D51726;
        Tue, 20 Jun 2023 23:08:37 -0700 (PDT)
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-6b46831fd13so3306810a34.3;
        Tue, 20 Jun 2023 23:08:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687327717; x=1689919717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQu7yQb5csSSHJ7nBU/IUnjQhId+NDJJip5y+n97vEg=;
        b=LeIPVXIw8CD52fqluKOfPkV9HgdOtVWFjkZ4bmOcKJMgJSXrPAwy8vuv07vT5UEoVD
         WC0dXj2v8KzPzeFFPgpS31+tXJRoU4wGwV5iFpm1MNloTdrVKYZyX+a0zbe1C0Lc8g/d
         r1hKyCy6m75RhBabwBhIGddbBwJtEH6EHylIQQqhVb8wGfxxxWZkj89YAYP8TNSRj+Q7
         MLOqArC6h6ToRSoy9QsExCxuvFU8g7YqHBzbOnYnamZ4leQ7FU8u+NIgIUsHbG5i3hj9
         Dy1MQQ6W3BbYQ1N3VMicwC5bC1X9HoLQOBHjaFNAU4A/L/QAU924uB/csXZ5bnb4G2s4
         J9uw==
X-Gm-Message-State: AC+VfDyoNIFuG/JLkQ2h1Smwxyl6yzc/B+A2Qmm/sK8FaT6+IKIok58z
        NKrUEgdM3Njs0ItTcC90MA==
X-Google-Smtp-Source: ACHHUZ4q/VUU5rO08raP7Wcd2haYrjhocRfR+rnudbHAEeakSs+BmSAT3d9NcLof8fM06P7RVtFqzQ==
X-Received: by 2002:a05:6358:ce24:b0:131:22f2:8185 with SMTP id gt36-20020a056358ce2400b0013122f28185mr426093rwb.12.1687327715912;
        Tue, 20 Jun 2023 23:08:35 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id d28-20020a630e1c000000b00528da88275bsm2323621pgl.47.2023.06.20.23.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 23:08:35 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     rostedt@goodmis.org, mhiramat@kernel.org, beaub@linux.microsoft.com
Cc:     kelulanainsley@gmail.com, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sunliming <sunliming@kylinos.cn>
Subject: [PATCH v3 0/3] tracing/user_events: Fix incorrect return value for
Date:   Wed, 21 Jun 2023 14:08:23 +0800
Message-Id: <20230621060827.151564-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the writing operation return the count of writes regardless of whether
events are enabled or disabled. Fix this by just return zero when events
are disabled.

v2 -> v3:
- Change the return value from -ENOENT to zero

v1 -> v2:
- Change the return value from -EFAULT to -ENOENT


sunliming (3):
  tracing/user_events: Fix incorrect return value for writing operation
    when events are disable
  selftests/user_events: Enable the event before write_fault test in
    ftrace self-test
  selftests/user_events: Add test cases when event is diabled

 kernel/trace/trace_events_user.c                  | 3 ++-
 tools/testing/selftests/user_events/ftrace_test.c | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.25.1

