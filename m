Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8862A737B7A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 08:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjFUGgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjFUGf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:35:59 -0400
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417E21FF5;
        Tue, 20 Jun 2023 23:35:16 -0700 (PDT)
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-6687446eaccso2784668b3a.3;
        Tue, 20 Jun 2023 23:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687329286; x=1689921286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UwLBYM4w/H7KoFqtcB4hQtAsyswAe46iM2ztf4QLeWA=;
        b=COJbwxBxfLaJFS0hvhVtk93zfccR4O+Msv0xAle/hAmP1tPByHcBYsYjIpTtsr17Ey
         fTIp98oH3oF6VEImZYXYBEQxqfoUTcDVJCNpKbsneans6aXMzvqpalPb6Ai/GmBCkoWH
         a9V26DaaOPc+Sb3e6WRqkycWfa8d7zKDzDAJxxOwqftKAWRcPGXey5YuQMEQ6PP9Y9vv
         whj7G31T6IHRi2OYxso0Zp04yszxR4XofO4SM9wErNOoHyRe6F9H4c9SZyNTaPH5h6Bm
         gAw9isAXq96x56hGhRN89RU4I0VjLQKZ+XUr6W5nuJ4fkZmUQlzqRsuO+t5AcLNrwYL4
         SNMA==
X-Gm-Message-State: AC+VfDzrvkeTWJ97fwGkKxaaF7hzfMhxBjddcVXki7jABMkSjs1siXE7
        +K37D5M9xF8lpD+CmL6yrw==
X-Google-Smtp-Source: ACHHUZ4VjU0MwUo7X5EhB5iTtxuauMxunWUWBc7vFtY9ck4VfMOvMDrNcKLLqgFDf3BORuPgsIPKLA==
X-Received: by 2002:a05:6a00:1a56:b0:658:c1a9:becc with SMTP id h22-20020a056a001a5600b00658c1a9beccmr20749626pfv.12.1687329286205;
        Tue, 20 Jun 2023 23:34:46 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id c25-20020a62e819000000b00666d7ef2310sm2306298pfi.94.2023.06.20.23.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 23:34:45 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     rostedt@goodmis.org, mhiramat@kernel.org, beaub@linux.microsoft.com
Cc:     kelulanainsley@gmail.com, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sunliming <sunliming@kylinos.cn>
Subject: [PATCH v3 2/3] selftests/user_events: Enable the event before write_fault test in ftrace self-test
Date:   Wed, 21 Jun 2023 14:34:38 +0800
Message-Id: <20230621063438.154271-1-sunliming@kylinos.cn>
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

The user_event has not be enabled in write_fault test in ftrace
self-test, Just enable it.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 tools/testing/selftests/user_events/ftrace_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index abfb49558a26..d33bd31425db 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -373,6 +373,10 @@ TEST_F(user, write_fault) {
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
 	ASSERT_EQ(0, reg.write_index);
 
+	/* Enable event */
+	self->enable_fd = open(enable_file, O_RDWR);
+	ASSERT_NE(-1, write(self->enable_fd, "1", sizeof("1")))
+
 	/* Write should work normally */
 	ASSERT_NE(-1, writev(self->data_fd, (const struct iovec *)io, 2));
 
-- 
2.25.1

