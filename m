Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3857F743147
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 01:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjF2XvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 19:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjF2Xu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 19:50:56 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 966DA2D55;
        Thu, 29 Jun 2023 16:50:55 -0700 (PDT)
Received: from CPC-beaub-VBQ1L.localdomain (unknown [4.155.48.123])
        by linux.microsoft.com (Postfix) with ESMTPSA id C2F84208396C;
        Thu, 29 Jun 2023 16:50:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C2F84208396C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1688082654;
        bh=0aQD7w91qsRnUacHvqCqrLheZ0AfaxAuOy5KqQ12dw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y3trTN8upge61n68tUauMvmEglojh7Eu6kcf56/khalzgWsTsroZzvWzaUKgLrdN/
         +VVBUDDdlaaVYvB3tXU7DJyJwwPzOQnF9N438SsZY3IExQpDlZuAbzECcByTb4VA84
         hJOXprKkVX4WLa6kbaWfgUv9lPttAuHsGFfHA2R0=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests/user_events: Test struct size match cases
Date:   Thu, 29 Jun 2023 23:50:49 +0000
Message-Id: <20230629235049.581-3-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629235049.581-1-beaub@linux.microsoft.com>
References: <20230629235049.581-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The self tests for user_events currently does not ensure that the edge
case for struct types work properly with size differences.

Add cases for mis-matching struct names and sizes to ensure they work
properly.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 tools/testing/selftests/user_events/dyn_test.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/user_events/dyn_test.c b/tools/testing/selftests/user_events/dyn_test.c
index d6979a48478f..91a4444ad42b 100644
--- a/tools/testing/selftests/user_events/dyn_test.c
+++ b/tools/testing/selftests/user_events/dyn_test.c
@@ -217,6 +217,18 @@ TEST_F(user, matching) {
 	/* Types don't match */
 	TEST_NMATCH("__test_event u64 a; u64 b",
 		    "__test_event u32 a; u32 b");
+
+	/* Struct name and size matches */
+	TEST_MATCH("__test_event struct my_struct a 20",
+		   "__test_event struct my_struct a 20");
+
+	/* Struct name don't match */
+	TEST_NMATCH("__test_event struct my_struct a 20",
+		    "__test_event struct my_struct b 20");
+
+	/* Struct size don't match */
+	TEST_NMATCH("__test_event struct my_struct a 20",
+		    "__test_event struct my_struct a 21");
 }
 
 int main(int argc, char **argv)
-- 
2.34.1

