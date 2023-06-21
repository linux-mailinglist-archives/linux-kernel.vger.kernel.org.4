Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4378737B56
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 08:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjFUGg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjFUGgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:36:07 -0400
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C604C10FB;
        Tue, 20 Jun 2023 23:35:25 -0700 (PDT)
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-1b525af07a6so26098425ad.1;
        Tue, 20 Jun 2023 23:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687329308; x=1689921308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rOw6lr7KCaSTbJVfVX5591M2W/FZfWw7G+MVsaNTI+g=;
        b=cWqYMvgy2v4E6fjpyYOM+qaoxJLvUVCx2qfGCFe2QYlzrCZGWZTpB3j1PG6omhA6VZ
         4PB7esX2zOjLVTZS/k5GhshOO6+qUX8PnSqJthKKr7lo/6/8vTVYam4p8HUA3s2ZRbK/
         bboFlV0zJ1pn5U1CyF9892lQHZHcF8kL7nYltZlvg4SjVkntTUHUnknp3zpcLkas8wA6
         /RP6lGIlBWQzaojyJjSFqyo8wSoC9mk8dsR86ejWONzf6vVSpjt2F14Q2QJDSaeeio8s
         1i/yAx8N5h7FHWkburxYzLjDWpk2ulMIyJRHbJ2yl702QVKHkLgJdzJwlFANVzKsmSOz
         j+Uw==
X-Gm-Message-State: AC+VfDxhd5RHpzSgm8sof0UU79gAxIWJgSqpd8QZi/iIX+iTmvxAIN8I
        LUFmYlGiKJf7hL7Fab9eVQ==
X-Google-Smtp-Source: ACHHUZ5UFqt4bZo98PnGsOl8cmIyq++2mSRoSZ9M/lz6KCX1WvNV4k4qrQCYPZ5sDR7n3y23mLPtkw==
X-Received: by 2002:a17:902:d353:b0:1b3:c7c1:8ded with SMTP id l19-20020a170902d35300b001b3c7c18dedmr8466029plk.27.1687329308272;
        Tue, 20 Jun 2023 23:35:08 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id z7-20020a170902708700b001b3dada0e78sm2593054plk.258.2023.06.20.23.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 23:35:07 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     rostedt@goodmis.org, mhiramat@kernel.org, beaub@linux.microsoft.com
Cc:     kelulanainsley@gmail.com, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sunliming <sunliming@kylinos.cn>
Subject: [PATCH v3 3/3] selftests/user_events: Add test cases when event is diabled
Date:   Wed, 21 Jun 2023 14:35:02 +0800
Message-Id: <20230621063502.154378-1-sunliming@kylinos.cn>
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

When user_events are disabled, it's write operation should return zero.
Add this test cases.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 tools/testing/selftests/user_events/ftrace_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index d33bd31425db..7968d69c3a5c 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -297,6 +297,9 @@ TEST_F(user, write_events) {
 	io[0].iov_base = &reg.write_index;
 	io[0].iov_len = sizeof(reg.write_index);
 
+	/* Write should return zero when event is not enabled */
+	ASSERT_EQ(0, writev(self->data_fd, (const struct iovec *)io, 3));
+
 	/* Enable event */
 	self->enable_fd = open(enable_file, O_RDWR);
 	ASSERT_NE(-1, write(self->enable_fd, "1", sizeof("1")))
-- 
2.25.1

