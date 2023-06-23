Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D6F73AE53
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 03:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjFWBdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 21:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjFWBdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 21:33:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88492107
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 18:33:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A9276194A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 01:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C05C433CC;
        Fri, 23 Jun 2023 01:33:37 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qCVg8-002M7j-1C;
        Thu, 22 Jun 2023 21:33:36 -0400
Message-ID: <20230623013336.182046869@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 22 Jun 2023 21:31:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        sunliming <sunliming@kylinos.cn>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-linus][PATCH 2/3] selftests/user_events: Enable the event before write_fault test in
 ftrace self-test
References: <20230623013152.037225511@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: sunliming <sunliming@kylinos.cn>

The user_event has not been enabled in write_fault test in ftrace
self-test, Just enable it.

Link: https://lkml.kernel.org/r/20230621063438.154271-1-sunliming@kylinos.cn

Signed-off-by: sunliming <sunliming@kylinos.cn>
Acked-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/testing/selftests/user_events/ftrace_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index eb6904d89f14..88898749e5b7 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -400,6 +400,10 @@ TEST_F(user, write_fault) {
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
 	ASSERT_EQ(0, reg.write_index);
 
+	/* Enable event */
+	self->enable_fd = open(enable_file, O_RDWR);
+	ASSERT_NE(-1, write(self->enable_fd, "1", sizeof("1")))
+
 	/* Write should work normally */
 	ASSERT_NE(-1, writev(self->data_fd, (const struct iovec *)io, 2));
 
-- 
2.39.2
